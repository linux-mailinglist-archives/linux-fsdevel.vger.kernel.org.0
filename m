Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ADD968CDB2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Feb 2023 04:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjBGDyO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Feb 2023 22:54:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjBGDyB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Feb 2023 22:54:01 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2CA30EB3;
        Mon,  6 Feb 2023 19:53:36 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id j1so7833186pjd.0;
        Mon, 06 Feb 2023 19:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vnJphn8h/teaY51bYztcFGncAa/2yVuimAdfonZwh2I=;
        b=PLGORcIX7Z6FO2uh+mQhLmU6Q65FKoCoeEVpBOahKass5lqk/ZUcoT3F2MndhZwPvD
         0mcdoaI0U+baKWJ4JeOTlEZMvmaGel6EF3KYGvL0ma0HMwuPbMS/eNIBMp+3cjBI0CAV
         NPA6xJUzYQHhqdAsh/yDBz3rnThh7PF6IO6hLIZ3nUcpqLHo1AWOMnsnXd1o1hcMqQcd
         pgEDrwE4PnU5B1H8IA44sCgFJTPz/tBTbDkXemjFx+Vaa57KvKgs/iHYnRn357d7G2JT
         LQ3Urkg90KMHhySnNKDmJ+igImMdxMsMTgz5oKSQDPZl1mNYYAqTz+y9YQ4gDmZ0jN2o
         Be1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vnJphn8h/teaY51bYztcFGncAa/2yVuimAdfonZwh2I=;
        b=FalSsuCnTycobAEuLQXIeAaIpyjPsUROHFSGltL1f+KDvpXfbdY6Qh3MOK8nOa5zzn
         vIFnArPigDiOJgbkkD3v5l12WcbItkzcgu4r07l3Tw9Mu8BWbZ5cvfZbsJWupT62J4v4
         KpcYHBvT1sMafujng2lg3nzu/FUkOEQh2r7oAW0Ae2ikBrVdLvAEHlVkUcFtZR0/6c7G
         jU0pb8wL5EWrhtrlc9HGpeug3QwOMc6S5FCDCiQonC8/DolUc9aXTJPdT432Zzhx8W8B
         NjxujUt0tf5uzQewA9u0Ew4q7km869lAZchJ2h5s99trPAPvyVj8qi5oul/sse0ZJzSj
         97Ug==
X-Gm-Message-State: AO0yUKXWL9/t4ZubtmsIDziaCTEPeB+rNyT6+Cjim4b6c6bna45snoGC
        hhd7PT1N3wih6PasZvZd3Bw=
X-Google-Smtp-Source: AK7set+8EGcTNLLEym88LMDaQznwmnIZe5fv2xZTmJeysKbk4P1tuC9B1rImnpJu2fsuK/TfhwXLRA==
X-Received: by 2002:a17:902:c40f:b0:196:e8e:cd28 with SMTP id k15-20020a170902c40f00b001960e8ecd28mr1564019plk.15.1675742016151;
        Mon, 06 Feb 2023 19:53:36 -0800 (PST)
Received: from strix-laptop.hitronhub.home ([123.110.9.95])
        by smtp.googlemail.com with ESMTPSA id q4-20020a170902b10400b0019682e27995sm7647655plr.223.2023.02.06.19.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 19:53:35 -0800 (PST)
From:   Chih-En Lin <shiyn.lin@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        John Hubbard <jhubbard@nvidia.com>,
        Nadav Amit <namit@vmware.com>, Barry Song <baohua@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Yang Shi <shy828301@gmail.com>, Peter Xu <peterx@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Zach O'Keefe" <zokeefe@google.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Hugh Dickins <hughd@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Yu Zhao <yuzhao@google.com>, Juergen Gross <jgross@suse.com>,
        Tong Tiangen <tongtiangen@huawei.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Li kunyu <kunyu@nfschina.com>,
        Minchan Kim <minchan@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Gautam Menghani <gautammenghani201@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>, Will Deacon <will@kernel.org>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andrei Vagin <avagin@gmail.com>,
        Barret Rhoden <brho@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Alexey Gladkov <legion@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Dinglan Peng <peng301@purdue.edu>,
        Pedro Fonseca <pfonseca@purdue.edu>,
        Jim Huang <jserv@ccns.ncku.edu.tw>,
        Huichun Feng <foxhoundsk.tw@gmail.com>,
        Chih-En Lin <shiyn.lin@gmail.com>
Subject: [PATCH v4 05/14] mm/khugepaged: Break COW PTE before scanning pte
Date:   Tue,  7 Feb 2023 11:51:30 +0800
Message-Id: <20230207035139.272707-6-shiyn.lin@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230207035139.272707-1-shiyn.lin@gmail.com>
References: <20230207035139.272707-1-shiyn.lin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We should not allow THP to collapse COW-ed PTE. So, break COW PTE
before collapse_pte_mapped_thp() collapse to THP. Also, break COW
PTE before khugepaged_scan_pmd() scan PTE.

