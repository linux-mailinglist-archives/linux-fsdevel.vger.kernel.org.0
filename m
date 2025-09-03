Return-Path: <linux-fsdevel+bounces-60170-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DB0B425F3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 17:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E40F03B540B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 15:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6D628B4E1;
	Wed,  3 Sep 2025 15:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="a68bS0aZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WnwQ63DY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A180828725C
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 15:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756914671; cv=none; b=ZEGcrktrUH8HNIhAthIKvS1fafmlEuCn/jJJeDuI+Icgx8VN+uxuTsUN7uzdnVHalF+tJHy5TgGBKxBVFsbicwQ2BxPjM2+y9FvDjvBHE0qjkAl9v8Fu/bc226wRQtVPFMIOAwrfFcRa1uyzrwv6zl4I4vQesOH/UHBk6r6GwQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756914671; c=relaxed/simple;
	bh=APzqWH0oRevpq36H5IUkv17NFE5OjV5zZJ5LOOStAmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KLE8qqzg+EeQQazU0LRnoO58/esYtezKPRpGWFSKB6hbHO4g6jMkvH0fsssaN0xuuby+snWczPpXtyk6cEfdMCqcLwDqvrVMCHdYQShcvF432KqYgAYubr0P0f257qfVvNDhfbCpNM50K3/i7zJOxTN9kpWMpl7xdaMKNi7FHU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=a68bS0aZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WnwQ63DY; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7F4077A0463;
	Wed,  3 Sep 2025 11:51:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 03 Sep 2025 11:51:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1756914667;
	 x=1757001067; bh=zIYvK6W65QA9fNCf0hJ8sn5QkIYZbLTqZztMMovnpZ0=; b=
	a68bS0aZOqs3AHaFTbHc7TF645+KIAr4JknbvsPwDhiF+Q5VY0SiY2FZH6SyV7Lt
	jwog2ylCMyFuc9pZSiQeARuyn/Bzv+/RNmaojwoNMGl59i1Pntx4FwlY3iwErENe
	V+NrcVk30ufGu/uTsZ3TC5RAGzm+kFbZmWmxyDwbXggnwAXzF/sYgWtDkvYEMCSs
	YDQ6glqhOfabDYRgvbfhqcULBxZR50HeKzHPaqvs2Trg+RnBr37YIxShwDwZMgVV
	yqvWgeTKBJ7BC/5BYLjZkFD+e8AwK9uhCKBckuRHaKIC4puxtUO3ajlmdGPlY7aL
	SkHl9bl024Fspkr7NRoR6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756914667; x=
	1757001067; bh=zIYvK6W65QA9fNCf0hJ8sn5QkIYZbLTqZztMMovnpZ0=; b=W
	nwQ63DYnXdj8uNtTG2jDMuA7S/g/aWhm6czogmSrFERYBt92r+AHOLQlswX+Sj9w
	9En7vSuPLoefC+NjLVRI54/p/F/9o03r4f5QT39k9VerKi1F3jzX10ojVmJxlvnf
	1OT7ZFM2wz3NFOqIpmNW9Q8XfwVzSRIi7zS664C2rrUaptk3iBeNtG2ORKuMN+0r
	nAtzw9ZnzEOBRmV74irsUpxzA/b8PLFWdIr6w+P67eN8B2HT11IwbfwukjPSSvrf
	Lj16Au5h4cXcNQRmmuukzU8SXVHiSUzl86f0i9bPHX9u9F6IgKpxYoK8Hoo8JL+d
	olr0qVHkwgUnDX0Xq60fg==
X-ME-Sender: <xms:62O4aNjYdmcZ5GvPWkoHcVov_QUvBACYPRLXFIiXzfoWcYwuJhnoHg>
    <xme:62O4aKe-T1TkqbtviG9TNpAm0WcQm8C7vO89XGC8ltssyDJUHfapT_TNRxXUTRFNf
    AsxB7UO7Xl8cX1d>
X-ME-Received: <xmr:62O4aNimHwMOw7B1RmYuRt5xvuscuBgZ_42XMe2b97dkmUBFoxM30BOlFcxU670yHOVDjTkHm899k0MMIB6yeRuaEHCUmJbkQJyENO6ksVSoEAA6QiNd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeeuvghrnhguucfu
    tghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrghtth
    gvrhhnpeefgeegfeffkeduudelfeehleelhefgffehudejvdfgteevvddtfeeiheeflefg
    vdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvg
    hrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegujhifohhngheskhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepjhhorghnnhgvlhhkohhonhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhhi
    khhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopehnvggrlhesghhomhhprgdrug
    gvvhdprhgtphhtthhopehjohhhnhesghhrohhvvghsrdhnvghtpdhrtghpthhtoheplhhi
    nhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:62O4aCzp9UmeCJjx_gUHASflAXPWKIvPpvBepfuNZuaxY6D8QmmBLg>
    <xmx:62O4aJPu8RhwRWjGyaj0TzPfWYCzbBl9M51TeEII58D0f9P7t0NpFw>
    <xmx:62O4aDUd53LOJdv3Bm0ZYRwE7k9uCJX7vZQGEuJRByGLuvHx17pfHA>
    <xmx:62O4aN0RT3Le9ffGhWsmpXfF_9_WVwHtsiDEDsQUm8WdxHa_vEdYLA>
    <xmx:62O4aPHuQhpmiiMJ5pz-6IZ4jQfJzCY5hhxnBCsXZ96MbD7CBxYQ5DCu>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Sep 2025 11:51:06 -0400 (EDT)
