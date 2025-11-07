Return-Path: <linux-fsdevel+bounces-67508-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7885BC41E2A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 23:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2CCCB4EAD22
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 22:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E037E3164B8;
	Fri,  7 Nov 2025 22:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="OTh2wwn1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730F4315D26
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Nov 2025 22:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762555816; cv=none; b=gu29yANHyous9lZ9xacfh6kezAVV4TLQHXcNu1BD65SyxWap44PHEiRLoD82zKmJV/w4SS7WU7RpQ8PtrPeWJrwe7UFpimXlELb4T8dOIweJNMnFxogKam+ulVzdSjBr6T/AsSTrVcEipkl4SdOSS4lgUIqzk5LuhB/s4SpI0H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762555816; c=relaxed/simple;
	bh=t1PWd9W4F3MKCeCrtb+bV5TXG4Q3iLBygfAXlk1bL90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sNtAVqPK0Z1hWmbpLIIMdKOQQT/yDbNwlnSHfwisd1ox/n3zFJ1nGGnN7XYSPAfWpK2408FY1ZVY8yleS5XKO+R9T9DiG/GTEyrPMl9arWWGy1byu4v1I49jWumD/rIQvFRqTCIwSpwj0nA94mTixZ8q9AnrGBR5uh6KECYhkvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=OTh2wwn1; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-88054872394so18532386d6.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Nov 2025 14:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1762555812; x=1763160612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R64FiI16+WP3yeCxBiatrBL599beZnZfURxXJrYPjuA=;
        b=OTh2wwn1I/0SNSvdVBqTHB/Nlje+NO948PsSdWEn+zdjCupnVffmXKYIY6hp+TXz54
         sZSbvULt6INIZ6csadKvFEfoONa7nBFUdgIwVL2lxiKFcA2lWlzk2qxGpWpH4nbMvxYy
         XVn1EmepFfBqIX5IlaMfANeOg2cVRARiAWszZJ6tj+kQICVWRi15ycVEc85GW+HYdLaE
         ZWaTeUzaGEnerultDa6f9RXzS1N4aHU5TTMfXR3ARwnf1WcnELFRm2tdN/4sPBRglGVP
         XB2ef4xPqkDxTPP7vkVBMmHjz5tIZnMOk5emrkhdvObKN28cfGQpbgHYcgq2PVdGZEBW
         3j4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762555812; x=1763160612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R64FiI16+WP3yeCxBiatrBL599beZnZfURxXJrYPjuA=;
        b=ktglTO994dIjwGqDj8e10/Tzh+pqAqA8NKgBDdR7wC5D9u+AS+tNHpfNqAzicl22U2
         o5HoEs/9IsJWTv3cH8n5W9Pdv0hYW503p7FgfyTx1XrKiWvzylho84OxQj3RgEotT69K
         meVyCdCzw+cLvl9WYv5KSSpLUHuq+qVWKBbHHiQLldTAHw2ABffhmdreXnjWgjba3xGT
         4aVCsyguAxRY4JWh9nLS0mCrSlIMNhPLRcXj/Fu5uOCXWaA8uZY6SN6HkJvQietw2NxG
         DyEAa+Dg9YP+2PapoCCi5SqpngtjjdnBGwehws/iG0L1S9Vq9YK+zJKEBnPSN9Imz0ND
         zW0w==
X-Forwarded-Encrypted: i=1; AJvYcCV2VSmOyY5H/GOL0DhmB1adulFT6uO6GCikPerc3KnpswQn30fEuALW4JajM4pCAdrzcdZC46qBCWR+gIWh@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr9dv8LrcPSvRviGcJ/FVQe3BhBcTPoXPYQ3LXDo3yXhXnAD1g
	jEW6WjCzn3EgDAVNP5JDYFZNp0ZwssBHPdXJnSzdaomU+Yxexqgvju3PUkGi/6G9WuE=
X-Gm-Gg: ASbGncvom3OAZbHYnax0+QK2grkjI6npBDsJjlBvpmgWMIoGccqDkfrZWnnqwLp4DpR
	gIWlI/lsNiwklg/CPkDKmvideGgnildjf6t9bwmjJsXbUSkJgWBtK3MnG1cxabvwKjryNU901Q0
	e4dLxM6O/ThRJfZOunv4aTptRCl23DYfNrjGsswXQlGw4xe5bHkRq+DjNGKdROrqEcbOxif9P27
	NLc7+W4uZ1EqxDg2m9tBz/pFsneFoWwTfkUOLTv1mtNhpfjVr23s8BlXrxWndFa28N5tJCkh4aQ
	s3AwxuNaMDJITyR465tI0W+ivrmogJBjSpIzValyzOHDC4VJIFJqsJTo9i8b7RzromNjx9eHaBi
	oNGo63CfcUd/i7wEWztm5d2VkrqWfklH62piX28PkLzkp+sntfLmsjxx4QF43u7Exb7t/h6wmFA
	effiHlNWWZ19lkfA79vlVpjzLX8RK7xs2cI+IqnZIq8seN6x0juvh8yza8ZtcpswtunIAaQRzmB
	9El4AtMCo/kBQ==
