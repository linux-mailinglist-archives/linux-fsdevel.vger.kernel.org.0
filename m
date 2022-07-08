Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7747856B468
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jul 2022 10:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237757AbiGHIW6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jul 2022 04:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237765AbiGHIW5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jul 2022 04:22:57 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E349D81494
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Jul 2022 01:22:54 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id fz10so11339117pjb.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Jul 2022 01:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KWf5dtXssMqsGOz7VAfXoh+v1Z2hqWDoP8+0nbo6wHo=;
        b=m0PYz6XwlosOdsP+9iwryUoydSkHiDwsygkPzmDiJ8OAMhJc7xJghUUzA7I2zcptug
         jqR+u+fNiLVVZ33aytEaErpcgQwFvATwbeNUs5ygSQDeyx2nP73Pc2ZOA8RjiHxvUjc8
         tXuKr6alGYPRffom/o3tmmrWW27BX/q82+CZEBpY1UXlMHgJiNHt0cIjtUBA6Nox/NlE
         W4q1PS1pjn+6e6A2xxNP3/p/G3K/iuWp07vpnVmbKtiC+FEixbZ/JquZPPJj1Gk1q4i0
         nXWIYhpROF75IR6nVRGDkPzlhfT+MNGx+7x1qU5olypFlgu1PqydGNNBJgcdQ8Cnn6K2
         IhtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KWf5dtXssMqsGOz7VAfXoh+v1Z2hqWDoP8+0nbo6wHo=;
        b=VvLOwy0lYnd2BkmnICLhWHUBIuCEeUI8Sz4cC7KSbnwVMMErY48unBtIMq82jaJ3zv
         JbcX1iq+ABcea+gWPqivnEfi8D0JKoQwGWgFAFrBJSatrOjNaRytJEH2zgC4XI8a4T/f
         jcchYQYmTu7tN/qWdMjyOL1/mcrNRHzqCds2NSmrSYkG4g0Mnjj9w3zSxFCLZOFNsMTD
         ojgsPIhkls0pTPQoUhu4zp9oAlOW8U8ws4qcdf+4Kw65johwfTNaBx0JqhhEgSf0WP46
         9UxZoVO3yuXsDOQa5pcRYUrH3Db/LKTeAhGysNaU23RUg7cUSjrj8OLoQsO0D4ZpThTp
         6r7w==
X-Gm-Message-State: AJIora9I7OO+wjzat1zse+tth40Hywksj0RmkFsRUlf9jn4IujUobx+f
        djQ+5MPbQ7QKdnh7E60qLtX54g==
X-Google-Smtp-Source: AGRyM1sXw4OaPJ/ttATPWPzLoQNiXr1HO7oR/PrceAT9cX2L07mrACBC5lCbCAIytcQOPDZR6J8YpA==
X-Received: by 2002:a17:902:7618:b0:16a:23ec:75f6 with SMTP id k24-20020a170902761800b0016a23ec75f6mr2465799pll.158.1657268574396;
        Fri, 08 Jul 2022 01:22:54 -0700 (PDT)
Received: from C02FT5A6MD6R.bytedance.net ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id x65-20020a636344000000b00412b1043f33sm3329291pgb.39.2022.07.08.01.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 01:22:53 -0700 (PDT)
From:   Gang Li <ligang.bdlg@bytedance.com>
To:     mhocko@suse.com, akpm@linux-foundation.org, surenb@google.com
Cc:     hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        viro@zeniv.linux.org.uk, ebiederm@xmission.com,
        keescook@chromium.org, rostedt@goodmis.org, mingo@redhat.com,
        peterz@infradead.org, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, david@redhat.com, imbrenda@linux.ibm.com,
        adobriyan@gmail.com, yang.yang29@zte.com.cn, brauner@kernel.org,
        stephen.s.brennan@oracle.com, zhengqi.arch@bytedance.com,
        haolee.swjtu@gmail.com, xu.xin16@zte.com.cn,
        Liam.Howlett@Oracle.com, ohoono.kwon@samsung.com,
        peterx@redhat.com, arnd@arndb.de, shy828301@gmail.com,
        alex.sierra@amd.com, xianting.tian@linux.alibaba.com,
        willy@infradead.org, ccross@google.com, vbabka@suse.cz,
        sujiaxun@uniontech.com, sfr@canb.auug.org.au,
        vasily.averin@linux.dev, mgorman@suse.de, vvghjk1234@gmail.com,
        tglx@linutronix.de, luto@kernel.org, bigeasy@linutronix.de,
        fenghua.yu@intel.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
        Gang Li <ligang.bdlg@bytedance.com>
