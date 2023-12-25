Return-Path: <linux-fsdevel+bounces-6900-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D11C81DEE5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Dec 2023 08:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 302EF1C21701
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Dec 2023 07:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D648E1C2E;
	Mon, 25 Dec 2023 07:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oGOsMrpd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF10F15B9;
	Mon, 25 Dec 2023 07:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703490987; x=1735026987;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=ztD1+owzc5TzCOzkgrTNjFp4iDlX9X9XCZbpsHCrBxA=;
  b=oGOsMrpdvoiCOGeezHwu+ZjOWcfOKzulEHHizFQQb7+zLbrhNLM6iEiV
   Zk2Ba2dinNXHoLo16VbBqD85f4vv/Xml03pgcs9DhK+rf3nwKQW+uNMBr
   r1jH1DQGWWj1CqI04ey8yEFbsoG6/TqgI+XZ5NteKHtguyRIFa1EgKEXn
   v8M0s8CUkW+Dj+7XdbrD49dubZNjwKXW5kVEWAx1Z0YepSO9VT193RSZ9
   bkik4Gta7Ig0qsgihe9+TAEnJGMk4fZF0zhimh+FrITOTaVJfnJNs2CAQ
   U+WU1wpXNCdvtwE/WSx6D/BZFvnSgCaAGqAI6JWmXALuhyExWa7pA+h4H
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="427439992"
X-IronPort-AV: E=Sophos;i="6.04,302,1695711600"; 
   d="scan'208";a="427439992"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2023 23:56:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,302,1695711600"; 
   d="scan'208";a="19725986"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2023 23:56:17 -0800
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
Subject: Re: [PATCH v5 00/11] mempolicy2, mbind2, and weighted interleave
In-Reply-To: <20231223181101.1954-1-gregory.price@memverge.com> (Gregory
	Price's message of "Sat, 23 Dec 2023 13:10:50 -0500")
References: <20231223181101.1954-1-gregory.price@memverge.com>
Date: Mon, 25 Dec 2023 15:54:18 +0800
Message-ID: <87frzqg1jp.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Gregory Price <gourry.memverge@gmail.com> writes:

> Weighted interleave is a new interleave policy intended to make
> use of a the new distributed-memory environment made available
> by CXL.  The existing interleave mechanism does an even round-robin
> distribution of memory across all nodes in a nodemask, while
> weighted interleave can distribute memory across nodes according
> the available bandwidth that that node provides.
>
> As tests below show, "default interleave" can cause major performance
> degredation due to distribution not matching bandwidth available,
> while "weighted interleave" can provide a performance increase.
>
> For example, the stream benchmark demonstrates that default interleave
> is actively harmful, where weighted interleave is beneficial.
>
> Hardware: 1-socket 8 channel DDR5 + 1 CXL expander in PCIe x16
> Default interleave : -78% (slower than DRAM)
> Global weighting   : -6% to +4% (workload dependant)
> Targeted weights   : +2.5% to +4% (consistently better than DRAM)
>
> If nothing else, this shows how awful round-robin interleave is.

I guess the performance of the default policy, local (fast memory)
first, may be even better in some situation?  For example, before the
bandwidth of DRAM is saturated?

I understand that you may want to limit the memory usage of the fast
memory too.  But IMHO, that is another requirements.  That should be
enforced by something like per-node memory limit.

> Rather than implement yet another specific syscall to set one
> particular field of a mempolicy, we chose to implement an extensible
> mempolicy interface so that future extensions can be captured.
>
> To implement weighted interleave, we need an interface to set the
> node weights along with a MPOL_WEIGHTED_INTERLEAVE. We implement a
> a sysfs extension for "system global" weights which can be set by
> a daemon or administrator, and new extensible syscalls (mempolicy2,
> mbind2) which allow task-local weights to be set via user-software.
>
> The benefit of the sysfs extension is that MPOL_WEIGHTED_INTERLEAVE
> can be used by the existing set_mempolicy and mbind via numactl.
>
> There are 3 "phases" in the patch set that could be considered
> for separate merge candidates, but are presented here as a single
> line as the goal is a fully functional MPOL_WEIGHTED_INTERLEAVE.
>
> 1) Implement MPOL_WEIGHTED_INTERLEAVE with a sysfs extension for
>    setting system-global weights via sysfs.
>    (Patches 1 & 2)
>
> 2) Refactor mempolicy creation mechanism to use an extensible arg
>    struct `struct mempolicy_args` to promote code re-use between
>    the original mempolicy/mbind interfaces and the new interfaces.
>    (Patches 3-6)
>
> 3) Implementation of set_mempolicy2, get_mempolicy2, and mbind2,
>    along with the addition of task-local weights so that per-task
>    weights can be registered for MPOL_WEIGHTED_INTERLEAVE.
>    (Patches 7-11)
>
> Included at the bottom of this cover letter is linux test project
> tests for backward and forward compatibility, some sample software
> which can be used for quick tests, as well as a numactl branch
> which implements `numactl -w --interleave` for testing.
>
> = Performance summary =
> (tests may have different configurations, see extended info below)
> 1) MLC (W2) : +38% over DRAM. +264% over default interleave.
>    MLC (W5) : +40% over DRAM. +226% over default interleave.
> 2) Stream   : -6% to +4% over DRAM, +430% over default interleave.
> 3) XSBench  : +19% over DRAM. +47% over default interleave.
>
> = LTP Testing Summary =
> existing mempolicy & mbind tests: pass
> mempolicy & mbind + weighted interleave (global weights): pass
> mempolicy2 & mbind2 + weighted interleave (global weights): pass
> mempolicy2 & mbind2 + weighted interleave (local weights): pass
>

