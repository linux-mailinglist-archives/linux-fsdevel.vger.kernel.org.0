Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B092856B466
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jul 2022 10:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237784AbiGHIXc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jul 2022 04:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237776AbiGHIX3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jul 2022 04:23:29 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F215F30B
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Jul 2022 01:23:26 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id y9so8725795pff.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Jul 2022 01:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XuDZzz9tVnB8J2jQEjeJNVf5Aik6JfaRXz4bVLQK2Uk=;
        b=DIZH2h+N1eb2jQqowZGUpKwgUfWoCe3azh5guhmj8MDrC3dMQ3QvY4azmwaqEt1asq
         GHX6szMJe7+TQRsqaW0h1F1xH5/Vt3ZOxzJNknCLtw7qSFJ2qUP6Mqz83hJTSlP1HbOB
         8tVQ64fDYFAZS8zGV8EpvERQDadFWuc3exmymJKUpAWvy9dUz/k/y7FjvJ/Mg02eoB93
         SmehkHPQYRql9dwypeIAeoVFNVdwvI6Pwx+SqkLHswEmZT22De/evOfaz6cljvVTRzPS
         K4WLNbqWZ17kl86EY9XjxMWk7dLlqfuPkSJY6giWhrh9Cj3qaJBqcMNYhbFYVrTfrhK1
         pJ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XuDZzz9tVnB8J2jQEjeJNVf5Aik6JfaRXz4bVLQK2Uk=;
        b=JMhy8E72rqseb2mluaJMGaT+3ksotQIWfGQp6uVndGsJWk5FVB1ODUv3TiTPTlgyAq
         J+MEX/VSBpUC3ju51KXE+ezZqnxO/Ldac6/uY+E0SgLpH7yhNz9E7oc7M6FM64Vwbsn5
         luGaO5P76nRowU+bMaD/h+oB1ItHFWvU8r1r0Efpe0p+jnbK6qNS9h/fAmNTHgv20tVs
         A9ML2hhqtxN2je89y0FgY2tOhsxEYMP8hozpu9DFKg6BUZPNbtZomqshODE2p6JK5Lrr
         evfHZFDpK8HBY/7qSn85sfg3MiyonH3o3hs7v7WpPJ91pLQFmgJ//Nte+OUHy0H964Ty
         PxJw==
X-Gm-Message-State: AJIora/z+urDHqUgF03LhFEAVzQ5T72Qj3M7B+JaWdPjRCGWIFTByAET
        4QkvlYiIbIPP4GlFoDRe9MAfMQ==
X-Google-Smtp-Source: AGRyM1uDYINZFh863sauNGlXqipvFwUiPCbVj1rtxjbEOySlvPOW7DbzRdiKgLA6/RsZxnbuDo5Xmw==
X-Received: by 2002:a65:6e4d:0:b0:411:c102:397e with SMTP id be13-20020a656e4d000000b00411c102397emr2297823pgb.271.1657268606508;
        Fri, 08 Jul 2022 01:23:26 -0700 (PDT)
Received: from C02FT5A6MD6R.bytedance.net ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id x65-20020a636344000000b00412b1043f33sm3329291pgb.39.2022.07.08.01.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 01:23:25 -0700 (PDT)
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
Subject: [PATCH v2 4/5] mm: enable per numa node rss_stat count
Date:   Fri,  8 Jul 2022 16:21:28 +0800
Message-Id: <20220708082129.80115-5-ligang.bdlg@bytedance.com>
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

