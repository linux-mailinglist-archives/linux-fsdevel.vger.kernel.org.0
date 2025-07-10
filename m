Return-Path: <linux-fsdevel+bounces-54479-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4945B00121
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 14:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C295E5479ED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 12:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1699D23C4F4;
	Thu, 10 Jul 2025 12:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rp0OuMT3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D777207E1D;
	Thu, 10 Jul 2025 12:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752148992; cv=none; b=cTmPaX/IOQ2IDzw8j0QA2HSCTVBCdhHM002SaoEfn33a8X/roi9fzttIN9ElCGamA3zWhTz5CvmIgBCWx4px0PZfQBwRgmmmcBln0Ex8+LRaUyAPH12uFQ8asv9BaaXhNbWDWrd98VO50U994fdf/bH0HvHb0qqmz3zAlzCl/UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752148992; c=relaxed/simple;
	bh=nNuCjhsowYZ2SHuy8Ny1SbnsiGlGf5snyfLqhxn2Y70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O7XxI+Qzh+IGmFLhpqNCbvTLHnhtoFnc5XmhPPK0NJyj+NBROHzRYNguJNCg1dmhr8lzUNszuPUE7F2gCDGS4GZJMCnn6mhXAJewX5Fb+lOuyZpemCyxVIAwYlGhoLV2WK+b5pHqFTvf0SrnVjT04J8Nk1KVV9sgeCkvuTHcrD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rp0OuMT3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5C38C4CEE3;
	Thu, 10 Jul 2025 12:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752148991;
	bh=nNuCjhsowYZ2SHuy8Ny1SbnsiGlGf5snyfLqhxn2Y70=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rp0OuMT39W/H3+xYP3yeAlYFYNHp6/AF3JW+ePVoPW0RXpVi9ONwDZZgClcj3qcWf
	 6fXkHh44kAF8RJhdwqGQIdcpr0gw2/7TSqXv/BaYQXipLJHK53wWl4IC9pHMnX135m
	 9/hTN+1JwHm/ySfW16d6Olxdxk2P/JMaIEY5aQO6n03RE1ZTHd1A3lRR+VL87FJgo/
	 Uqemk6OZPkG85s+nzJLZoF4hV0tTA+60bzEp/GyL3zvMKUVnTHfPsQHG9/94I3j8J2
	 DZvToVcsvLBHhUtUqAGSL7Y/6fVciRGbZ0n6LERKZD1Rym2d3RyLjgPW1ulzrw40Pl
	 hiu+vJG2zeQ3g==
Date: Thu, 10 Jul 2025 14:03:05 +0200
From: Christian Brauner <brauner@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, Anuj Gupta <anuj20.g@samsung.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Kanchan Joshi <joshi.k@samsung.com>, 
	LTP List <ltp@lists.linux.it>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Benjamin Copeland <benjamin.copeland@linaro.org>, rbm@suse.com, Naresh Kamboju <naresh.kamboju@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, Alexey Dobriyan <adobriyan@gmail.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, Eric Biggers <ebiggers@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: fix FS_IOC_GETLBMD_CAP parsing in
 blkdev_common_ioctl()
Message-ID: <20250710-geber-keimen-40cdd4bf17f7@brauner>
References: <20250709181030.236190-1-arnd@kernel.org>
 <20250710-passen-petersilie-32f6f1e9a1fc@brauner>
 <d2e1d4a9-d475-43e3-824b-579e5084aaf3@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d2e1d4a9-d475-43e3-824b-579e5084aaf3@app.fastmail.com>

