Return-Path: <linux-fsdevel+bounces-9000-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8134B83CB61
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 19:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8BB6B243F1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 18:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902D6136650;
	Thu, 25 Jan 2024 18:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYzXlcSV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A74F135A5C;
	Thu, 25 Jan 2024 18:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706208248; cv=none; b=r8jJ6dSxest8tjO19eZFmWE/h7n3ru8NCjGlpq4jI0F9a35XzIt/KC8gI5Dt+Bq2Oz97rZODCqa3ilNhDSfKhdr2K9lIHN06IGaSEwyjHrnAqK72R4lMT9yJ6+zSS1udbkvH9rpDhYza54Wi2qCzKTX4fUMpL+m+AhIzlZYM0IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706208248; c=relaxed/simple;
	bh=4CXcduw/Xk9UrumRFbOxXT/jVuq9BdtzqZqCW2srHGU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vCioD4Vjmf5R3wO7kJLSqqSLvM7k46wFm7jZDcro4Lv530I1LDY/cBrolZaNb2QK6TxrrlQB58yQVDnEitFeuHQ/rnUw9wo5zCMpaHhGtWTk19SkWbnjvitTfJVXg6zST9pZaEvIQcvYoRtLEquiqr+c3u3Rpc0g3cwGnwbtw2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nYzXlcSV; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-6ddc5faeb7fso1257103b3a.3;
        Thu, 25 Jan 2024 10:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706208245; x=1706813045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XCM3+Jwfhpm+dmL8fIjOhTZIVTHnDTgH9yjGWopoEEE=;
        b=nYzXlcSVkc+oh5EIf+NErYZ/UnjILz1mSUL78SNN4aKr5wrCSrXgYPEABX8MCtROqV
         Hie/GeWDpH11sYQWN0SaCi0CU0gPvRLNdV1v3QR979CIas2KVt2Yb26O+tZnRJdN+r4a
         uKSi7Zk7uZxhDz/ctnv82fYuvW+yxkEjTgVtofnWyhZxbSewfHgvs+14k6Fee0DoBnbP
         cZz4zsEvvY39JA0Z37CPMUkY81ijvjHFXkGbCrrjTKzRENZ+gVF8+yQVRTsAbQrsJbO1
         p7r1kdR3eeEk/1VOWwwHGmyXtgGBWqkNnWv/L+jof409BiHhqEnjaOfrS/BKHVR0GWnW
         TiTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706208245; x=1706813045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XCM3+Jwfhpm+dmL8fIjOhTZIVTHnDTgH9yjGWopoEEE=;
        b=Po6Mg1vp571iftY9acegeRPh+n5BlO+ABXGwgg5YnYmPO0+lXzqXFHMzr9oGWSH9s9
         WKV0no06alHaEJgivl0hhFBbz4G4RYHTO3CbfO6+y33g8d7F61dsBBu9xv/kkchykxil
         MLPtEtiDbYZrO4gdOr6p3h6At4P0Y4gWEmDjiHwPAu4jTd1PHvljYB37IuL/16hm93gE
         YOIPPMbfQ8/tqawH3Z64w+r6nWZI4Of53lBkY/OyG4IBT8FAaT3QGqAAyDPaTaeFMzid
         6AV5gdDEsB/wryKb64HUeYOKX6OrH4CF4WadJc7CFQTTJ2hfIPF418T9BSWShePecGk4
         frGw==
X-Gm-Message-State: AOJu0Yw57J+62p0cXRXT85cU7tGhI2OqhNl5tumz9rHsxvvemDRZF2Bc
	rYa87DGBcgufW81/SnYnrOl4ZVXGW43S6dHFXlCKDYm8Dk0sOcbbCfGC2NIBF8Gn
X-Google-Smtp-Source: AGHT+IG8IKF2LbF/tulleNXQK9a0buVlgJX+T6ILRE02yC4Dg04nb88+bqtRLNJHNefgetU7IyONPg==
X-Received: by 2002:a05:6a00:1d13:b0:6db:cdbc:311e with SMTP id a19-20020a056a001d1300b006dbcdbc311emr167814pfx.61.1706208245137;
        Thu, 25 Jan 2024 10:44:05 -0800 (PST)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id p14-20020aa7860e000000b006ddcf56fb78sm1815070pfn.62.2024.01.25.10.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 10:44:04 -0800 (PST)
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
Subject: [PATCH v3 3/4] mm/mempolicy: introduce MPOL_WEIGHTED_INTERLEAVE for weighted interleaving
Date: Thu, 25 Jan 2024 13:43:44 -0500
Message-Id: <20240125184345.47074-4-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240125184345.47074-1-gregory.price@memverge.com>
References: <20240125184345.47074-1-gregory.price@memverge.com>
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
    current weight (pol->cur_il_weight) will be allocated first, before
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
 include/linux/mempolicy.h                     |   3 +
 include/uapi/linux/mempolicy.h                |   1 +
 mm/mempolicy.c                                | 274 +++++++++++++++++-
 4 files changed, 283 insertions(+), 4 deletions(-)

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
index 931b118336f4..c644d7bbd396 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -54,6 +54,9 @@ struct mempolicy {
 		nodemask_t cpuset_mems_allowed;	/* relative to these nodes */
 		nodemask_t user_nodemask;	/* nodemask passed by user */
 	} w;
