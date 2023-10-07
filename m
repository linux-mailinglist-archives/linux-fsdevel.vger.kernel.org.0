Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2D37BC9DD
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Oct 2023 22:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344177AbjJGUvT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 Oct 2023 16:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344151AbjJGUvN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 Oct 2023 16:51:13 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7761095;
        Sat,  7 Oct 2023 13:51:11 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3248aa5cf4eso3225180f8f.1;
        Sat, 07 Oct 2023 13:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696711870; x=1697316670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Eqt+lFhGqyhgA/GIcCG4Sd1WLEsHw06nfkpMalVsW4=;
        b=Ru+OOEp90ZxWbfQzr2tymGylhyaTuLX2Eu0LjuozDBlltxaJqqvME9fPpc7GmyWXIi
         nFSXmB3DnPT/ZAjVg9pYowUpeR3FPny4d+MvP5z5OIRtUPfb3ymIInbNhvtMziT4c9iG
         xqDz7LGy+G/zsROsLfur+ukqskhSW83xPPbdC4bYnVYO+MIhB+67RO7CTggMmRAjVFRJ
         /IubIvMIuh/un2lP28NBpQnVAuHeN05slSna+7GJLjQT9qXJa6fzXVw+iniY2W5ri8bD
         EzuLvYlH08S/STbXb1VWcxsWlFXBAKcn/03JnsxgTzea46TDRezVTTU2EIlFl6gX8k5R
         dWZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696711870; x=1697316670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Eqt+lFhGqyhgA/GIcCG4Sd1WLEsHw06nfkpMalVsW4=;
        b=rylqF+l5ao+etdiSPKBMd6oEIKzWGXmDwK6UZ+7vcg4Dz8xt8XvL6eh/Ju0ICPGSgz
         vHO7Oyre/ArhcH2qglvDmhZw7/C2NTRJueBzxadzghbPnNChRWZiSnTGAkHa3Ygg7vp1
         FYPYCcgy4tN9r39o79HAp7vgfYHoj3yU53oUW5b4LsvXOhWlg3IvK555mVD/ZB3EMSsg
         7i+tj6pd5DvxjO1VA8ZcQGFJMn0E1eP+5EIyH59BsQULYkdNs89BKlHU70EprtogcSzy
         YlX0OFPZKyV8sIr9FijiTYnsJBvRAixVIKCRh0u02uoV3z2OX/zwz7indx/OS4Klnf6G
         kcLQ==
X-Gm-Message-State: AOJu0YwJvIerH44n6Q2S/TPUyRHDpiiwzbAimg0ewzH/gbw5gje5GgeZ
        8eiVwcPzW9oXqWLvGD/1ogg=
X-Google-Smtp-Source: AGHT+IGDGw56aAVS4Ps+h8icv4jAQgm4Hk3HtBxKyknFOFfb//OHVHdrVHz4nilvcQwrSS5yFdaaXw==
X-Received: by 2002:a5d:4c8a:0:b0:313:ecd3:7167 with SMTP id z10-20020a5d4c8a000000b00313ecd37167mr9918903wrs.42.1696711869667;
        Sat, 07 Oct 2023 13:51:09 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id g7-20020adfe407000000b003232d122dbfsm5120550wrm.66.2023.10.07.13.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 13:51:08 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Andy Lutomirski <luto@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v3 1/3] mm: drop the assumption that VM_SHARED always implies writable
Date:   Sat,  7 Oct 2023 21:50:59 +0100
Message-ID: <e1bcbcba7ffbe421bbd262029a3a59178b52e3c5.1696709413.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1696709413.git.lstoakes@gmail.com>
References: <cover.1696709413.git.lstoakes@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is a general assumption that VMAs with the VM_SHARED flag set are
writable. If the VM_MAYWRITE flag is not set, then this is simply not the
case.

Update those checks which affect the struct address_space->i_mmap_writable
field to explicitly test for this by introducing [vma_]is_shared_maywrite()
helper functions.

This remains entirely conservative, as the lack of VM_MAYWRITE guarantees
that the VMA cannot be written to.

Suggested-by: Andy Lutomirski <luto@kernel.org>
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
index 92a9c6157de1..e9c03fb00d5c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -454,7 +454,7 @@ extern const struct address_space_operations empty_aops;
  *   It is also used to block modification of page cache contents through
  *   memory mappings.
  * @gfp_mask: Memory allocation flags to use for allocating pages.
