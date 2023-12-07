Return-Path: <linux-fsdevel+bounces-5072-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFFF807D51
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 01:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB2CD1C20953
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 00:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3F1ED5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 00:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahZnDzFr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x1144.google.com (mail-yw1-x1144.google.com [IPv6:2607:f8b0:4864:20::1144])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE33318D;
	Wed,  6 Dec 2023 16:28:10 -0800 (PST)
Received: by mail-yw1-x1144.google.com with SMTP id 00721157ae682-5d3644ca426so1010387b3.1;
        Wed, 06 Dec 2023 16:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701908890; x=1702513690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p2jrmbLAF90SkKFGh277QUQB5VktoD8qYGVqtPErfcM=;
        b=ahZnDzFryBtkIyX0PsIjS6rx91sgurvC84agAuLdBcZU2Xq+1C6BSfgAXw+VHz4LOi
         voGDvIQsEjMc0X/rDZffkebgc5xV8BwytW5++Uje7pD6d3d9Ybtibtx3YC2bwwOyf1Ks
         XrAgHkkZkG8AZeD4t98Uwmf73bfubX5x08Lq4rDHo6lRy6CWS2Op5BYj2y8ab6ZvBWv6
         3gB/hLR71RgvNeC/pURhRaGJB6gnR9QQ4CWdfnB7DWiHwW9hHNqHFnDKm3N6qYKibCv8
         N15/CZ+RbiVXbLMVxiy0oH/NN6p654dA8X8BO0WUghyGZiJq4GuaW7ICYoj1MWQrPnph
         42HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701908890; x=1702513690;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p2jrmbLAF90SkKFGh277QUQB5VktoD8qYGVqtPErfcM=;
        b=g+RmMLEmLzIGx4rw2A0hS7CC66BpQzWlRh35vUFxJ56Oqv1d5JGic748uDOh3PWgSD
         9UG0U0X/AINZbSqVFiqLAmkCEXnPcfFbrqibejoRCXVIF0JjSs9M36e+ox5hBlntSptY
         bko1Anae6ClUUiZwNEJUFnsOO/4KAq9SA5FXxPyk/DGTS4/M2iu3/25mio/o4QdSpa55
         9P2LFQ2O9dM/6odz4d9INghLW5WWTJdn0DcWpWxXCHpLWQ3XFdkGufa2PS0MoarRRDDR
         fG2BHPJfahAZrHrzlPXk3uI61FQK7mJpRjnCaX/k4YSebEVlChMBZzs7IboslqP/YKEZ
         Vzcw==
X-Gm-Message-State: AOJu0YzxI603g3WjkExDsJjEZfRRBs403esiR1u04bw7/DwpWLujSRix
	HKPXpbyOpqvFW3VHbaxwkg==
X-Google-Smtp-Source: AGHT+IEQJAoREK4xn8fsoXYjhaCunmOrXu+8IFSL9PQ5FsLRppKBmZuAP2/vtiTo6pDT7CHS3wM00A==
X-Received: by 2002:a81:aa09:0:b0:5d7:1941:355b with SMTP id i9-20020a81aa09000000b005d71941355bmr1862188ywh.66.1701908889569;
        Wed, 06 Dec 2023 16:28:09 -0800 (PST)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id x145-20020a81a097000000b005d82fc8cc92sm19539ywg.105.2023.12.06.16.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 16:28:09 -0800 (PST)
From: Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To: linux-mm@kvack.org,
	jgroves@micron.com,
	ravis.opensrc@micron.com,
	sthanneeru@micron.com,
	emirakhur@micron.com,
	Hasan.Maruf@amd.com
Cc: linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	arnd@arndb.de,
	tglx@linutronix.de,
	luto@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
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
	Johannes Weiner <hannes@cmpxchg.org>,
	Hasan Al Maruf <hasanalmaruf@fb.com>,
	Hao Wang <haowang3@fb.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Michal Hocko <mhocko@suse.com>,
	Zhongkun He <hezhongkun.hzk@bytedance.com>,
	Frank van der Linden <fvdl@google.com>,
	John Groves <john@jagalactic.com>,
	Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Subject: [RFC PATCH 00/11] mempolicy2, mbind2, and weighted interleave
