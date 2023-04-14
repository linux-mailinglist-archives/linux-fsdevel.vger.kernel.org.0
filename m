Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4A46E25A2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 16:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjDNO0a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 10:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjDNO0E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:26:04 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF04EC160;
        Fri, 14 Apr 2023 07:25:35 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id hg12so3951157pjb.2;
        Fri, 14 Apr 2023 07:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681482335; x=1684074335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oPtVqejd8xN45YdR2Q6v6XG0kYjXUF7jvXEtA29Ek40=;
        b=DO2Q+d81fMe4kXw95FsyYMfTz/qUSAi6t2W34rh9XXJe8g3xYfBr+ymjaQ+uYh9eTI
         gHotO5OUPv5kWIbSchNOMjer5oobGqrHJG+prcCHTVFXEpI6y9M0+rge1hgjyuYxoB0u
         wX1SvUVvU2sIJxeGvrr7rS1EZIQVvYq2oa4eABUzfPnn7z8r+qL+fynWlo9OAhrZaHzR
         3jOzOMCHKM1OzWW9i5YbxNsYH1Uk4ufsEhHfEwnQp8mwyPkSVTACUM3lCwWK6IlQbd5Q
         G7EY5aNAMKUNsQAQl+8b7ZKPp2am6ArpZNUTK0p0bV3mimWd5Tg5a3ckqpM3MRvKpkwh
         wEcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681482335; x=1684074335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oPtVqejd8xN45YdR2Q6v6XG0kYjXUF7jvXEtA29Ek40=;
        b=IVrzADRA6p9Bd2wxW9UcrFJcS6/Q9j2mUhI6BW+SvNXO5bxNeNHYdG9f9nE0hAAD88
         RFoBLXh5mxi9hWAnAMYX5kb1zPcI5FXUSjYvZXai5PsYrXXjmYy6T5kPgvFpyPWQ+a0e
         45Zego2K4S2CBiY6pQmNFDBRbYxS524xHZ/bWhaX5Iw6gXgvR2IvZMoH4T7dyGs5bCS5
         NgXFGSKxH6avnCc9zlHLzYRqDd9Dyg9YtUkvmrP1kxieSDk2rXXfpXTYE15AiO+9C6e3
         e16nUb7m1bqIySqvr9P9pFTKYTmp4Gtym1dw9zhNDpM9ilK+5rMo2eGbIhoBydt42Jvl
         QNJA==
X-Gm-Message-State: AAQBX9d22eiNuAL7i6F8EVXg6ZBH/sKzRnY3a6OsSdZoK7RUOl72UkWL
        QNtNSKlWxmEnT83J/z+pLXw=
X-Google-Smtp-Source: AKy350adAdAtgay4aFNJF81hhKV3XEsvf6Y3Gn4taIN+xVDvh1O3itAQNBSXC0EdDJB6K6v4iC1zqg==
X-Received: by 2002:a17:902:d4cc:b0:19f:2dff:2199 with SMTP id o12-20020a170902d4cc00b0019f2dff2199mr3045076plg.68.1681482335057;
        Fri, 14 Apr 2023 07:25:35 -0700 (PDT)
Received: from strix-laptop.. (2001-b011-20e0-1499-8303-7502-d3d7-e13b.dynamic-ip6.hinet.net. [2001:b011:20e0:1499:8303:7502:d3d7:e13b])
        by smtp.googlemail.com with ESMTPSA id h7-20020a17090ac38700b0022335f1dae2sm2952386pjt.22.2023.04.14.07.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 07:25:34 -0700 (PDT)
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
Subject: [PATCH v5 08/17] mm/ksm: Break COW PTE before modify shared PTE
Date:   Fri, 14 Apr 2023 22:23:32 +0800
Message-Id: <20230414142341.354556-9-shiyn.lin@gmail.com>
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

Break COW PTE before merge the page that reside in COW-ed PTE.

Signed-off-by: Chih-En Lin <shiyn.lin@gmail.com>
---
 mm/ksm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 2b8d30068cbb..963ef4d0085d 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1052,7 +1052,7 @@ static int write_protect_page(struct vm_area_struct *vma, struct page *page,
 			      pte_t *orig_pte)
 {
 	struct mm_struct *mm = vma->vm_mm;
-	DEFINE_PAGE_VMA_WALK(pvmw, page, vma, 0, 0);
+	DEFINE_PAGE_VMA_WALK(pvmw, page, vma, 0, PVMW_BREAK_COW_PTE);
 	int swapped;
 	int err = -EFAULT;
 	struct mmu_notifier_range range;
@@ -1169,6 +1169,8 @@ static int replace_page(struct vm_area_struct *vma, struct page *page,
 	barrier();
 	if (!pmd_present(pmde) || pmd_trans_huge(pmde))
 		goto out;
+	if (break_cow_pte(vma, pmd, addr))
+		goto out;
 
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, addr,
 				addr + PAGE_SIZE);
-- 
2.34.1

