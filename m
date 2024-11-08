Return-Path: <linux-fsdevel+bounces-33995-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A249C15A9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 05:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8EEC1F23924
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 04:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779FD1CF2B9;
	Fri,  8 Nov 2024 04:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="HgCq3OXw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B1C1CC88D
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Nov 2024 04:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731041666; cv=none; b=GWCEGo9t3gRt5/jAjyhu9pVKKK348hokVZuFjKquHFWpo7nmq4ihzGiPPL7PqHBm8I/XGHcSgh0+rBOYskWOedmkAqfu3Cu0sGD0mrGazMeP4N2sSdWdcjgmcBjVmMktBzKW4OO3TAokspELk5nPB/hS1z5Lx00gGdcYq/7POtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731041666; c=relaxed/simple;
	bh=4dfcRQTKy/ZQ08B1LBSQCWNEIXYeYK1yjUmQFPOfCV0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LtzMXi7e75iElSJCL+z4ysDRPTl6nkuJq2/k5OZJCfehDaM95O9y66OKHvsNaWIfhxOHUzxwEw68wlB0kxfdmooCWOJxs9w/pow/2ezrl3INAtTVLIX3SsBDXbEp5e6PbQXLppjaTrWauVua8F4trzRB8MMSsTMWAAJtYNuF5PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=HgCq3OXw; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-720c2db824eso1774355b3a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Nov 2024 20:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1731041663; x=1731646463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hVnE8KoSWvQrySVoFk+5AaLOc5U+ZVQrUtr7emR0zyQ=;
        b=HgCq3OXw3udjhxgoruU0nWMqFk60xlMEXmT6dAGeckw44PZfW2lKb+ykhmleDwvi/I
         eB+utiGfwriXq4Ah8zkxkgppc52lbAUSxrg8H+IWNq+wTLhjov6ix+2dx5NyCSZY4zYp
         jlsmzuXvd36PBzCblRRBc/tIlLHOYsrwxU4Fg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731041663; x=1731646463;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hVnE8KoSWvQrySVoFk+5AaLOc5U+ZVQrUtr7emR0zyQ=;
        b=j0kNbi4uMgyPfxRi1UZL11EdSYC1mpL+DdX1SFXRyVvNKZVATjZiJDo8rhXCy3WQXP
         XB73WT/IdXB8wq9nKDpcgEmj2yb+ELgRzB80C0bMVauAttbRiBk+4HOEIThrTqni53w5
         A2NAAmJydsSKBOhQVcC3QHMErGfWDuoB1tT9NYppjiul3wg/lRlrb1toYbi1Fkjni4VC
         YLpsFbMPX37RT5y1AH5XnUj9M3RZALr9JbFYc4qA+oGg6BQbLBi431UBSfRflWRFkeET
         JrA8Rs1n8Xk1iyQVkI+JLm07tXXb+Kil6VoVZyIL2+LP9TcEPTXXGuDg5FSJg4tpIl8C
         GzZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrazRULW/hdAVTRUw0N1zdxJOrLIb39AeUVZ0WVHbcNFSQlZiEMklk6oyNML5mnUEj2UixZwegfVKYs7EF@vger.kernel.org
X-Gm-Message-State: AOJu0YzZhh6nCcjHjlagadMShz2eXsu7d3nK4m43J5QOY8mn4dwVebxS
	wdOB0H9hwfza06SlP2gr5VpAWmj/fPfFzf4A9a6OYlxrLTjaOy2lin1mH5svaHc=
X-Google-Smtp-Source: AGHT+IF6iM/3Bnq14C8i35iPrfwe5VoM2fCabYmrLmSi7fKymsLx30l92X+H6sLekD1Q4j+4rA0rXA==
X-Received: by 2002:a05:6a00:4610:b0:71e:744a:3fbd with SMTP id d2e1a72fcca58-7241334f8b3mr2200778b3a.20.1731041663338;
        Thu, 07 Nov 2024 20:54:23 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078a7c76sm2697476b3a.48.2024.11.07.20.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 20:54:22 -0800 (PST)
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
	Daniel Jurgens <danielj@nvidia.com>,
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
Subject: [PATCH net-next v8 0/6] Suspend IRQs during application busy periods
Date: Fri,  8 Nov 2024 04:53:22 +0000
Message-Id: <20241108045337.292905-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

Welcome to v8, see changelog below.

This revision is a quick follow-up to v7 and only drops the unneeded
exports in patch 2. No other changes.

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
the kernel.

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
nearly 10 runs of each test case [8] using the scripts on github [7].
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

