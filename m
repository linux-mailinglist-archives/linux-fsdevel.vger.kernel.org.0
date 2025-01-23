Return-Path: <linux-fsdevel+bounces-39988-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A2EA1A95D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 19:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42CC97A1917
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 18:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8836154C07;
	Thu, 23 Jan 2025 18:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="CwhVWvj5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QuuaC0di"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062EE13AD03
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 18:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737655616; cv=none; b=uBE78jDygT4NVUrut1hzzRlDRghoT0Yt6Q64+p7/mjNFr0hqwANp7mZD41poP8o6V9wqc6v7JeBntIm21tvwS2+IJNFV+1Bf1tho7KJXtrocDbTDa/TfHvPoJCUxXVpZoROKzMZ5hE5o/+F78qwymwCHv4NhXASHrmQzKovEwPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737655616; c=relaxed/simple;
	bh=g0AvpfSlWd+TXj8Uyfvr7WHwZeVDAcKPdQUhRf+I6Tc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZQHHhMg5ik/FqvblvF0fL9FIoxoR4l6EtLNWCqlOb54h5lIh6wD5xwNuLXAWRqAivzLZOgcdVcDzF/OA7lhQz8oWja/y2c0oQe0keyCjiaZWR7tsf8ifvluL2kjQGhb8YKppnC1CKCQBcMbyeGPQ0fVlkyDdiaBYb2rEEN3JGVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=CwhVWvj5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QuuaC0di; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id BD91E11400BF;
	Thu, 23 Jan 2025 13:06:53 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 23 Jan 2025 13:06:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1737655613;
	 x=1737742013; bh=m9iclX3Fi9r/kGrs6o769OftzHlFezggHmPimC5oQso=; b=
	CwhVWvj5ri+0IucfGNqovCRlIWyALS16WkL4dsZ/YuRp5dP62ilJucLanKIwPRRI
	I1zYjt8f4E6wYQ7kO5he4sBDs3YGNDdrnU3fWY6JeeRObf9dVTqg9Ie8IAgeColn
	ZM4RRAUMLEPJx/pHhP54YUAJHhKX/bKcz78FJsDmlk1dHhcc/Rq4SqStUyFtSXl4
	Fo+NodgjWHCM7/iEH1UGCtg8odGXupIywwChs5bwsyT2vYSFxLDIWOZJWca5OUr3
	i0mFH279q/jUP+9yJ5CzoZXGs/3buIfEApW5tqHe28OiQfJpzwSPoY9rpArVKGqe
	1bac8jccJC29Mnd18qB/4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1737655613; x=
	1737742013; bh=m9iclX3Fi9r/kGrs6o769OftzHlFezggHmPimC5oQso=; b=Q
	uuaC0diwaysVz/IQNV0TEZ3AUeYWfBja/rpn/yzWO9KnxPVi/Ufk1WxnS1YX+GEK
	eJYzDO9ksw0i0ARN3DtLlEgK2mwASUvvccvLHeOHlnDXGaaBIxScBu8W4PWY2wOU
	iVbZC4F+K6WduNFK3f872o79XovFbLbhBE1gQ/LEb1X/Y8uVCbjez7ktoH4SZm3M
	+IYxM61EentcF3MSWMgBHLoGlaqQO66aJMvlrsNMiskOdYg9ek8khp7+ZTAC9ONL
	7lrWW3Kit3zWYFfrUQYmys+iP3Jsmla05TJ2JhEwVhjztq5wYwnMgEEO6LNdeVm+
	AKFsSdmNPUVflIlvjX0/g==
X-ME-Sender: <xms:O4WSZz1jjBPV-xmRlLpi_-fLuFxC7jNSkYyFLJ2LD_zOQGCfDHxZKA>
    <xme:O4WSZyErIR7cdBzl0yfmzbSEYTnlsKrrrpIDhpMeBM7T6cwJ_TXvFOw6xQ-o5tf4e
    Za8PTMnZ7ekUHkL>
X-ME-Received: <xmr:O4WSZz5bq_jqa-j4dRQpjQogygRG87984f4ofE35qG2FpgP6UnllR2r7tYJ8CSYPfumVF7aUCO6bSj1nDYX1NEYV6otQj5zbY7I90wCL9JkGEvTUNDuM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgvdeffecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddv
    jeenucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusg
    gvrhhtsehfrghsthhmrghilhdrfhhmqeenucggtffrrghtthgvrhhnpeduleefvdduvedu
    veelgeelffffkedukeegveelgfekleeuvdehkeehheehkefhfeenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghr
    thesfhgrshhtmhgrihhlrdhfmhdpnhgspghrtghpthhtohepudegpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehjohgrnhhnvghlkhhoohhnghesghhmrghilhdrtghomhdp
    rhgtphhtthhopegsshgthhhusggvrhhtseguughnrdgtohhmpdhrtghpthhtohepmhhikh
    hlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghl
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhgvfhhflhgvgihusehlih
    hnuhigrdgrlhhisggrsggrrdgtohhmpdhrtghpthhtoheplhgrohgrrhdrshhhrghosehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepshgvnhhoiihhrghtshhkhiestghhrhhomhhiuhhmrdhorhhgpdhrtghp
    thhtohepthhfihhgrgestghhrhhomhhiuhhmrdhorhhg
X-ME-Proxy: <xmx:O4WSZ435-vpvI19s5jsdNAl0mD_r655LNCOdDTid2sWZT-CjxO6sVQ>
    <xmx:O4WSZ2GzUOmHrqiNZyF45h-HxdqbUBsivQ7CRvRlDCndjQveoOsTQw>
    <xmx:O4WSZ58i2NQfnTI1nIzqCedyYzVdSXKg93Lc8x-BKwduhdjT2YVUoQ>
    <xmx:O4WSZzkpUw7MeQmNYCFGrRq_Vu8N0_8Cu9QOTS1SoK5b-fx6iRUXfA>
    <xmx:PYWSZzczjVBgJg9YluoeWM7qeooCk9vlOYQXp-379G_xjwQUlmkWcekY>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Jan 2025 13:06:50 -0500 (EST)
