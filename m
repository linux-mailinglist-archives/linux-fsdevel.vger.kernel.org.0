Return-Path: <linux-fsdevel+bounces-20592-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C1A8D5496
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 23:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BB561C21A70
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 21:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE7F18130F;
	Thu, 30 May 2024 21:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="OCQ0RX5M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PXlFxrDj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0BC17DE23
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 21:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717104409; cv=none; b=hROL6y84a9Kzu01ePeDiZXZkX+/K7g4h/VS8H4qc71djRlrVcrWQlmsl0wlQwtw2c7GJ9XOVZ7GlLlTiCC5C2WxCY8IMJwhQ7IJFWpIKaqBrJQppLdoKmnm74EAsHrxQYl7hz3MJY4bs/Ags1nL3WY5YN7k6dh8rmJ5qxuP1ZIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717104409; c=relaxed/simple;
	bh=AoD7Q2bQteeHgrQsj8nQ9T+1h91PL+tZMc9LWbZI+PQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ITqJtva9DE/UyE1lRTlt1UofRwGtrE5jw+OGNXQgdoWbq+G8KzCozqErzJ/dcW8dKOur5Du8rCZNQrVLWj+rGC2LPvZ+B6MvZzT/Ny++okgpvsXfi5KQWlVjuEZRKd2RzIbSk6xN3XaRXPv6ciiYqNanzDl9HIkHSg/JCC2fcII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=OCQ0RX5M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PXlFxrDj; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 6044C11400BF;
	Thu, 30 May 2024 17:26:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 30 May 2024 17:26:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1717104405;
	 x=1717190805; bh=M3VDYQrFGJ5JsWMSPU3u380B8iXDdpsXX3rzX4Wd+DM=; b=
	OCQ0RX5MLSMmpPVaocMFr//iVSB655P32J90aMF2EbBb8v3aZt0YQr/SbNZrcKRU
	a3inwyAaWeFv7a77emQ1+Lbli2hHx89yW6VbstWFdo+IavRgWCNuroh+PYeTJ274
	gZIxnRVVMjadOTEp5AxqRbo8jjyC6HJwd8U6aVTw82OCFtf+1vNMs1PvnHfprIas
	VCYWzKOotDvqX6yDedI2XfrTM5nd0zDo3xNNcfvUSNMlypf3xaziRIqEcnW2VHyi
	DwDcVixODpmXkRUv3ytpQfM3+JDQ1cIs0nV1i4zhPU/UdhN0YEGNrczn+pgp32YN
	d0P4wY2j9mFaKuuaDicmPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717104405; x=
	1717190805; bh=M3VDYQrFGJ5JsWMSPU3u380B8iXDdpsXX3rzX4Wd+DM=; b=P
	XlFxrDjzXeutns9Vv6jPqoQxP9UYyKtI/h/fnSXPH/wTRd1WvhYQuqf9Z61dffqA
	BPF8mLMN/WrzR31/9vPQy5gjvlzslhDaj7PKyYgcoyCX1GZRsKS5W3kRz1dvMtrq
	Q7kygIuZA6LmBKIB7QRbrzQTfKDnBJRIHXbwWQsUF6WYPf9oz6T9jeGJZn1Vtw+j
	3VOCNX+3HcvRfAHu3m5IN7aYbZ3EHQ/gXKl+jVKKSob7VgdQYMpWBPtboHgBKq8T
	wOP1XDg28ALUiIT4z47fj9gaDXkrIAc9p45kDMjVADc3WEAkvovIJb/yAweMFkch
	qz/U/TFmr+T0evco4ABlw==
X-ME-Sender: <xms:FO9YZj1jeuF24LyDP-CR9kRz1FJdaDG-iqsq67lL9w_hYtU-f5tjvg>
    <xme:FO9YZiErd6D-tck5AHa1Yrk0BK2VEy-8uEtnfdYRpg4WAH6NYuJ7Rst2yG3Zv1B6g
    L_G6BUyOZMYAlYP>
X-ME-Received: <xmr:FO9YZj5bSbunvvOVEbJPeIOb20V8jVLs2fkp4t78Hdg0_TaSPu-XXNA2nICYdBB9PIm9hOzvhjiDr0ifh6HdKpUv5-SAREdS6YP_gZ4PabD4w6zjKa7m>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekgedgudehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepuegv
    rhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrg
    hilhdrfhhmqeenucggtffrrghtthgvrhhnpeevhffgvdeltddugfdtgfegleefvdehfeei
    veejieefveeiteeggffggfeulefgjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhl
    rdhfmh
