Return-Path: <linux-fsdevel+bounces-28647-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E90C596C887
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 22:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DC6E2899E2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 20:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8CE1E9743;
	Wed,  4 Sep 2024 20:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="t6PmsxpM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248791E8B85
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 20:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725481780; cv=none; b=tEdagO04fuRiXLnyNsgaM1yt6DBEzOSjMf3KNsGzTb8BuETncozZAAMrE6syWI19TapXwQF8ev5aEkAP241tc7rIIrasXbu6VYJFoLms60oRv7yHVLj8+sFQLWrjjOFXnAvSPpSaFuBWMmE/iSZ5VohLq+ulIIZXVDxzAlNjktw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725481780; c=relaxed/simple;
	bh=K07lhn/HFnq8Dqz7ymidJhSUR1D7kuClGgpotTVtGhM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lnWgSNjNy0zmuAn1DxyE2X8C0CqjsZE/y3Hi2/S1KOQwmIqCo/6iHizs2oVSYHJQ0dSxihvcF6Q39fLYsgh0g0+Q9fDoeacnCvL6Ssq5+1GeQMBYzKd9N8+327rlwTyQNfO5SY9sKTY9/pT8kWxV11H6QAAlk683fi1Zknz6r/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=t6PmsxpM; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e1a9dc3f0a3so86544276.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Sep 2024 13:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1725481778; x=1726086578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TdpAgT058g8D2uASHL0DyNBaXA20e/8A0vSavuo8wh4=;
        b=t6PmsxpMsywtEph2siajdK60/OcSRpMQPtKJnGROJRG9kI1Gp1/rNxorG/MqqLH+l+
         H14YTRgFOkNBfL6siP+FKyN2IeTCw1iGaeGpmoQc/iLaRuWWopFoXdDK+Tc9TeNtK+/5
         h67DTT4lnKQYncY5hWZojuuRih7kCOi8eAh25/kTc44WLtgEil3oC7NLP9wGJoF6etXL
         UiBU8d//Dut8uTuJKM+zXAVdAj8cBoTJDfqf7louS1A7C7Go4vro7X1XWicgya2693hF
         h5Ixr8/x1GnSx7ZxgwaOIWj9F/if3i8EHDiRuipRj6DGGcrfxI0KPPYbkLEyZy05uTwh
         6T9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725481778; x=1726086578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TdpAgT058g8D2uASHL0DyNBaXA20e/8A0vSavuo8wh4=;
        b=XrVUgSXYTxbR6yE5asqXg7/3ChK73HgepO0voKhrIJviCw62lfEzasgggkXlLeUhAu
         tRmIPu9xzSR3Y+IIUKVvOvLydi0WKriLSWP19OFeDVyqCrT2UIHTVze+EwWcpbBTSi5Q
         yv0I0rR5lOp4xn96sJwW+t472DB5Efm/wf5L7P8v/5rDBeuFLABWzIt+D1FfzJpDur3O
         Nv0ygFuFkAANvyb1CbqilSXmCFV9wV/6V2A6d9KwJEeHA1IwJ5DbJf2/OsaQbZJ2UbLE
         bOrG5u0+nCKwoPkyHA8thqrQIsFUnHtxj3CyjSb7guvQGxFsBJAy4UqApZchc+iE48E0
         7WXw==
X-Forwarded-Encrypted: i=1; AJvYcCUXBDUfyhtASlWUnWaVj9jSMPo2Q1FKZxPBFLKbS8LFRyrX3E8INkfFfSzuhu5Msn3JYNQ03eLDvDlx6n0q@vger.kernel.org
X-Gm-Message-State: AOJu0YyQW5Hmi60+ZFnkMsMrYeI+Qj6GNYPfqTmIfP9k1gwqEYNx9tB1
	QNpM6iOQ9E4gGRdgKo68r5JoCo7FRL7qAA67KwpXyw48g41ZxwCnXWNXOqmbFpg=
X-Google-Smtp-Source: AGHT+IHeHitsPcQ1kfVrPGq0b4GF0aiDUGxULm3YTFoSiEMXAET19y3p8EGpUVDmPCTd+KLj6bMEOQ==
X-Received: by 2002:a05:6902:70a:b0:e0e:7b3d:53fe with SMTP id 3f1490d57ef6-e1a79fd884emr23296230276.18.1725481778061;
        Wed, 04 Sep 2024 13:29:38 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c520418d34sm1551586d6.119.2024.09.04.13.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 13:29:37 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	linux-bcachefs@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v5 14/18] fsnotify: generate pre-content permission event on page fault
Date: Wed,  4 Sep 2024 16:28:04 -0400
Message-ID: <eb208a363df0afccfafad8078d7563d54513f295.1725481503.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1725481503.git.josef@toxicpanda.com>
References: <cover.1725481503.git.josef@toxicpanda.com>
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

Export a simple helper that file systems that have their own ->fault()
will use, and have a more complicated helper to be do fancy things with
in filemap_fault.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/mm.h |   1 +
 mm/filemap.c       | 116 ++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 110 insertions(+), 7 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ab3d78116043..89665732b404 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3503,6 +3503,7 @@ extern vm_fault_t filemap_fault(struct vm_fault *vmf);
 extern vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 		pgoff_t start_pgoff, pgoff_t end_pgoff);
 extern vm_fault_t filemap_page_mkwrite(struct vm_fault *vmf);
+extern vm_fault_t filemap_fsnotify_fault(struct vm_fault *vmf);
 
 extern unsigned long stack_guard_gap;
 /* Generic expand stack which grows the stack according to GROWS{UP,DOWN} */
