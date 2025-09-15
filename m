Return-Path: <linux-fsdevel+bounces-61456-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 809D1B58704
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 23:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F0263AF18A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 21:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C1B2C027A;
	Mon, 15 Sep 2025 21:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="TWRzt9ML";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TBs6qUVS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE5229DB9A
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 21:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757973436; cv=none; b=Qx/JKFJtZwGTtLCLYcRiv1ArvvYw7xMZh510HaACLrPY1i/B2fKNYg++xs5Xl5do3HWW/+PiTJYwRJn4A8RRYKNPcQeWjMaRiII/hbI/fOqo4oqGf2FZhrfTLIF/+gDjWV40Lw4tVlHQxEWxKNzL3dVPmRTOblDhMsDcSThvegw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757973436; c=relaxed/simple;
	bh=U9YB5QHaAU1Cjp8LONgc+i+GaihaWouIjRO2SEMgJFk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=A8yn+YQjA8kirBmSj1MUULKPUCRew9LJOcMbExXf+gdGD+H8OOs6pmadlNGRkKGcDyAg3MU1rANXS7X3KqdXnxMu9G9FXjx5Rm3SmM2uOlG+RPJDD2zR9enmEsU0LDGd9e5FwGJM3JjzRngqxn7ih4LU2MviIMhdebJzEV5dT0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=TWRzt9ML; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TBs6qUVS; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 212BE1D0028E;
	Mon, 15 Sep 2025 17:57:13 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 15 Sep 2025 17:57:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1757973432;
	 x=1758059832; bh=YqShPbxTyu0djE3WmQmfDmKuwri7pxp/2IfXm+BGuus=; b=
	TWRzt9MLDFCc9AgKaFnatF+DvWtvH5EDN0bE2bz4C5i6OAT2dzRnOgnfrEKnojAA
	QKqzISOUh/aEfvICSL17MtQ+WMtwMpoX/gP1G1rex+XhnR6oqGOaACILAISWq9Xy
	XPHDerbrTQvbGxGR86AmwOg2JcKyApbASFm1BuyugaW6Y6AkeZxIp1sQtWoqSZjd
	OjicLk7NE8k/gZ2rV6QEFXjEFrKGrtMp6uDZ8KDe9GqlLsTjDCUU/Ui4KXTS1VFX
	/7UEvPLTnDBirwJM0RTiU50sVZ7ifqyit1GjVqvRYCxG+T5eYCOoFGqvrka+Pmj3
	PK1DW9jY2wr/PvEFA1BcHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757973432; x=
	1758059832; bh=YqShPbxTyu0djE3WmQmfDmKuwri7pxp/2IfXm+BGuus=; b=T
	Bs6qUVSpz7ofzmPKbdjGfTgsjBV7N399hzIPkMCSStP5gpgYc236bXoBXzcM93qW
	0HCFWM3TqRGsLS7cdL1F//xD5csFhuhrOzVP4aLtpwEfd0nW9lJfAQJ+pBN6ESEv
	2OkNe1YtzfiinyO9e8yFyDBP2/MEExeAGcmSTiE89nxFAaueRrDgvSmsuARxT7IG
	x46u8/bVL7wajUI9DNiAoqpIXUbiYyynPtveIWq34BiiJOf6o7+n+iYtZ+1Q/+7d
	/gZXpnjqmtdYasZQVUWgtSOJ2chAHTHkY47R/q3/30iaCveUZkHmNEQsNyJpiyZl
	HLFT3B/Z4KlNL5A1CwRDw==
X-ME-Sender: <xms:uIvIaHIDkFZC_roEZzO3LjRwDVLHL5zNAGWdbkWoXobyh0sxc-vR0w>
    <xme:uIvIaFvxa7Vc62GbxFTbXfme0tEaADolxS0f9ofFr2yW2bbf5ilG3sITGFydVB3Vu
    yijoqSLGp4FO3vq>
