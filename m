Return-Path: <linux-fsdevel+bounces-32316-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5FC9A35C7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 08:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CCC228381C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 06:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A43018FDA3;
	Fri, 18 Oct 2024 06:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bnk7JPfe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1046B18E03D;
	Fri, 18 Oct 2024 06:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729233670; cv=none; b=ZpnT7SeP1PVX9o+4r0CDZLm4xNgGldxREk9A0bf9qLiRs3Z6x23chqMAknk1vMLPmV6wm7jcFPoG2SQ6prjwLp1oY3sOoHJnKsfgR6BFPcp6HGK+vRnmgPPDWLPovQh5owxWc3qIloY4GDGLmg00Ad3egSAwMlBPE8xsv6kp9T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729233670; c=relaxed/simple;
	bh=GA4zNC/BA7uVqXos9F/5h3uPYjHVZ8vkHQMHlvAZyyg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UxgVKhUw+Le7o+QBx3wXyFSQvLEbuzBlXS1Ckf6zLrN+Fs0AtCRGYpjXbPC7yxXAG3fmmYc4eUyqTTeL1BT98e5VD37OgEK6KmcCz9c3f1FDpcWDUxQAvHcEa6IQ7RaAWBUDRB8DAbt7q0+u32gs1boKKaC+uQVEkUIfaGQ8DI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bnk7JPfe; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729233668; x=1760769668;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GA4zNC/BA7uVqXos9F/5h3uPYjHVZ8vkHQMHlvAZyyg=;
  b=bnk7JPfeY8gruayeyqqzgqhMsOWWKvshxjBXuACbCC7xQw9niIB4pMRX
   TcvQxn3LPhqBueJmMDT9+uClyd+MRH4hhAGj3HRj9Qk7BMdS/cklBifVF
   R4Hf54/zlcIf3r5adn4PUX9wYvBrYJEg283eGVy+QMT7ps+pDDkXABhUv
   nFTk9wBVlwt1+D7yL3+XDRl6rwaHoQCj7fNy38qopGuR6u3oEPmwEOePQ
   YEUIG/qQSeyJ2oLxzqGIyGxSZPQNG/zuqsFGwdEFBmSWGjQb1cPaecgLA
   AW5qADW0eo5V7Hn8ntRLAcANIaQjqWcwQwwJ/UhkIOEa6yc//4Yyijvdp
   w==;
X-CSE-ConnectionGUID: 3QAjLIW6TX+kIeUGCwyoEg==
X-CSE-MsgGUID: r/45t9ohTtmtUgkZFbCeFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="28884872"
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="28884872"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 23:41:03 -0700
X-CSE-ConnectionGUID: zH0hGZmDQVO7EAYVusV2Hw==
X-CSE-MsgGUID: ymW4e2aWT3qeiSwr7IcC9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="83607514"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.6])
  by orviesa003.jf.intel.com with ESMTP; 17 Oct 2024 23:41:03 -0700
From: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	usamaarif642@gmail.com,
	ryan.roberts@arm.com,
	ying.huang@intel.com,
	21cnbao@gmail.com,
	akpm@linux-foundation.org,
	linux-crypto@vger.kernel.org,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	clabbe@baylibre.com,
	ardb@kernel.org,
	ebiggers@google.com,
	surenb@google.com,
	kristen.c.accardi@intel.com,
	zanussi@kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	mcgrof@kernel.org,
	kees@kernel.org,
	joel.granados@kernel.org,
	bfoster@redhat.com,
	willy@infradead.org,
	linux-fsdevel@vger.kernel.org
Cc: wajdi.k.feghali@intel.com,
	vinodh.gopal@intel.com,
	kanchana.p.sridhar@intel.com
