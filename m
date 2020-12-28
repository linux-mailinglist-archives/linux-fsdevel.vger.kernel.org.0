Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFEAC2E68F2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Dec 2020 17:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634517AbgL1Qn3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Dec 2020 11:43:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2634520AbgL1QnX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Dec 2020 11:43:23 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1875C0617BE
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Dec 2020 08:42:38 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id s15so5859158plr.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Dec 2020 08:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GBe/b9s8qqbpbQdwEPlaqqS3TNcD0u7ThCgRkdEr4Jw=;
        b=v/NoCGdgXah6y6zVWO1fsQndVgPIjrJ2rE13jiKiVgAfL2vJoXnAiOybkczPpZ/srP
         skVWcIyvWXhe5dQ/5m9jLz0daq/xw1o6x3jqAlvWC8ulyaVFR5CbfWY8eA/YgoMVzSCa
         JqtsZnuZQkfih0UwIj3cN0hkol74gQzcCeKr92Z91S6RCMEu9sHpsNmZRWV4YfUlIDp6
         Rdv3S2bC5BvYY3H97cjp4Kl7+Kpa8rBrtguAyaU2SkQW5Cb9ex+b85qBJhG/PrVp8h8x
         5n0UXarClyuYSiF5y3krUP9iDfHPTFa4+F4OXPnnxFglNZ0LYFUEXHlY3U63/b1TEcqj
         p7Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GBe/b9s8qqbpbQdwEPlaqqS3TNcD0u7ThCgRkdEr4Jw=;
        b=aOxY51YC7GdNbho7wrat+A94ahZQnHSsZKh8zmmoXZvqKxvrJmJiqnQ3vX23tWT8ZS
         EBBXreJFbevtyUiGR0z+WCDkVRuFGf5QVioB1g0cmgQKHM/hPL3dbpK8IOH/2r79pR5Q
         fBBMQNElAtJ4LoUaDSH+YRQKeqbvn4EOhpqIoSkyh6/GpSyhu1PM1x4Hubfo1xyFSKwJ
         78yeGzMQpCP3x6hMuWIEwStwzzufC0EYwAGKaRjWvhBb/CjQgjOysKzI3ygggOecoZie
         uYRLU8LuEIjN+gMJzUJ8LsGR3j/nxLsinuwNLFglHoqxxTvVrITsHygwSUMtSr5KhdRU
         gp9g==
X-Gm-Message-State: AOAM5335qeRd/uyp1gVAV57emEblqg0LIMVE8B9zCnWM+IDfPFA15KQQ
        Cls0mgkDGEJKnL6cgGqWYQ5jZQ==
X-Google-Smtp-Source: ABdhPJxGCLcCGaBEmbcaJmvGtBP69UmZRyhbqjAIFfaVBg8jiTijtNZ9RZkGPdnXmFLkWZEtRM+DtQ==
X-Received: by 2002:a17:902:8487:b029:dc:20bc:2812 with SMTP id c7-20020a1709028487b02900dc20bc2812mr8913396plo.66.1609173757811;
        Mon, 28 Dec 2020 08:42:37 -0800 (PST)
Received: from localhost.bytedance.net ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id r68sm36686306pfr.113.2020.12.28.08.42.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Dec 2020 08:42:37 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, adobriyan@gmail.com,
        akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, hughd@google.com, shakeelb@google.com,
        guro@fb.com, samitolvanen@google.com, feng.tang@intel.com,
        neilb@suse.de, iamjoonsoo.kim@lge.com, rdunlap@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v6 7/7] mm: memcontrol: make the slab calculation consistent
Date:   Tue, 29 Dec 2020 00:41:10 +0800
Message-Id: <20201228164110.2838-8-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201228164110.2838-1-songmuchun@bytedance.com>
References: <20201228164110.2838-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Although the ratio of the slab is one, we also should read the ratio
from the related memory_stats instead of hard-coding. And the local
variable of size is already the value of slab_unreclaimable. So we
do not need to read again.

To do this we need some code like below:

if (unlikely(memory_stats[i].idx == NR_SLAB_UNRECLAIMABLE_B)) {
-	size = memcg_page_state(memcg, NR_SLAB_RECLAIMABLE_B) +
-	       memcg_page_state(memcg, NR_SLAB_UNRECLAIMABLE_B);
+       VM_BUG_ON(i < 1);
+       VM_BUG_ON(memory_stats[i - 1].idx != NR_SLAB_RECLAIMABLE_B);
+	size += memcg_page_state(memcg, memory_stats[i - 1].idx) *
+		memory_stats[i - 1].ratio;

It requires a series of VM_BUG_ONs or comments to ensure these two
items are actually adjacent and in the right order. So it would
probably be easier to implement this using a wrapper that has a big
switch() for unit conversion.

More details about this discussion can refer to:

    https://lore.kernel.org/patchwork/patch/1348611/

This would fix the ratio inconsistency and get rid of the order
guarantee.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/memcontrol.c | 105 +++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 66 insertions(+), 39 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index a40797a27f87..eec44918d373 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1511,49 +1511,71 @@ static bool mem_cgroup_wait_acct_move(struct mem_cgroup *memcg)
 
 struct memory_stat {
 	const char *name;
-	unsigned int ratio;
 	unsigned int idx;
 };
 
 static const struct memory_stat memory_stats[] = {
-	{ "anon", PAGE_SIZE, NR_ANON_MAPPED },
-	{ "file", PAGE_SIZE, NR_FILE_PAGES },
-	{ "kernel_stack", 1024, NR_KERNEL_STACK_KB },
-	{ "pagetables", PAGE_SIZE, NR_PAGETABLE },
-	{ "percpu", 1, MEMCG_PERCPU_B },
-	{ "sock", PAGE_SIZE, MEMCG_SOCK },
-	{ "shmem", PAGE_SIZE, NR_SHMEM },
-	{ "file_mapped", PAGE_SIZE, NR_FILE_MAPPED },
-	{ "file_dirty", PAGE_SIZE, NR_FILE_DIRTY },
-	{ "file_writeback", PAGE_SIZE, NR_WRITEBACK },
+	{ "anon",			NR_ANON_MAPPED			},
+	{ "file",			NR_FILE_PAGES			},
+	{ "kernel_stack",		NR_KERNEL_STACK_KB		},
+	{ "pagetables",			NR_PAGETABLE			},
+	{ "percpu",			MEMCG_PERCPU_B			},
+	{ "sock",			MEMCG_SOCK			},
+	{ "shmem",			NR_SHMEM			},
+	{ "file_mapped",		NR_FILE_MAPPED			},
+	{ "file_dirty",			NR_FILE_DIRTY			},
+	{ "file_writeback",		NR_WRITEBACK			},
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	{ "anon_thp", PAGE_SIZE, NR_ANON_THPS },
-	{ "file_thp", PAGE_SIZE, NR_FILE_THPS },
-	{ "shmem_thp", PAGE_SIZE, NR_SHMEM_THPS },
+	{ "anon_thp",			NR_ANON_THPS			},
+	{ "file_thp",			NR_FILE_THPS			},
+	{ "shmem_thp",			NR_SHMEM_THPS			},
 #endif
-	{ "inactive_anon", PAGE_SIZE, NR_INACTIVE_ANON },
-	{ "active_anon", PAGE_SIZE, NR_ACTIVE_ANON },
-	{ "inactive_file", PAGE_SIZE, NR_INACTIVE_FILE },
-	{ "active_file", PAGE_SIZE, NR_ACTIVE_FILE },
-	{ "unevictable", PAGE_SIZE, NR_UNEVICTABLE },
-
-	/*
-	 * Note: The slab_reclaimable and slab_unreclaimable must be
-	 * together and slab_reclaimable must be in front.
-	 */
-	{ "slab_reclaimable", 1, NR_SLAB_RECLAIMABLE_B },
-	{ "slab_unreclaimable", 1, NR_SLAB_UNRECLAIMABLE_B },
+	{ "inactive_anon",		NR_INACTIVE_ANON		},
+	{ "active_anon",		NR_ACTIVE_ANON			},
+	{ "inactive_file",		NR_INACTIVE_FILE		},
+	{ "active_file",		NR_ACTIVE_FILE			},
+	{ "unevictable",		NR_UNEVICTABLE			},
+	{ "slab_reclaimable",		NR_SLAB_RECLAIMABLE_B		},
+	{ "slab_unreclaimable",		NR_SLAB_UNRECLAIMABLE_B		},
 
 	/* The memory events */
-	{ "workingset_refault_anon", 1, WORKINGSET_REFAULT_ANON },
-	{ "workingset_refault_file", 1, WORKINGSET_REFAULT_FILE },
-	{ "workingset_activate_anon", 1, WORKINGSET_ACTIVATE_ANON },
-	{ "workingset_activate_file", 1, WORKINGSET_ACTIVATE_FILE },
-	{ "workingset_restore_anon", 1, WORKINGSET_RESTORE_ANON },
-	{ "workingset_restore_file", 1, WORKINGSET_RESTORE_FILE },
-	{ "workingset_nodereclaim", 1, WORKINGSET_NODERECLAIM },
+	{ "workingset_refault_anon",	WORKINGSET_REFAULT_ANON		},
+	{ "workingset_refault_file",	WORKINGSET_REFAULT_FILE		},
+	{ "workingset_activate_anon",	WORKINGSET_ACTIVATE_ANON	},
+	{ "workingset_activate_file",	WORKINGSET_ACTIVATE_FILE	},
+	{ "workingset_restore_anon",	WORKINGSET_RESTORE_ANON		},
+	{ "workingset_restore_file",	WORKINGSET_RESTORE_FILE		},
+	{ "workingset_nodereclaim",	WORKINGSET_NODERECLAIM		},
 };
 
+/* Translate stat items to the correct unit for memory.stat output */
+static int memcg_page_state_unit(int item)
+{
+	switch (item) {
+	case MEMCG_PERCPU_B:
+	case NR_SLAB_RECLAIMABLE_B:
+	case NR_SLAB_UNRECLAIMABLE_B:
+	case WORKINGSET_REFAULT_ANON:
+	case WORKINGSET_REFAULT_FILE:
+	case WORKINGSET_ACTIVATE_ANON:
+	case WORKINGSET_ACTIVATE_FILE:
+	case WORKINGSET_RESTORE_ANON:
+	case WORKINGSET_RESTORE_FILE:
+	case WORKINGSET_NODERECLAIM:
+		return 1;
+	case NR_KERNEL_STACK_KB:
+		return SZ_1K;
+	default:
+		return PAGE_SIZE;
+	}
+}
+
+static inline unsigned long memcg_page_state_output(struct mem_cgroup *memcg,
+						    int item)
+{
+	return memcg_page_state(memcg, item) * memcg_page_state_unit(item);
+}
+
 static char *memory_stat_format(struct mem_cgroup *memcg)
 {
 	struct seq_buf s;
@@ -1577,13 +1599,12 @@ static char *memory_stat_format(struct mem_cgroup *memcg)
 	for (i = 0; i < ARRAY_SIZE(memory_stats); i++) {
 		u64 size;
 
-		size = memcg_page_state(memcg, memory_stats[i].idx);
-		size *= memory_stats[i].ratio;
+		size = memcg_page_state_output(memcg, memory_stats[i].idx);
 		seq_buf_printf(&s, "%s %llu\n", memory_stats[i].name, size);
 
 		if (unlikely(memory_stats[i].idx == NR_SLAB_UNRECLAIMABLE_B)) {
-			size = memcg_page_state(memcg, NR_SLAB_RECLAIMABLE_B) +
-			       memcg_page_state(memcg, NR_SLAB_UNRECLAIMABLE_B);
+			size += memcg_page_state_output(memcg,
+							NR_SLAB_RECLAIMABLE_B);
 			seq_buf_printf(&s, "slab %llu\n", size);
 		}
 	}
@@ -6377,6 +6398,12 @@ static int memory_stat_show(struct seq_file *m, void *v)
 }
 
 #ifdef CONFIG_NUMA
+static inline unsigned long lruvec_page_state_output(struct lruvec *lruvec,
+						     int item)
+{
+	return lruvec_page_state(lruvec, item) * memcg_page_state_unit(item);
+}
+
 static int memory_numa_stat_show(struct seq_file *m, void *v)
 {
 	int i;
@@ -6394,8 +6421,8 @@ static int memory_numa_stat_show(struct seq_file *m, void *v)
 			struct lruvec *lruvec;
 
 			lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(nid));
-			size = lruvec_page_state(lruvec, memory_stats[i].idx);
-			size *= memory_stats[i].ratio;
+			size = lruvec_page_state_output(lruvec,
+							memory_stats[i].idx);
 			seq_printf(m, " N%d=%llu", nid, size);
 		}
 		seq_putc(m, '\n');
-- 
2.11.0

