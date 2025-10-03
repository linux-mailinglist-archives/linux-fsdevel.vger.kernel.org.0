Return-Path: <linux-fsdevel+bounces-63379-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CE493BB7461
	for <lists+linux-fsdevel@lfdr.de>; Fri, 03 Oct 2025 17:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 17CC34ED346
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Oct 2025 15:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0129C169AE6;
	Fri,  3 Oct 2025 15:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mazzo.li header.i=@mazzo.li header.b="Ugyn4DBJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wSexZcdJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8791928312E
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Oct 2025 15:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759503764; cv=none; b=fKIexWA9x8hZGxwGxh4C4sGjmEaDKAdn3TmCe2uuTx/n1qC91BYHn5NdeFn1o9cSGdDntN695fl8mjQVRDemXLn29hxY1E9KtofGCTYq5gEZBETz4IaNhGqXIthV2qz1OSo+r57juu3mJJ+muna046Hp5ygiYq/rwTllez6a8Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759503764; c=relaxed/simple;
	bh=N1mXVJT4bduMMsYAi9qHWRwth+oiwNSW4i0kA+U3hcU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=IY+G8DpD2DkyYw8X3jk58KXv5keQ/g/t30bV2NlCr/tThY+4QfR+6lV8HwPBbJLGgIOwMKTjabGmyRHlte61aLFL3G15FAKC8TdO/d5WpAvvsfe9j+6P9cdX38FmDiJMpFeP7idxSxyMU2ebLESz2GkTcvr+Tfa/eDqBKXGxjfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mazzo.li; spf=pass smtp.mailfrom=mazzo.li; dkim=pass (2048-bit key) header.d=mazzo.li header.i=@mazzo.li header.b=Ugyn4DBJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wSexZcdJ; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mazzo.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mazzo.li
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 854D1EC01EF;
	Fri,  3 Oct 2025 11:02:40 -0400 (EDT)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-05.internal (MEProxy); Fri, 03 Oct 2025 11:02:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mazzo.li; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1759503760;
	 x=1759590160; bh=/OdHW84fKKP0jMsRETX5xqrNjwoBqKzr6SPCGUttL2E=; b=
	Ugyn4DBJXL2L0CzpQP8HJOgMRQ3bE4e4EF6+RlNtnp43awQrSDmmPn5u7lerWONC
	UVA2OZPbwVEjZOyRvnF/QFGZx+ToRp21dIS8+h/thAdZWLGSHYp5u1TSUaPpEfIY
	BcKwKtwqS4cLdJaPGBM+he8AE9arOG8oBJXRNzJWTen4UNiFLmwztnQOLSvU8ewd
	l9HPE/912QY3E+e/Eib1c3UC6u1vK9yrq2nrT7j+vFztlWHlV8vCsjI8lyJqtNup
	eyhnIbo47ItmYwNj3IFCHzV2M4XokRMOlZvFfjuiaQ8XEqqa88eI0XfPMh8nAxZx
	j0Y6JnExcF8d5KpNhETooA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759503760; x=
	1759590160; bh=/OdHW84fKKP0jMsRETX5xqrNjwoBqKzr6SPCGUttL2E=; b=w
	SexZcdJhT3MwgL3rsqsMvJ2RiJWEgGbXSP8/mpAj77d1+zHkCjsRG3AU+zCkYyj8
	/FpIkquB/nzwxSPFqhPQSZfAYQXq8hYRACnusqhDwM/hGJhH3rodP62v2vWlOMcz
	lBEYGWK7cN264Dw0K2nRX9FXXnPPmDGedeecxjOiwGflr3OUcMMSJHDjYq4uJOlg
	egI86oIBbJ2ADDfC76ibn0DCGZb7eNLU7W7yMcQ7whMjwLCnzkpUAXeF9D5xDv/z
	Tl0eWzJLncIZ5kAcd1pyeE6Z5cviCgn86DUD8q6RpqlmgCBcrXxGv1J7aK//e7Uq
	oiDQXrtWJH627Wj86FEVQ==
X-ME-Sender: <xms:j-XfaPqfsGLRrtCai4yN5ZuNch7j6nOK92l6AAK6syXvVeBJe07aCw>
    <xme:j-XfaEeN9da-glPxju-FIk5AFZV8di35uskP7xOYsFnGG2THEdy9s6Zi7oG7H5P1b
    wdURlX0mcBjUNEd0jxzApcfYMUsFxsZ4JDmOlRzxvs5hXjidfWc-ds>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekledvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfhrhgrnhgt
    vghstghoucforgiiiiholhhifdcuoehfsehmrgiiiihordhliheqnecuggftrfgrthhtvg
    hrnhepteeihfetffefieffffetledvueeuhfdvtdeuleekfeeludeuheduuedvleeiveff
    necuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehfsehmrgiiiihordhlihdpnhgspghrtghpthht
    ohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsggvrhhnugdrshgthhhusg
    gvrhhtsehfrghsthhmrghilhdrfhhmpdhrtghpthhtoheprghmihhrjeefihhlsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepughjfihonhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihhklhho
    shesshiivghrvgguihdrhhhupdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:kOXfaPWua9cj-SSEPo9TltJp88cZ3FR2tWO1Ytv1M9Shd-iU6iELYQ>
    <xmx:kOXfaA4M0xtuOTFxFygkqSUqud-sfQqa_TMFTEJu7RnKNVofxu7jEg>
    <xmx:kOXfaCqFDh2mfvU5tnexGzKNy1GEdLjjghexv_KMJ3VC0q3TmkQiLA>
    <xmx:kOXfaLmNuigzjS_CgQmxh8f9KmYC3H-3JxriElsXCw6LrwyOHbuSoQ>
    <xmx:kOXfaCjX7l9lFKwTfJqvI9NSq3C1yiFOT7ogmdj7fWirIVF6E5VSUNIz>
