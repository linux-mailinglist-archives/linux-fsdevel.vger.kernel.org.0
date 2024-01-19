Return-Path: <linux-fsdevel+bounces-8321-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1778C832E77
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 18:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80D11B22E24
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 17:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1016E56450;
	Fri, 19 Jan 2024 17:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSG2aa1w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD73155E76;
	Fri, 19 Jan 2024 17:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705687059; cv=none; b=iQ9YF/4rbTvWxCIqwoBD+w8z/xneqI0rPTQ2duJiD3qw+MKEjFjkEd84NpXpByFwhukWShc33q5EuNGRRkN5pGAUeLRX9GLeoVfGu76TOp1+RtKH8BXk6Tg30+E3b3vDkZZOJDSZzPGIz54wFUNgCWXgUkH5Q7yG/EKwjqrAl7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705687059; c=relaxed/simple;
	bh=jJgNGlPdlVWlGMbRb+a4MUByz3Y3X6FSgFFMPoH1vh0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ISQ1IbOguAQkzm1HIMQKC4G8mldGiftCqm8Md9AguJ5yTZ14KirlKHX46z9UXgS2Oiw/4szNhZ4OcB2dOdVoCSdMsFceyWaErmhzHE2ypZP0lw9eHbWjyrWzQFt9BtxvDY6Voc3Zt9mtOzrsxpwXjGQRlBGbv9rP44PCmPP3+Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hSG2aa1w; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-5ce10b5ee01so846835a12.1;
        Fri, 19 Jan 2024 09:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705687057; x=1706291857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aobVexH8/88o56PNLkpXB/+PjF4JOXjJJoQ58wPFt8g=;
        b=hSG2aa1wdh21XnTM49y5rDzpMkucOp9k78AY0NXQ1+lzDYLkxIk6/BWWdcr6N537HO
         dS0NrHNf62f23gt+/ZVWsui8y+gfrRK5xfKFYDi087RQZjqmJUCNWGj5PR9K7f5PG5H7
         4AE4kGkoLGRUqSci/BW5Ic+YEHdF3/XEQ4q9q6ORyrn8KpM9feFqz7ykhbNv7drGwNkx
         nXkmnm0b0iBGJmYeYFtPwrYW6HU82WXb1j/8mvw11WHCv8XFLC/y+/+3Nrnj1HsMm0CM
         JIVKcAVOFIdWBpDzAB9DtGiwNXBorVZjXcd7n4+76ROMOXJhfM7ALITns2c1VuXhzOpU
         LgEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705687057; x=1706291857;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aobVexH8/88o56PNLkpXB/+PjF4JOXjJJoQ58wPFt8g=;
        b=lG6YBFiGWKSZ/H7IA7yrweQeJzPb+ZzB9dO8o5BU2CyIqXyhEC1UObZ58XZBEdxUVq
         MLKuPrUWudC7Dvv6ec4K9ky+RgWeMdZyGGtZDRK1g+0+dD99fmeIrY+elW9yEyOfOUtx
         2+dmizzPERe2hGVmvaTejEGy1gt59zPMTfrjkh7aUtFOEQHCehFg3DvrAJ2ae28EgAZw
         4KIRDwAuds87ysNHwvp7aoQpOkUrl4oRQvF/561O5QJuWs8y9eSM+ovlpJZbgYrVR/WO
         NpbpK5VeQaqBgrN+X7wItmXaLTeJycbv44FrCAAiCyXT7iOuC1OC596ObQnbiOL8cCpq
         aVzg==
X-Gm-Message-State: AOJu0YzMyf18TbiUNly2TIqxjVOoNapNdnbwvkD0LkQEgT7dtoZtO/sE
	6uIXz4W1xHSXayZvP5iNG6tsHfTivgDN0uGF5zb3EFCspdurlU8=
