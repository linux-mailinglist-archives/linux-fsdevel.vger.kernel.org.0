Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF24B12AF1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2019 11:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbfECJrT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 May 2019 05:47:19 -0400
Received: from mail.stbuehler.de ([5.9.32.208]:42206 "EHLO mail.stbuehler.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726681AbfECJrT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 May 2019 05:47:19 -0400
Received: from chromobil.fritz.box (unknown [IPv6:2a02:8070:a29c:5000:823f:5dff:fe0f:b5b6])
        by mail.stbuehler.de (Postfix) with ESMTPSA id 0CD33C007E8;
        Fri,  3 May 2019 09:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=stbuehler.de;
        s=stbuehler1; t=1556876836;
        bh=HNNhAZo5XVrEo+Uqw618pAuMsJsK5ZN2WxF8rpFqaWU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=QM3GQxN4cWeLETVrDHadaXOpobocuozHgTTYBEHRxWyX9UEE3bCoxBefVrLSTHm8R
         V4pD9YcV/tw1BzQWw0NRXdcyM9vt67W7yer6zvlQdKb4yORBbb8WvBJRSfsKJffkOr
         kVz7i/+wqCX8c6rA1XL3AfAH9vTx+7Sw9mgCkLSE=
From:   =?UTF-8?q?Stefan=20B=C3=BChler?= <source@stbuehler.de>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2] io_uring: restructure io_{read,write} control flow
Date:   Fri,  3 May 2019 11:47:14 +0200
Message-Id: <20190503094715.2381-1-source@stbuehler.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <37071226-375a-07a6-d3d3-21323145de71@kernel.dk>
References: <37071226-375a-07a6-d3d3-21323145de71@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Call io_async_list_note at the end if -EAGAIN is going to be returned;
we need iov_count for that, which we have (almost) at the same time as
we need to free iovec.

Instead of using a second return value reset the normal one after
passing it to io_rw_done.

Unless rw_verify_area returns -EAGAIN this shouldn't result in different
behavior.

This change should make it easier to punt a request to the workers by
returning -EAGAIN and still calling io_async_list_note if needed.

Signed-off-by: Stefan Bühler <source@stbuehler.de>
---
 fs/io_uring.c | 89 ++++++++++++++++++++++-----------------------------
 1 file changed, 39 insertions(+), 50 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 84efb8956734..52e435a72b6f 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1062,26 +1062,24 @@ static int io_read(struct io_kiocb *req, const struct sqe_submit *s,
 	ret = io_import_iovec(req->ctx, READ, s, &iovec, &iter);
 	if (ret)
 		return ret;
-
 	iov_count = iov_iter_count(&iter);
+
 	ret = rw_verify_area(READ, file, &kiocb->ki_pos, iov_count);
-	if (!ret) {
-		ssize_t ret2;
+	if (ret)
+		goto out_free;
 
-		/* Catch -EAGAIN return for forced non-blocking submission */
-		ret2 = call_read_iter(file, kiocb, &iter);
-		if (!force_nonblock || ret2 != -EAGAIN) {
-			io_rw_done(kiocb, ret2);
-		} else {
-			/*
-			 * If ->needs_lock is true, we're already in async
-			 * context.
-			 */
-			if (!s->needs_lock)
-				io_async_list_note(READ, req, iov_count);
-			ret = -EAGAIN;
-		}
+	/* Passthrough -EAGAIN return for forced non-blocking submission */
+	ret = call_read_iter(file, kiocb, &iter);
+	if (!(force_nonblock && ret == -EAGAIN)) {
+		io_rw_done(kiocb, ret);
+		ret = 0;
 	}
+
+out_free:
+	/* If ->needs_lock is true, we're already in async context. */
+	if (ret == -EAGAIN && !s->needs_lock)
+		io_async_list_note(READ, req, iov_count);
+
 	kfree(iovec);
 	return ret;
 }
@@ -1109,50 +1107,41 @@ static int io_write(struct io_kiocb *req, const struct sqe_submit *s,
 	ret = io_import_iovec(req->ctx, WRITE, s, &iovec, &iter);
 	if (ret)
 		return ret;
-
 	iov_count = iov_iter_count(&iter);
 
 	ret = -EAGAIN;
-	if (force_nonblock && !(kiocb->ki_flags & IOCB_DIRECT)) {
-		/* If ->needs_lock is true, we're already in async context. */
-		if (!s->needs_lock)
-			io_async_list_note(WRITE, req, iov_count);
+	if (force_nonblock && !(kiocb->ki_flags & IOCB_DIRECT))
 		goto out_free;
-	}
 
 	ret = rw_verify_area(WRITE, file, &kiocb->ki_pos, iov_count);
-	if (!ret) {
-		ssize_t ret2;
+	if (ret)
+		goto out_free;
 
-		/*
-		 * Open-code file_start_write here to grab freeze protection,
-		 * which will be released by another thread in
-		 * io_complete_rw().  Fool lockdep by telling it the lock got
-		 * released so that it doesn't complain about the held lock when
-		 * we return to userspace.
-		 */
-		if (S_ISREG(file_inode(file)->i_mode)) {
-			__sb_start_write(file_inode(file)->i_sb,
-						SB_FREEZE_WRITE, true);
-			__sb_writers_release(file_inode(file)->i_sb,
-						SB_FREEZE_WRITE);
-		}
-		kiocb->ki_flags |= IOCB_WRITE;
+	/*
+	 * Open-code file_start_write here to grab freeze protection,
+	 * which will be released by another thread in
+	 * io_complete_rw().  Fool lockdep by telling it the lock got
+	 * released so that it doesn't complain about the held lock when
+	 * we return to userspace.
+	 */
+	if (S_ISREG(file_inode(file)->i_mode)) {
+		__sb_start_write(file_inode(file)->i_sb, SB_FREEZE_WRITE, true);
+		__sb_writers_release(file_inode(file)->i_sb, SB_FREEZE_WRITE);
+	}
+	kiocb->ki_flags |= IOCB_WRITE;
 
-		ret2 = call_write_iter(file, kiocb, &iter);
-		if (!force_nonblock || ret2 != -EAGAIN) {
-			io_rw_done(kiocb, ret2);
-		} else {
-			/*
-			 * If ->needs_lock is true, we're already in async
-			 * context.
-			 */
-			if (!s->needs_lock)
-				io_async_list_note(WRITE, req, iov_count);
-			ret = -EAGAIN;
-		}
+	/* Passthrough -EAGAIN return for forced non-blocking submission */
+	ret = call_write_iter(file, kiocb, &iter);
+	if (!(force_nonblock && ret == -EAGAIN)) {
+		io_rw_done(kiocb, ret);
+		ret = 0;
 	}
+
 out_free:
+	/* If ->needs_lock is true, we're already in async context. */
+	if (ret == -EAGAIN && !s->needs_lock)
+		io_async_list_note(WRITE, req, iov_count);
+
 	kfree(iovec);
 	return ret;
 }
-- 
2.20.1

