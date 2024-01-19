Return-Path: <linux-fsdevel+bounces-8324-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E19832E84
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 18:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A5431F23022
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 17:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F95C58208;
	Fri, 19 Jan 2024 17:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zj870H3V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45165788D;
	Fri, 19 Jan 2024 17:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705687071; cv=none; b=AsuBvILkmArrENmLgJxivmWBOFS7QR6IzTuAM0v8R0v2nJcMQltWcAeTzxkFCP0yELon+w+jy7YWGoBjEAFGWznOQYvyQpn7LKQSZE9tqvfMex64EdBPgPAYYXmPeN4a1jnniIWaAAHRlOwmJD4DM7yTnc3khmKLRViqRP7v1Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705687071; c=relaxed/simple;
	bh=HsBwcnAp4Ec+T+Ri7eUs16RhiZeIwmWWOPvKM/u+Ckc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bJGHnoVaS3ZFN/HbfVig7Ase2q4g4sPmS73eS/ObObqCPQn/g9Wa/MqWKITkF8ca/F/GwOT/R2NoMrH8+JY7OYpDt6oo0UvTL7coVwSpjrKyBkgFqJADkvbrcuWJNm3IF0Dsy6I8R7r8M6k6T7iCxldAR/Y0Hsek2lSs2CGC+6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zj870H3V; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-5c66b093b86so1677790a12.0;
        Fri, 19 Jan 2024 09:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705687069; x=1706291869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xYdTXegllZnwUd7P10iCK/8wjQlu7DI3LPWKbF+wNP4=;
        b=Zj870H3V5E3Syk/yizBqtsE72xMnw24XnH2ndR5zmMG+JoF9FBhMWBXKdi36hCth1L
         Ie/wzKVOdftxWW+lXry4nPomoNnlWn5IZNX1f811WrrSVxAedbYnR/71Vhb1yT4MFRhs
         PX36gfDTAEeoDLbEsuVWOe74MTn9Et66JwBLs0VRVOTSqLyCcPFp6wHqihbkb26uQf4c
         zVbCV+jN15sCSrn5//blH9EnQm22OSmBSABx/IMYGNWp6Tg+aRH9euWB//T62Ye8p0C1
         X5QQp1w75WhmSYCfG95X9vNcNhW/JvjZ9ov6Dw8UrXKe5aq269WQu8E8EVDMEM7k+pgy
         NC8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705687069; x=1706291869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xYdTXegllZnwUd7P10iCK/8wjQlu7DI3LPWKbF+wNP4=;
        b=PtzcGkDe6chEZZ0TnMTxcfE3xueV6po88MnwN0NH8Exa2ni5d3v+ZKO4BAjr4V1xIm
         g33OLvmtwBcAmlrjJkHRMm6bsBJYY8dKpfI4gIHjrguj2UCAzWunfrrw5FuUgtrSBIxz
         IT8G12Sd+v6R75HYF66D7W/JBXgWY+y/+nOb9iGlujTSrJSxKksWjtFCdGsbv0pLJBSN
         S9qkokHe51UzK1ysBTSAtPTSkxrYJiaKr6S0bM8JnVUam4Ot0xF7ACbpsgdEXqpZG9qi
         TaUjL3mnVlZ5I56SguA4ijVR8VO05+m3UNrijKUOZbRnj4njGTnmkUAQxnguTLsZ2cIU
         Bc+g==
X-Gm-Message-State: AOJu0Yyc4Zr6sXB7Bc6JUEhTDk3Ai2zRMTFIYl9OKos3g9hJ22kbOJu+
	k3pOfWsnA//SHkf06kxuPzGHCun8MIr6clYhmeJ89FXKjDKBA2zZxxRy7NxOTnTr
X-Google-Smtp-Source: AGHT+IHdR2xaCWUc/NXZ6rfAOlpQ+4q2jubABI1mQChuoE4D92PMJD/I4hwji7oIwhRxml30oPrdww==
X-Received: by 2002:a17:90a:cb11:b0:28f:f846:4ee8 with SMTP id z17-20020a17090acb1100b0028ff8464ee8mr1953516pjt.7.1705687069105;
        Fri, 19 Jan 2024 09:57:49 -0800 (PST)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id sh18-20020a17090b525200b002901ded7356sm4202670pjb.2.2024.01.19.09.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 09:57:48 -0800 (PST)
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
	Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>
