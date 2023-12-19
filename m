Return-Path: <linux-fsdevel+bounces-6465-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D83281800C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 04:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 558CC1C218B5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 03:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608B946AA;
	Tue, 19 Dec 2023 03:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YciXHxau"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14581881E;
	Tue, 19 Dec 2023 03:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702955176; x=1734491176;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=xFD1mAG4X6D4EsrR/uu2BDhdli3SrlaNsWC+Y0amNw4=;
  b=YciXHxauCg1ZdfaVyzBSQh8SdyN3yZ3MxJs+561ZvP3cgx+hL04LNlze
   s35ss0y+dbA/4QSAXyQDb3HeS1M+ExK3bC3ExRPBrvYDWFbwQDHnAjEc4
   7ABD1NAnNIeD91ex1mJVnu3vSIjkpdIIdvvXXQ/uB0YAfH/HJfFgGJ03H
   f2Y3uysb5982mjuh1dKJ2VLoHG+ZrsLrAOD3wO3DvK3E3ICsn+uArvppB
   uwG4I1Nafe69G+kaHr/m455saWJDa0mFFkIFJwj+/aUrhjcM3RceV0yha
   S/6MiWmYKw/rUlNrx+fNtNn6wigm9Np/FQJC77rzhUtpht8v9o5NlFAPx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="14288882"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="14288882"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 19:06:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="769071319"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="769071319"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 19:06:04 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Gregory Price <gourry.memverge@gmail.com>
Cc: linux-mm@kvack.org,  linux-doc@vger.kernel.org,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-api@vger.kernel.org,  x86@kernel.org,  akpm@linux-foundation.org,
  arnd@arndb.de,  tglx@linutronix.de,  luto@kernel.org,  mingo@redhat.com,
  bp@alien8.de,  dave.hansen@linux.intel.com,  hpa@zytor.com,
  mhocko@kernel.org,  tj@kernel.org,  gregory.price@memverge.com,
  corbet@lwn.net,  rakie.kim@sk.com,  hyeongtak.ji@sk.com,
  honggyu.kim@sk.com,  vtavarespetr@micron.com,  peterz@infradead.org,
  jgroves@micron.com,  ravis.opensrc@micron.com,  sthanneeru@micron.com,
  emirakhur@micron.com,  Hasan.Maruf@amd.com,  seungjun.ha@samsung.com,
  Johannes Weiner <hannes@cmpxchg.org>,  Hasan Al Maruf
 <hasanalmaruf@fb.com>,  Hao Wang <haowang3@fb.com>,  Dan Williams
 <dan.j.williams@intel.com>,  Michal Hocko <mhocko@suse.com>,  Zhongkun He
 <hezhongkun.hzk@bytedance.com>,  Frank van der Linden <fvdl@google.com>,
  John Groves <john@jagalactic.com>,  Jonathan Cameron
 <Jonathan.Cameron@Huawei.com>
