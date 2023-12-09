Return-Path: <linux-fsdevel+bounces-5407-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B8880B29C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Dec 2023 08:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB887B20C60
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Dec 2023 07:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005761FDF;
	Sat,  9 Dec 2023 07:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSFHaeIs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91C91BE7;
	Fri,  8 Dec 2023 23:00:57 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id af79cd13be357-77f335002cfso150125585a.3;
        Fri, 08 Dec 2023 23:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702105257; x=1702710057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f0/QsDUqVOH9BytpPr3Z53rXKvjz2DVO81ae22Cz4+M=;
        b=PSFHaeIsQxT3fPp6v+QLIMdBumke8orGESvleO4YlR2NesdtdLebrfIWTh3GeLJEoX
         GHnBrM44EsYOsOxWS2DPAQUD3S4sS98BtE1i6x/K7PoJ3OsePTMm5wObnmk5PqhdN7Ry
         VO0pteh6G1vz22Lr6bzCSXxyCy1fvwU7C2XM0GzcaAiQV0st8SAMFCRxEDvCx+MVsXNH
         cI5JSLqV1/V3u/nP180g4D21p0KRm05YqDidTURza/YQ5SRliY5ntxZRelzATan6aicq
         /VrjhodbVxHopin9rrR6Kjz7K9YteFqKZ1WDyjMrDLl0iR7PR63454iQptro2KgsaARP
         Gbvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702105257; x=1702710057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f0/QsDUqVOH9BytpPr3Z53rXKvjz2DVO81ae22Cz4+M=;
        b=Bmzo/qnJSUGfxLkNJUz3akZt2g4PbZTTh/XfhqxJGeyKyJE4SyVsy2MB1xgZnpgkWn
         eMPvbaswRpcBfTRfb7JTLj6ayOQzFdcCxs6nh8BlGCxkU/AuYAMX27dwKMwpKjk6JuLi
         OvS9i3NS9upLLnQbi7wIawoA9xKwIb1ZHjzwAAa1LBRSs6u3NDXTBuYf9LWl4Czm9Vf2
         B3FW6WSAYGQH7kIW8jFF7+e9nnw+yKcjKjWj6FfsfUl3u0oiYwmLirWhVf0BnqbbNrdd
         Mq34FVHK4HLJxdkC5B5irUgw8GYWND5kwWMg7MKnndjDw6kuoYTG84fYdGuZWzMAuw0o
         c9aw==
X-Gm-Message-State: AOJu0YzldZiQ2qug1vLpg+iY/qz1fcPluH5iZVefyj+QEeq+DQsNKFfz
	FEkwoteq2psWl6zFfSpcSw==
X-Google-Smtp-Source: AGHT+IHzzAJgvXXv0VkKyzYw1q1C6HSp7DMbEqYwJaHNuPCI+sjP7dceW1TF3ra6bNoategdmsIdnQ==
X-Received: by 2002:a05:620a:370e:b0:77e:fba3:a23a with SMTP id de14-20020a05620a370e00b0077efba3a23amr1474903qkb.148.1702105256885;
        Fri, 08 Dec 2023 23:00:56 -0800 (PST)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id x8-20020a81b048000000b005df5d592244sm326530ywk.78.2023.12.08.23.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 23:00:56 -0800 (PST)
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
	Gregory Price <gregory@gregoryprice.net>
Subject: [PATCH v2 11/11] mm/mempolicy: extend set_mempolicy2 and mbind2 to support weighted interleave
Date: Sat,  9 Dec 2023 01:59:33 -0500
Message-Id: <20231209065931.3458-12-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231209065931.3458-1-gregory.price@memverge.com>
References: <20231209065931.3458-1-gregory.price@memverge.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gregory Price <gregory@gregoryprice.net>

Extend set_mempolicy2 and mbind2 to support weighted interleave, and
demonstrate the extensibility of the mpol_args structure.

To support weighted interleave we add interleave weight fields to the
following structures:

Kernel Internal:  (include/linux/mempolicy.h)
struct mempolicy {
	/* task-local weights to apply to weighted interleave */
	unsigned char weights[MAX_NUMNODES];
}
struct mempolicy_args {
	/* Optional: interleave weights for MPOL_WEIGHTED_INTERLEAVE */
	unsigned char *il_weights;	/* of size MAX_NUMNODES */
}

