Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA2DF1449A1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2020 02:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbgAVB6I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jan 2020 20:58:08 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:55146 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726396AbgAVB6I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jan 2020 20:58:08 -0500
Received: from dread.disaster.area (pa49-181-218-253.pa.nsw.optusnet.com.au [49.181.218.253])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id D8C383A20B2;
        Wed, 22 Jan 2020 12:57:58 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iu5HJ-0000e5-JG; Wed, 22 Jan 2020 12:57:57 +1100
Date:   Wed, 22 Jan 2020 12:57:57 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Johannes Thumshirn <jth@kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v8 1/2] fs: New zonefs file system
Message-ID: <20200122015757.GG9407@dread.disaster.area>
References: <20200121065846.216538-1-damien.lemoal@wdc.com>
 <20200121065846.216538-2-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200121065846.216538-2-damien.lemoal@wdc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=LYdCFQXi c=1 sm=1 tr=0
        a=TU0PeEMO9XNyODJ+pEfdLw==:117 a=TU0PeEMO9XNyODJ+pEfdLw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=Jdjhy38mL1oA:10
        a=7-415B0cAAAA:8 a=uG8Sni3PD9131csrXFQA:9 a=ZAq4knvq0sbCs-1K:21
        a=1709yZKkk6hjmF5l:21 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Damien,

I've finally had a chance to recover from LCA, catch up and look at
this again. Overall, pretty good, but a few comments below....

On Tue, Jan 21, 2020 at 03:58:45PM +0900, Damien Le Moal wrote:
> zonefs is a very simple file system exposing each zone of a zoned block
> device as a file. Unlike a regular file system with zoned block device
> support (e.g. f2fs), zonefs does not hide the sequential write
> constraint of zoned block devices to the user. Files representing
> sequential write zones of the device must be written sequentially
> starting from the end of the file (append only writes).

....

> --- /dev/null
> +++ b/fs/zonefs/super.c
> @@ -0,0 +1,1178 @@
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

Something was bugging me about this, and reading the rest of the
patch it finally triggered. For conventional zones, inode->i_size =
zi->i_max_size, and so if offset >= isize for a conventional
zone then this:

	length = min(length, max_isize - offset);

is going to result in length <= 0 and we return a negative length
iomap.

IOWs, this case should only trigger for IO into sequential zones,
as it appears to be prevented at higher layers for conventional
zones by explicit checks against i_max_size and/or
iov_iter_truncate() calls to ensure user IOs are limited to within
i_max_size.

Hence it looks to me that triggering the (offset >= isize) case here
for conventional zones is a WARN_ON_ONCE() and return -EIO
situation...

SO, perhaps:

	isize = i_size_read(inode);
	if (offset >= isize) {
		if (WARN_ON_ONCE(i->i_ztype == ZONEFS_ZTYPE_CNV)) {
			/* drop locks */
			return -EIO;
		}
		length = min(length, max_isize - offset);
		iomap->type = IOMAP_UNWRITTEN;
	} else {
		length = min(length, isize - offset);
		iomap->type = IOMAP_MAPPED;
	}

This also seems tailored around the call from zonefs_map_blocks()
which tries to map the entire zone (length = zi->i_max_size) for
writeback mappings. Hence the length in this case always requires
clamping to zi->i_max_size - offset. Again, there's an issue here:

