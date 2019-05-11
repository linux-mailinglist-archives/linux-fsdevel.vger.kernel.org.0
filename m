Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F55A1A889
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2019 18:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbfEKQ5d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 May 2019 12:57:33 -0400
Received: from mail.stbuehler.de ([5.9.32.208]:54240 "EHLO mail.stbuehler.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728524AbfEKQ5b (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 May 2019 12:57:31 -0400
Received: from chromobil.fritz.box (unknown [IPv6:2a02:8070:a29c:5000:823f:5dff:fe0f:b5b6])
        by mail.stbuehler.de (Postfix) with ESMTPSA id 598B3C030C4;
        Sat, 11 May 2019 16:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=stbuehler.de;
        s=stbuehler1; t=1557593849;
        bh=MWXSBGxPaBW/HBIO9l9nup2qTJSSGAZJVidtIRfiMQ0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=HwCGi4ypIvMndly4XoW4wATu+dOxmlFQxV8388KTImdQ0/V6mwZv9b1raA/C7cLYE
         3DSGBiqUq8FsxNgpbPQRzCRYgOfkbG5J+Kh8n52deNce/d/jXo7T8Wgkjf/JwhLpwW
         la3NmUZcVD9eIQP7RCyXSIJyBs+jq+EN6XgOHUn8=
From:   =?UTF-8?q?Stefan=20B=C3=BChler?= <source@stbuehler.de>
To:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 5/5] io_uring: use FMODE_NOWAIT to detect files supporting IOCB_NOWAIT
Date:   Sat, 11 May 2019 18:57:27 +0200
Message-Id: <20190511165727.31599-5-source@stbuehler.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190511165727.31599-1-source@stbuehler.de>
References: <e2bf63a3-703b-9be2-c171-5dcc1797d2b1@stbuehler.de>
 <20190511165727.31599-1-source@stbuehler.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This replaces the magic check looking for S_ISBLK(mode) ||
S_ISCHR(mode); given the io_uring file doesn't support read/write the
check for io_uring_fops is useless anyway.

Signed-off-by: Stefan Bühler <source@stbuehler.de>
---
 fs/io_uring.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index e1c6ab63628f..396ce6804977 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -867,23 +867,6 @@ static struct file *io_file_get(struct io_submit_state *state, int fd)
 	return state->file;
 }
 
-/*
- * If we tracked the file through the SCM inflight mechanism, we could support
- * any file. For now, just ensure that anything potentially problematic is done
- * inline.
- */
-static bool io_file_supports_async(struct file *file)
-{
-	umode_t mode = file_inode(file)->i_mode;
-
-	if (S_ISBLK(mode) || S_ISCHR(mode))
-		return true;
-	if (S_ISREG(mode) && file->f_op != &io_uring_fops)
-		return true;
-
-	return false;
-}
-
 static int io_prep_rw(struct io_kiocb *req, const struct sqe_submit *s,
 		      bool force_nonblock)
 {
@@ -896,7 +879,13 @@ static int io_prep_rw(struct io_kiocb *req, const struct sqe_submit *s,
 	if (!req->file)
 		return -EBADF;
 
-	if (force_nonblock && !io_file_supports_async(req->file))
+	/*
+	 * don't set IOCB_NOWAIT if not supported (forces async punt)
+	 *
+	 * we don't punt if NOWAIT is not supported but requested as
+	 * kiocb_set_rw_flags will return EOPNOTSUPP
+	 */
+	if (force_nonblock && !(req->file->f_mode & FMODE_NOWAIT))
 		force_nonblock = false;
 
 	kiocb->ki_pos = READ_ONCE(sqe->off);
-- 
2.20.1

