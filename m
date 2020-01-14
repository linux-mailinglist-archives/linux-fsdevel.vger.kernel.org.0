Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAA0913B1FB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2020 19:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbgANSYu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jan 2020 13:24:50 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51598 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgANSYu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jan 2020 13:24:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lCcGhYDre5ydVBW+5WHNxQD/UQCIFzV1hH0V2qK7F40=; b=fedTnQS9jIpNs0eLEN5qnEYF6
        +Y/cdlMjZeDk/ALvDq+QckTe7dAsmd+zTTIm8P01V3BevklKWL/uBGSfY2QMoPd2kkN/C71esgiYJ
        kDPcUW++4RS/Ss+pdd+DqcgzRPWLhnG7RMjNBpNB7X5J+0lm2+xDb0FdqrX3XlzUq+zo5J9Pc1s7l
        u04vPQdzdFj1FCu0GyNo3BgaXu8IW6s7Ylq9LdP23l39IgMHpZ5p1pCnDNolrnvV/q5b8NSpKADSc
        1rszFjyaHhijPVtTkxFK5e4JzZXfDj86sDwJ0QvyLDVIgWJ6tAHxlHf+0g+zybBrur80t2MT+BzPo
        Knfc9CNqQ==;
Received: from [2603:3004:32:9a00::7442]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1irQrs-0005bf-PV; Tue, 14 Jan 2020 18:24:44 +0000
Subject: Re: [PATCH v6 2/2] zonefs: Add documentation
To:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Johannes Thumshirn <jth@kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Hannes Reinecke <hare@suse.de>
References: <20200108083649.450834-1-damien.lemoal@wdc.com>
 <20200108083649.450834-3-damien.lemoal@wdc.com>
From:   Randy Dunlap <rdunlap@infradead.org>
X-Enigmail-Draft-Status: N11100
Message-ID: <c9f37661-03a0-22e3-4b99-b97c47917b5d@infradead.org>
Date:   Tue, 14 Jan 2020 10:24:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200108083649.450834-3-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Damien,

Here are a few editorial comments for you...


On 1/8/20 12:36 AM, Damien Le Moal wrote:
> Add the new file Documentation/filesystems/zonefs.txt to document
> zonefs principles and user-space tool usage.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
> ---
>  Documentation/filesystems/zonefs.txt | 241 +++++++++++++++++++++++++++
>  MAINTAINERS                          |   1 +
>  2 files changed, 242 insertions(+)
>  create mode 100644 Documentation/filesystems/zonefs.txt
> 
> diff --git a/Documentation/filesystems/zonefs.txt b/Documentation/filesystems/zonefs.txt
> new file mode 100644
> index 000000000000..97008eb8ff82
> --- /dev/null
> +++ b/Documentation/filesystems/zonefs.txt
> @@ -0,0 +1,241 @@
> +ZoneFS - Zone filesystem for Zoned block devices
> +
> +Overview
> +========
> +
> +zonefs is a very simple file system exposing each zone of a zoned block device
> +as a file. Unlike a regular POSIX-compliant file system with native zoned block
> +device support (e.g. f2fs), zonefs does not hide the sequential write
> +constraint of zoned block devices to the user. Files representing sequential
> +write zones of the device must be written sequentially starting from the end
> +of the file (append only writes).
> +
> +As such, zonefs is in essence closer to a raw block device access interface
> +than to a full featured POSIX file system. The goal of zonefs is to simplify

             full-featured

> +the implementation of zoned block device support in applications by replacing> +direct block device file ioctls which may be more obscure to developers. One
> +example of this approach is the implementation of LSM (log-structured merge)
> +tree structures (such as used in RocksDB and LevelDB) on zoned block devices
> +by allowing SSTables to be stored in a zone file similarly to a regular file
> +system rather than as a range of sectors of the entire disk. The introduction
> +of the higher level construct "one file is one zone" can help reducing the
> +amount of changes needed in the application as well as introducing support for
> +different application programming languages.
> +
> +Zoned block devices
> +-------------------
> +
> +Zoned storage devices belong to a class of storage devices with an address
> +space that is divided into zones. A zone is a group of consecutive LBAs and all
> +zones are contiguous (there are no LBA gaps). Zones may have different types.
> +* Conventional zones: there are no access constraints to LBAs belonging to
> +  conventional zones. Any read or write access can be executed, similarly to a
> +  regular block device.
> +* Sequential zones: these zones accept random reads but must be written
> +  sequentially. Each sequential zone has a write pointer maintained by the
> +  device that keeps track of the mandatory start LBA position of the next write
> +  to the device. As a result of this write constraint, LBAs in a sequential zone
> +  cannot be overwritten. Sequential zones must first be erased using a special
> +  command (zone reset) before rewritting.

                                 rewriting.

