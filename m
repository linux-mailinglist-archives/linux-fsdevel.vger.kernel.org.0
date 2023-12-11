Return-Path: <linux-fsdevel+bounces-5450-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D51F980C108
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 06:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FDC31F2060E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 05:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8AB21F5FA;
	Mon, 11 Dec 2023 05:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fB5FjEVh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA242B3;
	Sun, 10 Dec 2023 21:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702274150; x=1733810150;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=e2bHdzm75z38LjF+9o3T3w5mUw+3GAOwy/r3Sc5Wnf4=;
  b=fB5FjEVhWkktHL+8X0WiKHZhevS3gauEznt6P3FT60r8UuFHV81F3cQ4
   L5m0HJ2WsAE2CADJY9+fadc+D+ct2QkyY+sjt1r0EwTKCPSVdoXwMB+Yk
   8/iLvMdl2GJmTMHtVQJZVtfn9OlZdC+rLgshpPaPNEchPaSheS3MDwI0X
   IRgLRBwS6AH/lLeil2Q8lKPFD+5ph9uOnErFZrqfDmolpud8BST0wLM0T
   xdQZAavgAIeP2tUkcB7Im9unKl57ua6gflp2ETIGF0P3Y8WAXXk9r+IxH
   IhrXxKUIdIVRRv/qzsZb+zzhnzhXDLuOskM+p9wH82Flr89fICd5MWZ9k
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="1714376"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="1714376"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2023 21:55:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="776539295"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="776539295"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2023 21:55:39 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Gregory Price <gourry.memverge@gmail.com>
Cc: linux-mm@kvack.org,  linux-doc@vger.kernel.org,
  linux-fsdevel@vger.kernel.org,  linux-api@vger.kernel.org,
  linux-arch@vger.kernel.org,  linux-kernel@vger.kernel.org,
  akpm@linux-foundation.org,  arnd@arndb.de,  tglx@linutronix.de,
  luto@kernel.org,  mingo@redhat.com,  bp@alien8.de,
  dave.hansen@linux.intel.com,  x86@kernel.org,  hpa@zytor.com,
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
Subject: Re: [PATCH v2 00/11] mempolicy2, mbind2, and weighted interleave
In-Reply-To: <20231209065931.3458-1-gregory.price@memverge.com> (Gregory
	Price's message of "Sat, 9 Dec 2023 01:59:20 -0500")
References: <20231209065931.3458-1-gregory.price@memverge.com>
Date: Mon, 11 Dec 2023 13:53:40 +0800
Message-ID: <87r0jtxp23.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi, Gregory,

Thanks for updated version!

Gregory Price <gourry.memverge@gmail.com> writes:

> v2:
>   changes / adds:
> - flattened weight matrix to an array at requested of Ying Huang
> - Updated ABI docs per Davidlohr Bueso request
> - change uapi structure to use aligned/fixed-length members as
>   Suggested-by: Arnd Bergmann <arnd@arndb.de>
> - Implemented weight fetch logic in get_mempolicy2
> - mbind2 was changed to take (iovec,len) as function arguments
>   rather than add them to the uapi structure, since they describe
>   where to apply the mempolicy - as opposed to being part of it.
>
>   fixes:
> - fixed bug on fork/pthread
>   Reported-by: Seungjun Ha <seungjun.ha@samsung.com>
>   Link: https://lore.kernel.org/linux-cxl/20231206080944epcms2p76ebb230b9=
f4595f5cfcd2531d67ab3ce@epcms2p7/
> - fixed bug in mbind2 where MPOL_F_GWEIGHTS was not set when il_weights
>   was omitted after local weights were added as an option
> - fixed bug in interleave logic where an OOB access was made if
>   next_node_in returned MAX_NUMNODES
> - fixed bug in bulk weighted interleave allocator where over-allocation
>   could occur.
>
>   tests:
> - LTP: validated existing get_mempolicy, set_mempolicy, and mbind testss
> - LTP: validated existing get_mempolicy, set_mempolicy, and mbind with
>        MPOL_WEIGHTED_INTERLEAVE added.
> - basic set_mempolicy2 tests and numactl -w --interleave tests
>
>   numactl:
> - Sample numactl extension for set_mempolicy available here:
>   Link: https://github.com/gmprice/numactl/tree/weighted_interleave_master
>
> (summary of LTP tests and manual tests added to end of cover letter)
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> This patch set extends the mempolicy interface to enable new
> mempolicies which may require extended data to operate. One
> such policy is included with this set as an example.
>
> There are 3 major "phases" in the patch set:
> 1) Implement a "global weight" mechanism via sysfs, which allows
>    set_mempolicy to implement MPOL_WEIGHTED_INTERLEAVE utilizing
>    weights set by the administrator (or system daemon).
>
> 2) A refactor of the mempolicy creation mechanism to accept an
>    extensible argument structure `struct mempolicy_args` to promote
>    code re-use between the original mempolicy/mbind interfaces and
>    the new extended mempolicy/mbind interfaces.
>
> 3) Implementation of set_mempolicy2, get_mempolicy2, and mbind2,
>    along with the addition of task-local weights so that per-task
>    weights can be registered for MPOL_WEIGHTED_INTERLEAVE.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> (Patch 1) : sysfs addition - /sys/kernel/mm/mempolicy/
>
> This feature  provides a way to set interleave weight information under
> sysfs at /sys/kernel/mm/mempolicy/weighted_interleave/nodeN/nodeM/weight
>
>     The sysfs structure is designed as follows.
>
>       $ tree /sys/kernel/mm/mempolicy/
>       /sys/kernel/mm/mempolicy/
>       =E2=94=9C=E2=94=80=E2=94=80 possible_nodes
>       =E2=94=94=E2=94=80=E2=94=80 weighted_interleave
>           =E2=94=9C=E2=94=80=E2=94=80 nodeN
>           =E2=94=82=C2=A0  =E2=94=94=E2=94=80=E2=94=80 weight
>           =E2=94=94=E2=94=80=E2=94=80 nodeN+X
>           =C2=A0   =E2=94=94=E2=94=80=E2=94=80 weight
>
> 'mempolicy' is added to '/sys/kernel/mm/' as a control group for
> the mempolicy subsystem.

