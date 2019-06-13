Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18C8B43779
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2019 16:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732641AbfFMO7A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jun 2019 10:59:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40622 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732610AbfFMOzJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jun 2019 10:55:09 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AB71680494;
        Thu, 13 Jun 2019 14:55:06 +0000 (UTC)
Received: from jsavitz.bos.com (dhcp-17-175.bos.redhat.com [10.18.17.175])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F0F8D6061E;
        Thu, 13 Jun 2019 14:55:00 +0000 (UTC)
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
        Rafael Aquini <aquini@redhat.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v4] fs/proc: add VmTaskSize field to /proc/$$/status
Date:   Thu, 13 Jun 2019 10:54:50 -0400
Message-Id: <1560437690-13919-1-git-send-email-jsavitz@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 13 Jun 2019 14:55:08 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The kernel provides no architecture-independent mechanism to get the
size of the virtual address space of a task (userspace process) without
brute-force calculation. This patch allows a user to easily retrieve
this value via a new VmTaskSize entry in /proc/$$/status.

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
+ VmTaskSize                  size of task (userspace process) vm space
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

