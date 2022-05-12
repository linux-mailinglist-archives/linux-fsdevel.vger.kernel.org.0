Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34301524484
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 May 2022 06:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347465AbiELEsY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 May 2022 00:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348566AbiELEsJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 May 2022 00:48:09 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5902C67A
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 May 2022 21:47:56 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id cq17-20020a17090af99100b001dc0386cd8fso3827424pjb.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 May 2022 21:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lV5EqWUJeu9NiPA/kLK56rAUvj5r/7m7kXc0Lxi4HQU=;
        b=vEdnQCvwGKZH3KBEgV/hEl8AX4D2GxUvAZ3VQiUrbIDlifvTSa/BIuTjsBv2jTELlY
         4gxguKg5L2J3PbyDN18HSD8su+QORRgVq0wuXWZ6rgrPaxpkOr6Ad24cbhTCNqpLXief
         FOreoW9B88ZO+wClsHBKA8YWZFWhmS3POOsIAbrasVsr+UgOvyj6Uk/+KhhgT4J2aDeI
         bf5r5DBpbyTcy5DzBciwgV+kNc+qQIDVHHi2ZMf6qQJQZjZE0djDQhIb+SqiZMmfDib4
         wvHQNPHZk/a+jj9cDrtQdRcgaXjHDAYUPMXZaN3riW7m45C/iFAhUFWlv1Q0ktu1dqDZ
         Y/QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lV5EqWUJeu9NiPA/kLK56rAUvj5r/7m7kXc0Lxi4HQU=;
        b=gVoxzqR9PfYT3oufVvtZeP8c5vGEkV+SWUYZR+PE6FBXndVcDvNXpGVPWCTNo8Zbnw
         CqAOiSt6i3QNnIWTmR9K4pLC3VbxHkBZ7jX2eUmx5n11UfJpjxdVkhE5pTJRWlv6PfXk
         clkoRmESJOYmiiTVgKynOChShRmrZ+S3dC2PIG3spUReWfvvEnUKOQ+7cdlVQRkCvE1l
         TpHI/EIrO2SBbCIrZmj/blsb6/kXHiQbc/pYIkSm7p9C9XF99/U3PM/idPNyjHSoF3Np
         10fyXW9DSZyPzB8+EyyFWVpS+n/C3FOh6Nym3rnC6TTibKDF9JHfqVkCY0ilH1q9oS9U
         BNjA==
X-Gm-Message-State: AOAM531NtNmM5lbx1myhbpAN0KLmH8ES1PAlI+5r+R3N4UsAUuEXCbkn
        gu+/NRoOfb1EKq9NS21RMZ0oGw==
X-Google-Smtp-Source: ABdhPJwzSzpqvu17RyZaImuVVXfRwCqv4PsquKh6+mxBIzxD361DDWk3HS5eFZVma3nchUiQEDg2Hw==
X-Received: by 2002:a17:903:1051:b0:15c:f02f:cd0e with SMTP id f17-20020a170903105100b0015cf02fcd0emr28805111plc.81.1652330875710;
        Wed, 11 May 2022 21:47:55 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id 5-20020a170902e9c500b0015edc07dcf3sm2790824plk.21.2022.05.11.21.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 21:47:55 -0700 (PDT)
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
Subject: [PATCH 3/5 v1] mm: add numa fields for tracepoint rss_stat
Date:   Thu, 12 May 2022 12:46:32 +0800
Message-Id: <20220512044634.63586-4-ligang.bdlg@bytedance.com>
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
index 1b6c2e912ec8..cde5529285d6 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2007,27 +2007,28 @@ static inline unsigned long get_mm_counter(struct mm_struct *mm, int member, int
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
index ddc8c944f417..2f4707d94624 100644
--- a/include/trace/events/kmem.h
+++ b/include/trace/events/kmem.h
@@ -347,7 +347,8 @@ static unsigned int __maybe_unused mm_ptr_to_hash(const void *ptr)
 	EM(MM_FILEPAGES)	\
 	EM(MM_ANONPAGES)	\
 	EM(MM_SWAPENTS)		\
-	EMe(MM_SHMEMPAGES)
+	EM(MM_SHMEMPAGES)	\
+	EMe(MM_NO_TYPE)
 
 #undef EM
 #undef EMe
@@ -367,29 +368,41 @@ TRACE_EVENT(rss_stat,
 
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
index adb07fb0b483..2d3040a190f6 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -170,9 +170,10 @@ static int __init init_zero_pfn(void)
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

