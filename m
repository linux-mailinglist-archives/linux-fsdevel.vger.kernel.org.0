Return-Path: <linux-fsdevel+bounces-74044-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B5313D2B659
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 05:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D79573010051
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 04:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E92346766;
	Fri, 16 Jan 2026 04:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Vaf1jmIH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F125A3396E0;
	Fri, 16 Jan 2026 04:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768537797; cv=none; b=eF+iROSow4nqcYbrU6k8tKk6EiAm3sdIKa1IUqbF5JS+LDqkX/KWriELMGydBd8sVMU3gF3MaovvzsEISpgNI0fG0RS+AWC0XPsfPFGUb+hZPes283iNUGIGLMLclCUSxHGrjxY50fjdIqkcAHvjvPQI8RuiJQBBsGpkkTQMqSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768537797; c=relaxed/simple;
	bh=Zf4kittjBNRDVR6tEC+WOQoDjn0D3icLHME9K0CwPzQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O2GWoCRrKz7/Fwfwd6uIuNnwUT+5dIjBnRTRPQgn4rVXCFZwvPLHY0L5jqecrlB8sl7mJftJYrfESn2GulLmLZMLjNXaXX5Fq5SDC7od/MQWM+wtPs9ywEw8mX+2LuddKojKo5b9xWQRk7LVn30EHU3D5Sz2U13P6kBf6v6mS7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Vaf1jmIH; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=eP
	3njpltV1K3EjB4QjEgVjSquOOd4TFp8ei/1PUu6Eg=; b=Vaf1jmIHGcNwl9UAQR
	6BkVNv8uVwonPOQf4treTG49XEm6Hi5Dffx0PpzO2pHG1XBmSRbJk5EgGIaLRtXE
	KEizFlS+CY/8FlDMvxmuo+V3bHaRdPUjdJ2OlehSYSOkYufAmI3vBCvcnmWXIvgZ
	yNwI0ganUUDJPeu/ZD7/ca5jg=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wBnsI5jvmlpEDHXGA--.25381S2;
	Fri, 16 Jan 2026 12:28:21 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: akpm@linux-foundation.org,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	riel@surriel.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	harry.yoo@oracle.com,
	jannh@google.com,
	willy@infradead.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	zhengqi.arch@bytedance.com,
	shakeel.butt@linux.dev
Cc: kuba@kernel.org,
	jackzxcui1989@163.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] mm: vmscan: add skipexec mode not to reclaim pages with VM_EXEC vma flag
Date: Fri, 16 Jan 2026 12:28:17 +0800
Message-Id: <20260116042817.3790405-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBnsI5jvmlpEDHXGA--.25381S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3WrWUGw4UCFyDuF4UZw47Arb_yoW7ZF4UpF
	Z7Gr18KF4rJr13Z397AF47Zw15t3yrKF47GFW2934xZwnxWFyvqF93KFyYyF1Fkrs7XFya
	qr42yFWruw4rAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRAR6rUUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/xtbCvwV9h2lpvmXzyAAA3g

For some embedded systems, .text segments are often fixed. In situations
of high memory pressure, these fixed segments may be reclaimed by the
system, leading to iowait when these segments will be used again.
The iowait problem becomes even more severe due to the following reasons:

1. The reclaimed code segments are often those that handle exceptional
scenarios, which are not frequently executed. When memory pressure
increases, the entire system can become sluggish, leading to execution of
these seldom-used exception-handling code segments. Since these segments
are more likely to be reclaimed from memory, this exacerbates system
sluggishness.

2. The reclaimed code segments used for exception handling are often
shared by multiple tasks, causing these tasks to wait on the folio's
PG_locked bit, further increasing I/O wait.

3. Under memory pressure, the reclamation of code segments is often
scattered and randomly distributed, slowing down the efficiency of block
device reads and further exacerbating I/O wait.

While this issue could be addressed by preloading a library mlock all
executable segments, it would lead to many code segments that are never
used being locked, resulting in memory waste.

In systems where code execution is relatively fixed, preventing currently
in-use code segments from being reclaimed makes sense. This acts as a
self-adaptive way for the system to lock the necessary portions, which
saves memory compared to locking all code segments with mlock.

