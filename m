Return-Path: <linux-fsdevel+bounces-6006-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1498121A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 23:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51370282872
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 22:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51268184B;
	Wed, 13 Dec 2023 22:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxLm/dhO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x1144.google.com (mail-yw1-x1144.google.com [IPv6:2607:f8b0:4864:20::1144])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4FBCD;
	Wed, 13 Dec 2023 14:41:23 -0800 (PST)
Received: by mail-yw1-x1144.google.com with SMTP id 00721157ae682-5e309941f46so8631967b3.3;
        Wed, 13 Dec 2023 14:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702507282; x=1703112082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sQj9WOnsM0f2QBVJFaA07qwu+2AGMixCt2osTiOUlBA=;
        b=DxLm/dhOrTT9pQXDKuSz/0R8rLoF1Nx2HHcE+dvaD0ViqmDIPOKsLN8jFC279r7XfX
         kRF31VqeCn633/Cmi+emida2+xZq212mKmU7Fg5k/GiIql1ACDkOv0M6YRjh1Kt6pBxA
         dAilcvmkL5x4dHtRVRObc07ZR4T7GJeyxSO+ay70Af0YBku/211XUI5ZQjF5HjtUPGJe
         OCLMsNm/hdvlfT0gt7zHJYUVzeblsfyIJhBvecGvslP61OzfPwl42vprVRFNvqPmKaZ2
         EGCIlU0dusVtbXreuC7kphWE0pi4TAWrEIsJD2fnIyMWdvk2Txidwef3bZxpqPxX1Ffp
         hErQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702507282; x=1703112082;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sQj9WOnsM0f2QBVJFaA07qwu+2AGMixCt2osTiOUlBA=;
        b=HUFnEWeJb5xEn6M4ExUj5rgDftxu3xiYVA4pW1QnOzxm9csoPJIrIb8Xq85H31Vx3H
         cGBkHv7MXP9fZY6yXpGUAic0N6znPZ5hy78HUPvHsHQppJasw9ecff/IA/lberRtM8vQ
         potOSs49EPxoVw5ArkQXb/PqlUnBG2RO33Dbr7/OL1GnTrjmKQupP/O3Cn1Pg0IWm5HP
         AN/CRq5RXwspvlOH8uVNEmxv8svrCp4Wrn00gvtKMjSN+aQCDg1/S7XxCHRPxdyHXXDa
         Y1Ks4iwaVNoDcDocheDz7LHCGTUwn+aPcx6APoYmVNOOAfNJDhXCo9NCRBhHoDz7R6Fy
         uDHg==
X-Gm-Message-State: AOJu0YzWGNKFZ27emym6jUq1ocKLBTWJ5riqQ2jSqpB6g0CSzJ3k9ibe
	ESe0XJa37Pxm0Eb4D7ApFw==
X-Google-Smtp-Source: AGHT+IFPsvEj36C15FQdwmY0y4ZK17YKRHk4GHugj6eB1GfEL3xpeuMVD0tiFXM6YVPlKIdY8SrulA==
X-Received: by 2002:a0d:e606:0:b0:5e2:ecce:e5ec with SMTP id p6-20020a0de606000000b005e2eccee5ecmr1180832ywe.82.1702507282081;
        Wed, 13 Dec 2023 14:41:22 -0800 (PST)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id v4-20020a818504000000b005d9729068f5sm5050583ywf.42.2023.12.13.14.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 14:41:21 -0800 (PST)
From: Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To: linux-mm@kvack.org
Cc: linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	x86@kernel.org,
	akpm@linux-foundation.org,
	arnd@arndb.de,
	tglx@linutronix.de,
	luto@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	mhocko@kernel.org,
	tj@kernel.org,
	ying.huang@intel.com,
	gregory.price@memverge.com,
	corbet@lwn.net,
	rakie.kim@sk.com,
	hyeongtak.ji@sk.com,
	honggyu.kim@sk.com,
	vtavarespetr@micron.com,
	peterz@infradead.org,
	jgroves@micron.com,
	ravis.opensrc@micron.com,
	sthanneeru@micron.com,
	emirakhur@micron.com,
	Hasan.Maruf@amd.com,
	seungjun.ha@samsung.com,
	Johannes Weiner <hannes@cmpxchg.org>,
	Hasan Al Maruf <hasanalmaruf@fb.com>,
	Hao Wang <haowang3@fb.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Michal Hocko <mhocko@suse.com>,
	Zhongkun He <hezhongkun.hzk@bytedance.com>,
	Frank van der Linden <fvdl@google.com>,
	John Groves <john@jagalactic.com>,
	Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Subject: [PATCH v3 00/11] mempolicy2, mbind2, and weighted interleave
