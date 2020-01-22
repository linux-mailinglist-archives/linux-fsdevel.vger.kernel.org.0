Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80A6D145A0F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2020 17:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbgAVQmt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jan 2020 11:42:49 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:37975 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgAVQms (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jan 2020 11:42:48 -0500
Received: by mail-io1-f65.google.com with SMTP id i7so7284219ioo.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jan 2020 08:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RfiRzl729pSQkcVcyHTXNJXLD8uT/Zh0KX5h0rH8OOE=;
        b=Vtu+Oq5gEAO9RZ0XdxLepwTDRsT+4l7hnqDjoUlOnBJhyJQeZDk9ysQkmuahDdl7V9
         DTWL5O4OWPfwccVKZhdwTLs96FprFEYcUuaBoYVGr/K0M/zwRgn8b37r3VSK2vGHRpvm
         x66UPSrgUxYd+vJAkvBrV0YKJ68s/W2TPBbkKV2i/ti2N2WKqTFt4B7YQkBrkMCRtl+C
         U8Qp4SapIKKw2FqIQjDqLt0c5ufvTqAll+btDUpAyBhR0zhf6ctW5mUoAjhnMyhJP0n3
         pIJw1uAFPf6Ff6hQ2bbhBCYWmwUml2Ofdtz8QugF4ToaqKGFSyHfsEHI4RfuFdgcUJl4
         RtJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RfiRzl729pSQkcVcyHTXNJXLD8uT/Zh0KX5h0rH8OOE=;
        b=IUgoy5bhnbQlAWTbzTu8T6FRp4T1a5v5TV5mp05JkDZMkCgvC/PQLLkwNCRAO1ctm3
         NuLis5BYSt717RvCN1eDzA2hUMXZjz+1qnlXL7dQcG+b0ITB6gkbLfap1Vu174YV10PA
         9V3KsbJa0Qe6cI03MSuKzjMY1MHK2LWhTKN2GXz8F4Ij49rm8FxiKFPjX3xuY+XU2xh5
         F53ObNdOjnhsfY3JfMTFWWaHDZVxXRlO8Fjbssndne6oipYtlI4taTv2A9hvQPTItqqO
         ixpmbw6eD7Rn7hcMfPL2NJWenK7e0eVbYDW3ufG9Sel6RhOMUAQAYJnwx6GoYXO0bVJG
         9LtQ==
X-Gm-Message-State: APjAAAUHQjmt0189yehbU9oYnOz5rzSxKMlK3zxfsELYn4ad+vwpLYI6
        hCc1qh9SZvHpB4vze2JFQRZaHKO0ajI=
X-Google-Smtp-Source: APXvYqwyFd9pcByXHyotx2H96fZrn/peNcW0PRxTpuSU/TvG3mekjSSzF3Qnbe3qbIo7g6Xv2ADQ+A==
X-Received: by 2002:a5d:9805:: with SMTP id a5mr3425782iol.80.1579711367872;
        Wed, 22 Jan 2020 08:42:47 -0800 (PST)
Received: from x1.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id o6sm14599681ilc.76.2020.01.22.08.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 08:42:47 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, jannh@google.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/3] eventpoll: abstract out epoll_ctl() handler
Date:   Wed, 22 Jan 2020 09:42:42 -0700
Message-Id: <20200122164244.27799-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122164244.27799-1-axboe@kernel.dk>
References: <20200122164244.27799-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

No functional changes in this patch.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/eventpoll.c | 45 +++++++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 67a395039268..cd848e8d08e2 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -2074,27 +2074,15 @@ SYSCALL_DEFINE1(epoll_create, int, size)
 	return do_epoll_create(0);
 }
 
