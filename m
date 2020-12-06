Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB7852D01E2
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Dec 2020 09:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbgLFIc7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Dec 2020 03:32:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbgLFIc6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Dec 2020 03:32:58 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1B1C08E862
        for <linux-fsdevel@vger.kernel.org>; Sun,  6 Dec 2020 00:31:57 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id b26so6929499pfi.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Dec 2020 00:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KwRaMRI+Sr6xQo3P1J4+HoZOIYaqIcm7QaRM3zeaHfM=;
        b=PRd0vzD/2Sfkm55VZCIWYO1SYAuzM56m2d7biop5RolLR2ogMnVEGiPJhLhDPDObMW
         NgaZSB9qXSMiN+B7CM1wNTUxoGLnKFhBTm1vJI+vyEnU8CnO4gDi1iY7f36ef/ReRVDo
         tYJfaEHnhV61ky7Ql+2u3VfR7XAaCOxb0ltJsDBQhaoZr8r98oJbn3uqUcoiyquGen98
         Y/U+6ZzOwPmy0jIW2h0lzdvQQn9+63sqBSV650Sq1ENh3kBNyvHct57dyqPXdGB50ruD
         OVVW9URrc5fGzg3xl32gVd1mPix6CgFbHzuJstcUCxP7fSs6IiomiZ+BKJ1qr0Acgvg9
         iTYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KwRaMRI+Sr6xQo3P1J4+HoZOIYaqIcm7QaRM3zeaHfM=;
        b=gYXl8xVRnKaabQq25CLGB/XpDseQ7cmfVFaqFkqn+Af+soDOjaOZ71jjtCRgEt+Kyw
         IcOpefnaVrm5+XMWqdBtSp1SYvmoXhH42ECgd5ClN1mWLM/M+VLFe3GaXr0+bhTxhMMl
         c2IVnT4WbdlAAwZjrGGCdsRAlpFORPKeBRZyi/8k5ozUnPG+Cl/42GbZTEFBmMjB/7wU
         DWxsstyH3uoqdM2+dHi9X8JLYV6Rsd4m/a2TKrCoH5/4P1M60Jp9FiIIbHtxNaKbz/4I
         yTDC0jUDMxhy+EYEjUmEtS4Rd/6M4tcSBOlPTd/SFmlhiBEbibQglbPpwbNU/uW9EIS6
         qt1g==
X-Gm-Message-State: AOAM5339hlfdwqDJijdId7+ZH2u9hpujTmNbsg/Dtl3z0b136jbVRx5/
        eIKvQGF8xMCmw/no0o2Q6Nq4ug==
X-Google-Smtp-Source: ABdhPJxdUC6z9YY2WIIE315X8TQ7+1z6todWeE3J1HIe1vWBnZ5aoN34w2v6gsnRsL4eio6wszhukw==
X-Received: by 2002:a62:1749:0:b029:19d:960c:1bb8 with SMTP id 70-20020a6217490000b029019d960c1bb8mr11645979pfx.63.1607243516981;
        Sun, 06 Dec 2020 00:31:56 -0800 (PST)
Received: from localhost.localdomain ([103.136.221.70])
        by smtp.gmail.com with ESMTPSA id c2sm10229107pfa.59.2020.12.06.00.31.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Dec 2020 00:31:56 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, adobriyan@gmail.com,
        akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, hughd@google.com, will@kernel.org,
        guro@fb.com, rppt@kernel.org, tglx@linutronix.de, esyr@redhat.com,
        peterx@redhat.com, krisman@collabora.com, surenb@google.com,
        avagin@openvz.org, elver@google.com, rdunlap@infradead.org,
        iamjoonsoo.kim@lge.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 11/12] mm: memcontrol: make the slab calculation consistent
Date:   Sun,  6 Dec 2020 16:29:47 +0800
Message-Id: <20201206082948.11812-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201206082948.11812-1-songmuchun@bytedance.com>
References: <20201206082948.11812-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Although the ratio of the slab is one, we also should read the ratio
from the related memory_stats instead of hard-coding. And the local
variable of size is already the value of slab_unreclaimable. So we
do not need to read again.

The unit of the vmstat counters are either pages or bytes now. So we
can drop the ratio in struct memory_stat. This can make the code clean
and simple. And get rid of the awkward mix of static and runtime
initialization of the memory_stats table.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/memcontrol.c | 108 ++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 70 insertions(+), 38 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 48d70c1ad301..49fbcf003bf5 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1493,48 +1493,71 @@ static bool mem_cgroup_wait_acct_move(struct mem_cgroup *memcg)
 
 struct memory_stat {
 	const char *name;
-	unsigned int ratio;
 	unsigned int idx;
 };
 
 static const struct memory_stat memory_stats[] = {
-	{ "anon", PAGE_SIZE, NR_ANON_MAPPED },
-	{ "file", PAGE_SIZE, NR_FILE_PAGES },
-	{ "kernel_stack", 1, NR_KERNEL_STACK_B },
-	{ "percpu", 1, MEMCG_PERCPU_B },
-	{ "sock", PAGE_SIZE, MEMCG_SOCK },
-	{ "shmem", PAGE_SIZE, NR_SHMEM },
-	{ "file_mapped", PAGE_SIZE, NR_FILE_MAPPED },
-	{ "file_dirty", PAGE_SIZE, NR_FILE_DIRTY },
-	{ "file_writeback", PAGE_SIZE, NR_WRITEBACK },
+	{ "anon",			NR_ANON_MAPPED			},
+	{ "file",			NR_FILE_PAGES			},
+	{ "kernel_stack",		NR_KERNEL_STACK_B		},
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
+	int unit;
+
+	switch (item) {
+	case WORKINGSET_REFAULT_ANON:
+	case WORKINGSET_REFAULT_FILE:
+	case WORKINGSET_ACTIVATE_ANON:
+	case WORKINGSET_ACTIVATE_FILE:
+	case WORKINGSET_RESTORE_ANON:
+	case WORKINGSET_RESTORE_FILE:
+	case WORKINGSET_NODERECLAIM:
+		unit = 1;
+		break;
+	default:
+		unit = memcg_stat_item_in_bytes(item) ? 1 : PAGE_SIZE;
+		break;
+	}
+
+	return unit;
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
@@ -1558,13 +1581,16 @@ static char *memory_stat_format(struct mem_cgroup *memcg)
 	for (i = 0; i < ARRAY_SIZE(memory_stats); i++) {
 		u64 size;
 
-		size = memcg_page_state(memcg, memory_stats[i].idx);
-		size *= memory_stats[i].ratio;
+		size = memcg_page_state_output(memcg, memory_stats[i].idx);
 		seq_buf_printf(&s, "%s %llu\n", memory_stats[i].name, size);
 
+		/*
+		 * We are printing reclaimable, unreclaimable of the slab
+		 * and the sum of both.
+		 */
 		if (unlikely(memory_stats[i].idx == NR_SLAB_UNRECLAIMABLE_B)) {
-			size = memcg_page_state(memcg, NR_SLAB_RECLAIMABLE_B) +
-			       memcg_page_state(memcg, NR_SLAB_UNRECLAIMABLE_B);
+			size += memcg_page_state_output(memcg,
+							NR_SLAB_RECLAIMABLE_B);
 			seq_buf_printf(&s, "slab %llu\n", size);
 		}
 	}
@@ -6358,6 +6384,12 @@ static int memory_stat_show(struct seq_file *m, void *v)
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
@@ -6375,8 +6407,8 @@ static int memory_numa_stat_show(struct seq_file *m, void *v)
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

