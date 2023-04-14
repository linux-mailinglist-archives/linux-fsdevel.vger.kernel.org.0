Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419956E259E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 16:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjDNO0F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 10:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjDNOZl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:25:41 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F0BC174;
        Fri, 14 Apr 2023 07:25:17 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id n17so2474695pln.8;
        Fri, 14 Apr 2023 07:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681482316; x=1684074316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NclmCECex/CFHpfM/6wkOB23PF4WtO4cEeKh/pps1Cs=;
        b=V/AYfRJNaMRNYL9IFUoiq8cp7WDMTq2GdsZvRBqNgIQMjdcljye7UNo4NkMi4droC4
         g5yT7eVZsB6DEJwhMaSh3Br5JzCqVkrbV1+D6X5yYOdeaazRSZc17CpFg5tcLGYOjwQT
         97ybU/LG3FFdXqYCQI8mH9xuTMVWg1lxOxMNJFuV2OvfA9O6XB/Fg78pyV5CD0wc+3v4
         BUCcN4TLNpn2PMDRaTahfhVrMZNCmzTbW/+ugSX+IsLMaYMGzhOgUaEZ+bYBSMuxem1z
         mpC8ySmb9LnKke2HRfRgo/xQlUYMkO3YtXm14ThPJznVqyVcaH20JK5Gwte/rlNF4GH/
         3Irw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681482316; x=1684074316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NclmCECex/CFHpfM/6wkOB23PF4WtO4cEeKh/pps1Cs=;
        b=hFRxCaokBTIcSxQPcIA8ssdBIleLZVURsfkAo3+eg5koiv6I7tsdJgF/FxlV3hAIEF
         926WfCaRz3x2Rgsna1SaG8pP0Q24lG9+AMc1e8tPprb8ZKmArLzXaSc8uGOjdLCa4X23
         H0BgOxcW+IszZaByY+uAR4NEbshXCJPXASzPRSaH/1x6HZosBQEHiHYxbhVixdoX3xd/
         8b0ZiOj62d2ocl2FoWQszLZHSD1hGtG4Il3HY5NlX8R2Mpl3uUAKy8K9PD0vQU5W2KwV
         M2DeFO5wsityzxZqVrotTRZ+u/Xb09uS0o9GusUMqbcjyFlJCf1fOj6azOwcUs1SpZmf
         rwvw==
X-Gm-Message-State: AAQBX9eB7tKWvfTWqfahePpz30Kbl9DJlrHw0/P+Ze2AGXO3/gD/vW+h
        4JY1yJMAmQzCSLXC3AuBB+I=
X-Google-Smtp-Source: AKy350ZPU+Edlq0VRRV3L/JnX2VakyMBg2O0FN77xU7rql7Qa95cBelgIKvLqgkAsYrK6MRTS18ulw==
X-Received: by 2002:a17:90a:7382:b0:244:af48:c4f3 with SMTP id j2-20020a17090a738200b00244af48c4f3mr5780766pjg.7.1681482316538;
        Fri, 14 Apr 2023 07:25:16 -0700 (PDT)
Received: from strix-laptop.. (2001-b011-20e0-1499-8303-7502-d3d7-e13b.dynamic-ip6.hinet.net. [2001:b011:20e0:1499:8303:7502:d3d7:e13b])
        by smtp.googlemail.com with ESMTPSA id h7-20020a17090ac38700b0022335f1dae2sm2952386pjt.22.2023.04.14.07.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 07:25:16 -0700 (PDT)
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
Subject: [PATCH v5 06/17] mm/rmap: Break COW PTE in rmap walking
Date:   Fri, 14 Apr 2023 22:23:30 +0800
Message-Id: <20230414142341.354556-7-shiyn.lin@gmail.com>
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

Some of the features (unmap, migrate, device exclusive, mkclean, etc)
might modify the pte entry via rmap. Add a new page vma mapped walk
flag, PVMW_BREAK_COW_PTE, to indicate the rmap walking to break COW PTE.

