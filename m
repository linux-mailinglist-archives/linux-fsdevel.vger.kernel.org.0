Return-Path: <linux-fsdevel+bounces-72866-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8E3D04096
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 16:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1BB97318FD0B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 15:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81400242D83;
	Thu,  8 Jan 2026 15:13:45 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D3319D074;
	Thu,  8 Jan 2026 15:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767885225; cv=none; b=lIC8woLNnBCsN77gHMY5QKWlDY3JmbcIPkj4Dcxn05qzBglqMC0uzjGNfEsxK7oIYSmcrjK715h4THaWmEWOrDxrs7bXWc+UZ4v4u4wLo8XaX6ESVZhrDOGDmSDl42rIKosvQ33CNjWtoBzvrSEiMPyORXEQZRl8SI+Lxz0x7VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767885225; c=relaxed/simple;
	bh=+teN4yANOmvIPOvVUosclkc9Zr6evXe19p5C2sakcV4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T8giPmD2Ld5GmlA3FPcYtGTg8kIOFkHbj7A1jn/GWhk3z0q5JVEqrxKi9V7neGtg7iy9AzMTYZ8hCIgQa5xd171ziQft3AwA+qXOpTT4e3QY65O/uT2Ltm+9xKOWYDaCThFH3AinQmCFvdsxLk9XnL/0qkH3Jjf4aVERZ8dSPGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dn7hY4wsJzJ46C2;
	Thu,  8 Jan 2026 23:13:33 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id AB24240570;
	Thu,  8 Jan 2026 23:13:38 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 8 Jan
 2026 15:13:37 +0000
Date: Thu, 8 Jan 2026 15:13:35 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: John Groves <John@Groves.net>
CC: Miklos Szeredi <miklos@szeredi.hu>, Dan Williams
	<dan.j.williams@intel.com>, Bernd Schubert <bschubert@ddn.com>, "Alison
 Schofield" <alison.schofield@intel.com>, John Groves <jgroves@micron.com>,
	Jonathan Corbet <corbet@lwn.net>, Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan
 Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, "David
 Hildenbrand" <david@kernel.org>, Christian Brauner <brauner@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, Stefan
 Hajnoczi <shajnocz@redhat.com>, Joanne Koong <joannelkoong@gmail.com>, Josef
 Bacik <josef@toxicpanda.com>, Bagas Sanjaya <bagasdotme@gmail.com>, Chen
 Linxuan <chenlinxuan@uniontech.com>, "James Morse" <james.morse@arm.com>,
	Fuad Tabba <tabba@google.com>, "Sean Christopherson" <seanjc@google.com>,
	Shivank Garg <shivankg@amd.com>, Ackerley Tng <ackerleytng@google.com>,
	Gregory Price <gourry@gourry.net>, Aravind Ramesh <arramesh@micron.com>, Ajay
 Joshi <ajayjoshi@micron.com>, <venkataravis@micron.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-cxl@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH V3 17/21] famfs_fuse: Plumb dax iomap and fuse
 read/write/mmap
Message-ID: <20260108151335.000079d7@huawei.com>
In-Reply-To: <20260107153332.64727-18-john@groves.net>
References: <20260107153244.64703-1-john@groves.net>
	<20260107153332.64727-1-john@groves.net>
	<20260107153332.64727-18-john@groves.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Wed,  7 Jan 2026 09:33:26 -0600
John Groves <John@Groves.net> wrote:

> This commit fills in read/write/mmap handling for famfs files. The
> dev_dax_iomap interface is used - just like xfs in fs-dax mode.
> 
> * Read/write are handled by famfs_fuse_[read|write]_iter() via
>   dax_iomap_rw() to fsdev_dax.
> * Mmap is handled by famfs_fuse_mmap()
> * Faults are handled by famfs_filemap*fault(), using dax_iomap_fault()
>   to fsdev_dax.
> * File offset to dax offset resolution is handled via
>   famfs_fuse_iomap_begin(), which uses famfs "fmaps" to resolve the
>   the requested (file, offset) to an offset on a dax device (by way of
>   famfs_fileofs_to_daxofs() and famfs_interleave_fileofs_to_daxofs())
> 
> Signed-off-by: John Groves <john@groves.net>
A few minor comments and suggestions inline.

