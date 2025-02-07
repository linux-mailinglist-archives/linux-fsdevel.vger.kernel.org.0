Return-Path: <linux-fsdevel+bounces-41182-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21628A2C163
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 12:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF8FC1662B7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 11:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93FF1DE4D8;
	Fri,  7 Feb 2025 11:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="m/PsobRW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GSaFdmRK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4CD1DE8BC;
	Fri,  7 Feb 2025 11:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738926981; cv=none; b=PsLJtaS+Ac5UBPKGS6GY3hbd6GhdQiLqyfSBRrlZIJIRjYXgrnYwEqhjTrIGIOC+VkiYxW0fBMHBRpTVDoun3vBGJdEdotDlzgSgbzy8X3g89wIRwNH4lCl/tJQsz9irtMK99rE5/J5U4l73ubxMGxj1zWY4Sl5IbQ8We7ExbHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738926981; c=relaxed/simple;
	bh=DROL0ZXTKDjz9yzFbtNgyiI5REj61oxPGEL9qJLwF5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qmjwv0qcJlFT0YxeZ2CVwjp2xvdFrBApOA3Tw4LlSv0auqD7Qz1WJdZ6ZFT5YdlqDOf8G2pfYYEsJCgeYkgkg2k3RbwOIgwjwKFGR75CgDReRTQtrJspbqagsBjb++UjRFMGi1auzLAZAE8Ix6L81VLCxwdpNTwqiVgdnPhfH3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=m/PsobRW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GSaFdmRK; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 318931380173;
	Fri,  7 Feb 2025 06:16:16 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 07 Feb 2025 06:16:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1738926976;
	 x=1739013376; bh=6Aibj85N4Xec6Md8vzDUFOhcxs5xfx+jKDyQhwhdMb4=; b=
	m/PsobRW644YOws6wEwgWIOiDRsrV3jqWbP5ZnESppbnJvawwsBs6OIPmakPwgQw
	LNZz+wtWory4jdAZQ2go6zLjvR1qgNPL9u4h/baZCngKEuSzS65ZTZ5zNvxJIGEL
	UjlQ2DdBAXZ7HhwNbub+2MLeELVQSAz6lxBX2E/mwtcBP4MX17nQLhFAvoWlr9+J
	qqtuB6zb2o9b6f0E3A1LiKRjrN5iUAqfcKk90HIRq9YgSBzIi0IM+HZXVFxvEt2P
	5cC6BaQMWxroQvO8jajcR1V1h5r6/mYjVnuIsf4peQmuav+qqMqQ5VzDtHlzj0ht
	Nte1vBBPaNhURx7BApv3yA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738926976; x=
	1739013376; bh=6Aibj85N4Xec6Md8vzDUFOhcxs5xfx+jKDyQhwhdMb4=; b=G
	SaFdmRK8lPjTAepSVafaUoCjWzBBcE+1WuM9Hq/7TyHFONaXfKvAKQ02mXiJArk0
	fF4tWhW3XqyCXyoa1rallflj4l+vI8PvSTGRNMSqMZX7u8ndU1HlxvTSmYbvA5Xc
	fOTutlsDaeuqzsoS7zLHxoe3vBCdwiykSWYoqfFjToN+oWjF1fJ5AZ3Wajb0wdM8
	JH5/7dYQ2XFS4h/phMJywtG7DEx1gAZXQ1Xuti3SOjuTd2I26DngBPn9fAwMqGB7
	zd5d3ijabbE9BjBbh8Hnl4PACv8dj9Nx3NscSo8K9OArYwJTgPHYfEVBwaivud+K
	lhTg03BXEqSF+/uZ1eX6w==
X-ME-Sender: <xms:f-ulZ01q_VJ4rAl2wrjghhE_kZAC2tyueeWcTyuAJy-evyFmpPK8Jw>
    <xme:f-ulZ_GMWRB74JUMU6wpfUUM2yQaZeyrZHuQ4QFNLSbOrOLGJ0Oqe190QdeO-kwMI
    W653cX1I6Ax5Lv1>
