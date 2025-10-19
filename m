Return-Path: <linux-fsdevel+bounces-64632-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DC0BEEE28
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 00:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B788C1892028
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Oct 2025 22:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E386724290D;
	Sun, 19 Oct 2025 22:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="kQYBKvWN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="InDwQoxG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE77D1C2334
	for <linux-fsdevel@vger.kernel.org>; Sun, 19 Oct 2025 22:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760912551; cv=none; b=CuuwLwmqsQ4aWmUppA3ETqsu0WBYOeF8n3nRIkCktckQWU5/n5zPMsO2i2J6JCewJk/YQsvXfXHovcpeY5T7se+rXRl7yMVqsvA97hiJ8DS7EdrgrEkb/1FNoX4TGz90urlKNDv7l8Au0K7a83mHF6REgJ5hm4tt1qWeMUN8S08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760912551; c=relaxed/simple;
	bh=CIZ4KSHm/TDqtU22yFK46uAIoMVOjVPnvtWa8D8h49M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ypkvdh0jTkwjRqrHnGBBLSg2xuj7nMV5DPdy2FLaqUX8diH/QkyXegQeRHTTybhiF0plhrI3rps+lkmsvMiVE9FRMUHXeZ3Zx+aMAzjf7EulGS/A/JZNY77AGi6yGBQMds7V4RSaCfhD42g60/EpW1Bt/yobOpwI3rFMRJGJrKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=kQYBKvWN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=InDwQoxG; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 474E27A000E;
	Sun, 19 Oct 2025 18:22:27 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sun, 19 Oct 2025 18:22:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1760912547;
	 x=1760998947; bh=EMKngj9mAFqVLtZYGCYJCRZpTACScFtVRA35l80hOMU=; b=
	kQYBKvWNSMV6yFLg1QYLbocDu/28gvLlY8CCagEwvOIFH0k83jFw9Xg5KaLttcwM
	hrl0RxTSk34pIPqO/q+/drvh85uevZQwgJNI20mNX0sxQXGXhMIJCcUJkypWPISF
	ijQ4DTUqLZ1M2vewKaUocselpkUrAc2wmz1uvqx+FROcovAByOa2B/8yFJNbiWU7
	RPwkWcBG0t59SRAKE32dsxWxnDY++rj/wsT2ee4G6llDKDiWM+j5/PShEmWV6d/Y
	yKwVO9pkp6q1bbwf5UETxSD7dbklKvtQUF9ntcuhPALeFhMP6StwqSDzc9vwG7W+
	XItUziRroc3jrVp2Q1unqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760912547; x=
	1760998947; bh=EMKngj9mAFqVLtZYGCYJCRZpTACScFtVRA35l80hOMU=; b=I
	nDwQoxGfdLmGrGaEhEZ22BS6GgNFp5xxUjIND+Y31NeH8MpXVadnXpAPkJ6UXzdh
	ZSP4HANX+ePf54Tr1WV88tMNJmk7uK/utCxF/7rVfDfF/+CfXzQ+3uxDnXJlR5s1
	6o5O+4eRFqKd4LSegau1wd6vefWc/+CA4tZKQ73Os4nSwpvk435bk72OH+G+8abH
	if94I8zIKWTG4ydwAUnRZYEgZLLGtWdgQiVaztL1oMy3t4IDuJ/Ts1BTEoWNnKaV
	22H7NT3fdXmPvEoNucZAGiOidVkKeCkIJ0a8AQRdPwdzK30/c3h+IZC5qmqnnzYO
	cSeUPUMuWl3cIru1Q6S4A==
X-ME-Sender: <xms:omT1aLnZCRdxbapNYyZScxNJXaut9E5IZM0oriXYduK-QPHs5b2bUA>
    <xme:omT1aLNpOg4nsVciZMoxZV3gJUF0pPhBoyzGwYjVh5DpLlimuAZZbApwwzPZtjZRK
    3d_-PCdbrpZwxFTWHjQtQ36U9IKSSJK9S2J6PtJdsxrXq_eQ0be>
X-ME-Received: <xmr:omT1aGFklXd7ztBtxQxObgi_vxPMmlIecaKfLy72k9aoDOxP7Yeiju9JzbKXHH2aL-zWmU0MQE4JcH3OhJrfm-qSusWrWMmBBeyh1qVWRj48Tea77I3R>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeeiudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeehhfejueejleehtdehteefvdfgtdelffeuudejhfehgedufedvhfehueev
    udeugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeduhedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepsghstghhuhgsvghrthesuggunhdrtghomhdprh
    gtphhtthhopehjohgrnhhnvghlkhhoohhnghesghhmrghilhdrtghomhdprhgtphhtthho
    pehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehmihhklhhosh
    esshiivghrvgguihdrhhhupdhrtghpthhtohepmhhinhhgohesrhgvughhrghtrdgtohhm
    pdhrtghpthhtohepjhhurhhirdhlvghllhhisehrvgguhhgrthdrtghomhdprhgtphhtth
    hopehvihhntggvnhhtrdhguhhithhtohhtsehlihhnrghrohdrohhrghdprhgtphhtthho
    peguihgvthhmrghrrdgvghhgvghmrghnnhesrghrmhdrtghomhdprhgtphhtthhopehroh
    hsthgvughtsehgohhoughmihhsrdhorhhg
