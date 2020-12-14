Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE9702DA013
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Dec 2020 20:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438061AbgLNTOq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Dec 2020 14:14:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440528AbgLNTOT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Dec 2020 14:14:19 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F2DC06179C
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Dec 2020 11:13:38 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id p187so17994240iod.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Dec 2020 11:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TMZPnAjXizjL/GC4e0rRBbgTIwmRcqkOa9SMMz0fkM0=;
        b=Z06/gjqN7oYySiwQGKhtiiKTNcV0dZ6yEdjyWSBHsL7wAchVf0CFhYboSHB66AuKsS
         6Lp1z9d+yaQ+ly+phdjzsIwCM5xxNB6bq5BLk+wPWvUsc4iHlFAL6ardgKliKdLDsyk3
         f9zHh5H7jOIn/3uHP4OOoYjeD265AyAY0ZiCEiNCJhYqMXcp9IjqCqFG5eucn/CKDVwc
         PS8skOsdKgjhfLSzlmnQggtHxioLnY7zPZrZr9Yx/OO/blvc8xgthVNcym94JDd7/9kL
         YhW2BmdhNDlNo9BEEHvz5SxmMIgfFsVUU+mDAy3pgsyc5n7ETM/yP4Fk67i2x14jhbNt
         c0aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TMZPnAjXizjL/GC4e0rRBbgTIwmRcqkOa9SMMz0fkM0=;
        b=MuVM7XlNGQ5QRuqNEAHFKx6M8AouN6rAIZ5Iy1zfCD/Nor7Tq8sI6XBqRMHA7hcE5G
         xVObO5AFShwW5QnaLYlUC8qSSgMhB1Un/30TI7rk8qrT0sAoszGNxTrG/X0MhYT1U/qY
         Ni6CXvJ3qnwm3WIK1Brz4sMSXZQ/qK4pcu0n7XH0BWEK8M825IzqszcvyPruw2S7Da9J
         CcE2mXZQRHkuNSbb0gFklprwaAF3+UmFmg6YiKmAf8IHH/xtjwkZZhTHJ2GLqVJEAMfC
         saooqYZV9vyt2tLsILs/8d2EVqh28i74so6JtRH6i3Gtc9CEGECKOVoGKO0ywb/ftTD3
         TRTg==
X-Gm-Message-State: AOAM532y+bEosFNBrhKTxJQAVM31YLecBPaPV4izcyfTfMuBMT2tJwwz
        vx95iJaR4pizRnWjri9TYIiIG4LWDUk/XA==
X-Google-Smtp-Source: ABdhPJxyC0vd/4UjsF/H7s+udDRBJKpBXKBK5C7FTl/GOPoU97395XUKsKm2rv3WfXYccWI2sUJtFw==
X-Received: by 2002:a05:6602:2110:: with SMTP id x16mr31702738iox.127.1607973218086;
        Mon, 14 Dec 2020 11:13:38 -0800 (PST)
Received: from p1.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id 11sm11760566ilt.54.2020.12.14.11.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 11:13:37 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4/4] io_uring: enable LOOKUP_NONBLOCK path resolution for filename lookups
Date:   Mon, 14 Dec 2020 12:13:24 -0700
Message-Id: <20201214191323.173773-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201214191323.173773-1-axboe@kernel.dk>
References: <20201214191323.173773-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Instead of being pessimistic and assume that path lookup will block, use
LOOKUP_NONBLOCK to attempt just a cached lookup. This ensures that the
fast path is always done inline, and we only punt to async context if
IO is needed to satisfy the lookup.

For forced nonblock open attempts, mark the file O_NONBLOCK over the
actual ->open() call as well. We can safely clear this again before
doing fd_install(), so it'll never be user visible that we fiddled with
it.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 44 ++++++++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 9d7baf8ba77a..6734a2616990 100644
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
@@ -3998,7 +3997,6 @@ static int __io_openat_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe
 		return ret;
 	}
 	req->open.nofile = rlimit(RLIMIT_NOFILE);
-	req->open.ignore_nonblock = false;
 	req->flags |= REQ_F_NEED_CLEANUP;
 	return 0;
 }
@@ -4040,39 +4038,45 @@ static int io_openat2(struct io_kiocb *req, bool force_nonblock)
 {
 	struct open_flags op;
 	struct file *file;
+	bool nonblock_set;
 	int ret;
 
-	if (force_nonblock && !req->open.ignore_nonblock)
-		return -EAGAIN;
-
 	ret = build_open_flags(&req->open.how, &op);
 	if (ret)
 		goto err;
+	nonblock_set = op.open_flag & O_NONBLOCK;
+	if (force_nonblock) {
+		/*
+		 * Don't bother trying for O_TRUNC or O_CREAT open, it'll
+		 * always -EAGAIN
+		 */
+		if (req->open.how.flags & (O_TRUNC | O_CREAT))
+			return -EAGAIN;
+		op.lookup_flags |= LOOKUP_NONBLOCK;
+		op.open_flag |= O_NONBLOCK;
+	}
 
 	ret = __get_unused_fd_flags(req->open.how.flags, req->open.nofile);
 	if (ret < 0)
 		goto err;
 
 	file = do_filp_open(req->open.dfd, req->open.filename, &op);
+	if (force_nonblock && file == ERR_PTR(-EAGAIN)) {
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