Thanks,

Jonathan

> ---
>  fs/fuse/famfs.c  | 458 +++++++++++++++++++++++++++++++++++++++++++++++
>  fs/fuse/file.c   |  18 +-
>  fs/fuse/fuse_i.h |  18 ++
>  3 files changed, 492 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/fuse/famfs.c b/fs/fuse/famfs.c
> index b5cd1b5c1d6c..c02b14789c6e 100644
> --- a/fs/fuse/famfs.c
> +++ b/fs/fuse/famfs.c
> @@ -602,6 +602,464 @@ famfs_file_init_dax(
>  	return rc;
>  }
>  
> +/*********************************************************************
> + * iomap_operations
> + *
> + * This stuff uses the iomap (dax-related) helpers to resolve file offsets to
> + * offsets within a dax device.
> + */
> +
> +static ssize_t famfs_file_bad(struct inode *inode);
> +
> +static int
> +famfs_interleave_fileofs_to_daxofs(struct inode *inode, struct iomap *iomap,
> +			 loff_t file_offset, off_t len, unsigned int flags)
> +{
> +	struct fuse_inode *fi = get_fuse_inode(inode);
> +	struct famfs_file_meta *meta = fi->famfs_meta;
> +	struct fuse_conn *fc = get_fuse_conn(inode);
> +	loff_t local_offset = file_offset;
> +	int i;
> +
> +	/* This function is only for extent_type INTERLEAVED_EXTENT */
> +	if (meta->fm_extent_type != INTERLEAVED_EXTENT) {
> +		pr_err("%s: bad extent type\n", __func__);
> +		goto err_out;
> +	}
> +
> +	if (famfs_file_bad(inode))
> +		goto err_out;
> +
> +	iomap->offset = file_offset;
> +
> +	for (i = 0; i < meta->fm_niext; i++) {
> +		struct famfs_meta_interleaved_ext *fei = &meta->ie[i];
> +		u64 chunk_size = fei->fie_chunk_size;
> +		u64 nstrips = fei->fie_nstrips;
> +		u64 ext_size = fei->fie_nbytes;
> +
> +		ext_size = min_t(u64, ext_size, meta->file_size);
min() probably fine. Also, how about avoiding the assignment that
is immediately overwritten.

		u64 ext_size = min(fei->fie_nbytes, meta->file_size);

> +
> +		if (ext_size == 0) {
> +			pr_err("%s: ext_size=%lld file_size=%ld\n",
> +			       __func__, fei->fie_nbytes, meta->file_size);
> +			goto err_out;
> +		}
> +
> +		/* Is the data is in this striped extent? */
> +		if (local_offset < ext_size) {
Similar comments to below, though here that would mean not being able
to scope these local variables as tightly so maybe not worth it to reduce
indent.

> +			u64 chunk_num       = local_offset / chunk_size;
> +			u64 chunk_offset    = local_offset % chunk_size;
> +			u64 stripe_num      = chunk_num / nstrips;
> +			u64 strip_num       = chunk_num % nstrips;
> +			u64 chunk_remainder = chunk_size - chunk_offset;

I'd group chunk stuff, then strip stuff.

> +			u64 strip_offset    = chunk_offset + (stripe_num * chunk_size);
> +			u64 strip_dax_ofs = fei->ie_strips[strip_num].ext_offset;
> +			u64 strip_devidx = fei->ie_strips[strip_num].dev_index;
> +
> +			if (strip_devidx >= fc->dax_devlist->nslots) {
> +				pr_err("%s: strip_devidx %llu >= nslots %d\n",
> +				       __func__, strip_devidx,
> +				       fc->dax_devlist->nslots);
> +				goto err_out;
> +			}
> +
> +			if (!fc->dax_devlist->devlist[strip_devidx].valid) {
> +				pr_err("%s: daxdev=%lld invalid\n", __func__,
> +					strip_devidx);
> +				goto err_out;
> +			}
> +
> +			iomap->addr    = strip_dax_ofs + strip_offset;
> +			iomap->offset  = file_offset;
> +			iomap->length  = min_t(loff_t, len, chunk_remainder);
> +
> +			iomap->dax_dev = fc->dax_devlist->devlist[strip_devidx].devp;
> +
> +			iomap->type    = IOMAP_MAPPED;
> +			iomap->flags   = flags;
> +
> +			return 0;
> +		}
> +		local_offset -= ext_size; /* offset is beyond this striped extent */
> +	}
> +
> + err_out:
> +	pr_err("%s: err_out\n", __func__);
> +
> +	/* We fell out the end of the extent list.
> +	 * Set iomap to zero length in this case, and return 0
> +	 * This just means that the r/w is past EOF
> +	 */
> +	iomap->addr    = 0; /* there is no valid dax device offset */
> +	iomap->offset  = file_offset; /* file offset */
> +	iomap->length  = 0; /* this had better result in no access to dax mem */
> +	iomap->dax_dev = NULL;
> +	iomap->type    = IOMAP_MAPPED;
> +	iomap->flags   = flags;
> +
> +	return 0;
> +}
> +
> +/**
> + * famfs_fileofs_to_daxofs() - Resolve (file, offset, len) to (daxdev, offset, len)
> + *
> + * This function is called by famfs_fuse_iomap_begin() to resolve an offset in a
> + * file to an offset in a dax device. This is upcalled from dax from calls to
> + * both  * dax_iomap_fault() and dax_iomap_rw(). Dax finishes the job resolving
> + * a fault to a specific physical page (the fault case) or doing a memcpy
> + * variant (the rw case)
> + *
> + * Pages can be PTE (4k), PMD (2MiB) or (theoretically) PuD (1GiB)
> + * (these sizes are for X86; may vary on other cpu architectures
> + *
> + * @inode:  The file where the fault occurred
> + * @iomap:       To be filled in to indicate where to find the right memory,
> + *               relative  to a dax device.
> + * @file_offset: Within the file where the fault occurred (will be page boundary)
> + * @len:         The length of the faulted mapping (will be a page multiple)
> + *               (will be trimmed in *iomap if it's disjoint in the extent list)
> + * @flags:

As below. All should have docs, even if trivial.

> + *
> + * Return values: 0. (info is returned in a modified @iomap struct)
> + */
> +static int
> +famfs_fileofs_to_daxofs(struct inode *inode, struct iomap *iomap,
> +			 loff_t file_offset, off_t len, unsigned int flags)
> +{
> +	struct fuse_inode *fi = get_fuse_inode(inode);
> +	struct famfs_file_meta *meta = fi->famfs_meta;
> +	struct fuse_conn *fc = get_fuse_conn(inode);
> +	loff_t local_offset = file_offset;
> +	int i;
> +
> +	if (!fc->dax_devlist) {
> +		pr_err("%s: null dax_devlist\n", __func__);
> +		goto err_out;
> +	}
> +
> +	if (famfs_file_bad(inode))
> +		goto err_out;
> +
> +	if (meta->fm_extent_type == INTERLEAVED_EXTENT)
> +		return famfs_interleave_fileofs_to_daxofs(inode, iomap,
> +							  file_offset,
> +							  len, flags);
> +
> +	iomap->offset = file_offset;
> +
> +	for (i = 0; i < meta->fm_nextents; i++) {

I'd drag declaration of i into the loop init.

> +		/* TODO: check devindex too */
> +		loff_t dax_ext_offset = meta->se[i].ext_offset;
> +		loff_t dax_ext_len    = meta->se[i].ext_len;
> +		u64 daxdev_idx = meta->se[i].dev_index;
> +
> +
> +		/* TODO: test that superblock and log offsets only happen
> +		 * with superblock and log files. Requires instrumentaiton
> +		 * from user space...
> +		 */
> +
> +		/* local_offset is the offset minus the size of extents skipped
> +		 * so far; If local_offset < dax_ext_len, the data of interest
> +		 * starts in this extent
> +		 */
> +		if (local_offset < dax_ext_len) {

Maybe flip logic and use a continue.  Mostly to reduce indent of the rest of
this.   Or maybe a helper function for this bit.


> +			loff_t ext_len_remainder = dax_ext_len - local_offset;
> +			struct famfs_daxdev *dd;
> +
> +			if (daxdev_idx >= fc->dax_devlist->nslots) {
> +				pr_err("%s: daxdev_idx %llu >= nslots %d\n",
> +				       __func__, daxdev_idx,
> +				       fc->dax_devlist->nslots);
> +				goto err_out;
> +			}
> +
> +			dd = &fc->dax_devlist->devlist[daxdev_idx];
> +
> +			if (!dd->valid || dd->error) {
> +				pr_err("%s: daxdev=%lld %s\n", __func__,
> +				       daxdev_idx,
> +				       dd->valid ? "error" : "invalid");
> +				goto err_out;
> +			}
> +
> +			/*
> +			 * OK, we found the file metadata extent where this
> +			 * data begins
> +			 * @local_offset      - The offset within the current
> +			 *                      extent
> +			 * @ext_len_remainder - Remaining length of ext after
> +			 *                      skipping local_offset
> +			 * Outputs:
> +			 * iomap->addr:   the offset within the dax device where
> +			 *                the  data starts
> +			 * iomap->offset: the file offset
> +			 * iomap->length: the valid length resolved here
> +			 */
> +			iomap->addr    = dax_ext_offset + local_offset;
> +			iomap->offset  = file_offset;
> +			iomap->length  = min_t(loff_t, len, ext_len_remainder);
> +
> +			iomap->dax_dev = fc->dax_devlist->devlist[daxdev_idx].devp;
> +
> +			iomap->type    = IOMAP_MAPPED;
> +			iomap->flags   = flags;
> +			return 0;
> +		}
> +		local_offset -= dax_ext_len; /* Get ready for the next extent */
> +	}
> +
> + err_out:
> +	pr_err("%s: err_out\n", __func__);
> +
> +	/* We fell out the end of the extent list.
> +	 * Set iomap to zero length in this case, and return 0
> +	 * This just means that the r/w is past EOF
> +	 */
> +	iomap->addr    = 0; /* there is no valid dax device offset */
> +	iomap->offset  = file_offset; /* file offset */
> +	iomap->length  = 0; /* this had better result in no access to dax mem */
> +	iomap->dax_dev = NULL;
> +	iomap->type    = IOMAP_MAPPED;
> +	iomap->flags   = flags;
> +
> +	return 0;
> +}
> +
> +/**
> + * famfs_fuse_iomap_begin() - Handler for iomap_begin upcall from dax
> + *
> + * This function is pretty simple because files are
> + * * never partially allocated
> + * * never have holes (never sparse)
> + * * never "allocate on write"
> + *
> + * @inode:  inode for the file being accessed
> + * @offset: offset within the file
> + * @length: Length being accessed at offset
> + * @flags:
> + * @iomap:  iomap struct to be filled in, resolving (offset, length) to
> + *          (daxdev, offset, len)
> + * @srcmap:

All parameters should have description. 

> + */
> +static int
> +famfs_fuse_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
> +		  unsigned int flags, struct iomap *iomap, struct iomap *srcmap)
> +{
> +	struct fuse_inode *fi = get_fuse_inode(inode);
> +	struct famfs_file_meta *meta = fi->famfs_meta;
> +	size_t size;
> +
> +	size = i_size_read(inode);
> +
> +	WARN_ON(size != meta->file_size);
> +
> +	return famfs_fileofs_to_daxofs(inode, iomap, offset, length, flags);
> +}

