Return-Path: <linux-fsdevel+bounces-23964-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 351A3937093
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 00:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4E9F1F229ED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 22:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F229E14601C;
	Thu, 18 Jul 2024 22:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="imAwPsPB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ltve/5u0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9B4146003
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jul 2024 22:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721340684; cv=none; b=SpsnF4SwcgQwvhWwowhB6EZ7u5k7az5DWsNODHpP2Ht8esDis5sZTz2o/qThLsJXzt/lC6gI1tVzQFfJkM27vDACqRANkXDKQPWNU6Lu2H/rBmyqTIx/vec2r4R+wutBtgZTnG45u7lDXjz/AgdAZj3j+n0Pwz/U1/ZY3D8jamQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721340684; c=relaxed/simple;
	bh=mRNmt366Q9pzo+SizSIhfibSyrr8NrkWjSoXGa112rw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uUL02NwqoKOo/2oPMOcDgActstuMNG7H1RVOzFiGi3/39LDAonuMlQ4xdR0HBPIcnZ4JGUM5Vq7uNzNhtEwYI7z41RGTzGf+rLQau6pj872vzhREyxK1U5JLBBFKy2tCRdQDPtjFS6HcdvpgnfnAVzPXBrC/ybf6fSCrbh1gago=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aakef.fastmail.fm; spf=pass smtp.mailfrom=aakef.fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=imAwPsPB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ltve/5u0; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aakef.fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aakef.fastmail.fm
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 7217F1140162;
	Thu, 18 Jul 2024 18:11:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 18 Jul 2024 18:11:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1721340681;
	 x=1721427081; bh=LIbCIhRK9vb5rcxJL8jV/2VlapWPypwj0Ptdkeq7nIE=; b=
	imAwPsPBvsg7scsYPhugAGaRggb+dMH0+8fsb6RQD7ByxSWO68s0+zK+mIeGA29i
	v5IRLIR9/JSIexF5WcThbnwBNQ3qWhpqsew34kSEPklZIXfu0Zm1+SdZdVj0oKKF
	5zCi9+WNB/rOjTJL34+CFGGvw730q7yAaYDHkw2DnhWNEJBMXKkOj9m4CgKOka4P
	sMLsMF82X2Vl6ILacyNs/SZBTYLpnH0WYpv6VIS1q4ovZyrB7RmACwwJW6IFZdny
	PKI5E3J9emNbbE9HFSgg7PiR1Y/TEUwtyk2jrLbF8SbQsa88tUpycDCiciRGG58l
	f2qo6FbfufFCN/D1fHlCUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1721340681; x=
	1721427081; bh=LIbCIhRK9vb5rcxJL8jV/2VlapWPypwj0Ptdkeq7nIE=; b=L
	tve/5u010bnA2mhpR1wIR3k1vabHZPByJi4ruApj5A/GV/yaniNl0j94J5k9FE6H
	8Hc8tmB9Wy2+pGLgJnaYeMlXoC6+ElfGZqfT60yzjiumhbUmOkCjziKj+XnvLMsy
	fJh8z4shGYtByDJcKk+sIuG9sjG0IgUZ0vIkKvD8I5qZf7RMA5JsbfpGtAMGWo2Z
	3fSRX+wyEaDvFt5KQToF8dhqBa0TF9nR9CT6jgZolsNGPYKF62d+PG990+2hfq3J
	R2cETrK4re7LB2uDr7fAgz0ihGy0Mff65fiTTsl5RloVfJ+Jy+FL+mICykQFEpms
	Ld/bbfp1g1y1dZqNJWYzA==
X-ME-Sender: <xms:CZOZZiyCjDoRH8uRA_oWWmlcjjWm8P-DknQqklqYBhR52eloKxME2w>
    <xme:CZOZZuQQTZvAJYXxOP7YfmQCyxu7DM0NAsVh0P2GzG4HvfkKfX4LVwUgkXoQLP6-g
    pNJ8Tu_Ecnx4MQq>
X-ME-Received: <xmr:CZOZZkVhjZ4Zyl1BqIIURZVF-yRcB-XLpW5Tn_l7t3xdLmqC_Quaq2HPMuROQIFELnKU56_WATpH-WRT_JGxOK16hmXmwmlRB1aYjb-JlXWpqUvHhBn2rodH96nz0tcPJ8tLM8XUFTfGS2qJ2Ex96ukPhsgH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrhedtgddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepuegvrhhn
    ugcuufgthhhusggvrhhtuceosghspghlihhsthhssegrrghkvghfrdhfrghsthhmrghilh
    drfhhmqeenucggtffrrghtthgvrhhnpeejhfegfefgtdejhfehgfevvdeufffffffgfeet
    feegudevffeuieffheelgfffueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghspghlihhs
    thhssegrrghkvghfrdhfrghsthhmrghilhdrfhhm
