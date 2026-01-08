Return-Path: <linux-fsdevel+bounces-72933-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FA9D06229
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 21:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE9B13039ACC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 20:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF0433066F;
	Thu,  8 Jan 2026 20:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="HFFGtcTA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C0B330666
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jan 2026 20:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767904728; cv=none; b=PEb/BF504j83cSyRiOCQdf7NYVPsHNqBxNtWH/Ee7c26bHDLSCGBPtLUP0OnfiseyggZa0DdXD7m8ZPUEWIRrasU0mWTPiL6nleLZ+6EdED7gaRU/FtYCjm1+29riCGxagN8B13xaH0/vIW4viqH+BQyKl5j4OTBuAAi7XtgYO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767904728; c=relaxed/simple;
	bh=qpZtiRNxcsJUu3AUTMQj3Awyi35/tyhY6J8Dqm1Quvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dFE/SjMK5DdCxBZCvuGLlv0b/HQpP6dAAF7vDm44b2ocm+hW2O6yGb0qm5RPZMhRM/RwTkAxUrjyxEIchuQoZkvWqjNdSwyxUT+qPW3jKBSIdGS2ux/Q4TrtdLP2KDwS5U22gOaSvm2P70uNcgbP8o1OQStcC1WMbFuQI2lgouA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=HFFGtcTA; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-88a32bf0248so28338076d6.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Jan 2026 12:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1767904725; x=1768509525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nggVLtJRnFU0QDlUT0CWimedJUol/+KzTaLPJoqAtUY=;
        b=HFFGtcTApntHosngjgK334Z8upT+hEJe1YlSIUt7m+8s9IFnGpbISwACJYKGBM72qk
         nEB4sC1ThkYKzI724WdX1+NjcZFyzKKL5c+iITmvogIVkZz8Do4AACEMIorusnwlLyzR
         2Rhu0gDdyovYpb8+yqk0tVRTZppuJahTXfU3TAoTPS7/N3w7cahCJNocg73aFGtAASD9
         mzneFBdhddRVeZFQ6Cgy4IcfAz0WR/SBKwuHcByMwfpCOHOp18iKbEXUuKH4h5r475o2
         HD2lPSJY/heQNxrXS4Acwf7bvAqw1IDz2hcczyGJf9+lVP6TLA1JmKTmpRar5nCeSj47
         b01Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767904725; x=1768509525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nggVLtJRnFU0QDlUT0CWimedJUol/+KzTaLPJoqAtUY=;
        b=PPkpb8zb6LDZUhc7+VLspZKxHyhJHsvHAxTwINDl6QNbH2QHjsEYGKYL3O/9cy5AVQ
         m92G+WmGG2V/pIrcHujbge6htN8hi9rlB75MARzD0jtIz4Eh0SlzhLfwKwI8QhPT1/dr
         nos/0CkGx3fxxSZk/a8ddekXyvuUwCu/ENuXfdndol7N0+qu3Ln3ikak1D4NX61JGZoE
         +Y4HvPIF2ocdvdoSkb7S6Jq6ko0HTS/D+FtAnsSpd4pf3Y3a7QAEDqP7IhnGy4ACQsc5
         TPf3xIf8aYrs48Ynd8hSFCaNslL+ztM1hRmfbd40M8U28Nyo1PTT08/VThB2nTjLjPsA
         ekUg==
X-Forwarded-Encrypted: i=1; AJvYcCVAfox4m00xK8G2tyJ3c9pDrZCDFfHCG2mCXo9+fylUjD6bTOrYjjm5TqiivpIrz8FzeCHPwwu0Eg/zCc1Y@vger.kernel.org
X-Gm-Message-State: AOJu0YzNTmDczDyrCBpjbSICWj3+586ds9am239mSqjknpLvT0RZpCER
	iIhZsMlVS2SLit/5woctgzmr4Q4UAS7FqdIInerDugUDxsvgsZMcECDp2RWsWsW3NbI=
