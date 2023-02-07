Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A8A68CDA9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Feb 2023 04:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjBGDw5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Feb 2023 22:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbjBGDww (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Feb 2023 22:52:52 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B22E33443;
        Mon,  6 Feb 2023 19:52:45 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id ge21-20020a17090b0e1500b002308aac5b5eso7491266pjb.4;
        Mon, 06 Feb 2023 19:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=THkbeIqrskaD2PQNhZ3CklGbHlPRjGInAR3sWDIA39M=;
        b=EY+PKakRdaKE8DbW8E7qw6byiX3BYP4skCjmQhfzN0h8oR9JAHzemzDky43uEb59dh
         gGvEuSdb6CDSmxf3bE8x90QtOtHc+/A9dyJZas7vltrEelfSf9UqYYKuTIoSF2fFV7xS
         v8wZ6FvO+8b9g+srnNdSAzjhha7lziW7v/2keYQ50SsNWYFLwol9wyBZ7tJHaO6Cs9g0
         Gsb4p/q6gVlCZjRX262CLrPLNMYi6vztpssdmhh41phtqu3bvcPt+6rGlSf+5bPVXSOQ
         DLBTyZCEnfOuLKc5wre6Pf4M7uM71w46yMuXL0rgeO3wX8DGYS1/cB6DLuzNf08GI45W
         qilw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=THkbeIqrskaD2PQNhZ3CklGbHlPRjGInAR3sWDIA39M=;
        b=ysmVa5+JT0om6qHlCrKRyQXZXYx4M3oD/xc+yKgnla+1Y73omLabKinP+rx1sxWAuI
         CGXbdZfuI4BHETcI2JOnAty3UBOzupyjb7QLqkiGyqQeMbR3p16BbAkZe+5NNvfsOB83
         Ap8CYeSWGZ66Y+EIF4m2gLTPw2muQwvsGCPYY9yVIlgRNEu5lJ9rrwS2o44ajKEyrtnJ
         hyFfd6MPLQ1Nysznbl55+PXy914RMmuMToZkVTTnsDz3QxkhuxvmFDuf2WrPdL0+IV1n
         GIp7qDbkFf1RUXw8eJJkse77kvK7IPgfFPlz3gIy6icY7PxAHaMA9Nin0F8jAcGbMR/a
         brfA==
X-Gm-Message-State: AO0yUKX241fbIzPCnZCRBCsYLLi63M8pz95djWoqoY1lKdvUZbyMsZrK
        kOgWezeoZnsYq3aA64gV1RQ=
X-Google-Smtp-Source: AK7set+nGsqo/sl/wqd55K2dU5QYefXctRyCSyI26tZ7c51ELti8mM2EnNAUFgqv60jBNNLuth9o3w==
X-Received: by 2002:a17:902:c950:b0:196:58ac:6593 with SMTP id i16-20020a170902c95000b0019658ac6593mr1729111pla.61.1675741965047;
        Mon, 06 Feb 2023 19:52:45 -0800 (PST)
Received: from strix-laptop.hitronhub.home ([123.110.9.95])
        by smtp.googlemail.com with ESMTPSA id q4-20020a170902b10400b0019682e27995sm7647655plr.223.2023.02.06.19.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 19:52:44 -0800 (PST)
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
Subject: [PATCH v4 01/14] mm: Allow user to control COW PTE via prctl
Date:   Tue,  7 Feb 2023 11:51:26 +0800
Message-Id: <20230207035139.272707-2-shiyn.lin@gmail.com>
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
 include/linux/sched/coredump.h | 12 +++++++++++-
 include/uapi/linux/prctl.h     |  6 ++++++
 kernel/sys.c                   | 11 +++++++++++
 3 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched/coredump.h b/include/linux/sched/coredump.h
index 8270ad7ae14c..570d599ebc85 100644
--- a/include/linux/sched/coredump.h
+++ b/include/linux/sched/coredump.h
@@ -83,7 +83,17 @@ static inline int get_dumpable(struct mm_struct *mm)
 #define MMF_HAS_PINNED		27	/* FOLL_PIN has run, never cleared */
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
-				 MMF_DISABLE_THP_MASK)
+				 MMF_DISABLE_THP_MASK | MMF_COW_PTE_MASK)
 
 #endif /* _LINUX_SCHED_COREDUMP_H */
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index a5e06dcbba13..664a3c023019 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -284,4 +284,10 @@ struct prctl_mm_map {
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
index 88b31f096fb2..eeab3093026f 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2350,6 +2350,14 @@ static int prctl_set_vma(unsigned long opt, unsigned long start,
 }
 #endif /* CONFIG_ANON_VMA_NAME */
 
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
@@ -2628,6 +2636,9 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
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

