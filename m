Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713356E2594
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 16:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjDNOYs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 10:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbjDNOYn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:24:43 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F144C152;
        Fri, 14 Apr 2023 07:24:31 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id f2so9911822pjs.3;
        Fri, 14 Apr 2023 07:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681482270; x=1684074270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uu2tvK/dyE/2iioL4m/q+1zLO0tq6AJoZ0N1fRXdBLI=;
        b=VZpG6YhRv9cCG3dhHA4pW1dfvwCMu8AdyhCK9POKf5RMu8MA/hMLmX9JH6IlIvozl1
         1fVKpFWNxMc57Q90dZ7CxY5g8ZjQa98VKAWwZZYhMZCFgRuJLaCo0ene2tZmu1p3/eXY
         vgGdzYayeuafSTKmDbbuUID2tYVhNc9bsT3u2L34Qz3Sk4G3BHCgygYiRqeJFkwIHjs2
         Nr2TTPHguT7oEswc2lYK0IYXrvHQR6EAjkurHZk2S7EXlB2uNgw4hengUxVBmEPCr65L
         0Jsxm3ALANv9sKddMqxMVD0nh2jBBNUv96/3Ut35UTZ1DS0w9BP0/MQAFy73Zj+IzSAG
         mDuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681482270; x=1684074270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uu2tvK/dyE/2iioL4m/q+1zLO0tq6AJoZ0N1fRXdBLI=;
        b=A1ixAIeOTQNaUx4ylEcA1Fn9UbDYq6LFOnlnJPwuQS5fGU4vv+QbuIh5ypSFTqej7M
         IzY2uyxSbTte/Z+rlz+bpH2/0tCnrtQ8e4MwnjieVjMaqJ1vXlYFKEmxTJTkXDNu/B8u
         UWmMoFZmy46mKARpxeMWadb1UjIM0Ovg8j+eLHQ0OruNx4TH834Z94PC+MiYhzxENkJ3
         AZIc6MUdpB20DXaUY3GvUQGgRtS70JK5vUHhfmZIIaVnsdNCOgy9QpHuuRm+bC+mLX3V
         axOaFMxyruswCAwY1B051W/s07G1nLfOXbTHa0oqSOvkz8saYq6rlSap18Wm5+etLL4D
         SlYw==
X-Gm-Message-State: AAQBX9d2laPtzEyhRItEj0sN/O15AE8IEnzY/k5DmXPLFQC65BRfuzA2
        ulLrx5di0vezqRwiXGh2qqI=
X-Google-Smtp-Source: AKy350YJJQnFLpjJ1GWwTuBA1s0UTSEAKxeCsIUIoR1dqPUv21yoi97HToCfZrLndDVV2aGKaYjHpw==
X-Received: by 2002:a17:90a:4a17:b0:247:2d48:76f7 with SMTP id e23-20020a17090a4a1700b002472d4876f7mr4010602pjh.44.1681482270305;
        Fri, 14 Apr 2023 07:24:30 -0700 (PDT)
Received: from strix-laptop.. (2001-b011-20e0-1499-8303-7502-d3d7-e13b.dynamic-ip6.hinet.net. [2001:b011:20e0:1499:8303:7502:d3d7:e13b])
        by smtp.googlemail.com with ESMTPSA id h7-20020a17090ac38700b0022335f1dae2sm2952386pjt.22.2023.04.14.07.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 07:24:29 -0700 (PDT)
From:   Chih-En Lin <shiyn.lin@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        John Hubbard <jhubbard@nvidia.com>,
        Nadav Amit <namit@vmware.com>, Barry Song <baohua@kernel.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yu Zhao <yuzhao@google.com>,
        Steven Barrett <steven@liquorix.net>,
        Juergen Gross <jgross@suse.com>, Peter Xu <peterx@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Tong Tiangen <tongtiangen@huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Alex Sierra <alex.sierra@amd.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Li kunyu <kunyu@nfschina.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Joey Gouly <joey.gouly@arm.com>,
        Chih-En Lin <shiyn.lin@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Zach O'Keefe" <zokeefe@google.com>,
        Gautam Menghani <gautammenghani201@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrei Vagin <avagin@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexey Gladkov <legion@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Dinglan Peng <peng301@purdue.edu>,
        Pedro Fonseca <pfonseca@purdue.edu>,
        Jim Huang <jserv@ccns.ncku.edu.tw>,
        Huichun Feng <foxhoundsk.tw@gmail.com>
