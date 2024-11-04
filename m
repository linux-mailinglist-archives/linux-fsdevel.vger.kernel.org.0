Return-Path: <linux-fsdevel+bounces-33632-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F8D9BC069
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2024 22:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68EABB218B4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2024 21:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242801FCF71;
	Mon,  4 Nov 2024 21:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="t73YnmV9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56CB14B94F
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Nov 2024 21:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730757402; cv=none; b=rqgLHtiS45C1C6TojmMA0QIhdFqoN/jWKcBkQgeDUgb90TYVhEkhtG6tnoHQkLivuyMVV446uuqrjunkS3sfC0RHeBKyJElEfVFvF9Wh2ZOXy38jBhMMFNvVazEBEfx72a9JD4LuPw1xLhkClX0DizBMqVujXeVIAUdh5WoAdqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730757402; c=relaxed/simple;
	bh=k1oGRIXA8Ds6UKlUpkxjefln+dZPYbrZn2dXyfrpmiA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kvpY/ogJajpKHjQ74Fypp0Jwhfhgn3rObOV8ZRkYayMrAuKoJ58Ghvv7aRQ1Ppjx4+AXOspG6UtQ6F47jL/kmG+HP5Og/ymF0QTIyPHrTa+QwMIMy+agweMBJVv7a9zErT5JS7bR3YDqPGHK7f84J6lJnk2hTl0vHruARHy3Vws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=t73YnmV9; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7ee7e87f6e4so1379659a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Nov 2024 13:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730757399; x=1731362199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9ZC1oVr2fCU3XgjL+8JL28Xe2ps6/LkM4EsQAD6p33o=;
        b=t73YnmV9rRAMGRg2RlyiekFSbXI7TDgPr9JPH/SxfMvw4EaMcK18pmlRwDPmdnSyA8
         2/nW9JRAq+RP96PkAhfaGwMveFHrLkHEPm1QJN9eCFsnLXIKrXKsODuke+AA7Ba7FEcJ
         IRsQh+dMuy0mH/VPMYKhFEsI7VcLCLdOJqYfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730757399; x=1731362199;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ZC1oVr2fCU3XgjL+8JL28Xe2ps6/LkM4EsQAD6p33o=;
        b=bYFn0MVRXPOVMwvRXbPKwNA7vgJmNORe/gZjlwLneakDtWLR5zdf201dBOvEZQwoJ1
         TRLsA8uzwCJXwzsdnnKyQgMtGkNbwwou3A9VYNsYNBogd/TkiPEcmwfLx8XZlQQXqyco
         EzqB4Mz83SEiPp/dDBMXDZpp3Dg3NSUF7LCnlGoqrkgXDTE1kJHhZo/KsB+DKcl+8j/X
         AkOpRGg6levmhLZFmrC7xC4/SSH2uWtw7TFnXKkqSs9P2pDGgc+FehabT2RDosfrIU8V
         9HkD/7/ZNJJzCUmeg035Dsj0QjmOkjjuy8DyfqSy1cBHmgu95GKRATFdtwKZzkvREvIh
         5sRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSeqyGKOXMzBKAhJcyIEosdV8V31VTdUb+HhprwbEciR/Ex/HVbh6dWFYy3NQSVhXDkgLGatstbjVA+Je7@vger.kernel.org
X-Gm-Message-State: AOJu0YwfOsZ6mvxbUr1VHL5Y2P8+3Yvi6MIanlVetYpv4pvcBhQMU9Mf
	nC/l0rmswG1smt0dgLz1JEbedsH0zqhsQ/TL+qwlI+gN+vIhjVaBOTpLdkouu9M=
