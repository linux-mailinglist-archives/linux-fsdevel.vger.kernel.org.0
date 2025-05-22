Return-Path: <linux-fsdevel+bounces-49679-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF95AC0D7D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 16:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBFA63A3502
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 14:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94C917A30A;
	Thu, 22 May 2025 14:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="GbDFzeqM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SHVXjK92"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDBC12E7E;
	Thu, 22 May 2025 14:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747922550; cv=none; b=k8/z/Xik3Xqy+BHxB8PI2OQ0fHCARBn1eAjEjvHn9TSvWpJ1FS6qsLs+chhBKKP0K5mu6PsrJAYx6zGdt2f7/wEYTJjuJgtIZqRSLuvV0Zhq//t5waukM4HOnYyewaeXPiOTWFeVdecFslwGm8TKSLr1+C/S8WljymOwkbm9v4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747922550; c=relaxed/simple;
	bh=VKDEPzwby3mBDQ3BsLrh1Y11pUMU7WCO46ezVRwnuYI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=cIdtZniLsYsESY662xzX0QDzpGPKQrOgztYQ63TvGXt1gOd3CSysvNIt7YX/Af8Jx+ImlugOY5CTXlCcvSQ4bDM5BVdeXoDAdwoP31wt/iRev3qwuRBgT2xCWoeTp7ab0MJGHtWHkxm/8m8HNxcipG3qcdOQ/mjdbXvjnKtmUeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=GbDFzeqM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SHVXjK92; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 90C9A1140161;
	Thu, 22 May 2025 10:02:26 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-05.internal (MEProxy); Thu, 22 May 2025 10:02:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1747922546;
	 x=1748008946; bh=LfW+1ywcWa9OhtIkbg/ys95rDhhPMEoOa3R2KQwbOuA=; b=
	GbDFzeqM+YW0vnFa5HSFfMWEoD4LZrTUjeEP2fQ1+8y3h+UcDI2vPDWvl8/Gm2/A
	5FONauhwL/y71YlOvo9rqMB120rZRH1NlXy3lrRoQuw3nvI+/2zCRy4i4KSzmG9G
	W2HZ/pRk1FBKzUVdPxwLBpAS4rxeHGJInO+AHITHPswqnQNOJXux0cLYylH4lZpp
	TnH6vODOWe+8enZ3cQvphei6pverOgeZBuFz2JOh7+6q7htWUirh3e8VtoitF/Rf
	OO0i8O6sGzrptB7QeenvRU2z1yEIGPFK4NwKz/a7PhrQkHhkafTE3789S4YOaX/M
	kj+aEAFyck6M47uCxRvx+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747922546; x=
	1748008946; bh=LfW+1ywcWa9OhtIkbg/ys95rDhhPMEoOa3R2KQwbOuA=; b=S
	HVXjK92PV+H7079UBzPU1fnix++TF+Dzl4KDq9YJ99FU7yMClNDsIFI+y+6DYDt4
	zxkujlFmTa6TG0/iEL2GWf83cnOcQFkLaBqTeV4e4gJGjnyhJ+oxeXjEMAUMdiMG
	tPVnp17lZ5Gym4y1EUhazMwwni3YRfWmhB0OaLsEZU+ivbvQRdW5LxzLr7GF4lr5
	IVsZo3EEFeG0JtnMxvI7feFsjayTc1Dh4Nkj1r4DfyQopWTNyMcreS0rwJwx4iV+
	+SSlKLVebiFzAFiG3QPns+nQA/bLP3TKf4SPi8CiRisCX7afOer97qXLeDxUrK3u
	OATPyaKI8b3olkyBW2H3g==
