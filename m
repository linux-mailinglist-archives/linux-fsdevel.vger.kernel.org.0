Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B574912CC7C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Dec 2019 06:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfL3FEx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Dec 2019 00:04:53 -0500
Received: from mail.oriontransfer.net ([45.56.91.4]:41446 "EHLO
        mail.oriontransfer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbfL3FEx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Dec 2019 00:04:53 -0500
X-Greylist: delayed 584 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Dec 2019 00:04:53 EST
Received: from koyoko.local (unknown [151.210.215.183])
        by mail.oriontransfer.net (Postfix) with ESMTPSA id 0FC6F2AFB2;
        Mon, 30 Dec 2019 04:55:07 +0000 (UTC)
From:   Samuel Williams <samuel.williams@oriontransfer.co.nz>
To:     adobriyan@gmail.com, linux-fsdevel@vger.kernel.org
Cc:     Samuel Williams <samuel.williams@oriontransfer.co.nz>
Subject: [PATCH] Fix alignment of value in /proc/$pid/smaps
Date:   Mon, 30 Dec 2019 17:53:03 +1300
Message-Id: <20191230045303.226623-1-samuel.williams@oriontransfer.co.nz>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The /proc/$pid/smaps output has an alignment issue for the field
FilePmdMapped and THPeligible.

Increases the alignment of FilePmdMapped by 1 space, and converts the
alignment of THPeligible to use spaces instead of tabs, to be consistent
with the other fields.
---
 fs/proc/task_mmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 9442631fd4af..f7ca20af2371 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -810,7 +810,7 @@ static void __show_smap(struct seq_file *m, const struct mem_size_stats *mss,
 	SEQ_PUT_DEC(" kB\nLazyFree:       ", mss->lazyfree);
 	SEQ_PUT_DEC(" kB\nAnonHugePages:  ", mss->anonymous_thp);
 	SEQ_PUT_DEC(" kB\nShmemPmdMapped: ", mss->shmem_thp);
-	SEQ_PUT_DEC(" kB\nFilePmdMapped: ", mss->file_thp);
+	SEQ_PUT_DEC(" kB\nFilePmdMapped:  ", mss->file_thp);
 	SEQ_PUT_DEC(" kB\nShared_Hugetlb: ", mss->shared_hugetlb);
 	seq_put_decimal_ull_width(m, " kB\nPrivate_Hugetlb: ",
 				  mss->private_hugetlb >> 10, 7);
@@ -840,7 +840,7 @@ static int show_smap(struct seq_file *m, void *v)
 
 	__show_smap(m, &mss, false);
 
-	seq_printf(m, "THPeligible:		%d\n",
+	seq_printf(m, "THPeligible:           %d\n",
 		   transparent_hugepage_enabled(vma));
 
 	if (arch_pkeys_enabled())
-- 
2.24.1

