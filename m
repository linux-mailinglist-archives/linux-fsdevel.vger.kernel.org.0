Return-Path: <linux-fsdevel+bounces-64625-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF39BEEB37
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Oct 2025 20:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A70D3E536F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Oct 2025 18:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733F718FC86;
	Sun, 19 Oct 2025 18:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="OKHWaKPU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TFSKTB6x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E1D354AE8
	for <linux-fsdevel@vger.kernel.org>; Sun, 19 Oct 2025 18:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760897757; cv=none; b=FS98l6J+6FjvF0yVXIQAq0EL2TB/6Ex5QFGaAbGle9/sKjHhUdzCmSqlvIwHONtoxHwfSgVBWHRlQ+N9woStA8N47bnM1952sqJRzArvC5eGmsBHet4QqmEZXgwnMjLuv4Y/vKsCf8RMwikTTK1pRU0Y5cC/olvySsJoB4xM3Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760897757; c=relaxed/simple;
	bh=iw3bzsqUurP9LOO71/t5FVHaW4DaYQO9lJkJlfeiB9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ikql59nz9MvGSZyL9mx0Poi9uqvq5uTn/JU7wybURonLxCIHG79rDCTUxxDAWC2e0v96jQIyB+VofqmZR1LqLEoRDU6t9KGRcXDQ5X9TrX5O5hG585Nbn0aHC7RUf5tRv6tE8RkmFOoBmKyqOYHa3kzyNmd/XkKbPYUktkkSUro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=OKHWaKPU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TFSKTB6x; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id BE2491D00093;
	Sun, 19 Oct 2025 14:15:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Sun, 19 Oct 2025 14:15:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1760897752;
	 x=1760984152; bh=2Vv+/ghXuAURG3OfuZrbm6OWjL4p3T+oqy6/v80BLi8=; b=
	OKHWaKPU1/izwTo4myxZKZPaajnzcwHLEkQEjH4ScNY4UMWmtPPEbWDk1S89l8N9
	P+yMQay0G9trnDiPeBUso0Y6VcBCqmZW3PxonNtkWxdtlkrR7wLGNqkpGxguSt3C
	wn8O7A+ZIoaY87iAI8cmF0etYeDhPrPzo8QkpjAt22zRwEZGuxmNjR5sGMj/6lQv
	NvmObtz1GJJPE8yGZpUX8UpZV4uSLCvteK4/lci+WOkVf3N9xWSmxnPdMCqank0J
	tPzAspxyL2x3azlX+Ur2zgeUFqejShvtuSKjzdqYubw0eD4cz1dC7D/2Jpl9VQuQ
	+K47qYiKStw9aQ82m4sCpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760897752; x=
	1760984152; bh=2Vv+/ghXuAURG3OfuZrbm6OWjL4p3T+oqy6/v80BLi8=; b=T
	FSKTB6xE2QclHH6PnEe5iC3sHNfY914d2MjTzXscF9HUKWtlRcIKpH9Xl+KUGc+Z
	N8mwJJNoTTmvo6tBhPtvOuyfwUFqPi7DVvjXuKI3TBqhNP5vqEEFyGD559GXQQLp
	o+0pt8836a5fUG5ZbkB60355fXsv/Of78JH1x2QzaeX3GpaAY+TOKaXqbV3xe7TR
	mbPG1qsBVwH5iLVRL4iaYxEwVjhf4KnuBCmqcqgaToG+xyaRLgnRkM4O/tPkkXE1
	xcaA4giAGWnGopxPsH1ywSs9i1fhdZ24cmYCFsEyzqhOjEt24ymOvIoE23APQFJc
	BsCwNNHPWdY6SoaEfNlDQ==
X-ME-Sender: <xms:1ir1aD1VEZDSbJfjOjC7GkvdRZPpTQN04jv1Z46qvGchY4hRzjvDkw>
    <xme:1ir1aOeYEqWhxEdRgkfR7ymaBn_uEiW_gmuUfr03gOohM5dQ0N4JjODZdRQXpOqiG
    ANMXTTt6iy66cl53Qm8El62qWyJafHOInpYyV7jyn3_OVdqgPcS3Q>
