Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB7DD3E37F1
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Aug 2021 04:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbhHHCIL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 Aug 2021 22:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbhHHCIK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 Aug 2021 22:08:10 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BE8C061760
        for <linux-fsdevel@vger.kernel.org>; Sat,  7 Aug 2021 19:07:52 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id u21-20020a17090a8915b02901782c36f543so19826741pjn.4
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 Aug 2021 19:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dwN65lOUWCgfc5FR2xnpIGVNh4f9hPLrdp8V42nRuEI=;
        b=fgc2EYW7k+YZMwiC/zEHrwd3OX9XXSS0Py/nYlLGpV/s7MzDSslbfB/PwvZoKrLgYF
         CJI4xqiBVk0DZTaRliobcytVTr2VcgidzWEv7AbclNsCdCqoZq0sh3ZW0I0jqZu5QTCw
         EN3hBb3ZYzF/nrf78YnpmJrbKVx+n0/6EmnSLcSQNsZ3PUaAs7mvy+aVVgd0FaFr62iP
         ZBcYYdoEdEFzWVfzDkDL0O0sPC7+9m/h/x31mXWtD+J0IgqBJs8pdYmltiYfrtQMXcez
         YJKFiOiiKBvBsMrRLb8l3iFbM9cqwdpG+hH8upGSNuXdeaJ2uZcibNVD02MhgwLdLCm7
         8jQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dwN65lOUWCgfc5FR2xnpIGVNh4f9hPLrdp8V42nRuEI=;
        b=r3PF1vytIh26RHe1s08qeMwPigVMmrHEQH3LTVjs49mQhKDRun3SDy3v/5GDY/Lrow
         GdQ8pe12f3mhaJ+J6bT3MGCX+Q+lgbqq8uWnhGAB/bx1JpxesT5G4jSStceHztN4rBeH
         CAZCIpuWKELA6wcZkbZwHyk4kU9rjfmfr6I97lTeYXOu/rAiBQtAOx0Q+r2Sn9boir9f
         BIHwVHtIc1hJcchAX1avep8uQXXLBL32O1u3N6mshuaiM2OFsJTtAXjhutXtgp5ofO9F
         RDiLwltuxfMa7E9gxDKB7nBY9XDH2TZAANQwxTx4l+oEXk2Fs0yEJdPXlFfZQ96WnWlK
         3pyQ==
X-Gm-Message-State: AOAM531ejOjjq+1P8V8HLL4JkYKXezbqcpiQGwKmO/HCYuPhTnx42JFD
        nUxwE2BW7TgIdtZ0gB00tB8=
X-Google-Smtp-Source: ABdhPJyvaJVUQ80nhCy7y9ZgYlCgRAOm1yMl+Lh6vfpO16MOgsEx+0kmVDYeMxlnm9snam5J25lqOQ==
X-Received: by 2002:a17:90a:b38e:: with SMTP id e14mr17861844pjr.170.1628388471406;
        Sat, 07 Aug 2021 19:07:51 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id o18sm3987432pjp.1.2021.08.07.19.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Aug 2021 19:07:50 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Pavel Emelyanov <xemul@parallels.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Nadav Amit <namit@vmware.com>
Subject: [PATCH 2/3] userfaultfd: prevent concurrent API initialization
Date:   Sat,  7 Aug 2021 19:07:23 -0700
Message-Id: <20210808020724.1022515-3-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210808020724.1022515-1-namit@vmware.com>
References: <20210808020724.1022515-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

userfaultfd assumes that the enabled features are set once and never
changed after UFFDIO_API ioctl succeeded.