X-ME-Sender: <xms:cS4vaBVOYY3rEskCqDVh2akO2Ij8iYYyoFE0A71xPvRRUiXGh0TWpA>
    <xme:cS4vaBk55xcyMDRK6wietN7pGJTQmBXis2-OkX8bjF1ndMmhqicjvcXf_llmel4JC
    FQ_wPSD8rWTKWs-sPI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdeiudehucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgj
    fhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuc
    eorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedu
    keetgefggffhjeeggeetfefggfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdp
    nhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtsh
    gsohhgvghnugesrghlphhhrgdrfhhrrghnkhgvnhdruggvpdhrtghpthhtohepsghrrghu
    nhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnuggvrhhsrdhrohigvghllh
    eslhhinhgrrhhordhorhhgpdhrtghpthhtohepuggrnhdrtggrrhhpvghnthgvrheslhhi
    nhgrrhhordhorhhgpdhrtghpthhtohepnhgrrhgvshhhrdhkrghmsghojhhusehlihhnrg
    hrohdrohhrghdprhgtphhtthhopehlkhhfthdqthhrihgrghgvsehlihhsthhsrdhlihhn
    rghrohdrohhrghdprhgtphhtthhopehrvghgrhgvshhsihhonhhssehlihhsthhsrdhlih
    hnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrd
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:cS4vaNYdLDNra9fF1YVk2NtYD8SJ1t6bgUBTzEjtGVlNr56zMdRcTQ>
    <xmx:cS4vaEVkwsZ8t8yX62g5nHG1WwBacxmRtaLacRIRxnKHw1Of5GhZYg>
    <xmx:cS4vaLlzusj6YyeYGNDdDh9g2HLATjq8lUFZ9NUl6bydAGrGXHYaQg>
    <xmx:cS4vaBcYzphX9IFTuy-UhheITIf5WIuJwYcMXppifPRl5mg-hidQ9g>
    <xmx:ci4vaOMUgefLcA-xlUGszgK2RG30yfnFE5yyjnaKI8CkkIi_9E4VTbRh>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2B50D1060063; Thu, 22 May 2025 10:02:25 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tc6af0bd36d39ecf6
Date: Thu, 22 May 2025 16:01:53 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Naresh Kamboju" <naresh.kamboju@linaro.org>,
 linux-fsdevel@vger.kernel.org, linux-mips@vger.kernel.org,
 "open list" <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
 "Linux Regressions" <regressions@lists.linux.dev>
Cc: "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 "Anders Roxell" <anders.roxell@linaro.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>,
 "Dan Carpenter" <dan.carpenter@linaro.org>
Message-Id: <70d46cd3-80f4-4f5e-b0fc-fa2a6f284404@app.fastmail.com>
In-Reply-To: 
 <CA+G9fYsZPSJ55FQ9Le9rLQMVHaHyE5kU66xqiPnz6mmfhvPfbQ@mail.gmail.com>
References: 
 <CA+G9fYsZPSJ55FQ9Le9rLQMVHaHyE5kU66xqiPnz6mmfhvPfbQ@mail.gmail.com>
Subject: Re: mips gcc-12 malta_defconfig 'SOCK_COREDUMP' undeclared (first use in this
 function); did you mean 'SOCK_RDM'?
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, May 22, 2025, at 15:22, Naresh Kamboju wrote:

> ## Build log
> net/unix/af_unix.c: In function 'unix_find_bsd':
> net/unix/af_unix.c:1152:21: error: 'SOCK_COREDUMP' undeclared (first
> use in this function); did you mean 'SOCK_RDM'?
>  1152 |         if (flags & SOCK_COREDUMP) {

SOCK_COREDUMP should be defined outside of ARCH_HAS_SOCKET_TYPES.
How about reducing the scope of that check like this?

      Arnd

diff --git a/arch/mips/include/asm/socket.h b/arch/mips/include/asm/socket.h
index 4724a563c5bf..43a09f0dd3ff 100644
--- a/arch/mips/include/asm/socket.h
+++ b/arch/mips/include/asm/socket.h
@@ -36,15 +36,6 @@ enum sock_type {
 	SOCK_PACKET	= 10,
 };
 
-#define SOCK_MAX (SOCK_PACKET + 1)
-/* Mask which covers at least up to SOCK_MASK-1.  The
- *  * remaining bits are used as flags. */
-#define SOCK_TYPE_MASK 0xf
-
-/* Flags for socket, socketpair, paccept */
-#define SOCK_CLOEXEC	O_CLOEXEC
-#define SOCK_NONBLOCK	O_NONBLOCK
-
 #define ARCH_HAS_SOCKET_TYPES 1
 
 #endif /* _ASM_SOCKET_H */
diff --git a/include/linux/net.h b/include/linux/net.h
index 139c85d0f2ea..f60fff91e1df 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -70,6 +70,7 @@ enum sock_type {
 	SOCK_DCCP	= 6,
 	SOCK_PACKET	= 10,
 };
+#endif /* ARCH_HAS_SOCKET_TYPES */
 
 #define SOCK_MAX (SOCK_PACKET + 1)
 /* Mask which covers at least up to SOCK_MASK-1.  The
@@ -83,8 +84,6 @@ enum sock_type {
 #endif
 #define SOCK_COREDUMP	O_NOCTTY
 
-#endif /* ARCH_HAS_SOCKET_TYPES */
-
 /**
  * enum sock_shutdown_cmd - Shutdown types
  * @SHUT_RD: shutdown receptions



