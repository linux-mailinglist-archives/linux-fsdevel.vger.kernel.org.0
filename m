Return-Path: <linux-fsdevel+bounces-5083-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD95F807D5D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 01:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAEE61F2177B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 00:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118065C9A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 00:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFs9INeN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x1143.google.com (mail-yw1-x1143.google.com [IPv6:2607:f8b0:4864:20::1143])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC3510FE;
	Wed,  6 Dec 2023 16:28:34 -0800 (PST)
Received: by mail-yw1-x1143.google.com with SMTP id 00721157ae682-5d8ddcc433fso905317b3.1;
        Wed, 06 Dec 2023 16:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701908914; x=1702513714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8sMKntUCwGORCmofLfZT1MSDcnyRiDF38MmkYVSlo18=;
        b=KFs9INeNqgy6vR24SFP/lML49e+j1nzr1Sd+W5DrYenr9zGWYK/jDXuMRMl1/mqDIi
         XF9v5/HZfz6XNTgXGA3QC8qJSObbcF+oCzGM/Bze1aQqTG5ohpaSi2BaCsafhlbm+x3/
         xmiWGujhl1UvFYp0K03IGLDVH2O//omklmRqJla4noJBU4IIR9DrjsP2YJwX86GX4kV6
         dn+Hr+9OkAYcYR9EjmI+kVHvbCd8zSeZ88ETIodfnfHZYcM4f2FRqYJPmn30nUy9B7pe
         YPYUZEHXmrZ/K0J55lW8AhxG9fcU8pRY+wU2+gJiQ6wPZHYlBElFmdj2m/Gpc8v8Y72U
         qOTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701908914; x=1702513714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8sMKntUCwGORCmofLfZT1MSDcnyRiDF38MmkYVSlo18=;
        b=N3n0V194E+hqRTgcjlJPFu88ZeC61nTpDmN5FTbDeRAo3DOu1c1GCZtvpw3eDWMAdv
         cFtiS74hgwltiuDuD62AnLyT7nWR2gbOBZ9b1dQhnjf4XarlWM8LV4IYwMYQUuzQz7Ac
         mBFY9pHyFcIbBNwZ06w7B5cuAbDKU8ciFEaDHun3Y3OJabRB9+/DabH4W3imsDaOm+xO
         FCtRsg4Ld8AI8QVyNooC88iJClwdVHgGuMxCScsOW4li4tmJnwLUUUqjQzXKavlGzTgZ
         1B1fbTH6ukBdeFdaZEZ90t1MzqgZTOw3qImzE+pZ1XVtyRebC+bUW/VtusrNAl+AJbQe
         gNcA==
X-Gm-Message-State: AOJu0YwR6ikmndscN4AVw9Tbxp9CrHT7cVksjQuAoD8vo1uKlRpyoFKx
	D62BmP/3cKpIYYt0Hm1KAQ==
X-Google-Smtp-Source: AGHT+IHmyuouwkkne7RrSVBTRF2p/91Z1VhvWmitMBtJZHL73MgXl2+R3+Qk4aVsbxdFCFBs22j++A==
X-Received: by 2002:a81:528f:0:b0:5d7:1940:8df7 with SMTP id g137-20020a81528f000000b005d719408df7mr1276443ywb.94.1701908913726;
        Wed, 06 Dec 2023 16:28:33 -0800 (PST)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id x145-20020a81a097000000b005d82fc8cc92sm19539ywg.105.2023.12.06.16.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 16:28:33 -0800 (PST)
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
	Gregory Price <gregory@gregoryprice.net>
Subject: [RFC PATCH 11/11] mm/mempolicy: extend set_mempolicy2 and mbind2 to support weighted interleave
Date: Wed,  6 Dec 2023 19:27:59 -0500
Message-Id: <20231207002759.51418-12-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231207002759.51418-1-gregory.price@memverge.com>
References: <20231207002759.51418-1-gregory.price@memverge.com>
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
 .../admin-guide/mm/numa_memory_policy.rst     | 13 ++-
 include/linux/mempolicy.h                     |  2 +
 include/uapi/linux/mempolicy.h                |  3 +
 mm/mempolicy.c                                | 87 ++++++++++++++++++-
 4 files changed, 100 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/mm/numa_memory_policy.rst b/Documentation/admin-guide/mm/numa_memory_policy.rst
