Return-Path: <linux-fsdevel+bounces-38996-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CA0A0AD8B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 03:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0806218864AB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 02:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3911A136351;
	Mon, 13 Jan 2025 02:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FOKokPMs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642AF433C8;
	Mon, 13 Jan 2025 02:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736736471; cv=none; b=Qc5gBDsfMRkB9FMbn8oxKRsyafKsZzurM/ZalyvSrqrfhVART+7FAD3KCOoeBA3/fCLu8q409RZ+K2krXQ+Dtb0GckePdpZPvKsi4/aSBos/SX69qYx4s6D4is3rzVT/A+PeB8rSe+l3p4gpgLrej49esk+iILnpY2eQ3Ax0huM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736736471; c=relaxed/simple;
	bh=gP6Hf8DV4w/UTePON+8BvVG7kYjOiT0KO8ZCUbBNisg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mtHFNouGVZlC+H0/B1rNYW//pv7oEZxVY7WarY3wL3dpdpqtT57HtMDfSoMX+MU1sNKT2zvbGUsZkLsNf8ojEnr2h+FYFwehg1VN+3CNwDqBsIIzmb1Rk+Xcqzvs5g6ykx7XV0R000WAPnJ3bO2U7B09vph2kEm/DUYxnVUSZTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FOKokPMs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5855C4CEDF;
	Mon, 13 Jan 2025 02:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736736470;
	bh=gP6Hf8DV4w/UTePON+8BvVG7kYjOiT0KO8ZCUbBNisg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FOKokPMsFfajbfEYx/DPjYFLRqlx6tsU9JAJwyO9Yl6QzrD5hN/rzZz0rR61g8F+p
	 KNgYIBGaE9Cza208rccMBtJQo3udGHEdyJYl35QvZkUQfQIBnGDYxMTBjxQSBdNl6W
	 rfvJbZkYu0OkLsuu05877EMrvG5LshP8SSGSkn/pXipItuycmvNk+AaXR6HCH+Bo8m
	 nY+0jB3niQ+2CZZoz8UHNbwN+St82Zpzws8K8kQIloUL2RirNCeodtrow9nIeTn0Wq
	 Z3ienwoVjtHr8LM4rdPu+pT3S7nV6JPjXLrrZcEdMLRIgiTR8CX82mo5IJU29NHsuu
	 0XlGEOGFxd/+w==
Date: Sun, 12 Jan 2025 18:47:50 -0800
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
Subject: Re: [PATCH v6 05/26] fs/dax: Create a common implementation to break
 DAX layouts
Message-ID: <20250113024750.GV1306365@frogsfrogsfrogs>
References: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
 <79936ac15c917f4004397027f648d4fc9c092424.1736488799.git-series.apopple@nvidia.com>
 <20250110164438.GJ6156@frogsfrogsfrogs>
 <lui7hffmc35dfzwxu3xyybf5pion74fbfxszfopsp6tgyt2ajq@bmpeieroavro>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lui7hffmc35dfzwxu3xyybf5pion74fbfxszfopsp6tgyt2ajq@bmpeieroavro>