X-Google-Smtp-Source: AGHT+IHjvil0X8OrLeTgvG5WefwkCoXtDBNXDk7hl7zwVK1E7VQZJUbvOpUSonPCpcogcelNJcC2DA==
X-Received: by 2002:a17:903:11c5:b0:20b:b40b:3454 with SMTP id d9443c01a7336-2111ae2bebemr156452485ad.0.1730757398937;
        Mon, 04 Nov 2024 13:56:38 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057062b8sm65860255ad.63.2024.11.04.13.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 13:56:38 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: corbet@lwn.net,
	hdanton@sina.com,
	bagasdotme@gmail.com,
	pabeni@redhat.com,
	namangulati@google.com,
	edumazet@google.com,
	amritha.nambiar@intel.com,
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
	Andrew Lunn <andrew+netdev@lunn.ch>,
	bpf@vger.kernel.org (open list:BPF [MISC]:Keyword:(?:\b|_)bpf(?:\b|_)),
	Christian Brauner <brauner@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Johannes Berg <johannes.berg@intel.com>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and infrastructure)),
	linux-kernel@vger.kernel.org (open list),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Mina Almasry <almasrymina@google.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH net-next v6 0/7] Suspend IRQs during application busy periods
Date: Mon,  4 Nov 2024 21:55:24 +0000
Message-Id: <20241104215542.215919-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

Welcome to v6, see changelog below. This revision includes only
documentation changes: patch 7 has been updated with Bagas' suggestions
and the htmldoc looks better as a result. In addition, this cover letter
has been updated with a full re-run of the test data. We've included a
new test case highlighting a case Sridhar asked about in our v3. See
below.

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

We propose adding a new napi config parameter: irq_suspend_timeout to
help balance CPU usage and network processing efficiency when using IRQ
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

IRQ suspension is introduced via a per-NAPI configuration parameter that
controls the maximum time that IRQs can be suspended.

Here's how it is intended to work:
  - The user application (or system administrator) uses the netdev-genl
    netlink interface to set the pre-existing napi_defer_hard_irqs and
    gro_flush_timeout NAPI config parameters to enable IRQ deferral.

  - The user application (or system administrator) sets the proposed
    irq_suspend_timeout parameter via the netdev-genl netlink interface
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
latency of concurrent applications using the same RX queue(s).

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

While it would be possible to inject the suspend timeout via
the existing epoll ioctl, it is more natural to avoid this path for one
main reason:

  An epoll context is linked to NAPI IDs as file descriptors are added;
  this means any epoll context might suddenly be associated with a
  different net_device if the application were to replace all existing
  fds with fds from a different device. In this case, the scope of the
  suspend timeout becomes unclear and many edge cases for both the user
  application and the kernel are introduced

Only a single iteration through napi busy polling is needed for this
mechanism to work effectively. Since an important objective for this
mechanism is preserving cpu cycles, exactly one iteration of the napi
busy loop is invoked when busy_poll_usecs is set to 0.

~ Important call out in the implementation

  - Enabling per epoll-context preferred busy poll will now effectively
    lead to a nonblocking iteration through napi_busy_loop, even when
    busy_poll_usecs is 0. See patch 4.

~ Benchmark configs & descriptions

The changes were benchmarked with memcached [3] using the benchmarking
tool mutilate [4].

To facilitate benchmarking, a small patch [5] was applied to memcached
1.6.29 to allow setting per-epoll context preferred busy poll and other
settings via environment variables. Another small patch [6] was applied
to libevent to enable full busy-polling.

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
  - suspend0:
    - set defer_hard_irqs to 0
    - set gro_flush_timeout to 0
    - set irq_suspend_timeout to 20,000,000
    - enable busy poll via the existing ioctl (busy_poll_usecs = 0,
      busy_poll_budget = 64, prefer_busy_poll = true)
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
at least 15 runs of each test case [8] using the scripts on github [7].
For latency, the median is shown. For throughput and CPU utilization,
the average is shown.

The results also include cycles-per-query (cpq) and
instruction-per-query (ipq) metrics, following the methodology proposed
in [2], to augment the CPU utilization numbers, which could be skewed
due to frequency scaling. We find that this does not appear to be the
case as CPU utilization and low-level metrics show similar trends.

These results were captured using the scripts on github [7] to
illustrate how this approach compares with other pre-existing
mechanisms. This data is not to be interpreted as scientific data
captured in a fully isolated lab setting, but instead as best effort,
illustrative information comparing and contrasting tradeoffs.

The absolute QPS results are higher than our previous submission, but
the relative differences between variants are equivalent. Because the
patches have been rebased on 6.12, several factors have likely
influenced the overall performance. Most importantly, we had to switch
to a new set of basic kernel options, which has likely altered the
baseline performance. Because the overall comparison of variants still
holds, we have not attempted to recreate the exact set of kernel options
from the previous submission.

