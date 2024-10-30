Return-Path: <linux-fsdevel+bounces-33278-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 842A99B6B55
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 18:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A76D81C232CF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 17:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BFD199FA0;
	Wed, 30 Oct 2024 17:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="ee5kMVeU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kPMQDEyr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723C31BD9D9
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Oct 2024 17:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730310650; cv=none; b=jEKGlgKqsV26l9+TGjlgpnE+Ly/VjIWGMuyVoTrGUpTmABPeDnHrNBBpS+7VnV+xfY8h54tVV7AWy3NqTsFpH5QBzcwHPjViobQqf0z6uRwVoyS7N8OxJ3G8fECWPyr/j0hBOf7NzT1hVzGhXhLCniyK2fwk4ND74T+sDVERTyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730310650; c=relaxed/simple;
	bh=6ZmA4Ppv/xrO7/ePtCukYvRWTyfBGJ04bG5VLxrNwKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nr0bwL3c5qOVjPExhGdwNbLzhpkREoGS7XJiUtyjMA40Me06+3B3VKVZvpm//5pbYPYO2CbSnu2wy5/uRqLZlfhJcRF5Vh1oE+5FkEuquCFQUEaBJLURYrmexxnoQXfuIDdx7uvtRo8/xGYdghW0GEoUrvCcJUgg9YUdb3OKWbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=ee5kMVeU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kPMQDEyr; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 774A92540106;
	Wed, 30 Oct 2024 13:50:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 30 Oct 2024 13:50:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1730310646;
	 x=1730397046; bh=GyIajqQ6eWLz9sZT4IGRowRDoTWkqpFwP0xy5ABre+g=; b=
	ee5kMVeUhAantSAjwtcAfZD8gwcVzil54C8rkTS9NBR7CzAl5UUpiSK+ouNuv4Bw
	3rJb0vz3g/BaKXvGONWK2FBg6Aoe+hZxW83FVk2xqWkWu8WyzRNtQdM7geujqgxb
	evwKp77oMec3ySl43gk/DE3UlZcmZglGbo4RIjoxBJyHqqMjVs4ISvWG2wl1goON
	vDilvwx4wUsDC2G0V761i6ex+b5ibdXAbftHCzumHf+Dynt8JAs/cFrPI9K6vJ/c
	XXOO/Oaf5gzH9iHB8wg8JOW9yq8fzuv4L+DNY+/m8uFClhmcFKenRXTC4kjSTskF
	cFEfS6GjZH2etTLjWWN2ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730310646; x=
	1730397046; bh=GyIajqQ6eWLz9sZT4IGRowRDoTWkqpFwP0xy5ABre+g=; b=k
	PMQDEyrjAp87dJQrAbM0HGJ/2NTwPaHZFsjXVnrOFVg0HpY740u5kLgqBorXkpp7
	0uQwgl07thNCOvaUTZ1k/Id7ZmRm7uh4iR3H6NIGW0v+VHvTFP23kXTswLwb5ljb
	J2B6frzqJ+PIx2a+sZT3Mew78HTPloDVxrYNkUV28Q9ah117nab3QOIZiTHucV3k
	OMZoPGbw1xSi5qRVnD/OOZK7HS7R0PIiW6MrQonglz2WWEer0J9FEAsXHlzNOJQp
	XwNAJF3VwE1alNJHkk1ASfsN3k0fbfw/rNsZI4KFjuw5wOLoJN+0OujyTejhz0lW
	e7UmqmZ2lujQ1ZsxKWs6A==
X-ME-Sender: <xms:9XEiZwfqKhvQ3Wwb4kPtGEwIIx3yf0qr-rocEC9NtfHEY4BsqXIheQ>
    <xme:9XEiZyML8jeA9gEE3VIAHaQRZtMH_148KA938jM00l7ms3mRU8JlXKNAkgAhfXB7l
    OoCysN0tDSY2ts4>
