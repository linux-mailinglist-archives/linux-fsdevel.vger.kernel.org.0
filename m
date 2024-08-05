Return-Path: <linux-fsdevel+bounces-25013-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4550947B82
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 15:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C0A71F22093
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 13:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BC4158DC3;
	Mon,  5 Aug 2024 13:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="jA8xAVXs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q3HYT6TQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A6A1E480
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Aug 2024 13:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722863126; cv=none; b=COnQRT4RMW/j4DanqJ4m3yzz0ZiNlgqwx9x983iiCmP/FpKxQvcNMqcHhkr9s8PD6R7hRu2ltkheXqnWCZQAOiCTMqzR50Z2/i/RUiEGAw53P8XziY+nbxzqP5VchF0SE7d3jAc88k5zWNrZLZjlvCbcXLge+RNq8zifgzsWN4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722863126; c=relaxed/simple;
	bh=LYD4qoaHOJpej5+bq7DbToIeQdEsIlpokZIGc/A+xa0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UnQSuKbQUIG6pdtQbr9xluy5dpe/fIxzgQmJmVpEr+sYbPjev2jO2/xtU3uPYcMiuUltShv1QgmdGpDqXr7+zblfZAzpSXoe87RO8OhaFOjeMS6ceoOABYEMtGnt0DlkFvR8mjZY5ZF7RkHuDphGw2ztwwprpcb4jDGCksDHvtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=jA8xAVXs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q3HYT6TQ; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 700A61151B72;
	Mon,  5 Aug 2024 09:05:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 05 Aug 2024 09:05:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1722863123;
	 x=1722949523; bh=KyWLTesC56YNZhNdzFVikKZfLFZYWoq+tiLxOKt6vFA=; b=
	jA8xAVXsocf0fwTz6X5CLtgWf9xqmtvb6JRN6bPWKmvuRqRJ0BZpavo4VCvrrpYV
	7WSNPEmDabRTQO946mLPrOl2KEcvqlgDNZVEc+T9r3xwCDFjGLDh1iPhZ9I3xSyk
	vNxpfReyxUvyt6Z0DMbKr6urgWqy83p9M4kTOvb/gwQVHH+NDW6VXRCFNVG3bmwe
	BhUFO3e3doezWacECY3zNweBiLPFiCIBpAVUsdxR46hc5DljF/DTCiN0Nmkt5Agg
	vnnHV3NXnCO0oWhMOYyGersOMfT09CdBbOKyxPvvBh9rZBXvl3eZBVWx+HVhAUiL
	nE5ct3CULIDTZtWdn55DYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1722863123; x=
	1722949523; bh=KyWLTesC56YNZhNdzFVikKZfLFZYWoq+tiLxOKt6vFA=; b=Q
	3HYT6TQT7zGyOGAZX6RTTcZhfsqgI1wY0Dg4peFLESI62K4tVOyfOqvjraSSQkdC
	Djk2eDK3k7v55hab1TW2kWQwwUnD1r7ZdxFvsUAMhpsmEV9NB0OUsJDzP+xgPLKA
	SBfVAcBBNrJErH6OT0ooJCjC3b4x3qFFSoBtRPz3oxg1BAcWWdJPfHJUVpTOozex
	P/Uv7YGbtW+9mdjlLjSmzR62LS5iobfTzDXYWPZchlbFWL5RiRvDKm2u1qBw2J/0
	jgatrqCRqpShpBACIqJWAuX9VIfwhJ2E4Y8TF/8pPopPDgYGr/MIcHzyF9cXClJR
	ZtFnHv9oxcO2YD299jQZQ==
X-ME-Sender: <xms:E86wZgZFwWAPD8m4ozflY6jU_S7ZQhiVlWP7izJo2KJRCtjwpDdsiw>
    <xme:E86wZrbjy_Pn69COaf-UwOHcMrUkcg_9gESJu4xSfmi4a0t0R6kDyN6CwajyTG8wp
    Sd-p2teqt_QGUq9>
X-ME-Received: <xmr:E86wZq_QjbNIGXQPCKFsKMUee_sHrB8X7804fAUakBrqjuLfgNX6pXtZBLYZZfxaLw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeigdeiudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepuegvrhhn
    ugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilh
    drfhhmqeenucggtffrrghtthgvrhhnpeduleefvdduveduveelgeelffffkedukeegveel
    gfekleeuvdehkeehheehkefhfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhf
    mhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:E86wZqqAFkXZ_Va9a7nsu5LTpSA1PbjtQKrBgZ3MoXFIovemCQSu7g>
    <xmx:E86wZrpIKee37nMbhmW2VUFFUlrbi1u7Xv5yiuFyVEg09mUOqK3nIg>
    <xmx:E86wZoSvSVyGKZyzc-lU_XfqvwtiAqYsv_9n9lSAA8kRu2xaWSAkkw>
    <xmx:E86wZrrkXTelDuurxNFjQwpuDuPHxjMesFN5FcvigRuhJVjju4axiQ>
    <xmx:E86wZsf3wUW-34N3Q-LvS0ENMoHl1paRooRogkAe4wzQWB8IqS4l3zaS>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Aug 2024 09:05:22 -0400 (EDT)
