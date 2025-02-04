Return-Path: <linux-fsdevel+bounces-40816-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7AF5A27CDC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 21:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FBDC3A6073
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 20:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15AC21A425;
	Tue,  4 Feb 2025 20:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="NGkEEzqN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="igKGe3Yn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B31A2046B1
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Feb 2025 20:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738701507; cv=none; b=mItqXiALriYDh4ZsJo/zYk6/gNERp8msCygIQngZpXRRDbeNudELg/dsmjaD4MI3i4Xaws0kf+sMPS9rew1CB9SXn6/USTIZPYQN9y5wiOYPiGzPcud91nuG1MScBPqrlShJcaqixGJQdrLfB9y/M/lcPXWUkBpsJzlw6KoSv0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738701507; c=relaxed/simple;
	bh=0LzZRFEegukC9csBCV3VR755x/ldL9XOpP5cQ3/vmgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fO+wEEigQQ6+5z+hFwpM5XHlplcbpRdCwakHUfdk+Z2WQc59a9/tP90V1U4A+CXImLFh8wOqbfIZWddfZK2d6lqRxAU0wb/0UXkwiCFb3Iu6df0uLkSbVp8TpAkFKWXclAmBTaiGyyYHuBvyE59yaTy3hEG7JRy3uCXRwPCbBOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=NGkEEzqN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=igKGe3Yn; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 91F632540182;
	Tue,  4 Feb 2025 15:38:24 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 04 Feb 2025 15:38:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738701504;
	 x=1738787904; bh=aC/xKI9hMjzhwTYgoEcpUeuy/PjsjPZvnArmdieLqPU=; b=
	NGkEEzqNozUCIS0+POm760pnIKYmVs56UE+vuJvWebbyE6mrUJtZyXeX6MRVXUr2
	pXZWtCluHkLWrG/V0mTeayzBi5EjFtovj4eaPSViu89aTPoj7cSJOk6nE7XMeZGa
	InBOopOE4edYmUUiSrnvvfMaCBKI5RDCQQeC9qPYwbOFrwWmnQF0LHtzCP5N/WsV
	BxzEJtKJKaAOEOt4pJ4n1Gu/aqtpqusZAQ+UMZTyA0ibvkp8hRtYkYdjdMRHCJtY
	Hh7PYw9+j45zSZpiVSrrjTiCf+UTgUscZnBWw2dqx+boZFGGYKViTm4p0Z/ZLe2j
	dh4uhRAJxHghRaH88dYb7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738701504; x=
	1738787904; bh=aC/xKI9hMjzhwTYgoEcpUeuy/PjsjPZvnArmdieLqPU=; b=i
	gKGe3Ynd5SeRwAfaxWO2Xxzv20YDaREOabH6OY+mS69GSbqlYiG0ZzGLhbXMlidO
	prxl4iPD/1dBr0Wb7DVo94F+gaX0XfmLuVjDFFFm4Cojl33oLiFfssWEEGP4rMpd
	YxONOt54JxNR2L6AMj93i+c4JBDkSjhHfxt34rysr8e6tOkPzC0Zplz4KbYnyy3f
	lbi2JZZife6ZHw0FD2D4mCTrxdet+fh/WdZUA2GPpxay7yLJvE83O4LlvDmeFm3C
	53FfcQu8gAWylYoaXJhn1e35pR04xDwCbHG/p6hi+DQVBOQFZNb6ojlduzy574bu
	4pxT5nBijV7xGy4Vv/S0A==
X-ME-Sender: <xms:v3qiZ6W4-vnu4CuZTlIp5BqmPaEX6Anf-nkCsqDYnLCjhRabCLL8PQ>
    <xme:v3qiZ2n4tke_dLWexXxfdJhgGCmlcdlNfUJNRRd0x2nVkxZQYohXcY4TY5UXWzWtH
    Z-JXE4hQtOgNAjo>
