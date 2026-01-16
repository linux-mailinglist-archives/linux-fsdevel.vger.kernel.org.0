Return-Path: <linux-fsdevel+bounces-74069-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4802FD2E4F6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 09:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BD6E303BE21
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 08:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797D030F552;
	Fri, 16 Jan 2026 08:54:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE943090C1;
	Fri, 16 Jan 2026 08:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768553647; cv=none; b=n5h1GjPrBygD3b+v3tzKQQK/3yi7r3bJwjaOPevFM2ZDCDil0dYbHMdgQzufQa7GDJ3aHPlL0d5qEmCwNQLglyW9/O1bAPr+0w+eqy0WQAGzKhUQR1wsHFjIv/jAv6pGZ/FX+CdlrejA9wQqsdnAvdVQtG3OcgZ+5TptRFdvdA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768553647; c=relaxed/simple;
	bh=p/xX5cmT21gqUCpIsuFg1gcOvCjwir7AiuUywjbVk58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pxyOp3/gSb6AteIZuoRlS/ujEWApdLw63yIGiYkkl9r70x1YzyNyfrI8GFXCStvmBg6/GVI9TMQVNtNthDn4SJkFVaZnOd7Hb2+1x/m9SDAzZXwEsJwYV8/T36rZ26cx/oXieSPg7llywU0Jlpdul8Pw6c77DClsTK5GZ5wPMpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3AF04227A8E; Fri, 16 Jan 2026 09:53:59 +0100 (CET)
Date: Fri, 16 Jan 2026 09:53:59 +0100
From: Christoph Hellwig <hch@lst.de>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hch@lst.de, tytso@mit.edu,
	willy@infradead.org, jack@suse.cz, djwong@kernel.org,
	josef@toxicpanda.com, sandeen@sandeen.net, rgoldwyn@suse.com,
	xiang@kernel.org, dsterba@suse.com, pali@kernel.org,
	ebiggers@kernel.org, neil@brown.name, amir73il@gmail.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com,
	gunho.lee@lge.com, Hyunchul Lee <hyc.lee@gmail.com>
