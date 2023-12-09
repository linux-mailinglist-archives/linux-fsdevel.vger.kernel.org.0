Return-Path: <linux-fsdevel+bounces-5396-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8C880B270
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Dec 2023 07:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FBC7B20CC2
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Dec 2023 06:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09BE1FB5;
	Sat,  9 Dec 2023 06:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EhIlwjk+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x1142.google.com (mail-yw1-x1142.google.com [IPv6:2607:f8b0:4864:20::1142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C754210D0;
	Fri,  8 Dec 2023 22:59:35 -0800 (PST)
Received: by mail-yw1-x1142.google.com with SMTP id 00721157ae682-5d8ddcc433fso23056197b3.1;
        Fri, 08 Dec 2023 22:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702105175; x=1702709975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YI1z9+ESJ3AC/4PJEXYNptSj3hiMyM6XJWuJ3/E5N/w=;
        b=EhIlwjk+MKiEFnDd/ObCnghQphStzvmx8MvZy7LQgo0KUQFAgF0JT1jGpHnghTqLv0
         QL7hvyrNpJx2UpzGbjSqyOR6FKd7XVz4ibiLxn6e65SXQKBmbZGDNyk8Mo4pmtudbT94
         kEAhG5ETNSFq2tHDQ2ZpXDy/LHMkyh9FdlAVbXNk4RxXBwUPr3gTbhI47DEzerFwudVb
         F1LZp6R53v+E3+hAn4yjqwKyrHbVEHDID7eugyMbPl06M+mRLf4jQpBRkMY0qOYGSh7N
         5ljMzQTnQDAUF+tgQ3IGWYe+vz3bi3yk6yUM92eCf/hUN2GHzR+c8UmhOdHn1EGSy7sm
         a0zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702105175; x=1702709975;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YI1z9+ESJ3AC/4PJEXYNptSj3hiMyM6XJWuJ3/E5N/w=;
        b=IA7IeNs+vJ9+ji4E04Ama7qtBpQQvAdteLrDWXKuct+zEC5Ltn+3Y3VRLbDPwVKxvK
         YdhmIbTIgM+YtRig2tEdgc81TzvIn2JxyDAy3sSLDc1SIb02bO8sdjRlfB/f/P5RiQpg
         CzafYHhCXuaRYre/NVEmpynqtkhrEMjRz4GibizDIUa6GV6DIqMx15OHrbls+yv6mQkQ
         +UinS4VAJjpmiDonvYBhBauxITOiHgYBBwle2rVA8sNjCexu4Qy7fkt8hZgy3hcKjuvr
         92NcYWaCYjY2bytMQmnsf9+iImR4gX+CvADxsuMvVQOHj8sIUUOhR//9YcuUmnTEgSME
         8nig==
X-Gm-Message-State: AOJu0YyWpD3JD+oExnpu2uS3KJnrmixgxddL3/70dOhkdEzFNUxnu/dy
	tAhytDbo7TYALW9JC9ln8g==
X-Google-Smtp-Source: AGHT+IEZFfc1V+oRjt07yJ4RSuXNK6K8aPmNz6FPdvo8zxvV+YrFla15aFjZS42iFGsIj1GU/dsqOQ==
X-Received: by 2002:a0d:d64c:0:b0:5d7:1940:8dcf with SMTP id y73-20020a0dd64c000000b005d719408dcfmr650906ywd.54.1702105174760;
        Fri, 08 Dec 2023 22:59:34 -0800 (PST)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id x8-20020a81b048000000b005df5d592244sm326530ywk.78.2023.12.08.22.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 22:59:34 -0800 (PST)
From: Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To: linux-mm@kvack.org
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
Subject: [PATCH v2 00/11] mempolicy2, mbind2, and weighted interleave
Date: Sat,  9 Dec 2023 01:59:20 -0500
Message-Id: <20231209065931.3458-1-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

v2:
  changes / adds:
- flattened weight matrix to an array at requested of Ying Huang
- Updated ABI docs per Davidlohr Bueso request
- change uapi structure to use aligned/fixed-length members as
  Suggested-by: Arnd Bergmann <arnd@arndb.de>
- Implemented weight fetch logic in get_mempolicy2
- mbind2 was changed to take (iovec,len) as function arguments
  rather than add them to the uapi structure, since they describe
  where to apply the mempolicy - as opposed to being part of it.

  fixes:
- fixed bug on fork/pthread
  Reported-by: Seungjun Ha <seungjun.ha@samsung.com>
  Link: https://lore.kernel.org/linux-cxl/20231206080944epcms2p76ebb230b9f4595f5cfcd2531d67ab3ce@epcms2p7/
- fixed bug in mbind2 where MPOL_F_GWEIGHTS was not set when il_weights
  was omitted after local weights were added as an option
- fixed bug in interleave logic where an OOB access was made if
  next_node_in returned MAX_NUMNODES
- fixed bug in bulk weighted interleave allocator where over-allocation
  could occur.

  tests:
- LTP: validated existing get_mempolicy, set_mempolicy, and mbind testss
- LTP: validated existing get_mempolicy, set_mempolicy, and mbind with
       MPOL_WEIGHTED_INTERLEAVE added.
- basic set_mempolicy2 tests and numactl -w --interleave tests

  numactl:
- Sample numactl extension for set_mempolicy available here:
  Link: https://github.com/gmprice/numactl/tree/weighted_interleave_master

(summary of LTP tests and manual tests added to end of cover letter)

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
sysfs at /sys/kernel/mm/mempolicy/weighted_interleave/nodeN/nodeM/weight

    The sysfs structure is designed as follows.

      $ tree /sys/kernel/mm/mempolicy/
      /sys/kernel/mm/mempolicy/
      ├── possible_nodes
      └── weighted_interleave
          ├── nodeN
          │   └── weight
          └── nodeN+X
              └── weight

'mempolicy' is added to '/sys/kernel/mm/' as a control group for
the mempolicy subsystem.

'possible_nodes' is added to 'mm/mempolicy' to help describe the
expected structures under mempolicy directorys. For example,
possible_nodes describes what nodeN directories wille exist under
the weighted_interleave directory.

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
        __u16 mode;
        __u16 mode_flags;
        __s32 home_node;
        __aligned_u64 pol_nodes;
        __u64 pol_maxnodes;
        __u64 addr;
        __s32 policy_node;
        __s32 addr_node;
        __aligned_u64 *il_weights;      /* of size pol_maxnodes */
};

The basic mempolicy settings which are shared across all interfaces
are captured at the top of the structure, while extensions such as
'policy_node' and 'addr' are collected beneath.

The syscalls are uniform and defined as follows:

long sys_mbind2(struct iovec *vec, size_t vlen,
                struct mpol_args *args, size_t usize,
                unsigned long flags);

long sys_get_mempolicy2(struct mpol_args *args, size_t size,
                        unsigned long flags);

long sys_set_mempolicy2(struct mpol_args *args, size_t size,
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
    - 'vec' and 'vlen' are sed to operate on multiple memory
       ranges, rather than a single memory range per syscall.
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

=====================================================================
Test Reports:

LTP set_mempolicy, get_mempolicy, mbind regression tests:

MPOL_WEIGHTED_INTERLEAVE added manually to test basic functionality
but did not adjust tests for weighting.  Basically the weights were
set to 1, which is the default, and it should behavior like standard
MPOL_INTERLEAVE if logic is correct.

== set_mempolicy01
Summary:
passed   18
failed   0
broken   0
skipped  0
warnings 0

== set_mempolicy02
Summary:
passed   10
failed   0
broken   0
skipped  0
warnings 0

== set_mempolicy03
Summary:
passed   64
failed   0
broken   0
skipped  0
warnings 0

== set_mempolicy04
Summary:
passed   32
failed   0
broken   0
skipped  0
warnings 0

== set_mempolicy05 - n/a on non-x86

== set_mempolicy06 - set_mempolicy02 + MPOL_WEIGHTED_INTERLEAVE
Summary:
passed   10
failed   0
broken   0
skipped  0
warnings 0

== set_mempolicy07 - set_mempolicy04 + MPOL_WEIGHTED_INTERLEAVE
Summary:
passed   32
failed   0
broken   0
skipped  0
warnings 0


== get_mempolicy01 - added MPOL_WEIGHTED_INTERLEAVE
Summary:
passed   12
failed   0
broken   0
skipped  0
warnings 0

== get_mempolicy02
Summary:
passed   2
failed   0
broken   0
skipped  0
warnings 0


== mbind01 - added WEIGHTED_INTERLEAVE
Summary:
passed   15
failed   0
broken   0
skipped  0
warnings 0

== mbind02 - added WEIGHTED_INTERLEAVE
Summary:
passed   4
failed   0
broken   0
skipped  0
warnings 0

== mbind03 - added WEIGHTED_INTERLEAVE
Summary:
passed   16
failed   0
broken   0
skipped  0
warnings 0

== mbind04 - added WEIGHTED_INTERLEAVE
Summary:
passed   48
failed   0
broken   0
skipped  0
warnings 0

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
        uint64_t pol_maxnodes;
        uint64_t addr;
        int32_t policy_node;
        int32_t addr_node;
        uint64_t il_weights;
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
        wil_args.pol_maxnodes = total_nodes + 1;
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

 .../ABI/testing/sysfs-kernel-mm-mempolicy     |  18 +
 ...fs-kernel-mm-mempolicy-weighted-interleave |  21 +
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
 include/linux/mempolicy.h                     |  21 +
 include/linux/syscalls.h                      |   7 +
 include/uapi/asm-generic/unistd.h             |   8 +-
 include/uapi/linux/mempolicy.h                |  20 +-
 mm/mempolicy.c                                | 946 ++++++++++++++++--
 22 files changed, 1036 insertions(+), 114 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-mm-mempolicy
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave

-- 
2.39.1


