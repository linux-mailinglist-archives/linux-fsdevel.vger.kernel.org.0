Return-Path: <linux-fsdevel+bounces-22822-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD6B91CF29
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jun 2024 23:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB12A2826BE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jun 2024 21:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102D9140378;
	Sat, 29 Jun 2024 21:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="lGD4HYeM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pttxMWzJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC48F4B5A6;
	Sat, 29 Jun 2024 21:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719695167; cv=none; b=FTaDbarRxgMIFMgOypa4J1/OMGLARTJEo1oLjI7fehzglQoL3Y5kATrVomqEQgYwqIUDTju7yMXTGicJRF5l85NR6u91t/lcM8Hl5N+9xE3siY3O1a9b016AIS25qW4cXDTKPi/AKakauJQuLUyT1RnTSxGyD9NBKqryVKY1eSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719695167; c=relaxed/simple;
	bh=Cv2OWvyUZOVP44gprTyINkMjpObatIzOMeMYpMQ74wI=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=UCdm5ZPNEX0uMLY0PJiiRLV7YJLgAmXNtvBv23YfXqSCKvHexihn/phHyMqn2WxB7aU3f3wejLYysQSLtuVoGUCWcb+iVYTZ8tNBszBQThOlyjgsQDy3jtox0186b4aTSoVXEidiP8zGUpHNc8BP6u1vdp7Nc/dICgsHq3B6xwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=lGD4HYeM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pttxMWzJ; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 82CAF1800099;
	Sat, 29 Jun 2024 17:06:01 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Sat, 29 Jun 2024 17:06:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1719695161; x=1719781561; bh=GZ6e31l0eU
	0HBfpZN9NPc8YVWdePfL7XMhkPKJ3qUo8=; b=lGD4HYeMu3zX2B6rMUxsNDmkx9
	doj+1na9uH7lXIG/u9ZQAJqYbbXz73dRr4UpodsQfspJDFsUobxr9eGHmlkACxam
	C9QR5vMZjr+P/Jfunb0+vW6XHwuz6/R/B8rRdEzFAx6V9sfkBVl/X2PJKSaZS7w7
	QALZ2IVSAzHZ/Rp5pZvOSQ+ReI0qS7+67UnLR1DxTiaIAJRtO8WhfIELir13Wt8s
	KowmEiOSnNltszVjkhLPRDrvLE2lIcrTNAmIYfgoIsQ82Bzf705R7K98kV5uWPRC
	rkR6zyzur/prHHn25+4Q4cC7MiumgMVqejTK8vBd9QmbOmq+av4D4j25cgFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1719695161; x=1719781561; bh=GZ6e31l0eU0HBfpZN9NPc8YVWdeP
	fL7XMhkPKJ3qUo8=; b=pttxMWzJvDFMeJBUdzP3EtaS84eFVNzpH1fN/+TngLjx
	ZvfzebXM9uXNRF6iUrLBsUMkgQ2ZlV2GLzmMteHcQQCyuxAaznLHE1gcCZgc7f1R
	HJEEIlai6wwfCvlb8qkWaBw9zRn+bYE6873TAUZDCG6Ctby4zTdy8tjbqEOjCAbB
	x+GkhJ2vfBDFfbUGo3fKLjDwGNfQ5we5hmQ/fOJVhE4rLOdoQ3iFa0ChftPLGZ5K
	gFC6eRlYvq4fW6VNllWQspF2ioUbPjd2ViMAed0wVEOOqDwH3MbpBJWkVkSJAYKp
	msCkmhNAwXk8klLnCjTL5AHIqxHBVsjKJjCiCkaevQ==
X-ME-Sender: <xms:NneAZqgo27T24kaZCuGdcWmHY3T_lXiB2CE7frpx3k62jXmNovK2uQ>
    <xme:NneAZrBbrVr5saMIB7ghju2LiK0F_uqCccw_VQfZO3TSZHgjDXf8y7jrL3IfN5IPz
    TY6_qJGsdudJQvM2t8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrtdelgdduheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:NneAZiGC0HnTL2v7O8hJldRxxvy926gchW6ck74sSIX6qimfzzny1A>
    <xmx:NneAZjR6AAwezTX448A3OWJgbZecfzHh21QspyW5LAQC7Hp-aDKaKQ>
    <xmx:NneAZnyEMoamDQzK2PrFjvRyOd73uDwFc05XS_xFb-IoSS1S_kxwSA>
    <xmx:NneAZh5twLHAdNMekV7VhtIMtWXM1C-KwuF8aZ08c7bxOMj92W1SLQ>
    <xmx:OXeAZg-nhJZW9uSqHFfkndVr8i2R3r4TNMu05gKV0KZ2EnvccAfHILal>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id AB781B6008D; Sat, 29 Jun 2024 17:05:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-538-g1508afaa2-fm-20240616.001-g1508afaa
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d1408856-1d06-4aae-8b44-06e73ac001f8@app.fastmail.com>
In-Reply-To: <a913c77e-1abb-409f-86b9-8805c1451988@roeck-us.net>
References: <20240624163707.299494-1-arnd@kernel.org>
 <20240624163707.299494-7-arnd@kernel.org>
 <a913c77e-1abb-409f-86b9-8805c1451988@roeck-us.net>
Date: Sat, 29 Jun 2024 23:05:37 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Guenter Roeck" <linux@roeck-us.net>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "Rich Felker" <dalias@libc.org>, "Andreas Larsson" <andreas@gaisler.com>,
 linux-mips@vger.kernel.org, guoren <guoren@kernel.org>,
 "Christophe Leroy" <christophe.leroy@csgroup.eu>,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-s390@vger.kernel.org,
 "Helge Deller" <deller@gmx.de>, linux-sh@vger.kernel.org,
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 "Heiko Carstens" <hca@linux.ibm.com>,
 "musl@lists.openwall.com" <musl@lists.openwall.com>,
 "Nicholas Piggin" <npiggin@gmail.com>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
 "Brian Cain" <bcain@quicinc.com>,
 "Christian Brauner" <brauner@kernel.org>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 "Xi Ruoyao" <libc-alpha@sourceware.org>, linux-parisc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 "Adhemerval Zanella Netto" <adhemerval.zanella@linaro.org>,
 linux-hexagon@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH v2 06/13] parisc: use generic sys_fanotify_mark implementation
Content-Type: text/plain

On Sat, Jun 29, 2024, at 19:46, Guenter Roeck wrote:

> Building parisc:allmodconfig ... failed
> --------------
> Error log:
> In file included from fs/notify/fanotify/fanotify_user.c:14:
> include/linux/syscalls.h:248:25: error: conflicting types for 
> 'sys_fanotify_mark'; have 'long int(int,  unsigned int,  u32,  u32,  
> int,  const char *)' {aka 'long int(int,  unsigned int,  unsigned int,  
> unsigned int,  int,  const char *)'}
>   248 |         asmlinkage long 
> sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))       \
>       |                         ^~~
> include/linux/syscalls.h:234:9: note: in expansion of macro 
> '__SYSCALL_DEFINEx'
>   234 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
>       |         ^~~~~~~~~~~~~~~~~

Thanks for the report, this has escaped my build testing
since I had fanotify disabled on the parisc build.

Sent a fix now and queued it as a fix in the asm-generic
tree:

https://lore.kernel.org/lkml/20240629210359.94426-1-arnd@kernel.org/T/#u

     Arnd

