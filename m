Return-Path: <linux-fsdevel+bounces-61287-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 327B1B57332
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 10:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E19E03B2946
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 08:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6672D2EAB7E;
	Mon, 15 Sep 2025 08:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="RIy8nZv1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V3JdgmZx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B7B2417E6
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 08:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757925567; cv=none; b=WOHK4+UjBJ/oVDLGAo+aRUxi9bdySN09cWanPL/mMify/I/N4gMf1aHaJaX0yHcnZCIYXZ4oyYDLe0HeeTHjP+qoztD8AevWPc1Le0g/a138W5i+CnVJAhFnxNF5F4EG9G3FdvCG+9VUDGhrIFIlFOT+UX2HKotRLFcrD0wB2Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757925567; c=relaxed/simple;
	bh=xw/DOnFIb/p1zOaQj89EfCTiBg8PfaompReRBYnY8QI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=saHgJvCG4IvfmJF3QyyMPSWAKvFYDlqvYb6g5tGSnmKSDjPD8JA77IO+CUmBmg1v5refAE5uiStfXJ6WmH3ga6EvskiouLucSisZnLF8/JqP/EvwFRtlcCvAOwFZO1zifvoIyTJyvhAtESLufqZdeHBbKGsZ2W0aJGStsVkuRfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=RIy8nZv1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V3JdgmZx; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9FB417A0126;
	Mon, 15 Sep 2025 04:39:24 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 15 Sep 2025 04:39:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1757925564;
	 x=1758011964; bh=WJYmwajZMar9GD80eAxMWQ/QhNw7YT5mQjhbAjsbNMU=; b=
	RIy8nZv12vsLOpL89ZqqsOMSHFio7/xau68v9is+nN+c53Wks4Zam/MhWnqJbw9n
	QAyfkn4Yhxaw1Efrx/GmxY9gvG63ts9Tr7NJabl6gcHv4eBzHPaYCOC3D4NkbbsQ
	ExZe+ADIjj5hIibHcS96D5kVCP63N8i/CtAshJvUVvlHmQO/RZUTr4qVIsMNIR5U
	wA/f2P73JK8uitK3w5n8zSHlQrIIv7sQgBHeiaGHVFHpO8i4iZjkDcxqoAJC/xV2
	p2n8SVb8ATg1rf0k0HWcpHanlOux/KQypiqpvTIVhge686uKEMUhBoeLb8mVvwU3
	iU1cTJ+r3SHzmdUXdEPKOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757925564; x=
	1758011964; bh=WJYmwajZMar9GD80eAxMWQ/QhNw7YT5mQjhbAjsbNMU=; b=V
	3JdgmZxgmxwHg9HeyYC8aBbQUwYnfow+oR8GGY68TVOSIE2uKjPvRcM3rFkUxAuL
	Gn0zPnviiKCuVb8hBbtT1giY3p9no5065eeuty+z0c/tBQZkT1STrgDG0fw5PftM
	o0Km8kFVPKr2HYU1DL41BRrJGoolpKISpCn93TrSRnnU6gV0G8XRdQOUaDR06V8/
	RTQMO4XwSzFZL5jR/6thnamlNQmhK1ScbXvkv6KHEpRRAbYWeX9jGcFZJdo10R/b
	Gm9cidoABiI/enR/TwjtlE8iLyDexjzdZMOeFH1dHP5qbcFGe6j/wSBZA4mvasVb
	+EggQDsSg/BLXT2Db4JGw==
X-ME-Sender: <xms:vNDHaLxxp5BMqQmVMDSJ4YIxLoBS88udevG23eFXEk3C-PJaZIxrBg>
    <xme:vNDHaOzn3ItbsI_pgtZvrwJvTcIHaKtCGWdu-8nSYYd8wn320usDLvWtyuT01Zn2b
    XWhTSvuMZMsDEBg>