Date: Wed, 13 Dec 2023 17:41:07 -0500
Message-Id: <20231213224118.1949-1-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

=====================================================================
v3:
  Biggest takeaway - LTP backward compatibility tests, new LTP tests,
  and MLC benchmark showed 40% performance bump over DRAM and nearly
  200% performance over default interleave.

  changes / adds:
- get2(): actually fetch the il_weights (doh!)
- get2(): retrieve home_node
- get2(): addr as arg instead of struct member, drop MPOL_F_NODE flag
          get_mempolicy() can be used for this, don't duplicate warts
	  Suggested-by: Ying Huang <ying.huang@intel.com>
- get2(): only copy weights if mode is weighted interleave
- mbind2(): addr/len instead of iovec
            user can use a for loop...
- sysfs: remove possible_nodes
	 Suggested-by: Ying Huang <ying.huang@intel.com>
- sysfs: simplify to weighted_interleave/nodeN
         Suggested-by: Ying Huang <ying.huang@intel.com>
- sysfs: add default weight mechanism (echo > nodeN)
	 Suggested-by: Ying Huang <ying.huang@intel.com>

  fixes:
- build: syscalls.h mpol_args definition missing
- build: missing `__user` from weights_ptr definition
- bug:   uninitialized weight_total in bulk allocator
- bug:   bad pointer to copy_struct_from_user in mbind2
- bug:   get_mempolicy2 uninitialized data copied to user
- bug:   get_vma_mempolicy policy reference counting
- bug:   MPOL_F_GWEIGHTS not set correctly in set_mempolicy2
- bug:   MPOL_F_GWEIGHTS not set correctly in mbind2
- bug:   get_mempolicy2 error not checked on nodemask userland copy
- bug:   mbind2 did not parse nodemask correctly

  tests:
- ltp branch: https://github.com/gmprice/ltp/tree/mempolicy2
- new set_mempolicy2() tests
     1) set_mempolicy() tests w/ new syscall
     2) weighted interleave validation
- new get_mempolicy2() tests
     1) get_mempolicy() tests w/ new syscall
     2) weighted interleave validation
- new mbind2() tests
     1) mbind() tests w/ new syscall
- new performance tests (MLC) from Ravi @ Micron
     Example:
        Workload:                               W5
        Data Signature:                         1:1 read:write
        DRAM only bandwidth (GBps):             273.2
        DRAM + CXL (default interleave) (GBps): 117.23
        DRAM + CXL (weighted interleave)(GBps): 382.7
        Gain over DRAM only:                    1.4x

=====================================================================
v2:
  changes / adds:
- flatted weight matrix to an array at requested of Ying Huang
- Updated ABI docs per Davidlohr Bueso request
- change uapi structure to use aligned/fixed-length members
- Implemented weight fetch logic in get_mempolicy2
- mbind2 was changed to take (iovec,len) as function arguments
  rather than add them to the uapi structure, since they describe
  where to apply the mempolicy - as opposed to being part of it.

  fixes:
- fixed bug reported by Seungjun Ha <seungjun.ha@samsung.com>
  Link: https://lore.kernel.org/linux-cxl/20231206080944epcms2p76ebb230b9f4595f5cfcd2531d67ab3ce@epcms2p7/
- fixed bug in mbind2 where MPOL_F_GWEIGHTS was not set when il_weights
  was omitted after local weights were added as an option
- fixed bug in interleave logic where an OOB access was made if
  next_node_in returned MAX_NUMNODES
- fixed bug in bulk weighted interleave allocator where over-allocation
  could occur.

  tests:
- LTP: validated existing get_mempolicy, set_mempolicy, and mbind tests
- LTP: validated existing get_mempolicy, set_mempolicy, and mbind with
       MPOL_WEIGHTED_INTERLEAVE added.
- basic set_mempolicy2 tests and numactl -w --interleave tests

  numactl:
