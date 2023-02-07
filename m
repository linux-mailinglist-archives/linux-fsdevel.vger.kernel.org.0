Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5963768CDB4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Feb 2023 04:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjBGDyj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Feb 2023 22:54:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjBGDyP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Feb 2023 22:54:15 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD6C36444;
        Mon,  6 Feb 2023 19:53:56 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id e19so6451550plc.9;
        Mon, 06 Feb 2023 19:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P2hiqzbHJQraqi9uwlHzBIrzOyDxCP/J3GJiV5ChdNY=;
        b=bmOC7XUPYoB8TNQF7f0wYym0XRU34TbLiGrQ4u3lU2iawbK3M9Yxa2YG5f2unStsBz
         Gl7fnqxofqZfItKUqy/uxWj4gKzfqEHOiZpN3jsLN+pXOzyJRlfM6RG1F5aqeUQD56rm
         PfpHbRAv5wRzLb7GbK7Dtvb20vGmVB8yYws60BRLU39ZhuDrjQjtjXkww0bx9kbB+KiN
         QLE80k9KYlUBvl3ALbdcdlXaSO/lIoktoU+FuFkbrp/+L0s0YiAKRSdpxRqHHhIKiXS/
         w+LEABWKYLafPT81g2ZVH6IIUA2YjdTap9V5QJ406//JaGKHHilBqrDZ0tSmNSWU2W/P
         LSbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P2hiqzbHJQraqi9uwlHzBIrzOyDxCP/J3GJiV5ChdNY=;
        b=ARhKoWGhnpr1SSdqxLPdfwH+I1mOPopduHKRO2VCESw6Oet394RFkfK+rHIBnqLq54
         Jt7iyTVXPvCC6draj1yTHj6U4whcVJd/S79Y1Yd/5AE8D5DLWFD2nnRlPTbfKaHM3wy5
         XbmlTIpX2fJIhOXWOlxSOryDtq2lKS+4xOssYCaMzJ1TZyYLYcJGpcjk4PO/GyEhfSnI
         WaJnA9bnICDflvwDFJGcOFCWnIqhm2xcCBkJsyR6sE5wVvz0ZFuSYNl5tnYQa6rh7+4H
         hrM48heXh971b++iOG6VDDtJYSy064gJcFOdgNhs8R7CHWFzoR+U/RAhQK6WDjhrXqX7
         0OKw==
X-Gm-Message-State: AO0yUKUFXjuSlg0VJ5ihobnf2cTZ4hXThkZYxqrZ8T11LVRiNAw+tE+z
        lvBjx1uqnVOJLM6acrL0g3Q=
X-Google-Smtp-Source: AK7set9XER72kqQ2uHZQ9Dv9OhzTxcotdKJFhFXMKaajUQO56abILAuY/kvBJuFI6YmYXpde35qWlw==
X-Received: by 2002:a17:902:f691:b0:199:2f45:14fd with SMTP id l17-20020a170902f69100b001992f4514fdmr1033089plg.31.1675742029047;
        Mon, 06 Feb 2023 19:53:49 -0800 (PST)
Received: from strix-laptop.hitronhub.home ([123.110.9.95])
        by smtp.googlemail.com with ESMTPSA id q4-20020a170902b10400b0019682e27995sm7647655plr.223.2023.02.06.19.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 19:53:48 -0800 (PST)
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
Subject: [PATCH v4 06/14] mm/ksm: Break COW PTE before modify shared PTE
Date:   Tue,  7 Feb 2023 11:51:31 +0800
Message-Id: <20230207035139.272707-7-shiyn.lin@gmail.com>
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

Break COW PTE before merge the page that reside in COW-ed PTE.

Signed-off-by: Chih-En Lin <shiyn.lin@gmail.com>
---
 mm/ksm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index dd02780c387f..ce3887d3b04c 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1045,7 +1045,7 @@ static int write_protect_page(struct vm_area_struct *vma, struct page *page,
 			      pte_t *orig_pte)
 {
 	struct mm_struct *mm = vma->vm_mm;
-	DEFINE_PAGE_VMA_WALK(pvmw, page, vma, 0, 0);
+	DEFINE_PAGE_VMA_WALK(pvmw, page, vma, 0, PVMW_BREAK_COW_PTE);
 	int swapped;
 	int err = -EFAULT;
 	struct mmu_notifier_range range;
@@ -1163,6 +1163,8 @@ static int replace_page(struct vm_area_struct *vma, struct page *page,
 	barrier();
 	if (!pmd_present(pmde) || pmd_trans_huge(pmde))
 		goto out;
+	if (break_cow_pte(vma, pmd, addr))
+		goto out;
 
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, mm, addr,
 				addr + PAGE_SIZE);
-- 
2.34.1

