Return-Path: <linux-fsdevel+bounces-24277-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F9C93C848
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 20:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA98D1C21A4B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 18:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1253F55884;
	Thu, 25 Jul 2024 18:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="F9eDTA5T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005271F959
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jul 2024 18:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721931619; cv=none; b=N5DHHDSQdgZ/TOuacYuq3T9CRni4w4/f1TiuesLCIK/t2gMF/nobPYeRd5znoB8LO3NPSMpUkgkB5sjhUQR8HiCHAAkZxF9VvLMZhIi00w7oT9z2Fv9TA5iBVQ9Jo33YznNLB5B8gXtntevD9KjqwJ5polEg2DZwSJfeMPGbmLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721931619; c=relaxed/simple;
	bh=g5LYCcVMbQdzidWygRiVOkC8Uc0XNUuZ7Os/Hul1tJ8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u4BxMNKz1alV3uogHXwx436ngOh1ELzQzssXbUvk8Ud+84v2xZISEXTlyL2XJkmf5BXvJnIkMDk0CCXmlc5QrlNkpIdmx442T7+4GS8GkEbREa9f9L/HCONiCbL+wxcVnV+OojWRK2QuNLzzeAQAPpj1j9kryzz/t/otUV8tVPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=F9eDTA5T; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7093472356dso120245a34.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jul 2024 11:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1721931617; x=1722536417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7tWJ2c4tr/BjcKYqRu4CB7etWtMzNUdX29DLxMzM6Sw=;
        b=F9eDTA5T/sAAnqvYnODQ8lNp/MuqqBgVny79avKDJPRTKJGL/BE+wSHs40okEaW04Q
         KHyPCQv7TePz47p55ielTa37U7mEVcTHAlyBvtjhmvWPl4h+7bZ2T7DneWSIJZwi1Oj/
         o+zlfNJs4eyXCNYkNYC2W7FF5KK3yDSRaNGkIYGPX9H7r2SGHxGA+JxIC8ItmrPVizL4
         jZ2jBHuT0wPK8LY93kN7O86bxhlOK0yPEzT3HS+08PQo4GGjgUrXPp2dwvpJ3BefvmkA
         /bafUGDtEdLjG9zsiLM92FS7oXbFi4ytAZto+GjFBSymDvzPMbjv5FCgz9UDfyU5iYwk
         77wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721931617; x=1722536417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7tWJ2c4tr/BjcKYqRu4CB7etWtMzNUdX29DLxMzM6Sw=;
        b=V8QW1+064Cbx0A9DOfnYh8bSmNNFQxz5MdPUJ+ZL2IBZa9v0sGmAx9sC5ogbQzSyHn
         bTfMwnkgsHqynVFZdz2me1iFptdRd1vQqU8bsMg7eKkUnYDxsyyzj0jPZZ57nb7FXmn0
         v9uOxJnB70L3hKOp1gOAiONMjp0uuUdEbhldDz8F1EQBfKcu8JpCZSYCc+rRMTXNWFfL
         0kRX+T2rEZ1JeWeevFI5jCbh7i9B/AibPfZUmIpzpWnFHKeBuCl9pAs9ONGlHRDNCiMT
         BDpFAUdFv+av7UW7N2DFn2QZuCDgJ8EKp5dmBAAZMB3bew/26sTHxGGATmGDXUUR8UXI
         7ezA==
X-Forwarded-Encrypted: i=1; AJvYcCVLMjfIpu0VzqXjYJdafeD8GWOmqQm3W49AwX1AwGLh4Q9GTgms0D9v+cj02xIFBb+B6wwlTLDl+b/kx7HfXuW9tZwc3zeF3Ri4u2+oBg==
X-Gm-Message-State: AOJu0Yz4OVhFvCGNGeNScyo9ke8bR/LGDWXwkHitN9gq52HQH5TTjxmv
	gEATGyzYr6Epeb+jXJ5ugrnmrJnQ1boThL9QWmobnicnuzuvVclaiRUJn0kN+k8=
