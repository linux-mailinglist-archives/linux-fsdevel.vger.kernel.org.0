Return-Path: <linux-fsdevel+bounces-26947-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A0895D446
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 19:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 499AF283C5E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 17:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17494190067;
	Fri, 23 Aug 2024 17:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="bQn86fte"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15AB18BBB6
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 17:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724434300; cv=none; b=dn4EC3hu1tzNAVI6VuPta3yONHmTLAct0QIpIW79ZYmTOLkAFpMCdE/w+hSVnQvWg3NHe8AlprIC52hgTmEAMyGhMhd3o7drIGPD/nZRBZo/qNsohauSkg7JGykDTP9LYN1GuH4YHDdXMeCzIz0VzAq/4RguNzLpqtSfL7mf2n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724434300; c=relaxed/simple;
	bh=37UJ5ktzUpM2s4o2qkuvLFiCNbRe+VA93OyVjUFKmQ0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qUtD0NKEepdNqF5fGHahtGFZUy62kwHtwUVYH7TcKPy44uoLpiWlNBUhMGmIp5zjIImDubZCZdaYORd4G68h95+z9BJZ1ub3sxqPkZyrpB/XCb9Yd+TLjGCqpnM424cvzoSF2to1iCNx6JPcx9RTosCfl1iPIidoo4+xtsrG3MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=bQn86fte; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7141e20e31cso1908939b3a.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 10:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1724434297; x=1725039097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eeQuPlz37x3HMig2XWrJ2845o22KT6G97MEqYbYkWH0=;
        b=bQn86fte+GJxt3hZtg2ab7Iingz1vyVp2qmMVUAm88ehM1j4qkjaf6UJAIHJt9VxZe
         n1xRxYfJh48D1zJj6bSa9DhFrYauZ7JJEgd/9KG1MwtvAbUnDfr5xQhcLIZM++oGdyq/
         3wmrgxEKpfo7mSvoTLiZHB6npqp+8X101nARw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724434297; x=1725039097;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eeQuPlz37x3HMig2XWrJ2845o22KT6G97MEqYbYkWH0=;
        b=LhEj+8D5PXUERTvPyg/R6QPpov+7J7uhReNSEJEZzcxlm1Ck+wNLBj3xYM4tj+Kmge
         fstiw/lMPpYQ46F7fvJ9a/IwlmD/EBgLuZ8dvn+d8q7isqofJkQO5GnZOaOz+Fsyze3J
         jmv5FnbN4EAdlGjG3XZGblRkWZ8+ZZIhpb4LlZoVMkA2PkYyOuK+Kai69KOs7C5S2S5T
         5uLNP+PPJe9PLy0qK9/aS1fnL35wRE2872mYXszyHfVIkGB4JUucehyx/DCDkDOU7eaJ
         I+K/ziTHxhWvLl6X2tf5Ovp4W9eHABEKWzq5dQfPLRxLuw0wBtCbedEu/b6yqlNYmLdH
         Niqg==
X-Forwarded-Encrypted: i=1; AJvYcCXAiGSEB4YZuqHLH0fESEnT2xbj2NC9Un4/l3grZtE2TWJvGw9tyDCPBFXdI36XqyFNipuZ+pmzANdXRuZV@vger.kernel.org
X-Gm-Message-State: AOJu0YxWRXV+toy9Zfr5JTEmr1lzSXoIlvvKUz+YhSsvTSTCf35/FTA7
	yLrfHl/zxeDI4HOJw70St0m+HUpMfFysS+u0ppIGLnuk7LTl+NqwlLhYqRB3/gg=