Subject: [PATCH v2 3/3] mm/mempolicy: introduce MPOL_WEIGHTED_INTERLEAVE for weighted interleaving
Date: Fri, 19 Jan 2024 12:57:30 -0500
Message-Id: <20240119175730.15484-4-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240119175730.15484-1-gregory.price@memverge.com>
References: <20240119175730.15484-1-gregory.price@memverge.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a system has multiple NUMA nodes and it becomes bandwidth hungry,
using the current MPOL_INTERLEAVE could be an wise option.

However, if those NUMA nodes consist of different types of memory such
as socket-attached DRAM and CXL/PCIe attached DRAM, the round-robin
based interleave policy does not optimally distribute data to make use
of their different bandwidth characteristics.

Instead, interleave is more effective when the allocation policy follows
each NUMA nodes' bandwidth weight rather than a simple 1:1 distribution.

This patch introduces a new memory policy, MPOL_WEIGHTED_INTERLEAVE,
enabling weighted interleave between NUMA nodes.  Weighted interleave
allows for proportional distribution of memory across multiple numa
nodes, preferably apportioned to match the bandwidth of each node.

For example, if a system has 1 CPU node (0), and 2 memory nodes (0,1),
with bandwidth of (100GB/s, 50GB/s) respectively, the appropriate
weight distribution is (2:1).

Weights for each node can be assigned via the new sysfs extension:
/sys/kernel/mm/mempolicy/weighted_interleave/

For now, the default value of all nodes will be `1`, which matches
the behavior of standard 1:1 round-robin interleave. An extension
will be added in the future to allow default values to be registered
at kernel and device bringup time.

The policy allocates a number of pages equal to the set weights. For
example, if the weights are (2,1), then 2 pages will be allocated on
node0 for every 1 page allocated on node1.

The new flag MPOL_WEIGHTED_INTERLEAVE can be used in set_mempolicy(2)
and mbind(2).

There are 3 integration points:

weighted_interleave_nodes:
    Counts the number of allocations as they occur, and applies the
    weight for the current node.  When the weight reaches 0, switch
    to the next node.

weighted_interleave_nid:
    Gets the total weight of the nodemask as well as each individual
    node weight, then calculates the node based on the given index.

bulk_array_weighted_interleave:
    Gets the total weight of the nodemask as well as each individual
    node weight, then calculates the number of "interleave rounds" as
    well as any delta ("partial round").  Calculates the number of
    pages for each node and allocates them.

    If a node was scheduled for interleave via interleave_nodes, the
    current weight (pol->cur_weight) will be allocated first, before
    the remaining bulk calculation is done.

One piece of complexity is the interaction between a recent refactor
which split the logic to acquire the "ilx" (interleave index) of an
allocation and the actually application of the interleave.  The
calculation of the `interleave index` is done by `get_vma_policy()`,
while the actual selection of the node will be later appliex by the
relevant weighted_interleave function.

Suggested-by: Hasan Al Maruf <Hasan.Maruf@amd.com>
Signed-off-by: Gregory Price <gregory.price@memverge.com>
Co-developed-by: Rakie Kim <rakie.kim@sk.com>
Signed-off-by: Rakie Kim <rakie.kim@sk.com>
Co-developed-by: Honggyu Kim <honggyu.kim@sk.com>
Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
Co-developed-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
Signed-off-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
Co-developed-by: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>
Signed-off-by: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>
Co-developed-by: Ravi Jonnalagadda <ravis.opensrc@micron.com>
Signed-off-by: Ravi Jonnalagadda <ravis.opensrc@micron.com>
---
 .../admin-guide/mm/numa_memory_policy.rst     |   9 +
 include/linux/mempolicy.h                     |   5 +
 include/uapi/linux/mempolicy.h                |   1 +
 mm/mempolicy.c                                | 234 +++++++++++++++++-
 4 files changed, 246 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/mm/numa_memory_policy.rst b/Documentation/admin-guide/mm/numa_memory_policy.rst
index eca38fa81e0f..a70f20ce1ffb 100644
--- a/Documentation/admin-guide/mm/numa_memory_policy.rst
+++ b/Documentation/admin-guide/mm/numa_memory_policy.rst
@@ -250,6 +250,15 @@ MPOL_PREFERRED_MANY
 	can fall back to all existing numa nodes. This is effectively
 	MPOL_PREFERRED allowed for a mask rather than a single node.
 
