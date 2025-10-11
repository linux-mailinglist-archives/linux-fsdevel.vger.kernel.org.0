Return-Path: <linux-fsdevel+bounces-63846-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D502BCF770
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Oct 2025 16:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CCB7189BB73
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Oct 2025 14:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200251DA3D;
	Sat, 11 Oct 2025 14:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="T64Y5qW8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TqeMkf8Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D8511CAF
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 Oct 2025 14:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760193311; cv=none; b=Bh7d7icRKzcd5py8cYtxT2gC2EsHAok9R7iGizaMWfgFGXxBPEHu0SKa2tEa0RqhvYtjXaJD+db1pxnHUEC++slB41K8FPZL3zEdYjkzwcOgYEbKtvdhXO0DYaz3+CtSXYClI+OnM+R9ZKSdiPmlFBoFcIqNsMqW0R0DhQANh1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760193311; c=relaxed/simple;
	bh=fMeAIRkGA1ZD2jkYoaDRyMgY8CpugXxqQ7KPxYpofEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tyNAKPw/1m9R7Q4g2UVQ6p4gtQ87dNU4APkkpv3lFmO2lpVG2azfuxPtYllZrEGECjkocF9vAZk0Tewod1AV56v/nVxyCPMD3CaeV9VZebuGFvONHXcMCXXR2FmYx9iahbna115OlYupc7pJsEDo0aLEgC3D/Q16CwRvwBd25YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=T64Y5qW8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TqeMkf8Y; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 5CC20EC01B1;
	Sat, 11 Oct 2025 10:35:03 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Sat, 11 Oct 2025 10:35:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1760193303;
	 x=1760279703; bh=fqA3IJpa71URjLPGjVHLpjDH6wmJesXXN2GBdp+T95k=; b=
	T64Y5qW8Yu0m4OiONYTmA1Iz52B17GfLQ5BwPvczgF4OfgDL25L+lqz/tZk2i5S9
	yx0zkpP1BkOMSDEQ1uTIPiC2L0ynr97XN5jAzELSQnjy/qmvH+wajqb+mKZMtEci
	X6WkS4NFKG4q4nA3kiWdiGs15+gsTw5KDqNh6WGyvoHrgOZB1KwJlq7KV4ygZ/MU
	V3w3pmdleq4IESnTMdZVldbVynUTn8RdRYKKnFeNoiKIRHDQ7ilXz8edECTkKFta
	OOIDu1YAF60h21WbJc8uVItF8N8itks4RuLQGFyx7egTYzSjN5Thde7fZNRh+iON
	DTAsfu17EoYfC/k5BtzATg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760193303; x=
	1760279703; bh=fqA3IJpa71URjLPGjVHLpjDH6wmJesXXN2GBdp+T95k=; b=T
	qeMkf8Y43QCIMcdG1fqyylHwQO3UQ79B3ecWNNMVy0KSA9hJ+fPvnvtTFTuISzyY
	pQfpS5M+rIR+omfTlOnxIbSkJOH2aSHDKGm8k29BGIYBlUIYeTvCd7uyHZWFpvNn
	deJ/kPxEOTuF1setfoPEhywsvVCGf1Sm2HUYxz4Ys0vtQWoVErIBLUCj2U/62dis
	QCfzKbopQNf0gqDZVKepHD+dErZg9nmIDIRzxmh5RwCOO6o2ZR8KYJAD2JzZyj0s
	1C9y85Poj15mrLxMuAk+FKjTPiIRviDdiM+jfd/pXsdtXyWYFWoa3IXOYKZxuoqi
	yr5pvEGbm9JSNWL859Fmg==
X-ME-Sender: <xms:FmvqaAC7EVdAAWYDKFIYbh9ZQ2ZYXzUGNQVejeZNw0rZn6_Jxi3w8Q>
    <xme:FmvqaOicRkVxHhdOoXVsmjGSe-Jr3-1hzmkWHlrHp9ljjZmZSms5Ei4G5YNoUgJEF
    2TgiIS1_Hw18BBuUZnQHq-WuFDkuBBhH-qE14OzFCjAQrJReX_RVBg>