> +
> +static inline bool
> +famfs_is_write_fault(struct vm_fault *vmf)
> +{
> +	return (vmf->flags & FAULT_FLAG_WRITE) &&
> +	       (vmf->vma->vm_flags & VM_SHARED);
> +}
> +
> +static vm_fault_t
> +famfs_filemap_fault(struct vm_fault *vmf)
> +{
> +	return __famfs_fuse_filemap_fault(vmf, 0, famfs_is_write_fault(vmf));
> +}
> +
> +static vm_fault_t
> +famfs_filemap_huge_fault(struct vm_fault *vmf, unsigned int pe_size)
> +{
> +	return __famfs_fuse_filemap_fault(vmf, pe_size, famfs_is_write_fault(vmf));
> +}
> +
> +static vm_fault_t
> +famfs_filemap_page_mkwrite(struct vm_fault *vmf)
> +{
> +	return __famfs_fuse_filemap_fault(vmf, 0, true);
I'm not an fs person but I note ext4 etc are able to use the
same callback for all of these and can figure out the write fault
question inside that callback. Is there a reason that doesn't work here?
Looks like an appropriate vmf flag is set for each type of callback.
> +}
> +
> +static vm_fault_t
Similar to earlier comments. I'd put these on one line unless you
have to split them due to length.

