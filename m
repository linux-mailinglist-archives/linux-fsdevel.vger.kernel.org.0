Return-Path: <linux-fsdevel+bounces-50730-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB77FACEFBF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 14:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 236003ACCAA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 12:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4082253FF;
	Thu,  5 Jun 2025 12:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ZpWXzjcL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6A121D590;
	Thu,  5 Jun 2025 12:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749128327; cv=none; b=mD+OtJhAMyNX3cyIVaeosMIcuQvl9m8KhfrAMZPGhodO0pw4mdBDJjUFMrz/1WbeP3id36GmUMFZFvkhxZVgKwMb40NbmKDyEnlZGtw6yUgm+h1jJoo3mx5V0h+rFS23O0NhsBINZcwFSfj0XiRlcu9jl5sl9ZoDmDFOFIIzR0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749128327; c=relaxed/simple;
	bh=b1fne/a2Hlwob8vSxGXFclDlnjhc3RArSy3fosP+Duc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mrSihvPzYdcpsZJ2wpmuJdeHl8RLrQTQW6d3nXUVAgAuCDe/qSsn6E3T1GIIYyoboOOMMgGC8KfwRCtcB56bNZgmld+qDLp9QsgJOLvTIp0Q1vJe5U4slKL6qs90MLxgpSIFIlBdo0AyXs5A8UKP/DFCwP7s3m5IRlkX3eF0WEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ZpWXzjcL; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1749128320; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=1Dk53K+1nREQrA9jzQRa+fEPI5lfv5hZFEHqPDWUDYg=;
	b=ZpWXzjcLS3p4Q++iyAikBIRQh7rROgh4JMrS6G93CgPAOz2x+YKYWSSsX733n6BV0KP8EHkkBHbNkOGbx1OaxuHvk4F23qd4fBeracxrr6DdK0W3QKsDLB+7sijJajjajXol6v+Bf9jcadSgc4iysSWgUPDKari13rLtFMkTQqM=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Wd8HvvE_1749128318 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 05 Jun 2025 20:58:38 +0800
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
Subject: [PATCH v2] mm: fix the inaccurate memory statistics issue for users
Date: Thu,  5 Jun 2025 20:58:29 +0800
Message-ID: <f4586b17f66f97c174f7fd1f8647374fdb53de1c.1749119050.git.baolin.wang@linux.alibaba.com>
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

In addition, the 'mm->rss_stat' is updated by using add_mm_counter() and
dec/inc_mm_counter(), which are all wrappers around percpu_counter_add_batch().
In percpu_counter_add_batch(), there is percpu batch caching to avoid 'fbc->lock'
contention. This patch changes task_mem() and task_statm() to get the accurate
mm counters under the 'fbc->lock', but this should not exacerbate kernel
'mm->rss_stat' lock contention due to the percpu batch caching of the mm
counters. The following test also confirm the theoretical analysis.

I run the stress-ng that stresses anon page faults in 32 threads on my 32 cores
machine, while simultaneously running a script that starts 32 threads to
busy-loop pread each stress-ng thread's /proc/pid/status interface. From the
following data, I did not observe any obvious impact of this patch on the
stress-ng tests.

w/o patch:
stress-ng: info:  [6848]          4,399,219,085,152 CPU Cycles          67.327 B/sec
stress-ng: info:  [6848]          1,616,524,844,832 Instructions          24.740 B/sec (0.367 instr. per cycle)
stress-ng: info:  [6848]          39,529,792 Page Faults Total           0.605 M/sec
stress-ng: info:  [6848]          39,529,792 Page Faults Minor           0.605 M/sec

w/patch:
stress-ng: info:  [2485]          4,462,440,381,856 CPU Cycles          68.382 B/sec
stress-ng: info:  [2485]          1,615,101,503,296 Instructions          24.750 B/sec (0.362 instr. per cycle)
stress-ng: info:  [2485]          39,439,232 Page Faults Total           0.604 M/sec
stress-ng: info:  [2485]          39,439,232 Page Faults Minor           0.604 M/sec

Tested-by Donet Tom <donettom@linux.ibm.com>
Reviewed-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
Tested-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Acked-by: SeongJae Park <sj@kernel.org>
Acked-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
Changes from v1:
 - Update the commit message to add some measurements.
 - Add acked tag from Michal. Thanks.
 - Drop the Fixes tag.

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


