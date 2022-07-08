Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5779F56B460
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jul 2022 10:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237790AbiGHIXT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jul 2022 04:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237792AbiGHIXQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jul 2022 04:23:16 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD011814B2
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Jul 2022 01:23:10 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id i8-20020a17090a4b8800b001ef8a65bfbdso1146520pjh.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Jul 2022 01:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yv41KjiZt+ml0QTtKBiEgL10atNQnela5H6jReLePT8=;
        b=d2lfcx5HvslvT7tftwDggz5mpjJEOTFyP1qlI8O1gHKFDnDy4S+jjXx4J5QpSkuvNU
         aQ3rRp0ZxyHvJNHkmffR2aX46udJQhDRPbmrGpk5adRJDHW50fdnLkP9mI0uISAZgXei
         qd01Wqvnv3M/VaQLoEO+/5po6XE/XFHyvwBjAiu+NPd3o4L2u3RY+mxjTJQRHjJna2uG
         TvomrcsIg0CU7rBnL/c9TyRKlktmVnAh8si9UR8HtVj2Hy+UlAStR/kOoiJaR0XJjzh1
         EIfOyxHE4vSfPsYTROb2AjZCtH8IzJtRCkByJgf75M/9zGz2b23SR0a6f9B8I70Vdm2t
         cmqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yv41KjiZt+ml0QTtKBiEgL10atNQnela5H6jReLePT8=;
        b=UDxJH2W4PDPzYBqNj1nR/zGyjon6GWjFtZBOp5u4kzrIpds+8tREocbrrAW7kkcXpV
         FkIe8I+fa2gIcoUZXIsjSjsrlOVDkwPRIncnPSE5JRelGuXxvnYHgKYj6jnYSd9FMA1e
         7WpHqlqNYqPoyT290jdaUkP0jNv5zQtfCZzzH99fnCM/+zTou3txkJZr9kIHngVHNPgT
         oO6L801fFm1XmdGKCuaH8Wq2v/nZNrqoMic3ybiaqLWyBKWepyvIdjXxaaoe44KDumKE
         X7CTq3WEmqnhcibStqAuWLtcMLyYVcHptw9GRQ/xaGBbRde+3iSsPU4L1OYnpgA97uzY
         hCEw==
X-Gm-Message-State: AJIora+vjjKnpv8BfsJq+V6mMIY9GY1vPLPP5DfdMEQno2EOQy2EEmK6
        pQ7qG2gOwfKUs96HFA2s29Afsg==
X-Google-Smtp-Source: AGRyM1t3xYv6yrh7qgCSAECIXVYwtZaYoNdgFwwWOiDTbf9ukW8Rrjpm5c3WW/Ydd8RnPZkVCXyWHA==
X-Received: by 2002:a17:90a:c387:b0:1ef:8f7b:60d3 with SMTP id h7-20020a17090ac38700b001ef8f7b60d3mr10648017pjt.42.1657268590284;
        Fri, 08 Jul 2022 01:23:10 -0700 (PDT)
Received: from C02FT5A6MD6R.bytedance.net ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id x65-20020a636344000000b00412b1043f33sm3329291pgb.39.2022.07.08.01.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 01:23:09 -0700 (PDT)
From:   Gang Li <ligang.bdlg@bytedance.com>
To:     mhocko@suse.com, akpm@linux-foundation.org, surenb@google.com,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        viro@zeniv.linux.org.uk, ebiederm@xmission.com,
        keescook@chromium.org, peterz@infradead.org, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, david@redhat.com,
        imbrenda@linux.ibm.com, adobriyan@gmail.com,
        yang.yang29@zte.com.cn, brauner@kernel.org,
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
Subject: [PATCH v2 3/5] mm: add numa fields for tracepoint rss_stat
Date:   Fri,  8 Jul 2022 16:21:27 +0800
Message-Id: <20220708082129.80115-4-ligang.bdlg@bytedance.com>
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

Since we add numa_count for mm->rss_stat, the tracepoint should
also be modified. Now the output looks like this:

```
sleep-660   [002]   918.524333: rss_stat:             mm_id=1539334265 curr=0 type=MM_NO_TYPE type_size=0B node=2 node_size=32768B diff_size=-8192B
sleep-660   [002]   918.524333: rss_stat:             mm_id=1539334265 curr=0 type=MM_FILEPAGES type_size=4096B node=-1 node_size=0B diff_size=-4096B
sleep-660   [002]   918.524333: rss_stat:             mm_id=1539334265 curr=0 type=MM_NO_TYPE type_size=0B node=1 node_size=0B diff_size=-4096B
```

Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>
---
 include/linux/mm.h          |  9 +++++----
 include/trace/events/kmem.h | 27 ++++++++++++++++++++-------
 mm/memory.c                 |  5 +++--
 3 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 84ce6e1b1252..a7150ee7439c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2041,27 +2041,28 @@ static inline unsigned long get_mm_counter(struct mm_struct *mm, int member, int
 	return (unsigned long)val;
 }
 
