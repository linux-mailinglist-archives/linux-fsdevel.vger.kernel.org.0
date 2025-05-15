Return-Path: <linux-fsdevel+bounces-49160-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FA2AB8BBF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 18:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F6AB16A138
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 16:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7613121ADA4;
	Thu, 15 May 2025 16:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b="ZTaDJrWO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OGG4gtgv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5556626ACB;
	Thu, 15 May 2025 16:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747324839; cv=none; b=U5u/SqB53qvjvGWx9qfXXr3rNt8QmJK4PGqlR/8grP0wH7aH8HVFL5m3gwZ1eg3iOtS0WdKy8oTTUu9PqG1BnCE/lYT7w5cGEfRJBLQfVAVPG1GbNPW3q7wTdlOX5UAg0Oa/7O6KQN59Q1uL/BfEQB7CcfSbt/3M4Tjd/3ZXbd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747324839; c=relaxed/simple;
	bh=Ht8GrC1/WhiK6Zak+5S5UJso+Ncn4Dqne8cOnc7np9c=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=j7LkVQYEpZNhPoswFE0lW61lUzNy85bmUGrt1yKuEbEcf/udMM/Ppkg5zkhtRvYg1QOzUmoeT/XWNQdKS/II3ae0f/eveLkT3fU5sMnLShkd2qFrkiMgVlhpYlBXt2g1EtG0/Q57WFb+7b0tGmTHQcvCwv+4LELF396xVXnOlqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev; spf=pass smtp.mailfrom=svenpeter.dev; dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b=ZTaDJrWO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OGG4gtgv; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svenpeter.dev
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 5F56C1380241;
	Thu, 15 May 2025 12:00:36 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-04.internal (MEProxy); Thu, 15 May 2025 12:00:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1747324836; x=1747411236; bh=Ht8GrC1/WhiK6Zak+5S5UJso+Ncn4Dqn
	e8cOnc7np9c=; b=ZTaDJrWO3GosTmJ4laSKWarSByuF+hIC183G9SiDMXMK5D01
	TkpaalyNd/ifGOS392Mjk6FV92jCkEfjGQnS2wCAHouIdy9zs/CPhZlWuS2UeAZe
	htioNGQJwKBHn7Z9biJEI89g39d7EDyqf541fakoygcecSi0TAZMBM9Z2tUCr1O8
	KHguMbnMyMeSMgtlPNt6B1+byP67LtC/0t+treW5MWUNtMu/P2EicaMz4qUI+6QV
	wOZhjHLoUlNveuS8R6R2ywM/21Da+PWrJKAmmXRg1r1VWk0YyCJXwLNqAlpZocBw
	bICREuq9ZxfY208QeXkYuryNy3dhsEH9BERvjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747324836; x=
	1747411236; bh=Ht8GrC1/WhiK6Zak+5S5UJso+Ncn4Dqne8cOnc7np9c=; b=O
	GG4gtgvsg8QMgNK/JeA/j+Et2OBN8bbuCYugP1djZ7y5kwcW8FgWkxLukTPoJIRI
	SIdqo4eJRWXOuKQC+yhtY4qDVpecs/lEx3H67sthOxdk/lZVUrjvl78Kl49jU3cC
	gKAO4pylbEQcizzVHXGjfWPkGiVAOBuz2d1Hzclzq5aMyrfiAPkWGEcJeIEMAijy
	g1Wp8DHhgPVRZlb2Kd82VKIKjbW9PY6hld2eieABDa6WPR8TZpiRxNo/GXzzNKhJ
	0ML+hDe+T9XZnCL0+Z8QNXfP+Fdmvi264Ibj9VAUAxkX/UGq5Xa/OOwILIeHs9f7
	ItitJRlJIcF7Q+HY3dP2A==
X-ME-Sender: <xms:og8maDZwXPJh0JEZZ4U9e08ktN0ZBsSIzL59WRsOY7Dp_NMKtAHgQQ>
    <xme:og8maCZn6stAOVhD0ckx_JCO5fX3j80FQJcT94WdeEp2WmSzPuZuHraxN_QbTRMJ0
    RYXCuUpdpApTLrcZeg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefuddtfedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertder
    tdejnecuhfhrohhmpedfufhvvghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvth
    gvrhdruggvvheqnecuggftrfgrthhtvghrnhepgeegheelffdujeduffevfefhieekgeef
    fedukedtvdduhfffjeehleekfeehhfdtnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepshhvvghnsehsvhgvnhhpvghtvghrrdguvghvpdhnsggp
    rhgtphhtthhopeduledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvghrnhgvsh
    htohestghorhgvlhhlihhumhdrtghomhdprhgtphhtthhopehslhgrvhgrseguuhgsvgih
    khhordgtohhmpdhrtghpthhtohepvghthhgrnhesvghthhgrnhgtvggufigrrhgushdrtg
    homhdprhgtphhtthhopegvrhhnvghsthhordhmnhgurdhfvghrnhgrnhguvgiisehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepthhofihinhgthhgvnhhmihesghhmrghilhdrtghomh
    dprhgtphhtthhopeifihhllhihsehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohep
    sghrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhdrtggrrhhpvg
    hnthgvrheslhhinhgrrhhordhorhhgpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhig
    fhhouhhnuggrthhiohhnrdhorhhg
