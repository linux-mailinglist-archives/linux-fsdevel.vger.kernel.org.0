Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE16D6E25A0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 16:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbjDNO0U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 10:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjDNOZ4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:25:56 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E11CC09;
        Fri, 14 Apr 2023 07:25:26 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id h24-20020a17090a9c1800b002404be7920aso18803455pjp.5;
        Fri, 14 Apr 2023 07:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681482326; x=1684074326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TCxBEbp3Vh2LecugBLRL5yp+Vpy2XMoG5rUe/amD8/I=;
        b=ZUkBFFgDZMzq0ei7OkZmTW87uX2xk5y2kJKyAYLp3lpS89qPRHDKJgz7tCSi6O1V6k
         GrFbOBQFX/XypGH/c1yklfosrEHoIqzQ10mKCvEBfVArBFpSNqifnArvfV57Wofxfked
         tQSdXPx2lkO9j+I9wB/qaUE15663ceimdY4la8QuwN52VLu4kI7OSpxGktPP3xTt05op
         8/JPrXs0WD8ikj7mOCQTPzq3BQuATZD6Bj6rr4p7YEsHpV8Rg7fuN426Vq3Yjlwn5Htj
         98xjWssljzirK0y11ZY7ToIsvcWt1GPlCV+66dUlZIWt1/ldVbpqyb0Vt9r3pd3avAS7
         t9Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681482326; x=1684074326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TCxBEbp3Vh2LecugBLRL5yp+Vpy2XMoG5rUe/amD8/I=;
        b=YVs5vOLVgAe5DagTU3OXVUWA9HSV7pUhn7AC7Bxe1tYjhaSh6KeNiqlmtIGuk3gH08
         XHMbtyTFDybcJqWs6UedMQxC9d+cHsbZ3y83WJcKsToWGzF9WPQ2ew4nooBdUCMVhCAF
         pLxFG74WYPXuiq9wuPsPkR0AKinxwLUL9bW9b0Bv/EGFtZnl84ZOHytt1zWb4AZBUqdA
         /NHYlFHg1qoe4sNmQaEu6HiZSQ94q3RQ1gEAu8RvE1GvruKw4uRL6dAsj9fb3STfDaf0
         VEnFmtqN9Eawfnrg+Q86HrDERlyzRiU+4zAuqXxzRrQmxoprNNirm7cg4h0LTi8tLxqa
         vDUA==
X-Gm-Message-State: AAQBX9dz4iMwNe2k2V6b5RpQXrEO8jzZ7I+Zl/BW1+x53G1jkkLAwFZy
        1p4J16lNeVGcYg0jp+sAfZc=
X-Google-Smtp-Source: AKy350apXLIP0kt5VCJQRQireZ4xb8EqK6nTeakZbNZ/7tzb6r5mGG/H+ghRbHSVVMAlJe/5ZJjFlQ==
X-Received: by 2002:a17:90b:788:b0:246:896a:408d with SMTP id l8-20020a17090b078800b00246896a408dmr5981639pjz.14.1681482325813;
        Fri, 14 Apr 2023 07:25:25 -0700 (PDT)
Received: from strix-laptop.. (2001-b011-20e0-1499-8303-7502-d3d7-e13b.dynamic-ip6.hinet.net. [2001:b011:20e0:1499:8303:7502:d3d7:e13b])
        by smtp.googlemail.com with ESMTPSA id h7-20020a17090ac38700b0022335f1dae2sm2952386pjt.22.2023.04.14.07.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 07:25:25 -0700 (PDT)
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
Subject: [PATCH v5 07/17] mm/khugepaged: Break COW PTE before scanning pte
Date:   Fri, 14 Apr 2023 22:23:31 +0800
Message-Id: <20230414142341.354556-8-shiyn.lin@gmail.com>
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
index 92e6f56a932d..3020fcb53691 100644
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
@@ -886,7 +887,7 @@ static int find_pmd_or_thp_or_none(struct mm_struct *mm,
 		return SCAN_PMD_MAPPED;
 	if (pmd_devmap(pmde))
 		return SCAN_PMD_NULL;
-	if (pmd_bad(pmde))
+	if (pmd_write(pmde) && pmd_bad(pmde))
 		return SCAN_PMD_NULL;
 	return SCAN_SUCCEED;
 }
@@ -937,6 +938,8 @@ static int __collapse_huge_page_swapin(struct mm_struct *mm,
 			pte_unmap(vmf.pte);
 			continue;
 		}
+		if (break_cow_pte(vma, pmd, address))
+			return SCAN_COW_PTE;
 		ret = do_swap_page(&vmf);
 
 		/*
@@ -1049,6 +1052,9 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 	if (result != SCAN_SUCCEED)
 		goto out_up_write;
 
+	/* We should already handled COW-ed PTE. */
+	VM_WARN_ON(test_bit(MMF_COW_PTE, &mm->flags) && !pmd_write(*pmd));
+
 	anon_vma_lock_write(vma->anon_vma);
 
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, address,
@@ -1159,6 +1165,13 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
 
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
@@ -1217,6 +1230,10 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
 			goto out_unmap;
 		}
 
+		/*
+		 * If we only trigger the break COW PTE, the page usually
+		 * still in COW mapping, which it still be shared.
+		 */
 		if (page_mapcount(page) > 1) {
 			++shared;
 			if (cc->is_khugepaged &&
@@ -1512,6 +1529,11 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
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
@@ -1717,6 +1739,11 @@ static int retract_page_tables(struct address_space *mapping, pgoff_t pgoff,
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
@@ -2154,6 +2181,11 @@ static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
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
@@ -2224,6 +2256,7 @@ static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
 	}
 	rcu_read_unlock();
 
+out:
 	if (result == SCAN_SUCCEED) {
 		if (cc->is_khugepaged &&
 		    present < HPAGE_PMD_NR - khugepaged_max_ptes_none) {
-- 
2.34.1

