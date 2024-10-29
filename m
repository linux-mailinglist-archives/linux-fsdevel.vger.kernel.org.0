Return-Path: <linux-fsdevel+bounces-33166-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFBC9B557B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 23:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D7191F219F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 22:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F976209F4E;
	Tue, 29 Oct 2024 22:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="L6u16TAw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DQC242Ae"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F27419258A
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Oct 2024 22:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730239507; cv=none; b=OUagMMZxle6N940cd8ZJNvwOZz2HB6+8af+Jc+B8W9uYSWufLvgCyRUY6kn5NJExBapAQYtN4uYLDP2W0ZcCAjNmwzvkhNnX0hK4GAssQK43uiXCq8YtUJxOdaRd6COT5UyI3PCc7yUCqMeaVy8Wb1Mj8RAuDvrlHz2uksCTvGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730239507; c=relaxed/simple;
	bh=gpxC6zYjPN2j/8xuiqtR1AXLFYj3aG3xPwKJN1X9WUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PmL75n71dFTTSgzrslQ0aRhoT2xlolLinFKZKrRLldL+dJKO+NmLtIdvS8hr/IzQgMOYvTno/a1uzKnEc1BPUjlcDynaIVOKdfSNHegL+/KoEHgY8UXYaS8OcoQ+2WEi+51LHCpR5+5puq9mMdCJw3RiE4f2r+m3kqX1/p/oL2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=L6u16TAw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DQC242Ae; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 54EB411401E5;
	Tue, 29 Oct 2024 18:05:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 29 Oct 2024 18:05:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1730239503;
	 x=1730325903; bh=qJnqdu0EUYMcc5VwCh5qXc1sj+G9PV7/k3eZZ0fAZUY=; b=
	L6u16TAwcvFdg5on4M7ASKIIhqsWGuXbiHbNRi9tE+obmh57AhMXAyY7WVqvMADq
	Q2lAKMTcYPRhbHOQfW4be/usfqvXCQIwdNUjYz2YCx2j88Fxq5IFgRt23E13iKeo
	G+AwqhBs7AclPcnG2hjumQuDue1DdEgwlR6EPBAnRevj5UEC5tVC+iyDW1vq7ie4
	XT6XguA26Ju+PZvXd06qdpJswqHqQxrbAiXHLk7to2LKwb4Kb4Lbn5AGy5rSzwqR
	hDEX/rT6ag71Tcvj+3573IFNuhYnm14NW9LuT9PvJfNNpUqa4D7GTKvgH/Oxocwe
	FXeZN+bGnqrkXHqvgIdkOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730239503; x=
	1730325903; bh=qJnqdu0EUYMcc5VwCh5qXc1sj+G9PV7/k3eZZ0fAZUY=; b=D
	QC242AeZFaEoXS9atGHgtHAbXcvUuTTaoXrEq4pzlBfrnDGcNYi4NtPiENeHVKED
	dObf8KQfaqnLP/XumY3QH+bLW3LpI+JBPqSgsKBIEi61NLnKLw4XhlmwYdBzxPlj
	HHL/3nL/ALN1TK3fD6bVSd65/eWtdm+1p2+JctivNudwYnkVfpE9sMKudatKsmG8
	eodK8e0Q3rmGwLq7GbnaHVRus4UhajDx6TZbvjQ2JKO6Ntaa3IlBVJXpmsMxPmAC
	vruPKqNapfOHmtkhGOW1n/+HwR7fRRKQo3VEMU/XGiIs15GzlpBP5/ZH5igmMAwp
	FemknXafbWfUx/VVnt6Lw==
X-ME-Sender: <xms:DVwhZ_GasaEm2ksDFu277ORu9Q2vLRLDbQoyx-hFstr0CbKWVr5WEg>
    <xme:DVwhZ8Wa9YW7vXkPWhDMAMqFx496UHdl-vmNn9Pc7QzAjhWxXTKl8bn4CYgF_yCQN
    rh1DTdHX1pjcBi2>
