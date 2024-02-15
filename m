Return-Path: <linux-fsdevel+bounces-11742-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A44856CCE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 19:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BCBBB29C72
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 18:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2B21474D1;
	Thu, 15 Feb 2024 18:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JdeZASRb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD8213B7AA
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Feb 2024 18:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708021692; cv=none; b=OFL7DVJNIcJLxj47Pti9caJw3WXeBRNx00nc5L9apGbSr9my0Nas0+LqB6ilPDlbb/DJC8lmqmRnI1NUX4LyU0YMxGGWNq5WhoVwxN7XlZumybUgCpcobPqVr2xNIFhcfEb06xW1KMp9gErZDBEjZAr1rEU27uUhaxasOtlWq54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708021692; c=relaxed/simple;
	bh=APdeBRsHAtrJONBAc4fOC4nb+0sbyGbwGk53lr6VS2s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=A4Yxo+le9A75RHq0pcryW/nbxuPtYwQHleXf6sfXTMtCndxLEOF0uxIfHRTrJy0VEAeTK+jiCW0RUY0LooE+sYMsLB7kuhJrUVXtqWvXJZveSGobrsgYdrJNpdZb4A2BltttxHebSmoGpsDIlV7daLqBkYmsK2+1zqL82uG7JpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lokeshgidra.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JdeZASRb; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lokeshgidra.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b26eef6cso1533703276.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Feb 2024 10:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708021690; x=1708626490; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5jFzOipv9bDJZnpb7UwZ8Eham/ShclgiDNDH7Ow4z+0=;
        b=JdeZASRbYGYpemdfvKlLncp+bu5y5SrC9zBhw3hUislOcnKDtb8Maj+MENxMnDBGz8
         +3+LGzuHYoaPV80kNhyGPR6dW+5DIgB174pmMlT50p+5WRL2ss/TbnVO3KmYW4UGLC1C
         Pc3y7YAVoZuz8OXIY6UpTFVcJAtbc9PRkn7gWSmEUBpN6BZWyb0PEdX/dMmEFEZUJSlD
         WPnKXbD+FKcDG8HqwxgEm1RLg4m1NuD7NMH459wax33b81DplHbFcTxGtOdGCxRHeKky
         JR8swyaRs+ap5hHtKe+Js63RVYTgDPAxkQn0Bgt0gSmpb4GXwd3VnhB1WqxM2VvDwnO0
         QbGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708021690; x=1708626490;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5jFzOipv9bDJZnpb7UwZ8Eham/ShclgiDNDH7Ow4z+0=;
        b=VBTMsDNCt4qjc4a3eq8RlrybFv5pQ3PVtUhldoujT2u0kBeWMnsSqQPL2OCt8gMTwY
         GtEfWTsdwmk5qRrplL/buM5OZaF5ONqVVAr+tvLtOCJxb7E+WIT4UZf1sh9YlBkN9/vp
         c40B8mhE8GPoGsAODfTYolJIizU+zgR8XoTUA4ZTBeEDduWR0Z5CNf/si9szvvk6ahLn
         Ms+LNuWffJYwk0dfhsvYO1i7WQ2iki9tAMp96L7/R65xT6UZsY9D2QSxmwNMvKdmfHGs
         FV+NOPPrfBHgM3xOQyjlHKiewnoKIL7Eodt7mR5XU2VWF2W3UUd4beUWRc9XsPmBBXuA
         whGw==
X-Forwarded-Encrypted: i=1; AJvYcCW8cz0Lc1YRxv5XVrnmbYypb421Y4E5/E8pu44XM9Hn1wS9OVZFW2buH1NlNszXaZOaBmuy3ZRLzmBl2Qq35C0YJFrgmb2S/o8+x/aX5w==
X-Gm-Message-State: AOJu0YysVGiU/RE2oK+MFnzwpGs9NRpJQpzF1SnCl0gJsVPbCbODbMm+
	6lewjBIDZxRaalRawOh8qIDKgMZ9+ELBpKRnctgUpWzHVDKwq8WM6ZAO4s/uRU3fGqKwox857mc
	88LtGO1OLHmqevbZ5+1SbMQ==
X-Google-Smtp-Source: AGHT+IHHi2mCkEldISrNhtoRZCLnocCFS9qBcw8e+39nrcye3IQvcjCcfdDQNRvMWp/R1wX/qkVergX2FymdVGvJXg==
X-Received: from lg.mtv.corp.google.com ([2620:15c:211:202:6186:87a3:6b94:9b81])
 (user=lokeshgidra job=sendgmr) by 2002:a05:6902:f11:b0:dc6:db9b:7a6d with
 SMTP id et17-20020a0569020f1100b00dc6db9b7a6dmr83663ybb.13.1708021690138;
 Thu, 15 Feb 2024 10:28:10 -0800 (PST)
Date: Thu, 15 Feb 2024 10:27:53 -0800
In-Reply-To: <20240215182756.3448972-1-lokeshgidra@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240215182756.3448972-1-lokeshgidra@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240215182756.3448972-2-lokeshgidra@google.com>
Subject: [PATCH v7 1/4] userfaultfd: move userfaultfd_ctx struct to header file
From: Lokesh Gidra <lokeshgidra@google.com>
To: akpm@linux-foundation.org
Cc: lokeshgidra@google.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, surenb@google.com, 
	kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com, 
	david@redhat.com, axelrasmussen@google.com, bgeffon@google.com, 
	willy@infradead.org, jannh@google.com, kaleshsingh@google.com, 
	ngeoffray@google.com, timmurray@google.com, rppt@kernel.org, 
	Liam.Howlett@oracle.com, ryan.roberts@arm.com
Content-Type: text/plain; charset="UTF-8"

Moving the struct to userfaultfd_k.h to be accessible from
mm/userfaultfd.c. There are no other changes in the struct.

This is required to prepare for using per-vma locks in userfaultfd
operations.

Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
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


