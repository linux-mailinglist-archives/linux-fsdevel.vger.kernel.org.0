Return-Path: <linux-fsdevel+bounces-59507-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A39CB3A386
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 17:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0896D16A43C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 15:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B24250BF2;
	Thu, 28 Aug 2025 15:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MGfNUHJt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8784222577
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 15:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756393302; cv=none; b=seCYAZQjzMyM18OstiEeEvpHGRMN8IRiWjvxQZslMfSUm1OZLXh0LFgayr1vIEcHoUU/4XOvD4YEtLr6waekGSi96MPXHVlX7UMS4JKj/LAihGGHpFBS/VXPUgX2k1Oopaa09lphEjGJTzXFT7tHhQRkVH0+RswfzyERsur9Up0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756393302; c=relaxed/simple;
	bh=jiCO4EpiHg5C8h6mfG01FjOaiu7OVUBHjPIOhZBOHPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fxlnnr/6R5RyxBvKhpst0I6qmHBuv/lMBhJfmc6y8pDJEuR/eJlf362IBVlpyXQ0mWM5ikDn8u7+PXAlG0YuQDVfmOkwFuIgW/0ybDkvohgTZ31/KCF46/jHIUQ8HmPtSjlzWpreeMSYFxZu2Je+PrmDcLcpypgNBiFejLjGj0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MGfNUHJt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57B08C4CEEB;
	Thu, 28 Aug 2025 15:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756393302;
	bh=jiCO4EpiHg5C8h6mfG01FjOaiu7OVUBHjPIOhZBOHPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MGfNUHJtnc80lKXvLTuBgOS3H0PsZWQIl5MHyCRS0naMAfHvwzfNpbjH1Y0W8swZZ
	 omJN7uyyB4PQ6mQcFCxrK6q5OhVbIt6zS8+hR/lF/r/faKuskBr3l+hOV6rNBE8iUG
	 CZOzeWRgjauZ/SHwBhK6UKekNEK3HahVOErvnegEdD6ZAoa1PghNuGa4bvJZURCOEs
	 xQzifWxwbWBlXtnYKzHjhzMxvHa+pFxxCFsIz80w7l2Cbj/kCOUMk3oRhB3zY6jHph
	 xLkRgZ1mt5PdoiGAdrXFKTZaV8NyONE2dgUySJ9e/u5l7tQtzmHICnoAMvLPzqyxCu
	 8UkIDaArtbZ9g==
Date: Thu, 28 Aug 2025 08:01:41 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>, synarete@gmail.com,
	Bernd Schubert <bernd@bsbernd.com>, neal@gompa.dev, John@groves.net,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 7/7] fuse: enable FUSE_SYNCFS for all servers
Message-ID: <20250828150141.GG8117@frogsfrogsfrogs>
References: <CAJnrk1Z3JpJM-hO7Hw9_KUN26PHLnoYdiw1BBNMTfwPGJKFiZQ@mail.gmail.com>
 <20250821222811.GQ7981@frogsfrogsfrogs>
 <851a012d-3f92-4f9d-8fa5-a57ce0ff9acc@bsbernd.com>
 <CAL_uBtfa-+oG9zd-eJmTAyfL-usqe+AXv15usunYdL1LvCHeoA@mail.gmail.com>
 <CAJnrk1aoZbfRGk+uhWsgq2q+0+GR2kCLpvNJUwV4YRj4089SEg@mail.gmail.com>
 <20250826193154.GE19809@frogsfrogsfrogs>
 <CAJnrk1YMLTPYFzTkc_w-5wkc-BXUrFezXcU-jM0mHg1LeJrZeA@mail.gmail.com>
 <CAJfpegsRw3kSbJU7-OS7XS3xPTRvgAi+J_twMUFQQA661bM9zA@mail.gmail.com>
 <20250827191238.GC8117@frogsfrogsfrogs>
 <CAJfpegu5n=Y58TXCWDG3gw87BnjOmHzSHs3PSLisA8VqV+Y-Fw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegu5n=Y58TXCWDG3gw87BnjOmHzSHs3PSLisA8VqV+Y-Fw@mail.gmail.com>

On Thu, Aug 28, 2025 at 04:08:19PM +0200, Miklos Szeredi wrote:
> On Wed, 27 Aug 2025 at 21:12, Darrick J. Wong <djwong@kernel.org> wrote:
> 
> > Well sync() will poke all the fuse filesystems, right?
> 
> Only those with writeback_cache enabled.  But yeah, apparently this
> was overlooked when dealing with "don't allow DoS-ing sync(2)".
> 
> Can't see a good way out of this.

I wonder, is it possible to shift a fuse_simple_request to behave like a
fuse_simple_background request?  For certain DOS-happy requests, one
could use wait_event_interruptible_timeout(&req->waitq...) with a really
high timeout.

If the wait times out, we shift the completion to asynchronous and
return -ETIMEDOUT to the (blocked) caller.  That would allow the system
to make progress though you'd probably have to take some drastic action
if the fuse server sends back a failure (e.g. setting FUSE_I_BAD).

(The problem with timeouts is that I tried setting a 60s timeout on
fuse2fs and discovered that certain horrid fstests actually create
monster files that take 45min to FUSE_RELEASE and so I don't know what a
reasonable timeout is...)

--D

> Thanks,
> Miklos