> +famfs_filemap_pfn_mkwrite(struct vm_fault *vmf)
Given this and the previous page_mkwrite one are identical, just
use one more generically named callback.  Lots of FS seem to do this
when these match. E.g. ext4_dax_fault()

> +{
> +	return __famfs_fuse_filemap_fault(vmf, 0, true);
> +}
> +
> +static vm_fault_t
> +famfs_filemap_map_pages(struct vm_fault	*vmf, pgoff_t start_pgoff,
> +			pgoff_t	end_pgoff)
> +{
> +	return filemap_map_pages(vmf, start_pgoff, end_pgoff);

Why not just use this directly as the vm_operation?  shmem does
this for instance.


> +}
> +
> +const struct vm_operations_struct famfs_file_vm_ops = {
> +	.fault		= famfs_filemap_fault,
> +	.huge_fault	= famfs_filemap_huge_fault,
> +	.map_pages	= famfs_filemap_map_pages,
> +	.page_mkwrite	= famfs_filemap_page_mkwrite,
> +	.pfn_mkwrite	= famfs_filemap_pfn_mkwrite,
> +};
> +
> +/*********************************************************************
> + * file_operations
> + */
> +
> +/**
> + * famfs_file_bad() - Check for files that aren't in a valid state
> + *
> + * @inode - inode
> + *
> + * Returns: 0=success
> + *          -errno=failure
> + */
> +static ssize_t
Odd return type.  Why not int?
> +famfs_file_bad(struct inode *inode)
> +{
> +	struct fuse_inode *fi = get_fuse_inode(inode);
> +	struct famfs_file_meta *meta = fi->famfs_meta;
> +	size_t i_size = i_size_read(inode);
> +
> +	if (!meta) {
> +		pr_err("%s: un-initialized famfs file\n", __func__);
> +		return -EIO;
> +	}
> +	if (meta->error) {
> +		pr_debug("%s: previously detected metadata errors\n", __func__);
> +		return -EIO;
> +	}
> +	if (i_size != meta->file_size) {
> +		pr_warn("%s: i_size overwritten from %ld to %ld\n",
> +		       __func__, meta->file_size, i_size);
> +		meta->error = true;
> +		return -ENXIO;
> +	}
> +	if (!IS_DAX(inode)) {
> +		pr_debug("%s: inode %llx IS_DAX is false\n",
> +			 __func__, (u64)inode);
> +		return -ENXIO;
> +	}
> +	return 0;
> +}
> +
> +static ssize_t

