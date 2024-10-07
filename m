Return-Path: <linux-fsdevel+bounces-31253-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9756D9937D8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 22:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE56FB22061
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 20:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215671DE3C9;
	Mon,  7 Oct 2024 20:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="RwK0CvTp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XiXOfhne"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE8D1DE3A0
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Oct 2024 20:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728331329; cv=none; b=MbfZCB3wYeWr3pX0luyapmNEH/exTcAf54dmzOIW220Z8ZqUnD0/q9JONatzuc/dpfih2RVNbByRHeKYRYLTCWPY0kQs3MCdGwh27EueUsNSqqofR/g6lgcNQ63mSZe3zytk9bjLe2mMnqq5zeeDax1ghW1FGN+0KrHxNzMX9Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728331329; c=relaxed/simple;
	bh=H4TyWasyzQsEqdtDAdYGrZ/SXhutcBkv+0asTFevxCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t+d635Y7qvH44NuvcBPaXQWgu990tHmE4unUjdK+kaubye4e0aaps3yRr2PQepcQiTLz/2PhlHPVNdhmAlkVB/J7vCrh1ZDrfYwGlYDvnYjHxFas88SRP8jXh/963XfIlmNH+T7KCtSgrYJ1DEDlgDDKnjPO/ipqPiACHPhBS4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=RwK0CvTp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XiXOfhne; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id B760A1140097;
	Mon,  7 Oct 2024 16:02:04 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 07 Oct 2024 16:02:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728331324;
	 x=1728417724; bh=fto1Mm/+Vv3kjPvv6h2ZCsDJYq2/Q/MX27uVu3va9ZM=; b=
	RwK0CvTpQir6649O/DQSp2HZTEZXgHqLUF+O3f+jVFakT6YO69zXCtC/XsqioaHL
	FtJN+k2EX60OpWDwcBavbk7FVuU6gQv4NGkm0nByLNghJDKPAv5SfE771Im1gOzp
	wv/HW+G1wpZRvACpsa17gLJtT1oTR8ZYa7kzUYnmXmU6HMCRFvMtzE9tcB0Yu+pf
	Prz9/2hhp0nJwQ3Mi02Xr7KmJWMxYUd9t1U1zeUkPO3w+pT7+CYZvhXIvJIAbLGi
	qZE+VoOCNLBETDuBjGeg1capvKu8UtDotzuP79zodK3MZpU4rssR6U03WEA8dGFN
	i3oEHaFIlhOQfqUHROFF6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728331324; x=
	1728417724; bh=fto1Mm/+Vv3kjPvv6h2ZCsDJYq2/Q/MX27uVu3va9ZM=; b=X
	iXOfhne2fJcWBF/GeseYmx2uxT9E+XhiFjXwW2qJkoozFPkT+/o7lUN/zGxilLkT
	rOMNXD+D+Q/rqC6VUwaC8ayqHrDv/CmiczNLT8c393OtCC9U/kQcwmI4tPi13BzI
	libeL3g5zrkBFwp6Ow+Bb7jfHU9Wub3/2NxMlCOmsihepKE0j4VJHwcQ5NGZGZfu
	Ov26+HMaTtCeaLIlKriKUlX6wznF5BTUICnkFz7brQgk87OOGTIqZW/fgm40fF5r
	rCsJqYFPXrYZ6GiBmmkJGkbp++ZGj8lUhsw8+rJgIHlw+hJdz23p3ExX4ZnJ5Wbf
	tu2px3nFahPfNVXZQxSbA==
X-ME-Sender: <xms:Oz4EZ1KYSN0Q-TxQSlP8cFR148Etp_z6Q6FmJpvt9tDMx1Q_fNabSg>
    <xme:Oz4EZxKjUEBdGQTXN711xSd0uhs1Cipm2b-N_S9xiYkJueoEFW0yeleRZvnQgRBbx
    7KGC1fa6vVZL6Sd>
X-ME-Received: <xmr:Oz4EZ9vyz7zPZ0v19KJzT74bcL9P94_mjo24nfw-nRdxG0wEnUrhLdjlcUFg-pHPuq5iHmxXj8trF4E2ZaL3YuimSEmNb2CiXxOjKFXF8StAQ29YpupA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvledgudegiecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:Oz4EZ2aVgkmkmJzI_qQAvBHJJLIsYDDgkbn8j1yYR9xVSWjM8dZoqg>
    <xmx:Oz4EZ8YEHwn4IU0N0WqR6TmRrvg3_hAQeypAz6TpqjnC4XHTMzu1qQ>
    <xmx:Oz4EZ6CI7VuMAoxGeNjlybIDb_5loqeh03oDFn_h6symg1TzhkzkZg>
    <xmx:Oz4EZ6Z9ALOeGsxkge7okCCYOavr1jsXEzVNZer884MctxDho7B0SQ>
    <xmx:PD4EZ84VUYxNFlTN0YzCELs1tUXX9ZZdNr6wvV5viZk0IUGaMS-73yXd>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Oct 2024 16:02:02 -0400 (EDT)
Message-ID: <ebc29d73-ad5a-4fba-b892-1cea7f1b44d0@fastmail.fm>
Date: Mon, 7 Oct 2024 22:02:01 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] fuse: add optional kernel-enforced timeout for
 requests
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
 josef@toxicpanda.com, jefflexu@linux.alibaba.com, laoar.shao@gmail.com,
 kernel-team@meta.com
