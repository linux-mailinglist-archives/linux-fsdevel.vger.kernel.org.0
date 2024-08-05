Return-Path: <linux-fsdevel+bounces-25017-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE95947BCC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 15:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 129B4281C29
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 13:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A45315B102;
	Mon,  5 Aug 2024 13:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="uGZ5rXxB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LMu/Z9iU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72450155C8D
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Aug 2024 13:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722864402; cv=none; b=p+cXVz8lYQHMEdkCHRRxy9haTi77Vz7PpZH8dRhzrk+8bNcZuIH39l55z8waK5cEwDxG39eyVUpYEVOjPSjMemOMCV7Ci57eTfHjXQrWSDtTZJe/b0j70OCuh2/anUDwln85obqmf7/lPqcipkuyoq+T2GfiTMgv1qNneWfHikk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722864402; c=relaxed/simple;
	bh=czbAzqsycMUOBcC4w/B3EU2C/SnzhQqbVTm6KZiJpC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oDkThFI44kM+CyC6qBPIT2skKhBjnLD+F+pbVCMyh8hYqKKG60IDt4joXB0iAM1AJ12DNwvT7yYLKgbv6FsjushlutM+F1Sdb8tIaaQxu0TnFswDTjIB+jK691KbwkEggm17jBMHeH5ONEBYasCTXglTONoiMjXIkHgxabVsRY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=uGZ5rXxB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LMu/Z9iU; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 820871151B2D;
	Mon,  5 Aug 2024 09:26:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 05 Aug 2024 09:26:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1722864399;
	 x=1722950799; bh=vUmDBsU0UwiFl464IjlB+KELkRh8jsvnukkKlncWtxE=; b=
	uGZ5rXxBYhBnHbB5QbNAwmp7YOkMFWcprxWjzn6LDAE3Ehmo1n1ZGCc5pd/BwMU7
	oHV9PD4XDW5MV5WjgwFdeUiOcDLO97JA/n6oNwAm9pI+3EzkfpSrFjjVw4FB5rUG
	/5cKIz55J953/LRbjZEmevNxoAzsN5Z3219HnX4BMJWfxBWo+1sLxvoOd8m5Se/Y
	GOkqiAmdQ4+w00On58+VU7NusgYua/lIUl3Pz8rvCoBMUTrpBwLIODZTy3htgEKr
	g06oCllVdPo81q/XYpMQXF+X594RNDBtQsTNcO7KpGFTnV+Ezb0j6JLjWNqh/LPx
	gR6e9K1CmOOcL2bTZFnvqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1722864399; x=
	1722950799; bh=vUmDBsU0UwiFl464IjlB+KELkRh8jsvnukkKlncWtxE=; b=L
	Mu/Z9iUQKZV6xeUjvArM3VKczImZ8RZQh0p/criEKFo0EMXRFR4RQlKw2kG3ERkS
	bNFcfnVJFQgP/kl4JfQj/mAS4/iKkEIt2mvktIL84rlJo8znSpwV3QFxYXBHU2Mv
	ySJt4EA7btSAs8OSK13ut5k9P8QA1KfrY+rznMOoDOHFKEqai6LejkhetfK2uUQa
	r9NZu0Hqh/EbclRs+hInkY2RThc7QscPkVcw/IRCKSioyc8jSKKLnEVCfswlJsNS
	IggAPTbA7wIYQYDKSSHsaliYgmIGszILBEzzyrGj/o/BVkbCliAuSVQ3v37PUusT
	QY6796MKlVZkxa8HanMcQ==
X-ME-Sender: <xms:D9OwZpzQTY5_TBMPuI9NVMWyYbY6mP-WZ5Bh3R0QGPt1iU8ChV065Q>
    <xme:D9OwZpQWVGBXpLd9r5Zv7m0YbgPiNElZZO3EkzmjiRGgaxd_OqSaXEusv762ziKtX
    7hOm5aBNv1aNvpu>
