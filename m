Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793AC6E25B2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 16:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbjDNO1y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 10:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjDNO1V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:27:21 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E17C14C;
        Fri, 14 Apr 2023 07:26:41 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id p17so7278698pla.3;
        Fri, 14 Apr 2023 07:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681482400; x=1684074400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pkKoN7JGClqVnt1AeoWnxp66FVN/o5YfrH8QxbWcJ4w=;
        b=GRybeaFMg+Tlp7YS9TVn4xA45yiEJL0qMT1inOuLZsGOXPVD2E/YaXnYcgYTXRUz//
         QvmpHhgCwPci58KuGNuLYdFMpZPK6bnXEcnxiRsfm/bCSZrOLaHnj/SEZDBWYisnuRM2
         +DmqjELMmOt4orXaPNd0id1kWz9cyVowFUg4AyBtYjiUc+UmYRPdjKRwUOeizBqMFH1Y
         7D+lI6PErU4cZ0n1S53tvBs5zsPXdak3yH0KqfblvcF/6rQEuvpqrSOwPDxRwOk2GHaL
         +RbWVZRrlnha4CkqVW6/HiukXtBUoOII7B692mHbsqKGp5WGuHfv+sJ9KmHFUGHLUnyc
         jtWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681482400; x=1684074400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pkKoN7JGClqVnt1AeoWnxp66FVN/o5YfrH8QxbWcJ4w=;
        b=AEbkhT1zxlE560LGxj1aMgVQVpWCcAFl5hpsAGqlbAab3XCB1LSwz/Q9klw8851QD+
         XNd0d/d9S7d2mr+fFF9vpM78obyYtAN6YqzLzGoODfxLr9oLG+hIpgX34I3N4CQvEtO0
         Fz9EwH2Akc8uhTA5Xid6tD6ylVt7BLZNSLqxljlTYnncaEKhS6Vnf+55moIRnTx5zUp2
         veVswsYcVgG/Q/wQiK1twLGvYQoceJwFFL3oXflC6JCryLGSGnNlKUv/RSvtSdlCNuov
         re3uR1PbqO8wabjDS5lpKDaL1e7lWu3qBP8z25MdxWXbi1uWM/89Os1HbEOPARnQ5xU9
         yJXw==
X-Gm-Message-State: AAQBX9dRR1fNjs8pKcBYPLK1iT4nCjoj/O7StaiFCvq92l8eFX2vpQB7
        CpD1uLnCa5C/xMxSvHfCkrA=
X-Google-Smtp-Source: AKy350Y5ToRmeTXJN5+SiXzLMP/O2AXtSNTAG2ikMyRrX7oX9xVsgnswEEqRZu4VkIFIeAnepJcLLg==
X-Received: by 2002:a17:90b:19c3:b0:246:cf0c:ecd7 with SMTP id nm3-20020a17090b19c300b00246cf0cecd7mr5668320pjb.16.1681482399689;
        Fri, 14 Apr 2023 07:26:39 -0700 (PDT)
Received: from strix-laptop.. (2001-b011-20e0-1499-8303-7502-d3d7-e13b.dynamic-ip6.hinet.net. [2001:b011:20e0:1499:8303:7502:d3d7:e13b])
        by smtp.googlemail.com with ESMTPSA id h7-20020a17090ac38700b0022335f1dae2sm2952386pjt.22.2023.04.14.07.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 07:26:39 -0700 (PDT)
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
Subject: [PATCH v5 15/17] events/uprobes: Break COW PTE before replacing page
Date:   Fri, 14 Apr 2023 22:23:39 +0800
Message-Id: <20230414142341.354556-16-shiyn.lin@gmail.com>
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

Break COW PTE if we want to replace the page which
resides in COW-ed PTE.

Signed-off-by: Chih-En Lin <shiyn.lin@gmail.com>
---
 kernel/events/uprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 59887c69d54c..db6bfaab928d 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -156,7 +156,7 @@ static int __replace_page(struct vm_area_struct *vma, unsigned long addr,
 	struct folio *old_folio = page_folio(old_page);
 	struct folio *new_folio;
 	struct mm_struct *mm = vma->vm_mm;
-	DEFINE_FOLIO_VMA_WALK(pvmw, old_folio, vma, addr, 0);
+	DEFINE_FOLIO_VMA_WALK(pvmw, old_folio, vma, addr, PVMW_BREAK_COW_PTE);
 	int err;
 	struct mmu_notifier_range range;
 
-- 
2.34.1

