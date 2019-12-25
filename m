Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A798012A569
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Dec 2019 02:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbfLYBdY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Dec 2019 20:33:24 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44870 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbfLYBdY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Dec 2019 20:33:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=B7vf1Lr+0vpG04aPGihhTl0MZWGW2MJj0bafFcdjdMk=; b=HNWZ4B+qJ+4daIU9cLRoqebso
        uD0fy9nZmBV34lrqbLjTU8poeKfZ8vKMXJ+2bkyzBhGtWjQT+Ojzxn/OD5r/OJ+TkMSmLQMQBUm3Y
        /i22SV476jUCPkq6ofG4atiwSOSOSmeWY4cTY3OuWpVY0p7WFx+uiJOMJZ1FPv13SP4peiUOwM6Fj
        /DIWN8DGtSa7+t6BshbY8SaTekZt9S8nq/PF8/q6MK2zBJ/z/gKJxtNE+zO2HzUMC68WSxWAQhFmd
        H5et2qhXxS0JUWaP7uu+Eff3xnq4zNEPXSwYF1opPNiUR2yZWtsiX1vwxOqk55Gad28OIb9LIbyHM
        XzTIvF1Jg==;
Received: from [2601:1c0:6280:3f0::fee9]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ijvY4-0001B5-EY; Wed, 25 Dec 2019 01:33:16 +0000
Subject: Re: [PATCH v3 2/2] zonefs: Add documentation
To:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Johannes Thumshirn <jth@kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Hannes Reinecke <hare@suse.de>
References: <20191224020615.134668-1-damien.lemoal@wdc.com>
 <20191224020615.134668-3-damien.lemoal@wdc.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ac1bd604-0088-2002-f03b-5752425bb530@infradead.org>
Date:   Tue, 24 Dec 2019 17:33:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191224020615.134668-3-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Just a few typos and nits and a few questions...

On 12/23/19 6:06 PM, Damien Le Moal wrote:
> Add the new file Documentation/filesystems/zonefs.txt to document zonefs
> principles and user-space tool usage.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> Reviewed-by: Hannes Reinecke <hare@suse.com>
> Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
> ---
>  Documentation/filesystems/zonefs.txt | 215 +++++++++++++++++++++++++++
>  MAINTAINERS                          |   1 +
>  2 files changed, 216 insertions(+)
>  create mode 100644 Documentation/filesystems/zonefs.txt
> 
> diff --git a/Documentation/filesystems/zonefs.txt b/Documentation/filesystems/zonefs.txt
> new file mode 100644
> index 000000000000..e88a4743bc64
> --- /dev/null
> +++ b/Documentation/filesystems/zonefs.txt
> @@ -0,0 +1,215 @@
> +ZoneFS - Zone filesystem for Zoned block devices
> +
> +Overview
> +========
> +
> +zonefs is a very simple file system exposing each zone of a zoned block device
> +as a file. Unlike a regular file system with zoned block device support (e.g.
> +f2fs), zonefs does not hide the sequential write constraint of zoned block
> +devices to the user. Files representing sequential write zones of the device
> +must be written sequentially starting from the end of the file (append only
> +writes).
> +
> +As such, zonefs is in essence closer to a raw block device access interface
> +than to a full featured POSIX file system. The goal of zonefs is to simplify
> +the implementation of zoned block devices support in applications by replacing

                      of zoned block device support

> +raw block device file accesses with a richer file API, avoiding relying on
> +direct block device file ioctls which may be more obscure to developers. One
> +example of this approach is the implementation of LSM (log-structured merge)
> +tree structures (such as used in RocksDB and LevelDB) on zoned block devices
> +by allowing SSTables to be stored in a zone file similarly to a regular file
> +system rather than as a range of sectors of the entire disk. The introduction
> +of the higher level construct "one file is one zone" can help reducing the
> +amount of changes needed in the application as well as introducing support for
> +different application programming languages.
> +
> +zonefs on-disk metadata
> +-----------------------
> +
> +zonefs on-disk metadata is reduced to an immutable super block which
> +persistently stores a magic number and optional features flags and values. On

                                                   feature