Date: Wed,  6 Dec 2023 19:27:48 -0500
Message-Id: <20231207002759.51418-1-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch set extends the mempolicy interface to enable new
mempolicies which may require extended data to operate.

One such policy is included with this set as an example:
MPOL_WEIGHTED_INTERLEAVE

There are 3 major "phases" in the patch set:
1) Implement a "global weight" mechanism via sysfs, which allows
   set_mempolicy to implement MPOL_WEIGHTED_INTERLEAVE utilizing
   weights set by the administrator (or system daemon).

2) A refactor of the mempolicy creation mechanism to accept an
   extensible argument structure `struct mempolicy_args` to promote
   code re-use between the original mempolicy/mbind interfaces and
   the new extended mempolicy2/mbind2 interfaces.

3) Implementation of set_mempolicy2, get_mempolicy2, and mbind2,
   along with the addition of task-local weights so that per-task
   weights can be registered for MPOL_WEIGHTED_INTERLEAVE.

=====================================================================
(Patch 1) : sysfs addition - /sys/kernel/mm/mempolicy/

This feature  provides a way to set interleave weight information under
sysfs at /sys/kernel/mm/mempolicy/weighted_interleave/nodeN/nodeM/weight

    The sysfs structure is designed as follows.

      $ tree /sys/kernel/mm/mempolicy/
      /sys/kernel/mm/mempolicy/
      ├── cpu_nodes
      ├── possible_nodes
      └── weighted_interleave
          ├── nodeN
          │   ├── nodeM
          │   │     └── weight
          │   └── nodeM+X
          │         └── weight
          └── nodeN+X
              ├── nodeM
              │     └── weight
              └── node+X
                    └── weight

'cpu_nodes' and 'possible_nodes' is added to 'mm/mempolicy' to help
describe the expected structures under mempolicy directorys. For
example 'cpu_nodes' will describe what 'nodeN' directories will
exist in 'weighted_interleave', while 'possible_nodes' describes
what nodeM directories wille exist under the 'nodeN' directories.

Internally, weights are represented as a matrix of [src,dst] nodes.

struct interleave_weight_table {
        unsigned char weights[MAX_NUMNODES];
};
static struct interleave_weight_table *iw_table;

"Source Nodes" are nodes which have 1 or more CPUs, while "Destination
Nodes" include any possible node.  A "Possible" node is one which has
been reserved by the system, but which may or may not be online.

We present possible nodes, instead of online nodes, to simplify the
management interface, considering that a) the table of MAX_NUMNODES
size is allocated anyway to simplfy fetching of weights, and b) it
simplifies the management of hotplug events, allowing for weights to
be set prior to a node coming online which may be beneficial for
immediate use of the memory.

