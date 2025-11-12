Return-Path: <linux-fsdevel+bounces-68087-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FA0C54252
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 20:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2F35334B1AF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 19:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7DA634D916;
	Wed, 12 Nov 2025 19:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ueCv7JmA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC2434D38F
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Nov 2025 19:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762975794; cv=none; b=JhKDjSI1VMlfmGORYI1ATP1B6cun5ly1kBdzqLbd991Y07av0VXoMBFyDaiYESx9PA+y1CQq3w6yHmNt05/2ln3F/2XiwJ+GBLSiuv8ovFXipmX3S9iCAdtOSlpt6hx+1BN8cQCzEwmPsmwH92bcPtP2UzuVIEt5OjCW1v2IeKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762975794; c=relaxed/simple;
	bh=oWT3QdfzIV3jbSGJXVBBh6ddTLW23EABmnAWQr4nZ1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QkRh8FZdFi5VJMAwvLAARD/7L6sgsuIRJ1JlNx9QGKhUX0hFvAmWMj0RDI0S4ZGsLKUy3juz13wTm6Wz3tzcqfzM8y32SMUifK6PCgWLS8sDBzG7Q1CK1QHqRN5D6sYngUntlz1R0nk6S/RDXXjw1YQv58no7gildmP4ed8hEbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ueCv7JmA; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8b2a4b6876fso4314185a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Nov 2025 11:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1762975791; x=1763580591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T7tukR8goduFTZ00FpwpL7JWktUWF3Mq7A3Wmoox3b0=;
        b=ueCv7JmAjtqI0gF+tfVnACo9PU17ifJtvdmippVwrC5/JZH1bQevLHEZ0bn15lkr9S
         Ier1nGktNolPrwiEgbq4RmATGAYT6iR9RlR/FR504QEJmNDBYJ2gZNWJ3/HrJbPGxjFk
         G6koATqImxp133UblEdRRXaZHk7Mk3ne6qmST2sooUX15G91xUTeu/7hRygInlHBe2E+
         hrMgegeuVmzq/nxFXlWJMi3qHZh/fBq05t8VElR4paYQ6l2EYxWSnu2hGX08rsyZkqyG
         KAuI0J312Y/rXV8yQi5vycN/oZYwdjOOHvnrk9ClSEV0KSnvySm8HaOFR9CTa3iqNvjd
         Loqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762975791; x=1763580591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T7tukR8goduFTZ00FpwpL7JWktUWF3Mq7A3Wmoox3b0=;
        b=sn/JnOJ4XyO4mS4P3A9+LJNSDM0aUZeOAu+vZDxzHkNiPGwcLI3XHSwIlRAt8bY2z4
         2JlRwIJmrxvZNlmqtE7e8BMGJn8hrfWl8uiujONg6SVsbjNYpNfbuwp+Uc3zMpCEQfrF
         guI2KsAbykzzbCTOw/juewT5LNIVtM9/H9bMkzyHDl7CzHoOZ/ufgGARNwQ2aOGYOsqd
         dpFCiivFBmK0ZGwfEPa6efh02+uYKN9sZMmrP/vzS7dW4GbOb/ofNV1cxh/XA0TZWAVX
         DsxktXC5q2I4FV1DJ4kRmBZWG20D6Mr5C3iXXWJvE7oa3ErLp6eYH1QhW2QQsuzjyAxT
         y5Uw==
X-Forwarded-Encrypted: i=1; AJvYcCWbpkpo3oi6B4sUlQMf5HlHP+V0mkNG4PyXBT7PLEzQWiQJT4pRD/IyocMoy51HVErfhrJ+Bxkw5OrcbEq1@vger.kernel.org
X-Gm-Message-State: AOJu0YzMJag9SO1wej3vtJXMIvbejUrkrjjAljQ8xCar1hp87wMbt0WA
	+EioBAEX+IItkooWIN7LLhUmaomNNuKQLYUPBpKlan+Yg+GDjMHH5A7bJFFT7V3Enms=
