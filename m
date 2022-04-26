Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E0250F040
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Apr 2022 07:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244504AbiDZFma (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Apr 2022 01:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244437AbiDZFm1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Apr 2022 01:42:27 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9A0326F9
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Apr 2022 22:39:19 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id t24-20020a17090a449800b001d2d6e740c3so881475pjg.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Apr 2022 22:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pqJIcFO1YbM2kMD/7P/nIKLZQYZcxdFTC0Vu8kenpz8=;
        b=hMgaPC2CMNA38BUc/4Z6knwfUpImRGhDmly5NSUZyOtnP8B4CuknojlkCLYqYS4Xx1
         Mhi5lC5QrZ7YRgbk+KhF1jxO4da//wil1kv0DtVbRdO8F+TyX8sogYFIfc6A4c6xm3ms
         lYBbLBA0PvfaZECq+R+oZTMXzoWCVObiN+831v/ZE7dPqbNMSBmVDHDznmgQjIaZcF80
         DbgNwnHh+LuA3EHgAweI6pmmir7P1NHgymNtVNBQQWlypnpCZ27UdD5h4YOFmIpgGjKJ
         bshFBhtMcvXmKyOL1UgI8bURuYaux5ZQU9gUxnGIys2/Uzfi1iE84Wa9YQO783bR8pr0
         4w0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pqJIcFO1YbM2kMD/7P/nIKLZQYZcxdFTC0Vu8kenpz8=;
        b=qynihxMWrHH1rWkvf2FJ3oE1UynfU+vmWs0blxCbGNC70YCcjd2gnPNcVz/ex8D4WT
         uYvGQa3X6e+ekOOS3KdAjIbl0Zadho3rPk5YhlEaFbw5I+dlcK0h2eykRY/RnMGif3mw
         cOL1Pv7DXdHf7s/SK8x10aOtuEOV8Aj1j2SfxZPrQr1qq90F3/x2TWVKXS39RMkecj5T
         K2OhtNosH5iIMVbKd5b3x/6vP3jQodiqT3T+mdtIWq6agAyD5FlCoCDmOyY3uw4mZQ0K
         QM1FMVOqVMF2++qgyy8GHF5HI/QbaA2UIBa0tozPiibFv0TvDVgJezc/i/s4+VSfd8G8
         /Mmg==
X-Gm-Message-State: AOAM5311v2np8Ky8cE8jsGIlzBzx2IFJ/R93/MqVHf/3Yq8KRLAsHiB/
        hrYggKPjk2DnZZ4LImfi7wKWlIlQBvZCLTBK
X-Google-Smtp-Source: ABdhPJxejvTv5A7Rpc8BPLWrIBFEPFhn9b9ix6mcFYNGcgcKtqjBfcMW7mNudjijKMPTfwkilfD5EMyQa5cknhMO
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a63:82c2:0:b0:3ab:5747:8837 with SMTP
 id w185-20020a6382c2000000b003ab57478837mr6091278pgd.297.1650951559185; Mon,
 25 Apr 2022 22:39:19 -0700 (PDT)
Date:   Tue, 26 Apr 2022 05:38:59 +0000
In-Reply-To: <20220426053904.3684293-1-yosryahmed@google.com>
Message-Id: <20220426053904.3684293-2-yosryahmed@google.com>
Mime-Version: 1.0
References: <20220426053904.3684293-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v3 1/6] mm: add NR_SECONDARY_PAGETABLE stat
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        James Morse <james.morse@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        Marc Zyngier <maz@kernel.org>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-mips@vger.kernel.org, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add NR_SECONDARY_PAGETABLE stat to count secondary page table uses, e.g.
KVM shadow page tables. This provides more insights on the kernel memory
used by a workload.

