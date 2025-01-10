Return-Path: <linux-fsdevel+bounces-38892-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6140A097D6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 17:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B008188D517
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 16:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0080021325E;
	Fri, 10 Jan 2025 16:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vHRV9nyq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B862212D6E;
	Fri, 10 Jan 2025 16:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736527820; cv=none; b=twWnm8Lnncn/A+U9sdzu6hvJbPq3nNscWOejhMOfdZ/sLTAJDq3dwyIDqfOgLcrJECyh35+i1jg+GRVKT0l6eq1U5ExF6Dqk2NJu/g65eWOqc9MXduHGJUP3ZyN/9szTmimjSz806XHc39jN+5xUWITk8CvDARYUEascx9IHpXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736527820; c=relaxed/simple;
	bh=5VSUGSu9BR1n/nKzKdICXzahPQ4soShf72WzqIUuGnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XHIJ1kXmEGtbA7sbhO9Fsv8tCeUPB0UE8Kwj8p/4NKuge2fOJiGUPVsVKy6jJFiI9PXOmaHP+d/RPbiFZWOu8tnSD55T06JhHuoYcL50TJPODhAN9bnxT9FtcW6Wmhj4fE4mFgg4LEe4X1zqGH/lYvDTyGvVq++NPfkB66zv0k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vHRV9nyq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09E81C4CED6;
	Fri, 10 Jan 2025 16:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736527820;
	bh=5VSUGSu9BR1n/nKzKdICXzahPQ4soShf72WzqIUuGnE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vHRV9nyqpL+Ro7f3yAiw9q++PTaPDuF/ivKV9lmJ4Ukmz/yQRbrjnqsoGlttY/XBE
	 Hq9zsm1IRvDBUJnmkp4CMx5ZoJwmszsP87Mt6ywM6PqXIwvlKTF6CPT/tknjZuZk7j
	 w8Vnd87saIzejPxlLTyqpOGOqOhVoMYtwGiWX5Qe3IUJCaT066yCqLUUrgRR5rdbMj
	 ty7WZb3SdAG0Y0EjvRRAXWvRACRC9iMC0RVfZTAL3YY9+yQVa2QyyJhQn6G9vgxX4P
	 CiyXkEafzE/5RH7p1+fdiZxkwvvPC6ygb5InHSPPT0iJ2/hXirT2MXnGJ0/qT2Axab
	 jaN+omHLMWPwQ==
Date: Fri, 10 Jan 2025 08:50:19 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Alistair Popple <apopple@nvidia.com>
Cc: akpm@linux-foundation.org, dan.j.williams@intel.com, linux-mm@kvack.org,
	alison.schofield@intel.com, lina@asahilina.net,
	zhang.lyra@gmail.com, gerald.schaefer@linux.ibm.com,
	vishal.l.verma@intel.com, dave.jiang@intel.com, logang@deltatee.com,
	bhelgaas@google.com, jack@suse.cz, jgg@ziepe.ca,
	catalin.marinas@arm.com, will@kernel.org, mpe@ellerman.id.au,
	npiggin@gmail.com, dave.hansen@linux.intel.com, ira.weiny@intel.com,
	willy@infradead.org, tytso@mit.edu, linmiaohe@huawei.com,
	david@redhat.com, peterx@redhat.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	jhubbard@nvidia.com, hch@lst.de, david@fromorbit.com,
	chenhuacai@kernel.org, kernel@xen0n.name, loongarch@lists.linux.dev
Subject: Re: [PATCH v6 07/26] fs/dax: Ensure all pages are idle prior to
 filesystem unmount
Message-ID: <20250110165019.GK6156@frogsfrogsfrogs>
References: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
 <704662ae360abeb777ed00efc6f8f232a79ae4ff.1736488799.git-series.apopple@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <704662ae360abeb777ed00efc6f8f232a79ae4ff.1736488799.git-series.apopple@nvidia.com>