- Sample numactl extension for set_mempolicy available here:
  Link: https://github.com/gmprice/numactl/tree/weighted_interleave_master

(added summary of test reports to end of cover letter)

=====================================================================

This patch set extends the mempolicy interface to enable new
mempolicies which may require extended data to operate. One
such policy is included with this set as an example.

There are 3 major "phases" in the patch set:
1) Implement a "global weight" mechanism via sysfs, which allows
   set_mempolicy to implement MPOL_WEIGHTED_INTERLEAVE utilizing
   weights set by the administrator (or system daemon).

2) A refactor of the mempolicy creation mechanism to accept an
   extensible argument structure `struct mempolicy_args` to promote
   code re-use between the original mempolicy/mbind interfaces and
   the new extended mempolicy/mbind interfaces.

3) Implementation of set_mempolicy2, get_mempolicy2, and mbind2,
   along with the addition of task-local weights so that per-task
   weights can be registered for MPOL_WEIGHTED_INTERLEAVE.

=====================================================================
(Patch 1) : sysfs addition - /sys/kernel/mm/mempolicy/

This feature  provides a way to set interleave weight information under
sysfs at /sys/kernel/mm/mempolicy/weighted_interleave/

    The sysfs structure is designed as follows.

      $ tree /sys/kernel/mm/mempolicy/
      /sys/kernel/mm/mempolicy/
      └── weighted_interleave
          ├── nodeN
          └── nodeN+X

'mempolicy' is added to '/sys/kernel/mm/' as a control group for
the mempolicy subsystem.

Internally, weights are represented as an array of unsigned char

static unsigned char iw_table[MAX_NUMNODES];

char was chosen as most reasonable distributions can be represented
as factors <100, and to minimize memory usage (1KB)

We present possible nodes, instead of online nodes, to simplify the
management interface, considering that a) the table is of size
MAX_NUMNODES anyway to simplify fetching of weights (no need to track
sizes, and MAX_NUMNODES is typically at most 1kb), and b) it simplifies
management of hotplug events, allowing for weights to be set prior to
a node coming online, which may be beneficial for immediate use.

