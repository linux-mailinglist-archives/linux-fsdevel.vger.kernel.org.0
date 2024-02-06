Return-Path: <linux-fsdevel+bounces-10404-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A9184AB68
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 02:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B05B21F258C0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 01:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BB41870;
	Tue,  6 Feb 2024 01:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IkJeKvR6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E1C4A02
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Feb 2024 01:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707181789; cv=none; b=a7k1LNUw3faiqRGSGdw8mA7YbBOxf3ngPqmc2GBXxrj63hZNkvHyVlGqnxz89fqdMboQa6dAjlvnyh8ACEOv9jQScFqr1caq4lay1T8sWaLtteAnZEzbNKFSeju4BYE22QgbXtcmiHKEVDmlkk/zyMkpZ7Q3f+mkBTed/WFhN5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707181789; c=relaxed/simple;
	bh=bW5FqUi/xixapZsn2hg3bnkQMMB9OGn3jW6cVE5NBpw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=P3/MDbtah/n/WAhXoZMV4VsIR6wdcGwXHcvXq64tsYqq3wWjVdtlGNBR4WYJSWcsjUo6uWY5ZWW/wOzsh1nhUgJMdSTxVXf8SDmiG+dnS6kRMWGwnMP05tkXv27yaCvuRm/lcQf23fD3grOh6jiMhPDRgfy9qgg+mXwNzxnaqPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lokeshgidra.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IkJeKvR6; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lokeshgidra.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc693399655so8096928276.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Feb 2024 17:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707181787; x=1707786587; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=l0Wsa/otXfcNbNeX5OxfMRaNnAPGn+xliclZzLODRNs=;
        b=IkJeKvR6Iclv0F+scZfsBuvRqyDqE7LSd1FwFesYxaZLtceS+MwKQTBgbVler14khK
         xvdjNJ7wWY0wa8umpb2erSiE4BB3hH+VPMuqbP1pW/0GPTRUWCp27R0iFio4HlZT+x98
         YIQetP6lbogEreqEZSGdSulXWUiK7xU6F38xQGn87dds+edeeRisB2QK8XSUBmp8isDD
         Wf5bZytpzM4e80MQnk55AQRRRwApV2ZtsTpOKxjfhJwruatI6//zN4v0tkVGaDzfD8wG
         DI2ZvYXKbDENTQa0bN2fQ+BY1dcNMECQd85AYTikexsFS0vJvhblABu+aPAuqu4UpGWs
         M0Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707181787; x=1707786587;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l0Wsa/otXfcNbNeX5OxfMRaNnAPGn+xliclZzLODRNs=;
        b=HC1JWzF1pDlQQifMg8ACj/6ZEMouW/B4UUwbhB4sdrfGkOfAumELE0x7oPzbnn0Y5C
         cChGyBANN36qle04Cud4hhzPUTsVYTQPghreK7+MilzzD190ugUtyXT8fQMbnkBFVo/5
         iQ2iumx6JhYUnC4pLhPUQIBS/JuEoI5CMLu+TnVkfMN16B7ql2/LIvDr3G4DYdHedtBN
         HtaB/oB1j6vucvK8cbYxrTXG23dieulZUmYoKyb/8teC6+DG5kvwkv5RmRHBfX46H5rO
         znWDSlimld7vKNqkZfh4IXb6tUqMujhlAipdDNy8NpBOUH41QQNQZAcBvohfLH/YcAwT
         oMeg==
X-Gm-Message-State: AOJu0YxpTLH1uVmIKvAQ0OQGKnJW06cr/CBUGXXtWUqFZf0Za+vAiClg
	+IQLrhnYF79yT2DAKlmgIHNL23BfDs9pnbFSU8+oCYNEa5aSa3fN7EgsMyNVfpcld7rnc0/GoAM
	OpyW4tOfq3Rh1dF1Zqv4UHw==
X-Google-Smtp-Source: AGHT+IENlNSDcojoxWkSl049zlYz4bm/u4F+E9+JQ3HrIX9YrhW8LmpdpxXCyJfTB1mNb9KyDkiJPwezJtg2W5ykyQ==
X-Received: from lg.mtv.corp.google.com ([2620:15c:211:202:713:bb2c:e0e8:becb])
 (user=lokeshgidra job=sendgmr) by 2002:a05:6902:13ce:b0:dc6:e90a:7f2a with
 SMTP id y14-20020a05690213ce00b00dc6e90a7f2amr53474ybu.5.1707181786937; Mon,
 05 Feb 2024 17:09:46 -0800 (PST)