X-ME-Received: <xmr:f-ulZ87gTU6oVkM3kMCzpMQqA9BKLP90rQs4FD_RqDHPUjS2RYcsoi8CbiBsFRlTaAoAVdpNfYC7LohHHqYEK0_uCQi026dd5GIKEP__wND0vokYuVmy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddv
    jeenucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugessghssggvrh
    hnugdrtghomheqnecuggftrfgrthhtvghrnhepuefgvedvgeeguedtlefggfeigfffjeeh
    ffektdeiudffheelvdefveegjeehtdejnecuffhomhgrihhnpehgihhthhhusgdrtghomh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghr
    nhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmh
    htphhouhhtpdhrtghpthhtohepvhgsrggskhgrsehsuhhsvgdrtgiipdhrtghpthhtohep
    mhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopeifihhllhihsehinhhfrh
    gruggvrggurdhorhhgpdhrtghpthhtoheptghhrhhishhtihgrnheshhgvuhhsvghlrdgv
    uhdprhgtphhtthhopehjohhsvghfsehtohigihgtphgrnhgurgdrtghomhdprhgtphhtth
    hopehmshiivghrvgguihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprhgvghhrvghs
    shhiohhnsheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehlihhnuhigqd
    hkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhig
    qdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:f-ulZ9037XXRMk8nBj87nbhmleQ-1eFdpxLz4kWX-V-rP9J0WWMs2g>
    <xmx:f-ulZ3EbMbjvJ4uNwBjcaldrup2upqo7iLml8r4KvJtMhn9PtUvPDQ>
    <xmx:f-ulZ2_Rolb0lsFmS-2pvgBZ1AnMzw1RPcWERKe93CegqYZ6QaFhyQ>
    <xmx:f-ulZ8l3bvJBNoLfZUk8jK5-rw-bzEES6XpAsnsVGqvPXZbuVKVj8Q>
    <xmx:gOulZ2f8u7iE_17qld9_K2K7zPjwn0-Agw7XXHYJivHCVmunR8NtYJSr>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Feb 2025 06:16:13 -0500 (EST)
Message-ID: <94df7323-4ded-416a-b850-41e7ba034fdc@bsbernd.com>
Date: Fri, 7 Feb 2025 12:16:12 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION][BISECTED] Crash with Bad page state for FUSE/Flatpak
 related applications since v6.13
To: Vlastimil Babka <vbabka@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>
Cc: Matthew Wilcox <willy@infradead.org>,
 Christian Heusel <christian@heusel.eu>, Josef Bacik <josef@toxicpanda.com>,
 Miklos Szeredi <mszeredi@redhat.com>, regressions@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Joanne Koong <joannelkoong@gmail.com>, linux-mm <linux-mm@kvack.org>,
 =?UTF-8?Q?Mantas_Mikul=C4=97nas?= <grawity@gmail.com>
References: <2f681f48-00f5-4e09-8431-2b3dbfaa881e@heusel.eu>
 <CAJfpegtaTET+R7Tc1MozTQWmYfgsRp6Bzc=HKonO=Uq1h6Nzgw@mail.gmail.com>
 <Z6XWVU6ZTCIl3jnc@casper.infradead.org>
 <03eb13ad-03a2-4982-9545-0a5506e043d0@suse.cz>
 <CAJfpegtvy0N8dNK-jY1W-LX=TyGQxQTxHkgNJjFbWADUmzb6xA@mail.gmail.com>
 <f8b08ef9-5bba-490c-9d99-9ab955e68732@suse.cz>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <f8b08ef9-5bba-490c-9d99-9ab955e68732@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/7/25 11:55, Vlastimil Babka wrote:
> On 2/7/25 11:43, Miklos Szeredi wrote:
>> On Fri, 7 Feb 2025 at 11:25, Vlastimil Babka <vbabka@suse.cz> wrote:
>>
>>> Could be a use-after free of the page, which sets PG_lru again. The list
>>> corruptions in __rmqueue_pcplist also suggest some page manipulation after
>>> free. The -1 refcount suggests somebody was using the page while it was
>>> freed due to refcount dropping to 0 and then did a put_page()?
>>
>> Can you suggest any debug options that could help pinpoint the offender?
> 
> CONFIG_DEBUG_VM enables a check in put_page_testzero() that would catch the
> underflow (modulo a tiny race window where it wouldn't). Worth trying.

I typically run all of my tests with these options enabled

https://github.com/bsbernd/tiny-qemu-virtio-kernel-config


If Christian or Mantas could tell me what I need to install and run, I
could probably quickly give it a try.



Thanks,
Bernd