Is it good to add 'mempolicy' in '/sys/kernel/mm/numa'?  The advantage
is that 'mempolicy' here is in fact "NUMA mempolicy".  The disadvantage
is one more directory nesting.  I have no strong opinion here.

> 'possible_nodes' is added to 'mm/mempolicy' to help describe the
> expected structures under mempolicy directorys. For example,
> possible_nodes describes what nodeN directories wille exist under
> the weighted_interleave directory.

We have '/sys/devices/system/node/possible' already.  Is this just a
duplication?  If so, why?  And, the possible nodes can be gotten via
contents of 'weighted_interleave' too.

And it appears not necessary to make 'weighted_interleave/nodeN'
directory.  Why not just make it a file.

And, can we add a way to reset weight to the default value?  For example
`echo > nodeN/weight` or `echo > nodeN`.

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
>     nodemask_t *policy_nodes;       /* get/set/mbind */
>     int policy_node;                /* get: policy node information */
>     unsigned long addr;             /* get: vma address */
>     int addr_node;                  /* get: node the address belongs to */
>     int home_node;                  /* mbind: use MPOL_MF_HOME_NODE */
>     unsigned char *il_weights;      /* for mode MPOL_WEIGHTED_INTERLEAVE =
*/
> };
>
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
>         __u64 pol_maxnodes;
>         __u64 addr;
>         __s32 policy_node;
>         __s32 addr_node;
>         __aligned_u64 *il_weights;      /* of size pol_maxnodes */
> };

This looks unnecessarily complex.  I don't think that it's a good idea
to use exact same parameter for all 3 syscalls.

For example, can we use something as below?

  long set_mempolicy2(int mode, const unsigned long *nodemask, unsigned int=
 *il_weights,
                          unsigned long maxnode, unsigned long home_node,
                          unsigned long flags);

  long mbind2(unsigned long start, unsigned long len,
                          int mode, const unsigned long *nodemask, unsigned=
 int *il_weights,
                          unsigned long maxnode, unsigned long home_node,
                          unsigned long flags);

A struct may be defined to hold mempolicy iteself.

struct mpol {
        int mode;
        unsigned int home_node;
        const unsigned long *nodemask;
        unsigned int *il_weights;
        unsigned int maxnode;
};

> The basic mempolicy settings which are shared across all interfaces
> are captured at the top of the structure, while extensions such as
> 'policy_node' and 'addr' are collected beneath.
>
> The syscalls are uniform and defined as follows:
>
> long sys_mbind2(struct iovec *vec, size_t vlen,
>                 struct mpol_args *args, size_t usize,
>                 unsigned long flags);
>
> long sys_get_mempolicy2(struct mpol_args *args, size_t size,
>                         unsigned long flags);
>
> long sys_set_mempolicy2(struct mpol_args *args, size_t size,
>                         unsigned long flags);
>
> The 'flags' argument for mbind2 is the same as 'mbind', except with
> the addition of MPOL_MF_HOME_NODE to denote whether the 'home_node'
> field should be utilized.
>
> The 'flags' argument for get_mempolicy2 is the same as get_mempolicy.
>
> The 'flags' argument is not used by 'set_mempolicy' at this time, but
> may end up allowing the use of MPOL_MF_HOME_NODE if such functionality
> is desired.
>
> The extensions can be summed up as follows:
>
> get_mempolicy2 extensions:
>     'mode', 'policy_node', and 'addr_node' can now be fetched with
>     a single call, rather than multiple with a combination of flags.
>     - 'mode' will always return the policy mode
>     - 'policy_node' will replace the functionality of MPOL_F_NODE
>     - 'addr_node' will return the node for 'addr' w/ MPOL_F_ADDR
>
> set_mempolicy2:
>     - task-local interleave weights can be set via 'il_weights'
>       (see next patch)
>
> mbind2:
>     - 'vec' and 'vlen' are sed to operate on multiple memory
>        ranges, rather than a single memory range per syscall.
>     - 'home_node' field sets policy home node w/ MPOL_MF_HOME_NODE
>     - task-local interleave weights can be set via 'il_weights'
>       (see next patch)
>

--
Best Regards,
Huang, Ying

[snip]

