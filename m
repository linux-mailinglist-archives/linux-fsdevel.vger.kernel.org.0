Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B47E354990
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Apr 2021 02:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238506AbhDFAJm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Apr 2021 20:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238223AbhDFAJl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Apr 2021 20:09:41 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DBCC06174A
        for <linux-fsdevel@vger.kernel.org>; Mon,  5 Apr 2021 17:09:34 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id f75so18565881yba.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Apr 2021 17:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:cc;
        bh=SbZbPTFJCpAYJ6ceslhgL56jY3VfoMYUKBkk6r45HOA=;
        b=UZ9KBrbI1nM5xWuW0nXCQxtVxWoF1SZ25VkOCplQ+47tOX9JP+PJmjURhaLLNtXhyk
         3F3h2hbNyjKoSemmCs8bvDw0BPhtD64GzUFH08dJxnkhoEK+WeaEY8JVrQlHi/41c1Zu
         Ze/UfoBaoeiH4fF077FjUMKUmoujB4X9friykVh6uM7Ceh0Q5KaOaAM/vXElJNETc3w6
         SYxrrW+ESxgWySiYyMbE77PsbB6OAScAhcURo9CSrXqytfzFXjB2k2T4Q3GX25BYSely
         9ZMsxQ5GPzaBRyj5XO3uDB1f9Z4ciwDNH1dOzFl28oRGrLD2z8HH9emjhNGnrv7N1gRy
         b0Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc;
        bh=SbZbPTFJCpAYJ6ceslhgL56jY3VfoMYUKBkk6r45HOA=;
        b=iMYwfzk5AgBdccBUwf5RW7D4ulUV8OobEJsjDOc3i//J38eOnm/OhRygC7zIndqW5S
         1jJSxTZXxs011t7td6DPl9FozAsQIXznhGroqHL35g/6ov5IPeOX2ZY7hEzoC9WVTSsE
         ruiEqWmJ0NVBNX68y+nbpI5fDRNcj5zpbfGh8W0yJTx3e/1vV9GTtne3V8URvR/TD3CU
         zGdJuml0jncbXQakNvY0OBmVkzKkiMmsZp75+/A+02MRjwKdeEjDdMnvMFpY82BIs1CQ
         UjiLDZE3hdRTbDpE9CGRpsd7AvNaBqKPHX7Cc+7r3cC193uXDSU7aV62BSYmJ86jkWOW
         SFIQ==
X-Gm-Message-State: AOAM532U+WHFWK33JrGs3lFOiRC9gOqNgNCp93ugH6kf9ejAiqeGuh74
        99Vs8afxt+a6OSBkv7murMSRQhU7kEmtJjPP0FA=
X-Google-Smtp-Source: ABdhPJyH2Z75+zMmJGcVncBwU1GYAMfWaNqXsTaEBlC4zPdwlyE4IHogLTW0mZbB4cUHkPX5YurIObOVuoCJ0Pxtw68=
X-Received: from cfijalkovich.mtv.corp.google.com ([2620:15c:211:202:76bb:8f57:ed5a:ae22])
 (user=cfijalkovich job=sendgmr) by 2002:a25:4014:: with SMTP id
 n20mr38672945yba.39.1617667774125; Mon, 05 Apr 2021 17:09:34 -0700 (PDT)
Date:   Mon,  5 Apr 2021 17:09:30 -0700
Message-Id: <20210406000930.3455850-1-cfijalkovich@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
Subject: [PATCH v2] mm, thp: Relax the VM_DENYWRITE constraint on file-backed THPs
From:   Collin Fijalkovich <cfijalkovich@google.com>
Cc:     songliubraving@fb.com, surenb@google.com, hridya@google.com,
        kaleshsingh@google.com, hughd@google.com, timmurray@google.com,
        william.kucharski@oracle.com, akpm@linux-foundation.org,
        willy@infradead.org, Collin Fijalkovich <cfijalkovich@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Transparent huge pages are supported for read-only non-shmem files,
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

Comparison of the performance characteristics of 4KB and 2MB-backed
libraries follows; the Android dex2oat tool was used to AOT compile an
example application on a single ARM core.

4KB Pages:
==========

count              event_name            # count / runtime
598,995,035,942    cpu-cycles            # 1.800861 GHz
 81,195,620,851    raw-stall-frontend    # 244.112 M/sec
347,754,466,597    iTLB-loads            # 1.046 G/sec
  2,970,248,900    iTLB-load-misses      # 0.854122% miss rate

Total test time: 332.854998 seconds.

2MB Pages:
==========

count              event_name            # count / runtime
592,872,663,047    cpu-cycles            # 1.800358 GHz
 76,485,624,143    raw-stall-frontend    # 232.261 M/sec
350,478,413,710    iTLB-loads            # 1.064 G/sec
    803,233,322    iTLB-load-misses      # 0.229182% miss rate

Total test time: 329.826087 seconds

A check of /proc/$(pidof dex2oat64)/smaps shows THPs in use:

/apex/com.android.art/lib64/libart.so
FilePmdMapped:      4096 kB

/apex/com.android.art/lib64/libart-compiler.so
FilePmdMapped:      2048 kB

Signed-off-by: Collin Fijalkovich <cfijalkovich@google.com>
---
Changes v1 -> v2:
* commit message 'non-shmem filesystems' -> 'non-shmem files'
* Add performance testing data to commit message

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
2.31.0.208.g409f899ff0-goog