This can probably just return an int given type seems to be driven
by famfs_file_bad() which doesn't make much sense as returning a ssize_t
Storing an int into a ssize_t without cast should be fine.

> +famfs_fuse_rw_prep(struct kiocb *iocb, struct iov_iter *ubuf)
> +{
> +	struct inode *inode = iocb->ki_filp->f_mapping->host;
> +	size_t i_size = i_size_read(inode);
> +	size_t count = iov_iter_count(ubuf);
> +	size_t max_count;
> +	ssize_t rc;
> +
> +	rc = famfs_file_bad(inode);
> +	if (rc)
> +		return rc;
> +
> +	/* Avoid unsigned underflow if position is past EOF */
> +	if (iocb->ki_pos >= i_size)
> +		max_count = 0;
> +	else
> +		max_count = i_size - iocb->ki_pos;
> +
> +	if (count > max_count)
> +		iov_iter_truncate(ubuf, max_count);
> +
> +	if (!iov_iter_count(ubuf))
> +		return 0;
> +
> +	return rc;
> +}
> +
> +ssize_t
> +famfs_fuse_read_iter(struct kiocb *iocb, struct iov_iter	*to)
> +{
> +	ssize_t rc;
> +
> +	rc = famfs_fuse_rw_prep(iocb, to);
> +	if (rc)
> +		return rc;
> +
> +	if (!iov_iter_count(to))
> +		return 0;
> +
> +	rc = dax_iomap_rw(iocb, to, &famfs_iomap_ops);
> +
> +	file_accessed(iocb->ki_filp);
> +	return rc;
> +}

