Return-Path: <linux-fsdevel+bounces-49968-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9AAAC6687
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 12:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 912874E3D5F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 10:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD3810E3;
	Wed, 28 May 2025 10:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kode54.net header.i=@kode54.net header.b="UMj86KVn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nqqf7JzF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD24E274FCE;
	Wed, 28 May 2025 10:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748426443; cv=none; b=scdeEb5Xp0iPssW4UopFSh8RLjaO2YjVE0xvjv6D55K0NFK9lpR1aSQYTQ+NCZOW5HMSa6E0b4nsZKs8azjW7utn24LhZCHShKqh59iwcamJ3fGZJgbq/MUYmUc7ufFG8ddG4i6DUvrfr02uXZK7MalzURtm0uBfdZLfD0VT94c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748426443; c=relaxed/simple;
	bh=WQeTlHuVSBJoVN4kE4XxtFen/lxCvh0cIB1WExXu+rE=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=hPj2m7QbYuIdKfwtnajgIa404hh5c1K+JyZm0s0bsk2+36qlWEoqp9XQ1MWvS7w0BirkF2a+os8T7dTqLvt8aMdKekfM9HDJdE0g5bdDQ6s30zu/E5Xbc4d67tBEgjH7opQ2pQhB2yhmW81HUqc6RlvN7mo2MyW5LnMfXGusC1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kode54.net; spf=pass smtp.mailfrom=kode54.net; dkim=pass (2048-bit key) header.d=kode54.net header.i=@kode54.net header.b=UMj86KVn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nqqf7JzF; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kode54.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kode54.net
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id D8B07138270D;
	Wed, 28 May 2025 06:00:39 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 28 May 2025 06:00:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kode54.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1748426439;
	 x=1748512839; bh=eV4x9DFHlcFo11zyF70Wii41wecmfGe1saKF1QyZteg=; b=
	UMj86KVnVkk9x4kxSTJn398QXEufLltreS1u1o8VijElPbOqAIRxvZtD6hBnEnwI
	JA7SLMM6R93+xe8hbheD/eP5I8wpNdttxSxMjebZUPC999tX3KUXHYldkMDORc8f
	NC4ogrZsqFYqkizkS/4VNs2jVQMRF0cJB9gDqp2ILOnwCnYa2LGfBrdtVcI8oBVn
	7jQ5vvWzh+CoYTR99GImMX1nyKYdxhLY2iymc2508FkWVC76YgisDzUK5hpiAHsa
	8HWvy46ph6qcpBa6bjnXYwOEkSaYj9324St90GtHhnVQCbroj6izcZSDkzbH/dFd
	saQjVMA5KgefmcxAH4soFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748426439; x=
	1748512839; bh=eV4x9DFHlcFo11zyF70Wii41wecmfGe1saKF1QyZteg=; b=n
	qqf7JzFpU5LxnKowSZ4sr1iecrmSRZn04ZpK3yQH35os2zW0JmlYz/7xy6BCklJW
	Lw19+PkmeCeFgLSOnD3ogUEL/iD5djEQgnNTh4SB7zPfD9+6txGG6+ySfuHJUhqJ
	MYjvPt1e0qgcKxwUZ9zASdQ7rjq/iFhe55mFgZZMn9qITs5Us/gwoWKmFaIu6M1J
	stL9EmXQ0QO7zakobDRRRyEqx6W+C1KYjwVqwI5gQYDVWR+aqOFfYARu11e6Q+fZ
	zp9P2W9ouxXa7PeRgBrCTjQDAHzGcf7FEHFVJPvKcxbhf/lVsbWEEBNT/fgl75ia
	cKU/bylVEmOYVs8WZAhEw==
X-ME-Sender: <xms:x942aKc5FrRDD1sYuINC_LnkbU1_wJ3Z9wDZX3gP_k764qkjXaV80g>
    <xme:x942aEOyLOU0EzqkXFH5ptTE-51UxugRK_4Oua2ApsfNHbzpa9mKHYWvTz85RcUEO
    -Eun6ImqbVlwjqG_Uc>
