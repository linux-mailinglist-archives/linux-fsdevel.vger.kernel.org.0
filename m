Return-Path: <linux-fsdevel+bounces-39064-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 568F9A0BDBA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 17:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F26A18843B2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 16:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5EA820F078;
	Mon, 13 Jan 2025 16:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLlpfmd/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8B024024E;
	Mon, 13 Jan 2025 16:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736786361; cv=none; b=K+JS/RtsptA0J6XV53e4nlfUkBH9HUnn4pBJFStA8eKRIPCn3U35riVjdRgzgAmj58613jaOc3w34PBi9YAxoRd0cN/7k7393neY8/dDS5RrzOuYZL4l2zqRC2YmVEtnEJZxMFz0R3FC2I/EFs4IW/s4NxvMPTzekq8PKUh5O4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736786361; c=relaxed/simple;
	bh=7yznwIi42BWHftKG3KqqtvRJ/fpAO2hGQPkmVEWTBvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OH+pLke1PUW4NrmSUSjHsuBPjEe7LET/jA476WnvQLWPDlSWZoZS+wEqT0XyEOiVM4M8uoh4Hz+82zto8Ul9SzCJWN3v4ywiWpBWtEtHDYX8Nu3sYuqD5qKDJ/DuoM3+SOM6nIFbZNd2zeMs50dFmakzXORnpaLMXdc6YWZeDdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLlpfmd/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3939C4CED6;
	Mon, 13 Jan 2025 16:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736786360;
	bh=7yznwIi42BWHftKG3KqqtvRJ/fpAO2hGQPkmVEWTBvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KLlpfmd/IoMZQf0B0YYjLx4o9rP8DTZKejG1O8vfSWPjyCS2XILDAckd5gCmh6rP9
	 /T3Cvy+yTMVmmH/N/GjaylSnqiT89TAh3GxFJJHcBOU6LvkJ1h9xixjVinLXuHU4nt
	 ECYSTKSgqiAwbGNNiCncyIrMBlpzr+1QMbZ5pAqEB1ClImKQff9LEJGRjIsbcjET4n
	 +MFgQikxj6ac6i20rUdYKPRtDh8nUehKNFQt3wM6//DN8Ciu9YvhK4xLhJOX5xdZCx
	 2IqstzSR51IgAV3sdE5yQvpQD2u3T19UHIhd9gDBToQ2stuE58sZE1PDTJqiixqlpi
	 hMUJ03H6PRjHQ==
Date: Mon, 13 Jan 2025 08:39:20 -0800
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
Message-ID: <20250113163920.GE1306365@frogsfrogsfrogs>
References: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
 <704662ae360abeb777ed00efc6f8f232a79ae4ff.1736488799.git-series.apopple@nvidia.com>
 <20250110165019.GK6156@frogsfrogsfrogs>
 <p5vmaqlzge3dkkpnwceewi4io5ngqaczfa7ysujwa45kkevnam@sqc5usu7vgde>
 <20250113024940.GW1306365@frogsfrogsfrogs>
 <o4zau42ynlekxemrzubcmfxhdk7v73ffhevdyle6w6dpqaeziq@5dvnxtrwj25b>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <o4zau42ynlekxemrzubcmfxhdk7v73ffhevdyle6w6dpqaeziq@5dvnxtrwj25b>

