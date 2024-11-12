Return-Path: <linux-fsdevel+bounces-34510-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B269C5FBC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 19:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4B9E284CEF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 18:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555CA21A4B2;
	Tue, 12 Nov 2024 17:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="B8tf1Q0l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20379219E3B
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 17:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731434214; cv=none; b=EGbL2a/0xswXEVkrUn94YpPJ/wKKjgjCpcIH1HJw8Q7I8jT7/4Yb88pFpxIpkKA/Z+GT0JEsiO8yF6meJjwdAk84WTQ0phhM824U9lhx8GWfPKRjEqZ8mg+Ll8oOPlcNyx6ExQXFTKZddeOzHpsQXSSMR9RNyYMUpXte+Pv/jVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731434214; c=relaxed/simple;
	bh=32HChrQf54ppyFpL+uRbV0WQCoSZt7JFC7d0t8FH4FM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fVr8+7Za9ZW3binHz3LkFyunExbBweHAG64gkTLE35sd61ezh4vyVuRHWcRRSVlJ484wT+wVBFyXAHLkzDni/i/pzYCA38KKsxrQA2mV8AJK+rhbvoMArLvbE162sZMNKwmJYXn25unI+0Of8HVfvhIKuZHQot7FPYIdpvEX1Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=B8tf1Q0l; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6ea5f68e17aso60637067b3.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 09:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731434212; x=1732039012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3KCTaRjNmkxmxaKf/dEMrgpxbgs8A3iRugI4cag6Bm4=;
        b=B8tf1Q0l7Cn2olzOKvKEvlb0nDjyun1H6yBmktm8r+ZUdYyL7fXrHgPR86KS4qO5mX
         xF92wdQNgjKiXZLTW4TQzwX1BQ/0py4K3gH1EnOCC+ZJr7FIUhjAaF5MoWCPmYmzdnA1
         rKc+WgW33Co5PzS+FZBxurWXj7GktZtFJIGYzip83HhHVqWRgQicx16YvyTDAxl5rgNY
         /FEXaDcYbaXdqKL9otaV5SLCikbQtz/2K+ylc0hnwjb2aCCz5IldEtrFDzBzyhuThQdY
         9dJ1f//LtW90U9jDTbg1bYEqDGo1hoQrinq1o8vyCVLteMwh6Bzf8ZLK84KjX57zfLyY
         m20g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731434212; x=1732039012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3KCTaRjNmkxmxaKf/dEMrgpxbgs8A3iRugI4cag6Bm4=;
        b=mTHzx9CgOtnWaEhxLnqLgKxXPPvn89Sr7GF2qknegPdgJUblNjbTM+gXK9m4B0oYB3
         FpzN50RQuVam4NMFN8JzwF4Q7ahyLJKFPBVs0QuknYRdLlcf/qvDzqqlrp5ot2YhlokD
         ErcyL/x1K3FErIDGCKjdqDgI/rCM3QvoWm+En26XXYFC04mNyo/QB39ZKDA3VZRWwUo4
         w2Y1UAAn3qw/mhs5XqOHszTqqQhvlC3L7VUOklszmuf5RRramexn/WRbFBG/a/3M0Olr
         8AjZ7Dtj/hOzFfS8m64hsrDbjT2kHQOf9iWHmPU6isTlO238MQeMWwQqqQRMggwtUAo4
         cZ0w==
X-Forwarded-Encrypted: i=1; AJvYcCV+i+o/Mc5xbhaNHvpgZdR5hpRADXMEGRgEvd9XSoX+ldShGrIRS8CODe3a1MGLsRZJYW92KbSju0ZSUWou@vger.kernel.org
X-Gm-Message-State: AOJu0YzUjklCqidWhrwt/KX3/HdReMMD4JdNk7eQLec0E741yDuPbDhY
	dIiBYSPQKzxqLZe7tB2Zg3EO6wSvz80E5dJBd2GSVKy5jd6b4DAR9u/FkCrUD64=
X-Google-Smtp-Source: AGHT+IFoXHSrvSv1nHXDianvdqh8AvWvvCdruw2IfTMCI7MfgJuOUf9jQwkCjXgIqLVtzlih0erFEw==
X-Received: by 2002:a05:690c:700e:b0:6ea:8dad:c3cf with SMTP id 00721157ae682-6eadddbc58emr168920227b3.20.1731434212150;
        Tue, 12 Nov 2024 09:56:52 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eaceb0cdc8sm26499817b3.65.2024.11.12.09.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 09:56:51 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	torvalds@linux-foundation.org,
	linux-xfs@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-ext4@vger.kernel.org
