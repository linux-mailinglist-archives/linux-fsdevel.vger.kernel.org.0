Return-Path: <linux-fsdevel+bounces-25466-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E51C094C546
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 21:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14E291C21A69
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 19:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57540160883;
	Thu,  8 Aug 2024 19:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="xePCLMjo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9D515EFBC
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Aug 2024 19:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723145315; cv=none; b=tl3BMRhXhGUcL1GReeNz6Nhqm/bUDRtIrn8BfIdqK5HJJpJgMA5z88xhIoX3mZxbqEMTWwlNhz9YGx1jU/zKdp7jVlU/7djHOknMPSCXoSyP1hRMtqEiGeDnUkENKhYcuPLWfq3xtWwzi5lsZRiIUv+gycsQsshGMO6tGuhMOcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723145315; c=relaxed/simple;
	bh=QxwPx/y8cQKYt0urtviHOcv6Dke8kHBSjkLFA9JU5oY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mQCS2gB4WpeGjR9E4XTvqk63b6FL27uX1Wo+5HDK1PRkZfE0vWP78bjxATMB3bVR1EVNC/v327o5mqwqzT9BphLED2Af2xC4hiLfOPbVokgkgq9IgoSux3KL2aaD0hKHYLeW+FtFqLYEa+3qSU5fwwYZBHrz1JrV9IK7xA/tQEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=xePCLMjo; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7a1d3e93cceso223723985a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Aug 2024 12:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1723145313; x=1723750113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bvi8Rvhrw8hau65mccNHsPcN1GGNLITREHvwNWenIGo=;
        b=xePCLMjo9bKQOYBS3zYObj/6DOZYMYgWGOXKI+QVjvzLFzt39OM/varGzge5Vwt2Oj
         Jo1YQmHyxAAeDuSocdjg8ZUyS7rCqV1AXIdy3CucTy0Ad5u6hIcouNNhX7u5T++DhRvG
         wATXu02Bp/zggHdaqOunW+/ssKhDneZhyESiQWr/tiq04k/XcycJG2jOMVUE8oa+dnNR
         yjDSlpgRXBEnjqcd4XWbXluVbv2gXAJ7YmqhvsPQz29eai64urb5pQlhfKQNGHiEmzCU
         rzOirmnPNdxvDZbv8LDYmxJQ+gDxlQljjsZjh4XMdkUo0k35ZT289vhLv6/DG3dkUcPa
         ybKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723145313; x=1723750113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bvi8Rvhrw8hau65mccNHsPcN1GGNLITREHvwNWenIGo=;
        b=e514Jbzdst3C/AZAPhYUTBl4cPqibcILQ6HATUtjMDRUaYc9bgJohsJA5pu73cnQC7
         udaT4HnfjhybvHFFhQ/e/PBfCWsBXjMsABkLZC4kEEmK5Vi8h2SnBild7XlnRWSTffnh
         vzpTDN3iv57sAE8BL91iiuTkTded7EgHS52VwqfY3ll6Bl8FPM1nvmkIH13OoX5CO9Hr
         0O/zRr3uVGOcarANqzHC3f/uRxB37tGEO1dYr46SkUi1hq+9ITfXPkl8lxRiw4nnYCxJ
         /shaKlrgUaWlOmZDKQCIrN7vrluEg4uI1kX5iec7BhjbXbc+yW+grZyNYDfbBUmpJrtU
         bRtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZHiowY4Q4Wgwr60OnYe4DCfJfx9W1XjqOSDF1yw+BMSpYO4Es8bcmShjKT7DBx5BdvjmDcxGoacXrGXfYybRN6w1exFoKo9BPq4QAug==
X-Gm-Message-State: AOJu0YzX5VuIdp/nwy/Doc6kYJ2wLUFoBVtG71kMe1UyY/5aiZsUszwJ
	3pkl8kzeLjZff/rL3CHXJS+y5h5rFJbEe+mdE31YOpPTOKrld+muL1sF7hw7k2s=
X-Google-Smtp-Source: AGHT+IHg5LiBxHcCbfRpZx/vfgLSV1DWqamdnXjHqSd3YJqdZjtNT3V/jkh6Hvbl6Y9gLBaUnNrkIQ==
X-Received: by 2002:a05:620a:1917:b0:7a1:dc64:59db with SMTP id af79cd13be357-7a3824762c9mr447120385a.8.1723145312983;
        Thu, 08 Aug 2024 12:28:32 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a378693d23sm188152785a.87.2024.08.08.12.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 12:28:32 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-bcachefs@vger.kernel.org
Subject: [PATCH v2 13/16] fsnotify: generate pre-content permission event on page fault
Date: Thu,  8 Aug 2024 15:27:15 -0400
Message-ID: <b8c3f0d9ed6d23f9a636919e28293cdbbe22e0db.1723144881.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1723144881.git.josef@toxicpanda.com>
References: <cover.1723144881.git.josef@toxicpanda.com>
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
 include/linux/mm.h |  2 +
 mm/filemap.c       | 97 ++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 92 insertions(+), 7 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ab3d78116043..c33f3b7f7261 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3503,6 +3503,8 @@ extern vm_fault_t filemap_fault(struct vm_fault *vmf);
 extern vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 		pgoff_t start_pgoff, pgoff_t end_pgoff);
 extern vm_fault_t filemap_page_mkwrite(struct vm_fault *vmf);
+extern vm_fault_t filemap_maybe_emit_fsnotify_event(struct vm_fault *vmf,
+						    struct file **fpin);
 
 extern unsigned long stack_guard_gap;
 /* Generic expand stack which grows the stack according to GROWS{UP,DOWN} */
diff --git a/mm/filemap.c b/mm/filemap.c
index 8b1684b62177..3d232166b051 100644
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
@@ -3260,6 +3261,72 @@ static vm_fault_t filemap_fault_recheck_pte_none(struct vm_fault *vmf)
 	return ret;
 }
 
+/**
+ * filemap_maybe_emit_fsnotify_event - maybe emit a pre-content event.
+ * @vmf:	struct vm_fault containing details of the fault.
+ * @fpin:	pointer to the struct file pointer that may be pinned.
+ *
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
+vm_fault_t filemap_maybe_emit_fsnotify_event(struct vm_fault *vmf,
+					     struct file **fpin)
+{
+	struct file *file = vmf->vma->vm_file;
+	loff_t pos = vmf->pgoff << PAGE_SHIFT;
+	int mask = (vmf->flags & FAULT_FLAG_WRITE) ? MAY_WRITE : MAY_READ;
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
+		return VM_FAULT_SIGBUS | VM_FAULT_RETRY;
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
+EXPORT_SYMBOL_GPL(filemap_maybe_emit_fsnotify_event);
+
 /**
  * filemap_fault - read in file data for page fault handling
  * @vmf:	struct vm_fault containing details of the fault
@@ -3299,6 +3366,19 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 	if (unlikely(index >= max_idx))
 		return VM_FAULT_SIGBUS;
 
+	/*
+	 * If we have pre-content watchers then we need to generate events on
+	 * page fault so that we can populate any data before the fault.
+	 */
+	ret = filemap_maybe_emit_fsnotify_event(vmf, &fpin);
+	if (unlikely(ret)) {
+		if (fpin) {
+			fput(fpin);
+			ret |= VM_FAULT_RETRY;
+		}
+		return ret;
+	}
+
 	/*
 	 * Do we have something in the page cache already?
 	 */
@@ -3309,21 +3389,24 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
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