diff --git a/mm/filemap.c b/mm/filemap.c
index 8b1684b62177..b2d29947ce7f 100644
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
 
@@ -3190,12 +3191,12 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
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
 
 	/* See comment in do_sync_mmap_readahead. */
@@ -3260,6 +3261,93 @@ static vm_fault_t filemap_fault_recheck_pte_none(struct vm_fault *vmf)
 	return ret;
 }
 
+/*
+ * If we have pre-content watches on this file we will need to emit an event for
+ * this range.  We will handle dropping the lock and emitting the event.
+ *
+ * If FAULT_FLAG_RETRY_NOWAIT is set then we'll return VM_FAULT_RETRY.
+ *
+ * If no event was emitted then *fpin will be NULL and we will return 0.
+ *
+ * If any error occurred we will return VM_FAULT_SIGBUS, *fpin could still be
+ * set and will need to have fput() called on it.
+ *
+ * If we emitted the event then we will return 0 and *fpin will be set, this
+ * must have fput() called on it, and the caller must call VM_FAULT_RETRY after
+ * any other operations it does in order to re-fault the page and make sure the
+ * appropriate locking is maintained.
+ *
+ * Return: the appropriate vm_fault_t return code, 0 on success.
+ */
+static vm_fault_t __filemap_fsnotify_fault(struct vm_fault *vmf,
+					   struct file **fpin)
+{
+	struct file *file = vmf->vma->vm_file;
+	loff_t pos = vmf->pgoff << PAGE_SHIFT;
+	int mask = (vmf->flags & FAULT_FLAG_WRITE) ? MAY_WRITE : MAY_ACCESS;
+	int ret;
+
+	/*
+	 * We already did this and now we're retrying with everything locked,
+	 * don't emit the event and continue.
+	 */
+	if (vmf->flags & FAULT_FLAG_TRIED)
+		return 0;
+
+	/* No watches, return NULL. */
+	if (!fsnotify_file_has_pre_content_watches(file))
+		return 0;
+
+	/* We are NOWAIT, we can't wait, just return EAGAIN. */
+	if (vmf->flags & FAULT_FLAG_RETRY_NOWAIT)
+		return VM_FAULT_RETRY;
+
+	/*
+	 * If this fails then we're not allowed to drop the fault lock, return a
+	 * SIGBUS so we don't errantly populate pagecache with bogus data for
+	 * this file.
+	 */
+	*fpin = maybe_unlock_mmap_for_io(vmf, *fpin);
+	if (*fpin == NULL)
+		return VM_FAULT_SIGBUS;
+
+	/*
+	 * We can't fput(*fpin) at this point because we could have been passed
+	 * in fpin from a previous call.
+	 */
+	ret = fsnotify_file_area_perm(*fpin, mask, &pos, PAGE_SIZE);
+	if (ret)
+		return VM_FAULT_SIGBUS;
+
+	return 0;
+}
+
+/**
+ * filemap_fsnotify_fault - maybe emit a pre-content event.
+ * @vmf:	struct vm_fault containing details of the fault.
+ *
+ * If we have a pre-content watch on this file we will emit an event for this
+ * range.  If we return anything the fault caller should return immediately, we
+ * will return VM_FAULT_RETRY if we had to emit an event, which will trigger the
+ * fault again and then the fault handler will run the second time through.
+ *
+ * Return: a bitwise-OR of %VM_FAULT_ codes, 0 if nothing happened.
+ */
+vm_fault_t filemap_fsnotify_fault(struct vm_fault *vmf)
+{
+	struct file *fpin = NULL;
+	vm_fault_t ret;
+
+	ret = __filemap_fsnotify_fault(vmf, &fpin);
+	if (fpin) {
+		fput(fpin);
+		if (!ret)
+			ret = VM_FAULT_RETRY;
+	}
+	return ret;
+}
+EXPORT_SYMBOL_GPL(filemap_fsnotify_fault);
+
 /**
  * filemap_fault - read in file data for page fault handling
  * @vmf:	struct vm_fault containing details of the fault
@@ -3299,6 +3387,17 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 	if (unlikely(index >= max_idx))
 		return VM_FAULT_SIGBUS;
 
+	/*
+	 * If we have pre-content watchers then we need to generate events on
+	 * page fault so that we can populate any data before the fault.
+	 */
+	ret = __filemap_fsnotify_fault(vmf, &fpin);
+	if (unlikely(ret)) {
+		if (fpin)
+			fput(fpin);
+		return ret;
+	}
+
 	/*
 	 * Do we have something in the page cache already?
 	 */
@@ -3309,21 +3408,24 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 		 * the lock.
 		 */
 		if (!(vmf->flags & FAULT_FLAG_TRIED))
-			fpin = do_async_mmap_readahead(vmf, folio);
+			fpin = do_async_mmap_readahead(vmf, folio, fpin);
 		if (unlikely(!folio_test_uptodate(folio))) {
 			filemap_invalidate_lock_shared(mapping);
 			mapping_locked = true;
 		}
 	} else {
 		ret = filemap_fault_recheck_pte_none(vmf);
-		if (unlikely(ret))
+		if (unlikely(ret)) {
+			if (fpin)
+				goto out_retry;
 			return ret;
+		}
 
 		/* No page in the page cache at all */
 		count_vm_event(PGMAJFAULT);
 		count_memcg_event_mm(vmf->vma->vm_mm, PGMAJFAULT);
 		ret = VM_FAULT_MAJOR;
-		fpin = do_sync_mmap_readahead(vmf);
+		fpin = do_sync_mmap_readahead(vmf, fpin);
 retry_find:
 		/*
 		 * See comment in filemap_create_folio() why we need
-- 
2.43.0


