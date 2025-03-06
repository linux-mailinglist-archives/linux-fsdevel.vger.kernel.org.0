Return-Path: <linux-fsdevel+bounces-43383-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8ABA556F4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 20:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29EC11898229
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 19:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3BCF26FA4C;
	Thu,  6 Mar 2025 19:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b="POgOjkl7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fMA7NqF4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD20DDA8;
	Thu,  6 Mar 2025 19:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741290004; cv=none; b=eTmOU6A5evSfejpkaYk44rLjVtCZcn+LfzwFL2aW7P0gJk8b3xYYMPwBwhsm0DbWW8/txvMdICPLJX0bhS/KbH81J0P6Yzg/Kfnw5M5MsI8TlLsMqK8XfhMoK5CL3b38Phi5GI24G7kqWzyLX6UsBnlq6QwjRCIyYOXP+R7IPMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741290004; c=relaxed/simple;
	bh=WW62Pr+2vyiq34TRqGp71vBMBra8C0VpXJwzu86jBNQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=IaS4c/zWLnB7b2l7FlvlEvhJxRpSbLIclNyY6hwfmRATbCpzcGsXZz2IiGO8No7LhFvhwR310WIxPooaMivI4AWa1N2ossuBuhPkvbk+YTfSik+7oWGgDuoEgFpJe/GS4feFFE6RVLcCpZ4ty53UXBdDTaEMfmCz0LfxwkVitPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev; spf=pass smtp.mailfrom=svenpeter.dev; dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b=POgOjkl7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fMA7NqF4; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svenpeter.dev
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3A9501140177;
	Thu,  6 Mar 2025 14:40:01 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-12.internal (MEProxy); Thu, 06 Mar 2025 14:40:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1741290001; x=1741376401; bh=MwAYJwbtPEdvfmZY6by4HNRxoaKm4GTn
	paPzZObN9tw=; b=POgOjkl7OAfw52Cv025UP30xbZr94NZXHkPoIXvNoGZEfSx/
	hZvBEvXL4NgsF0pa4iGJPP7D8haTTOYKI3KtNkYa9Bx/7c0T4KOK10t49gRLd5WK
	ShuXr9YwNMEqRWtmXPJdDvw+/9KFuIEYtP14K2Gqarsa42Q255rH6rOQ7KmRnSQk
	xx7hTh2vblyBYcagwW42G8gBCOPaB4qotOKqrw8aA+UCFMWxOEcEkRXqj3hhD/qY
	/imLgake66Cj/i6N9r/aCQI4w4LYDw2el+0ImSvm8rI8kVFoS6siCCSGOPbq76Lt
	0cksjZLChEQDEa4MiSFH+sKrNqzx/CyEOFZnMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741290001; x=
	1741376401; bh=MwAYJwbtPEdvfmZY6by4HNRxoaKm4GTnpaPzZObN9tw=; b=f
	MA7NqF4MkY/RtzPDcsWYcZNmtgku9vIzYrbREBghwRAh3yTw8cvIAnV2rVsl9qbD
	ZLDxDKRRzAf03uNSkHM9NZ2zkSIlTpJiZIWZi0ewrAATUEeKwcRnn57AHRi5Ffo9
	OaKn4yAWWZYUde3huF4FFSSOPpewwQC7j4YgDrU7flom2rhhy076ivdFvV49DNfH
	jhXGrDbrpDjYyC2d09cXjKGGD8Prs8Cmp0tXrveaidVU75M3p/Tq0BvHBR/Mo4jo
	P0cmCNwwT4M1BR2bl1rj+3FQ1+L5QTO8Af9fWkr2VJcLZIOcDvAysPeedh7EX1JE
	Qn+xjoWFROPisHpd938fA==
