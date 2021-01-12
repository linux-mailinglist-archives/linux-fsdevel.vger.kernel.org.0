Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31C722F2404
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 01:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbhALAci (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 19:32:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbhALAbI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 19:31:08 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346A6C0617A2;
        Mon, 11 Jan 2021 16:30:28 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id v3so1220621ilo.5;
        Mon, 11 Jan 2021 16:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e85jGa4l7Ltpm4J5B4ttRB7c3u6YAvgPMu6mhyi+DSY=;
        b=vhppCzJeoOG642HV7mKXuPYQnMIDxj83Oei9LxecFI5l+zQa3c0Imccad4Ac3REk9a
         XQvTApPuhJG09yGAOeDT/lhD970Z4GbKH450BzvW9Q3dfxNErNhOuiMMo5RuluJrTzWf
         cGvQCoXV6Kb+7OOE59oOCA4lSKnVke4EWqycx5d5OfdieeiJQsx68w8cMqivkYDH5BzN
         GO/sINuJweTkFKX91yv5YPWTF3JnnRS1mLv+tTVkGZAI0QL04dHYXKJrjPUI1b6i0osn
         dyDqBDTZvmH6ZMSrQTJb0Pa4BMJoPEwJvd9PFm6yDY8jOSD2kU2HXmmOIe00gTORM0jY
         cUHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e85jGa4l7Ltpm4J5B4ttRB7c3u6YAvgPMu6mhyi+DSY=;
        b=eZVA/gESWTA5JcaQJOsWHpFl7OLZcHFDyTsSKJezO79UKu0CqhvjjTZDUOlfeJMQyg
         //OP3KXDQ/v8LnFCXATCpyxhqbcLcO11MZBEO8+Rt+Db09qZjmT5HsVt1D5fXlZ7X9OI
         Of/RI0ZeMLmQjQ03SZYbZC76cZeX2DQGE62JSkxW4OOpPShHWWQeAl5FbxKvd0kHa+/s
         mA6Mv1oLEo8cfJQZJw+6Iwc/ZzrpUFghR7Cif0/HCJCugbVG/wvlo2R4kJbQBsNMkqgE
         2/GdyzItxZx8gbt7h6YIuVjEfFSNytJz1FQ7SFeONodEjMS8M54L8en1VIy/OCrnOdnl
         JsHw==
X-Gm-Message-State: AOAM530/wdXYkSaA3Jbu9aO7VHqcBS0SIKoQ7HO7y/gJbkxmNMTDM3qJ
        226bt/bTlfCRwM6yKxxOtqgW39jcs70=
X-Google-Smtp-Source: ABdhPJy4j0pcFI0rW4p5IWzBMmcZ3A1rycMAHBZE/RMwRmcumYpng0XuMrsbSF879zvIMOvZCVhxHQ==
X-Received: by 2002:a92:6a0c:: with SMTP id f12mr606003ilc.122.1610411427282;
        Mon, 11 Jan 2021 16:30:27 -0800 (PST)
Received: from willemb.nyc.corp.google.com ([2620:0:1003:312:f693:9fff:fef4:3e8a])
        by smtp.gmail.com with ESMTPSA id z10sm741723ioi.47.2021.01.11.16.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 16:30:26 -0800 (PST)
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, willy@infradead.org, arnd@kernel.org,
        Willem de Bruijn <willemb@google.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5/6] compat: add set_maybe_compat_user_sigmask helper
Date:   Mon, 11 Jan 2021 19:30:16 -0500
Message-Id: <20210112003017.4010304-6-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
In-Reply-To: <20210112003017.4010304-1-willemdebruijn.kernel@gmail.com>
References: <20210112003017.4010304-1-willemdebruijn.kernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Willem de Bruijn <willemb@google.com>

Deduplicate the open coded branch on sigmask compat handling.

Signed-off-by: Willem de Bruijn <willemb@google.com>
Cc: Jens Axboe <axboe@kernel.dk>
---
 fs/eventpoll.c         |  5 +----
 fs/io_uring.c          |  9 +--------
 fs/select.c            | 10 ++--------
 include/linux/compat.h | 10 ++++++++++
 4 files changed, 14 insertions(+), 20 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index c9dcffba2da1..c011327c8402 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -2247,10 +2247,7 @@ static int do_epoll_pwait(int epfd, struct epoll_event __user *events,
 	 * If the caller wants a certain signal mask to be set during the wait,
 	 * we apply it here.
 	 */
-	if (!in_compat_syscall())
-		error = set_user_sigmask(sigmask, sigsetsize);
-	else
-		error = set_compat_user_sigmask(sigmask, sigsetsize);
+	error = set_maybe_compat_user_sigmask(sigmask, sigsetsize);
 	if (error)
 		return error;
 
diff --git a/fs/io_uring.c b/fs/io_uring.c
index fdc923e53873..abc88bc738ce 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -7190,14 +7190,7 @@ static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events,
 	} while (1);
 
 	if (sig) {
-#ifdef CONFIG_COMPAT
-		if (in_compat_syscall())
-			ret = set_compat_user_sigmask((const compat_sigset_t __user *)sig,
-						      sigsz);
-		else
-#endif
-			ret = set_user_sigmask(sig, sigsz);
-
+		ret = set_maybe_compat_user_sigmask(sig, sigsz);
 		if (ret)
 			return ret;
 	}
diff --git a/fs/select.c b/fs/select.c
index 27567795a892..c013662bbf51 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -773,10 +773,7 @@ static long do_pselect(int n, fd_set __user *inp, fd_set __user *outp,
 			return -EINVAL;
 	}
 
-	if (!in_compat_syscall())
-		ret = set_user_sigmask(sigmask, sigsetsize);
-	else
-		ret = set_compat_user_sigmask(sigmask, sigsetsize);
+	ret = set_maybe_compat_user_sigmask(sigmask, sigsetsize);
 	if (ret)
 		return ret;
 
@@ -1146,10 +1143,7 @@ static int do_ppoll(struct pollfd __user *ufds, unsigned int nfds,
 			return -EINVAL;
 	}
 
-	if (!in_compat_syscall())
-		ret = set_user_sigmask(sigmask, sigsetsize);
-	else
-		ret = set_compat_user_sigmask(sigmask, sigsetsize);
+	ret = set_maybe_compat_user_sigmask(sigmask, sigsetsize);
 	if (ret)
 		return ret;
 
diff --git a/include/linux/compat.h b/include/linux/compat.h
index 6e65be753603..4a9b740496b4 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -18,6 +18,7 @@
 #include <linux/aio_abi.h>	/* for aio_context_t */
 #include <linux/uaccess.h>
 #include <linux/unistd.h>
+#include <linux/sched/signal.h>
 
 #include <asm/compat.h>
 
@@ -942,6 +943,15 @@ static inline bool in_compat_syscall(void) { return false; }
 
 #endif /* CONFIG_COMPAT */
 
+static inline int set_maybe_compat_user_sigmask(const void __user *umask,
+						size_t sigsetsize)
+{
+	if (!in_compat_syscall())
+		return set_user_sigmask(umask, sigsetsize);
+	else
+		return set_compat_user_sigmask(umask, sigsetsize);
+}
+
 /*
  * Some legacy ABIs like the i386 one use less than natural alignment for 64-bit
  * types, and will need special compat treatment for that.  Most architectures
-- 
2.30.0.284.gd98b1dd5eaa7-goog

