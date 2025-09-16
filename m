Return-Path: <linux-fsdevel+bounces-61707-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E59F3B591E9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 11:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78C35161CCD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 09:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A544D2580F9;
	Tue, 16 Sep 2025 09:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="BRdJ3Bw3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DBquHLeR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB51B17597
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 09:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758014279; cv=none; b=S0ug/hAo/H4uf/A8X6PVeb1G9qMsstMb10/lJi250P/2jH+T3pigoj2LUQsi3T4gZU+JrHjo4IiAKhY/cGOOQKBAOzggjwOT4mDyxwJuDP3dDdRjsNsuP8kGnqoC30v1IlP5LrH1KC7AaUdd8PyEnoyurBNRGjJqfpfGS1nOSI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758014279; c=relaxed/simple;
	bh=QewYBolD3qDrFHYdzN1pEDVbU6uD6tkiUnPG8yHRc5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j60hcNNIiZDYDAcGh9gBAsqk0QAEtH+edI1WKv+CI3AJUAJ39u66uNjZ5+d0H6tSqZRYHhECzr0CyT9Tx0KDaM/rmLFHm+NEBEM4gdCkhhGmxBoJn3fUyfb8xqmXJR+jPon8j/+JiYcMpN5Zb3pYrZrcBEBVqwQ+IF8kOU9SPx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=BRdJ3Bw3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DBquHLeR; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id E92DCEC023E;
	Tue, 16 Sep 2025 05:17:55 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 16 Sep 2025 05:17:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1758014275;
	 x=1758100675; bh=CXbyD4jzmWQ1VtHqrCjK+sGbU6slLV0OI/tZ7st5Bp0=; b=
	BRdJ3Bw3ivWQjP6UNr7jBqQIhs8SIDRIncR1Ua0+IAZ9jhVAWD/0HeQHpzR3UrnO
	808xGS+EPb+S1vNad6EA1G1vJ95g+K5PaXllT/0TA3+/kCqIFxwzHcjIjrycxP1i
	N8PVKY17/MKD0Diz7zp6lzPdbR32tbeoLySc+zp+T3Us2wNVZ6HTArOGTWtCPI7s
	rJmfL9y9Z7Ea6DHSFP24K/ZK49qDVvZ7TpEJSu46pszQ8k6RPsRqGCaiegaE7HUz
	42TWtLj0p78Lci0kmms+vlMgL5kggVHuhE4gkr5wSHk7P2410ta6BH9fDG/70Ap6
	PQAVOzPNZ8W9QGFHnVk+5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758014275; x=
	1758100675; bh=CXbyD4jzmWQ1VtHqrCjK+sGbU6slLV0OI/tZ7st5Bp0=; b=D
	BquHLeRNYG9PSjU7cu8k4WPqwsOWalFCuKRhxBnAZQh4KST4/YUCkFpIyvqJVsaw
	htHqn7/RlApVm097Pqey1QZYWddJUxdEjTksTkkUJufKRFZjKierLs1JfW2X+qbM
	hat6yGXJKjk50ldodIcuEba9Y6WjBusLpg7CweNi+O+Z/tASI5U8McY5pSBTCakU
	X6xab8nqe+BgmVKgCmuU6LtWPuL99/HM1kf5Jv6mEEq1Mvfn7o8v9yQ2Nc5dQ7Gf
	/XUWZstg2IvYemiyIdGDgePN7EkV7RIifC7Imkq/gDprntBMAX2KeOpgrzhs7Tcg
	OOyVdWYpeW5a9Flz9/j1w==
X-ME-Sender: <xms:QyvJaDU5pCUXidgFhCBCLF3ujAmhCZ9l6Z3rvxqTsb0ReCvYjWTrAg>
    <xme:QyvJaGIHGLOizHtMJ71hC86pBP2Zxjjxez0KY4XPsbn5xU52YgdLSXaIyLWSyDN1a
    9USlUOxmJT3Qu-1>
X-ME-Received: <xmr:QyvJaL8-VXuBUYgDwzyhcf-uZY8gqgn1E_U8lDaX-59EslKaii0r1XuiMLStPtEhxwMfjJS7qYiaKpSqyGdYkwEgUF1QaUcqxUYBjRneps8uT2OL_Uvy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegtddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepuegvrhhnugcu
    ufgthhhusggvrhhtuceosggvrhhnugessghssggvrhhnugdrtghomheqnecuggftrfgrth
    htvghrnhepfeeggeefffekudduleefheelleehgfffhedujedvgfetvedvtdefieehfeel
    gfdvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    gvrhhnugessghssggvrhhnugdrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhorghnnhgvlhhkohhonhhgsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtoheprghlihesuggunhdrtghomhdprhgtphhtthhopehlihhnuhigqdhf
    shguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhikhhloh
    hssehsiigvrhgvughirdhhuh
