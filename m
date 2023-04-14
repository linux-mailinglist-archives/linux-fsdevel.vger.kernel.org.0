Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7096E25AA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 16:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjDNO1N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 10:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbjDNO0j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:26:39 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C79A5DE;
        Fri, 14 Apr 2023 07:26:04 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id v9so23781319pjk.0;
        Fri, 14 Apr 2023 07:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681482363; x=1684074363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JhJhY1i1X+rQfu4Bn4P5O3hneE5Ahqf44H1V3MlMZSE=;
        b=WVSBGvQEWeeZCzJHUSLw6TdU7X7htMEhqLVUOYjuOm5exiNC5ijdRkufnNFt84Bcvp
         nBa+HXyOE083VwztPKaRnxXoBufXzhDqGmx5EU3nQdOfFARZyba4elQgihG66ZdIP+us
         AWQNBgqB3ZgRwKcjr/anLW7Yt0XHKvMOhoHHSJ+HOxL3sObVLefIP9AIAVNCeVEtEv1h
         XIqwvMreBHtnZXG4BLKofcPieosXJ8aJJOZrrwvezai6c/gmMsNouFT0iBOD95fZd4ZF
         KiC837Ko9b7VgCfyYEEiAshz0fl07KLeKm1Og9HKhxYYplg/Ram9QSDXV5nmw7PrXhcj
         UxEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681482363; x=1684074363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JhJhY1i1X+rQfu4Bn4P5O3hneE5Ahqf44H1V3MlMZSE=;
        b=I3yWmk9/SnuWH4NgGe/+okpq54cUPsfNpqIcFmHifKA1FfwZZ7KAwF2ybTXSpjvd/N
         GG3BtDGjhDKwGiXFS3bVKAdycnUK/yYnBDp0xB9JXlpJVWwgwuKgrfvBTMYsetvlFpEV
         gIlTsNa9mnDW8YgjN4e3zKcuEtWxEpsrI9b6o9x+sW2vlqrJVf2Ew0LFW6IhvKoCF+d4
         F/a3vGHUWNbh3XDRaGBYBVEFBpHiMoSVOc8/LvKIhb7JOP0ZLVrI1aeBZadllmjN8w2X
         IRTEfCLAEEIYdGSSrybFatLVqsdCMO+yU+oiz5NZsRs//BVklMxfFrgf1ztxR3k6YXPC
         bjjA==
X-Gm-Message-State: AAQBX9esOUpz2Nj3PX+L3kYvJCBkcBpLxU8H133ucw/GKr8+KndtpioT
        +dwIOBxcWSWSRl0qlDwHN2s=
X-Google-Smtp-Source: AKy350Y3WXBAfHkfEIZhG0ei3Tp0PNc3fK1Ni3ksxBjZThrmtWAJdx1hd2dMChF2jmP20depYO7fIQ==
X-Received: by 2002:a17:90a:5b12:b0:244:9385:807f with SMTP id o18-20020a17090a5b1200b002449385807fmr5616908pji.44.1681482362745;
        Fri, 14 Apr 2023 07:26:02 -0700 (PDT)
Received: from strix-laptop.. (2001-b011-20e0-1499-8303-7502-d3d7-e13b.dynamic-ip6.hinet.net. [2001:b011:20e0:1499:8303:7502:d3d7:e13b])
        by smtp.googlemail.com with ESMTPSA id h7-20020a17090ac38700b0022335f1dae2sm2952386pjt.22.2023.04.14.07.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 07:26:02 -0700 (PDT)
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
Subject: [PATCH v5 11/17] mm/mprotect: Break COW PTE before changing protection
Date:   Fri, 14 Apr 2023 22:23:35 +0800
Message-Id: <20230414142341.354556-12-shiyn.lin@gmail.com>
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

If the PTE table is COW-ed, break it before changing the protection.

Signed-off-by: Chih-En Lin <shiyn.lin@gmail.com>
---
 mm/mprotect.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 13e84d8c0797..a33f23a73fa5 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -103,6 +103,9 @@ static long change_pte_range(struct mmu_gather *tlb,
 	if (pmd_trans_unstable(pmd))
 		return 0;
 
+	if (break_cow_pte(vma, pmd, addr))
+		return 0;
+
 	/*
 	 * The pmd points to a regular pte so the pmd can't change
 	 * from under us even if the mmap_lock is only hold for
@@ -312,6 +315,12 @@ static inline int pmd_none_or_clear_bad_unless_trans_huge(pmd_t *pmd)
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

