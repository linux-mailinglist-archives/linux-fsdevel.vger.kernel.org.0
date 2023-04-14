Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02FB66E25B4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 16:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjDNO15 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 10:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbjDNO1Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:27:24 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A09CC37;
        Fri, 14 Apr 2023 07:26:49 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id v9so23783189pjk.0;
        Fri, 14 Apr 2023 07:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681482409; x=1684074409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6QF5xJOwjDJikkH9xEOT05QJOI9cchS0txpOZNjqBVs=;
        b=PG8vzbsOguYntaBArXbPoyIOsUI0mlogXRMQ4K9KcrLog2kyEaNPzgy2SEcS28YMUz
         IYXTxZGaddfvbi1anPbUGMwmo7Ik9EQqSMINnbh5SC09Rc1vsm3SmI8jX+O0mSrg3R1D
         MEvaod7BVxSb4j6WdFrCjbbKx5aJ4njVMPUPFG3PrD+ynvMVvRCyg3r+bhlDW0Qh0WQ7
         JQcJOgXzbwgB47RvgU3kyZR72Ehyob9f2lb4Xld+MgKykEaM1vneMQijfXeQ/BPtilCu
         3w3bGXb4MB3IouRkauI2Ok4meKWRELFArwxIoQaBgvym7muq1nRaMooCTqk/IeMMr1cK
         E+Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681482409; x=1684074409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6QF5xJOwjDJikkH9xEOT05QJOI9cchS0txpOZNjqBVs=;
        b=X19LYlhZUWyru24aX23k7E1eTbaXQf42xQX0tO6zLfFhfnhQLdGL8SZSLk5wZaKkMz
         vS+9wv9blCaAJSgKtDqiML48knLu8i51N/OQT59nG0MWmjyc+y9wXwiIHUn/3Bvv+IPn
         Qb8ABSQhFql+nKQVuE2AOT/bFO5uh9JEvhkdU96k1JyF3GbVmhAhL4G1q6qB8mWxVd3T
         8CpHAbRM1chmBnkFa3pG+zHsLh8kWHrIZg3yjp5tGr6+GwLp02uEUCFf7ROLB3ppN36f
         QzbHQSgNMnY8tKm7vRVWdKyMuLYwDmL4AYfAQEjgoNULM8kbuoTAM2ejopG7C26FPN6d
         /6kA==
X-Gm-Message-State: AAQBX9dkCKRK5Bn9hUhJLejWilfvx3NXSy8Ocwu4tY/caZtXEtmLgoaN
        INGZ5+xz49JOX+7WHTAF8hk=
X-Google-Smtp-Source: AKy350YDDumVi1irC542NcdDUhAmG+zJHPpfUQ/Rbi3FQQGV1ol+SNXvZU2bDpybjtxtp5gLwcClZg==
X-Received: by 2002:a17:90b:17c9:b0:246:a228:1359 with SMTP id me9-20020a17090b17c900b00246a2281359mr10871223pjb.23.1681482408896;
        Fri, 14 Apr 2023 07:26:48 -0700 (PDT)
Received: from strix-laptop.. (2001-b011-20e0-1499-8303-7502-d3d7-e13b.dynamic-ip6.hinet.net. [2001:b011:20e0:1499:8303:7502:d3d7:e13b])
        by smtp.googlemail.com with ESMTPSA id h7-20020a17090ac38700b0022335f1dae2sm2952386pjt.22.2023.04.14.07.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 07:26:48 -0700 (PDT)
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
Subject: [PATCH v5 16/17] mm: fork: Enable COW PTE to fork system call
Date:   Fri, 14 Apr 2023 22:23:40 +0800
Message-Id: <20230414142341.354556-17-shiyn.lin@gmail.com>
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
index 0c92f224c68c..8452d5c4eb5e 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2679,6 +2679,13 @@ pid_t kernel_clone(struct kernel_clone_args *args)
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

