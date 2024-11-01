Return-Path: <linux-fsdevel+bounces-33385-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B309B87D0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 01:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A59CE28428A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 00:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8BA1C28E;
	Fri,  1 Nov 2024 00:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="tiRsBClq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D1C17BD5
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Nov 2024 00:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730422151; cv=none; b=CBjMi3d+w8pHuEnI7fdl2+he86uwDDwGU58Kf8+jX+qyVYWo7T8Nyn4PQ3sxExEhhHFLLzLE1tVLnU119gOiGRdCf/zvci8yNQ6stZX+f+jEiuOj6gUARGhvRdAowyF0a6erYt+DT/ngHRLyOUiVeBRPlgO4p6EPlXbG0zfA8Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730422151; c=relaxed/simple;
	bh=qrpWzmVw+CJBJABtOBPun92uJpRq6PNaFfKaCSIW78w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ubL1qt7lfbTkcHq5BxzKnBeVPB4SL17UxoeX81WbKlM4rnC/DKUCbYSXhuHZ00UYna00fqj3Z2rrW3H308NgMjhEfKOGR9TAEpTadHu8pVgw8Og5vzXvqiJMVDubmeZh8Yn09xhuebzbZ/Z71HCmykDUJaDTrT3dV4q/YJn5jbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=tiRsBClq; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-720b2d8bb8dso1161672b3a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Oct 2024 17:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730422144; x=1731026944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yAb42VI7+bbWEyLO/lqnqH12jx4YI2ajFFvMCBT6+DM=;
        b=tiRsBClqSsBhBKkJIkAut+xfyff3bloP4dLXcCpejVe3PVj/20EIS8JZvYc85ZW6Zc
         ZcmYVZcByF++q3h/X9GOjTPz7A0qOcJvQvzlzBYJ3gMscihKyTb4ob/AlelVBM3anyiJ
         peElv/J1JBo0JqQBiuRbF7wN9r6HQE7pG/YUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730422144; x=1731026944;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yAb42VI7+bbWEyLO/lqnqH12jx4YI2ajFFvMCBT6+DM=;
        b=HrVSPEG6np27oGxa9v6+n+cn7k2oszW0vTgUoKiIcuI6rBUoQIEIR8hbthoazyLJVw
         PDpYgS1sKXFPfoXow9tZdvp/0DkG541aOtYRthu+EuinYm6yTtrQeodi7bipTbJhm4HA
         iKh+X7cKeoZp49PZ5SMa6G3y+2lCJD1aXbIcXozDUui5SDqz7LGdWAmFrcnaM1m5UiJC
         yuZ4t9/JTvJ4axblTRI3YXAn7H80xRISjs9k6+UzMR5DZ+VfWINfy4QsG1fs57UQ6e55
         Bfk2uUmu7uKX8+2ovEKTlWCHK3OQgysqNyiH4uaMot4GeBJYA9oMN3qa1PIPXrcb0iTX
         cu/w==
X-Forwarded-Encrypted: i=1; AJvYcCWclb3hrWZo5OjOkUyLlF16izM03Sq9krNjku3DP9Q+TuaEk4UDbYN+PrG7DPrPUzpTXl4P8Bkl5HRz5Sf0@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1YBeadRAHIG69P6ca+z2NKkY/x5WiQCGUQ7kwutwrTTEhQTr3
	wjUJ3UH9+ZUtT/7kKP68j7HuWBuJ+rLvx/DanWE4bNl0x3TpDPUEXVaatTQpMq0=
X-Google-Smtp-Source: AGHT+IFiYl+1s2/pTA4G9aO1q6tmt8go9HG9iT/TVFy5YI0q1DwzlbPtYCb7pUHiX7fYkOcxjlq2YQ==
X-Received: by 2002:a05:6a00:4606:b0:71e:68ae:aae1 with SMTP id d2e1a72fcca58-72063028d99mr28699395b3a.19.1730422143600;
        Thu, 31 Oct 2024 17:49:03 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee45a12c27sm1585365a12.93.2024.10.31.17.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 17:49:03 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
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
	Jonathan Corbet <corbet@lwn.net>,
	Kory Maincent <kory.maincent@bootlin.com>,
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
Subject: [PATCH net-next v3 0/7] Suspend IRQs during application busy periods
Date: Fri,  1 Nov 2024 00:48:27 +0000
Message-Id: <20241101004846.32532-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

Welcome to v3, see changelog below. Note that our performance tests were
not re-run for this revision as we only updated a commit message and
added a selftest.

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

