Return-Path: <linux-fsdevel+bounces-63143-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB34BAF1E5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 01 Oct 2025 07:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FC862A2573
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Oct 2025 05:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6102D7DCC;
	Wed,  1 Oct 2025 05:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="pJNq2w0j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jx28+7Q6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3055AC148
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Oct 2025 05:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759295111; cv=none; b=u4uE/ycNkZUrNASrkVtlyK2eIa4gboU7voh+OtUDmqhKzdSMWDz5tWAIrxV5P1p3yYCZd1rrT+NFVI/WOfdUIVZ8WrtwkHB8tnRijzkTGnBgDPtNeYyG9vSKmjRbet4bDhyAUJtdXmRmlWRsXDdVaHWTl8SgR6MIuM10BHCsjj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759295111; c=relaxed/simple;
	bh=dhH7ksiJ52Adbb0i0w4+RpnOPEIP9S4pXSNzSzi2UVM=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=lYwUIgT1ydsfgRodapNJqdYMjjBFyPpTbcBl0IFyBBDBj6W1HDFFGkGOI7IDG7/p6BRMKh8Ua1y7XP/C5snqWMthnlKz7PgdVywD7/KvqMCyT25SXYqqtPN3ogAcVGjdl3FLIxbdvIIyjFpSCelfGgOjMYG0XjyAnvrfLpPmqxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=pJNq2w0j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jx28+7Q6; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 218F014000F3;
	Wed,  1 Oct 2025 01:05:08 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 01 Oct 2025 01:05:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1759295108; x=1759381508; bh=/NQsSycP6U2GSNzbG9SaNl+/YBEdNDa6u66
	9/PHEfM8=; b=pJNq2w0jtBDajn1W9Rf4Ejun4bs5M0+RZur4OIoSCdWvPM2etaA
	xTYYgjzKOEaS9QiF6efL3+SPGNw3TRikHooMuLkIJ/Fdm9DBVIeV7DiJDGnTR5qA
	QDmcSjsSxsYM2SAOKeZAHUFxAWslJxbj0SqMcMwDHqtlVu9CUfhmZ+BGRnT3jNqw
	fMyrkeUmhLjmmXwk3UHTBse4J2PwkhXC0TgqC3IysBZTBc4vAOFDdHmG2xdagJs9
	YNMTk5szZnL1ciMV9WslCMRux1oKLGk/nifkPtlGUErv5bonfJbtj12jClVRpyI3
	ozNv+SnREV3y7OG7st134buz64n+cmnXHAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759295108; x=
	1759381508; bh=/NQsSycP6U2GSNzbG9SaNl+/YBEdNDa6u669/PHEfM8=; b=j
	x28+7Q6agQ69Tt31eyJJjIW0PsLLjrCnkofg44/5nmN8petz7v3rNl+s43Pw9iZX
	UKxpODvMgWR2/TQAeWRnpLysQxIU6kDFeSk/yiwdpfs98i9vsDZkYK1+6Y04DWq2
	dJ0Kw66JBa0h1I3Pv1LaNTV34x292fT9Nq805sPHRYVBq1fcRGuDitiHeuoUMO6c
	wG/S60UzbVHbu3AD5ILA44iimcbkAOyAEgyYcE34fJM185lycSDOz9mAIsNGTTiA
	WfYssG4PX/1vQLULdZTLpST5jLP7NCNu5slj11itlE2yknWkL/7sgc+h7vBZEXsZ
	8t+KqXbQf5P2eDQalziTQ==
X-ME-Sender: <xms:g7bcaCXiGkvh1zQ8wKvFmzD8liTnp3xOGKQasiG5Rv2G9nj35FF1cA>
    <xme:g7bcaJim60BLeGz5Q4pL254wHPE3ZRKU7AWOl19KQ4BkMgI_I2tg-D9tP_1fnPB3e
    CzLlOKcMkS8e_pKpX-sFIBiahzjubBfEtB4SE97O-xoAD5kyH4>
X-ME-Received: <xmr:g7bcaFb1Ks4f4jj4IMsMkv6W6v8plgVSeIy0tPJzDA0JUTER_x_FvIwJiINGV-SziCQpx7lirAeZgTI5jC-p0tBR0MQX3xA3vqU1YkYH0aTc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekvddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefujghffffkrhesthekredttddtjeenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    ffudfhvdeuleevieefvdfftdekkeevtefhkeehhfdvvdegjeejfeejvdegteekudenucff
    ohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepnhgvihhlsgesohifnhhmrghilhdrnhgvthdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvhhirhhoseiivg
    hnihhvrdhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehlihhnuhigqdhfshguvghv
    vghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhgrtghksehsuhhsvg
    drtgiipdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghmihhrjeefih
    hlsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:g7bcaOq9yx71uSCNbO3-QI5MKnTj0eP1gE219E6FT9XW-oCA2t4nyg>
    <xmx:g7bcaKP0WxT3gSCucVaafsfZwe8B-c3PAQSm3FYUCNLrVWtY9CLVwQ>
    <xmx:g7bcaJoJ5bddlAfFmXQv0lecZzF-x9pHEC9YGX9oUjnoBFcgMie6mw>
    <xmx:g7bcaPdG0sB5Gy-aRyMG_v95BtbnyRiUIMlOibkHjad-VmCdU8MjpA>
    <xmx:hLbcaOMaOgGKCs_WD4dNottLcF72YUgYkVu2OrdH6Yc3o7nsvIkDWK5_>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Oct 2025 01:05:04 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Amir Goldstein" <amir73il@gmail.com>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jeff Layton" <jlayton@kernel.org>,
 "Jan Kara" <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 00/11] Create APIs to centralise locking for directory ops
In-reply-to: <175897201039.1696783.9339851944147869858@noble.neil.brown.name>
References: <20250926025015.1747294-1-neilb@ownmail.net>, <>,
 <CAOQ4uxhr+pFGa+SW-pJgeNpK5BYPxr6VVvq5LLQV4M59UBrVbw@mail.gmail.com>,
 <175897201039.1696783.9339851944147869858@noble.neil.brown.name>
Date: Wed, 01 Oct 2025 15:04:57 +1000
Message-id: <175929509753.1696783.3463564221734515934@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Sat, 27 Sep 2025, NeilBrown wrote:
> On Sat, 27 Sep 2025, Amir Goldstein wrote:
> > On Fri, Sep 26, 2025 at 4:50 AM NeilBrown <neilb@ownmail.net> wrote:
> 
> > 
> > Can you please share a branch for testing.
> 
> https://github.com/neilbrown/linux branch pdirops
> 
> I may update that as I process other review.
> 

I have updated this with responses to all review comments (I hope).
I've added a patch to change vfs_mkdir() to unlock on error,
and one which introduced end_creating_keep() so we can think about
whether it is worthwhile.

I don't plan to resend the whole series until after -rc1 is out.

Thanks,
NeilBrown

