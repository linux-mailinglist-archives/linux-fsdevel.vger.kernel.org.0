Return-Path: <linux-fsdevel+bounces-25124-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 097399494D9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 17:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AC52280DF1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 15:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31AE3CF58;
	Tue,  6 Aug 2024 15:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="ReosuGFY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y8f2SHYJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA87A286A6
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Aug 2024 15:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722959455; cv=none; b=O1EmUnpOHUKj5yZPxf7ll0IS18FbSPia3qaNjWDfh7k9BWatGpEEaM54F6dLAoMvW1IXCHh1us3aPmJNVFPqAhVTcglLl1kz2fwSxTCzHhvEbxcq8mkf6WZqRAsWwsEw8t/fQ9WY41sA+hejE2ql0+RYwg8Ek70oEb0elcvwNvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722959455; c=relaxed/simple;
	bh=QwPlrJl+sQ/1UElXOSUZWSjx2V9Cry0D46XVzDdCsOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ROIsxMh7m4/MkMdZ/7yUc72o02AnrXnw2cNEC9T+/Powel6hxSIURCfrl+TgmCWG4T7M1oo2fj1pH1RkrSCYU/XzVXG+jtZV0kPZSdPIouh+X4SbP9n6d12TmSgKZ6NwZHlg1P++MwipL1XsH+ZTJheZHDzeZKcq6e16wAxxJTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=ReosuGFY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y8f2SHYJ; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 04A7C114FBD9;
	Tue,  6 Aug 2024 11:50:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 06 Aug 2024 11:50:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1722959450;
	 x=1723045850; bh=sESz4/Wc+4a3rBPOmbf1qv0qIQ0PF2l+tan6XUjOs6U=; b=
	ReosuGFYrd0L3MbOkEfYSmpe3KBerPVl1Ctkt6NG09NdPEGIEJJBH3xn8INdam+1
	3Zo7DHa3nfWMjj6CirG8PHeEBMOUWgw6bDP79KHfXL6dntmLcm2VodKykKYtHeG6
	g8zsa0K+QM9mrkxi2k8x8jxKSpE5S5vh6lkBGUdNS0jrBAQS+BJVI0vHVxFTY+AP
	sWiTTyQkW6Oyp92osx0K6agu/qCslAJps4qJIoyxtLJkEfN63l8KwrZcOkvFWUQU
	DR1Dms6tq1RAwhQnyrVkLh6IDrDcucFts63BrbN5wmId940xrcn6aAJHYaNVm7tA
	Zec5WKjdJjLAqK2No2p5vw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1722959450; x=
	1723045850; bh=sESz4/Wc+4a3rBPOmbf1qv0qIQ0PF2l+tan6XUjOs6U=; b=Y
	8f2SHYJu739/HS95LEpRfY2Nv2yKafXRg3nbo9APxcPQBhsxbZz0te3w94cCHmWJ
	4yoOd4PEM36YRi3UzTOjnZhghCL4l5t6/RAf8Zno8xNgtZ9wVgw84Z9qQweNwnO8
	7OdDktr7n0Pxua8EAZJaPDlglmYwuv2zQZBMWmI9dMTuOfBZZaJ8GaKmpSX1y2kl
	tvwwoEJ4s/BfvykH4ANDir+k9S/hndu+9ZKaxmTAsSviNxDGZHuj0nKa57edN/RH
	yYIHd8YXr5vWCZGo04z2W0LugCu7tBvSAmM3N994Yafy/prLA0UMIOZbaXB42nAM
	E6d96Ljv3OqE2XHKTmPsQ==
X-ME-Sender: <xms:WkayZgGPwxw-tdJrm6_rCLRtDnmOF-B2v_Fc5D-oSfP1Vqa1YRRhtA>
    <xme:WkayZpXloOwhNR50vy6cru9fIf7s4qAei5joUwj09Q1D3fSLSe1KGTBI2sg2uzEfY
    QhHRNYqnSz83Skd>
X-ME-Received: <xmr:WkayZqL2gSFt8zm7x4mnGq89uwmcWKE3EBl-s_hJuDXV3zqBLhzeOwUu-rxQk2MHdM3CL-IFbfoPRplOD8VOmfAWdK7EyuLgz_eU9W2Rhy0Cpq6CwrW4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeekgdelfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepuegvrhhn
    ugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilh
    drfhhmqeenucggtffrrghtthgvrhhnpeduleefvdduveduveelgeelffffkedukeegveel
    gfekleeuvdehkeehheehkefhfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhf
    mhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:WkayZiH7JiaA5sBVW_Ov5AxwgHQJERArkcs8mNR-PLaAx-d0RGYleA>
    <xmx:WkayZmVX6KBYsPe_c1BuwzcJB071hN8xk4XohQikPEWXueV6FsXrcQ>
    <xmx:WkayZlOQdOk89iCOjJKnxFncgN3Isu5XqF6sx7X9awqTghZ3S9FkFA>
    <xmx:WkayZt2WbZknl7ondYHoCTQzwkAlYUBhZaQPWIqKjzn01MzIGQIaPA>
    <xmx:WkayZhH_kjDIH3X0L1H98YzmIv_QgPGhdTnDn1JydCWG6HyYEWSnabyf>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Aug 2024 11:50:49 -0400 (EDT)
