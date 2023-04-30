Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0886F2B58
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 May 2023 00:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbjD3W0r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Apr 2023 18:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbjD3W0p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Apr 2023 18:26:45 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C841A8;
        Sun, 30 Apr 2023 15:26:43 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f09b4a1584so10641415e9.2;
        Sun, 30 Apr 2023 15:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682893602; x=1685485602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yb73uisocFKIniSChsToEe21gb62ZyaVkxC6mK3mItE=;
        b=gsFUOW0Y9mVkXYV4t1E3PZo4X+N6fp7jxDS8tKbqlcgdlkmj2YG0RghKtdWI4BHcOn
         xmp8KAt5xli9RCnbEdUVxSSUWCGjy24PH09/PdiiJh7jpjCgPLpX2EhIJuaszKUJClIO
         yUPl5VmCgoUzeb6EVEGupAsJVFpMsZGFY8XhBfz7ERKU5+CTzb/dsrItI8T4HkBJZvd3
         jglAD7KNqidPxalMHaS4SSmu+1+R2DLYIOztB9CPpdBc4DkwwKFLL1a/QyUKGiikRpE0
         z8rsTAmdz1M0ur6TcRjjdsphLB3CeA9C+VoFBwIAfT4upypl8VdTAVrSyVvooMoXErfV
         /n0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682893602; x=1685485602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yb73uisocFKIniSChsToEe21gb62ZyaVkxC6mK3mItE=;
        b=ilAivtNeVo8LZusXWj3IL1/TCSdVMrTkvaltR8wiamqysfzkQGXmL0dDhvMO9dErl7
         NBlwglQBfNt5tY9/DPIlBxlLH9l84XxpTVPZMZZOBZEJ3NXe5C6bBpA1a6RMwdJCtqh9
         qcS9AT6p8JjxwjkRQC1gMy/uiqzl8j5qp4zTH2v9j04+sWqMIMlQp1tut7u3cx5+cCRM
         XjumUH0IYJPXVYHKg8s7K4ZXoJDbuKRVTcW0emX7dYuQasFtzXXi7qJVSk3LBHYOdXxP
         /VgMNrkskja2ZT82uHjZ1t9ZdXtZWhEaI3JmuddTkbcZlQfbN2WXw7LfxaFh5Bwc+PGz
         YpDw==
X-Gm-Message-State: AC+VfDxyOCgQOY9Y/bU4kwd+uTUIxXAOm/4nHS2mwm09hSoYjZ/yATK8
        Lzs/5jeIQrTtxS8aDn9Mw/E=
X-Google-Smtp-Source: ACHHUZ57BxNNYDj7zctg3JHwhr5cvQ58P7G8J8BYjVMfhqIVRLA7nj5p4p4AxNhjquz50+Pn+mUt6A==
X-Received: by 2002:a5d:40c4:0:b0:306:2b1a:101d with SMTP id b4-20020a5d40c4000000b003062b1a101dmr2146028wrq.12.1682893602232;
        Sun, 30 Apr 2023 15:26:42 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id g2-20020a5d5402000000b002da75c5e143sm26699865wrv.29.2023.04.30.15.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Apr 2023 15:26:41 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v2 1/3] mm: drop the assumption that VM_SHARED always implies writable
Date:   Sun, 30 Apr 2023 23:26:05 +0100
Message-Id: <e7ade2f58da0ea3d2510f2ea377d0ae27c8d3d59.1682890156.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1682890156.git.lstoakes@gmail.com>
References: <cover.1682890156.git.lstoakes@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There are places in the kernel where there is an implicit assumption that
VM_SHARED VMAs must either be writable or might become writable via
e.g. mprotect().

We can explicitly check for the writable, shared case while remaining
conservative - If VM_MAYWRITE is not set then, by definition, the memory
can never be written to.

Update these checks to also check for VM_MAYWRITE.

Suggested-by: Andy Lutomirski <luto@amacapital.net>
Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 include/linux/fs.h |  4 ++--
 include/linux/mm.h | 11 +++++++++++
 kernel/fork.c      |  2 +-
 mm/filemap.c       |  2 +-
 mm/madvise.c       |  2 +-
 mm/mmap.c          | 12 ++++++------
 6 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 67495ef79bb2..874fe0e38e65 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -413,7 +413,7 @@ extern const struct address_space_operations empty_aops;
  *   It is also used to block modification of page cache contents through
  *   memory mappings.
  * @gfp_mask: Memory allocation flags to use for allocating pages.
- * @i_mmap_writable: Number of VM_SHARED mappings.
+ * @i_mmap_writable: Number of VM_SHARED, VM_MAYWRITE mappings.
  * @nr_thps: Number of THPs in the pagecache (non-shmem only).
  * @i_mmap: Tree of private and shared mappings.
  * @i_mmap_rwsem: Protects @i_mmap and @i_mmap_writable.
