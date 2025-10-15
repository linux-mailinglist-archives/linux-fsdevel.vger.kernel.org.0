Return-Path: <linux-fsdevel+bounces-64246-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 630F0BDF5B5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 17:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A118B19C7C83
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 15:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F584299923;
	Wed, 15 Oct 2025 15:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="dW6skM6s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q51/O0zd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5658E2522BE
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 15:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760542212; cv=none; b=XErZS18beQND57Z5DJjf01jBem6Ks7g6x/xE6C+lIihSAs13BAi6LgsdAeEFBOJ3UdlPQ5IzZKoBIr0kMjtdaD0l/FPtCrj2e4OQ+oaWpG7WKezmVR4FbyGTucZ5bNrWKD6uw0GMepztJBLtaZ5USNTSs4xnP4EMeCveThi3G08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760542212; c=relaxed/simple;
	bh=hR9rZXOS28XrWRaww1nNuXB3NTUIo8KAbja29JpsS1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t5ppOAFi3B4xSHJ7SUcaUIMoLfiR/bPTTbME07D0kNEL+TuGBEP7UqG8AYBadn3Qf2t4GEruKaQIKkOTS7w8oZiX+t9t+Slq+NsbOH4S/M+B/mSkp4+UuL4YKyNCGL6TZTluiYgAgo8GVbz4Y53OTM7At6u5KJdt8KlbefXVaAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=dW6skM6s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q51/O0zd; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 3F6ECEC0178;
	Wed, 15 Oct 2025 11:30:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 15 Oct 2025 11:30:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1760542207;
	 x=1760628607; bh=fkAH8YWGxIwBLRfFRs+1ooPPdhNwWytvG+AeJExMgTs=; b=
	dW6skM6sipgqm1zHXK6fEerdFG8yrC37XmN/OgJ75VAQQCT+H6SZpXOoyl80MXFr
	3jX/fcvkPNVKl0m/JMsHw81bzifAYxp3uQB2PXz8kSEVfHVXTBiThI4XZQZgus6a
	Lov9mwaAti2W5E97vKiD8lcAmidvmV/aAIMtc2VQ8OWAt8CjnQmB5LtuaItVEAcP
	D1fRp1V0J4ocRv7hQuVY32M0N09RHGBs1q5V8nP/vprc1fBzyBvkmOt5htn+rCsj
	dhrACAcYeIXFa40tdw4SymP1nCSqv5Jb7Y9bgrBXVI4LjXYuTq3dGnpg/N2OwzU5
	VsntsWq7GiKxzKcxFT4lIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760542207; x=
	1760628607; bh=fkAH8YWGxIwBLRfFRs+1ooPPdhNwWytvG+AeJExMgTs=; b=q
	51/O0zdf2HpAa+jFKnl6FXEDs550D9wObrvf4FVmbMsROGVU11v87U5M00nOk5cP
	K/PH44ZQtAeSO9W0Pxm5cz9mMxlG96GzwBKO4y6n4jO4egCRTocwjT1Vm1wW++42
	5OlWolu59/nL+TKH/i1DaLiT7Uv6vriDY7k37vNnH9a7QJKihKnmU/9I0jpeQTp/
	I3aBiEMlNyjcUykVo1iybnNP2wJUOGFXpCxFCntOXhWlGLcl7P7JeAxQS1+RHadI
	xbwDbfii9wJzDz6L4ppLPIcRjx1t/PVhdIyPm87VwUQGglvsQBeFr/DTi8APTvyY
	dW5vaF28DmkcSzyoMd/3g==
X-ME-Sender: <xms:_r3vaK6GpMEv9nwuNrKLcY_GRVb8X3ngNxsr8hfCIa-_N-kemXFDtg>
    <xme:_r3vaAQsVpGDabvJg-KC-SqF6-R5Y8U9IPkB2a7y-WEEslPGfQ2CPwFC7nSZ-M_AP
    zSWef5Dkiia-qIkx90MV_p84AiFb98_3Zky_aV_A20Jf3Aucdvb>
X-ME-Received: <xmr:_r3vaN7mp5uvJ_SHjRvjy1Pivc2uPnlvPrpvZrhxygc7hpsraSRY-KkRwvnr_yPorw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdefjeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpedtuedvueduledtudekhfeuleduudeijedvveevveetuddvfeeuvdekffej
    leeuueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugessghssggvrhhnugdrtgho
    mhdpnhgspghrtghpthhtohepudehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hjohgrnhhnvghlkhhoohhnghesghhmrghilhdrtghomhdprhgtphhtthhopegsshgthhhu
    sggvrhhtseguughnrdgtohhmpdhrtghpthhtohepmhhikhhlohhssehsiigvrhgvughird
    hhuhdprhgtphhtthhopehmihhnghhosehrvgguhhgrthdrtghomhdprhgtphhtthhopehp
    vghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehjuhhrihdrlhgvlh
    hlihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepvhhinhgtvghnthdrghhuihhtthho
    theslhhinhgrrhhordhorhhgpdhrtghpthhtohepughivghtmhgrrhdrvghgghgvmhgrnh
    hnsegrrhhmrdgtohhmpdhrtghpthhtoheprhhoshhtvgguthesghhoohgumhhishdrohhr
    gh