Message-ID: <325b214c-4c7b-4826-a1b9-382f5a988286@fastmail.fm>
Date: Thu, 23 Jan 2025 19:06:48 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 2/2] fuse: add default_request_timeout and
 max_request_timeout sysctls
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Bernd Schubert <bschubert@ddn.com>, Miklos Szeredi <miklos@szeredi.hu>,
 linux-fsdevel@vger.kernel.org, jefflexu@linux.alibaba.com,
 laoar.shao@gmail.com, jlayton@kernel.org, senozhatsky@chromium.org,
 tfiga@chromium.org, bgeffon@google.com, etmartin4313@gmail.com,
 kernel-team@meta.com, Josef Bacik <josef@toxicpanda.com>,
 Luis Henriques <luis@igalia.com>
References: <20250122215528.1270478-1-joannelkoong@gmail.com>
 <20250122215528.1270478-3-joannelkoong@gmail.com> <87ikq5x4ws.fsf@igalia.com>
 <CAJfpegtNrTrGUNrEKrcxEc-ecybetAqQ9fF60bCf7-==9n_1dg@mail.gmail.com>
 <9248bca5-9b16-4b5c-b1b2-b88325429bbe@ddn.com>
 <CAJnrk1bbvfxhYmtxYr58eSQpxR-fsQ0O8BBohskKwCiZSN4XWg@mail.gmail.com>
 <4f642283-d529-4e5f-b0ba-190aa9bf888c@fastmail.fm>
 <CAJnrk1YDFcF5GPR23GPuWnxt2WeGzf8_bc4cJG8Z-DHvbRNkFA@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJnrk1YDFcF5GPR23GPuWnxt2WeGzf8_bc4cJG8Z-DHvbRNkFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/23/25 18:48, Joanne Koong wrote:
> On Thu, Jan 23, 2025 at 9:19 AM Bernd Schubert
> <bernd.schubert@fastmail.fm> wrote:
>>
>> Hi Joanne,
>>
>>>>> Thanks, applied and pushed with some cleanups including Luis's clamp idea.
>>>>
>>>> Hi Miklos,
>>>>
>>>> I don't think the timeouts do work with io-uring yet, I'm not sure
>>>> yet if I have time to work on that today or tomorrow (on something
>>>> else right now, I can try, but no promises).
>>>
>>> Hi Bernd,
>>>
>>> What are your thoughts on what is missing on the io-uring side for
>>> timeouts? If a request times out, it will abort the connection and
>>> AFAICT, the abort logic should already be fine for io-uring, as users
>>> can currently abort the connection through the sysfs interface and
>>> there's no internal difference in aborting through sysfs vs timeouts.
>>>
>>
>> in fuse_check_timeout() it iterates over each fud and then fpq.
>> In dev_uring.c fpq is is per queue but unrelated to fud. In current
>> fuse-io-uring fud is not cloned anymore - using fud won't work.
>> And Requests are also not queued at all on the other list
>> fuse_check_timeout() is currently checking.
> 
> In the io-uring case, there still can be fuds and their associated
> fpqs given that /dev/fuse can be used still, no? So wouldn't the
> io-uring case still need this logic in fuse_check_timeout() for
> checking requests going through /dev/fuse?

Yes, these need to be additionally checked.

> 
>>
>> Also, with a ring per core, maybe better to use
>> a per queue check that is core bound? I.e. zero locking overhead?
> 
> How do you envision a queue check that bypasses grabbing the
> queue->lock? The timeout handler could be triggered on any core, so
> I'm not seeing how it could be core bound.

I don't want to bypass it, but maybe each queue could have its own
workq and timeout checker? And then use queue_delayed_work_on()?


> 
>> And I think we can also avoid iterating over hash lists (queue->fpq),
>> but can use the 'ent_in_userspace' list.
>>
>> We need to iterate over these other entry queues anyway:
>>
>> ent_w_req_queue
>> fuse_req_bg_queue
>> ent_commit_queue
>>
> 
> Why do we need to iterate through the ent lists (ent_w_req_queue and
> ent_commit_queue)? AFAICT, in io-uring a request is either on the
> fuse_req_queue/fuse_req_bg_queue or on the fpq->processing list. Even
> when an entry has been queued to ent_w_req_queue or ent_commit_queue,
> the request itself is still queued on
> fuse_req_queue/fuse_req_bg_queue/fpq->processing. I'm not sure I
> understand why we still need to look at the ent lists?

Yeah you are right, we could avoid ent_w_req_queue and ent_commit_queue
if we use fpq->processing, but processing consists of 256 lists -
overhead is much smaller by using the entry lists?


> 
>>
>> And we also need to iterate over
>>
>> fuse_req_queue
>> fuse_req_bg_queue
> 
> Why do we need to iterate through fuse_req_queue and
> fuse_req_bg_queue? fuse_uring_request_expired() checks the head of
> fuse_req_queue and fuse_req_bg_queue and given that requests are added
> to fuse_req_queue/fuse_req_bg_queue sequentially (eg added to the tail
> of these lists), why isn't this enough?

I admit I'm a bit lost with that question. Aren't you pointing out
the same lists as I do?

> 
> 
> If it's helpful, I can resubmit this patch series so that the io-uring
> changes are isolated to its own patch (eg have patch 1 and 2 from the
> original series and then have patch 3 be the io-uring changes).

Sounds good to me.


Thanks,
Bernd

