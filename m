Return-Path: <linux-fsdevel+bounces-30301-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C811988E97
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Sep 2024 10:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EDA01F212EF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Sep 2024 08:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416A719DFBB;
	Sat, 28 Sep 2024 08:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="odE65yVa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JwXyKN3a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A9F15A8
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Sep 2024 08:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727512995; cv=none; b=Fr5wjL0SNCSb2R6NJnqcqxxa+lMb7V89L4an8iPUy1Wq1odGxBfhRIHfjEdisPQp61ixTG0wUISBjTXWfOi2DQ7WEd369h9j2mxY1mtSLfPaTOmhnVGLjy2Sjca6ygGh9A5VCKiQkXXLrZTLpcmHDW9VKcYtXQDEZYhb4a6guXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727512995; c=relaxed/simple;
	bh=GBwUceAR5uCrw6WouZelGW/JQJrjuO0LaKKxgINviN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HfRACFFb33x/tiDuySfDB5qyamaygg0f6CdePwCS5QmJAz6bXAwPTVBfkBw+tSuarjRB5ZCS2kIWhEZ2F2NgsPxiGMLJ+Ls5nwzdVesGTAsDYnxnFf16EVKr16F7ZanlkkrgDlWpjiAqWxPQlgTTtffuGsM0OSo2toe7bARwKBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=odE65yVa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JwXyKN3a; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9A1F1114023A;
	Sat, 28 Sep 2024 04:43:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Sat, 28 Sep 2024 04:43:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1727512991;
	 x=1727599391; bh=qJ8gYURxf+mVDCbtYkN8V33A7kwZaZQmELzbCC4/qq8=; b=
	odE65yVaHkk64nvx25Wm+TYaCfrJGGPtOSHuvyNWFi27c9v64w1A1k/u/hRVwtJw
	MJce13pjT+Oo0WOZbnlFHpxt0HMvfArDV+quona+0PSLK1/QQ87zX62yfx9bvUDr
	COwUBHRwV/MQj+mSLFUc2bmkZBkSWHFoexF5ZWY03mcjc8JAaWH2I5snAFnSFmz1
	+Hcsfx9S0sruJSPwxVA+Dc6U5Z+0MLtauK6Z7Sx9Mhw1gd5VtYXMUYC1jJBHK5ku
	vknmodYMDUY6yBQI6HTYv1PO6YAeyI5ZwEh9xPo+j8brvws1au49VSI4Co92m8wh
	Pgnv2SbN8Jni2q07/5brqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727512991; x=
	1727599391; bh=qJ8gYURxf+mVDCbtYkN8V33A7kwZaZQmELzbCC4/qq8=; b=J
	wXyKN3aqluZCy7YG/Dfhs4Wi7O007kutg9KhU1c+ZTHCoJU/k1NepaWmTTn5Asjy
	WrgsfmyC+2aJjAC8/RKNOaKkec3R8XZCpwgn+FiZPjHJKwiJwS+NOnkuV688LwYt
	U2oDikHmFZCiDCILuK5F7C99OLHmsBY9QJ2QhEz1nxKMPZyl/vStUEpdRkFYO8t2
	joBfLu8WSdnk/sgxZxvWu5J0n4BWRI8irnSQThHUAY+2jXlkO0XiOV9XbZ5zGLQJ
	7YJQhetrNlx8CJpNRZAX+UIiAZEvKRGwWDGoDcGr4zspQpUDNONnbK0IJJxsBbid
	FiXT0xdPow8Lxp3712fZg==
X-ME-Sender: <xms:nsH3ZjpLmF8Dg_T8l1bf3XtlVlZ2bFTcJ4m_CZasPqTvecZDVsJqGw>
    <xme:nsH3Zto_3HTmMwNAh54-B2kgrnEYlU591btasddnIqtgi5I2Xbr924nHF-zDAP7V2
    bFtu9gSxoYH_KQa>
X-ME-Received: <xmr:nsH3ZgNkfYOYhS22T4qgCPV88OUtPjrNpATm59USE_OJAA24dhjF2C5abf7zVqupExqXtRQzUj8jdNHlhCpaGc-F75Q1bxnp5nCBXYD5JML2dnlrNrg_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddutddgudeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddv
    jeenucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusg
    gvrhhtsehfrghsthhmrghilhdrfhhmqeenucggtffrrghtthgvrhhnpeduleefvdduvedu
    veelgeelffffkedukeegveelgfekleeuvdehkeehheehkefhfeenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghr
    thesfhgrshhtmhgrihhlrdhfmhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepjhhorghnnhgvlhhkohhonhhgsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopehlihhnuh
    igqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhho
    shgvfhesthhogihitghprghnuggrrdgtohhmpdhrtghpthhtohepjhgvfhhflhgvgihuse
    hlihhnuhigrdgrlhhisggrsggrrdgtohhmpdhrtghpthhtoheplhgrohgrrhdrshhhrgho
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgvrhhnvghlqdhtvggrmhesmhgvthgrrd
    gtohhm
