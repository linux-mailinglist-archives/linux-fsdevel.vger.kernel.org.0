Return-Path: <linux-fsdevel+bounces-7064-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B72E08216E6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 05:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFAA41C210A5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 04:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16AD21118;
	Tue,  2 Jan 2024 04:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ipuJnKOX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1A2EC8;
	Tue,  2 Jan 2024 04:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704169791; x=1735705791;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=hqB1jolzeL5g0fOOCpwx+h0oswS2dZ1l57/pHl6LV6w=;
  b=ipuJnKOXH/d55FxxnePKnOgpQYBzjTUOk/nIeGbdlSR7JfxzuGM1JbIy
   9K0eAD81mm6F6CtoPFbCA4GWby4oQKw3sMAknAYMCmqpZG54+WNxX9yc/
   dcjM7jel1BwYSguIIfijKolgB1NeY/sRXyrd3WoMNZiwPWmCFzpV1IdLw
   VI5Ml0IloM7SC2R5jt8TAPD966b7KWdzptLo9UOTVb02KAmRZS//vjl86
   4+lHClOy4Mw/OJcltNOn6LVI8HVBzq1eGkSOVajWE+94lcL9YVKfZKjZB
   WxGgGYITfzL84JTpS96N4jTR5eLCzEsoLfF3v6nqrEid4GvYGaiRoTYP2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="427999332"
X-IronPort-AV: E=Sophos;i="6.04,324,1695711600"; 
   d="scan'208";a="427999332"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2024 20:29:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="779578844"
X-IronPort-AV: E=Sophos;i="6.04,324,1695711600"; 
   d="scan'208";a="779578844"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2024 20:29:41 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Gregory Price <gregory.price@memverge.com>
Cc: Gregory Price <gourry.memverge@gmail.com>,  <linux-mm@kvack.org>,
  <linux-doc@vger.kernel.org>,  <linux-fsdevel@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  <linux-api@vger.kernel.org>,
  <x86@kernel.org>,  <akpm@linux-foundation.org>,  <arnd@arndb.de>,
  <tglx@linutronix.de>,  <luto@kernel.org>,  <mingo@redhat.com>,
  <bp@alien8.de>,  <dave.hansen@linux.intel.com>,  <hpa@zytor.com>,
  <mhocko@kernel.org>,  <tj@kernel.org>,  <corbet@lwn.net>,
  <rakie.kim@sk.com>,  <hyeongtak.ji@sk.com>,  <honggyu.kim@sk.com>,
  <vtavarespetr@micron.com>,  <peterz@infradead.org>,
  <jgroves@micron.com>,  <ravis.opensrc@micron.com>,
  <sthanneeru@micron.com>,  <emirakhur@micron.com>,  <Hasan.Maruf@amd.com>,
  <seungjun.ha@samsung.com>,  Johannes Weiner <hannes@cmpxchg.org>,  Hasan
 Al Maruf <hasanalmaruf@fb.com>,  Hao Wang <haowang3@fb.com>,  Dan Williams
 <dan.j.williams@intel.com>,  "Michal Hocko" <mhocko@suse.com>,  Zhongkun
 He <hezhongkun.hzk@bytedance.com>,  "Frank van der Linden"
 <fvdl@google.com>,  John Groves <john@jagalactic.com>,  Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v5 00/11] mempolicy2, mbind2, and weighted interleave
