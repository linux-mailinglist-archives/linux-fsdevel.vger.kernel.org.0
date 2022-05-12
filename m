Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38DF852447E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 May 2022 06:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348298AbiELErr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 May 2022 00:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348248AbiELErj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 May 2022 00:47:39 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FFD2BB03
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 May 2022 21:47:37 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id s14so3801832plk.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 May 2022 21:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mu0oeSRdhbh9VeZjyF6ZLYtewD09HIHqh0x41OUf5r4=;
        b=qnE+4npLf7k/552JUhxPioA2V3oZwkdvutxLoX/n6XSuqRN7fIBAHvmd53SRC1gfco
         rzzLHz3zgQAJDwh2IFamU7U2v5I3rRTL8xwlFFlTuF+kBCUIew/y0SfK5rHvdwXr90wR
         xn0+PpzAPDTbU/Kg/E8MP0GcLWP3e51IvM4fId1s0w2zJstOZt3rcXs6ZdSVEULGPIYf
         7Y+tv4cAwzZ9E+P3NfR1YGOqdD5fPgADfJMaid5eRiVUMgWKVLWcs4IF8hPC43IAsqtd
         Ecjws63bHi/APHivVWVCT4UWPSPT4Ji/V32qShK/kqf/IzZGjtw1W/l1ZZxR0bgT8LkX
         kikw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mu0oeSRdhbh9VeZjyF6ZLYtewD09HIHqh0x41OUf5r4=;
        b=2k/g8wCCZ3RBlMCv00jNmXOBnZz8fw8wCUlQ4eOH0RjuT3Ik2jGJy6E2z4w+vGZC04
         r3DZ9xj8khi0rnSrlGCmGQ0uyPcBp/VUBErpfnmS45/trzT1M4237O2quB23rZZTf7VE
         9v6yh3kzf0Mf7ysbUUjjROqPiIJdsCO6fsicYPOXCqrPgeaTWnp6Dw/zgXjrdetUN3Om
         Psk7j9tN8u2uCfvuvdO42dfX2BVwsfNKixxFmmqfSWp9Ibb6cAh6c0BFcyUlrb/ziuxP
         V0pzvdW4iK9vrELOlui95A8QZ/71ivOARo3d4ovIhgN0MvybwwjpWfu1pV4SY69kloqD
         AIIA==
X-Gm-Message-State: AOAM532CONU6wQFqKHLpGL8J6tMiG47l1+GElbiTpJv1KS08xdwOS+9z
        g89xjlRG4Gq594Nl/IbEZN0/Cw==
X-Google-Smtp-Source: ABdhPJzUuiCelUq6G3b+1zXrlgNS09+gkvww/VC4mZYDFyo1AFj5M1cF8Up8xWtVli0E/gbLSTNFag==
X-Received: by 2002:a17:902:9a4c:b0:158:b6f0:4aa2 with SMTP id x12-20020a1709029a4c00b00158b6f04aa2mr28430242plv.163.1652330857366;
        Wed, 11 May 2022 21:47:37 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id 5-20020a170902e9c500b0015edc07dcf3sm2790824plk.21.2022.05.11.21.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 21:47:36 -0700 (PDT)
From:   Gang Li <ligang.bdlg@bytedance.com>
To:     akpm@linux-foundation.org
Cc:     songmuchun@bytedance.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, ebiederm@xmission.com, keescook@chromium.org,
        viro@zeniv.linux.org.uk, rostedt@goodmis.org, mingo@redhat.com,
        peterz@infradead.org, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, david@redhat.com, imbrenda@linux.ibm.com,
        apopple@nvidia.com, adobriyan@gmail.com,
        stephen.s.brennan@oracle.com, ohoono.kwon@samsung.com,
        haolee.swjtu@gmail.com, kaleshsingh@google.com,
        zhengqi.arch@bytedance.com, peterx@redhat.com, shy828301@gmail.com,
        surenb@google.com, ccross@google.com, vincent.whitchurch@axis.com,
        tglx@linutronix.de, bigeasy@linutronix.de, fenghua.yu@intel.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Gang Li <ligang.bdlg@bytedance.com>