> +mount, zonefs uses blkdev_report_zones() to obtain the device zone configuration
> +and populates the mount point with a static file tree solely based on this
> +information. File sizes come from the device zone type and write pointer
> +position managed by the device itself.
> +
> +The super block is always writen on disk at sector 0. The first zone of the

                             written

> +device storing the super block is never exposed as a zone file by zonefs. If the
> +zone containing the super block is a sequential zone, the mkzonefs format tool
> +always "finishes" the zone, that is, transition the zone to a full state to make

                                        it transitions the zone

> +it readonly, preventing any data write.
> +
> +Zone type sub-directories
> +-------------------------
> +
> +Files representing zones of the same type are grouped together under the same
> +sub-directory automatically created on mount.
> +
> +For conventional zones, the sub-directory "cnv" is used. This directory is
> +however created only and only if the device has useable conventional zones. If

                   if and only if                  usable

> +the device only has a single conventional zone at sector 0, the zone will not
> +be exposed as a file as it will be used to store zonefs super block. For such

                                           to store the zonefs super block.

> +devices, the "cnv" sub-directory will not be created.
> +
> +For sequential write zones, the sub-directory "seq" is used.
> +
> +These two directories are the only directories that exist in zonefs. Users
> +cannot create other directories and cannot rename nor delete the "cnv" and
> +"seq" sub-directories.
> +
> +The size of the directories indicated by the st_size field of struct stat,
> +obtained with the stat() or fstat() system calls, indicate the number of files

                                                     indicates

> +existing under the directory.
> +
> +Zone files
> +----------
> +
> +Zone files are named using the number of the zone they represent within the set
> +of zones of a particular type. That is, both the "cnv" and "seq" directories
> +contain files named "0", "1", "2", ... The file numbers also represent
> +increasing zone start sector on the device.
> +
> +All read and write operations to zone files are not allowed beyond the file
> +maximum size, that is, beyond the zone size. Any access exceeding the zone
> +size is failed with the -EFBIG error.
> +
> +Creating, deleting, renaming or modifying any attribute of files and
> +sub-directories is not allowed.
> +
> +The number of blocks of a file as reported by stat() and fstat() indicates the
> +size of the file zone, or in other words, the maximum file size.
> +
> +Conventional zone files
> +-----------------------
> +
> +The size of conventional zone files is fixed to the size of the zone they
> +represent. Conventional zone files cannot be truncated.
> +
> +These files can be randomly read and written, using any form of IO operation:
> +buffered IOs, direct IOs, memory mapped IOs (mmap) etc. There are no IO

                                                     , etc.

> +constraint for these files beyond the file size limit mentioned above.

   constraints

> +
> +Sequential zone files
> +---------------------
> +
> +The size of sequential zone files present in the "seq" sub-directory represent

                                                                        represents

> +the file's zone write pointer position relative to the zone start sector.
> +
> +Sequential zone files can only be written sequentially, starting from the file
> +end, that is, write operations can only be append writes. Zonefs makes no
> +attempt at accepting random writes and will fail any write request that has a
> +start offset not corresponding to the end of the last issued write.
> +
> +In order to give guarantees regarding write ordering, zonefs also prevents
> +buffered writes and mmap writes for sequential files. Only direct IO writes are
> +accepted. There are no restrictions on read operations nor on the type of IO
> +used to request reads (buffered IOs, direct IOs and mmap reads are all
> +accepted).
> +
> +Truncating sequential zone files is allowed only down to 0, in wich case, the

                                                                  which

> +zone is reset to rewind the file zone write pointer position to the start of
> +the zone, or up to the zone size, in which case the file's zone is transitioned
> +to the FULL state (finish zone operation).

Just to clarify, truncate can be done to zero or the the zone size, but nothing else.
Is that correct?

> +
> +zonefs format options
> +---------------------
> +
> +Several optional features of zonefs can be enabled at format time.
> +* Conventional zone aggregation: ranges of contiguous conventional zones can be
> +  agregated into a single larger file instead of the default one file per zone.

     aggregated

> +* File ownership: The owner UID and GID of zone files is by default 0 (root)
> +  but can be changed to any valid UID/GID.
> +* File access permissions: the default 640 access permissions can be changed.
> +
> +User Space Tools
> +----------------
> +
> +The mkzonefs tool is used to format zoned block devices for use with zonefs.
> +This tool is available on Github at:
> +
> +git@github.com:damien-lemoal/zonefs-tools.git.

