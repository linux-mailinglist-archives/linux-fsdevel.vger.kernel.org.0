Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35BEE6E25B6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 16:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbjDNO2Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 10:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjDNO1n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:27:43 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E66CC27;
        Fri, 14 Apr 2023 07:27:00 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id y6so17360091plp.2;
        Fri, 14 Apr 2023 07:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681482418; x=1684074418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dmHQTVbWw4YJlaNGarehFo5gsGgag0lLmmC2sUNSy5Y=;
        b=Rg/JhHpRFP6NIoGwm8nSvdS97FJcuj54dkHXyU7p5Et6BsX8Y9CS79uGrfUmlS+JAL
         hPa+a+/WivLZ888Jgxh5bYaernMZCgxjwb6UiAJIg+o7J8xsb26hyzcAQGcdrRDrWPni
         qAx/B+FYNu3GQx+8coAUZg7QUzb86cyQ6xyA9cGOrVU+5F5TvZM8zXeYjs3NfX13Npqo
         bUkbOI/uzjodhpPk7flzky6o5Bn/RWd94kPtge56rFxlfVjiZwagW4fP1Ra7E8uq6m3p
         xS7lqJYVqdKFKA4LdZGqWW4hjdpjXCYPbiDtCuRbf0Arcl1cQTSkZlFTBu9DDfP/aL+W
         WL1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681482418; x=1684074418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dmHQTVbWw4YJlaNGarehFo5gsGgag0lLmmC2sUNSy5Y=;
        b=iUonSlTBPWbCa/9d8ZmkzWFyhNV/hGokH5v4WSwwzG/8Wrgyl3uWlj6JYpmm3bpvNf
         CKRVBIUqLeAlVxKPXtUBZZS866iM5K0drTPyjdfio/cU5pC6DpH2lABeUoMpS9+ovGTW
         MrQmgqy6lOzSwigaddGyHonSTiWEaQ9uMROXiZKOAl1mpb93yWtKoXRs6D8ihfMcLYKz
         dmvxYJbPuGJMa+H1xGWb77dO1DOJGX1/RL4PbU99ZdrgIhLP4MZJuM2Qj8agA6fbtjf8
         ykzWrXZal0s/X10bzQZR72xSLHbyLjGfo0yLdtQEpUqJBXXBszn9KPiSA3YsRAE6oJR6
         WeYQ==
X-Gm-Message-State: AAQBX9cUDE+ZEshlaugIeQ1+dqhesHHPgs0B6Ujm2lBwdG6U/dm86n/8
        ucdpLC/Yi5Yma7WhPTijwPY=
X-Google-Smtp-Source: AKy350abULEhuTKLG0Ici+w1lLZw7xKikgteau1wnZf/Xw2onMLRl5rBE0j5qE6rGm+yWTHui+5XfQ==
X-Received: by 2002:a17:90a:7443:b0:247:271:c3f4 with SMTP id o3-20020a17090a744300b002470271c3f4mr5656869pjk.2.1681482418095;
        Fri, 14 Apr 2023 07:26:58 -0700 (PDT)
Received: from strix-laptop.. (2001-b011-20e0-1499-8303-7502-d3d7-e13b.dynamic-ip6.hinet.net. [2001:b011:20e0:1499:8303:7502:d3d7:e13b])
        by smtp.googlemail.com with ESMTPSA id h7-20020a17090ac38700b0022335f1dae2sm2952386pjt.22.2023.04.14.07.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 07:26:57 -0700 (PDT)
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
Subject: [PATCH v5 17/17] mm: Check the unexpected modification of COW-ed PTE
Date:   Fri, 14 Apr 2023 22:23:41 +0800
Message-Id: <20230414142341.354556-18-shiyn.lin@gmail.com>
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

In the most of the cases, we don't expect any write access to COW-ed PTE
table. To prevent this, add the new modification check to the page table
check.

But, there are still some of valid reasons where we might want to modify
COW-ed PTE tables. Therefore, add the enable/disable function to the
check.

Signed-off-by: Chih-En Lin <shiyn.lin@gmail.com>
---
 arch/x86/include/asm/pgtable.h   |  1 +
 include/linux/page_table_check.h | 62 ++++++++++++++++++++++++++++++++
 mm/memory.c                      |  4 +++
 mm/page_table_check.c            | 58 ++++++++++++++++++++++++++++++
 4 files changed, 125 insertions(+)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 7425f32e5293..6b323c672e36 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1022,6 +1022,7 @@ static inline pud_t native_local_pudp_get_and_clear(pud_t *pudp)
 static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
 			      pte_t *ptep, pte_t pte)
 {
+	cowed_pte_table_check_modify(mm, addr, ptep, pte);
 	page_table_check_pte_set(mm, addr, ptep, pte);
 	set_pte(ptep, pte);
 }
diff --git a/include/linux/page_table_check.h b/include/linux/page_table_check.h
index 01e16c7696ec..4a54dc454281 100644
--- a/include/linux/page_table_check.h
+++ b/include/linux/page_table_check.h
@@ -113,6 +113,54 @@ static inline void page_table_check_pte_clear_range(struct mm_struct *mm,
 	__page_table_check_pte_clear_range(mm, addr, pmd);
 }
 