X-ME-Received: <xmr:D9OwZjXt5q9XlQIEU2A9uzuRVw9zy0Rf2jEQ9xh0rf9ypAGoViXqSscO7FTN_k24KA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeigdeiiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepuegvrhhn
    ugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilh
    drfhhmqeenucggtffrrghtthgvrhhnpeduleefvdduveduveelgeelffffkedukeegveel
    gfekleeuvdehkeehheehkefhfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhf
    mhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:D9OwZrgJMEZzopGwnK7Jv3BjOShgQNRrV9sdLw4YelvcXKANhYFC3A>
    <xmx:D9OwZrA3E83ozA6jO_nftB4UNUkJHdYaJp9mzhNCnIF4zmk3Fskpyw>
    <xmx:D9OwZkJyXQzkNpQfmH0mXL-3YvUl8Qeo-IuynIfD8u7Dalliq0lLFQ>
    <xmx:D9OwZqCD5jtC8dJxrmVakKRV-4IBCALTtiIb-vfWdX87DQiUYELaZg>
    <xmx:D9OwZt2UgG_0115dpFnbZwtN8nstzygjiGrPSC5Vh7pvAhqawWo-JxFW>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Aug 2024 09:26:38 -0400 (EDT)
Message-ID: <fc1ed986-fcd6-4a52-aed3-f3f61f2513a7@fastmail.fm>
Date: Mon, 5 Aug 2024 15:26:37 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] fuse: add optional kernel-enforced timeout for
 requests
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com, laoar.shao@gmail.com, kernel-team@meta.com
References: <20240730002348.3431931-1-joannelkoong@gmail.com>
 <20240730002348.3431931-2-joannelkoong@gmail.com>
 <CAJnrk1Yf68HbGUuDv6zwfqkarMBsaHi1DJPdA0Fg5EyXvWbtFA@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US