On Mon, Jan 13, 2025 at 04:48:31PM +1100, Alistair Popple wrote:
> On Sun, Jan 12, 2025 at 06:49:40PM -0800, Darrick J. Wong wrote:
> > On Mon, Jan 13, 2025 at 11:57:18AM +1100, Alistair Popple wrote:
> > > On Fri, Jan 10, 2025 at 08:50:19AM -0800, Darrick J. Wong wrote:
> > > > On Fri, Jan 10, 2025 at 05:00:35PM +1100, Alistair Popple wrote:
> > > > > File systems call dax_break_mapping() prior to reallocating file
> > > > > system blocks to ensure the page is not undergoing any DMA or other
> > > > > accesses. Generally this is needed when a file is truncated to ensure
> > > > > that if a block is reallocated nothing is writing to it. However
> > > > > filesystems currently don't call this when an FS DAX inode is evicted.
> > > > > 
> > > > > This can cause problems when the file system is unmounted as a page
> > > > > can continue to be under going DMA or other remote access after
> > > > > unmount. This means if the file system is remounted any truncate or
> > > > > other operation which requires the underlying file system block to be
> > > > > freed will not wait for the remote access to complete. Therefore a
> > > > > busy block may be reallocated to a new file leading to corruption.
> > > > > 
> > > > > Signed-off-by: Alistair Popple <apopple@nvidia.com>
> > > > > 
> > > > > ---
> > > > > 
> > > > > Changes for v5:
> > > > > 
> > > > >  - Don't wait for pages to be idle in non-DAX mappings
> > > > > ---
> > > > >  fs/dax.c            | 29 +++++++++++++++++++++++++++++
> > > > >  fs/ext4/inode.c     | 32 ++++++++++++++------------------
> > > > >  fs/xfs/xfs_inode.c  |  9 +++++++++
> > > > >  fs/xfs/xfs_inode.h  |  1 +
> > > > >  fs/xfs/xfs_super.c  | 18 ++++++++++++++++++
> > > > >  include/linux/dax.h |  2 ++
> > > > >  6 files changed, 73 insertions(+), 18 deletions(-)
> > > > > 
> > > > > diff --git a/fs/dax.c b/fs/dax.c
> > > > > index 7008a73..4e49cc4 100644
> > > > > --- a/fs/dax.c
> > > > > +++ b/fs/dax.c
> > > > > @@ -883,6 +883,14 @@ static int wait_page_idle(struct page *page,
> > > > >  				TASK_INTERRUPTIBLE, 0, 0, cb(inode));
> > > > >  }
> > > > >  
> > > > > +static void wait_page_idle_uninterruptible(struct page *page,
> > > > > +					void (cb)(struct inode *),
> > > > > +					struct inode *inode)
> > > > > +{
> > > > > +	___wait_var_event(page, page_ref_count(page) == 1,
> > > > > +			TASK_UNINTERRUPTIBLE, 0, 0, cb(inode));
> > > > > +}
> > > > > +
> > > > >  /*
> > > > >   * Unmaps the inode and waits for any DMA to complete prior to deleting the
> > > > >   * DAX mapping entries for the range.
> > > > > @@ -911,6 +919,27 @@ int dax_break_mapping(struct inode *inode, loff_t start, loff_t end,
> > > > >  }
> > > > >  EXPORT_SYMBOL_GPL(dax_break_mapping);
> > > > >  
> > > > > +void dax_break_mapping_uninterruptible(struct inode *inode,
> > > > > +				void (cb)(struct inode *))
> > > > > +{
> > > > > +	struct page *page;
> > > > > +
> > > > > +	if (!dax_mapping(inode->i_mapping))
> > > > > +		return;
> > > > > +
> > > > > +	do {
> > > > > +		page = dax_layout_busy_page_range(inode->i_mapping, 0,
> > > > > +						LLONG_MAX);
> > > > > +		if (!page)
> > > > > +			break;
> > > > > +
> > > > > +		wait_page_idle_uninterruptible(page, cb, inode);
> > > > > +	} while (true);
> > > > > +
> > > > > +	dax_delete_mapping_range(inode->i_mapping, 0, LLONG_MAX);
> > > > > +}
> > > > > +EXPORT_SYMBOL_GPL(dax_break_mapping_uninterruptible);
> > > > > +
> > > > >  /*
> > > > >   * Invalidate DAX entry if it is clean.
> > > > >   */
> > > > > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > > > > index ee8e83f..fa35161 100644
> > > > > --- a/fs/ext4/inode.c
> > > > > +++ b/fs/ext4/inode.c
> > > > > @@ -163,6 +163,18 @@ int ext4_inode_is_fast_symlink(struct inode *inode)
> > > > >  	       (inode->i_size < EXT4_N_BLOCKS * 4);
> > > > >  }
> > > > >  
> > > > > +static void ext4_wait_dax_page(struct inode *inode)
> > > > > +{
> > > > > +	filemap_invalidate_unlock(inode->i_mapping);
> > > > > +	schedule();
> > > > > +	filemap_invalidate_lock(inode->i_mapping);
> > > > > +}
> > > > > +
> > > > > +int ext4_break_layouts(struct inode *inode)
> > > > > +{
> > > > > +	return dax_break_mapping_inode(inode, ext4_wait_dax_page);
> > > > > +}
> > > > > +
> > > > >  /*
> > > > >   * Called at the last iput() if i_nlink is zero.
> > > > >   */
> > > > > @@ -181,6 +193,8 @@ void ext4_evict_inode(struct inode *inode)
> > > > >  
> > > > >  	trace_ext4_evict_inode(inode);
> > > > >  
> > > > > +	dax_break_mapping_uninterruptible(inode, ext4_wait_dax_page);
> > > > > +
> > > > >  	if (EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL)
> > > > >  		ext4_evict_ea_inode(inode);
> > > > >  	if (inode->i_nlink) {
> > > > > @@ -3902,24 +3916,6 @@ int ext4_update_disksize_before_punch(struct inode *inode, loff_t offset,
> > > > >  	return ret;
> > > > >  }
> > > > >  
> > > > > -static void ext4_wait_dax_page(struct inode *inode)
> > > > > -{
> > > > > -	filemap_invalidate_unlock(inode->i_mapping);
> > > > > -	schedule();
> > > > > -	filemap_invalidate_lock(inode->i_mapping);
> > > > > -}
> > > > > -
> > > > > -int ext4_break_layouts(struct inode *inode)
> > > > > -{
> > > > > -	struct page *page;
> > > > > -	int error;
> > > > > -
> > > > > -	if (WARN_ON_ONCE(!rwsem_is_locked(&inode->i_mapping->invalidate_lock)))
> > > > > -		return -EINVAL;
> > > > > -
> > > > > -	return dax_break_mapping_inode(inode, ext4_wait_dax_page);
> > > > > -}
> > > > > -
> > > > >  /*
> > > > >   * ext4_punch_hole: punches a hole in a file by releasing the blocks
> > > > >   * associated with the given offset and length
> > > > > diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> > > > > index 4410b42..c7ec5ab 100644
> > > > > --- a/fs/xfs/xfs_inode.c
> > > > > +++ b/fs/xfs/xfs_inode.c
> > > > > @@ -2997,6 +2997,15 @@ xfs_break_dax_layouts(
> > > > >  	return dax_break_mapping_inode(inode, xfs_wait_dax_page);
> > > > >  }
> > > > >  
> > > > > +void
> > > > > +xfs_break_dax_layouts_uninterruptible(
> > > > > +	struct inode		*inode)
> > > > > +{
> > > > > +	xfs_assert_ilocked(XFS_I(inode), XFS_MMAPLOCK_EXCL);
> > > > > +
> > > > > +	dax_break_mapping_uninterruptible(inode, xfs_wait_dax_page);
> > > > > +}
> > > > > +
> > > > >  int
> > > > >  xfs_break_layouts(
> > > > >  	struct inode		*inode,
> > > > > diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
> > > > > index c4f03f6..613797a 100644
> > > > > --- a/fs/xfs/xfs_inode.h
> > > > > +++ b/fs/xfs/xfs_inode.h
> > > > > @@ -594,6 +594,7 @@ xfs_itruncate_extents(
> > > > >  }
> > > > >  
> > > > >  int	xfs_break_dax_layouts(struct inode *inode);
> > > > > +void xfs_break_dax_layouts_uninterruptible(struct inode *inode);
> > > > >  int	xfs_break_layouts(struct inode *inode, uint *iolock,
> > > > >  		enum layout_break_reason reason);
> > > > >  
> > > > > diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> > > > > index 8524b9d..73ec060 100644
> > > > > --- a/fs/xfs/xfs_super.c
> > > > > +++ b/fs/xfs/xfs_super.c
> > > > > @@ -751,6 +751,23 @@ xfs_fs_drop_inode(
> > > > >  	return generic_drop_inode(inode);
> > > > >  }
> > > > >  
> > > > > +STATIC void
> > > > > +xfs_fs_evict_inode(
> > > > > +	struct inode		*inode)
> > > > > +{
> > > > > +	struct xfs_inode	*ip = XFS_I(inode);
> > > > > +	uint			iolock = XFS_IOLOCK_EXCL | XFS_MMAPLOCK_EXCL;
> > > > > +
> > > > > +	if (IS_DAX(inode)) {
> > > > > +		xfs_ilock(ip, iolock);
> > > > > +		xfs_break_dax_layouts_uninterruptible(inode);
> > > > > +		xfs_iunlock(ip, iolock);
> > > > 
> > > > If we're evicting the inode, why is it necessary to take i_rwsem and the
> > > > mmap invalidation lock?  Shouldn't the evicting thread be the only one
> > > > with access to this inode?
> > > 
> > > Hmm, good point. I think you're right. I can easily stop taking
> > > XFS_IOLOCK_EXCL. Not taking XFS_MMAPLOCK_EXCL is slightly more difficult because
> > > xfs_wait_dax_page() expects it to be taken. Do you think it is worth creating a
> > > separate callback (xfs_wait_dax_page_unlocked()?) specifically for this path or
> > > would you be happy with a comment explaining why we take the XFS_MMAPLOCK_EXCL
> > > lock here?
> > 
> > There shouldn't be any other threads removing "pages" from i_mapping
> > during eviction, right?  If so, I think you can just call schedule()
> > directly from dax_break_mapping_uninterruptble.
> 
> Oh right, and I guess you are saying the same would apply to ext4 so no need to
> cycle the filemap lock there either, which I've just noticed is buggy anyway. So
> I can just remove the callback entirely for dax_break_mapping_uninterruptible.

Right.  You might want to rename dax_break_layouts_uninterruptible to
make it clearer that it's for evictions and doesn't go through the
mmap invalidation lock.

> > (dax mappings aren't allowed supposed to persist beyond unmount /
> > eviction, just like regular pagecache, right??)
> 
> Right they're not *supposed* to, but until at least this patch is applied they
> can ;-)

Yikes!

--D

>  - Alistair
> 
> > --D
> > 
> > >  - Alistair
> > > 
> > > > --D
> > > > 
> > > > > +	}
> > > > > +
> > > > > +	truncate_inode_pages_final(&inode->i_data);
> > > > > +	clear_inode(inode);
> > > > > +}
> > > > > +
> > > > >  static void
> > > > >  xfs_mount_free(
> > > > >  	struct xfs_mount	*mp)
> > > > > @@ -1189,6 +1206,7 @@ static const struct super_operations xfs_super_operations = {
> > > > >  	.destroy_inode		= xfs_fs_destroy_inode,
> > > > >  	.dirty_inode		= xfs_fs_dirty_inode,
> > > > >  	.drop_inode		= xfs_fs_drop_inode,
> > > > > +	.evict_inode		= xfs_fs_evict_inode,
> > > > >  	.put_super		= xfs_fs_put_super,
> > > > >  	.sync_fs		= xfs_fs_sync_fs,
> > > > >  	.freeze_fs		= xfs_fs_freeze,
> > > > > diff --git a/include/linux/dax.h b/include/linux/dax.h
> > > > > index ef9e02c..7c3773f 100644
> > > > > --- a/include/linux/dax.h
> > > > > +++ b/include/linux/dax.h
> > > > > @@ -274,6 +274,8 @@ static inline int __must_check dax_break_mapping_inode(struct inode *inode,
> > > > >  {
> > > > >  	return dax_break_mapping(inode, 0, LLONG_MAX, cb);
> > > > >  }
> > > > > +void dax_break_mapping_uninterruptible(struct inode *inode,
> > > > > +				void (cb)(struct inode *));
> > > > >  int dax_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
> > > > >  				  struct inode *dest, loff_t destoff,
> > > > >  				  loff_t len, bool *is_same,
> > > > > -- 
> > > > > git-series 0.9.1
> > > > > 
> > > 
> 

