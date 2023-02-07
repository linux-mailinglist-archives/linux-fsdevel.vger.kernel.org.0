Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8161E68CDB0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Feb 2023 04:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjBGDyC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Feb 2023 22:54:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjBGDx6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Feb 2023 22:53:58 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8693644B;
        Mon,  6 Feb 2023 19:53:23 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id b5so14380838plz.5;
        Mon, 06 Feb 2023 19:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ESippIZ/CnSB38WrMj5JjilizAGyOvY6jTA6jEVsXQY=;
        b=hCRrp5kpGX6QjdARktYunOshhGk1+EWKFT5Inj47ph8UgEaPUwrDd08achgmwp3+yh
         X2XxKEgIJtkgLu7diHgDiBGzH0J0BsocTB0tHay6IQqubsICj4ahady75+p1pVmQ8hmv
         REsKqot4Cf2GZHbfsUo2MbxsDaWeFF3d2o5dwAPUToyCuvp5zwyr5SD9uH5rEsgqfVHY
         ZTNUoPVRCVRlIsFb+wrwo4fjETdVaEMb6/wHALYAOJ8lWPfF/ePBMb3BHCpJbWQiS8tA
         FypkGbVdOQkNs6tW5XpQtNablH6CqIhBzSTyPoFExmbx9SOovtew9FUYuUyPZkNYuYub
         Ph9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ESippIZ/CnSB38WrMj5JjilizAGyOvY6jTA6jEVsXQY=;
        b=rrBfPTJ2aPvYsMeIf+qeDEUE9J3aN0zlEVYSE3xOIEf+GsGEs7wNZBR8cJU2FP5dd7
         B29f2l4LpsVeM05Y2G9kH8KT9h72JfAuPWpT4fx2NzfoOOpm+H3cHfG47waX8PokPyM8
         A4db7fW70PluzG56JirRH1Q0f+ZGifBvjK5C16Cv7A75JSFJsVR+4AKe50PzQaXZOGZa
         mtTilZTuTjwwp3fonKUm7CFpoWvKNH2igMgkM92f/8BP4ogOdDlq08p2rgRqCGtgU/oR
         4Bz2NgFamO3mJLgqrzZ0Zw5Crz0cY8FiBPpT/Ur4aGg23qp8SveJ7QcYIVFmZadCBC5Y
         flXQ==
X-Gm-Message-State: AO0yUKVDhKGKvLKBuOVDTW/lkctjVoggLHaEmTuWk/b2lB5dcFToI+vY
        iUWZUy+TfP0YPuJiMIZoHYM=
X-Google-Smtp-Source: AK7set+i4QEI6ncNS3F1kMiQrABLK/ayhTEQ52mLQfi5RcF2b9D1IkmgPWJcep3JctJB4hPN+Y3yPQ==
X-Received: by 2002:a17:902:f24c:b0:198:e584:5823 with SMTP id j12-20020a170902f24c00b00198e5845823mr1054495plc.34.1675742003150;
        Mon, 06 Feb 2023 19:53:23 -0800 (PST)
Received: from strix-laptop.hitronhub.home ([123.110.9.95])
        by smtp.googlemail.com with ESMTPSA id q4-20020a170902b10400b0019682e27995sm7647655plr.223.2023.02.06.19.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 19:53:22 -0800 (PST)
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
Subject: [PATCH v4 04/14] mm/rmap: Break COW PTE in rmap walking
Date:   Tue,  7 Feb 2023 11:51:29 +0800
Message-Id: <20230207035139.272707-5-shiyn.lin@gmail.com>
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
index bd3504d11b15..d0f07e551973 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -368,6 +368,8 @@ int make_device_exclusive_range(struct mm_struct *mm, unsigned long start,
 #define PVMW_SYNC		(1 << 0)
 /* Look for migration entries rather than present PTEs */
 #define PVMW_MIGRATION		(1 << 1)
+/* Break COW-ed PTE during walking */
+#define PVMW_BREAK_COW_PTE	(1 << 2)
 
 struct page_vma_mapped_walk {
 	unsigned long pfn;
diff --git a/mm/migrate.c b/mm/migrate.c
index a4d3fc65085f..04376ce05aa8 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -183,7 +183,8 @@ void putback_movable_pages(struct list_head *l)
 static bool remove_migration_pte(struct folio *folio,
 		struct vm_area_struct *vma, unsigned long addr, void *old)
 {
-	DEFINE_FOLIO_VMA_WALK(pvmw, old, vma, addr, PVMW_SYNC | PVMW_MIGRATION);
+	DEFINE_FOLIO_VMA_WALK(pvmw, old, vma, addr,
+			      PVMW_SYNC | PVMW_MIGRATION | PVMW_BREAK_COW_PTE);
 
 	while (page_vma_mapped_walk(&pvmw)) {
 		rmap_t rmap_flags = RMAP_NONE;
diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 93e13fc17d3c..7b35e85b9964 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -251,6 +251,10 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
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
index b616870a09be..bce97496b1f6 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1012,7 +1012,8 @@ static int page_vma_mkclean_one(struct page_vma_mapped_walk *pvmw)
 static bool page_mkclean_one(struct folio *folio, struct vm_area_struct *vma,
 			     unsigned long address, void *arg)
 {
-	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, address, PVMW_SYNC);
+	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, address,
+			      PVMW_SYNC | PVMW_BREAK_COW_PTE);
 	int *cleaned = arg;
 
 	*cleaned += page_vma_mkclean_one(&pvmw);
@@ -1463,7 +1464,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 		     unsigned long address, void *arg)
 {
 	struct mm_struct *mm = vma->vm_mm;
-	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, address, 0);
+	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, address, PVMW_BREAK_COW_PTE);
 	pte_t pteval;
 	struct page *subpage;
 	bool anon_exclusive, ret = true;
@@ -1834,7 +1835,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 		     unsigned long address, void *arg)
 {
 	struct mm_struct *mm = vma->vm_mm;
-	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, address, 0);
+	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, address, PVMW_BREAK_COW_PTE);
 	pte_t pteval;
 	struct page *subpage;
 	bool anon_exclusive, ret = true;
@@ -2187,7 +2188,7 @@ static bool page_make_device_exclusive_one(struct folio *folio,
 		struct vm_area_struct *vma, unsigned long address, void *priv)
 {
 	struct mm_struct *mm = vma->vm_mm;
-	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, address, 0);
+	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, address, PVMW_BREAK_COW_PTE);
 	struct make_exclusive_args *args = priv;
 	pte_t pteval;
 	struct page *subpage;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index bf3eedf0209c..15eda32146fd 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1882,7 +1882,8 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 
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

