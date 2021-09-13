Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19DD4409C62
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Sep 2021 20:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238241AbhIMSjW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Sep 2021 14:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241450AbhIMSjV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Sep 2021 14:39:21 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB829C061760
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Sep 2021 11:38:05 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id w10-20020a170903310a00b0013a74038765so3581517plc.22
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Sep 2021 11:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ORusbr9BmjXcPtqf7j3wkWSVtlEx7sQaXqjNFhLLsiA=;
        b=Uxvo/AAaVm/TrsvJp2gPNfsdMAsdNAIFJblX2JLeH8VzGnDWWDFSFoA9yWUkSSpMiz
         cGjKsie76v7gq+aIUvGk1bAoiZcDZQj8NQMlSNL6WGp60sBlfLD8FFHehC1QkZ7n/cv9
         PT0kSVMrvv3dHZPO/o8Io+O2gZZTfKgfls4OVc22DWixMDPGZAqRdlFDNet11tfAs7e/
         +4BNQQ2J7H5VMxHr4pQEGJ7ClSfgfoxNGYKCP4n61HRZ8AKVqUg6NB6Iw+a55vNnA1ny
         VdH7D84V1kTI01XOVAgWHojt+9WSLUB2aiI/aliBL3hdIgK4TRKRr3uUHHeQNchu9Qal
         MoZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ORusbr9BmjXcPtqf7j3wkWSVtlEx7sQaXqjNFhLLsiA=;
        b=K06d3bmovSetsg+xdlh52rN00KN/hJjOapgbM5TUg5b7jHOryfCFn6SiY+sIxXo9Jg
         AvWvUh4JqSBxbJTLGmunEGvupES200ziQJCl3PMJxnK75cBwfoXdhJ3pW3yx1YGP5f2l
         9EA/gziEZP7kEaTTn07KV2Cx4do2Cuk1L1aHxUIDYU+XH1V2sjhunYVQ84WYc5HIRyDK
         0y8VO8Fru17FkeQDNUjIxHoFvf9f49qdnUoUd/YabjvC09QhgPUCE8dKS220WE8iJA4Q
         Q7RaVcgmklHQw8UKyAUSXokeoD1xbVxSEhObjxpofIhLaHVPybT9WAM4kiB5PZ+rDjSu
         N6rw==
X-Gm-Message-State: AOAM532FpP6gxZT6yzIoEecCHd/xECnFC0SfAWlE4Pucjx3ew7Q8Vz4P
        YMolpnsRX2Zyr7ceiiG28JRar3RvhnvA+ac=
X-Google-Smtp-Source: ABdhPJyjtH0D7FayRsBKsENe5kjIx+9tqfBFSgR2CE2IKyePXWGrlsCUJovbx0HZTl6n38vb3KkdnSnzJdwn0u0=
X-Received: from ramjiyani.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2edd])
 (user=ramjiyani job=sendgmr) by 2002:a17:90a:7f04:: with SMTP id
 k4mr1046505pjl.0.1631558284830; Mon, 13 Sep 2021 11:38:04 -0700 (PDT)
Date:   Mon, 13 Sep 2021 18:37:52 +0000
Message-Id: <20210913183753.563103-1-ramjiyani@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH] aio: Add support for the POLLFREE
From:   Ramji Jiyani <ramjiyani@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Benjamin LaHaise <bcrl@kvack.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Ramji Jiyani <ramjiyani@google.com>, kernel-team@android.com,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
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
2.33.0.309.g3052b89438-goog

