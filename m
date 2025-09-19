Return-Path: <linux-fsdevel+bounces-62196-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB78B87BFF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 04:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F29B94E0BBA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 02:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E6025A343;
	Fri, 19 Sep 2025 02:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="Lof1pJiM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958AB35942;
	Fri, 19 Sep 2025 02:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758250223; cv=none; b=GnSDcPbrtCIu0Xeime6PLJm5o2ggNH7ofHhhoqr9XlsVZLck0SPFpT7fbkYoJV1g1EoeDqfCEucPcxGzEyZBIs0tv4h+tVU0JfAs+ZrxCpGkjzw0vphP0ojcOtHCgjVqdStkgdxUmYafNzZyvByMqWfMsDwdz9FYNS7SLJVZk+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758250223; c=relaxed/simple;
	bh=e61wfCFkrnLoWDwH79oREXQ3lPTB6/MyrBzhdNPwV64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VKcNGYHcLQkFc2zUZmCHOoPtpxODBdBHFk5KWUHVljL6CA1aiuP4ALBNfbIV9XZbd+wLglF8OG3gsYsGxiN52IYqwGv2wOv9zDARZW0h5GSwwzf+Y5vHanONK4Ts3FGLStfA6KkTr7tHHKGCTdBuaPqPKt5B51I7DwTXlzP/fC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=Lof1pJiM; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 1962614C2D3;
	Fri, 19 Sep 2025 04:50:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1758250213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qDl2rXRvrmQPYT8Y/zyjE3gK9Zfk8+TR4UBbLdUOCIY=;
	b=Lof1pJiMuy/lokXeXA5XKeYnMfqgxUUQuaxPE/W7du4WGEPqWd9OWVJhYnjRdhQUU9jVuq
	edkuy45EhidZKnJ3B+5qh06hzRREczyk46Dv9+b+RtdTM+miIkXkmBIz2j746BUUpZnh4H
	9AXamWTQ9retRwqoYXqNRFmbgflbOKgDpSMyDf3Bpy8gjSxL1bg/Lf1Q123kLwPbNSVTCv
	PsshlG9DYr1SisSLVW9EI3KGYjMIs8LbMWqNR07QwNj4R+rCkXzdSCXXOVbANHaDpB75+C
	Tq4diZQsCCPHQFyvdVrlz3y5ssSguW43MzLDpw5xTygGMv/O+cxIwaunybMUpQ==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 907a32a2;
	Fri, 19 Sep 2025 02:50:09 +0000 (UTC)
Date: Fri, 19 Sep 2025 11:49:54 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Remi Pommarel <repk@triplefau.lt>
Cc: v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Subject: Re: [RFC PATCH 0/5] 9p: Performance improvements for build workloads
Message-ID: <aMzE0kbTCADO9QCc@codewreck.org>
References: <cover.1756635044.git.repk@triplefau.lt>
 <aMa2Q_BUNonUSOjA@codewreck.org>
 <aMxazb_dcK3hTATI@pilgrim>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aMxazb_dcK3hTATI@pilgrim>

Remi Pommarel wrote on Thu, Sep 18, 2025 at 09:17:33PM +0200:
> RFC was mainly here to know if a io_wait_event_killable() would made
> sense before getting the scheduler tree involved. Also as it is my first
> contribution in v9fs (and fs subsystem) wanted to be sure I wasn't
> missing something obvious, caching could be a complex subject to grasp.
> This also comes with some drawbacks, if for example server removes a
> shared file or modify a symlink the client will be desynchronized, so I
> wanted first to be sure we were ok with that when using cache=loose.

Ok!
I think it's completely fine for cache=loose, we're basically telling
the client we're alone in the world.

> I'll try to monitor the new mount API and rebase the series when that
> get merged. I'll probably separate the io_wait_event_killable() in its
> own patchset though.

Thanks, I need to find time to check the v9ses lifetime as I asked about
after a syzcaller bug showed up[1], so it might not be immediate, but
I'll get to it eventually

[1] https://lore.kernel.org/v9fs/aKlg5Ci4WC11GZGz@codewreck.org/T/#u

> > Another thing I tried ages ago was making clunk asynchronous,
> > but that didn't go well;
> > protocol-wise clunk errors are ignored so I figured it was safe enough
> > to just fire it in the background, but it caused some regressions I
> > never had time to look into...
> > 
> > As for reusing fids, I'm not sure it's obvious because of things like
> > locking that basically consider one open file = one fid;
> > I think we're already re-using fids when we can, but I guess it's
> > technically possible to mark a fid as shared and only clone it if an
> > operation that requires an exclusive fid is done...?
> > I'm not sure I want to go down that hole though, sounds like an easy way
> > to mess up and give someone access to data they shouldn't be able to
> > access by sharing a fid opened by another user or something more
> > subtle..
> 
> Yes I gave that a bit more thinking and came up with quite the same
> conclusion, I then gave up on this idea. The asynchronous clunk seems
> interesting though, maybe I'll take a look into that.

It's been a while, but the last time I rebased the patches was around here:
https://github.com/martinetd/linux/commits/9p-async-v2/
(the v1 branch also had clunks async, with this comment
> This has a few problems, but mostly we can't just replace all clunks
> with async ones: depending on the server, explicit close() must clunk
> to make sure the IO is flushed, so these should wait for clunk to finish.
)

If you have time to play with this, happy to consider it again, but
it'll definitely need careful testing (possibly implement the clunk part
as a non-default option? although I'm not sure how that'd fly, linux
doesn't really like options that sacrifice reliability for performance...)

Anyway, that's something I definitely don't have time for short term,
but happy to discuss :)

Cheers,
-- 
Dominique Martinet | Asmadeus