the 'weight' of a node (an unsigned char of value 1-255) is the number
of pages that are allocated during a "weighted interleave" round.
(See 'weighted interleave' for more details').

=====================================================================
(Patch 2) set_mempolicy: MPOL_WEIGHTED_INTERLEAVE

Weighted interleave is a new memory policy that interleaves memory
across numa nodes in the provided nodemask based on the weights
described in patch 1 (sysfs global weights).

When a system has multiple NUMA nodes and it becomes bandwidth hungry,
the current MPOL_INTERLEAVE could be an wise option.

However, if those NUMA nodes consist of different types of memory such
as having local DRAM and CXL memory together, the current round-robin
based interleaving policy doesn't maximize the overall bandwidth
because of their different bandwidth characteristics.

Instead, the interleaving can be more efficient when the allocation
policy follows each NUMA nodes' bandwidth weight rather than having 1:1
round-robin allocation.

This patch introduces a new memory policy, MPOL_WEIGHTED_INTERLEAVE,
which enables weighted interleaving between NUMA nodes.  Weighted
interleave allows for a proportional distribution of memory across
multiple numa nodes, preferablly apportioned to match the bandwidth
capacity of each node from the perspective of the accessing node.

For example, if a system has 1 CPU node (0), and 2 memory nodes (0,1),
with a relative bandwidth of (100GB/s, 50GB/s) respectively, the
appropriate weight distribution is (2:1).

Weights will be acquired from the global weight array exposed by the
sysfs extension: /sys/kernel/mm/mempolicy/weighted_interleave/

The policy will then allocate the number of pages according to the
set weights.  For example, if the weights are (2,1), then 2 pages
will be allocated on node0 for every 1 page allocated on node1.

The new flag MPOL_WEIGHTED_INTERLEAVE can be used in set_mempolicy(2)
and mbind(2).

=====================================================================
(Patches 3-6) Refactoring mempolicy for code-reuse

To avoid multiple paths of mempolicy creation, we should refactor the
existing code to enable the designed extensibility, and refactor
existing users to utilize the new interface (while retaining the
existing userland interface).

This set of patches introduces a new mempolicy_args structure, which
is used to more fully describe a requested mempolicy - to include
existing and future extensions.

/*
 * Describes settings of a mempolicy during set/get syscalls and
 * kernel internal calls to do_set_mempolicy()
 */
struct mempolicy_args {
    unsigned short mode;            /* policy mode */
    unsigned short mode_flags;      /* policy mode flags */
    int home_node;                  /* mbind: use MPOL_MF_HOME_NODE */
    nodemask_t *policy_nodes;       /* get/set/mbind */
    unsigned char *il_weights;      /* for mode MPOL_WEIGHTED_INTERLEAVE */
    int policy_node;                /* get: policy node information */
};

This arg structure will eventually be utilized by the following
interfaces:
    mpol_new() - new mempolicy creation
    do_get_mempolicy() - acquiring information about mempolicy
    do_set_mempolicy() - setting the task mempolicy
    do_mbind()         - setting a vma mempolicy

do_get_mempolicy() is completely refactored to break it out into
separate functionality based on the flags provided by get_mempolicy(2)
    MPOL_F_MEMS_ALLOWED: acquires task->mems_allowed
    MPOL_F_ADDR: acquires information on vma policies
    MPOL_F_NODE: changes the output for the policy arg to node info

We refactor the get_mempolicy syscall flatten the logic based on these
flags, and aloow for set_mempolicy2() to re-use the underlying logic.

The result of this refactor, and the new mempolicy_args structure, is
that extensions like 'sys_set_mempolicy_home_node' can now be directly
integrated into the initial call to 'set_mempolicy2', and that more
complete information about a mempolicy can be returned with a single
call to 'get_mempolicy2', rather than multiple calls to 'get_mempolicy'


=====================================================================
(Patches 7-10) set_mempolicy2, get_mempolicy2, mbind2

These interfaces are the 'extended' counterpart to their relatives.
They use the userland 'struct mpol_args' structure to communicate a
complete mempolicy configuration to the kernel.  This structure
looks very much like the kernel-internal 'struct mempolicy_args':

struct mpol_args {
        /* Basic mempolicy settings */
        __u16 mode;
        __u16 mode_flags;
        __s32 home_node;
        __aligned_u64 pol_nodes;
        __aligned_u64 *il_weights;      /* of size pol_maxnodes */
        __u64 pol_maxnodes;
        __s32 policy_node;
};

The basic mempolicy settings which are shared across all interfaces
are captured at the top of the structure, while extensions such as
'policy_node' and 'addr' are collected beneath.

The syscalls are uniform and defined as follows:

long sys_mbind2(unsigned long addr, unsigned long len,
                struct mpol_args *args, size_t usize,
                unsigned long flags);

long sys_get_mempolicy2(struct mpol_args *args, size_t size,
                        unsigned long addr, unsigned long flags);

long sys_set_mempolicy2(struct mpol_args *args, size_t size,
                        unsigned long flags);

The 'flags' argument for mbind2 is the same as 'mbind', except with
the addition of MPOL_MF_HOME_NODE to denote whether the 'home_node'
field should be utilized.

The 'flags' argument for get_mempolicy2 allows for MPOL_F_ADDR to
allow operating on VMA policies, but MPOL_F_NODE and MPOL_F_MEMS_ALLOWED
behavior has been omitted, since get_mempolicy() provides this already.

The 'flags' argument is not used by 'set_mempolicy' at this time, but
may end up allowing the use of MPOL_MF_HOME_NODE if such functionality
is desired.

The extensions can be summed up as follows:

get_mempolicy2 extensions:
    'mode' and 'policy_node' can now be fetched with a single call
    rather than multiple with a combination of flags.
    - 'mode' will always return the policy mode
    - 'policy_node' will replace the functionality of MPOL_F_NODE
    - MPOL_F_MEMS_ALLOWED and MPOL_F_NODE are otherwise not supported

set_mempolicy2:
    - task-local interleave weights can be set via 'il_weights'
      (see next patch)

mbind2:
    - 'home_node' field sets policy home node w/ MPOL_MF_HOME_NODE
    - task-local interleave weights can be set via 'il_weights'
      (see next patch)

=====================================================================
(Patch 11) set_mempolicy2/mbind2: MPOL_WEIGHTED_INTERLEAVE

This patch shows the explicit extension pattern when adding new
policies to mempolicy2/mbind2.  This adds the 'il_weights' field
to mpol_args and adds the logic to fill in task-local weights.

There are now two ways to weight a mempolicy: global and local.
To denote which mode the task is in, we add the internal flag:
MPOL_F_GWEIGHT /* Utilize global weights */

When MPOL_F_GWEIGHT is set, the global weights are used, and
when it is not set, task-local weights are used.

Example logic:
if (pol->flags & MPOL_F_GWEIGHT)
       pol_weights = iw_table;
else
       pol_weights = pol->wil.weights;

set_mempolicy is changed to always set MPOL_F_GWEIGHT, since this
syscall is incapable of passing weights via its interfaces, while
set_mempolicy2 sets MPOL_F_GWEIGHT if MPOL_F_WEIGHTED_INTERLEAVE
is required but (*il_weights) in mpol_args is null.

The operation of task-local weighted is otherwise exactly the
same - except for what occurs on task migration.

On task migration, the system presently has no way of determining
what the new weights "should be", or what the user "intended".

For this reason, we default all weights to '1' and do not allow
weights to be '0'.  This means, should a migration occur where
one or more nodes appear into the nodemask - the effective weight
for that node will be '1'.  This avoids a potential allocation
failure condition if a migration occurs and introduces a node
which otherwise did not have a weight.

For this reason, users should use task-local weighting when
migrations are not expected, and global weighting when migrations
are expected or possible.

=====================================================================
Existing LTP Tests: https://github.com/gmprice/ltp/tree/mempolicy2

LTP set_mempolicy, get_mempolicy, mbind regression tests:

MPOL_WEIGHTED_INTERLEAVE added manually to test basic functionality
but did not adjust tests for weighting.  Basically the weights were
set to 1, which is the default, and it should behavior like standard
MPOL_INTERLEAVE if logic is correct.

== set_mempolicy01
passed   18
failed   0

== set_mempolicy02
passed   10
failed   0

== set_mempolicy03
passed   64
failed   0

== set_mempolicy04
passed   32
failed   0

== set_mempolicy05 - n/a on non-x86

== set_mempolicy06 - set_mempolicy02 + MPOL_WEIGHTED_INTERLEAVE
passed   10
failed   0

== set_mempolicy07 - set_mempolicy04 + MPOL_WEIGHTED_INTERLEAVE
passed   32
failed   0

== get_mempolicy01 - added MPOL_WEIGHTED_INTERLEAVE
passed   12
failed   0

== get_mempolicy02
passed   2
failed   0

== mbind01 - added WEIGHTED_INTERLEAVE
passed   15
failed   0

== mbind02 - added WEIGHTED_INTERLEAVE
passed   4
failed   0

== mbind03 - added WEIGHTED_INTERLEAVE
passed   16
failed   0

== mbind04 - added WEIGHTED_INTERLEAVE
passed   48
failed   0

=====================================================================
New LTP Tests: https://github.com/gmprice/ltp/tree/mempolicy2

set_mempolicy2, get_mempolicy2, mbind2

Took the original set_mempolicy and get_mempolicy tests, and updated
them to utilize the new mempolicy2 interfaces.  Added additional tests
for setting task-local weights to validate behavior.

== set_mempolicy201 - set_mempolicy01 equiv
passed   18
failed   0

== set_mempolicy202 - set_mempolicy02 equiv
passed   10
failed   0

== set_mempolicy203 - set_mempolicy03 equiv
passed   64
failed   0

== set_mempolicy204 - set_mempolicy04 equiv
passed   32
failed   0

== set_mempolicy205 - set_mempolicy06 equiv
passed   10
failed   0

== set_mempolicy206 - set_mempolicy07 equiv
passed   32
failed   0

== set_mempolicy207 - MPOL_WEIGHTED_INTERLEAVE with task-local weights
passed   6
failed   0

== get_mempolicy201 - get_mempolicy01 equiv
passed   12
failed   0

== get_mempolicy202 - get_mempolicy02 equiv
passed   2
failed   0

== get_mempolicy203 - NEW - fetch global and local weights
passed   6
failed   0

== mbind201 - mbind01 equiv
passed   15
failed   0

== mbind202 - mbind02 equiv
passed   4
failed   0

== mbind203 - mbind03 equiv
passed   16
failed   0

== mbind204 - mbind04 equiv
passed   48
failed   0

=====================================================================
Basic set_mempolicy2 test

set_mempolicy2 w/ weighted interleave, task-local weights and uses
pthread_create to demonstrate the mempolicy is overwritten by child.

Manually validating the distribution via numa_maps

007c0000 weighted interleave:0-1 heap anon=65794 dirty=65794 active=0 N0=54829 N1=10965 kernelpagesize_kB=4
7f3f2c000000 weighted interleave:0-1 anon=32768 dirty=32768 active=0 N0=5461 N1=27307 kernelpagesize_kB=4
7f3f34000000 weighted interleave:0-1 anon=16384 dirty=16384 active=0 N0=2731 N1=13653 kernelpagesize_kB=4
7f3f3bffe000 weighted interleave:0-1 anon=65538 dirty=65538 active=0 N0=10924 N1=54614 kernelpagesize_kB=4
7f3f5c000000 weighted interleave:0-1 anon=16384 dirty=16384 active=0 N0=2731 N1=13653 kernelpagesize_kB=4
7f3f60dfe000 weighted interleave:0-1 anon=65537 dirty=65537 active=0 N0=54615 N1=10922 kernelpagesize_kB=4

Expected distribution is 5:1 or 1:5 (less node should be ~16.666%)
1) 10965/65794 : 16.6656...
2) 5461/32768  : 16.6656...
3) 2731/16384  : 16.6687...
4) 10924/65538 : 16.6682...
5) 2731/16384  : 16.6687...
6) 10922/65537 : 16.6653...


