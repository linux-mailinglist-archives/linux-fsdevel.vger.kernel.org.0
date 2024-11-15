Return-Path: <linux-fsdevel+bounces-34943-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EB09CF03B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 16:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 380A328A541
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 15:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57281F7547;
	Fri, 15 Nov 2024 15:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="jA61qXD0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D2E1F4275
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 15:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731684717; cv=none; b=TvT2NDRyMghmjfo9ew7EY7m44iVSk77JFYK62/HrLNLjipZnD5B/Fhn8cHL/zckuTt2GGtxPnfBISC087h1eFv8tS+41qVaSkTlpuKFP5XJAHs1YQE27j8r3tf7Qp2JHFJsg/aNNPZJOv/BU5HjPzpl0lx4MKMSsNoXXSr33VMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731684717; c=relaxed/simple;
	bh=32HChrQf54ppyFpL+uRbV0WQCoSZt7JFC7d0t8FH4FM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=btulAgVD7cmF0uq0/uqnEolFA8mNj5+CYPjB+cqwolmKyTN/PAgyQJ/h+vAWKpLL2SgdyFtN9J9Ck2WDaYw43UgXjKG2n7kP1vwbsXcMowPQajuqIbe5sxGbLddb3sNtkIscpe45i3AuGz1a0vrmy324yOd0URjsfLnNsZ+lUjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=jA61qXD0; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6ee4460fd7bso16249867b3.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 07:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731684714; x=1732289514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3KCTaRjNmkxmxaKf/dEMrgpxbgs8A3iRugI4cag6Bm4=;
        b=jA61qXD0D+5s1K3oXaOlt3fiKxBu4Z1olSsgdJsIA0G38KJ8AqkvsFDcLzgAlrJZ52
         Hn24JTZTb1L2XNUb5XqEBTOzJ98S98UZYMp5rc9YC71wP6Ffo3/EZ34kLqFby2MNPi6Y
         Ofgo+NSfyVe67MVsvzVOqQZjMa1t16WDshS1PMB0R1f8rnItl1WpQQarS0gebZUMLrJf
         v8hjEm5gZYyZJoP0Wx8p3pVpjyp1dSaXDuaHTxo2lQULdK2V30Zi+ygWrCtFBEmZ2trn
         pSsRhAIGONoFL8/ueM9bhjgi3Ms1Ikaqjkqi/WzdLBk+oZOs4PWPkRgd3XbpBbV3R1/h
         Ziww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731684714; x=1732289514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3KCTaRjNmkxmxaKf/dEMrgpxbgs8A3iRugI4cag6Bm4=;
        b=gAVB29ILJkXi7iE/faMJGiFENFkfFfMAQMIxLdn625dyeNui68wUi3LFanhoSHnVMK
         U0LrdcQfKH30XJ8y7scS8rC679A6sWDSzhuzzo0MJFEGaMITC4p/zvsDYoAfVWZoJrb0
         zI8OEIz3u3sY0aq16l3oGUZlDs7b4JBHDPSrt9fw8nte/q4XAeWO5aOtBcYhwzwW6ylb
         pnUfYq3Dy9ENd4T+BbzrD4HhQbXJITGpSC/cFnm/+GBHiNiuPYrHEuLivWqfwE3brePp
         McaNf3XM38778X3ghw2N/F9pcNBAjDDe+g8788v8o87lAMhpDR2DKRfRODYYfJ/g/x8l
         w5wA==
X-Forwarded-Encrypted: i=1; AJvYcCXf3ruOYag5xargeLsiRcX3gwBUmgCDMpgnnncYCC0VTDW63JTtLVy+dJf/R89qPdkPjoKhBtP7+gUkjbTX@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2Yy1LE9s6ULnCJ2sHx54QCq8Sac9otvoj9KiipipumuJKuxxR
	C6C8uqciahLxjSClsJY1KBPAwq+UtNJ9DY81zzSCu1dkUn5Z/C72At1seg6tTxSaw9QUVbY7njb
	U
X-Google-Smtp-Source: AGHT+IFmVYcZJStgSp9a9E1dsOyyT4rBH0daYbq6mRod+diiaSsdzS2Ed6cQkqbS64804RotiUDKFQ==
X-Received: by 2002:a05:690c:9:b0:6e2:a129:1623 with SMTP id 00721157ae682-6ee55c69ee9mr29748387b3.38.1731684714337;
        Fri, 15 Nov 2024 07:31:54 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ee4444ccdfsm7704207b3.120.2024.11.15.07.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 07:31:53 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk,
	linux-xfs@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-ext4@vger.kernel.org
Subject: [PATCH v8 16/19] fsnotify: generate pre-content permission event on page fault
Date: Fri, 15 Nov 2024 10:30:29 -0500
Message-ID: <aa56c50ce81b1fd18d7f5d71dd2dfced5eba9687.1731684329.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1731684329.git.josef@toxicpanda.com>
References: <cover.1731684329.git.josef@toxicpanda.com>
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