X-ME-Proxy: <xmx:_r3vaFTVxf_yJB0Prm3QX1wTjcTDI1WY4JWkWxNpQcli3gclGZvFKA>
    <xmx:_r3vaKnsG9OnsDKVMoWk71KwZtOcnroCUhJmexUIOGlunIsl2qe7Mg>
    <xmx:_r3vaBS-ts5hxf5yGHsWwJdUWS-_1J8TW29-gZgZtbvKBNL9xpU5iw>
    <xmx:_r3vaJvrL1l5-Ll88FEphekFyZz_y6YeXwNo1l3amZmDMbQohesX-A>
    <xmx:_73vaG9-ktnudB36KH8cK7pI0JlajFM5M1wdzf5kbIVUn-fuJAAfhlQE>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Oct 2025 11:30:04 -0400 (EDT)
Message-ID: <6d16a94b-3277-4922-a628-f17f622369bc@bsbernd.com>
Date: Wed, 15 Oct 2025 17:30:02 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fuse: Wake requests on the same cpu
To: Joanne Koong <joannelkoong@gmail.com>, Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Luis Henriques <luis@igalia.com>, linux-fsdevel@vger.kernel.org
References: <20251014-wake-same-cpu-v2-1-68f5078845c6@ddn.com>
 <CAJnrk1brjsPoXc_dbMj-Ty4dr5ZCxtVjBn6WGOY8DkGxh87R5Q@mail.gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US
In-Reply-To: <CAJnrk1brjsPoXc_dbMj-Ty4dr5ZCxtVjBn6WGOY8DkGxh87R5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/15/25 01:11, Joanne Koong wrote:
> On Tue, Oct 14, 2025 at 2:50 AM Bernd Schubert <bschubert@ddn.com> wrote:
>>
>> For io-uring it makes sense to wake the waiting application (synchronous
>> IO) on the same core.
>>
>> With queue-per-pore
> 
> nit typo: core, not pore

:) Thanks, dunno how I managed to get that.

> 
>>
>> fio --directory=/tmp/dest --name=iops.\$jobnum --rw=randread --bs=4k \
>>      --size=1G --numjobs=1 --iodepth=1 --time_based --runtime=30s
>>      \ --group_reporting --ioengine=psync --direct=1
>>
> 
> Which server are you using for these benchmarks? passthrough_hp?

passthrough_hp on tmpfs, system has 256GB RAM - enough for these benchmarks, with 16 (32 HT) cores.