X-ME-Received: <xmr:FmvqaFyPrEgGiH9xXkXjIaaTBTwnEgJVuQvYXV4a27dR7x2Gpuw2VzMCigb1L5MIbk4_lGaM4nEJMQkgqrQN0Uau>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduuddvudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpefvihhnghhm
    rghoucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepff
    ffveffieethfdviedthfdvjefhueeiffffheffvdegheeggedvudfggeehgedunecuffho
    mhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehmsehmrghofihtmhdrohhrghdpnhgspghrtghpthhtohep
    kedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgvnhhtrdhovhgvrhhsthhrvg
    gvtheslhhinhhugidruggvvhdprhgtphhtthhopegrshhmrgguvghushestghouggvfihr
    vggtkhdrohhrghdprhgtphhtthhopehvlehfsheslhhishhtshdrlhhinhhugidruggvvh
    dprhgtphhtthhopehnvghtfhhssehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthht
    oheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopeguhhhofigvlhhlshesrhgvughhrghtrdgtohhmpdhrtghpthhtohepvghrihgt
    vhhhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhgthhhosehiohhnkhhovhdrnh
    gvth
X-ME-Proxy: <xmx:FmvqaH2SyR1g648Gw9ufR1YmyOMBVkHCNx0r9cJXp4Ql6FKm9HiKng>
    <xmx:FmvqaC-CycAiy9anI9hEolqiJ3RXk8OO-OTJsodG7-g0wjonNZRdTg>
    <xmx:FmvqaHpdo_NvHCOtuQawZYQ69B0sfygMZJfRNIIkEhi5fioYc_O69Q>
    <xmx:FmvqaMSYgvy9g3fvF2Wzszdf63jjiuUpcXwo9GG_nA7sfyzGu7z8xg>
    <xmx:F2vqaCyLOaPIPp40VY3Wp6xNZbha2XeIWwOTg4-dMZh9jnpdaDyDM3dA>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 Oct 2025 10:35:01 -0400 (EDT)
Message-ID: <da9b0573-506a-4ce3-88f3-b1714b32db5f@maowtm.org>
Date: Sat, 11 Oct 2025 15:35:00 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: -ENODATA from read syscall on 9p
To: Kent Overstreet <kent.overstreet@linux.dev>,
 Dominique Martinet <asmadeus@codewreck.org>
Cc: v9fs@lists.linux.dev, netfs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>,
 Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>
References: <hexeb4tmfqsugdy442mkkomevnhjzpuwtsslypeo3lnbbtmpmk@ibrapupausp7>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <hexeb4tmfqsugdy442mkkomevnhjzpuwtsslypeo3lnbbtmpmk@ibrapupausp7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/8/25 18:54, Kent Overstreet wrote:
> So I recently rebased my xfstests branch and started seeing quite the
> strange test failures:
> 
> 00891     +cat: /ktest-out/xfstests/generic/036.dmesg: No data available
> 
> No idea why a userspace update would expose this, it's a kernel bug - in
> the main netfs/9p read path, no less. Upon further investigation, cat is
> indeed receiving -ENODATA from a read syscall.
> [...]

Hi Kent,

Not a 9pfs maintainer here, but I think I have encountered this in the
past but I didn't think too much of it.  Which kernel version are you
testing on?  A while ago I sent a patch to fix some stale metadata
issue on uncached 9pfs, and one of the symptom was -ENODATA from a read:
https://lore.kernel.org/all/cover.1743956147.git.m@maowtm.org/

Basically, if some other process has a 9pfs file open, and the file
shrinks on the server side, the inode's i_size is not updated when another
process tries to read it, and the result is -ENODATA (instead of reporting
a normal EOF).

Does this sound like it could be happening in your situation?  This patch
series should land in 6.18, so if this was not reproduced on -next it
might be worth a try?

I hope this information is helpful :)

Tingmao

