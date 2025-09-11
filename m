Return-Path: <linux-fsdevel+bounces-60982-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2DBB53EF3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 01:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CAA67BC924
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 23:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778B82FABE5;
	Thu, 11 Sep 2025 23:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Ln87lhGr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BazkyKiT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1302F99A9
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Sep 2025 23:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757631757; cv=none; b=twDSpjCtjspcwaT4DN4QL6S/TiYQxMrXeZIlBJ9W2c7Z+Q9XKLMksdF76NA+mAZO5d+0DLFdpfSRbA41A28YH45Q6EVIQJZQAkKKNm8TzHsLNwU4CL6gsDNey/6ZDyPTIFfzjfvVzTNhXvuNIoszgjayvbxwzWMD4NZrp3Oc4XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757631757; c=relaxed/simple;
	bh=4uq60TjnjzVeYeGd52U7m7mDFUotIHICygHwfDlDbLY=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=bRuMnUzd82L98OFmLxEb5Brxqy92AM1ra8tvEGBMdErtZ+oJG2cDD4aA17aGyh5YvdmZEFp+8d+imAJplQ58AsBn+yF+OvYu270AsYerqSo5QkPPQqmVf+AdvN/BeFyUyxeY0XqyX9217YOj17T7IOGAoszVvwRYSeQDrEtWJGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Ln87lhGr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BazkyKiT; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E7A1914002F3;
	Thu, 11 Sep 2025 19:02:33 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 11 Sep 2025 19:02:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1757631753; x=1757718153; bh=4O35zT/IUgJeFzosituEW0yXf9KO/i123Si
	uqaKX398=; b=Ln87lhGrY2wLIZg7h/BgpuFXjtd3u+k+XepKXUhBGfSge9ENuX0
	UJZQVW7DAy6VuYRE3iBeXqw+nrWUW/rgvg46zUeXjtDN1AXvvKFq9u7VOgtCwSY2
	UlUeF53NGdH4a2OWc08EORWTKPSII6Je1ZkdpXEgtwKbsTV/N7kwCs+0X8bETp3I
	o2W2R/5PX77ZsTvPZL359vtO5drmpGpnOzt13u/Q5Orye8GPY1YI+Gqax5ewGWW1
	Zt6RvkRWfQDqbU1DGyjmWegxcjLoO9eM6j6ygp+mnlh6QH8uoOaBh74X3COFRZ7H
	/GLsMSxzYtCrh3MFazpfRZO+LsEnO3g7P9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757631753; x=
	1757718153; bh=4O35zT/IUgJeFzosituEW0yXf9KO/i123SiuqaKX398=; b=B
	azkyKiTVBIHlBdzv6IPv3f6ZFKDfhPfiiLMy4TlhVBBHFYz1SZRqarzV5FZmuOnP
	w8OJMLMLJnm4/txh0HM3Ogp6Y7qWDBw8ek7hr1zVgH7hUvBwmS7wunCSU16ujTD6
	Kvsj6LniC2tlaIFpWH1m3/qNQQOWELdJ8YqPlHazIfphol5fOsb6k5GmgjmlkKkw
	UCq6dsrBiogDlAzB+AW7Ftxa1eCpKAmzTpe26EM6ivqcvk0GIwfiOHwUJqNZTn81
	WTgon2NQ4g/NySm1mo53aBZ1tU8jF7FVzEcMe8N09egTNtcqjqbmT2wa6rIQfd6Z
	pT9nMgg/4HmpuvmiX2hRQ==
X-ME-Sender: <xms:CVXDaKrqsiP19oWxQdSXyNq6WQpyDpJuvm9AsrheIAANuVuXyfvaLw>
    <xme:CVXDaAAdw8D8w3vud6Ms814LK8qqwaoWw6JV9z88tcl-Mfcw5hiR64SlR8lHxiHQf
    355_H65tl6h3g>
X-ME-Received: <xmr:CVXDaExd7xnY8n6PvvvdmdxXq6iMsqaiyEfsqElnVMtnK9Yexq1XXgagx82OKeXfPBtYmy9crPMkbjXZxTGbmxpEEqwYzZ9MD-aCyM8CvjoH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvjeeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghfhrvfevufgjfhffkfesthejredttddtjeenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    ekhefhiefhtdekkefhheeggfffueeifefhfeekjeeiueegteejlefgteffleekgeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtg
    hpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehjrggtkhesshhushgvrdgtiidprhgtphhtthhopehjlhgrhihtohhnse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegrmhhirhejfehilhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:CVXDaF3dEO6Fh-9sCY9WIqtRxbj9bBM-R5QWIOm04glzISmeNm8heQ>
    <xmx:CVXDaMw8e8ofJ82kP-dkzw_LqKgmTiPluM7gcinpnmns0KfOHQ9Elw>
    <xmx:CVXDaEH_3CpMUtlGfNASiepeXhtD5WJAWz5g8VtGScjYXBdaz1K4tQ>
    <xmx:CVXDaHZ0ps2M3Vgfa4NQxh9FmK-Er0BC2wKHU7Nbj4V12e03ftVdEA>
    <xmx:CVXDaHbAnGCjnzxAzEPFQx6qbue5U0xWShnv_GHimcf8o8CgiLzBMHGq>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Sep 2025 19:02:31 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
Reply-to: neil@brown.name
To: "Al Viro" <viro@zeniv.linux.org.uk>
Cc: "Christian Brauner" <brauner@kernel.org>,
 "Amir Goldstein" <amir73il@gmail.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Jan Kara" <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/7] VFS/ovl: add lookup_one_positive_killable()
In-reply-to: <20250911200559.GW39973@ZenIV>
References: <>, <20250911200559.GW39973@ZenIV>
Date: Fri, 12 Sep 2025 09:02:23 +1000
Message-id: <175763174394.1428249.161680562107118369@noble.neil.brown.name>

On Fri, 12 Sep 2025, Al Viro wrote:
> On Tue, Sep 09, 2025 at 02:43:15PM +1000, NeilBrown wrote:
> 
> > Note that instead of always getting an exclusive lock, ovl now only gets
> > a shared lock, and only sometimes.  The exclusive lock was never needed.
> 
> what it is the locking environment in callers and what stabilizes
> that list hanging off rdd, seeing that you now run through it without
> having dir held exclusive?

rdd is per-thread - always allocated on the stack.
In this case an iterate_dir() call has built a cache of a directory and
the maybe_whiteout and been constructed of everything that is DT_CHR.
Now, outside the readdir lock, we are lookup up each of those to check
if they are really whiteouts.

So no other thread can tough this list at all.

Thanks,
NeilBrown