@@ -516,7 +516,7 @@ static inline int mapping_mapped(struct address_space *mapping)
 
 /*
  * Might pages of this file have been modified in userspace?
- * Note that i_mmap_writable counts all VM_SHARED vmas: do_mmap
+ * Note that i_mmap_writable counts all VM_SHARED, VM_MAYWRITE vmas: do_mmap
  * marks vma as VM_SHARED if it is shared, and the file was opened for
  * writing i.e. vma may be mprotected writable even if now readonly.
  *
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 27ce77080c79..3e8fb4601520 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -851,6 +851,17 @@ static inline bool vma_is_accessible(struct vm_area_struct *vma)
 	return vma->vm_flags & VM_ACCESS_FLAGS;
 }
 
+static inline bool is_shared_maywrite(vm_flags_t vm_flags)
+{
+	return (vm_flags & (VM_SHARED | VM_MAYWRITE)) ==
+		(VM_SHARED | VM_MAYWRITE);
+}
+
+static inline bool vma_is_shared_maywrite(struct vm_area_struct *vma)
+{
+	return is_shared_maywrite(vma->vm_flags);
+}
+
 static inline
 struct vm_area_struct *vma_find(struct vma_iterator *vmi, unsigned long max)
 {
diff --git a/kernel/fork.c b/kernel/fork.c
index 4342200d5e2b..7ebd6229219a 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -733,7 +733,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 
 			get_file(file);
 			i_mmap_lock_write(mapping);
-			if (tmp->vm_flags & VM_SHARED)
+			if (vma_is_shared_maywrite(tmp))
 				mapping_allow_writable(mapping);
 			flush_dcache_mmap_lock(mapping);
 			/* insert tmp into the share list, just after mpnt */
diff --git a/mm/filemap.c b/mm/filemap.c
index a34abfe8c654..4d896515032c 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3607,7 +3607,7 @@ int generic_file_mmap(struct file *file, struct vm_area_struct *vma)
  */
 int generic_file_readonly_mmap(struct file *file, struct vm_area_struct *vma)
 {
-	if ((vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_MAYWRITE))
+	if (vma_is_shared_maywrite(vma))
 		return -EINVAL;
 	return generic_file_mmap(file, vma);
 }
diff --git a/mm/madvise.c b/mm/madvise.c
index b5ffbaf616f5..5eb59854e285 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -969,7 +969,7 @@ static long madvise_remove(struct vm_area_struct *vma,
 			return -EINVAL;
 	}
 
-	if ((vma->vm_flags & (VM_SHARED|VM_WRITE)) != (VM_SHARED|VM_WRITE))
+	if (!vma_is_shared_maywrite(vma))
 		return -EACCES;
 
 	offset = (loff_t)(start - vma->vm_start)
diff --git a/mm/mmap.c b/mm/mmap.c
index 5522130ae606..646e34e95a37 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -107,7 +107,7 @@ void vma_set_page_prot(struct vm_area_struct *vma)
 static void __remove_shared_vm_struct(struct vm_area_struct *vma,
 		struct file *file, struct address_space *mapping)
 {
-	if (vma->vm_flags & VM_SHARED)
+	if (vma_is_shared_maywrite(vma))
 		mapping_unmap_writable(mapping);
 
 	flush_dcache_mmap_lock(mapping);
@@ -428,7 +428,7 @@ static unsigned long count_vma_pages_range(struct mm_struct *mm,
 static void __vma_link_file(struct vm_area_struct *vma,
 			    struct address_space *mapping)
 {
-	if (vma->vm_flags & VM_SHARED)
+	if (vma_is_shared_maywrite(vma))
 		mapping_allow_writable(mapping);
 
 	flush_dcache_mmap_lock(mapping);
@@ -2642,7 +2642,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	vma->vm_pgoff = pgoff;
 
 	if (file) {
-		if (vm_flags & VM_SHARED) {
+		if (is_shared_maywrite(vm_flags)) {
 			error = mapping_map_writable(file->f_mapping);
 			if (error)
 				goto free_vma;
@@ -2717,7 +2717,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	vma_iter_store(&vmi, vma);
 	mm->map_count++;
 	if (vma->vm_file) {
-		if (vma->vm_flags & VM_SHARED)
+		if (vma_is_shared_maywrite(vma))
 			mapping_allow_writable(vma->vm_file->f_mapping);
 
 		flush_dcache_mmap_lock(vma->vm_file->f_mapping);
@@ -2734,7 +2734,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 
 	/* Once vma denies write, undo our temporary denial count */
 unmap_writable:
-	if (file && vm_flags & VM_SHARED)
+	if (file && is_shared_maywrite(vm_flags))
 		mapping_unmap_writable(file->f_mapping);
 	file = vma->vm_file;
 	ksm_add_vma(vma);
@@ -2781,7 +2781,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		unmap_region(mm, &mm->mm_mt, vma, prev, next, vma->vm_start,
 			     vma->vm_end, true);
 	}
-	if (file && (vm_flags & VM_SHARED))
+	if (file && is_shared_maywrite(vm_flags))
 		mapping_unmap_writable(file->f_mapping);
 free_vma:
 	vm_area_free(vma);
-- 
2.40.1