The absolute QPS results shift between submissions, but the
relative differences are equivalent. As patches are rebased,
several factors likely influence overall performance.

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
      base  200K  199946     112     239     416      26   12973   11343
   defer10  200K  199971      54     124     142      29   19412   17460
   defer20  200K  199986      60     130     153      26   15644   14095
   defer50  200K  200025      79     144     182      23   12122   11632
  defer200  200K  199999     164     254     309      19    8923    9635
  fullbusy  200K  199998      46     118     133     100   43658   23133
  napibusy  200K  199983     100     237     277      56   24840   24716
  suspend0  200K  200020     105     249     432      30   14264   11796
 suspend10  200K  199950      53     123     141      32   19518   16903
 suspend20  200K  200037      58     126     151      30   16426   14736
 suspend50  200K  199961      73     136     177      26   13310   12633
suspend200  200K  199998     149     251     306      21    9566   10203

  testcase  load     qps  avglat  95%lat  99%lat     cpu     cpq     ipq
      base  400K  400014     139     269     707      41    9476    9343
   defer10  400K  400016      59     133     166      53   13991   12989
   defer20  400K  399952      67     140     172      47   12063   11644
   defer50  400K  400007      87     162     198      39    9384    9880
  defer200  400K  399979     181     274     330      31    7089    8430
  fullbusy  400K  399987      50     123     156     100   21827   16037
  napibusy  400K  400014      76     222     272      83   18185   16529
  suspend0  400K  400015     127     350     776      47   10699    9603
 suspend10  400K  400023      57     129     164      54   13758   13178
 suspend20  400K  400043      62     135     169      49   12071   11826
 suspend50  400K  400071      76     149     186      42   10011   10301
suspend200  400K  399961     154     269     327      34    7827    8774

  testcase  load     qps  avglat  95%lat  99%lat     cpu     cpq     ipq
      base  600K  599951     149     266     574      61    9265    8876
   defer10  600K  600006      71     147     203      76   11866   10936
   defer20  600K  600123      76     152     203      66   10430   10342
   defer50  600K  600162      95     172     217      54    8526    9142
  defer200  600K  599942     200     301     357      46    6977    8212
  fullbusy  600K  599990      55     127     177     100   14551   13983
  napibusy  600K  600035      63     160     250      96   13937   14140
  suspend0  600K  599903     127     320     732      68   10166    8963
 suspend10  600K  599908      63     137     192      69   10902   11100
 suspend20  600K  599961      66     141     194      65    9976   10370
 suspend50  600K  599973      80     159     204      57    8678    9381
suspend200  600K  600010     157     277     346      48    7133    8381

  testcase  load     qps  avglat  95%lat  99%lat     cpu     cpq     ipq
      base  800K  800039     181     300     536      87    9585    8304
   defer10  800K  800038     181     530     939      96   10564    8970
   defer20  800K  800029     112     225     329      90   10056    8935
   defer50  800K  799999     120     208     296      82    9234    8562
  defer200  800K  800066     227     338     401      63    7117    8129
  fullbusy  800K  800040      61     134     190     100   10913   12608
  napibusy  800K  799944      64     141     214      99   10828   12588
  suspend0  800K  799911     126     248     509      85    9346    8498
 suspend10  800K  800006      69     143     200      83    9410    9845
 suspend20  800K  800120      74     150     207      78    8786    9454
 suspend50  800K  799989      87     168     224      71    7946    8833
suspend200  800K  799987     160     292     357      62    6923    8229

  testcase  load     qps  avglat  95%lat  99%lat     cpu     cpq     ipq
      base 1000K  906879    4079    5751    6216      98    9496    7904
   defer10 1000K  860849    3643    6274    6730      99   10040    8676
   defer20 1000K  896063    3298    5840    6349      98    9620    8237
   defer50 1000K  919782    2962    5513    5807      97    9284    7951
  defer200 1000K  970941    3059    5348    5984      95    8593    7959
  fullbusy 1000K  999950      70     150     207     100    8732   10777
  napibusy 1000K  999996      78     154     223     100    8722   10656
  suspend0 1000K  949706    2666    5770    6660      99    9071    8046
 suspend10 1000K 1000024      80     160     220      92    8137    9035
 suspend20 1000K 1000059      83     165     226      89    7850    8804
 suspend50 1000K  999955      95     180     240      84    7411    8459