On Fri, Jan 10, 2025 at 05:00:35PM +1100, Alistair Popple wrote:
> File systems call dax_break_mapping() prior to reallocating file
> system blocks to ensure the page is not undergoing any DMA or other
> accesses. Generally this is needed when a file is truncated to ensure
> that if a block is reallocated nothing is writing to it. However
> filesystems currently don't call this when an FS DAX inode is evicted.
> 
> This can cause problems when the file system is unmounted as a page
> can continue to be under going DMA or other remote access after
> unmount. This means if the file system is remounted any truncate or
> other operation which requires the underlying file system block to be
> freed will not wait for the remote access to complete. Therefore a
> busy block may be reallocated to a new file leading to corruption.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> 
> ---
> 
> Changes for v5:
> 
>  - Don't wait for pages to be idle in non-DAX mappings
> ---
>  fs/dax.c            | 29 +++++++++++++++++++++++++++++
>  fs/ext4/inode.c     | 32 ++++++++++++++------------------
>  fs/xfs/xfs_inode.c  |  9 +++++++++
>  fs/xfs/xfs_inode.h  |  1 +
>  fs/xfs/xfs_super.c  | 18 ++++++++++++++++++
>  include/linux/dax.h |  2 ++
>  6 files changed, 73 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index 7008a73..4e49cc4 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -883,6 +883,14 @@ static int wait_page_idle(struct page *page,
>  				TASK_INTERRUPTIBLE, 0, 0, cb(inode));
>  }
>  
> +static void wait_page_idle_uninterruptible(struct page *page,
> +					void (cb)(struct inode *),
> +					struct inode *inode)
> +{
> +	___wait_var_event(page, page_ref_count(page) == 1,
> +			TASK_UNINTERRUPTIBLE, 0, 0, cb(inode));
> +}
> +
>  /*
>   * Unmaps the inode and waits for any DMA to complete prior to deleting the
>   * DAX mapping entries for the range.
> @@ -911,6 +919,27 @@ int dax_break_mapping(struct inode *inode, loff_t start, loff_t end,
>  }
>  EXPORT_SYMBOL_GPL(dax_break_mapping);
>  
> +void dax_break_mapping_uninterruptible(struct inode *inode,
> +				void (cb)(struct inode *))
> +{
> +	struct page *page;
> +
> +	if (!dax_mapping(inode->i_mapping))
> +		return;
> +
> +	do {
> +		page = dax_layout_busy_page_range(inode->i_mapping, 0,
> +						LLONG_MAX);
> +		if (!page)
> +			break;
> +
> +		wait_page_idle_uninterruptible(page, cb, inode);
> +	} while (true);
> +
> +	dax_delete_mapping_range(inode->i_mapping, 0, LLONG_MAX);
> +}
> +EXPORT_SYMBOL_GPL(dax_break_mapping_uninterruptible);
> +
>  /*
>   * Invalidate DAX entry if it is clean.
>   */
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index ee8e83f..fa35161 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -163,6 +163,18 @@ int ext4_inode_is_fast_symlink(struct inode *inode)
>  	       (inode->i_size < EXT4_N_BLOCKS * 4);
>  }
>  
> +static void ext4_wait_dax_page(struct inode *inode)
> +{
> +	filemap_invalidate_unlock(inode->i_mapping);
> +	schedule();
> +	filemap_invalidate_lock(inode->i_mapping);
> +}
> +
> +int ext4_break_layouts(struct inode *inode)
> +{
> +	return dax_break_mapping_inode(inode, ext4_wait_dax_page);
> +}
> +
>  /*
>   * Called at the last iput() if i_nlink is zero.
>   */
> @@ -181,6 +193,8 @@ void ext4_evict_inode(struct inode *inode)
>  
>  	trace_ext4_evict_inode(inode);
>  
> +	dax_break_mapping_uninterruptible(inode, ext4_wait_dax_page);
> +
>  	if (EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL)
>  		ext4_evict_ea_inode(inode);
>  	if (inode->i_nlink) {
> @@ -3902,24 +3916,6 @@ int ext4_update_disksize_before_punch(struct inode *inode, loff_t offset,
>  	return ret;
>  }
>  
> -static void ext4_wait_dax_page(struct inode *inode)
> -{
> -	filemap_invalidate_unlock(inode->i_mapping);
> -	schedule();
> -	filemap_invalidate_lock(inode->i_mapping);
> -}
> -
> -int ext4_break_layouts(struct inode *inode)
> -{
> -	struct page *page;
> -	int error;
> -
> -	if (WARN_ON_ONCE(!rwsem_is_locked(&inode->i_mapping->invalidate_lock)))
> -		return -EINVAL;
> -
> -	return dax_break_mapping_inode(inode, ext4_wait_dax_page);
> -}
> -
>  /*
>   * ext4_punch_hole: punches a hole in a file by releasing the blocks
>   * associated with the given offset and length
> diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> index 4410b42..c7ec5ab 100644
> --- a/fs/xfs/xfs_inode.c
> +++ b/fs/xfs/xfs_inode.c
> @@ -2997,6 +2997,15 @@ xfs_break_dax_layouts(
>  	return dax_break_mapping_inode(inode, xfs_wait_dax_page);
>  }
>  
> +void
> +xfs_break_dax_layouts_uninterruptible(
> +	struct inode		*inode)
> +{
> +	xfs_assert_ilocked(XFS_I(inode), XFS_MMAPLOCK_EXCL);
> +
> +	dax_break_mapping_uninterruptible(inode, xfs_wait_dax_page);
> +}
> +
>  int
>  xfs_break_layouts(
>  	struct inode		*inode,
> diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
> index c4f03f6..613797a 100644
> --- a/fs/xfs/xfs_inode.h
> +++ b/fs/xfs/xfs_inode.h
> @@ -594,6 +594,7 @@ xfs_itruncate_extents(
>  }
>  
>  int	xfs_break_dax_layouts(struct inode *inode);
> +void xfs_break_dax_layouts_uninterruptible(struct inode *inode);
>  int	xfs_break_layouts(struct inode *inode, uint *iolock,
>  		enum layout_break_reason reason);
>  
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index 8524b9d..73ec060 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -751,6 +751,23 @@ xfs_fs_drop_inode(
>  	return generic_drop_inode(inode);
>  }
>  
> +STATIC void
> +xfs_fs_evict_inode(
> +	struct inode		*inode)
> +{
> +	struct xfs_inode	*ip = XFS_I(inode);
> +	uint			iolock = XFS_IOLOCK_EXCL | XFS_MMAPLOCK_EXCL;
> +
> +	if (IS_DAX(inode)) {
> +		xfs_ilock(ip, iolock);
> +		xfs_break_dax_layouts_uninterruptible(inode);
> +		xfs_iunlock(ip, iolock);

If we're evicting the inode, why is it necessary to take i_rwsem and the
mmap invalidation lock?  Shouldn't the evicting thread be the only one
with access to this inode?

--D

> +	}
> +
> +	truncate_inode_pages_final(&inode->i_data);
> +	clear_inode(inode);
> +}
> +
>  static void
>  xfs_mount_free(
>  	struct xfs_mount	*mp)
> @@ -1189,6 +1206,7 @@ static const struct super_operations xfs_super_operations = {
>  	.destroy_inode		= xfs_fs_destroy_inode,
>  	.dirty_inode		= xfs_fs_dirty_inode,
>  	.drop_inode		= xfs_fs_drop_inode,
> +	.evict_inode		= xfs_fs_evict_inode,
>  	.put_super		= xfs_fs_put_super,
>  	.sync_fs		= xfs_fs_sync_fs,
>  	.freeze_fs		= xfs_fs_freeze,
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index ef9e02c..7c3773f 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -274,6 +274,8 @@ static inline int __must_check dax_break_mapping_inode(struct inode *inode,
>  {
>  	return dax_break_mapping(inode, 0, LLONG_MAX, cb);
>  }
> +void dax_break_mapping_uninterruptible(struct inode *inode,
> +				void (cb)(struct inode *));
>  int dax_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
>  				  struct inode *dest, loff_t destoff,
>  				  loff_t len, bool *is_same,
> -- 
> git-series 0.9.1
> 