> +
> +Zoned storage devices can be implemented using various recording and media
> +technologies. The most common form of zoned storage today uses the SCSI Zoned
> +Block Commands (ZBC) and Zoned ATA Commands (ZAC) interfaces on Shingled
> +Magnetic Recording (SMR) HDDs.
> +
> +Solid State Disks (SSD) storage devices can also implement a zoned interface
> +to, for instance, reduce internal write amplification due to garbage collection.
> +The NVMe Zoned NameSpace (ZNS) is a technical proposal of the NVMe standard
> +committee aiming at adding a zoned storage interface to the NVMe protocol.
> +
> +zonefs on-disk metadata
> +-----------------------
> +
> +zonefs on-disk metadata is reduced to an immutable super block which
> +persistently stores a magic number and optional feature flags and values. On
> +mount, zonefs uses blkdev_report_zones() to obtain the device zone configuration
> +and populates the mount point with a static file tree solely based on this
> +information. File sizes come from the device zone type and write pointer
> +position managed by the device itself.
> +
> +The super block is always written on disk at sector 0. The first zone of the
> +device storing the super block is never exposed as a zone file by zonefs. If
> +the zone containing the super block is a sequential zone, the mkzonefs format
> +tool always "finishes" the zone, that is, it transitions the zone to a full
> +state to make it read-only, preventing any data write.
> +
> +Zone type sub-directories
> +-------------------------
> +
> +Files representing zones of the same type are grouped together under the same
> +sub-directory automatically created on mount.
> +
> +For conventional zones, the sub-directory "cnv" is used. This directory is
> +however created if and only if the device has usable conventional zones. If
> +the device only has a single conventional zone at sector 0, the zone will not
> +be exposed as a file as it will be used to store the zonefs super block. For
> +such devices, the "cnv" sub-directory will not be created.
> +
> +For sequential write zones, the sub-directory "seq" is used.
> +
> +These two directories are the only directories that exist in zonefs. Users
> +cannot create other directories and cannot rename nor delete the "cnv" and
> +"seq" sub-directories.
> +
> +The size of the directories indicated by the st_size field of struct stat,
> +obtained with the stat() or fstat() system calls, indicates the number of files
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
> +buffered IOs, direct IOs, memory mapped IOs (mmap), etc. There are no IO
> +constraint for these files beyond the file size limit mentioned above.

I would prefer to see "I/O" here instead of "IO", but that's just a nit.

> +
> +Sequential zone files
> +---------------------
> +
> +The size of sequential zone files present in the "seq" sub-directory represents
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

ditto.

> +
> +Truncating sequential zone files is allowed only down to 0, in which case, the
> +zone is reset to rewind the file zone write pointer position to the start of
> +the zone, or up to the zone size, in which case the file's zone is transitioned
> +to the FULL state (finish zone operation).
> +
> +zonefs format options
> +---------------------
> +
> +Several optional features of zonefs can be enabled at format time.
> +* Conventional zone aggregation: ranges of contiguous conventional zones can be
> +  aggregated into a single larger file instead of the default one file per zone.
> +* File ownership: The owner UID and GID of zone files is by default 0 (root)
> +  but can be changed to any valid UID/GID.
> +* File access permissions: the default 640 access permissions can be changed.
> +
> +User Space Tools
> +================
> +
> +The mkzonefs tool is used to format zoned block devices for use with zonefs.
> +This tool is available on Github at:
> +
> +https://github.com/damien-lemoal/zonefs-tools
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
> +conventional zone file (all conventional zones are aggregated under a single
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

Still slow.  You don't want to change that?

> +
> +# ls -l /mnt/seq/0
> +-rw-r----- 1 root root 4096 Nov 25 13:23 /mnt/seq/0
> +
> +The written file can be truncated to the zone size, preventing any further
> +write operation.
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
