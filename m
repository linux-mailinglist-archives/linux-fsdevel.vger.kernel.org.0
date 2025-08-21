Return-Path: <linux-fsdevel+bounces-58691-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 834C8B3088E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 23:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0549A3A115B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 21:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13432D837E;
	Thu, 21 Aug 2025 21:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="p/0DO/xw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IeMogtoo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102212D7DF3
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 21:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755812519; cv=none; b=E7/x4rhVCimw/lRFsfH+PSSrd7unRE2lsLi4oRZRh08FSVnbxr2gSixQY8kn/GLjsy0Iw7C5CTZMbljk8Zl3buT0/GLR/h/9Hn6wFE9vdW2U6tL/MiEcNH4IJi15GsK6LDe8W4EBSGUfDanTjV3EWbwF2CHp+HtKRuY1W3yTt4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755812519; c=relaxed/simple;
	bh=CAgV351WMTJmrBMWDI0Pbn5l6Df3CMzD8yyMt2oZIRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oJQBFTy9rIaMutC7SG2KjughkFJAbgQmLmTUNedY2VhFINVOqOxMApjLV24IxGcBG7oza8fR+Lbn1KjuYcUHdcVob/Bpn0ptW5F/dnwngLuD14DJt5R/EpV0lKpETnStduz789Z4Kn5k6ILrHN/1r/eBwGLBgFgGK8X4AOsfWJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=p/0DO/xw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IeMogtoo; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 0FCA1EC086A;
	Thu, 21 Aug 2025 17:41:56 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 21 Aug 2025 17:41:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1755812516;
	 x=1755898916; bh=DgVzTmUOfIb9+Jx34kKQLruNgfyShfvLjkh0EaGsGns=; b=
	p/0DO/xwsYR3YuHIUGGfGjOh9yM5UeQ4CTRK6IgApJQPDkZQNk4sCVwIgmyCMqTD
	P/PQwjPXNk8MrFtd38uZ+t9jd1eWAV4STL4Hb32E0vU2kKNzmaz/aNawDJwWhhC8
	ECak5dcR7fOgn/n6DIfWE3ewkGP9MB8CuzUj3vEesT+YET0NdKAErW8/ZA6d77D0
	78VGRwosjWCCN+Gqsmy4rbw4LL+WLEiGudgrEfCZ2hvSfBTbbYUTqp1EACn3Ljln
	qy8dIdWiDVqRGAZb08LiNF/yJ3OQM4Q/UtodnbkReQGRxA8TwVT//VnzCJV7coWc
	nUgvJVlBgsV76l38pCsDAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755812516; x=
	1755898916; bh=DgVzTmUOfIb9+Jx34kKQLruNgfyShfvLjkh0EaGsGns=; b=I
	eMogtooO3NS1ZobvrfuMXzm++wUmsWHsbMSwI1rjFY4mstwpjOGqgyZsKkg+lFeJ
	7EupnvpXq6L55zIeIscdzmZnh2CZPQcEYZuXXTkRDSefHUbQvckW0s2syq42cQ+o
	n8JAl5zWMekDU3mRWjMtNK/s/3xVLmIrmHnOh2fZxHod00l9TpI6489ODCVhTkB9
	wrjRo7ZW3Kb+LofKXOUwyV/xuXwSFtKsrM5oX/9B2m3dxyTXyHQXJjH6JhvskgWc
	RDmDa0JcSDWBQyf9t7p7IipvuCGGAYKpjZo8v9RawfYcW/JHHH5Qdpq2s3ZXMvKL
	W4v7IodNBkTmUz4dWi5Hg==
X-ME-Sender: <xms:o5KnaA_pcX8SmgYA0RhsWndBuJvCQdLZAleZbSPa-ohN5LfSONIaMg>
    <xme:o5KnaGSR-2H8aNmGfAbK-w1OeITQsZJlFJXAekozQs1di7A5bV7HmFXPFTzbuAH5C
    LRFnRVZJxm1sI0R>
X-ME-Received: <xmr:o5KnaMctnAvyRclK8YmSro9r0p5ABLVeeCnkh1O2F4NClsvHUdWJP5lxI_jFrx3uMyRv5pSN_pIuYcJ7HYWRW80rH-ARGr6ZCpkT2v_xmShNQKXefYg7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedvvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeejgfeljeeuffehhfeukedvudfhteethedtheefjefhveduteehhfdttedv
    keekveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugessghssggvrhhnugdrtgho
    mhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepug
    hjfihonhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegsshgthhhusggvrhhtsegu
    ughnrdgtohhmpdhrtghpthhtohepjhhohhhnsehgrhhovhgvshdrnhgvthdprhgtphhtth
    hopehjohgrnhhnvghlkhhoohhnghesghhmrghilhdrtghomhdprhgtphhtthhopehlihhn
    uhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmh
    hikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopehnvggrlhesghhomhhprgdr
    uggvvh
X-ME-Proxy: <xmx:o5KnaCAcyU8n_K0SrIfGVa72vdZKmlisVV5bqpDYYy6dyOj4kAfxcQ>
    <xmx:o5KnaGkZs6feMeJUyp1gcNLqRq_QDXiVfOG9d_a6aIaVYCDfOyCOTA>
    <xmx:o5KnaFeDvD4ZeJd9ty8Mc8qG1PVYav-I42vL4pBi7KF3IcGIQDqLrw>
    <xmx:o5KnaCQR4SizVRRXLpD8j2V__e9D3awmbCtzxwaSo2IBL8dBDNl0wg>
    <xmx:pJKnaNFGD908eqLbhexL5GlINtx3LpUz_odUVRH5cI8w1JKxjakj_9ex>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Aug 2025 17:41:54 -0400 (EDT)
Message-ID: <3d9daf0b-2dd6-48cb-9495-76b2b73a5113@bsbernd.com>
Date: Thu, 21 Aug 2025 23:41:54 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET RFC v4 4/4] libfuse: implement syncfs
To: "Darrick J. Wong" <djwong@kernel.org>, bschubert@ddn.com
Cc: John@groves.net, joannelkoong@gmail.com, linux-fsdevel@vger.kernel.org,
 miklos@szeredi.hu, neal@gompa.dev
References: <20250821003720.GA4194186@frogsfrogsfrogs>
 <175573712188.20121.2758227627402346100.stgit@frogsfrogsfrogs>
Content-Language: en-US, de-DE, fr
From: Bernd Schubert <bernd@bsbernd.com>
In-Reply-To: <175573712188.20121.2758227627402346100.stgit@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/21/25 02:49, Darrick J. Wong wrote:
> Hi all,
> 
> Implement syncfs in libfuse so that iomap-compatible fuse servers can
> receive syncfs commands.
> 
> If you're going to start using this code, I strongly recommend pulling
> from my git trees, which are linked below.
> 
> With a bit of luck, this should all go splendidly.
> Comments and questions are, as always, welcome.
> 
> --D
> 
> kernel git tree:
> https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-iomap-attrs
> ---
> Commits in this patchset:
>  * libfuse: wire up FUSE_SYNCFS to the low level library
>  * libfuse: add syncfs support to the upper library
> ---
>  include/fuse.h          |    5 +++++
>  include/fuse_lowlevel.h |   16 ++++++++++++++++
>  lib/fuse.c              |   31 +++++++++++++++++++++++++++++++
>  lib/fuse_lowlevel.c     |   19 +++++++++++++++++++
>  4 files changed, 71 insertions(+)
> 

Thank you, both look good to me. This is independent of io-map - we can
apply it immediately?


Thanks,
Bernd

