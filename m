Return-Path: <linux-fsdevel+bounces-63387-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A210BB7C50
	for <lists+linux-fsdevel@lfdr.de>; Fri, 03 Oct 2025 19:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C876E19C599F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Oct 2025 17:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6592D8791;
	Fri,  3 Oct 2025 17:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="O+uTd9ue";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MhMm1X5n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A38823A989
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Oct 2025 17:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759512931; cv=none; b=trfPQ/oC9wBp4rCnQVqkUErraKa1ocFoRoKcTuxcWF0gk+0S/LX/cqG6gy5oUPRPB/KXcB3FW/s8EV9/W0/BlYxidyOScEqrPZGksz9KN1NiMtP1nvlt3fn4c8ycbI8D6tQiJzKcKyWtuNlSnd7UTb02io91TD6DMrjyNczqhgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759512931; c=relaxed/simple;
	bh=XVlF37Ic24TFX4+jnhj19/kDjBXel1yAP/KR262KgME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SI7CLLPVjRBipPRYFHtqbTNG7kj1EqYz2nyRkm4qTrwfm/8Ex8JmiSju1Wcm9xGokUL1NE8VYyfTuAUKTLO5/K4d8N0AvYp+UcuDBazwqsxHl/1i8zeJCJRWVEzbkJx57hc82UOH9rQrmkr+MdnZokO8UELxGfDm9lVWmVl419w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=O+uTd9ue; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MhMm1X5n; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 2E0901D001A6;
	Fri,  3 Oct 2025 13:35:28 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 03 Oct 2025 13:35:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759512928;
	 x=1759599328; bh=K6Q1z832QYliSB84OkWakJJTMzLyU3J3VPggYo8UHqQ=; b=
	O+uTd9ueRzmrJUJZiU/6g9u5uSQkKkeda1R+cTjFxqu7qki/cZl8C/Z6Y4PQ2ePC
	J/1MY/p1wlcbkmmGS2SuxEEX/kjrfOQ1FXIrVRRE8Q2fJJbwaThwQ8amCSDkNnkH
	DLqjpVwh0pAdJcpk755gc6xYE+cnD9/Q7i6QlDTQSnWMVDLeSCrrPrF2EnW1BWd2
	Ed8CrvhiFRk9vN8WrDxKmXk3+P3OJrJo3L+Pkp7gj0ej0dvgnQxaA6LI1knt2JuT
	yVG6w+dh7/xk6OgaugJo/0Zhp/6/vmDP+2gsFTPGzEsSqNIFLXvPtXlO+k8GPlAz
	9TiRLZyS8p56ftZ1zwGv5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759512928; x=
	1759599328; bh=K6Q1z832QYliSB84OkWakJJTMzLyU3J3VPggYo8UHqQ=; b=M
	hMm1X5nDMVXi6H/w1yrkQBjqPsvPmC8FBUBAtp4wbMFQOIf/ofiZkFHRUOSDaFcG
	Y782UdAvIJLPJTsHsvXQC+Ei+0f8dWu59Ezh956ISOEnhOS5SNcqXpizTaW8h+ld
	ByMIPOZP7IX7kU8A2f6lCXnjyer48n0U8Dr6valr7gM6h16UXHUEwKDz/XFmTydH
	BYLZxgJIr1YvY8F0AsV/O9q8tjfV7i+kjlY2D2WOCU83lQPaWYTDhNl6fSkL0cf3
	rjw53uSpfBDk5HhOIc9CRYlJ2j010+QL2XcbzyiZTZEfajhkBmmZurJldIAq4SeJ
	v4+qMzGeN314zbcpaHrsQ==
X-ME-Sender: <xms:XwngaFYXwnd-ARFzW1Xq9Zs8W5vt0mLfMgpKpqO3rs07igcqwzVvmQ>
    <xme:XwngaAF1VG19WKBVwVMpLYLwAxxVia8kTUZaHsKQn6wwTqfoFQPor7_lYYo1n9gra
    mKMU_4jVJgF2Y1BtfwxLrL5hcuNHCgyDktEnKSeoIxhA_-5JfYBsA>
X-ME-Received: <xmr:XwngaBwSxHHXOy9r7ho2hjAjkS2i65L5ER1h0W77_aktsWZoMCN40tp8IP1tQ1383gFfzY3fWgDKL0vU5nKAsPAIT8y_ka3a2XBMHiLUkFKMtJCyk9pe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekleehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepuegvrhhnugcu
    ufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdrfh
    hmqeenucggtffrrghtthgvrhhnpeevvdffhfeltedttdelffehudeiueevgefhvdfgfedu
    ieehudffheduteelhffgueenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhkvghrnh
    gvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhfmhdpnhgspghrtg
    hpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepfhesmhgriiiiohdr
    lhhipdhrtghpthhtoheprghmihhrjeefihhlsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    eplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegujhifohhngh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhikhhlohhssehsiigvrhgvughirdhh
    uh
X-ME-Proxy: <xmx:XwngaKlNfnYhetOS_uISizn4Q8otEdsn-C87XbgHXyEJBFZZn0gmWA>
    <xmx:XwngaCm2znkMF2OUQ78T_mV8l4AUxris3XNLA1MffwOBLAK8u4ZfIQ>
    <xmx:XwngaEyEqJ8zFOnDlqZ5y-Brv_OhiO8Ibv5Ux2UBZjPtY1tRAIRqIg>
    <xmx:XwngaPoStU0XGNWdqVjyYNoWV-i5ep-r3_0zapYZz6KYnObhXM85fw>
    <xmx:YAngaCTGCZZHdIL9o2Q1ORPeC7-y7vCAzsg2_vdNrqJaQyiHhBxxx3rh>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Oct 2025 13:35:26 -0400 (EDT)