X-ME-Received: <xmr:1ir1aIU1-odFbnHv3cn7T5EcoLIGCJgkoWavj9sm6mDjP3snpn777mA1I1T_OvJhldz1AXjpfTNJTF-JlsResDsiVhAJ2CoBfASqFg2cv0VOavhBycbu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeehieegucetufdoteggodetrf
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
X-ME-Proxy: <xmx:1ir1aG9cb-X7TtaU_tHnJPPKAany7f_PLt-f3qbiWegEgoV4pB2Csg>
    <xmx:1ir1aCi1kOJ1C_VropdF9h-qDDhHoby0Ircnbzqt7853e3GD6jVyCQ>
    <xmx:1ir1aCc2pkb7OVVFQtBAozFw2QOIZcwvn3CRrRMd5MyPEvPUO6UyGw>
    <xmx:1ir1aLIdi7uDzDNmT1bsYvMwsq-bRWdgdVD9d3Ttlwdqk5zG_WdjvA>
    <xmx:2Cr1aCLfwG6EG_qCrCnV0Ape-_Ybv8MDGgld9Kr6VkSw4_jKaZ0frHzY>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 Oct 2025 14:15:48 -0400 (EDT)
Message-ID: <b0717e48-0879-4af8-bd31-11a239dea787@bsbernd.com>
Date: Sun, 19 Oct 2025 20:15:47 +0200
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
Content-Transfer-Encoding: 7bit



On 10/16/25 23:53, Bernd Schubert wrote:
> On 10/16/25 22:13, Joanne Koong wrote:
> And then 
> 
> bschubert2@imesrv3 ~>fio --directory=/tmp/dest --name=iops.\$jobnum --rw=randread --bs=4k --size=1G --numjobs=1 --iodepth=1 --time_based --runtime=30s --group_reporting --ioengine=psync --direct=1 
> 
> 
> With WF_CURRENT_CPU: READ: bw=269MiB/s
> With WF_SYNC:        READ: bw=214MiB/s
> With plain wake_up:  READ: bw=217MiB/s
> 

The culprit with plain wake might be here

             fio-7669    [011] d..2. 13916.272607: sched_switch: prev_comm=fio prev_pid=7669 prev_prio=120 prev_state=S ==> next_comm=swapper/11 next_pid=
...
          <idle>-0       [011] d.s4. 13916.281747: sched_waking: comm=kworker/11:1 pid=297 prio=120 target_cpu=011
          <idle>-0       [011] d.s4. 13916.281749: sched_waking_extended: comm=kworker/11:1 pid=297 prio=120 prev_cpu=011 current_cpu=011 target_cpu=011
          <idle>-0       [011] dNs5. 13916.281769: sched_wakeup: comm=kworker/11:1 pid=297 prio=120 target_cpu=011
          <idle>-0       [011] dNs5. 13916.281769: sched_wakeup_extended: comm=kworker/11:1 pid=297 prio=120 prev_cpu=011 current_cpu=011 target_cpu=011
          <idle>-0       [011] d..2. 13916.281779: sched_switch: prev_comm=swapper/11 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=kworker/11:1 nex
t_pid=297 next_prio=120
    kworker/11:1-297     [011] d.h3. 13916.282654: sched_waking: comm=fio pid=7669 prio=120 target_cpu=011
    kworker/11:1-297     [011] d.h3. 13916.282654: sched_waking_extended: comm=fio pid=7669 prio=120 prev_cpu=011 current_cpu=011 target_cpu=011
    kworker/11:1-297     [011] d.h3. 13916.282654: select_task_rq_fair <-select_task_rq
    kworker/11:1-297     [011] d.h3. 13916.282655: sched_migrate_task: comm=fio pid=7669 prio=120 orig_cpu=11 dest_cpu=26


==> migration from cpu=11 to cpu=26

    kworker/11:1-297     [011] d.h3. 13916.282657: sched_wake_idle_without_ipi: cpu=26
          <idle>-0       [026] dN.2. 13916.282686: sched_wakeup: comm=fio pid=7669 prio=120 target_cpu=026
          <idle>-0       [026] dN.2. 13916.282687: sched_wakeup_extended: comm=fio pid=7669 prio=120 prev_cpu=026 current_cpu=026 target_cpu=026
          <idle>-0       [026] d..2. 13916.282690: sched_switch: prev_comm=swapper/26 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=fio next_pid=766
9 next_prio=120
             fio-7669    [026] d..2. 13916.282717: sched_switch: prev_comm=fio prev_pid=7669 prev_prio=120 prev_state=S ==> next_comm=swapper/26 next_pid=


This is with added in sched_wakeup_extended() but prev_cpu is not
correctly assigned yet. Also not needed anymore as we can see
that migration is in in select_task_rq_fair/sched_migrate_task.




