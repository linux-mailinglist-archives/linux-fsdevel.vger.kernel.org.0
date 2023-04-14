Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8AA76E2596
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 16:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjDNOY5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 10:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjDNOYy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:24:54 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E02BC140;
        Fri, 14 Apr 2023 07:24:40 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id cm18-20020a17090afa1200b0024713adf69dso6267251pjb.3;
        Fri, 14 Apr 2023 07:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681482280; x=1684074280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EI/xgA3T+jD6+X1P1tFB/fdrO9EhnI4pOgRfKhyKXi8=;
        b=dp9B4As7NRowFOhmFgHptzwRqDpv7/qxF2zrakWreLkouXNX+Ey0loxIIQdV0mAyjL
         wbB5XAF4XVWn7QWMCRTQsmGD65y5w+/3d5YZz+ZuQURVTP5mQmbfpw6uP6zYos/mTpxi
         Z2hMRosDak5Clhncc6D/belgtQPtCjSdu0z42/aBMHdBa3D3dMT8E2ppfvQuohvqykwf
         DKHGG/m/ZpQ6kgNHGpm5DTfDKIRJF+FpahmqHY2B6kez9gLckPsly4+UQSub9VJUk4mA
         UmGR+EpFifjGDLsruJ//xx4xJj9JDgYl1bK+1deT7vfi23+wJW8oTTmCtvanwFXVxaJf
         ifng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681482280; x=1684074280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EI/xgA3T+jD6+X1P1tFB/fdrO9EhnI4pOgRfKhyKXi8=;
        b=bglvtuH5/hADmO8XMJyTq/8ZPtQvG71S7GEwWrJKkcfMC/OHlGTh4JYFhdyUL4kM0r
         aKqsSjVYz9N9xv2jiYkt8lsst/cyKknEYcDUOoG125Xnm0uONVg0C0KQjtx3xEtxI3rt
         QTNfijMOLW4RBbtT1Gxu5NsOcOLXPXLzfIv2yBfbSRiykJuux8iWKtpoyKx4wFUSfxWK
         at+tvCDk+yjX/HtpzXC4g6tdqUO2QioaklQgfyrv5tkZGDO4hrR/N7+hX1B1If7PPrTd
         cHLS/KSifXpJxg7fIfFWUKBQ/fKTYpz8CFwU4eEQGwsBXLErigeIupjmlgrDGKVyY2r6
         ZHqg==
X-Gm-Message-State: AAQBX9cXYvRdfHJOcPC/gJgw5J4jICfVgR/yo1JrvvVeyb7oeyFaFMgD
        vkJKW0vmRsSfjsvuw94vdvs=
X-Google-Smtp-Source: AKy350bVGay/l+iKywICpX6DkfyRQb5ITLNSdlflzo3Pxj01rUABeJIlD5c4oSXbLyfahy3pI5Uy8Q==
X-Received: by 2002:a17:90a:fc6:b0:237:97a3:1479 with SMTP id 64-20020a17090a0fc600b0023797a31479mr6207174pjz.28.1681482279586;
        Fri, 14 Apr 2023 07:24:39 -0700 (PDT)
Received: from strix-laptop.. (2001-b011-20e0-1499-8303-7502-d3d7-e13b.dynamic-ip6.hinet.net. [2001:b011:20e0:1499:8303:7502:d3d7:e13b])
        by smtp.googlemail.com with ESMTPSA id h7-20020a17090ac38700b0022335f1dae2sm2952386pjt.22.2023.04.14.07.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 07:24:39 -0700 (PDT)
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
Subject: [PATCH v5 02/17] mm: Allow user to control COW PTE via prctl
Date:   Fri, 14 Apr 2023 22:23:26 +0800
Message-Id: <20230414142341.354556-3-shiyn.lin@gmail.com>
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

Add a new prctl, PR_SET_COW_PTE, to allow the user to enable COW PTE.
Since it has a time gap between using the prctl to enable the COW PTE
and doing the fork, we use two states (MMF_COW_PTE_READY and MMF_COW_PTE)
to determine the task that wants to do COW PTE or already doing it.

The MMF_COW_PTE_READY flag marks the task to do COW PTE in the next time
of fork(). During fork(), if MMF_COW_PTE_READY set, fork() will unset the
flag and set the MMF_COW_PTE flag. After that, fork() might shares PTEs
instead of duplicates it.

Signed-off-by: Chih-En Lin <shiyn.lin@gmail.com>
---
 include/linux/sched/coredump.h | 13 ++++++++++++-
 include/uapi/linux/prctl.h     |  6 ++++++
 kernel/sys.c                   | 11 +++++++++++
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched/coredump.h b/include/linux/sched/coredump.h
index 0e17ae7fbfd3..dff4b0938c39 100644
--- a/include/linux/sched/coredump.h
+++ b/include/linux/sched/coredump.h
@@ -87,7 +87,18 @@ static inline int get_dumpable(struct mm_struct *mm)
 
 #define MMF_DISABLE_THP_MASK	(1 << MMF_DISABLE_THP)
 
+/*
+ * MMF_COW_PTE_READY: Marking the task to do COW PTE in the next time of
+ * fork(). During fork(), if MMF_COW_PTE_READY set, fork() will unset the
+ * flag and set the MMF_COW_PTE flag. After that, fork() might shares PTEs
+ * rather than duplicates it.
+ */
+#define MMF_COW_PTE_READY	29 /* Share PTE tables in next time of fork() */
+#define MMF_COW_PTE		30 /* PTE tables are shared between processes */
+#define MMF_COW_PTE_MASK	(1 << MMF_COW_PTE)
+
 #define MMF_INIT_MASK		(MMF_DUMPABLE_MASK | MMF_DUMP_FILTER_MASK |\
-				 MMF_DISABLE_THP_MASK | MMF_HAS_MDWE_MASK)
+				 MMF_DISABLE_THP_MASK | MMF_HAS_MDWE_MASK |\
+				 MMF_COW_PTE_MASK)
 
 #endif /* _LINUX_SCHED_COREDUMP_H */
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 1312a137f7fb..8fc82ced80b5 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -290,4 +290,10 @@ struct prctl_mm_map {
 #define PR_SET_VMA		0x53564d41
 # define PR_SET_VMA_ANON_NAME		0
 
+/*
+ * Set the prepare flag, MMF_COW_PTE_READY, to do the share (copy-on-write)
+ * page table in the next time of fork.
+ */
+#define PR_SET_COW_PTE			65
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/sys.c b/kernel/sys.c
index 495cd87d9bf4..eb1c38c4bad2 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2377,6 +2377,14 @@ static inline int prctl_get_mdwe(unsigned long arg2, unsigned long arg3,
 		PR_MDWE_REFUSE_EXEC_GAIN : 0;
 }
 
+static int prctl_set_cow_pte(struct mm_struct *mm)
+{
+	if (test_bit(MMF_COW_PTE, &mm->flags))
+		return -EINVAL;
+	set_bit(MMF_COW_PTE_READY, &mm->flags);
+	return 0;
+}
+
 SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 		unsigned long, arg4, unsigned long, arg5)
 {
@@ -2661,6 +2669,9 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 	case PR_SET_VMA:
 		error = prctl_set_vma(arg2, arg3, arg4, arg5);
 		break;
+	case PR_SET_COW_PTE:
+		error = prctl_set_cow_pte(me->mm);
+		break;
 	default:
 		error = -EINVAL;
 		break;
-- 
2.34.1