X-Gm-Gg: AY/fxX5jAUN4qJ+2iq7m4xkPfaz+Cj8Mik6Nw0JSFl3wrXnkzefrR+V724dO+z5nn06
	UYtfHu3v1GD8XBgf+IPmXiW0jKpkZxcQXKpfQrmD7rH0Ky8sblGZqnAxIxN0R8TaCiFjhLGB6sr
	xX/pv7upduaj++NPQwc51AykpQOyXH1Z7RCOwh9f2Il4s9orGd/UcScc3ndBaIlNoMi1EWeZDI+
	3Yy1opCb0ePVPWthuwBllODKGjZLyFaP6B6XUpPaXqn+CvqWmM4qbwBgjHmxOJcuT8K/hAmqF31
	Y5fRsZoMYVVyWKgSQPnPeT1xGfIlT5SaNxvZWnMzf8+88TITXTY17EN9oRgX6/aa/uA1veNQ5LW
	wMgJM+l3VmYWBUZ7jgb3E+CkXxw1ABfQpefIY0yxYNHZO10RS9jaWnPHugr+6Tt3YF+c7iASTGD
	1AWYGQFYCTqPl07N6WJ1+hr3APEvaKJMsHu7jyzbJ+T5Ps59TpGavPLLBMSvs2zyspbidfzHjAA
	+k=
X-Google-Smtp-Source: AGHT+IGGkUof/CU2/WL6ia65lx/hKwi6wIF+fNWN77FX8bbJUBtv8zQ3F0zWY/9RAxC3ckJGR4/xjQ==
X-Received: by 2002:a05:6214:e4f:b0:88a:52a1:2576 with SMTP id 6a1803df08f44-8908418394fmr114080716d6.1.1767904725150;
        Thu, 08 Jan 2026 12:38:45 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890770e472csm60483886d6.23.2026.01.08.12.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 12:38:44 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-cxl@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	corbet@lwn.net,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	akpm@linux-foundation.org,
	vbabka@suse.cz,
	surenb@google.com,
	mhocko@suse.com,
	jackmanb@google.com,
	ziy@nvidia.com,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	rppt@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	rientjes@google.com,
	shakeel.butt@linux.dev,
	chrisl@kernel.org,
	kasong@tencent.com,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	bhe@redhat.com,
	baohua@kernel.org,
	yosry.ahmed@linux.dev,
	chengming.zhou@linux.dev,
	roman.gushchin@linux.dev,
	muchun.song@linux.dev,
	osalvador@suse.de,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	cl@gentwo.org,
	harry.yoo@oracle.com,
	zhengqi.arch@bytedance.com
Subject: [RFC PATCH v3 2/8] mm: constify oom_control, scan_control, and alloc_context nodemask
Date: Thu,  8 Jan 2026 15:37:49 -0500
Message-ID: <20260108203755.1163107-3-gourry@gourry.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108203755.1163107-1-gourry@gourry.net>
References: <20260108203755.1163107-1-gourry@gourry.net>
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
index 631577384677..fe4f29624117 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -81,7 +81,7 @@ extern bool cpuset_cpu_is_isolated(int cpu);
 extern nodemask_t cpuset_mems_allowed(struct task_struct *p);
 #define cpuset_current_mems_allowed (current->mems_allowed)
 void cpuset_init_current_mems_allowed(void);
-int cpuset_nodemask_valid_mems_allowed(nodemask_t *nodemask);
+int cpuset_nodemask_valid_mems_allowed(const nodemask_t *nodemask);
 
 extern bool cpuset_current_node_allowed(int node, gfp_t gfp_mask);
 
@@ -226,7 +226,7 @@ static inline nodemask_t cpuset_mems_allowed(struct task_struct *p)
 #define cpuset_current_mems_allowed (node_states[N_MEMORY])
 static inline void cpuset_init_current_mems_allowed(void) {}
 
-static inline int cpuset_nodemask_valid_mems_allowed(nodemask_t *nodemask)
+static inline int cpuset_nodemask_valid_mems_allowed(const nodemask_t *nodemask)
 {
 	return 1;
 }
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 45dfb2f2883c..dd4f5d49f638 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3572,7 +3572,7 @@ extern int __meminit early_pfn_to_nid(unsigned long pfn);
 extern void mem_init(void);
 extern void __init mmap_init(void);
 
