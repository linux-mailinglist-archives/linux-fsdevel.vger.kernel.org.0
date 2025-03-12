Return-Path: <linux-fsdevel+bounces-43773-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77038A5D76D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 08:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 027173A6764
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 07:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD9F1F4E56;
	Wed, 12 Mar 2025 07:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5O1KuK3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7921D1F4C85
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Mar 2025 07:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741765148; cv=none; b=vASndRCnX8+uJn8jeOLqeyfdHZs9yBW8eQsfkkMyHPxhzUF/TghnrW04FsdgkbYYGj8tsBxgs+8QCJ04wg8uQNFIXV3Dvj0vzEoikyFk7P9arLGC+DjsTN9+6yYdiJisv3RFzj+zBs4n7B0fVUrPCHSAAvCCusupBEkqw4UBb5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741765148; c=relaxed/simple;
	bh=CKp10scVDJl3/78PacODCH5S2HnQy1oE2Wz0Xm2u9Lw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oLR5SQ6SKXUSj1qnD/OLifz7FuzSdD5SVNJD8/jVA8rabpOHSrSq9OYnvSqZtUkhdL3Wm1/EXLne9oXcnwGamSfriAgf/mBx+9IywC4o3AAD1iwCzDa7smsKA3i/UYzB1ixjB+fD+6h8wvAZJG/kHn1LhBtG6CQB+cct7kROJWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b5O1KuK3; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e5b572e45cso11632124a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Mar 2025 00:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741765145; x=1742369945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZXgNWLo9/xllBne308Dx3jLc61dwiBpHKKDO6kh8PiA=;
        b=b5O1KuK3xWtUNYAcIp+oSvq+3MIu40/aUy0BoACbp6Drk0ZbgLUaLoodiix5QU0gz+
         kac05+8RM017OkpW6UT/ghtGTUrREeXsTVzGKZj66xLLAT/o++buJq/T5MDHeUwOQjA6
         h93DJKOEz3XE8y32QC+py7salkxH7kpctvZhGdFSQynwshQbEp9lezdbXq/sqcoowDXV
         Im7222MRG4S8utqTrNM0SOhnRIFR9Yw0m9ZJ/n4Zbwv9ifQ5/xH+uUEHYyyg4LJzFEok
         1ua22sulaWZLDKkG1RiN+9SpOILTx2M0dJT40xk5Vn7N0ovGgEYEBRFP1miKLNfyFZEM
         cb+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741765145; x=1742369945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZXgNWLo9/xllBne308Dx3jLc61dwiBpHKKDO6kh8PiA=;
        b=KsZ5EtTUXcRXlrWISNYhAho39+HJQxqFpiWDyTwHzpj0928O16jO4ad1YtN5w1v0Ba
         jEbqslT85sNyrCe8E/fNsgeYz9XtySpH1xiIZESUb3Juf7v5GRP7KaPfdrDAGYE0qZ7a
         ycLWF+C+gjZ8seY78Vm0bU53EyjpgTx5qQoHu82Tji6NO0RvO0V7dyak1in0/s1WS3NF
         ryi9FB9eI3xOoE/lTuzZbzuFSJoMQ7jluHcuwzkxsWaXDu/ccPdOrNdMGCj+lP5inKUG
         loJLSOtKybXy29Ph6vh78hGJSQgAVCxDpXSHb7uZ6rWxrtim1WgjlD1+HefFP9kDMXvl
         XN6A==
X-Forwarded-Encrypted: i=1; AJvYcCWrcTjer7dpSyj2VSjdvECNbigg1QXUJWpNk8t/acvjVnQD4QxfLAUHkSdWTCJ52gnBbutUYRmONX5QJIWu@vger.kernel.org
X-Gm-Message-State: AOJu0YyetIwSY3Q0ve2X9jLSBeEUwB/3jXywnhJrQU20uHJfzD2Gm+Wo
	HcrHXXd2WfjZUpoeO998bZWleDJrHEctTIIb/DSypFsfZ/hEoYoWXzqgAI/Z
