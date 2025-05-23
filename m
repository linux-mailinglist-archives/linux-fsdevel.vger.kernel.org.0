Return-Path: <linux-fsdevel+bounces-49705-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E6AAC1A5A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 05:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72C234A6A86
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 03:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5291122126D;
	Fri, 23 May 2025 03:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="um2upLww"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A072DCBE7;
	Fri, 23 May 2025 03:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747970189; cv=none; b=dM8tfpbTVcKVT5W1nocPcy+hivmily1iGeld536e4sPIy0D79PllvDjQYP9BrpDSSf03K2w1L8l/KpoQInT5e166AmsIPzTQfHJf4OODf+yq9gvcdmOE4oGGYQ/V05EiWXnQkTeaZkbmJgf1RZl8ahIUwtjk44w6FxaEuTklp1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747970189; c=relaxed/simple;
	bh=4ILR+KNCVjzNUNFwBTMlAvwJnCMmVeT55gitSiQ3iZw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CScwlO+jDebVUuKABwVI+kTePXMuXmzCmacjwnlJsmwARR1Wy/UgvHtVtMNsaA4bbjlyaCHZPVOqkliiCbcDKtlOPOFrWmknDtWQ3icjsEufl0nGWXUydijAa7CUFGLvcyfpbXQPVudIe0GqT8vipB+mu7oVooSBgqJaiezX5iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=um2upLww; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1747970184; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=WFP3g7I4K8WGl+2djGsOu7kO5N2vxrcXlNXYY/Iekm8=;
	b=um2upLwwfnBcL2SA5WVhauQ/3MqArXJmr6jFHbWnjYgx3naUFQvjh7LQ17A0UB3iT0JCrOsqXa18XHSmqgQrzoiq378wIys1wHzk2c6QAOvRG+M0qYks/8w+hvproj3iUGCWH+taxoB6Oq6P3ZxB9n8XASNjgHooKiwwzle1j4w=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WbYd28j_1747970183 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 23 May 2025 11:16:23 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	shakeelb@google.com
Cc: lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH] mm: fix the inaccurate memory statistics issue for users
Date: Fri, 23 May 2025 11:16:13 +0800
Message-ID: <3dd21f662925c108cfe706c8954e8c201a327550.1747969935.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On some large machines with a high number of CPUs running a 64K kernel,
we found that the 'RES' field is always 0 displayed by the top command
for some processes, which will cause a lot of confusion for users.

    PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
 875525 root      20   0   12480      0      0 R   0.3   0.0   0:00.08 top
      1 root      20   0  172800      0      0 S   0.0   0.0   0:04.52 systemd

The main reason is that the batch size of the percpu counter is quite large
on these machines, caching a significant percpu value, since converting mm's
rss stats into percpu_counter by commit f1a7941243c1 ("mm: convert mm's rss
stats into percpu_counter"). Intuitively, the batch number should be optimized,
but on some paths, performance may take precedence over statistical accuracy.
Therefore, introducing a new interface to add the percpu statistical count
and display it to users, which can remove the confusion. In addition, this
change is not expected to be on a performance-critical path, so the modification
should be acceptable.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 fs/proc/task_mmu.c | 14 +++++++-------
 include/linux/mm.h |  5 +++++
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index b9e4fbbdf6e6..f629e6526935 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -36,9 +36,9 @@ void task_mem(struct seq_file *m, struct mm_struct *mm)
 	unsigned long text, lib, swap, anon, file, shmem;
 	unsigned long hiwater_vm, total_vm, hiwater_rss, total_rss;
 
-	anon = get_mm_counter(mm, MM_ANONPAGES);
-	file = get_mm_counter(mm, MM_FILEPAGES);
-	shmem = get_mm_counter(mm, MM_SHMEMPAGES);
+	anon = get_mm_counter_sum(mm, MM_ANONPAGES);
+	file = get_mm_counter_sum(mm, MM_FILEPAGES);
+	shmem = get_mm_counter_sum(mm, MM_SHMEMPAGES);
 
 	/*
 	 * Note: to minimize their overhead, mm maintains hiwater_vm and
@@ -59,7 +59,7 @@ void task_mem(struct seq_file *m, struct mm_struct *mm)
 	text = min(text, mm->exec_vm << PAGE_SHIFT);
 	lib = (mm->exec_vm << PAGE_SHIFT) - text;
 
-	swap = get_mm_counter(mm, MM_SWAPENTS);
+	swap = get_mm_counter_sum(mm, MM_SWAPENTS);
 	SEQ_PUT_DEC("VmPeak:\t", hiwater_vm);
 	SEQ_PUT_DEC(" kB\nVmSize:\t", total_vm);
 	SEQ_PUT_DEC(" kB\nVmLck:\t", mm->locked_vm);
@@ -92,12 +92,12 @@ unsigned long task_statm(struct mm_struct *mm,
 			 unsigned long *shared, unsigned long *text,
 			 unsigned long *data, unsigned long *resident)
 {
-	*shared = get_mm_counter(mm, MM_FILEPAGES) +
-			get_mm_counter(mm, MM_SHMEMPAGES);
+	*shared = get_mm_counter_sum(mm, MM_FILEPAGES) +
+			get_mm_counter_sum(mm, MM_SHMEMPAGES);
 	*text = (PAGE_ALIGN(mm->end_code) - (mm->start_code & PAGE_MASK))
 								>> PAGE_SHIFT;
 	*data = mm->data_vm + mm->stack_vm;
-	*resident = *shared + get_mm_counter(mm, MM_ANONPAGES);
+	*resident = *shared + get_mm_counter_sum(mm, MM_ANONPAGES);
 	return mm->total_vm;
 }
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 185424858f23..15ec5cfe9515 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2568,6 +2568,11 @@ static inline unsigned long get_mm_counter(struct mm_struct *mm, int member)
 	return percpu_counter_read_positive(&mm->rss_stat[member]);
 }
 
+static inline unsigned long get_mm_counter_sum(struct mm_struct *mm, int member)
+{
+	return percpu_counter_sum_positive(&mm->rss_stat[member]);
+}
+
 void mm_trace_rss_stat(struct mm_struct *mm, int member);
 
 static inline void add_mm_counter(struct mm_struct *mm, int member, long value)
-- 
2.43.5