the 'weight' of a node (an unsigned char of value 1-255) is the number
of pages that are allocated during a "weighted interleave" round.
(See 'weighted interleave' for more details').

The [src,dst] matrix is implemented to allow for the capturing the
complexity of bandwidth distribution across a multi-socket, or
heterogeneous memory environment. For example, consider a 2-socket
Intel server with 1 CXL Memory expander attached to each socket.

From the perspective of a task on a CPU in Socket 0, the bandwidth
distribution is as follows:

Socket 0 DRAM:  (# DDR Channels) * (DDR Bandwidth)     ~400GB/s
Socket 0 CXL :  (# CXL Lanes) * (CXL Lane Bandwidth)    128GB/s
Socket 1 DRAM + CXL:   (# UPI Lanes) * (UPI Bandwidth) ~64GB/s

If the task is then migrated to Socket 1, the bandwidth distribution
flips to the following.

Socket 1 DRAM:  (# DDR Channels) * (DDR Bandwidth)     ~400GB/s
Socket 1 CXL :  (# CXL Lanes) * (CXL Lane Bandwidth)    128GB/s
Socket 0 DRAM + CXL:   (# UPI Lanes) * (UPI Bandwidth) ~64GB/s

The matrix allows for a 'source node' perspective weighting strategy,
which allows for migrated tasks to simply "re-weight" new allocations
immediately, by simply changing the [src] index they access in the
global interleave weight table.

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

Weights will be acquired from the global weight matrix exposed by the
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
    nodemask_t *policy_nodes;       /* get/set/mbind */
    int policy_node;                /* get: policy node information */
    unsigned long addr;             /* get: vma address */
    int addr_node;                  /* get: node the address belongs to */
    int home_node;                  /* mbind: use MPOL_MF_HOME_NODE */
    unsigned char *il_weights;      /* for mode MPOL_WEIGHTED_INTERLEAVE */
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
        unsigned short mode;
        unsigned short mode_flags;
        unsigned long *pol_nodes;
        unsigned long pol_maxnodes;
        /* get_mempolicy: policy node information */
        int policy_node;
        /* get_mempolicy: memory range policy */
        unsigned long addr;
        int addr_node;
        /* mbind2: policy home node */
        int home_node;
        /* mbind2: address ranges to apply the policy */
        struct iovec *vec;
        size_t vlen;
        /* weighted interleave settings */
        unsigned char *il_weights;      /* of size pol_maxnodes */
};

The basic mempolicy settings which are shared across all interfaces
are captured at the top of the structure, while extensions such as
'policy_node' and 'addr' are collected beneath.

The syscalls are uniform and defined as follows:

long sys_mbind2(struct mpol_args *args,
                size_t size,
                unsigned long flags);

long sys_get_mempolicy2(struct mpol_args *args,
                        size_t size,
                        unsigned long flags);

long sys_set_mempolicy2(struct mpol_args *args,
                        size_t size,
                        unsigned long flags);

The 'flags' argument for mbind2 is the same as 'mbind', except with
the addition of MPOL_MF_HOME_NODE to denote whether the 'home_node'
field should be utilized.

The 'flags' argument for get_mempolicy2 is the same as get_mempolicy.

The 'flags' argument is not used by 'set_mempolicy' at this time, but
may end up allowing the use of MPOL_MF_HOME_NODE if such functionality
is desired.

The extensions can be summed up as follows:

get_mempolicy2 extensions:
    'mode', 'policy_node', and 'addr_node' can now be fetched with
    a single call, rather than multiple with a combination of flags.
    - 'mode' will always return the policy mode
    - 'policy_node' will replace the functionality of MPOL_F_NODE
    - 'addr_node' will return the node for 'addr' w/ MPOL_F_ADDR

set_mempolicy2:
    - task-local interleave weights can be set via 'il_weights'
      (see next patch)

mbind2:
    - 'home_node' field sets policy home node w/ MPOL_MF_HOME_NODE
    - task-local interleave weights can be set via 'il_weights'
      (see next patch)
    - 'vec' and 'vlen' can be used to operate on multiple memory
      ranges, rather than a single memory range per syscall.

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
       pol_weights = iw_table[numa_node_id()].weights;
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

Gregory Price (9):
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

Rakie Kim (2):
  mm/mempolicy: implement the sysfs-based weighted_interleave interface
  mm/mempolicy: introduce MPOL_WEIGHTED_INTERLEAVE for weighted
    interleaving

 .../ABI/testing/sysfs-kernel-mm-mempolicy     |  33 +
 ...fs-kernel-mm-mempolicy-weighted-interleave |  35 +
 .../admin-guide/mm/numa_memory_policy.rst     |  85 ++
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
 include/linux/mempolicy.h                     |  21 +
 include/linux/syscalls.h                      |   6 +
 include/uapi/asm-generic/unistd.h             |   8 +-
 include/uapi/linux/mempolicy.h                |  27 +-
 mm/mempolicy.c                                | 960 ++++++++++++++++--
 22 files changed, 1103 insertions(+), 114 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-mm-mempolicy
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave

-- 
2.39.1