X-ME-Proxy: <xmx:nsH3Zm6z5bWgYXyDZnBFfWgLLkQOe2NgxRCnWE5BZCDYZWA7IEPAYw>
    <xmx:nsH3Zi7-rdu64RwgkCy7hB0gP-ewzwXYsPboGxEainMTwkFJttAc-Q>
    <xmx:nsH3ZugpwZI6jJdgTjTJWy63qBdb1hG4Dh17pWwO3V3zK16JsCdAmg>
    <xmx:nsH3Zk7ZYkzdfhnwqWPMheO4dnxK78fUBCNp-nFvDfVEzKyDdeaTMw>
    <xmx:n8H3ZpZ0nQWZppDvFjyPFci4aRDvotAnMkK0PVxWWcW58qIlRIzHDBVM>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 28 Sep 2024 04:43:09 -0400 (EDT)
Message-ID: <7d609efd-9e0e-45b1-8793-872161a24318@fastmail.fm>
Date: Sat, 28 Sep 2024 10:43:08 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] fuse: add optional kernel-enforced timeout for
 requests
To: Joanne Koong <joannelkoong@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, josef@toxicpanda.com,
 jefflexu@linux.alibaba.com, laoar.shao@gmail.com, kernel-team@meta.com
References: <20240830162649.3849586-1-joannelkoong@gmail.com>
 <20240830162649.3849586-2-joannelkoong@gmail.com>
 <CAJfpegug0MeX7HYDkAGC6fn9HaMtsWf2h3OyuepVQar7E5y0tw@mail.gmail.com>
 <CAJnrk1bdyDq+4jo29ZbyjdcbFiU2qyCGGbYbqQc_G23+B_Xe_Q@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJnrk1bdyDq+4jo29ZbyjdcbFiU2qyCGGbYbqQc_G23+B_Xe_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Joanne,

On 9/27/24 21:36, Joanne Koong wrote:
> On Mon, Sep 2, 2024 at 3:38 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>>
>> On Fri, 30 Aug 2024 at 18:27, Joanne Koong <joannelkoong@gmail.com> wrote:
>>>
>>> There are situations where fuse servers can become unresponsive or
>>> stuck, for example if the server is in a deadlock. Currently, there's
>>> no good way to detect if a server is stuck and needs to be killed
>>> manually.
>>>
>>> This commit adds an option for enforcing a timeout (in seconds) on
>>> requests where if the timeout elapses without a reply from the server,
>>> the connection will be automatically aborted.
>>
>> Okay.
>>
>> I'm not sure what the overhead (scheduling and memory) of timers, but
>> starting one for each request seems excessive.
> 
> I ran some benchmarks on this using the passthrough_ll server and saw
> roughly a 1.5% drop in throughput (from ~775 MiB/s to ~765 MiB/s):
> fio --name randwrite --ioengine=sync --thread --invalidate=1
> --runtime=300 --ramp_time=10 --rw=randwrite --size=1G --numjobs=4
> --bs=4k --alloc-size 98304 --allrandrepeat=1 --randseed=12345
> --group_reporting=1 --directory=/root/fuse_mount
> 
> Instead of attaching a timer to each request, I think we can instead
> do the following:
> * add a "start_time" field to each request tracking (in jiffies) when
> the request was started
> * add a new list to the connection that all requests get enqueued
> onto. When the request is completed, it gets dequeued from this list
> * have a timer for the connection that fires off every 10 seconds or
> so. When this timer is fired, it checks if "jiffies > req->start_time
> + fc->req_timeout" against the head of the list to check if the
> timeout has expired and we need to abort the request. We only need to
> check against the head of the list because we know every other request
> after this was started later in time. I think we could even just use
> the fc->lock for this instead of needing a separate lock. In the worst
> case, this grants a 10 second upper bound on the timeout a user
> requests (eg if the user requests 2 minutes, in the worst case the
> timeout would trigger at 2 minutes and 10 seconds).
> 
> Also, now that we're aborting the connection entirely on a timeout
> instead of just aborting the request, maybe it makes sense to change
> the timeout granularity to minutes instead of seconds. I'm envisioning
> that this timeout mechanism will mostly be used as a safeguard against
> malicious or buggy servers with a high timeout configured (eg 10
> minutes), and minutes seems like a nicer interface for users than them
> having to convert that to seconds.
> 
> Let me know if I've missed anything with this approach but if not,
> then I'll submit v7 with this change.


sounds great to me. Just, could we do this per fuse_dev to avoid a
single lock for all cores?


Thanks,
Bernd

