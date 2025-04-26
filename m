Return-Path: <linux-fsdevel+bounces-47443-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 861FFA9D78E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Apr 2025 06:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6952F7B24DA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Apr 2025 04:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4B0188735;
	Sat, 26 Apr 2025 04:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="n1RriIzW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C7529B0
	for <linux-fsdevel@vger.kernel.org>; Sat, 26 Apr 2025 04:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745642990; cv=none; b=Tj+jh/6lXGiJiZCNj22zU9lBv3ywN+deBl7WC3EXH8Eq9wm5jVNPjo72wYKNd4/NC3XVTB5PvM1vs+jGoEh3O5IBnWc3iVy0bQhMDppptigIzb9NieO4H3EuKz9gM6jMfrEX0fN17sMCM2G0m/RNEty8gRSDgaI7B76nO85EwJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745642990; c=relaxed/simple;
	bh=O4rp6IwoUrX6ClOEHBMGSVhVYVqknK0cRFU5ZLyTr7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cSM5MqpFQvTQL/GR1drenhIy02CXLXvn0jbtdKeMmNK/sXHsNTpq6pDG4vAarTEtfG24e9u5MOeO/r6CweunsAetnTSA0+USbgzNrpSe4+uAyXRcTemwmcP/u9SVEKxNGu0BjuVqcSmur/1Zu25ORTQdR/Ph2nrVwWLGic64jyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=n1RriIzW; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 26 Apr 2025 00:49:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745642984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qfL8sNSt8aBeDy41/of+ea5k84Wg2W7P9qGzyIHgGJs=;
	b=n1RriIzWGjdHBv5Cn/E/nL83jN2ElZ7qJee66C09Ub7VH7mtYmrpsMJwPC42qVwh8xyW+6
	V2NStu1aHj+OT1EtdksOFvjz7+iGG+dsZGoB31wnbIvzHFTU3fylg0TIsJsQLDkoKxAH34
	13ZwJ9/8CVNi3TN3F1tGLDt1Gbml3tw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.15-rc4
Message-ID: <rn2bojnk2h3z6xavoap6phjbib55poltxclv64xaijtikg4f5v@npknltjjnzan>
References: <ivvkek4ykbdgktx5dimhfr5eniew4esmaz2wjowcggvc7ods4a@mlvoxz5bevqp>
 <CAHk-=wg546GhBGFLWiuUCB7M1b3TuKqMEARCXhCkxXjZ56FMrg@mail.gmail.com>
 <q3thzkbsq6bwur7baoxvxijnlvnobyt6cx4sckonhgdkviwz76@45b6xlzvrtkr>
 <CAHk-=wh09TvgFu3WKaeLu8jAxCmwZa24N7spAXi=jrVGW7X9ZA@mail.gmail.com>
 <mlsjl7qigswkjvvqg2bheyagebpm2eo66nyysztnrbpjau2czt@pdxzjedm5nqw>
 <CAHk-=wiSXnaqfv0+YkOkJOotWKW6w5oHFB5xU=0yJKUf8ZFb-Q@mail.gmail.com>
 <lmp73ynmvpl55lnfym3ry76ftegc6bu35akltfdwtwtjyyy46z@d3oygrswoiki>
 <CAHk-=wiZ=ZBZyKfg-pyA3wmEq+RkscKB1s68c7k=3GaT48e9Jg@mail.gmail.com>
 <opsx7zniuyrf5uef3x4vbmbusu34ymdt5myyq47ajiefigrg4n@ky74wpog4gr4>
 <CAHk-=wjGiu1BA_hOBYdaYWE0yMyJvMqw66_0wGe_M9FBznm9JQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjGiu1BA_hOBYdaYWE0yMyJvMqw66_0wGe_M9FBznm9JQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Apr 25, 2025 at 09:11:18PM -0700, Linus Torvalds wrote:
> On Fri, 25 Apr 2025 at 20:59, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> >
> > Yeah, Al just pointed me at generic_set_sb_d_ops().
> >
> > Which is a perverse way to hide an ops struct. Bloody hell...
> 
> Kent, it's that perverse thing EXACTLY FOR THE REASONS I TOLD YOU.

And you never noticed that the complaints I had about the dcache bits
didn't make sense and how I said it should work was how it actually does
work? Heh.

We were talking past each other because everywhere else in filesystem
land you define your ops structs, which means you can read through them,
but when the ops struct is behind a helper that can be called from
anywhere (the ext4 init code is what, 400 lines ballpark last I check) -
good luck...

> The common case will never even *look* at the dentry ops, because
> that's way too damn expensive, and the common case wants nothing at
> all to do with case insensitivity.
> 
> So guess why that odd specialized function exists?
> 
> Exactly because the dcache makes damn sure that the irrelevant CI case
> is never in the hot path. So when you set those special dentry
> operations to say that you want the CI slow-paths, the VFS layer then
> sets magic bits in the dentry itself that makes it go to there.
> 
> That way the dentry code doesn't do the extra check for "do I have
> special dentry operations for hashing on bad filesystems?" IOW, in
> order to avoid two pointer dereferences, we set one bit in the dentry
> flags instead, and now we have that information right there.

Well, that's d_set_op(), for the "flags to skip hitting the ops struct"
bits. That's perfectly sane, sensible thing to do; you could still pass
a d_ops to it that was defined within that specific filesystem.

generic_set_sb_d_ops() just hides the fact that a d_operations exists.
That's where the confusion came from, because if any of the other major
local filesystems defined one I'd have seen it.

> So yes, people who want to use case-insensitive lookups need to go to
> some extra effort, exactly because we do NOT want that garbage to
> affect the well-behaved paths.
> 
> And no, I'm not surprised that you didn't get it all right. The VFS
> layer is complicated, and the dentry cache is some of the more complex
> parts of it.

I think the more hilarious part is that CI lookups without the special
d_ops seems to actually work - passes tests and I got a report today
that the code I finished last night "works now, please don't change it".

So, yeah. Fun times.

