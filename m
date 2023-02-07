Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F9168CDB6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Feb 2023 04:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjBGDyv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Feb 2023 22:54:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjBGDy1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Feb 2023 22:54:27 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D13301BF;
        Mon,  6 Feb 2023 19:54:01 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id o13so13713744pjg.2;
        Mon, 06 Feb 2023 19:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=radrNJcEj52EO1Vyn1//3vwMeqorrUn+XF43zRmwQLM=;
        b=e9tBbGrVc6KrCXLirUIwtUWWZ5pScVYwhGOAX85/DTr5qa96neTYfNiaW0Zb/8meJQ
         1pqo78jPkCl06fIq603NmiH73ykIdE4tNysE7jWe+cqbGQoi9HRy5GXSizPwBDnptLs/
         VdPLJ2wnPfV6r6WEDIrm8HmD229QpmDjX+wZ0dIu0qcmHVGfNGsYodK0wfi2wWI5G+SG
         Fm3K4UDmTwirbtiNNPUbhT/BLmCWI8dVf3lP7LNwLlC9pYszNYTHzELutRWlrZWhnAtV
         9JbufIvqryccaNGycUo23FTX14QEl0JPhIjUdPVkkLIlKOzmjCljWGg/3U79rB9jCxhI
         mobw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=radrNJcEj52EO1Vyn1//3vwMeqorrUn+XF43zRmwQLM=;
        b=nv4RjaRjTqNLPqPlPn1MNKb8fQTApY5WWwMpQ+qp6+5jPjZz4e4hacRyhKge4aJAbT
         5kKdk7ifiGwZu8D5dl7ouCIkXx7iPiiPKSXYslaj4B0HZbPtnJXd5srYfKz9IkyCponI
         cZYqWI/MI9ETYzeLHVTxjGihBzlrxyBG4WO67Yqg94n7fCVZ2NL3H/cVGj56j/P3k2IJ
         vtcjx4wTG47juGg51WaDPWwkNod3OmwlgfSscdKG5L2Jk1T/NJEM+h9dCkdxP0T+bQa6
         n9mWq51eKsOEU7Pf8xXP3pUL4d5eeWHWhyR+g/DrmvwmPz9prOMC7dF9j55VHK4QU1bK
         KBRA==
X-Gm-Message-State: AO0yUKWoaVhb9TcNzDN1rsekTmwOOGQiDcmcZjYFiU5FQ7XZonfkwwkW
        5V2WPeYqbK0zO4fQsl1+K34=
X-Google-Smtp-Source: AK7set/ZfBJEIGUrpJL8s7VUE/4LvMWeWo6c88SMYAKDr4tnwSgq7/tvhA0ZTlIbSkN1+Fz2FrhpsQ==
X-Received: by 2002:a17:902:e2c2:b0:199:1219:1568 with SMTP id l2-20020a170902e2c200b0019912191568mr1103226plc.4.1675742040504;
        Mon, 06 Feb 2023 19:54:00 -0800 (PST)
Received: from strix-laptop.hitronhub.home ([123.110.9.95])
        by smtp.googlemail.com with ESMTPSA id q4-20020a170902b10400b0019682e27995sm7647655plr.223.2023.02.06.19.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 19:53:59 -0800 (PST)
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
Subject: [PATCH v4 07/14] mm/madvise: Handle COW-ed PTE with madvise()
Date:   Tue,  7 Feb 2023 11:51:32 +0800
Message-Id: <20230207035139.272707-8-shiyn.lin@gmail.com>
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
index b6ea204d4e23..8b815942f286 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -428,6 +428,9 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 	if (pmd_trans_unstable(pmd))
 		return 0;
 #endif
+	if (break_cow_pte(vma, pmd, addr))
+		return 0;
+
 	tlb_change_page_size(tlb, PAGE_SIZE);
 	orig_pte = pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
 	flush_tlb_batched_pending(mm);
@@ -629,6 +632,10 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 	if (pmd_trans_unstable(pmd))
 		return 0;
 
+	/* We should only allocate PTE. */
+	if (break_cow_pte(vma, pmd, addr))
+		goto next;
+
 	tlb_change_page_size(tlb, PAGE_SIZE);
 	orig_pte = pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
 	flush_tlb_batched_pending(mm);
@@ -989,6 +996,12 @@ static long madvise_remove(struct vm_area_struct *vma,
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