Message-ID: <9245091f-1738-4621-be8e-9b2b34c46860@fastmail.fm>
Date: Mon, 5 Aug 2024 15:05:20 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] fuse: add optional kernel-enforced timeout for
 requests
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com,
 laoar.shao@gmail.com, kernel-team@meta.com
References: <20240730002348.3431931-1-joannelkoong@gmail.com>
 <20240730002348.3431931-2-joannelkoong@gmail.com>
 <51a1d881-d3c6-4be6-93e7-358200df1bdd@fastmail.fm>
 <CAJnrk1aqKeo1zY3SMw1vFvQjHdHbmva5qSL0uAYBmQDKiHL_AQ@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US
In-Reply-To: <CAJnrk1aqKeo1zY3SMw1vFvQjHdHbmva5qSL0uAYBmQDKiHL_AQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/5/24 06:45, Joanne Koong wrote:
> On Sun, Aug 4, 2024 at 3:46 PM Bernd Schubert
> <bernd.schubert@fastmail.fm> wrote:
>>
>>
>>
>> On 7/30/24 02:23, Joanne Koong wrote:
>>> There are situations where fuse servers can become unresponsive or take
>>> too long to reply to a request. Currently there is no upper bound on
>>> how long a request may take, which may be frustrating to users who get
>>> stuck waiting for a request to complete.
>>>
>>> This commit adds a timeout option (in seconds) for requests. If the
>>> timeout elapses before the server replies to the request, the request
>>> will fail with -ETIME.
>>>
>>> There are 3 possibilities for a request that times out:
>>> a) The request times out before the request has been sent to userspace
>>> b) The request times out after the request has been sent to userspace
>>> and before it receives a reply from the server
>>> c) The request times out after the request has been sent to userspace
>>> and the server replies while the kernel is timing out the request
>>>
>>> While a request timeout is being handled, there may be other handlers
>>> running at the same time if:
>>> a) the kernel is forwarding the request to the server
>>> b) the kernel is processing the server's reply to the request
>>> c) the request is being re-sent
>>> d) the connection is aborting
>>> e) the device is getting released
>>>
>>> Proper synchronization must be added to ensure that the request is
>>> handled correctly in all of these cases. To this effect, there is a new
>>> FR_FINISHING bit added to the request flags, which is set atomically by
>>> either the timeout handler (see fuse_request_timeout()) which is invoked
>>> after the request timeout elapses or set by the request reply handler
>>> (see dev_do_write()), whichever gets there first. If the reply handler
>>> and the timeout handler are executing simultaneously and the reply handler
>>> sets FR_FINISHING before the timeout handler, then the request will be
>>> handled as if the timeout did not elapse. If the timeout handler sets
>>> FR_FINISHING before the reply handler, then the request will fail with
>>> -ETIME and the request will be cleaned up.
>>>
>>> Currently, this is the refcount lifecycle of a request:
>>>
>>> Synchronous request is created:
>>> fuse_simple_request -> allocates request, sets refcount to 1
>>>    __fuse_request_send -> acquires refcount
>>>      queues request and waits for reply...
>>> fuse_simple_request -> drops refcount
>>>
>>> Background request is created:
>>> fuse_simple_background -> allocates request, sets refcount to 1
>>>
>>> Request is replied to:
>>> fuse_dev_do_write
>>>    fuse_request_end -> drops refcount on request
>>>
>>> Proper acquires on the request reference must be added to ensure that the
>>> timeout handler does not drop the last refcount on the request while
>>> other handlers may be operating on the request. Please note that the
>>> timeout handler may get invoked at any phase of the request's
>>> lifetime (eg before the request has been forwarded to userspace, etc).
>>>
>>> It is always guaranteed that there is a refcount on the request when the
>>> timeout handler is executing. The timeout handler will be either
>>> deactivated by the reply/abort/release handlers, or if the timeout
>>> handler is concurrently executing on another CPU, the reply/abort/release
>>> handlers will wait for the timeout handler to finish executing first before
>>> it drops the final refcount on the request.
>>>
>>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>>> ---
>>>   fs/fuse/dev.c    | 187 +++++++++++++++++++++++++++++++++++++++++++++--
>>>   fs/fuse/fuse_i.h |  14 ++++
>>>   fs/fuse/inode.c  |   7 ++
>>>   3 files changed, 200 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
>>> index 9eb191b5c4de..9992bc5f4469 100644
>>> --- a/fs/fuse/dev.c
>>> +++ b/fs/fuse/dev.c
>>> @@ -31,6 +31,8 @@ MODULE_ALIAS("devname:fuse");
>>>
>>>   static struct kmem_cache *fuse_req_cachep;
>>>
>>> +static void fuse_request_timeout(struct timer_list *timer);
>>> +
>>>   static struct fuse_dev *fuse_get_dev(struct file *file)
>>>   {
>>>        /*
>>> @@ -48,6 +50,8 @@ static void fuse_request_init(struct fuse_mount *fm, struct fuse_req *req)
>>>        refcount_set(&req->count, 1);
>>>        __set_bit(FR_PENDING, &req->flags);
>>>        req->fm = fm;
>>> +     if (fm->fc->req_timeout)
>>> +             timer_setup(&req->timer, fuse_request_timeout, 0);
>>>   }
>>>
>>>   static struct fuse_req *fuse_request_alloc(struct fuse_mount *fm, gfp_t flags)
>>> @@ -277,12 +281,15 @@ static void flush_bg_queue(struct fuse_conn *fc)
>>>    * the 'end' callback is called if given, else the reference to the
>>>    * request is released
>>>    */
>>> -void fuse_request_end(struct fuse_req *req)
>>> +static void do_fuse_request_end(struct fuse_req *req, bool from_timer_callback)
>>>   {
>>>        struct fuse_mount *fm = req->fm;
>>>        struct fuse_conn *fc = fm->fc;
>>>        struct fuse_iqueue *fiq = &fc->iq;
>>>
>>> +     if (from_timer_callback)
>>> +             req->out.h.error = -ETIME;
>>> +
>>>        if (test_and_set_bit(FR_FINISHED, &req->flags))
>>>                goto put_request;
>>>
>>> @@ -296,8 +303,6 @@ void fuse_request_end(struct fuse_req *req)
>>>                list_del_init(&req->intr_entry);
>>>                spin_unlock(&fiq->lock);
>>>        }
>>> -     WARN_ON(test_bit(FR_PENDING, &req->flags));
>>> -     WARN_ON(test_bit(FR_SENT, &req->flags));
>>>        if (test_bit(FR_BACKGROUND, &req->flags)) {
>>>                spin_lock(&fc->bg_lock);
>>>                clear_bit(FR_BACKGROUND, &req->flags);
>>> @@ -324,13 +329,105 @@ void fuse_request_end(struct fuse_req *req)
>>>                wake_up(&req->waitq);
>>>        }
>>>
>>> +     if (!from_timer_callback && req->timer.function)
>>> +             timer_delete_sync(&req->timer);
>>> +
>>>        if (test_bit(FR_ASYNC, &req->flags))
>>>                req->args->end(fm, req->args, req->out.h.error);
>>>   put_request:
>>>        fuse_put_request(req);
>>>   }
>>> +
>>> +void fuse_request_end(struct fuse_req *req)
>>> +{
>>> +     WARN_ON(test_bit(FR_PENDING, &req->flags));
>>> +     WARN_ON(test_bit(FR_SENT, &req->flags));
>>> +
>>> +     do_fuse_request_end(req, false);
>>> +}
>>>   EXPORT_SYMBOL_GPL(fuse_request_end);
>>>
>>> +static void timeout_inflight_req(struct fuse_req *req)
>>> +{
>>> +     struct fuse_conn *fc = req->fm->fc;
>>> +     struct fuse_iqueue *fiq = &fc->iq;
>>> +     struct fuse_pqueue *fpq;
>>> +
>>> +     spin_lock(&fiq->lock);
>>> +     fpq = req->fpq;
>>> +     spin_unlock(&fiq->lock);
>>> +
>>> +     /*
>>> +      * If fpq has not been set yet, then the request is aborting (which
>>> +      * clears FR_PENDING flag) before dev_do_read (which sets req->fpq)
>>> +      * has been called. Let the abort handler handle this request.
>>> +      */
>>> +     if (!fpq)
>>> +             return;
>>> +
>>> +     spin_lock(&fpq->lock);
>>> +     if (!fpq->connected || req->out.h.error == -ECONNABORTED) {
>>> +             /*
>>> +              * Connection is being aborted or the fuse_dev is being released.
>>> +              * The abort / release will clean up the request
>>> +              */
>>> +             spin_unlock(&fpq->lock);
>>> +             return;
>>> +     }
>>> +
>>> +     if (!test_bit(FR_PRIVATE, &req->flags))
>>> +             list_del_init(&req->list);
>>> +
>>> +     spin_unlock(&fpq->lock);
>>> +
>>> +     do_fuse_request_end(req, true);
>>> +}
>>> +
>>> +static void timeout_pending_req(struct fuse_req *req)
>>> +{
>>> +     struct fuse_conn *fc = req->fm->fc;
>>> +     struct fuse_iqueue *fiq = &fc->iq;
>>> +     bool background = test_bit(FR_BACKGROUND, &req->flags);
>>> +
>>> +     if (background)
>>> +             spin_lock(&fc->bg_lock);
>>> +     spin_lock(&fiq->lock);
>>> +
>>> +     if (!test_bit(FR_PENDING, &req->flags)) {
>>> +             spin_unlock(&fiq->lock);
>>> +             if (background)
>>> +                     spin_unlock(&fc->bg_lock);
>>> +             timeout_inflight_req(req);
>>> +             return;
>>> +     }
>>> +
>>> +     if (!test_bit(FR_PRIVATE, &req->flags))
>>> +             list_del_init(&req->list);
>>> +
>>> +     spin_unlock(&fiq->lock);
>>> +     if (background)
>>> +             spin_unlock(&fc->bg_lock);
>>> +
>>> +     do_fuse_request_end(req, true);
>>> +}
>>> +
>>> +static void fuse_request_timeout(struct timer_list *timer)
>>> +{
>>> +     struct fuse_req *req = container_of(timer, struct fuse_req, timer);
>>
>> Let's say the timeout thread races with the thread that does
>> fuse_dev_do_write() and that thread is much faster and already calls :
>>
>> fuse_dev_do_write():
>>          fuse_request_end(req);
>>          fuse_put_request(req);
>> out:
>>          return err ? err : nbytes;
>>
>>
>> (What I mean is that the timeout triggered, but did not reach
>> FR_FINISHING yet and at the same time another thread on another core
>> calls fuse_dev_do_write()).
>>
>>> +
>>> +     /*
>>> +      * Request reply is being finished by the kernel right now.
>>> +      * No need to time out the request.
>>> +      */
>>> +     if (test_and_set_bit(FR_FINISHING, &req->flags))
>>> +             return;
>>
>> Wouldn't that trigger an UAF when the fuse_dev_do_write() was proceding
>> much faster and already released the request?
> 
> I don't believe so. In fuse_dev_do_write(), the call to
> fuse_request_end() will call timer_delete_sync(), which will either
> cancel the timer or wait for the timer to finish running if it's
> concurrently running on another CPU.

Yeah you right, I had missed that timer_delete_sync waits.

>>
>>> +
>>> +     if (test_bit(FR_PENDING, &req->flags))
>>> +             timeout_pending_req(req);
>>> +     else
>>> +             timeout_inflight_req(req);
>>> +}
>>> +
>>>   static int queue_interrupt(struct fuse_req *req)
>>>   {
>>>        struct fuse_iqueue *fiq = &req->fm->fc->iq;
>>> @@ -409,7 +506,8 @@ static void request_wait_answer(struct fuse_req *req)
>>>
>>>   static void __fuse_request_send(struct fuse_req *req)
>>>   {
>>> -     struct fuse_iqueue *fiq = &req->fm->fc->iq;
>>> +     struct fuse_conn *fc = req->fm->fc;
>>> +     struct fuse_iqueue *fiq = &fc->iq;
>>>
>>>        BUG_ON(test_bit(FR_BACKGROUND, &req->flags));
>>>        spin_lock(&fiq->lock);
>>> @@ -421,6 +519,10 @@ static void __fuse_request_send(struct fuse_req *req)
>>>                /* acquire extra reference, since request is still needed
>>>                   after fuse_request_end() */
>>>                __fuse_get_request(req);
>>> +             if (req->timer.function) {
>>> +                     req->timer.expires = jiffies + fc->req_timeout;
>>> +                     add_timer(&req->timer);
>>> +             }
>>
>> Does this leave a chance to put in a timeout of 0, if someone first sets
>>   fc->req_timeout and then sets it back to 0?
> 
> I don't think so. The req_timeout is per connection and specified at
> mount time. Once the fc->req_timeout is set for the connection it
> can't be changed even if the default_req_timeout sysctl gets set to 0.

Ah right, I had somehow though changing the sysctl param would update 
connections.

Sorry for the noise!


Thanks,
Bernd