X-ME-Received: <xmr:uIvIaMST0XwQ3tkxqXie0e569OkVEhOZh8e_8ujusHsaz-hqQ0XT9nF1EJTNRgxCshOwK6iktp16UOxLADC1rozVlx6b0fr13kXIUt_aYgMDv_rYY-aa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefkeekvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuhffvvehfjggtgfesthekredttddvjeenucfhrhhomhepuegvrhhnugcu
    ufgthhhusggvrhhtuceosggvrhhnugessghssggvrhhnugdrtghomheqnecuggftrfgrth
    htvghrnhepueetvdejffefgfevtdegtdffudeiveekveevvdeigfegteevuddvgeejfeej
    hfeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    gvrhhnugessghssggvrhhnugdrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhorghnnhgvlhhkohhonhhgsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtoheprghlihesuggunhdrtghomhdprhgtphhtthhopehlihhnuhigqdhf
    shguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhikhhloh
    hssehsiigvrhgvughirdhhuh
X-ME-Proxy: <xmx:uIvIaDM47028E7zwqtMphiB6ZDEKYcE7L8-Huy15umR7rDDuQfZVkw>
    <xmx:uIvIaJYN83LMwbDxCeXuevMZ2av1Ip92Qo8uoO3MMj4mEbsy7v247A>
    <xmx:uIvIaFyg5HHSH9jy8TYAQNRGa4pvedqgcRaKMxnyHBcu-31vEiI9ew>
    <xmx:uIvIaMLVZ54zmrBrwhgFgy7go3LDgBgltPRlncz5z-Wqv2WQyOivaA>
    <xmx:uIvIaNGXrDp4TvoG108d6Mrdp9-dNPUkJQrzhdeb9_R5eTGRwFKXYvD3>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 17:57:12 -0400 (EDT)
Message-ID: <478c4d28-e7d9-4dbd-9521-a3cea73fddde@bsbernd.com>
Date: Mon, 15 Sep 2025 23:57:11 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fs/fuse: fix potential memory leak from
 fuse_uring_cancel
From: Bernd Schubert <bernd@bsbernd.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Jian Huang Li <ali@ddn.com>, linux-fsdevel@vger.kernel.org,
 miklos@szeredi.hu
References: <94377ddf-9d04-4181-a632-d8c393dcd240@ddn.com>
 <CAJnrk1ZHfd3r1+s0fV209LROO1kixM=_T7Derm+GrR_hYa_wpw@mail.gmail.com>
 <99313bf9-963f-430e-a929-faa915d77202@bsbernd.com>
 <CAJnrk1aYqZPNg_O25Yv6d5jGdzcPv0oyQ93KwarxovBJMyymdA@mail.gmail.com>
 <4acdbba9-c4ad-4b33-b74b-2acc424cb24a@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <4acdbba9-c4ad-4b33-b74b-2acc424cb24a@bsbernd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/15/25 23:46, Bernd Schubert wrote:
> 
> 
> On 9/15/25 23:23, Joanne Koong wrote:
>> On Mon, Sep 15, 2025 at 1:15 PM Bernd Schubert <bernd@bsbernd.com> wrote:
>>>
>>> Hi Joanne,
>>>
>>> thanks for looking into this.
>>>
>>> On 9/15/25 20:15, Joanne Koong wrote:
>>>> On Thu, Sep 11, 2025 at 3:34 AM Jian Huang Li <ali@ddn.com> wrote:
>>>>>
>>>>> This issue could be observed sometimes during libfuse xfstests, from
>>>>> dmseg prints some like "kernel: WARNING: CPU: 4 PID: 0 at
>>>>> fs/fuse/dev_uring.c:204 fuse_uring_destruct+0x1f5/0x200 [fuse]".
>>>>>
>>>>> The cause is, if when fuse daemon just submitted
>>>>> FUSE_IO_URING_CMD_REGISTER SQEs, then umount or fuse daemon quits at
>>>>> this very early stage. After all uring queues stopped, might have one or
>>>>> more unprocessed FUSE_IO_URING_CMD_REGISTER SQEs get processed then some
>>>>> new ring entities are created and added to ent_avail_queue, and
>>>>> immediately fuse_uring_cancel moves them to ent_in_userspace after SQEs
>>>>> get canceled. These ring entities will not be moved to ent_released, and
>>>>> will stay in ent_in_userspace when fuse_uring_destruct is called, needed
>>>>> be freed by the function.
>>>>
>>>> Hi Jian,
>>>>
>>>> Does it suffice to fix this race by tearing down the entries from the
>>>> available queue first before tearing down the entries in the userspace
>>>> queue? eg something like
>>>>
>>>>  static void fuse_uring_teardown_entries(struct fuse_ring_queue *queue)
>>>>  {
>>>> -       fuse_uring_stop_list_entries(&queue->ent_in_userspace, queue,
>>>> -                                    FRRS_USERSPACE);
>>>>         fuse_uring_stop_list_entries(&queue->ent_avail_queue, queue,
>>>>                                      FRRS_AVAILABLE);
>>>> +       fuse_uring_stop_list_entries(&queue->ent_in_userspace, queue,
>>>> +                                    FRRS_USERSPACE);
>>>>  }
>>>>
>>>> AFAICT, the race happens right now because when fuse_uring_cancel()
>>>> moves the FRRS_AVAILABLE entries on the ent_avail_queue to the
>>>> ent_in_userspace queue, fuse_uring_teardown_entries() may have already
>>>> called fuse_uring_stop_list_entries() on the ent_in_userspace queue,
>>>> thereby now missing the just-moved entries altogether, eg this logical
>>>> flow
>>>>
>>>> -> fuse_uring_stop_list_entries(&queue->ent_in_userspace, ...);
>>>>     -> fuse_uring_cancel() moves entry from avail q to userspace q
>>>> -> fuse_uring_stop_list_entries(&queue->ent_avail_queue, ...);
>>>>
>>>> If instead fuse_uring_teardown_entries() stops the available queue first, then
>>>> -> fuse_uring_stop_list_entries(&queue->ent_avail_queue, ...);
>>>>     -> fuse_uring_cancel()
>>>> -> fuse_uring_stop_list_entries(&queue->ent_in_userspace, ...);
>>>>
>>>> seems fine now and fuse_uring_cancel() would basically be a no-op
>>>> since ent->state is now FRRS_TEARDOWN.
>>>>
>>>
>>> I'm not sure. Let's say we have
>>>
>>> task 1                                   task2
>>> fuse_uring_cmd()
>>>     fuse_uring_register()
>>>          [slowness here]
>>>                                         fuse_abort_conn()
>>>                                           fuse_uring_teardown_entries()
>>>          [slowness continue]
>>>          fuse_uring_do_register()
>>>             fuse_uring_prepare_cancel()
>>>             fuse_uring_ent_avail()
>>>
>>>
>>> I.e. fuse_uring_teardown_entries() might be called before
>>> the command gets marked cancel-able and before it is
>>> moved to the avail queue. I think we should extend the patch
>>> and actually not set the ring to ready when fc->connected
>>> is set to 0.
>>>
>>
>> Hi Bernd,
>>
>> I think this is a separate race from the fuse_uring_cancel one.
>> afaics, this race can happen even if the user doesn't call
>> fuse_uring_cancel(). imo I think the cleanest solution to this
>> registration vs teardown race is to check queue->stopped in
>> fuse_uring_do_register() after we grab the queue spinlock, and if
>> queue->stopped is true, then just clean up the entry ourselves with
>> fuse_uring_entry_teardown()).
> 
> What speaks against just doing as in the existing patch and freeing
> the ent_in_userspace entries fuse_uring_destruct()? 
> IMO it covers both races, missing is just to avoid setting the ring
> as ready.

Well, maybe cleaner, I don't have a strong opinion. We could skip the
comment and explanation with your approach.


Thanks,
Bernd