UAPI: (/include/uapi/linux/mempolicy.h)
struct mpol_args {
	/* Optional: interleave weights for MPOL_WEIGHTED_INTERLEAVE */
	unsigned char *il_weights;	/* of size pol_max_nodes */
}

The task-local weights are a single, one-dimensional array of weights
that apply to all possible nodes on the system.  If a node is set in
the mempolicy nodemask, the weight in `il_weights` must be >= 1,
otherwise set_mempolicy2() will return -EINVAL.  If a node is not
set in pol_nodemask, the weight will default to `1` in the task policy.

The default value of `1` is required to handle the situation where a
task migrates to a set of nodes for which weights were not set (up to
and including the local numa node).  For example, a migrated task whose
nodemask changes entirely will have all its weights defaulted back
to `1`, or if the nodemask changes to include a mix of nodes that
were not previously accounted for - the weighted interleave may be
suboptimal.

If migrations are expected, a task should prefer not to use task-local
interleave weights, and instead utilize the global settings for natural
re-weighting on migration.

To support global vs local weighting,  we add the kernel-internal flag:
MPOL_F_GWEIGHT (1 << 5) /* Utilize global weights */

This flag is set when il_weights is omitted by set_mempolicy2(), or
when MPOL_WEIGHTED_INTERLEAVE is set by set_mempolicy(). This internal
mode_flag dictates whether global weights or task-local weights are
utilized by the the various weighted interleave functions:

* weighted_interleave_nodes
* weighted_interleave_nid
* alloc_pages_bulk_array_weighted_interleave

if (pol->flags & MPOL_F_GWEIGHT)
	pol_weights = iw_table[numa_node_id()].weights;
else
	pol_weights = pol->wil.weights;

To simplify creations and duplication of mempolicies, the weights are
added as a structure directly within mempolicy. This allows the
existing logic in __mpol_dup to copy the weights without additional
allocations:

if (old == current->mempolicy) {
	task_lock(current);
	*new = *old;
	task_unlock(current);
} else
	*new = *old

Suggested-by: Rakie Kim <rakie.kim@sk.com>
Suggested-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
Suggested-by: Honggyu Kim <honggyu.kim@sk.com>
Suggested-by: Vinicius Tavares Petrucci <vtavarespetr@micron.com>
Signed-off-by: Gregory Price <gregory.price@memverge.com>
Co-developed-by: Rakie Kim <rakie.kim@sk.com>
Signed-off-by: Rakie Kim <rakie.kim@sk.com>
Co-developed-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
Signed-off-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
Co-developed-by: Honggyu Kim <honggyu.kim@sk.com>
Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
Co-developed-by: Vinicius Tavares Petrucci <vtavarespetr@micron.com>
Signed-off-by: Vinicius Tavares Petrucci <vtavarespetr@micron.com>
---
 .../admin-guide/mm/numa_memory_policy.rst     |  10 ++
 include/linux/mempolicy.h                     |   2 +
 include/uapi/linux/mempolicy.h                |   2 +
 mm/mempolicy.c                                | 105 +++++++++++++++++-
 4 files changed, 115 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/mm/numa_memory_policy.rst b/Documentation/admin-guide/mm/numa_memory_policy.rst
index f1ba33de3a6e..84c076af74c3 100644
--- a/Documentation/admin-guide/mm/numa_memory_policy.rst
+++ b/Documentation/admin-guide/mm/numa_memory_policy.rst
@@ -254,6 +254,8 @@ MPOL_WEIGHTED_INTERLEAVE
 	This mode operates the same as MPOL_INTERLEAVE, except that
 	interleaving behavior is executed based on weights set in
 	/sys/kernel/mm/mempolicy/weighted_interleave/
+	when configured to utilize global weights, or based on task-local
+	weights configured with set_mempolicy2(2) or mbind2(2).
 
 	Weighted interleave allocations pages on nodes according to
 	their weight.  For example if nodes [0,1] are weighted [5,2]
@@ -261,6 +263,13 @@ MPOL_WEIGHTED_INTERLEAVE
 	2 pages allocated on node1.  This can better distribute data
 	according to bandwidth on heterogeneous memory systems.
 
+	When utilizing task-local weights, weights are not rebalanced
+	in the event of a task migration.  If a weight has not been
+	explicitly set for a node set in the new nodemask, the
+	value of that weight defaults to "1".  For this reason, if
+	migrations are expected or possible, users should consider
+	utilizing global interleave weights.
+
 NUMA memory policy supports the following optional mode flags:
 
 MPOL_F_STATIC_NODES