+#ifdef CONFIG_COW_PTE
+void __check_cowed_pte_table_enable(pte_t *ptep);
+void __check_cowed_pte_table_disable(pte_t *ptep);
+void __cowed_pte_table_check_modify(struct mm_struct *mm, unsigned long addr,
+				    pte_t *ptep, pte_t pte);
+
+static inline void check_cowed_pte_table_enable(pte_t *ptep)
+{
+	if (static_branch_likely(&page_table_check_disabled))
+		return;
+
+	__check_cowed_pte_table_enable(ptep);
+}
+
+static inline void check_cowed_pte_table_disable(pte_t *ptep)
+{
+	if (static_branch_likely(&page_table_check_disabled))
+		return;
+
+	__check_cowed_pte_table_disable(ptep);
+}
+
+static inline void cowed_pte_table_check_modify(struct mm_struct *mm,
+						unsigned long addr,
+						pte_t *ptep, pte_t pte)
+{
+	if (static_branch_likely(&page_table_check_disabled))
+		return;
+
+	__cowed_pte_table_check_modify(mm, addr, ptep, pte);
+}
+#else
+static inline void check_cowed_pte_table_enable(pte_t *ptep)
+{
+}
+
+static inline void check_cowed_pte_table_disable(pte_t *ptep)
+{
+}
+
+static inline void cowed_pte_table_check_modify(struct mm_struct *mm,
+						unsigned long addr,
+						pte_t *ptep, pte_t pte)
+{
+}
+#endif /* CONFIG_COW_PTE */
+
+
 #else
 
 static inline void page_table_check_alloc(struct page *page, unsigned int order)
@@ -162,5 +210,19 @@ static inline void page_table_check_pte_clear_range(struct mm_struct *mm,
 {
 }
 
+static inline void check_cowed_pte_table_enable(pte_t *ptep)
+{
+}
+
+static inline void check_cowed_pte_table_disable(pte_t *ptep)
+{
+}
+
+static inline void cowed_pte_table_check_modify(struct mm_struct *mm,
+						unsigned long addr,
+						pte_t *ptep, pte_t pte)
+{
+}
+
 #endif /* CONFIG_PAGE_TABLE_CHECK */
 #endif /* __LINUX_PAGE_TABLE_CHECK_H */
diff --git a/mm/memory.c b/mm/memory.c
index 7908e20f802a..e62487413038 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1202,10 +1202,12 @@ copy_cow_pte_range(struct vm_area_struct *dst_vma,
 				 * Although, parent's PTE is COW-ed, we should
 				 * still need to handle all the swap stuffs.
 				 */
+				check_cowed_pte_table_disable(src_pte);
 				ret = copy_nonpresent_pte(dst_mm, src_mm,
 							  src_pte, src_pte,
 							  curr, curr,
 							  addr, rss);
+				check_cowed_pte_table_enable(src_pte);
 				if (ret == -EIO) {
 					entry = pte_to_swp_entry(*src_pte);
 					break;
@@ -1223,8 +1225,10 @@ copy_cow_pte_range(struct vm_area_struct *dst_vma,
 			 * copy_present_pte() will determine the mapped page
 			 * should be COW mapping or not.
 			 */
+			check_cowed_pte_table_disable(src_pte);
 			ret = copy_present_pte(curr, curr, src_pte, src_pte,
 					       addr, rss, NULL);
+			check_cowed_pte_table_enable(src_pte);
 			/*
 			 * If we need a pre-allocated page for this pte,
 			 * drop the lock, recover all the entries, fall
diff --git a/mm/page_table_check.c b/mm/page_table_check.c
index 25d8610c0042..5175c7476508 100644
--- a/mm/page_table_check.c
+++ b/mm/page_table_check.c
@@ -14,6 +14,9 @@
 struct page_table_check {
 	atomic_t anon_map_count;
 	atomic_t file_map_count;
+#ifdef CONFIG_COW_PTE
+	atomic_t check_cowed_pte;
+#endif
 };
 
 static bool __page_table_check_enabled __initdata =
@@ -248,3 +251,58 @@ void __page_table_check_pte_clear_range(struct mm_struct *mm,
 		pte_unmap(ptep - PTRS_PER_PTE);
 	}
 }
+
+#ifdef CONFIG_COW_PTE
+void __check_cowed_pte_table_enable(pte_t *ptep)
+{
+	struct page *page = pte_page(*ptep);
+	struct page_ext *page_ext = page_ext_get(page);
+	struct page_table_check *ptc = get_page_table_check(page_ext);
+
+	atomic_set(&ptc->check_cowed_pte, 1);
+	page_ext_put(page_ext);
+}
+
+void __check_cowed_pte_table_disable(pte_t *ptep)
+{
+	struct page *page = pte_page(*ptep);
+	struct page_ext *page_ext = page_ext_get(page);
+	struct page_table_check *ptc = get_page_table_check(page_ext);
+
+	atomic_set(&ptc->check_cowed_pte, 0);
+	page_ext_put(page_ext);
+}
+
+static int check_cowed_pte_table(pte_t *ptep)
+{
+	struct page *page = pte_page(*ptep);
+	struct page_ext *page_ext = page_ext_get(page);
+	struct page_table_check *ptc = get_page_table_check(page_ext);
+	int check = 0;
+
+	check = atomic_read(&ptc->check_cowed_pte);
+	page_ext_put(page_ext);
+
+	return check;
+}
+
+void __cowed_pte_table_check_modify(struct mm_struct *mm, unsigned long addr,
+				    pte_t *ptep, pte_t pte)
+{
+	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
+	pmd_t *pmd;
+
+	if (!test_bit(MMF_COW_PTE, &mm->flags) || !check_cowed_pte_table(ptep))
+		return;
+
+	pgd = pgd_offset(mm, addr);
+	p4d = p4d_offset(pgd, addr);
+	pud = pud_offset(p4d, addr);
+	pmd = pmd_offset(pud, addr);
+
+	if (!pmd_none(*pmd) && !pmd_write(*pmd) && cow_pte_count(pmd) > 1)
+		BUG_ON(!pte_same(*ptep, pte));
+}
+#endif
-- 
2.34.1

