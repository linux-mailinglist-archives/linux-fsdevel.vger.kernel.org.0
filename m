Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F846E259C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 16:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbjDNOZx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 10:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbjDNOZf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:25:35 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A945C159;
        Fri, 14 Apr 2023 07:25:08 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id z11-20020a17090abd8b00b0024721c47ceaso4803623pjr.3;
        Fri, 14 Apr 2023 07:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681482307; x=1684074307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dV/mcZq3W0H+ZVjv4/WnTWEPlbKKMR+weOFNfLWMeuE=;
        b=BQzfiDtPhE/M68lDOGSaU8+eH4GXZloBn+mcpK/aB1N6LYOdAjEHlkaXhXyCfvnuvb
         CEpHvh+6L7eTtlX4yjqbuSmzGdE8fDpHFFYGnZbcZ6MNJT9ylYo2GZtipXJ+6+UzOHTP
         D9tDXMnJaFlxK7VzjklsrLI+Av/83wf+aOZbs0pt3RSvdic9m6nNNQPQNVFeZpQ+CdQC
         995Zkm9AnPgmLkqehhkRv+/kwi2qGfOnf/V+BnSYKMp7WXLrh660WuQiac7blN5+7+zM
         OxDurW2yAjeOkZJcY9VilooGc5d9qjlhXDXtnE3QoGRPpuKLJN+X+vr5d2OKSx411qOk
         mH+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681482307; x=1684074307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dV/mcZq3W0H+ZVjv4/WnTWEPlbKKMR+weOFNfLWMeuE=;
        b=PncXfUVSv4SOYf3jdUX0J4/cn3EljQIX9CeIJfVVkBnOldqJcpOoqmRqK+GFyUxA2/
         uGuGxRxk0rb2AAg14iqE3Laa/F15zI0hQpFWxh2wKbqelbZF5+c3r5XDcoNh/Gc8xbqX
         nZcFa7mAlSekRCI5ckUlK1rBbI/hn/9vnrJsQcORP22xXD834IT++R32bgYtfNn9STgJ
         Qd6Ozlp87AZfXUTzEMJfUvnFTBHUXIuhgoN2CSITq2cZ7OEC8503x7ckP3LRVY8o0d0H
         2bR7i9oOw1BhGD/39gmunyZDqslab/v1FlfEM3HK6lRAzYbGUSU2QcHMZpsItktuKAIq
         Qg2g==
X-Gm-Message-State: AAQBX9fILVNpyWWN90rMbvcZoeligUZojvtgYqb5EvDnPOD0asfqCa68
        hz7AJ9CMmTfF/tCFM6t+Img=
X-Google-Smtp-Source: AKy350aLkOiAuG932gYmw+BNYfvRwYLr6hT7jeWvEtEaIuQt7YrDBI1fGEqKpu+mP4tyXM4ARraeiA==
X-Received: by 2002:a17:902:ce89:b0:19f:2dff:21a4 with SMTP id f9-20020a170902ce8900b0019f2dff21a4mr3285427plg.16.1681482307277;
        Fri, 14 Apr 2023 07:25:07 -0700 (PDT)
Received: from strix-laptop.. (2001-b011-20e0-1499-8303-7502-d3d7-e13b.dynamic-ip6.hinet.net. [2001:b011:20e0:1499:8303:7502:d3d7:e13b])
        by smtp.googlemail.com with ESMTPSA id h7-20020a17090ac38700b0022335f1dae2sm2952386pjt.22.2023.04.14.07.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 07:25:06 -0700 (PDT)
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
Subject: [PATCH v5 05/17] mm: Handle COW-ed PTE during zapping
Date:   Fri, 14 Apr 2023 22:23:29 +0800
Message-Id: <20230414142341.354556-6-shiyn.lin@gmail.com>
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

To support the zap functionally for COW-ed PTE, we need to zap the
entire PTE table each time instead of partially zapping pages.
Therefore, if the zap range covers the entire PTE table, we can
handle de-account, remove the rmap, etc. However we shouldn't modify
the entries when there are still someone references to the COW-ed
PTE. Otherwise, if only the zapped process references to this COW-ed
PTE, we just reuse it and do the normal zapping.