+MPOL_WEIGHTED_INTERLEAVE
+	This mode operates the same as MPOL_INTERLEAVE, except that
+	interleaving behavior is executed based on weights set in
+	/sys/kernel/mm/mempolicy/weighted_interleave/
+
+	Weighted interleave allocates pages on nodes according to a
+	weight.  For example if nodes [0,1] are weighted [5,2], 5 pages
+	will be allocated on node0 for every 2 pages allocated on node1.
+
 NUMA memory policy supports the following optional mode flags:
 
 MPOL_F_STATIC_NODES
diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index 931b118336f4..c1a083eb0dd5 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -54,6 +54,11 @@ struct mempolicy {
 		nodemask_t cpuset_mems_allowed;	/* relative to these nodes */
 		nodemask_t user_nodemask;	/* nodemask passed by user */
 	} w;
+
+	/* Weighted interleave settings */
+	struct {
+		u8 cur_weight;
+	} wil;
 };
 
 /*
diff --git a/include/uapi/linux/mempolicy.h b/include/uapi/linux/mempolicy.h
index a8963f7ef4c2..1f9bb10d1a47 100644
--- a/include/uapi/linux/mempolicy.h
+++ b/include/uapi/linux/mempolicy.h
@@ -23,6 +23,7 @@ enum {
 	MPOL_INTERLEAVE,
 	MPOL_LOCAL,
 	MPOL_PREFERRED_MANY,
+	MPOL_WEIGHTED_INTERLEAVE,
 	MPOL_MAX,	/* always last member of enum */
 };
 
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 427bddf115df..aa3b2389d3e0 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -19,6 +19,13 @@
  *                for anonymous memory. For process policy an process counter
  *                is used.
  *
+ * weighted interleave
+ *                Allocate memory interleaved over a set of nodes based on
+ *                a set of weights (per-node), with normal fallback if it
+ *                fails.  Otherwise operates the same as interleave.
+ *                Example: nodeset(0,1) & weights (2,1) - 2 pages allocated
+ *                on node 0 for every 1 page allocated on node 1.
+ *
  * bind           Only allocate memory on a specific set of nodes,
  *                no fallback.
  *                FIXME: memory is allocated starting with the first node
@@ -313,6 +320,7 @@ static struct mempolicy *mpol_new(unsigned short mode, unsigned short flags,
 	policy->mode = mode;
 	policy->flags = flags;
 	policy->home_node = NUMA_NO_NODE;
+	policy->wil.cur_weight = 0;
 
 	return policy;
 }
@@ -425,6 +433,10 @@ static const struct mempolicy_operations mpol_ops[MPOL_MAX] = {
 		.create = mpol_new_nodemask,
 		.rebind = mpol_rebind_preferred,
 	},
