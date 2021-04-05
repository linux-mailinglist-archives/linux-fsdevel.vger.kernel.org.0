Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB055353BD5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Apr 2021 07:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbhDEFtF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Apr 2021 01:49:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50956 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231937AbhDEFtF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Apr 2021 01:49:05 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1355XEQL174033;
        Mon, 5 Apr 2021 01:48:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : mime-version : content-type; s=pp1;
 bh=VhAe+bnXRKR8N1ZukPeIYdk9hCBI+vrlf4N3eVwM9wU=;
 b=V2PlyvEeNCPmi9qucRugZyZg9RIFBnXphCMbkVnO8idhPYW+zC3pv6J9bDn3M5GanFzm
 c7wMrORKWxWkqFWahLPBgkVgG/D65bZ2cvwi9Y4gcxyBchRuybjU1oZ0YcIV4RahbUSz
 7n8RrAvHe8pdlxKd5y2Y+r9JWMOqujruQGe8CSB3aMdL/yTETp+EFp9HfFzsJC+4vQWg
 K/ENhkFcgdTWw4o6odcKbOrbfhfpficCNLViw2jI/k8ndDwmtsmSgjxxwADNI/LhZSQS
 Wh5Aym+6KAXV3Xu4Y0U0STvjeKHrViHf5I83crpw9uN8vebvtGu+YVdA10SnHaRxkE8Q SQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37q5vtykqv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Apr 2021 01:48:56 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 1355ft3R021903;
        Mon, 5 Apr 2021 05:48:54 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 37q2q5h154-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Apr 2021 05:48:54 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1355mpsY41156980
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 5 Apr 2021 05:48:51 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BEB4B4C044;
        Mon,  5 Apr 2021 05:48:51 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A777F4C046;
        Mon,  5 Apr 2021 05:48:50 +0000 (GMT)
Received: from in.ibm.com (unknown [9.77.196.204])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon,  5 Apr 2021 05:48:50 +0000 (GMT)
Date:   Mon, 5 Apr 2021 11:18:48 +0530
From:   Bharata B Rao <bharata@linux.ibm.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, aneesh.kumar@linux.ibm.com
Subject: High kmalloc-32 slab cache consumption with 10k containers
Message-ID: <20210405054848.GA1077931@in.ibm.com>
Reply-To: bharata@linux.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: d5J6KZPQCt7kx2F5vtvM2YJi6e6vJfwp
X-Proofpoint-ORIG-GUID: d5J6KZPQCt7kx2F5vtvM2YJi6e6vJfwp
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-05_02:2021-04-01,2021-04-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxscore=0 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 impostorscore=0 clxscore=1011 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104030000 definitions=main-2104050038
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

When running 10000 (more-or-less-empty-)containers on a bare-metal Power9
server(160 CPUs, 2 NUMA nodes, 256G memory), it is seen that memory
consumption increases quite a lot (around 172G) when the containers are
running. Most of it comes from slab (149G) and within slab, the majority of
it comes from kmalloc-32 cache (102G)

The major allocator of kmalloc-32 slab cache happens to be the list_head
allocations of list_lru_one list. These lists are created whenever a
FS mount happens. Specially two such lists are registered by alloc_super(),
one for dentry and another for inode shrinker list. And these lists
are created for all possible NUMA nodes and for all given memcgs
(memcg_nr_cache_ids to be particular)

If,

A = Nr allocation request per mount: 2 (one for dentry and inode list)
B = Nr NUMA possible nodes
C = memcg_nr_cache_ids
D = size of each kmalloc-32 object: 32 bytes,

then for every mount, the amount of memory consumed by kmalloc-32 slab
cache for list_lru creation is A*B*C*D bytes.

Following factors contribute to the excessive allocations:

- Lists are created for possible NUMA nodes.
- memcg_nr_cache_ids grows in bulk (see memcg_alloc_cache_id() and additional
  list_lrus are created when it grows. Thus we end up creating list_lru_one
  list_heads even for those memcgs which are yet to be created.
  For example, when 10000 memcgs are created, memcg_nr_cache_ids reach
  a value of 12286.
- When a memcg goes offline, the list elements are drained to the parent
  memcg, but the list_head entry remains.
- The lists are destroyed only when the FS is unmounted. So list_heads
  for non-existing memcgs remain and continue to contribute to the
  kmalloc-32 allocation. This is presumably done for performance
  reason as they get reused when new memcgs are created, but they end up
  consuming slab memory until then.
- In case of containers, a few file systems get mounted and are specific
  to the container namespace and hence to a particular memcg, but we
  end up creating lists for all the memcgs.
  As an example, if 7 FS mounts are done for every container and when
  10k containers are created, we end up creating 2*7*12286 list_lru_one
  lists for each NUMA node. It appears that no elements will get added
  to other than 2*7=14 of them in the case of containers.

One straight forward way to prevent this excessive list_lru_one
allocations is to limit the list_lru_one creation only to the
relevant memcg. However I don't see an easy way to figure out
that relevant memcg from FS mount path (alloc_super())

As an alternative approach, I have this below hack that does lazy
list_lru creation. The memcg-specific list is created and initialized
only when there is a request to add an element to that particular
list. Though I am not sure about the full impact of this change
on the owners of the lists and also the performance impact of this,
the overall savings look good.

Used memory
		Before		During		After
W/o patch	23G		172G		40G
W/  patch	23G		69G		29G

Slab consumption
		Before		During		After
W/o patch	1.5G		149G		22G
W/  patch	1.5G		45G		10G

Number of kmalloc-32 allocations
		Before		During		After
W/o patch	178176		3442409472	388933632
W/  patch	190464		468992		468992

Any thoughts on other approaches to address this scenario and
any specific comments about the approach that I have taken is
appreciated. Meanwhile the patch looks like below:

From 9444a0c6734c2853057b1f486f85da2c409fdc84 Mon Sep 17 00:00:00 2001
From: Bharata B Rao <bharata@linux.ibm.com>
Date: Wed, 31 Mar 2021 18:21:45 +0530
Subject: [PATCH 1/1] mm: list_lru: Allocate list_lru_one only when required.

Don't pre-allocate list_lru_one list heads for all memcg_cache_ids.
Instead allocate and initialize it only when required.

Signed-off-by: Bharata B Rao <bharata@linux.ibm.com>
---
 mm/list_lru.c | 79 +++++++++++++++++++++++++--------------------------
 1 file changed, 38 insertions(+), 41 deletions(-)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index 6f067b6b935f..b453fa5008cc 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -112,16 +112,32 @@ list_lru_from_kmem(struct list_lru_node *nlru, void *ptr,
 }
 #endif /* CONFIG_MEMCG_KMEM */
 
+static void init_one_lru(struct list_lru_one *l)
+{
+	INIT_LIST_HEAD(&l->list);
+	l->nr_items = 0;
+}
+
 bool list_lru_add(struct list_lru *lru, struct list_head *item)
 {
 	int nid = page_to_nid(virt_to_page(item));
 	struct list_lru_node *nlru = &lru->node[nid];
 	struct mem_cgroup *memcg;
 	struct list_lru_one *l;
+	struct list_lru_memcg *memcg_lrus;
 
 	spin_lock(&nlru->lock);
 	if (list_empty(item)) {
 		l = list_lru_from_kmem(nlru, item, &memcg);
+		if (!l) {
+			l = kmalloc(sizeof(struct list_lru_one), GFP_ATOMIC);
+			if (!l)
+				goto out;
+
+			init_one_lru(l);
+			memcg_lrus = rcu_dereference_protected(nlru->memcg_lrus, true);
+			memcg_lrus->lru[memcg_cache_id(memcg)] = l;
+		}
 		list_add_tail(item, &l->list);
 		/* Set shrinker bit if the first element was added */
 		if (!l->nr_items++)
@@ -131,6 +147,7 @@ bool list_lru_add(struct list_lru *lru, struct list_head *item)
 		spin_unlock(&nlru->lock);
 		return true;
 	}
+out:
 	spin_unlock(&nlru->lock);
 	return false;
 }
@@ -176,11 +193,12 @@ unsigned long list_lru_count_one(struct list_lru *lru,
 {
 	struct list_lru_node *nlru = &lru->node[nid];
 	struct list_lru_one *l;
-	unsigned long count;
+	unsigned long count = 0;
 
 	rcu_read_lock();
 	l = list_lru_from_memcg_idx(nlru, memcg_cache_id(memcg));
-	count = READ_ONCE(l->nr_items);
+	if (l)
+		count = READ_ONCE(l->nr_items);
 	rcu_read_unlock();
 
 	return count;
@@ -207,6 +225,9 @@ __list_lru_walk_one(struct list_lru_node *nlru, int memcg_idx,
 	unsigned long isolated = 0;
 
 	l = list_lru_from_memcg_idx(nlru, memcg_idx);
+	if (!l)
+		goto out;
+
 restart:
 	list_for_each_safe(item, n, &l->list) {
 		enum lru_status ret;
@@ -251,6 +272,7 @@ __list_lru_walk_one(struct list_lru_node *nlru, int memcg_idx,
 			BUG();
 		}
 	}
+out:
 	return isolated;
 }
 
@@ -312,12 +334,6 @@ unsigned long list_lru_walk_node(struct list_lru *lru, int nid,
 }
 EXPORT_SYMBOL_GPL(list_lru_walk_node);
 
-static void init_one_lru(struct list_lru_one *l)
-{
-	INIT_LIST_HEAD(&l->list);
-	l->nr_items = 0;
-}
-
 #ifdef CONFIG_MEMCG_KMEM
 static void __memcg_destroy_list_lru_node(struct list_lru_memcg *memcg_lrus,
 					  int begin, int end)
@@ -328,41 +344,16 @@ static void __memcg_destroy_list_lru_node(struct list_lru_memcg *memcg_lrus,
 		kfree(memcg_lrus->lru[i]);
 }
 
-static int __memcg_init_list_lru_node(struct list_lru_memcg *memcg_lrus,
-				      int begin, int end)
-{
-	int i;
-
-	for (i = begin; i < end; i++) {
-		struct list_lru_one *l;
-
-		l = kmalloc(sizeof(struct list_lru_one), GFP_KERNEL);
-		if (!l)
-			goto fail;
-
-		init_one_lru(l);
-		memcg_lrus->lru[i] = l;
-	}
-	return 0;
-fail:
-	__memcg_destroy_list_lru_node(memcg_lrus, begin, i);
-	return -ENOMEM;
-}
-
 static int memcg_init_list_lru_node(struct list_lru_node *nlru)
 {
 	struct list_lru_memcg *memcg_lrus;
 	int size = memcg_nr_cache_ids;
 
-	memcg_lrus = kvmalloc(sizeof(*memcg_lrus) +
+	memcg_lrus = kvzalloc(sizeof(*memcg_lrus) +
 			      size * sizeof(void *), GFP_KERNEL);
 	if (!memcg_lrus)
 		return -ENOMEM;
 
-	if (__memcg_init_list_lru_node(memcg_lrus, 0, size)) {
-		kvfree(memcg_lrus);
-		return -ENOMEM;
-	}
 	RCU_INIT_POINTER(nlru->memcg_lrus, memcg_lrus);
 
 	return 0;
@@ -389,15 +380,10 @@ static int memcg_update_list_lru_node(struct list_lru_node *nlru,
 
 	old = rcu_dereference_protected(nlru->memcg_lrus,
 					lockdep_is_held(&list_lrus_mutex));
-	new = kvmalloc(sizeof(*new) + new_size * sizeof(void *), GFP_KERNEL);
+	new = kvzalloc(sizeof(*new) + new_size * sizeof(void *), GFP_KERNEL);
 	if (!new)
 		return -ENOMEM;
 
-	if (__memcg_init_list_lru_node(new, old_size, new_size)) {
-		kvfree(new);
-		return -ENOMEM;
-	}
-
 	memcpy(&new->lru, &old->lru, old_size * sizeof(void *));
 
 	/*
@@ -526,6 +512,7 @@ static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
 	struct list_lru_node *nlru = &lru->node[nid];
 	int dst_idx = dst_memcg->kmemcg_id;
 	struct list_lru_one *src, *dst;
+	struct list_lru_memcg *memcg_lrus;
 
 	/*
 	 * Since list_lru_{add,del} may be called under an IRQ-safe lock,
@@ -534,7 +521,17 @@ static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
 	spin_lock_irq(&nlru->lock);
 
 	src = list_lru_from_memcg_idx(nlru, src_idx);
+	if (!src)
+		goto out;
+
 	dst = list_lru_from_memcg_idx(nlru, dst_idx);
+	if (!dst) {
+		/* TODO: Use __GFP_NOFAIL? */
+		dst = kmalloc(sizeof(struct list_lru_one), GFP_ATOMIC);
+		init_one_lru(dst);
+		memcg_lrus = rcu_dereference_protected(nlru->memcg_lrus, true);
+		memcg_lrus->lru[dst_idx] = dst;
+	}
 
 	list_splice_init(&src->list, &dst->list);
 
@@ -543,7 +540,7 @@ static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
 		memcg_set_shrinker_bit(dst_memcg, nid, lru_shrinker_id(lru));
 		src->nr_items = 0;
 	}
-
+out:
 	spin_unlock_irq(&nlru->lock);
 }
 
-- 
2.26.2