X-ME-Received: <xmr:9XEiZxiItN0cYTeZvVFMyGIosnGE7ahXh_xOz2CGzt35i7r5yhN4zPkOp0Gj3RWjL5lYyDAMoxKA5-NMN9aAE1vQ0rxQ_wZ-gKrbOpuVbJDMnQGRNrbb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekfedguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddv
    jeenucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusg
    gvrhhtsehfrghsthhmrghilhdrfhhmqeenucggtffrrghtthgvrhhnpeevgfeukedtfeeu
    gfekueeikeeileejheffjeehleduieefteeufefhteeuhefhfeenucffohhmrghinhepkh
    gvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdrfhhmpdhnsg
    gprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjohgrnhhn
    vghlkhhoohhnghesghhmrghilhdrtghomhdprhgtphhtthhopehmihhklhhoshesshiivg
    hrvgguihdrhhhupdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehjohhsvghfsehtohigihgtphgrnhgurgdrtg
    homhdprhgtphhtthhopehjvghffhhlvgiguheslhhinhhugidrrghlihgsrggsrgdrtgho
    mhdprhgtphhtthhopehlrghorghrrdhshhgrohesghhmrghilhdrtghomhdprhgtphhtth
    hopehkvghrnhgvlhdqthgvrghmsehmvghtrgdrtghomh
X-ME-Proxy: <xmx:9XEiZ1_uJiNvlISET1n9Vlp7sEDhibZnJFhADT4SWLP1pTnAKW-acQ>
    <xmx:9XEiZ8uclE_8VjXJ6x__PAdgIwkF_gC9l67Ug8p8xPQZFmUFO3zrvA>
    <xmx:9XEiZ8HAL31ov7Yg2tARMSruXd_6XHhwHzrsgYKDP7WK4PusDpokJA>
    <xmx:9XEiZ7MJDLcFww816ZRQUds_-tu313ZsWPFtweIMbXbLSDM24K8SUA>
    <xmx:9nEiZx-k0DbciaTiXKPEILhV2Yz5Q-iK6dDp_P276cDrI0bYFvxbpiLU>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Oct 2024 13:50:44 -0400 (EDT)
Message-ID: <1de1227f-0f81-44bf-b42a-044ed47d44a5@fastmail.fm>
Date: Wed, 30 Oct 2024 18:50:43 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/3] fuse: add optional kernel-enforced timeout for
 requests
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com,
 jefflexu@linux.alibaba.com, laoar.shao@gmail.com, kernel-team@meta.com
References: <20241011191320.91592-1-joannelkoong@gmail.com>
 <20241011191320.91592-3-joannelkoong@gmail.com>
 <9ba4eaf4-b9f0-483f-90e5-9512aded419e@fastmail.fm>
 <CAJnrk1b7N3uPueBbZJ1E8qVj1pQh-Bu4V-rYJAGmR0JtzbEPKg@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJnrk1b7N3uPueBbZJ1E8qVj1pQh-Bu4V-rYJAGmR0JtzbEPKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/30/24 18:21, Joanne Koong wrote:
> On Tue, Oct 29, 2024 at 12:17 PM Bernd Schubert
> <bernd.schubert@fastmail.fm> wrote:
>>
>>
>>
>> On 10/11/24 21:13, Joanne Koong wrote:
>>> There are situations where fuse servers can become unresponsive or
>>> stuck, for example if the server is deadlocked. Currently, there's no
>>> good way to detect if a server is stuck and needs to be killed manually.
>>>
>>> This commit adds an option for enforcing a timeout (in minutes) for
>>> requests where if the timeout elapses without the server responding to
>>> the request, the connection will be automatically aborted.
>>>
>>> Please note that these timeouts are not 100% precise. The request may
>>> take an extra FUSE_TIMEOUT_TIMER_FREQ seconds beyond the requested max
>>> timeout due to how it's internally implemented.
>>>
>>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>>> ---
>>>  fs/fuse/dev.c    | 80 ++++++++++++++++++++++++++++++++++++++++++++++++
>>>  fs/fuse/fuse_i.h | 21 +++++++++++++
>>>  fs/fuse/inode.c  | 21 +++++++++++++
>>>  3 files changed, 122 insertions(+)
>>>
>>> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
>>> index 1f64ae6d7a69..054bfa2a26ed 100644
>>> --- a/fs/fuse/dev.c
>>> +++ b/fs/fuse/dev.c
>>> @@ -45,6 +45,82 @@ static struct fuse_dev *fuse_get_dev(struct file *file)
>>>       return READ_ONCE(file->private_data);
>>>  }
>>>
>>> +static bool request_expired(struct fuse_conn *fc, struct fuse_req *req)
>>> +{
>>> +     return jiffies > req->create_time + fc->timeout.req_timeout;
>>> +}
>>> +
>>> +/*
>>> + * Check if any requests aren't being completed by the specified request
>>> + * timeout. To do so, we:
>>> + * - check the fiq pending list
>>> + * - check the bg queue
>>> + * - check the fpq io and processing lists
>>> + *
>>> + * To make this fast, we only check against the head request on each list since
>>> + * these are generally queued in order of creation time (eg newer requests get
>>> + * queued to the tail). We might miss a few edge cases (eg requests transitioning
>>> + * between lists, re-sent requests at the head of the pending list having a
>>> + * later creation time than other requests on that list, etc.) but that is fine
>>> + * since if the request never gets fulfilled, it will eventually be caught.
>>> + */
>>> +void fuse_check_timeout(struct timer_list *timer)
>>> +{
>>> +     struct fuse_conn *fc = container_of(timer, struct fuse_conn, timeout.timer);
>>> +     struct fuse_iqueue *fiq = &fc->iq;
>>> +     struct fuse_req *req;
>>> +     struct fuse_dev *fud;
>>> +     struct fuse_pqueue *fpq;
>>> +     bool expired = false;
>>> +     int i;
>>> +
>>> +     spin_lock(&fiq->lock);
>>> +     req = list_first_entry_or_null(&fiq->pending, struct fuse_req, list);
>>> +     if (req)
>>> +             expired = request_expired(fc, req);
>>> +     spin_unlock(&fiq->lock);
>>> +     if (expired)
>>> +             goto abort_conn;
>>> +
>>> +     spin_lock(&fc->bg_lock);
>>> +     req = list_first_entry_or_null(&fc->bg_queue, struct fuse_req, list);
>>> +     if (req)
>>> +             expired = request_expired(fc, req);
>>> +     spin_unlock(&fc->bg_lock);
>>> +     if (expired)
>>> +             goto abort_conn;
>>> +
>>> +     spin_lock(&fc->lock);
>>> +     if (!fc->connected) {
>>> +             spin_unlock(&fc->lock);
>>> +             return;
>>> +     }
>>> +     list_for_each_entry(fud, &fc->devices, entry) {
>>> +             fpq = &fud->pq;
>>> +             spin_lock(&fpq->lock);
>>> +             req = list_first_entry_or_null(&fpq->io, struct fuse_req, list);
>>> +             if (req && request_expired(fc, req))
>>> +                     goto fpq_abort;
>>> +
>>> +             for (i = 0; i < FUSE_PQ_HASH_SIZE; i++) {
>>> +                     req = list_first_entry_or_null(&fpq->processing[i], struct fuse_req, list);
>>> +                     if (req && request_expired(fc, req))
>>> +                             goto fpq_abort;
>>> +             }
>>> +             spin_unlock(&fpq->lock);
>>> +     }
>>> +     spin_unlock(&fc->lock);
>>
>> I really don't have a strong opinion on that - I wonder if it wouldn't
>> be better for this part to have an extra timeout list per fud or pq as
>> previously. That would slightly increases memory usage and overhead per
>> request as a second list is needed, but would reduce these 1/min cpu
>> spikes as only one list per fud would need to be checked. But then, it
>> would be easy to change that later, if timeout checks turn out to be a
>> problem.
>>
> 
> Thanks for the review.
> 
> On v7 [1] which used an extra timeout list, the feedback was
> 
> "One thing I worry about is adding more roadblocks on the way to making
> request queuing more scalable.
> 
> Currently there's fc->num_waiting that's touched on all requests and
> bg_queue/bg_lock that are touched on background requests.  We should
> be trying to fix these bottlenecks instead of adding more.
> 
> Can't we use the existing lists to scan requests?
> 
> It's more complex, obviously, but at least it doesn't introduce yet
> another per-fc list to worry about."
> 
> 
> [1] https://lore.kernel.org/linux-fsdevel/CAJfpegs9A7iBbZpPMF-WuR48Ho_=z_ZWfjrLQG2ob0k6NbcaUg@mail.gmail.com/


Yeah I know, but I'm just a bit scared about the cpu spikes this gives
on a recent systems (like 96 cores AMDs we have in the lab) and when
device clone is activated (and Miklos had also asked to use the same 
hash lists to find requests with fuse-uring). 
The previous discussion was mainly about avoiding a new global lock,
i.e. I wonder if can't use a mix - avoid the new list and its lock,
but still avoid scanning through [FUSE_PQ_HASH_SIZE] lists per
cloned-device/core.

I'm also not opposed against the current version and optimize it later.

Thanks,
Bernd

