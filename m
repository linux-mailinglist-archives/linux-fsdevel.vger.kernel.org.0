Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB35334A22
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Mar 2021 22:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbhCJVuw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 16:50:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbhCJVu1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 16:50:27 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE906C061574
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Mar 2021 13:50:27 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id z13so9645464plo.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Mar 2021 13:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=2/H3hQCaHwfnzylFb005783iZv8m6Dk6xxFiFwYXl2k=;
        b=Hyv7Yh9phqQMd9/cQHrN4FjQjTAIfhsLRQRAPalxsJHB3yJRGs2AojFWAa8BaOJkV5
         XA8L6EvPO3gAkv2ugEKvSMnE2r2ChiYSLA9EsTr0lRlBpf8YqW1Zjc5QJ35N7ZIORxgy
         qPnRNow7FeFO0LnedAdmGzFF2GFnginNfR+5aVDCEWQfTvJDn3sGly7P3UD69RCV3rVF
         WoWhvBdNlO3b4cJ7r4PoIiz0QKU0D5sbQXXoYEL4aRLjD3UPlxDHrh14QXHeew+iOUcX
         vvLPfvCXr0KMItO7NQdXkANh7gB1NT1vgMxjxMxS1siSrkXaFDHVF9gkIAoK1Zq3u5lb
         Hyyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=2/H3hQCaHwfnzylFb005783iZv8m6Dk6xxFiFwYXl2k=;
        b=ApKhuwdJFV5qi+6uBhgjFu+iMYid+LKq+TBuUtMbnVepi4JorGtxUsZVbTQYPpmr9f
         XfjoSXrUR4BEXVizckmOgEiJfLEUdjNAm43ZoPRnPv/5w4oCT8qttRVgn0OF2tvRPqkW
         k4X0t4xFNNNqFSxeudDMfGQUZKaMgKatzGraXjiSbrsh+Nwd9T8bbqqnEIOJDetROjTJ
         gD7ntmKIKCmw+gNqzN4+SlWR3S7dAURkeJtP3z6mWpEaWwMGHv0A2iP1Yc+8YZnrLWeE
         0gh1eQ1yTvGxw1MnmaO5nMWcahq5hw0QodCYKJDoMsX3M4soKtjmsasirRgTE74ORaX4
         jf6A==
X-Gm-Message-State: AOAM531z99mzvPhJfCKLwM6QJ/5OLkVUoHykfqK+66V9rDEv803QpeWz
        hU2STD39FDDdwwg/MzRR/yws1BjLb9aH
X-Google-Smtp-Source: ABdhPJwlSrVzqRPm69b5UEV6PXGiLUfSpKQVWYPiqhBw+JgQscqn/bQx4VAmuAjckiMbWHQlPW10jb/GZSRA
X-Received: from bg.sfo.corp.google.com ([2620:15c:8:10:f8cb:bbee:22b1:7932])
 (user=bgeffon job=sendgmr) by 2002:aa7:8a56:0:b029:1f3:9c35:3cbb with SMTP id
 n22-20020aa78a560000b02901f39c353cbbmr4562813pfa.24.1615413027247; Wed, 10
 Mar 2021 13:50:27 -0800 (PST)
Date:   Wed, 10 Mar 2021 13:50:23 -0800
Message-Id: <20210310215023.4129753-1-bgeffon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH] eventfd: Introduce EFD_ZERO_ON_WAKE
From:   Brian Geffon <bgeffon@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Brian Geffon <bgeffon@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Sonny Rao <sonnyrao@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch introduces a new flag to eventfd, called EFD_ZERO_ON_WAKE.
This change is primarily introduced for use cases which do not care about
the value stored in the eventfd itself. Such existing use cases require an
additional read syscall to clear the count.

This flag provides the following guarantees:

(1) Writes can never block or return EAGAIN.
    The reason this is true is because we don't actually need to store the
    value and as a result the internal value is only changed between 0 and
    1 and back to 0. Therefore POLLERR and POLLOUT are never possible
    outcomes. A poll with POLLOUT or a write will always immediately
    return regardless of EFD_NONBLOCK.

(2) Read / POLLIN result in the internal value being reset to 0.
    When EFD_NONBLOCK is set reads when the internal value is 0 will
    immediately return with EAGAIN, as it always has. Similiarly, when
    a read is performed without EFD_NONBLOCK it will block until a write
    occurs. In both cases after the read completes successfully the
    internal value is reset to 0. When polling with POLLIN, upon return
    of a POLLIN event the internal value will be reset to 0.

Signed-off-by: Brian Geffon <bgeffon@google.com>
---
 fs/eventfd.c            | 39 +++++++++++++++++++++++++++++++++++++--
 include/linux/eventfd.h |  8 +++++++-
 2 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/fs/eventfd.c b/fs/eventfd.c