Signed-off-by: Chih-En Lin <shiyn.lin@gmail.com>
---
 include/linux/rmap.h | 2 ++
 mm/migrate.c         | 3 ++-
 mm/page_vma_mapped.c | 4 ++++
 mm/rmap.c            | 9 +++++----
 mm/vmscan.c          | 3 ++-
 5 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index b87d01660412..57e9b72dc63a 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -377,6 +377,8 @@ int make_device_exclusive_range(struct mm_struct *mm, unsigned long start,
 #define PVMW_SYNC		(1 << 0)
 /* Look for migration entries rather than present PTEs */
 #define PVMW_MIGRATION		(1 << 1)
+/* Break COW-ed PTE during walking */
+#define PVMW_BREAK_COW_PTE	(1 << 2)
 
 struct page_vma_mapped_walk {
 	unsigned long pfn;
diff --git a/mm/migrate.c b/mm/migrate.c
index db3f154446af..38933993af14 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -184,7 +184,8 @@ void putback_movable_pages(struct list_head *l)
 static bool remove_migration_pte(struct folio *folio,
 		struct vm_area_struct *vma, unsigned long addr, void *old)
 {
-	DEFINE_FOLIO_VMA_WALK(pvmw, old, vma, addr, PVMW_SYNC | PVMW_MIGRATION);
+	DEFINE_FOLIO_VMA_WALK(pvmw, old, vma, addr,
+			      PVMW_SYNC | PVMW_MIGRATION | PVMW_BREAK_COW_PTE);
 
 	while (page_vma_mapped_walk(&pvmw)) {
 		rmap_t rmap_flags = RMAP_NONE;
diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 4e448cfbc6ef..1750b3460828 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -254,6 +254,10 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 			step_forward(pvmw, PMD_SIZE);
 			continue;
 		}
+		if (pvmw->flags & PVMW_BREAK_COW_PTE) {
+			if (break_cow_pte(vma, pvmw->pmd, pvmw->address))
+				return not_found(pvmw);
+		}
 		if (!map_pte(pvmw))
 			goto next_pte;
 this_pte:
diff --git a/mm/rmap.c b/mm/rmap.c
index 8632e02661ac..5582da6d72fc 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1006,7 +1006,8 @@ static int page_vma_mkclean_one(struct page_vma_mapped_walk *pvmw)
 static bool page_mkclean_one(struct folio *folio, struct vm_area_struct *vma,
 			     unsigned long address, void *arg)
 {
-	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, address, PVMW_SYNC);
+	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, address,
+			      PVMW_SYNC | PVMW_BREAK_COW_PTE);
 	int *cleaned = arg;
 
 	*cleaned += page_vma_mkclean_one(&pvmw);
@@ -1450,7 +1451,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 		     unsigned long address, void *arg)
 {
 	struct mm_struct *mm = vma->vm_mm;
-	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, address, 0);
+	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, address, PVMW_BREAK_COW_PTE);
 	pte_t pteval;
 	struct page *subpage;
 	bool anon_exclusive, ret = true;
@@ -1810,7 +1811,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 		     unsigned long address, void *arg)
 {
 	struct mm_struct *mm = vma->vm_mm;
-	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, address, 0);
+	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, address, PVMW_BREAK_COW_PTE);
 	pte_t pteval;
 	struct page *subpage;
 	bool anon_exclusive, ret = true;
@@ -2177,7 +2178,7 @@ static bool page_make_device_exclusive_one(struct folio *folio,
 		struct vm_area_struct *vma, unsigned long address, void *priv)
 {
 	struct mm_struct *mm = vma->vm_mm;
-	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, address, 0);
+	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, address, PVMW_BREAK_COW_PTE);
 	struct make_exclusive_args *args = priv;
 	pte_t pteval;
 	struct page *subpage;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 9c1c5e8b24b8..4abbd036f927 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1892,7 +1892,8 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 
 		/*
 		 * The folio is mapped into the page tables of one or more
-		 * processes. Try to unmap it here.
+		 * processes. Try to unmap it here. Also, since it will write
+		 * to the page tables, break COW PTE if they are.
 		 */
 		if (folio_mapped(folio)) {
 			enum ttu_flags flags = TTU_BATCH_FLUSH;
-- 
2.34.1

