Return-Path: <linux-fsdevel+bounces-61454-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30496B586E6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 23:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 393551894708
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 21:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABD4261B7F;
	Mon, 15 Sep 2025 21:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="eiYk5OrT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jpW84tW6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFE71D618A
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 21:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757972772; cv=none; b=SfiT8NLWmDMSM3Oi6rwbwxwjE4yqqa3zZ7Gb4mogA7EJt3Y4s2+szqb/usETeOQgW1HBImH0ewvhcFnI9IdQFjlCwN5sSS3Yj8FVtztLo1n+J5fEpk+4xkmfVQRHWn1p+zY5jSkevEQabprv3sq3Rzm+IdT9p0oeiMk5ZF3VRl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757972772; c=relaxed/simple;
	bh=TvItWeiPxyeVxH9ANTvlGXpEih4YG4bc31NnKXDKhlg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NRpWgzDI6uPbjIB7eGosnca1xVThmyySmM/ckDeyIgwfuWrxZiaQ3AJt44s8NgJEHzBSahsJm0n+oXbnwutClEspiiWZlCPwEHxgrrZ4DCxEj3YTVH42aB+YoD4XPZbpxJWmDoeeBywX3TYwS9wurjuSuTPluR15GNfMO3pHqK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=eiYk5OrT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jpW84tW6; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 39F777A02AB;
	Mon, 15 Sep 2025 17:46:06 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 15 Sep 2025 17:46:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1757972766;
	 x=1758059166; bh=wcYyFOejfQ29urHD5CAKXZN46sSGbzNo9wmWzdZNjE0=; b=
	eiYk5OrTI/ChmhGs5Livp3eM7KO6J7QWi5hOXq0Dkr+h5ljQ3qODjMlklklsSwSB
	aUzGP1w+q/fA8wqCxi8kd4wEOFq/bnS5uCy5FwAuYhFWQJFuwGw7yGQPilpsSP2D
	0CyJ0XTJjuyJLNJeNfhyqjz4qFBHB5ctQ4WgQ0nMtWOImVkP/zvOnjy/9BlvbuKV
	U9ZeAQ9pI41t+d22Q2UxCf5K80BmrXHrs/wuX00b5675MPoI4KJ6z2pyBY7HKEId
	1hWRnbJBpQMYWjzki5h9GI0hbGIQVxXLqlhQqN9loz1LmmyoT74iDKsXEPit0e1x
	Jv6VmmwM+OTzxXuqmuwjSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757972766; x=
	1758059166; bh=wcYyFOejfQ29urHD5CAKXZN46sSGbzNo9wmWzdZNjE0=; b=j
	pW84tW6lCAbpkTWsssfkyrBE0xSpSUNAbVmqZddhK111H1VFZAH1GcIGc2n2T8oz
	I4h/QkRlSRQkZBGt7OPlP0FiD9BvhaVwEcVfQtWNkH97xgF+dorL6/YYNPPoQuK3
	wenGbtbXtPfomvDnydWFjl3gkRPsKQbd2E4qVznoklRwNISzmjXCSoiX93VGeuQf
	46zlXYs0L2+qIADehySoXmyHlIS83s2Wlf20diZLa+lTYyimvuW/xHXenKYlsdeK
	Nj03xsfYyCDsyZg+u1Z1i9z94vA5z3c+lnArpLF1/kObJCmwc5q8CrGD6KqpE/bh
	UBT9BqHMAPIXi+Ks0ed/g==
X-ME-Sender: <xms:HYnIaLK0lvwihiCPQpXCCaRDTNYV_8S5H6GvkEkvWr80g4ArK1SAdA>
    <xme:HYnIaJvphFBx_CLQ5u95RosxlKHuSb3sI7YdlWdFs-P7quhK0LTbuPJkUF_tEi9eg
    D_jPg9XkjHelo0p>
X-ME-Received: <xmr:HYnIaATHfFCMt09TB2ptQpdpstiNOwH2zrYhSKd30VQry1d6evhpr-RA6pvbrT4yyLSjU4EsuQBmbLEoBqAToMY_j2x4NkZ1txIncjXwP0qVZ-IybQZF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefkeektdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:HYnIaHOK3_z6lzgyAddFB9gV3mjx2vfQ_xqw_dk38oe2DbeQ2AYlRQ>
    <xmx:HYnIaNaSKyyNGFFPrIuXPrNW3N54PI_wqR7ktC3EO7aE4qORMvyB_w>
    <xmx:HYnIaJzcrG0x7D4xHsxKOJjIq0A-LjgjpvZGJlukzyzyX9VECRKWrg>
    <xmx:HYnIaAL9ysMv5WZQN6eTHzApv_H0LLQX4zRhEofI0cGq3CZJde4oRQ>
    <xmx:HonIaB1L_4dvGBoNsD4KehuNFVxHKUHpsHVQfrnw5bZcc-Ptv6eO94gX>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 17:46:04 -0400 (EDT)
