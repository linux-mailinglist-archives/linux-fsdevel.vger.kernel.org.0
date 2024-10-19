Return-Path: <linux-fsdevel+bounces-32431-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8753C9A4FEB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2024 19:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 078181F22550
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2024 17:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6BC1898ED;
	Sat, 19 Oct 2024 17:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="lqSj41DP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264F716C850
	for <linux-fsdevel@vger.kernel.org>; Sat, 19 Oct 2024 17:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729357884; cv=none; b=t9JliKOQB4iHAeMf5txlEUWucQw3/MjDlg7EqEz0tbhX+aNlvw+qF9nsEk2b7Bm06i3AfqJ6C64z3fepyh0CS5PLwK6sOxX8WYzkQ8aoSZCivIlaReFBBTfuQn9xz2EsJcgYqizjsO8GExArNHjHRf1ApaJulONOrSpV5m+CGbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729357884; c=relaxed/simple;
	bh=rXs2AZiZA9d9IO35nyk5yjrNc3xmMdODhBOZ8YIMnKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kx34AdNDcw9cCIvjNsZAirWwP27pENaCY+H3MsdnkRI9xRPBqB0KGRmjA4iHba9L8Yl5ea5LnyAABIefMgem3mT3kvV3s8btipn+mjJCHI8Rj8H7WcKNPsJ7V1NX92dRJjR9He79vQ95e6mQijiTyZXSPNJm+wZsKCIlf4ssxk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=lqSj41DP; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sttXc801/wq4eFpHpLG+mWupU5eeeWRHyMsIlp0HKDg=; b=lqSj41DPhPD8OPZjpLHcTf0db6
	y5HzMf5fhjttuJHvVTb+6CMBhPJBJ7jCdHoCNWlnTPVLg6ofZJYSi0PPpG7QAYLbC960pmJKWmoXf
	Cp3BDvD3YKdY+Gj+n4w/Q1t2Lr2Dan4t2Xce+qdfHEWvYK04BFcT6ss55YSZ3w3mAreSTKxofyuVB
	hmNdhwWTLpmH1Y6Vg0dP9UorfHjJ0Vs1UngxIe0RuFFouoTmAdctmKX5I8uxVDm578x5L3V2kb3zI
	OQ4ntWXebEHXVpzDWzSWO5oyv2g0oPOCq8VLMLi/92dw6AETrfN/PyooIRJMmBcW22Bc4TIAklptO
	TNylAUVg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t2Cz0-00000005R8T-3NKg;
	Sat, 19 Oct 2024 17:11:18 +0000
Date: Sat, 19 Oct 2024 18:11:18 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC][PATCH] getname_maybe_null() - the third variant of
 pathname copy-in
Message-ID: <20241019171118.GE1172273@ZenIV>
References: <20241016050908.GH4017910@ZenIV>
 <20241016-reingehen-glanz-809bd92bf4ab@brauner>
 <20241016140050.GI4017910@ZenIV>
 <20241016-rennen-zeugnis-4ffec497aae7@brauner>
 <20241017235459.GN4017910@ZenIV>
 <20241018-stadien-einweichen-32632029871a@brauner>
 <20241018165158.GA1172273@ZenIV>
 <20241018193822.GB1172273@ZenIV>
 <20241019050322.GD1172273@ZenIV>
 <CAHk-=wh_QbELYAqcfvSdF7mBcu+6peXSCzeJVyg+N+Co+wWg5g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh_QbELYAqcfvSdF7mBcu+6peXSCzeJVyg+N+Co+wWg5g@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Oct 19, 2024 at 09:15:32AM -0700, Linus Torvalds wrote:

> IOW, I think the (NULL, AT_EMPTY_PATH) tuple makes sense as a way to
> pass just an 'fd', but I'm _not_ convinced it makes sense as a way to
> pass in AT_FDCWD.
> 
> Put another way: imagine you have a silly library implementation that does
> 
>     #define fstat(fd,buf) fstatat(fd, NULL, buf, AT_EMPTY_PATH)
> 
> and I think *that* is what we want to support. But if 'fd' is not a
> valid fd, you should get -EBADF, not "fstat of current working
> directlry".
> 
> Hmm?

There'd been an example of live use of that posted upthread:

https://sources.debian.org/src/snapd/2.65.3-1/tests/main/seccomp-statx/test-snapd-statx/bin/statx.py/?hl=71#L71

"" rather than NULL, but...
 
> This is not a hugely important thing. If people really think that
> doing "fstat()" on the current working directory is worth doing this
> for, then whatever.

