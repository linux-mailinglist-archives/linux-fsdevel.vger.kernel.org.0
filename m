Return-Path: <linux-fsdevel+bounces-47578-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FF4AA093F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 13:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05A737B001B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 11:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF952C10B1;
	Tue, 29 Apr 2025 11:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="upzrlCDO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344D41E766F;
	Tue, 29 Apr 2025 11:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745924888; cv=none; b=hN3C+d657DMXPmRRBQnPR1pnTZq03JivvsEe/QSQJZYpXvbwQjMHAPAsI/On/1ftzO0tRB2pPXCC58+bcdC/Unw5eKmuxeb4aHQ67+sfOF9DostFOiMxsDYM2yOg74QWU4gy0MTsaN2SkkyUuCvz6Mi+Vtdfyd5hCwM17QGHRZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745924888; c=relaxed/simple;
	bh=qPh/WrlbObgcctkRbyV6SsPJr/nOENTeraBZjUkNaww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQbRpxHzMTtMbIQp/fVz1LbNQtdrBeQhO8Zku0c2drFduTHf95Gx+QoUx7Ld2n8E0ygyjsmJGMIccnzIn/sJ+54IE6UY5Hhui5NC0l85rmxw/mSkMrqEIC4FhsEzLBa+Tjb0KpeMmay3R634NE3MxqGy97SmBkVeqKPn7NXzBvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=upzrlCDO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C4E1C4CEE3;
	Tue, 29 Apr 2025 11:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745924887;
	bh=qPh/WrlbObgcctkRbyV6SsPJr/nOENTeraBZjUkNaww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=upzrlCDOu25+anPHC9qHJrGtE9lgprNGBqAZF3Aw9jR4m7rYhcNhImz7gTBLelQJp
	 ipaTGIsJwaM+5m92zHWBQel3ynbnw1d1dzEoh6ySYaCXp7Wa5I9781W6Bn6juIRjO5
	 pkgDLASRxiFXKnyjCfBldYfxxCqATgFmAGcYfE0oozo/nFkdyDaN+kr0qRNXRmZ7/o
	 YrUAeTtymw/19eanV/PAsqI68oVlKsnjHA1XNhdZ5/GTldHmI43FnObOa4/FMUW+o4
	 g28BX5FfA4lEbnm7T+ZlygCe9V25dl0cRoEx2vrugITgO9o52yhmyKmkUHqJlYGAV5
	 7AczTN260dvVA==
Date: Tue, 29 Apr 2025 13:08:02 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Joe Damato <jdamato@fastly.com>, Carlos Llamas <cmllamas@google.com>, 
	linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Sridhar Samudrala <sridhar.samudrala@intel.com>, Alexander Duyck <alexander.h.duyck@intel.com>, 
	open list <linux-kernel@vger.kernel.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	William McVicker <willmcvicker@google.com>
Subject: Re: [PATCH vfs/vfs.fixes v2] eventpoll: Set epoll timeout if it's in
 the future
Message-ID: <20250429-begeben-zulagen-543d4ea75ca2@brauner>
References: <20250416185826.26375-1-jdamato@fastly.com>
 <20250426-haben-redeverbot-0b58878ac722@brauner>
 <ernjemvwu6ro2ca3xlra5t752opxif6pkxpjuegt24komexsr6@47sjqcygzako>
 <aA-xutxtw3jd00Bz@LQ3V64L9R2>
 <aBAB_4gQ6O_haAjp@google.com>
 <aBAEDdvoazY6UGbS@LQ3V64L9R2>
 <zvkvenkysbzves2qzknju5pmaws322r3lugzbstv6kuxcbw23k@mtddhwfxj3ce>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <zvkvenkysbzves2qzknju5pmaws322r3lugzbstv6kuxcbw23k@mtddhwfxj3ce>

On Tue, Apr 29, 2025 at 12:19:15PM +0200, Jan Kara wrote:
> On Mon 28-04-25 15:41:17, Joe Damato wrote:
> > On Mon, Apr 28, 2025 at 10:32:31PM +0000, Carlos Llamas wrote:
> > > On Mon, Apr 28, 2025 at 09:50:02AM -0700, Joe Damato wrote:
> > > > Thank you for spotting that and sorry for the trouble.
> > > 
> > > This was also flagged by our Android's epoll_pwait2 tests here:
> > > https://android.googlesource.com/platform/bionic/+/refs/heads/main/tests/sys_epoll_test.cpp
> > > They would all timeout, so the hang reported by Christian fits.
> > > 
> > > 
> > > > Christian / Jan what would be the correct way for me to deal with
> > > > this? Would it be to post a v3 (re-submitting the patch in its
> > > > entirety) or to post a new patch that fixes the original and lists
> > > > the commit sha from vfs.fixes with a Fixes tag ?
> > > 
> > > The original commit has landed in mainline already, so it needs to be
> > > new patch at this point. If if helps, here is the tag:
> > > Fixes: 0a65bc27bd64 ("eventpoll: Set epoll timeout if it's in the future")
> > > 
> > > > diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> > > > index 4bc264b854c4..1a5d1147f082 100644
> > > > --- a/fs/eventpoll.c
> > > > +++ b/fs/eventpoll.c
> > > > @@ -2111,7 +2111,9 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
> > > > 
> > > >                 write_unlock_irq(&ep->lock);
> > > > 
> > > > -               if (!eavail && ep_schedule_timeout(to))
> > > > +               if (!ep_schedule_timeout(to))
> > > > +                       timed_out = 1;
> > > > +               else if (!eavail)
> > > >                         timed_out = !schedule_hrtimeout_range(to, slack,
> > > >                                                               HRTIMER_MODE_ABS);
> > > >                 __set_current_state(TASK_RUNNING);
> > > 
> > > I've ran your change through our internal CI and I confirm it fixes the
> > > hangs seen on our end. If you send the fix feel free to add:
> > > 
> > > Tested-by: Carlos Llamas <cmllamas@google.com>
> > 
> > Thanks, will do.
> > 
> > I was waiting to hear back from Christian / Jan if they are OK with
> > the proposed fix before submitting something, but glad to hear it
> > fixes the issue for you. Sorry for the trouble.
> 
> Yep, a new patch submission with proper Fixes tag is needed at this point.

Yes, please send a new fixes patch that I can pick up!

Thanks!
Christian