maybe better to say:  https://github.com/damien-lemoal/zonefs-tools

> +
> +zonefs-tools also includes a test suite which can be run against any zoned
> +block device, including null_blk block device created with zoned mode.
> +
> +Examples
> +--------
> +
> +The following formats a 15TB host-managed SMR HDD with 256 MB zones
> +with the conventional zones aggregation feature enabled.
> +
> +# mkzonefs -o aggr_cnv /dev/sdX
> +# mount -t zonefs /dev/sdX /mnt
> +# ls -l /mnt/
> +total 0
> +dr-xr-xr-x 2 root root     1 Nov 25 13:23 cnv
> +dr-xr-xr-x 2 root root 55356 Nov 25 13:23 seq
> +
> +The size of the zone files sub-directories indicate the number of files
> +existing for each type of zones. In this example, there is only one
> +conventional zone file (all conventional zones are agreggated under a single

                                                      aggregated

> +file).
> +
> +# ls -l /mnt/cnv
> +total 137101312
> +-rw-r----- 1 root root 140391743488 Nov 25 13:23 0
> +
> +This aggregated conventional zone file can be used as a regular file.
> +
> +# mkfs.ext4 /mnt/cnv/0
> +# mount -o loop /mnt/cnv/0 /data
> +
> +The "seq" sub-directory grouping files for sequential write zones has in this
> +example 55356 zones.
> +
> +# ls -lv /mnt/seq
> +total 14511243264
> +-rw-r----- 1 root root 0 Nov 25 13:23 0
> +-rw-r----- 1 root root 0 Nov 25 13:23 1
> +-rw-r----- 1 root root 0 Nov 25 13:23 2
> +...
> +-rw-r----- 1 root root 0 Nov 25 13:23 55354
> +-rw-r----- 1 root root 0 Nov 25 13:23 55355
> +
> +For sequential write zone files, the file size changes as data is appended at
> +the end of the file, similarly to any regular file system.
> +
> +# dd if=/dev/zero of=/mnt/seq/0 bs=4096 count=1 conv=notrunc oflag=direct
> +1+0 records in
> +1+0 records out
> +4096 bytes (4.1 kB, 4.0 KiB) copied, 1.05112 s, 3.9 kB/s

why so slow?

> +
> +# ls -l /mnt/seq/0
> +-rw-r----- 1 root root 4096 Nov 25 13:23 /mnt/sdh/seq/0

I don't understand the "sdh/" here. Please explain for me (not necessarily
in the doc file).

> +
> +The written file can be truncated to the zone size, prventing any further write

                                                       preventing

> +operation.
> +
> +# truncate -s 268435456 /mnt/seq/0
> +# ls -l /mnt/seq/0
> +-rw-r----- 1 root root 268435456 Nov 25 13:49 /mnt/seq/0
> +
> +Truncation to 0 size allows freeing the file zone storage space and restart
> +append-writes to the file.
> +
> +# truncate -s 0 /mnt/seq/0
> +# ls -l /mnt/seq/0
> +-rw-r----- 1 root root 0 Nov 25 13:49 /mnt/seq/0
> +
> +Since files are statically mapped to zones on the disk, the number of blocks of
> +a file as reported by stat() and fstat() indicates the size of the file zone.
> +
> +# stat /mnt/seq/0
> +  File: /mnt/seq/0
> +  Size: 0         	Blocks: 524288     IO Block: 4096   regular empty file
> +Device: 870h/2160d	Inode: 50431       Links: 1
> +Access: (0640/-rw-r-----)  Uid: (    0/    root)   Gid: (    0/    root)
> +Access: 2019-11-25 13:23:57.048971997 +0900
> +Modify: 2019-11-25 13:52:25.553805765 +0900
> +Change: 2019-11-25 13:52:25.553805765 +0900
> + Birth: -
> +
> +The number of blocks of the file ("Blocks") in units of 512B blocks gives the
> +maximum file size of 524288 * 512 B = 256 MB, corresponding to the device zone
> +size in this example. Of note is that the "IO block" field always indicates the
> +minimum IO size for writes and corresponds to the device physical sector size.


thanks.
-- 
~Randy

