Return-Path: <linux-fsdevel+bounces-11947-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0570885963D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Feb 2024 11:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22AEB1C218AA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Feb 2024 10:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291DC374EE;
	Sun, 18 Feb 2024 10:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Xxj/ymOb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BjB60kZ7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wfout1-smtp.messagingengine.com (wfout1-smtp.messagingengine.com [64.147.123.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF70374C2;
	Sun, 18 Feb 2024 10:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708252198; cv=none; b=N/soipETMdTEe8ifHvcjqS1IEgTn7SIGWBvs8axvw2xMbuiYDDeMUv9cRCBaJosbJ3GC1bc12Crgk5nJSh9KdIfNh40xkYnIbMzF25brLGSLvdfkYKXqYLTBg5zrtvdvH7g48mcXdQ/sy/UZv4oQp9NLReN1Snkwkytw05Lz/hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708252198; c=relaxed/simple;
	bh=ufu21DiWxZYY2PtkEJELU0sA98ETiZvyf8lhN/8xhUI=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=CaJHVrqvWQyOUgxjSe5USOCJks4LYZfogmNlZc8BP+oX0oMpcCLj7D6GeNNvkzhCrL8g/9clZ1pX79CEJdHczrJFzioL+y8W0jo5y6Ib7BoWdoTT9e61R/e+DQigJlyiDGvkPrIZpOESutJhG1Z+Ghzr9ufaetMwbvMqjF5TrHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Xxj/ymOb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BjB60kZ7; arc=none smtp.client-ip=64.147.123.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 4903A1C00091;
	Sun, 18 Feb 2024 05:29:54 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Sun, 18 Feb 2024 05:29:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1708252193; x=1708338593; bh=wvWbnsQkj4
	q09CebU8XF1EAFsfblqr/+huPfno1vUNs=; b=Xxj/ymOb6AtEOsNK1eV7Ou8FAH
	O8F5SmLQ0fEZrKGCW3U2dc24m+SkCyu7IG94E2M+1mmZMo/rBi1MzLass+VVfDnr
	CZmDe1sp0UY7oFBi+OhPKbkC12hGlSKKDlgmBcPYo9lMeRHnhR30tRCrA4SWCXIu
	n2yZ9ibphH9kViUUtUFh7oOa7euVlO45Ej5pHfNPEZlPujeOp10994kuh1I6tCc8
	a7Q/BrsP+oSN0+FAWrinWGGBF7eWHIMY6tt6RO5vHL07q5MDUz6OD7ktVUbsm19h
	Or5gm7ry6NvbyZbjc3+MmyKSpmHMM8Cji6HfC9giMHiO9B7EC0J+TuJ7zlFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708252193; x=1708338593; bh=wvWbnsQkj4q09CebU8XF1EAFsfbl
	qr/+huPfno1vUNs=; b=BjB60kZ7OHneALkK3bPs3Ya3upMX9P/TuKg7p5H/0d4a
	CJjppOxcN6YjW3Hwl7BTLhMR5AYzKeQoYSn8WJF2OOG6ZJJmQzxTq9gfLIs9p5M+
	P2D+H8VwfFSx+dZT1ryLhBou9un8hcG7p0D798xWn35R8RmSn9oB8LKlmZWDKFSy
	fVWfBRSzzl2HfaqXvBFU1OcJwfw6XNG0Ao3f7kkDhsmGNSZT9To7SYIPfGctJcyY
	fbC4PXgE8MHNBNH+OcNUb39nSdRQI5LBP1jb+WgAEttClqxeT7Sc1y8hpYC2DA3i
	zBokALVHOYMQy+Xw0lQA6IrGTwueMzMreV9QDShhug==
X-ME-Sender: <xms:INzRZUcAzvqotltzQGr6jtVeWIazlU0sqqjh5EJLD76JtjoAWsEahQ>
    <xme:INzRZWMEYPlrbfAs2wz9cpTTzqWzLDKZ0WAHXxaiJMdbY6wKgdGg2_hHeSal86R85
    _rZBbEc9OFtweAXnis>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeigddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:INzRZVgod07_0p87nl5sRB9w63-VEhTrJ4VNLjxUONdSO8toYuzQKw>
    <xmx:INzRZZ-p_jzUpZ8kdbAY6glw5YmeyIWFngQ6eXzPlpMlh2sKIQdRKg>
    <xmx:INzRZQvXqkEB6Njib6zYfFe3bOZgC4CWwH38cdF0qVn10dnljgWviQ>
    <xmx:IdzRZdPFPiSDov-DsahK-l5TKYHo91EzHOca1b2h6hquvhoXpxfop3bWdJY>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id AF6AAB6008D; Sun, 18 Feb 2024 05:29:52 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3a829098-612b-4e5a-bcec-3727acee7ff8@app.fastmail.com>
In-Reply-To: <ZdHZydVbQ7rIhMYV@tassilo>
References: <20240216202352.2492798-1-arnd@kernel.org>
 <ZdHZydVbQ7rIhMYV@tassilo>
Date: Sun, 18 Feb 2024 11:29:32 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Andi Kleen" <ak@linux.intel.com>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Nick Desaulniers" <ndesaulniers@google.com>,
 "Bill Wendling" <morbo@google.com>, "Justin Stitt" <justinstitt@google.com>,
 "Kees Cook" <keescook@chromium.org>,
 "Andrew Morton" <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] fs/select: rework stack allocation hack for clang
Content-Type: text/plain

On Sun, Feb 18, 2024, at 11:19, Andi Kleen wrote:
> I suspect given the larger default stack now we could maybe just increase the
> warning limit too, but that should be fine.

I don't think we have increased the default stack size in decades,
it's still 8KB on almost all 32-bit architectures (sh, hexagon and m68k
still allow 4KB stacks, but that's probably broken). I would actually
like to (optionally) reduce the stack size for 64-bit machines
from 16KB to 12KB now that it's always vmapped.

> Reviewed-by: Andi Kleen <ak@linux.intel.com>

Thanks,

    Arnd

