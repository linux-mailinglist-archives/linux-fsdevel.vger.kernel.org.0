Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC0F668207
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2019 03:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbfGOBUy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 Jul 2019 21:20:54 -0400
Received: from mail106.syd.optusnet.com.au ([211.29.132.42]:45263 "EHLO
        mail106.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727006AbfGOBUy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 Jul 2019 21:20:54 -0400
Received: from dread.disaster.area (pa49-195-139-63.pa.nsw.optusnet.com.au [49.195.139.63])
        by mail106.syd.optusnet.com.au (Postfix) with ESMTPS id 0442C3DDC4E;
        Mon, 15 Jul 2019 11:20:42 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hmpeR-0006nl-LZ; Mon, 15 Jul 2019 11:19:35 +1000
Date:   Mon, 15 Jul 2019 11:19:35 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH RFC] fs: New zonefs file system
Message-ID: <20190715011935.GM7689@dread.disaster.area>
References: <20190712030017.14321-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712030017.14321-1-damien.lemoal@wdc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=FNpr/6gs c=1 sm=1 tr=0 cx=a_idp_d
        a=fNT+DnnR6FjB+3sUuX8HHA==:117 a=fNT+DnnR6FjB+3sUuX8HHA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=0o9FgrsRnhwA:10
        a=7-415B0cAAAA:8 a=j3wy73O8oSJ45MAQSE8A:9 a=2w8ThLbwMlW6iQc5:21
        a=Jo8aW4yMUH2SPfeF:21 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Just a few quick things as I read through this to see how it uses
iomap....