[snip]

> =====================================================================
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
>     unsigned char *il_weights;      /* for mode MPOL_WEIGHTED_INTERLEAVE */
> };

According to

https://www.geeksforgeeks.org/difference-between-argument-and-parameter-in-c-c-with-examples/

it appears that "parameter" are better than "argument" for struct name
here.  It appears that current kernel source supports this too.

$ grep 'struct[\t ]\+[a-zA-Z0-9]\+_param' -r include/linux | wc -l
411
$ grep 'struct[\t ]\+[a-zA-Z0-9]\+_arg' -r include/linux | wc -l
25

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
> =====================================================================
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
>         __u64 pol_maxnodes;

I understand that we want to avoid hole in struct.  But I still feel
uncomfortable to use __u64 for a small.  But I don't have solution too.
Anyone else has some idea?

>         __aligned_u64 pol_nodes;
>         __aligned_u64 *il_weights;      /* of size pol_maxnodes */

Typo?  Should be,

         __aligned_u64 il_weights;      /* of size pol_maxnodes */

?

Found this in some patch descriptions too.

> };
>
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

I still think that it's a good idea to make it possible to deprecate
get_mempolicy().  How about use a union as follows?

struct mpol_mems_allowed {
         __u64 maxnodes;
         __aligned_u64 nodemask;
};

union mpol_info {
        struct mpol_args args;
        struct mpol_mems_allowed mems_allowed;
        __s32 node;
};

> The 'flags' argument is not used by 'set_mempolicy' at this time, but
> may end up allowing the use of MPOL_MF_HOME_NODE if such functionality
> is desired.
>
> The extensions can be summed up as follows:
>
> get_mempolicy2 extensions:
>     - mode and mode flags are split into separate fields
>     - MPOL_F_MEMS_ALLOWED and MPOL_F_NODE are not supported
>
> set_mempolicy2:
>     - task-local interleave weights can be set via 'il_weights'
>
> mbind2:
>     - home_node field sets policy home node w/ MPOL_MF_HOME_NODE
>     - task-local interleave weights can be set via 'il_weights'
>

--
Best Regards,
Huang, Ying

[snip]