On Mon, Jan 13, 2025 at 11:47:41AM +1100, Alistair Popple wrote:
> On Fri, Jan 10, 2025 at 08:44:38AM -0800, Darrick J. Wong wrote:
> > On Fri, Jan 10, 2025 at 05:00:33PM +1100, Alistair Popple wrote:
> > > Prior to freeing a block file systems supporting FS DAX must check
> > > that the associated pages are both unmapped from user-space and not
> > > undergoing DMA or other access from eg. get_user_pages(). This is
> > > achieved by unmapping the file range and scanning the FS DAX
> > > page-cache to see if any pages within the mapping have an elevated
> > > refcount.
> > > 
> > > This is done using two functions - dax_layout_busy_page_range() which
> > > returns a page to wait for the refcount to become idle on. Rather than
> > > open-code this introduce a common implementation to both unmap and
> > > wait for the page to become idle.
> > > 
> > > Signed-off-by: Alistair Popple <apopple@nvidia.com>
> > 
> > So now that Dan Carpenter has complained, I guess I should look at
> > this...
> > 
> > > ---
> > > 
> > > Changes for v5:
> > > 
> > >  - Don't wait for idle pages on non-DAX mappings
> > > 
> > > Changes for v4:
> > > 
> > >  - Fixed some build breakage due to missing symbol exports reported by
> > >    John Hubbard (thanks!).
> > > ---
> > >  fs/dax.c            | 33 +++++++++++++++++++++++++++++++++
> > >  fs/ext4/inode.c     | 10 +---------
> > >  fs/fuse/dax.c       | 27 +++------------------------
> > >  fs/xfs/xfs_inode.c  | 23 +++++------------------
> > >  fs/xfs/xfs_inode.h  |  2 +-
> > >  include/linux/dax.h | 21 +++++++++++++++++++++
> > >  mm/madvise.c        |  8 ++++----
> > >  7 files changed, 68 insertions(+), 56 deletions(-)
> > > 
> > > diff --git a/fs/dax.c b/fs/dax.c
> > > index d010c10..9c3bd07 100644
> > > --- a/fs/dax.c
> > > +++ b/fs/dax.c
> > > @@ -845,6 +845,39 @@ int dax_delete_mapping_entry(struct address_space *mapping, pgoff_t index)
> > >  	return ret;
> > >  }
> > >  
> > > +static int wait_page_idle(struct page *page,
> > > +			void (cb)(struct inode *),
> > > +			struct inode *inode)
> > > +{
> > > +	return ___wait_var_event(page, page_ref_count(page) == 1,
> > > +				TASK_INTERRUPTIBLE, 0, 0, cb(inode));
> > > +}
> > > +
> > > +/*
> > > + * Unmaps the inode and waits for any DMA to complete prior to deleting the
> > > + * DAX mapping entries for the range.
> > > + */
> > > +int dax_break_mapping(struct inode *inode, loff_t start, loff_t end,
> > > +		void (cb)(struct inode *))
> > > +{
> > > +	struct page *page;
> > > +	int error;
> > > +
> > > +	if (!dax_mapping(inode->i_mapping))
> > > +		return 0;
> > > +
> > > +	do {
> > > +		page = dax_layout_busy_page_range(inode->i_mapping, start, end);
> > > +		if (!page)
> > > +			break;
> > > +
> > > +		error = wait_page_idle(page, cb, inode);
> > > +	} while (error == 0);
> > 
> > You didn't initialize error to 0, so it could be any value.  What if
> > dax_layout_busy_page_range returns null the first time through the loop?
> 
> Yes. I went down the rabbit hole of figuring out why this didn't produce a
> compiler warning and forgot to go back and fix it. Thanks.
>  
> > > +
> > > +	return error;
> > > +}
> > > +EXPORT_SYMBOL_GPL(dax_break_mapping);
> > > +
> > >  /*
> > >   * Invalidate DAX entry if it is clean.
> > >   */
> > 
> > <I'm no expert, skipping to xfs>
> > 
> > > diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> > > index 42ea203..295730a 100644
> > > --- a/fs/xfs/xfs_inode.c
> > > +++ b/fs/xfs/xfs_inode.c
> > > @@ -2715,21 +2715,17 @@ xfs_mmaplock_two_inodes_and_break_dax_layout(
> > >  	struct xfs_inode	*ip2)
> > >  {
> > >  	int			error;
> > > -	bool			retry;
> > >  	struct page		*page;
> > >  
> > >  	if (ip1->i_ino > ip2->i_ino)
> > >  		swap(ip1, ip2);
> > >  
> > >  again:
> > > -	retry = false;
> > >  	/* Lock the first inode */
> > >  	xfs_ilock(ip1, XFS_MMAPLOCK_EXCL);
> > > -	error = xfs_break_dax_layouts(VFS_I(ip1), &retry);
> > > -	if (error || retry) {
> > > +	error = xfs_break_dax_layouts(VFS_I(ip1));
> > > +	if (error) {
> > >  		xfs_iunlock(ip1, XFS_MMAPLOCK_EXCL);
> > > -		if (error == 0 && retry)
> > > -			goto again;
> > 
> > Hmm, so the retry loop has moved into xfs_break_dax_layouts, which means
> > that we no longer cycle the MMAPLOCK.  Why was the lock cycling
> > unnecessary?
> 
> Because the lock cycling is already happening in the xfs_wait_dax_page()
> callback which is called as part of the retry loop in dax_break_mapping().

Aha, good point.

--D

> > >  		return error;
> > >  	}
> > >  
> > > @@ -2988,19 +2984,11 @@ xfs_wait_dax_page(
> > >  
> > >  int
> > >  xfs_break_dax_layouts(
> > > -	struct inode		*inode,
> > > -	bool			*retry)
> > > +	struct inode		*inode)
> > >  {
> > > -	struct page		*page;
> > > -
> > >  	xfs_assert_ilocked(XFS_I(inode), XFS_MMAPLOCK_EXCL);
> > >  
> > > -	page = dax_layout_busy_page(inode->i_mapping);
> > > -	if (!page)
> > > -		return 0;
> > > -
> > > -	*retry = true;
> > > -	return dax_wait_page_idle(page, xfs_wait_dax_page, inode);
> > > +	return dax_break_mapping_inode(inode, xfs_wait_dax_page);
> > >  }
> > >  
> > >  int
> > > @@ -3018,8 +3006,7 @@ xfs_break_layouts(
> > >  		retry = false;
> > >  		switch (reason) {
> > >  		case BREAK_UNMAP:
> > > -			error = xfs_break_dax_layouts(inode, &retry);
> > > -			if (error || retry)
> > > +			if (xfs_break_dax_layouts(inode))
> > 
> > dax_break_mapping can return -ERESTARTSYS, right?  So doesn't this need
> > to be:
> > 			error = xfs_break_dax_layouts(inode);
> > 			if (error)
> > 				break;
> > 
> > Hm?
> 
> Right. Thanks for the review, have fixed for the next respin.
> 
>  - Alistair
> 
> > --D
> > 
> > >  				break;
> > >  			fallthrough;
> > >  		case BREAK_WRITE:
> > > diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
> > > index 1648dc5..c4f03f6 100644
> > > --- a/fs/xfs/xfs_inode.h
> > > +++ b/fs/xfs/xfs_inode.h
> > > @@ -593,7 +593,7 @@ xfs_itruncate_extents(
> > >  	return xfs_itruncate_extents_flags(tpp, ip, whichfork, new_size, 0);
> > >  }
> > >  
> > > -int	xfs_break_dax_layouts(struct inode *inode, bool *retry);
> > > +int	xfs_break_dax_layouts(struct inode *inode);
> > >  int	xfs_break_layouts(struct inode *inode, uint *iolock,
> > >  		enum layout_break_reason reason);
> > >  
> > > diff --git a/include/linux/dax.h b/include/linux/dax.h
> > > index 9b1ce98..f6583d3 100644
> > > --- a/include/linux/dax.h
> > > +++ b/include/linux/dax.h
> > > @@ -228,6 +228,20 @@ static inline void dax_read_unlock(int id)
> > >  {
> > >  }
> > >  #endif /* CONFIG_DAX */
> > > +
> > > +#if !IS_ENABLED(CONFIG_FS_DAX)
> > > +static inline int __must_check dax_break_mapping(struct inode *inode,
> > > +			    loff_t start, loff_t end, void (cb)(struct inode *))
> > > +{
> > > +	return 0;
> > > +}
> > > +
> > > +static inline void dax_break_mapping_uninterruptible(struct inode *inode,
> > > +						void (cb)(struct inode *))
> > > +{
> > > +}
> > > +#endif
> > > +
> > >  bool dax_alive(struct dax_device *dax_dev);
> > >  void *dax_get_private(struct dax_device *dax_dev);
> > >  long dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff, long nr_pages,
> > > @@ -251,6 +265,13 @@ vm_fault_t dax_finish_sync_fault(struct vm_fault *vmf,
> > >  int dax_delete_mapping_entry(struct address_space *mapping, pgoff_t index);
> > >  int dax_invalidate_mapping_entry_sync(struct address_space *mapping,
> > >  				      pgoff_t index);
> > > +int __must_check dax_break_mapping(struct inode *inode, loff_t start,
> > > +				loff_t end, void (cb)(struct inode *));
> > > +static inline int __must_check dax_break_mapping_inode(struct inode *inode,
> > > +						void (cb)(struct inode *))
> > > +{
> > > +	return dax_break_mapping(inode, 0, LLONG_MAX, cb);
> > > +}
> > >  int dax_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
> > >  				  struct inode *dest, loff_t destoff,
> > >  				  loff_t len, bool *is_same,
> > > diff --git a/mm/madvise.c b/mm/madvise.c
> > > index 49f3a75..1f4c99e 100644
> > > --- a/mm/madvise.c
> > > +++ b/mm/madvise.c
> > > @@ -1063,7 +1063,7 @@ static int guard_install_pud_entry(pud_t *pud, unsigned long addr,
> > >  	pud_t pudval = pudp_get(pud);
> > >  
> > >  	/* If huge return >0 so we abort the operation + zap. */
> > > -	return pud_trans_huge(pudval) || pud_devmap(pudval);
> > > +	return pud_trans_huge(pudval);
> > >  }
> > >  
> > >  static int guard_install_pmd_entry(pmd_t *pmd, unsigned long addr,
> > > @@ -1072,7 +1072,7 @@ static int guard_install_pmd_entry(pmd_t *pmd, unsigned long addr,
> > >  	pmd_t pmdval = pmdp_get(pmd);
> > >  
> > >  	/* If huge return >0 so we abort the operation + zap. */
> > > -	return pmd_trans_huge(pmdval) || pmd_devmap(pmdval);
> > > +	return pmd_trans_huge(pmdval);
> > >  }
> > >  
> > >  static int guard_install_pte_entry(pte_t *pte, unsigned long addr,
> > > @@ -1183,7 +1183,7 @@ static int guard_remove_pud_entry(pud_t *pud, unsigned long addr,
> > >  	pud_t pudval = pudp_get(pud);
> > >  
> > >  	/* If huge, cannot have guard pages present, so no-op - skip. */
> > > -	if (pud_trans_huge(pudval) || pud_devmap(pudval))
> > > +	if (pud_trans_huge(pudval))
> > >  		walk->action = ACTION_CONTINUE;
> > >  
> > >  	return 0;
> > > @@ -1195,7 +1195,7 @@ static int guard_remove_pmd_entry(pmd_t *pmd, unsigned long addr,
> > >  	pmd_t pmdval = pmdp_get(pmd);
> > >  
> > >  	/* If huge, cannot have guard pages present, so no-op - skip. */
> > > -	if (pmd_trans_huge(pmdval) || pmd_devmap(pmdval))
> > > +	if (pmd_trans_huge(pmdval))
> > >  		walk->action = ACTION_CONTINUE;
> > >  
> > >  	return 0;
> > > -- 
> > > git-series 0.9.1
> > > 
> 