X-Google-Smtp-Source: AGHT+IHa4bh4wA88eVMoX5E62JhWzOqLfoKjVNlf/WlIbJZ2yL4Vqf0nWM40KbBpTvsOBe8XkO5ivA==
X-Received: by 2002:a17:90a:2f43:b0:28e:7bc0:31cb with SMTP id s61-20020a17090a2f4300b0028e7bc031cbmr283159pjd.24.1705687056886;
        Fri, 19 Jan 2024 09:57:36 -0800 (PST)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id sh18-20020a17090b525200b002901ded7356sm4202670pjb.2.2024.01.19.09.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 09:57:36 -0800 (PST)
From: Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org,
	corbet@lwn.net,
	akpm@linux-foundation.org,
	gregory.price@memverge.com,
	honggyu.kim@sk.com,
	rakie.kim@sk.com,
	hyeongtak.ji@sk.com,
	mhocko@kernel.org,
	ying.huang@intel.com,
	vtavarespetr@micron.com,
	jgroves@micron.com,
	ravis.opensrc@micron.com,
	sthanneeru@micron.com,
	emirakhur@micron.com,
	Hasan.Maruf@amd.com,
	seungjun.ha@samsung.com,
	hannes@cmpxchg.org,
	dan.j.williams@intel.com,
	Hasan Al Maruf <hasanalmaruf@fb.com>,
	Hao Wang <haowang3@fb.com>,
	Michal Hocko <mhocko@suse.com>,
	Zhongkun He <hezhongkun.hzk@bytedance.com>,
	Frank van der Linden <fvdl@google.com>,
	John Groves <john@jagalactic.com>,
	Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
	Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v2 0/3] mm/mempolicy: weighted interleave mempolicy and sysfs extension
Date: Fri, 19 Jan 2024 12:57:27 -0500
Message-Id: <20240119175730.15484-1-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Andrew,

Can you please replace the patches on mm-unstable with this line,
it has bulk-allocator bug fixes and some design changes at the
request of Ying Huang. Full v2 notes are just before the test info.

= Cover Letter

Weighted interleave is a new interleave policy intended to make
use of heterogeneous memory environments appearing with CXL.

The existing interleave mechanism does an even round-robin
distribution of memory across all nodes in a nodemask, while
weighted interleave distributes memory across nodes according
to a provided weight. (Weight = # of page allocations per round)

Weighted interleave is intended to reduce average latency when
bandwidth is pressured - therefore increasing total throughput.

In other words: It allows greater use of the total available
bandwidth in a heterogeneous hardware environment (different
hardware provides different bandwidth capacity).

As bandwidth is pressured, latency increases - first linearly
and then exponentially. By keeping bandwidth usage distributed
according to available bandwidth, we therefore can reduce the
average latency of a cacheline fetch.

A good explanation of the bandwidth vs latency response curve:
https://mahmoudhatem.wordpress.com/2017/11/07/memory-bandwidth-vs-latency-response-curve/

From the article:
```
Constant region:
    The latency response is fairly constant for the first 40%
    of the sustained bandwidth.
Linear region:
    In between 40% to 80% of the sustained bandwidth, the
    latency response increases almost linearly with the bandwidth
    demand of the system due to contention overhead by numerous
    memory requests.
Exponential region:
    Between 80% to 100% of the sustained bandwidth, the memory
    latency is dominated by the contention latency which can be
    as much as twice the idle latency or more.
Maximum sustained bandwidth :
    Is 65% to 75% of the theoretical maximum bandwidth.
```

As a general rule of thumb:
* If bandwidth usage is low, latency does not increase. It is
  optimal to place data in the nearest (lowest latency) device.
* If bandwidth usage is high, latency increases. It is optimal
  to place data such that bandwidth use is optimized per-device.

This is the top line goal: Provide a user a mechanism to target using
the "maximum sustained bandwidth" of each hardware component in a
heterogenous memory system.


For example, the stream benchmark demonstrates that 1:1 (default)
interleave is actively harmful, while weighted interleave can be
beneficial. Default interleave distributes data such that too much
pressure is placed on devices with lower available bandwidth.

Stream Benchmark (High level results, 1 Socket + 1 CXL Device)
Default interleave : -78% (slower than DRAM)
Global weighting   : -6% to +4% (workload dependant)
Targeted weights   : +2.5% to +4% (consistently better than DRAM)

Global means the task-policy was set (set_mempolicy), while targeted
means VMA policies were set (mbind2). We see weighted interleave
is not always beneficial when applied globally, but is always
beneficial when applied to bandwidth-driving memory regions.

We implement sysfs entries for "system global" weights which can be
set by a daemon or administrator.


There are 3 patches in this set:
1) Implement system-global interleave weights as sysfs extension
   in mm/mempolicy.c.  These weights are RCU protected, and the
   default/minimum weight is 1 for all nodes.

   In future work, we intend to expose an interface for HMAT/CDAT
   information to be used during boot to set reasonable system
   default values based on the memory configuration of the system
   discovered at boot or during device hotplug.

