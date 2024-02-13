Return-Path: <linux-fsdevel+bounces-11265-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D428523A2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 01:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFC2E1F22F97
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 00:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB1C55E45;
	Tue, 13 Feb 2024 00:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g52v5K/R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1939554BFD
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Feb 2024 00:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783587; cv=none; b=KvR9Giq+grMi75zv3IotkHPLZNbMiWnpz1EcHfwlMYt+kI0TacMITn/Txl97pZH186dIzDfcOhIabfawIHTbnFD3k1JvyZnDwpl25sy3yBW2YtAhcB0aYgA9GhAvTBa/lWfVkudLw2mP2ltOUyfr0riUt4SsAzjlW7EcYvky/iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783587; c=relaxed/simple;
	bh=z41+dvNtRXeKCs53H9ygm12hU6JxKhETApVU+NXe4U4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=s0EJt+AaM2BtbwBIcad4Kd3QvvUo0k2vxkhP7rumd7IWlV37z6zmX8xuDQm3GZghRXE9Uyzf5lwcHkWLzcAnAQ2jLmReWAb94MgSkZPDFHCIZ89QhPZ4KD+F5TheBB804r/r27krBWsCM0/EvVMyv+pPl5X74BNONbtBM6jE7wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lokeshgidra.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g52v5K/R; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lokeshgidra.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6dbdcfd39so7811059276.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 16:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707783585; x=1708388385; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FeTp34JzZtDcGzw26Xy4JuyVdUXeLDl6wgD9/498E4U=;
        b=g52v5K/RGyVGjMvU9YqeKBjkNahzo5eqSpoHrWByHxcBSyJ7vBCWUIMWjYXjWNKdjR
         H7yDKG7ki0iVR4Jfgc6e+gGlNNzQPGaZcEWlSjC2pvvbLhsuQmZD4dkaEoMbcrDfbZRF
         wiW7IzKRAOJKg8mGObhMLWPb80z3UbOjRmmUWps+EOJvG+V/aPTRWA8yggof2FI0SiR/
         cEzPXtdPTQNH78lXR634/EEXuUxHVmzmEmUk3C8dw2tTWaUUg+Ri4GDJ+A/6UJS31pX/
         KI8cfUPgHneiCH85qFGA3iaN5iPYUhE7x+E3PRhJqbiQYE6ps5ObN9g9Cv0/IY69SKDE
         NhnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707783585; x=1708388385;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FeTp34JzZtDcGzw26Xy4JuyVdUXeLDl6wgD9/498E4U=;
        b=SN8UAlFjhVj15CIvkySy06P+GyPYlgCCehvRnd+kii9b4F0E7CKCTJklhcNcVFuS85
         1whBccGJYnMhSmUEpufM+fgRk8UQQp6T+aUNZfU9B0YF+/nBEvJsePzNZ77Jx8y7Ku4i
         JWSmFNJvDTuYzXRi1rN5AoYVCZJUbPGZ717NNm85ViuEqsqz6T2ZZIHoFr+5MO+rQRpu
         ijVUgQ/Z2dCvdS50/wAeHJy54LaQGeOXmaPIegEUJXUk+g+NJ3Gi85DExpin/dPefsND
         JjNWr+xbW8wdt21oYnOXZr3y277ju/gHYVi27TTJ0wJAXQfpo0Hu66S7LKvjJB55jIiO
         ZAoQ==
X-Gm-Message-State: AOJu0Yyyp/zGA/ZK6u6l/ZOlTdSzpFVsfg7j1sUCOtsSBoErHqgJMs+0
	8D4krmxU8AIWk4bloV5TPYIHqQ7TPZju5aam2UJA1BtG2HnOcLJKg4vu9lmVBH33Betu+72cEIz
	0BynrTzS52cD87OfLVABPiA==
X-Google-Smtp-Source: AGHT+IHHF8psOCpR3jPtRIweQhip+WhYFn+NGs+b1/7N2Bm+HUMlIaS9Pt1A9QzZr7uT4pBB5l5vrCPMXQlp/u7k7Q==
X-Received: from lg.mtv.corp.google.com ([2620:15c:211:202:fd80:ef0f:6359:fc4c])
 (user=lokeshgidra job=sendgmr) by 2002:a05:6902:10c2:b0:dc6:d2c8:6e50 with
 SMTP id w2-20020a05690210c200b00dc6d2c86e50mr1289834ybu.7.1707783585214; Mon,
 12 Feb 2024 16:19:45 -0800 (PST)
Date: Mon, 12 Feb 2024 16:19:18 -0800
In-Reply-To: <20240213001920.3551772-1-lokeshgidra@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240213001920.3551772-1-lokeshgidra@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240213001920.3551772-2-lokeshgidra@google.com>
Subject: [PATCH v5 1/3] userfaultfd: move userfaultfd_ctx struct to header file
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
2.43.0.687.g38aa6559b0-goog


