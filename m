Return-Path: <linux-fsdevel+bounces-9001-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB9083CB65
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 19:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1FF529CB01
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 18:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5993A137C23;
	Thu, 25 Jan 2024 18:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDrK9D2g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348EB135A7C;
	Thu, 25 Jan 2024 18:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706208252; cv=none; b=GT4wFuDDtzlxJmRJj737ptsGSskpf2l6pFb4wthOQmDA9ewf+6++9yocO2xKKZPJWYmhg9YcUL85MoZos6NCHHwvAeTegR49Zyw6w6mm/BRhkHccmhc9CwiQBJh8hm+amy7MVSyYKPhxy4mHmpB/YFglOynB//GHBDiAU6Frztg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706208252; c=relaxed/simple;
	bh=ecRKWJQhY4wR39DMh1DAJeETva8Uc2luxfi1zh9+yS0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QJcqk7kWFDSAd5fPPCbWhstVe/++1lsK7UdsBFjpCiInCqvZDOVoZGLrAns1bg02LRs4DL4F4GMDh71puOKrfxLdanFlhfzYrvc4MgYWDA1uhaOF+LfwVafC9RZDngFdgJXuegsIA59hyj2cVJVw7/DvIeEPeIP3dvBgSgIavLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EDrK9D2g; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-6dc6f47302bso3586231b3a.1;
        Thu, 25 Jan 2024 10:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706208250; x=1706813050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aiHyh81A5rrvisQFQaV58YSJpwtynFeoOhG26thY/oo=;
        b=EDrK9D2gKSAxlpFG5CvxVTYxQe6XmbOFPscf7bK3r+pVUP1GGs6bVRzXYBrZ3jlis5
         b/CcoRKM4tBYEluwKO7O4UFhjh5Xi3DwZ6DHiOAZIVCsK5stY2+10HMfMQ6YaS4Uy+7u
         XScPz/1kpYq0GAWDCiLlbG2ISNoIZYGNFvhatxuIdVOZXcaFHicALuWqBQgCr+Ko2/YY
         t7otp4v57iQ2zzgFauaZAW2JkExSvvr2CivllkGP+951CgfLfzfFkBIFZBHI4B4Tuixr
         bW/r7MDGlvzV+eYZ6MooN97UG7v9snd87c6PfL2cArh7shLBwLMN1Z3RYMxyzHHxddXf
         GZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706208250; x=1706813050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aiHyh81A5rrvisQFQaV58YSJpwtynFeoOhG26thY/oo=;
        b=CMHod1dmUhJmTn6HwIfBvqAPgLPcnlWHB99XPZW4oR4nziXg+SexhQHw+jwSRoz5HZ
         pBtKrzKYSpCMXJ0+qHssB+aqG67ehtVw8PFLzXcGLQzV0ySpfkkkHwZXz1XFZltVWyXO
         mNazbEg6OzlcEFuICSdaH3oGPbp9oQ5yBVcWTrggJa+Tc0TmS5pl+Q5hT10P6DlgQ7YL
         CiVuoETGIgawYImAbTD1ewsGTTDNSXAGZfuUaLjzMO5fe8gRiM+lfXNBDyx1zjkaq+W/
         1SB0Z7SApOxO0sAxwIN9hfhAd1II9axzB9ulZNCzXP3CepPuHtAP7Hz3nuS3wvofh+wr
         Sj/w==
X-Gm-Message-State: AOJu0Yyi46gdCDD8JfZ2Obwq5A0YiSx8im1R6UODbzPI3Iv6kk7LOTcD
	whHYBI/78z7stWZQSg8U+dMaRp0BOIWRdjyp0PBzULgZwKyHA7Q=
X-Google-Smtp-Source: AGHT+IGg7DSmaG2TFNg0cpW9ZTaAi3nnBJTCM2ZL3E6BfG30NMueGRRYhoyixqtu5WQyXV2EyJrwbQ==
X-Received: by 2002:aa7:8a07:0:b0:6d0:8b0f:1091 with SMTP id m7-20020aa78a07000000b006d08b0f1091mr108795pfa.30.1706208248914;
        Thu, 25 Jan 2024 10:44:08 -0800 (PST)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id p14-20020aa7860e000000b006ddcf56fb78sm1815070pfn.62.2024.01.25.10.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 10:44:08 -0800 (PST)
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
	dan.j.williams@intel.com
Subject: [PATCH v3 4/4] mm/mempolicy: change cur_il_weight to atomic and carry the node with it
Date: Thu, 25 Jan 2024 13:43:45 -0500
Message-Id: <20240125184345.47074-5-gregory.price@memverge.com>
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

In the prior patch, we carry only the current weight for a weighted
interleave round with us across calls through the allocator path.

node = next_node_in(current->il_prev, pol->nodemask)
pol->cur_il_weight <--- this weight applies to the above node

This separation of data can cause a race condition.