X-ME-Proxy: <xmx:og8maF9n4m0XTvV5oBne8_Mlbelgg9HJg7713LGn_XjUWfxnidu5oA>
    <xmx:og8maJrJvCRzR2oMTs27U5UhJORvxz2NXb1pGrGlcV51GvulupGhcg>
    <xmx:og8maOr2veNZQTrBVoasOxlaSD0n076nlVfcEbAvpq1ScFvRI1EfFw>
    <xmx:og8maPT5VrAYpd58WuUFjF3oG_P_EwNsHs7Khn9RllclgT_McPJU-w>
    <xmx:pA8maKaQ0w7CPG4bPr-Hjww9ejNSnaHyYfBuLjxAQIEAroHfoAGxPS_U>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 65288106005E; Thu, 15 May 2025 12:00:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tf135b851f6ecbaa4
Date: Thu, 15 May 2025 18:00:34 +0200
From: "Sven Peter" <sven@svenpeter.dev>
To: "Nick Chan" <towinchenmi@gmail.com>,
 =?UTF-8?Q?Ernesto_A=2E_Fern=C3=A1ndez?= <ernesto.mnd.fernandez@gmail.com>
Cc: "Yangtao Li" <frank.li@vivo.com>,
 "Ethan Carter Edwards" <ethan@ethancedwards.com>, asahi@lists.linux.dev,
 brauner@kernel.org, dan.carpenter@linaro.org,
 "ernesto@corellium.com" <ernesto@corellium.com>,
 "Aditya Garg" <gargaditya08@live.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, jack@suse.cz,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-staging@lists.linux.dev, "Theodore Ts'o" <tytso@mit.edu>,
 viro@zeniv.linux.org.uk, willy@infradead.org, slava@dubeyko.com,
 glaubitz@physik.fu-berlin.de
Message-Id: <47721ba1-2ffb-45df-aed0-ad0308f6d606@app.fastmail.com>
In-Reply-To: <e6a5a737-ce64-4d31-aeea-2e6190da2ff5@gmail.com>
References: <20250319-apfs-v2-0-475de2e25782@ethancedwards.com>
 <20250512101122.569476-1-frank.li@vivo.com> <20250512234024.GA19326@eaf>
 <63eb2228-dcec-40a6-ba02-b4f3a6e13809@gmail.com> <20250514201925.GA8597@eaf>
 <e6a5a737-ce64-4d31-aeea-2e6190da2ff5@gmail.com>
Subject: Re: Subject: [RFC PATCH v2 0/8] staging: apfs: init APFS filesystem support
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025, at 07:08, Nick Chan wrote:
> Ernesto A. Fern=C3=A1ndez =E6=96=BC 2025/5/15 =E5=87=8C=E6=99=A84:19 =E5=
=AF=AB=E9=81=93:
>> Hi Nick,
>>
>> On Tue, May 13, 2025 at 12:13:23PM +0800, Nick Chan wrote:
>>> 2. When running Linux on iPhone, iPad, iPod touch, Apple TV (current=
ly there are Apple A7-A11 SoC support in
>>> upstream), resizing the main APFS volume is not feasible especially =
on A11 due to shenanigans with the encrypted
>>> data volume. So the safe ish way to store a file system on the disk =
becomes a using linux-apfs-rw on a (possibly
>>> fixed size) volume that only has one file and that file is used as a=
 loopback device.
>> That's very interesting. Fragmentation will be brutal after a while t=
hough.
>> Unless you are patching away the copy-on-write somehow?'
> On a fixed size (preallocated size =3D=3D max size) volume with only a=20
> single non-sparse file on it,
> copy-on-write should not happen. I believe the xART volume is also the=20
> same case with only
> one non-sparse file.

Yeah, the gigalocker file on the xART volume (which is the only file we =
care about
for eventual Secure Enclave support on M1+ macs) is stored contiguously =
without
copy-on-write on the disk.



Sven