suspend200 1000K  999914     163     299     366      77    6833    8078

  testcase  load     qps  avglat  95%lat  99%lat     cpu     cpq     ipq
      base   MAX 1037654    4184    5453    5810     100    8411    7938
   defer10   MAX  905607    4840    6151    6380     100    9639    8431
   defer20   MAX  986463    4455    5594    5796     100    8848    8110
   defer50   MAX 1077030    4000    5073    5299     100    8104    7920
  defer200   MAX 1040728    4152    5385    5765     100    8379    7849
  fullbusy   MAX 1247536    3518    3935    3984     100    6998    7930
  napibusy   MAX 1136310    3799    7756    9964     100    7670    7877
  suspend0   MAX 1057509    4132    5724    6185     100    8253    7918
 suspend10   MAX 1215147    3580    3957    4041     100    7185    7944
 suspend20   MAX 1216469    3576    3953    3988     100    7175    7950
 suspend50   MAX 1215871    3577    3961    4075     100    7181    7949
suspend200   MAX 1216882    3556    3951    3988     100    7175    7955

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

    It is possible, but presents challenges for userspace. User
    applications must ensure that the file descriptors added to epoll
    contexts have the same NAPI ID to support busy polling.

    An epoll context is not permanently tied to any particular NAPI ID.
    So, a user application could decide to clear the file descriptors
    from the context and add a new set of file descriptors with a
    different NAPI ID to the context. Busy polling would work as
    expected, but the meaning of the suspend timeout becomes ambiguous
    because IRQs are not inherently associated with epoll contexts, but
    rather with the NAPI. The user program would need to reissue the
    ioctl to set the irq_suspend_timeout, but the napi_defer_hard_irqs
    and gro_flush_timeout settings would come from the NAPI's
    napi_config (which are set either by sysfs or by netlink). Such an
    interface seems awkard to use from a user perspective.

    Further, IRQs are related to NAPIs, which is why they are stored in
    the napi_config space. Putting the irq_suspend_timeout in
    the epoll context while other IRQ deferral mechanisms remain in the
    NAPI's napi_config space seems like an odd design choice.

    We've opted to keep all of the IRQ deferral parameters together and
    place the irq_suspend_timeout in napi_config. This has nice benefits
    for userspace: if a user app were to remove all file descriptors
    from an epoll context and add new file descriptors with a new NAPI ID,
    the correct suspend timeout for that NAPI ID would be used automatically
    without the user application needing to do anything (like re-issuing an
    ioctl, for example). All IRQ deferral related parameters are in one
    place and can all be set the same way: with netlink.

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

v8:
  - Update patch 2 to drop the exports, as requested by Jakub.

v7: https://lore.kernel.org/netdev/20241108023912.98416-1-jdamato@fastly.com/
  - Jakub noted that patch 2 adds unnecessary complexity by checking the
    suspend timeout in the NAPI loop. This makes the code more
    complicated and difficult to reason about. He's right; we've dropped
    patch 2 which simplifies this series.
  - Updated the cover letter with a full re-run of all test cases.
  - Updated FAQ #2.

v6: https://lore.kernel.org/netdev/20241104215542.215919-1-jdamato@fastly.com/
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

Martin Karsten (4):
  net: Add napi_struct parameter irq_suspend_timeout
  net: Add control functions for irq suspension
  eventpoll: Trigger napi_busy_loop, if prefer_busy_poll is set
  eventpoll: Control irq suspension for prefer_busy_poll

 Documentation/netlink/specs/netdev.yaml       |   7 +
 Documentation/networking/napi.rst             | 170 ++++++++-
 fs/eventpoll.c                                |  36 +-
 include/linux/netdevice.h                     |   2 +
 include/net/busy_poll.h                       |   3 +
 include/uapi/linux/netdev.h                   |   1 +
 net/core/dev.c                                |  39 +++
 net/core/dev.h                                |  25 ++
 net/core/netdev-genl-gen.c                    |   5 +-
 net/core/netdev-genl.c                        |  12 +
 tools/include/uapi/linux/netdev.h             |   1 +
 tools/testing/selftests/net/.gitignore        |   1 +
 tools/testing/selftests/net/Makefile          |   3 +-
 tools/testing/selftests/net/busy_poll_test.sh | 164 +++++++++
 tools/testing/selftests/net/busy_poller.c     | 328 ++++++++++++++++++
 15 files changed, 790 insertions(+), 7 deletions(-)
 create mode 100755 tools/testing/selftests/net/busy_poll_test.sh
 create mode 100644 tools/testing/selftests/net/busy_poller.c


base-commit: dc7c381bb8649e3701ed64f6c3e55316675904d7
-- 
2.25.1


