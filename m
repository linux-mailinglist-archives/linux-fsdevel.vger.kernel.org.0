Return-Path: <linux-fsdevel+bounces-11461-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 808AE853E3D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 23:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5107CB2CD37
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 22:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE8E6217F;
	Tue, 13 Feb 2024 21:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nh3cUfB1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D3E629FB
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Feb 2024 21:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707861477; cv=none; b=eREMmTWd6tUYmCi+/mIR3Gsyy9WCiqqdntrlzWuNKOoICciVNUFm5RP8/Q1o524mjDddrR3wCvNuwR1PfdeIhjjxlpTPhH+I+QkRqUU8CXUERA8G1bY3Wyk/PQe/JkFgcUdjA2w9en3lGNgbzCZIutCNO7vjJjvAYyZzos3tS3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707861477; c=relaxed/simple;
	bh=z41+dvNtRXeKCs53H9ygm12hU6JxKhETApVU+NXe4U4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OEb+gMohqsmpLklNe/M2wxWZkMBDKYJkskzcYhO1zOUXrK8xOru9Jb4RcJfGVq4ghoAWDCIgKICYQYDyYKk8N/M9DUvM0aq8FobmSEcCt5dNhKDT5KNoi3lKOpgNI/pFEDw1icPdQNdN738MAVWg8119n/+OCfMjVb9CHCc3ZCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lokeshgidra.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nh3cUfB1; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lokeshgidra.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5efe82b835fso109011827b3.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Feb 2024 13:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707861475; x=1708466275; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FeTp34JzZtDcGzw26Xy4JuyVdUXeLDl6wgD9/498E4U=;
        b=nh3cUfB1Ln4GU+nYHusOfl2CI/raE/6IxRV2oZfUbNz9sPHFKb/yPT4r9YrUSFXbVZ
         K5g8gb7dZ4PejMDDxrZBNbYGaFkYAAF2kSOT1eLH9EY+ul/2HfzferF0/KiPFbOHIALo
         iJR03JFwDfGhgYZvwQRh1I/mAj3xOVxTJ37/PrhHeQDUnbJ+HkKRp+JFgWzCRSAgVEOr
         cipcqRAulXwyLNLkX9eVdQtOqZf8LPis8OlCt22FFyQcs8BWiX8CZlIVQM1BqOVO+fVO
         WDMoOD3PGyI0nEDSrFGGa49aFICpirpJG2GqjKtf1UniRwSVxQfe7Wjxbsltosc5tukc
         CP/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707861475; x=1708466275;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FeTp34JzZtDcGzw26Xy4JuyVdUXeLDl6wgD9/498E4U=;
        b=O0rqjD1VUItWx1d8Yl8bKJnzq8Emop9kiAaBEgWjLwUrJINXXzJQDL8kW4Vvw9rmqK
         1Fs7hB04+G4+cKItyPk5iXD4DOcQTVnvMALJqZL3MIkymb2lrv8HgVIQ23cDP0J4sxgt
         WfNEPJSzkddtlc25yOu5KwZ2CBtEKXxUtBfLaqBrVa0lrESiU1puf1R28MQJ1/aQ1JJK
         weSdJ0IEbcDhH/s7eEiLoAxv7lZ5RINz/NFYoTtOWstBp2MiT16iwjOrvHA7ES7LUrut
         GNW1roJfSTKN28fDgp/XVmdYPSCVcry6GTgsuQIPQDnPPF80KaW4R+oszn3uLe7lMcg+
         qmJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWp/GCS1yNZJ8IjeS0SEdnFVjJWpLsLACxXep7XhCeKZrUGPvFh7EJSf9wPbKUdwrqvebwwQmr4D7mAbo4dNd8jt7V6w9R+YrApnUP9iQ==
X-Gm-Message-State: AOJu0Yz+5FehmvTBi083ZLInA+7F1/DT9U4SL5xEsy9p3+JZbpS6Tyni
	4Lnk0IyUcbPn9lAoXSr9sKViSCGmqjPTDh/XIGyFkPFrBgePsWlfamyRMtSetz+CUjL4LI9sHSR
	I6MWx3B2+BO+isbpFr5G2/Q==
X-Google-Smtp-Source: AGHT+IF6FRAl67GGzZTs+uSDLQ3zEXnXXJGoppNG6Drbo0W+NjY2DiKJAS+tQbv/WS3Q7Q/R1NWID6lqQwyYNbHC0w==
X-Received: from lg.mtv.corp.google.com ([2620:15c:211:202:ce6c:821f:a756:b4b8])
 (user=lokeshgidra job=sendgmr) by 2002:a05:6902:1021:b0:dc6:fa35:b42 with
 SMTP id x1-20020a056902102100b00dc6fa350b42mr95095ybt.2.1707861475235; Tue,
 13 Feb 2024 13:57:55 -0800 (PST)
Date: Tue, 13 Feb 2024 13:57:39 -0800
In-Reply-To: <20240213215741.3816570-1-lokeshgidra@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240213215741.3816570-1-lokeshgidra@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240213215741.3816570-2-lokeshgidra@google.com>
Subject: [PATCH v6 1/3] userfaultfd: move userfaultfd_ctx struct to header file
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