X-Google-Smtp-Source: AGHT+IG+t7W2iRxxfrZk/u5gp+f2w3SND7ViS3jz0N1bJUoIJi4bLPonGfje6sH5LeUoA6myPn7daA==
X-Received: by 2002:a05:6830:368a:b0:703:68ad:94c1 with SMTP id 46e09a7af769-7092e76e8famr4554614a34.31.1721931616967;
        Thu, 25 Jul 2024 11:20:16 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d73ed346sm107452985a.68.2024.07.25.11.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 11:20:16 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org
Subject: [PATCH 10/10] fsnotify: generate pre-content permission event on page fault
Date: Thu, 25 Jul 2024 14:19:47 -0400
Message-ID: <1bc2855779e7ba1d80592be7d6257b43f1a91886.1721931241.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1721931241.git.josef@toxicpanda.com>
References: <cover.1721931241.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FS_PRE_ACCESS or FS_PRE_MODIFY will be generated on page fault depending
on the faulting method.

This pre-content event is meant to be used by hierarchical storage
managers that want to fill in the file content on first read access.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/notify/fsnotify.c             | 13 +++++++++
 include/linux/fsnotify_backend.h | 14 +++++++++
 mm/filemap.c                     | 50 ++++++++++++++++++++++++++++----
 3 files changed, 71 insertions(+), 6 deletions(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 1ca4a8da7f29..435232d46b4f 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -28,6 +28,19 @@ void __fsnotify_vfsmount_delete(struct vfsmount *mnt)
 	fsnotify_clear_marks_by_mount(mnt);
 }
 