> 
>> no-io-uring
>>     READ: bw=116MiB/s (122MB/s), 116MiB/s-116MiB/s
>> no-io-uring wake on the same core (not part of this patch)
>>     READ: bw=115MiB/s (120MB/s), 115MiB/s-115MiB/s
>> unpatched
>>     READ: bw=260MiB/s (273MB/s), 260MiB/s-260MiB/s
>> patched
>>     READ: bw=345MiB/s (362MB/s), 345MiB/s-345MiB/s
>>
>> Without io-uring and core bound fuse-server queues there is almost
>> not difference. In fact, fio results are very fluctuating, in
>> between 85MB/s and 205MB/s during the run.
>>
>> With --numjobs=8
>>
>> unpatched
>>     READ: bw=2378MiB/s (2493MB/s), 2378MiB/s-2378MiB/s
>> patched
>>     READ: bw=2402MiB/s (2518MB/s), 2402MiB/s-2402MiB/s
>> (differences within the confidence interval)
>>
>> '-o io_uring_q_mask=0-3:8-11' (16 core / 32 SMT core system) and
>>
>> unpatched
>>     READ: bw=1286MiB/s (1348MB/s), 1286MiB/s-1286MiB/s
>> patched
>>     READ: bw=1561MiB/s (1637MB/s), 1561MiB/s-1561MiB/s
>>
>> I.e. no differences with many application threads and queue-per-core,
>> but perf gain with overloaded queues - a bit surprising.
>>
>> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
>> ---
>> This was already part of the RFC series and was then removed on
>> request to keep out optimizations from the main fuse-io-uring
>> series.
>> Later I was hesitating to add it back, as I was working on reducing the
>> required number of queues/rings and initially thought
>> wake-on-current-cpu needs to be a conditional if queue-per-core or
>> a reduced number of queues is used.
>> After testing with reduced number of queues, there is still a measurable
>> benefit with reduced number of queues - no condition on that needed
>> and the patch can be handled independently of queue size reduction.
>> ---
>> Changes in v2:
>> - Fix the doxygen comment for __wake_up_on_current_cpu
>> - Move up the ' Wake up waiter sleeping in
>>    request_wait_answer()' comment in fuse_request_end()
>> - Link to v1: https://lore.kernel.org/r/20251013-wake-same-cpu-v1-1-45d8059adde7@ddn.com
>> ---
>>   fs/fuse/dev.c        |  5 ++++-
>>   include/linux/wait.h |  6 +++---
>>   kernel/sched/wait.c  | 16 +++++++++++++++-
>>   3 files changed, 22 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
>> index 132f38619d70720ce74eedc002a7b8f31e760a61..3a3d88e60e48df3ac57cff3be8df12c4f20ace9a 100644
>> --- a/fs/fuse/dev.c
>> +++ b/fs/fuse/dev.c
>> @@ -500,7 +500,10 @@ void fuse_request_end(struct fuse_req *req)
>>                  spin_unlock(&fc->bg_lock);
>>          } else {
>>                  /* Wake up waiter sleeping in request_wait_answer() */
>> -               wake_up(&req->waitq);
>> +               if (test_bit(FR_URING, &req->flags))
> 
> might be worth having a separate helper for this since this is also
> called in request_wait_answer()

Ok, I can do that in v3

> 
>> +                       wake_up_on_current_cpu(&req->waitq);
> 
> Won't this lose cache locality for all the other data that is in the
> client thread's cache on the previous CPU? It seems to me like on
> average this would be a costlier miss overall? What are your thoughts
> on this?

So as in the introduction, which b4 made a '---' comment below,
initially I thought this should be a conditional on queue-per-core.
With queue-per-core it should be easy to explain, I think.

App submits request on core-X, waits/sleeps, request gets handle on
core-X by queue-X.
If there are more applications running on this core, they
get likely re-scheduled to another core, as the libfuse queue thread is
core bound. If other applications don't get re-scheduled either the
entire system is overloaded or someone sets manual application core
affinity - we can't do much about that in either case. With
queue-per-core there is also no debate about "previous CPU".
Worse is actually scheduler behavior here, although the ring thread
itself goes to sleep soon enough. Application gets still quite often
re-scheduled to another core. Without wake-on-same core behavior is
even worse and it jumps across all the time. Not good for CPU cache...

With reduced queues we can assume that it to jump between cores, I
have no problem to make it a conditional on that, just results are
encouraging to apply it unconditionally - see the results above for
"-o io_uring_q_mask=0-3:8-11' (16 core / 32 SMT core system)"





> 
>> +               else
>> +                       wake_up(&req->waitq);
>>          }
>>
>>          if (test_bit(FR_ASYNC, &req->flags))
>> diff --git a/include/linux/wait.h b/include/linux/wait.h
>> index f648044466d5f55f2d65a3aa153b4dfe39f0b6dc..831a187b3f68f0707c75ceee919fec338db410b3 100644
>> --- a/include/linux/wait.h
>> +++ b/include/linux/wait.h
>> @@ -219,6 +219,7 @@ void __wake_up_sync(struct wait_queue_head *wq_head, unsigned int mode);
>>   void __wake_up_pollfree(struct wait_queue_head *wq_head);
>>
>>   #define wake_up(x)                     __wake_up(x, TASK_NORMAL, 1, NULL)
>> +#define wake_up_on_current_cpu(x)      __wake_up_on_current_cpu(x, TASK_NORMAL, NULL)
>>   #define wake_up_nr(x, nr)              __wake_up(x, TASK_NORMAL, nr, NULL)
>>   #define wake_up_all(x)                 __wake_up(x, TASK_NORMAL, 0, NULL)
>>   #define wake_up_locked(x)              __wake_up_locked((x), TASK_NORMAL, 1)
>> @@ -479,9 +480,8 @@ do {                                                                                \
>>          __wait_event_cmd(wq_head, condition, cmd1, cmd2);                       \
>>   } while (0)
>>
>> -#define __wait_event_interruptible(wq_head, condition)                         \
>> -       ___wait_event(wq_head, condition, TASK_INTERRUPTIBLE, 0, 0,             \
>> -                     schedule())
>> +#define __wait_event_interruptible(wq_head, condition) \
>> +       ___wait_event(wq_head, condition, TASK_INTERRUPTIBLE, 0, 0, schedule())
>>
>>   /**
>>    * wait_event_interruptible - sleep until a condition gets true
>> diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
>> index 20f27e2cf7aec691af040fcf2236a20374ec66bf..94120076bc1ae465735843cc5821ca532d9c398a 100644
>> --- a/kernel/sched/wait.c
>> +++ b/kernel/sched/wait.c
>> @@ -147,10 +147,24 @@ int __wake_up(struct wait_queue_head *wq_head, unsigned int mode,
>>   }
>>   EXPORT_SYMBOL(__wake_up);
>>
>> -void __wake_up_on_current_cpu(struct wait_queue_head *wq_head, unsigned int mode, void *key)
>> +/**
>> + * __wake_up_on_current_cpu - wake up threads blocked on a waitqueue, on the
>> + * current cpu
>> + * @wq_head: the waitqueue
>> + * @mode: which threads
>> + * @nr_exclusive: how many wake-one or wake-many threads to wake up
> 
> I don't think you meant to include this line?

Yeah, the entire comment is broken :( Sorry about that.

> 
>> + * @key: is directly passed to the wakeup function
>> + *
>> + * If this function wakes up a task, it executes a full memory barrier
>> + * before accessing the task state.  Returns the number of exclusive
>> + * tasks that were awaken.
> 
> Doesn't this return a void?
> 

Yeah, I promise I triple check next time when I copy and paste comments.


Thanks,
Bernd