In-Reply-To: <CAJnrk1Yf68HbGUuDv6zwfqkarMBsaHi1DJPdA0Fg5EyXvWbtFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/5/24 06:52, Joanne Koong wrote:
> On Mon, Jul 29, 2024 at 5:28 PM Joanne Koong <joannelkoong@gmail.com> wrote:
>>
>> There are situations where fuse servers can become unresponsive or take
>> too long to reply to a request. Currently there is no upper bound on
>> how long a request may take, which may be frustrating to users who get
>> stuck waiting for a request to complete.
>>
>> This commit adds a timeout option (in seconds) for requests. If the
>> timeout elapses before the server replies to the request, the request
>> will fail with -ETIME.
>>
>> There are 3 possibilities for a request that times out:
>> a) The request times out before the request has been sent to userspace
>> b) The request times out after the request has been sent to userspace
>> and before it receives a reply from the server
>> c) The request times out after the request has been sent to userspace
>> and the server replies while the kernel is timing out the request
>>
>> While a request timeout is being handled, there may be other handlers
>> running at the same time if:
>> a) the kernel is forwarding the request to the server
>> b) the kernel is processing the server's reply to the request
>> c) the request is being re-sent
>> d) the connection is aborting
>> e) the device is getting released
>>
>> Proper synchronization must be added to ensure that the request is
>> handled correctly in all of these cases. To this effect, there is a new
>> FR_FINISHING bit added to the request flags, which is set atomically by
>> either the timeout handler (see fuse_request_timeout()) which is invoked
>> after the request timeout elapses or set by the request reply handler
>> (see dev_do_write()), whichever gets there first. If the reply handler
>> and the timeout handler are executing simultaneously and the reply handler
>> sets FR_FINISHING before the timeout handler, then the request will be
>> handled as if the timeout did not elapse. If the timeout handler sets
>> FR_FINISHING before the reply handler, then the request will fail with
>> -ETIME and the request will be cleaned up.
>>
>> Currently, this is the refcount lifecycle of a request:
>>
>> Synchronous request is created:
>> fuse_simple_request -> allocates request, sets refcount to 1
>>    __fuse_request_send -> acquires refcount
>>      queues request and waits for reply...
>> fuse_simple_request -> drops refcount
>>
>> Background request is created:
>> fuse_simple_background -> allocates request, sets refcount to 1
>>
>> Request is replied to:
>> fuse_dev_do_write
>>    fuse_request_end -> drops refcount on request
>>
>> Proper acquires on the request reference must be added to ensure that the
>> timeout handler does not drop the last refcount on the request while
>> other handlers may be operating on the request. Please note that the
>> timeout handler may get invoked at any phase of the request's
>> lifetime (eg before the request has been forwarded to userspace, etc).
>>
>> It is always guaranteed that there is a refcount on the request when the
>> timeout handler is executing. The timeout handler will be either
>> deactivated by the reply/abort/release handlers, or if the timeout
>> handler is concurrently executing on another CPU, the reply/abort/release
>> handlers will wait for the timeout handler to finish executing first before
>> it drops the final refcount on the request.
>>
>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>> ---
>>   fs/fuse/dev.c    | 187 +++++++++++++++++++++++++++++++++++++++++++++--
>>   fs/fuse/fuse_i.h |  14 ++++
>>   fs/fuse/inode.c  |   7 ++
>>   3 files changed, 200 insertions(+), 8 deletions(-)
>>
>> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
>> index 9eb191b5c4de..9992bc5f4469 100644
>> --- a/fs/fuse/dev.c
>> +++ b/fs/fuse/dev.c
>> @@ -31,6 +31,8 @@ MODULE_ALIAS("devname:fuse");
>>
>>   static struct kmem_cache *fuse_req_cachep;
>>
>> +static void fuse_request_timeout(struct timer_list *timer);
>> +
>>   static struct fuse_dev *fuse_get_dev(struct file *file)
>>   {
>>          /*
>> @@ -48,6 +50,8 @@ static void fuse_request_init(struct fuse_mount *fm, struct fuse_req *req)
>>          refcount_set(&req->count, 1);
>>          __set_bit(FR_PENDING, &req->flags);
>>          req->fm = fm;
>> +       if (fm->fc->req_timeout)
>> +               timer_setup(&req->timer, fuse_request_timeout, 0);
>>   }
>>
>>   static struct fuse_req *fuse_request_alloc(struct fuse_mount *fm, gfp_t flags)
>> @@ -277,12 +281,15 @@ static void flush_bg_queue(struct fuse_conn *fc)
>>    * the 'end' callback is called if given, else the reference to the
>>    * request is released
>>    */
>> -void fuse_request_end(struct fuse_req *req)
>> +static void do_fuse_request_end(struct fuse_req *req, bool from_timer_callback)
>>   {
>>          struct fuse_mount *fm = req->fm;
>>          struct fuse_conn *fc = fm->fc;
>>          struct fuse_iqueue *fiq = &fc->iq;
>>
>> +       if (from_timer_callback)
>> +               req->out.h.error = -ETIME;
>> +
>>          if (test_and_set_bit(FR_FINISHED, &req->flags))
>>                  goto put_request;
>>
>> @@ -296,8 +303,6 @@ void fuse_request_end(struct fuse_req *req)
>>                  list_del_init(&req->intr_entry);
>>                  spin_unlock(&fiq->lock);
>>          }
>> -       WARN_ON(test_bit(FR_PENDING, &req->flags));
>> -       WARN_ON(test_bit(FR_SENT, &req->flags));
>>          if (test_bit(FR_BACKGROUND, &req->flags)) {
>>                  spin_lock(&fc->bg_lock);
>>                  clear_bit(FR_BACKGROUND, &req->flags);
>> @@ -324,13 +329,105 @@ void fuse_request_end(struct fuse_req *req)
>>                  wake_up(&req->waitq);
>>          }
>>
>> +       if (!from_timer_callback && req->timer.function)
>> +               timer_delete_sync(&req->timer);
>> +
>>          if (test_bit(FR_ASYNC, &req->flags))
>>                  req->args->end(fm, req->args, req->out.h.error);
>>   put_request:
>>          fuse_put_request(req);
>>   }
>> +
>> +void fuse_request_end(struct fuse_req *req)
>> +{
>> +       WARN_ON(test_bit(FR_PENDING, &req->flags));
>> +       WARN_ON(test_bit(FR_SENT, &req->flags));
>> +
>> +       do_fuse_request_end(req, false);
>> +}
>>   EXPORT_SYMBOL_GPL(fuse_request_end);
>>
>> +static void timeout_inflight_req(struct fuse_req *req)
>> +{
>> +       struct fuse_conn *fc = req->fm->fc;
>> +       struct fuse_iqueue *fiq = &fc->iq;
>> +       struct fuse_pqueue *fpq;
>> +
>> +       spin_lock(&fiq->lock);
>> +       fpq = req->fpq;
>> +       spin_unlock(&fiq->lock);
>> +
>> +       /*
>> +        * If fpq has not been set yet, then the request is aborting (which
>> +        * clears FR_PENDING flag) before dev_do_read (which sets req->fpq)
>> +        * has been called. Let the abort handler handle this request.
>> +        */
>> +       if (!fpq)
>> +               return;
>> +
>> +       spin_lock(&fpq->lock);
>> +       if (!fpq->connected || req->out.h.error == -ECONNABORTED) {
>> +               /*
>> +                * Connection is being aborted or the fuse_dev is being released.
>> +                * The abort / release will clean up the request
>> +                */
>> +               spin_unlock(&fpq->lock);
>> +               return;
>> +       }
>> +
>> +       if (!test_bit(FR_PRIVATE, &req->flags))
>> +               list_del_init(&req->list);
>> +
>> +       spin_unlock(&fpq->lock);
>> +
>> +       do_fuse_request_end(req, true);
>> +}
>> +
>> +static void timeout_pending_req(struct fuse_req *req)
>> +{
>> +       struct fuse_conn *fc = req->fm->fc;
>> +       struct fuse_iqueue *fiq = &fc->iq;
>> +       bool background = test_bit(FR_BACKGROUND, &req->flags);
>> +
>> +       if (background)
>> +               spin_lock(&fc->bg_lock);
>> +       spin_lock(&fiq->lock);
>> +
>> +       if (!test_bit(FR_PENDING, &req->flags)) {
>> +               spin_unlock(&fiq->lock);
>> +               if (background)
>> +                       spin_unlock(&fc->bg_lock);
>> +               timeout_inflight_req(req);
>> +               return;
>> +       }
>> +
>> +       if (!test_bit(FR_PRIVATE, &req->flags))
>> +               list_del_init(&req->list);
>> +
>> +       spin_unlock(&fiq->lock);
>> +       if (background)
>> +               spin_unlock(&fc->bg_lock);
>> +
>> +       do_fuse_request_end(req, true);
>> +}
>> +
>> +static void fuse_request_timeout(struct timer_list *timer)
>> +{
>> +       struct fuse_req *req = container_of(timer, struct fuse_req, timer);
>> +
>> +       /*
>> +        * Request reply is being finished by the kernel right now.
>> +        * No need to time out the request.
>> +        */
>> +       if (test_and_set_bit(FR_FINISHING, &req->flags))
>> +               return;
>> +
>> +       if (test_bit(FR_PENDING, &req->flags))
>> +               timeout_pending_req(req);
>> +       else
>> +               timeout_inflight_req(req);
>> +}
>> +
>>   static int queue_interrupt(struct fuse_req *req)
>>   {
>>          struct fuse_iqueue *fiq = &req->fm->fc->iq;
>> @@ -409,7 +506,8 @@ static void request_wait_answer(struct fuse_req *req)
>>
>>   static void __fuse_request_send(struct fuse_req *req)
>>   {
>> -       struct fuse_iqueue *fiq = &req->fm->fc->iq;
>> +       struct fuse_conn *fc = req->fm->fc;
>> +       struct fuse_iqueue *fiq = &fc->iq;
>>
>>          BUG_ON(test_bit(FR_BACKGROUND, &req->flags));
>>          spin_lock(&fiq->lock);
>> @@ -421,6 +519,10 @@ static void __fuse_request_send(struct fuse_req *req)
>>                  /* acquire extra reference, since request is still needed
>>                     after fuse_request_end() */
>>                  __fuse_get_request(req);
>> +               if (req->timer.function) {
>> +                       req->timer.expires = jiffies + fc->req_timeout;
>> +                       add_timer(&req->timer);
>> +               }
>>                  queue_request_and_unlock(fiq, req);
>>
>>                  request_wait_answer(req);
>> @@ -539,6 +641,10 @@ static bool fuse_request_queue_background(struct fuse_req *req)
>>                  if (fc->num_background == fc->max_background)
>>                          fc->blocked = 1;
>>                  list_add_tail(&req->list, &fc->bg_queue);
>> +               if (req->timer.function) {
>> +                       req->timer.expires = jiffies + fc->req_timeout;
>> +                       add_timer(&req->timer);
>> +               }
>>                  flush_bg_queue(fc);
>>                  queued = true;
>>          }
>> @@ -1268,6 +1374,9 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
>>          req = list_entry(fiq->pending.next, struct fuse_req, list);
>>          clear_bit(FR_PENDING, &req->flags);
>>          list_del_init(&req->list);
>> +       /* Acquire a reference in case the timeout handler starts executing */
>> +       __fuse_get_request(req);
>> +       req->fpq = fpq;
>>          spin_unlock(&fiq->lock);
>>
>>          args = req->args;
>> @@ -1280,6 +1389,7 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
>>                  if (args->opcode == FUSE_SETXATTR)
>>                          req->out.h.error = -E2BIG;
>>                  fuse_request_end(req);
>> +               fuse_put_request(req);
>>                  goto restart;
> 
> While rereading through fuse_dev_do_read, I just realized we also need
> to handle the race condition for the error edge cases (here and in the
> "goto out_end;"), since the timeout handler could have finished
> executing by the time we hit the error edge case. We need to
> test_and_set_bit(FR_FINISHING) so that either the timeout_handler or
> dev_do_read cleans up the request, but not both. I'll fix this for v3.

I know it would change semantics a bit, but wouldn't it be much easier /
less racy if fuse_dev_do_read() would delete the timer when it takes a
request from fiq->pending and add it back in (with new timeouts) before
it returns the request?

Untested:

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 9992bc5f4469..444f667e2f43 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1379,6 +1379,15 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
         req->fpq = fpq;
         spin_unlock(&fiq->lock);

+       if (req->timer.function) {
+               /* request gets handled, remove the previous timeout */
+               timer_delete_sync(&req->timer);
+               if (test_bit(FR_FINISHED, &req->flags)) {
+                       fuse_put_request(req);
+                       goto restart;
+               }
+       }
+
         args = req->args;
         reqsize = req->in.h.len;

@@ -1433,24 +1442,10 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
         if (test_bit(FR_INTERRUPTED, &req->flags))
                 queue_interrupt(req);

-       /*
-        * Check if the timeout handler is running / ran. If it did, we need to
-        * remove the request from any lists in case the timeout handler finished
-        * before dev_do_read moved the request to the processing list.
-        *
-        * Check FR_SENT to distinguish whether the timeout or the write handler
-        * is finishing the request. However, there can be the case where the
-        * timeout handler and resend handler are running concurrently, so we
-        * need to also check the FR_PENDING bit.
-        */
-       if (test_bit(FR_FINISHING, &req->flags) &&
-           (test_bit(FR_SENT, &req->flags) || test_bit(FR_PENDING, &req->flags))) {
-               spin_lock(&fpq->lock);
-               if (!test_bit(FR_PRIVATE, &req->flags))
-                       list_del_init(&req->list);
-               spin_unlock(&fpq->lock);
-               fuse_put_request(req);
-               return -ETIME;
+       if (req->timer.function) {
+               /* re-arm the request */
+               req->timer.expires = jiffies + fc->req_timeout;
+               add_timer(&req->timer);
         }

         fuse_put_request(req);

Thanks,
Bernd

