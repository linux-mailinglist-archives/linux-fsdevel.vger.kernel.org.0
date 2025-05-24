Return-Path: <linux-fsdevel+bounces-49804-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF19CAC2D00
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 May 2025 04:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B3E01C06CD8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 May 2025 02:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85AAD18DB0E;
	Sat, 24 May 2025 02:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="iGM1QGsL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFC1288A5;
	Sat, 24 May 2025 02:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748052013; cv=none; b=OKpmocpjMjJEAsa+QF9vMaOGNZhdBqK/43RZBMJS5YBGmyIkAPkSf0SmAPLPc1GfMogC3u3mMucbZygMHN+lsAPahWCA4mG62VC2H6b1fT8VvNOHqi8CDBm5oUl6yZYaLHYvhvyukCcbhh256+Nu3T32t68ib6+i+1qSy9u0QZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748052013; c=relaxed/simple;
	bh=yVsIs9c2VNbcBMNMt2QKM6J6M2oE1mZDuv/fT2zyWkk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XBRiF5nFTYnXa8a3Iu8IZ95R7ummyHKtWSs41hzrRmKdZ0mapoLShxuuZfOr4RrbC5MFEuG5FVMO8ECBL+zYXJveskLj5DZLrcO7AXS9K0KGhKVD0TIREFm2TCi14uWgeHRaKrDHnFzMqqRMu0zcZ2kXkCYvev825xrkEuFH38E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=iGM1QGsL; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1748052007; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=+lI6y2wDJ47d4yiPcvPJikdG0IMfeTY5l5iLcdXaZ4c=;
	b=iGM1QGsLFrKnaqh43kXkDXkmQ3/cLlmyVkhEkFgRxYMEvdzDG2a7x+JLDllCObjbCfs6ib/qYv3TyM/00MYN0MVwdYyh17HPxD3kn91orMhJSR37X+s5j+pt15cazYQ6kYj5GYaLo+eLNRd3V6FnHZ6ozJanklEMNMuc3w5I2/0=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WbcNlVP_1748052005 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 24 May 2025 10:00:05 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	shakeel.butt@linux.dev
Cc: lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	donettom@linux.ibm.com,
	aboorvad@linux.ibm.com,
	sj@kernel.org,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm: fix the inaccurate memory statistics issue for users
Date: Sat, 24 May 2025 09:59:53 +0800
Message-ID: <4f0fd51eb4f48c1a34226456b7a8b4ebff11bf72.1748051851.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On some large machines with a high number of CPUs running a 64K pagesize
kernel, we found that the 'RES' field is always 0 displayed by the top
command for some processes, which will cause a lot of confusion for users.

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

Fixes: f1a7941243c1 ("mm: convert mm's rss stats into percpu_counter")
Tested-by Donet Tom <donettom@linux.ibm.com>
Reviewed-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
Tested-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Acked-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
Changes from RFC:
 - Collect reviewed and tested tags. Thanks.
 - Add Fixes tag.
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