2) A mild refactor of some interleave-logic for re-use in the
   new weighted interleave logic.

3) MPOL_WEIGHTED_INTERLEAVE extension for set_mempolicy/mbind


Included below are some performance and LTP test information,
and a sample numactl branch which can be used for testing.

= Performance summary =
(tests may have different configurations, see extended info below)
1) MLC (W2) : +38% over DRAM. +264% over default interleave.
   MLC (W5) : +40% over DRAM. +226% over default interleave.
2) Stream   : -6% to +4% over DRAM, +430% over default interleave.
3) XSBench  : +19% over DRAM. +47% over default interleave.

= LTP Testing Summary =
existing mempolicy & mbind tests: pass
mempolicy & mbind + weighted interleave (global weights): pass

= version history
v2:
- MAJOR: Torture tested bulk allocator, fixed edge conditions
         tracking the next me->il_node.  Added documentation.
         Prior version was stable, but the resulting me->il_node
         could be wrong under certain circumstances.
- naming: iw_table_mtx -> iw_table_lock
- RCU: use synchronize+kfree and simplify the weight structure
- default: remove default table, since it's static for now
- sysfs setup: simplify setup, if table==NULL presume 1's
- node_store: only allocate (sizeof(u8) * nr_node_ids)
- allocators: update to deal with NULL table pointer
- read_once: __builtin_memcpy -> memcpy
- formatting

v1:
- RCU: This version protects the weight array with RCU.
- ktest fix: proper include (types.h) in uapi header
- doc: make mpol_params in docs reflect definition
- doc: mempolicy.c comments in MPOL_WEIGHTED_INTERLEAVE patch

- Dropped task-local weights and syscalls from the proposal
  until affirmative use cases for task-local weights appear.
Link: https://lore.kernel.org/linux-mm/20240103224209.2541-1-gregory.price@memverge.com/

=====================================================================
Performance tests - MLC
From - Ravi Jonnalagadda <ravis.opensrc@micron.com>

Hardware: Single-socket, multiple CXL memory expanders.

Workload:                               W2
Data Signature:                         2:1 read:write
DRAM only bandwidth (GBps):             298.8
DRAM + CXL (default interleave) (GBps): 113.04
DRAM + CXL (weighted interleave)(GBps): 412.5
Gain over DRAM only:                    1.38x
Gain over default interleave:           2.64x

Workload:                               W5
Data Signature:                         1:1 read:write
DRAM only bandwidth (GBps):             273.2
DRAM + CXL (default interleave) (GBps): 117.23
DRAM + CXL (weighted interleave)(GBps): 382.7
Gain over DRAM only:                    1.4x
Gain over default interleave:           2.26x

=====================================================================
Performance test - Stream
From - Gregory Price <gregory.price@memverge.com>

Hardware: Single socket, single CXL expander
numactl extension: https://github.com/gmprice/numactl/tree/weighted_interleave_master

Summary: 64 threads, ~18GB workload, 3GB per array, executed 100 times
Default interleave : -78% (slower than DRAM)
Global weighting   : -6% to +4% (workload dependant)
mbind2 weights     : +2.5% to +4% (consistently better than DRAM)

