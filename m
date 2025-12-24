Return-Path: <linux-fsdevel+bounces-72066-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B61CDC986
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 15:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 676AD30E6D1B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 14:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A2D357A50;
	Wed, 24 Dec 2025 14:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tyhicks.com header.i=@tyhicks.com header.b="oz34Y+Eo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hdGU5FRS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB8334E74E;
	Wed, 24 Dec 2025 14:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766587665; cv=none; b=fznQ77FPMua27afYYT3icOAGv4AdflIho/ZkYDaoqyj2kjgzPYzfPB13Wvk87m8SOI0CAbB66e8BUqMPRHMBENAQQwcT0UCjO/RpIyxn6MgyPCd2K58UWkt53l8Fc44lu94EncmJHHsS9oocJr/ubtKY8UTBLnl3C7OcF21PVkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766587665; c=relaxed/simple;
	bh=SqBEQsTs8SDxEIJg4ZrazeXz15zlp0d74t+CsBqNEwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cef8XisyJ5W++5/oIzhhHGwuT29GZrc8IihggCyEx74M7RMzGc5KjrzDw7iluJyQ3BJNGRYx1shl/Xp+1p0lKsyUxY9rr9EyA2907gkRfizrq79AvWnULvdjCZsccLeurioKBFoP81PCzjv05hyNB0FOaIJSQMpcZJBJp/Ns4SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tyhicks.com; spf=pass smtp.mailfrom=tyhicks.com; dkim=pass (2048-bit key) header.d=tyhicks.com header.i=@tyhicks.com header.b=oz34Y+Eo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hdGU5FRS; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tyhicks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tyhicks.com
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 78ABC1D000F8;
	Wed, 24 Dec 2025 09:47:42 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 24 Dec 2025 09:47:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tyhicks.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1766587662;
	 x=1766674062; bh=5dlqoBNLe1qadi3fugn7RBaiGTrrIZ80AP50YCGn7xY=; b=
	oz34Y+Eo3TjxE8PmKKYBfuLhEqry1N6+rBQZIcOTdKoxWwpB/7GeR6+3P1/Cxroo
	m0EQWQq96XoChfzlB8Q1WwwxAuSykhByXUB2If6LZKTL14RukXSEOMAurFSwnWSp
	afVCHE7Cj1XZ0jdnGx07DxGdx9xtHRQcdBVuyu48h1ja2R1mh4gE4TPXOerY2m0a
	ygjOfSwUDp6EopuNpYz5hOr5ZKx+6H2q5vn4jDwjTq9Er3HH0OAs8F8NG72G6mbA
	eXsdPkAHlJGXn31GeXZszmQtMFFTo3VQXfN4VR+8XyDYuqlgjJDv4eMH5iIOlod6
	OEljYzgskhTSs8KUFNAUQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766587662; x=
	1766674062; bh=5dlqoBNLe1qadi3fugn7RBaiGTrrIZ80AP50YCGn7xY=; b=h
	dGU5FRStUCpERImsfDUA+IrDlj1ssSyzUAuPHiKLWFBbqgIuBVhKE7vnpYpHUMwL
	mRmHiufRXePoR8osuiCwCJDbUNbQn77/xGQqGFdPk8xy7MhP9OPt+b1whINodd5F
	AUGJ7nhyUIvfm9P9sBKpRSlhnmWP6ULBr4DixBkTcAdhoFFtq1wFnZbHX/FgA4xi
	ui1CY1NXEUhdEDeg86fbcExcZBvDHmm3msDzX+d/m3dBLp7cp2gqdjb2GOFNlAM5
	PWPXJPDxBomrFB0C0GAMgsWT8qSXBMArb/MwCkSfVL56UXYxvX4jPFcFCw33PkVM
	AUEtCZhjz/zpjkU1wHMhQ==