X-ME-Received: <xmr:x942aLhwVCO0FnsNg3m-JxaIXucFNlXQDGvoK9o-H_o7gSAz55m-uf0PlWM-SeeNK8Y3ecqnDouyguH-zPnf8upc_CwcL2iwqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvvdeljeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegggfgtfffkvfev
    uffhofhfjgesthhqredtredtjeenucfhrhhomhepfdevhhhrihhsthhophhhvghrucfunh
    hofihhihhllhdfuceotghhrhhisheskhhouggvheegrdhnvghtqeenucggtffrrghtthgv
    rhhnpeeijeelkefhudekueekvdejtdeuueelteegvdeuveettdekjeekiedugeegteevud
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhr
    ihhssehkohguvgehgedrnhgvthdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepmhgrlhhtvgdrshgthhhrohgvuggvrhesthhngihiphdruggv
    pdhrtghpthhtohepjhhohhhnsehsthhofhhfvghlrdhorhhgpdhrtghpthhtohepkhgvnh
    htrdhovhgvrhhsthhrvggvtheslhhinhhugidruggvvhdprhgtphhtthhopehtohhrvhgr
    lhgusheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheplhhinh
    hugidqsggtrggthhgvfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    lhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:x942aH-6vKaUwCdpcQxktyla0Yut1_YwlSPY1nY9TTYTSnglESol7Q>
    <xmx:x942aGtGQdk0348b9oihzzecNN8iIpcUb6cYqLgsUkrmdcubR7LdbA>
    <xmx:x942aOG5mVvIcxicGbUuUPhZgKq39eYphjwoTCNYIu0cjKfiq1NBew>
    <xmx:x942aFPcfQkWGI6VtKFgq13sbwz89_YzFpek22la9-zjI7t32ajY-Q>
    <xmx:x942aPW5c4arKAfoY7TncaYrgRdrdS0iSqwaGsQfplAvs7EisPI-lZFx>
Feedback-ID: i9ec6488d:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 May 2025 06:00:38 -0400 (EDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 28 May 2025 03:00:38 -0700
Message-Id: <DA7PG162QJME.2FUT6C3GBGDB3@kode54.net>
To: =?utf-8?q?Malte_Schr=C3=B6der?= <malte.schroeder@tnxip.de>, "John
 Stoffel" <john@stoffel.org>, "Kent Overstreet" <kent.overstreet@linux.dev>
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
 <linux-bcachefs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] bcachefs changes for 6.16
From: "Christopher Snowhill" <chris@kode54.net>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <oxkibsokaa3jw2flrbbzb5brx5ere724f3b2nyr2t5nsqfjw4u@23q3ardus43h> <dmfrgqor3rfvjfmx7bp4m7h7wis4dt5m3kc2d3ilgkg4fb4vem@wytvcdifbcav> <26678.2527.611113.400746@quad.stoffel.home> <DA7O5Z6M9D5H.2OX4U4K5YQ7C9@kode54.net> <c2001c69-e735-4976-ac8b-6269c825cb92@tnxip.de>
In-Reply-To: <c2001c69-e735-4976-ac8b-6269c825cb92@tnxip.de>

On Wed May 28, 2025 at 2:33 AM PDT, Malte Schr=C3=B6der wrote:
> On 28/05/2025 11:00, Christopher Snowhill wrote:
>> On Tue May 27, 2025 at 11:52 AM PDT, John Stoffel wrote:
>>>>>>>> "Kent" =3D=3D Kent Overstreet <kent.overstreet@linux.dev> writes:
>>>> There was a feature request I forgot to mention - New option,
>>>> 'rebalance_on_ac_only'. Does exactly what the name suggests, quite
>>>> handy with background compression.
>>> LOL, only if you know what the _ac_ part stands for.  :-)
>> Would you have suggested perhaps _mains_ ? That may have rang better
>> with some folks. I suppose, at least.
>>
> What about 'no_rebalance_on_battery'?=C2=A0

Oh, awesome suggestion. A little inversion of language, so battery is
front and center, and we avoid having to think of a billion different
terms for line power. What say anyone else?

>
> /Malte


