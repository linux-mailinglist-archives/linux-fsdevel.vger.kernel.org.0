Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE6E6E25A4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 16:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjDNO0o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 10:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbjDNO0Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:26:16 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0B4CC21;
        Fri, 14 Apr 2023 07:25:45 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id w11so18965495pjh.5;
        Fri, 14 Apr 2023 07:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681482344; x=1684074344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kpWPxfuvaIk0mWPLrjy7A4XPzxhA7fLlfGdW1mVCUr4=;
        b=hh51/J2GfHz8TwBXTTAD8ByIt7vqu+CJYMOv8Gn6VP6zDZ8jsx1AQK/YylhhDx4Yy+
         0CRLCxANjdDWRbaxrpOrHOgnYRD+lcAf3QSkDS3YbWO/xcoE3Gbv43mriuPlxclwVTP9
         phx5iCBpOFU3ljdbu0G2CPDJwoQgv/dk9OnKHsSHbvxVBZS7ab+FJCrdG2Pr8gDTkNbA
         cLPqeTL9RK1Gw4vF6qbn/cWyXpQXTI1KYeztWpb3aEC0oy5a7FRBFGm+8ZwfNEXjkHbL
         Rw88PFqPGh3pJ+S1C9QijWHos/UCC72XeH/rxFcOom0qMDyPSeMXOfp7PnqjaxjFryYV
         7CUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681482344; x=1684074344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kpWPxfuvaIk0mWPLrjy7A4XPzxhA7fLlfGdW1mVCUr4=;
        b=TY1NK6FePlkw/ygUqZeuSi5bhpMlTOFr12TsPVicX2pxQHse6S2kys73OhatSfhYg7
         YOkXrTpgk1o2OaK3aIBkMQH81ZDFXl7AABV80MWAFarAcTNtUuZpso98Hxh4SfJIdj2W
         Y+Uwvqk1JhQRgn9MozLR/jBw0tgNtye0wobDSMLKnfb944MsvL/do19scY8/j+Te1ufl
         nIHstgVc+bZh07ivfho9Eub+42zLtpxX31HWSgCJZ5KJEtc0mTJH5qJ1UJrvm6svgWxJ
         +9gYS2bZm7UTXuGzjdmv6vSu3mDv7Y+q5JjnyUJAABXymbphTDWvlpgZWR91DZs1McUq
         X3WA==
X-Gm-Message-State: AAQBX9ePj4M6d7TEvndTtoGdrSAzGgThUcsztPCiutpWHNpOjr9inxWs
        SlDwcUrM8+8iB+EhcsaJQ0Q=
X-Google-Smtp-Source: AKy350aBdG9vJ3XmlVaPR+W/QhjaJcPhPOUy0mPoGFQqm07k6eNoRRTZfMByKXsSMfstD+2cplrm3g==
X-Received: by 2002:a17:90a:4925:b0:23f:7ff6:eba with SMTP id c34-20020a17090a492500b0023f7ff60ebamr5879955pjh.0.1681482344318;
        Fri, 14 Apr 2023 07:25:44 -0700 (PDT)
Received: from strix-laptop.. (2001-b011-20e0-1499-8303-7502-d3d7-e13b.dynamic-ip6.hinet.net. [2001:b011:20e0:1499:8303:7502:d3d7:e13b])
        by smtp.googlemail.com with ESMTPSA id h7-20020a17090ac38700b0022335f1dae2sm2952386pjt.22.2023.04.14.07.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 07:25:43 -0700 (PDT)
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
Subject: [PATCH v5 09/17] mm/madvise: Handle COW-ed PTE with madvise()
Date:   Fri, 14 Apr 2023 22:23:33 +0800
Message-Id: <20230414142341.354556-10-shiyn.lin@gmail.com>
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

Break COW PTE if madvise() modify the pte entry of COW-ed PTE.
Following are the list of flags which need to break COW PTE. However,
like MADV_HUGEPAGE and MADV_MERGEABLE, we should handle it respectively.

- MADV_DONTNEED: It calls to zap_page_range() which already be handled.
- MADV_FREE: It uses walk_page_range() with madvise_free_pte_range() to
	     free the page by itself, so add break_cow_pte().
- MADV_REMOVE: Same as MADV_FREE, it remove the page by itself, so add
	       break_cow_pte_range().
- MADV_COLD: Similar to MAD_FREE, break COW PTE before pageout.
- MADV_POPULATE: Let GUP deal with it.

Signed-off-by: Chih-En Lin <shiyn.lin@gmail.com>
---
 mm/madvise.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/mm/madvise.c b/mm/madvise.c
index 340125d08c03..71176edb751e 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -425,6 +425,9 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 	if (pmd_trans_unstable(pmd))
 		return 0;
 #endif
+	if (break_cow_pte(vma, pmd, addr))
+		return 0;
+
 	tlb_change_page_size(tlb, PAGE_SIZE);
 	orig_pte = pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
 	flush_tlb_batched_pending(mm);
@@ -625,6 +628,10 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 	if (pmd_trans_unstable(pmd))
 		return 0;
 
+	/* We should only allocate PTE. */
+	if (break_cow_pte(vma, pmd, addr))
+		goto next;
+
 	tlb_change_page_size(tlb, PAGE_SIZE);
 	orig_pte = pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
 	flush_tlb_batched_pending(mm);
@@ -984,6 +991,12 @@ static long madvise_remove(struct vm_area_struct *vma,
 	if ((vma->vm_flags & (VM_SHARED|VM_WRITE)) != (VM_SHARED|VM_WRITE))
 		return -EACCES;
 
+	error = break_cow_pte_range(vma, start, end);
+	if (error < 0)
+		return error;
+	else if (error > 0)
+		return -ENOMEM;
+
 	offset = (loff_t)(start - vma->vm_start)
 			+ ((loff_t)vma->vm_pgoff << PAGE_SHIFT);
 
-- 
2.34.1