X-ME-Proxy: <xmx:FO9YZo35QMzfpFdcoc3auDoVWVtF5WjVcHaN_5zb3rsYVgzh_e_vFQ>
    <xmx:FO9YZmGzHuhxXyt6e2hpUy_uzx-NvPd5nJ2Ls6bOGLs996vpF1GEZQ>
    <xmx:FO9YZp8ijmZQ7NPG4GhAYAdOGXUvtdhKR0uDbzIvK015Ir-rvGNmfw>
    <xmx:FO9YZjkp0ZzIFpMoCQu_TPB0ecGc9xLP6RpKo52o1U4fT_pplMiPIA>
    <xmx:Fe9YZjPFoUvf8UFDapdwoRiksB-YZHjY3xa2VK392hNYCV3WzLF5CPIn>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 May 2024 17:26:44 -0400 (EDT)
Message-ID: <7b9851dd-f175-4d68-9ef4-cceea7eeff05@fastmail.fm>
Date: Thu, 30 May 2024 23:26:42 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 14/19] fuse: {uring} Allow to queue to the ring
To: Josef Bacik <josef@toxicpanda.com>, Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>,
 linux-fsdevel@vger.kernel.org
References: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
 <20240529-fuse-uring-for-6-9-rfc2-out-v1-14-d149476b1d65@ddn.com>
 <20240530203251.GF2210558@perftesting>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20240530203251.GF2210558@perftesting>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/30/24 22:32, Josef Bacik wrote:
> On Wed, May 29, 2024 at 08:00:49PM +0200, Bernd Schubert wrote:
>> This enables enqueuing requests through fuse uring queues.
>>
>> For initial simplicity requests are always allocated the normal way
>> then added to ring queues lists and only then copied to ring queue
>> entries. Later on the allocation and adding the requests to a list
>> can be avoided, by directly using a ring entry. This introduces
>> some code complexity and is therefore not done for now.
>>
>> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
>> ---
>>  fs/fuse/dev.c         | 80 +++++++++++++++++++++++++++++++++++++++-----
>>  fs/fuse/dev_uring.c   | 92 ++++++++++++++++++++++++++++++++++++++++++---------
>>  fs/fuse/dev_uring_i.h | 17 ++++++++++
>>  3 files changed, 165 insertions(+), 24 deletions(-)
>>
>> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
>> index 6ffd216b27c8..c7fd3849a105 100644
>> --- a/fs/fuse/dev.c
>> +++ b/fs/fuse/dev.c
>> @@ -218,13 +218,29 @@ const struct fuse_iqueue_ops fuse_dev_fiq_ops = {
>>  };
>>  EXPORT_SYMBOL_GPL(fuse_dev_fiq_ops);
>>  
>> -static void queue_request_and_unlock(struct fuse_iqueue *fiq,
>> -				     struct fuse_req *req)
>> +
>> +static void queue_request_and_unlock(struct fuse_conn *fc,
>> +				     struct fuse_req *req, bool allow_uring)
>>  __releases(fiq->lock)
>>  {
>> +	struct fuse_iqueue *fiq = &fc->iq;
>> +
>>  	req->in.h.len = sizeof(struct fuse_in_header) +
>>  		fuse_len_args(req->args->in_numargs,
>>  			      (struct fuse_arg *) req->args->in_args);
>> +
>> +	if (allow_uring && fuse_uring_ready(fc)) {
>> +		int res;
>> +
>> +		/* this lock is not needed at all for ring req handling */
>> +		spin_unlock(&fiq->lock);
>> +		res = fuse_uring_queue_fuse_req(fc, req);
>> +		if (!res)
>> +			return;
>> +
>> +		/* fallthrough, handled through /dev/fuse read/write */
> 
> We need the lock here because we're modifying &fiq->pending, this will end in
> tears.

Ouch right, sorry that I had missed that. I will actually remove the
fallthrough altogether, not needed anymore.

> 
>> +	}
>> +
>>  	list_add_tail(&req->list, &fiq->pending);
>>  	fiq->ops->wake_pending_and_unlock(fiq);
>>  }
>> @@ -261,7 +277,7 @@ static void flush_bg_queue(struct fuse_conn *fc)
>>  		fc->active_background++;
>>  		spin_lock(&fiq->lock);
>>  		req->in.h.unique = fuse_get_unique(fiq);
>> -		queue_request_and_unlock(fiq, req);
>> +		queue_request_and_unlock(fc, req, true);
>>  	}
>>  }
>>  
>> @@ -405,7 +421,8 @@ static void request_wait_answer(struct fuse_req *req)
>>  
>>  static void __fuse_request_send(struct fuse_req *req)
>>  {
>> -	struct fuse_iqueue *fiq = &req->fm->fc->iq;
>> +	struct fuse_conn *fc = req->fm->fc;
>> +	struct fuse_iqueue *fiq = &fc->iq;
>>  
>>  	BUG_ON(test_bit(FR_BACKGROUND, &req->flags));
>>  	spin_lock(&fiq->lock);
>> @@ -417,7 +434,7 @@ static void __fuse_request_send(struct fuse_req *req)
>>  		/* acquire extra reference, since request is still needed
>>  		   after fuse_request_end() */
>>  		__fuse_get_request(req);
>> -		queue_request_and_unlock(fiq, req);
>> +		queue_request_and_unlock(fc, req, true);
>>  
>>  		request_wait_answer(req);
>>  		/* Pairs with smp_wmb() in fuse_request_end() */
>> @@ -487,6 +504,10 @@ ssize_t fuse_simple_request(struct fuse_mount *fm, struct fuse_args *args)
>>  	if (args->force) {
>>  		atomic_inc(&fc->num_waiting);
>>  		req = fuse_request_alloc(fm, GFP_KERNEL | __GFP_NOFAIL);
>> +		if (unlikely(!req)) {
>> +			ret = -ENOTCONN;
>> +			goto err;
>> +		}
> 
> This is extraneous, and not possible since we're doing __GFP_NOFAIL.
> 
>>  
>>  		if (!args->nocreds)
>>  			fuse_force_creds(req);
>> @@ -514,16 +535,55 @@ ssize_t fuse_simple_request(struct fuse_mount *fm, struct fuse_args *args)
>>  	}
>>  	fuse_put_request(req);
>>  
>> +err:
>>  	return ret;
>>  }
>>  
>> -static bool fuse_request_queue_background(struct fuse_req *req)
>> +static bool fuse_request_queue_background_uring(struct fuse_conn *fc,
>> +					       struct fuse_req *req)
>> +{
>> +	struct fuse_iqueue *fiq = &fc->iq;
>> +	int err;
>> +
>> +	req->in.h.unique = fuse_get_unique(fiq);
>> +	req->in.h.len = sizeof(struct fuse_in_header) +
>> +		fuse_len_args(req->args->in_numargs,
>> +			      (struct fuse_arg *) req->args->in_args);
>> +
>> +	err = fuse_uring_queue_fuse_req(fc, req);
>> +	if (!err) {
> 
> I'd rather
> 
> if (err)
> 	return false;
> 
> Then the rest of this code.
> 
> Also generally speaking I think you're correct, below isn't needed because the
> queues themselves have their own limits, so I think just delete this bit.
> 
>> +		/* XXX remove and lets the users of that use per queue values -
>> +		 * avoid the shared spin lock...
>> +		 * Is this needed at all?
>> +		 */
>> +		spin_lock(&fc->bg_lock);
>> +		fc->num_background++;
>> +		fc->active_background++;


I now actually think we still need it, because in the current version it
queues to queue->async_fuse_req_queue  / queue->sync_fuse_req_queue.

>> +
>> +
>> +		/* XXX block when per ring queues get occupied */
>> +		if (fc->num_background == fc->max_background)
>> +			fc->blocked = 1;

I need to double check again, but I think I can just remove both XXX.

I also just see an issue with fc->active_background, fuse_request_end()
is decreasing it unconditionally, but with uring we never increase it
(and don't need it). I think I need an FR_URING flag.


>> +		spin_unlock(&fc->bg_lock);
>> +	}
>> +
>> +	return err ? false : true;
>> +}
>> +
>> +/*
>> + * @return true if queued
>> + */
>> +static int fuse_request_queue_background(struct fuse_req *req)
>>  {
>>  	struct fuse_mount *fm = req->fm;
>>  	struct fuse_conn *fc = fm->fc;
>>  	bool queued = false;
>>  
>>  	WARN_ON(!test_bit(FR_BACKGROUND, &req->flags));
>> +
>> +	if (fuse_uring_ready(fc))
>> +		return fuse_request_queue_background_uring(fc, req);
>> +
>>  	if (!test_bit(FR_WAITING, &req->flags)) {
>>  		__set_bit(FR_WAITING, &req->flags);
>>  		atomic_inc(&fc->num_waiting);
>> @@ -576,7 +636,8 @@ static int fuse_simple_notify_reply(struct fuse_mount *fm,
>>  				    struct fuse_args *args, u64 unique)
>>  {
>>  	struct fuse_req *req;
>> -	struct fuse_iqueue *fiq = &fm->fc->iq;
>> +	struct fuse_conn *fc = fm->fc;
>> +	struct fuse_iqueue *fiq = &fc->iq;
>>  	int err = 0;
>>  
>>  	req = fuse_get_req(fm, false);
>> @@ -590,7 +651,8 @@ static int fuse_simple_notify_reply(struct fuse_mount *fm,
>>  
>>  	spin_lock(&fiq->lock);
>>  	if (fiq->connected) {
>> -		queue_request_and_unlock(fiq, req);
>> +		/* uring for notify not supported yet */
>> +		queue_request_and_unlock(fc, req, false);
>>  	} else {
>>  		err = -ENODEV;
>>  		spin_unlock(&fiq->lock);
>> @@ -2205,6 +2267,7 @@ void fuse_abort_conn(struct fuse_conn *fc)
>>  		fuse_uring_set_stopped(fc);
>>  
>>  		fuse_set_initialized(fc);
>> +
> 
> Extraneous newline.
> 
>>  		list_for_each_entry(fud, &fc->devices, entry) {
>>  			struct fuse_pqueue *fpq = &fud->pq;
>>  
>> @@ -2478,6 +2541,7 @@ static long fuse_uring_ioctl(struct file *file, __u32 __user *argp)
>>  		if (res != 0)
>>  			return res;
>>  		break;
>> +
> 
> Extraneous newline.
> 

Sorry, these two slipped through.

>>  		case FUSE_URING_IOCTL_CMD_QUEUE_CFG:
>>  			fud->uring_dev = 1;
>>  			res = fuse_uring_queue_cfg(fc->ring, &cfg.qconf);
>> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
>> index 6001ba4d6e82..fe80e66150c3 100644
>> --- a/fs/fuse/dev_uring.c
>> +++ b/fs/fuse/dev_uring.c
>> @@ -32,8 +32,7 @@
>>  #include <linux/io_uring/cmd.h>
>>  
>>  static void fuse_uring_req_end_and_get_next(struct fuse_ring_ent *ring_ent,
>> -					    bool set_err, int error,
>> -					    unsigned int issue_flags);
>> +					    bool set_err, int error);
>>  
>>  static void fuse_ring_ring_ent_unset_userspace(struct fuse_ring_ent *ent)
>>  {
>> @@ -683,8 +682,7 @@ static int fuse_uring_copy_to_ring(struct fuse_ring *ring, struct fuse_req *req,
>>   * userspace will read it
>>   * This is comparable with classical read(/dev/fuse)
>>   */
>> -static void fuse_uring_send_to_ring(struct fuse_ring_ent *ring_ent,
>> -				    unsigned int issue_flags, bool send_in_task)
>> +static void fuse_uring_send_to_ring(struct fuse_ring_ent *ring_ent)
>>  {
>>  	struct fuse_ring *ring = ring_ent->queue->ring;
>>  	struct fuse_ring_req *rreq = ring_ent->rreq;
>> @@ -721,20 +719,17 @@ static void fuse_uring_send_to_ring(struct fuse_ring_ent *ring_ent,
>>  	rreq->in = req->in.h;
>>  	set_bit(FR_SENT, &req->flags);
>>  
>> -	pr_devel("%s qid=%d tag=%d state=%lu cmd-done op=%d unique=%llu issue_flags=%u\n",
>> +	pr_devel("%s qid=%d tag=%d state=%lu cmd-done op=%d unique=%llu\n",
>>  		 __func__, ring_ent->queue->qid, ring_ent->tag, ring_ent->state,
>> -		 rreq->in.opcode, rreq->in.unique, issue_flags);
>> +		 rreq->in.opcode, rreq->in.unique);
>>  
>> -	if (send_in_task)
>> -		io_uring_cmd_complete_in_task(ring_ent->cmd,
>> -					      fuse_uring_async_send_to_ring);
>> -	else
>> -		io_uring_cmd_done(ring_ent->cmd, 0, 0, issue_flags);
>> +	io_uring_cmd_complete_in_task(ring_ent->cmd,
>> +				      fuse_uring_async_send_to_ring);

Oops, here went something wrong, in the previous patch, which had
introduce the "if (send_in_task)" - this part of later patch.

>>  
>>  	return;
>>  
>>  err:
>> -	fuse_uring_req_end_and_get_next(ring_ent, true, err, issue_flags);
>> +	fuse_uring_req_end_and_get_next(ring_ent, true, err);
>>  }
>>  
>>  /*
>> @@ -811,8 +806,7 @@ static bool fuse_uring_ent_release_and_fetch(struct fuse_ring_ent *ring_ent)
>>   * has lock/unlock/lock to avoid holding the lock on calling fuse_request_end
>>   */
>>  static void fuse_uring_req_end_and_get_next(struct fuse_ring_ent *ring_ent,
>> -					    bool set_err, int error,
>> -					    unsigned int issue_flags)
>> +					    bool set_err, int error)
>>  {
>>  	struct fuse_req *req = ring_ent->fuse_req;
>>  	int has_next;
>> @@ -828,7 +822,7 @@ static void fuse_uring_req_end_and_get_next(struct fuse_ring_ent *ring_ent,
>>  	has_next = fuse_uring_ent_release_and_fetch(ring_ent);
>>  	if (has_next) {
>>  		/* called within uring context - use provided flags */
>> -		fuse_uring_send_to_ring(ring_ent, issue_flags, false);
>> +		fuse_uring_send_to_ring(ring_ent);
>>  	}
>>  }
>>  
>> @@ -863,7 +857,7 @@ static void fuse_uring_commit_and_release(struct fuse_dev *fud,
>>  out:
>>  	pr_devel("%s:%d ret=%zd op=%d req-ret=%d\n", __func__, __LINE__, err,
>>  		 req->args->opcode, req->out.h.error);
>> -	fuse_uring_req_end_and_get_next(ring_ent, set_err, err, issue_flags);
>> +	fuse_uring_req_end_and_get_next(ring_ent, set_err, err);
>>  }
>>  
>>  /*
>> @@ -1101,3 +1095,69 @@ int fuse_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
>>  	goto out;
>>  }
>>  
>> +int fuse_uring_queue_fuse_req(struct fuse_conn *fc, struct fuse_req *req)
>> +{
>> +	struct fuse_ring *ring = fc->ring;
>> +	struct fuse_ring_queue *queue;
>> +	int qid = 0;
>> +	struct fuse_ring_ent *ring_ent = NULL;
>> +	int res;
>> +	bool async = test_bit(FR_BACKGROUND, &req->flags);
>> +	struct list_head *req_queue, *ent_queue;
>> +
>> +	if (ring->per_core_queue) {
>> +		/*
>> +		 * async requests are best handled on another core, the current
>> +		 * core can do application/page handling, while the async request
>> +		 * is handled on another core in userspace.
>> +		 * For sync request the application has to wait - no processing, so
>> +		 * the request should continue on the current core and avoid context
>> +		 * switches.
>> +		 * XXX This should be on the same numa node and not busy - is there
>> +		 * a scheduler function available  that could make this decision?
>> +		 * It should also not persistently switch between cores - makes
>> +		 * it hard for the scheduler.
>> +		 */
>> +		qid = task_cpu(current);
>> +
>> +		if (unlikely(qid >= ring->nr_queues)) {
>> +			WARN_ONCE(1,
>> +				  "Core number (%u) exceeds nr ueues (%zu)\n",
>> +				  qid, ring->nr_queues);
>> +			qid = 0;
>> +		}
>> +	}
>> +
>> +	queue = fuse_uring_get_queue(ring, qid);
>> +	req_queue = async ? &queue->async_fuse_req_queue :
>> +			    &queue->sync_fuse_req_queue;
>> +	ent_queue = async ? &queue->async_ent_avail_queue :
>> +			    &queue->sync_ent_avail_queue;
>> +
>> +	spin_lock(&queue->lock);
>> +
>> +	if (unlikely(queue->stopped)) {
>> +		res = -ENOTCONN;
>> +		goto err_unlock;
> 
> This is the only place we use err_unlock, just do
> 
> if (unlikely(queue->stopped)) {
> 	spin_unlock(&queue->lock);
> 	return -ENOTCONN;
> }
> 
> and then you can get rid of res.  Thanks,


Thanks, will do.
(I personally typically avoid unlock/return in the middle of a function
as one can easily miss the unlock with new code additions - I have bad
experience with that).


Thanks,
Bernd

