Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 989473FF043
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Sep 2021 17:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345849AbhIBPeK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Sep 2021 11:34:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:57312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234465AbhIBPeI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Sep 2021 11:34:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 52A8E610CD;
        Thu,  2 Sep 2021 15:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630596790;
        bh=WwYdTWP6eNm+J5Il2EKANSs5L/HmsnHp5e3hmUJfBUg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A4dHS+sw0sVgMoOs4ab8XO8E1JWv1xdOpnvBUhIGkzrIgp/Vrxy8AO6lFMvOdJ2VN
         uqUDpGALQTD51UZivGlUovONCe/bL16WwCOMEV6oyDeX9ob3pjohfGLQIriwHVw3zC
         astHWlG++5QQnQXWEQlUvZ+6xlZKULakXzuDEhFuOxoBdyjOPqwbbc/p6sov2ZeGmg
         PoG/UScH30YwdA/4XhG1Ql2uG90sufLtmm1Ec58x1ugVLt5nt26uF4Aw8EnMxnPKzB
         nmiGnXdbovq9NWIZDPZ6glaw8XaC46cjuXICGx58o/YbdKxhNkKQ3P8cfE62Z32Et1
         VgnrIt3Y2sBjQ==
Date:   Thu, 2 Sep 2021 08:33:09 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Shiyang Ruan <ruansy.fnst@fujitsu.com>, linux-xfs@vger.kernel.org,
        dan.j.williams@intel.com, david@fromorbit.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        nvdimm@lists.linux.dev, rgoldwyn@suse.de, viro@zeniv.linux.org.uk,
        willy@infradead.org
Subject: Re: [PATCH v8 6/7] xfs: support CoW in fsdax mode
Message-ID: <20210902153309.GB9892@magnolia>
References: <20210829122517.1648171-1-ruansy.fnst@fujitsu.com>
 <20210829122517.1648171-7-ruansy.fnst@fujitsu.com>
 <20210902074308.GE13867@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210902074308.GE13867@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 02, 2021 at 09:43:08AM +0200, Christoph Hellwig wrote:
> On Sun, Aug 29, 2021 at 08:25:16PM +0800, Shiyang Ruan wrote:
> > In fsdax mode, WRITE and ZERO on a shared extent need CoW performed.
> > After that, new allocated extents needs to be remapped to the file.  Add
> > an implementation of ->iomap_end() for dax write ops to do the remapping
> > work.
> 
> Please split the new dax infrastructure from the XFS changes.
> 
> >  static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
> > -			       int *iomap_errp, const struct iomap_ops *ops)
> > +		int *iomap_errp, const struct iomap_ops *ops)
> >  {
> >  	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
> >  	XA_STATE(xas, &mapping->i_pages, vmf->pgoff);
> > @@ -1631,7 +1664,7 @@ static bool dax_fault_check_fallback(struct vm_fault *vmf, struct xa_state *xas,
> >  }
> >  
> >  static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
> > -			       const struct iomap_ops *ops)
> > +		const struct iomap_ops *ops)
> 
> These looks like unrelated whitespace changes.
> 
> > -static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
> > +loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
> >  {
> >  	const struct iomap *iomap = &iter->iomap;
> >  	const struct iomap *srcmap = iomap_iter_srcmap(iter);
> > @@ -918,6 +918,7 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
> >  
> >  	return written;
> >  }
> > +EXPORT_SYMBOL_GPL(iomap_zero_iter);
> 
> I don't see why this would have to be exported.
> 
> > +	unsigned 		flags,
> > +	struct iomap 		*iomap)
> > +{
> > +	int			error = 0;
> > +	struct xfs_inode	*ip = XFS_I(inode);
> > +	bool			cow = xfs_is_cow_inode(ip);
> 
> The cow variable is only used once, so I think we can drop it.
> 
> > +	const struct iomap_iter *iter =
> > +				container_of(iomap, typeof(*iter), iomap);
> 
> Please comment this as it is a little unusual.
> 
> > +
> > +	if (cow) {
> > +		if (iter->processed <= 0)
> > +			xfs_reflink_cancel_cow_range(ip, pos, length, true);
> > +		else
> > +			error = xfs_reflink_end_cow(ip, pos, iter->processed);
> > +	}
> > +	return error ?: iter->processed;
> 
> The ->iomap_end convention is to return 0 or a negative error code.
> Also i'd much prefer to just spell this out in a normal sequential way:
> 
> 	if (!xfs_is_cow_inode(ip))
> 		return 0;
> 
> 	if (iter->processed <= 0) {
> 		xfs_reflink_cancel_cow_range(ip, pos, length, true);
> 		return 0;
> 	}
> 
> 	return xfs_reflink_end_cow(ip, pos, iter->processed);

Seeing as written either contains iter->processed if it's positive, or
zero if nothing got written or there were errors, I wonder why this
isn't just:

	if (!xfs_is_cow_inode(ip));
		return 0;

	if (!written) {
		xfs_reflink_cancel_cow_range(ip, pos, length, true);
		return 0;
	}

	return xfs_reflink_end_cow(ip, pos, written);

? (He says while cleaning up trying to leave for vacation, pardon me
if this comment is totally boneheaded...)

--D

> > +static inline int
> > +xfs_iomap_zero_range(
> > +	struct xfs_inode	*ip,
> > +	loff_t			pos,
> > +	loff_t			len,
> > +	bool			*did_zero)
> > +{
> > +	struct inode		*inode = VFS_I(ip);
> > +
> > +	return IS_DAX(inode)
> > +			? dax_iomap_zero_range(inode, pos, len, did_zero,
> > +					       &xfs_dax_write_iomap_ops)
> > +			: iomap_zero_range(inode, pos, len, did_zero,
> > +					       &xfs_buffered_write_iomap_ops);
> > +}
> 
> 	if (IS_DAX(inode))
> 		return dax_iomap_zero_range(inode, pos, len, did_zero,
> 					    &xfs_dax_write_iomap_ops);
> 	return iomap_zero_range(inode, pos, len, did_zero,
> 				&xfs_buffered_write_iomap_ops);
> 
> > +static inline int
> > +xfs_iomap_truncate_page(
> > +	struct xfs_inode	*ip,
> > +	loff_t			pos,
> > +	bool			*did_zero)
> > +{
> > +	struct inode		*inode = VFS_I(ip);
> > +
> > +	return IS_DAX(inode)
> > +			? dax_iomap_truncate_page(inode, pos, did_zero,
> > +					       &xfs_dax_write_iomap_ops)
> > +			: iomap_truncate_page(inode, pos, did_zero,
> > +					       &xfs_buffered_write_iomap_ops);
> > +}
> 
> Same here.