If a cgroup-initiated task migration or mems_allowed change occurs
from outside the context of the task, this can cause the weight to
become stale, meaning we may end using that weight to allocate
memory on the wrong node.

Example:
  1) task A sets (cur_il_weight = 8) and (current->il_prev) to
     node0. node1 is the next set bit in pol->nodemask
  2) rebind event occurs, removing node1 from the nodemask.
     node2 is now the next set bit in pol->nodemask
     cur_il_weight is now stale.
  3) allocation occurs, next_node_in(il_prev, nodes) returns
     node2. cur_il_weight is now applied to the wrong node.

The upper level allocator logic must still enforce mems_allowed,
so this isn't dangerous, but it is innaccurate.

Just clearing the weight is insufficient, as it creates two more
race conditions.  The root of the issue is the separation of weight
and node data between nodemask and cur_il_weight.

To solve this, update cur_il_weight to be an atomic_t, and place the
node that the weight applies to in the upper bits of the field:

atomic_t cur_il_weight
	node bits 32:8
	weight bits 7:0

Now retrieving or clearing the active interleave node and weight
is a single atomic operation, and we are not dependent on the
potentially changing state of (pol->nodemask) to determine what
node the weight applies to.

Two special observations:
- if the weight is non-zero, cur_il_weight must *always* have a
  valid node number, e.g. it cannot be NUMA_NO_NODE (-1).
  This is because we steal the top byte for the weight.

- MAX_NUMNODES is presently limited to 1024 or less on every
  architecture. This would permanently limit MAX_NUMNODES to
  an absolute maximum of (1 << 24) to avoid overflows.

Per some reading and discussion, it appears that max nodes is
limited to 1024 so that zone type still fits in page flags, so
this method seemed preferable compared to the alternatives of
trying to make all or part of mempolicy RCU protected (which
may not be possible, since it is often referenced during code
chunks which call operations that may sleep).

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 include/linux/mempolicy.h |  2 +-
 mm/mempolicy.c            | 93 +++++++++++++++++++++++++--------------
 2 files changed, 61 insertions(+), 34 deletions(-)

diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index c644d7bbd396..8108fc6e96ca 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -56,7 +56,7 @@ struct mempolicy {
 	} w;
 
 	/* Weighted interleave settings */
-	u8 cur_il_weight;
+	atomic_t cur_il_weight;
 };
 
 /*
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 5a517511658e..41b5fef0a6f5 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -321,7 +321,7 @@ static struct mempolicy *mpol_new(unsigned short mode, unsigned short flags,
 	policy->mode = mode;
 	policy->flags = flags;
 	policy->home_node = NUMA_NO_NODE;
-	policy->cur_il_weight = 0;
+	atomic_set(&policy->cur_il_weight, 0);
 
 	return policy;
 }
@@ -356,6 +356,7 @@ static void mpol_rebind_nodemask(struct mempolicy *pol, const nodemask_t *nodes)
 		tmp = *nodes;
 
 	pol->nodes = tmp;
+	atomic_set(&pol->cur_il_weight, 0);
 }
 
 static void mpol_rebind_preferred(struct mempolicy *pol,
@@ -973,8 +974,10 @@ static long do_get_mempolicy(int *policy, nodemask_t *nmask,
 			*policy = next_node_in(current->il_prev, pol->nodes);
 		} else if (pol == current->mempolicy &&
 				(pol->mode == MPOL_WEIGHTED_INTERLEAVE)) {
-			if (pol->cur_il_weight)
-				*policy = current->il_prev;
+			int cweight = atomic_read(&pol->cur_il_weight);
+
+			if (cweight & 0xFF)
+				*policy = cweight >> 8;
 			else
 				*policy = next_node_in(current->il_prev,
 						       pol->nodes);
@@ -1864,36 +1867,48 @@ static unsigned int weighted_interleave_nodes(struct mempolicy *policy)
 	unsigned int node, next;
 	struct task_struct *me = current;
 	u8 __rcu *table;
+	int cur_weight;
 	u8 weight;
 
-	node = next_node_in(me->il_prev, policy->nodes);
-	if (node == MAX_NUMNODES)
-		return node;
+	cur_weight = atomic_read(&policy->cur_il_weight);
+	node = cur_weight >> 8;
+	weight = cur_weight & 0xff;
 
-	/* on first alloc after setting mempolicy, acquire first weight */
-	if (unlikely(!policy->cur_il_weight)) {
+	/* If nodemask was rebound, just fetch the next node */
+	if (!weight || !node_isset(node, policy->nodes)) {
+		node = next_node_in(me->il_prev, policy->nodes);
+		/* can only happen if nodemask has become invalid */
+		if (node == MAX_NUMNODES)
+			return node;
 		rcu_read_lock();
 		table = rcu_dereference(iw_table);
 		/* detect system-default values */
 		weight = table ? table[node] : 1;
-		policy->cur_il_weight = weight ? weight : 1;
+		weight = weight ? weight : 1;
 		rcu_read_unlock();
 	}
 
 	/* account for this allocation call */
-	policy->cur_il_weight--;
+	weight--;
 
 	/* if now at 0, move to next node and set up that node's weight */
-	if (unlikely(!policy->cur_il_weight)) {
+	if (unlikely(!weight)) {
 		me->il_prev = node;
 		next = next_node_in(node, policy->nodes);
-		rcu_read_lock();
-		table = rcu_dereference(iw_table);
-		/* detect system-default values */
-		weight = table ? table[next] : 1;
-		policy->cur_il_weight = weight ? weight : 1;
-		rcu_read_unlock();
-	}
+		if (next != MAX_NUMNODES) {
+			rcu_read_lock();
+			table = rcu_dereference(iw_table);
+			/* detect system-default values */
+			weight = table ? table[next] : 1;
+			weight = weight ? weight : 1;
+			rcu_read_unlock();
+			cur_weight = (next << 8) | weight;
+		} else /* policy->nodes became invalid */
+			cur_weight = 0;
+	} else
+		cur_weight = (node << 8) | weight;
+
+	atomic_set(&policy->cur_il_weight, cur_weight);
 	return node;
 }
 
