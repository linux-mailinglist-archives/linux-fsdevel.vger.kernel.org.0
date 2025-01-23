Return-Path: <linux-fsdevel+bounces-39994-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C8EA1A9BC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 19:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 720CE3AD8BC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 18:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD89715B0F2;
	Thu, 23 Jan 2025 18:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="hkTZ37wq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qt7s2usi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8B9155742
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 18:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737657646; cv=none; b=qXstkt3JXCeFaFFraaMvHgNXm3q7RD9yn82gXZmz78TclFXk7uQFN4Sllfi9QYZy4NN4cBBd+j0bCs/BW0lfWcSvRGstiOUqV7U5k3dXHYRN+bODZ2lhnJ/m9bSCAaXrMPu/POnGtnk4GpotB2La0TnpLF4pr3UeQBrmRzk71IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737657646; c=relaxed/simple;
	bh=HlVIxAGEJpqZwWhIc5XhJsfXic4GVQcrpZUgX4+fJ2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ShGP6dkfkK/kI3+MN7ZkGL4n7l3miz71lKWYwFY+lf70YHsylZQgi1W0IUHbkOCOqToTQFAEPIaWRgYr0vVWUVu9jRMSy2GW7n6otOHYnMe2iKCJDN8WDKrkAJ7NfdTgR8HxlFpa2zyn70cS/Nbqb8EoRbteYkUnqXh2gLObnLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=hkTZ37wq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qt7s2usi; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4D2CB25400DA;
	Thu, 23 Jan 2025 13:40:42 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 23 Jan 2025 13:40:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1737657642;
	 x=1737744042; bh=CKB/k5pxBz2Zg71jcC49yY3s2w2N/Bk/2Yh9FM5XEUI=; b=
	hkTZ37wql+/bGPRve3zRwu+eUjsRikHBzVP78UjO/HLcW8AOLlLkZGtnFFeCW91/
	6SdeMEhU8DthUD00tFq6ZQrtYg+yrjMjr1rKq/EiP5dJpo36VFHvCCJ1nSWxsgpF
	osIh+lJ8UVXV5z4mP4MTw6YpAsMWuBztKgJEDIKH70j8sY2kp5EQUvLLSQocNmOW
	/2tdIylD1p43O+DczcXLBSAE6BWroyQt8NU1Fark6ivyDDImjqjRC3OAj8IiJmc4
	9WCx5Zmj60ee8N09d+gEUEqaamSwGvxV03tPlrUQyO6OVWhng2C+iU+UA1BRBQZI
	Newfj4k7T/Glrod8YKU2NA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1737657642; x=
	1737744042; bh=CKB/k5pxBz2Zg71jcC49yY3s2w2N/Bk/2Yh9FM5XEUI=; b=Q
	t7s2usij26woI97pMIEyYMM4WDBDIRI5825QTZR9JLjFe+zrrcztEV/o4lKy9QHy
	Dzzcdki13WVToIx+99RjBzLRKn5UxKE9qgsOzKJgSr4erahV69/ZRYcXTu4xXd/n
	YTqBhB7NbXsayAgQcx/E59GPgqtpXr/WIjJM0/rgdMV09q0c4YjZjhl4Xpi+P4lK
	BbMKeHGU4+ePo9pSckNoW/zG0tuZgbSgho1XhnWW5VabmKXjMlkosUOGm9AnMVAp
	0XCyPYaLP2RBzxmyY8w6wsyyVwWm0wXpIYCbnOHtYJ7Uh3ExgVYuKQfdTjy2I/7p
	06W8lx1xwM7eOB99TzRsA==
X-ME-Sender: <xms:KY2SZ_VL6mA1dmrDYX_2xrT5SHlCtsJBFAAXXYFJ0TJiOGvV2nYo0Q>
    <xme:KY2SZ3mR0ofuBYG1GwGp1BCbH4S0CUCx1bn9IOK2st-CyIQ3MD5eNF-ghl_PFvr0m
    eKIdc4CLTJU6EBn>