+	[MPOL_WEIGHTED_INTERLEAVE] = {
+		.create = mpol_new_nodemask,
+		.rebind = mpol_rebind_nodemask,
+	},
 };
 
 static bool migrate_folio_add(struct folio *folio, struct list_head *foliolist,
@@ -846,7 +858,8 @@ static long do_set_mempolicy(unsigned short mode, unsigned short flags,
 
 	old = current->mempolicy;
 	current->mempolicy = new;
-	if (new && new->mode == MPOL_INTERLEAVE)
+	if (new && (new->mode == MPOL_INTERLEAVE ||
+		    new->mode == MPOL_WEIGHTED_INTERLEAVE))
 		current->il_prev = MAX_NUMNODES-1;
 	task_unlock(current);
 	mpol_put(old);
@@ -872,6 +885,7 @@ static void get_policy_nodemask(struct mempolicy *pol, nodemask_t *nodes)
 	case MPOL_INTERLEAVE:
 	case MPOL_PREFERRED:
 	case MPOL_PREFERRED_MANY:
+	case MPOL_WEIGHTED_INTERLEAVE:
 		*nodes = pol->nodes;
 		break;
 	case MPOL_LOCAL:
@@ -956,6 +970,13 @@ static long do_get_mempolicy(int *policy, nodemask_t *nmask,
 		} else if (pol == current->mempolicy &&
 				pol->mode == MPOL_INTERLEAVE) {
 			*policy = next_node_in(current->il_prev, pol->nodes);
+		} else if (pol == current->mempolicy &&
+				(pol->mode == MPOL_WEIGHTED_INTERLEAVE)) {
+			if (pol->wil.cur_weight)
+				*policy = current->il_prev;
+			else
+				*policy = next_node_in(current->il_prev,
+						       pol->nodes);
 		} else {
 			err = -EINVAL;
 			goto out;
@@ -1785,7 +1806,8 @@ struct mempolicy *get_vma_policy(struct vm_area_struct *vma,
 	pol = __get_vma_policy(vma, addr, ilx);
 	if (!pol)
 		pol = get_task_policy(current);
-	if (pol->mode == MPOL_INTERLEAVE) {
+	if (pol->mode == MPOL_INTERLEAVE ||
+	    pol->mode == MPOL_WEIGHTED_INTERLEAVE) {
 		*ilx += vma->vm_pgoff >> order;
 		*ilx += (addr - vma->vm_start) >> (PAGE_SHIFT + order);
 	}
@@ -1835,6 +1857,28 @@ bool apply_policy_zone(struct mempolicy *policy, enum zone_type zone)
 	return zone >= dynamic_policy_zone;
 }
 
+static unsigned int weighted_interleave_nodes(struct mempolicy *policy)
+{
+	unsigned int next;
+	struct task_struct *me = current;
+	u8 __rcu *table;
+
+	next = next_node_in(me->il_prev, policy->nodes);
+	if (next == MAX_NUMNODES)
+		return next;
+
+	rcu_read_lock();
+	table = rcu_dereference(iw_table);
+	if (!policy->wil.cur_weight)
+		policy->wil.cur_weight = table ? table[next] : 1;
+	rcu_read_unlock();
+
+	policy->wil.cur_weight--;
+	if (!policy->wil.cur_weight)
+		me->il_prev = next;
+	return next;
+}
+
 /* Do dynamic interleaving for a process */
 static unsigned int interleave_nodes(struct mempolicy *policy)
 {
@@ -1869,6 +1913,9 @@ unsigned int mempolicy_slab_node(void)
 	case MPOL_INTERLEAVE:
 		return interleave_nodes(policy);
 
+	case MPOL_WEIGHTED_INTERLEAVE:
+		return weighted_interleave_nodes(policy);
+
 	case MPOL_BIND:
 	case MPOL_PREFERRED_MANY:
 	{
@@ -1907,6 +1954,39 @@ static unsigned int read_once_policy_nodemask(struct mempolicy *pol,
 	return nodes_weight(*mask);
 }
 
+static unsigned int weighted_interleave_nid(struct mempolicy *pol, pgoff_t ilx)
+{
+	nodemask_t nodemask;
+	unsigned int target, nr_nodes;
+	u8 __rcu *table;
+	unsigned int weight_total = 0;
+	u8 weight;
+	int nid;
+
+	nr_nodes = read_once_policy_nodemask(pol, &nodemask);
+	if (!nr_nodes)
+		return numa_node_id();
+
+	rcu_read_lock();
+	table = rcu_dereference(iw_table);
+	/* calculate the total weight */
+	for_each_node_mask(nid, nodemask)
+		weight_total += table ? table[nid] : 1;
+
+	/* Calculate the node offset based on totals */
+	target = ilx % weight_total;
+	nid = first_node(nodemask);
+	while (target) {
+		weight = table ? table[nid] : 1;
+		if (target < weight)
+			break;
+		target -= weight;
+		nid = next_node_in(nid, nodemask);
+	}
+	rcu_read_unlock();
+	return nid;
+}
+
 /*
  * Do static interleaving for interleave index @ilx.  Returns the ilx'th
  * node in pol->nodes (starting from ilx=0), wrapping around if ilx
@@ -1967,6 +2047,11 @@ static nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *pol,
 		*nid = (ilx == NO_INTERLEAVE_INDEX) ?
 			interleave_nodes(pol) : interleave_nid(pol, ilx);
 		break;
+	case MPOL_WEIGHTED_INTERLEAVE:
+		*nid = (ilx == NO_INTERLEAVE_INDEX) ?
+			weighted_interleave_nodes(pol) :
+			weighted_interleave_nid(pol, ilx);
+		break;
 	}
 
 	return nodemask;
@@ -2028,6 +2113,7 @@ bool init_nodemask_of_mempolicy(nodemask_t *mask)
 	case MPOL_PREFERRED_MANY:
 	case MPOL_BIND:
 	case MPOL_INTERLEAVE:
+	case MPOL_WEIGHTED_INTERLEAVE:
 		*mask = mempolicy->nodes;
 		break;
 
@@ -2127,7 +2213,8 @@ struct page *alloc_pages_mpol(gfp_t gfp, unsigned int order,
 		 * If the policy is interleave or does not allow the current
 		 * node in its nodemask, we allocate the standard way.
 		 */
-		if (pol->mode != MPOL_INTERLEAVE &&
+		if ((pol->mode != MPOL_INTERLEAVE &&
+		    pol->mode != MPOL_WEIGHTED_INTERLEAVE) &&
 		    (!nodemask || node_isset(nid, *nodemask))) {
 			/*
 			 * First, try to allocate THP only on local node, but
@@ -2263,6 +2350,135 @@ static unsigned long alloc_pages_bulk_array_interleave(gfp_t gfp,
 	return total_allocated;
 }
 
+static unsigned long alloc_pages_bulk_array_weighted_interleave(gfp_t gfp,
+		struct mempolicy *pol, unsigned long nr_pages,
+		struct page **page_array)
+{
+	struct task_struct *me = current;
+	unsigned long total_allocated = 0;
+	unsigned long nr_allocated;
+	unsigned long rounds;
+	unsigned long node_pages, delta;
+	u8 weight, resume_weight;
+	u8 __rcu *table;
+	u8 *weights;
+	unsigned int weight_total = 0;
+	unsigned long rem_pages = nr_pages;
+	nodemask_t nodes;
+	int nnodes, node, weight_nodes, resume_node;
+	int prev_node = NUMA_NO_NODE;
+	bool delta_depleted = false;
+	int i;
+
+	if (!nr_pages)
+		return 0;
+
+	nnodes = read_once_policy_nodemask(pol, &nodes);
+	if (!nnodes)
+		return 0;
+
+	/* Continue allocating from most recent node and adjust the nr_pages */
+	if (pol->wil.cur_weight) {
+		node = next_node_in(me->il_prev, nodes);
+		node_pages = pol->wil.cur_weight;
+		if (node_pages > rem_pages)
+			node_pages = rem_pages;
+		nr_allocated = __alloc_pages_bulk(gfp, node, NULL, node_pages,
+						  NULL, page_array);
+		page_array += nr_allocated;
+		total_allocated += nr_allocated;
+		/* if that's all the pages, no need to interleave */
+		if (rem_pages <= pol->wil.cur_weight) {
+			pol->wil.cur_weight -= rem_pages;
+			return total_allocated;
+		}
+		/* Otherwise we adjust nr_pages down, and continue from there */
+		rem_pages -= pol->wil.cur_weight;
+		pol->wil.cur_weight = 0;
+		prev_node = node;
+	}
+
+	/* fetch the weights for this operation and calculate total weight */
+	weights = kmalloc(nnodes, GFP_KERNEL);
+	if (!weights)
+		return total_allocated;
+
+	rcu_read_lock();
+	table = rcu_dereference(iw_table);
+	weight_nodes = 0;
+	while (weight_nodes < nnodes) {
+		node = next_node_in(prev_node, nodes);
+		weight = table ? table[node] : 1;
+		weights[weight_nodes++] = weight;
+		weight_total += weight;
+	}
+	rcu_read_unlock();
+
+	/*
+	 * Now we can continue allocating from 0 instead of an offset
+	 * We calculate the number of rounds and any partial rounds so
+	 * that we minimize the number of calls to __alloc_pages_bulk
+	 * This requires us to track which node we should resume from.
+	 *
+	 * if (rounds > 0) and (delta == 0), resume_node will always be
+	 * the current me->il_prev
+	 *
+	 * if (delta > 0) and delta is depleted exactly on a node-weight
+	 * boundary, resume node will be the node last allocated from when
+	 * delta reached 0.
+	 *
+	 * if (delta > 0) and delta is not depleted on a node-weight boundary,
+	 * resume node will be the node prior to the node last allocated from.
+	 *
+	 * (rounds == 0) and (delta == 0) is not possible (earlier exit)
+	 */
+	rounds = rem_pages / weight_total;
+	delta = rem_pages % weight_total;
+	/* If no delta, we'll resume from current prev_node and first weight */
+	for (i = 0; i < nnodes; i++) {
+		node = next_node_in(prev_node, nodes);
+		weight = weights[i];
+		node_pages = weight * rounds;
+		/* If a delta exists, add this node's portion of the delta */
+		if (delta >= weight) {
+			node_pages += weight;
+			delta -= weight;
+			resume_node = node;
+			resume_weight = i < (nnodes - 1) ? weights[i+1] :
+							   weights[0];
+			/* stop tracking iff (delta == weight) */
+			delta_depleted = !delta;
+		} else if (delta) { /* <= weight */
+			/* if delta depleted, resume from this node */
+			node_pages += delta;
+			delta = 0;
+			resume_node = prev_node;
+			resume_weight = weight - (node_pages % weight);
+			delta_depleted = true; /* stop tracking */
+		} else if (!delta_depleted) {
+			/* if there was no delta, track last allocated node */
+			resume_node = node;
+			resume_weight = i < (nnodes - 1) ? weights[i+1] :
+							   weights[0];
+		}
+		/* node_pages can be 0 if an allocation fails and rounds == 0 */
+		if (!node_pages)
+			break;
+		nr_allocated = __alloc_pages_bulk(gfp, node, NULL, node_pages,
+						  NULL, page_array);
+		page_array += nr_allocated;
+		total_allocated += nr_allocated;
+		if (total_allocated == nr_pages)
+			break;
+		prev_node = node;
+	}
+	/* resume allocating from the calculated node and weight */
+	me->il_prev = resume_node;
+	pol->wil.cur_weight = resume_weight;
+	kfree(weights);
+	return total_allocated;
+}
+
 static unsigned long alloc_pages_bulk_array_preferred_many(gfp_t gfp, int nid,
 		struct mempolicy *pol, unsigned long nr_pages,
 		struct page **page_array)
@@ -2303,6 +2519,10 @@ unsigned long alloc_pages_bulk_array_mempolicy(gfp_t gfp,
 		return alloc_pages_bulk_array_interleave(gfp, pol,
 							 nr_pages, page_array);
 
+	if (pol->mode == MPOL_WEIGHTED_INTERLEAVE)
+		return alloc_pages_bulk_array_weighted_interleave(
+				  gfp, pol, nr_pages, page_array);
+
 	if (pol->mode == MPOL_PREFERRED_MANY)
 		return alloc_pages_bulk_array_preferred_many(gfp,
 				numa_node_id(), pol, nr_pages, page_array);
@@ -2378,6 +2598,7 @@ bool __mpol_equal(struct mempolicy *a, struct mempolicy *b)
 	case MPOL_INTERLEAVE:
 	case MPOL_PREFERRED:
 	case MPOL_PREFERRED_MANY:
+	case MPOL_WEIGHTED_INTERLEAVE:
 		return !!nodes_equal(a->nodes, b->nodes);
 	case MPOL_LOCAL:
 		return true;
@@ -2514,6 +2735,10 @@ int mpol_misplaced(struct folio *folio, struct vm_area_struct *vma,
 		polnid = interleave_nid(pol, ilx);
 		break;
 
+	case MPOL_WEIGHTED_INTERLEAVE:
+		polnid = weighted_interleave_nid(pol, ilx);
+		break;
+
 	case MPOL_PREFERRED:
 		if (node_isset(curnid, pol->nodes))
 			goto out;
@@ -2888,6 +3113,7 @@ static const char * const policy_modes[] =
 	[MPOL_PREFERRED]  = "prefer",
 	[MPOL_BIND]       = "bind",
 	[MPOL_INTERLEAVE] = "interleave",
+	[MPOL_WEIGHTED_INTERLEAVE] = "weighted interleave",
 	[MPOL_LOCAL]      = "local",
 	[MPOL_PREFERRED_MANY]  = "prefer (many)",
 };
@@ -2947,6 +3173,7 @@ int mpol_parse_str(char *str, struct mempolicy **mpol)
 		}
 		break;
 	case MPOL_INTERLEAVE:
+	case MPOL_WEIGHTED_INTERLEAVE:
 		/*
 		 * Default to online nodes with memory if no nodelist
 		 */
@@ -3057,6 +3284,7 @@ void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
 	case MPOL_PREFERRED_MANY:
 	case MPOL_BIND:
 	case MPOL_INTERLEAVE:
+	case MPOL_WEIGHTED_INTERLEAVE:
 		nodes = pol->nodes;
 		break;
 	default:
-- 
2.39.1