+
+	/* Weighted interleave settings */
+	u8 cur_il_weight;
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
index b13c45a0bfcb..5a517511658e 100644
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
@@ -314,6 +321,7 @@ static struct mempolicy *mpol_new(unsigned short mode, unsigned short flags,
 	policy->mode = mode;
 	policy->flags = flags;
 	policy->home_node = NUMA_NO_NODE;
+	policy->cur_il_weight = 0;
 
 	return policy;
 }
@@ -426,6 +434,10 @@ static const struct mempolicy_operations mpol_ops[MPOL_MAX] = {
 		.create = mpol_new_nodemask,
 		.rebind = mpol_rebind_preferred,
 	},
+	[MPOL_WEIGHTED_INTERLEAVE] = {
+		.create = mpol_new_nodemask,
+		.rebind = mpol_rebind_nodemask,
+	},
 };
 
 static bool migrate_folio_add(struct folio *folio, struct list_head *foliolist,
@@ -847,7 +859,8 @@ static long do_set_mempolicy(unsigned short mode, unsigned short flags,
 
 	old = current->mempolicy;
 	current->mempolicy = new;
-	if (new && new->mode == MPOL_INTERLEAVE)
+	if (new && (new->mode == MPOL_INTERLEAVE ||
+		    new->mode == MPOL_WEIGHTED_INTERLEAVE))
 		current->il_prev = MAX_NUMNODES-1;
 	task_unlock(current);
 	mpol_put(old);
@@ -873,6 +886,7 @@ static void get_policy_nodemask(struct mempolicy *pol, nodemask_t *nodes)
 	case MPOL_INTERLEAVE:
 	case MPOL_PREFERRED:
 	case MPOL_PREFERRED_MANY:
+	case MPOL_WEIGHTED_INTERLEAVE:
 		*nodes = pol->nodes;
 		break;
 	case MPOL_LOCAL:
@@ -957,6 +971,13 @@ static long do_get_mempolicy(int *policy, nodemask_t *nmask,
 		} else if (pol == current->mempolicy &&
 				pol->mode == MPOL_INTERLEAVE) {
 			*policy = next_node_in(current->il_prev, pol->nodes);
+		} else if (pol == current->mempolicy &&
+				(pol->mode == MPOL_WEIGHTED_INTERLEAVE)) {
+			if (pol->cur_il_weight)
+				*policy = current->il_prev;
+			else
+				*policy = next_node_in(current->il_prev,
+						       pol->nodes);
 		} else {
 			err = -EINVAL;
 			goto out;
@@ -1769,7 +1790,8 @@ struct mempolicy *__get_vma_policy(struct vm_area_struct *vma,
  * @vma: virtual memory area whose policy is sought
  * @addr: address in @vma for shared policy lookup
  * @order: 0, or appropriate huge_page_order for interleaving
- * @ilx: interleave index (output), for use only when MPOL_INTERLEAVE
+ * @ilx: interleave index (output), for use only when MPOL_INTERLEAVE or
+ *       MPOL_WEIGHTED_INTERLEAVE
  *
  * Returns effective policy for a VMA at specified address.
  * Falls back to current->mempolicy or system default policy, as necessary.
@@ -1786,7 +1808,8 @@ struct mempolicy *get_vma_policy(struct vm_area_struct *vma,
 	pol = __get_vma_policy(vma, addr, ilx);
 	if (!pol)
 		pol = get_task_policy(current);
-	if (pol->mode == MPOL_INTERLEAVE) {
+	if (pol->mode == MPOL_INTERLEAVE ||
+	    pol->mode == MPOL_WEIGHTED_INTERLEAVE) {
 		*ilx += vma->vm_pgoff >> order;
 		*ilx += (addr - vma->vm_start) >> (PAGE_SHIFT + order);
 	}
@@ -1836,6 +1859,44 @@ bool apply_policy_zone(struct mempolicy *policy, enum zone_type zone)
 	return zone >= dynamic_policy_zone;
 }
 
+static unsigned int weighted_interleave_nodes(struct mempolicy *policy)
+{
+	unsigned int node, next;
+	struct task_struct *me = current;
+	u8 __rcu *table;
+	u8 weight;
+
+	node = next_node_in(me->il_prev, policy->nodes);
+	if (node == MAX_NUMNODES)
+		return node;
+
+	/* on first alloc after setting mempolicy, acquire first weight */
+	if (unlikely(!policy->cur_il_weight)) {
+		rcu_read_lock();
+		table = rcu_dereference(iw_table);
+		/* detect system-default values */
+		weight = table ? table[node] : 1;
+		policy->cur_il_weight = weight ? weight : 1;
+		rcu_read_unlock();
+	}
+
+	/* account for this allocation call */
+	policy->cur_il_weight--;
+
+	/* if now at 0, move to next node and set up that node's weight */
+	if (unlikely(!policy->cur_il_weight)) {
+		me->il_prev = node;
+		next = next_node_in(node, policy->nodes);
+		rcu_read_lock();
+		table = rcu_dereference(iw_table);
+		/* detect system-default values */
+		weight = table ? table[next] : 1;
+		policy->cur_il_weight = weight ? weight : 1;
+		rcu_read_unlock();
+	}
+	return node;
+}
+
 /* Do dynamic interleaving for a process */
 static unsigned int interleave_nodes(struct mempolicy *policy)
 {
@@ -1870,6 +1931,9 @@ unsigned int mempolicy_slab_node(void)
 	case MPOL_INTERLEAVE:
 		return interleave_nodes(policy);
 
+	case MPOL_WEIGHTED_INTERLEAVE:
+		return weighted_interleave_nodes(policy);
+
 	case MPOL_BIND:
 	case MPOL_PREFERRED_MANY:
 	{
@@ -1908,6 +1972,39 @@ static unsigned int read_once_policy_nodemask(struct mempolicy *pol,
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
@@ -1968,6 +2065,11 @@ static nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *pol,
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
@@ -2029,6 +2131,7 @@ bool init_nodemask_of_mempolicy(nodemask_t *mask)
 	case MPOL_PREFERRED_MANY:
 	case MPOL_BIND:
 	case MPOL_INTERLEAVE:
+	case MPOL_WEIGHTED_INTERLEAVE:
 		*mask = mempolicy->nodes;
 		break;
 
@@ -2128,7 +2231,8 @@ struct page *alloc_pages_mpol(gfp_t gfp, unsigned int order,
 		 * If the policy is interleave or does not allow the current
 		 * node in its nodemask, we allocate the standard way.
 		 */
-		if (pol->mode != MPOL_INTERLEAVE &&
+		if ((pol->mode != MPOL_INTERLEAVE &&
+		    pol->mode != MPOL_WEIGHTED_INTERLEAVE) &&
 		    (!nodemask || node_isset(nid, *nodemask))) {
 			/*
 			 * First, try to allocate THP only on local node, but
@@ -2264,6 +2368,156 @@ static unsigned long alloc_pages_bulk_array_interleave(gfp_t gfp,
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
+	int nnodes, node, resume_node, next_node;
+	int prev_node = me->il_prev;
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
+	if (pol->cur_il_weight) {
+		node = next_node_in(prev_node, nodes);
+		node_pages = pol->cur_il_weight;
+		if (node_pages > rem_pages)
+			node_pages = rem_pages;
+		nr_allocated = __alloc_pages_bulk(gfp, node, NULL, node_pages,
+						  NULL, page_array);
+		page_array += nr_allocated;
+		total_allocated += nr_allocated;
+		/*
+		 * if that's all the pages, no need to interleave, otherwise
+		 * we need to set up the next interleave node/weight correctly.
+		 */
+		if (rem_pages < pol->cur_il_weight) {
+			/* stay on current node, adjust cur_il_weight */
+			pol->cur_il_weight -= rem_pages;
+			return total_allocated;
+		} else if (rem_pages == pol->cur_il_weight) {
+			/* move to next node / weight */
+			me->il_prev = node;
+			next_node = next_node_in(node, nodes);
+			rcu_read_lock();
+			table = rcu_dereference(iw_table);
+			weight = table ? table[next_node] : 1;
+			/* detect system-default usage */
+			pol->cur_il_weight = weight ? weight : 1;
+			rcu_read_unlock();
+			return total_allocated;
+		}
+		/* Otherwise we adjust nr_pages down, and continue from there */
+		rem_pages -= pol->cur_il_weight;
+		pol->cur_il_weight = 0;
+		prev_node = node;
+	}
+
+	/* create a local copy of node weights to operate on outside rcu */
+	weights = kmalloc(nr_node_ids, GFP_KERNEL);
+	if (!weights)
+		return total_allocated;
+
+	rcu_read_lock();
+	table = rcu_dereference(iw_table);
+	/* If table is not registered, use system defaults */
+	if (table)
+		memcpy(weights, iw_table, nr_node_ids);
+	else
+		memset(weights, 1, nr_node_ids);
+	rcu_read_unlock();
+
+	/* calculate total, detect system default usage */
+	for_each_node_mask(node, nodes) {
+		/* detect system-default usage */
+		if (!weights[node])
+			weights[node] = 1;
+		weight_total += weights[node];
+	}
+
+	/*
+	 * Now we can continue allocating from 0 instead of an offset
+	 * We calculate the number of rounds and any partial rounds so
+	 * that we minimize the number of calls to __alloc_pages_bulk
+	 * This requires us to track which node we should resume from.
+	 *
+	 * if (rounds > 0) and (delta == 0), resume_node will always be
+	 * the current value of prev_node, which may be NUMA_NO_NODE if
+	 * this is the first allocation after a policy is replaced. The
+	 * resume weight will be the weight of the next node.
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
+	resume_node = prev_node;
+	resume_weight = weights[next_node_in(prev_node, nodes)];
+	/* If no delta, we'll resume from current prev_node and first weight */
+	for (i = 0; i < nnodes; i++) {
+		node = next_node_in(prev_node, nodes);
+		weight = weights[node];
+		node_pages = weight * rounds;
+		/* If a delta exists, add this node's portion of the delta */
+		if (delta > weight) {
+			node_pages += weight;
+			delta -= weight;
+			resume_node = node;
+		} else if (delta) {
+			node_pages += delta;
+			if (delta == weight) {
+				/* resume from next node with its weight */
+				resume_node = node;
+				next_node = next_node_in(node, nodes);
+				resume_weight = weights[next_node];
+			} else {
+				/* resume from this node w/ remaining weight */
+				resume_node = prev_node;
+				resume_weight = weight - (node_pages % weight);
+			}
+			delta = 0;
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
+	pol->cur_il_weight = resume_weight;
+	kfree(weights);
+	return total_allocated;
+}
+
 static unsigned long alloc_pages_bulk_array_preferred_many(gfp_t gfp, int nid,
 		struct mempolicy *pol, unsigned long nr_pages,
 		struct page **page_array)
@@ -2304,6 +2558,10 @@ unsigned long alloc_pages_bulk_array_mempolicy(gfp_t gfp,
 		return alloc_pages_bulk_array_interleave(gfp, pol,
 							 nr_pages, page_array);
 
+	if (pol->mode == MPOL_WEIGHTED_INTERLEAVE)
+		return alloc_pages_bulk_array_weighted_interleave(
+				  gfp, pol, nr_pages, page_array);
+
 	if (pol->mode == MPOL_PREFERRED_MANY)
 		return alloc_pages_bulk_array_preferred_many(gfp,
 				numa_node_id(), pol, nr_pages, page_array);
@@ -2379,6 +2637,7 @@ bool __mpol_equal(struct mempolicy *a, struct mempolicy *b)
 	case MPOL_INTERLEAVE:
 	case MPOL_PREFERRED:
 	case MPOL_PREFERRED_MANY:
+	case MPOL_WEIGHTED_INTERLEAVE:
 		return !!nodes_equal(a->nodes, b->nodes);
 	case MPOL_LOCAL:
 		return true;
@@ -2515,6 +2774,10 @@ int mpol_misplaced(struct folio *folio, struct vm_area_struct *vma,
 		polnid = interleave_nid(pol, ilx);
 		break;
 
+	case MPOL_WEIGHTED_INTERLEAVE:
+		polnid = weighted_interleave_nid(pol, ilx);
+		break;
+
 	case MPOL_PREFERRED:
 		if (node_isset(curnid, pol->nodes))
 			goto out;
@@ -2889,6 +3152,7 @@ static const char * const policy_modes[] =
 	[MPOL_PREFERRED]  = "prefer",
 	[MPOL_BIND]       = "bind",
 	[MPOL_INTERLEAVE] = "interleave",
+	[MPOL_WEIGHTED_INTERLEAVE] = "weighted interleave",
 	[MPOL_LOCAL]      = "local",
 	[MPOL_PREFERRED_MANY]  = "prefer (many)",
 };
@@ -2948,6 +3212,7 @@ int mpol_parse_str(char *str, struct mempolicy **mpol)
 		}
 		break;
 	case MPOL_INTERLEAVE:
+	case MPOL_WEIGHTED_INTERLEAVE:
 		/*
 		 * Default to online nodes with memory if no nodelist
 		 */
@@ -3058,6 +3323,7 @@ void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
 	case MPOL_PREFERRED_MANY:
 	case MPOL_BIND:
 	case MPOL_INTERLEAVE:
+	case MPOL_WEIGHTED_INTERLEAVE:
 		nodes = pol->nodes;
 		break;
 	default:
-- 
2.39.1