X-ME-Proxy: <xmx:omT1aBv4a1H92UyOsT-ePLOF5HDjmauICiR4Vs0mtdfKtIxVT7aCdw>
    <xmx:omT1aGSFi3sztIzBvFTmnQqTUv2LWeWz6cGh8qZOlWz0hBHnyggygQ>
    <xmx:omT1aLPH1r_35NxIMGUDpjZc2GUD0wMYaV5yBrVORvSbO_YydzSAog>
    <xmx:omT1aE7eDI1XdIXaDINvzjYSQU3Gt5TfE9JFzs8ZEwT3xmkjfKrkHg>
    <xmx:o2T1aC4rAuBis5rZgeJlsMOexuEXH7_9W8cMvOWeyQMcvkwBg1N0bkId>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 Oct 2025 18:22:24 -0400 (EDT)
Message-ID: <005ede4e-7e9f-454e-9360-ef04111ece29@bsbernd.com>
Date: Mon, 20 Oct 2025 00:22:22 +0200
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
 <b0717e48-0879-4af8-bd31-11a239dea787@bsbernd.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <b0717e48-0879-4af8-bd31-11a239dea787@bsbernd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/19/25 20:15, Bernd Schubert wrote:
> 
> 
> On 10/16/25 23:53, Bernd Schubert wrote:
>> On 10/16/25 22:13, Joanne Koong wrote:
>> And then 
>>
>> bschubert2@imesrv3 ~>fio --directory=/tmp/dest --name=iops.\$jobnum --rw=randread --bs=4k --size=1G --numjobs=1 --iodepth=1 --time_based --runtime=30s --group_reporting --ioengine=psync --direct=1 
>>
>>
>> With WF_CURRENT_CPU: READ: bw=269MiB/s
>> With WF_SYNC:        READ: bw=214MiB/s
>> With plain wake_up:  READ: bw=217MiB/s
>>
> 
> The culprit with plain wake might be here
> 
>              fio-7669    [011] d..2. 13916.272607: sched_switch: prev_comm=fio prev_pid=7669 prev_prio=120 prev_state=S ==> next_comm=swapper/11 next_pid=
> ...
>           <idle>-0       [011] d.s4. 13916.281747: sched_waking: comm=kworker/11:1 pid=297 prio=120 target_cpu=011
>           <idle>-0       [011] d.s4. 13916.281749: sched_waking_extended: comm=kworker/11:1 pid=297 prio=120 prev_cpu=011 current_cpu=011 target_cpu=011
>           <idle>-0       [011] dNs5. 13916.281769: sched_wakeup: comm=kworker/11:1 pid=297 prio=120 target_cpu=011
>           <idle>-0       [011] dNs5. 13916.281769: sched_wakeup_extended: comm=kworker/11:1 pid=297 prio=120 prev_cpu=011 current_cpu=011 target_cpu=011
>           <idle>-0       [011] d..2. 13916.281779: sched_switch: prev_comm=swapper/11 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=kworker/11:1 nex
> t_pid=297 next_prio=120
>     kworker/11:1-297     [011] d.h3. 13916.282654: sched_waking: comm=fio pid=7669 prio=120 target_cpu=011
>     kworker/11:1-297     [011] d.h3. 13916.282654: sched_waking_extended: comm=fio pid=7669 prio=120 prev_cpu=011 current_cpu=011 target_cpu=011
>     kworker/11:1-297     [011] d.h3. 13916.282654: select_task_rq_fair <-select_task_rq
>     kworker/11:1-297     [011] d.h3. 13916.282655: sched_migrate_task: comm=fio pid=7669 prio=120 orig_cpu=11 dest_cpu=26
> 
> 
> ==> migration from cpu=11 to cpu=26
> 
>     kworker/11:1-297     [011] d.h3. 13916.282657: sched_wake_idle_without_ipi: cpu=26
>           <idle>-0       [026] dN.2. 13916.282686: sched_wakeup: comm=fio pid=7669 prio=120 target_cpu=026
>           <idle>-0       [026] dN.2. 13916.282687: sched_wakeup_extended: comm=fio pid=7669 prio=120 prev_cpu=026 current_cpu=026 target_cpu=026
>           <idle>-0       [026] d..2. 13916.282690: sched_switch: prev_comm=swapper/26 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=fio next_pid=766
> 9 next_prio=120
>              fio-7669    [026] d..2. 13916.282717: sched_switch: prev_comm=fio prev_pid=7669 prev_prio=120 prev_state=S ==> next_comm=swapper/26 next_pid=
> 
> 
> This is with added in sched_wakeup_extended() but prev_cpu is not
> correctly assigned yet. Also not needed anymore as we can see
> that migration is in in select_task_rq_fair/sched_migrate_task.
> 

The persistent core switches seem to come from select_idle_sibling(). 
Hmm, that kind of means we should create one queue and ring-thread per
sibling only.