-/*
- * The following function implements the controller interface for
- * the eventpoll file that enables the insertion/removal/change of
- * file descriptors inside the interest set.
- */
-SYSCALL_DEFINE4(epoll_ctl, int, epfd, int, op, int, fd,
-		struct epoll_event __user *, event)
+static int do_epoll_ctl(int epfd, int op, int fd, struct epoll_event *epds)
 {
 	int error;
 	int full_check = 0;
 	struct fd f, tf;
 	struct eventpoll *ep;
 	struct epitem *epi;
-	struct epoll_event epds;
 	struct eventpoll *tep = NULL;
 
-	error = -EFAULT;
-	if (ep_op_has_event(op) &&
-	    copy_from_user(&epds, event, sizeof(struct epoll_event)))
-		goto error_return;
-
 	error = -EBADF;
 	f = fdget(epfd);
 	if (!f.file)
@@ -2112,7 +2100,7 @@ SYSCALL_DEFINE4(epoll_ctl, int, epfd, int, op, int, fd,
 
 	/* Check if EPOLLWAKEUP is allowed */
 	if (ep_op_has_event(op))
-		ep_take_care_of_epollwakeup(&epds);
+		ep_take_care_of_epollwakeup(epds);
 
 	/*
 	 * We have to check that the file structure underneath the file descriptor
@@ -2128,11 +2116,11 @@ SYSCALL_DEFINE4(epoll_ctl, int, epfd, int, op, int, fd,
 	 * so EPOLLEXCLUSIVE is not allowed for a EPOLL_CTL_MOD operation.
 	 * Also, we do not currently supported nested exclusive wakeups.
 	 */
-	if (ep_op_has_event(op) && (epds.events & EPOLLEXCLUSIVE)) {
+	if (ep_op_has_event(op) && (epds->events & EPOLLEXCLUSIVE)) {
 		if (op == EPOLL_CTL_MOD)
 			goto error_tgt_fput;
 		if (op == EPOLL_CTL_ADD && (is_file_epoll(tf.file) ||
-				(epds.events & ~EPOLLEXCLUSIVE_OK_BITS)))
+				(epds->events & ~EPOLLEXCLUSIVE_OK_BITS)))
 			goto error_tgt_fput;
 	}
 
@@ -2192,8 +2180,8 @@ SYSCALL_DEFINE4(epoll_ctl, int, epfd, int, op, int, fd,
 	switch (op) {
 	case EPOLL_CTL_ADD:
 		if (!epi) {
-			epds.events |= EPOLLERR | EPOLLHUP;
-			error = ep_insert(ep, &epds, tf.file, fd, full_check);
+			epds->events |= EPOLLERR | EPOLLHUP;
+			error = ep_insert(ep, epds, tf.file, fd, full_check);
 		} else
 			error = -EEXIST;
 		if (full_check)
@@ -2208,8 +2196,8 @@ SYSCALL_DEFINE4(epoll_ctl, int, epfd, int, op, int, fd,
 	case EPOLL_CTL_MOD:
 		if (epi) {
 			if (!(epi->event.events & EPOLLEXCLUSIVE)) {
-				epds.events |= EPOLLERR | EPOLLHUP;
-				error = ep_modify(ep, epi, &epds);
+				epds->events |= EPOLLERR | EPOLLHUP;
+				error = ep_modify(ep, epi, epds);
 			}
 		} else
 			error = -ENOENT;
@@ -2231,6 +2219,23 @@ SYSCALL_DEFINE4(epoll_ctl, int, epfd, int, op, int, fd,
 	return error;
 }
 
+/*
+ * The following function implements the controller interface for
+ * the eventpoll file that enables the insertion/removal/change of
+ * file descriptors inside the interest set.
+ */
+SYSCALL_DEFINE4(epoll_ctl, int, epfd, int, op, int, fd,
+		struct epoll_event __user *, event)
+{
+	struct epoll_event epds;
+
+	if (ep_op_has_event(op) &&
+	    copy_from_user(&epds, event, sizeof(struct epoll_event)))
+		return -EFAULT;
+
+	return do_epoll_ctl(epfd, op, fd, &epds);
+}
+
 /*
  * Implement the event wait interface for the eventpoll file. It is the kernel
  * part of the user space epoll_wait(2).
-- 
2.25.0