X-ME-Received: <xmr:v3qiZ-ZyQvKnY3pn4s_m7XtXx4lGAdfiVtunZzIxljgOnDEva_vDQkPh1P9ov2yeuaEpc2BZCpDXEeoLSrKJT7FyBXvpmSAeInvb4VKiqT6O1uwJMP1G>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvudehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddv
    jeenucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusg
    gvrhhtsehfrghsthhmrghilhdrfhhmqeenucggtffrrghtthgvrhhnpeduleefvdduvedu
    veelgeelffffkedukeegveelgfekleeuvdehkeehheehkefhfeenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghr
    thesfhgrshhtmhgrihhlrdhfmhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepjhhorghnnhgvlhhkohhonhhgsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopehlihhnuh
    igqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgv
    rhhnvghlqdhtvggrmhesmhgvthgrrdgtohhm
X-ME-Proxy: <xmx:v3qiZxX8cH4Y_5PENh4mlqZRoEcW9nc-X_BFT9yETx88PU1-g1Jg0Q>
    <xmx:v3qiZ0n3NS6fwtnf2SZ39MbU_hXSgrjF-_wwGenYlBZfsi-wfQwnbg>
    <xmx:v3qiZ2d8WO_lxgDTB6WNDEKQCvF4DoaLYORxyXukn2lhQ_oswx30kg>
    <xmx:v3qiZ2ETA9xKLwoWrWevl8IaAGZb6tA9IfOxbR2BzRVWyPJalPIFyg>
    <xmx:wHqiZ1BNZabG9l_1xiIxPcODZKLgESQm1NMgW7tEgxUbDY1REA0GiHBE>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Feb 2025 15:38:22 -0500 (EST)
Message-ID: <bc801a5c-8150-4b6c-b7b6-b587d556d99b@fastmail.fm>
Date: Tue, 4 Feb 2025 21:38:22 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: clear FR_PENDING without holding fiq lock for uring
 requests
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, kernel-team@meta.com
References: <20250203185040.2365113-1-joannelkoong@gmail.com>
 <ff73c955-2267-4c77-8dca-0e4181d8e8b4@fastmail.fm>
 <CAJnrk1YfPU9qgaq=3KtO8dWxEqwpX-TJ-BD4vjUHsqtAqT859Q@mail.gmail.com>
 <74a5f0ea-e7dc-440b-82c6-5755dea98fa4@fastmail.fm>
 <CAJnrk1ZgHNb78dz-yfNTpxmW7wtT88A=m-zF0ZoLXKLUHRjNTw@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJnrk1ZgHNb78dz-yfNTpxmW7wtT88A=m-zF0ZoLXKLUHRjNTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2/4/25 21:29, Joanne Koong wrote:
> On Tue, Feb 4, 2025 at 12:00 PM Bernd Schubert
> <bernd.schubert@fastmail.fm> wrote:
>>
>>
>>
>> On 2/4/25 20:26, Joanne Koong wrote:
>>> Hi Bernd,
>>>
>>> On Tue, Feb 4, 2025 at 3:03 AM Bernd Schubert
>>> <bernd.schubert@fastmail.fm> wrote:
>>>>
>>>> Hi Joanne,
>>>>
>>>> On 2/3/25 19:50, Joanne Koong wrote:
>>>>> req->flags is set/tested/cleared atomically in fuse. When the FR_PENDING
>>>>> bit is cleared from the request flags when assigning a request to a
>>>>> uring entry, the fiq->lock does not need to be held.
>>>>>
>>>>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>>>>> Fixes: c090c8abae4b6 ("fuse: Add io-uring sqe commit and fetch support")
>>>>> ---
>>>>>  fs/fuse/dev_uring.c | 2 --
>>>>>  1 file changed, 2 deletions(-)
>>>>>
>>>>> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
>>>>> index ab8c26042aa8..42389d3e7235 100644
>>>>> --- a/fs/fuse/dev_uring.c
>>>>> +++ b/fs/fuse/dev_uring.c
>>>>> @@ -764,9 +764,7 @@ static void fuse_uring_add_req_to_ring_ent(struct fuse_ring_ent *ent,
>>>>>                       ent->state);
>>>>>       }
>>>>>
>>>>> -     spin_lock(&fiq->lock);
>>>>>       clear_bit(FR_PENDING, &req->flags);
>>>>> -     spin_unlock(&fiq->lock);
>>>>>       ent->fuse_req = req;
>>>>>       ent->state = FRRS_FUSE_REQ;
>>>>>       list_move(&ent->list, &queue->ent_w_req_queue);
>>>>
>>>> I think that would have an issue in request_wait_answer(). Let's say
>>>>
>>>>
>>>> task-A, request_wait_answer(),
>>>>                 spin_lock(&fiq->lock);
>>>>                 /* Request is not yet in userspace, bail out */
>>>>                 if (test_bit(FR_PENDING, &req->flags)) {  // ========> if passed
>>>>                         list_del(&req->list);  // --> removes from the list
>>>>
>>>> task-B,
>>>> fuse_uring_add_req_to_ring_ent()
>>>>         clear_bit(FR_PENDING, &req->flags);
>>>>         ent->fuse_req = req;
>>>>         ent->state = FRRS_FUSE_REQ;
>>>>         list_move_tail(&ent->list, &queue->ent_w_req_queue);
>>>>         fuse_uring_add_to_pq(ent, req);  // ==> Add to list
>>>>
>>>>
>>>>
>>>> What I mean is, task-A passes the if, but is then slower than task-B. I.e.
>>>> task-B runs fuse_uring_add_to_pq() before task-B does the list_del.
>>>>
>>>
>>> Is this race condition possible given that fiq->ops->send_req() is
>>> called (and completed) before request_wait_answer() is called? The
>>> path I see is this:
>>>
>>> __fuse_simple_request()
>>>     __fuse_request_send()
>>>         fuse_send_one()
>>>             fiq->ops->send_req()
>>>                   fuse_uring_queue_fuse_req()
>>>                       fuse_uring_add_req_to_ring_ent()
>>>                            clear FR_PENDING bit
>>>                            fuse_uring_add_to_pq()
>>>         request_wait_answer()
>>>
>>> It doesn't seem like task A can call request_wait_answer() while task
>>> B is running fuse_uring_queue_fuse_req() on the same request while the
>>> request still has the FR_PENDING bit set.
>>>
>>> This case of task A running request_wait_answer() while task B is
>>> executing fuse_uring_add_req_to_ring_ent() can happen through
>>> fuse_uring_commit_fetch() ->  fuse_uring_add_req_to_ring_ent(), but at
>>> that point the FR_PENDING flag will have already been cleared on the
>>> request, so this would bypass the "if (test_bit(FR_PENDING,...))"
>>> check in request_wait_answer().
>>
>> I mean this case. I don't think FR_PENDING is cleared - why should it?
>> And where? The request is pending state, waiting to get into 'FR_SENT'?
>>
>>>
>>> Is there something I'm missing? I think if this race condition is
>>> possible, then we also have a bigger problem where the request can be
>>> freed out in this request_wait_answer() ->  if (test_bit(FR_PENDING,
>>> &req->flags))...  case while fuse_uring_add_req_to_ring_ent() ->
>>> fuse_uring_add_to_pq() dereferences it still.
>>
>> I don't think so, if we take the lock.
>>
> 
> the path I'm looking at is this:
> 
> task A -
> __fuse_simple_request()
>     fuse_get_req() -> request is allocated (req refcount is 1)
>     __fuse_request_send()
>         __fuse_get_request() -> req refcount is 2
>         fuse_send_one() -> req gets sent to uring
>         request_wait_answer()
>                ...
>                hits the interrupt case, goes into "if
> test_bit(FR_PENDING, ...)" case which calls __fuse_put_request(), req
> refcount is now 1
>     fuse_put_request() -> req refcount is dropped to 0, request is freed
> 
> while in task B -
> fuse_uring_commit_fetch()
>     fuse_uring_next_fuse_req()
>         fuse_uring_ent_assign_req()
>             gets req off fuse_req_queue
>             fuse_uring_add_req_to_ring_ent()
>                  clear FR_PENDING
>                  fuse_uring_add_to_pq()
>                      dereferences req
> 
> if task A hits the interrupt case in request_wait_answer() and then
> calls fuse_put_request() before task B clears the pending flag (and
> after it's gotten the request from the fuse_req_queue in
> fuse_uring_ent_assign_req()), then I think we hit this case, no?
> 

Oh no, yes, you are right. It is a bit ugly to use fiq lock for list
handling. I think I'm going to add uring handler for that to
request_wait_answer. In general, basically request_wait_answer
is currently operating on the wrong list - it assumes fiq, but that
is not where the request it waiting on.


Thanks for pointing this out!


