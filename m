Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC3965862
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2019 16:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbfGKOAU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Jul 2019 10:00:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:51088 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726116AbfGKOAT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Jul 2019 10:00:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F326BAF10;
        Thu, 11 Jul 2019 14:00:16 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 274F01E43CA; Thu, 11 Jul 2019 16:00:16 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     <linux-mm@kvack.org>, <linux-xfs@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Boaz Harrosh <boaz@plexistor.com>, Jan Kara <jack@suse.cz>,
        stable@vger.kernel.org
Subject: [PATCH 1/3] mm: Handle MADV_WILLNEED through vfs_fadvise()
Date:   Thu, 11 Jul 2019 16:00:10 +0200
Message-Id: <20190711140012.1671-2-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190711140012.1671-1-jack@suse.cz>
References: <20190711140012.1671-1-jack@suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently handling of MADV_WILLNEED hint calls directly into readahead
code. Handle it by calling vfs_fadvise() instead so that filesystem can
use its ->fadvise() callback to acquire necessary locks or otherwise
prepare for the request.

Suggested-by: Amir Goldstein <amir73il@gmail.com>
CC: stable@vger.kernel.org # Needed by "xfs: Fix stale data exposure
					when readahead races with hole punch"
Signed-off-by: Jan Kara <jack@suse.cz>
---
 mm/madvise.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 628022e674a7..ae56d0ef337d 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -14,6 +14,7 @@
 #include <linux/userfaultfd_k.h>
 #include <linux/hugetlb.h>
 #include <linux/falloc.h>
+#include <linux/fadvise.h>
 #include <linux/sched.h>
 #include <linux/ksm.h>
 #include <linux/fs.h>
@@ -275,6 +276,7 @@ static long madvise_willneed(struct vm_area_struct *vma,
 			     unsigned long start, unsigned long end)
 {
 	struct file *file = vma->vm_file;
+	loff_t offset;
 
 	*prev = vma;
 #ifdef CONFIG_SWAP
@@ -298,12 +300,20 @@ static long madvise_willneed(struct vm_area_struct *vma,
 		return 0;
 	}
 
-	start = ((start - vma->vm_start) >> PAGE_SHIFT) + vma->vm_pgoff;
-	if (end > vma->vm_end)
-		end = vma->vm_end;
-	end = ((end - vma->vm_start) >> PAGE_SHIFT) + vma->vm_pgoff;
-
-	force_page_cache_readahead(file->f_mapping, file, start, end - start);
+	/*
+	 * Filesystem's fadvise may need to take various locks.  We need to
+	 * explicitly grab a reference because the vma (and hence the
+	 * vma's reference to the file) can go away as soon as we drop
+	 * mmap_sem.
+	 */
+	*prev = NULL;	/* tell sys_madvise we drop mmap_sem */
+	get_file(file);
+	up_read(&current->mm->mmap_sem);
+	offset = (loff_t)(start - vma->vm_start)
+			+ ((loff_t)vma->vm_pgoff << PAGE_SHIFT);
+	vfs_fadvise(file, offset, end - start, POSIX_FADV_WILLNEED);
+	fput(file);
+	down_read(&current->mm->mmap_sem);
 	return 0;
 }
 
-- 
2.16.4