Subject: [RFC PATCH v1 07/13] crypto: iaa - Change cpu-to-iaa mappings to evenly balance cores to IAAs.
Date: Thu, 17 Oct 2024 23:40:55 -0700
Message-Id: <20241018064101.336232-8-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20241018064101.336232-1-kanchana.p.sridhar@intel.com>
References: <20241018064101.336232-1-kanchana.p.sridhar@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change distributes the cpus more evenly among the IAAs in each socket.

 Old algorithm to assign cpus to IAA:
 ------------------------------------
 If "nr_cpus" = nr_logical_cpus (includes hyper-threading), the current
 algorithm determines "nr_cpus_per_node" = nr_cpus / nr_nodes.

 Hence, on a 2-socket Sapphire Rapids server where each socket has 56 cores
 and 4 IAA devices, nr_cpus_per_node = 112.

 Further, cpus_per_iaa = (nr_nodes * nr_cpus_per_node) / nr_iaa
 Hence, cpus_per_iaa = 224/8 = 28.

 The iaa_crypto driver then assigns 28 "logical" node cpus per IAA device
 on that node, that results in this cpu-to-iaa mapping:

 lscpu|grep NUMA
 NUMA node(s):        2
 NUMA node0 CPU(s):   0-55,112-167
 NUMA node1 CPU(s):   56-111,168-223

 NUMA node 0:
 cpu   0-27    28-55  112-139  140-167
 iaa   iax1    iax3   iax5     iax7

 NUMA node 1:
 cpu   56-83  84-111  168-195   196-223
 iaa   iax9   iax11   iax13     iax15

 This appears non-optimal for a few reasons:

 1) The 2 logical threads on a core will get assigned to different IAA
    devices. For e.g.:
      cpu 0:   iax1
      cpu 112: iax5
 2) One of the logical threads on a core is assigned to an IAA that is not
    closest to that core. For e.g. cpu 112.
 3) If numactl is used to start processes sequentially on the logical
    cores, some of the IAA devices on the socket could be over-subscribed,
    while some could be under-utilized.

This patch introduces a scheme to more evenly balance the logical cores to
IAA devices on a socket.

 New algorithm to assign cpus to IAA:
 ------------------------------------
 We introduce a function "cpu_to_iaa()" that takes a logical cpu and
 returns the IAA device closest to it.

 If "nr_cpus" = nr_logical_cpus (includes hyper-threading), the new
 algorithm determines "nr_cpus_per_node" = topology_num_cores_per_package().

 Hence, on a 2-socket Sapphire Rapids server where each socket has 56 cores
 and 4 IAA devices, nr_cpus_per_node = 56.

 Further, cpus_per_iaa = (nr_nodes * nr_cpus_per_node) / nr_iaa
 Hence, cpus_per_iaa = 112/8 = 14.

 The iaa_crypto driver then assigns 14 "logical" node cpus per IAA device
 on that node, that results in this cpu-to-iaa mapping:

 NUMA node 0:
 cpu   0-13,112-125   14-27,126-139  28-41,140-153  42-55,154-167
 iaa   iax1           iax3           iax5           iax7

 NUMA node 1:
 cpu   56-69,168-181  70-83,182-195  84-97,196-209   98-111,210-223
 iaa   iax9           iax11          iax13           iax15

 This resolves the 3 issues with non-optimality of cpu-to-iaa mappings
 pointed out earlier with the existing approach.

Originally-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
---
 drivers/crypto/intel/iaa/iaa_crypto_main.c | 84 ++++++++++++++--------
 1 file changed, 54 insertions(+), 30 deletions(-)

diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c b/drivers/crypto/intel/iaa/iaa_crypto_main.c
index 8e6859c97970..c854a7a1aaa4 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
@@ -55,6 +55,46 @@ static struct idxd_wq *wq_table_next_wq(int cpu)
 	return entry->wqs[entry->cur_wq];
 }
 