On Fri, Jul 12, 2019 at 12:00:17PM +0900, Damien Le Moal wrote:
> +static int zonefs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
> +			      unsigned int flags, struct iomap *iomap)
> +{
> +	struct zonefs_sb_info *sbi = ZONEFS_SB(inode->i_sb);
> +	loff_t max_isize = zonefs_file_max_size(inode);
> +	loff_t isize = i_size_read(inode);
> +
> +	/*
> +	 * For sequential zones, enforce direct IO writes. This is already
> +	 * checked when writes are issued, so warn about this here if we
> +	 * get buffered write to a sequential file inode.
> +	 */
> +	if (WARN_ON_ONCE(zonefs_file_is_seq(inode) && (flags & IOMAP_WRITE) &&
> +			 (!(flags & IOMAP_DIRECT))))
                         ^ Excess (..).

> +		return -EIO;

> +	/* An IO cannot exceed the zone size */
> +	if (offset >= max_isize)
> +		return -EFBIG;

So a write() call that is for a length longer than max_isize is
going to end up being a short write? i.e. iomap_apply() will loop
mapping the inode until either we reach the end of the user write
or we hit max_isize?

How is userspace supposed to tell the difference between a short
write and a write that overruns max_isize?

> +	/* All blocks are always mapped */
> +	if (offset >= i_size_read(inode)) {
> +		length = min(length, max_isize - offset);
> +		iomap->type = IOMAP_UNWRITTEN;
> +	} else {
> +		length = min(length, isize - offset);
> +		iomap->type = IOMAP_MAPPED;
> +	}
> +	iomap->offset = offset & (~sbi->s_blocksize_mask);
> +	iomap->length = (offset + length + sbi->s_blocksize_mask) &
> +			(~sbi->s_blocksize_mask);
> +	iomap->addr = zonefs_file_addr(inode) + iomap->offset;
> +	iomap->bdev = inode->i_sb->s_bdev;
> +
> +	return 0;
> +}
> +
> +static const struct iomap_ops zonefs_iomap_ops = {
> +	.iomap_begin	= zonefs_iomap_begin,
> +};
> +
> +static int zonefs_readpage(struct file *unused, struct page *page)
> +{
> +	return iomap_readpage(page, &zonefs_iomap_ops);
> +}
> +
> +static int zonefs_readpages(struct file *unused, struct address_space *mapping,
> +			    struct list_head *pages, unsigned int nr_pages)
> +{
> +	return iomap_readpages(mapping, pages, nr_pages, &zonefs_iomap_ops);
> +}
> +
> +static int zonefs_map_blocks(struct iomap_writepage_ctx *wpc,
> +			     struct inode *inode, loff_t offset)
> +{
> +	if (offset >= wpc->iomap.offset &&
> +	    offset < wpc->iomap.offset + wpc->iomap.length)
> +		return 0;
> +
> +	memset(&wpc->iomap, 0, sizeof(wpc->iomap));
> +	return zonefs_iomap_begin(inode, offset, INT_MAX, 0, &wpc->iomap);

Why is the write length set to INT_MAX here? What happens when we
get a zone that is larger than 2GB? i.e. the length parameter is a
loff_t, not an int....


> +static int zonefs_truncate_seqfile(struct inode *inode)
> +{
> +	struct zonefs_inode_info *zi = ZONEFS_I(inode);
> +	int ret;
> +
> +	/* Serialize against page faults */
> +	down_write(&zi->i_mmap_sem);
> +
> +	ret = blkdev_reset_zones(inode->i_sb->s_bdev,
> +				 zonefs_file_addr(inode) >> SECTOR_SHIFT,
> +				 zonefs_file_max_size(inode) >> SECTOR_SHIFT,
> +				 GFP_KERNEL);

Not sure GFP_KERNEL is safe here. This is called holding a
filesystem lock here, so it's not immediately clear to me if this
can deadlock through memory reclaim or not...

> +	if (ret) {
> +		zonefs_err(inode->i_sb,
> +			   "zonefs: Reset zone at %llu failed %d",
> +			   zonefs_file_addr(inode) >> SECTOR_SHIFT,
> +			   ret);

redundant "zonefs" in error message.

> +	} else {
> +		truncate_setsize(inode, 0);
> +		zi->i_wpoffset = 0;
> +	}
> +
> +	up_write(&zi->i_mmap_sem);
> +
> +	return ret;
> +}
> +
> +static int zonefs_inode_setattr(struct dentry *dentry, struct iattr *iattr)
> +{
> +	struct inode *inode = d_inode(dentry);
> +	int ret;
> +
> +	ret = setattr_prepare(dentry, iattr);
> +	if (ret)
> +		return ret;
> +
> +	if ((iattr->ia_valid & ATTR_UID &&
> +	     !uid_eq(iattr->ia_uid, inode->i_uid)) ||
> +	    (iattr->ia_valid & ATTR_GID &&
> +	     !gid_eq(iattr->ia_gid, inode->i_gid))) {
> +		ret = dquot_transfer(inode, iattr);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (iattr->ia_valid & ATTR_SIZE) {
> +		/* The size of conventional zone files cannot be changed */
> +		if (zonefs_file_is_conv(inode))
> +			return -EPERM;
> +
> +		/*
> +		 * For sequential zone files, we can only allow truncating to
> +		 * 0 size which is equivalent to a zone reset.
> +		 */
> +		if (iattr->ia_size != 0)
> +			return -EPERM;
> +
> +		ret = zonefs_truncate_seqfile(inode);
> +		if (ret)
> +			return ret;

Ok, so we are calling zonefs_truncate_seqfile() holding the i_rwsem
as well. That does tend to imply GFP_NOFS should probably be used
for the blkdev_reset_zones() call.

> +	}
> +
> +	setattr_copy(inode, iattr);
> +
> +	return 0;
> +}
> +
> +static const struct inode_operations zonefs_file_inode_operations = {
> +	.setattr	= zonefs_inode_setattr,
> +};
> +
> +/*
> + * Open a file.
> + */
> +static int zonefs_file_open(struct inode *inode, struct file *file)
> +{
> +	/*
> +	 * Note: here we can do an explicit open of the file zone,
> +	 * on the first open of the inode. The explicit close can be
> +	 * done on the last release (close) call for the inode.
> +	 */
> +
> +	return generic_file_open(inode, file);
> +}

Why is a wrapper needed for this?

> +static int zonefs_file_fsync(struct file *file, loff_t start, loff_t end,
> +			     int datasync)
> +{
> +	struct inode *inode = file_inode(file);
> +	int ret;
> +
> +	/*
> +	 * Since only direct writes are allowed in sequential files, we only
> +	 * need a device flush for these files.
> +	 */
> +	if (zonefs_file_is_seq(inode))
> +		goto flush;
> +
> +	ret = file_write_and_wait_range(file, start, end);
> +	if (ret == 0)
> +		ret = file_check_and_advance_wb_err(file);
> +	if (ret)
> +		return ret;

> +
> +flush:
> +	return blkdev_issue_flush(inode->i_sb->s_bdev, GFP_KERNEL, NULL);

The goto can be avoided in this case simply:

	if (zonefs_file_is_conv(inode)) {
		/* do flush */
	}
	return blkdev_issue_flush(inode->i_sb->s_bdev, GFP_KERNEL, NULL);

> +}
> +
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
> +
> +static const struct vm_operations_struct zonefs_file_vm_ops = {
> +	.fault		= zonefs_filemap_fault,
> +	.map_pages	= filemap_map_pages,
> +	.page_mkwrite	= zonefs_filemap_page_mkwrite,
> +};
> +
> +static int zonefs_file_mmap(struct file *file, struct vm_area_struct *vma)
> +{
> +	/*
> +	 * Conventional zone files can be mmap-ed READ/WRITE.
> +	 * For sequential zone files, only readonly mappings are possible.
> +	 */
> +	if (zonefs_file_is_seq(file_inode(file)) &&
> +	    (vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_MAYWRITE))
> +		return -EINVAL;
> +
> +	file_accessed(file);
> +	vma->vm_ops = &zonefs_file_vm_ops;
> +
> +	return 0;
> +}
> +
> +static loff_t zonefs_file_llseek(struct file *file, loff_t offset, int whence)
> +{
> +	loff_t isize = i_size_read(file_inode(file));
> +
> +	/*
> +	 * Seeks are limited to below the zone size for conventional zones
> +	 * and below the zone write pointer for sequential zones. In both
> +	 * cases, this limit is the inode size.
> +	 */
> +	return generic_file_llseek_size(file, offset, whence, isize, isize);
> +}
> +
> +static ssize_t zonefs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
> +{
> +	struct inode *inode = file_inode(iocb->ki_filp);
> +	struct zonefs_sb_info *sbi = ZONEFS_SB(inode->i_sb);
> +	loff_t max_pos = zonefs_file_max_size(inode);
> +	size_t count;
> +	ssize_t ret = 0;
> +
> +	/*
> +	 * Check that the read operation does not go beyond the maximum
> +	 * file size.
> +	 */
> +	if (iocb->ki_pos >= zonefs_file_max_size(inode))
> +		return -EFBIG;
> +
> +	/*
> +	 * For sequential zones, limit reads to written data.
> +	 */
> +	if (zonefs_file_is_seq(inode))
> +		max_pos = i_size_read(inode);
> +	if (iocb->ki_pos >= max_pos)
> +		return 0;

Isn't this true for both types of zone at this point? i.e. at this
point:

	max_pos = i_size_read(inode);
	if (iocb->ki_pos >= max_pos)
		return 0;

because i_size is either the zonefs_file_max_size() for conventional
zones (which we've already checked) or it's the write pointer for
a sequential zone. i.e. it's the max position for either case.

> +	iov_iter_truncate(to, max_pos - iocb->ki_pos);
> +	count = iov_iter_count(to);
> +	if (!count)
> +		return 0;

The iov_iter should never be zero length here, because that implies
the position was >= max_pos and that will be caught by the above
checks...

> +	/* Direct IO reads must be aligned to device physical sector size */
> +	if ((iocb->ki_flags & IOCB_DIRECT) &&
> +	    ((iocb->ki_pos | count) & sbi->s_blocksize_mask))
> +		return -EINVAL;
> +
> +	if (iocb->ki_flags & IOCB_NOWAIT) {
> +		if (!inode_trylock_shared(inode))
> +			return -EAGAIN;
> +	} else {
> +		inode_lock_shared(inode);
> +	}

IIUC, write IO completion takes the inode lock to serialise file
size updates for sequential zones. In that case, shouldn't this lock
be taken before we do the EOF checks above?

> +	if (iocb->ki_flags & IOCB_DIRECT) {
> +		file_accessed(iocb->ki_filp);
> +		ret = iomap_dio_rw(iocb, to, &zonefs_iomap_ops, NULL);
> +	} else {
> +		ret = generic_file_read_iter(iocb, to);
> +	}
> +
> +	inode_unlock_shared(inode);
> +
> +	return ret;
> +}
> +
> +/*
> + * We got a write error: get the sequenial zone information from the device to
> + * figure out where the zone write pointer is and verify the inode size against
> + * it.
> + */
> +static int zonefs_write_failed(struct inode *inode, int error)
> +{
> +	struct super_block *sb = inode->i_sb;
> +	struct zonefs_inode_info *zi = ZONEFS_I(inode);
> +	sector_t sector = zi->i_addr >> SECTOR_SHIFT;
> +	unsigned int noio_flag;
> +	struct blk_zone zone;
> +	int n = 1, ret;
> +
> +	zonefs_warn(sb, "Updating inode zone %llu info\n", sector);
> +
> +	noio_flag = memalloc_noio_save();
> +	ret = blkdev_report_zones(sb->s_bdev, sector, &zone, &n);
> +	memalloc_noio_restore(noio_flag);

What deadlock does the memalloc_noio_save() avoid? There should be a
comment explaining what problem memalloc_noio_save() avoids
everywhere it is used like this. If it isn't safe to do GFP_KERNEL
allocations here under the i_rwsem, then why would it be safe to
do GFP_KERNEL allocations in the truncate code under the i_rwsem?

> +
> +	if (!n)
> +		ret = -EIO;
> +	if (ret) {
> +		zonefs_err(sb, "Get zone %llu report failed %d\n",
> +			   sector, ret);
> +		return ret;
> +	}
> +
> +	zi->i_wpoffset = (zone.wp - zone.start) << SECTOR_SHIFT;
> +	if (i_size_read(inode) != zi->i_wpoffset) {
> +		i_size_write(inode, zi->i_wpoffset);
> +		truncate_pagecache(inode, zi->i_wpoffset);
> +	}

This looks .... dangerous. If the write pointer was advanced, but
the data wasn't written properly, this causes stale data exposure on
write failure. i.e. it's not failsafe.

I suspect that on a sequential zone write failure and the write
pointer does not equal the offset of the write, we should consider
the zone corrupt. Also, this is for direct IO completion for
sequential writes, yes? So what does the page cache truncation
acheive given that only direct IO writes are allowed to these files?

> +
> +	return error;
> +}
> +
> +static int zonefs_update_size(struct inode *inode, loff_t new_pos)
> +{
> +	struct zonefs_inode_info *zi = ZONEFS_I(inode);
> +
> +	zi->i_wpoffset = new_pos;
> +	if (new_pos > i_size_read(inode))
> +		i_size_write(inode, new_pos);
> +	return 0;
> +}
> +
> +static int zonefs_dio_seqwrite_end_io(struct kiocb *iocb, ssize_t size,
> +				      unsigned int flags)
> +{
> +	struct inode *inode = file_inode(iocb->ki_filp);
> +	int ret;
> +
> +	inode_lock(inode);
> +	if (size < 0)
> +		ret = zonefs_write_failed(inode, size);
> +	else
> +		ret = zonefs_update_size(inode, iocb->ki_pos + size);
> +	inode_unlock(inode);
> +	return ret;

Shouldn't this have a check that it's being called on a sequential
zone inode?

> +}
> +
> +static ssize_t zonefs_file_dio_aio_write(struct kiocb *iocb,
> +					 struct iov_iter *from)
> +{
> +	struct inode *inode = file_inode(iocb->ki_filp);
> +	struct zonefs_inode_info *zi = ZONEFS_I(inode);
> +	size_t count;
> +
> +	/*
> +	 * The size of conventional zone files is fixed to the zone size.
> +	 * So only direct writes to sequential zones need adjusting the
> +	 * inode size on IO completion.
> +	 */
> +	if (zonefs_file_is_conv(inode))
> +		return iomap_dio_rw(iocb, from, &zonefs_iomap_ops, NULL);
> +
> +	/* Enforce append only sequential writes */
> +	count = iov_iter_count(from);
> +	if (iocb->ki_pos != zi->i_wpoffset) {
> +		zonefs_err(inode->i_sb,
> +			   "Unaligned write at %llu + %zu (wp %llu)\n",
> +			   iocb->ki_pos, count, zi->i_wpoffset);
> +		return -EINVAL;
> +	}
> +
> +	if (is_sync_kiocb(iocb)) {
> +		/*
> +		 * Don't use the end_io callback for synchronous iocbs,
> +		 * as we'd deadlock on i_rwsem.  Instead perform the same
> +		 * actions manually here.
> +		 */
> +		count = iomap_dio_rw(iocb, from, &zonefs_iomap_ops, NULL);
> +		if (count < 0)
> +			return zonefs_write_failed(inode, count);
> +		zonefs_update_size(inode, iocb->ki_pos);
> +		return count;

Urk. This locking is nasty, and doesn't avoid the problem.....

> +	}
> +
> +	return iomap_dio_rw(iocb, from, &zonefs_iomap_ops,
> +			    zonefs_dio_seqwrite_end_io);

... because I think this can deadlock.

AFAIA, the rule is that IO completion callbacks cannot take
a lock that is held across IO submission. The reason is that
IO can complete so fast that the submission code runs the
completion. i.e. iomap_dio_rw() can be the function that calls
iomap_dio_complete() and runs the IO completion.

In which case, this will deadlock because we are already holding the
i_rwsem and the end_io completion will try to take it again.



> +}
> +
> +static ssize_t zonefs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
> +{
> +	struct inode *inode = file_inode(iocb->ki_filp);
> +	struct zonefs_sb_info *sbi = ZONEFS_SB(inode->i_sb);
> +	size_t count;
> +	ssize_t ret;
> +
> +	/*
> +	 * Check that the read operation does not go beyond the file
> +	 * zone boundary.
> +	 */
> +	if (iocb->ki_pos >= zonefs_file_max_size(inode))
> +		return -EFBIG;
> +	iov_iter_truncate(from, zonefs_file_max_size(inode) - iocb->ki_pos);
> +	count = iov_iter_count(from);
> +
> +	if (!count)
> +		return 0;
> +
> +	/*
> +	 * Direct IO writes are mandatory for sequential zones so that write IO
> +	 * order is preserved. The direct writes also must be aligned to
> +	 * device physical sector size.
> +	 */
> +	if (iocb->ki_flags & IOCB_DIRECT) {
> +		if ((iocb->ki_pos | count) & sbi->s_blocksize_mask)
> +			return -EINVAL;
> +	} else {
> +		if (zonefs_file_is_seq(inode))
> +			return -EOPNOTSUPP;

zonefs_iomap_begin() returns -EIO in this case and issues a warning.
This seems somewhat inconsistent....

> +	}
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

Shouldn't this be done before the iov_iter is truncated?

> +
> +	if (iocb->ki_flags & IOCB_DIRECT)
> +		ret = zonefs_file_dio_aio_write(iocb, from);
> +	else
> +		ret = iomap_file_buffered_write(iocb, from, &zonefs_iomap_ops);
> +
> +out:
> +	inode_unlock(inode);
> +
> +	if (ret > 0 && (!(iocb->ki_flags & IOCB_DIRECT))) {
> +		iocb->ki_pos += ret;
> +		ret = generic_write_sync(iocb, ret);
> +	}

Hmmm. The split of checks and doing stuff between direct IO and
buffered IO seems a bit arbitrary. e.g. the "sequential zones can
only do append writes" is in zonefs_file_dio_aio_write(), but we
do a check that "sequential zones can only do direct IO" here.

And then we have the sync code that can only occur on buffered IO,
which we don't have a wrapper function for but really should.  And I
suspect that the locking is going to have to change here because of
the direct IO issues, so maybe it would be best to split this up
similar to the way XFS has two completely separate functions for the
two paths....


> +static struct kmem_cache *zonefs_inode_cachep;
> +
> +static struct inode *zonefs_alloc_inode(struct super_block *sb)
> +{
> +	struct zonefs_inode_info *zi;
> +
> +	zi = kmem_cache_alloc(zonefs_inode_cachep, GFP_KERNEL);
> +	if (!zi)
> +		return NULL;
> +
> +	init_rwsem(&zi->i_mmap_sem);
> +	inode_init_once(&zi->i_vnode);
> +
> +	return &zi->i_vnode;
> +}
> +
> +static void zonefs_destroy_cb(struct rcu_head *head)
> +{
> +	struct inode *inode = container_of(head, struct inode, i_rcu);
> +
> +	kmem_cache_free(zonefs_inode_cachep, ZONEFS_I(inode));
> +}
> +
> +static void zonefs_destroy_inode(struct inode *inode)
> +{
> +	call_rcu(&inode->i_rcu, zonefs_destroy_cb);
> +}

If this is all the inode destructor is, then implement ->free_inode
instead. i.e.

zonefs_free_inode(inode)
{
	kmem_cache_free(zonefs_inode_cachep, ZONEFS_I(inode));
}

and the VFS takes care of the RCU freeing of the inode.

> +/*
> + * File system stat.
> + */
> +static int zonefs_statfs(struct dentry *dentry, struct kstatfs *buf)
> +{
> +	struct super_block *sb = dentry->d_sb;
> +	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
> +	sector_t nr_sectors = sb->s_bdev->bd_part->nr_sects;
> +	enum zonefs_ztype t;
> +
> +	buf->f_type = ZONEFS_MAGIC;
> +	buf->f_bsize = dentry->d_sb->s_blocksize;
> +	buf->f_namelen = ZONEFS_NAME_MAX;
> +
> +	buf->f_blocks = nr_sectors >> (sb->s_blocksize_bits - SECTOR_SHIFT);
> +	buf->f_bfree = 0;
> +	buf->f_bavail = 0;
> +
> +	buf->f_files = sbi->s_nr_zones[ZONEFS_ZTYPE_ALL] - 1;
> +	for (t = ZONEFS_ZTYPE_ALL; t < ZONEFS_ZTYPE_MAX; t++) {
> +		if (sbi->s_nr_zones[t])
> +			buf->f_files++;
> +	}
> +	buf->f_ffree = 0;
> +
> +	/* buf->f_fsid = 0; uuid, see ext2 */

This doesn't tell me anything useful. Does it mean "we should use
the uuid like ext2" or something else? is it a "TODO:" item?

> +	buf->f_namelen = ZONEFS_NAME_MAX;

You've done this twice. :)

> +static char *zgroups_name[ZONEFS_ZTYPE_MAX] = {
> +	NULL,
> +	"cnv",
> +	"seq"
> +};

What's the reason for a NULL in the first entry?

> +
> +/*
> + * Create a zone group and populate it with zone files.
> + */
> +static int zonefs_create_zgroup(struct super_block *sb, struct blk_zone *zones,
> +				enum zonefs_ztype type)
> +{
> +	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
> +	struct blk_zone *zone, *next, *end;
> +	char name[ZONEFS_NAME_MAX];
> +	unsigned int nr_files = 0;
> +	struct dentry *dir;
> +
> +	/* If the group is empty, nothing to do */
> +	if (!sbi->s_nr_zones[type])
> +		return 0;
> +
> +	dir = zonefs_create_inode(sb->s_root, zgroups_name[type], NULL);
> +	if (!dir)
> +		return -ENOMEM;
> +
> +	/*
> +	 * Note: The first zone contains the super block: skip it.
> +	 */
> +	end = zones + sbi->s_nr_zones[ZONEFS_ZTYPE_ALL];
> +	for (zone = &zones[1]; zone < end; zone = next) {
> +
> +		next = zone + 1;
> +		if (zonefs_zone_type(zone) != type)
> +			continue;
> +
> +		/* Ignore offline zones */
> +		if (zonefs_zone_offline(zone))
> +			continue;
> +
> +		/*
> +		 * For conventional zones, contiguous zones can be aggregated
> +		 * together to form larger files.
> +		 * Note that this overwrites the length of the first zone of
> +		 * the set of contiguous zones aggregated together.
> +		 * Only zones with the same condition can be agreggated so that
> +		 * offline zones are excluded and readonly zones are aggregated
> +		 * together into a read only file.
> +		 */
> +		if (type == ZONEFS_ZTYPE_CNV &&
> +		    zonefs_has_feature(sbi, ZONEFS_F_AGRCNV)) {
> +			for (; next < end; next++) {
> +				if (zonefs_zone_type(next) != type ||
> +				    next->cond != zone->cond)
> +					break;
> +				zone->len += next->len;
> +			}
> +		}
> +
> +		if (zonefs_has_feature(sbi, ZONEFS_F_STARTSECT_NAME))
> +			/* Use zone start sector as file names */
> +			snprintf(name, ZONEFS_NAME_MAX - 1, "%llu",
> +				 zone->start);
> +		else
> +			/* Use file number as file names */
> +			snprintf(name, ZONEFS_NAME_MAX - 1, "%u", nr_files);
> +		nr_files++;
> +
> +		if (!zonefs_create_inode(dir, name, zone))
> +			return -ENOMEM;

I guess this means partial setup due to failure needs to be torn
down by the kill_super() code?

> +	}
> +
> +	zonefs_info(sb, "Zone group %d (%s), %u zones -> %u file%s\n",
> +		    type, zgroups_name[type], sbi->s_nr_zones[type],
> +		    nr_files, nr_files > 1 ? "s" : "");
> +
> +	return 0;
> +}
> +
> +static struct blk_zone *zonefs_get_zone_info(struct super_block *sb)
> +{
> +	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
> +	struct block_device *bdev = sb->s_bdev;
> +	sector_t nr_sectors = bdev->bd_part->nr_sects;
> +	unsigned int i, n, nr_zones = 0;
> +	struct blk_zone *zones, *zone;
> +	sector_t sector = 0;
> +	int ret;
> +
> +	sbi->s_blocksize_mask = sb->s_blocksize - 1;
> +	sbi->s_nr_zones[ZONEFS_ZTYPE_ALL] = blkdev_nr_zones(bdev);
> +	zones = kvcalloc(sbi->s_nr_zones[ZONEFS_ZTYPE_ALL],
> +			 sizeof(struct blk_zone), GFP_KERNEL);
> +	if (!zones)
> +		return ERR_PTR(-ENOMEM);

Hmmm. That's a big allocation. That might be several megabytes for a
typical 16TB SMR drive, right? It might be worth adding a comment
indicating just how large this is, because it's somewhat unusual in
kernel space, even for temporary storage.

> --- /dev/null
> +++ b/fs/zonefs/zonefs.h
> @@ -0,0 +1,190 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Simple zone file system for zoned block devices.
> + *
> + * Copyright (C) 2019 Western Digital Corporation or its affiliates.
> + */
> +#ifndef __ZONEFS_H__
> +#define __ZONEFS_H__
> +
> +#include <linux/fs.h>
> +#include <linux/magic.h>
> +
> +/*
> + * Maximum length of file names: this only needs to be large enough to fit
> + * the zone group directory names and a decimal value of the start sector of
> + * the zones for file names. 16 characterse is plenty.
> + */
> +#define ZONEFS_NAME_MAX		16
> +
> +/*
> + * Zone types: ZONEFS_ZTYPE_SEQWRITE is used for all sequential zone types

ZONEFS_ZTYPE_SEQ?

> + * defined in linux/blkzoned.h, that is, BLK_ZONE_TYPE_SEQWRITE_REQ and
> + * BLK_ZONE_TYPE_SEQWRITE_PREF.
> + */
> +enum zonefs_ztype {
> +	ZONEFS_ZTYPE_ALL = 0,
> +	ZONEFS_ZTYPE_CNV,
> +	ZONEFS_ZTYPE_SEQ,
> +	ZONEFS_ZTYPE_MAX,
> +};

What is ZONEFS_ZTYPE_ALL supposed to be used for?

> +static inline bool zonefs_zone_offline(struct blk_zone *zone)
> +{
> +	return zone->cond == BLK_ZONE_COND_OFFLINE;
> +}
> +
> +static inline bool zonefs_zone_readonly(struct blk_zone *zone)
> +{
> +	return zone->cond == BLK_ZONE_COND_READONLY;
> +}

These should be block layer helpers as the operate on blk_zone,
not zonefs structures.

> +
> +/*
> + * Inode private data.
> + */
> +struct zonefs_inode_info {
> +	struct inode		i_vnode;
> +	enum zonefs_ztype	i_ztype;
> +	loff_t			i_addr;
> +	loff_t			i_wpoffset;
> +	loff_t			i_max_size;
> +	struct rw_semaphore	i_mmap_sem;
> +};
> +
> +static inline struct zonefs_inode_info *ZONEFS_I(struct inode *inode)
> +{
> +	return container_of(inode, struct zonefs_inode_info, i_vnode);
> +}
> +
> +static inline bool zonefs_file_is_conv(struct inode *inode)
> +{
> +	return ZONEFS_I(inode)->i_ztype == ZONEFS_ZTYPE_CNV;
> +}
> +
> +static inline bool zonefs_file_is_seq(struct inode *inode)
> +{
> +	return ZONEFS_I(inode)->i_ztype == ZONEFS_ZTYPE_SEQ;
> +}
> +
> +/*
> + * Address (byte offset) on disk of a file zone.
> + */
> +static inline loff_t zonefs_file_addr(struct inode *inode)
> +{
> +	return ZONEFS_I(inode)->i_addr;
> +}

so it's a disk address, but it's encoded in bytes rather than sectors
so that makes it an offset. That's kinda confusing coming from a
filesystem that makes a clear distinction between these two things.

> +
> +/*
> + * Maximum possible size of a file (i.e. the zone size).
> + */
> +static inline loff_t zonefs_file_max_size(struct inode *inode)
> +{
> +	return ZONEFS_I(inode)->i_max_size;
> +}
> +
> +/*
> + * On-disk super block (block 0).
> + */
> +struct zonefs_super {
> +
> +	/* Magic number */
> +	__le32		s_magic;		/*    4 */
> +
> +	/* Metadata version number */
> +	__le32		s_version;		/*    8 */
> +
> +	/* Features */
> +	__le64		s_features;		/*   16 */

On-disk version numbers are kinda redundant when you have
fine grained feature fields to indicate the on-disk layout...

> +/*
> + * Feature flags.
> + */
> +enum zonefs_features {
> +	/*
> +	 * Use a zone start sector value as file name.
> +	 */
> +	ZONEFS_F_STARTSECT_NAME,
> +	/*
> +	 * Aggregate contiguous conventional zones into a single file.
> +	 */
> +	ZONEFS_F_AGRCNV,
> +	/*
> +	 * Use super block specified UID for files instead of default.
> +	 */
> +	ZONEFS_F_UID,
> +	/*
> +	 * Use super block specified GID for files instead of default.
> +	 */
> +	ZONEFS_F_GID,
> +	/*
> +	 * Use super block specified file permissions instead of default 640.
> +	 */
> +	ZONEFS_F_PERM,
> +};

Are these the on-disk feature bit definitions, or just used in
memory? Or both?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