X-ME-Proxy: <xmx:CZOZZojUFU7ulp7mhdcIoqVyG675ev8IfsL3S6dw0AOqIzvsec-Z3A>
    <xmx:CZOZZkBy4fUrNcQikurpIaABMRKxAbqfDwjbfDpbtx0s_dC87y-bNw>
    <xmx:CZOZZpLBiZFU9GwDCEXuuCiz82IzTp37vux6kTAV9VnDN5YZurjQCw>
    <xmx:CZOZZrAoxjzIuG0jqqRzlhRESv7OD_8rZ1-YOvbaEhuWQTsZxCr5CQ>
    <xmx:CZOZZm3KDh4IrahK99ooyPC9sBVVK0qarA45cRGtYAXrli30-9eX9ipL>
Feedback-ID: id8a84192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jul 2024 18:11:18 -0400 (EDT)
Message-ID: <0d34890b-0769-4b0c-86b7-0a43601962d4@aakef.fastmail.fm>
Date: Fri, 19 Jul 2024 00:11:17 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: add optional kernel-enforced timeout for fuse
 requests
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com,
 osandov@osandov.com, kernel-team@meta.com
References: <20240717213458.1613347-1-joannelkoong@gmail.com>
 <951dd7ff-d131-4a54-90b9-268722c33219@fastmail.fm>
 <CAJnrk1Zy1cek+V-D2F6xbk=Xz=z9b3v=9W+FzH+yAxmpqvmdYA@mail.gmail.com>
