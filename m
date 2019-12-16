Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26DE711FFF1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2019 09:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfLPIgS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Dec 2019 03:36:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:36922 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726722AbfLPIgR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Dec 2019 03:36:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 707E9AD31;
        Mon, 16 Dec 2019 08:36:11 +0000 (UTC)
Subject: Re: [PATCH 1/2] fs: New zonefs file system
To:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Johannes Thumshirn <jth@kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>
References: <20191212183816.102402-1-damien.lemoal@wdc.com>
 <20191212183816.102402-2-damien.lemoal@wdc.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <c7f17b54-8f90-3dd3-98f7-cf540d70333d@suse.de>
Date:   Mon, 16 Dec 2019 09:36:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191212183816.102402-2-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/12/19 7:38 PM, Damien Le Moal wrote:
> zonefs is a very simple file system exposing each zone of a zoned block
> device as a file. Unlike a regular file system with zoned block device
> support (e.g. f2fs), zonefs does not hide the sequential write
> constraint of zoned block devices to the user. Files representing
> sequential write zones of the device must be written sequentially
> starting from the end of the file (append only writes).
> 
> As such, zonefs is in essence closer to a raw block device access
> interface than to a full featured POSIX file system. The goal of zonefs
> is to simplify the implementation of zoned block devices support in
> applications by replacing raw block device file accesses with a richer
> file API, avoiding relying on direct block device file ioctls which may
> be more obscure to developers. One example of this approach is the
> implementation of LSM (log-structured merge) tree structures (such as
> used in RocksDB and LevelDB) on zoned block devices by allowing SSTables
> to be stored in a zone file similarly to a regular file system rather
> than as a range of sectors of a zoned device. The introduction of the
> higher level construct "one file is one zone" can help reducing the
> amount of changes needed in the application as well as introducing
> support for different application programming languages.
> 
> Zonefs on-disk metadata is reduced to an immutable super block to
> persistently store a magic number and optional features flags and
> values. On mount, zonefs uses blkdev_report_zones() to obtain the device
> zone configuration and populates the mount point with a static file tree
> solely based on this information. E.g. file sizes come from the device
> zone type and write pointer offset managed by the device itself.
> 
> The zone files created on mount have the following characteristics.
> 1) Files representing zones of the same type are grouped together
>     under a common sub-directory:
>       * For conventional zones, the sub-directory "cnv" is used.
>       * For sequential write zones, the sub-directory "seq" is used.
>    These two directories are the only directories that exist in zonefs.
>    Users cannot create other directories and cannot rename nor delete
>    the "cnv" and "seq" sub-directories.
> 2) The name of zone files is the number of the file within the zone
>     type sub-directory, in order of increasing zone start sector.
> 3) The size of conventional zone files is fixed to the device zone size.
>     Conventional zone files cannot be truncated.
> 4) The size of sequential zone files represent the file's zone write
>     pointer position relative to the zone start sector. Truncating these
>     files is allowed only down to 0, in wich case, the zone is reset to
>     rewind the zone write pointer position to the start of the zone, or
>     up to the zone size, in which case the file's zone is transitioned
>     to the FULL state (finish zone operation).
> 5) All read and write operations to files are not allowed beyond the
>     file zone size. Any access exceeding the zone size is failed with
>     the -EFBIG error.
> 6) Creating, deleting, renaming or modifying any attribute of files and
>     sub-directories is not allowed.
> 
> Several optional features of zonefs can be enabled at format time.
> * Conventional zone aggregation: ranges of contiguous conventional
>    zones can be agregated into a single larger file instead of the
>    default one file per zone.
> * File ownership: The owner UID and GID of zone files is by default 0
>    (root) but can be changed to any valid UID/GID.
> * File access permissions: the default 640 access permissions can be
>    changed.
> 
> The mkzonefs tool is used to format zoned block devices for use with
> zonefs. This tool is available on Github at:
> 
> git@github.com:damien-lemoal/zonefs-tools.git.
> 
> zonefs-tools also includes a test suite which can be run against any
> zoned block device, including null_blk block device created with zoned
> mode.
> 
> Example: the following formats a 15TB host-managed SMR HDD with 256 MB
> zones with the conventional zones aggregation feature enabled.
> 
> $ sudo mkzonefs -o aggr_cnv /dev/sdX
> $ sudo mount -t zonefs /dev/sdX /mnt
> $ ls -l /mnt/
> total 0
> dr-xr-xr-x 2 root root     1 Nov 25 13:23 cnv
> dr-xr-xr-x 2 root root 55356 Nov 25 13:23 seq
> 
> The size of the zone files sub-directories indicate the number of files
> existing for each type of zones. In this example, there is only one
> conventional zone file (all conventional zones are agreggated under a
> single file).
> 
> $ ls -l /mnt/cnv
> total 137101312
> -rw-r----- 1 root root 140391743488 Nov 25 13:23 0
> 
> This aggregated conventional zone file can be used as a regular file.
> 
> $ sudo mkfs.ext4 /mnt/cnv/0
> $ sudo mount -o loop /mnt/cnv/0 /data
> 
> The "seq" sub-directory grouping files for sequential write zones has
> in this example 55356 zones.
> 
> $ ls -lv /mnt/seq
> total 14511243264
> -rw-r----- 1 root root 0 Nov 25 13:23 0
> -rw-r----- 1 root root 0 Nov 25 13:23 1
> -rw-r----- 1 root root 0 Nov 25 13:23 2
> ...
> -rw-r----- 1 root root 0 Nov 25 13:23 55354
> -rw-r----- 1 root root 0 Nov 25 13:23 55355
> 
> For sequential write zone files, the file size changes as data is
> appended at the end of the file, similarly to any regular file system.
> 
> $ dd if=/dev/zero of=/mnt/seq/0 bs=4K count=1 conv=notrunc oflag=direct
> 1+0 records in
> 1+0 records out
> 4096 bytes (4.1 kB, 4.0 KiB) copied, 1.05112 s, 3.9 kB/s
> 
> $ ls -l /mnt/seq/0
> -rw-r----- 1 root root 4096 Nov 25 13:23 /mnt/sdh/seq/0
> 
> The written file can be truncated to the zone size, prventing any
> further write operation.
> 
> $ truncate -s 268435456 /mnt/seq/0
> $ ls -l /mnt/seq/0
> -rw-r----- 1 root root 268435456 Nov 25 13:49 /mnt/seq/0
> 
> Truncation to 0 size allows freeing the file zone storage space and
> restart append-writes to the file.
> 
> $ truncate -s 0 /mnt/seq/0
> $ ls -l /mnt/seq/0
> -rw-r----- 1 root root 0 Nov 25 13:49 /mnt/seq/0
> 
> Since files are statically mapped to zones on the disk, the number of
> blocks of a file as reported by stat() and fstat() indicates the size
> of the file zone.
> 
> $ stat /mnt/seq/0
>    File: /mnt/seq/0
>    Size: 0       Blocks: 524288     IO Block: 4096   regular empty file
> Device: 870h/2160d      Inode: 50431       Links: 1
> Access: (0640/-rw-r-----)  Uid: (    0/    root)   Gid: (    0/  root)
> Access: 2019-11-25 13:23:57.048971997 +0900
> Modify: 2019-11-25 13:52:25.553805765 +0900
> Change: 2019-11-25 13:52:25.553805765 +0900
>   Birth: -
> 
> The number of blocks of the file ("Blocks") in units of 512B blocks
> gives the maximum file size of 524288 * 512 B = 256 MB, corresponding
> to the device zone size in this example. Of note is that the "IO block"
> field always indicates the minimum IO size for writes and corresponds
> to the device physical sector size.
> 
> This code contains contributions from:
> * Johannes Thumshirn <jthumshirn@suse.de>,
> * Darrick J. Wong <darrick.wong@oracle.com>,
> * Christoph Hellwig <hch@lst.de>,
> * Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com> and
> * Ting Yao <tingyao@hust.edu.cn>.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>   MAINTAINERS                |    9 +
>   fs/Kconfig                 |    1 +
>   fs/Makefile                |    1 +
>   fs/zonefs/Kconfig          |    9 +
>   fs/zonefs/Makefile         |    4 +
>   fs/zonefs/super.c          | 1158 ++++++++++++++++++++++++++++++++++++
>   fs/zonefs/zonefs.h         |  169 ++++++
>   include/uapi/linux/magic.h |    1 +
>   8 files changed, 1352 insertions(+)
>   create mode 100644 fs/zonefs/Kconfig
>   create mode 100644 fs/zonefs/Makefile
>   create mode 100644 fs/zonefs/super.c
>   create mode 100644 fs/zonefs/zonefs.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 02d5278a4c9a..0641167ed2ea 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18282,6 +18282,15 @@ L:	linux-kernel@vger.kernel.org
>   S:	Maintained
>   F:	arch/x86/kernel/cpu/zhaoxin.c
>   
> +ZONEFS FILESYSTEM
> +M:	Damien Le Moal <damien.lemoal@wdc.com>
> +M:	Naohiro Aota <naohiro.aota@wdc.com>
> +R:	Johannes Thumshirn <jth@kernel.org>
> +L:	linux-fsdevel@vger.kernel.org
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs.git
> +S:	Maintained
> +F:	fs/zonefs/
> +
>   ZPOOL COMPRESSED PAGE STORAGE API
>   M:	Dan Streetman <ddstreet@ieee.org>
>   L:	linux-mm@kvack.org
> diff --git a/fs/Kconfig b/fs/Kconfig
> index 7b623e9fc1b0..a3f97ca2bd46 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -40,6 +40,7 @@ source "fs/ocfs2/Kconfig"
>   source "fs/btrfs/Kconfig"
>   source "fs/nilfs2/Kconfig"
>   source "fs/f2fs/Kconfig"
> +source "fs/zonefs/Kconfig"
>   
>   config FS_DAX
>   	bool "Direct Access (DAX) support"
> diff --git a/fs/Makefile b/fs/Makefile
> index 1148c555c4d3..527f228a5e8a 100644
> --- a/fs/Makefile
> +++ b/fs/Makefile
> @@ -133,3 +133,4 @@ obj-$(CONFIG_CEPH_FS)		+= ceph/
>   obj-$(CONFIG_PSTORE)		+= pstore/
>   obj-$(CONFIG_EFIVAR_FS)		+= efivarfs/
>   obj-$(CONFIG_EROFS_FS)		+= erofs/
> +obj-$(CONFIG_ZONEFS_FS)		+= zonefs/
> diff --git a/fs/zonefs/Kconfig b/fs/zonefs/Kconfig
> new file mode 100644
> index 000000000000..6490547e9763
> --- /dev/null
> +++ b/fs/zonefs/Kconfig
> @@ -0,0 +1,9 @@
> +config ZONEFS_FS
> +	tristate "zonefs filesystem support"
> +	depends on BLOCK
> +	depends on BLK_DEV_ZONED
> +	help
> +	  zonefs is a simple File System which exposes zones of a zoned block
> +	  device as files.
> +
> +	  If unsure, say N.
> diff --git a/fs/zonefs/Makefile b/fs/zonefs/Makefile
> new file mode 100644
> index 000000000000..75a380aa1ae1
> --- /dev/null
> +++ b/fs/zonefs/Makefile
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_ZONEFS_FS) += zonefs.o
> +
> +zonefs-y	:= super.o
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
> new file mode 100644
> index 000000000000..5a2558cae3e3
> --- /dev/null
> +++ b/fs/zonefs/super.c
> @@ -0,0 +1,1158 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Simple zone file system for zoned block devices.
> + *
> + * Copyright (C) 2019 Western Digital Corporation or its affiliates.
> + */
> +#include <linux/module.h>
> +#include <linux/fs.h>
> +#include <linux/magic.h>
> +#include <linux/iomap.h>
> +#include <linux/init.h>
> +#include <linux/slab.h>
> +#include <linux/blkdev.h>
> +#include <linux/statfs.h>
> +#include <linux/writeback.h>
> +#include <linux/quotaops.h>
> +#include <linux/seq_file.h>
> +#include <linux/parser.h>
> +#include <linux/uio.h>
> +#include <linux/mman.h>
> +#include <linux/sched/mm.h>
> +#include <linux/crc32.h>
> +
> +#include "zonefs.h"
> +
> +static int zonefs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
> +			      unsigned int flags, struct iomap *iomap,
> +			      struct iomap *srcmap)
> +{
> +	struct zonefs_sb_info *sbi = ZONEFS_SB(inode->i_sb);
> +	struct zonefs_inode_info *zi = ZONEFS_I(inode);
> +	loff_t max_isize = zi->i_max_size;
> +	loff_t isize;
> +
> +	/*
> +	 * For sequential zones, enforce direct IO writes. This is already
> +	 * checked when writes are issued, so warn about this here if we
> +	 * get buffered write to a sequential file inode.
> +	 */
> +	if (WARN_ON_ONCE(zi->i_ztype == ZONEFS_ZTYPE_SEQ &&
> +			 (flags & IOMAP_WRITE) && !(flags & IOMAP_DIRECT)))
> +		return -EIO;
> +
> +	/*
> +	 * For all zones, all blocks are always mapped. For sequential zones,
> +	 * all blocks after the write pointer (inode size) are always unwritten.
> +	 */
> +	mutex_lock(&zi->i_truncate_mutex);
> +	isize = i_size_read(inode);
> +	if (offset >= isize) {
> +		length = min(length, max_isize - offset);
> +		if (zi->i_ztype == ZONEFS_ZTYPE_CNV)
> +			iomap->type = IOMAP_MAPPED;
> +		else
> +			iomap->type = IOMAP_UNWRITTEN;
> +	} else {
> +		length = min(length, isize - offset);
> +		iomap->type = IOMAP_MAPPED;
> +	}
> +	mutex_unlock(&zi->i_truncate_mutex);
> +
> +	iomap->offset = offset & (~sbi->s_blocksize_mask);
> +	iomap->length = ((offset + length + sbi->s_blocksize_mask) &
> +			 (~sbi->s_blocksize_mask)) - iomap->offset;
> +	iomap->bdev = inode->i_sb->s_bdev;
> +	iomap->addr = (zi->i_zsector << SECTOR_SHIFT) + iomap->offset;
> +
> +	return 0;
> +}
> +
> +static const struct iomap_ops zonefs_iomap_ops = {
> +	.iomap_begin	= zonefs_iomap_begin,
> +};
> +
This probably shows my complete ignorance, but what is the effect on 
enforcing the direct I/O writes on the pagecache?
IE what happens for buffered reads? Will the pages be invalidated when a 
write has been issued?
Or do we simply rely on upper layers to ensure no concurrent buffered 
and direct I/O is being made?

[ .. ]
> +
> +static int zonefs_seq_file_truncate(struct inode *inode, loff_t isize)
> +{
> +	struct zonefs_inode_info *zi = ZONEFS_I(inode);
> +	loff_t old_isize;
> +	enum req_opf op;
> +	int ret = 0;
> +
> +	/*
> +	 * For sequential zone files, we can only allow truncating to 0 size,
> +	 * which is equivalent to a zone reset, or to the maximum file size,
> +	 * which is equivalent toa zone finish.

Spelling: to a

[ .. ]

Other than that:
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