#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <numa.h>
#include <errno.h>
#include <numaif.h>
#include <unistd.h>
#include <pthread.h>
#include <sys/uio.h>
#include <sys/types.h>
#include <stdint.h>

#define MPOL_WEIGHTED_INTERLEAVE 6
#define SET_MEMPOLICY2(a, b) syscall(457, a, b, 0)

#define M256 (1024*1024*256)
#define PAGE_SIZE (4096)

struct mpol_args {
        /* Basic mempolicy settings */
        uint16_t mode;
        uint16_t mode_flags;
        int32_t home_node;
        uint64_t pol_nodes;
        uint64_t il_weights;
        uint64_t pol_maxnodes;
        int32_t policy_node;
};

struct mpol_args wil_args;
struct bitmask *wil_nodes;
unsigned char *weights;
int total_nodes = -1;
pthread_t tid;

void set_mempolicy_call(int which)
{
        weights = (unsigned char *)calloc(total_nodes, sizeof(unsigned char));
        wil_nodes = numa_allocate_nodemask();

        numa_bitmask_setbit(wil_nodes, 0); weights[0] = which ? 1 : 5;
        numa_bitmask_setbit(wil_nodes, 1); weights[1] = which ? 5 : 1;

        memset(&wil_args, 0, sizeof(wil_args));
        wil_args.mode = MPOL_WEIGHTED_INTERLEAVE;
        wil_args.mode_flags = 0;
        wil_args.pol_nodes = wil_nodes->maskp;
        wil_args.pol_maxnodes = total_nodes;
        wil_args.il_weights = weights;

        int ret = SET_MEMPOLICY2(&wil_args, sizeof(wil_args));
        fprintf(stderr, "set_mempolicy2 result: %d(%s)\n", ret, strerror(errno));
}