Subject: Re: [PATCH v4 00/11] mempolicy2, mbind2, and weighted interleave
In-Reply-To: <20231218194631.21667-1-gregory.price@memverge.com> (Gregory
	Price's message of "Mon, 18 Dec 2023 14:46:20 -0500")
References: <20231218194631.21667-1-gregory.price@memverge.com>
Date: Tue, 19 Dec 2023 11:04:05 +0800
Message-ID: <87wmtanba2.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Gregory Price <gourry.memverge@gmail.com> writes:

> This patch set extends the mempolicy interface to enable new
> mempolicies which may require extended data to operate.
>
> MPOL_WEIGHTED_INTERLEAVE is included as an example extension.

Per my understanding, it's better to describe why we need this patchset
at the beginning.  Per my understanding, weighted interleave is used to
expand DRAM bandwidth for workloads with real high memory bandwidth
requirements.  Without it, DRAM bandwidth will be saturated, which leads
to poor performance.

> Patches 1 and 2 (weighted interleave w/ sysfs globals) can be
> an candidate for merge separate from patches 3-11, but 3-11 are
> dependent on them, so it is included in the overall RFC.
>
> There are 3 major "phases" in the patch set:
>
> 1) Implement MPOL_WEIGHTED_INTERLEAVE with a sysfs extension,
>    which allows and admin/daemon to set weights via sysfs.
>    (Patches 1 & 2).  Weighted interleave allows for interleave
>    other than 1:1 (round-robin), such that bandwidth can be used
>    optimally. For example, a 9:1 interleave between nodes 0 and 1
>    would place 9 pages on node0 for every 1 page on node1.
>
> 2) A refactor of the mempolicy creation mechanism to accept an
>    extensible argument structure `struct mempolicy_args` to promote
>    code re-use between the original mempolicy/mbind interfaces and
>    the new extended mempolicy/mbind interfaces.
>    (Patches 3-6)
>
> 3) Implementation of set_mempolicy2, get_mempolicy2, and mbind2,
>    along with the addition of task-local weights so that per-task
>    weights can be registered for MPOL_WEIGHTED_INTERLEAVE.
>    (Patches 7-11)
>
> A sample numactl extension can be found here to test global weights:
> https://github.com/gmprice/numactl/tree/weighted_interleave_master
>
> Additionally, at the bottom of this cover letter is linux test
> project tests for backward and forward compatibility, and some
> sample software for quick and dirty testing.
>
> =3D Performance summary =3D
> (tests may have different configurations, see extended info below)
> 1) MLC (W2) : +38% over DRAM. +264% over default interleave.
>    MLC (W5) : +40% over DRAM. +226% over default interleave.
> 2) Stream   : -6% to +4% over DRAM, +430% over default interleave.
> 3) XSBench  : +19% over DRAM. +47% over default interleave.
>
> =3D LTP Testing Summary =3D
> https://github.com/gmprice/ltp/tree/mempolicy2
> existing mempolicy & mbind tests: pass
> mempolicy & mbind + weighted interleave (global weights): pass
> mempolicy2 & mbind2 + weighted interleave (global weights): pass
> mempolicy2 & mbind2 + weighted interleave (local weights): pass
>
> =3D Other test summary =3D
> numactl global weight useage: pass
> weight distribution validation: pass
>
> =3D v4 (full notes moved to bottom) =3D
> - CONFIG_MMU, CONFIG_SYSFS, tools/perf configs
> - sysfs attr init build warning
> - arch/arm64 syscall wire-ups (Thanks Arnd!)
> - Performance tests
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Performance tests - MLC
> From - Ravi Jonnalagadda <ravis.opensrc@micron.com>
>
> Hardware: Single-socket, multiple CXL memory expanders.
>
> Workload:                               W2
> Data Signature:                         2:1 read:write
> DRAM only bandwidth (GBps):             298.8
> DRAM + CXL (default interleave) (GBps): 113.04
> DRAM + CXL (weighted interleave)(GBps): 412.5
> Gain over DRAM only:                    1.38x
> Gain over default interleave:           2.64x
>
> Workload:                               W5
> Data Signature:                         1:1 read:write
> DRAM only bandwidth (GBps):             273.2
> DRAM + CXL (default interleave) (GBps): 117.23
> DRAM + CXL (weighted interleave)(GBps): 382.7
> Gain over DRAM only:                    1.4x
> Gain over default interleave:           2.26x
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Performance test - Stream
> From - Gregory Price <gregory.price@memverge.com>
>
> Hardware: Single socket, single CXL expander
>
> Summary: 64 threads, ~18GB workload, 3GB per array, executed 100 times
> Default interleave : -78% (slower than DRAM)
> Global weighting   : -6% to +4% (workload dependant)
> mbind2 weights     : +2.5% to +4% (consistently better than DRAM)
>
> dram only:
> numactl --cpunodebind=3D1 --membind=3D1 ./stream_c.exe --ntimes 100 --arr=
ay-size 400M --malloc
> Function     Direction    BestRateMBs     AvgTime      MinTime      MaxTi=
me
> Copy:        0->0            200923.2     0.032662     0.031853     0.033=
301
> Scale:       0->0            202123.0     0.032526     0.031664     0.032=
970
> Add:         0->0            208873.2     0.047322     0.045961     0.047=
884
> Triad:       0->0            208523.8     0.047262     0.046038     0.048=
414
>
> CXL-only:
> numactl --cpunodebind=3D1 -w --membind=3D2 ./stream_c.exe --ntimes 100 --=
array-size 400M --malloc
> Copy:        0->0             22209.7     0.288661     0.288162     0.289=
342
> Scale:       0->0             22288.2     0.287549     0.287147     0.288=
291
> Add:         0->0             24419.1     0.393372     0.393135     0.393=
735
> Triad:       0->0             24484.6     0.392337     0.392083     0.394=
331
>
> Based on the above, the optimal weights are ~9:1
> echo 9 > /sys/kernel/mm/mempolicy/weighted_interleave/node1
> echo 1 > /sys/kernel/mm/mempolicy/weighted_interleave/node2
>
> default interleave:
> numactl --cpunodebind=3D1 --interleave=3D1,2 ./stream_c.exe --ntimes 100 =
--array-size 400M --malloc
> Copy:        0->0             44666.2     0.143671     0.143285     0.144=
174
> Scale:       0->0             44781.6     0.143256     0.142916     0.143=
713
> Add:         0->0             48600.7     0.197719     0.197528     0.197=
858
> Triad:       0->0             48727.5     0.197204     0.197014     0.197=
439
>
> global weighted interleave:
> numactl --cpunodebind=3D1 -w --interleave=3D1,2 ./stream_c.exe --ntimes 1=
00 --array-size 400M --malloc
> Copy:        0->0            190085.9     0.034289     0.033669     0.034=
645
> Scale:       0->0            207677.4     0.031909     0.030817     0.033=
061
> Add:         0->0            202036.8     0.048737     0.047516     0.053=
409
> Triad:       0->0            217671.5     0.045819     0.044103     0.046=
755
>
> targted regions w/ global weights (mbind2 on malloc regions special -b fl=
ag)
> numactl --cpunodebind=3D1 --membind=3D1 ./stream_c.exe -b --ntimes 100 --=
array-size 400M --malloc
> Copy:        0->0            205827.0     0.031445     0.031094     0.031=
984
> Scale:       0->0            208171.8     0.031320     0.030744     0.032=
505
> Add:         0->0            217352.0     0.045087     0.044168     0.046=
515
> Triad:       0->0            216884.8     0.045062     0.044263     0.046=
982
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Performance tests - XSBench
> From - Hyeongtak Ji <hyeongtak.ji@sk.com>
>
> Hardware: Single socket, Single CXL memory Expander
>
> NUMA node 0: 56 logical cores, 128 GB memory
> NUMA node 2: 96 GB CXL memory
> Threads:     56
> Lookups:     170,000,000
>
> Summary: +19% over DRAM. +47% over default interleave.
>
> Performance tests - XSBench
> 1. dram only
> $ numactl -m 0 ./XSBench -s XL =E2=80=93p 5000000
> Runtime:     36.235 seconds
> Lookups/s:   4,691,618
>
> 2. default interleave
> $ numactl =E2=80=93i 0,2 ./XSBench =E2=80=93s XL =E2=80=93p 5000000
> Runtime:     55.243 seconds
> Lookups/s:   3,077,293
>
> 3. weighted interleave
> numactl =E2=80=93w =E2=80=93i 0,2 ./XSBench =E2=80=93s XL =E2=80=93p 5000=
000
> Runtime:     29.262 seconds
> Lookups/s:   5,809,513
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> (Patch 1) : sysfs addition - /sys/kernel/mm/mempolicy/
>
> This feature  provides a way to set interleave weight information under
> sysfs at /sys/kernel/mm/mempolicy/weighted_interleave/
>
>     The sysfs structure is designed as follows.
>
>       $ tree /sys/kernel/mm/mempolicy/
>       /sys/kernel/mm/mempolicy/
>       =E2=94=94=E2=94=80=E2=94=80 weighted_interleave
>           =E2=94=9C=E2=94=80=E2=94=80 nodeN
>           =E2=94=94=E2=94=80=E2=94=80 nodeN+X
>
> 'mempolicy' is added to '/sys/kernel/mm/' as a control group for
> the mempolicy subsystem.
>
> Internally, weights are represented as an array of unsigned char
>
> static unsigned char iw_table[MAX_NUMNODES];
>
> char was chosen as most reasonable distributions can be represented
> as factors <100, and to minimize memory usage (1KB)
>
> We present possible nodes, instead of online nodes, to simplify the
> management interface, considering that a) the table is of size
> MAX_NUMNODES anyway to simplify fetching of weights (no need to track
> sizes, and MAX_NUMNODES is typically at most 1kb), and b) it simplifies
> management of hotplug events, allowing for weights to be set prior to
> a node coming online, which may be beneficial for immediate use.
>
> the 'weight' of a node (an unsigned char of value 1-255) is the number
> of pages that are allocated during a "weighted interleave" round.
> (See 'weighted interleave' for more details').
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> (Patch 2) set_mempolicy: MPOL_WEIGHTED_INTERLEAVE
>
> Weighted interleave is a new memory policy that interleaves memory
> across numa nodes in the provided nodemask based on the weights
> described in patch 1 (sysfs global weights).
>
> When a system has multiple NUMA nodes and it becomes bandwidth hungry,
> the current MPOL_INTERLEAVE could be an wise option.
>
> However, if those NUMA nodes consist of different types of memory such
> as having local DRAM and CXL memory together, the current round-robin
> based interleaving policy doesn't maximize the overall bandwidth
> because of their different bandwidth characteristics.
>
> Instead, the interleaving can be more efficient when the allocation
> policy follows each NUMA nodes' bandwidth weight rather than having 1:1
> round-robin allocation.
>
> This patch introduces a new memory policy, MPOL_WEIGHTED_INTERLEAVE,
> which enables weighted interleaving between NUMA nodes.  Weighted
> interleave allows for a proportional distribution of memory across
> multiple numa nodes, preferablly apportioned to match the bandwidth
> capacity of each node from the perspective of the accessing node.
>
> For example, if a system has 1 CPU node (0), and 2 memory nodes (0,1),
> with a relative bandwidth of (100GB/s, 50GB/s) respectively, the
> appropriate weight distribution is (2:1).
>
> Weights will be acquired from the global weight array exposed by the
> sysfs extension: /sys/kernel/mm/mempolicy/weighted_interleave/
>
> The policy will then allocate the number of pages according to the
> set weights.  For example, if the weights are (2,1), then 2 pages
> will be allocated on node0 for every 1 page allocated on node1.
>
> The new flag MPOL_WEIGHTED_INTERLEAVE can be used in set_mempolicy(2)
> and mbind(2).
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> (Patches 3-6) Refactoring mempolicy for code-reuse
>
> To avoid multiple paths of mempolicy creation, we should refactor the
> existing code to enable the designed extensibility, and refactor
> existing users to utilize the new interface (while retaining the
> existing userland interface).
>
> This set of patches introduces a new mempolicy_args structure, which
> is used to more fully describe a requested mempolicy - to include
> existing and future extensions.
>
> /*
>  * Describes settings of a mempolicy during set/get syscalls and
>  * kernel internal calls to do_set_mempolicy()
>  */
> struct mempolicy_args {
>     unsigned short mode;            /* policy mode */
>     unsigned short mode_flags;      /* policy mode flags */
>     int home_node;                  /* mbind: use MPOL_MF_HOME_NODE */
>     nodemask_t *policy_nodes;       /* get/set/mbind */
>     unsigned char *il_weights;      /* for mode MPOL_WEIGHTED_INTERLEAVE =
*/
>     int policy_node;                /* get: policy node information */
> };

Because we use more and more parameters to describe the mempolicy, I
think it's a good idea to replace some parameters with struct.  But I
don't think it's a good idea to put unrelated stuff into the struct.
For example,

struct mempolicy_param {
    unsigned short mode;            /* policy mode */
    unsigned short mode_flags;      /* policy mode flags */
    int home_node;                  /* mbind: use MPOL_MF_HOME_NODE */
    nodemask_t *policy_nodes;
    unsigned char *il_weights;      /* for mode MPOL_WEIGHTED_INTERLEAVE */
};

describe the parameters to create the mempolicy.  It can be used by
set/get_mempolicy() and mbind().  So, I think that it's a good
abstraction.  But "policy_node" has nothing to do with set_mempolicy()
and mbind().  So I think that we shouldn't add it into the struct.  It's
totally OK to use different parameters for different functions.  For
example,

long do_set_mempolicy(struct mempolicy_param *mparam);
long do_mbind(unsigned long start, unsigned long len,
                struct mempolicy_param *mparam, unsigned long flags);
long do_get_task_mempolicy(struct mempolicy_param *mparam, int
                *policy_node);

This isn't the full list.  My point is to use separate parameter for
something specific for some function.

> This arg structure will eventually be utilized by the following
> interfaces:
>     mpol_new() - new mempolicy creation
>     do_get_mempolicy() - acquiring information about mempolicy
>     do_set_mempolicy() - setting the task mempolicy
>     do_mbind()         - setting a vma mempolicy
>
> do_get_mempolicy() is completely refactored to break it out into
> separate functionality based on the flags provided by get_mempolicy(2)
>     MPOL_F_MEMS_ALLOWED: acquires task->mems_allowed
>     MPOL_F_ADDR: acquires information on vma policies
>     MPOL_F_NODE: changes the output for the policy arg to node info
>
> We refactor the get_mempolicy syscall flatten the logic based on these
> flags, and aloow for set_mempolicy2() to re-use the underlying logic.
>
> The result of this refactor, and the new mempolicy_args structure, is
> that extensions like 'sys_set_mempolicy_home_node' can now be directly
> integrated into the initial call to 'set_mempolicy2', and that more
> complete information about a mempolicy can be returned with a single
> call to 'get_mempolicy2', rather than multiple calls to 'get_mempolicy'
>
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> (Patches 7-10) set_mempolicy2, get_mempolicy2, mbind2
>
> These interfaces are the 'extended' counterpart to their relatives.
> They use the userland 'struct mpol_args' structure to communicate a
> complete mempolicy configuration to the kernel.  This structure
> looks very much like the kernel-internal 'struct mempolicy_args':
>
> struct mpol_args {
>         /* Basic mempolicy settings */
>         __u16 mode;
>         __u16 mode_flags;
>         __s32 home_node;
>         __aligned_u64 pol_nodes;
>         __aligned_u64 *il_weights;      /* of size pol_maxnodes */
>         __u64 pol_maxnodes;
>         __s32 policy_node;
> };

Same as my idea above.  I think we shouldn't add policy_node for
set_mempolicy2()/mbind2().  That will make users confusing.  We can use
a different struct for get_mempolicy2().

> The basic mempolicy settings which are shared across all interfaces
> are captured at the top of the structure, while extensions such as
> 'policy_node' and 'addr' are collected beneath.
>
> The syscalls are uniform and defined as follows:
>
> long sys_mbind2(unsigned long addr, unsigned long len,
>                 struct mpol_args *args, size_t usize,
>                 unsigned long flags);
>
> long sys_get_mempolicy2(struct mpol_args *args, size_t size,
>                         unsigned long addr, unsigned long flags);
>
> long sys_set_mempolicy2(struct mpol_args *args, size_t size,
>                         unsigned long flags);
>
> The 'flags' argument for mbind2 is the same as 'mbind', except with
> the addition of MPOL_MF_HOME_NODE to denote whether the 'home_node'
> field should be utilized.
>
> The 'flags' argument for get_mempolicy2 allows for MPOL_F_ADDR to
> allow operating on VMA policies, but MPOL_F_NODE and MPOL_F_MEMS_ALLOWED
> behavior has been omitted, since get_mempolicy() provides this already.
>
> The 'flags' argument is not used by 'set_mempolicy' at this time, but
> may end up allowing the use of MPOL_MF_HOME_NODE if such functionality
> is desired.
>
> The extensions can be summed up as follows:
>
> get_mempolicy2 extensions:
>     'mode' and 'policy_node' can now be fetched with a single call
>     rather than multiple with a combination of flags.
>     - 'mode' will always return the policy mode
>     - 'policy_node' will replace the functionality of MPOL_F_NODE
>     - MPOL_F_MEMS_ALLOWED and MPOL_F_NODE are otherwise not supported
>
> set_mempolicy2:
>     - task-local interleave weights can be set via 'il_weights'
>       (see next patch)
>
> mbind2:
>     - 'home_node' field sets policy home node w/ MPOL_MF_HOME_NODE
>     - task-local interleave weights can be set via 'il_weights'
>       (see next patch)
>

--
Best Regards,
Huang, Ying

[snip]