X-Gm-Gg: ASbGncvYKTpqoj3u1SkuDa8VkPzB3Dpd0Tj2jXIeshtbOcMDVigoyaD4JV+x0p/FP/S
	t7vZTtOVkVMOxt29cbXChSKif+SUzh/4yh+c8nEtTXEBcGgLAseTbNFqe3IA5WqzKNWhSQ+5JAN
	baZZN2xiaLkmGg4nHI0q1dOsumwXQPdSXK69LOoRbAd6Md4fEGfPEgkOQZWvYEIVm5Dlqmq5u+o
	u7tu3N++plw52l/Gvj1Z+D8/olrhNo3Fc2yFbtiL2N1973vbLq2U3dn1z65CIzWaWKsqzXNCJDS
	Jsm+gDT6SjpVR35GkCkkWy8tpz7rGkDHNOsWp7LibgN1F2xUKTYN33vVQ22dFTGEhkwHgHpne1T
	fMKbL7a0k3mhd3gtc/QfwswBjwWKByKDPM8yeRE/SJVIdbWomrJ7fJyQN8q4oDXKLKksbMPQhiG
	RJ/6xrcayzydEJFBouzrSTlJtpORp0gRCNgitEaKniaDTgPMh/sXK0suRFXUbK+GtD
X-Google-Smtp-Source: AGHT+IHo8OwgwUC032YSv60eOJd12q77M7KD3oUAYRPoiD1R5IwVdmpQvxPyI0R/rCY63GPtuNDIug==
X-Received: by 2002:a05:620a:4406:b0:8a4:40da:b907 with SMTP id af79cd13be357-8b29b768ba9mr557487185a.32.1762975790793;
        Wed, 12 Nov 2025 11:29:50 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b29aa0082esm243922885a.50.2025.11.12.11.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 11:29:50 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: kernel-team@meta.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	cgroups@vger.kernel.org,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	longman@redhat.com,
	akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	osalvador@suse.de,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	kees@kernel.org,
	muchun.song@linux.dev,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	rientjes@google.com,
	jackmanb@google.com,
	cl@gentwo.org,
	harry.yoo@oracle.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	zhengqi.arch@bytedance.com,
	yosry.ahmed@linux.dev,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	fabio.m.de.francesco@linux.intel.com,
	rrichter@amd.com,
	ming.li@zohomail.com,
	usamaarif642@gmail.com,
	brauner@kernel.org,
	oleg@redhat.com,
	namcao@linutronix.de,
	escape@linux.alibaba.com,
	dongjoo.seo1@samsung.com
Subject: [RFC PATCH v2 01/11] mm: constify oom_control, scan_control, and alloc_context nodemask
Date: Wed, 12 Nov 2025 14:29:17 -0500
Message-ID: <20251112192936.2574429-2-gourry@gourry.net>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251112192936.2574429-1-gourry@gourry.net>
References: <20251112192936.2574429-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The nodemasks in these structures may come from a variety of sources,
including tasks and cpusets - and should never be modified by any code
when being passed around inside another context.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 include/linux/cpuset.h | 4 ++--
 include/linux/mm.h     | 4 ++--
 include/linux/mmzone.h | 6 +++---
 include/linux/oom.h    | 2 +-
 include/linux/swap.h   | 2 +-
 kernel/cgroup/cpuset.c | 2 +-
 mm/internal.h          | 2 +-
 mm/mmzone.c            | 5 +++--
 mm/page_alloc.c        | 4 ++--
 mm/show_mem.c          | 9 ++++++---
 mm/vmscan.c            | 6 +++---
 11 files changed, 25 insertions(+), 21 deletions(-)

diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index 2ddb256187b5..548eaf7ef8d0 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -80,7 +80,7 @@ extern bool cpuset_cpu_is_isolated(int cpu);
 extern nodemask_t cpuset_mems_allowed(struct task_struct *p);
 #define cpuset_current_mems_allowed (current->mems_allowed)
 void cpuset_init_current_mems_allowed(void);
-int cpuset_nodemask_valid_mems_allowed(nodemask_t *nodemask);
+int cpuset_nodemask_valid_mems_allowed(const nodemask_t *nodemask);
 
 extern bool cpuset_current_node_allowed(int node, gfp_t gfp_mask);
 
@@ -219,7 +219,7 @@ static inline nodemask_t cpuset_mems_allowed(struct task_struct *p)
 #define cpuset_current_mems_allowed (node_states[N_MEMORY])
 static inline void cpuset_init_current_mems_allowed(void) {}
 
-static inline int cpuset_nodemask_valid_mems_allowed(nodemask_t *nodemask)
+static inline int cpuset_nodemask_valid_mems_allowed(const nodemask_t *nodemask)
 {
 	return 1;
 }
diff --git a/include/linux/mm.h b/include/linux/mm.h
index d16b33bacc32..1a874917eae6 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3343,7 +3343,7 @@ extern int __meminit early_pfn_to_nid(unsigned long pfn);
 extern void mem_init(void);
 extern void __init mmap_init(void);
 