> +
> +int
> +famfs_fuse_mmap(struct file *file, struct vm_area_struct *vma)
> +{
> +	struct inode *inode = file_inode(file);
> +	ssize_t rc;
> +
> +	rc = famfs_file_bad(inode);
> +	if (rc)
> +		return (int)rc;
This was odd so I went and looked. famfs_file_bad() should probably just return an int.
> +
> +	file_accessed(file);
> +	vma->vm_ops = &famfs_file_vm_ops;
> +	vm_flags_set(vma, VM_HUGEPAGE);
> +	return 0;
> +}
> +
>  #define FMAP_BUFSIZE PAGE_SIZE
>  
>  int
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 1f64bf68b5ee..45a09a7f0012 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1831,6 +1831,8 @@ static ssize_t fuse_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  
>  	if (FUSE_IS_VIRTIO_DAX(fi))
>  		return fuse_dax_read_iter(iocb, to);
> +	if (fuse_file_famfs(fi))
> +		return famfs_fuse_read_iter(iocb, to);
>  
>  	/* FOPEN_DIRECT_IO overrides FOPEN_PASSTHROUGH */
>  	if (ff->open_flags & FOPEN_DIRECT_IO)
> @@ -1853,6 +1855,8 @@ static ssize_t fuse_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  
>  	if (FUSE_IS_VIRTIO_DAX(fi))
>  		return fuse_dax_write_iter(iocb, from);
> +	if (fuse_file_famfs(fi))
> +		return famfs_fuse_write_iter(iocb, from);
>  
>  	/* FOPEN_DIRECT_IO overrides FOPEN_PASSTHROUGH */
>  	if (ff->open_flags & FOPEN_DIRECT_IO)
> @@ -1868,9 +1872,13 @@ static ssize_t fuse_splice_read(struct file *in, loff_t *ppos,
>  				unsigned int flags)
>  {
>  	struct fuse_file *ff = in->private_data;
> +	struct inode *inode = file_inode(in);
> +	struct fuse_inode *fi = get_fuse_inode(inode);
>  
>  	/* FOPEN_DIRECT_IO overrides FOPEN_PASSTHROUGH */
> -	if (fuse_file_passthrough(ff) && !(ff->open_flags & FOPEN_DIRECT_IO))
> +	if (fuse_file_famfs(fi))
> +		return -EIO; /* famfs does not use the page cache... */

As below.

> +	else if (fuse_file_passthrough(ff) && !(ff->open_flags & FOPEN_DIRECT_IO))
>  		return fuse_passthrough_splice_read(in, ppos, pipe, len, flags);
>  	else
>  		return filemap_splice_read(in, ppos, pipe, len, flags);
> @@ -1880,9 +1888,13 @@ static ssize_t fuse_splice_write(struct pipe_inode_info *pipe, struct file *out,
>  				 loff_t *ppos, size_t len, unsigned int flags)
>  {
>  	struct fuse_file *ff = out->private_data;
> +	struct inode *inode = file_inode(out);
> +	struct fuse_inode *fi = get_fuse_inode(inode);
>  
>  	/* FOPEN_DIRECT_IO overrides FOPEN_PASSTHROUGH */
> -	if (fuse_file_passthrough(ff) && !(ff->open_flags & FOPEN_DIRECT_IO))
> +	if (fuse_file_famfs(fi))
> +		return -EIO; /* famfs does not use the page cache... */

Not sure why original code had else, but not needed given returned.
Maybe stick to local style.


> +	else if (fuse_file_passthrough(ff) && !(ff->open_flags & FOPEN_DIRECT_IO))
>  		return fuse_passthrough_splice_write(pipe, out, ppos, len, flags);
>  	else
>  		return iter_file_splice_write(pipe, out, ppos, len, flags);
> @@ -2390,6 +2402,8 @@ static int fuse_file_mmap(struct file *file, struct vm_area_struct *vma)
>  	/* DAX mmap is superior to direct_io mmap */
>  	if (FUSE_IS_VIRTIO_DAX(fi))
>  		return fuse_dax_mmap(file, vma);
> +	if (fuse_file_famfs(fi))
> +		return famfs_fuse_mmap(file, vma);
>  
>  	/*
>  	 * If inode is in passthrough io mode, because it has some file open