index 72ab21e24ec2..f3a9dcbaa7ed 100644
--- a/Documentation/admin-guide/mm/numa_memory_policy.rst
+++ b/Documentation/admin-guide/mm/numa_memory_policy.rst
@@ -254,7 +254,8 @@ MPOL_WEIGHTED_INTERLEAVE
 	This mode operates the same as MPOL_INTERLEAVE, except that
 	interleaving behavior is executed based on weights set in
 	/sys/kernel/mm/mempolicy/weighted_interleave/
-	rather than simple round-robin interleave (which is the default).
+	when configured to utilize global weights, or based on task-local
+	weights configured with set_mempolicy2(2) or mbind2(2).
 
 	When utilizing global weights from the sysfs interface,
 	weights are applied in a src-node relative manner.  For example
@@ -267,6 +268,13 @@ MPOL_WEIGHTED_INTERLEAVE
 	cgroup initiated migrations) to re-weight for the optimal
 	distribution of bandwidth.
 
+	When utilizing task-local weights, weights are not rebalanced
+	in the event of a task migration.  If a weight has not been
+	explicitly set for a node set in the new nodemask, the
+	value of that weight defaults to "1".  For this reason, if
+	migrations are expected or possible, users should consider
+	utilizing global interleave weights.
+
 NUMA memory policy supports the following optional mode flags:
 
 MPOL_F_STATIC_NODES
@@ -533,6 +541,9 @@ Extended Mempolicy Arguments::
 		/* mbind2: address ranges to apply the policy */
 		struct iovec *vec;
 		size_t vlen;
+
+		/* weighted interleave settings */
+		unsigned char *il_weights;  /* of size pol_maxnodes */
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
index 3e463442fe28..c2f229037be3 100644
--- a/include/uapi/linux/mempolicy.h
+++ b/include/uapi/linux/mempolicy.h
@@ -43,6 +43,8 @@ struct mpol_args {
 	/* mbind2: address ranges to apply the policy */
 	struct iovec *vec;
 	size_t vlen;
+	/* weighted interleave settings */
+	unsigned char *il_weights;	/* of size pol_maxnodes */
 };
 
 /* Flags for set_mempolicy */