dram only:
numactl --cpunodebind=1 --membind=1 ./stream_c.exe --ntimes 100 --array-size 400M --malloc
Function     Direction    BestRateMBs     AvgTime      MinTime      MaxTime
Copy:        0->0            200923.2     0.032662     0.031853     0.033301
Scale:       0->0            202123.0     0.032526     0.031664     0.032970
Add:         0->0            208873.2     0.047322     0.045961     0.047884
Triad:       0->0            208523.8     0.047262     0.046038     0.048414

CXL-only:
numactl --cpunodebind=1 -w --membind=2 ./stream_c.exe --ntimes 100 --array-size 400M --malloc
Copy:        0->0             22209.7     0.288661     0.288162     0.289342
Scale:       0->0             22288.2     0.287549     0.287147     0.288291
Add:         0->0             24419.1     0.393372     0.393135     0.393735
Triad:       0->0             24484.6     0.392337     0.392083     0.394331

Based on the above, the optimal weights are ~9:1
echo 9 > /sys/kernel/mm/mempolicy/weighted_interleave/node1
echo 1 > /sys/kernel/mm/mempolicy/weighted_interleave/node2

default interleave:
numactl --cpunodebind=1 --interleave=1,2 ./stream_c.exe --ntimes 100 --array-size 400M --malloc
Copy:        0->0             44666.2     0.143671     0.143285     0.144174
Scale:       0->0             44781.6     0.143256     0.142916     0.143713
Add:         0->0             48600.7     0.197719     0.197528     0.197858
Triad:       0->0             48727.5     0.197204     0.197014     0.197439

global weighted interleave:
numactl --cpunodebind=1 -w --interleave=1,2 ./stream_c.exe --ntimes 100 --array-size 400M --malloc
Copy:        0->0            190085.9     0.034289     0.033669     0.034645
Scale:       0->0            207677.4     0.031909     0.030817     0.033061
Add:         0->0            202036.8     0.048737     0.047516     0.053409
Triad:       0->0            217671.5     0.045819     0.044103     0.046755