+bool fsnotify_file_has_content_watches(struct file *file)
+{
+	struct inode *inode = file_inode(file);
+	struct super_block *sb = inode->i_sb;
+	struct mount *mnt = real_mount(file->f_path.mnt);
+	u32 mask = inode->i_fsnotify_mask;
+
+	mask |= mnt->mnt_fsnotify_mask;
+	mask |= sb->s_fsnotify_mask;
+
+	return !!(mask & FSNOTIFY_PRE_CONTENT_EVENTS);
+}
+
 /**
  * fsnotify_unmount_inodes - an sb is unmounting.  handle any watched inodes.
  * @sb: superblock being unmounted.
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 36c3d18cc40a..6983fbf096b8 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -900,6 +900,15 @@ static inline void fsnotify_init_event(struct fsnotify_event *event)
 	INIT_LIST_HEAD(&event->list);
 }
 
+#ifdef CONFIG_FANOTIFY_ACCESS_PERMISSIONS
+bool fsnotify_file_has_content_watches(struct file *file);
+#else
+static inline bool fsnotify_file_has_content_watches(struct file *file)
+{
+	return false;
+}
+#endif /* CONFIG_FANOTIFY_ACCESS_PERMISSIONS */
+
 #else
 
 static inline int fsnotify(__u32 mask, const void *data, int data_type,
@@ -938,6 +947,11 @@ static inline u32 fsnotify_get_cookie(void)
 static inline void fsnotify_unmount_inodes(struct super_block *sb)
 {}
 
+static inline bool fsnotify_file_has_content_watches(struct file *file)
+{
+	return false;
+}
+
 #endif	/* CONFIG_FSNOTIFY */
 
 #endif	/* __KERNEL __ */
diff --git a/mm/filemap.c b/mm/filemap.c
index ca8c8d889eef..cc9d7885bbe3 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -46,6 +46,7 @@
 #include <linux/pipe_fs_i.h>
 #include <linux/splice.h>
 #include <linux/rcupdate_wait.h>
+#include <linux/fsnotify.h>
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 #include "internal.h"
@@ -3112,13 +3113,13 @@ static int lock_folio_maybe_drop_mmap(struct vm_fault *vmf, struct folio *folio,
  * that.  If we didn't pin a file then we return NULL.  The file that is
  * returned needs to be fput()'ed when we're done with it.
  */
-static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
+static struct file *do_sync_mmap_readahead(struct vm_fault *vmf,
+					   struct file *fpin)
 {
 	struct file *file = vmf->vma->vm_file;
 	struct file_ra_state *ra = &file->f_ra;
 	struct address_space *mapping = file->f_mapping;
 	DEFINE_READAHEAD(ractl, file, ra, mapping, vmf->pgoff);
-	struct file *fpin = NULL;
 	unsigned long vm_flags = vmf->vma->vm_flags;
 	unsigned int mmap_miss;
 
@@ -3182,12 +3183,12 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
  * was pinned if we have to drop the mmap_lock in order to do IO.
  */
 static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
-					    struct folio *folio)
+					    struct folio *folio,
+					    struct file *fpin)
 {
 	struct file *file = vmf->vma->vm_file;
 	struct file_ra_state *ra = &file->f_ra;
 	DEFINE_READAHEAD(ractl, file, ra, file->f_mapping, vmf->pgoff);
-	struct file *fpin = NULL;
 	unsigned int mmap_miss;
 
 	/* If we don't want any read-ahead, don't bother */
@@ -3287,6 +3288,35 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 	if (unlikely(index >= max_idx))
 		return VM_FAULT_SIGBUS;
 
+	/*
+	 * If we have pre-content watchers then we need to generate events on
+	 * page fault so that we can populate any data before the fault.
+	 *
+	 * We only do this on the first pass through, otherwise the populating
+	 * application could potentially deadlock on the mmap lock if it tries
+	 * to populate it with mmap.
+	 */
+	if (fault_flag_allow_retry_first(vmf->flags) &&
+	    fsnotify_file_has_content_watches(file)) {
+		int mask = (vmf->flags & FAULT_FLAG_WRITE) ? MAY_WRITE : MAY_READ;
+		loff_t pos = vmf->pgoff << PAGE_SHIFT;
+
+		fpin = maybe_unlock_mmap_for_io(vmf, fpin);
+
+		/*
+		 * We can only emit the event if we did actually release the
+		 * mmap lock.
+		 */
+		if (fpin) {
+			error = fsnotify_file_area_perm(fpin, mask, &pos,
+							PAGE_SIZE);
+			if (error) {
+				fput(fpin);
+				return VM_FAULT_ERROR;
+			}
+		}
+	}
+
 	/*
 	 * Do we have something in the page cache already?
 	 */
@@ -3297,7 +3327,7 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 		 * the lock.
 		 */
 		if (!(vmf->flags & FAULT_FLAG_TRIED))
-			fpin = do_async_mmap_readahead(vmf, folio);
+			fpin = do_async_mmap_readahead(vmf, folio, fpin);
 		if (unlikely(!folio_test_uptodate(folio))) {
 			filemap_invalidate_lock_shared(mapping);
 			mapping_locked = true;
@@ -3311,7 +3341,7 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 		count_vm_event(PGMAJFAULT);
 		count_memcg_event_mm(vmf->vma->vm_mm, PGMAJFAULT);
 		ret = VM_FAULT_MAJOR;
-		fpin = do_sync_mmap_readahead(vmf);
+		fpin = do_sync_mmap_readahead(vmf, fpin);
 retry_find:
 		/*
 		 * See comment in filemap_create_folio() why we need
@@ -3604,6 +3634,7 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 	struct vm_area_struct *vma = vmf->vma;
 	struct file *file = vma->vm_file;
 	struct address_space *mapping = file->f_mapping;
+	struct inode *inode = mapping->host;
 	pgoff_t last_pgoff = start_pgoff;
 	unsigned long addr;
 	XA_STATE(xas, &mapping->i_pages, start_pgoff);
@@ -3612,6 +3643,13 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 	unsigned long rss = 0;
 	unsigned int nr_pages = 0, mmap_miss = 0, mmap_miss_saved, folio_type;
 
+	/*
+	 * We are under RCU, we can't emit events here, we need to force a
+	 * normal fault to make sure the events get sent.
+	 */
+	if (fsnotify_file_has_content_watches(file))
+		return ret;
+
 	rcu_read_lock();
 	folio = next_uptodate_folio(&xas, mapping, end_pgoff);
 	if (!folio)
-- 
2.43.0


