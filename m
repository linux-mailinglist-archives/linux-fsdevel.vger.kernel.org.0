Return-Path: <linux-fsdevel+bounces-64399-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDB2BE5B02
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 00:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C37C84FD6AC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 22:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745E521FF5F;
	Thu, 16 Oct 2025 22:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="H30euT63";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AzmByFP6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98983BB5A
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Oct 2025 22:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760653843; cv=none; b=dWZIenbzhf+9mpCZgSGNw7NPPFpy3jrM80Oq2Ll5eeUZ4VNIchtqktHm4IwuVqG+Lt5dQaUyzZPP3mPlFCuoGcvs7N8CEIUAKV9Kh6PwC3p7iZrQ7hRGX7dMM82XZdWcIhxPpuWMtuL04BklkHrkF3aw9m3qPvIDUMd+/o27b1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760653843; c=relaxed/simple;
	bh=GKV5q3WMucpYWgMQ7H7TRgVugC6KyxD9txH93K8m0tw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LB5s5WtwnxCpc26cL/uzZo4mTfmCNB+FJoE1qasepa2FE41tMeYTOWe1pIk5mvCf5J6neUwpoxZm6Y+Bk6IH8UMVQwUQQW1E0oqhrJCA5KRv1HApwgA4p97TT+gbWvGc3AztJQnzr39IM0qqA6Zagqf/er/5xQHciYphz+eNrOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=H30euT63; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AzmByFP6; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 5DC821D00101;
	Thu, 16 Oct 2025 18:30:39 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 16 Oct 2025 18:30:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1760653839;
	 x=1760740239; bh=c6y/iHl9z/uK43Ueq3uTvXdp8cIbEIaqeaaABtXjBG0=; b=
	H30euT63d0CS9bGAoyItbEV88OOobMQpRcluB9DGdqXDLbPxKrhXAl/of1J6jSc2
	zObQEIbbWiUXPOgw2GqYJyVGukeC/XEeTCm1/jEEl0ucHLMEd6yP6QAYej1Dhfsk
	1C5Ii9SBNYwRublkShoQt5itZRD5CtjWOS788iUWf77YNGNLPq1zcPevSQ74e96K
	kL1txDuM7XCJuv6XLH5YsJlQHPDBQepNIoq5cda/6sRPRhOpBs2j2U7u7bwzVoqo
	136wG0haiWAFHdN7f6vTYbeI96oM4GBZH6U86aazGVWDGV0mFv0k9p0lIi6451i8
	bzATdx0C+WUQ4Y3wsq2ZRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760653839; x=
	1760740239; bh=c6y/iHl9z/uK43Ueq3uTvXdp8cIbEIaqeaaABtXjBG0=; b=A
	zmByFP6BD/LVrWw1ics9mvrjAOTO/JeBs9e8G4MhWx0XQ/3MKJCe7zjF+vTo2W5/
	k10VOo9VIKY2pL8hU7ABUirHhggSbFPlB2q8fhbv8GfxZoT0JPVsK+nw5U/SbE0G
	AHenAgG7aAvzd7X+uBdZi4oGuL27myoS/js19uAnyNuWwpb5ak6IRasTbUEX3i8Q
	2SrLGLsSVEAuOPDJObuh3W/X8Ex59hCSg608gABwV/0KJFeKwcTpsjJgQsY4avzt
	fgqd5lKErUHMHQ8MOseSx0T8d0HfegaOL0AEvwhtpBi16xV3Wai6FVXhcRIacEkw
	732fEeQUAYuGv9pfTFieA==
X-ME-Sender: <xms:DXLxaKyNoJ06esFGKvV052xlsM80ll-wWFbUY1216wbkN9JH61FUwg>
    <xme:DXLxaCpaFWBZ8zlELFLJVCIht8bIkayIcy9IkFs6Q2mXtyDqTghJZtOYfOE9wjxlJ
    gK_UkkrwWbf1hdyKHfiP2IKYd3B9cAAHGZ_o2bCY3NOjQ3ntdmN>
X-ME-Received: <xmr:DXLxaAyxjOVYLa2NV5bFBoGhCqyb67y001VLuZIoryak1v551FeuwTljd7H2y5m66Lth0-ESh0EySZFweFjHStKQ8pIIBIxq89NuBXXRWDFVqlWxIhxJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdejhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeefgeegfeffkeduudelfeehleelhefgffehudejvdfgteevvddtfeeiheef
    lefgvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeduhedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepsghstghhuhgsvghrthesuggunhdrtghomhdprh
    gtphhtthhopehjohgrnhhnvghlkhhoohhnghesghhmrghilhdrtghomhdprhgtphhtthho
    pehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehmihhklhhosh
    esshiivghrvgguihdrhhhupdhrtghpthhtohepmhhinhhgohesrhgvughhrghtrdgtohhm
    pdhrtghpthhtohepjhhurhhirdhlvghllhhisehrvgguhhgrthdrtghomhdprhgtphhtth
    hopehvihhntggvnhhtrdhguhhithhtohhtsehlihhnrghrohdrohhrghdprhgtphhtthho
    peguihgvthhmrghrrdgvghhgvghmrghnnhesrghrmhdrtghomhdprhgtphhtthhopehroh
    hsthgvughtsehgohhoughmihhsrdhorhhg