Subject: [PATCH v5 01/17] mm: Split out the present cases from zap_pte_range()
Date:   Fri, 14 Apr 2023 22:23:25 +0800
Message-Id: <20230414142341.354556-2-shiyn.lin@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414142341.354556-1-shiyn.lin@gmail.com>
References: <20230414142341.354556-1-shiyn.lin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As the complexity of zap_pte_range() has increased, The readability
and maintainability are becoming more difficult. To simplfy and
improve the expandability of zap PTE part, split the present and
non-present cases from zap_pte_range() and replace the individual
flag variable by the single flag with bitwise operations.

Signed-off-by: Chih-En Lin <shiyn.lin@gmail.com>
---
 mm/memory.c | 217 +++++++++++++++++++++++++++++++---------------------
 1 file changed, 129 insertions(+), 88 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 01a23ad48a04..0476cf22ea33 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1351,29 +1351,147 @@ zap_install_uffd_wp_if_needed(struct vm_area_struct *vma,
 	pte_install_uffd_wp_if_needed(vma, addr, pte, pteval);
 }
 
+#define ZAP_PTE_INIT 0x0000
+#define ZAP_PTE_FORCE_FLUSH 0x0001
+
+struct zap_pte_details {
+	pte_t **pte;
+	unsigned long *addr;
+	unsigned int flags;
+	int rss[NR_MM_COUNTERS];
+};
+
+/* Return 0 to continue, 1 to break. */
+static inline int
+zap_present_pte(struct mmu_gather *tlb, struct vm_area_struct *vma,
+		struct zap_details *details,
+		struct zap_pte_details *pte_details)
+{
+	struct mm_struct *mm = tlb->mm;
+	struct page *page;
+	unsigned int delay_rmap;
+	unsigned long addr = *pte_details->addr;
+	pte_t *pte = *pte_details->pte;
+	pte_t ptent = *pte;
+
+	page = vm_normal_page(vma, addr, ptent);
+	if (unlikely(!should_zap_page(details, page)))
+		return 0;
+
+	ptent = ptep_get_and_clear_full(mm, addr, pte, tlb->fullmm);
+	tlb_remove_tlb_entry(tlb, pte, addr);
+	zap_install_uffd_wp_if_needed(vma, addr, pte, details, ptent);
+	if (unlikely(!page))
+		return 0;
+
+	delay_rmap = 0;
+	if (!PageAnon(page)) {
+		if (pte_dirty(ptent)) {
+			set_page_dirty(page);
+			if (tlb_delay_rmap(tlb)) {
+				delay_rmap = 1;
+				pte_details->flags |= ZAP_PTE_FORCE_FLUSH;
+			}
+		}
+		if (pte_young(ptent) && likely(vma_has_recency(vma)))
+			mark_page_accessed(page);
+
+	}
+	pte_details->rss[mm_counter(page)]--;
+	if (!delay_rmap) {
+		page_remove_rmap(page, vma, false);
+		if (unlikely(page_mapcount(page) < 0))
+			print_bad_pte(vma, addr, ptent, page);
+	}
+	if (unlikely(__tlb_remove_page(tlb, page, delay_rmap))) {
+		*pte_details->addr += PAGE_SIZE;
+		pte_details->flags |= ZAP_PTE_FORCE_FLUSH;
+		return 1;
+	}
+
+	return 0;
+}
+
+static inline void
+zap_nopresent_pte(struct mmu_gather *tlb, struct vm_area_struct *vma,
+		  struct zap_details *details,
+		  struct zap_pte_details *pte_details)
+{
+	struct mm_struct *mm = tlb->mm;
+	struct page *page;
+	unsigned long addr = *pte_details->addr;
+	pte_t *pte = *pte_details->pte;
+	pte_t ptent = *pte;
+	swp_entry_t entry = pte_to_swp_entry(ptent);
+
+	if (is_device_private_entry(entry) ||
+	    is_device_exclusive_entry(entry)) {
+		page = pfn_swap_entry_to_page(entry);
+		if (unlikely(!should_zap_page(details, page)))
+			return;
+		/*
+		 * Both device private/exclusive mappings should only
+		 * work with anonymous page so far, so we don't need to
+		 * consider uffd-wp bit when zap. For more information,
+		 * see zap_install_uffd_wp_if_needed().
+		 */
+		WARN_ON_ONCE(!vma_is_anonymous(vma));
+		pte_details->rss[mm_counter(page)]--;
+		if (is_device_private_entry(entry))
+			page_remove_rmap(page, vma, false);
+		put_page(page);
+	} else if (!non_swap_entry(entry)) {
+		/* Genuine swap entry, hence a private anon page */
+		if (!should_zap_cows(details))
+			return;
+		pte_details->rss[MM_SWAPENTS]--;
+		if (unlikely(!free_swap_and_cache(entry)))
+			print_bad_pte(vma, addr, ptent, NULL);
+	} else if (is_migration_entry(entry)) {
+		page = pfn_swap_entry_to_page(entry);
+		if (!should_zap_page(details, page))
+			return;
+		pte_details->rss[mm_counter(page)]--;
+	} else if (pte_marker_entry_uffd_wp(entry)) {
+		/* Only drop the uffd-wp marker if explicitly requested */
+		if (!zap_drop_file_uffd_wp(details))
+			return;
+	} else if (is_hwpoison_entry(entry) ||
+		   is_swapin_error_entry(entry)) {
+		if (!should_zap_cows(details))
+			return;
+	} else {
+		/* We should have covered all the swap entry types */
+		WARN_ON_ONCE(1);
+	}
+	pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
+	zap_install_uffd_wp_if_needed(vma, addr, pte, details, ptent);
+}
+
 static unsigned long zap_pte_range(struct mmu_gather *tlb,
 				struct vm_area_struct *vma, pmd_t *pmd,
 				unsigned long addr, unsigned long end,
 				struct zap_details *details)
 {
 	struct mm_struct *mm = tlb->mm;
-	int force_flush = 0;
-	int rss[NR_MM_COUNTERS];
 	spinlock_t *ptl;
 	pte_t *start_pte;
 	pte_t *pte;
-	swp_entry_t entry;
+	struct zap_pte_details pte_details = {
+		.addr = &addr,
+		.flags = ZAP_PTE_INIT,
+		.pte = &pte,
+	};
 
 	tlb_change_page_size(tlb, PAGE_SIZE);
 again:
-	init_rss_vec(rss);
+	init_rss_vec(pte_details.rss);
 	start_pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
 	pte = start_pte;
 	flush_tlb_batched_pending(mm);
 	arch_enter_lazy_mmu_mode();
 	do {
 		pte_t ptent = *pte;
-		struct page *page;
 
 		if (pte_none(ptent))
 			continue;
@@ -1382,95 +1500,18 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			break;
 
 		if (pte_present(ptent)) {
-			unsigned int delay_rmap;
-
-			page = vm_normal_page(vma, addr, ptent);
-			if (unlikely(!should_zap_page(details, page)))
-				continue;
-			ptent = ptep_get_and_clear_full(mm, addr, pte,
-							tlb->fullmm);
-			tlb_remove_tlb_entry(tlb, pte, addr);
-			zap_install_uffd_wp_if_needed(vma, addr, pte, details,
-						      ptent);
-			if (unlikely(!page))
-				continue;
-
-			delay_rmap = 0;
-			if (!PageAnon(page)) {
-				if (pte_dirty(ptent)) {
-					set_page_dirty(page);
-					if (tlb_delay_rmap(tlb)) {
-						delay_rmap = 1;
-						force_flush = 1;
-					}
-				}
-				if (pte_young(ptent) && likely(vma_has_recency(vma)))
-					mark_page_accessed(page);
-			}
-			rss[mm_counter(page)]--;
-			if (!delay_rmap) {
-				page_remove_rmap(page, vma, false);
-				if (unlikely(page_mapcount(page) < 0))
-					print_bad_pte(vma, addr, ptent, page);
-			}
-			if (unlikely(__tlb_remove_page(tlb, page, delay_rmap))) {
-				force_flush = 1;
-				addr += PAGE_SIZE;
+			if (zap_present_pte(tlb, vma, details, &pte_details))
 				break;
-			}
 			continue;
 		}
-
-		entry = pte_to_swp_entry(ptent);
-		if (is_device_private_entry(entry) ||
-		    is_device_exclusive_entry(entry)) {
-			page = pfn_swap_entry_to_page(entry);
-			if (unlikely(!should_zap_page(details, page)))
-				continue;
-			/*
-			 * Both device private/exclusive mappings should only
-			 * work with anonymous page so far, so we don't need to
-			 * consider uffd-wp bit when zap. For more information,
-			 * see zap_install_uffd_wp_if_needed().
-			 */
-			WARN_ON_ONCE(!vma_is_anonymous(vma));
-			rss[mm_counter(page)]--;
-			if (is_device_private_entry(entry))
-				page_remove_rmap(page, vma, false);
-			put_page(page);
-		} else if (!non_swap_entry(entry)) {
-			/* Genuine swap entry, hence a private anon page */
-			if (!should_zap_cows(details))
-				continue;
-			rss[MM_SWAPENTS]--;
-			if (unlikely(!free_swap_and_cache(entry)))
-				print_bad_pte(vma, addr, ptent, NULL);
-		} else if (is_migration_entry(entry)) {
-			page = pfn_swap_entry_to_page(entry);
-			if (!should_zap_page(details, page))
-				continue;
-			rss[mm_counter(page)]--;
-		} else if (pte_marker_entry_uffd_wp(entry)) {
-			/* Only drop the uffd-wp marker if explicitly requested */
-			if (!zap_drop_file_uffd_wp(details))
-				continue;
-		} else if (is_hwpoison_entry(entry) ||
-			   is_swapin_error_entry(entry)) {
-			if (!should_zap_cows(details))
-				continue;
-		} else {
-			/* We should have covered all the swap entry types */
-			WARN_ON_ONCE(1);
-		}
-		pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
-		zap_install_uffd_wp_if_needed(vma, addr, pte, details, ptent);
+		zap_nopresent_pte(tlb, vma, details, &pte_details);
 	} while (pte++, addr += PAGE_SIZE, addr != end);
 
-	add_mm_rss_vec(mm, rss);
+	add_mm_rss_vec(mm, pte_details.rss);
 	arch_leave_lazy_mmu_mode();
 
 	/* Do the actual TLB flush before dropping ptl */
-	if (force_flush) {
+	if (pte_details.flags & ZAP_PTE_FORCE_FLUSH) {
 		tlb_flush_mmu_tlbonly(tlb);
 		tlb_flush_rmaps(tlb, vma);
 	}
@@ -1482,8 +1523,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 	 * entries before releasing the ptl), free the batched
 	 * memory too. Restart if we didn't do everything.
 	 */
-	if (force_flush) {
-		force_flush = 0;
+	if (pte_details.flags & ZAP_PTE_FORCE_FLUSH) {
+		pte_details.flags &= ~ZAP_PTE_FORCE_FLUSH;
 		tlb_flush_mmu(tlb);
 	}
 
-- 
2.34.1

