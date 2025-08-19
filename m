Return-Path: <linux-fsdevel+bounces-58348-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 592CCB2CF86
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 00:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1730E72462B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 22:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC86123AE95;
	Tue, 19 Aug 2025 22:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XAKsCjoh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16450238C1E
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Aug 2025 22:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755643888; cv=none; b=coCp8DzRMpzvUVQhQ0EDRiHZ91CGC3rukcJcHAk+lziePtE1xC0frgCk7vEp7QcSzFxBBFaS4h0M++gUMHohkLEmF62Kbplvwh6gTk6HBF0OlhgCxntZC+jAb/Zzi348kNlsyX/3PdiWjQAH2u2N0WyXKhVZ5y/Ss2NwPpIoXbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755643888; c=relaxed/simple;
	bh=0EhGywHsxcMRBt+wOZgf8QuCfFuIsG8HUBKxaLb9qmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c/UjvheK+DppAWZQGd/0YOQ1Hk3gfEJuX3YAa/e3SxiTeV3cxXiztCcvCg/yS2iZarUbRb0o9hrms6E1gAVTf0/7pwiEkyIJjjURhiwIfjXcARR2X4hT5Oz2xPWU07SjNruqpN46Ulh8Mizwar57upa/X6zZ0Fy9iE8r/9eW+LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XAKsCjoh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9380EC4CEF1;
	Tue, 19 Aug 2025 22:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755643887;
	bh=0EhGywHsxcMRBt+wOZgf8QuCfFuIsG8HUBKxaLb9qmw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XAKsCjohZHsLCHH2e+L38HlCb9oGaRuF7uvHPicAAf6cauQ8fIhOG9Q+crDf2Z5tu
	 ffOpSkXQFTCtuNHXHIQqUCvrZr8Lpgs2j7I96zTW4buatL6wn3n4r3v0RP+ih2KiON
	 bfS/VTuoQ0ch9cNFjIGJjOphRMkSJZ8LKd8KLeFwazG/1R5NFV5zSDCP7NGm7OwNcE
	 +u8AJHRP/GwEG1OEbMXbE4cYOYz/3wIlo2+7vssJlh9/RFvLpjli5Ghq7oldWr5Cnh
	 9nNUHa/goeQdyZyHUthpuK5oCKL/MKCvA3bwf7h5I6nLfJtXj0DQRStVCxOi930pdr
	 CGvUNDI9nBOUg==
Date: Tue, 19 Aug 2025 15:51:27 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, John@groves.net,
	bernd@bsbernd.com, joannelkoong@gmail.com
Subject: Re: [PATCH 4/7] fuse: implement file attributes mask for statx
Message-ID: <20250819225127.GI7981@frogsfrogsfrogs>
References: <175279449418.710975.17923641852675480305.stgit@frogsfrogsfrogs>
 <175279449542.710975.4026114067817403606.stgit@frogsfrogsfrogs>
 <CAJfpegvwGw_y1rXZtmMf_8xJ9S6D7OUeN7YK-RU5mSaOtMciqA@mail.gmail.com>
 <20250818200155.GA7942@frogsfrogsfrogs>
 <CAJfpegtC4Ry0FeZb_13DJuTWWezFuqR=B8s=Y7GogLLj-=k4Sg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegtC4Ry0FeZb_13DJuTWWezFuqR=B8s=Y7GogLLj-=k4Sg@mail.gmail.com>

On Tue, Aug 19, 2025 at 05:01:15PM +0200, Miklos Szeredi wrote:
> On Mon, 18 Aug 2025 at 22:01, Darrick J. Wong <djwong@kernel.org> wrote:
> 
> > In theory only specialty programs are going to be interested in directio
> > or atomic writes, and only userspace nfs servers and backup programs are
> > going to care about subvolumes, so I don't know if it's really worth the
> > trouble to cache all that.
> >
> > The dio/atomic fields are 7x u32, and the subvol id is u64.  That's 40
> > bytes per inode, which is kind of a lot.
> 
> Agreed.  This should also depend on the sync mode.
> 
> AT_STATX_DONT_SYNC: anything not cached should be cleared from the mask.
> 
> AT_STATX_FORCE_SYNC: cached values should be ignored and FUSE_STATX
> request sent.

IMO, if the caller asks for the weird statx attributes
(dioalign/subvol/write_atomic) then they probably prefer to wait to get
the attributes they asked for.  I'd be willing to strip them out of the
request_mask if they affirm _DONT_SYNC though.

Something like this, maybe?

#define FUSE_UNCACHED_STATX_MASK	(STATX_DIOALIGN | \
					 STATX_SUBVOL | \
					 STATX_WRITE_ATOMIC)

and then in fuse_update_get_attr,

	if (!request_mask)
		sync = false;
	else if (request_mask & FUSE_UNCACHED_STATX_MASK) {
		if (flags & AT_STATX_DONT_SYNC) {
			request_mask &= ~FUSE_UNCACHED_STATX_MASK;
			sync = false;
		} else {
			sync = true;
		}
	} else if (flags & AT_STATX_FORCE_SYNC)
		sync = true;
	else if (flags & AT_STATX_DONT_SYNC)
		sync = false;
	else if (request_mask & inval_mask & ~cache_mask)
		sync = true;
	else
		sync = time_before64(fi->i_time, get_jiffies_64());

> AT_STATX_SYNC_AS_STAT: ???

I have no idea what that means. :)

Way back in 2017, dhowells implied that it synchronises the attributes
with the backing store in the same way that network filesystems do[1].
But the question is, does fuse count as a network fs?

I guess it does.  But the discussion from 2016 also provided "this is
very filesystem specific" so I guess we can do whatever we want??  XFS
and ext4 ignore that value.  The statx(2) manpage repeats that "whatever
stat does" language, but the stat(2) and stat(3) manpages don't say a
darned thing.

I was just gonna ignore it.

[1] https://lore.kernel.org/linux-fsdevel/147948603812.5122.5116851833739815967.stgit@warthog.procyon.org.uk/

--D

> Thanks,
> Miklos
> 

