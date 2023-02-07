Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B6668CDBB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Feb 2023 04:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjBGDzV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Feb 2023 22:55:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjBGDyz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Feb 2023 22:54:55 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145DD36FCD;
        Mon,  6 Feb 2023 19:54:26 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id c10-20020a17090a1d0a00b0022e63a94799so17291825pjd.2;
        Mon, 06 Feb 2023 19:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Fn2XJ6BeCuZXUbdo2K6qkX2BSn2D/fR6IYZR7N3Gdw=;
        b=CCUTutBoo2pbeZ3p1iGL8KlrwP8i3sjy+zx/AKmz1K9JrJ6oIfbvMlkFe++UpZ/o9c
         jLR0f59TMqFDvtBg/ZmOnybfErE0kys1xmXLilQ4FNTfi+LYKDLdIAWZW2V+uXG84A8G
         rJ0AdKYEfh/6NMITd7LBVlt8V4YMumtaI/ciIbWz7MN+mzdB5Mx+rEKHHtpThg8oRG3L
         At7ypimq/NDP8NtbuqqygEIWJ/zadD+1PVG6vwc4ahN51pv4KYtCTrdPMnGhQa4H4iEe
         V0DTtr2SOV4h13OOuEpVbRXS1EibeJGHdSfw/VsQXeEnMfZsXT51uoS1YherAt6a013L
         XX+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Fn2XJ6BeCuZXUbdo2K6qkX2BSn2D/fR6IYZR7N3Gdw=;
        b=VTuC/meU9lRqBuk5m5EwezpGhGMssruvVgQbPLskhLyZt8JexiItjl22JmfmYgzl9Y
         Pmd2FHVqNJFeYUaWUvpPTPmPpXfR29kUnL9x6NNkIlH0zHV/HF1zOgaD6ey+brMd31hT
         P+A8zcagzSKDXh48oPDkLEpKj8v3cysGxLjvJWSiGSPF+twQPqDOfsIV3s2FwpopnaV0
         kJxPZL8g5cDTQhP1LRuwcgdyxMm1SeBBOzJ+sxLQdJnY3ysHGqLgKIbvXw1SOESm6WT1
         8hxtSswDZSWdSYKstABMwbehFRC3VSfoZe4v2Xkk5SLot945QT5lQP56GID1wd1gkkKA
         wIqA==
X-Gm-Message-State: AO0yUKWLv9g+CDV2G7s21rTfbj7JumHKVxDNew+NCmhUq8/bVE8ZVczc
        M6Nx3F86Aol7OXlwXzuEUBk=
X-Google-Smtp-Source: AK7set8H/+HhL0xGcMIRPsUXfCYGK7THtXNOLIHlQ4vaHRULRWfe88k0qBDEJHUrIvleBegMqDXp6Q==
X-Received: by 2002:a17:902:c404:b0:198:c27f:8954 with SMTP id k4-20020a170902c40400b00198c27f8954mr1407914plk.54.1675742062426;
        Mon, 06 Feb 2023 19:54:22 -0800 (PST)
Received: from strix-laptop.hitronhub.home ([123.110.9.95])
        by smtp.googlemail.com with ESMTPSA id q4-20020a170902b10400b0019682e27995sm7647655plr.223.2023.02.06.19.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 19:54:21 -0800 (PST)
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
Subject: [PATCH v4 09/14] mm/mprotect: Break COW PTE before changing protection
Date:   Tue,  7 Feb 2023 11:51:34 +0800
Message-Id: <20230207035139.272707-10-shiyn.lin@gmail.com>
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

If the PTE table is COW-ed, break it before changing the protection.

Signed-off-by: Chih-En Lin <shiyn.lin@gmail.com>
---
 mm/mprotect.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 61cf60015a8b..8b18cd0e5c5e 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -103,6 +103,9 @@ static unsigned long change_pte_range(struct mmu_gather *tlb,
 	if (pmd_trans_unstable(pmd))
 		return 0;
 
+	if (break_cow_pte(vma, pmd, addr))
+		return 0;
+
 	/*
 	 * The pmd points to a regular pte so the pmd can't change
 	 * from under us even if the mmap_lock is only hold for
@@ -314,6 +317,12 @@ static inline int pmd_none_or_clear_bad_unless_trans_huge(pmd_t *pmd)
 		return 1;
 	if (pmd_trans_huge(pmdval))
 		return 0;
+	/*
+	 * If the entry point to COW-ed PTE, it's write protection bit
+	 * will cause pmd_bad().
+	 */
+	if (!pmd_write(pmdval))
+		return 0;
 	if (unlikely(pmd_bad(pmdval))) {
 		pmd_clear_bad(pmd);
 		return 1;
-- 
2.34.1