X-ME-Sender: <xms:Dv1LabmB5W7u0smPsjKMjRDrxDtv0I597wrvUXrAr9POCnHe9XfFwg>
    <xme:Dv1LaY7RHcFM2iY95Nt0f6ukejkFWF_6rpMe7bS_BqESV-qaNbvXkNc8fyV_VyLkI
    2FWunPWBFu3MBfY3S7Ftn_2Vz6RVCXU1ZAkr6-03CnUD7suVkFuoQg>
X-ME-Received: <xmr:Dv1LaRgpusoK8JQSSvHqSKKH45vrnVS9Ry-mAw1tPfAc_shoUN30_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeivdelkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepvfihlhgvrhcu
    jfhitghkshcuoegtohguvgesthihhhhitghkshdrtghomheqnecuggftrfgrthhtvghrnh
    epgefhieeuheefkeetffefffekjefhgfefiedvveeiuedugfeufeefvdeihfehieevnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghouggvse
    hthihhihgtkhhsrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopegrmhhirhejfehilhesghhmrghilhdrtghomhdprhgtphhtthhope
    gsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvghilhessghrohif
    nhdrnhgrmhgvpdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepvggtrhihphhtfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Dv1LaVEKuNL9CyokRiLYshqJe82kfyRL0JEgX_Ej4Xv4EjSfPaPV_A>
    <xmx:Dv1LaXTo2WUcUkHb6X9AT_kFQQWCmU34ioI570PynJWP80zreRJ8gA>
    <xmx:Dv1LaSxPeXwjwrzFUPL3ZOw51J3CiIXx2ZjW8L5FrECttLX4bRE1Xg>
    <xmx:Dv1LaTfMlknCSCL369P96_qizovsq7BI9aJAsjJ9-u_VMfJsvh9UqQ>
    <xmx:Dv1LaTV8wY_1-wRSFM3T_KTp00-zzjMtK8BA5rCowLMmYJcOGn6nVZnB>
Feedback-ID: i78e14604:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Dec 2025 09:47:41 -0500 (EST)
Date: Wed, 24 Dec 2025 08:47:39 -0600
From: Tyler Hicks <code@tyhicks.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>, ecryptfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 0/2] Fix two regressions from
 start_creating()/start_removing() conversion
Message-ID: <aUv9C5Z4Y996T8BT@yaupon>
References: <20251223194153.2818445-1-code@tyhicks.com>
 <CAOQ4uxg5Qbkt2WzfXojzCNUYwj9BsW6vzKEL4265PQxBgNkdeA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxg5Qbkt2WzfXojzCNUYwj9BsW6vzKEL4265PQxBgNkdeA@mail.gmail.com>

On 2025-12-24 07:31:59, Amir Goldstein wrote:
> On Tue, Dec 23, 2025 at 9:42 PM Tyler Hicks <code@tyhicks.com> wrote:
> >
> > When running the eCryptfs test suite on v6.19-rc2, I noticed BUG splats
> > from every test and that the umount utility was segfaulting when tearing
> > down after a test. Bisection led me to commit f046fbb4d81d ("ecryptfs:
> > use new start_creating/start_removing APIs").
> >
> > This patch series addresses that regression and also a mknod problem
> > spotted during code review.
> >
> 
> Ouch!
> 
> Christian,
> 
> In retrospect, it's a shame that patches get merged with zero test coverage
> and no ACK from the maintainer.

I wasn't able to be a very active maintainer over the last year. I think
Christian did the right thing here.

> OTOH, relying on ACKs from all fs maintainers will seriously impair
> the ability to make vfs wide changes like this one.

Exactly. The fringe filesystems shouldn't slow down the entire VFS.

> Feels like we need to find a better balance.
> 
> At least for ecryptfs, if we know that Tyler is at least testing rc1
> regularly (?) that's a comfort.

I will be more active going forward and now have an easy setup for
testing rc1's regularly.

Tyler

> 
> Thanks,
> Amir.