References: <20240830162649.3849586-1-joannelkoong@gmail.com>
 <20240830162649.3849586-2-joannelkoong@gmail.com>
 <CAJfpegug0MeX7HYDkAGC6fn9HaMtsWf2h3OyuepVQar7E5y0tw@mail.gmail.com>
 <CAJnrk1bdyDq+4jo29ZbyjdcbFiU2qyCGGbYbqQc_G23+B_Xe_Q@mail.gmail.com>
 <7d609efd-9e0e-45b1-8793-872161a24318@fastmail.fm>
 <CAJnrk1ZSoHq2Qg94z8NLDg5OLk6ezVA_aFjKEibSi7H5KDM+3Q@mail.gmail.com>
 <CAJnrk1btbP-jDVttuh-skyAQyHR80to+u55g7BANzqW2af_+Qw@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJnrk1btbP-jDVttuh-skyAQyHR80to+u55g7BANzqW2af_+Qw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/7/24 20:39, Joanne Koong wrote:
> On Tue, Oct 1, 2024 at 10:03 AM Joanne Koong <joannelkoong@gmail.com> wrote:
>>
>> On Sat, Sep 28, 2024 at 1:43 AM Bernd Schubert
>> <bernd.schubert@fastmail.fm> wrote:
>>>
>>> Hi Joanne,
>>>
>>> On 9/27/24 21:36, Joanne Koong wrote:
>>>> On Mon, Sep 2, 2024 at 3:38 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>>>>>
>>>>> On Fri, 30 Aug 2024 at 18:27, Joanne Koong <joannelkoong@gmail.com> wrote:
>>>>>>
>>>>>> There are situations where fuse servers can become unresponsive or
>>>>>> stuck, for example if the server is in a deadlock. Currently, there's
>>>>>> no good way to detect if a server is stuck and needs to be killed
>>>>>> manually.
>>>>>>
>>>>>> This commit adds an option for enforcing a timeout (in seconds) on
>>>>>> requests where if the timeout elapses without a reply from the server,
>>>>>> the connection will be automatically aborted.
>>>>>
>>>>> Okay.
>>>>>
>>>>> I'm not sure what the overhead (scheduling and memory) of timers, but
>>>>> starting one for each request seems excessive.
>>>>
>>>> I ran some benchmarks on this using the passthrough_ll server and saw
>>>> roughly a 1.5% drop in throughput (from ~775 MiB/s to ~765 MiB/s):
>>>> fio --name randwrite --ioengine=sync --thread --invalidate=1
>>>> --runtime=300 --ramp_time=10 --rw=randwrite --size=1G --numjobs=4
>>>> --bs=4k --alloc-size 98304 --allrandrepeat=1 --randseed=12345
>>>> --group_reporting=1 --directory=/root/fuse_mount
>>>>
>>>> Instead of attaching a timer to each request, I think we can instead
>>>> do the following:
>>>> * add a "start_time" field to each request tracking (in jiffies) when
>>>> the request was started
>>>> * add a new list to the connection that all requests get enqueued
>>>> onto. When the request is completed, it gets dequeued from this list
>>>> * have a timer for the connection that fires off every 10 seconds or
>>>> so. When this timer is fired, it checks if "jiffies > req->start_time
>>>> + fc->req_timeout" against the head of the list to check if the
>>>> timeout has expired and we need to abort the request. We only need to
>>>> check against the head of the list because we know every other request
>>>> after this was started later in time. I think we could even just use
>>>> the fc->lock for this instead of needing a separate lock. In the worst
>>>> case, this grants a 10 second upper bound on the timeout a user
>>>> requests (eg if the user requests 2 minutes, in the worst case the
>>>> timeout would trigger at 2 minutes and 10 seconds).
>>>>
>>>> Also, now that we're aborting the connection entirely on a timeout
>>>> instead of just aborting the request, maybe it makes sense to change
>>>> the timeout granularity to minutes instead of seconds. I'm envisioning
>>>> that this timeout mechanism will mostly be used as a safeguard against
>>>> malicious or buggy servers with a high timeout configured (eg 10
>>>> minutes), and minutes seems like a nicer interface for users than them
>>>> having to convert that to seconds.
>>>>
>>>> Let me know if I've missed anything with this approach but if not,
>>>> then I'll submit v7 with this change.
>>>
>>>
>>> sounds great to me. Just, could we do this per fuse_dev to avoid a
>>> single lock for all cores?
>>>
>>
>> Will do! thanks for the suggestion - in that case, I'll add its own
>> spinlock for it too then.
> 
> I realized while working on v7 that we can't do this per fuse device
> because the request is only associated with a device once it's read in
> by the server (eg fuse_dev_do_read).
> 
> I ran some rough preliminary benchmarks with
> ./libfuse/build/example/passthrough_ll  -o writeback -o max_threads=4
> -o source=~/fstests ~/fuse_mount
> and
> fio --name randwrite --ioengine=sync --thread --invalidate=1
> --runtime=300 --ramp_time=10 --rw=randwrite --size=1G --numjobs=4
> --bs=4k --alloc-size 98304 --allrandrepeat=1 --randseed=12345
> --group_reporting=1 --directory=fuse_mount
> 
> and didn't see any noticeable difference in throughput (~37 MiB/sec on
> my system) with vs without the timeout.
> 


That is not much, isn't your limit the backend? I wonder what would happen
with 25GB/s I'm testing with. Wouldn't it make sense for this to test with 
sequential large IO? And possibly with the passthrough-hp branch that
bypasses IO? And a NUMA system probably would be helpful as well. 
I.e. to test the effect on the kernel side without having an IO limited
system?


With the io-uring interface requests stay in queues from the in-coming CPU
so easier to achieve there, although I wonder for your use-case if it
wouldn't be sufficient to start the timer only when the request is on
the way to fuse-server? One disadvantage I see is that virtiofs would need
to be specially handled.


Thanks,
Bernd