Signed-off-by: Chih-En Lin <shiyn.lin@gmail.com>
---
 include/trace/events/huge_memory.h |  1 +
 mm/khugepaged.c                    | 35 +++++++++++++++++++++++++++++-
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
index 3e6fb05852f9..5f2c39f61521 100644
--- a/include/trace/events/huge_memory.h
+++ b/include/trace/events/huge_memory.h
@@ -13,6 +13,7 @@
 	EM( SCAN_PMD_NULL,		"pmd_null")			\
 	EM( SCAN_PMD_NONE,		"pmd_none")			\
 	EM( SCAN_PMD_MAPPED,		"page_pmd_mapped")		\
+	EM( SCAN_COW_PTE,		"cowed_pte")			\
 	EM( SCAN_EXCEED_NONE_PTE,	"exceed_none_pte")		\
 	EM( SCAN_EXCEED_SWAP_PTE,	"exceed_swap_pte")		\
 	EM( SCAN_EXCEED_SHARED_PTE,	"exceed_shared_pte")		\
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 90acfea40c13..1cddc20318d5 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -31,6 +31,7 @@ enum scan_result {
 	SCAN_PMD_NULL,
 	SCAN_PMD_NONE,
 	SCAN_PMD_MAPPED,
+	SCAN_COW_PTE,
 	SCAN_EXCEED_NONE_PTE,
 	SCAN_EXCEED_SWAP_PTE,
 	SCAN_EXCEED_SHARED_PTE,
@@ -875,7 +876,7 @@ static int find_pmd_or_thp_or_none(struct mm_struct *mm,
 		return SCAN_PMD_MAPPED;
 	if (pmd_devmap(pmde))
 		return SCAN_PMD_NULL;
-	if (pmd_bad(pmde))
+	if (pmd_write(pmde) && pmd_bad(pmde))
 		return SCAN_PMD_NULL;
 	return SCAN_SUCCEED;
 }
@@ -926,6 +927,8 @@ static int __collapse_huge_page_swapin(struct mm_struct *mm,
 			pte_unmap(vmf.pte);
 			continue;
 		}
+		if (break_cow_pte(vma, pmd, address))
+			return SCAN_COW_PTE;
 		ret = do_swap_page(&vmf);
 
 		/*
@@ -1038,6 +1041,9 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 	if (result != SCAN_SUCCEED)
 		goto out_up_write;
 
+	/* We should already handled COW-ed PTE. */
+	VM_WARN_ON(test_bit(MMF_COW_PTE, &mm->flags) && !pmd_write(*pmd));
+
 	anon_vma_lock_write(vma->anon_vma);
 
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, NULL, mm,
@@ -1148,6 +1154,13 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
 
 	memset(cc->node_load, 0, sizeof(cc->node_load));
 	nodes_clear(cc->alloc_nmask);
+
+	/* Break COW PTE before we collapse the pages. */
+	if (break_cow_pte(vma, pmd, address)) {
+		result = SCAN_COW_PTE;
+		goto out;
+	}
+
 	pte = pte_offset_map_lock(mm, pmd, address, &ptl);
 	for (_address = address, _pte = pte; _pte < pte + HPAGE_PMD_NR;
 	     _pte++, _address += PAGE_SIZE) {
@@ -1206,6 +1219,10 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
 			goto out_unmap;
 		}
 
+		/*
+		 * If we only trigger the break COW PTE, the page usually
+		 * still in COW mapping, which it still be shared.
+		 */
 		if (page_mapcount(page) > 1) {
 			++shared;
 			if (cc->is_khugepaged &&
@@ -1501,6 +1518,11 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 		goto drop_hpage;
 	}
 
+	/* We shouldn't let COW-ed PTE collapse. */
+	if (break_cow_pte(vma, pmd, haddr))
+		goto drop_hpage;
+	VM_WARN_ON(test_bit(MMF_COW_PTE, &mm->flags) && !pmd_write(*pmd));
+
 	/*
 	 * We need to lock the mapping so that from here on, only GUP-fast and
 	 * hardware page walks can access the parts of the page tables that
@@ -1706,6 +1728,11 @@ static int retract_page_tables(struct address_space *mapping, pgoff_t pgoff,
 				result = SCAN_PTE_UFFD_WP;
 				goto unlock_next;
 			}
+			if (test_bit(MMF_COW_PTE, &mm->flags) &&
+			     !pmd_write(*pmd)) {
+				result = SCAN_COW_PTE;
+				goto unlock_next;
+			}
 			collapse_and_free_pmd(mm, vma, addr, pmd);
 			if (!cc->is_khugepaged && is_target)
 				result = set_huge_pmd(vma, addr, pmd, hpage);
@@ -2143,6 +2170,11 @@ static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
 	swap = 0;
 	memset(cc->node_load, 0, sizeof(cc->node_load));
 	nodes_clear(cc->alloc_nmask);
+	if (break_cow_pte(find_vma(mm, addr), NULL, addr)) {
+		result = SCAN_COW_PTE;
+		goto out;
+	}
+
 	rcu_read_lock();
 	xas_for_each(&xas, page, start + HPAGE_PMD_NR - 1) {
 		if (xas_retry(&xas, page))
@@ -2213,6 +2245,7 @@ static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
 	}
 	rcu_read_unlock();
 
+out:
 	if (result == SCAN_SUCCEED) {
 		if (cc->is_khugepaged &&
 		    present < HPAGE_PMD_NR - khugepaged_max_ptes_none) {
-- 
2.34.1