X-ME-Proxy: <xmx:QyvJaBKHAEFRnmgzN7cWS3qIfoSaI6fi4XefpWXzTxvG_F094WeTnA>
    <xmx:QyvJaIn8wZUY7QeKBr3RiCzUPjEZUskediVV-TdfkOlLGJB55zhkOw>
    <xmx:QyvJaNOvsjCOV7goLPJaE6A4KWjxNz_mzudFCEfXN6hneKNrgRYZ4w>
    <xmx:QyvJaG1VvXFhWVjDaNYmFE9GBbDdO3qBJ0n-ASv6pbB_oI4kEDtdGw>
    <xmx:QyvJaCwtFurDHe1cREIp5gzndcaVLNc_8k8v-9ewzGkItU3GnOQziG3m>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Sep 2025 05:17:54 -0400 (EDT)
Message-ID: <e5793dc4-94f8-4216-aa0c-463331d3092b@bsbernd.com>
Date: Tue, 16 Sep 2025 11:17:53 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fs/fuse: fix potential memory leak from
 fuse_uring_cancel
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Jian Huang Li <ali@ddn.com>, linux-fsdevel@vger.kernel.org,
 miklos@szeredi.hu
References: <94377ddf-9d04-4181-a632-d8c393dcd240@ddn.com>
 <CAJnrk1ZHfd3r1+s0fV209LROO1kixM=_T7Derm+GrR_hYa_wpw@mail.gmail.com>
 <99313bf9-963f-430e-a929-faa915d77202@bsbernd.com>
 <CAJnrk1aYqZPNg_O25Yv6d5jGdzcPv0oyQ93KwarxovBJMyymdA@mail.gmail.com>
 <4acdbba9-c4ad-4b33-b74b-2acc424cb24a@bsbernd.com>
 <478c4d28-e7d9-4dbd-9521-a3cea73fddde@bsbernd.com>
 <CAJnrk1ahQf5-Rb+axFJ=yNn=AWneTtYjKMFzVeorKjQfTjc9Aw@mail.gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJnrk1ahQf5-Rb+axFJ=yNn=AWneTtYjKMFzVeorKjQfTjc9Aw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/16/25 01:04, Joanne Koong wrote:
> On Mon, Sep 15, 2025 at 2:57 PM Bernd Schubert <bernd@bsbernd.com> wrote:
>> On 9/15/25 23:46, Bernd Schubert wrote:
>>> On 9/15/25 23:23, Joanne Koong wrote:
>>>> On Mon, Sep 15, 2025 at 1:15 PM Bernd Schubert <bernd@bsbernd.com> wrote:
>>>>>
>>>>> Hi Joanne,
>>>>>
>>>>> thanks for looking into this.
>>>>>
>>>>> On 9/15/25 20:15, Joanne Koong wrote:
>>>>>> On Thu, Sep 11, 2025 at 3:34 AM Jian Huang Li <ali@ddn.com> wrote:
>>>>>>>
>>>>>>> This issue could be observed sometimes during libfuse xfstests, from
>>>>>>> dmseg prints some like "kernel: WARNING: CPU: 4 PID: 0 at
>>>>>>> fs/fuse/dev_uring.c:204 fuse_uring_destruct+0x1f5/0x200 [fuse]".
>>>>>>>
>>>>>>> The cause is, if when fuse daemon just submitted
>>>>>>> FUSE_IO_URING_CMD_REGISTER SQEs, then umount or fuse daemon quits at
>>>>>>> this very early stage. After all uring queues stopped, might have one or
>>>>>>> more unprocessed FUSE_IO_URING_CMD_REGISTER SQEs get processed then some
>>>>>>> new ring entities are created and added to ent_avail_queue, and
>>>>>>> immediately fuse_uring_cancel moves them to ent_in_userspace after SQEs
>>>>>>> get canceled. These ring entities will not be moved to ent_released, and
>>>>>>> will stay in ent_in_userspace when fuse_uring_destruct is called, needed
>>>>>>> be freed by the function.
>>>>>>
>>>>>> Hi Jian,
>>>>>>
>>>>>> Does it suffice to fix this race by tearing down the entries from the
>>>>>> available queue first before tearing down the entries in the userspace
>>>>>> queue? eg something like
>>>>>>
>>>>>>  static void fuse_uring_teardown_entries(struct fuse_ring_queue *queue)
>>>>>>  {
>>>>>> -       fuse_uring_stop_list_entries(&queue->ent_in_userspace, queue,
>>>>>> -                                    FRRS_USERSPACE);
>>>>>>         fuse_uring_stop_list_entries(&queue->ent_avail_queue, queue,
>>>>>>                                      FRRS_AVAILABLE);
>>>>>> +       fuse_uring_stop_list_entries(&queue->ent_in_userspace, queue,
>>>>>> +                                    FRRS_USERSPACE);
>>>>>>  }
>>>>>>
>>>>>> AFAICT, the race happens right now because when fuse_uring_cancel()
>>>>>> moves the FRRS_AVAILABLE entries on the ent_avail_queue to the
>>>>>> ent_in_userspace queue, fuse_uring_teardown_entries() may have already
>>>>>> called fuse_uring_stop_list_entries() on the ent_in_userspace queue,
>>>>>> thereby now missing the just-moved entries altogether, eg this logical
>>>>>> flow
>>>>>>
>>>>>> -> fuse_uring_stop_list_entries(&queue->ent_in_userspace, ...);
>>>>>>     -> fuse_uring_cancel() moves entry from avail q to userspace q
>>>>>> -> fuse_uring_stop_list_entries(&queue->ent_avail_queue, ...);
>>>>>>
>>>>>> If instead fuse_uring_teardown_entries() stops the available queue first, then
>>>>>> -> fuse_uring_stop_list_entries(&queue->ent_avail_queue, ...);
>>>>>>     -> fuse_uring_cancel()
>>>>>> -> fuse_uring_stop_list_entries(&queue->ent_in_userspace, ...);
>>>>>>
>>>>>> seems fine now and fuse_uring_cancel() would basically be a no-op
>>>>>> since ent->state is now FRRS_TEARDOWN.
>>>>>>
>>>>>
>>>>> I'm not sure. Let's say we have
>>>>>
>>>>> task 1                                   task2
>>>>> fuse_uring_cmd()
>>>>>     fuse_uring_register()
>>>>>          [slowness here]
>>>>>                                         fuse_abort_conn()
>>>>>                                           fuse_uring_teardown_entries()
>>>>>          [slowness continue]
>>>>>          fuse_uring_do_register()
>>>>>             fuse_uring_prepare_cancel()
>>>>>             fuse_uring_ent_avail()
>>>>>
>>>>>
>>>>> I.e. fuse_uring_teardown_entries() might be called before
>>>>> the command gets marked cancel-able and before it is
>>>>> moved to the avail queue. I think we should extend the patch
>>>>> and actually not set the ring to ready when fc->connected
>>>>> is set to 0.
>>>>>
>>>>
>>>> Hi Bernd,
>>>>
>>>> I think this is a separate race from the fuse_uring_cancel one.
>>>> afaics, this race can happen even if the user doesn't call
>>>> fuse_uring_cancel(). imo I think the cleanest solution to this
>>>> registration vs teardown race is to check queue->stopped in
>>>> fuse_uring_do_register() after we grab the queue spinlock, and if
>>>> queue->stopped is true, then just clean up the entry ourselves with
>>>> fuse_uring_entry_teardown()).
>>>
>>> What speaks against just doing as in the existing patch and freeing
>>> the ent_in_userspace entries fuse_uring_destruct()?
>>> IMO it covers both races, missing is just to avoid setting the ring
>>> as ready.
> 
> Couldn't the entry in fuse_uring_do_register() be in the available
> queue when we get to fuse_uring_destruct() which means the existing

We would never go into fuse_uring_destruct(), because io-uring would
still hold references on the fuse device / fuse_conn.

> patch would also have to iterate through the available queue too? eg
> i'm imagining something like
> 
> fuse_uring_do_register()
>    -> fuse_uring_prepare_cancel()
>          *** fuse_uring_cancel() + teardown run on other threads
>    -> fuse_uring_ent_avail()

Up to hear it is right, but then see io_ring_exit_work() in io_uring.c.
I.e. it will run io_uring_try_cancel_requests() in a loop.
fuse_uring_cancel() is a noop as long as ent->state != FRRS_AVAILABLE

If commands are not cancelled at all, io_ring_exit_work() will print
warnings in intervals - initially I hadn't figured out about
IO_URING_F_CANCEL (and maybe it also didn't exist in earlier kernel
versions) and then had added workarounds into fuse_dev_release(),
because of the io-uring references.

> 
> imo, I think this scenario is its own separate race (between
> registration and cancellation, that can happen irregardless of
> teardown) that should be fixed by calling fuse_uring_prepare_cancel()
> only after the fuse_uring_ent_avail() call, but I think this
> underscores a bit that explicitly checking against torn down entries
> is more robust when dealing with these races.
> 
>>
>> Well, maybe cleaner, I don't have a strong opinion. We could skip the
>> comment and explanation with your approach.
> 
> I don't really have a strong opinion on this either, just wanted to
> share my thoughts. If you'd rather go with the existing patch, then we
> should do that.


I still think Jians patch works as it is, although there is a bit magic
behind it. The mere fact that we have the discussion above it probably
reason enough to at least try to find a way to make easier to read.


Thanks,
Bernd