@@ -83,6 +85,7 @@ struct mpol_args {
 #define MPOL_F_SHARED  (1 << 0)	/* identify shared policies */
 #define MPOL_F_MOF	(1 << 3) /* this policy wants migrate on fault */
 #define MPOL_F_MORON	(1 << 4) /* Migrate On protnone Reference On Node */
+#define MPOL_F_GWEIGHT	(1 << 5) /* Utilize global weights */
 
 /*
  * These bit locations are exposed in the vm.zone_reclaim_mode sysctl
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index c203cea52ce9..7273bb9540fa 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -274,6 +274,7 @@ static struct mempolicy *mpol_new(struct mempolicy_args *args)
 	unsigned short mode = args->mode;
 	unsigned short flags = args->mode_flags;
 	nodemask_t *nodes = args->policy_nodes;
+	int node;
 
 	if (mode == MPOL_DEFAULT) {
 		if (nodes && !nodes_empty(*nodes))
@@ -300,6 +301,19 @@ static struct mempolicy *mpol_new(struct mempolicy_args *args)
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
 
@@ -312,6 +326,16 @@ static struct mempolicy *mpol_new(struct mempolicy_args *args)
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
@@ -1612,6 +1636,7 @@ SYSCALL_DEFINE3(mbind2, struct mpol_args __user *, uargs, size_t, usize,
 	struct iovec iovstack[UIO_FASTIOV];
 	struct iovec *iov = iovstack;
 	struct iov_iter iter;
+	unsigned char weights[MAX_NUMNODES];
 	int err;
 
 	err = copy_struct_from_user(&kargs, sizeof(kargs), uargs, usize);
@@ -1648,6 +1673,19 @@ SYSCALL_DEFINE3(mbind2, struct mpol_args __user *, uargs, size_t, usize,
 	} else
 		margs.policy_nodes = NULL;
 
+	if (kargs.mode == MPOL_WEIGHTED_INTERLEAVE) {
+		err = copy_struct_from_user(&weights,
+					    sizeof(weights),
+					    &kargs.il_weights,
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
 	err = import_iovec(ITER_DEST, kargs.vec, kargs.vlen,
 			   ARRAY_SIZE(iovstack), &iov, &iter);
@@ -1686,6 +1724,9 @@ static long kernel_set_mempolicy(int mode, const unsigned long __user *nmask,
 	if (err)
 		return err;
 
+	if (mode & MPOL_WEIGHTED_INTERLEAVE)
+		mode_flags |= MPOL_F_GWEIGHT;
+
 	memset(&args, 0, sizeof(args));
 	args.mode = lmode;
 	args.mode_flags = mode_flags;
@@ -1708,6 +1749,7 @@ SYSCALL_DEFINE3(set_mempolicy2, struct mpol_args __user *, uargs, size_t, usize,
 	struct mempolicy_args margs;
 	int err;
 	nodemask_t policy_nodemask;
+	unsigned char weights[MAX_NUMNODES];
 
 	if (flags)
 		return -EINVAL;
@@ -1732,6 +1774,19 @@ SYSCALL_DEFINE3(set_mempolicy2, struct mpol_args __user *, uargs, size_t, usize,
 	} else
 		margs.policy_nodes = NULL;
 
+	if (kargs.mode == MPOL_WEIGHTED_INTERLEAVE && kargs.il_weights) {
+		err = copy_struct_from_user(weights,
+					    sizeof(weights),
+					    kargs.il_weights,
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
 
@@ -2081,16 +2136,22 @@ static unsigned int weighted_interleave_nodes(struct mempolicy *policy)
 {
 	unsigned int next;
 	struct task_struct *me = current;
+	unsigned char *weights;
 
 	if (policy->wil.cur_weight > 0) {
 		policy->wil.cur_weight--;
 		return me->il_prev;
 	}
 
+	if (policy->flags & MPOL_F_GWEIGHT)
+		weights = iw_table[numa_node_id()].weights;
+	else
+		weights = policy->wil.weights;
+
 	next = next_node_in(me->il_prev, policy->nodes);
 	if (next < MAX_NUMNODES) {
 		me->il_prev = next;
-		policy->wil.cur_weight = iw_table[numa_node_id()].weights[next];
+		policy->wil.cur_weight = weights[next];
 	}
 	return next;
 }
@@ -2160,15 +2221,21 @@ static unsigned int weighted_interleave_nid(struct mempolicy *pol, pgoff_t ilx)
 {
 	nodemask_t nodemask = pol->nodes;
 	unsigned int target, weight_total = 0;
-	int nid, local_node = numa_node_id();
+	int nid;
+	unsigned char *pol_weights;
 	unsigned char weights[MAX_NUMNODES];
 	unsigned char weight;
 
 	barrier();
 
+	if (pol->flags & MPOL_F_GWEIGHT)
+		pol_weights = iw_table[numa_node_id()].weights;
+	else
+		pol_weights = pol->wil.weights;
+
 	/* Collect weights and save them on stack so they don't change */
 	for_each_node_mask(nid, nodemask) {
-		weight = iw_table[local_node].weights[nid];
+		weight = pol_weights[nid];
 		weight_total += weight;
 		weights[nid] = weight;
 	}
@@ -2564,6 +2631,7 @@ static unsigned long alloc_pages_bulk_array_weighted_interleave(gfp_t gfp,
 	unsigned long nr_allocated;
 	unsigned long rounds;
 	unsigned long node_pages, delta;
+	unsigned char *pol_weights;
 	unsigned char weight;
 	unsigned char weights[MAX_NUMNODES];
 	unsigned int weight_total;
@@ -2576,9 +2644,14 @@ static unsigned long alloc_pages_bulk_array_weighted_interleave(gfp_t gfp,
 
 	nnodes = nodes_weight(nodes);
 
+	if (pol->flags & MPOL_F_GWEIGHT)
+		pol_weights = iw_table[numa_node_id()].weights;
+	else
+		pol_weights = pol->wil.weights;
+
 	/* Collect weights and save them on stack so they don't change */
 	for_each_node_mask(node, nodes) {
-		weight = iw_table[numa_node_id()].weights[node];
+		weight = pol_weights[node];
 		weight_total += weight;
 		weights[node] = weight;
 	}
@@ -3095,6 +3168,7 @@ void mpol_shared_policy_init(struct shared_policy *sp, struct mempolicy *mpol)
 {
 	int ret;
 	struct mempolicy_args margs;
+	unsigned char weights[MAX_NUMNODES];
 
 	sp->root = RB_ROOT;		/* empty tree == default mempolicy */
 	rwlock_init(&sp->lock);
@@ -3112,6 +3186,11 @@ void mpol_shared_policy_init(struct shared_policy *sp, struct mempolicy *mpol)
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