Subject: [PATCH v2 2/5] mm: add numa_count field for rss_stat
Date:   Fri,  8 Jul 2022 16:21:26 +0800
Message-Id: <20220708082129.80115-3-ligang.bdlg@bytedance.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220708082129.80115-1-ligang.bdlg@bytedance.com>
References: <20220708082129.80115-1-ligang.bdlg@bytedance.com>
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
index 32512af31721..9fd34ab484f4 100644
--- a/include/linux/mm_types_task.h
+++ b/include/linux/mm_types_task.h
@@ -52,11 +52,17 @@ enum {
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
index 23f0ba3affe5..f4f93d6fecd5 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -140,6 +140,10 @@ DEFINE_PER_CPU(unsigned long, process_counts) = 0;
 
 __cacheline_aligned DEFINE_RWLOCK(tasklist_lock);  /* outer */
 
+#if (defined SPLIT_RSS_COUNTING) && (defined CONFIG_NUMA)
+#define SPLIT_RSS_NUMA_COUNTING
+#endif
+
 #ifdef CONFIG_PROVE_RCU
 int lockdep_tasklist_lock_is_held(void)
 {
@@ -757,6 +761,16 @@ static void check_mm(struct mm_struct *mm)
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
@@ -769,6 +783,29 @@ static void check_mm(struct mm_struct *mm)
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
@@ -783,6 +820,7 @@ void __mmdrop(struct mm_struct *mm)
 	destroy_context(mm);
 	mmu_notifier_subscriptions_destroy(mm);
 	check_mm(mm);
+	mm_free_rss_stat(mm);
 	put_user_ns(mm->user_ns);
 	mm_pasid_drop(mm);
 	free_mm(mm);
@@ -824,12 +862,22 @@ static inline void put_signal_struct(struct signal_struct *sig)
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
@@ -956,6 +1004,7 @@ void set_task_stack_end_magic(struct task_struct *tsk)
 static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 {
 	struct task_struct *tsk;
+	int *numa_count __maybe_unused;
 	int err;
 
 	if (node == NUMA_NO_NODE)
@@ -977,9 +1026,16 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
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
@@ -1045,6 +1101,10 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 
 	return tsk;
 
+free_rss_stat:
+#ifdef SPLIT_RSS_NUMA_COUNTING
+	kfree(numa_count);
+#endif
 free_stack:
 	exit_task_stack_account(tsk);
 	free_thread_stack(tsk);
@@ -1114,7 +1174,6 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	mm->map_count = 0;
 	mm->locked_vm = 0;
 	atomic64_set(&mm->pinned_vm, 0);
-	memset(&mm->rss_stat, 0, sizeof(mm->rss_stat));
 	spin_lock_init(&mm->page_table_lock);
 	spin_lock_init(&mm->arg_lock);
 	mm_init_cpumask(mm);
@@ -1141,6 +1200,9 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	if (mm_alloc_pgd(mm))
 		goto fail_nopgd;
 
+	if (mm_init_rss_stat(mm))
+		goto fail_nocontext;
+
 	if (init_new_context(p, mm))
 		goto fail_nocontext;
 
@@ -2142,7 +2204,9 @@ static __latent_entropy struct task_struct *copy_process(
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