X-Gm-Gg: ASbGnctes2CeFZhJHyb+EFJQN0e/u5VzHpPHcMHDha4AYTP+PmPnhdkmo9HfZascFrq
	5SPu8zWnaqE2Nf3n4Z5RrnFcfbFU1BkRE0arGaP3LntZ0jDzbUfus5qVuBXnHq0aXjJOvfzo6e8
	A5AiJ20zDeEAFloGAX2flkWpxNoHUxvcMnKHwOpqZOq1N34N5jNiwYzolgyL+m1cqrDI6tSDWLb
	I5FSQb0uqulomVGG8c93Sun5XSRFFhNEnbxNaEw1dkfB0f3erazXfhxk2GJieZGxGN250mdEbiK
	XcRiiX+DyQyKtaAJcOCMuAhu3nZnbXVNYKW7of5GTBDPRNNr9dAHZyB8lmyz6x8WGGjDQSpFI3n
	yqE74Z7u9k5qCw950gPJ8njX59HhHd9RD37+F6MHwjQ==
X-Google-Smtp-Source: AGHT+IFZlBFvNJ3+RkYWE6r0gMKlv8TgMbAOeOyeC9Kk50uz28kbKy7co7dakkb4T0GaoCv2ZfEAjg==
X-Received: by 2002:a17:907:968a:b0:ac2:d2f3:6c2e with SMTP id a640c23a62f3a-ac2d2f37833mr463053566b.8.1741765144345;
        Wed, 12 Mar 2025 00:39:04 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac282c69e89sm624740666b.167.2025.03.12.00.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 00:39:03 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 4/6] Revert "fsnotify: generate pre-content permission event on page fault"
Date: Wed, 12 Mar 2025 08:38:50 +0100
Message-Id: <20250312073852.2123409-5-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250312073852.2123409-1-amir73il@gmail.com>
References: <20250312073852.2123409-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 8392bc2ff8c8bf7c4c5e6dfa71ccd893a3c046f6.

In the use case of buffered write whose input buffer is mmapped file on a
filesystem with a pre-content mark, the prefaulting of the buffer can
happen under the filesystem freeze protection (obtained in vfs_write())
which breaks assumptions of pre-content hook and introduces potential
deadlock of HSM handler in userspace with filesystem freezing.

Now that we have pre-content hooks at file mmap() time, disable the
pre-content event hooks on page fault to avoid the potential deadlock.

Reported-by: syzbot+7229071b47908b19d5b7@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-fsdevel/7ehxrhbvehlrjwvrduoxsao5k3x4aw275patsb3krkwuq573yv@o2hskrfawbnc/
Fixes: 8392bc2ff8c8b ("fsnotify: generate pre-content permission event on page fault")
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 include/linux/mm.h |  1 -
 mm/filemap.c       | 74 ----------------------------------------------
 mm/nommu.c         |  7 -----
 3 files changed, 82 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7b1068ddcbb70..8483e09aeb2cd 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3420,7 +3420,6 @@ extern vm_fault_t filemap_fault(struct vm_fault *vmf);
 extern vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 		pgoff_t start_pgoff, pgoff_t end_pgoff);
 extern vm_fault_t filemap_page_mkwrite(struct vm_fault *vmf);
-extern vm_fault_t filemap_fsnotify_fault(struct vm_fault *vmf);
 
 extern unsigned long stack_guard_gap;
 /* Generic expand stack which grows the stack according to GROWS{UP,DOWN} */
diff --git a/mm/filemap.c b/mm/filemap.c
index 2974691fdfad2..ff5fcdd961364 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -47,7 +47,6 @@
 #include <linux/splice.h>
 #include <linux/rcupdate_wait.h>
 #include <linux/sched/mm.h>
-#include <linux/fsnotify.h>
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 #include "internal.h"
@@ -3336,48 +3335,6 @@ static vm_fault_t filemap_fault_recheck_pte_none(struct vm_fault *vmf)
 	return ret;
 }
 