Signed-off-by: Chih-En Lin <shiyn.lin@gmail.com>
---
 mm/memory.c | 92 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 87 insertions(+), 5 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index f8a87a0fc382..7908e20f802a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -192,6 +192,12 @@ static inline void free_pmd_range(struct mmu_gather *tlb, pud_t *pud,
 	pmd = pmd_offset(pud, addr);
 	do {
 		next = pmd_addr_end(addr, end);
+#ifdef CONFIG_COW_PTE
+		if (test_bit(MMF_COW_PTE, &tlb->mm->flags)) {
+			if (!pmd_none(*pmd) && !pmd_write(*pmd))
+				VM_WARN_ON(cow_pte_count(pmd) != 1);
+		}
+#endif
 		if (pmd_none_or_clear_bad(pmd))
 			continue;
 		free_pte_range(tlb, pmd, addr);
@@ -1656,6 +1662,7 @@ zap_install_uffd_wp_if_needed(struct vm_area_struct *vma,
 
 #define ZAP_PTE_INIT 0x0000
 #define ZAP_PTE_FORCE_FLUSH 0x0001
+#define ZAP_PTE_IS_SHARED 0x0002
 
 struct zap_pte_details {
 	pte_t **pte;
@@ -1681,9 +1688,13 @@ zap_present_pte(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	if (unlikely(!should_zap_page(details, page)))
 		return 0;
 
-	ptent = ptep_get_and_clear_full(mm, addr, pte, tlb->fullmm);
+	if (pte_details->flags & ZAP_PTE_IS_SHARED)
+		ptent = ptep_get(pte);
+	else
+		ptent = ptep_get_and_clear_full(mm, addr, pte, tlb->fullmm);
 	tlb_remove_tlb_entry(tlb, pte, addr);
-	zap_install_uffd_wp_if_needed(vma, addr, pte, details, ptent);
+	if (!(pte_details->flags & ZAP_PTE_IS_SHARED))
+		zap_install_uffd_wp_if_needed(vma, addr, pte, details, ptent);
 	if (unlikely(!page))
 		return 0;
 
@@ -1767,8 +1778,10 @@ zap_nopresent_pte(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		/* We should have covered all the swap entry types */
 		WARN_ON_ONCE(1);
 	}
-	pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
-	zap_install_uffd_wp_if_needed(vma, addr, pte, details, ptent);
+	if (!(pte_details->flags & ZAP_PTE_IS_SHARED)) {
+		pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
+		zap_install_uffd_wp_if_needed(vma, addr, pte, details, ptent);
+	}
 }
 
 static unsigned long zap_pte_range(struct mmu_gather *tlb,
@@ -1785,6 +1798,36 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 		.flags = ZAP_PTE_INIT,
 		.pte = &pte,
 	};
+#ifdef CONFIG_COW_PTE
+	unsigned long orig_addr = addr;
+
+	if (test_bit(MMF_COW_PTE, &mm->flags) && !pmd_write(*pmd)) {
+		if (!range_in_vma(vma, addr & PMD_MASK,
+				  (addr + PMD_SIZE) & PMD_MASK)) {
+			/*
+			 * We cannot promise this COW-ed PTE will also be zap
+			 * with the rest of VMAs. So, break COW PTE here.
+			 */
+			break_cow_pte(vma, pmd, addr);
+		} else {
+			/*
+			 * We free the batched memory before we handle
+			 * COW-ed PTE.
+			 */
+			tlb_flush_mmu(tlb);
+			end = (addr + PMD_SIZE) & PMD_MASK;
+			addr = addr & PMD_MASK;
+			start_pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
+			if (cow_pte_count(pmd) == 1) {
+				/* Reuse COW-ed PTE */
+				pmd_t new = pmd_mkwrite(*pmd);
+				set_pmd_at(tlb->mm, addr, pmd, new);
+			} else
+				pte_details.flags |= ZAP_PTE_IS_SHARED;
+			pte_unmap_unlock(start_pte, ptl);
+		}
+	}
+#endif
 
 	tlb_change_page_size(tlb, PAGE_SIZE);
 again:
@@ -1828,7 +1871,16 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 	 */
 	if (pte_details.flags & ZAP_PTE_FORCE_FLUSH) {
 		pte_details.flags &= ~ZAP_PTE_FORCE_FLUSH;
-		tlb_flush_mmu(tlb);
+		/*
+		 * With COW-ed PTE, we defer freeing the batched memory until
+		 * after we have actually cleared the COW-ed PTE's pmd entry.
+		 * Since, if we are the only ones still referencing the COW-ed
+		 * PTe table after we have freed the batched memory, the page
+		 * table check will report a bug with anon_map_count != 0 in
+		 * page_table_check_zero().
+		 */
+		if (!(pte_details.flags & ZAP_PTE_IS_SHARED))
+			tlb_flush_mmu(tlb);
 	}
 
 	if (addr != end) {
@@ -1836,6 +1888,36 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 		goto again;
 	}
 
+#ifdef CONFIG_COW_PTE
+	if (pte_details.flags & ZAP_PTE_IS_SHARED) {
+		start_pte = pte_offset_map_lock(mm, pmd, orig_addr, &ptl);
+		if (!pmd_put_pte(pmd)) {
+			pmd_t new = pmd_mkwrite(*pmd);
+			set_pmd_at(tlb->mm, addr, pmd, new);
+			/*
+			 * We are the only ones who still referencing this.
+			 * Clear the page table check before we free the
+			 * batched memory.
+			 */
+			page_table_check_pte_clear_range(mm, orig_addr, *pmd);
+			pte_unmap_unlock(start_pte, ptl);
+			/* free the batched memory and flush the TLB. */
+			tlb_flush_mmu(tlb);
+			free_pte_range(tlb, pmd, addr);
+		} else {
+			pmd_clear(pmd);
+			pte_unmap_unlock(start_pte, ptl);
+			mm_dec_nr_ptes(tlb->mm);
+			/*
+			 * Someone still referencing to the table,
+			 * we just flush TLB here.
+			 */
+			flush_tlb_range(vma, addr & PMD_MASK,
+					(addr + PMD_SIZE) & PMD_MASK);
+		}
+	}
+#endif
+
 	return addr;
 }
 
-- 
2.34.1