Message-ID: <bcd6dff5-2015-4d02-a676-89e4b707cce2@bsbernd.com>
Date: Wed, 3 Sep 2025 17:51:05 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] fuse: capture the unique id of fuse commands being
 sent
To: "Darrick J. Wong" <djwong@kernel.org>,
 Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, neal@gompa.dev, John@groves.net,
 linux-fsdevel@vger.kernel.org
References: <175573708506.15537.385109193523731230.stgit@frogsfrogsfrogs>
 <175573708609.15537.12935438672031544498.stgit@frogsfrogsfrogs>
 <CAJnrk1Z_xLxDSJDcsdes+e=25ZGyKL4_No0b1fF_kUbDfB6u2w@mail.gmail.com>
 <20250826185201.GA19809@frogsfrogsfrogs>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20250826185201.GA19809@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 8/26/25 20:52, Darrick J. Wong wrote:
> On Thu, Aug 21, 2025 at 05:15:50PM -0700, Joanne Koong wrote:
>> On Wed, Aug 20, 2025 at 5:51 PM Darrick J. Wong <djwong@kernel.org> wrote:
>>>
>>> From: Darrick J. Wong <djwong@kernel.org>
>>>
>>> The fuse_request_{send,end} tracepoints capture the value of
>>> req->in.h.unique in the trace output.  It would be really nice if we
>>> could use this to match a request to its response for debugging and
>>> latency analysis, but the call to trace_fuse_request_send occurs before
>>> the unique id has been set:
>>>
>>> fuse_request_send:    connection 8388608 req 0 opcode 1 (FUSE_LOOKUP) len 107
>>> fuse_request_end:     connection 8388608 req 6 len 16 error -2
>>>
>>> Move the callsites to trace_fuse_request_send to after the unique id has
>>> been set, or right before we decide to cancel a request having not set
>>> one.
>>>
>>> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
>>> ---
>>>  fs/fuse/dev.c       |    6 +++++-
>>>  fs/fuse/dev_uring.c |    8 +++++++-
>>
>> I think we'll also need to do the equivalent for virtio.
> 
> Ackpth, virtio sends commands too??
> 
> Oh, yes, it does -- judging from the fuse_get_unique calls, at least
> virtio_fs_send_req and maybe virtio_fs_send_forget need to add a call to
> trace_fuse_request_send?
> 
>>>  2 files changed, 12 insertions(+), 2 deletions(-)
>>>
>>>
>>> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
>>> index 6f2b277973ca7d..05d6e7779387a4 100644
>>> --- a/fs/fuse/dev.c
>>> +++ b/fs/fuse/dev.c
>>> @@ -376,10 +376,15 @@ static void fuse_dev_queue_req(struct fuse_iqueue *fiq, struct fuse_req *req)
>>>         if (fiq->connected) {
>>>                 if (req->in.h.opcode != FUSE_NOTIFY_REPLY)
>>>                         req->in.h.unique = fuse_get_unique_locked(fiq);
>>> +
>>> +               /* tracepoint captures in.h.unique */
>>> +               trace_fuse_request_send(req);
>>> +
>>>                 list_add_tail(&req->list, &fiq->pending);
>>>                 fuse_dev_wake_and_unlock(fiq);
>>>         } else {
>>>                 spin_unlock(&fiq->lock);
>>> +               trace_fuse_request_send(req);
>>
>> Should this request still show up in the trace even though the request
>> doesn't actually get sent to the server? imo that makes it
>> misleading/confusing unless the trace also indicates -ENOTCONN.
> 
> Hrmm.  I was thinking that it would be very nice to have
> fuse_request_{send,end} bracket the start and end of a fuse request,
> even if we kill it immediately.
> 
> OTOH from a tracing "efficiency" perspective it's probably ok for
> never-sent requests only to ever hit the fuse_request_end tracepoint
> since the id will not get reused for quite some time.
> 
> <shrug> Thoughts?
> 
> --D
> 
>>>                 req->out.h.error = -ENOTCONN;
>>>                 clear_bit(FR_PENDING, &req->flags);
>>>                 fuse_request_end(req);
>>> @@ -398,7 +403,6 @@ static void fuse_send_one(struct fuse_iqueue *fiq, struct fuse_req *req)
>>>         req->in.h.len = sizeof(struct fuse_in_header) +
>>>                 fuse_len_args(req->args->in_numargs,
>>>                               (struct fuse_arg *) req->args->in_args);
>>> -       trace_fuse_request_send(req);
>>>         fiq->ops->send_req(fiq, req);
>>>  }
>>>
>>> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
>>> index 249b210becb1cc..14f263d4419392 100644
>>> --- a/fs/fuse/dev_uring.c
>>> +++ b/fs/fuse/dev_uring.c
>>> @@ -7,6 +7,7 @@
>>>  #include "fuse_i.h"
>>>  #include "dev_uring_i.h"
>>>  #include "fuse_dev_i.h"
>>> +#include "fuse_trace.h"
>>>
>>>  #include <linux/fs.h>
>>>  #include <linux/io_uring/cmd.h>
>>> @@ -1265,12 +1266,17 @@ void fuse_uring_queue_fuse_req(struct fuse_iqueue *fiq, struct fuse_req *req)
>>>
>>>         err = -EINVAL;
>>>         queue = fuse_uring_task_to_queue(ring);
>>> -       if (!queue)
>>> +       if (!queue) {
>>> +               trace_fuse_request_send(req);
>>
>> Same question here.
>>
>> Thanks,
>> Joanne
>>


I really need to find time to update my related branch - as I wrote
before, I already have all of that, I think.


Thanks,
Bernd