Message-ID: <4acdbba9-c4ad-4b33-b74b-2acc424cb24a@bsbernd.com>
Date: Mon, 15 Sep 2025 23:46:03 +0200
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
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJnrk1aYqZPNg_O25Yv6d5jGdzcPv0oyQ93KwarxovBJMyymdA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/15/25 23:23, Joanne Koong wrote:
> On Mon, Sep 15, 2025 at 1:15 PM Bernd Schubert <bernd@bsbernd.com> wrote:
>>
>> Hi Joanne,
>>
>> thanks for looking into this.
>>
>> On 9/15/25 20:15, Joanne Koong wrote:
>>> On Thu, Sep 11, 2025 at 3:34 AM Jian Huang Li <ali@ddn.com> wrote:
>>>>
>>>> This issue could be observed sometimes during libfuse xfstests, from
>>>> dmseg prints some like "kernel: WARNING: CPU: 4 PID: 0 at
>>>> fs/fuse/dev_uring.c:204 fuse_uring_destruct+0x1f5/0x200 [fuse]".
>>>>
>>>> The cause is, if when fuse daemon just submitted
>>>> FUSE_IO_URING_CMD_REGISTER SQEs, then umount or fuse daemon quits at
>>>> this very early stage. After all uring queues stopped, might have one or
>>>> more unprocessed FUSE_IO_URING_CMD_REGISTER SQEs get processed then some
>>>> new ring entities are created and added to ent_avail_queue, and
>>>> immediately fuse_uring_cancel moves them to ent_in_userspace after SQEs
>>>> get canceled. These ring entities will not be moved to ent_released, and
>>>> will stay in ent_in_userspace when fuse_uring_destruct is called, needed
>>>> be freed by the function.
>>>
>>> Hi Jian,
>>>
>>> Does it suffice to fix this race by tearing down the entries from the
>>> available queue first before tearing down the entries in the userspace
>>> queue? eg something like
>>>
>>>  static void fuse_uring_teardown_entries(struct fuse_ring_queue *queue)
>>>  {
>>> -       fuse_uring_stop_list_entries(&queue->ent_in_userspace, queue,
>>> -                                    FRRS_USERSPACE);
>>>         fuse_uring_stop_list_entries(&queue->ent_avail_queue, queue,
>>>                                      FRRS_AVAILABLE);
>>> +       fuse_uring_stop_list_entries(&queue->ent_in_userspace, queue,
>>> +                                    FRRS_USERSPACE);
>>>  }
>>>
>>> AFAICT, the race happens right now because when fuse_uring_cancel()
>>> moves the FRRS_AVAILABLE entries on the ent_avail_queue to the
>>> ent_in_userspace queue, fuse_uring_teardown_entries() may have already
>>> called fuse_uring_stop_list_entries() on the ent_in_userspace queue,
>>> thereby now missing the just-moved entries altogether, eg this logical
>>> flow
>>>
>>> -> fuse_uring_stop_list_entries(&queue->ent_in_userspace, ...);
>>>     -> fuse_uring_cancel() moves entry from avail q to userspace q
>>> -> fuse_uring_stop_list_entries(&queue->ent_avail_queue, ...);
>>>
>>> If instead fuse_uring_teardown_entries() stops the available queue first, then
>>> -> fuse_uring_stop_list_entries(&queue->ent_avail_queue, ...);
>>>     -> fuse_uring_cancel()
>>> -> fuse_uring_stop_list_entries(&queue->ent_in_userspace, ...);
>>>
>>> seems fine now and fuse_uring_cancel() would basically be a no-op
>>> since ent->state is now FRRS_TEARDOWN.
>>>
>>
>> I'm not sure. Let's say we have
>>
>> task 1                                   task2
>> fuse_uring_cmd()
>>     fuse_uring_register()
>>          [slowness here]
>>                                         fuse_abort_conn()
>>                                           fuse_uring_teardown_entries()
>>          [slowness continue]
>>          fuse_uring_do_register()
>>             fuse_uring_prepare_cancel()
>>             fuse_uring_ent_avail()
>>
>>
>> I.e. fuse_uring_teardown_entries() might be called before
>> the command gets marked cancel-able and before it is
>> moved to the avail queue. I think we should extend the patch
>> and actually not set the ring to ready when fc->connected
>> is set to 0.
>>
> 
> Hi Bernd,
> 
> I think this is a separate race from the fuse_uring_cancel one.
> afaics, this race can happen even if the user doesn't call
> fuse_uring_cancel(). imo I think the cleanest solution to this
> registration vs teardown race is to check queue->stopped in
> fuse_uring_do_register() after we grab the queue spinlock, and if
> queue->stopped is true, then just clean up the entry ourselves with
> fuse_uring_entry_teardown()).

What speaks against just doing as in the existing patch and freeing
the ent_in_userspace entries fuse_uring_destruct()? 
IMO it covers both races, missing is just to avoid setting the ring
as ready.


Thanks,
Bernd


