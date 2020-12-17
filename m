Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF662DD50E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Dec 2020 17:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbgLQQUB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Dec 2020 11:20:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728649AbgLQQUA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Dec 2020 11:20:00 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049D0C061282
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Dec 2020 08:19:20 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id g1so26354504ilk.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Dec 2020 08:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JTR3cI7lOqIwEx0cNt3QyNMnkPxMg2CNmpQoqv+u4Qw=;
        b=oxM2hMlKdpi+ZLxbEEvp3e+7RlQqMy/XIwtoI7pcp1Tl7Jj+Z8YvWOuNlf8f0wFpeC
         7SDMj/CaKlOoExGcjL/NIvivDOWTVHXLKm3AWiGm14oz5y9pdXTnA1zL8Drc2l4E9nr7
         18y+k9UAmGsif1sVIH5BWKn448eukUgeI0U1s4G45V+kxrW86rnk9TYEf1dgI8actg/L
         D6WfpCv/G7mPASADFYELJSf5/uHzx+MCJPZx9Jv1FgnsO3GJk186s2Zw8+Rbr1/xg2iC
         P1nnki9dKYmP/Kq4u/Rvy9greWvM51balrFwcsgQsLCVsU4oxvKJbuQVowJ2+gY8ONjv
         K+cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JTR3cI7lOqIwEx0cNt3QyNMnkPxMg2CNmpQoqv+u4Qw=;
        b=sR/8KzMfwc8eYGAeF30SUfd9P+aJUHtBuJQescfazLr9JsWLoyH9ynIUudUXk4ppLF
         r1juNvDHBM/1AuloQp4idyoZyRgRt8H9fR6EiMNVb0C3AblYxznGNru1bZJPv2YA8AU2
         3Nywtqyjl9Oa8oMJS61i4ag4RPb0gGVVWGdoG2Mc7Bx9m3FJ0k7Ze4oXmtDFsdCE5tIN
         hNYKnVnQ/EbU2qgY3DFgnGuFWeuCac49Bd2/BYoQy/zxjVzPg5dx8Ys5tvK0QUbhpKHd
         eOPXGhImnMklk140WeOhkxkfxZzLc97Hur0G9mAUW+WqpLCtsiQMkz1voPF0CPRoTyF3
         w8Kw==
X-Gm-Message-State: AOAM530X0Tj1OenP++T+DGiPb7lTKSrBVb+ZCQkc9PPGrgu2bd11lCCY
        mgdFTmBH/kXxEaHOvzDcJNtb/IVam95Y2A==
X-Google-Smtp-Source: ABdhPJwS+K1Fnt4Tq+UXt2nCghVMgr2UhsWmS6gaROsDvVAIl4/CBr5lbZY1XM4MUqzEzIzmLdX+wA==
X-Received: by 2002:a92:d0ca:: with SMTP id y10mr51278782ila.68.1608221959109;
        Thu, 17 Dec 2020 08:19:19 -0800 (PST)
Received: from p1.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k76sm3849957ilk.36.2020.12.17.08.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 08:19:18 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4/4] io_uring: enable LOOKUP_CACHED path resolution for filename lookups
Date:   Thu, 17 Dec 2020 09:19:11 -0700
Message-Id: <20201217161911.743222-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201217161911.743222-1-axboe@kernel.dk>
References: <20201217161911.743222-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Instead of being pessimistic and assume that path lookup will block, use
LOOKUP_CACHED to attempt just a cached lookup. This ensures that the
fast path is always done inline, and we only punt to async context if
IO is needed to satisfy the lookup.

For forced nonblock open attempts, mark the file O_NONBLOCK over the
actual ->open() call as well. We can safely clear this again before
doing fd_install(), so it'll never be user visible that we fiddled with
it.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 47 +++++++++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 20 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 6f9392c35eef..5a703c8a4521 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -487,7 +487,6 @@ struct io_sr_msg {
 struct io_open {
 	struct file			*file;
 	int				dfd;
-	bool				ignore_nonblock;
 	struct filename			*filename;
 	struct open_how			how;
 	unsigned long			nofile;
@@ -3996,7 +3995,6 @@ static int __io_openat_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe
 		return ret;
 	}
 	req->open.nofile = rlimit(RLIMIT_NOFILE);
-	req->open.ignore_nonblock = false;
 	req->flags |= REQ_F_NEED_CLEANUP;
 	return 0;
 }
@@ -4038,39 +4036,48 @@ static int io_openat2(struct io_kiocb *req, bool force_nonblock)
 {
 	struct open_flags op;
 	struct file *file;
+	bool nonblock_set;
+	bool resolve_nonblock;
 	int ret;
 
-	if (force_nonblock && !req->open.ignore_nonblock)
-		return -EAGAIN;
-
 	ret = build_open_flags(&req->open.how, &op);
 	if (ret)
 		goto err;
+	nonblock_set = op.open_flag & O_NONBLOCK;
+	resolve_nonblock = req->open.how.resolve & RESOLVE_CACHED;
+	if (force_nonblock) {
+		/*
+		 * Don't bother trying for O_TRUNC, O_CREAT, or O_TMPFILE open,
+		 * it'll always -EAGAIN
+		 */
+		if (req->open.how.flags & (O_TRUNC | O_CREAT | O_TMPFILE))
+			return -EAGAIN;
+		op.lookup_flags |= LOOKUP_CACHED;
+		op.open_flag |= O_NONBLOCK;
+	}
 
 	ret = __get_unused_fd_flags(req->open.how.flags, req->open.nofile);
 	if (ret < 0)
 		goto err;
 
 	file = do_filp_open(req->open.dfd, req->open.filename, &op);
+	/* only retry if RESOLVE_CACHED wasn't already set by application */
+	if ((!resolve_nonblock && force_nonblock) && file == ERR_PTR(-EAGAIN)) {
+		/*
+		 * We could hang on to this 'fd', but seems like marginal
+		 * gain for something that is now known to be a slower path.
+		 * So just put it, and we'll get a new one when we retry.
+		 */
+		put_unused_fd(ret);
+		return -EAGAIN;
+	}
+
 	if (IS_ERR(file)) {
 		put_unused_fd(ret);
 		ret = PTR_ERR(file);
-		/*
-		 * A work-around to ensure that /proc/self works that way
-		 * that it should - if we get -EOPNOTSUPP back, then assume
-		 * that proc_self_get_link() failed us because we're in async
-		 * context. We should be safe to retry this from the task
-		 * itself with force_nonblock == false set, as it should not
-		 * block on lookup. Would be nice to know this upfront and
-		 * avoid the async dance, but doesn't seem feasible.
-		 */
-		if (ret == -EOPNOTSUPP && io_wq_current_is_worker()) {
-			req->open.ignore_nonblock = true;
-			refcount_inc(&req->refs);
-			io_req_task_queue(req);
-			return 0;
-		}
 	} else {
+		if (force_nonblock && !nonblock_set)
+			file->f_flags &= ~O_NONBLOCK;
 		fsnotify_open(file);
 		fd_install(ret, file);
 	}
-- 
2.29.2