-/**
- * filemap_fsnotify_fault - maybe emit a pre-content event.
- * @vmf:	struct vm_fault containing details of the fault.
- *
- * If we have a pre-content watch on this file we will emit an event for this
- * range.  If we return anything the fault caller should return immediately, we
- * will return VM_FAULT_RETRY if we had to emit an event, which will trigger the
- * fault again and then the fault handler will run the second time through.
- *
- * Return: a bitwise-OR of %VM_FAULT_ codes, 0 if nothing happened.
- */
-vm_fault_t filemap_fsnotify_fault(struct vm_fault *vmf)
-{
-	struct file *fpin = NULL;
-	int mask = (vmf->flags & FAULT_FLAG_WRITE) ? MAY_WRITE : MAY_ACCESS;
-	loff_t pos = vmf->pgoff >> PAGE_SHIFT;
-	size_t count = PAGE_SIZE;
-	int err;
-
-	/*
-	 * We already did this and now we're retrying with everything locked,
-	 * don't emit the event and continue.
-	 */
-	if (vmf->flags & FAULT_FLAG_TRIED)
-		return 0;
-
-	/* No watches, we're done. */
-	if (likely(!FMODE_FSNOTIFY_HSM(vmf->vma->vm_file->f_mode)))
-		return 0;
-
-	fpin = maybe_unlock_mmap_for_io(vmf, fpin);
-	if (!fpin)
-		return VM_FAULT_SIGBUS;
-
-	err = fsnotify_file_area_perm(fpin, mask, &pos, count);
-	fput(fpin);
-	if (err)
-		return VM_FAULT_SIGBUS;
-	return VM_FAULT_RETRY;
-}
-EXPORT_SYMBOL_GPL(filemap_fsnotify_fault);
-
 /**
  * filemap_fault - read in file data for page fault handling
  * @vmf:	struct vm_fault containing details of the fault
@@ -3481,37 +3438,6 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 	 * or because readahead was otherwise unable to retrieve it.
 	 */
 	if (unlikely(!folio_test_uptodate(folio))) {
-		/*
-		 * If this is a precontent file we have can now emit an event to
-		 * try and populate the folio.
-		 */
-		if (!(vmf->flags & FAULT_FLAG_TRIED) &&
-		    unlikely(FMODE_FSNOTIFY_HSM(file->f_mode))) {
-			loff_t pos = folio_pos(folio);
-			size_t count = folio_size(folio);
-
-			/* We're NOWAIT, we have to retry. */
-			if (vmf->flags & FAULT_FLAG_RETRY_NOWAIT) {
-				folio_unlock(folio);
-				goto out_retry;
-			}
-
-			if (mapping_locked)
-				filemap_invalidate_unlock_shared(mapping);
-			mapping_locked = false;
-
-			folio_unlock(folio);
-			fpin = maybe_unlock_mmap_for_io(vmf, fpin);
-			if (!fpin)
-				goto out_retry;
-
-			error = fsnotify_file_area_perm(fpin, MAY_ACCESS, &pos,
-							count);
-			if (error)
-				ret = VM_FAULT_SIGBUS;
-			goto out_retry;
-		}
-
 		/*
 		 * If the invalidate lock is not held, the folio was in cache
 		 * and uptodate and now it is not. Strange but possible since we
diff --git a/mm/nommu.c b/mm/nommu.c
index baa79abdaf037..9cb6e99215e2b 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1613,13 +1613,6 @@ int remap_vmalloc_range(struct vm_area_struct *vma, void *addr,
 }
 EXPORT_SYMBOL(remap_vmalloc_range);
 
-vm_fault_t filemap_fsnotify_fault(struct vm_fault *vmf)
-{
-	BUG();
-	return 0;
-}
-EXPORT_SYMBOL_GPL(filemap_fsnotify_fault);
-
 vm_fault_t filemap_fault(struct vm_fault *vmf)
 {
 	BUG();
-- 
2.34.1


