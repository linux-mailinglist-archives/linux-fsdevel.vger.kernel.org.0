Return-Path: <linux-fsdevel+bounces-23210-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55691928B0C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 17:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FF7F286AB4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 15:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2AA515FA60;
	Fri,  5 Jul 2024 15:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="HXdJnhE2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vn2Nc6T3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9CB148853
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jul 2024 15:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720191772; cv=none; b=sN53fpBRJrIwu7kpVuH1HaZ8mmUGO3iLbyXzdJUZe3YIutZjQxQfVheIqmdB4qUyJP+BjK0BEsCtjtYTMiMA3PXIvlWmkT1nxK4sQZ0g6zwDcKNEtxyQZBtjregG1lOmy5nnqjDJn7lajBYyC3MSQEHpFO6YD311a09SJ/ipWEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720191772; c=relaxed/simple;
	bh=iOOQCLk6yGIkuyNrRH2EGj1ncjYlDZd8paT+EiCQISg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=harm6Jyj+2VTAPQbElx398ksnAytWOaTQMY0a5Plg+0Fc0pOgHCB6vuPaSSVdxXKJW4FxcS6IVRZfPjrM/OhWLsljNNN2BZOoXrQVv0Ycq2g/gQkcVLBnX6ya79jViqZQOt/ThmPJGru8pBJ2lmtnC/XW91DtFa9oHgISbkOS8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=HXdJnhE2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vn2Nc6T3; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id E54771140163;
	Fri,  5 Jul 2024 11:02:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 05 Jul 2024 11:02:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1720191769;
	 x=1720278169; bh=a3JNPOjz/dF1RkpmyoLu9TIUAMQ8TA6u4dh6wSFbB3o=; b=
	HXdJnhE2H3EeAC5+3TYw6x1/nNJPlGnCWArQrGI3ulwguLc0nSo7EaEgI/TybZ0q
	JnbatGaRyaqgTSXKuOqiDRt5Ylw36GhMyR6tbVXJy1r0VpObW4+0tu5Vq7BjC8Zo
	Dub2+EMgX+VjD0j8zBPUp96JKyH5LrXve1TYjtAunYipx9X4agtCZ/yClADqrKDL
	aV3k1fV3pb4tJiMiPflUAlw6dfmbn8TVAOPoFw2J49O/gKmS5j8GbgdqGvlkjaLn
	GpGQjGWmi0rR8cG570mRr9ZyPCNHzPkXjJAvnzYua5rRTcQPeNtbp06TASw5PwS8
	unW7kG1Nx20xZkus4xAV2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1720191769; x=
	1720278169; bh=a3JNPOjz/dF1RkpmyoLu9TIUAMQ8TA6u4dh6wSFbB3o=; b=V
	n2Nc6T3oNUiTW5hGhCgMs7ySShNruo0T8pxgkYC7TDD2PxXuZkSKoVA6+weWg5/g
	tV0Zkwb4PgQso+7VKAsFDbfnEmISNsBsMTiiLNyLdnigWZkJ6lifUwkdImdmJoBx
	q2AVbG5AY6X3xM46YrtKIxNWqcpjiyGSnIVMaTmzFZj6AVmfBXoB3lQ+NmzISAre
	HzMPIIWSg9ImqhFHEgZ7m0vn0PdOtvgPJJpFMzTbmrlEDjWdTL7jZAtz8G8wYkVQ
	bB5rM+/tYiAn0hutYTw9WukP8EqYXB9C2/dFvkDRskLgi//S2cJMI+l9MC7pJ09B
	YpJYB5ZAY8pRcljAES8Ow==
X-ME-Sender: <xms:GAuIZl2LAbNHLAlQgXyIpgcHNFJyH2q5ZpMi3Tee9Sskj0UkPOaBNQ>
    <xme:GAuIZsEAkALpM-wE2iboorZE9q-RwHGCUwfi6xBRmhRrcMt5QnwHLscP5gkTTxSOX
    BnFprEFNq0j_K_G>
