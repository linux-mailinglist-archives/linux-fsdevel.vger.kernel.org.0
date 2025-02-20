Return-Path: <linux-fsdevel+bounces-42158-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61474A3D5D3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 11:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D77D7A48EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 10:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA51D1F150D;
	Thu, 20 Feb 2025 10:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="NOoPxoKb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zW5KC/Pe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA982286295
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Feb 2025 10:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740045636; cv=none; b=bwSrCiC+JqEdH/96mYxsBMoWncW7Khd8XwdEgsedoihN5O5SnYoJzNLaRDv2rsJbSsnF/qLCG081qufIvmwrKhxCblFvYE9UMnB5U58ZDEtVelpKgn2iwweMhTtb5K9EpcqL8N6mWzCFTIWEiWNcDA40OVPMshVxleknybWXkug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740045636; c=relaxed/simple;
	bh=6abVsmX8ioP3YxqgLp21Xv1cXc+KxSgsLmb3FAVc9DE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CLizUthGJsh36a38dswKSXCalaebuaKO+Bu3y+l/uHCPLpGPUxEdw9UFZQ9h5W5r1nTeDTLgkwbeMy/Oc6mLubnS4x99gj6fgraGX7xLJxZy8c3pJXe4ZUdyy+mEWu3VrEfrAWGgAeyqOyRdG8G+l7OwOM+G0S58jOSJvGYZ4G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=NOoPxoKb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zW5KC/Pe; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 960B91140155;
	Thu, 20 Feb 2025 05:00:32 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 20 Feb 2025 05:00:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740045632;
	 x=1740132032; bh=PkPqJ9l8KufL9V4SnIq7wt30LuJLWTbaZ5mys7abUPc=; b=
	NOoPxoKbNKYIqIi5dOV73BimG0VZbPVxwRQePCfBWCgb7XCnrHUfEvMIYLk7AIUo
	phNWKCAKuOvC3aBLVY3eXhAoWFNWYmhZ3/lQf77GwLxwX0dcD8PyurFYW5X+nguV
	Y5bfR3EuAHGI4Zepx3BUMV0hTMVg/AJeWhxzSH34ONKeqq24rfJF/TUIGn8/HkE6
	vFUCh2SCFwPKE3ryhStN5RCA9bpgto4f3bVD44PKf7/qIrH4yq+yvVJZhae2soJn
	6xrIopjd3H04E6RC6IMSl67UcDu9Rcsj0iq5oZC299FtJsfmVM2WZ/G6ckFeHeZV
	HU4o3cLPYlO4wpqcj3exrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1740045632; x=
	1740132032; bh=PkPqJ9l8KufL9V4SnIq7wt30LuJLWTbaZ5mys7abUPc=; b=z
	W5KC/PeCX8LBd2POTtgxmwzCASsnXGWFcy3wNhKKzJTCy5E2Fa+Gs4k8VdFB2wST
	oS1bcV6P5ZnloQgtojiCuaWoyuIQRtSbClEC1k5rSVJEm1fYD6kaMMixnpq3E1Hn
	FCrWieEsX6PnIuZZpL+AFxS9/O1lLbIZcZNUQyxNzUIbNYSWc/trHQEn18ryLpY8
	mUm5Xtiza5NrkEuV+9WKRu+xcJsEErQwL+FFOk56F9jVJGN+kroKzMEqj32DSccl
	V4I+KFHAX36Nevhh/JBy/SGkqorkVtN2BahRSgirwwy9YS6vR4DKYpnnfImxTeVE
	r6dG52otYZBVjdu0XUAvg==
X-ME-Sender: <xms:QP22ZzB0fxm0qOAZ8f29m-3CACqC0oMa8EWKu_JLuyXLSF9aVdTW-A>
    <xme:QP22Z5i03WHjpT0O-TDQyaUybLZhQ8Xn1TdJz6_S6fhktkYSyvXpZXLScjm1w3adf
    qCrgASl8qzex1-G>
X-ME-Received: <xmr:QP22Z-nMJh-WHFM32AT61KgtdGljj8ujauQei5j3Zus-9lFmCLSJgHkqMALN7ntLJBkNbigxSnE-z3mu7EZRFOLuY47YH6PXZYFTtGaRNPXdufxlrzlW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeiieekiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddv
    jeenucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusg
    gvrhhtsehfrghsthhmrghilhdrfhhmqeenucggtffrrghtthgvrhhnpeevhffgvdeltddu
    gfdtgfegleefvdehfeeiveejieefveeiteeggffggfeulefgjeenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghr
    thesfhgrshhtmhgrihhlrdhfmhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthho
    pehsrghmtghlvgifihhssehgohhoghhlvgdrtghomhdprhgtphhtthhopehfuhhsvgdqug
    gvvhgvlheslhhishhtshdrshhouhhrtggvfhhorhhgvgdrnhgvthdprhgtphhtthhopehl
    rghurhgrrdhprhhomhgsvghrghgvrhestggvrhhnrdgthhdprhgtphhtthhopehlihhnuh
    igqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:QP22Z1wBTlnxWsyeyH3o2caih5_fGVhvzJecA0MYbAstJA3O3dKBcw>
    <xmx:QP22Z4QAg2DHp2PmwGdKLiebif02T37kzgxMMwDudFKbF7GL90VkxQ>
    <xmx:QP22Z4Zs1DwSPLirpsxpMah5bPIq22B8bWNacTy8U9A-IqvWFmITqg>
    <xmx:QP22Z5QqGHJsNdlWGoAUyWJuPSNPsdfYG5ftnRrbpZh6J-OTaw1M8g>
    <xmx:QP22Z9JzwN7O2xXJ3a9KyCw3o_eFkid6uBipTk5ixreSDwGpJGq83v9T>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Feb 2025 05:00:31 -0500 (EST)
Message-ID: <76b3d8c4-65dc-4545-ae61-4def20a71374@fastmail.fm>
Date: Thu, 20 Feb 2025 11:00:30 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [fuse-devel] Symlink caching: Updating the target can result in
 corrupted symlinks - kernel issue?
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Sam Lewis <samclewis@google.com>, fuse-devel@lists.sourceforge.net,
 laura.promberger@cern.ch, linux-fsdevel@vger.kernel.org
References: <CAJfpegvVtao9OotO3sZopxxkSTkRV-cizpE1r2VtG7xZExZFOQ@mail.gmail.com>
 <20250219195400.1700787-1-samclewis@google.com>
 <568e942f-7ef9-4a00-a94f-441f156471b1@fastmail.fm>
 <CAJfpeguEsq2amd-UxiSEktZLSpR0s+LXFeknpLdZR6vk8fbb_A@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJfpeguEsq2amd-UxiSEktZLSpR0s+LXFeknpLdZR6vk8fbb_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/20/25 10:57, Miklos Szeredi wrote:
> On Wed, 19 Feb 2025 at 21:22, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:
> 
>> I think we should write tests for all of these fuse specific operations,
>> ideally probably as part of xfstests.
> 
> That's a good idea, but for now the above Tested-by should be
> sufficient.   I'll post a proper patch.

I have it on my TODO list. We will need tests for all notify operations.
Having it in libfuse is not sufficient, as that less likely to be run
by kernel devs.
If we are very luckily, I can make someone else from DDN to work on
these tests, but not promised.

@Sam could you please describe your reproducer?

Thanks,
Bernd