index e265b6dd4f34..56bf04d6461e 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -172,8 +172,21 @@ static __poll_t eventfd_poll(struct file *file, poll_table *wait)
 	 */
 	count = READ_ONCE(ctx->count);
 
-	if (count > 0)
+	if (count > 0) {
+		if ((ctx->flags & EFD_ZERO_ON_WAKE) &&
+				(poll_requested_events(wait) & EPOLLIN)) {
+			/*
+			 * We're going to cause a wake on EPOLLIN, we need to zero the count.
+			 * We validate that EPOLLIN is a requested event because if the user
+			 * did something odd like POLLPRI we wouldn't want to zero the count
+			 * if no wake happens.
+			 */
+			spin_lock_irq(&ctx->wqh.lock);
+			ctx->count = 0;
+			spin_unlock_irq(&ctx->wqh.lock);
+		}
 		events |= EPOLLIN;
+	}
 	if (count == ULLONG_MAX)
 		events |= EPOLLERR;
 	if (ULLONG_MAX - 1 > count)
@@ -239,8 +252,11 @@ static ssize_t eventfd_read(struct kiocb *iocb, struct iov_iter *to)
 		__add_wait_queue(&ctx->wqh, &wait);
 		for (;;) {
 			set_current_state(TASK_INTERRUPTIBLE);
-			if (ctx->count)
+			if (ctx->count) {
+				if (ctx->flags & EFD_ZERO_ON_WAKE)
+					ctx->count = 0;
 				break;
+			}
 			if (signal_pending(current)) {
 				__remove_wait_queue(&ctx->wqh, &wait);
 				__set_current_state(TASK_RUNNING);
@@ -280,6 +296,18 @@ static ssize_t eventfd_write(struct file *file, const char __user *buf, size_t c
 		return -EINVAL;
 	spin_lock_irq(&ctx->wqh.lock);
 	res = -EAGAIN;
+
+	/*
+	 * In the case of EFD_ZERO_ON_WAKE the actual count is never needed, for this
+	 * reason we only adjust it to set it from 0 to 1 or 1 to 0. This means that
+	 * write will never return EWOULDBLOCK or block, because there is always
+	 * going to be enough space to write as the amount we will increment could
+	 * be at most 1 as it's clamped below. Additionally, we know that POLLERR
+	 * cannot be returned when EFD_ZERO_ON_WAKE is used for the same reason.
+	 */
+	if (ctx->flags & EFD_ZERO_ON_WAKE)
+		ucnt = (ctx->count == 0) ? 1 : 0;
+
 	if (ULLONG_MAX - ctx->count > ucnt)
 		res = sizeof(ucnt);
 	else if (!(file->f_flags & O_NONBLOCK)) {
@@ -414,9 +442,16 @@ static int do_eventfd(unsigned int count, int flags)
 	BUILD_BUG_ON(EFD_CLOEXEC != O_CLOEXEC);
 	BUILD_BUG_ON(EFD_NONBLOCK != O_NONBLOCK);
 
+	/* O_NOFOLLOW has been repurposed as EFD_ZERO_ON_WAKE */
+	BUILD_BUG_ON(EFD_ZERO_ON_WAKE != O_NOFOLLOW);
+
 	if (flags & ~EFD_FLAGS_SET)
 		return -EINVAL;
 
+	/* The semaphore semantics would be lost if using EFD_ZERO_ON_WAKE */
+	if ((flags & EFD_ZERO_ON_WAKE) && (flags & EFD_SEMAPHORE))
+		return -EINVAL;
+
 	ctx = kmalloc(sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
 		return -ENOMEM;
diff --git a/include/linux/eventfd.h b/include/linux/eventfd.h
index fa0a524baed0..19cab0b654a4 100644
--- a/include/linux/eventfd.h
+++ b/include/linux/eventfd.h
@@ -26,8 +26,14 @@
 #define EFD_CLOEXEC O_CLOEXEC
 #define EFD_NONBLOCK O_NONBLOCK
 
+/*
+ * We intentionally use the value of O_NOFOLLOW for EFD_ZERO_ON_WAKE
+ * because O_NOFOLLOW would have no meaning with an eventfd.
+ */
+#define EFD_ZERO_ON_WAKE O_NOFOLLOW
+
 #define EFD_SHARED_FCNTL_FLAGS (O_CLOEXEC | O_NONBLOCK)
-#define EFD_FLAGS_SET (EFD_SHARED_FCNTL_FLAGS | EFD_SEMAPHORE)
+#define EFD_FLAGS_SET (EFD_SHARED_FCNTL_FLAGS | EFD_SEMAPHORE | EFD_ZERO_ON_WAKE)
 
 struct eventfd_ctx;
 struct file;
-- 
2.30.1.766.gb4fecdf3b7-goog

