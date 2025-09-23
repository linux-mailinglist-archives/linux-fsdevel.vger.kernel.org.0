Return-Path: <linux-fsdevel+bounces-62511-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82606B9673B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 16:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AE15188612C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 14:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120C8242D83;
	Tue, 23 Sep 2025 14:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c0AxnyUR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3D91DF994;
	Tue, 23 Sep 2025 14:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758639257; cv=none; b=O17uGVsE2zcYcxFI09x3aR+OOu/YzqyMiUmAsmawMRwr7Y2I2l7oMBoxykrplq1Epoh2YKmtxzW9ggDNrIZoCqwREf+sPEvmY8CAy6kdpSB+fwEmmh4929WZl94IIrGv0PaK2iTNXZnK90AjIm68DkK2HF7lB0yaQh7WsM6eck0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758639257; c=relaxed/simple;
	bh=Q+q/KMy8jASqHkieY8zNx1dSC2KdYN3tgLx54rwnG2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EafwL6f8bQCQst3ftiDRvTvsafvuIgwAkW+HyjjiT412paT4GFJJuLbomHBrdhMzSai1pMsJgNFH4JaZ3ajTtbbTb4JYO4uzCsHOQ/QjG062zxB7QSfazkSy4PhtwQxwCbfht5yyR0hy7pdd2ejoW9VL8BMHKY2XkfDpBh57tSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c0AxnyUR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF17C4CEF5;
	Tue, 23 Sep 2025 14:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758639253;
	bh=Q+q/KMy8jASqHkieY8zNx1dSC2KdYN3tgLx54rwnG2g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c0AxnyUREi1rp+dfFiB0QXwcWfBZJ2RunCDtBOqWcBTI9g5f2u3iL95mtLPCe0xHb
	 4BnDEeYbtXJq2kFtf8wYLcMTU077KMgVopK3t98hWVBUNnDJCIzAhbHErhblMsSGr3
	 PRMSX0XhvSUn6sKd13rCWsgxNAX0pYeDNbHbHFYB96iWz/XGNa37MTqH4/6khpbP/k
	 t5D5Sm7OAwZewNHfmHSiGdsOmbYSBWgcUiPbIWh+CkcAkPWkPZT35h7XphCaqWwZMY
	 KZL25kobDVBI1EYjq7uk6KvQh4qO5LGOkgW+FuWfHN0RNMnxJojGV1vBkFo+NwJ6WT
	 iQ1EyELPMWeQg==
Date: Tue, 23 Sep 2025 07:54:13 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: bernd@bsbernd.com, linux-xfs@vger.kernel.org, John@groves.net,
	linux-fsdevel@vger.kernel.org, neal@gompa.dev,
	joannelkoong@gmail.com
Subject: Re: [PATCH 2/8] fuse: flush pending fuse events before aborting the
 connection
Message-ID: <20250923145413.GH8117@frogsfrogsfrogs>
References: <175798149979.381990.14913079500562122255.stgit@frogsfrogsfrogs>
 <175798150070.381990.9068347413538134501.stgit@frogsfrogsfrogs>
 <CAJfpegtW++UjUioZA3XqU3pXBs29ewoUOVys732jsusMo2GBDA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegtW++UjUioZA3XqU3pXBs29ewoUOVys732jsusMo2GBDA@mail.gmail.com>

On Tue, Sep 23, 2025 at 01:11:39PM +0200, Miklos Szeredi wrote:
> On Tue, 16 Sept 2025 at 02:24, Darrick J. Wong <djwong@kernel.org> wrote:
> 
> > +       /*
> > +        * Wait for all the events to complete or abort.  Touch the watchdog
> > +        * once per second so that we don't trip the hangcheck timer while
> > +        * waiting for the fuse server.
> > +        */
> > +       smp_mb();
> > +       while (wait_event_timeout(fc->blocked_waitq,
> > +                       !fc->connected || atomic_read(&fc->num_waiting) == 0,
> > +                       HZ) == 0)
> 
> I applied this patch, but then realized that I don't understand what's
> going on here.

We go around this tight loop until either 1 second goes by, the fuse
connection drops, or the number of fuse commands hits zero.  Non-timeout
Wakeups are stimulated by the wake_up_all(&fc->blocked_waitq) in
fuse_drop_waiting() after the request is completed or aborted.

The loop body touches the soft lockup watchdog so that we don't get hung
task warnings while waiting for a possibly large number of RELEASE
requests (or whatever's queued up at that point) to be processed by the
server.  I didn't use wait_event_killable_timeout because I don't know
how to clean up an in-progress unmount midway through.

> Why is this site special?  Should the other waits for server response
> be treated like this?

I'm not sure what you're referring to by "special" -- are you asking
about why I added the touch_softlockup_watchdog() call here but not in
fuse_wait_aborted()?  I think it could use that treatment too, but once
you abort all the pending requests they tend to go away very quickly.
It might be the case that nobody's gotten a warning simply because the
aborted requests all go away in under 30 seconds.

--D

> Thanks,
> Miklos

