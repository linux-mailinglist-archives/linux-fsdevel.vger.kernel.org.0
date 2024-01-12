Return-Path: <linux-fsdevel+bounces-7891-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BB082C690
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 22:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F07F0289183
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 21:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76F117998;
	Fri, 12 Jan 2024 21:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLOzSElp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB1A1772F;
	Fri, 12 Jan 2024 21:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-5f3da7ba2bfso70740497b3.3;
        Fri, 12 Jan 2024 13:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705093724; x=1705698524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PiIoFXAtLYDcaRD95aOOGNs+4GbHvnGDWcpOfSyNcnY=;
        b=kLOzSElpQ6x2Gxk919mr+MJ9wjX3rqYgT1PApNxFnE4a6Fc0eVOCOgAhuMZPiBg4tN
         Myj5pHl+080zJtUgD52WlQqyZvSaOypXJLnSVUdjx6iqEJZA5QxONmRO0Z2YvfUBdw6V
         g1kbsJb2D94XAHyLPKbN+8MkGAm1SquDdeeM0cU0gi6ix3Jt2RBhElKDVyZjfOfhIEND
         wV0in4jCrH5Gh2YGU0wMgYf8TVwhU7kF0shB0sbbzDQnfIAUphT0RrPhI5dGlhj/8PgI
         NvvCNkq7aoaX2jWMLVeSt+wIW1TuWcoYBqC0tcnzMryhdU5JBtYL9BByPUaXEo7JlQJx
         kL9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705093724; x=1705698524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PiIoFXAtLYDcaRD95aOOGNs+4GbHvnGDWcpOfSyNcnY=;
        b=DrZE+m23SgeJEimj0DACK+6ck10pH/1Sx/ngdwaDkgNauquOKarHEaPoena+uQv9YH
         O/zUAuwApXlYd7fsZKl3cH3tbTHFVl/txPs5xGltN/7i6KWkdeNLpzh/6dXjVelEssBq
         0UwWD9hi2fL+3f9Bc5TWgYmOXQ4UrcUft74LPIxk/n93LDTBMSwk6GzLrvNtrTKJsOLD
         U8yBUBpyQb1CNNA6wFaKMrYtMxAMDt9d/h1iwTMYntuDt6nshFIYtRL+bXn7OX2fl5uY
         WQ18iPXqVOaXlZuRitsin5ASNZiqxCMV+C+aqij4nGWS21qS9NeoBxubYc58ghUvrcO3
         iIrw==
X-Gm-Message-State: AOJu0YzPJbyC0xSZ5juVw5hacDpRfkkQ2j53GiXYm/nXQPsEEjMt04hR
	yF2PPlt4hHX+f3OffYTpVw==
X-Google-Smtp-Source: AGHT+IGCnmUom0ICH1KYC73MM9s7LOdRSmnzcWpTuRJgL1vv8TMBiSmGu+gCIhpP8R1rY4qX0tk38Q==
X-Received: by 2002:a81:c74d:0:b0:5f6:e0f3:e8df with SMTP id i13-20020a81c74d000000b005f6e0f3e8dfmr1676816ywl.97.1705093724121;
        Fri, 12 Jan 2024 13:08:44 -0800 (PST)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id ci24-20020a05690c0a9800b005f93cc31ff0sm1635518ywb.72.2024.01.12.13.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 13:08:43 -0800 (PST)
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
Subject: [PATCH 3/3] mm/mempolicy: introduce MPOL_WEIGHTED_INTERLEAVE for weighted interleaving
Date: Fri, 12 Jan 2024 16:08:34 -0500
Message-Id: <20240112210834.8035-4-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240112210834.8035-1-gregory.price@memverge.com>
References: <20240112210834.8035-1-gregory.price@memverge.com>
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

In addition, the `default_iw_table` is created, which will be extended
in the future to allow defaults to be registered by drivers. For now,
the default value of all nodes will be `1`, which matches the behavior
of standard 1:1 round-robin interleave.

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
 mm/mempolicy.c                                | 214 +++++++++++++++++-
 4 files changed, 226 insertions(+), 3 deletions(-)

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
index 0abd3a3394ef..a2b5d64b28e0 100644
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
@@ -327,6 +334,7 @@ static struct mempolicy *mpol_new(unsigned short mode, unsigned short flags,
 	policy->mode = mode;
 	policy->flags = flags;
 	policy->home_node = NUMA_NO_NODE;
+	policy->wil.cur_weight = 0;
 
 	return policy;
 }
@@ -439,6 +447,10 @@ static const struct mempolicy_operations mpol_ops[MPOL_MAX] = {
 		.create = mpol_new_nodemask,
 		.rebind = mpol_rebind_preferred,
 	},