- * @i_mmap_writable: Number of VM_SHARED mappings.
+ * @i_mmap_writable: Number of VM_SHARED, VM_MAYWRITE mappings.
  * @nr_thps: Number of THPs in the pagecache (non-shmem only).
  * @i_mmap: Tree of private and shared mappings.
  * @i_mmap_rwsem: Protects @i_mmap and @i_mmap_writable.
@@ -557,7 +557,7 @@ static inline int mapping_mapped(struct address_space *mapping)
 
 /*
  * Might pages of this file have been modified in userspace?
- * Note that i_mmap_writable counts all VM_SHARED vmas: do_mmap
+ * Note that i_mmap_writable counts all VM_SHARED, VM_MAYWRITE vmas: do_mmap
  * marks vma as VM_SHARED if it is shared, and the file was opened for
  * writing i.e. vma may be mprotected writable even if now readonly.
  *
diff --git a/include/linux/mm.h b/include/linux/mm.h
index a7b667786cde..c9e9628addc4 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -937,6 +937,17 @@ static inline bool vma_is_accessible(struct vm_area_struct *vma)
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
index e45a4457ba83..1e6c656e0857 100644
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
index 48cd16c54e86..ad559f94e125 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3637,7 +3637,7 @@ int generic_file_mmap(struct file *file, struct vm_area_struct *vma)
  */
 int generic_file_readonly_mmap(struct file *file, struct vm_area_struct *vma)
 {
-	if ((vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_MAYWRITE))
+	if (vma_is_shared_maywrite(vma))
 		return -EINVAL;
 	return generic_file_mmap(file, vma);
 }
diff --git a/mm/madvise.c b/mm/madvise.c
index a4a20de50494..5c74fb645de8 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -999,7 +999,7 @@ static long madvise_remove(struct vm_area_struct *vma,
 			return -EINVAL;
 	}
 
-	if ((vma->vm_flags & (VM_SHARED|VM_WRITE)) != (VM_SHARED|VM_WRITE))
+	if (!vma_is_shared_maywrite(vma))
 		return -EACCES;
 
 	offset = (loff_t)(start - vma->vm_start)
diff --git a/mm/mmap.c b/mm/mmap.c
index 673429ee8a9e..6f6856b3267a 100644
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
@@ -384,7 +384,7 @@ static unsigned long count_vma_pages_range(struct mm_struct *mm,
 static void __vma_link_file(struct vm_area_struct *vma,
 			    struct address_space *mapping)
 {
-	if (vma->vm_flags & VM_SHARED)
+	if (vma_is_shared_maywrite(vma))
 		mapping_allow_writable(mapping);
 
 	flush_dcache_mmap_lock(mapping);
@@ -2767,7 +2767,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	vma->vm_pgoff = pgoff;
 
 	if (file) {
-		if (vm_flags & VM_SHARED) {
+		if (is_shared_maywrite(vm_flags)) {
 			error = mapping_map_writable(file->f_mapping);
 			if (error)
 				goto free_vma;
@@ -2842,7 +2842,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	mm->map_count++;
 	if (vma->vm_file) {
 		i_mmap_lock_write(vma->vm_file->f_mapping);
-		if (vma->vm_flags & VM_SHARED)
+		if (vma_is_shared_maywrite(vma))
 			mapping_allow_writable(vma->vm_file->f_mapping);
 
 		flush_dcache_mmap_lock(vma->vm_file->f_mapping);
@@ -2859,7 +2859,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 
 	/* Once vma denies write, undo our temporary denial count */
 unmap_writable:
-	if (file && vm_flags & VM_SHARED)
+	if (file && is_shared_maywrite(vm_flags))
 		mapping_unmap_writable(file->f_mapping);
 	file = vma->vm_file;
 	ksm_add_vma(vma);
@@ -2907,7 +2907,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		unmap_region(mm, &vmi.mas, vma, prev, next, vma->vm_start,
 			     vma->vm_end, vma->vm_end, true);
 	}
-	if (file && (vm_flags & VM_SHARED))
+	if (file && is_shared_maywrite(vm_flags))
 		mapping_unmap_writable(file->f_mapping);
 free_vma:
 	vm_area_free(vma);
-- 
2.42.0

