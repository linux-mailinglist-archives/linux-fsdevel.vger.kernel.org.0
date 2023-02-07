Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B0768CDC7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Feb 2023 04:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjBGD4X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Feb 2023 22:56:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjBGDz7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Feb 2023 22:55:59 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEFC37541;
        Mon,  6 Feb 2023 19:55:28 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id rm7-20020a17090b3ec700b0022c05558d22so13497293pjb.5;
        Mon, 06 Feb 2023 19:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mqI9CX9OCLRhinZW0rV2yxCcmMTFndJVCdpXa5ZUnco=;
        b=o8ui0BwXjQb6Xz0+sV/XmAtBjIzgRNhLYPdfI9IHudkrwl5gTXpIpMOvolOaL9acRP
         XCdxnPWLWgJw0ORyp798XI/vdNQuP73eC52jwImCAT0YkmN/TUT0tUbkJMmm/mxAgpS0
         XwxXjspo5I4w92K8TbwcdAFn+fv7U2jGlSP77xhKOI9/9crgO40/0FZOrKoybVWuIL8t
         fgIES6vwRi5iZ+RJVoHMkoDuT77EbnvzOn3Wgu+tVadR852ojkBEAyXwqTWHEvQ+/F9D
         oEoa54gTUp2x7VmLp0YL5AnlSdnytBXcKlTuEBzoyN6tEHrZwBETmGO0jD6Kw2tysYBO
         mLpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mqI9CX9OCLRhinZW0rV2yxCcmMTFndJVCdpXa5ZUnco=;
        b=FqKLPSr6YSBVPN7QFrgMu3ZfT2gOq9KxJ8qV2CvYR24T+OWQx8g+BSzt7L2JfIa1rX
         d+8reyEYiJ0P8zkhu+5n4+PxzCGB+Jb1aszv0NQKS/acON/ToWtk2FLFUcByXuIG9XOA
         jNq+DHHhz8A4UYOhJ1qgCzerIfqBrry5Q+yq0fA3Ybkd4DYAP4UV8rf42ozaK07Lyf8G
         kuqsMERA0oXmVohheDuu5qnq49ocLdd0UphQRxD9Whl1gRZ8DxbiUAYHi5IVJXYA+9Vp
         OAbCs+Iy+p7zRvqAb1zsDvHUrzaOzOxPE3G1gUxk84XPsZZtHQOJ9sthzBqPRSkOR7RZ
         h51w==
X-Gm-Message-State: AO0yUKUbIAeiYS24QtrKikq7vQU6wk8V/lcNJRtnx0VA7BZqaGF1bfxA
        CPZ/0w3XsakVYh3N0R1Fv/A=
X-Google-Smtp-Source: AK7set8xEIMQnqgw2pXG5HFkn5MnGyHjDBNyhDZPYQWQM7saiWZRxmBOABnr1379qxiruU1f4ByBsQ==
X-Received: by 2002:a17:903:32c9:b0:196:1425:740c with SMTP id i9-20020a17090332c900b001961425740cmr1762111plr.62.1675742128059;
        Mon, 06 Feb 2023 19:55:28 -0800 (PST)
Received: from strix-laptop.hitronhub.home ([123.110.9.95])
        by smtp.googlemail.com with ESMTPSA id q4-20020a170902b10400b0019682e27995sm7647655plr.223.2023.02.06.19.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 19:55:27 -0800 (PST)
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
Subject: [PATCH v4 14/14] mm: fork: Enable COW PTE to fork system call
Date:   Tue,  7 Feb 2023 11:51:39 +0800
Message-Id: <20230207035139.272707-15-shiyn.lin@gmail.com>
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

This patch enables the Copy-On-Write (COW) mechanism to the PTE table
in fork system call. To let the process do COW PTE fork, use
prctl(PR_SET_COW_PTE), it will set the MMF_COW_PTE_READY flag to the
process for enabling COW PTE during the next time of fork.

It uses the MMF_COW_PTE flag to distinguish the normal page table
and the COW one. Moreover, it is difficult to distinguish whether all
the page tables is out of COW state. So the MMF_COW_PTE flag won't be
disabled after setup.

Signed-off-by: Chih-En Lin <shiyn.lin@gmail.com>
---
 kernel/fork.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/fork.c b/kernel/fork.c
index 9f7fe3541897..94c35c8b31b1 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2678,6 +2678,13 @@ pid_t kernel_clone(struct kernel_clone_args *args)
 			trace = 0;
 	}
 
+#ifdef CONFIG_COW_PTE
+	if (current->mm && test_bit(MMF_COW_PTE_READY, &current->mm->flags)) {
+		clear_bit(MMF_COW_PTE_READY, &current->mm->flags);
+		set_bit(MMF_COW_PTE, &current->mm->flags);
+	}
+#endif
+
 	p = copy_process(NULL, trace, NUMA_NO_NODE, args);
 	add_latent_entropy();
 
-- 
2.34.1