However, currently, UFFDIO_API can be called concurrently from two
different threads, succeed on both threads and leave userfaultfd's
features in non-deterministic state. Theoretically, other uffd
operations (ioctl's and page-faults) can be dispatched while adversely
affected by such changes of features.

Moreover, the writes to ctx->state and ctx->features are not ordered,
which can - theoretically, again - let userfaultfd_ioctl() think
that userfaultfd API completed, while the features are still not
initialized.

To avoid races, it is arguably best to get rid of ctx->state. Since
there are only 2 states, record the API initialization in ctx->features
as the uppermost bit and remove ctx->state.

Cc: Pavel Emelyanov <xemul@parallels.com>
Fixes: 9cd75c3cd4c3d ("userfaultfd: non-cooperative: add ability to report non-PF events from uffd descriptor")
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 fs/userfaultfd.c | 91 +++++++++++++++++++++++-------------------------
 1 file changed, 44 insertions(+), 47 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 29a3016f16c9..003f0d31743e 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -33,11 +33,6 @@ int sysctl_unprivileged_userfaultfd __read_mostly;
 
 static struct kmem_cache *userfaultfd_ctx_cachep __read_mostly;
 
-enum userfaultfd_state {
-	UFFD_STATE_WAIT_API,
-	UFFD_STATE_RUNNING,
-};
-
 /*
  * Start with fault_pending_wqh and fault_wqh so they're more likely
  * to be in the same cacheline.
@@ -69,8 +64,6 @@ struct userfaultfd_ctx {
 	unsigned int flags;
 	/* features requested from the userspace */
 	unsigned int features;
-	/* state machine */
-	enum userfaultfd_state state;
 	/* released */
 	bool released;
 	/* memory mappings are changing because of non-cooperative event */
@@ -104,6 +97,14 @@ struct userfaultfd_wake_range {
 	unsigned long len;
 };
 
+/* internal indication that UFFD_API ioctl was successfully executed */
+#define UFFD_FEATURE_INITIALIZED		(1u << 31)
+
+static bool userfaultfd_is_initialized(struct userfaultfd_ctx *ctx)
+{
+	return ctx->features & UFFD_FEATURE_INITIALIZED;
+}
+
 static int userfaultfd_wake_function(wait_queue_entry_t *wq, unsigned mode,
 				     int wake_flags, void *key)
 {
@@ -667,7 +668,6 @@ int dup_userfaultfd(struct vm_area_struct *vma, struct list_head *fcs)
 
 		refcount_set(&ctx->refcount, 1);
 		ctx->flags = octx->flags;
-		ctx->state = UFFD_STATE_RUNNING;
 		ctx->features = octx->features;
 		ctx->released = false;
 		atomic_set(&ctx->mmap_changing, 0);
@@ -944,38 +944,33 @@ static __poll_t userfaultfd_poll(struct file *file, poll_table *wait)
 
 	poll_wait(file, &ctx->fd_wqh, wait);
 
-	switch (ctx->state) {
-	case UFFD_STATE_WAIT_API:
+	if (!userfaultfd_is_initialized(ctx))
 		return EPOLLERR;
-	case UFFD_STATE_RUNNING:
-		/*
-		 * poll() never guarantees that read won't block.
-		 * userfaults can be waken before they're read().
-		 */
-		if (unlikely(!(file->f_flags & O_NONBLOCK)))
-			return EPOLLERR;
-		/*
-		 * lockless access to see if there are pending faults
-		 * __pollwait last action is the add_wait_queue but
-		 * the spin_unlock would allow the waitqueue_active to
-		 * pass above the actual list_add inside
-		 * add_wait_queue critical section. So use a full
-		 * memory barrier to serialize the list_add write of
-		 * add_wait_queue() with the waitqueue_active read
-		 * below.
-		 */
-		ret = 0;
-		smp_mb();
-		if (waitqueue_active(&ctx->fault_pending_wqh))
-			ret = EPOLLIN;
-		else if (waitqueue_active(&ctx->event_wqh))
-			ret = EPOLLIN;
 
-		return ret;
-	default:
-		WARN_ON_ONCE(1);
+	/*
+	 * poll() never guarantees that read won't block.
+	 * userfaults can be waken before they're read().
+	 */
+	if (unlikely(!(file->f_flags & O_NONBLOCK)))
 		return EPOLLERR;
-	}
+	/*
+	 * lockless access to see if there are pending faults
+	 * __pollwait last action is the add_wait_queue but
+	 * the spin_unlock would allow the waitqueue_active to
+	 * pass above the actual list_add inside
+	 * add_wait_queue critical section. So use a full
+	 * memory barrier to serialize the list_add write of
+	 * add_wait_queue() with the waitqueue_active read
+	 * below.
+	 */
+	ret = 0;
+	smp_mb();
+	if (waitqueue_active(&ctx->fault_pending_wqh))
+		ret = EPOLLIN;
+	else if (waitqueue_active(&ctx->event_wqh))
+		ret = EPOLLIN;
+
+	return ret;
 }
 
 static const struct file_operations userfaultfd_fops;
@@ -1170,7 +1165,7 @@ static ssize_t userfaultfd_read(struct file *file, char __user *buf,
 	int no_wait = file->f_flags & O_NONBLOCK;
 	struct inode *inode = file_inode(file);
 
-	if (ctx->state == UFFD_STATE_WAIT_API)
+	if (!userfaultfd_is_initialized(ctx))
 		return -EINVAL;
 
 	for (;;) {
@@ -1909,9 +1904,10 @@ static int userfaultfd_continue(struct userfaultfd_ctx *ctx, unsigned long arg)
 static inline unsigned int uffd_ctx_features(__u64 user_features)
 {
 	/*
-	 * For the current set of features the bits just coincide
+	 * For the current set of features the bits just coincide. Set
+	 * UFFD_FEATURE_INITIALIZED to mark the features as enabled.
 	 */
-	return (unsigned int)user_features;
+	return (unsigned int)user_features | UFFD_FEATURE_INITIALIZED;
 }
 
 /*
@@ -1924,12 +1920,10 @@ static int userfaultfd_api(struct userfaultfd_ctx *ctx,
 {
 	struct uffdio_api uffdio_api;
 	void __user *buf = (void __user *)arg;
+	unsigned int ctx_features;
 	int ret;
 	__u64 features;
 
-	ret = -EINVAL;
-	if (ctx->state != UFFD_STATE_WAIT_API)
-		goto out;
 	ret = -EFAULT;
 	if (copy_from_user(&uffdio_api, buf, sizeof(uffdio_api)))
 		goto out;
@@ -1953,9 +1947,13 @@ static int userfaultfd_api(struct userfaultfd_ctx *ctx,
 	ret = -EFAULT;
 	if (copy_to_user(buf, &uffdio_api, sizeof(uffdio_api)))
 		goto out;
-	ctx->state = UFFD_STATE_RUNNING;
+
 	/* only enable the requested features for this uffd context */
-	ctx->features = uffd_ctx_features(features);
+	ctx_features = uffd_ctx_features(features);
+	ret = -EINVAL;
+	if (cmpxchg(&ctx->features, 0, ctx_features) != 0)
+		goto err_out;
+
 	ret = 0;
 out:
 	return ret;
@@ -1972,7 +1970,7 @@ static long userfaultfd_ioctl(struct file *file, unsigned cmd,
 	int ret = -EINVAL;
 	struct userfaultfd_ctx *ctx = file->private_data;
 
-	if (cmd != UFFDIO_API && ctx->state == UFFD_STATE_WAIT_API)
+	if (cmd != UFFDIO_API && !userfaultfd_is_initialized(ctx))
 		return -EINVAL;
 
 	switch(cmd) {
@@ -2086,7 +2084,6 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
 	refcount_set(&ctx->refcount, 1);
 	ctx->flags = flags;
 	ctx->features = 0;
-	ctx->state = UFFD_STATE_WAIT_API;
 	ctx->released = false;
 	atomic_set(&ctx->mmap_changing, 0);
 	ctx->mm = current->mm;
-- 
2.25.1