-extern void __show_mem(unsigned int flags, nodemask_t *nodemask, int max_zone_idx);
+extern void __show_mem(unsigned int flags, const nodemask_t *nodemask, int max_zone_idx);
 static inline void show_mem(void)
 {
 	__show_mem(0, NULL, MAX_NR_ZONES - 1);
@@ -3353,7 +3353,7 @@ extern void si_meminfo(struct sysinfo * val);
 extern void si_meminfo_node(struct sysinfo *val, int nid);
 
 extern __printf(3, 4)
-void warn_alloc(gfp_t gfp_mask, nodemask_t *nodemask, const char *fmt, ...);
+void warn_alloc(gfp_t gfp_mask, const nodemask_t *nodemask, const char *fmt, ...);
 
 extern void setup_per_cpu_pageset(void);
 
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 7fb7331c5725..5c96b2c52817 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1725,7 +1725,7 @@ static inline int zonelist_node_idx(const struct zoneref *zoneref)
 
 struct zoneref *__next_zones_zonelist(struct zoneref *z,
 					enum zone_type highest_zoneidx,
-					nodemask_t *nodes);
+					const nodemask_t *nodes);
 
 /**
  * next_zones_zonelist - Returns the next zone at or below highest_zoneidx within the allowed nodemask using a cursor within a zonelist as a starting point
@@ -1744,7 +1744,7 @@ struct zoneref *__next_zones_zonelist(struct zoneref *z,
  */
 static __always_inline struct zoneref *next_zones_zonelist(struct zoneref *z,
 					enum zone_type highest_zoneidx,
-					nodemask_t *nodes)
+					const nodemask_t *nodes)
 {
 	if (likely(!nodes && zonelist_zone_idx(z) <= highest_zoneidx))
 		return z;
@@ -1770,7 +1770,7 @@ static __always_inline struct zoneref *next_zones_zonelist(struct zoneref *z,
  */
 static inline struct zoneref *first_zones_zonelist(struct zonelist *zonelist,
 					enum zone_type highest_zoneidx,
-					nodemask_t *nodes)
+					const nodemask_t *nodes)
 {
 	return next_zones_zonelist(zonelist->_zonerefs,
 							highest_zoneidx, nodes);
diff --git a/include/linux/oom.h b/include/linux/oom.h
index 7b02bc1d0a7e..00da05d227e6 100644
--- a/include/linux/oom.h
+++ b/include/linux/oom.h
@@ -30,7 +30,7 @@ struct oom_control {
 	struct zonelist *zonelist;
 
 	/* Used to determine mempolicy */
-	nodemask_t *nodemask;
+	const nodemask_t *nodemask;
 
 	/* Memory cgroup in which oom is invoked, or NULL for global oom */
 	struct mem_cgroup *memcg;
diff --git a/include/linux/swap.h b/include/linux/swap.h
index e818fbade1e2..f5154499bafd 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -381,7 +381,7 @@ extern void swap_setup(void);
 /* linux/mm/vmscan.c */
 extern unsigned long zone_reclaimable_pages(struct zone *zone);
 extern unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
-					gfp_t gfp_mask, nodemask_t *mask);
+					gfp_t gfp_mask, const nodemask_t *mask);
 
 #define MEMCG_RECLAIM_MAY_SWAP (1 << 1)
 #define MEMCG_RECLAIM_PROACTIVE (1 << 2)
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 52468d2c178a..cd3e2ae83d70 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -4238,7 +4238,7 @@ nodemask_t cpuset_mems_allowed(struct task_struct *tsk)
  *
  * Are any of the nodes in the nodemask allowed in current->mems_allowed?
  */
-int cpuset_nodemask_valid_mems_allowed(nodemask_t *nodemask)
+int cpuset_nodemask_valid_mems_allowed(const nodemask_t *nodemask)
 {
 	return nodes_intersects(*nodemask, current->mems_allowed);
 }
diff --git a/mm/internal.h b/mm/internal.h
index 1561fc2ff5b8..464e60dd7ba1 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -587,7 +587,7 @@ void page_alloc_sysctl_init(void);
  */
 struct alloc_context {
 	struct zonelist *zonelist;
-	nodemask_t *nodemask;
+	const nodemask_t *nodemask;
 	struct zoneref *preferred_zoneref;
 	int migratetype;
 
diff --git a/mm/mmzone.c b/mm/mmzone.c
index 0c8f181d9d50..59dc3f2076a6 100644
--- a/mm/mmzone.c
+++ b/mm/mmzone.c
@@ -43,7 +43,8 @@ struct zone *next_zone(struct zone *zone)
 	return zone;
 }
 
-static inline int zref_in_nodemask(struct zoneref *zref, nodemask_t *nodes)
+static inline int zref_in_nodemask(struct zoneref *zref,
+				   const nodemask_t *nodes)
 {
 #ifdef CONFIG_NUMA
 	return node_isset(zonelist_node_idx(zref), *nodes);
@@ -55,7 +56,7 @@ static inline int zref_in_nodemask(struct zoneref *zref, nodemask_t *nodes)
 /* Returns the next zone at or below highest_zoneidx in a zonelist */
 struct zoneref *__next_zones_zonelist(struct zoneref *z,
 					enum zone_type highest_zoneidx,
-					nodemask_t *nodes)
+					const nodemask_t *nodes)
 {
 	/*
 	 * Find the next suitable zone to use for the allocation.
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 600d9e981c23..fd5401fb5e00 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3924,7 +3924,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 	return NULL;
 }
 
-static void warn_alloc_show_mem(gfp_t gfp_mask, nodemask_t *nodemask)
+static void warn_alloc_show_mem(gfp_t gfp_mask, const nodemask_t *nodemask)
 {
 	unsigned int filter = SHOW_MEM_FILTER_NODES;
 
@@ -3943,7 +3943,7 @@ static void warn_alloc_show_mem(gfp_t gfp_mask, nodemask_t *nodemask)
 	__show_mem(filter, nodemask, gfp_zone(gfp_mask));
 }
 
-void warn_alloc(gfp_t gfp_mask, nodemask_t *nodemask, const char *fmt, ...)
+void warn_alloc(gfp_t gfp_mask, const nodemask_t *nodemask, const char *fmt, ...)
 {
 	struct va_format vaf;
 	va_list args;
diff --git a/mm/show_mem.c b/mm/show_mem.c
index 3a4b5207635d..24685b5c6dcf 100644
--- a/mm/show_mem.c
+++ b/mm/show_mem.c
@@ -116,7 +116,8 @@ void si_meminfo_node(struct sysinfo *val, int nid)
  * Determine whether the node should be displayed or not, depending on whether
  * SHOW_MEM_FILTER_NODES was passed to show_free_areas().
  */
-static bool show_mem_node_skip(unsigned int flags, int nid, nodemask_t *nodemask)
+static bool show_mem_node_skip(unsigned int flags, int nid,
+			       const nodemask_t *nodemask)
 {
 	if (!(flags & SHOW_MEM_FILTER_NODES))
 		return false;
@@ -177,7 +178,8 @@ static bool node_has_managed_zones(pg_data_t *pgdat, int max_zone_idx)
  * SHOW_MEM_FILTER_NODES: suppress nodes that are not allowed by current's
  *   cpuset.
  */
-static void show_free_areas(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
+static void show_free_areas(unsigned int filter, const nodemask_t *nodemask,
+			    int max_zone_idx)
 {
 	unsigned long free_pcp = 0;
 	int cpu, nid;
@@ -399,7 +401,8 @@ static void show_free_areas(unsigned int filter, nodemask_t *nodemask, int max_z
 	show_swap_cache_info();
 }
 
-void __show_mem(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
+void __show_mem(unsigned int filter, const nodemask_t *nodemask,
+		int max_zone_idx)
 {
 	unsigned long total = 0, reserved = 0, highmem = 0;
 	struct zone *zone;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index b2fc8b626d3d..03e7f5206ad9 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -80,7 +80,7 @@ struct scan_control {
 	 * Nodemask of nodes allowed by the caller. If NULL, all nodes
 	 * are scanned.
 	 */
-	nodemask_t	*nodemask;
+	const nodemask_t *nodemask;
 
 	/*
 	 * The memory cgroup that hit its limit and as a result is the
@@ -6530,7 +6530,7 @@ static bool allow_direct_reclaim(pg_data_t *pgdat)
  * happens, the page allocator should not consider triggering the OOM killer.
  */
 static bool throttle_direct_reclaim(gfp_t gfp_mask, struct zonelist *zonelist,
-					nodemask_t *nodemask)
+				    const nodemask_t *nodemask)
 {
 	struct zoneref *z;
 	struct zone *zone;
@@ -6610,7 +6610,7 @@ static bool throttle_direct_reclaim(gfp_t gfp_mask, struct zonelist *zonelist,
 }
 
 unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
-				gfp_t gfp_mask, nodemask_t *nodemask)
+				gfp_t gfp_mask, const nodemask_t *nodemask)
 {
 	unsigned long nr_reclaimed;
 	struct scan_control sc = {
-- 
2.51.1


