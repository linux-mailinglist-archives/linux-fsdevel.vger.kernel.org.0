Return-Path: <linux-fsdevel+bounces-55453-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8F1B0A9DE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 19:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BBF91C82ED8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 17:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9864D2E7F06;
	Fri, 18 Jul 2025 17:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="fgpx1021";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J9ZXUdHp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA0F2E6D15
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jul 2025 17:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752861441; cv=none; b=C1E3nkFEo6kUKFDeLebcGz3mYCuVaQ3zJflS7hLc1WispsMfqGy2uDJxNr2dMNTRFvzE0hditVK4vI8nFCeemQ8y65FJKk+DyNqMtMK780U4Pd0Z2N7oSqMDnYk/B2PqQKueNzZjkKMZBc6YkjOJrTvo7ZAeIFzILquctHydygo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752861441; c=relaxed/simple;
	bh=yOyrlwcf480m7JSU1y/oJGY+9TWPITbPSnb1p1ZsMzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MCddIvCdgtD+pU0v0Yc9mCRZdqFOBVSCtNFKfWnnYRPV2Ib2JNKMYcXuy7wTidO7hCYh6h4Q4YoMkWJ3g41gQmYkgkdBR511VGUMd5yoUTP9lHBMtYpzC8IU8x9OQ0L7H0wjHNeR3Iw7W/hKZox/yiXG35o9O6+Wl9AlH3dcMxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=fgpx1021; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J9ZXUdHp; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 08B9F1D00027;
	Fri, 18 Jul 2025 13:57:18 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 18 Jul 2025 13:57:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1752861437;
	 x=1752947837; bh=Djq6yXoOmGGPR8jYKjPTg2Ejdom54kNMW4qZ/LRupNE=; b=
	fgpx1021eNh7C+H0xqiF8L22LaDKEa+CvPqb4zr5DwQXskxaN+23mp9qG872WDcJ
	19OmKZZSG/cEIRTj6xNuNhRQoEIJeqyYq6acU2i8TP119EaRQda3seBlOwPtTs4Z
	AJ9A5EW8xLSfSnhJA+Hs7TRZMQYD2RaT7bVBfsffwxG/oLwSloeoDuTb0yRk7Ot4
	RZQMJZHjLvx0IcRHw1YIxu2JlrSLuzFx257UfOPhc9GQFVBGY+vrifufMuE5RXyk
	m9x+GXWqlGwdMB9QqWxceFW+fW9rKRg9b6qp7Zh6pFByEsKZklzgyglrK7Bymini
	w67yku1qPTG2zVuPUu3h5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752861437; x=
	1752947837; bh=Djq6yXoOmGGPR8jYKjPTg2Ejdom54kNMW4qZ/LRupNE=; b=J
	9ZXUdHppOJU2WCOfCFRbk+0waPCiy2QtTJat0VBFr6/OI3weo12a0lsf6SEo9V0j
	dw2kh8RQCUeldAzDlJEVbAQyXN6a1PxEMJ5YzzmoMkLTOBrPRgg+WJnl+HlV2oHw
	CEf6jyEhovghbcxi5x2qw7omgKICF6wYbaDJ8Jrkk61zWqS3bHcqWXBildgdFlCd
	GaQQ8u8LrSHyvITZlFxflquf2DW39MZcjCBoXm5wmXJ1GPrmnu+iHeozLVy9t4Fr
	rKSbaehOkDlgBBimzjCosXjeoihMypmLTdaOSux0tvdwOJZr8gK0Jv9BKH6qp0bb
	w5aO04HgCAfaOMrQH/YUA==
X-ME-Sender: <xms:_Yp6aCAOmGtuXkyvIMO0tb11Idv2pDCHmuZYJynBnyjlqt0Kp1s_9w>
    <xme:_Yp6aE8esnrWvyjGaOFYblXGljRWv7a0n-6zF5UVO2cxQxRg3SMoDbuYHWEIko5hJ
    IZA7cPJp6mYhWUq>
X-ME-Received: <xmr:_Yp6aGBR05uo3o6h8z6iJxFSjPoUtcmQJQwtLFD5T36GvSostMLP91DyG0OnlR49h52S-cOBjj8O0kWWY1BUii1lEPAMw6kCGhwvVDpPlBzmWKcZ7k0G>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeigeduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepuegvrhhnugcu
    ufgthhhusggvrhhtuceosggvrhhnugessghssggvrhhnugdrtghomheqnecuggftrfgrth
    htvghrnhepfeeggeefffekudduleefheelleehgfffhedujedvgfetvedvtdefieehfeel
    gfdvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    gvrhhnugessghssggvrhhnugdrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhorghnnhgvlhhkohhonhhgsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepughjfihonhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehl
    ihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epnhgvrghlsehgohhmphgrrdguvghvpdhrtghpthhtohepjhhohhhnsehgrhhovhgvshdr
    nhgvthdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhu
X-ME-Proxy: <xmx:_Yp6aBS1C99XKwZiyZ3bV8Hz5SytdmF5cF7UYcT3V12VGYxvFsOvRw>
    <xmx:_Yp6aFswTFKO2IDck0yCu_Q8e4l33LH3joiune268Y9kyiT-22I6uA>
    <xmx:_Yp6aF3PzgmRyKzgluguR76W-eOVkjnCmpBW5dQ74A5DFJbmNcYt4w>
    <xmx:_Yp6aOXc5cnCA-m80Krf8ur-nISlqtAS9lVsg6iCH46igzmf3aym_g>
    <xmx:_Yp6aDl7Qd3brsoMbpux5lzbynqXZO5CTetnFE4ms2wRjsjGfyhS8L1i>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Jul 2025 13:57:16 -0400 (EDT)
Message-ID: <6183725a-d3fd-473c-a5a8-52e384e579bd@bsbernd.com>
Date: Fri, 18 Jul 2025 19:57:15 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] fuse: flush pending fuse events before aborting the
 connection
To: Joanne Koong <joannelkoong@gmail.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org,
 neal@gompa.dev, John@groves.net, miklos@szeredi.hu
References: <175279449418.710975.17923641852675480305.stgit@frogsfrogsfrogs>
 <175279449501.710975.16858401145201411486.stgit@frogsfrogsfrogs>
 <286e65f0-a54c-46f0-86b7-e997d8bbca21@bsbernd.com>
 <CAJnrk1bvt=tr-87WLRx=KtGUsES09=hhpM=mspsaEezVORVLnQ@mail.gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJnrk1bvt=tr-87WLRx=KtGUsES09=hhpM=mspsaEezVORVLnQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 7/18/25 19:50, Joanne Koong wrote:
> On Fri, Jul 18, 2025 at 9:37 AM Bernd Schubert <bernd@bsbernd.com> wrote:
>>
>> On 7/18/25 01:26, Darrick J. Wong wrote:
>>> From: Darrick J. Wong <djwong@kernel.org>
>>>
>>> +/*
>>> + * Flush all pending requests and wait for them.  Only call this function when
>>> + * it is no longer possible for other threads to add requests.
>>> + */
>>> +void fuse_flush_requests(struct fuse_conn *fc, unsigned long timeout)
>>
>> I wonder if this should have "abort" in its name. Because it is not a
>> simple flush attempt, but also sets fc->blocked and fc->max_background.
>>
>>> +{
>>> +     unsigned long deadline;
>>> +
>>> +     spin_lock(&fc->lock);
>>> +     if (!fc->connected) {
>>> +             spin_unlock(&fc->lock);
>>> +             return;
>>> +     }
>>> +
>>> +     /* Push all the background requests to the queue. */
>>> +     spin_lock(&fc->bg_lock);
>>> +     fc->blocked = 0;
>>> +     fc->max_background = UINT_MAX;
>>> +     flush_bg_queue(fc);
>>> +     spin_unlock(&fc->bg_lock);
>>> +     spin_unlock(&fc->lock);
>>> +
>>> +     /*
>>> +      * Wait 30s for all the events to complete or abort.  Touch the
>>> +      * watchdog once per second so that we don't trip the hangcheck timer
>>> +      * while waiting for the fuse server.
>>> +      */
>>> +     deadline = jiffies + timeout;
>>> +     smp_mb();
>>> +     while (fc->connected &&
>>> +            (!timeout || time_before(jiffies, deadline)) &&
>>> +            wait_event_timeout(fc->blocked_waitq,
>>> +                     !fc->connected || atomic_read(&fc->num_waiting) == 0,
>>> +                     HZ) == 0)
>>> +             touch_softlockup_watchdog();
>>> +}
>>> +
>>>  /*
>>>   * Abort all requests.
>>>   *
>>> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
>>> index 9572bdef49eecc..1734c263da3a77 100644
>>> --- a/fs/fuse/inode.c
>>> +++ b/fs/fuse/inode.c
>>> @@ -2047,6 +2047,7 @@ void fuse_conn_destroy(struct fuse_mount *fm)
>>>  {
>>>       struct fuse_conn *fc = fm->fc;
>>>
>>> +     fuse_flush_requests(fc, 30 * HZ);
>>
>> I think fc->connected should be set to 0, to avoid that new requests can
>> be allocated.
> 
> fuse_abort_conn() logic is gated on "if (fc->connected)" so I think
> fc->connected can only get set to 0 within fuse_abort_conn()

Hmm yeah, I wonder if we should allow multiple values in there. Like
fuse_abort_conn sets UINT64_MAX and checks that and other functions
could set values in between? We could add another variable, but given
that it is used on every request allocation might be better to avoid too
many conditions.


Thanks,
Bernd