-extern void __show_mem(unsigned int flags, nodemask_t *nodemask, int max_zone_idx);
+extern void __show_mem(unsigned int flags, const nodemask_t *nodemask, int max_zone_idx);
 static inline void show_mem(void)
 {
 	__show_mem(0, NULL, MAX_NR_ZONES - 1);
@@ -3582,7 +3582,7 @@ extern void si_meminfo(struct sysinfo * val);
 extern void si_meminfo_node(struct sysinfo *val, int nid);
 
 extern __printf(3, 4)
-void warn_alloc(gfp_t gfp_mask, nodemask_t *nodemask, const char *fmt, ...);
+void warn_alloc(gfp_t gfp_mask, const nodemask_t *nodemask, const char *fmt, ...);
 
 extern void setup_per_cpu_pageset(void);
 
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 6a7db0fee54a..7f94d67ffac4 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1721,7 +1721,7 @@ static inline int zonelist_node_idx(const struct zoneref *zoneref)
 
 struct zoneref *__next_zones_zonelist(struct zoneref *z,
 					enum zone_type highest_zoneidx,
-					nodemask_t *nodes);
+					const nodemask_t *nodes);
 
 /**
  * next_zones_zonelist - Returns the next zone at or below highest_zoneidx within the allowed nodemask using a cursor within a zonelist as a starting point
@@ -1740,7 +1740,7 @@ struct zoneref *__next_zones_zonelist(struct zoneref *z,
  */
 static __always_inline struct zoneref *next_zones_zonelist(struct zoneref *z,
 					enum zone_type highest_zoneidx,
-					nodemask_t *nodes)
+					const nodemask_t *nodes)
 {
 	if (likely(!nodes && zonelist_zone_idx(z) <= highest_zoneidx))
 		return z;
@@ -1766,7 +1766,7 @@ static __always_inline struct zoneref *next_zones_zonelist(struct zoneref *z,
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
index 62fc7499b408..1569f3f4773b 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -370,7 +370,7 @@ extern void swap_setup(void);
 /* linux/mm/vmscan.c */
 extern unsigned long zone_reclaimable_pages(struct zone *zone);
 extern unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
-					gfp_t gfp_mask, nodemask_t *mask);
+					gfp_t gfp_mask, const nodemask_t *mask);
 
 #define MEMCG_RECLAIM_MAY_SWAP (1 << 1)
 #define MEMCG_RECLAIM_PROACTIVE (1 << 2)
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 289fb1a72550..a3ade9d5968b 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -4326,7 +4326,7 @@ nodemask_t cpuset_mems_allowed(struct task_struct *tsk)
  *
  * Are any of the nodes in the nodemask allowed in current->mems_allowed?
  */
-int cpuset_nodemask_valid_mems_allowed(nodemask_t *nodemask)
+int cpuset_nodemask_valid_mems_allowed(const nodemask_t *nodemask)
 {
 	return nodes_intersects(*nodemask, current->mems_allowed);
 }
diff --git a/mm/internal.h b/mm/internal.h
index 6dc83c243120..50d32055b544 100644
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
index ecb2646b57ba..bb89d81aa68c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3988,7 +3988,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 	return NULL;
 }
 
-static void warn_alloc_show_mem(gfp_t gfp_mask, nodemask_t *nodemask)
+static void warn_alloc_show_mem(gfp_t gfp_mask, const nodemask_t *nodemask)
 {
 	unsigned int filter = SHOW_MEM_FILTER_NODES;
 
@@ -4008,7 +4008,7 @@ static void warn_alloc_show_mem(gfp_t gfp_mask, nodemask_t *nodemask)
 	mem_cgroup_show_protected_memory(NULL);
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
index 7c962ee7819f..23f68e754738 100644
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
@@ -6502,7 +6502,7 @@ static bool allow_direct_reclaim(pg_data_t *pgdat)
  * happens, the page allocator should not consider triggering the OOM killer.
  */
 static bool throttle_direct_reclaim(gfp_t gfp_mask, struct zonelist *zonelist,
-					nodemask_t *nodemask)
+				    const nodemask_t *nodemask)
 {
 	struct zoneref *z;
 	struct zone *zone;
@@ -6582,7 +6582,7 @@ static bool throttle_direct_reclaim(gfp_t gfp_mask, struct zonelist *zonelist,
 }
 
 unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
-				gfp_t gfp_mask, nodemask_t *nodemask)
+				gfp_t gfp_mask, const nodemask_t *nodemask)
 {
 	unsigned long nr_reclaimed;
 	struct scan_control sc = {
-- 
2.52.0