X-ME-Received: <xmr:KY2SZ7b-RgQOBXemJGce5ssE2-a_heKSPx79WtNynNFpZ0hr6N2oEA7xeV7LAQHXOco9XSjRTdbew3nCkmE0L6r6j8NWj9CUSD8swXTjGRTJYceUE7kS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgvdegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddv
    jeenucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusg
    gvrhhtsehfrghsthhmrghilhdrfhhmqeenucggtffrrghtthgvrhhnpeduleefvdduvedu
    veelgeelffffkedukeegveelgfekleeuvdehkeehheehkefhfeenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghr
    thesfhgrshhtmhgrihhlrdhfmhdpnhgspghrtghpthhtohepudegpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehjohgrnhhnvghlkhhoohhnghesghhmrghilhdrtghomhdp
    rhgtphhtthhopegsshgthhhusggvrhhtseguughnrdgtohhmpdhrtghpthhtohepmhhikh
    hlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghl
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhgvfhhflhgvgihusehlih
    hnuhigrdgrlhhisggrsggrrdgtohhmpdhrtghpthhtoheplhgrohgrrhdrshhhrghosehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepshgvnhhoiihhrghtshhkhiestghhrhhomhhiuhhmrdhorhhgpdhrtghp
    thhtohepthhfihhgrgestghhrhhomhhiuhhmrdhorhhg
X-ME-Proxy: <xmx:KY2SZ6VjvYOjiRv1OPFChCZXTWx1-YyM4zBlAN5IRQtyGHhhjX7KWw>
    <xmx:KY2SZ5lviW10fRVynSjhgjGLwRw8RTf5Bqn7MSMDZS_VGBVAgQp0mA>
    <xmx:KY2SZ3eWui0o9RpOc0htHRyyZXl_ahabgvjhMymSdcHclCz9ia_Qug>
    <xmx:KY2SZzGM8nWOpx8BPkuDxGug-gk1uo2G98b3VOMqv_KrMM2_3z6ylw>
    <xmx:Ko2SZ-_YC1Gye92VJQycIXeHuro-byBZVT8yH4FQrH1nz7e0K1bmEsQv>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Jan 2025 13:40:39 -0500 (EST)
Message-ID: <b24caa0a-d431-4254-80ab-672c1e014bd3@fastmail.fm>
Date: Thu, 23 Jan 2025 19:40:38 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 2/2] fuse: add default_request_timeout and
 max_request_timeout sysctls
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Bernd Schubert <bschubert@ddn.com>, Miklos Szeredi <miklos@szeredi.hu>,
 linux-fsdevel@vger.kernel.org, jefflexu@linux.alibaba.com,
 laoar.shao@gmail.com, jlayton@kernel.org, senozhatsky@chromium.org,
 tfiga@chromium.org, bgeffon@google.com, etmartin4313@gmail.com,
 kernel-team@meta.com, Josef Bacik <josef@toxicpanda.com>,
 Luis Henriques <luis@igalia.com>
References: <20250122215528.1270478-1-joannelkoong@gmail.com>
 <20250122215528.1270478-3-joannelkoong@gmail.com> <87ikq5x4ws.fsf@igalia.com>
 <CAJfpegtNrTrGUNrEKrcxEc-ecybetAqQ9fF60bCf7-==9n_1dg@mail.gmail.com>
 <9248bca5-9b16-4b5c-b1b2-b88325429bbe@ddn.com>
 <CAJnrk1bbvfxhYmtxYr58eSQpxR-fsQ0O8BBohskKwCiZSN4XWg@mail.gmail.com>
 <4f642283-d529-4e5f-b0ba-190aa9bf888c@fastmail.fm>
 <CAJnrk1YDFcF5GPR23GPuWnxt2WeGzf8_bc4cJG8Z-DHvbRNkFA@mail.gmail.com>
 <325b214c-4c7b-4826-a1b9-382f5a988286@fastmail.fm>
 <CAJnrk1YGK7Oe5Hbz3ci_-mgVUR761MJfg7qQoWCNGxmbTH4ESg@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJnrk1YGK7Oe5Hbz3ci_-mgVUR761MJfg7qQoWCNGxmbTH4ESg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/23/25 19:32, Joanne Koong wrote:
> On Thu, Jan 23, 2025 at 10:06 AM Bernd Schubert
> <bernd.schubert@fastmail.fm> wrote:
>>
>>
>>
>> On 1/23/25 18:48, Joanne Koong wrote:
>>> On Thu, Jan 23, 2025 at 9:19 AM Bernd Schubert
>>> <bernd.schubert@fastmail.fm> wrote:
>>>>
>>>> Hi Joanne,
>>>>
>>>>>>> Thanks, applied and pushed with some cleanups including Luis's clamp idea.
>>>>>>
>>>>>> Hi Miklos,
>>>>>>
>>>>>> I don't think the timeouts do work with io-uring yet, I'm not sure
>>>>>> yet if I have time to work on that today or tomorrow (on something
>>>>>> else right now, I can try, but no promises).
>>>>>
>>>>> Hi Bernd,
>>>>>
>>>>> What are your thoughts on what is missing on the io-uring side for
>>>>> timeouts? If a request times out, it will abort the connection and
>>>>> AFAICT, the abort logic should already be fine for io-uring, as users
>>>>> can currently abort the connection through the sysfs interface and
>>>>> there's no internal difference in aborting through sysfs vs timeouts.
>>>>>
>>>>
>>>> in fuse_check_timeout() it iterates over each fud and then fpq.
>>>> In dev_uring.c fpq is is per queue but unrelated to fud. In current
>>>> fuse-io-uring fud is not cloned anymore - using fud won't work.
>>>> And Requests are also not queued at all on the other list
>>>> fuse_check_timeout() is currently checking.
>>>
>>> In the io-uring case, there still can be fuds and their associated
>>> fpqs given that /dev/fuse can be used still, no? So wouldn't the
>>> io-uring case still need this logic in fuse_check_timeout() for
>>> checking requests going through /dev/fuse?
>>
>> Yes, these need to be additionally checked.
>>
>>>
>>>>
>>>> Also, with a ring per core, maybe better to use
>>>> a per queue check that is core bound? I.e. zero locking overhead?
>>>
>>> How do you envision a queue check that bypasses grabbing the
>>> queue->lock? The timeout handler could be triggered on any core, so
>>> I'm not seeing how it could be core bound.
>>
>> I don't want to bypass it, but maybe each queue could have its own
>> workq and timeout checker? And then use queue_delayed_work_on()?
>>
>>
>>>
>>>> And I think we can also avoid iterating over hash lists (queue->fpq),
>>>> but can use the 'ent_in_userspace' list.
>>>>
>>>> We need to iterate over these other entry queues anyway:
>>>>
>>>> ent_w_req_queue
>>>> fuse_req_bg_queue
>>>> ent_commit_queue
>>>>
>>>
>>> Why do we need to iterate through the ent lists (ent_w_req_queue and
>>> ent_commit_queue)? AFAICT, in io-uring a request is either on the
>>> fuse_req_queue/fuse_req_bg_queue or on the fpq->processing list. Even
>>> when an entry has been queued to ent_w_req_queue or ent_commit_queue,
>>> the request itself is still queued on
>>> fuse_req_queue/fuse_req_bg_queue/fpq->processing. I'm not sure I
>>> understand why we still need to look at the ent lists?
>>
>> Yeah you are right, we could avoid ent_w_req_queue and ent_commit_queue
>> if we use fpq->processing, but processing consists of 256 lists -
>> overhead is much smaller by using the entry lists?
>>
>>
>>>
>>>>
>>>> And we also need to iterate over
>>>>
>>>> fuse_req_queue
>>>> fuse_req_bg_queue
>>>
>>> Why do we need to iterate through fuse_req_queue and
>>> fuse_req_bg_queue? fuse_uring_request_expired() checks the head of
>>> fuse_req_queue and fuse_req_bg_queue and given that requests are added
>>> to fuse_req_queue/fuse_req_bg_queue sequentially (eg added to the tail
>>> of these lists), why isn't this enough?
>>
>> I admit I'm a bit lost with that question. Aren't you pointing out
>> the same lists as I do?
>>
> 
> Oh, I thought your comment was saying that we need to "iterate" over
> it (eg go through every request on the lists)? It currently already
> checks the fuse_req_queue and fuse_req_bg_queue lists (in
> fuse_uring_request_expired() which gets invoked in the
> fuse_check_timeout() timeout handler).
> 
> Maybe the  fuse_uring_request_expired() addition got missed - I tried
> to call this out in the cover letter changelog, as I had to rebase
> this patchset on top of the io-uring patches, so I added this function
> in to make it work for io-uring. I believe this suffices for now for
> the io uring case (with future optimizations that can be added)?


Ah sorry, that is me, I had missed you had already rebased it to
io-uring.

So we are good to land this version. 
Just would be good if we could optimize this soon - our test systems
have 96 cores - 24576 list heads to check... I won't manage to work
on it today and probably also not tomorrow, but by Monday I should
have an optimized version ready.

Thanks,
Bernd


