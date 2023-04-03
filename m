Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFE96D54BE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Apr 2023 00:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbjDCW2r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Apr 2023 18:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233671AbjDCW2p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Apr 2023 18:28:45 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486D430F5;
        Mon,  3 Apr 2023 15:28:44 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id j18-20020a05600c1c1200b003ee5157346cso20729995wms.1;
        Mon, 03 Apr 2023 15:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680560923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ox0Um/keFFcr+KeFLWWO5PQW7Wkw7x46JWiMcUucBs=;
        b=IqTEJ0a+DVsrR/sbp6wFzGCaIOKJMW2b/WluK/3q1KwlzFGr2XzC9qJuUJ7AIX2xu4
         VYIERbGy4I05j29jD4GWHjBV6ImJSUz3sPPYuaiG3eLJPvg+F+AqPRyHgH2bhv2l56db
         zk8hKNxoUPqZbK88nvjMALCegh67BbKKtQfC7K4kazXrlMz9cSLjgulHxeThVTE8rvUZ
         +x99D6LZswyN/OkVpXX8XP5JnB1VyMyEIIhBPweYAiR35zd9A+eqrd5RweuIO7ZYe3W4
         yj9WMI0QJSNhWPnu7pDAnkoH6MTQRMYht7Ep7qdnI4WgFp8Z9VNNwFDLyS4XbvTKlWXa
         cJnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680560923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ox0Um/keFFcr+KeFLWWO5PQW7Wkw7x46JWiMcUucBs=;
        b=580VwcHehrfR3oIBYhjoXJI/NrlRJP+XnbXBl5mPbuxMcuGu3QcGSHeST6Vj7qi9+w
         OK2Ffz47Djw59DVi9OpFzUCjI590vY3QNdkeJYOve0Yp4/LNGlQ5iHcW9x29w4UfkIAM
         AcbYA+/Ts5D86zLt4sJ3MWcES5aLicLsod14MDPxH4AvVzE7bZUEi6T6VQF88wbLG3Aq
         VAinO3EoQpp6iCWSMyLRQuJTSNDnqLF+/da1nIHfhOgIy1tE+x1Yb5ZYfvw+SyCRXjag
         lVSoDyEBdHDv8MONI6RaEC9UDr0qEbqbJLXPrMy649Kk1F4/l+LfFflmyVxGdS4hFBlW
         Js0g==
X-Gm-Message-State: AAQBX9fx8KRnLGtiq0fBPYSJdmQLcL+pTQAwDidPW8f9PxaMIyRXYeIZ
        /1FtFgQtLQAgWexejCRIUSE=
X-Google-Smtp-Source: AKy350aFpMa5YFdkK6pkYk/H9LFfFmuJSQcyDrwohfghPSBYhva0NoXvbaDDHu8LijJ6wMsZJSfFTA==
X-Received: by 2002:a05:600c:2286:b0:3ed:e6c8:f11d with SMTP id 6-20020a05600c228600b003ede6c8f11dmr641590wmf.7.1680560922635;
        Mon, 03 Apr 2023 15:28:42 -0700 (PDT)
Received: from lucifer.home (host86-156-84-164.range86-156.btcentralplus.com. [86.156.84.164])
        by smtp.googlemail.com with ESMTPSA id u17-20020a05600c19d100b003dd1bd0b915sm20731309wmq.22.2023.04.03.15.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 15:28:41 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [RFC PATCH 1/3] mm: drop the assumption that VM_SHARED always implies writable
Date:   Mon,  3 Apr 2023 23:28:30 +0100
Message-Id: <691c33e2fe8fc0fd879374739b50af48524175a3.1680560277.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1680560277.git.lstoakes@gmail.com>
References: <cover.1680560277.git.lstoakes@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
index c85916e9f7db..373e1edd719c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -410,7 +410,7 @@ extern const struct address_space_operations empty_aops;
  *   It is also used to block modification of page cache contents through
  *   memory mappings.
  * @gfp_mask: Memory allocation flags to use for allocating pages.
