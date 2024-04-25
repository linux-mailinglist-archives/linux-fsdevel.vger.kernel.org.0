Return-Path: <linux-fsdevel+bounces-17842-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 542A78B2D1D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 00:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5716282FDF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 22:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6687015623B;
	Thu, 25 Apr 2024 22:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="GSh0/5Vz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33888155A5F;
	Thu, 25 Apr 2024 22:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714084144; cv=none; b=nTFMTIHKFiTVyuFGu/Q1ejRyIE/wkZZZD3qYBtEk7QO+3+u//SuveKe2RIzgqwFCUqnz2YPMtrQfEqRu/cuDYfLnrPnD/egIlNQMp54HE0i5OKrkPZ52Gpy9/t5JEFzy4LpXOxWh/3dqWadVQcJFrhnxA+cXmIVBOcbf5FmGljs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714084144; c=relaxed/simple;
	bh=fBJwJYiBaEhmff57XzUWO/n19/eyA8WODLPB9QbUvB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=swLFdyeQm6C5fj9PWyXnraXg9yPPbleOQPfbuDEZGqAV9yIH27hEJrfS5CkqBIONLxZ3VF4RP23gOEXbceVZynBH5L47WQR6ATPc8LqXD8i/gte1sJMe/NXs0GhjE2//nOm85/Vh5NGLuzFJ0j6mykM4NEVIhv7EV2RoWSVi/kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=GSh0/5Vz; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WEgjr4Rcl64k18v1qz1W+I3b2O+nggXutvnRPdAOVB4=; b=GSh0/5VzSseJJ5h3UtPAQkjiSG
	85X0s5NegfwpkX6FPnxiOV1A3UxbqlRhW2ldBLPKHYkKvZqYoJoFQR8ltK5p6UQPoQejW6wb5WVps
	RFnbKZVX+0JWvt5vg7XE70CmNCQXMCVerCvucMKyTnZUUeM/yAaH4FserradrZe3gNq0y7Xri/9Ux
	QvLqcbD4Wt6VS6fUoDIn/BtgayfWOakl3FXGdzoIBqszDHCyW3y15pmBUWPb75bVAuwaxXsYRjKh4
	dBHx9iQwNZBBaaJt2DH8sQJN2f4MFX5fMMCX52krR9H3L2p7OomLjbb4IPETT9B3foM4P7UXlscKx
	fbtMPC8g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s07aB-004Q1a-09;
	Thu, 25 Apr 2024 22:28:47 +0000
Date: Thu, 25 Apr 2024 23:28:47 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, jack@suse.cz, hch@lst.de,
	brauner@kernel.org, axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH vfs.all 08/26] erofs: prevent direct access of bd_inode
Message-ID: <20240425222847.GN2118490@ZenIV>
References: <20240406090930.2252838-1-yukuai1@huaweicloud.com>
 <20240406090930.2252838-9-yukuai1@huaweicloud.com>
 <20240407040531.GA1791215@ZenIV>
 <a660a238-2b7e-423f-b5aa-6f5777259f4d@linux.alibaba.com>
 <20240425195641.GJ2118490@ZenIV>
 <20240425200846.GK2118490@ZenIV>
 <22fccbef-1cf2-4579-a015-936f5ef40782@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22fccbef-1cf2-4579-a015-936f5ef40782@linux.alibaba.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Apr 26, 2024 at 05:56:52AM +0800, Gao Xiang wrote:
> Hi Al,
> 
> On 2024/4/26 04:08, Al Viro wrote:
> > On Thu, Apr 25, 2024 at 08:56:41PM +0100, Al Viro wrote:
> > 
> > > FWIW, see #misc.erofs and #more.erofs in my tree; the former is the
> > > minimal conversion of erofs_read_buf() and switch from buf->inode
> > > to buf->mapping, the latter follows that up with massage for
> > > erofs_read_metabuf().
> > 
> > First two and last four patches resp.  BTW, what are the intended rules
> > for inline symlinks?  "Should fit within the same block as the last
> 
> symlink on-disk layout follows the same rule of regular files.  The last
> logical block can be inlined right after the on-disk inode (called tail
> packing inline) or use a separate fs block to keep the symlink if tail
> packing inline doesn't fit.
> 
> > byte of on-disk erofs_inode_{compact,extended}"?  Feels like
> > erofs_read_inode() might be better off if it did copying the symlink
> > body instead of leaving it to erofs_fill_symlink(), complete with
> > the sanity checks...  I'd left that logics alone, though - I'm nowhere
> > near familiar enough with erofs layout.
> If I understand correctly, do you mean just fold erofs_fill_symlink()
> into the caller?  That is fine with me, I can change this in the
> future.

It's just that the calling conventions of erofs_read_inode() feel wrong ;-/
We return a pointer and offset, with (ERR_PTR(...), anything) used to
indicate an error and (pointer into page, offset) used (in case of
fast symlinks and only in case of fast symlinks) to encode the address
of symlink body, with data starting at pointer + offset + vi->xattr_isize
and length being ->i_size, no greater than block size - offset - vi->xattr_size.

If anything, it would be easier to follow (and document) if you had
allocated and filled the symlink body right there in erofs_read_inode().
That way you could lift erofs_put_metabuf() call into erofs_read_inode(),
along with the variable itself.

Perhaps something like void *erofs_read_inode(inode) with
	ERR_PTR(-E...) => error
	NULL => success, not a fast symlink
	pointer to string => success, a fast symlink, body allocated and returned
to caller.

Or, for that matter, have it return an int and stuff the body into ->i_link -
it's just that you'd need to set ->i_op there with such approach.

Not sure, really.  BTW, one comment about erofs_fill_symlink() - it's probably
a good idea to use kmemdup_nul() rather than open-coding it (and do that after
the block overflow check, obviously).