X-Google-Smtp-Source: AGHT+IFiGZDebDEhRVXxls0kH5eh/QGsg4E9U/rLRj6nZ1Cbnm3i7xtDWufqJiKsumQ/B4XCt3Wfbw==
X-Received: by 2002:a05:6a00:228e:b0:70d:2892:402b with SMTP id d2e1a72fcca58-7144576effemr4199359b3a.7.1724434296633;
        Fri, 23 Aug 2024 10:31:36 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7143430964fsm3279624b3a.150.2024.08.23.10.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 10:31:36 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	sdf@fomichev.me,
	peter@typeblog.net,
	m2shafiei@uwaterloo.ca,
	bjorn@rivosinc.com,
	hch@infradead.org,
	willy@infradead.org,
	willemdebruijn.kernel@gmail.com,
	skhawaja@google.com,
	kuba@kernel.org,
	Joe Damato <jdamato@fastly.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	bpf@vger.kernel.org (open list:BPF [MISC]:Keyword:(?:\b|_)bpf(?:\b|_)),
	Breno Leitao <leitao@debian.org>,
	Christian Brauner <brauner@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jan Kara <jack@suse.cz>,
	Jiri Pirko <jiri@resnulli.us>,
	Johannes Berg <johannes.berg@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and infrastructure)),
	linux-kernel@vger.kernel.org (open list),
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Paolo Abeni <pabeni@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH net-next 0/6] Suspend IRQs during application busy periods
Date: Fri, 23 Aug 2024 17:30:51 +0000
Message-Id: <20240823173103.94978-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

This series introduces a new mechanism, IRQ suspension, which allows
network applications using epoll to mask IRQs during periods of high
traffic while also reducing tail latency (compared to existing
mechanisms, see below) during periods of low traffic. In doing so, this
balances CPU consumption with network processing efficiency.

