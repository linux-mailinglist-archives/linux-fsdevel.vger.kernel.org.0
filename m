Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5B141B7BB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Sep 2021 21:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242557AbhI1Tqz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Sep 2021 15:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242534AbhI1Tqy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Sep 2021 15:46:54 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB261C06161C
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Sep 2021 12:45:14 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id z130-20020a256588000000b005b6b4594129so44939ybb.15
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Sep 2021 12:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=0asOvLyaIQidtaf+APJitxjeC5t6EzgqSyv0pg+UdAU=;
        b=oo+4dH0tmRYRu3ihXVqY8P4fx0PEAUQCYZqvytcW0mJnDZZhOsxWgnftB4Qm0yiQfO
         K3cu53AfTC8BvblOGKuoRWtb2RKVyJCF4YiAK8cePqBFJapNCYrsthov4irYC6OuejP5
         9hM+YxA5AaueYCMD4zeWjjNlXOBfZnVYQ2uWmvf1f+NDxMV6qvrwCf+KcpRCMQMa8ZCE
         m1TfsVcFiEMp0aBSFUEuWgLJyK/Y0foEPCAXtTzIV40Q0JAG2XYDsQV65pq2g7PAOQyk
         dhyBIz0iQRzG/AkqJ/SZD3LOixm9lVN9lzNRDSji+Xk3Sr1nNFGX7XUzQeZq1JD6igVJ
         ln9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=0asOvLyaIQidtaf+APJitxjeC5t6EzgqSyv0pg+UdAU=;
        b=hC658cq1TTPFeYIFsVYj+DjSE5BZyMKfuqmbqaiXvVEAg9/YzDAQpvKnMcWrDjBrFE
         I08FkgBBCzKEEc1ACHmDvWERbiw2pzHm8QU1qjxOoGKLDDo+CJw+HoV8tXGUcdwH869b
         eN2xrm3vuq6d0x9wIVi+goKvvqE7rC4RN7wfdLaJacogSY/7Vq7YpqLa+tUIweG+vba2
         D4ZIz0ikiNXuQM2SZZtGpxueiAHiAM7T+VeGf8OSrDzdsi+2nthMiQosNj7gse9XWqKB
         jD4WhgvbeLnww29mlNS+R5oTBTvxOYmYmy0+XxFvaxnpMidh4WkREDVWhlBd7VV8trZG
         AtVQ==
X-Gm-Message-State: AOAM531Dtu18ff2emunBliSAvz2Y+CJ5U/FAmApL6/zqh5meSObQ2f+Y
        XtIjkj6A6b9QgXnHot7V8m4Sv1CwBejve8g=
X-Google-Smtp-Source: ABdhPJzyvV1I7IuAvJ14k/hSlbEmdhT+ANufpfkpujJTOMmzp36i4I++jCbNBHsDaNuXpEOWS8uMtCp298nZWho=
X-Received: from ramjiyani.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2edd])
 (user=ramjiyani job=sendgmr) by 2002:a25:acd1:: with SMTP id
 x17mr8429840ybd.51.1632858313987; Tue, 28 Sep 2021 12:45:13 -0700 (PDT)
Date:   Tue, 28 Sep 2021 19:45:08 +0000
Message-Id: <20210928194509.4133465-1-ramjiyani@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
Subject: [RESEND PATCH] aio: Add support for the POLLFREE
From:   Ramji Jiyani <ramjiyani@google.com>
To:     Benjamin LaHaise <bcrl@kvack.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Ramji Jiyani <ramjiyani@google.com>, kernel-team@android.com,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Commit f5cb779ba163 ("ANDROID: binder: remove waitqueue when thread
exits.") fixed the use-after-free in eventpoll but aio still has the
same issue because it doesn't honor the POLLFREE flag.

Add support for the POLLFREE flag to force complete iocb inline in
aio_poll_wake(). A thread may use it to signal it's exit and/or request
to cleanup while pending poll request. In this case, aio_poll_wake()
needs to make sure it doesn't keep any reference to the queue entry
before returning from wake to avoid possible use after free via
poll_cancel() path.

The POLLFREE flag is no more exclusive to the epoll and is being
shared with the aio. Remove comment from poll.h to avoid confusion.
Also enclosed the POLLFREE macro definition in parentheses to fix
checkpatch error.

Signed-off-by: Ramji Jiyani <ramjiyani@google.com>
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
index 41b509f410bf..35b1b69af729 100644
--- a/include/uapi/asm-generic/poll.h
+++ b/include/uapi/asm-generic/poll.h
@@ -29,7 +29,7 @@
 #define POLLRDHUP       0x2000
 #endif
 
-#define POLLFREE	(__force __poll_t)0x4000	/* currently only for epoll */
+#define POLLFREE	((__force __poll_t)0x4000)
 
 #define POLL_BUSY_LOOP	(__force __poll_t)0x8000
 
-- 
2.33.0.685.g46640cef36-goog