Now we have all the infrastructure ready. Modify `*_mm_counter`,
`sync_mm_rss`, `add_mm_counter_fast` and `add_mm_rss_vec` to enable per
numa node rss_stat count.

Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>
---
 include/linux/mm.h | 42 +++++++++++++++++++++++++++++++++++-------
 mm/memory.c        | 20 ++++++++++++++++++--
 2 files changed, 53 insertions(+), 9 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a7150ee7439c..4a8e10ebc729 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2028,8 +2028,18 @@ static inline bool get_user_page_fast_only(unsigned long addr,
  */
 static inline unsigned long get_mm_counter(struct mm_struct *mm, int member, int node)
 {
-	long val = atomic_long_read(&mm->rss_stat.count[member]);
+	long val;
 
+	WARN_ON(node == NUMA_NO_NODE && member == MM_NO_TYPE);
+
+	if (node == NUMA_NO_NODE)
+		val = atomic_long_read(&mm->rss_stat.count[member]);
+	else
+#ifdef CONFIG_NUMA
+		val = atomic_long_read(&mm->rss_stat.numa_count[node]);
+#else
+		val = 0;
+#endif
 #ifdef SPLIT_RSS_COUNTING
 	/*
 	 * counter is updated in asynchronous manner and may go to minus.
@@ -2046,23 +2056,41 @@ void mm_trace_rss_stat(struct mm_struct *mm, int member, long member_count, int
 
 static inline void add_mm_counter(struct mm_struct *mm, int member, long value, int node)
 {
-	long count = atomic_long_add_return(value, &mm->rss_stat.count[member]);
+	long member_count = 0, numa_count = 0;
 
-	mm_trace_rss_stat(mm, member, count, NUMA_NO_NODE, 0, value);
+	if (member != MM_NO_TYPE)
+		member_count = atomic_long_add_return(value, &mm->rss_stat.count[member]);
+#ifdef CONFIG_NUMA
+	if (node != NUMA_NO_NODE)
+		numa_count = atomic_long_add_return(value, &mm->rss_stat.numa_count[node]);
+#endif
+	mm_trace_rss_stat(mm, member, member_count, node, numa_count, value);
 }
 
 static inline void inc_mm_counter(struct mm_struct *mm, int member, int node)
 {
-	long count = atomic_long_inc_return(&mm->rss_stat.count[member]);
+	long member_count = 0, numa_count = 0;
 
-	mm_trace_rss_stat(mm, member, count, NUMA_NO_NODE, 0, 1);
+	if (member != MM_NO_TYPE)
+		member_count = atomic_long_inc_return(&mm->rss_stat.count[member]);
+#ifdef CONFIG_NUMA
+	if (node != NUMA_NO_NODE)
+		numa_count = atomic_long_inc_return(&mm->rss_stat.numa_count[node]);
+#endif
+	mm_trace_rss_stat(mm, member, member_count, node, numa_count, 1);
 }
 
 static inline void dec_mm_counter(struct mm_struct *mm, int member, int node)
 {
-	long count = atomic_long_dec_return(&mm->rss_stat.count[member]);
+	long member_count = 0, numa_count = 0;
 
-	mm_trace_rss_stat(mm, member, count, NUMA_NO_NODE, 0, -1);
+	if (member != MM_NO_TYPE)
+		member_count = atomic_long_dec_return(&mm->rss_stat.count[member]);
+#ifdef CONFIG_NUMA
+	if (node != NUMA_NO_NODE)
+		numa_count = atomic_long_dec_return(&mm->rss_stat.numa_count[node]);
+#endif
+	mm_trace_rss_stat(mm, member, member_count, node, numa_count, -1);
 }
 
 /* Optimized variant when page is already known not to be PageAnon */
diff --git a/mm/memory.c b/mm/memory.c
index b085f368ae11..66c8d10d36cc 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -191,6 +191,14 @@ void sync_mm_rss(struct mm_struct *mm)
 			current->rss_stat.count[i] = 0;
 		}
 	}
+#ifdef CONFIG_NUMA
+	for_each_node(i) {
+		if (current->rss_stat.numa_count[i]) {
+			add_mm_counter(mm, MM_NO_TYPE, current->rss_stat.numa_count[i], i);
+			current->rss_stat.numa_count[i] = 0;
+		}
+	}
+#endif
 	current->rss_stat.events = 0;
 }
 
@@ -198,9 +206,12 @@ static void add_mm_counter_fast(struct mm_struct *mm, int member, int val, int n
 {
 	struct task_struct *task = current;
 
-	if (likely(task->mm == mm))
+	if (likely(task->mm == mm)) {
 		task->rss_stat.count[member] += val;
-	else
+#ifdef CONFIG_NUMA
+		task->rss_stat.numa_count[node] += val;
+#endif
+	} else
 		add_mm_counter(mm, member, val, node);
 }
 #define inc_mm_counter_fast(mm, member, node) add_mm_counter_fast(mm, member, 1, node)
@@ -520,6 +531,11 @@ static inline void add_mm_rss_vec(struct mm_struct *mm, int *rss, int *numa_rss)
 	for (i = 0; i < NR_MM_COUNTERS; i++)
 		if (rss[i])
 			add_mm_counter(mm, i, rss[i], NUMA_NO_NODE);
+#ifdef CONFIG_NUMA
+	for_each_node(i)
+		if (numa_rss[i] != 0)
+			add_mm_counter(mm, MM_NO_TYPE, numa_rss[i], i);
+#endif
 }
 
 /*
-- 
2.20.1

