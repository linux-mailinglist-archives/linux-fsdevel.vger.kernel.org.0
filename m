Return-Path: <linux-fsdevel+bounces-72934-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE37D06235
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 21:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9928C30692A8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 20:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D1E330B20;
	Thu,  8 Jan 2026 20:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="puL5YAtZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E06330D3B
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jan 2026 20:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767904734; cv=none; b=uuQ7mRquUNnBuIo8fKmCG45Y+sElxMu3WHxjo3TyFM+Iui1oBtN/0w3XNzaH5HgcOvMtXDZ7DjuE2ZfZd8SMzhxDDNnO+FcFfiLr91lm+UdRwH60xM6oLy8KXCkBwffawH9/FU63RccZCLNe0SuU41PemQbCBcAjY/nn2TuE8FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767904734; c=relaxed/simple;
	bh=NC/62yOtZDEWDFQWBLBYdje42g/fgNjMQjSNsPds1BQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hwVx3VT8foBM9OnbeHoZ8S5gGIddJxSPiDVV4BYqSL3Dr4lwIp87taWqbJ/Nns6KLHi4p6ASbrnnHpMvsETp1stcV9Pdji2bf+O9cUHEKbuCC5E37efwbDPepv8Z3cBD37fftJ92F4OY/g0+P4uSP+dIu1CvMd87beZk0E6kEik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=puL5YAtZ; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-88fca7bce90so37203416d6.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Jan 2026 12:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1767904730; x=1768509530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HzEtunsMdBn4IQoHvFlHCM71GQRUPpw4LtA2vMizqz0=;
        b=puL5YAtZgxEuvAG04IYeir0DuN8twNxXu56/AVFQJ6lluJwVZBG+zhIpiua1FRe3OL
         0OtoJTrWYGJHAs1L0yke7BMnbAVPyMeXpxS7tICNUqOpzln7BtRoF7dMdQ6pdMpy2UwT
         ko+louZGFVbgcQQTFsdmO4RSDTv5FgGzF8c6A+aixQ1RJPhUZrcIJpRhddZDsFRPzBP8
         +he//p+vj8YeSB2Vog5DV8dVNGCmqPrRrPWoTDAXdnv/+VZI6SpIubKnGZOwi7sAqPJc
         MZrKNk3u/EsuybgdpJEYc5OuucQa8kxxS8bCtoMDAF9jo/XJjqR1HtgtDLkrmCX01SL5
         f0Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767904730; x=1768509530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HzEtunsMdBn4IQoHvFlHCM71GQRUPpw4LtA2vMizqz0=;
        b=mBqKYVo58geYqPPqVvYfn2t3oOWEx5qJfZt6KBbUjxEXQ+HegMe5b6K1BYqRKBGrig
         ul4+KD82EfBobJbuPLX09U86aKbF7mpKKbxngVwXNjSfz0wgMRvCZDNioLm7UWD7Uqql
         2EN9iK7B7Oa8hmxJlj4y9v1SvLgIWXpsJZgBWwc6jVaB+dGAQwkVGrjhJLFfVe7/r34B
         PWmbYKu3trioraZUwodn5iHfWjyxd8kYKUJZ6ImkHy5DGVXYnqnbsxQMpNgNE9MCZgEl
         76mtTozAGG1UQEypjPCU5FgM8y37l9W/7xudixuLtTyKvSgLPCJ6yz0vYCHJ0//yoftu
         HmKw==
X-Forwarded-Encrypted: i=1; AJvYcCU9Pa5fiCheBXDhRUXAmnjyjwYSSsylc4WqfjxBrEE1dlejOHhK9quGlQoi6hUw94pdjYQtG9hxdK71IXAG@vger.kernel.org
X-Gm-Message-State: AOJu0YzXo5+QWdLXU4HZvkrU27Gj/UIYT3LGXNmEdke3FXUyf0tTsuBP
	oZRLs0qpOAWA7nX4dTjwaM/PPA08bctYtI/2f3IxGN8md6TK901ZLhyuhNT5MMR/uU509aYJZVg
	q0yBp