Martin Karsten (CC'd) and I have been collaborating on this series for
several months and have appreciated the feedback from the community on
our RFC [1]. We've updated the cover letter and kernel documentation in
an attempt to more clearly explain how this mechanism works, how
applications can use it, and how it compares to existing mechanisms in
the kernel. We've added an additional test case, 'fullbusy', achieved by
modifying libevent for comparison. See below for a detailed description,
link to the patch, and test results.

I briefly mentioned this idea at netdev conf 2024 (for those who were
there) and Martin described this idea in an earlier paper presented at
Sigmetrics 2024 [2].

~ The short explanation (TL;DR)

We propose adding a new sysfs parameter: irq_suspend_timeout to help
balance CPU usage and network processing efficiency when using IRQ
deferral and napi busy poll.

If this parameter is set to a non-zero value *and* a user application
has enabled preferred busy poll on a busy poll context (via the
EPIOCSPARAMS ioctl introduced in commit 18e2bf0edf4d ("eventpoll: Add
epoll ioctl for epoll_params")), then application calls to epoll_wait
for that context will cause device IRQs and softirq processing to be
suspended as long as epoll_wait successfully retrieves data from the
NAPI. Each time data is retrieved, the irq_suspend_timeout is deferred.

If/when network traffic subsides and epoll_wait returns no data, IRQ
suspension is immediately reverted back to the existing
napi_defer_hard_irqs and gro_flush_timeout mechanism which was
introduced in commit 6f8b12d661d0 ("net: napi: add hard irqs deferral
feature")).

The irq_suspend_timeout serves as a safety mechanism. If userland takes
a long time processing data, irq_suspend_timeout will fire and restart
normal NAPI processing.

For a more in depth explanation, please continue reading.

~ Comparison with existing mechanisms

Interrupt mitigation can be accomplished in napi software, by setting
napi_defer_hard_irqs and gro_flush_timeout, or via interrupt coalescing
in the NIC. This can be quite efficient, but in both cases, a fixed
timeout (or packet count) needs to be configured. However, a fixed
timeout cannot effectively support both low- and high-load situations:

At low load, an application typically processes a few requests and then
waits to receive more input data. In this scenario, a large timeout will
cause unnecessary latency.

At high load, an application typically processes many requests before
being ready to receive more input data. In this case, a small timeout
will likely fire prematurely and trigger irq/softirq processing, which
interferes with the application's execution. This causes overhead, most
likely due to cache contention.

While NICs attempt to provide adaptive interrupt coalescing schemes,
these cannot properly take into account application-level processing.

An alternative packet delivery mechanism is busy-polling, which results
in perfect alignment of application processing and network polling. It
delivers optimal performance (throughput and latency), but results in
100% cpu utilization and is thus inefficient for below-capacity
workloads.

We propose to add a new packet delivery mode that properly alternates
between busy polling and interrupt-based delivery depending on busy and
idle periods of the application. During a busy period, the system
operates in busy-polling mode, which avoids interference. During an idle
period, the system falls back to interrupt deferral, but with a small
timeout to avoid excessive latencies. This delivery mode can also be
viewed as an extension of basic interrupt deferral, but alternating
between a small and a very large timeout.

This delivery mode is efficient, because it avoids softirq execution
interfering with application processing during busy periods. It can be
used with blocking epoll_wait to conserve cpu cycles during idle
periods. The effect of alternating between busy and idle periods is that
performance (throughput and latency) is very close to full busy polling,
while cpu utilization is lower and very close to interrupt mitigation.

~ Usage details

IRQ suspension is introduced via a sysfs parameter that controls the
maximum time that IRQs can be suspended.

Here's how it is intended to work:
  - An administrator sets the existing sysfs parameters for
    napi_defer_hard_irqs and gro_flush_timeout to enable IRQ deferral.

  - An administrator sets the new sysfs parameter irq_suspend_timeout
    to a larger value than gro_flush_timeout to enable IRQ suspension.

  - The user application issues the existing epoll ioctl to set the
    prefer_busy_poll flag on the epoll context.

  - The user application then calls epoll_wait to busy poll for network
    events, as it normally would.

  - If epoll_wait returns events to userland, IRQs are suspended for the
    duration of irq_suspend_timeout.

  - If epoll_wait finds no events and the thread is about to go to
    sleep, IRQ handling using napi_defer_hard_irqs and gro_flush_timeout
    is resumed.

As long as epoll_wait is retrieving events, IRQs (and softirq
processing) for the NAPI being polled remain disabled. When network
traffic reduces, eventually a busy poll loop in the kernel will retrieve
no data. When this occurs, regular IRQ deferral using gro_flush_timeout
for the polled NAPI is re-enabled.

Unless IRQ suspension is continued by subsequent calls to epoll_wait, it
automatically times out after the irq_suspend_timeout timer expires.
Regular deferral is also immediately re-enabled when the epoll context
is destroyed.

~ Usage scenario

The target scenario for IRQ suspension as packet delivery mode is a
system that runs a dominant application with substantial network I/O.
The target application can be configured to receive input data up to a
certain batch size (via epoll_wait maxevents parameter) and this batch
size determines the worst-case latency that application requests might
experience. Because packet delivery is suspended during the target
application's processing, the batch size also determines the worst-case
latency of concurrent applications.

gro_flush_timeout should be set as small as possible, but large enough to
make sure that a single request is likely not being interfered with.

irq_suspend_timeout is largely a safety mechanism against misbehaving
applications. It should be set large enough to cover the processing of an
entire application batch, i.e., the factor between gro_flush_timeout and
irq_suspend_timeout should roughly correspond to the maximum batch size
that the target application would process in one go.

~ Design rationale

The implementation of the IRQ suspension mechanism very nicely dovetails
with the existing mechanism for IRQ deferral when preferred busy poll is
enabled (introduced in commit 7fd3253a7de6 ("net: Introduce preferred
busy-polling"), see that commit message for more details).
  
The existing IRQ deferral mechanism works together with our proposal,
and as such, it seems natural to put irq_suspend_time at the same level
of napi_defer_hard_irqs and gro_flush_timeout as a per-device sysfs
parameter with the hope that these parameters will eventually be
migrated to per-napi settings.

While it would be possible to inject the suspend timeout via
the existing epoll ioctl, it is more natural to avoid this path for two
reasons:
  
1. Using a sysfs parameter ensures admin oversight for using the
   mechanism and its configuration based on overall system objectives
  
2. An epoll context is linked to NAPI IDs as file descriptors are added;
   this means any epoll context might suddenly be associated with a
   different net_device if the application were to replace all existing
   fds with fds from a different device. In this case, the scope of the
   suspend timeout becomes unclear and many edge cases for both the user
   application and the kernel are introduced

Only a single iteration through napi busy polling is needed for this
mechanism to work effectively. Since an important objective for this
mechanism is preserving cpu cycles, exactly one iteration of the napi
busy loop is invoked when busy_poll_usecs is set to 0.

~ Important call outs in the implementation

  - Enabling per epoll-context preferred busy poll will now effectively
    lead to a nonblocking iteration through napi_busy_loop, even when
    busy_poll_usecs is 0. See patch 4.

  - Patches apply cleanly on commit d785ed945de6 ("net: wwan: t7xx: PCIe
    reset rescan"). When commit b4988e3bd1f0 ("eventpoll: Annotate
    data-race of busy_poll_usecs") is picked up from the vfs folks, there
    will be a very minor merge conflict with patch 4. patch 4 already
    includes the fix picked up vfs, but modifies the same line by adding an
    extra conditional.

  - In the future, time permitting, I hope to enable support for
    napi_defer_hard_irqs, gro_flush_timeout (introduced in commit
    6f8b12d661d0 ("net: napi: add hard irqs deferral feature")), and
    irq_suspend_timeout (introduced in this series) on a per-NAPI basis
    (presumably via netdev-genl).

~ Benchmark configs & descriptions

The changes were benchmarked with memcached [3] using the benchmarking
tool mutilate [4].

To facilitate benchmarking, a small patch [5] was applied to memcached
1.6.29 (the latest memcached release as of this submission) to allow
setting per-epoll context preferred busy poll and other settings via
environment variables. Another small patch [6] was applied to libevent
to enable full busy-polling.

Multiple scenarios were benchmarked as described below and the scripts
used for producing these results can be found on github [7] (note: all
scenarios use NAPI-based traffic splitting via SO_INCOMING_ID by passing
-N to memcached):

  - base:
    - no other options enabled
  - deferX:
    - set defer_hard_irqs to 100
    - set gro_flush_timeout to X,000
  - napibusy:
    - set defer_hard_irqs to 100
    - set gro_flush_timeout to 200,000
    - enable busy poll via the existing ioctl (busy_poll_usecs = 64,
      busy_poll_budget = 64, prefer_busy_poll = true)
  - fullbusy:
    - set defer_hard_irqs to 100
    - set gro_flush_timeout to 5,000,000
    - enable busy poll via the existing ioctl (busy_poll_usecs = 1000,
      busy_poll_budget = 64, prefer_busy_poll = true)
    - change memcached's nonblocking epoll_wait invocation (via
      libevent) to using a 1 ms timeout
  - suspendX:
    - set defer_hard_irqs to 100
    - set gro_flush_timeout to X,000
    - set irq_suspend_timeout to 20,000,000
    - enable busy poll via the existing ioctl (busy_poll_usecs = 0,
      busy_poll_budget = 64, prefer_busy_poll = true)

~ Benchmark results

Tested on:

Single socket AMD EPYC 7662 64-Core Processor
Hyperthreading disabled
4 NUMA Zones (NPS=4)
16 CPUs per NUMA zone (64 cores total)
2 x Dual port 100gbps Mellanox Technologies ConnectX-5 Ex EN NIC

The test machine is configured such that a single interface has 8 RX
queues. The queues' IRQs and memcached are pinned to CPUs that are
NUMA-local to the interface which is under test. The NIC's interrupt
coalescing configuration is left at boot-time defaults.

Results:

Results are shown below. The mechanism added by this series is
represented by the 'suspend' cases. Data presented shows a summary over
10 runs of each test case [8] using the scripts on github [7]. For,
latency the median of the 10 runs is shown. For throughput and CPU
utilization, the average is shown.

These results were captured using the scripts on github [7] to
illustrate how this approach compares with other pre-existing
mechanisms. This data is not to be interpreted as scientific data
captured in a fully isolated lab setting, but instead as best effort,
illustrative information comparing and contrasting tradeoffs.

Compare:
- Throughput (MAX) and latencies of base vs suspend.
- CPU usage of napibusy and fullbusy during lower load (200K, 400K for
  example) vs suspend.
- Latency of the defer variants vs suspend as timeout and load
  increases.

The overall takeaway is that the suspend variants provide a superior
combination of high throughput, low latency, and low cpu utilization
compared to all other variants. Each of the suspend variants works very
well, but some fine-tuning between latency and cpu utilization is still
possible by tuning the small timeout (gro_flush_timeout).

base
  load     qps  avglat  95%lat  99%lat     cpu
  200K  200042     113     234     416      28
  400K  399983     141     271     730      42
  600K  599951     162     386     712      64
  800K  800057     350    1151    2278      84
 1000K  962651    4168    5980    7611      99
   MAX  982241    4426    5809    7317      99

defer10
  load     qps  avglat  95%lat  99%lat     cpu
  200K  200025      53     119     140      31
  400K  400064      59     131     156      53
  600K  599930      72     146     204      76
  800K  800002     656    3236    5455      97
 1000K  887890    4806    6288    8568      99
   MAX  914970    4863    6008    6361     100

defer20
  load     qps  avglat  95%lat  99%lat     cpu
  200K  199971      59     122     149      26
  400K  400029      67     139     167      46
  600K  599985      78     152     195      68
  800K  799931     250    1009    2481      89
 1000K  896278    4662    5876    6422      99
   MAX  966120    4549    5652    6076     100

defer50
  load     qps  avglat  95%lat  99%lat     cpu
  200K  200005      78     133     175      22
  400K  400000      88     159     192      39
  600K  600067      97     173     214      58
  800K  799933     177     519    1302      81
 1000K  948784    4378    6078    8941      98
   MAX 1015637    4358    5354    6365     100

defer200
  load     qps  avglat  95%lat  99%lat     cpu
  200K  200025     164     255     304      18
  400K  399964     182     276     331      34
  600K  599924     204     303     361      48
  800K  800013     253     401     727      73
 1000K  979727    3380    5690    7648      98
   MAX 1022960    4322    5598    6652     100

fullbusy
  load     qps  avglat  95%lat  99%lat     cpu
  200K  200000      47     113     129     100
  400K  400071      51     123     148     100
  600K  599942      58     128     176     100
  800K  799966      65     138     191     100
 1000K 1000099      83     167     233     100
   MAX 1159578    3797    4281    4371     100

napibusy
  load     qps  avglat  95%lat  99%lat     cpu
  200K  200022     100     238     272      56
  400K  399897      77     223     273      83
  600K  600077      65     158     255      96
  800K  800007      74     147     237      99
 1000K  999992      88     173     242     100
   MAX 1067116    4060    5903   10231      99

suspend10
  load     qps  avglat  95%lat  99%lat     cpu
  200K  199984      51     119     139      32
  400K  400077      56     127     153      51
  600K  599944      64     137     190      69
  800K  800012      71     145     200      84
 1000K 1000031      95     183     300      94
   MAX 1146106    3852    4313    4462     100

suspend20
  load     qps  avglat  95%lat  99%lat     cpu
  200K  199966      57     120     146      29
  400K  400016      61     133     158      47
  600K  599997      68     141     187      65
  800K  800057      77     153     210      81
 1000K 1000059     107     191     397      92
   MAX 1150835    3813    4284    4373     100

suspend50
  load     qps  avglat  95%lat  99%lat     cpu
  200K  199940      72     125     170      25
  400K  399981      76     145     184      42
  600K  600054      82     157     201      58
  800K  799940      93     175     352      75
 1000K 1000000     108     200     269      89
   MAX 1139291    3834    4330    4383     100

suspend200
  load     qps  avglat  95%lat  99%lat     cpu
  200K  199983     149     250     298      19
  400K  399968     155     270     326      35
  600K  599982     159     285     348      51
  800K  800079     162     297     361      67
 1000K  999944     175     311     392      84
   MAX 1128863    3891    4334    4383     100

~ FAQ

  - Can the new timeout value be threaded through the new epoll ioctl ?

    Only with difficulty. The epoll ioctl sets options on an epoll
    context and the NAPI ID associated with an epoll context can change
    based on what file descriptors a user app adds to the epoll context.
    This would introduce complexity in the API from the user perspective
    and also complexity in the kernel.

    This new sysfs parameter, which is similar to and used in
    combination with napi_defer_hard_irqs and gro_flush_timeout should
    be exposed to users in the same way: via sysfs.

    At some point in the future, per-NAPI support for
    napi_defer_hard_irqs, gro_flush_timeout, and irq_suspend_timeout
    (presumably via netdev-genl) can be added.

  - Can irq suspend be built by combining NIC coalescing and
    gro_flush_timeout ?

    No. The problem is that the long timeout must engage if and only if
    prefer-busy is active.

    When using NIC coalescing for the short timeout (without
    napi_defer_hard_irqs/gro_flush_timeout), an interrupt after an idle
    period will trigger softirq, which will run napi polling. At this
    point, prefer-busy is not active, so NIC interrupts would be
    re-enabled. Then it is not possible for the longer timeout to
    interject to switch control back to polling. In other words, only by
    using the software timer for the short timeout, it is possible to
    extend the timeout without having to reprogram the NIC timer or
    reach down directly and disable interrupts.

    Using gro_flush_timeout for the long timeout also has problems, for
    the same underlying reason. In the current napi implementation,
    gro_flush_timeout is not tied to prefer-busy. We'd either have to
    change that and in the process modify the existing deferral
    mechanism, or introduce a state variable to determine whether
    gro_flush_timeout is used as long timeout for irq suspend or whether
    it is used for its default purpose. In an earlier version, we did
    try something similar to the latter and made it work, but it ends up
    being a lot more convoluted than our current proposal.

  - Isn't it already possible to combine busy looping with irq deferral?

    Yes, in fact enabling irq deferral via napi_defer_hard_irqs and
    gro_flush_timeout is a precondition for prefer_busy_poll to have an
    effect. If the application also uses a tight busy loop with
    essentially nonblocking epoll_wait (accomplished with a very short
    timeout parameter), this is the fullbusy case shown in the results.
    An application using blocking epoll_wait is shown as the napibusy
    case in the result. It's a hybrid approach that provides limited
    latency benefits compared to the base case and plain irq deferral,
    but not as good as fullbusy or suspend.

~ Special thanks

Several people were involved in earlier stages of the development of this
mechanism whom we'd like to thank:

  - Peter Cai (CC'd), for the initial kernel patch and his contributions
    to the paper.
    
  - Mohammadamin Shafie (CC'd), for testing various versions of the kernel
    patch and providing helpful feedback.

Thanks,
Martin and Joe

[1]: https://lore.kernel.org/netdev/20240812125717.413108-1-jdamato@fastly.com/
[2]: https://doi.org/10.1145/3626780
[3]: https://github.com/memcached/memcached/blob/master/doc/napi_ids.txt
[4]: https://github.com/leverich/mutilate
[5]: https://raw.githubusercontent.com/martinkarsten/irqsuspend/main/patches/memcached.patch
[6]: https://raw.githubusercontent.com/martinkarsten/irqsuspend/main/patches/libevent.patch
[7]: https://github.com/martinkarsten/irqsuspend
[8]: https://github.com/martinkarsten/irqsuspend/tree/main/results

rfc -> v1:
  - Cover letter updated to include more details.
  - Patch 1 updated to remove the documentation added. This was moved to
    patch 6 with the rest of the docs (see below).
  - Patch 5 updated to fix an error uncovered by the kernel build robot.
    See patch 5's changelog for more details.
  - Patch 6 added which updates kernel documentation.

Joe Damato (1):
  docs: networking: Describe irq suspension

Martin Karsten (5):
  net: Add sysfs parameter irq_suspend_timeout
  net: Suspend softirq when prefer_busy_poll is set
  net: Add control functions for irq suspension
  eventpoll: Trigger napi_busy_loop, if prefer_busy_poll is set
  eventpoll: Control irq suspension for prefer_busy_poll

 Documentation/networking/napi.rst | 112 +++++++++++++++++++++++++++++-
 fs/eventpoll.c                    |  34 ++++++++-
 include/linux/netdevice.h         |   2 +
 include/net/busy_poll.h           |   3 +
 net/core/dev.c                    |  53 ++++++++++++--
 net/core/net-sysfs.c              |  18 +++++
 6 files changed, 213 insertions(+), 9 deletions(-)

-- 
2.25.1