@@ -516,6 +525,7 @@ Extended Mempolicy Arguments::
 		__u64 addr; /* get_mempolicy2: policy address */
 		__s32 policy_node; /* get_mempolicy2: policy node information */
 		__s32 addr_node; /* get_mempolicy2: memory range policy */
+		__aligned_u64 il_weights;  /* u8 buf of size pol_maxnodes */
 	};
 
 The extended mempolicy argument structure is defined to allow the mempolicy
diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index 117c5395c6eb..c78874bd84dd 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -58,6 +58,7 @@ struct mempolicy {
 	/* Weighted interleave settings */
 	struct {
 		unsigned char cur_weight;
+		unsigned char weights[MAX_NUMNODES];
 	} wil;
 };
 
@@ -73,6 +74,7 @@ struct mempolicy_args {
 	unsigned long addr;		/* get: vma address */
 	int addr_node;			/* get: node the address belongs to */
 	int home_node;			/* mbind: use MPOL_MF_HOME_NODE */
+	unsigned char *il_weights;	/* for mode MPOL_WEIGHTED_INTERLEAVE */
 };
 
 /*
diff --git a/include/uapi/linux/mempolicy.h b/include/uapi/linux/mempolicy.h
index 506ea0f8f34e..687c72fbe6a1 100644
--- a/include/uapi/linux/mempolicy.h
+++ b/include/uapi/linux/mempolicy.h
@@ -37,6 +37,7 @@ struct mpol_args {
 	__u64 addr;
 	__s32 policy_node;	/* get_mempolicy: policy node info */
 	__s32 addr_node;	/* get_mempolicy: memory range policy */
+	__aligned_u64 il_weights; /* size: pol_maxnodes * sizeof(char) */
 };
 
 /* Flags for set_mempolicy */
@@ -77,6 +78,7 @@ struct mpol_args {
 #define MPOL_F_SHARED  (1 << 0)	/* identify shared policies */
 #define MPOL_F_MOF	(1 << 3) /* this policy wants migrate on fault */
 #define MPOL_F_MORON	(1 << 4) /* Migrate On protnone Reference On Node */
+#define MPOL_F_GWEIGHT	(1 << 5) /* Utilize global weights */
 
 /*
  * These bit locations are exposed in the vm.zone_reclaim_mode sysctl
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 8f609204fbe7..e5f86e430207 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -271,6 +271,7 @@ static struct mempolicy *mpol_new(struct mempolicy_args *args)
 	unsigned short mode = args->mode;
 	unsigned short flags = args->mode_flags;
 	nodemask_t *nodes = args->policy_nodes;
+	int node;
 
 	if (mode == MPOL_DEFAULT) {
 		if (nodes && !nodes_empty(*nodes))
@@ -297,6 +298,19 @@ static struct mempolicy *mpol_new(struct mempolicy_args *args)
 		    (flags & MPOL_F_STATIC_NODES) ||
 		    (flags & MPOL_F_RELATIVE_NODES))
 			return ERR_PTR(-EINVAL);
+	} else if (mode == MPOL_WEIGHTED_INTERLEAVE) {
+		/* weighted interleave requires a nodemask and weights > 0 */
+		if (nodes_empty(*nodes))
+			return ERR_PTR(-EINVAL);
+		if (args->il_weights) {
+			node = first_node(*nodes);
+			while (node != MAX_NUMNODES) {
+				if (!args->il_weights[node])
+					return ERR_PTR(-EINVAL);
+				node = next_node(node, *nodes);
+			}
+		} else if (!(args->mode_flags & MPOL_F_GWEIGHT))
+			return ERR_PTR(-EINVAL);
 	} else if (nodes_empty(*nodes))
 		return ERR_PTR(-EINVAL);
 
@@ -309,6 +323,16 @@ static struct mempolicy *mpol_new(struct mempolicy_args *args)
 	policy->home_node = NUMA_NO_NODE;
 	policy->wil.cur_weight = 0;
 	policy->home_node = args->home_node;
+	if (policy->mode == MPOL_WEIGHTED_INTERLEAVE && args->il_weights) {
+		policy->wil.cur_weight = 0;
+		/* Minimum weight value is always 1 */
+		memset(policy->wil.weights, 1, MAX_NUMNODES);
+		node = first_node(*nodes);
+		while (node != MAX_NUMNODES) {
+			policy->wil.weights[node] = args->il_weights[node];
+			node = next_node(node, *nodes);
+		}
+	}
 
 	return policy;
 }