X-Gm-Gg: AY/fxX4/DVo+nRHYQgbIW0uB7uikGx3yZhoT1YqYAMiGXxY01tG8VcTWPu1UG2J7X3y
	3ZEaedvTkTHO90QAL3lzTzsHP45KJezP8MjJ+IbKoj+/uIY9UDyPdkXO9GEgtYirYuAhyyRBjdC
	r5tGHkXgwJBGclPxpUsw8m6e1qPbMpbicQqCqjHCPvLdumhDWzDBjKY94BIF0TCsEDoQEobtIJj
	ifjB6ftA4g/r8jul3jjaQlz7RF56zH2yL9sfMyLgTzIlefK3AOPoJHX+mllWUqP7Vm8eUpWA9MB
	FGBDUqGQTgWmuigzfCHa8LMbmSQPMDUXRWQ8ceRw3+I17ufGmZueB2PaqHO9y+TDSTr5cUEDFB7
	2TMkldEdtfTQ/L1mfNJxX5PmaLBof555oaiKJ5rva7c7HrjUNajCtWmPFDU5SS04jWPdPUru320
	+37GAhOQo4rYP7nD2Hl9aHFA7jt3TVYX2X66gjeW7ulyFiWHn/z0xxyZeWUqavZ0QroGt0X+iUR
	uo=
X-Google-Smtp-Source: AGHT+IF3fWiGbPzGJ2jrA579ah6au0pY7RZhvW9wnxA0yziJvwGxMvsH3haaiag/Ap3aYN6F9CC0+g==
X-Received: by 2002:a05:6214:29c1:b0:890:19d1:532c with SMTP id 6a1803df08f44-890842311f3mr108761396d6.34.1767904730313;
        Thu, 08 Jan 2026 12:38:50 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890770e472csm60483886d6.23.2026.01.08.12.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 12:38:49 -0800 (PST)
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
Subject: [RFC PATCH v3 3/8] mm: restrict slub, compaction, and page_alloc to sysram
Date: Thu,  8 Jan 2026 15:37:50 -0500
Message-ID: <20260108203755.1163107-4-gourry@gourry.net>
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

Restrict page allocation and zone iteration to N_MEMORY nodes via
cpusets - or node_states[N_MEMORY] when cpusets is disabled.

__GFP_THISNODE allows N_PRIVATE nodes to be used explicitly (all
nodes become valid targets with __GFP_THISNODE).

This constrains core users of nodemasks to the node_states[N_MEMORY],
which is guaranteed to at least contain the set of nodes with sysram
memory blocks present at boot.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 include/linux/gfp.h |  6 ++++++
 mm/compaction.c     |  6 ++----
 mm/page_alloc.c     | 27 ++++++++++++++++-----------
 mm/slub.c           |  8 ++++++--
 4 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index b155929af5b1..0b6cdef7a232 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -321,6 +321,7 @@ struct folio *folio_alloc_mpol_noprof(gfp_t gfp, unsigned int order,
 		struct mempolicy *mpol, pgoff_t ilx, int nid);
 struct folio *vma_alloc_folio_noprof(gfp_t gfp, int order, struct vm_area_struct *vma,
 		unsigned long addr);