X-ME-Proxy: <xmx:DXLxaOo-PUrClBYDLpdGuuy-9l4oh947pRnOAY9y4gWVSQu71r8D-Q>
    <xmx:DXLxaIelGDvUdkihbBDUCAg_rDIka-ivF_7qIrNnx_UTpXwfrBN1MQ>
    <xmx:DXLxaJroEBQvADpLSrNjwc_fOdX7zN3yYKPKMSSWmH71n0RrXbcuig>
    <xmx:DXLxaKlqUEp_0mLeUmw5OhFFWcZ0QpEOlqPriZhYd9Idg_IrezRILQ>
    <xmx:D3LxaDWOuH-xVZbkZBQ7JFCSuzGu91nKAcj03fDAMUObgu-DZ_7jgXtL>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Oct 2025 18:30:35 -0400 (EDT)
Message-ID: <fadbf3c9-2b64-47e8-8108-f35ce9aebc2f@bsbernd.com>
Date: Fri, 17 Oct 2025 00:30:34 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fuse: Wake requests on the same cpu
To: Bernd Schubert <bschubert@ddn.com>, Joanne Koong
 <joannelkoong@gmail.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Ingo Molnar <mingo@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Luis Henriques <luis@igalia.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20251014-wake-same-cpu-v2-1-68f5078845c6@ddn.com>
 <CAJnrk1brjsPoXc_dbMj-Ty4dr5ZCxtVjBn6WGOY8DkGxh87R5Q@mail.gmail.com>
 <6d16a94b-3277-4922-a628-f17f622369bc@bsbernd.com>
 <CAJnrk1b9xVqmDY9kgDjPpjs7zuXNbiNaQnMyvY0iJirJbHi1yw@mail.gmail.com>
 <20251016085813.GB3245006@noisy.programming.kicks-ass.net>
 <20251016090019.GH4068168@noisy.programming.kicks-ass.net>
 <CAJnrk1aoPZj6KWKhBhPSASs-kgWDxipfY3MjPDBtG4v-zay3rg@mail.gmail.com>
 <90ecb50a-926b-45f1-b047-95e07f2e6e6f@ddn.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <90ecb50a-926b-45f1-b047-95e07f2e6e6f@ddn.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/16/25 23:53, Bernd Schubert wrote:
> On 10/16/25 22:13, Joanne Koong wrote:
>> On Thu, Oct 16, 2025 at 2:00 AM Peter Zijlstra <peterz@infradead.org> wrote:
>>>
>>> On Thu, Oct 16, 2025 at 10:58:14AM +0200, Peter Zijlstra wrote:
>>>> On Wed, Oct 15, 2025 at 03:19:31PM -0700, Joanne Koong wrote:
>>>>
>>>>>>> Won't this lose cache locality for all the other data that is in the
>>>>>>> client thread's cache on the previous CPU? It seems to me like on
>>>>>>> average this would be a costlier miss overall? What are your thoughts
>>>>>>> on this?
>>>>>>
>>>>>> So as in the introduction, which b4 made a '---' comment below,
>>>>>> initially I thought this should be a conditional on queue-per-core.
>>>>>> With queue-per-core it should be easy to explain, I think.
>>>>>>
>>>>>> App submits request on core-X, waits/sleeps, request gets handle on
>>>>>> core-X by queue-X.
>>>>>> If there are more applications running on this core, they
>>>>>> get likely re-scheduled to another core, as the libfuse queue thread is
>>>>>> core bound. If other applications don't get re-scheduled either the
>>>>>> entire system is overloaded or someone sets manual application core
>>>>>> affinity - we can't do much about that in either case. With
>>>>>> queue-per-core there is also no debate about "previous CPU".
>>>>>> Worse is actually scheduler behavior here, although the ring thread
>>>>>> itself goes to sleep soon enough. Application gets still quite often
>>>>>> re-scheduled to another core. Without wake-on-same core behavior is
>>>>>> even worse and it jumps across all the time. Not good for CPU cache...
>>>>>
>>>>> Maybe this is a lack of my understanding of scheduler internals,  but
>>>>> I'm having a hard time seeing what the benefit of
>>>>> wake_up_on_current_cpu() is over wake_up() for the queue-per-core
>>>>> case.
>>>>>
>>>>> As I understand it, with wake_up() the scheduler already will try to
>>>>> wake up the thread and put it back on the same core to maintain cache
>>>>> locality, which in this case is the same core
>>>>> "wake_up_on_current_cpu()" is trying to put it on. If there's too much
>>>>> load imbalance then regardless of whether you call wake_up() or
>>>>> wake_up_on_current_cpu(), the scheduler will migrate the task to
>>>>> whatever other core is better for it.
>>>>>
>>>>> So I guess the main benefit of calling wake_up_on_current_cpu() over
>>>>> wake_up() is that for situations where there is only some but not too
>>>>> much load imbalance we force the application to run on the current
>>>>> core even despite the scheduler thinking it's better for overall
>>>>> system health to distribute the load? I don't see an issue if the
>>>>> application thread runs very briefly but it seems more likely that the
>>>>> application thread could be work intensive in which case it seems like
>>>>> the thread would get migrated anyways or lead to more latency in the
>>>>> long term with trying to compete on an overloaded core?
>>>>
>>>> So the scheduler will try and wake on the previous CPU, but if that CPU
>>>> is not idle it will look for any non-idle CPU in the same L3 and very
>>>
>>> Typing hard: s/non-//
>>>
>>>> aggressively move tasks around.
>>>>
>>>> Notably if Task-A is waking Task-B, and Task-A is running on CPU-1 and
>>>> Task-B was previously running on CPU-1, then the wakeup will see CPU-1
>>>> is not idle (it is running Task-A) and it will try and find another CPU
>>>> in the same L3.
>>>>
>>>> This is fine if Task-A continues running; however in the case where
>>>> Task-A is going to sleep right after doing the wakeup, this is perhaps
>>>> sub-optimal, CPU-1 will end up idle.
>>>>
>>>> We have the WF_SYNC (wake-flag) that tries to indicate this latter case;
>>>> trouble is, it often gets used where it should not be, it is unreliable.
>>>> Therefore it not a strong hint.
>>>>
>>>> Then we 'recently' grew WF_CURRENT_CPU, that forces the wakeup to the
>>>> same CPU. If you abuse, you keep pieces :-)
>>>>
>>>> So it all depends a bit on the workload, machine and situation.
>>>>
>>>> Some machines L3 is fine, some machines L3 has exclusive L2 and it hurts
>>>> more to move tasks. Some workloads don't fit L2 so it doesn't matter
>>>> anyway. TL;DR is we need this damn crystal ball instruction :-)
>>
>> Thanks for the explanation! I found it very helpful.
>>
>> In light of that information, it seems to me that the original
>> wake_up() would be more optimal here than wake_up_on_current_cpu()
>> then. After fuse_request_end(), the thread still has work to do with
>> fetching and servicing the next requests. If it wakes up the
>> application on its cpu, then with queue-per-core the thread would be
>> forced to sleep since on the libfuse side during setup the thread is
>> pinned to the core, which would prevent any migration while the
>> application task runs. Or am I misassuming something in this analysis,
>> Bernd?
> 
> 
> Well, the numbers speak a different language. And I still don't see
> why wouldn't want to take on the current CPU at least if we have
> queue-per-core.
> Thanks a lot @Peter for the explanation. To my understanding WF_SYNC
> should do the trick, i.e. wake on the same core, when the current task
> is going to sleep anyway and there is nothing else running on that core.
> For a blocking IO with queue-per-core this is exactly what we have.
> 
> Example
> 
> + echo 'Running: example/passthrough_hp' -o allow_other --foreground --nopassthrough -o io_uring -o io_uring_nr_qs=2 /tmp/source /tmp/dest
> 
> 
> And then 
> 
> bschubert2@imesrv3 ~>fio --directory=/tmp/dest --name=iops.\$jobnum --rw=randread --bs=4k --size=1G --numjobs=1 --iodepth=1 --time_based --runtime=30s --group_reporting --ioengine=psync --direct=1 
> 
> 
> With WF_CURRENT_CPU: READ: bw=269MiB/s
> With WF_SYNC:        READ: bw=214MiB/s
> With plain wake_up:  READ: bw=217MiB/s
> 
> With WF_SYNC and plain wake_up I see a persistent core switching
> of the fio process between two cores on one numa node - so much 
> about L1/L2 cpu cache.
> With more fuse-io-uring queues there also would be additional
> switching for that and even lower perf, but with only one queue
> per numa that gets a bit restricted.
> 
> My guess is that WF_SYNC doesn't detect that the current libfuse
> ring thread will go to sleep in the io_uring_enter() system call
> rather quickly.
> I can try to get some time and figure out why the fio process
> bounces between two cores. I had already started to ftrace
> things, because even WF_CURRENT_CPU isn't ideal. Although this
> discussion here goes the other direction.


A bit more data points, with WF_CURRENT_CPU it sometimes jumps to 
330MB/s - both process then run on the same core and cpu-freq goes
up to max.

With 'numactl --localalloc --physcpubind=8', i.e. binding to the 
core of one of the ring threads, it 330MB/s.

With 'numactl --localalloc --physcpubind=10' or any other non-ring
thread core, it is about 270MB/s - this 'ideal' wake_up() should
result in this.

(fuse-io-uring ring threads are running on core-0 and core-8).


Thanks,
Bernd

