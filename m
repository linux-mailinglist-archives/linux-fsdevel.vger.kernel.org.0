Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8780043BEEF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Oct 2021 03:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236342AbhJ0BVp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Oct 2021 21:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237073AbhJ0BVo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Oct 2021 21:21:44 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA01C0613B9
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Oct 2021 18:19:19 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id q5-20020a05620a0d8500b0045edb4779dbso658703qkl.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Oct 2021 18:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=tXBF8IPHrXnSIr0GZNWDZAEr0MXQPNCBVCwEca8TIMo=;
        b=GU4Dsa3aUhwed3l5u1ByKWWvqupTtfJDlxC2YsdgHB6f0pBuk4ypKJa0/BG7tQ0RCc
         E0E3RsmDa3L48jL0xzc+0JbNw8zOvjwzTu888jZOCDnw7DFG9987Ij5sYAtn4DoREO9V
         w2EchOQ30pqD9rqHESWGMZWPSLKBP+0bkBZqBdY+y3qu4YzVKbfobOdI2CyvykQItDIs
         sfgJK11oQeCuuSYxVDRzEjToiK5pO4E55kOvqaJLLinUGbHVTlxKmec6y1TqochwE9Cb
         h1W6s1d8MBQRTQPHu6YmnrD1ZDhwylcziXIU4pwpvSoaSKzB0xZG4GXyxtsmzgbiGCwb
         SyKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=tXBF8IPHrXnSIr0GZNWDZAEr0MXQPNCBVCwEca8TIMo=;
        b=oaO3QcxWqsrcV7Je1Ad1sH44oM4VDPirmEqGsvqqcy2fjZoekpI8FfWyQJkgQeCbPU
         87xYp7iuwKNIpBTIG28AXKubnSxhgnssvaonGIxfYfA92I0AX6HjSkeU3DJfIGM5QWIE
         iRytBccoTcRzK+0mOYManjviSbl4powePhXXaSP+o2gKTWfOVx0UY3fHSYElmNq9XHBH
         Sa0xMZu4yNoZ/RSIuCVf8vuiU+FZrYI1b/FFNBVEFMQ+ROCEwTCr4zLggnH+Fv5wxOIQ
         3GQ+xwsrIO59xizs995pYf+0fg38Fr/TnDLQYlBh2r7Yw1d7TL1GHkE+mm8VjvRIqlTm
         z6XQ==
X-Gm-Message-State: AOAM532CCeTYIjL3bz9xIufJ01AvYeAkuBa194fo4lMGDVWZBm3Y8S0S
        PJvY6qcjt1EaGVjVss4yfpZ9LEF6VEGkYsI=
X-Google-Smtp-Source: ABdhPJyzttHnj9zHmxZU6jm7klx3kEHjC4Jg/LsIuYnI614jmLZSGY9gei/2uiOZloZGh2hKapyF4uQoS76nWmM=
X-Received: from ramjiyani.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2edd])
 (user=ramjiyani job=sendgmr) by 2002:ac8:5b8e:: with SMTP id
 a14mr28502874qta.391.1635297558699; Tue, 26 Oct 2021 18:19:18 -0700 (PDT)
Date:   Wed, 27 Oct 2021 01:18:34 +0000
Message-Id: <20211027011834.2497484-1-ramjiyani@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v5] aio: Add support for the POLLFREE
From:   Ramji Jiyani <ramjiyani@google.com>
To:     arnd@arndb.de, viro@zeniv.linux.org.uk, bcrl@kvack.org
Cc:     hch@lst.de, kernel-team@android.com, linux-aio@kvack.org,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, oleg@redhat.com, ebiggers@kernel.org,
        Ramji Jiyani <ramjiyani@google.com>,
        Jeff Moyer <jmoyer@redhat.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add support for the POLLFREE flag to force complete iocb inline in
aio_poll_wake(). A thread may use it to signal it's exit and/or request
to cleanup while pending poll request. In this case, aio_poll_wake()
needs to make sure it doesn't keep any reference to the queue entry
before returning from wake to avoid possible use after free via
poll_cancel() path.

UAF issue was found during binder and aio interactions in certain
sequence of events [1].

The POLLFREE flag is no more exclusive to the epoll and is being
shared with the aio. Remove comment from poll.h to avoid confusion.