- * @i_mmap_writable: Number of VM_SHARED mappings.
+ * @i_mmap_writable: Number of VM_SHARED, VM_MAYWRITE mappings.
  * @nr_thps: Number of THPs in the pagecache (non-shmem only).
  * @i_mmap: Tree of private and shared mappings.
  * @i_mmap_rwsem: Protects @i_mmap and @i_mmap_writable.
@@ -513,7 +513,7 @@ static inline int mapping_mapped(struct address_space *mapping)
 
 /*
  * Might pages of this file have been modified in userspace?
- * Note that i_mmap_writable counts all VM_SHARED vmas: do_mmap
+ * Note that i_mmap_writable counts all VM_SHARED, VM_MAYWRITE vmas: do_mmap
  * marks vma as VM_SHARED if it is shared, and the file was opened for
  * writing i.e. vma may be mprotected writable even if now readonly.
  *
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 898ece0a3802..8e64041b1703 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -862,6 +862,17 @@ static inline bool vma_is_accessible(struct vm_area_struct *vma)
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
index 2066a57786a8..58f257d60fee 100644
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
index 340125d08c03..606c395c4ddd 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -981,7 +981,7 @@ static long madvise_remove(struct vm_area_struct *vma,
 			return -EINVAL;
 	}
 
-	if ((vma->vm_flags & (VM_SHARED|VM_WRITE)) != (VM_SHARED|VM_WRITE))
+	if (!vma_is_shared_maywrite(vma))
 		return -EACCES;
 
 	offset = (loff_t)(start - vma->vm_start)
diff --git a/mm/mmap.c b/mm/mmap.c
index 51cd747884e3..c96dcce90772 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -106,7 +106,7 @@ void vma_set_page_prot(struct vm_area_struct *vma)
 static void __remove_shared_vm_struct(struct vm_area_struct *vma,
 		struct file *file, struct address_space *mapping)
 {
-	if (vma->vm_flags & VM_SHARED)
+	if (vma_is_shared_maywrite(vma))
 		mapping_unmap_writable(mapping);
 
 	flush_dcache_mmap_lock(mapping);
@@ -427,7 +427,7 @@ static unsigned long count_vma_pages_range(struct mm_struct *mm,
 static void __vma_link_file(struct vm_area_struct *vma,
 			    struct address_space *mapping)
 {
-	if (vma->vm_flags & VM_SHARED)
+	if (vma_is_shared_maywrite(vma))
 		mapping_allow_writable(mapping);
 
 	flush_dcache_mmap_lock(mapping);
@@ -2596,7 +2596,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	vma->vm_pgoff = pgoff;
 
 	if (file) {
-		if (vm_flags & VM_SHARED) {
+		if (is_shared_maywrite(vm_flags)) {
 			error = mapping_map_writable(file->f_mapping);
 			if (error)
 				goto free_vma;
@@ -2671,7 +2671,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	vma_iter_store(&vmi, vma);
 	mm->map_count++;
 	if (vma->vm_file) {
-		if (vma->vm_flags & VM_SHARED)
+		if (vma_is_shared_maywrite(vma))
 			mapping_allow_writable(vma->vm_file->f_mapping);
 
 		flush_dcache_mmap_lock(vma->vm_file->f_mapping);
@@ -2688,7 +2688,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 
 	/* Once vma denies write, undo our temporary denial count */
 unmap_writable:
-	if (file && vm_flags & VM_SHARED)
+	if (file && is_shared_maywrite(vm_flags))
 		mapping_unmap_writable(file->f_mapping);
 	file = vma->vm_file;
 expanded:
@@ -2734,7 +2734,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		unmap_region(mm, &mm->mm_mt, vma, prev, next, vma->vm_start,
 			     vma->vm_end, true);
 	}
-	if (file && (vm_flags & VM_SHARED))
+	if (file && is_shared_maywrite(vm_flags))
 		mapping_unmap_writable(file->f_mapping);
 free_vma:
 	vm_area_free(vma);
-- 
2.40.0