-void mm_trace_rss_stat(struct mm_struct *mm, int member, long count);
+void mm_trace_rss_stat(struct mm_struct *mm, int member, long member_count, int node,
+		       long numa_count, long diff_count);
 
 static inline void add_mm_counter(struct mm_struct *mm, int member, long value, int node)
 {
 	long count = atomic_long_add_return(value, &mm->rss_stat.count[member]);
 
-	mm_trace_rss_stat(mm, member, count);
+	mm_trace_rss_stat(mm, member, count, NUMA_NO_NODE, 0, value);
 }
 
 static inline void inc_mm_counter(struct mm_struct *mm, int member, int node)
 {
 	long count = atomic_long_inc_return(&mm->rss_stat.count[member]);
 
-	mm_trace_rss_stat(mm, member, count);
+	mm_trace_rss_stat(mm, member, count, NUMA_NO_NODE, 0, 1);
 }
 
 static inline void dec_mm_counter(struct mm_struct *mm, int member, int node)
 {
 	long count = atomic_long_dec_return(&mm->rss_stat.count[member]);
 
-	mm_trace_rss_stat(mm, member, count);
+	mm_trace_rss_stat(mm, member, count, NUMA_NO_NODE, 0, -1);
 }
 
 /* Optimized variant when page is already known not to be PageAnon */
diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
index 4cb51ace600d..7c8ad4aeb7b1 100644
--- a/include/trace/events/kmem.h
+++ b/include/trace/events/kmem.h
@@ -363,7 +363,8 @@ static unsigned int __maybe_unused mm_ptr_to_hash(const void *ptr)
 	EM(MM_FILEPAGES)	\
 	EM(MM_ANONPAGES)	\
 	EM(MM_SWAPENTS)		\
-	EMe(MM_SHMEMPAGES)
+	EM(MM_SHMEMPAGES)	\
+	EMe(MM_NO_TYPE)
 
 #undef EM
 #undef EMe
@@ -383,29 +384,41 @@ TRACE_EVENT(rss_stat,
 
 	TP_PROTO(struct mm_struct *mm,
 		int member,
-		long count),
+		long member_count,
+		int node,
+		long node_count,
+		long diff_count),
 
-	TP_ARGS(mm, member, count),
+	TP_ARGS(mm, member, member_count, node, node_count, diff_count),
 
 	TP_STRUCT__entry(
 		__field(unsigned int, mm_id)
 		__field(unsigned int, curr)
 		__field(int, member)
-		__field(long, size)
+		__field(long, member_size)
+		__field(int, node)
+		__field(long, node_size)
+		__field(long, diff_size)
 	),
 
 	TP_fast_assign(
 		__entry->mm_id = mm_ptr_to_hash(mm);
 		__entry->curr = !!(current->mm == mm);
 		__entry->member = member;
-		__entry->size = (count << PAGE_SHIFT);
+		__entry->member_size = (member_count << PAGE_SHIFT);
+		__entry->node = node;
+		__entry->node_size = (node_count << PAGE_SHIFT);
+		__entry->diff_size = (diff_count << PAGE_SHIFT);
 	),
 
-	TP_printk("mm_id=%u curr=%d type=%s size=%ldB",
+	TP_printk("mm_id=%u curr=%d type=%s type_size=%ldB node=%d node_size=%ldB diff_size=%ldB",
 		__entry->mm_id,
 		__entry->curr,
 		__print_symbolic(__entry->member, TRACE_MM_PAGES),
-		__entry->size)
+		__entry->member_size,
+		__entry->node,
+		__entry->node_size,
+		__entry->diff_size)
 	);
 #endif /* _TRACE_KMEM_H */
 
diff --git a/mm/memory.c b/mm/memory.c
index bb24da767f79..b085f368ae11 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -173,9 +173,10 @@ static int __init init_zero_pfn(void)
 }
 early_initcall(init_zero_pfn);
 
-void mm_trace_rss_stat(struct mm_struct *mm, int member, long count)
+void mm_trace_rss_stat(struct mm_struct *mm, int member, long member_count, int node,
+		       long numa_count, long diff_count)
 {
-	trace_rss_stat(mm, member, count);
+	trace_rss_stat(mm, member, member_count, node, numa_count, diff_count);
 }
 
 #if defined(SPLIT_RSS_COUNTING)
-- 
2.20.1