Subject: [PATCH 2/5 v1] mm: add numa_count field for rss_stat
Date:   Thu, 12 May 2022 12:46:31 +0800
Message-Id: <20220512044634.63586-3-ligang.bdlg@bytedance.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220512044634.63586-1-ligang.bdlg@bytedance.com>
References: <20220512044634.63586-1-ligang.bdlg@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch add new fields `numa_count` for mm_rss_stat and
task_rss_stat.

`numa_count` are in the size of `sizeof(long) * num_possible_numa()`.
To reduce mem consumption, they only contain the sum of rss which is
needed by `oom_badness` instead of recording different kinds of rss
sepratly.

Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>
---
 include/linux/mm_types_task.h |  6 +++
 kernel/fork.c                 | 70 +++++++++++++++++++++++++++++++++--
 2 files changed, 73 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm_types_task.h b/include/linux/mm_types_task.h
index 3e7da8c7ab95..c1ac2a33b697 100644
--- a/include/linux/mm_types_task.h
+++ b/include/linux/mm_types_task.h
@@ -64,11 +64,17 @@ enum {
 struct task_rss_stat {
 	int events;	/* for synchronization threshold */
 	int count[NR_MM_COUNTERS];
+#ifdef CONFIG_NUMA
+	int *numa_count;
+#endif
 };
 #endif /* USE_SPLIT_PTE_PTLOCKS */
 
 struct mm_rss_stat {
 	atomic_long_t count[NR_MM_COUNTERS];
+#ifdef CONFIG_NUMA
+	atomic_long_t *numa_count;
+#endif
 };
 
 struct page_frag {
diff --git a/kernel/fork.c b/kernel/fork.c
index 9796897560ab..e549e0b30e2b 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -141,6 +141,10 @@ DEFINE_PER_CPU(unsigned long, process_counts) = 0;
 
 __cacheline_aligned DEFINE_RWLOCK(tasklist_lock);  /* outer */
 
+#if (defined SPLIT_RSS_COUNTING) && (defined CONFIG_NUMA)
+#define SPLIT_RSS_NUMA_COUNTING
+#endif
+
 #ifdef CONFIG_PROVE_RCU
 int lockdep_tasklist_lock_is_held(void)
 {
@@ -765,6 +769,16 @@ static void check_mm(struct mm_struct *mm)
 				 mm, resident_page_types[i], x);
 	}
 
+#ifdef CONFIG_NUMA
+	for (i = 0; i < num_possible_nodes(); i++) {
+		long x = atomic_long_read(&mm->rss_stat.numa_count[i]);
+
+		if (unlikely(x))
+			pr_alert("BUG: Bad rss-counter state mm:%p node:%d val:%ld\n",
+				 mm, i, x);
+	}
+#endif
+
 	if (mm_pgtables_bytes(mm))
 		pr_alert("BUG: non-zero pgtables_bytes on freeing mm: %ld\n",
 				mm_pgtables_bytes(mm));
@@ -777,6 +791,29 @@ static void check_mm(struct mm_struct *mm)
 #define allocate_mm()	(kmem_cache_alloc(mm_cachep, GFP_KERNEL))
 #define free_mm(mm)	(kmem_cache_free(mm_cachep, (mm)))
 
+#ifdef CONFIG_NUMA
+static inline void mm_free_rss_stat(struct mm_struct *mm)
+{
+	kfree(mm->rss_stat.numa_count);
+}
+
+static inline int mm_init_rss_stat(struct mm_struct *mm)
+{
+	memset(&mm->rss_stat.count, 0, sizeof(mm->rss_stat.count));
+	mm->rss_stat.numa_count = kcalloc(num_possible_nodes(), sizeof(atomic_long_t), GFP_KERNEL);
+	if (unlikely(!mm->rss_stat.numa_count))
+		return -ENOMEM;
+	return 0;
+}
+#else
+static inline void mm_free_rss_stat(struct mm_struct *mm) {}
+static inline int mm_init_rss_stat(struct mm_struct *mm)
+{
+	memset(&mm->rss_stat.count, 0, sizeof(mm->rss_stat.count));
+	return 0;
+}
+#endif
+
 /*
  * Called when the last reference to the mm
  * is dropped: either by a lazy thread or by
@@ -791,6 +828,7 @@ void __mmdrop(struct mm_struct *mm)
 	destroy_context(mm);
 	mmu_notifier_subscriptions_destroy(mm);
 	check_mm(mm);
+	mm_free_rss_stat(mm);
 	put_user_ns(mm->user_ns);
 	free_mm(mm);
 }
@@ -831,12 +869,22 @@ static inline void put_signal_struct(struct signal_struct *sig)
 		free_signal_struct(sig);
 }
 
+#ifdef SPLIT_RSS_NUMA_COUNTING
+void rss_stat_free(struct task_struct *p)
+{
+	kfree(p->rss_stat.numa_count);
+}
+#else
+void rss_stat_free(struct task_struct *p) {}
+#endif
+
 void __put_task_struct(struct task_struct *tsk)
 {
 	WARN_ON(!tsk->exit_state);
 	WARN_ON(refcount_read(&tsk->usage));
 	WARN_ON(tsk == current);
 
+	rss_stat_free(tsk);
 	io_uring_free(tsk);
 	cgroup_free(tsk);
 	task_numa_free(tsk, true);
@@ -963,6 +1011,7 @@ void set_task_stack_end_magic(struct task_struct *tsk)
 static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 {
 	struct task_struct *tsk;
+	int *numa_count __maybe_unused;
 	int err;
 
 	if (node == NUMA_NO_NODE)
@@ -984,9 +1033,16 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 #endif
 	account_kernel_stack(tsk, 1);
 
+#ifdef SPLIT_RSS_NUMA_COUNTING
+	numa_count = kcalloc(num_possible_nodes(), sizeof(int), GFP_KERNEL);
+	if (!numa_count)
+		goto free_stack;
+	tsk->rss_stat.numa_count = numa_count;
+#endif
+
 	err = scs_prepare(tsk, node);
 	if (err)
-		goto free_stack;
+		goto free_rss_stat;
 
 #ifdef CONFIG_SECCOMP
 	/*
@@ -1047,6 +1103,10 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 #endif
 	return tsk;
 
+free_rss_stat:
+#ifdef SPLIT_RSS_NUMA_COUNTING
+	kfree(numa_count);
+#endif
 free_stack:
 	exit_task_stack_account(tsk);
 	free_thread_stack(tsk);
@@ -1117,7 +1177,6 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	mm->map_count = 0;
 	mm->locked_vm = 0;
 	atomic64_set(&mm->pinned_vm, 0);
-	memset(&mm->rss_stat, 0, sizeof(mm->rss_stat));
 	spin_lock_init(&mm->page_table_lock);
 	spin_lock_init(&mm->arg_lock);
 	mm_init_cpumask(mm);
@@ -1144,6 +1203,9 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	if (mm_alloc_pgd(mm))
 		goto fail_nopgd;
 
+	if (mm_init_rss_stat(mm))
+		goto fail_nocontext;
+
 	if (init_new_context(p, mm))
 		goto fail_nocontext;
 
@@ -2139,7 +2201,9 @@ static __latent_entropy struct task_struct *copy_process(
 	p->io_uring = NULL;
 #endif
 
-#if defined(SPLIT_RSS_COUNTING)
+#ifdef SPLIT_RSS_NUMA_COUNTING
+	memset(&p->rss_stat, 0, sizeof(p->rss_stat) - sizeof(p->rss_stat.numa_count));
+#else
 	memset(&p->rss_stat, 0, sizeof(p->rss_stat));
 #endif
 
-- 
2.20.1