void *func(void *arg)
{
        char *mainmem = malloc(M256);
        int i;

        set_mempolicy_call(1); /* weight 1 heavier */

        mainmem = malloc(M256);
        memset(mainmem, 1, M256);
        for (i = 0; i < (M256/PAGE_SIZE); i++) {
                mainmem = malloc(PAGE_SIZE);
                mainmem[0] = 1;
        }
        printf("thread done %d\n", getpid());
        getchar();
        return arg;
}

int main()
{
        char * mainmem;
        int i;

        total_nodes = numa_max_node() + 1;

        set_mempolicy_call(0); /* weight 0 heavier */
        pthread_create(&tid, NULL, func, NULL);

        mainmem = malloc(M256);
        memset(mainmem, 1, M256);
        for (i = 0; i < (M256/PAGE_SIZE); i++) {
                mainmem = malloc(PAGE_SIZE);
                mainmem[0] = 1;
        }
        printf("main done %d\n", getpid());
        getchar();

        return 0;
}

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
Performance tests - MLC
From Ravi Jonnalagadda <ravis.opensrc@micron.com>

Workload:                               W2
Data Signature:                         2:1 read:write
DRAM only bandwidth (GBps):             298.8
DRAM + CXL (default interleave) (GBps): 113.04
DRAM + CXL (weighted interleave)(GBps): 412.5
Gain over DRAM only:                    1.38x