X-ME-Received: <xmr:vNDHaLzxnQA1iSM_xrQE7q8RRgrEB5Yn6r8KVRsG7Say6ONm0hq7SZvujCJiy3kUi4d3_m0PyJy7lmwe5YcpD5sx097ZL9NdpoF8fwSQ_L4PWWKkHQgG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefjedvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepuegvrhhnugcu
    ufgthhhusggvrhhtuceosggvrhhnugessghssggvrhhnugdrtghomheqnecuggftrfgrth
    htvghrnhepjeffuddtgefhfffggfejheetjeeukeeiteeiheevheetueeigfeiueelkeej
    keeunecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgusegsshgsvghrnhgurdgtohhm
    pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeihrg
    hnghgvrhhkuhhnsehhuhgrfigvihdrtghomhdprhgtphhtthhopegsshgthhhusggvrhht
    seguughnrdgtohhmpdhrtghpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprh
    gtphhtthhopehjohgrnhhnvghlkhhoohhnghesghhmrghilhdrtghomhdprhgtphhtthho
    pehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:vNDHaAaS1EBinCu54v_l6T79ttX0PXZXmIiq35zl1b4QwO8nkI7I4w>
    <xmx:vNDHaEXqN2vSbkLRDbI861T9cP0noyKvYzNZkaiU4s7veLGQ2nrOHA>
    <xmx:vNDHaGgFHgeZqcv8YuEA6mWBRGUgCH1QYdii8_iLsb-fky-5-b6l8w>
    <xmx:vNDHaKv-9CPc5lEHl3SI2cyHetaf5y2kP0_ADJ5h11TpC-lKekTO7Q>
    <xmx:vNDHaDlvsKhJKjZLAZc0250rR8FurX6PvUvPI1wDHEaEssozYfBQ-eyP>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 04:39:23 -0400 (EDT)
Message-ID: <15ba1a8d-d216-4609-aa7d-5e32e54349e5@bsbernd.com>
Date: Mon, 15 Sep 2025 10:39:22 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] fuse: {io-uring} Allow reduced number of ring queues
To: yangerkun <yangerkun@huawei.com>, Bernd Schubert <bschubert@ddn.com>,
 Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org
References: <20250722-reduced-nr-ring-queues_3-v1-0-aa8e37ae97e6@ddn.com>
 <20250722-reduced-nr-ring-queues_3-v1-5-aa8e37ae97e6@ddn.com>
 <7c8557f9-1a8a-71ec-94aa-386e5abd3182@huawei.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <7c8557f9-1a8a-71ec-94aa-386e5abd3182@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/15/25 06:37, yangerkun wrote:
> 
> 
> 在 2025/7/23 5:58, Bernd Schubert 写道:
>> Currently, FUSE io-uring requires all queues to be registered before
>> becoming ready, which can result in too much memory usage.
> 
> Thank you very much for this patchset! We have also encountered this 
> issue and have been using per-CPU fiq->ops locally, which combines uring 
> ops and dev ops for a single fuse instance. After discussing it, we 
> prefer your solution as it seems excellent!
> 
>>
>> This patch introduces a static queue mapping system that allows FUSE
>> io-uring to operate with a reduced number of registered queues by:
>>
>> 1. Adding a queue_mapping array to track which registered queue each
>>     CPU should use
>> 2. Replacing the is_ring_ready() check with immediate queue mapping
>>     once any queues are registered
>> 3. Implementing fuse_uring_map_queues() to create CPU-to-queue mappings
>>     that prefer NUMA-local queues when available
>> 4. Updating fuse_uring_get_queue() to use the static mapping instead
>>     of direct CPU-to-queue correspondence
> 
> It appears that fuse_uring_do_register can assist in determining which 
> CPU has been registered. Perhaps you could also modify libfuse to make 
> use of this feature. Could you provide that?

Just had forgotten to post it:
https://github.com/bsbernd/libfuse/tree/uring-reduce-nr-queues.

In that branch you can specify the number of queues to use,
cores are then auto-selected. Or you can specify a core mask on
which cores queues are supposed to run on.

Kernel patch series v2 should follow in the evening, I was busy
till last week with other things.


Thanks,
Bernd