~ Important call outs in the implementation

  - Enabling per epoll-context preferred busy poll will now effectively
    lead to a nonblocking iteration through napi_busy_loop, even when
    busy_poll_usecs is 0. See patch 4.

  - Patches apply cleanly on commit 160a810b2a85 ("net: vxlan: update
    the document for vxlan_snoop()").

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
at least 10 runs of each test case [8] using the scripts on github [7].
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

The overall takeaway is that the suspend variants provide a superior
combination of high throughput, low latency, and low cpu utilization
compared to all other variants. Each of the suspend variants works very
well, but some fine-tuning between latency and cpu utilization is still
possible by tuning the small timeout (gro_flush_timeout).

Note: we've reorganized the results to make comparison among testcases
with the same load easier.

  testcase  load     qps  avglat  95%lat  99%lat     cpu     cpq     ipq
      base  200K  200024     127     254     458      25   12748   11289
   defer10  200K  199991      64     128     166      27   18763   16574
   defer20  200K  199986      72     135     178      25   15405   14173
   defer50  200K  200025      91     149     198      23   12275   12203
  defer200  200K  199996     182     266     326      18    8595    9183
  fullbusy  200K  200040      58     123     167     100   43641   23145
  napibusy  200K  200009     115     244     299      56   24797   24693
 suspend10  200K  200005      63     128     167      32   19559   17240
 suspend20  200K  199952      69     132     170      29   16324   14838
 suspend50  200K  200019      84     144     189      26   13106   12516
suspend200  200K  199978     168     264     326      20    9331    9643

  testcase  load     qps  avglat  95%lat  99%lat     cpu     cpq     ipq
      base  400K  400017     157     292     762      39    9287    9325
   defer10  400K  400033      71     141     204      53   13950   12943
   defer20  400K  399935      79     150     212      47   12027   11673
   defer50  400K  399888     101     171     231      39    9556    9921
  defer200  400K  399993     200     287     358      32    7428    8576
  fullbusy  400K  400018      63     132     203     100   21827   16062
  napibusy  400K  399970      89     230     292      83   18156   16508
 suspend10  400K  400061      69     139     202      54   13576   13057
 suspend20  400K  399988      73     144     206      49   11930   11773
 suspend50  400K  399975      88     161     218      42    9996   10270
suspend200  400K  399954     172     276     353      34    7847    8713

  testcase  load     qps  avglat  95%lat  99%lat     cpu     cpq     ipq
      base  600K  600031     166     289     631      61    9188    8787
   defer10  600K  599967      85     167     262      75   11833   10947
   defer20  600K  599888      89     165     243      66   10513   10362
   defer50  600K  600072     109     185     253      55    8664    9190
  defer200  600K  599951     222     315     393      45    6892    8213
  fullbusy  600K  600041      69     145     227     100   14549   13936
  napibusy  600K  599980      79     188     280      96   13927   14155
 suspend10  600K  600028      78     159     267      69   10877   11032
 suspend20  600K  600026      81     159     254      64    9922   10320
 suspend50  600K  600007      96     178     258      57    8681    9331
suspend200  600K  599964     177     295     369      47    7115    8366

  testcase  load     qps  avglat  95%lat  99%lat     cpu     cpq     ipq
      base  800K  800034     198     329     698      84    9366    8338
   defer10  800K  799718     243     642    1457      95   10532    9007
   defer20  800K  800009     132     245     399      89    9956    8979
   defer50  800K  800024     136     228     378      80    9002    8598
  defer200  800K  799965     255     362     473      66    7481    8147
  fullbusy  800K  799927      78     157     253     100   10915   12533
  napibusy  800K  799870      81     173     273      99   10826   12532
 suspend10  800K  799991      84     167     269      83    9380    9802
 suspend20  800K  799979      90     172     290      78    8765    9404
 suspend50  800K  800031     106     191     307      71    7945    8805
suspend200  800K  799905     182     307     411      62    6985    8242

  testcase  load     qps  avglat  95%lat  99%lat     cpu     cpq     ipq
      base 1000K  919543    3805    6390   14229      98    9324    7978
   defer10 1000K  850751    4574    7382   15370      99   10218    8470
   defer20 1000K  890296    4736    6862   14858      99    9708    8277
   defer50 1000K  932694    3463    6180   13251      97    9148    8053
  defer200 1000K  951311    3524    6052   13599      96    8875    7845
  fullbusy 1000K 1000011      90     181     278     100    8731   10686
  napibusy 1000K 1000050      93     184     280     100    8721   10547
 suspend10 1000K  999962     101     193     306      92    8138    8980
 suspend20 1000K 1000030     103     191     324      88    7844    8763
 suspend50 1000K 1000001     114     202     320      83    7396    8431
suspend200 1000K  999965     185     314     428      76    6733    8072

  testcase  load     qps  avglat  95%lat  99%lat     cpu     cpq     ipq
      base   MAX 1005592    4651    6594   14979     100    8679    7918
   defer10   MAX  928204    5106    7286   15199     100    9398    8380
   defer20   MAX  984663    4774    6518   14920     100    8861    8063
   defer50   MAX 1044099    4431    6368   14652     100    8350    7948
  defer200   MAX 1040451    4423    6610   14674     100    8380    7931
  fullbusy   MAX 1236608    3715    3987   12805     100    7051    7936
  napibusy   MAX 1077516    4345   10155   15957     100    8080    7842
 suspend10   MAX 1218344    3760    3990   12585     100    7150    7935
 suspend20   MAX 1220056    3752    4053   12602     100    7150    7961
 suspend50   MAX 1213666    3791    4103   12919     100    7183    7959
suspend200   MAX 1217411    3768    3988   12863     100    7161    7954

~ FAQ

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

v3:
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
 Documentation/networking/napi.rst             | 132 +++++++++-
 fs/eventpoll.c                                |  35 ++-
 include/linux/netdevice.h                     |   2 +
 include/net/busy_poll.h                       |   3 +
 include/uapi/linux/netdev.h                   |   1 +
 net/core/dev.c                                |  58 ++++-
 net/core/dev.h                                |  25 ++
 net/core/netdev-genl-gen.c                    |   5 +-
 net/core/netdev-genl.c                        |  12 +
 tools/include/uapi/linux/netdev.h             |   1 +
 tools/testing/selftests/net/.gitignore        |   1 +
 tools/testing/selftests/net/Makefile          |   2 +
 tools/testing/selftests/net/busy_poll_test.sh | 164 ++++++++++++
 tools/testing/selftests/net/busy_poller.c     | 245 ++++++++++++++++++
 15 files changed, 683 insertions(+), 10 deletions(-)
 create mode 100755 tools/testing/selftests/net/busy_poll_test.sh
 create mode 100644 tools/testing/selftests/net/busy_poller.c


base-commit: 9e114ec8084020e10e1cb7b43dbbf6e69940866b
-- 
2.25.1