Feedback-ID: i78a648d4:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D6C95216005F; Fri,  3 Oct 2025 11:02:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AKLrIgF2TFVc
Date: Fri, 03 Oct 2025 16:01:56 +0100
From: "Francesco Mazzoli" <f@mazzo.li>
To: "Amir Goldstein" <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, "Christian Brauner" <brauner@kernel.org>,
 "Darrick J. Wong" <djwong@kernel.org>,
 "Bernd Schubert" <bernd.schubert@fastmail.fm>,
 "Miklos Szeredi" <miklos@szeredi.hu>
Message-Id: <34918add-4215-4bd3-b51f-9e47157501a3@app.fastmail.com>
In-Reply-To: 
 <CAOQ4uxi_Pas-kd+WUG0NFtFZHkvJn=vgp4TCr0bptCaFpCzDyw@mail.gmail.com>
References: <bc883a36-e690-4384-b45f-6faf501524f0@app.fastmail.com>
 <CAOQ4uxi_Pas-kd+WUG0NFtFZHkvJn=vgp4TCr0bptCaFpCzDyw@mail.gmail.com>
Subject: Re: Mainlining the kernel module for TernFS, a distributed filesystem
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Oct 3, 2025, at 15:22, Amir Goldstein wrote:
> First of all, the project looks very impressive!
> 
> The first thing to do to understand the prospect of upstreaming is exactly
> what you did - send this email :)
> It is very detailed and the linked design doc is very thorough.

Thanks for the kind words!

> A codebase code with only one major user is a red flag.
> I am sure that you and your colleagues are very talented,
> but if your employer decides to cut down on upstreaming budget,
> the kernel maintainers would be left with an effectively orphaned filesystem.
> 
> This is especially true when the client is used in house, most likely
> not on a distro running the latest upstream kernel.
> 
> So yeh, it's a bit of a chicken and egg problem,
> but if you get community adoption for the server code,
> it will make a big difference on the prospect of upstreaming the client code.

Understood, we can definitely wait and see if TernFS gains wider adoption
before making concrete plans to upstream.

> I am very interested in this part, because that is IMO a question that
> we need to ask every new filesystem upstream attempt:
> "Can it be implemented in FUSE?"

Yes, and we have done so:
<https://github.com/XTXMarkets/ternfs/blob/main/go/ternfuse/ternfuse.go>.

> So my question is:
> Why is the FUSE client slower?
> Did you analyse the bottlenecks?
> Do these bottlenecks exist when using the FUSE-iouring channel?
> Mind you that FUSE-iouring was developed by DDN developers specifically
> for the use case of very fast distributed filesystems in userspace.
> ...
> I mean it sounds very cool from an engineering POV that you managed to
> remove unneeded constraints (a.k.a POSIX standard) and make a better
> product due to the simplifications, but that's exactly what userspace
> filesystems
> are for - for doing whatever you want ;)

These are all good questions, and while we have not profiled the FUSE driver
extensively, my impression is that relying critically on FUSE would be risky.
There are some specific things that would be difficult today. For instance
FUSE does not expose `d_revalidate`, which means that dentries would be dropped
needlessly in cases where we know they can be left in place.

There are also some more high level FUSE design points which we were concerned
by (although I'm not up to speed with the FUSE over io_uring work). One obvious
concern is the fact that with FUSE it's much harder to minimize copying.
FUSE passthrough helps but it would have made the read path significantly more
complex given the need to juggle file descriptors between user space and the
kernel. Also, TernFS uses Reed-Solomon to recover from situations where some
parts of a file is unreadable, and in that case we'd have had to fall back to
a non-passthrough version. Another possible FUSE performance pitfall is that
you're liable to be bottlenecked by the FUSE request queue, while if you work
directly within the kernel you're not.

And of course before BPF we wouldn't have been able to track the nature of
file closes to a degree where the FUSE driver can implement TernFS semantics
correctly.

This is not to say that a FUSE driver couldn't possibly work, but I think there
are good reason for wanting to work directly with the kernel if you want to be
sure to utilize resources effectively.

> Except for the wide adoption of the open source ceph server ;)

Oh, absolutely, I was just talking about how the code would look :).

Thanks,
Francesco

