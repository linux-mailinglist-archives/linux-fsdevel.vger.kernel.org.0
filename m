Return-Path: <linux-fsdevel+bounces-59439-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53027B38AF0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 22:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A63C1C23770
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 20:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304712F290E;
	Wed, 27 Aug 2025 20:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nOkCDv5q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BC92F067F
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 20:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756326418; cv=none; b=VYd+SU/9ntCI/4MAuzkE3J8qDkYjbuf+cZbclnb7ZIDUsm8/q7D+j1aV+5a6NtJB/OtZwzMsXLVYqzaMSBjuHCtlEQkaTKXONLkK6KiabckpSdEk0H3cjCOdrEB/uI5CH7ASQNPPB12oSXeFzu7N4L+UhsmXDiYu6pE98btHajU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756326418; c=relaxed/simple;
	bh=9lUKiCZ1Iqcl3faWoAm3hSX3QhsBxisOdnhvr4M94Do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qtbJbLEc3z4Qy5mps+itwtc9K+6YdCSufagbWT+WkJTuYSCZ7h+n/C0+vX5pX85rUG4m3sNu+GEQldQyYZnsXCSYXRqW8qlT5MG5/ClFmbGlNUtg5THizq6P9CsAhBIvlA9GKLma4DVv80lWKEhBJns+i2pQtHsbv8arF9llKKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nOkCDv5q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5C0BC4CEEB;
	Wed, 27 Aug 2025 20:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756326417;
	bh=9lUKiCZ1Iqcl3faWoAm3hSX3QhsBxisOdnhvr4M94Do=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nOkCDv5q2EjU3FWV9mo9pgjpIq58RdFdZvecuD3JYCTHXUP1iIGb11u9hYX5LyvbK
	 qhEo2A89AtdMicfBKNIZyQ4YxpOCSK8FRGQsUt+da9PiuxL6Wo+vX+yigH+TXpDqab
	 vjwq1q2Bw8g5NYFimLCqAG6yN+Jnv0lYbCOeD9xuVaJ2IeF5lP1+Qoe+zNDoXRHk2L
	 KaSvvoo+N3KS3c0rVgwZxuBoTHM2GMqlUfHDPHe7R58z1gatH00bFkVVKkv2SLWFVt
	 VcJTkKGxlXSNtM2aaw+YXl4XlSG/7OnTuMAcuOFqRZvpkMsU0szpRHLqPtqz5S4+OA
	 F4pkFxRKfWtKQ==
Date: Wed, 27 Aug 2025 13:26:57 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org,
	Joanne Koong <joannelkoong@gmail.com>,
	John Groves <John@groves.net>, Bernd Schubert <bernd@bsbernd.com>
Subject: Re: [PATCH v2] fuse: allow synchronous FUSE_INIT
Message-ID: <20250827202657.GD8117@frogsfrogsfrogs>
References: <20250827110004.584582-1-mszeredi@redhat.com>
 <20250827190215.GB8117@frogsfrogsfrogs>
 <CAJfpegsuWpexXDZF7Fqw71c36nMSpUwXXpcru7GmYDjXSuZx8w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegsuWpexXDZF7Fqw71c36nMSpUwXXpcru7GmYDjXSuZx8w@mail.gmail.com>

On Wed, Aug 27, 2025 at 09:51:04PM +0200, Miklos Szeredi wrote:
> On Wed, 27 Aug 2025 at 21:02, Darrick J. Wong <djwong@kernel.org> wrote:
> 
> > IOWs, would you be willing to rename this to FUSE_DEV_IOC_SET_FEATURE
> > and take a u32 code?  Then programs with an open /dev/fuse fd can
> > incrementally add pieces as required.  The first one would be
> > FUSE_DEV_SYNC_INIT, the second one would be FUSE_DEV_ADD_IOMAP, etc.
> 
> Okay, so this is not a mask, and individual features would need to be
> set with separate ioctl calls, right?
> 
> That would allow negotiating features.

Correct, one feature per ioctl call.

> > > +     return (typeof(fud)) ((unsigned long) fud & FUSE_DEV_PTR_MASK);
> >
> > s/unsigned long/uintptr_t/ here ?
> 
> Okay.
> 
> > If process_init_reply hits the ok==false case and clears fc->conn_init,
> > should this return an error here to abort the mount?
> 
> Yes, fixed.

Cool, thanks!

FWIW when I added the second FUSE_DEV_ mask, I ended up rewiring the
code like this:

#define FUSE_DEV_SYNC_INIT	(1UL << 0)
#define FUSE_DEV_INHERIT_IOMAP	(1UL << 1)
#define FUSE_DEV_FLAGS_MASK	(FUSE_DEV_SYNC_INIT | FUSE_DEV_INHERIT_IOMAP)
#define FUSE_DEV_PTR_MASK	(~FUSE_DEV_FLAGS_MASK)

and adding helpers to take care of all the annoying casts:

static inline void __fuse_set_dev_flags(struct file *file, uintptr_t flag)
{
	uintptr_t old_flags =
		(uintptr_t)READ_ONCE(file->private_data) & FUSE_DEV_FLAGS_MASK;

	WRITE_ONCE(file->private_data,
		(struct fuse_dev *)(old_flags | flag));
}

and fuse_fill_super_common ends up looking like this:

	if (ctx->fudptr) {
		uintptr_t raw = (uintptr_t)(*ctx->fudptr);
		uintptr_t flags = raw & FUSE_DEV_FLAGS_MASK;

		if (raw & FUSE_DEV_PTR_MASK)
			goto err_unlock;
		if (flags & FUSE_DEV_SYNC_INIT)
			fc->sync_init = 1;
		if (flags & FUSE_DEV_INHERIT_IOMAP)
			fc->may_iomap = 1;
	}

--D

> Thanks,
> Miklos