Workload:                               W5
Data Signature:                         1:1 read:write
DRAM only bandwidth (GBps):             273.2
DRAM + CXL (default interleave) (GBps): 117.23
DRAM + CXL (weighted interleave)(GBps): 382.7
Gain over DRAM only:                    1.4x

=====================================================================

Suggested-by: Gregory Price <gregory.price@memverge.com>
Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Suggested-by: Hasan Al Maruf <hasanalmaruf@fb.com>
Suggested-by: Hao Wang <haowang3@fb.com>
Suggested-by: Ying Huang <ying.huang@intel.com>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Suggested-by: Michal Hocko <mhocko@suse.com>
Suggested-by: tj <tj@kernel.org>
Suggested-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
Suggested-by: Frank van der Linden <fvdl@google.com>
Suggested-by: John Groves <john@jagalactic.com>
Suggested-by: Vinicius Tavares Petrucci <vtavarespetr@micron.com>
Suggested-by: Srinivasulu Thanneeru <sthanneeru@micron.com>
Suggested-by: Ravi Jonnalagadda <ravis.opensrc@micron.com>
Suggested-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Signed-off-by: Gregory Price <gregory.price@memverge.com>

Gregory Price (10):
  mm/mempolicy: introduce MPOL_WEIGHTED_INTERLEAVE for weighted
    interleaving
  mm/mempolicy: refactor sanitize_mpol_flags for reuse
  mm/mempolicy: create struct mempolicy_args for creating new
    mempolicies
  mm/mempolicy: refactor kernel_get_mempolicy for code re-use
  mm/mempolicy: allow home_node to be set by mpol_new
  mm/mempolicy: add userland mempolicy arg structure
  mm/mempolicy: add set_mempolicy2 syscall
  mm/mempolicy: add get_mempolicy2 syscall
  mm/mempolicy: add the mbind2 syscall
  mm/mempolicy: extend set_mempolicy2 and mbind2 to support weighted
    interleave

Rakie Kim (1):
  mm/mempolicy: implement the sysfs-based weighted_interleave interface

 .../ABI/testing/sysfs-kernel-mm-mempolicy     |   4 +
 ...fs-kernel-mm-mempolicy-weighted-interleave |  22 +
 .../admin-guide/mm/numa_memory_policy.rst     |  67 ++
 arch/alpha/kernel/syscalls/syscall.tbl        |   3 +
 arch/arm/tools/syscall.tbl                    |   3 +
 arch/m68k/kernel/syscalls/syscall.tbl         |   3 +
 arch/microblaze/kernel/syscalls/syscall.tbl   |   3 +
 arch/mips/kernel/syscalls/syscall_n32.tbl     |   3 +
 arch/mips/kernel/syscalls/syscall_o32.tbl     |   3 +
 arch/parisc/kernel/syscalls/syscall.tbl       |   3 +
 arch/powerpc/kernel/syscalls/syscall.tbl      |   3 +
 arch/s390/kernel/syscalls/syscall.tbl         |   3 +
 arch/sh/kernel/syscalls/syscall.tbl           |   3 +
 arch/sparc/kernel/syscalls/syscall.tbl        |   3 +
 arch/x86/entry/syscalls/syscall_32.tbl        |   3 +
 arch/x86/entry/syscalls/syscall_64.tbl        |   3 +
 arch/xtensa/kernel/syscalls/syscall.tbl       |   3 +
 include/linux/mempolicy.h                     |  19 +
 include/linux/syscalls.h                      |   8 +
 include/uapi/asm-generic/unistd.h             |   8 +-
 include/uapi/linux/mempolicy.h                |  18 +-
 mm/mempolicy.c                                | 921 +++++++++++++++---
 22 files changed, 994 insertions(+), 115 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-mm-mempolicy
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave

-- 
2.39.1


