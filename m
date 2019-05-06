Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66D4B150BD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2019 17:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfEFPx6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 May 2019 11:53:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:3346 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726321AbfEFPx6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 May 2019 11:53:58 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7C482306D334;
        Mon,  6 May 2019 15:53:57 +0000 (UTC)
Received: from jsavitz.bos.com (dhcp-17-161.bos.redhat.com [10.18.17.161])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3793560BEC;
        Mon,  6 May 2019 15:53:48 +0000 (UTC)
From:   Joel Savitz <jsavitz@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Joel Savitz <jsavitz@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Ram Pai <linuxram@us.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Huang Ying <ying.huang@intel.com>,
        Sandeep Patil <sspatil@android.com>,
        Rafael Aquini <aquini@redhat.com>,
        Yury Norov <yury.norov@gmail.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3] fs/proc: add VmTaskSize field to /proc/$$/status
Date:   Mon,  6 May 2019 11:53:43 -0400
Message-Id: <1557158023-23021-1-git-send-email-jsavitz@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Mon, 06 May 2019 15:53:58 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is currently no easy and architecture-independent way to find the
lowest unusable virtual address available to a process without
brute-force calculation. This patch allows a user to easily retrieve
this value via /proc/<pid>/status.

Using this patch, any program that previously needed to waste cpu cycles
recalculating a non-sensitive process-dependent value already known to
the kernel can now be optimized to use this mechanism.

Signed-off-by: Joel Savitz <jsavitz@redhat.com>
---
 Documentation/filesystems/proc.txt | 2 ++
 fs/proc/task_mmu.c                 | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/Documentation/filesystems/proc.txt b/Documentation/filesystems/proc.txt
index 66cad5c86171..1c6a912e3975 100644
--- a/Documentation/filesystems/proc.txt
+++ b/Documentation/filesystems/proc.txt
@@ -187,6 +187,7 @@ read the file /proc/PID/status:
   VmLib:      1412 kB
   VmPTE:        20 kb
   VmSwap:        0 kB
+  VmTaskSize:	137438953468 kB
   HugetlbPages:          0 kB
   CoreDumping:    0
   THP_enabled:	  1
@@ -263,6 +264,7 @@ Table 1-2: Contents of the status files (as of 4.19)
  VmPTE                       size of page table entries
  VmSwap                      amount of swap used by anonymous private data
                              (shmem swap usage is not included)
+ VmTaskSize                  lowest unusable address in process virtual memory
  HugetlbPages                size of hugetlb memory portions
  CoreDumping                 process's memory is currently being dumped
                              (killing the process may lead to a corrupted core)
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 95ca1fe7283c..0af7081f7b19 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -74,6 +74,8 @@ void task_mem(struct seq_file *m, struct mm_struct *mm)
 	seq_put_decimal_ull_width(m,
 		    " kB\nVmPTE:\t", mm_pgtables_bytes(mm) >> 10, 8);
 	SEQ_PUT_DEC(" kB\nVmSwap:\t", swap);
+	seq_put_decimal_ull_width(m,
+		    " kB\nVmTaskSize:\t", mm->task_size >> 10, 8);
 	seq_puts(m, " kB\n");
 	hugetlb_report_usage(m, mm);
 }
-- 
2.18.1