X-ME-Received: <xmr:GAuIZl4QSn8wtJVdoJnPPCU87LSYdFhQG3LsR_bIbIpNtzuPtkKHTPTN_O00voGk-o2ep_TyNZ2Q2xAnLn6AhzKNXJa78Ogv3qSY7yY5qBQLvTePr1Nj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddugdekfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepuegvrhhn
    ugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilh
    drfhhmqeenucggtffrrghtthgvrhhnpeevhffgvdeltddugfdtgfegleefvdehfeeiveej
    ieefveeiteeggffggfeulefgjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhf
    mh
X-ME-Proxy: <xmx:GAuIZi3YyJxJzalOVMULmUVvxhLPVTJYWhobeVfaQEyRK4J4JbvVfg>
    <xmx:GAuIZoE9fL8Iw5A66qvjOGxDmFGxK_Xapo0M5dTrm5KE8dgBu1b6YQ>
    <xmx:GAuIZj-y-jgd-Mn65OFT8R2Z8h13dcESIyL-qNuCu6PgEEyn0NazmA>
    <xmx:GAuIZlkQlOXqmYwZAm_omIVGYtw9ncy6X-aBZ9hMQoo-7M2brS7t4g>
    <xmx:GQuIZsCAydbUSgV4OeZgIFzGS1_5CZT5ZX6UjmUo9GgA8lMI72r2FK_W>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Jul 2024 11:02:47 -0400 (EDT)
Message-ID: <cdcb7b08-d7c6-4efb-a27c-23c9dff1de9e@fastmail.fm>
Date: Fri, 5 Jul 2024 17:02:46 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][RESEND] fuse: add simple request tracepoints
To: Josef Bacik <josef@toxicpanda.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org
References: <fc6559455ed29437cd414c0fc838ef4749670ff2.1720017492.git.josef@toxicpanda.com>
 <21a2cfee-0067-43d1-b605-68a99abd9f53@fastmail.fm>
 <20240705145226.GA879955@perftesting>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, fr, ru
In-Reply-To: <20240705145226.GA879955@perftesting>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/5/24 16:52, Josef Bacik wrote:
> On Thu, Jul 04, 2024 at 07:20:16PM +0200, Bernd Schubert wrote:
>>
>>
>> On 7/3/24 16:38, Josef Bacik wrote:
>>> I've been timing various fuse operations and it's quite annoying to do
>>> with kprobes.  Add two tracepoints for sending and ending fuse requests
>>> to make it easier to debug and time various operations.
>>
>> Thanks, this is super helpful.
>>
>> [...]
>>>
>>> +	EM( FUSE_STATX,			"FUSE_STATX")		\
>>> +	EMe(CUSE_INIT,			"CUSE_INIT")
>>> +
>>> +/*
>>> + * This will turn the above table into TRACE_DEFINE_ENUM() for each of the
>>> + * entries.
>>> + */
>>> +#undef EM
>>> +#undef EMe
>>> +#define EM(a, b)	TRACE_DEFINE_ENUM(a);
>>> +#define EMe(a, b)	TRACE_DEFINE_ENUM(a);
>>
>>
>> I'm not super familiar with tracepoints and I'm a bit list why "EMe" is
>> needed
>> in addition to EM? CUSE_INIT is just another number?
> 
> This is just obnoxious preprocessor abuse, so you're right this first iteration
> of EMe() is the same as EM(), but if you look right below that you have
> 
> /* Now we redfine it with the table that __print_symbolic needs. */
> #undef EM
> #undef EMe
> #define EM(a, b)        {a, b},
> #define EMe(a, b)       {a, b}
> 
> so later when we do
> 
> __print_symbolic(__entry->opcode, OPCODES)
> 
> OPCODES gets turned intoo
> 
> __print_symbolic(__entry->opcode,
> 		{FUSE_LOOKUP, "FUSE_LOOKUP"},{...},{CUSE_INIT, "CUSE_INIT"})
> 
> it's subtle and annoying, but the cleanest way to have these big opcode tables
> that are easy to add/remove stuff from for clean output.  Thanks,

Ah, I had missed the comma difference, sorry for the noise!
Looks good and very useful to me (I'm also using it now).


Reviewed-by: Bernd Schubert <bschubert@ddn.com>