X-Google-Smtp-Source: AGHT+IG4CM60aE94hoVAm6WlLLrQN78GzB6+sZgYXWXWNkYKc0tId9Jl3T1QS1663TlSzExe8IcNow==
X-Received: by 2002:a05:6214:20eb:b0:882:36d3:2c60 with SMTP id 6a1803df08f44-88238616f43mr9660116d6.19.1762555812276;
        Fri, 07 Nov 2025 14:50:12 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eda57ad8e6sm3293421cf.27.2025.11.07.14.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 14:50:11 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-cxl@vger.kernel.org,
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
Subject: [RFC PATCH 3/9] mm: default slub, oom_kill, compaction, and page_alloc to sysram
Date: Fri,  7 Nov 2025 17:49:48 -0500
Message-ID: <20251107224956.477056-4-gourry@gourry.net>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251107224956.477056-1-gourry@gourry.net>
References: <20251107224956.477056-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Constrain core users of nodemasks to the default_sysram_nodemask,
which is guaranteed to either be NULL or contain the set of nodes
with sysram memory blocks.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 mm/oom_kill.c   |  5 ++++-
 mm/page_alloc.c | 12 ++++++++----
 mm/slub.c       |  4 +++-
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index c145b0feecc1..e0b6137835b2 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -34,6 +34,7 @@
 #include <linux/export.h>
 #include <linux/notifier.h>
 #include <linux/memcontrol.h>
+#include <linux/memory-tiers.h>
 #include <linux/mempolicy.h>
 #include <linux/security.h>
 #include <linux/ptrace.h>
@@ -1118,6 +1119,8 @@ EXPORT_SYMBOL_GPL(unregister_oom_notifier);
 bool out_of_memory(struct oom_control *oc)
 {
 	unsigned long freed = 0;
+	if (!oc->nodemask)
+		oc->nodemask = default_sysram_nodes;
 
 	if (oom_killer_disabled)
 		return false;
@@ -1154,7 +1157,7 @@ bool out_of_memory(struct oom_control *oc)
 	 */
 	oc->constraint = constrained_alloc(oc);
 	if (oc->constraint != CONSTRAINT_MEMORY_POLICY)
-		oc->nodemask = NULL;
+		oc->nodemask = default_sysram_nodes;
 	check_panic_on_oom(oc);
 
 	if (!is_memcg_oom(oc) && sysctl_oom_kill_allocating_task &&
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index fd5401fb5e00..18213eacf974 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -34,6 +34,7 @@
 #include <linux/cpuset.h>
 #include <linux/pagevec.h>
 #include <linux/memory_hotplug.h>
+#include <linux/memory-tiers.h>
 #include <linux/nodemask.h>
 #include <linux/vmstat.h>
 #include <linux/fault-inject.h>
@@ -4610,7 +4611,7 @@ check_retry_cpuset(int cpuset_mems_cookie, struct alloc_context *ac)
 	 */
 	if (cpusets_enabled() && ac->nodemask &&
 			!cpuset_nodemask_valid_mems_allowed(ac->nodemask)) {
-		ac->nodemask = NULL;
+		ac->nodemask = default_sysram_nodes;
 		return true;
 	}
 
@@ -4794,7 +4795,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	 * user oriented.
 	 */
 	if (!(alloc_flags & ALLOC_CPUSET) || reserve_flags) {
-		ac->nodemask = NULL;
+		ac->nodemask = default_sysram_nodes;
 		ac->preferred_zoneref = first_zones_zonelist(ac->zonelist,
 					ac->highest_zoneidx, ac->nodemask);
 	}
@@ -4946,7 +4947,8 @@ static inline bool prepare_alloc_pages(gfp_t gfp_mask, unsigned int order,
 			ac->nodemask = &cpuset_current_mems_allowed;
 		else
 			*alloc_flags |= ALLOC_CPUSET;
-	}
+	} else if (!ac->nodemask) /* sysram_nodes may be NULL during __init */
+		ac->nodemask = default_sysram_nodes;
 
 	might_alloc(gfp_mask);
 
@@ -5190,8 +5192,10 @@ struct page *__alloc_frozen_pages_noprof(gfp_t gfp, unsigned int order,
 	/*
 	 * Restore the original nodemask if it was potentially replaced with
 	 * &cpuset_current_mems_allowed to optimize the fast-path attempt.
+	 *
+	 * If not set, default to sysram nodes.
 	 */
-	ac.nodemask = nodemask;
+	ac.nodemask = nodemask ? nodemask : default_sysram_nodes;
 
 	page = __alloc_pages_slowpath(alloc_gfp, order, &ac);
 
diff --git a/mm/slub.c b/mm/slub.c
index d4367f25b20d..b8358a961c4c 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -28,6 +28,7 @@
 #include <linux/cpu.h>
 #include <linux/cpuset.h>
 #include <linux/mempolicy.h>
+#include <linux/memory-tiers.h>
 #include <linux/ctype.h>
 #include <linux/stackdepot.h>
 #include <linux/debugobjects.h>
@@ -3570,7 +3571,8 @@ static struct slab *get_any_partial(struct kmem_cache *s,
 	do {
 		cpuset_mems_cookie = read_mems_allowed_begin();
 		zonelist = node_zonelist(mempolicy_slab_node(), pc->flags);
-		for_each_zone_zonelist(zone, z, zonelist, highest_zoneidx) {
+		for_each_zone_zonelist_nodemask(zone, z, zonelist, highest_zoneidx,
+						default_sysram_nodes) {
 			struct kmem_cache_node *n;
 
 			n = get_node(s, zone_to_nid(zone));
-- 
2.51.1