Compare:
- Throughput (MAX) and latencies of base vs suspend.
- CPU usage of napibusy and fullbusy during lower load (200K, 400K for
  example) vs suspend.
- Latency of the defer variants vs suspend as timeout and load
  increases.
- suspend0, which sets defer_hard_irqs and gro_flush_timeout to 0, has
  nearly the same performance as the base case (this is FAQ item #1).

The overall takeaway is that the suspend variants provide a superior
combination of high throughput, low latency, and low cpu utilization
compared to all other variants. Each of the suspend variants works very
well, but some fine-tuning between latency and cpu utilization is still
possible by tuning the small timeout (gro_flush_timeout).

Note: we've reorganized the results to make comparison among testcases
with the same load easier.

  testcase  load     qps  avglat  95%lat  99%lat     cpu     cpq     ipq
      base  200K  199954     112     237     415      26   13040   11336
   defer10  200K  200002      54     123     142      28   19033   16508
   defer20  200K  199985      60     130     153      26   15737   14247
   defer50  200K  199968      78     142     181      23   12113   11609
  defer200  200K  199997     163     252     304      18    8449    9155
  fullbusy  200K  199993      46     117     132     100   43959   23320
  napibusy  200K  200006     100     237     275      56   25016   24866
  suspend0  200K  200012     105     249     432      29   14369   11844
 suspend10  200K  200004      53     123     141      32   19432   16752
 suspend20  200K  200014      58     126     151      30   16356   14670
 suspend50  200K  200018      73     134     176      26   13245   12416
suspend200  200K  200027     149     250     302      20    9508    9781

  testcase  load     qps  avglat  95%lat  99%lat     cpu     cpq     ipq
      base  400K  399984     139     268     715      40    9437    9299
   defer10  400K  400002      59     133     165      53   14089   12908
   defer20  400K  400016      66     140     171      47   12085   11682
   defer50  400K  400037      87     161     198      39    9528    9879
  defer200  400K  399954     181     273     329      32    7326    8438
  fullbusy  400K  399951      50     123     155     100   21990   16097
  napibusy  400K  399997      76     221     271      83   18260   16511
  suspend0  400K  399991     125     337     768      48   11051    9629
 suspend10  400K  399990      57     129     161      54   13629   12841
 suspend20  400K  399922      61     135     167      49   12055   11715
 suspend50  400K  400024      75     148     186      42   10049   10243
suspend200  400K  399936     154     267     325      34    7770    8677

  testcase  load     qps  avglat  95%lat  99%lat     cpu     cpq     ipq
      base  600K  600064     148     265     576      61    9276    8757
   defer10  600K  599985      71     147     204      76   12048   10863
   defer20  600K  600024      75     151     199      66   10572   10328
   defer50  600K  600054      94     172     217      55    8584    9144
  defer200  600K  600030     200     299     355      45    6874    8189
  fullbusy  600K  599956      55     127     176     100   14650   13968
  napibusy  600K  599956      64     163     252      96   14022   14153
  suspend0  600K  600029     126     306     724      70   10393    8977
 suspend10  600K  599997      63     137     194      70   10991   11005
 suspend20  600K  600012      67     141     194      65   10108   10359
 suspend50  600K  600045      80     157     203      57    8747    9320
suspend200  600K  599940     158     277     344      48    7221    8354

  testcase  load     qps  avglat  95%lat  99%lat     cpu     cpq     ipq
      base  800K  800025     179     298     555      86    9572    8297
   defer10  800K  799275     224     633    1271      96   10679    8904
   defer20  800K  800041     114     226     328      90   10122    8917
   defer50  800K  799936     118     207     288      77    8820    8607
  defer200  800K  799994     228     341     403      65    7424    8130
  fullbusy  800K  799964      62     136     192     100   10992   12518
  napibusy  800K  799971      65     142     216      99   10911   12529
  suspend0  800K  799965     126     250     533      86    9489    8496
 suspend10  800K  799995      69     145     201      83    9475    9764
 suspend20  800K  799931      74     151     209      79    8976    9336
 suspend50  800K  799946      87     168     224      71    7993    8794
suspend200  800K  799993     160     292     357      62    6967    8184

  testcase  load     qps  avglat  95%lat  99%lat     cpu     cpq     ipq
      base 1000K  915792    3498    5740    6239      97    9388    7930
   defer10 1000K  876285    3896    6095    6418      99    9960    8542
   defer20 1000K  914909    3107    5771    6283      97    9407    8284
   defer50 1000K  928426    2977    5591    5931      97    9214    8012
  defer200 1000K  959989    3097    5306    5929      96    8816    7908
  fullbusy 1000K 1000102      74     155     213     100    8796   10559
  napibusy 1000K 1000006      74     154     216     100    8787   10654
  suspend0 1000K  960757    2223    5715    7029      98    8964    7993
 suspend10 1000K  999926      80     162     222      92    8246    8922
 suspend20 1000K 1000095      85     166     226      89    7966    8719
 suspend50 1000K 1000067      96     180     238      84    7476    8419
suspend200 1000K  999968     163     298     363      76    6798    8061

  testcase  load     qps  avglat  95%lat  99%lat     cpu     cpq     ipq
      base   MAX 1054805    4152    5298    5743     100    8332    7890
   defer10   MAX  937098    4598    6010    6347     100    9378    8407
   defer20   MAX  988905    4389    5637    5990     100    8886    8106
   defer50   MAX 1067194    3960    5216    5544     100    8235    7911
  defer200   MAX 1054967    4084    5496    5821     100    8323    7871
  fullbusy   MAX 1248006    3472    3918    3979     100    7050    7919
  napibusy   MAX 1128384    3742    7958   10753     100    7776    7872
  suspend0   MAX 1034456    4242    5668    6042     100    8497    7912
 suspend10   MAX 1229229    3513    3926    3986     100    7156    7937
 suspend20   MAX 1226845    3514    3939    3985     100    7171    7937
 suspend50   MAX 1230757    3513    3935    3983     100    7140    7935
suspend200   MAX 1230424    3503    3934    3984     100    7142    7927

~ FAQ

  - Why is a new parameter needed? Does irq_suspend_timeout override
    gro_flush_timeout?

    Using the suspend mechanism causes the system to alternate between
    polling mode and irq-driven packet delivery. During busy periods,
    irq_suspend_timeout overrides gro_flush_timeout and keeps the system
    busy polling, but when epoll finds no events, the setting of
    gro_flush_timeout and napi_defer_hard_irqs determine the next step.

    There are essentially three possible loops for network processing and
    packet delivery:

    1) hardirq -> softirq -> napi poll; basic interrupt delivery
    2) timer -> softirq -> napi poll; deferred irq processing
    3) epoll -> busy-poll -> napi poll; busy looping

    Loop 2 can take control from Loop 1, if gro_flush_timeout and
    napi_defer_hard_irqs are set.

    If gro_flush_timeout and napi_defer_hard_irqs are set, Loops 2 and
    3 "wrestle" with each other for control. During busy periods,
    irq_suspend_timeout is used as timer in Loop 2, which essentially
    tilts this in favour of Loop 3.

    If gro_flush_timeout and napi_defer_hard_irqs are not set, Loop 3
    cannot take control from Loop 1.

    Therefore, setting gro_flush_timeout and napi_defer_hard_irqs is the
    recommended usage, because otherwise setting irq_suspend_timeout
    might not have any discernible effect.

    This is shown in the results above: compare suspend0 with the base
    case. Note that the lack of napi_defer_hard_irqs and
    gro_flush_timeout produce similar results for both, which encourages
    the use of napi_defer_hard_irqs and gro_flush_timeout in addition to
    irq_suspend_timeout.

  - Can the new timeout value be threaded through the new epoll ioctl ?

    Only with difficulty. The epoll ioctl sets options on an epoll
    context and the NAPI ID associated with an epoll context can change
    based on what file descriptors a user app adds to the epoll context.
    This would introduce complexity in the API from the user perspective
    and also complexity in the kernel.

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
    case in the results. It's a hybrid approach that provides limited
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