On Thu, Jul 10, 2025 at 12:11:12PM +0200, Arnd Bergmann wrote:
> On Thu, Jul 10, 2025, at 10:00, Christian Brauner wrote:
> > On Wed, Jul 09, 2025 at 08:10:14PM +0200, Arnd Bergmann wrote:
> 
> >> +	if (_IOC_DIR(cmd)  == _IOC_DIR(FS_IOC_GETLBMD_CAP) &&
> >> +	    _IOC_TYPE(cmd) == _IOC_TYPE(FS_IOC_GETLBMD_CAP) &&
> >> +	    _IOC_NR(cmd)   == _IOC_NR(FS_IOC_GETLBMD_CAP) &&
> >> +	    _IOC_SIZE(cmd) >= LBMD_SIZE_VER0 &&
> >> +	    _IOC_SIZE(cmd) <= _IOC_SIZE(FS_IOC_GETLBMD_CAP))
> >
> > This part is wrong as we handle larger sizes just fine via
> > copy_struct_{from,to}_user().
> 
> I feel that is still an open question. As I understand it,
> you want to make it slightly easier for userspace callers
> to use future versions of an ioctl command by allowing them in
> old kernels as well, by moving that complexity into the kernel.
> 
> Checking against _IOC_SIZE(FS_IOC_GETLBMD_CAP) would keep the
> behavior consistent with the traditional model where userspace
> needs to have a fallback to previous ABI versions.
> 
> > Arnd, objections to writing it as follows?:
> 
> > +       /* extensible ioctls */
> > +       switch (_IOC_NR(cmd)) {
> > +       case _IOC_NR(FS_IOC_GETLBMD_CAP):
> > +               if (_IOC_DIR(cmd) != _IOC_DIR(FS_IOC_GETLBMD_CAP))
> > +                       break;
> > +               if (_IOC_TYPE(cmd) != _IOC_TYPE(FS_IOC_GETLBMD_CAP))
> > +                       break;
> > +               if (_IOC_NR(cmd) != _IOC_NR(FS_IOC_GETLBMD_CAP))
> > +                       break;
> > +               if (_IOC_SIZE(cmd) < LBMD_SIZE_VER0)
> > +                       break;
> > +               if (_IOC_SIZE(cmd) > PAGE_SIZE)
> > +                       break;
> > +               return blk_get_meta_cap(bdev, cmd, argp);
> 
> The 'PAGE_SIZE' seems arbitrary here, especially since that is often

I used that as an illustration since we're capping nearly all (regular)
uapi structures at that as a somewhat reasonable upper bound. If that's
smaller that's fine.

> larger than the maximum size that can be encoded in an ioctl command
> number (8KB or 16KB depending on the architecture). If we do need
> an upper bound larger than _IOC_SIZE(FS_IOC_GETLBMD_CAP), I think it
> should be a fixed number rather than a configuration dependent
> one, and I would prefer a smaller one over a larger one. Anything

Sure, fine by me.

> over a few dozen bytes is certainly suspicious, and once it gets
> to thousands of bytes, you need a dynamic allocation to avoid stack
> overflow in the kernel.

Sure, we do that already in some cases because we have use-cases for
that.

> 
> I had already updated my patch to move the checks into
> blk_get_meta_cap() itself and keep the caller simpler:

Ok.

> Regardless of what upper bound we pick, that at least limits
> the complexity to the one function that actually wants it.

Ok.

> 
> > And can I ask you to please take a look at fs/pidfs.c:pidfd_ioctl() and
> 
> PIDFD_GET_INFO has part of the same problem, as it still fails to
> check the _IOC_DIR() bits. I see you added a check for _IOC_TYPE()
> in commit 091ee63e36e8 ("pidfs: improve ioctl handling"), but
> the comment you added describes an unrelated issue and the fix
> was incomplete.
> 
> > fs/nsfs.c:ns_ioctl()?
> 
> You tried to add a similar validation in commit 7fd511f8c911
> ("nsfs: validate ioctls"), but it seems you got that wrong
> both by missing the _IOC_DIR check and by having a typo in the
> '_IOC_TYPE(cmd) == _IOC_TYPE(cmd)' line that means this is
> always true rather than comparing against 'NSIO'.
> 
> Overall my feeling is similar to Christoph's, that the added
> complexity in any of these three cases was a mistake, as it's
> too easy to mess it up.

For pidfs and nsfs it will definitely be the way we're doing it.
Especially with structures we definitely want to grow. I have zero
interest in spamming userspace with either a fragmented set of 100
ioctls that never give consistent information because they need to be
called in sequence nor constantly revised V2-100 ioctl commands that all
use a new structure with a fixed layout.

The fact that the ioctl api currently lacks validation is more testament
to how unspecified the requirements for ioctls and their encoding are
and we better fix that in general because like it or not we already have
quite a few size-versioned ioctls anyway. This is nothing we cannot fix.

Tell me what work you need and we'll do it.

The alternative I see is that I will start being very liberal in adding
extensible system calls for stuff such as pidfd_info() and ns_info()
instead of making them ioctls on the file where they belong.