@@ -1518,6 +1542,9 @@ static long kernel_mbind(unsigned long start, unsigned long len,
 	if (err)
 		return err;
 
+	if (mode & MPOL_WEIGHTED_INTERLEAVE)
+		mode_flags |= MPOL_F_GWEIGHT;
+
 	memset(&margs, 0, sizeof(margs));
 	margs.mode = lmode;
 	margs.mode_flags = mode_flags;
@@ -1611,6 +1638,8 @@ SYSCALL_DEFINE5(mbind2, const struct iovec __user *, vec, size_t, vlen,
 	struct iovec iovstack[UIO_FASTIOV];
 	struct iovec *iov = iovstack;
 	struct iov_iter iter;
+	unsigned char weights[MAX_NUMNODES];
+	unsigned char *weights_ptr;
 	int err;
 
 	if (!vec || !vlen)
@@ -1648,6 +1677,20 @@ SYSCALL_DEFINE5(mbind2, const struct iovec __user *, vec, size_t, vlen,
 	} else
 		margs.policy_nodes = NULL;
 
+	if (kargs.mode == MPOL_WEIGHTED_INTERLEAVE) {
+		weights_ptr = u64_to_user_ptr(kargs.il_weights);
+		err = copy_struct_from_user(&weights,
+					    sizeof(weights),
+					    weights_ptr,
+					    kargs.pol_maxnodes);
+		if (err)
+			return err;
+		margs.il_weights = weights;
+	} else {
+		margs.il_weights = NULL;
+		flags |= MPOL_F_GWEIGHT;
+	}
+
 	/* For each address range in vector, do_mbind */
 	err = import_iovec(ITER_DEST, vec, vlen, ARRAY_SIZE(iovstack), &iov,
 			   &iter);
@@ -1686,6 +1729,9 @@ static long kernel_set_mempolicy(int mode, const unsigned long __user *nmask,
 	if (err)
 		return err;
 
+	if (mode & MPOL_WEIGHTED_INTERLEAVE)
+		mode_flags |= MPOL_F_GWEIGHT;
+
 	memset(&args, 0, sizeof(args));
 	args.mode = lmode;
 	args.mode_flags = mode_flags;
@@ -1709,6 +1755,8 @@ SYSCALL_DEFINE3(set_mempolicy2, struct mpol_args __user *, uargs, size_t, usize,
 	int err;
 	nodemask_t policy_nodemask;
 	unsigned long __user *nodes_ptr;
+	unsigned char weights[MAX_NUMNODES];
+	unsigned char __user *weights_ptr;
 
 	if (flags)
 		return -EINVAL;
@@ -1734,6 +1782,20 @@ SYSCALL_DEFINE3(set_mempolicy2, struct mpol_args __user *, uargs, size_t, usize,
 	} else
 		margs.policy_nodes = NULL;
 
+	if (kargs.mode == MPOL_WEIGHTED_INTERLEAVE && kargs.il_weights) {
+		weights_ptr = u64_to_user_ptr(kargs.il_weights);
+		err = copy_struct_from_user(weights,
+					    sizeof(weights),
+					    weights_ptr,
+					    kargs.pol_maxnodes);
+		if (err)
+			return err;
+		margs.il_weights = weights;
+	} else {
+		margs.il_weights = NULL;
+		flags |= MPOL_F_GWEIGHT;
+	}
+
 	return do_set_mempolicy(&margs);
 }
 
@@ -1935,6 +1997,8 @@ SYSCALL_DEFINE3(get_mempolicy2, struct mpol_args __user *, uargs, size_t, usize,
 	int err;
 	nodemask_t policy_nodemask;
 	unsigned long __user *nodes_ptr;
+	unsigned char *weights_ptr;
+	unsigned char weights[MAX_NUMNODES];
 
 	err = copy_struct_from_user(&kargs, sizeof(kargs), uargs, usize);
 	if (err)
@@ -1951,6 +2015,9 @@ SYSCALL_DEFINE3(get_mempolicy2, struct mpol_args __user *, uargs, size_t, usize,
 					  &policy_nodemask);
 	}
 
+	if (kargs.il_weights)
+		margs.il_weights = weights;
+
 	margs.policy_nodes = kargs.pol_nodes ? &policy_nodemask : NULL;
 	if (flags & MPOL_F_ADDR) {
 		margs.addr = kargs.addr;
@@ -1971,6 +2038,13 @@ SYSCALL_DEFINE3(get_mempolicy2, struct mpol_args __user *, uargs, size_t, usize,
 					 margs.policy_nodes);
 	}
 
+	if (kargs.il_weights) {
+		weights_ptr = u64_to_user_ptr(kargs.il_weights);
+		err = copy_to_user(weights_ptr, weights, kargs.pol_maxnodes);
+		if (err)
+			return err;
+	}
+
 	return copy_to_user(uargs, &kargs, usize) ? -EFAULT : 0;
 }
 
@@ -2087,13 +2161,18 @@ static unsigned int weighted_interleave_nodes(struct mempolicy *policy)
 {
 	unsigned int next;
 	struct task_struct *me = current;
+	unsigned char next_weight;
 
 	next = next_node_in(me->il_prev, policy->nodes);
 	if (next == MAX_NUMNODES)
 		return next;
 
-	if (!policy->wil.cur_weight)
-		policy->wil.cur_weight = iw_table[next];
+	if (!policy->wil.cur_weight) {
+		next_weight = (policy->flags & MPOL_F_GWEIGHT) ?
+				iw_table[next] :
+				policy->wil.weights[next];
+		policy->wil.cur_weight = next_weight ? next_weight : 1;
+	}
 
 	policy->wil.cur_weight--;
 	if (!policy->wil.cur_weight)
@@ -2167,6 +2246,7 @@ static unsigned int weighted_interleave_nid(struct mempolicy *pol, pgoff_t ilx)
 	nodemask_t nodemask = pol->nodes;
 	unsigned int target, weight_total = 0;
 	int nid;
+	unsigned char *pol_weights;
 	unsigned char weights[MAX_NUMNODES];
 	unsigned char weight;
 
@@ -2178,8 +2258,13 @@ static unsigned int weighted_interleave_nid(struct mempolicy *pol, pgoff_t ilx)
 		return nid;
 
 	/* Then collect weights on stack and calculate totals */
+	if (pol->flags & MPOL_F_GWEIGHT)
+		pol_weights = iw_table;
+	else
+		pol_weights = pol->wil.weights;
+
 	for_each_node_mask(nid, nodemask) {
-		weight = iw_table[nid];
+		weight = pol_weights[nid];
 		weight_total += weight;
 		weights[nid] = weight;
 	}
@@ -2577,6 +2662,7 @@ static unsigned long alloc_pages_bulk_array_weighted_interleave(gfp_t gfp,
 	unsigned long nr_allocated;
 	unsigned long rounds;
 	unsigned long node_pages, delta;
+	unsigned char *pol_weights;
 	unsigned char weight;
 	unsigned char weights[MAX_NUMNODES];
 	unsigned int weight_total;
@@ -2590,9 +2676,14 @@ static unsigned long alloc_pages_bulk_array_weighted_interleave(gfp_t gfp,
 
 	nnodes = nodes_weight(nodes);
 
+	if (pol->flags & MPOL_F_GWEIGHT)
+		pol_weights = iw_table;
+	else
+		pol_weights = pol->wil.weights;
+
 	/* Collect weights and save them on stack so they don't change */
 	for_each_node_mask(node, nodes) {
-		weight = iw_table[node];
+		weight = pol_weights[node];
 		weight_total += weight;
 		weights[node] = weight;
 	}
@@ -3117,6 +3208,7 @@ void mpol_shared_policy_init(struct shared_policy *sp, struct mempolicy *mpol)
 {
 	int ret;
 	struct mempolicy_args margs;
+	unsigned char weights[MAX_NUMNODES];
 
 	sp->root = RB_ROOT;		/* empty tree == default mempolicy */
 	rwlock_init(&sp->lock);
@@ -3134,6 +3226,11 @@ void mpol_shared_policy_init(struct shared_policy *sp, struct mempolicy *mpol)
 		margs.mode_flags = mpol->flags;
 		margs.policy_nodes = &mpol->w.user_nodemask;
 		margs.home_node = NUMA_NO_NODE;
+		if (margs.mode == MPOL_WEIGHTED_INTERLEAVE &&
+		    !(margs.mode_flags & MPOL_F_GWEIGHT)) {
+			memcpy(weights, mpol->wil.weights, sizeof(weights));
+			margs.il_weights = weights;
+		}
 
 		/* contextualize the tmpfs mount point mempolicy to this file */
 		npol = mpol_new(&margs);
-- 
2.39.1