targted regions w/ global weights (modified stream to mbind2 malloc'd regions))
numactl --cpunodebind=1 --membind=1 ./stream_c.exe -b --ntimes 100 --array-size 400M --malloc
Copy:        0->0            205827.0     0.031445     0.031094     0.031984
Scale:       0->0            208171.8     0.031320     0.030744     0.032505
Add:         0->0            217352.0     0.045087     0.044168     0.046515
Triad:       0->0            216884.8     0.045062     0.044263     0.046982

=====================================================================
Performance tests - XSBench
From - Hyeongtak Ji <hyeongtak.ji@sk.com>

Hardware: Single socket, Single CXL memory Expander

NUMA node 0: 56 logical cores, 128 GB memory
NUMA node 2: 96 GB CXL memory
Threads:     56
Lookups:     170,000,000

Summary: +19% over DRAM. +47% over default interleave.

Performance tests - XSBench
1. dram only
$ numactl -m 0 ./XSBench -s XL –p 5000000
Runtime:     36.235 seconds
Lookups/s:   4,691,618

2. default interleave
$ numactl –i 0,2 ./XSBench –s XL –p 5000000
Runtime:     55.243 seconds
Lookups/s:   3,077,293

3. weighted interleave
numactl –w –i 0,2 ./XSBench –s XL –p 5000000
Runtime:     29.262 seconds
Lookups/s:   5,809,513

=====================================================================
LTP Tests: https://github.com/gmprice/ltp/tree/mempolicy2

= Existing tests
set_mempolicy, get_mempolicy, mbind

MPOL_WEIGHTED_INTERLEAVE added manually to test basic functionality
but did not adjust tests for weighting.  Basically the weights were
set to 1, which is the default, and it should behavior like standard
MPOL_INTERLEAVE if logic is correct.

== set_mempolicy01 : passed   18, failed   0
== set_mempolicy02 : passed   10, failed   0
== set_mempolicy03 : passed   64, failed   0
== set_mempolicy04 : passed   32, failed   0
== set_mempolicy05 - n/a on non-x86
== set_mempolicy06 : passed   10, failed   0
   this is set_mempolicy02 + MPOL_WEIGHTED_INTERLEAVE
== set_mempolicy07 : passed   32, failed   0
   set_mempolicy04 + MPOL_WEIGHTED_INTERLEAVE
== get_mempolicy01 : passed   12, failed   0
   change: added MPOL_WEIGHTED_INTERLEAVE
== get_mempolicy02 : passed   2, failed   0
== mbind01 : passed   15, failed   0
   added MPOL_WEIGHTED_INTERLEAVE
== mbind02 : passed   4, failed   0
   added MPOL_WEIGHTED_INTERLEAVE
== mbind03 : passed   16, failed   0
   added MPOL_WEIGHTED_INTERLEAVE
== mbind04 : passed   48, failed   0
   added MPOL_WEIGHTED_INTERLEAVE

=====================================================================
numactl (set_mempolicy) w/ global weighting test
numactl fork: https://github.com/gmprice/numactl/tree/weighted_interleave_master

command: numactl -w --interleave=0,1 ./eatmem

result (weights 1:1):
0176a000 weighted interleave:0-1 heap anon=65793 dirty=65793 active=0 N0=32897 N1=32896 kernelpagesize_kB=4
7fceeb9ff000 weighted interleave:0-1 anon=65537 dirty=65537 active=0 N0=32768 N1=32769 kernelpagesize_kB=4
50% distribution is correct

result (weights 5:1):
01b14000 weighted interleave:0-1 heap anon=65793 dirty=65793 active=0 N0=54828 N1=10965 kernelpagesize_kB=4
7f47a1dff000 weighted interleave:0-1 anon=65537 dirty=65537 active=0 N0=54614 N1=10923 kernelpagesize_kB=4
16.666% distribution is correct

result (weights 1:5):
01f07000 weighted interleave:0-1 heap anon=65793 dirty=65793 active=0 N0=10966 N1=54827 kernelpagesize_kB=4
7f17b1dff000 weighted interleave:0-1 anon=65537 dirty=65537 active=0 N0=10923 N1=54614 kernelpagesize_kB=4
16.666% distribution is correct

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int main (void)
{
        char* mem = malloc(1024*1024*256);
        memset(mem, 1, 1024*1024*256);
        for (int i = 0; i  < ((1024*1024*256)/4096); i++)
        {
                mem = malloc(4096);
                mem[0] = 1;
        }
        printf("done\n");
        getchar();
        return 0;
}

=====================================================================

Suggested-by: Gregory Price <gregory.price@memverge.com>
Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Suggested-by: Hasan Al Maruf <hasanalmaruf@fb.com>
Suggested-by: Hao Wang <haowang3@fb.com>
Suggested-by: Ying Huang <ying.huang@intel.com>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Suggested-by: Michal Hocko <mhocko@suse.com>
Suggested-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
Suggested-by: Frank van der Linden <fvdl@google.com>
Suggested-by: John Groves <john@jagalactic.com>
Suggested-by: Vinicius Tavares Petrucci <vtavarespetr@micron.com>
Suggested-by: Srinivasulu Thanneeru <sthanneeru@micron.com>
Suggested-by: Ravi Jonnalagadda <ravis.opensrc@micron.com>
Suggested-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Suggested-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
Suggested-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Gregory Price <gregory.price@memverge.com>


Gregory Price (2):
  mm/mempolicy: refactor a read-once mechanism into a function for
    re-use
  mm/mempolicy: introduce MPOL_WEIGHTED_INTERLEAVE for weighted
    interleaving

Rakie Kim (1):
  mm/mempolicy: implement the sysfs-based weighted_interleave interface

 .../ABI/testing/sysfs-kernel-mm-mempolicy     |   4 +
 ...fs-kernel-mm-mempolicy-weighted-interleave |  26 +
 .../admin-guide/mm/numa_memory_policy.rst     |   9 +
 include/linux/mempolicy.h                     |   5 +
 include/uapi/linux/mempolicy.h                |   1 +
 mm/mempolicy.c                                | 491 +++++++++++++++++-
 6 files changed, 523 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-mm-mempolicy
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave

-- 
2.39.1