+/*
+ * Given a cpu, find the closest IAA instance.  The idea is to try to
+ * choose the most appropriate IAA instance for a caller and spread
+ * available workqueues around to clients.
+ */
+static inline int cpu_to_iaa(int cpu)
+{
+	int node, n_cpus = 0, test_cpu, iaa = 0;
+	int nr_iaa_per_node;
+	const struct cpumask *node_cpus;
+
+	if (!nr_nodes)
+		return 0;
+
+	nr_iaa_per_node = nr_iaa / nr_nodes;
+	if (!nr_iaa_per_node)
+		return 0;
+
+	for_each_online_node(node) {
+		node_cpus = cpumask_of_node(node);
+		if (!cpumask_test_cpu(cpu, node_cpus))
+			continue;
+
+		for_each_cpu(test_cpu, node_cpus) {
+			if ((n_cpus % nr_cpus_per_node) == 0)
+				iaa = node * nr_iaa_per_node;
+
+			if (test_cpu == cpu)
+				return iaa;
+
+			n_cpus++;
+
+			if ((n_cpus % cpus_per_iaa) == 0)
+				iaa++;
+		}
+	}
+
+	return -1;
+}
+
 static void wq_table_add(int cpu, struct idxd_wq *wq)
 {
 	struct wq_table_entry *entry = per_cpu_ptr(wq_table, cpu);
@@ -895,8 +935,7 @@ static int wq_table_add_wqs(int iaa, int cpu)
  */
 static void rebalance_wq_table(void)
 {
-	const struct cpumask *node_cpus;
-	int node, cpu, iaa = -1;
+	int cpu, iaa;
 
 	if (nr_iaa == 0)
 		return;
@@ -906,37 +945,22 @@ static void rebalance_wq_table(void)
 
 	clear_wq_table();
 
-	if (nr_iaa == 1) {
-		for (cpu = 0; cpu < nr_cpus; cpu++) {
-			if (WARN_ON(wq_table_add_wqs(0, cpu))) {
-				pr_debug("could not add any wqs for iaa 0 to cpu %d!\n", cpu);
-				return;
-			}
-		}
-
-		return;
-	}
-
-	for_each_node_with_cpus(node) {
-		node_cpus = cpumask_of_node(node);
-
-		for (cpu = 0; cpu <  cpumask_weight(node_cpus); cpu++) {
-			int node_cpu = cpumask_nth(cpu, node_cpus);
-
-			if (WARN_ON(node_cpu >= nr_cpu_ids)) {
-				pr_debug("node_cpu %d doesn't exist!\n", node_cpu);
-				return;
-			}
+	for (cpu = 0; cpu < nr_cpus; cpu++) {
+		iaa = cpu_to_iaa(cpu);
+		pr_debug("rebalance: cpu=%d iaa=%d\n", cpu, iaa);
 
-			if ((cpu % cpus_per_iaa) == 0)
-				iaa++;
+		if (WARN_ON(iaa == -1)) {
+			pr_debug("rebalance (cpu_to_iaa(%d)) failed!\n", cpu);
+			return;
+		}
 
-			if (WARN_ON(wq_table_add_wqs(iaa, node_cpu))) {
-				pr_debug("could not add any wqs for iaa %d to cpu %d!\n", iaa, cpu);
-				return;
-			}
+		if (WARN_ON(wq_table_add_wqs(iaa, cpu))) {
+			pr_debug("could not add any wqs for iaa %d to cpu %d!\n", iaa, cpu);
+			return;
 		}
 	}
+
+	pr_debug("Finished rebalance local wqs.");
 }
 
 static inline int check_completion(struct device *dev,
@@ -2084,7 +2108,7 @@ static int __init iaa_crypto_init_module(void)
 		pr_err("IAA couldn't find any nodes with cpus\n");
 		return -ENODEV;
 	}
-	nr_cpus_per_node = nr_cpus / nr_nodes;
+	nr_cpus_per_node = topology_num_cores_per_package();
 
 	if (crypto_has_comp("deflate-generic", 0, 0))
 		deflate_generic_tfm = crypto_alloc_comp("deflate-generic", 0, 0);
-- 
2.27.0