[1] https://lore.kernel.org/r/CAKUd0B_TCXRY4h1hTztfwWbNSFQqsudDLn2S_28csgWZmZAG3Q@mail.gmail.com/

Fixes: af5c72b1fc7a ("Fix aio_poll() races")
Signed-off-by: Ramji Jiyani <ramjiyani@google.com>
Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: stable@vger.kernel.org # 4.19+
---
Changes since v1:
- Removed parenthesis around POLLFREE macro definition as per review.
- Updated description to refer UAF issue discussion this patch fixes.
- Updated description to remove reference to parenthesis change.
- Added Reviewed-by from Jeff Moyer

Changes since v2:
- Added Fixes tag.
- Added stable tag for backporting on 4.19+ LTS releases

Changes since v3:
- Updated patch description
- Updated Fixes tag to issue manifestation origin

Changes since v4:
- Added Reviewed-by from Christoph Hellwig
---
 fs/aio.c                        | 45 ++++++++++++++++++---------------
 include/uapi/asm-generic/poll.h |  2 +-
 2 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 51b08ab01dff..5d539c05df42 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1674,6 +1674,7 @@ static int aio_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
 {
 	struct poll_iocb *req = container_of(wait, struct poll_iocb, wait);
 	struct aio_kiocb *iocb = container_of(req, struct aio_kiocb, poll);
+	struct kioctx *ctx = iocb->ki_ctx;
 	__poll_t mask = key_to_poll(key);
 	unsigned long flags;
 
@@ -1683,29 +1684,33 @@ static int aio_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
 
 	list_del_init(&req->wait.entry);
 
-	if (mask && spin_trylock_irqsave(&iocb->ki_ctx->ctx_lock, flags)) {
-		struct kioctx *ctx = iocb->ki_ctx;
+	/*
+	 * Use irqsave/irqrestore because not all filesystems (e.g. fuse)
+	 * call this function with IRQs disabled and because IRQs have to
+	 * be disabled before ctx_lock is obtained.
+	 */
+	if (mask & POLLFREE) {
+		/* Force complete iocb inline to remove refs to deleted entry */
+		spin_lock_irqsave(&ctx->ctx_lock, flags);
+	} else if (!(mask && spin_trylock_irqsave(&ctx->ctx_lock, flags))) {
+		/* Can't complete iocb inline; schedule for later */
+		schedule_work(&req->work);
+		return 1;
+	}
 
-		/*
-		 * Try to complete the iocb inline if we can. Use
-		 * irqsave/irqrestore because not all filesystems (e.g. fuse)
-		 * call this function with IRQs disabled and because IRQs
-		 * have to be disabled before ctx_lock is obtained.
-		 */
-		list_del(&iocb->ki_list);
-		iocb->ki_res.res = mangle_poll(mask);
-		req->done = true;
-		if (iocb->ki_eventfd && eventfd_signal_allowed()) {
-			iocb = NULL;
-			INIT_WORK(&req->work, aio_poll_put_work);
-			schedule_work(&req->work);
-		}
-		spin_unlock_irqrestore(&ctx->ctx_lock, flags);
-		if (iocb)
-			iocb_put(iocb);
-	} else {
+	/* complete iocb inline */
+	list_del(&iocb->ki_list);
+	iocb->ki_res.res = mangle_poll(mask);
+	req->done = true;
+	if (iocb->ki_eventfd && eventfd_signal_allowed()) {
+		iocb = NULL;
+		INIT_WORK(&req->work, aio_poll_put_work);
 		schedule_work(&req->work);
 	}
+	spin_unlock_irqrestore(&ctx->ctx_lock, flags);
+	if (iocb)
+		iocb_put(iocb);
+
 	return 1;
 }
 
diff --git a/include/uapi/asm-generic/poll.h b/include/uapi/asm-generic/poll.h
index 41b509f410bf..f9c520ce4bf4 100644
--- a/include/uapi/asm-generic/poll.h
+++ b/include/uapi/asm-generic/poll.h
@@ -29,7 +29,7 @@
 #define POLLRDHUP       0x2000
 #endif
 
-#define POLLFREE	(__force __poll_t)0x4000	/* currently only for epoll */
+#define POLLFREE	(__force __poll_t)0x4000
 
 #define POLL_BUSY_LOOP	(__force __poll_t)0x8000
 
-- 
2.33.0.1079.g6e70778dc9-goog