+bool numa_zone_allowed(int alloc_flags, struct zone *zone, gfp_t gfp_mask);
 #else
 static inline struct page *alloc_pages_noprof(gfp_t gfp_mask, unsigned int order)
 {
@@ -337,6 +338,11 @@ static inline struct folio *folio_alloc_mpol_noprof(gfp_t gfp, unsigned int orde
 }
 #define vma_alloc_folio_noprof(gfp, order, vma, addr)		\
 	folio_alloc_noprof(gfp, order)
+static inline bool numa_zone_allowed(int alloc_flags, struct zone *zone,
+				     gfp_t gfp_mask)
+{
+	return true;
+}
 #endif
 
 #define alloc_pages(...)			alloc_hooks(alloc_pages_noprof(__VA_ARGS__))
diff --git a/mm/compaction.c b/mm/compaction.c
index 1e8f8eca318c..63ef9803607f 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2829,10 +2829,8 @@ enum compact_result try_to_compact_pages(gfp_t gfp_mask, unsigned int order,
 					ac->highest_zoneidx, ac->nodemask) {
 		enum compact_result status;
 
-		if (cpusets_enabled() &&
-			(alloc_flags & ALLOC_CPUSET) &&
-			!__cpuset_zone_allowed(zone, gfp_mask))
-				continue;
+		if (!numa_zone_allowed(alloc_flags, zone, gfp_mask))
+			continue;
 
 		if (prio > MIN_COMPACT_PRIORITY
 					&& compaction_deferred(zone, order)) {
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index bb89d81aa68c..76b12cef7dfc 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3723,6 +3723,16 @@ static bool zone_allows_reclaim(struct zone *local_zone, struct zone *zone)
 	return node_distance(zone_to_nid(local_zone), zone_to_nid(zone)) <=
 				node_reclaim_distance;
 }
+bool numa_zone_allowed(int alloc_flags, struct zone *zone, gfp_t gfp_mask)
+{
+	/* If cpusets is being used, check mems_allowed or sysram_nodes */
+	if (cpusets_enabled() && (alloc_flags & ALLOC_CPUSET))
+		return cpuset_zone_allowed(zone, gfp_mask);
+
+	/* Otherwise only allow N_PRIVATE if __GFP_THISNODE is present */
+	return (gfp_mask & __GFP_THISNODE) ||
+		node_isset(zone_to_nid(zone), node_states[N_MEMORY]);
+}
 #else	/* CONFIG_NUMA */
 static bool zone_allows_reclaim(struct zone *local_zone, struct zone *zone)
 {
@@ -3814,10 +3824,9 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 		struct page *page;
 		unsigned long mark;
 
-		if (cpusets_enabled() &&
-			(alloc_flags & ALLOC_CPUSET) &&
-			!__cpuset_zone_allowed(zone, gfp_mask))
-				continue;
+		if (!numa_zone_allowed(alloc_flags, zone, gfp_mask))
+			continue;
+
 		/*
 		 * When allocating a page cache page for writing, we
 		 * want to get it from a node that is within its dirty
@@ -4618,10 +4627,8 @@ should_reclaim_retry(gfp_t gfp_mask, unsigned order,
 		unsigned long min_wmark = min_wmark_pages(zone);
 		bool wmark;
 
-		if (cpusets_enabled() &&
-			(alloc_flags & ALLOC_CPUSET) &&
-			!__cpuset_zone_allowed(zone, gfp_mask))
-				continue;
+		if (!numa_zone_allowed(alloc_flags, zone, gfp_mask))
+			continue;
 
 		available = reclaimable = zone_reclaimable_pages(zone);
 		available += zone_page_state_snapshot(zone, NR_FREE_PAGES);
@@ -5131,10 +5138,8 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 	for_next_zone_zonelist_nodemask(zone, z, ac.highest_zoneidx, ac.nodemask) {
 		unsigned long mark;
 
-		if (cpusets_enabled() && (alloc_flags & ALLOC_CPUSET) &&
-		    !__cpuset_zone_allowed(zone, gfp)) {
+		if (!numa_zone_allowed(alloc_flags, zone, gfp))
 			continue;
-		}
 
 		if (nr_online_nodes > 1 && zone != zonelist_zone(ac.preferred_zoneref) &&
 		    zone_to_nid(zone) != zonelist_node_idx(ac.preferred_zoneref)) {
diff --git a/mm/slub.c b/mm/slub.c
index 861592ac5425..adebbddc48f6 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3594,9 +3594,13 @@ static struct slab *get_any_partial(struct kmem_cache *s,
 			struct kmem_cache_node *n;
 
 			n = get_node(s, zone_to_nid(zone));
+			if (!n)
+				continue;
+
+			if (!numa_zone_allowed(ALLOC_CPUSET, zone, pc->flags))
+				continue;
 
-			if (n && cpuset_zone_allowed(zone, pc->flags) &&
-					n->nr_partial > s->min_partial) {
+			if (n->nr_partial > s->min_partial) {
 				slab = get_partial_node(s, n, pc);
 				if (slab) {
 					/*
-- 
2.52.0