Content-Language: en-US, fr, ru
From: Bernd Schubert <bs_lists@aakef.fastmail.fm>
In-Reply-To: <CAJnrk1Zy1cek+V-D2F6xbk=Xz=z9b3v=9W+FzH+yAxmpqvmdYA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 7/18/24 07:24, Joanne Koong wrote:
> On Wed, Jul 17, 2024 at 3:23 PM Bernd Schubert
> <bernd.schubert@fastmail.fm> wrote:
>>
>> Hi Joanne,
>>
>> On 7/17/24 23:34, Joanne Koong wrote:
>>> There are situations where fuse servers can become unresponsive or take
>>> too long to reply to a request. Currently there is no upper bound on
>>> how long a request may take, which may be frustrating to users who get
>>> stuck waiting for a request to complete.
>>>
>>> This commit adds a daemon timeout option (in seconds) for fuse requests.
>>> If the timeout elapses before the request is replied to, the request will
>>> fail with -ETIME.
>>>
>>> There are 3 possibilities for a request that times out:
>>> a) The request times out before the request has been sent to userspace
>>> b) The request times out after the request has been sent to userspace
>>> and before it receives a reply from the server
>>> c) The request times out after the request has been sent to userspace
>>> and the server replies while the kernel is timing out the request
>>>
>>> Proper synchronization must be added to ensure that the request is
>>> handled correctly in all of these cases. To this effect, there is a new
>>> FR_PROCESSING bit added to the request flags, which is set atomically by
>>> either the timeout handler (see fuse_request_timeout()) which is invoked
>>> after the request timeout elapses or set by the request reply handler
>>> (see dev_do_write()), whichever gets there first.
>>>
>>> If the reply handler and the timeout handler are executing simultaneously
>>> and the reply handler sets FR_PROCESSING before the timeout handler, then
>>> the request is re-queued onto the waitqueue and the kernel will process the
>>> reply as though the timeout did not elapse. If the timeout handler sets
>>> FR_PROCESSING before the reply handler, then the request will fail with
>>> -ETIME and the request will be cleaned up.
>>>
>>> Proper acquires on the request reference must be added to ensure that the
>>> timeout handler does not drop the last refcount on the request while the
>>> reply handler (dev_do_write()) or forwarder handler (dev_do_read()) is
>>> still accessing the request. (By "forwarder handler", this is the handler
>>> that forwards the request to userspace).
>>>
>>> Currently, this is the lifecycle of the request refcount:
>>>
>>> Request is created:
>>> fuse_simple_request -> allocates request, sets refcount to 1
>>>   __fuse_request_send -> acquires refcount
>>>     queues request and waits for reply...
>>> fuse_simple_request -> drops refcount
>>>
>>> Request is freed:
>>> fuse_dev_do_write
>>>   fuse_request_end -> drops refcount on request
>>>
>>> The timeout handler drops the refcount on the request so that the
>>> request is properly cleaned up if a reply is never received. Because of
>>> this, both the forwarder handler and the reply handler must acquire a refcount
>>> on the request while it accesses the request, and the refcount must be
>>> acquired while the lock of the list the request is on is held.
>>>
>>> There is a potential race if the request is being forwarded to
>>> userspace while the timeout handler is executing (eg FR_PENDING has
>>> already been cleared but dev_do_read() hasn't finished executing). This
>>> is a problem because this would free the request but the request has not
>>> been removed from the fpq list it's on. To prevent this, dev_do_read()
>>> must check FR_PROCESSING at the end of its logic and remove the request
>>> from the fpq list if the timeout occurred.
>>>
>>> There is also the case where the connection may be aborted or the
>>> device may be released while the timeout handler is running. To protect
>>> against an extra refcount drop on the request, the timeout handler
>>> checks the connected state of the list and lets the abort handler drop the
>>> last reference if the abort is running simultaneously. Similarly, the
>>> timeout handler also needs to check if the req->out.h.error is set to
>>> -ESTALE, which indicates that the device release is cleaning up the
>>> request. In both these cases, the timeout handler will return without
>>> dropping the refcount.
>>>
>>> Please also note that background requests are not applicable for timeouts
>>> since they are asynchronous.
>>
>>
>> This and that thread here actually make me wonder if this is the right
>> approach
>>
>> https://lore.kernel.org/lkml/20240613040147.329220-1-haifeng.xu@shopee.com/T/
>>
>>
>> In  th3 thread above a request got interrupted, but fuse-server still
>> does not manage stop it. From my point of view, interrupting a request
>> suggests to add a rather short kernel lifetime for it. With that one
> 
> Hi Bernd,
> 
> I believe this solution fixes the problem outlined in that thread
> (namely, that the process gets stuck waiting for a reply). If the
> request is interrupted before it times out, the kernel will wait with
> a timeout again on the request (timeout would start over, but the
> request will still eventually sooner or later time out). I'm not sure
> I agree that we want to cancel the request altogether if it's
> interrupted. For example, if the user uses the user-defined signal
> SIGUSR1, it can be unexpected and arbitrary behavior for the request
> to be aborted by the kernel. I also don't think this can be consistent
> for what the fuse server will see since some requests may have already
> been forwarded to userspace when the request is aborted and some
> requests may not have.
> 
> I think if we were to enforce that the request should be aborted when
> it's interrupted regardless of whether a timeout is specified or not,
> then we should do it similarly to how the timeout handler logic
> handles it in this patch,rather than the implementation in the thread
> linked above (namely, that the request should be explicitly cleaned up
> immediately instead of when the interrupt request sends a reply); I
> don't believe the implementation in the link handles the case where
> for example the fuse server is in a deadlock and does not reply to the
> interrupt request. Also, as I understand it, it is optional for
> servers to reply or not to the interrupt request.

Hi Joanne,

yeah, the solution in the link above is definitely not ideal and I think
a timout based solution would be better. But I think your patch wouldn't
work either right now, unless server side sets a request timeout.
Btw, I would rename the variable 'daemon_timeout' to somethink like
req_timeout.

> 
>> either needs to wake up in intervals and check if request timeout got
>> exceeded or it needs to be an async kernel thread. I think that async
>> thread would also allow to give a timeout to background requests.
> 
> in my opinion, background requests do not need timeouts. As I
> understand it, background requests are used only for direct i/o async
> read/writes, writing back dirty pages,and readahead requests generated
> by the kernel. I don't think fuse servers would have a need for timing
> out background requests.

There is another discussion here, where timeouts are a possible although
ugly solution to avoid page copies

https://lore.kernel.org/linux-kernel/233a9fdf-13ea-488b-a593-5566fc9f5d92@fastmail.fm/T/


That is the bg writeback code path.

> 
>>
>> Or we add an async timeout to bg and interupted requests additionally?
> 
> The interrupted request will already have a timeout on it since it
> waits with a timeout again for the reply after it's interrupted.

If daemon side configures timeouts. And interrupted requests might want
to have a different timeout. I will check when I'm back if we can update
your patch a bit for that.

Your patch hooks in quite nicely and basically without overhead into fg
(sync) requests. Timing out bg requests will have a bit overhead (unless
I miss something), so maybe we need two solutions here. And if we want
to go that route at all, to avoid these extra fuse page copies.


> 
>>
>>
>> (I only basically reviewed, can't do carefully right now - on vacation
>> and as I just noticed, on a laptop that gives me electric shocks when I
>> connect it to power.)
> 
> No worries, thanks for your comments and hope you have a great
> vacation (without getting shocked :))!

Thank you! For now I'm not connecting power, 3h of battery left :)


Thanks,
Bernd