> +static int zonefs_map_blocks(struct iomap_writepage_ctx *wpc,
> +			     struct inode *inode, loff_t offset)
> +{
> +	if (offset >= wpc->iomap.offset &&
> +	    offset < wpc->iomap.offset + wpc->iomap.length)
> +		return 0;
> +
> +	memset(&wpc->iomap, 0, sizeof(wpc->iomap));
> +	return zonefs_iomap_begin(inode, offset, ZONEFS_I(inode)->i_max_size,
> +				  0, &wpc->iomap, NULL);

Where we pass flags = 0 into zonefs_iomap_begin(), and so there is
no checking that this writeback code path is only executing against
a conventional zone. I.e. the comments and checks in
zonefs_iomap_begin() relate only to user IO call paths, but don't
validate or comment on the writeback path callers, and there's no
comments or checks here that the inode points at a conventional
zone, either....

> +static vm_fault_t zonefs_filemap_fault(struct vm_fault *vmf)
> +{
> +	struct zonefs_inode_info *zi = ZONEFS_I(file_inode(vmf->vma->vm_file));
> +	vm_fault_t ret;
> +
> +	down_read(&zi->i_mmap_sem);
> +	ret = filemap_fault(vmf);
> +	up_read(&zi->i_mmap_sem);
> +
> +	return ret;
> +}
> +
> +static vm_fault_t zonefs_filemap_page_mkwrite(struct vm_fault *vmf)
> +{
> +	struct inode *inode = file_inode(vmf->vma->vm_file);
> +	struct zonefs_inode_info *zi = ZONEFS_I(inode);
> +	vm_fault_t ret;
> +
> +	sb_start_pagefault(inode->i_sb);
> +	file_update_time(vmf->vma->vm_file);
> +
> +	/* Serialize against truncates */
> +	down_read(&zi->i_mmap_sem);
> +	ret = iomap_page_mkwrite(vmf, &zonefs_iomap_ops);
> +	up_read(&zi->i_mmap_sem);
> +
> +	sb_end_pagefault(inode->i_sb);
> +	return ret;
> +}

Should there be a WARN_ON_ONCE(zi->zi_type != ZONEFS_ZTYPE_CNV) in
here?

> +static ssize_t zonefs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
> +{
> +	struct inode *inode = file_inode(iocb->ki_filp);
> +	struct zonefs_sb_info *sbi = ZONEFS_SB(inode->i_sb);
> +	struct zonefs_inode_info *zi = ZONEFS_I(inode);
> +	loff_t max_pos;
> +	size_t count;
> +	ssize_t ret;
> +
> +	if (iocb->ki_pos >= zi->i_max_size)
> +		return 0;
> +
> +	if (iocb->ki_flags & IOCB_NOWAIT) {
> +		if (!inode_trylock_shared(inode))
> +			return -EAGAIN;
> +	} else {
> +		inode_lock_shared(inode);
> +	}

We should really turn that into a generic helper. This pattern is
being replicated all over the place. Not in this patchset, though...

> +static int zonefs_report_zones_err_cb(struct blk_zone *zone, unsigned int idx,
> +				      void *data)
> +{
> +	struct inode *inode = data;
> +	struct zonefs_inode_info *zi = ZONEFS_I(inode);
> +	loff_t pos;
> +
> +	/*
> +	 * The condition of the zone may have change. Check it and adjust the
> +	 * inode information as needed, similarly to zonefs_init_file_inode().
> +	 */
> +	if (zone->cond == BLK_ZONE_COND_OFFLINE) {
> +		inode->i_flags |= S_IMMUTABLE;
> +		inode->i_mode &= ~0777;
> +		zone->wp = zone->start;
> +	} else if (zone->cond == BLK_ZONE_COND_READONLY) {
> +		inode->i_flags |= S_IMMUTABLE;
> +		inode->i_mode &= ~0222;
> +	}

This exact code is repeated in zonefs_init_file_inode(). Maybe it
should be a helper function?

> +
> +	pos = (zone->wp - zone->start) << SECTOR_SHIFT;
> +	zi->i_wpoffset = pos;
> +	if (i_size_read(inode) != pos) {
> +		zonefs_update_stats(inode, pos);
> +		i_size_write(inode, pos);
> +	}

What happens if this decreases the size of the zone? don't we need
to invalidate the page cache beyond the new EOF in this case (i.e.
it's a truncate operation)?

> +static int zonefs_seq_file_write_failed(struct inode *inode, int error)
> +{
> +	struct zonefs_inode_info *zi = ZONEFS_I(inode);
> +	struct super_block *sb = inode->i_sb;
> +	sector_t sector = zi->i_zsector;
> +	unsigned int nofs_flag;
> +	int ret;
> +
> +	zonefs_warn(sb, "Updating inode zone %llu info\n", sector);
> +
> +	/*
> +	 * blkdev_report_zones() uses GFP_KERNEL by default. Force execution as
> +	 * if GFP_NOFS was specified so that it will not end up recursing into
> +	 * the FS on memory allocation.
> +	 */
> +	nofs_flag = memalloc_nofs_save();
> +	ret = blkdev_report_zones(sb->s_bdev, sector, 1,
> +				  zonefs_report_zones_err_cb, inode);
> +	memalloc_nofs_restore(nofs_flag);

The comment is kinda redundant - it's explaining exactly what the
code does rather than why it needs this protection. i.e. the comment
should explain the recursion vector/deadlock that we are avoiding
here...

> +static int zonefs_file_dio_write_end(struct kiocb *iocb, ssize_t size, int ret,
> +				     unsigned int flags)
> +{
> +	struct inode *inode = file_inode(iocb->ki_filp);
> +	struct zonefs_inode_info *zi = ZONEFS_I(inode);
> +
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Conventional zone file size is fixed to the zone size so there
> +	 * is no need to do anything.
> +	 */
> +	if (zi->i_ztype == ZONEFS_ZTYPE_CNV)
> +		return 0;
> +
> +	mutex_lock(&zi->i_truncate_mutex);
> +
> +	if (size < 0) {
> +		ret = zonefs_seq_file_write_failed(inode, size);

Ok, so I see it is being called from IO completion context, whcih
means we'd want memalloc_noio_save() because the underlying bio
doesn't get freed until this whole completion runs, right?

> +static ssize_t zonefs_file_dio_write(struct kiocb *iocb, struct iov_iter *from)
> +{
> +	struct inode *inode = file_inode(iocb->ki_filp);
> +	struct zonefs_sb_info *sbi = ZONEFS_SB(inode->i_sb);
> +	struct zonefs_inode_info *zi = ZONEFS_I(inode);
> +	size_t count;
> +	ssize_t ret;
> +
> +	if (iocb->ki_flags & IOCB_NOWAIT) {
> +		if (!inode_trylock(inode))
> +			return -EAGAIN;
> +	} else {
> +		inode_lock(inode);
> +	}
> +
> +	ret = generic_write_checks(iocb, from);
> +	if (ret <= 0)
> +		goto out;
> +
> +	iov_iter_truncate(from, zi->i_max_size - iocb->ki_pos);
> +	count = iov_iter_count(from);

So count is initialised to the entire IO length....

> +
> +	/*
> +	 * Direct writes must be aligned to the block size, that is, the device
> +	 * physical sector size, to avoid errors when writing sequential zones
> +	 * on 512e devices (512B logical sector, 4KB physical sectors).
> +	 */
> +	if ((iocb->ki_pos | count) & sbi->s_blocksize_mask) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	/*
> +	 * Enforce sequential writes (append only) in sequential zones.
> +	 */
> +	mutex_lock(&zi->i_truncate_mutex);
> +	if (zi->i_ztype == ZONEFS_ZTYPE_SEQ &&
> +	    iocb->ki_pos != zi->i_wpoffset) {
> +		zonefs_err(inode->i_sb,
> +			   "Unaligned write at %llu + %zu (wp %llu)\n",
> +			   iocb->ki_pos, count,
> +			   zi->i_wpoffset);
> +		mutex_unlock(&zi->i_truncate_mutex);
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +	mutex_unlock(&zi->i_truncate_mutex);
> +
> +	ret = iomap_dio_rw(iocb, from, &zonefs_iomap_ops, &zonefs_dio_ops,
> +			   is_sync_kiocb(iocb));
> +	if (zi->i_ztype == ZONEFS_ZTYPE_SEQ &&
> +	    (ret > 0 || ret == -EIOCBQUEUED)) {
> +		if (ret > 0)
> +			count = ret;
> +		mutex_lock(&zi->i_truncate_mutex);
> +		zi->i_wpoffset += count;
> +		mutex_unlock(&zi->i_truncate_mutex);

Hmmmm. This looks problematic w.r.t. AIO. If we get -EIOCBQUEUED it
means the IO has been queued but not necessarily submitted, but
we update zi->i_wpoffset as though the entire AIO has laready
completed. ANd then we drop the inode_lock() and return, allowing
another AIO+DIO to be started.

Hence another concurrent sequential AIO+DIO write could now be
submitted and pass the above iocb->ki_pos != zi->i_wpoffset check.
Now we have two independent IOs in flight - one that is at the
current hardware write pointer offset, and one that is beyond it.

What happens if the block layer now re-orders these two IOs?


> +static struct dentry *zonefs_create_inode(struct dentry *parent,
> +					const char *name, struct blk_zone *zone)
> +{
> +	struct inode *dir = d_inode(parent);
> +	struct dentry *dentry;
> +	struct inode *inode;
> +
> +	dentry = d_alloc_name(parent, name);
> +	if (!dentry)
> +		return NULL;
> +
> +	inode = new_inode(parent->d_sb);
> +	if (!inode)
> +		goto out;
> +
> +	inode->i_ino = get_next_ino();

get_next_ino() doesn't guarantee inode number uniqueness (it's 32
bit and global across all filesystems so it can overflow). Are
duplicate inode numbers on this superblock an issue?

> +/*
> + * Read super block information from the device.
> + */
> +static int zonefs_read_super(struct super_block *sb)
> +{
> +	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
> +	struct zonefs_super *super;
> +	u32 crc, stored_crc;
> +	struct page *page;
> +	struct bio_vec bio_vec;
> +	struct bio bio;
> +	int ret;
> +
> +	page = alloc_page(GFP_KERNEL);
> +	if (!page)
> +		return -ENOMEM;
> +
> +	bio_init(&bio, &bio_vec, 1);
> +	bio.bi_iter.bi_sector = 0;
> +	bio_set_dev(&bio, sb->s_bdev);
> +	bio_set_op_attrs(&bio, REQ_OP_READ, 0);
> +	bio_add_page(&bio, page, PAGE_SIZE, 0);
> +
> +	ret = submit_bio_wait(&bio);
> +	if (ret)
> +		goto out;
> +
> +	super = page_address(page);
> +
> +	stored_crc = le32_to_cpu(super->s_crc);
> +	super->s_crc = 0;
> +	crc = crc32(~0U, (unsigned char *)super, sizeof(struct zonefs_super));
> +	if (crc != stored_crc) {
> +		zonefs_err(sb, "Invalid checksum (Expected 0x%08x, got 0x%08x)",
> +			   crc, stored_crc);
> +		ret = -EIO;
> +		goto out;
> +	}

Does this mean if mount or the kernel tries to autoprobe the
filesystem type on a device it will get -EIO and an "Invalid
checksum" error message rather than just silently returning -EINVAL
because....

> +	ret = -EINVAL;
> +	if (le32_to_cpu(super->s_magic) != ZONEFS_MAGIC)
> +		goto out;

... it isn't actually a zonefs filesystem?

i.e. shouldn't these checks be the other way around?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
