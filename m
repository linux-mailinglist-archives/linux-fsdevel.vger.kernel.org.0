Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72D4E132C81
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2020 18:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbgAGRGH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jan 2020 12:06:07 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:38086 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728436AbgAGRGH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jan 2020 12:06:07 -0500
Received: by mail-io1-f66.google.com with SMTP id v3so72141ioj.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jan 2020 09:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e2VHGTRGbmT0TWCqccSNO5YDmbgFqBHce+/l36ATDhQ=;
        b=q5C6VJ0UUVYvINzJQUaoKposktE8cI5jaMr2FFoLsejPr/1muAnvyjLmdD5PNrYHY7
         isLu9Ev3pvjG/5jLnw7RG7mQYIJYkinRt1ecHV2NWSInz82JLYoEQW4Oqb0rMRt8KLG/
         ZgcVFo/oYRcArUu80xD+AYw4ka9sgs/2nFHsey/A12cEBQk9ZJFO6WwgK80Wwb6Jo2sS
         I+RTplXRgbFVM9HMm7oiCbYXgUPxERa0LrVSs7d0Zt3HxdKHk7ANVmIDvU+jn9iMrHoh
         qMJSealaz27Tk048X5pzjsNUTLHvyNJ6sRxySSiLvavEs4jfADwsY0fp9TZm66BDUgN8
         csFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e2VHGTRGbmT0TWCqccSNO5YDmbgFqBHce+/l36ATDhQ=;
        b=a3hzxsrWkaGrMq9yHhfJoEZhd9924IqegyQ8DkOuRAxdgtjmfC5VGBKro3aAc4pQ/t
         6PaFmfdOdbUJDaFbyVBr1U3S0anGL3jkdWlYqEGgvBhS2tcVJo89O76gopCUBQgwBKLI
         Z9N1NSLImoXVpVHU3ja+kOctwiufa5Na+XXOBCu82R9RRhgVxU5y0s11gxsfZU6IUJLG
         GE/PPVH4/5yivXuLXT4UNTn4mNGrc8m+5eSwbpwXh89IAQ9ze4uh6jd+BDwS5Yq8bALn
         laTFOyQ7sd/QY5Ei8gDLTUFq3Loy91OPk7O311U7UVSMd3Z64uPfyghOv/KZHNzkZ9fO
         7Azw==
X-Gm-Message-State: APjAAAXc8G3KpGpxI14pmWIatmBBV11H6fJBMX/dsyJ8cu6DTrbq2KXE
        IvXZys3VNbdptHOVXD19qOEQ3nPhNDI=
X-Google-Smtp-Source: APXvYqwvejYKHFGGfnbzjK5C2OFjxIavk/sSD4Kj/XXLGpUvMTIDiA95R1oMqudCNzB0lpiPf5XVpQ==
X-Received: by 2002:a6b:f214:: with SMTP id q20mr37477624ioh.137.1578416440746;
        Tue, 07 Jan 2020 09:00:40 -0800 (PST)
Received: from x1.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id g4sm42547iln.81.2020.01.07.09.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 09:00:40 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5/6] io-wq: add support for uncancellable work
Date:   Tue,  7 Jan 2020 10:00:33 -0700
Message-Id: <20200107170034.16165-6-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107170034.16165-1-axboe@kernel.dk>
References: <20200107170034.16165-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Not all work can be cancelled, some of it we may need to guarantee
that it runs to completion. Allow the caller to set IO_WQ_WORK_NO_CANCEL
on work that must not be cancelled. Note that the caller work function
must also check for IO_WQ_WORK_NO_CANCEL on work that is marked
IO_WQ_WORK_CANCEL.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io-wq.c    | 8 +++++++-
 fs/io-wq.h    | 1 +
 fs/io_uring.c | 5 ++++-
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/io-wq.c b/fs/io-wq.c
index 541c8a3e0bbb..2f94170eeb89 100644
--- a/fs/io-wq.c
+++ b/fs/io-wq.c
@@ -452,6 +452,10 @@ static void io_worker_handle_work(struct io_worker *worker)
 		}
 		if (!worker->creds)
 			worker->creds = override_creds(wq->creds);
+		/*
+		 * OK to set IO_WQ_WORK_CANCEL even for uncancellable work,
+		 * the worker function will do the right thing.
+		 */
 		if (test_bit(IO_WQ_BIT_CANCEL, &wq->state))
 			work->flags |= IO_WQ_WORK_CANCEL;
 		if (worker->mm)
@@ -824,6 +828,7 @@ static bool io_work_cancel(struct io_worker *worker, void *cancel_data)
 	 */
 	spin_lock_irqsave(&worker->lock, flags);
 	if (worker->cur_work &&
+	    !(worker->cur_work->flags & IO_WQ_WORK_NO_CANCEL) &&
 	    data->cancel(worker->cur_work, data->caller_data)) {
 		send_sig(SIGINT, worker->task, 1);
 		ret = true;
@@ -898,7 +903,8 @@ static bool io_wq_worker_cancel(struct io_worker *worker, void *data)
 		return false;
 
 	spin_lock_irqsave(&worker->lock, flags);
-	if (worker->cur_work == work) {
+	if (worker->cur_work == work &&
+	    !(worker->cur_work->flags & IO_WQ_WORK_NO_CANCEL)) {
 		send_sig(SIGINT, worker->task, 1);
 		ret = true;
 	}
diff --git a/fs/io-wq.h b/fs/io-wq.h
index 3f5e356de980..04d60ad38dfc 100644
--- a/fs/io-wq.h
+++ b/fs/io-wq.h
@@ -12,6 +12,7 @@ enum {
 	IO_WQ_WORK_UNBOUND	= 32,
 	IO_WQ_WORK_INTERNAL	= 64,
 	IO_WQ_WORK_CB		= 128,
+	IO_WQ_WORK_NO_CANCEL	= 256,
 
 	IO_WQ_HASH_SHIFT	= 24,	/* upper 8 bits are used for hash key */
 };
diff --git a/fs/io_uring.c b/fs/io_uring.c
index 53ff67ab5c4b..e12b1545468d 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -3457,8 +3457,11 @@ static void io_wq_submit_work(struct io_wq_work **workptr)
 	struct io_kiocb *nxt = NULL;
 	int ret = 0;
 
-	if (work->flags & IO_WQ_WORK_CANCEL)
+	/* if NO_CANCEL is set, we must still run the work */
+	if ((work->flags & (IO_WQ_WORK_CANCEL|IO_WQ_WORK_NO_CANCEL)) ==
+				IO_WQ_WORK_CANCEL) {
 		ret = -ECANCELED;
+	}
 
 	if (!ret) {
 		req->has_user = (work->flags & IO_WQ_WORK_HAS_MM) != 0;
-- 
2.24.1