Message-ID: <239c3c0c-3290-494f-825d-864c8b9dd3c5@fastmail.fm>
Date: Tue, 6 Aug 2024 17:50:48 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] fuse: add optional kernel-enforced timeout for
 requests
To: Joanne Koong <joannelkoong@gmail.com>,
 Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com,
 laoar.shao@gmail.com, kernel-team@meta.com
References: <20240730002348.3431931-1-joannelkoong@gmail.com>
 <20240730002348.3431931-2-joannelkoong@gmail.com>
 <ffce4a22-5104-4707-812b-962638e45aeb@linux.alibaba.com>
 <CAJnrk1aHnn+i2FNxOEnLdhC6m9gF_O77t9yjsvsmFwLjBh-Gkw@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, fr, ru
In-Reply-To: <CAJnrk1aHnn+i2FNxOEnLdhC6m9gF_O77t9yjsvsmFwLjBh-Gkw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 8/6/24 00:53, Joanne Koong wrote:
> On Mon, Aug 5, 2024 at 12:32 AM Jingbo Xu <jefflexu@linux.alibaba.com> wrote:
>>
>>
>>
>> On 7/30/24 8:23 AM, Joanne Koong wrote:
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
>>>   __fuse_request_send -> acquires refcount
>>>     queues request and waits for reply...
>>> fuse_simple_request -> drops refcount
>>>
>>> Background request is created:
>>> fuse_simple_background -> allocates request, sets refcount to 1
>>>
>>> Request is replied to:
>>> fuse_dev_do_write
>>>   fuse_request_end -> drops refcount on request
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
>>>  fs/fuse/dev.c    | 187 +++++++++++++++++++++++++++++++++++++++++++++--
>>>  fs/fuse/fuse_i.h |  14 ++++
>>>  fs/fuse/inode.c  |   7 ++
>>>  3 files changed, 200 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
>>> index 9eb191b5c4de..9992bc5f4469 100644
>>> --- a/fs/fuse/dev.c
>>> +++ b/fs/fuse/dev.c
>>> @@ -31,6 +31,8 @@ MODULE_ALIAS("devname:fuse");
>>>
>>>  static struct kmem_cache *fuse_req_cachep;
>>>
>>> +static void fuse_request_timeout(struct timer_list *timer);
>>> +
>>>  static struct fuse_dev *fuse_get_dev(struct file *file)
>>>  {
>>>       /*
>>> @@ -48,6 +50,8 @@ static void fuse_request_init(struct fuse_mount *fm, struct fuse_req *req)
>>>       refcount_set(&req->count, 1);
>>>       __set_bit(FR_PENDING, &req->flags);
>>>       req->fm = fm;
>>> +     if (fm->fc->req_timeout)
>>> +             timer_setup(&req->timer, fuse_request_timeout, 0);
>>>  }
>>>
>>>  static struct fuse_req *fuse_request_alloc(struct fuse_mount *fm, gfp_t flags)
>>> @@ -277,12 +281,15 @@ static void flush_bg_queue(struct fuse_conn *fc)
>>>   * the 'end' callback is called if given, else the reference to the
>>>   * request is released
>>>   */
>>> -void fuse_request_end(struct fuse_req *req)
>>> +static void do_fuse_request_end(struct fuse_req *req, bool from_timer_callback)
>>>  {
>>>       struct fuse_mount *fm = req->fm;
>>>       struct fuse_conn *fc = fm->fc;
>>>       struct fuse_iqueue *fiq = &fc->iq;
>>>
>>> +     if (from_timer_callback)
>>> +             req->out.h.error = -ETIME;
>>> +
>>
>> FMHO, could we move the above error assignment up to the caller to make
>> do_fuse_request_end() look cleaner?
> 
> Sure, I was thinking that it looks cleaner setting this in
> do_fuse_request_end() instead of having to set it in both
> timeout_pending_req() and timeout_inflight_req(), but I see your point
> as well.
> I'll make this change in v3.
> 
>>
>>
>>>       if (test_and_set_bit(FR_FINISHED, &req->flags))
>>>               goto put_request;
>>>
>>> @@ -296,8 +303,6 @@ void fuse_request_end(struct fuse_req *req)
>>>               list_del_init(&req->intr_entry);
>>>               spin_unlock(&fiq->lock);
>>>       }
>>> -     WARN_ON(test_bit(FR_PENDING, &req->flags));
>>> -     WARN_ON(test_bit(FR_SENT, &req->flags));
>>>       if (test_bit(FR_BACKGROUND, &req->flags)) {
>>>               spin_lock(&fc->bg_lock);
>>>               clear_bit(FR_BACKGROUND, &req->flags);
>>> @@ -324,13 +329,105 @@ void fuse_request_end(struct fuse_req *req)
>>>               wake_up(&req->waitq);
>>>       }
>>>
>>> +     if (!from_timer_callback && req->timer.function)
>>> +             timer_delete_sync(&req->timer);
>>> +
>>
>> Similarly, move the caller i.e. fuse_request_end() call
>> timer_delete_sync() instead?
> 
> I don't think we can do that because the fuse_put_request() at the end
> of this function often holds the last refcount on the request which
> frees the request when it releases the ref.

Just a suggestion, maybe add an extra reference for the timer? The
condition above and fuse_request_timeout() would then need to release
that ref.


Thanks,
Bernd

