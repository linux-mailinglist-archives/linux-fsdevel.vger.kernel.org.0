Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE7D234522D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 23:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhCVWAR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 18:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbhCVV7z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 17:59:55 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F9AC061756
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Mar 2021 14:59:54 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id co15so232866pjb.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Mar 2021 14:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:cc;
        bh=voOmLAB+ChC2A4QEJf/yJCzWFfGe3YHCm7ZcDcYjjnU=;
        b=cd0M2VHOYGzQl8ZXH/1Sz3MjSzG2cudqMvnHDFR7ZzJq4unb+n72PKnDuWzta6zl56
         BT1G5HDQbp9Yo8Ym/E/Ed9bxayOeNfsP3OSuab7gWEBii+DL5NwY7Nkci6JOoXtnTHlV
         u+8jkHVP35f7FsExNWvgKUeF5xzdyzsQSZVvV/3wDVq/gUt4CajAGEJhK3ce9GVifPdN
         MdnIBUMdevzZaCIN0LcH0J4zJgPwDJpyhZoZkgg/cVJn2t/BBRzakpwcJvig9QNFaNH5
         4s/YDGKFKO/zGvlM7wWOFowipybMEr6brimqeTXqGP2eBz1Eh7yocLh7VM17Z/DLSKww
         OH8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc;
        bh=voOmLAB+ChC2A4QEJf/yJCzWFfGe3YHCm7ZcDcYjjnU=;
        b=NDEi3zeJF7UPRmZL1xzg5q5MTLhohguEwPXv0EDpZy1Flok8Drp1iSlq1uxz3xGaXF
         DywzfLsJK6pdIHzYnjNtBJHI1PuwQX7DZ7vlDeS4OWRZ15rjVFEVZ0LjXaVGC5W534Ov
         XG6FCmYemXLv+uIzCWWuyMdNs2ZXc84qsd5s//3mgpkf3K89SP7PP10siw8qwojrg08o
         Q4I26ylRiVYASr18qHJcyosrtDbFNMAv5Qwzsa6F0vYDYR9/RLE2fIJsr+gv6oXX4xUC
         4BpXEYkGJafY9HNQ9XiDR0kTCQ8gzjJ5WahsgbBx0sHonqU1+azA+2Jg/M66N0xWOeuy
         stXw==
X-Gm-Message-State: AOAM530redMzfoI43B6M8LiXOdpCN0Bh7iis/AfrUGeUE0ZH5OSf/n/V
        OONEpEp9Qwi+4iXU4N6V9P382QTn1UO8N09sTnw=
X-Google-Smtp-Source: ABdhPJwD6jhMxNK5nm1rj1xbPlntW8CX8SX1XOzhve/8dPDbQRmmU11dpDAzjKSMpeq7I2jfAjx+SWaxs9+WVLq47Hk=
X-Received: from cfijalkovich.mtv.corp.google.com ([2620:15c:211:202:3d09:6020:a2b1:f8fb])
 (user=cfijalkovich job=sendgmr) by 2002:a17:90a:ce0c:: with SMTP id
 f12mr1126811pju.11.1616450394091; Mon, 22 Mar 2021 14:59:54 -0700 (PDT)
Date:   Mon, 22 Mar 2021 14:58:23 -0700
Message-Id: <20210322215823.962758-1-cfijalkovich@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH] mm, thp: Relax the VM_DENYWRITE constraint on file-backed THPs
From:   Collin Fijalkovich <cfijalkovich@google.com>
Cc:     songliubraving@fb.com, surenb@google.com, hridya@google.com,
        kaleshsingh@google.com, hughd@google.com, timmurray@google.com,
        Collin Fijalkovich <cfijalkovich@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Transparent huge pages are supported for read-only non-shmem filesystems,
but are only used for vmas with VM_DENYWRITE. This condition ensures that
file THPs are protected from writes while an application is running
(ETXTBSY).  Any existing file THPs are then dropped from the page cache
when a file is opened for write in do_dentry_open(). Since sys_mmap
ignores MAP_DENYWRITE, this constrains the use of file THPs to vmas
produced by execve().

Systems that make heavy use of shared libraries (e.g. Android) are unable
to apply VM_DENYWRITE through the dynamic linker, preventing them from
benefiting from the resultant reduced contention on the TLB.

This patch reduces the constraint on file THPs allowing use with any
executable mapping from a file not opened for write (see
inode_is_open_for_write()). It also introduces additional conditions to
ensure that files opened for write will never be backed by file THPs.

Restricting the use of THPs to executable mappings eliminates the risk that
a read-only file later opened for write would encounter significant
latencies due to page cache truncation.

The ld linker flag '-z max-page-size=(hugepage size)' can be used to
produce executables with the necessary layout. The dynamic linker must
map these file's segments at a hugepage size aligned vma for the mapping to
be backed with THPs.

Signed-off-by: Collin Fijalkovich <cfijalkovich@google.com>
---
 fs/open.c       | 13 +++++++++++--
 mm/khugepaged.c | 16 +++++++++++++++-
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index e53af13b5835..f76e960d10ea 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -852,8 +852,17 @@ static int do_dentry_open(struct file *f,
 	 * XXX: Huge page cache doesn't support writing yet. Drop all page
 	 * cache for this file before processing writes.
 	 */
-	if ((f->f_mode & FMODE_WRITE) && filemap_nr_thps(inode->i_mapping))
-		truncate_pagecache(inode, 0);
+	if (f->f_mode & FMODE_WRITE) {
+		/*
+		 * Paired with smp_mb() in collapse_file() to ensure nr_thps
+		 * is up to date and the update to i_writecount by
+		 * get_write_access() is visible. Ensures subsequent insertion
+		 * of THPs into the page cache will fail.
+		 */
+		smp_mb();
+		if (filemap_nr_thps(inode->i_mapping))
+			truncate_pagecache(inode, 0);
+	}
 
 	return 0;
 
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index a7d6cb912b05..4c7cc877d5e3 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -459,7 +459,8 @@ static bool hugepage_vma_check(struct vm_area_struct *vma,
 
 	/* Read-only file mappings need to be aligned for THP to work. */
 	if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) && vma->vm_file &&
-	    (vm_flags & VM_DENYWRITE)) {
+	    !inode_is_open_for_write(vma->vm_file->f_inode) &&
+	    (vm_flags & VM_EXEC)) {
 		return IS_ALIGNED((vma->vm_start >> PAGE_SHIFT) - vma->vm_pgoff,
 				HPAGE_PMD_NR);
 	}
@@ -1872,6 +1873,19 @@ static void collapse_file(struct mm_struct *mm,
 	else {
 		__mod_lruvec_page_state(new_page, NR_FILE_THPS, nr);
 		filemap_nr_thps_inc(mapping);
+		/*
+		 * Paired with smp_mb() in do_dentry_open() to ensure
+		 * i_writecount is up to date and the update to nr_thps is
+		 * visible. Ensures the page cache will be truncated if the
+		 * file is opened writable.
+		 */
+		smp_mb();
+		if (inode_is_open_for_write(mapping->host)) {
+			result = SCAN_FAIL;
+			__mod_lruvec_page_state(new_page, NR_FILE_THPS, -nr);
+			filemap_nr_thps_dec(mapping);
+			goto xa_locked;
+		}
 	}
 
 	if (nr_none) {
-- 
2.31.0.rc2.261.g7f71774620-goog