Subject: [PATCH v7 15/18] fsnotify: generate pre-content permission event on page fault
Date: Tue, 12 Nov 2024 12:55:30 -0500
Message-ID: <8d223ba40c3ad28dcf9369bf16c3182baa925e59.1731433903.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1731433903.git.josef@toxicpanda.com>
References: <cover.1731433903.git.josef@toxicpanda.com>
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
 include/linux/mm.h |  1 +
 mm/filemap.c       | 78 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 01c5e7a4489f..90155ef8599a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3406,6 +3406,7 @@ extern vm_fault_t filemap_fault(struct vm_fault *vmf);
 extern vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 		pgoff_t start_pgoff, pgoff_t end_pgoff);
 extern vm_fault_t filemap_page_mkwrite(struct vm_fault *vmf);
+extern vm_fault_t filemap_fsnotify_fault(struct vm_fault *vmf);
 
 extern unsigned long stack_guard_gap;
 /* Generic expand stack which grows the stack according to GROWS{UP,DOWN} */
diff --git a/mm/filemap.c b/mm/filemap.c
index 68ea596f6905..0bf7d645dec5 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -47,6 +47,7 @@
 #include <linux/splice.h>
 #include <linux/rcupdate_wait.h>
 #include <linux/sched/mm.h>
+#include <linux/fsnotify.h>
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 #include "internal.h"
@@ -3289,6 +3290,52 @@ static vm_fault_t filemap_fault_recheck_pte_none(struct vm_fault *vmf)
 	return ret;
 }
 
+/**
+ * filemap_fsnotify_fault - maybe emit a pre-content event.
+ * @vmf:	struct vm_fault containing details of the fault.
+ * @folio:	the folio we're faulting in.
+ *
+ * If we have a pre-content watch on this file we will emit an event for this
+ * range.  If we return anything the fault caller should return immediately, we
+ * will return VM_FAULT_RETRY if we had to emit an event, which will trigger the
+ * fault again and then the fault handler will run the second time through.
+ *
+ * This is meant to be called with the folio that we will be filling in to make
+ * sure the event is emitted for the correct range.
+ *
+ * Return: a bitwise-OR of %VM_FAULT_ codes, 0 if nothing happened.
+ */
+vm_fault_t filemap_fsnotify_fault(struct vm_fault *vmf)
+{
+	struct file *fpin = NULL;
+	int mask = (vmf->flags & FAULT_FLAG_WRITE) ? MAY_WRITE : MAY_ACCESS;
+	loff_t pos = vmf->pgoff >> PAGE_SHIFT;
+	size_t count = PAGE_SIZE;
+	vm_fault_t ret;
+
+	/*
+	 * We already did this and now we're retrying with everything locked,
+	 * don't emit the event and continue.
+	 */
+	if (vmf->flags & FAULT_FLAG_TRIED)
+		return 0;
+
+	/* No watches, we're done. */
+	if (!fsnotify_file_has_pre_content_watches(vmf->vma->vm_file))
+		return 0;
+
+	fpin = maybe_unlock_mmap_for_io(vmf, fpin);
+	if (!fpin)
+		return VM_FAULT_SIGBUS;
+
+	ret = fsnotify_file_area_perm(fpin, mask, &pos, count);
+	fput(fpin);
+	if (ret)
+		return VM_FAULT_SIGBUS;
+	return VM_FAULT_RETRY;
+}
+EXPORT_SYMBOL_GPL(filemap_fsnotify_fault);
+
 /**
  * filemap_fault - read in file data for page fault handling
  * @vmf:	struct vm_fault containing details of the fault
@@ -3392,6 +3439,37 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 	 * or because readahead was otherwise unable to retrieve it.
 	 */
 	if (unlikely(!folio_test_uptodate(folio))) {
+		/*
+		 * If this is a precontent file we have can now emit an event to
+		 * try and populate the folio.
+		 */
+		if (!(vmf->flags & FAULT_FLAG_TRIED) &&
+		    fsnotify_file_has_pre_content_watches(file)) {
+			loff_t pos = folio_pos(folio);
+			size_t count = folio_size(folio);
+
+			/* We're NOWAIT, we have to retry. */
+			if (vmf->flags & FAULT_FLAG_RETRY_NOWAIT) {
+				folio_unlock(folio);
+				goto out_retry;
+			}
+
+			if (mapping_locked)
+				filemap_invalidate_unlock_shared(mapping);
+			mapping_locked = false;
+
+			folio_unlock(folio);
+			fpin = maybe_unlock_mmap_for_io(vmf, fpin);
+			if (!fpin)
+				goto out_retry;
+
+			error = fsnotify_file_area_perm(fpin, MAY_ACCESS, &pos,
+							count);
+			if (error)
+				ret = VM_FAULT_SIGBUS;
+			goto out_retry;
+		}
+
 		/*
 		 * If the invalidate lock is not held, the folio was in cache
 		 * and uptodate and now it is not. Strange but possible since we
-- 
2.43.0