In-Reply-To: <ZYqEjsaqseI68EyJ@memverge.com> (Gregory Price's message of "Tue,
	26 Dec 2023 02:45:18 -0500")
References: <20231223181101.1954-1-gregory.price@memverge.com>
	<87frzqg1jp.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZYqEjsaqseI68EyJ@memverge.com>
Date: Tue, 02 Jan 2024 12:27:42 +0800
Message-ID: <87le98e4w1.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Gregory Price <gregory.price@memverge.com> writes:

> On Mon, Dec 25, 2023 at 03:54:18PM +0800, Huang, Ying wrote:
>> Gregory Price <gourry.memverge@gmail.com> writes:
>> 
>> > For example, the stream benchmark demonstrates that default interleave
>> > is actively harmful, where weighted interleave is beneficial.
>> >
>> > Hardware: 1-socket 8 channel DDR5 + 1 CXL expander in PCIe x16
>> > Default interleave : -78% (slower than DRAM)
>> > Global weighting   : -6% to +4% (workload dependant)
>> > Targeted weights   : +2.5% to +4% (consistently better than DRAM)
>> >
>> > If nothing else, this shows how awful round-robin interleave is.
>> 
>> I guess the performance of the default policy, local (fast memory)
>> first, may be even better in some situation?  For example, before the
>> bandwidth of DRAM is saturated?
>> 
>
> Yes - but it's more complicated than that.
>
> Global weighting here means we did `numactl -w --interleave ...`, which
> means *all* memory regions will be interleaved.  Code, stack, heap, etc.
>
> Targeted weights means we used mbind2() with local weights, which only
> targted specific heap regions.
>
> The default policy was better than global weighting likely as a result
> of things like stack/code being distributed to higher latency memory
> produced a measurable overhead.
>
> To provide this, we only applied weights to bandwidth driving regions,
> and as a result we demonstrated a measurable performance increase.
>
> So yes, the defautl policy may be better in some situations - but that
> will be true of any policy.

Yes.  Some memory area may be more sensitive to memory latency than
other area.

Per my understanding, memory latency will increase with the actual
memory throughput.  And it increases quickly when the memory throughput
nears the maximum memory bandwidth.  As in the figures in the following
URL.

https://mahmoudhatem.wordpress.com/2017/11/07/memory-bandwidth-vs-latency-response-curve/

If the memory latency of the DRAM will not increase much, it's better to
place the hot data in DRAM always.  But if the memory throughput nears
the max memory bandwidth, so that the memory latency of DRAM increases
greatly, may be even higher than that of CXL memory, it's better to put
some hot data in CXL memory to reduce the overall memory latency.

If it's right, I suggest to add something like above in the patch
description.

>> I understand that you may want to limit the memory usage of the fast
>> memory too.  But IMHO, that is another requirements.  That should be
>> enforced by something like per-node memory limit.
>> 
>
> This interface does not limit memory usage of a particular node, it 
> distributes data according to the requested policy.
>
> Nuanced distinction, but important.  If nodes become exhausted, tasks
> are still free to allocate memory from any node in the nodemask, even if
> it violates the requested mempolicy.
>
> This is consistent with the existing behavior of mempolicy.

Good.

>> > =====================================================================
>> > (Patches 3-6) Refactoring mempolicy for code-reuse
>> >
>> > To avoid multiple paths of mempolicy creation, we should refactor the
>> > existing code to enable the designed extensibility, and refactor
>> > existing users to utilize the new interface (while retaining the
>> > existing userland interface).
>> >
>> > This set of patches introduces a new mempolicy_args structure, which
>> > is used to more fully describe a requested mempolicy - to include
>> > existing and future extensions.
>> >
>> > /*
>> >  * Describes settings of a mempolicy during set/get syscalls and
>> >  * kernel internal calls to do_set_mempolicy()
>> >  */
>> > struct mempolicy_args {
>> >     unsigned short mode;            /* policy mode */
>> >     unsigned short mode_flags;      /* policy mode flags */
>> >     int home_node;                  /* mbind: use MPOL_MF_HOME_NODE */
>> >     nodemask_t *policy_nodes;       /* get/set/mbind */
>> >     unsigned char *il_weights;      /* for mode MPOL_WEIGHTED_INTERLEAVE */
>> > };
>> 
>> According to
>> 
>> https://www.geeksforgeeks.org/difference-between-argument-and-parameter-in-c-c-with-examples/
>> 
>> it appears that "parameter" are better than "argument" for struct name
>> here.  It appears that current kernel source supports this too.
>> 
>> $ grep 'struct[\t ]\+[a-zA-Z0-9]\+_param' -r include/linux | wc -l
>> 411
>> $ grep 'struct[\t ]\+[a-zA-Z0-9]\+_arg' -r include/linux | wc -l
>> 25
>> 
>
> Will change.
>
>> > This arg structure will eventually be utilized by the following
>> > interfaces:
>> >     mpol_new() - new mempolicy creation
>> >     do_get_mempolicy() - acquiring information about mempolicy
>> >     do_set_mempolicy() - setting the task mempolicy
>> >     do_mbind()         - setting a vma mempolicy
>> >
>> > do_get_mempolicy() is completely refactored to break it out into
>> > separate functionality based on the flags provided by get_mempolicy(2)
>> >     MPOL_F_MEMS_ALLOWED: acquires task->mems_allowed
>> >     MPOL_F_ADDR: acquires information on vma policies
>> >     MPOL_F_NODE: changes the output for the policy arg to node info
>> >
>> > We refactor the get_mempolicy syscall flatten the logic based on these
>> > flags, and aloow for set_mempolicy2() to re-use the underlying logic.
>> >
>> > The result of this refactor, and the new mempolicy_args structure, is
>> > that extensions like 'sys_set_mempolicy_home_node' can now be directly
>> > integrated into the initial call to 'set_mempolicy2', and that more
>> > complete information about a mempolicy can be returned with a single
>> > call to 'get_mempolicy2', rather than multiple calls to 'get_mempolicy'
>> >
>> >
>> > =====================================================================
>> > (Patches 7-10) set_mempolicy2, get_mempolicy2, mbind2
>> >
>> > These interfaces are the 'extended' counterpart to their relatives.
>> > They use the userland 'struct mpol_args' structure to communicate a
>> > complete mempolicy configuration to the kernel.  This structure
>> > looks very much like the kernel-internal 'struct mempolicy_args':
>> >
>> > struct mpol_args {
>> >         /* Basic mempolicy settings */
>> >         __u16 mode;
>> >         __u16 mode_flags;
>> >         __s32 home_node;
>> >         __u64 pol_maxnodes;
>> 
>> I understand that we want to avoid hole in struct.  But I still feel
>> uncomfortable to use __u64 for a small.  But I don't have solution too.
>> Anyone else has some idea?
>>
>
> maxnode has been an `unsigned long` in every other interface for quite
> some time.  Seems better to keep this consistent rather than it suddenly
> become `unsigned long` over here and `unsigned short` over there.

I don't think that it matters.  The actual maximum node number will be
less than maximum `unsigned short`.

>> >         __aligned_u64 pol_nodes;
>> >         __aligned_u64 *il_weights;      /* of size pol_maxnodes */
>> 
>> Typo?  Should be,
>> 
>
> derp derp
>
>> >
>> > The 'flags' argument for mbind2 is the same as 'mbind', except with
>> > the addition of MPOL_MF_HOME_NODE to denote whether the 'home_node'
>> > field should be utilized.
>> >
>> > The 'flags' argument for get_mempolicy2 allows for MPOL_F_ADDR to
>> > allow operating on VMA policies, but MPOL_F_NODE and MPOL_F_MEMS_ALLOWED
>> > behavior has been omitted, since get_mempolicy() provides this already.
>> 
>> I still think that it's a good idea to make it possible to deprecate
>> get_mempolicy().  How about use a union as follows?
>> 
>> struct mpol_mems_allowed {
>>          __u64 maxnodes;
>>          __aligned_u64 nodemask;
>> };
>> 
>> union mpol_info {
>>         struct mpol_args args;
>>         struct mpol_mems_allowed mems_allowed;
>>         __s32 node;
>> };
>> 
>
> See my other email.  I've come around to see mems_allowed as a wart that
> needs to be removed.  The same information is already available via
> sysfs cpusets.mems and cpusets.mems_effective.
>
> Additionally, mems_allowed isn't even technically part of the mempolicy,
> so if we did want an interface to acquire the infomation, you'd prefer
> to just implement a stand-alone syscall.
>
> The sysfs interface seems sufficient though.
>
> `policy_node` is a similar "why does this even exist" type feature,
> except that it can still be used from get_mempolicy() and if there is an
> actual reason to extend it to get_mempolicy2() it can be added to
> mpol_params.

OK.

--
Best Regards,
Huang, Ying