Date: Mon,  5 Feb 2024 17:09:17 -0800
In-Reply-To: <20240206010919.1109005-1-lokeshgidra@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240206010919.1109005-1-lokeshgidra@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240206010919.1109005-2-lokeshgidra@google.com>
Subject: [PATCH v3 1/3] userfaultfd: move userfaultfd_ctx struct to header file
From: Lokesh Gidra <lokeshgidra@google.com>
To: akpm@linux-foundation.org
Cc: lokeshgidra@google.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, surenb@google.com, 
	kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com, 
	david@redhat.com, axelrasmussen@google.com, bgeffon@google.com, 
	willy@infradead.org, jannh@google.com, kaleshsingh@google.com, 
	ngeoffray@google.com, timmurray@google.com, rppt@kernel.org, 
	Liam.Howlett@oracle.com
Content-Type: text/plain; charset="UTF-8"

Moving the struct to userfaultfd_k.h to be accessible from
mm/userfaultfd.c. There are no other changes in the struct.

This is required to prepare for using per-vma locks in userfaultfd
operations.

Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 fs/userfaultfd.c              | 39 -----------------------------------
 include/linux/userfaultfd_k.h | 39 +++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 05c8e8a05427..58331b83d648 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -50,45 +50,6 @@ static struct ctl_table vm_userfaultfd_table[] = {
 
 static struct kmem_cache *userfaultfd_ctx_cachep __ro_after_init;
 
-/*
- * Start with fault_pending_wqh and fault_wqh so they're more likely
- * to be in the same cacheline.
- *
- * Locking order:
- *	fd_wqh.lock
- *		fault_pending_wqh.lock
- *			fault_wqh.lock
- *		event_wqh.lock
- *
- * To avoid deadlocks, IRQs must be disabled when taking any of the above locks,
- * since fd_wqh.lock is taken by aio_poll() while it's holding a lock that's
- * also taken in IRQ context.
- */
-struct userfaultfd_ctx {
-	/* waitqueue head for the pending (i.e. not read) userfaults */
-	wait_queue_head_t fault_pending_wqh;
-	/* waitqueue head for the userfaults */
-	wait_queue_head_t fault_wqh;
-	/* waitqueue head for the pseudo fd to wakeup poll/read */
-	wait_queue_head_t fd_wqh;
-	/* waitqueue head for events */
-	wait_queue_head_t event_wqh;
-	/* a refile sequence protected by fault_pending_wqh lock */
-	seqcount_spinlock_t refile_seq;
-	/* pseudo fd refcounting */
-	refcount_t refcount;
-	/* userfaultfd syscall flags */
-	unsigned int flags;
-	/* features requested from the userspace */
-	unsigned int features;
-	/* released */
-	bool released;
-	/* memory mappings are changing because of non-cooperative event */
-	atomic_t mmap_changing;
-	/* mm with one ore more vmas attached to this userfaultfd_ctx */
-	struct mm_struct *mm;
-};
-
 struct userfaultfd_fork_ctx {
 	struct userfaultfd_ctx *orig;
 	struct userfaultfd_ctx *new;
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index e4056547fbe6..691d928ee864 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -36,6 +36,45 @@
 #define UFFD_SHARED_FCNTL_FLAGS (O_CLOEXEC | O_NONBLOCK)
 #define UFFD_FLAGS_SET (EFD_SHARED_FCNTL_FLAGS)
 
+/*
+ * Start with fault_pending_wqh and fault_wqh so they're more likely
+ * to be in the same cacheline.
+ *
+ * Locking order:
+ *	fd_wqh.lock
+ *		fault_pending_wqh.lock
+ *			fault_wqh.lock
+ *		event_wqh.lock
+ *
+ * To avoid deadlocks, IRQs must be disabled when taking any of the above locks,
+ * since fd_wqh.lock is taken by aio_poll() while it's holding a lock that's
+ * also taken in IRQ context.
+ */
+struct userfaultfd_ctx {
+	/* waitqueue head for the pending (i.e. not read) userfaults */
+	wait_queue_head_t fault_pending_wqh;
+	/* waitqueue head for the userfaults */
+	wait_queue_head_t fault_wqh;
+	/* waitqueue head for the pseudo fd to wakeup poll/read */
+	wait_queue_head_t fd_wqh;
+	/* waitqueue head for events */
+	wait_queue_head_t event_wqh;
+	/* a refile sequence protected by fault_pending_wqh lock */
+	seqcount_spinlock_t refile_seq;
+	/* pseudo fd refcounting */
+	refcount_t refcount;
+	/* userfaultfd syscall flags */
+	unsigned int flags;
+	/* features requested from the userspace */
+	unsigned int features;
+	/* released */
+	bool released;
+	/* memory mappings are changing because of non-cooperative event */
+	atomic_t mmap_changing;
+	/* mm with one ore more vmas attached to this userfaultfd_ctx */
+	struct mm_struct *mm;
+};
+
 extern vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason);
 
 /* A combined operation mode + behavior flags. */
-- 
2.43.0.594.gd9cf4e227d-goog