v6:
  - Updated the cover letter with a full re-run of all test cases,
    including a new case suspend0, as requested by Sridhar previously.
  - Updated the kernel documentation in patch 7 as suggested by Bagas
    Sanjaya, which improved the htmldoc output.

v5: https://lore.kernel.org/netdev/20241103052421.518856-1-jdamato@fastly.com/
  - Adjusted patch 5 to only suspend IRQs when ep_send_events returns a
    positive return value. This issue was pointed out by Hillf Danton.
  - Updated the commit message of patch 6 which still mentioned netcat,
    despite the code being updated in v4 to replace it with socat and fixed
    misspelling of netdevsim.
  - Fixed a minor typo in patch 7 and removed an unnecessary paragraph.
  - Added Sridhar Samudrala's Reviewed-by to patch 1-5 and 7.

v4: https://lore.kernel.org/netdev/20241102005214.32443-1-jdamato@fastly.com/
  - Added a new FAQ item to cover letter.
  - Updated patch 6 to use socat instead of nc in busy_poll_test.sh and
    updated busy_poller.c to use netlink directly to configure napi
    params.
  - Updated the kernel documentation in patch 7 to include more details.
  - Dropped Stanislav's Acked-by and Bagas' Reviewed-by from patch 7
    since the documentation was updated.