Introduce /proc/sys/vm/skipexec_enabled that can be set to 1 to enable
this feature. When this feature is enabled, during memory reclamation
logic, a flag TTU_SKIP_EXEC will be passed to try_to_unmap, allowing
try_to_unmap_one to check if the vma has the VM_EXEC attribute when flag
TTU_SKIP_EXEC is present. If the VM_EXEC attribute is set, it will skip
the unmap operation.

In the same scenario of locking a large file with vmtouch -l, our tests
showed that without enabling the skipexec_enabled feature, the number of
occurrences where iowait exceeded 20ms was 47,457, the longest iowait is
3 seconds. After enabling the skipexec_enabled feature, the number of
occurrences dropped to only 34, the longest iowait is only 44ms, and none
of these 34 instances were due to page cache file pages causing I/O wait.

Signed-off-by: Xin Zhao <jackzxcui1989@163.com>
---
 include/linux/rmap.h      |  1 +
 include/linux/writeback.h |  1 +
 mm/page-writeback.c       | 14 ++++++++++++--
 mm/rmap.c                 |  3 +++
 mm/vmscan.c               |  2 ++
 5 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index daa92a585..6a919f27e 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -101,6 +101,7 @@ enum ttu_flags {
 					 * do a final flush if necessary */
 	TTU_RMAP_LOCKED		= 0x80,	/* do not grab rmap lock:
 					 * caller holds it */
+	TTU_SKIP_EXEC		= 0x100,/* skip VM_MAYEXEC when unmap */
 };
 
 #ifdef CONFIG_MMU
diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index f48e8ccff..16cf08028 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -343,6 +343,7 @@ extern struct wb_domain global_wb_domain;
 extern unsigned int dirty_writeback_interval;
 extern unsigned int dirty_expire_interval;
 extern int laptop_mode;
+extern int skipexec_enabled;
 
 void global_dirty_limits(unsigned long *pbackground, unsigned long *pdirty);
 unsigned long wb_calc_thresh(struct bdi_writeback *wb, unsigned long thresh);
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index ccdeb0e84..e7c4a35ad 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -101,7 +101,6 @@ static unsigned long vm_dirty_bytes;
  * The interval between `kupdate'-style writebacks
  */
 unsigned int dirty_writeback_interval = 5 * 100; /* centiseconds */
-
 EXPORT_SYMBOL_GPL(dirty_writeback_interval);
 
 /*
@@ -114,9 +113,11 @@ unsigned int dirty_expire_interval = 30 * 100; /* centiseconds */
  * a full sync is triggered after this time elapses without any disk activity.
  */
 int laptop_mode;
-
 EXPORT_SYMBOL(laptop_mode);
 
+int skipexec_enabled;
+EXPORT_SYMBOL(skipexec_enabled);
+
 /* End of sysctl-exported parameters */
 
 struct wb_domain global_wb_domain;
@@ -2334,6 +2335,15 @@ static const struct ctl_table vm_page_writeback_sysctls[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_jiffies,
 	},
+	{
+		.procname	= "skipexec_enabled",
+		.data		= &skipexec_enabled,
+		.maxlen		= sizeof(skipexec_enabled),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
 };
 #endif
 
diff --git a/mm/rmap.c b/mm/rmap.c
index f955f02d5..5f528a03a 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1864,6 +1864,9 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 	unsigned long hsz = 0;
 	int ptes = 0;
 
+	if ((flags & TTU_SKIP_EXEC) && (vma->vm_flags & VM_EXEC))
+		return false;
+
 	/*
 	 * When racing against e.g. zap_pte_range() on another cpu,
 	 * in between its ptep_get_and_clear_full() and folio_remove_rmap_*(),
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 670fe9fae..c9ca65aa9 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1350,6 +1350,8 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 
 			if (folio_test_pmd_mappable(folio))
 				flags |= TTU_SPLIT_HUGE_PMD;
+			if (skipexec_enabled)
+				flags |= TTU_SKIP_EXEC;
 			/*
 			 * Without TTU_SYNC, try_to_unmap will only begin to
 			 * hold PTL from the first present PTE within a large
-- 
2.34.1