This stat will be used by subsequent patches to count KVM pagetable
pages usage.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 drivers/base/node.c    | 2 ++
 fs/proc/meminfo.c      | 2 ++
 include/linux/mmzone.h | 1 +
 mm/memcontrol.c        | 1 +
 mm/page_alloc.c        | 6 +++++-
 mm/vmstat.c            | 1 +
 6 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index ec8bb24a5a22..9fe716832546 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -433,6 +433,7 @@ static ssize_t node_read_meminfo(struct device *dev,
 			     "Node %d ShadowCallStack:%8lu kB\n"
 #endif
 			     "Node %d PageTables:     %8lu kB\n"
+			     "Node %d SecPageTables:  %8lu kB\n"
 			     "Node %d NFS_Unstable:   %8lu kB\n"
 			     "Node %d Bounce:         %8lu kB\n"
 			     "Node %d WritebackTmp:   %8lu kB\n"
@@ -459,6 +460,7 @@ static ssize_t node_read_meminfo(struct device *dev,
 			     nid, node_page_state(pgdat, NR_KERNEL_SCS_KB),
 #endif
 			     nid, K(node_page_state(pgdat, NR_PAGETABLE)),
+			     nid, K(node_page_state(pgdat, NR_SECONDARY_PAGETABLE)),
 			     nid, 0UL,
 			     nid, K(sum_zone_node_page_state(nid, NR_BOUNCE)),
 			     nid, K(node_page_state(pgdat, NR_WRITEBACK_TEMP)),
diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index 6fa761c9cc78..fad29024eb2e 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -108,6 +108,8 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 #endif
 	show_val_kb(m, "PageTables:     ",
 		    global_node_page_state(NR_PAGETABLE));
+	show_val_kb(m, "SecPageTables:	",
+		    global_node_page_state(NR_SECONDARY_PAGETABLE));
 
 	show_val_kb(m, "NFS_Unstable:   ", 0);
 	show_val_kb(m, "Bounce:         ",
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 962b14d403e8..35f57f2578c0 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -219,6 +219,7 @@ enum node_stat_item {
 	NR_KERNEL_SCS_KB,	/* measured in KiB */
 #endif
 	NR_PAGETABLE,		/* used for pagetables */
+	NR_SECONDARY_PAGETABLE, /* secondary pagetables, e.g. kvm shadow pagetables */
 #ifdef CONFIG_SWAP
 	NR_SWAPCACHE,
 #endif
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 725f76723220..89fbd1793960 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1388,6 +1388,7 @@ static const struct memory_stat memory_stats[] = {
 	{ "kernel",			MEMCG_KMEM			},
 	{ "kernel_stack",		NR_KERNEL_STACK_KB		},
 	{ "pagetables",			NR_PAGETABLE			},
+	{ "secondary_pagetables",	NR_SECONDARY_PAGETABLE		},
 	{ "percpu",			MEMCG_PERCPU_B			},
 	{ "sock",			MEMCG_SOCK			},
 	{ "vmalloc",			MEMCG_VMALLOC			},
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2db95780e003..96d00ae9d5c1 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5932,7 +5932,8 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 		" active_file:%lu inactive_file:%lu isolated_file:%lu\n"
 		" unevictable:%lu dirty:%lu writeback:%lu\n"
 		" slab_reclaimable:%lu slab_unreclaimable:%lu\n"
-		" mapped:%lu shmem:%lu pagetables:%lu bounce:%lu\n"
+		" mapped:%lu shmem:%lu pagetables:%lu\n"
+		" secondary_pagetables:%lu bounce:%lu\n"
 		" kernel_misc_reclaimable:%lu\n"
 		" free:%lu free_pcp:%lu free_cma:%lu\n",
 		global_node_page_state(NR_ACTIVE_ANON),
@@ -5949,6 +5950,7 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 		global_node_page_state(NR_FILE_MAPPED),
 		global_node_page_state(NR_SHMEM),
 		global_node_page_state(NR_PAGETABLE),
+		global_node_page_state(NR_SECONDARY_PAGETABLE),
 		global_zone_page_state(NR_BOUNCE),
 		global_node_page_state(NR_KERNEL_MISC_RECLAIMABLE),
 		global_zone_page_state(NR_FREE_PAGES),
@@ -5982,6 +5984,7 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 			" shadow_call_stack:%lukB"
 #endif
 			" pagetables:%lukB"
+			" secondary_pagetables:%lukB"
 			" all_unreclaimable? %s"
 			"\n",
 			pgdat->node_id,
@@ -6007,6 +6010,7 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 			node_page_state(pgdat, NR_KERNEL_SCS_KB),
 #endif
 			K(node_page_state(pgdat, NR_PAGETABLE)),
+			K(node_page_state(pgdat, NR_SECONDARY_PAGETABLE)),
 			pgdat->kswapd_failures >= MAX_RECLAIM_RETRIES ?
 				"yes" : "no");
 	}
diff --git a/mm/vmstat.c b/mm/vmstat.c
index b75b1a64b54c..50bbec73809b 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1240,6 +1240,7 @@ const char * const vmstat_text[] = {
 	"nr_shadow_call_stack",
 #endif
 	"nr_page_table_pages",
+	"nr_secondary_page_table_pages",
 #ifdef CONFIG_SWAP
 	"nr_swapcached",
 #endif
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

