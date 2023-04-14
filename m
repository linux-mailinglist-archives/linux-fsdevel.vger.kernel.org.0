Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8DAA6E25B0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 16:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbjDNO1p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 10:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbjDNO1L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:27:11 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA40BB466;
        Fri, 14 Apr 2023 07:26:32 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id pm7-20020a17090b3c4700b00246f00dace2so10889278pjb.2;
        Fri, 14 Apr 2023 07:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681482390; x=1684074390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rbLbXdRuHfxtXDKPQRm3+FT68gnEt5TFpjsogoRT0lI=;
        b=HmAKDMksf6xnRVcfcxIezwmEPoznukRB4mgVdijUHQ21YemDDShfTmL8ccYJJy/uIv
         m8wcVocb0Vu9eVxKqU1s7MpYGhcuKa+oShTZ+fEaDuq206zVo4U+a6BLfds/qNiJyf9P
         aBJBBXz5pGWdJwCV/ISvkd5f2lPY9+MmyenS3R3CLgKuxE1lM3D7qGDF37xFAjH6b+F4
         3VsNve3Y7ot1RL+o7x7nuJ4ZPPVWRZ9yCgTv0NDTjoGu5zBmi13H0UBJOVTjJJqfyBjX
         eBme7l2CRwYd3A7kXwU5eY0/p3lxE6ieNay2Hkcq0BUNNIpDcn+prGiU5zYTEFJds9wk
         5U3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681482390; x=1684074390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rbLbXdRuHfxtXDKPQRm3+FT68gnEt5TFpjsogoRT0lI=;
        b=MG1A1b6BuApdHyK70zewH85v7y3usbnlluqUZo/wRglrBC6ImPTv9phRjx3khES7P1
         4khJKGBKdAjyGQgTqLQprzNl9tvZ8cxfLs37QqYkXOBr/McDherszCPRNAa02Nm/UA2o
         VqwFq+syFhVY4bIi3xwMNm3cuJnu27HSVPq7vkKb5rOawvxFtUPF4GLDHtlpD0IUEk8y
         QjgOHYWsBZf+Wd7gBom8fdFzstsXESFWqNjUMGMHxuzsWSfYG2K8TaWLdWafA7uWC5Px
         Y85F0bDrPTXw25N7Y+fJP6cNCOKppBSEQ4mrTB0m7F5BQfSs/yciwi97dO3Vs3eJL3UQ
         qcXA==
X-Gm-Message-State: AAQBX9fMNhgc9pYynaOUkGECM5Pm/mWbnJfjWZNE12Jw0xF0TYt0zpwU
        MM/y6PoU4VAFuNmItQ32Q9M=
X-Google-Smtp-Source: AKy350aqLfuqbdu67mJ4nM0k7rzcjp896bC+PGdAfO2G4R7flBKcTTuNhdwRHh+IhJRQkBKzvLByHQ==
X-Received: by 2002:a17:90a:2c05:b0:247:1e1e:57c0 with SMTP id m5-20020a17090a2c0500b002471e1e57c0mr5918775pjd.14.1681482390502;
        Fri, 14 Apr 2023 07:26:30 -0700 (PDT)
Received: from strix-laptop.. (2001-b011-20e0-1499-8303-7502-d3d7-e13b.dynamic-ip6.hinet.net. [2001:b011:20e0:1499:8303:7502:d3d7:e13b])
        by smtp.googlemail.com with ESMTPSA id h7-20020a17090ac38700b0022335f1dae2sm2952386pjt.22.2023.04.14.07.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 07:26:30 -0700 (PDT)
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
Subject: [PATCH v5 14/17] fs/proc: Support COW PTE with clear_refs_write
Date:   Fri, 14 Apr 2023 22:23:38 +0800
Message-Id: <20230414142341.354556-15-shiyn.lin@gmail.com>
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

Before clearing the entry in COW-ed PTE, break COW PTE first.

Signed-off-by: Chih-En Lin <shiyn.lin@gmail.com>
---
 fs/proc/task_mmu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 6a96e1713fd5..c76b74029dfd 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1195,6 +1195,11 @@ static int clear_refs_pte_range(pmd_t *pmd, unsigned long addr,
 	if (pmd_trans_unstable(pmd))
 		return 0;
 
+	/* Only break COW when we modify the soft-dirty bit. */
+	if (cp->type == CLEAR_REFS_SOFT_DIRTY &&
+	    break_cow_pte(vma, pmd, addr))
+		return 0;
+
 	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
 	for (; addr != end; pte++, addr += PAGE_SIZE) {
 		ptent = *pte;
-- 
2.34.1