X-ME-Received: <xmr:DVwhZxI8nC2IdbJVFbvu5cT0uyStkLUW6lI7IrrzhfX5ucSPVwEFfU6GpKxeq29fbRxLhiUKCRxAE_t9yqYhX_nIUEg7T-g3zjt8x4mguJPjIJoeJ_e5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekuddgudehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddv
    jeenucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusg
    gvrhhtsehfrghsthhmrghilhdrfhhmqeenucggtffrrghtthgvrhhnpeevhffgvdeltddu
    gfdtgfegleefvdehfeeiveejieefveeiteeggffggfeulefgjeenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghr
    thesfhgrshhtmhgrihhlrdhfmhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthho
    pehshhgrkhgvvghlrdgsuhhttheslhhinhhugidruggvvhdprhgtphhtthhopehjohgrnh
    hnvghlkhhoohhnghesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdhfshgu
    vghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhoshgvfhesth
    hogihitghprghnuggrrdgtohhmpdhrtghpthhtohepjhgvfhhflhgvgihusehlihhnuhig
    rdgrlhhisggrsggrrdgtohhmpdhrtghpthhtohephhgrnhhnvghssegtmhhpgigthhhgrd
    horhhgpdhrtghpthhtoheplhhinhhugidqmhhmsehkvhgrtghkrdhorhhgpdhrtghpthht
    ohepkhgvrhhnvghlqdhtvggrmhesmhgvthgrrdgtohhm
X-ME-Proxy: <xmx:DlwhZ9Er-QptOIfpIMoMtSL8VeTgD_VBKilEqUmvBwBcciupba4WXg>
    <xmx:DlwhZ1UyZWi9dn_31Y1RgVPuQWvnPqTLQRtEQPP1Xh9Uo5fKFDNqDQ>
    <xmx:DlwhZ4NokfsayaUKekF9um5QXaBeqQckWj3Ndh3qFrza9VvjCmS5wQ>
    <xmx:DlwhZ03DMCb3kcTW87bdh0qMENlODh0uMPphO1atWhjnn0lLR1cpug>
    <xmx:D1whZ9TiZBOWEc7b0D_Oe9KkPPase8xYdd0iKTOx7V20jxBix8o8L5du>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Oct 2024 18:05:00 -0400 (EDT)
Message-ID: <fc4dd249-1e7f-4b93-9b55-5dc217a543a9@fastmail.fm>
Date: Tue, 29 Oct 2024 23:04:59 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] fuse: remove tmp folio for writebacks and internal
 rb tree
To: Miklos Szeredi <miklos@szeredi.hu>, Shakeel Butt <shakeel.butt@linux.dev>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org,
 josef@toxicpanda.com, jefflexu@linux.alibaba.com, hannes@cmpxchg.org,
 linux-mm@kvack.org, kernel-team@meta.com
References: <20241014182228.1941246-1-joannelkoong@gmail.com>
 <20241014182228.1941246-3-joannelkoong@gmail.com>
 <CAJfpegs+txwBQsJf8GhiKoG3VxLH+y9jh8+1YHQds11m=0U7Xw@mail.gmail.com>
 <CAJnrk1a5UaVP0qSKcuww2dhLkeUqdkri_FEyVMAuTtvv3NMu9Q@mail.gmail.com>
 <ntkzydgiju5b5y4w6hzd6of2o6jh7u2bj6ptt24erri3ujkrso@7gbjrat65mfn>
 <CAJfpeguS-xSjmH2ATTp-BmtTgT0iTk2_4EMtnoxPPcepP=BCpQ@mail.gmail.com>
 <tgjnsph6wck3otk2zss326rj6ko2vftlc3r3phznswygbn3dtg@lxn7u3ojszzk>
 <CAJfpegvd-5h5Fx4=s-UwmbusA9_iLmGkk7+s9buhYQFsN76QNw@mail.gmail.com>
 <g5qhetudluazn6phri4kxxa3dgg6diuffh53dbhkxmjixzpk24@slojbhmjb55d>
 <CAJfpegvUJazUFEa_z_ev7BQGDoam+bFYOmKFPRkuFwaWjUnRJQ@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJfpegvUJazUFEa_z_ev7BQGDoam+bFYOmKFPRkuFwaWjUnRJQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/17/24 15:31, Miklos Szeredi wrote:
> On Wed, 16 Oct 2024 at 23:27, Shakeel Butt <shakeel.butt@linux.dev> wrote:
> 
>> Why is it bad? I can understand fuse server getting blocked on fuse
>> folios is bad but why it is bad for other applications/tasks? I am
>> wondering network filesystems have to handle similar situation then why
>> is it bad just for fuse?
> 
> You need privileges (physical access) to unplug the network cable.
> You don't need privileges (in most setups) to run a fuse server.

Not sure if that is the perfect example, you can also run a local user
space nfs server. I think the real difference is 'fusermount' which
typically has the s-bit set and allows mounts from unprivileged users.
I.e. I really think we should differentiate between 
privileged/non-privileged fuse server tasks.

Thanks,
Bernd