@@ -2385,6 +2400,7 @@ static unsigned long alloc_pages_bulk_array_weighted_interleave(gfp_t gfp,
 	nodemask_t nodes;
 	int nnodes, node, resume_node, next_node;
 	int prev_node = me->il_prev;
+	int cur_node_and_weight = atomic_read(&pol->cur_il_weight);
 	int i;
 
 	if (!nr_pages)
@@ -2394,10 +2410,11 @@ static unsigned long alloc_pages_bulk_array_weighted_interleave(gfp_t gfp,
 	if (!nnodes)
 		return 0;
 
+	node = cur_node_and_weight >> 8;
+	weight = cur_node_and_weight & 0xff;
 	/* Continue allocating from most recent node and adjust the nr_pages */
-	if (pol->cur_il_weight) {
-		node = next_node_in(prev_node, nodes);
-		node_pages = pol->cur_il_weight;
+	if (weight && node_isset(node, nodes)) {
+		node_pages = weight;
 		if (node_pages > rem_pages)
 			node_pages = rem_pages;
 		nr_allocated = __alloc_pages_bulk(gfp, node, NULL, node_pages,
@@ -2408,27 +2425,36 @@ static unsigned long alloc_pages_bulk_array_weighted_interleave(gfp_t gfp,
 		 * if that's all the pages, no need to interleave, otherwise
 		 * we need to set up the next interleave node/weight correctly.
 		 */
-		if (rem_pages < pol->cur_il_weight) {
+		if (rem_pages < weight) {
 			/* stay on current node, adjust cur_il_weight */
-			pol->cur_il_weight -= rem_pages;
+			weight -= rem_pages;
+			atomic_set(&pol->cur_il_weight, ((node << 8) | weight));
 			return total_allocated;
-		} else if (rem_pages == pol->cur_il_weight) {
+		} else if (rem_pages == weight) {
 			/* move to next node / weight */
 			me->il_prev = node;
 			next_node = next_node_in(node, nodes);
-			rcu_read_lock();
-			table = rcu_dereference(iw_table);
-			weight = table ? table[next_node] : 1;
-			/* detect system-default usage */
-			pol->cur_il_weight = weight ? weight : 1;
-			rcu_read_unlock();
+			if (next_node == MAX_NUMNODES) {
+				next_node = 0;
+				weight = 0;
+			} else {
+				rcu_read_lock();
+				table = rcu_dereference(iw_table);
+				weight = table ? table[next_node] : 1;
+				/* detect system-default usage */
+				weight = weight ? weight : 1;
+				rcu_read_unlock();
+			}
+			atomic_set(&pol->cur_il_weight,
+				   ((next_node << 8) | weight));
 			return total_allocated;
 		}
 		/* Otherwise we adjust nr_pages down, and continue from there */
-		rem_pages -= pol->cur_il_weight;
-		pol->cur_il_weight = 0;
+		rem_pages -= weight;
 		prev_node = node;
 	}
+	/* clear cur_il_weight in case of an allocation failure */
+	atomic_set(&pol->cur_il_weight, 0);
 
 	/* create a local copy of node weights to operate on outside rcu */
 	weights = kmalloc(nr_node_ids, GFP_KERNEL);
@@ -2513,7 +2539,8 @@ static unsigned long alloc_pages_bulk_array_weighted_interleave(gfp_t gfp,
 	}
 	/* resume allocating from the calculated node and weight */
 	me->il_prev = resume_node;
-	pol->cur_il_weight = resume_weight;
+	resume_node = next_node_in(resume_node, nodes);
+	atomic_set(&pol->cur_il_weight, ((resume_node << 8) | resume_weight));
 	kfree(weights);
 	return total_allocated;
 }
-- 
2.39.1