X-ME-Sender: <xms:EPrJZ1lpCVd-emq655nbe36q_MoCMaRBi1HjA5mNl3ba3YU0KGTy1g>
    <xme:EPrJZw3tqRfIH4VbFKHSoRtHGIwH60cR0ZFXlGSyQU2OcHAIhEHQ2xZxNWyBJxavQ
    Z9S3SGi4C49vSsxing>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdekieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertder
    tdejnecuhfhrohhmpedfufhvvghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvth
    gvrhdruggvvheqnecuggftrfgrthhtvghrnhepuddvieeutdelvdekkefgtdfftddugeeu
    vdeuffeiuedttefggedtfeeiteehjeeunecuffhomhgrihhnpegvtghlvggtthhitghlih
    hghhhtrdgtohenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehsvhgvnhesshhvvghnphgvthgvrhdruggvvhdpnhgspghrtghpthhtohepkedpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepvghrnhgvshhtohestghorhgvlhhlihhu
    mhdrtghomhdprhgtphhtthhopegvthhhrghnsegvthhhrghntggvugifrghrughsrdgtoh
    hmpdhrtghpthhtoheprghsrghhiheslhhishhtshdrlhhinhhugidruggvvhdprhgtphht
    thhopehlihhnuhigqdhsthgrghhinhhgsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtg
    hpthhtohepghgrrhhgrgguihhthigrtdeksehlihhvvgdrtghomhdprhgtphhtthhopeht
    hihtshhosehmihhtrdgvughupdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:EPrJZ7r0r4P-trjNVV3fb-R4etwnOa6A6HnSY0SgZ1_1u-4UNTippg>
    <xmx:EPrJZ1m7JVQM1qj8EBsqefzv82ihFzJwaA3XF2hboiTmI1r6fjJb9A>
    <xmx:EPrJZz1_stq9GQ-ZEzpMYUmtc2SjntFCUmn8MF9yowwgrjBDD9Je3Q>
    <xmx:EPrJZ0uXcy9_O5c1-r-yfc67V3-cH3BKizF54kWib7ZlJ8al5nIkFA>
    <xmx:EfrJZ4nUTJL8ax2nFQP2PylfRi6GQVwe8ZBRvusUVxClZYKAb9WjibcZ>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A6518BA006F; Thu,  6 Mar 2025 14:40:00 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 06 Mar 2025 20:39:14 +0100
From: "Sven Peter" <sven@svenpeter.dev>
To: "Theodore Ts'o" <tytso@mit.edu>, "Aditya Garg" <gargaditya08@live.com>
Cc: "Ethan Carter Edwards" <ethan@ethancedwards.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
 "asahi@lists.linux.dev" <asahi@lists.linux.dev>,
 "ernesto@corellium.com" <ernesto@corellium.com>
Message-Id: <4e41ef2b-7bc3-439c-9260-8a0ae835ca02@app.fastmail.com>
In-Reply-To: <20250306180427.GB279274@mit.edu>
References: <rxefeexzo2lol3qph7xo5tgnykp5c6wcepqewrze6cqfk22leu@wwkiu7yzkpvp>
 <d0be518b-3abf-497a-b342-ff862dd985a7@app.fastmail.com>
 <upqd7zp2cwg2nzfuc7spttzf44yr3ylkmti46d5udutme4cpgv@nbi3tpjsbx5e>
 <795A00D4-503C-4DCB-A84F-FACFB28FA159@live.com>
 <20250306180427.GB279274@mit.edu>
Subject: Re: [RFC] apfs: thoughts on upstreaming an out-of-tree module
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 6, 2025, at 19:04, Theodore Ts'o wrote:
> On Wed, Mar 05, 2025 at 07:23:55AM +0000, Aditya Garg wrote:
>>=20
>> This driver tbh will not =E2=80=98really=E2=80=99 be helpful as far a=
s T2 Macs are
>> concerned.
>>=20
>> On these Macs, the T2 Security Chip encrypts all the APFS partitions
>> on the internal SSD, and the key is in the T2 Chip. Even proprietary
>> APFS drivers cannot read these partitions.  I dunno how it works in
>> Apple Silicon Macs.
>
> How this workings on Apple Silicon Macs is described in this article:
>
>    https://eclecticlight.co/2022/04/23/explainer-filevault/
>
> It appears such a driver will also be useful if there are external
> SSD's using APFS.  (Although I suspect many external SSD's would end
> up using some other file system that might be more portable like VFS.)
>
> In terms of making it work with the internal SSD, it sounds like Linux
> would need to talk to the secure enclave on the T2 Security Chip and
> convince it to upload the encryption key into the hardware in-line
> encryption engine.  I don't know if presenting the user's password is
> sufficient, or if there is a requirement that the OS prove that it is
> "approved" software that was loaded via a certified boot chain, which
> various secure enclaves (such as TPM) are wont to do.

At least on Apple Silicon all you need is the user password (and a worki=
ng
Secure Enclave driver and a way to forward entangled keys from the Secure
Enclave to the NVMe co-processor). It's still possible to unlock the
encryption keys inside the Secure Enclave when booting into a secondary
macOS installation with all security features disabled (and with a
modified kernel). I'd assume the same applies to T2/x86 machines since
the T2 is an ancestor of the M-series Apple Silicon SoCs.

The only limitation that I'm aware of is that access to DRM keys
(HDCP, FairPlay for video streaming, etc.) is only allowed via a
certified boot chain.


Sven