v3: https://lore.kernel.org/netdev/20241101004846.32532-1-jdamato@fastly.com/
  - Added Stanislav Fomichev's Acked-by to every patch except the newly
    added selftest.
  - Added Bagas Sanjaya's Reviewed-by to the documentation patch.
  - Fixed the commit message of patch 2 to remove a reference to the now
    non-existent sysfs setting.
  - Added a self test which tests both "regular" busy poll and busy poll
    with suspend enabled. This was added as patch 6 as requested by
    Paolo. netdevsim was chosen instead of veth due to netdevsim's
    pre-existing support for netdev-genl. See the commit message of
    patch 6 for more details.

v2: https://lore.kernel.org/bpf/20241021015311.95468-1-jdamato@fastly.com/
  - Cover letter updated, including a re-run of test data.
  - Patch 1 rewritten to use netdev-genl instead of sysfs.
  - Patch 3 updated with a comment added to napi_resume_irqs.
  - Patch 4 rebased to apply now that commit b9ca079dd6b0 ("eventpoll:
    Annotate data-race of busy_poll_usecs") has been picked up from VFS.
  - Patch 6 updated the kernel documentation.

rfc -> v1:
  - Cover letter updated to include more details.
  - Patch 1 updated to remove the documentation added. This was moved to
    patch 6 with the rest of the docs (see below).
  - Patch 5 updated to fix an error uncovered by the kernel build robot.
    See patch 5's changelog for more details.
  - Patch 6 added which updates kernel documentation.

Joe Damato (2):
  selftests: net: Add busy_poll_test
  docs: networking: Describe irq suspension

Martin Karsten (5):
  net: Add napi_struct parameter irq_suspend_timeout
  net: Suspend softirq when prefer_busy_poll is set
  net: Add control functions for irq suspension
  eventpoll: Trigger napi_busy_loop, if prefer_busy_poll is set
  eventpoll: Control irq suspension for prefer_busy_poll

 Documentation/netlink/specs/netdev.yaml       |   7 +
 Documentation/networking/napi.rst             | 170 ++++++++-
 fs/eventpoll.c                                |  36 +-
 include/linux/netdevice.h                     |   2 +
 include/net/busy_poll.h                       |   3 +
 include/uapi/linux/netdev.h                   |   1 +
 net/core/dev.c                                |  58 +++-
 net/core/dev.h                                |  25 ++
 net/core/netdev-genl-gen.c                    |   5 +-
 net/core/netdev-genl.c                        |  12 +
 tools/include/uapi/linux/netdev.h             |   1 +
 tools/testing/selftests/net/.gitignore        |   1 +
 tools/testing/selftests/net/Makefile          |   3 +-
 tools/testing/selftests/net/busy_poll_test.sh | 164 +++++++++
 tools/testing/selftests/net/busy_poller.c     | 328 ++++++++++++++++++
 15 files changed, 805 insertions(+), 11 deletions(-)
 create mode 100755 tools/testing/selftests/net/busy_poll_test.sh
 create mode 100644 tools/testing/selftests/net/busy_poller.c


base-commit: dbb9a7ef347828870df3e5e6ddf19469a3277fc9
-- 
2.25.1


