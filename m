Return-Path: <linux-fsdevel+bounces-62525-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8DAB978B0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 22:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A07E3B96B1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 20:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6479E30BF4F;
	Tue, 23 Sep 2025 20:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pvs6xma4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFDE26CE17;
	Tue, 23 Sep 2025 20:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758661177; cv=none; b=Fi7KAl3A4owzjU/KUKykYUf4J31oD0yAKq1ErZu5xfqHYY5g4V6Y2SnHQPACwBFA1ZKv1uc4E4m9C7NQbQ2LjDbFprD/wXypn4ZaEMw1UyuubwQjOWVTIpkSWTRthSv8fyld4e2jkO6VYzVlKEeHXF3u057xt23MlfC7rndluEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758661177; c=relaxed/simple;
	bh=NIbwgI3W7ieltAoE7xVUGc0BdIsHi9VokAUkaobzrUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PjS054gm2lVuV8SZyd9R3ruNYFnVCzeA3NgjcGTsXC6drPSMlEFqdU1ZlDonbz0cwOiZL6ZAfFfylmhfqb45+3YSl/u/0KRjg6uv6vP6Pna6wB0L4eTuTnT+NmIXWOMcwt+olrnKN7UBmF5zEwzh10vCWRBJfOUEflkW59sEeYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pvs6xma4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 292ECC4CEF5;
	Tue, 23 Sep 2025 20:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758661177;
	bh=NIbwgI3W7ieltAoE7xVUGc0BdIsHi9VokAUkaobzrUg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pvs6xma4n1tE48JixcQLRYWhC4PFCYxSNyEJiUvwjhm3nonZIV+DY3sBthUcjB5/z
	 JRi8RhX0h3Vy8yGIVCMgRAWD4dT/nf8o0oB95a6F9dLwSizamZMz4V1/jPIIMtp88e
	 gSRfgzAcV12+NHHcLQfEHWAwucnlDiF3XKj/DBbw7L46h2jPdIGS4Bnpoaqb0xgMC6
	 57HbcTAntVs4p7uocGtzMAbz1at43P6umzLGKX3uwBA6ZAFep1528QgyQrbi4fcnka
	 xwZiHt5QIBqRRKI/r5QigBug9GQ4S9E7ApaIMaaGnA0deXeh7McCvCZtoV8sP09J5w
	 BLzaGI1EQQBEA==
Date: Tue, 23 Sep 2025 13:59:36 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: bernd@bsbernd.com, linux-xfs@vger.kernel.org, John@groves.net,
	linux-fsdevel@vger.kernel.org, neal@gompa.dev,
	joannelkoong@gmail.com
Subject: Re: [PATCH 2/8] fuse: flush pending fuse events before aborting the
 connection
Message-ID: <20250923205936.GI1587915@frogsfrogsfrogs>
References: <175798149979.381990.14913079500562122255.stgit@frogsfrogsfrogs>
 <175798150070.381990.9068347413538134501.stgit@frogsfrogsfrogs>
 <CAJfpegtW++UjUioZA3XqU3pXBs29ewoUOVys732jsusMo2GBDA@mail.gmail.com>
 <20250923145413.GH8117@frogsfrogsfrogs>
 <CAJfpegsytZbeQdO3aL+AScJa1Yr8b+_cWxZFqCuJBrV3yaoqNw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegsytZbeQdO3aL+AScJa1Yr8b+_cWxZFqCuJBrV3yaoqNw@mail.gmail.com>

On Tue, Sep 23, 2025 at 08:56:47PM +0200, Miklos Szeredi wrote:
> On Tue, 23 Sept 2025 at 16:54, Darrick J. Wong <djwong@kernel.org> wrote:
> 
> > I'm not sure what you're referring to by "special" -- are you asking
> > about why I added the touch_softlockup_watchdog() call here but not in
> > fuse_wait_aborted()?  I think it could use that treatment too, but once
> > you abort all the pending requests they tend to go away very quickly.
> > It might be the case that nobody's gotten a warning simply because the
> > aborted requests all go away in under 30 seconds.
> 
> Maybe I'm not understanding how the softlockup detector works.  I
> thought that it triggers if task is spinning in a tight loop.  That
> precludes any timeouts, since that means that the task went to sleep.
> 
> So what's happening here?

Hrm, I thought the softlockup detector also complains about tasks stuck
in uninterruptible sleep, but you're right, it *does* schedule() so the
softlockup detector won't complain about it.

I think.  Let me go try to prove that empirically. :)

--D

> Thanks,
> Miklos
> 