Message-ID: <7747f95d-b766-4528-91c5-87666624289e@fastmail.fm>
Date: Fri, 3 Oct 2025 19:35:25 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Mainlining the kernel module for TernFS, a distributed filesystem
To: Francesco Mazzoli <f@mazzo.li>, Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
 "Darrick J. Wong" <djwong@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>
References: <bc883a36-e690-4384-b45f-6faf501524f0@app.fastmail.com>
 <CAOQ4uxi_Pas-kd+WUG0NFtFZHkvJn=vgp4TCr0bptCaFpCzDyw@mail.gmail.com>
 <34918add-4215-4bd3-b51f-9e47157501a3@app.fastmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <34918add-4215-4bd3-b51f-9e47157501a3@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/3/25 17:01, Francesco Mazzoli wrote:
> On Fri, Oct 3, 2025, at 15:22, Amir Goldstein wrote:
>> First of all, the project looks very impressive!
>>
>> The first thing to do to understand the prospect of upstreaming is exactly
>> what you did - send this email :)
>> It is very detailed and the linked design doc is very thorough.
> 
> Thanks for the kind words!
> 
>> A codebase code with only one major user is a red flag.
>> I am sure that you and your colleagues are very talented,
>> but if your employer decides to cut down on upstreaming budget,
>> the kernel maintainers would be left with an effectively orphaned filesystem.
>>
>> This is especially true when the client is used in house, most likely
>> not on a distro running the latest upstream kernel.
>>
>> So yeh, it's a bit of a chicken and egg problem,
>> but if you get community adoption for the server code,
>> it will make a big difference on the prospect of upstreaming the client code.
> 
> Understood, we can definitely wait and see if TernFS gains wider adoption
> before making concrete plans to upstream.
> 
>> I am very interested in this part, because that is IMO a question that
>> we need to ask every new filesystem upstream attempt:
>> "Can it be implemented in FUSE?"
> 
> Yes, and we have done so:
> <https://github.com/XTXMarkets/ternfs/blob/main/go/ternfuse/ternfuse.go>.

Hmm, from fuse-io-uring point of view not ideal, see Han-Wens
explanation here
https://github.com/hanwen/go-fuse/issues/560

I just posted a new queue-reduction series today, maybe that
helps a bit
https://lore.kernel.org/r/20251003-reduced-nr-ring-queues_3-v2-0-742ff1a8fc58@ddn.com

At a minimum each implementation still should take care of numa affinity,
getting reasonable performance is hard if go-fuse has an issue with that.

Btw, I had see your design a week or two ago when posted on phoronix and
looks like you need to know in FUSE_RELEASE if application crashed. I think
that is trivial and we at DDN might also use for the posix/S3 interface,
patch follows - no need for extra steps with BPF).

> 
>> So my question is:
>> Why is the FUSE client slower?
>> Did you analyse the bottlenecks?
>> Do these bottlenecks exist when using the FUSE-iouring channel?
>> Mind you that FUSE-iouring was developed by DDN developers specifically
>> for the use case of very fast distributed filesystems in userspace.
>> ...
>> I mean it sounds very cool from an engineering POV that you managed to
>> remove unneeded constraints (a.k.a POSIX standard) and make a better
>> product due to the simplifications, but that's exactly what userspace
>> filesystems
>> are for - for doing whatever you want ;)
> 
> These are all good questions, and while we have not profiled the FUSE driver
> extensively, my impression is that relying critically on FUSE would be risky.
> There are some specific things that would be difficult today. For instance
> FUSE does not expose `d_revalidate`, which means that dentries would be dropped
> needlessly in cases where we know they can be left in place.

Fuse sends LOOKUP in fuse_dentry_revalidate()? I.e. that is just a userspace
counter then if a dentry was already looked up? For the upcoming
FUSE_LOOKUP_HANDLE we can also make sure it takes an additional flag argument.

> 
> There are also some more high level FUSE design points which we were concerned
> by (although I'm not up to speed with the FUSE over io_uring work). One obvious
> concern is the fact that with FUSE it's much harder to minimize copying.
> FUSE passthrough helps but it would have made the read path significantly more
> complex given the need to juggle file descriptors between user space and the
> kernel. Also, TernFS uses Reed-Solomon to recover from situations where some
> parts of a file is unreadable, and in that case we'd have had to fall back to
> a non-passthrough version. Another possible FUSE performance pitfall is that
> you're liable to be bottlenecked by the FUSE request queue, while if you work
> directly within the kernel you're not.

I agree on copying, but with io-uring I'm not sure about a request queue issue.
At best missing is a dynamic size of ring entries, which would reduce memory
usage. And yeah, zero-copy would help as well, but we at DDN buffer access
with erase coding, compression, etc - maybe possible at some with bpf, but right
now too hard.

> 
> And of course before BPF we wouldn't have been able to track the nature of
> file closes to a degree where the FUSE driver can implement TernFS semantics
> correctly.

See above, patch follows.


Thanks,
Bernd

