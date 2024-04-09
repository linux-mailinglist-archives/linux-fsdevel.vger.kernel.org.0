Return-Path: <linux-fsdevel+bounces-16504-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B960F89E66D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 01:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58C511F220C3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 23:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D598A158DD9;
	Tue,  9 Apr 2024 23:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IwD4UZXv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCDA15B10D;
	Tue,  9 Apr 2024 23:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712706621; cv=none; b=Ko4kjSZD+6P9dRYjvmJn3BBpZ3oFkVi/XhY+JBNOmCBYg+f7+OphhSKm6QtRfazaly4sqZytGVdpMo5MPZAJn9t06WNMMcRy7gFFczrd88HT7OKo2u31A26rJM/xCY48Q2JE4b3uvUw4xFAmQnXm8rP6J7PUm1p+Ime/mIgetZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712706621; c=relaxed/simple;
	bh=4yvqkxg7P3mEXrMaTzRewadQn2FdX0cCImxS4aKkHNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tdXcu4zbyr+vzM+7WRkuPgoTrhqbpeRXIHh9q4rdbpW82VwNLBJpCzS9/7VOrpna2qnrAlEtcL2k2NvqkPAwJJ1ctH1Zma7aBDOVzorZZk8iruASN7/DbEm6URze3nHOHLJWm4hSpdSJ705dBqHNA6EqmsYrqGMpSflNXpCX4B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IwD4UZXv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80A85C433F1;
	Tue,  9 Apr 2024 23:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712706620;
	bh=4yvqkxg7P3mEXrMaTzRewadQn2FdX0cCImxS4aKkHNM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IwD4UZXvrai1+2WNagGW37mpRo5DX+XGXIrlTz+Er1RdP8KpMQV5Pk0Cev7lBYNT4
	 0d7lD+Z0gZGIo06aK6w5rIJIXwQvWYg+agygC+j+x+bGMuu7NEDZQ1doCiaA+kT3sf
	 fnS5bo9h9hQ7m8OacWjf59ivhQrfC+TLjbD9/yaR/f5E9RATRg3Pm8FUXBoP1UMOnI
	 ilTYb/0WoV7LGnSY0ZUNMqjvWc6GQUGbDPr6WZ+bk3pX0wcaZXX16xPi1SH3eV41UA
	 Ko72w2FAbBA3Qe8dLtRiIrLW0c+JOmje8N5FOR36VQ8yilm+nzSMya2GxnD1OkBvVC
	 pIWhBING/1k+A==
Date: Tue, 9 Apr 2024 19:50:18 -0400
From: Eric Biggers <ebiggers@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Richard Fung <richardfung@google.com>, linux-fsdevel@vger.kernel.org,
	fsverity@lists.linux.dev
Subject: Re: [PATCH 1/1] fuse: Add initial support for fs-verity
Message-ID: <20240409235018.GC1609@quark.localdomain>
References: <20240328205822.1007338-1-richardfung@google.com>
 <20240328205822.1007338-2-richardfung@google.com>
 <CAJfpegvtUywhs8vse1rZ6E=hnxUS6uo_eii-oHDmWd0hb35jjA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJfpegvtUywhs8vse1rZ6E=hnxUS6uo_eii-oHDmWd0hb35jjA@mail.gmail.com>

On Tue, Apr 09, 2024 at 04:50:10PM +0200, Miklos Szeredi wrote:
> On Thu, 28 Mar 2024 at 21:58, Richard Fung <richardfung@google.com> wrote:
> >
> > This adds support for the FS_IOC_ENABLE_VERITY and FS_IOC_MEASURE_VERITY
> > ioctls. The FS_IOC_READ_VERITY_METADATA is missing but from the
> > documentation, "This is a fairly specialized use case, and most fs-verity
> > users won’t need this ioctl."
> >
> > Signed-off-by: Richard Fung <richardfung@google.com>
> > ---
> >  fs/fuse/ioctl.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 52 insertions(+)
> >
> > diff --git a/fs/fuse/ioctl.c b/fs/fuse/ioctl.c
> > index 726640fa439e..a0e86c3de48f 100644
> > --- a/fs/fuse/ioctl.c
> > +++ b/fs/fuse/ioctl.c
> > @@ -8,6 +8,7 @@
> >  #include <linux/uio.h>
> >  #include <linux/compat.h>
> >  #include <linux/fileattr.h>
> > +#include <linux/fsverity.h>
> >
> >  static ssize_t fuse_send_ioctl(struct fuse_mount *fm, struct fuse_args *args,
> >                                struct fuse_ioctl_out *outarg)
> > @@ -227,6 +228,57 @@ long fuse_do_ioctl(struct file *file, unsigned int cmd, unsigned long arg,
> >                         out_iov = iov;
> >                         out_iovs = 1;
> >                 }
> > +
> > +               /* For fs-verity, determine iov lengths from input */
> > +               switch (cmd) {
> > +               case FS_IOC_MEASURE_VERITY: {
> > +                       __u16 digest_size;
> > +                       struct fsverity_digest __user *uarg =
> > +               (struct fsverity_digest __user *)arg;
> > +
> > +                       if (copy_from_user(&digest_size, &uarg->digest_size,
> > +                                                sizeof(digest_size)))
> > +                               return -EFAULT;
> > +
> > +                       if (digest_size > SIZE_MAX - sizeof(struct fsverity_digest))
> > +                               return -EINVAL;
> > +
> > +                       iov->iov_len = sizeof(struct fsverity_digest) + digest_size;
> > +                       break;
> > +               }
> > +               case FS_IOC_ENABLE_VERITY: {
> > +                       struct fsverity_enable_arg enable;
> > +                       struct fsverity_enable_arg __user *uarg =
> > +               (struct fsverity_enable_arg __user *)arg;
> > +                       const __u32 max_buffer_len = FUSE_MAX_MAX_PAGES * PAGE_SIZE;
> > +
> > +                       if (copy_from_user(&enable, uarg, sizeof(enable)))
> > +                               return -EFAULT;
> > +
> > +                       if (enable.salt_size > max_buffer_len ||
> > +               enable.sig_size > max_buffer_len)
> > +                               return -ENOMEM;
> > +
> > +                       if (enable.salt_size > 0) {
> > +                               iov++;
> > +                               in_iovs++;
> > +
> > +                               iov->iov_base = u64_to_user_ptr(enable.salt_ptr);
> > +                               iov->iov_len = enable.salt_size;
> > +                       }
> > +
> > +                       if (enable.sig_size > 0) {
> > +                               iov++;
> > +                               in_iovs++;
> > +
> > +                               iov->iov_base = u64_to_user_ptr(enable.sig_ptr);
> > +                               iov->iov_len = enable.sig_size;
> > +                       }
> > +                       break;
> > +               }
> > +               default:
> > +                       break;
> > +               }
> >         }
> >
> >   retry:
> 
> I'm not thrilled by having ioctl specific handling added to the
> generic fuse ioctl code.
> 
> But more important is what  the fsverity folks think (CC's added).
> 

I am fine with having FUSE support passing through FS_IOC_MEASURE_VERITY and
FS_IOC_ENABLE_VERITY.

As you may have noticed, these ioctls are a bit more complex than the simple
ones that FUSE allows already.  The argument to FS_IOC_MEASURE_VERITY has a
variable-length trailing array, and the argument to FS_IOC_ENABLE_VERITY has up
to two pointers to other buffers.

I am hoping the FUSE folks have thoughts on what is the best way to support
ioctls like these.  I suspect that this patch (with the special handling in
FUSE) may be the only feasible approach, but I haven't properly investigated it.

- Eric