+	[MPOL_WEIGHTED_INTERLEAVE] = {
+		.create = mpol_new_nodemask,
+		.rebind = mpol_rebind_nodemask,
+	},
 };
 
 static bool migrate_folio_add(struct folio *folio, struct list_head *foliolist,
@@ -860,7 +872,8 @@ static long do_set_mempolicy(unsigned short mode, unsigned short flags,
 
 	old = current->mempolicy;
 	current->mempolicy = new;
-	if (new && new->mode == MPOL_INTERLEAVE)
+	if (new && (new->mode == MPOL_INTERLEAVE ||
+		    new->mode == MPOL_WEIGHTED_INTERLEAVE))
 		current->il_prev = MAX_NUMNODES-1;
 	task_unlock(current);
 	mpol_put(old);
@@ -886,6 +899,7 @@ static void get_policy_nodemask(struct mempolicy *pol, nodemask_t *nodes)
 	case MPOL_INTERLEAVE:
 	case MPOL_PREFERRED:
 	case MPOL_PREFERRED_MANY:
+	case MPOL_WEIGHTED_INTERLEAVE:
 		*nodes = pol->nodes;
 		break;
 	case MPOL_LOCAL:
@@ -970,6 +984,13 @@ static long do_get_mempolicy(int *policy, nodemask_t *nmask,
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
@@ -1799,7 +1820,8 @@ struct mempolicy *get_vma_policy(struct vm_area_struct *vma,
 	pol = __get_vma_policy(vma, addr, ilx);
 	if (!pol)
 		pol = get_task_policy(current);
-	if (pol->mode == MPOL_INTERLEAVE) {
+	if (pol->mode == MPOL_INTERLEAVE ||
+	    pol->mode == MPOL_WEIGHTED_INTERLEAVE) {
 		*ilx += vma->vm_pgoff >> order;
 		*ilx += (addr - vma->vm_start) >> (PAGE_SHIFT + order);
 	}
@@ -1849,6 +1871,28 @@ bool apply_policy_zone(struct mempolicy *policy, enum zone_type zone)
 	return zone >= dynamic_policy_zone;
 }
 
+static unsigned int weighted_interleave_nodes(struct mempolicy *policy)
+{
+	unsigned int next;
+	struct task_struct *me = current;
+	struct iw_table __rcu *table;
+
+	next = next_node_in(me->il_prev, policy->nodes);
+	if (next == MAX_NUMNODES)
+		return next;
+
+	rcu_read_lock();
+	table = rcu_dereference(iw_table);
+	if (!policy->wil.cur_weight)
+		policy->wil.cur_weight = table->weights[next];
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
@@ -1883,6 +1927,9 @@ unsigned int mempolicy_slab_node(void)
 	case MPOL_INTERLEAVE:
 		return interleave_nodes(policy);
 
+	case MPOL_WEIGHTED_INTERLEAVE:
+		return weighted_interleave_nodes(policy);
+
 	case MPOL_BIND:
 	case MPOL_PREFERRED_MANY:
 	{
@@ -1921,6 +1968,39 @@ static unsigned int read_once_policy_nodemask(struct mempolicy *pol,
 	return nodes_weight(*mask);
 }
 
+static unsigned int weighted_interleave_nid(struct mempolicy *pol, pgoff_t ilx)
+{
+	nodemask_t nodemask;
+	unsigned int target, nr_nodes;
+	struct iw_table __rcu *table;
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
+		weight_total += table->weights[nid];
+
+	/* Calculate the node offset based on totals */
+	target = ilx % weight_total;
+	nid = first_node(nodemask);
+	while (target) {
+		weight = table->weights[nid];
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
@@ -1981,6 +2061,11 @@ static nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *pol,
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
@@ -2042,6 +2127,7 @@ bool init_nodemask_of_mempolicy(nodemask_t *mask)
 	case MPOL_PREFERRED_MANY:
 	case MPOL_BIND:
 	case MPOL_INTERLEAVE:
+	case MPOL_WEIGHTED_INTERLEAVE:
 		*mask = mempolicy->nodes;
 		break;
 
@@ -2141,7 +2227,8 @@ struct page *alloc_pages_mpol(gfp_t gfp, unsigned int order,
 		 * If the policy is interleave or does not allow the current
 		 * node in its nodemask, we allocate the standard way.
 		 */
-		if (pol->mode != MPOL_INTERLEAVE &&
+		if ((pol->mode != MPOL_INTERLEAVE &&
+		    pol->mode != MPOL_WEIGHTED_INTERLEAVE) &&
 		    (!nodemask || node_isset(nid, *nodemask))) {
 			/*
 			 * First, try to allocate THP only on local node, but
@@ -2277,6 +2364,114 @@ static unsigned long alloc_pages_bulk_array_interleave(gfp_t gfp,
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
+	u8 weight;
+	struct iw_table __rcu *table;
+	u8 *weights;
+	unsigned int weight_total = 0;
+	unsigned long rem_pages = nr_pages;
+	nodemask_t nodes;
+	int nnodes, node, weight_nodes;
+	int prev_node = NUMA_NO_NODE;
+	int i;
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
+	for_each_node_mask(node, nodes) {
+		weights[weight_nodes++] = table->weights[node];
+		weight_total += table->weights[node];
+	}
+	rcu_read_unlock();
+
+	if (!weight_total) {
+		kfree(weights);
+		return total_allocated;
+	}
+
+	/* Now we can continue allocating as if from 0 instead of an offset */
+	rounds = rem_pages / weight_total;
+	delta = rem_pages % weight_total;
+	for (i = 0; i < nnodes; i++) {
+		node = next_node_in(prev_node, nodes);
+		weight = weights[i];
+		node_pages = weight * rounds;
+		if (delta) {
+			if (delta > weight) {
+				node_pages += weight;
+				delta -= weight;
+			} else {
+				node_pages += delta;
+				delta = 0;
+			}
+		}
+		nr_allocated = __alloc_pages_bulk(gfp, node, NULL, node_pages,
+						  NULL, page_array);
+		page_array += nr_allocated;
+		total_allocated += nr_allocated;
+		if (total_allocated == nr_pages)
+			break;
+		prev_node = node;
+	}
+
+	/*
+	 * Finally, we need to update me->il_prev and pol->wil.cur_weight
+	 * if there were overflow pages, but not equivalent to the node
+	 * weight, set the cur_weight to node_weight - delta and the
+	 * me->il_prev to the previous node. Otherwise if it was perfect
+	 * we can simply set il_prev to node and cur_weight to 0
+	 */
+	if (node_pages) {
+		me->il_prev = prev_node;
+		node_pages %= weight;
+		pol->wil.cur_weight = weight - node_pages;
+	} else {
+		me->il_prev = node;
+		pol->wil.cur_weight = 0;
+	}
+
+	kfree(weights);
+	return total_allocated;
+}
+
 static unsigned long alloc_pages_bulk_array_preferred_many(gfp_t gfp, int nid,
 		struct mempolicy *pol, unsigned long nr_pages,
 		struct page **page_array)
@@ -2317,6 +2512,11 @@ unsigned long alloc_pages_bulk_array_mempolicy(gfp_t gfp,
 		return alloc_pages_bulk_array_interleave(gfp, pol,
 							 nr_pages, page_array);
 
+	if (pol->mode == MPOL_WEIGHTED_INTERLEAVE)
+		return alloc_pages_bulk_array_weighted_interleave(gfp, pol,
+								  nr_pages,
+								  page_array);
+
 	if (pol->mode == MPOL_PREFERRED_MANY)
 		return alloc_pages_bulk_array_preferred_many(gfp,
 				numa_node_id(), pol, nr_pages, page_array);
@@ -2392,6 +2592,7 @@ bool __mpol_equal(struct mempolicy *a, struct mempolicy *b)
 	case MPOL_INTERLEAVE:
 	case MPOL_PREFERRED:
 	case MPOL_PREFERRED_MANY:
+	case MPOL_WEIGHTED_INTERLEAVE:
 		return !!nodes_equal(a->nodes, b->nodes);
 	case MPOL_LOCAL:
 		return true;
@@ -2528,6 +2729,10 @@ int mpol_misplaced(struct folio *folio, struct vm_area_struct *vma,
 		polnid = interleave_nid(pol, ilx);
 		break;
 
+	case MPOL_WEIGHTED_INTERLEAVE:
+		polnid = weighted_interleave_nid(pol, ilx);
+		break;
+
 	case MPOL_PREFERRED:
 		if (node_isset(curnid, pol->nodes))
 			goto out;
@@ -2902,6 +3107,7 @@ static const char * const policy_modes[] =
 	[MPOL_PREFERRED]  = "prefer",
 	[MPOL_BIND]       = "bind",
 	[MPOL_INTERLEAVE] = "interleave",
+	[MPOL_WEIGHTED_INTERLEAVE] = "weighted interleave",
 	[MPOL_LOCAL]      = "local",
 	[MPOL_PREFERRED_MANY]  = "prefer (many)",
 };
@@ -2961,6 +3167,7 @@ int mpol_parse_str(char *str, struct mempolicy **mpol)
 		}
 		break;
 	case MPOL_INTERLEAVE:
+	case MPOL_WEIGHTED_INTERLEAVE:
 		/*
 		 * Default to online nodes with memory if no nodelist
 		 */
@@ -3071,6 +3278,7 @@ void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
 	case MPOL_PREFERRED_MANY:
 	case MPOL_BIND:
 	case MPOL_INTERLEAVE:
+	case MPOL_WEIGHTED_INTERLEAVE:
 		nodes = pol->nodes;
 		break;
 	default:
-- 
2.39.1