Subject: Re: [PATCH v5 06/14] ntfs: update file operations
Message-ID: <20260116085359.GD15119@lst.de>
References: <20260111140345.3866-1-linkinjeon@kernel.org> <20260111140345.3866-7-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260111140345.3866-7-linkinjeon@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sun, Jan 11, 2026 at 11:03:36PM +0900, Namjae Jeon wrote:
>  /**
> + * ntfs_setattr - called from notify_change() when an attribute is being changed
> + * @idmap:	idmap of the mount the inode was found from
> + * @dentry:	dentry whose attributes to change
> + * @attr:	structure describing the attributes and the changes
>   *
> + * We have to trap VFS attempts to truncate the file described by @dentry as
> + * soon as possible, because we do not implement changes in i_size yet.  So we
> + * abort all i_size changes here.
>   *
> + * We also abort all changes of user, group, and mode as we do not implement
> + * the NTFS ACLs yet.

This comment isn't actually true, is it?  Also having kerneldoc comments
for something that implements VFS methods isn't generally very useful,
they should have their API documentation in the VFS documentation.  You
can comment anything special in a normal code comment if it applies.

> +	if (ia_valid & ATTR_SIZE) {
> +		if (NInoCompressed(ni) || NInoEncrypted(ni)) {
> +			ntfs_warning(vi->i_sb,
> +				     "Changes in inode size are not supported yet for %s files, ignoring.",
> +				     NInoCompressed(ni) ? "compressed" : "encrypted");
> +			err = -EOPNOTSUPP;

This is still quite a limitation.  But I also think you need a goto
to exit early here instead allowing the other attribute changes to
be applied?

Also experience from other file systems suggests splitting the ATTR_SIZE
handling into a separate helper tends to really help structuring the
code in general.

> +int ntfs_getattr(struct mnt_idmap *idmap, const struct path *path,
> +		struct kstat *stat, unsigned int request_mask,
> +		unsigned int query_flags)
>  {

Can you add support DIO alignment reporting here?  Especially with
things like compressed files this would be very useful.

> +static loff_t ntfs_file_llseek(struct file *file, loff_t offset, int whence)
>  {
> +	struct inode *vi = file->f_mapping->host;
> +
> +	if (whence == SEEK_DATA || whence == SEEK_HOLE) {

I'd stick to the structure of the XFS and ext4 llseek implementation
here and switch on whence and call the fitting helpers as needed.

Talking about helpers, why does iomap_seek_hole/iomap_seek_data
not work for ntfs?

> +		file_accessed(iocb->ki_filp);
> +		ret = iomap_dio_rw(iocb, to, &ntfs_read_iomap_ops, NULL, IOMAP_DIO_PARTIAL,

Why do you need IOMAP_DIO_PARTIAL?  That's mostly a workaround
for "interesting" locking in btrfs and gfs2.  If ntfs has similar
issues, it would be helpful to add a comment here.  Also maybe fix
the overly long line.

> +	if (NInoNonResident(ni) && (iocb->ki_flags & IOCB_DIRECT) &&
> +	    ((iocb->ki_pos | ret) & (vi->i_sb->s_blocksize - 1))) {
> +		ret = -EINVAL;
> +		goto out_lock;
> +	}

iomap_dio_rw now has a IOMAP_DIO_FSBLOCK_ALIGNED to do these
checks.  Also please throw in a comment why ntrfs needs fsblock
alignment.

> +	if (iocb->ki_pos + ret > old_data_size) {
> +		mutex_lock(&ni->mrec_lock);
> +		if (!NInoCompressed(ni) && iocb->ki_pos + ret > ni->allocated_size &&
> +		    iocb->ki_pos + ret < ni->allocated_size + vol->preallocated_size)
> +			ret = ntfs_attr_expand(ni, iocb->ki_pos + ret,
> +					ni->allocated_size + vol->preallocated_size);
> +		else if (NInoCompressed(ni) && iocb->ki_pos + ret > ni->allocated_size)
> +			ret = ntfs_attr_expand(ni, iocb->ki_pos + ret,
> +				round_up(iocb->ki_pos + ret, ni->itype.compressed.block_size));
> +		else
> +			ret = ntfs_attr_expand(ni, iocb->ki_pos + ret, 0);
> +		mutex_unlock(&ni->mrec_lock);
> +		if (ret < 0)
> +			goto out;
> +	}

What is the reason to do the expansion here instead of in the iomap_begin
handler when we know we are committed to write to range?

> +	if (NInoNonResident(ni) && iocb->ki_flags & IOCB_DIRECT) {

Mayube split this direct I/O branch which is quite huge into a separate
helper, similar to what a lof of other file systems are doing?

>  	}
> +out:
> +	if (ret < 0 && ret != -EIOCBQUEUED) {
> +out_err:
> +		if (ni->initialized_size != old_init_size) {
> +			mutex_lock(&ni->mrec_lock);
> +			ntfs_attr_set_initialized_size(ni, old_init_size);
> +			mutex_unlock(&ni->mrec_lock);
> +		}
> +		if (ni->data_size != old_data_size) {
> +			truncate_setsize(vi, old_data_size);
> +			ntfs_attr_truncate(ni, old_data_size);
> +		}

Don't you also need to this in dio I/O completion handler for async
writes?  (actually I guess they aren't supported, I'll try to find the
code for that).

> +static vm_fault_t ntfs_filemap_page_mkwrite(struct vm_fault *vmf)
>  {
> +	vm_fault_t ret;
> +
> +	if (unlikely(IS_IMMUTABLE(inode)))
> +		return VM_FAULT_SIGBUS;

I don't think the VM ever allows write faults on files not opened for
writing, which can't be done for IS_IMMUTABLE files.  If you could ever
hit this we have a huge problem in the upper layers that needs fixing.

> +static int ntfs_ioctl_fitrim(struct ntfs_volume *vol, unsigned long arg)
> +{
> +	struct fstrim_range __user *user_range;
> +	struct fstrim_range range;
> +	struct block_device *dev;
>  	int err;
>  
> +static long ntfs_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
>  {
> +	struct inode *vi = file_inode(file);
> +	struct ntfs_inode *ni = NTFS_I(vi);
> +	struct ntfs_volume *vol = ni->vol;
> +	int err = 0;
> +	loff_t end_offset = offset + len;
> +	loff_t old_size, new_size;
> +	s64 start_vcn, end_vcn;
> +	bool map_locked = false;
> +
> +	if (!S_ISREG(vi->i_mode))
> +		return -EOPNOTSUPP;

ntfs_fallocate is only wired up in ntfs_file_ops, so this can't
happen.

> +	inode_dio_wait(vi);
> +	if (mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_COLLAPSE_RANGE |
> +		    FALLOC_FL_INSERT_RANGE)) {
> +		filemap_invalidate_lock(vi->i_mapping);
> +		map_locked = true;
> +	}
> +
> +	if (mode & FALLOC_FL_INSERT_RANGE) {

This would benefit a lot from being structured like __xfs_file_fallocate,
that is switch on mode & FALLOC_FL_MODE_MASK for the operation, and
then have a helper for each separate operation type.  The current
huge function is pretty unreadable.


