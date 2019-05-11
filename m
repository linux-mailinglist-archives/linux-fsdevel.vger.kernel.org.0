Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 265161A88D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2019 18:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbfEKQ5b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 May 2019 12:57:31 -0400
Received: from mail.stbuehler.de ([5.9.32.208]:54220 "EHLO mail.stbuehler.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727047AbfEKQ5a (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 May 2019 12:57:30 -0400
Received: from chromobil.fritz.box (unknown [IPv6:2a02:8070:a29c:5000:823f:5dff:fe0f:b5b6])
        by mail.stbuehler.de (Postfix) with ESMTPSA id A853BC030C0;
        Sat, 11 May 2019 16:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=stbuehler.de;
        s=stbuehler1; t=1557593848;
        bh=CMEz/QIJbaTDIQoqKRDXXFv3bSR004q+JIkQB31NCVQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=S1Y8gyJMi2pLIKmlc/ox042/DXlGILxJCmuOdmDLaYdZ26u5W3jXN93yvXBUVbMwF
         kbZJo5X1v6RUgeEWPMoksq2TkIJdpX7sTTOZK7LmpAvq60jFrfoMieyBLHCzBsrwN7
         l2x8jf+zGi+QiokWD/gZA21MXdCEqsPmjF/72pdA=
From:   =?UTF-8?q?Stefan=20B=C3=BChler?= <source@stbuehler.de>
To:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/5] pipe: use IOCB_NOWAIT instead of O_NONBLOCK
Date:   Sat, 11 May 2019 18:57:25 +0200
Message-Id: <20190511165727.31599-3-source@stbuehler.de>
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

Fix pipe read_iter/write_iter implementations to handle IOCB_NOWAIT; for
simple reads IOCB_NOWAIT will be set if O_NONBLOCK was set.

Signed-off-by: Stefan Bühler <source@stbuehler.de>
---
 fs/pipe.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 41065901106b..a122331cf30f 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -335,13 +335,13 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 			break;
 		if (!pipe->waiting_writers) {
 			/* syscall merging: Usually we must not sleep
-			 * if O_NONBLOCK is set, or if we got some data.
+			 * if IOCB_NOWAIT is set, or if we got some data.
 			 * But if a writer sleeps in kernel space, then
 			 * we can wait for that data without violating POSIX.
 			 */
 			if (ret)
 				break;
-			if (filp->f_flags & O_NONBLOCK) {
+			if (iocb->ki_flags & IOCB_NOWAIT) {
 				ret = -EAGAIN;
 				break;
 			}
@@ -446,7 +446,7 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 				pipe->tmp_page = page;
 			}
 			/* Always wake up, even if the copy fails. Otherwise
-			 * we lock up (O_NONBLOCK-)readers that sleep due to
+			 * we lock up (IOCB_NOWAIT-)readers that sleep due to
 			 * syscall merging.
 			 * FIXME! Is this really true?
 			 */
@@ -477,7 +477,7 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 		}
 		if (bufs < pipe->buffers)
 			continue;
-		if (filp->f_flags & O_NONBLOCK) {
+		if (iocb->ki_flags & IOCB_NOWAIT) {
 			if (!ret)
 				ret = -EAGAIN;
 			break;
@@ -780,6 +780,7 @@ int create_pipe_files(struct file **res, int flags)
 		iput(inode);
 		return PTR_ERR(f);
 	}
+	f->f_mode |= FMODE_NOWAIT;
 
 	f->private_data = inode->i_pipe;
 
@@ -791,6 +792,7 @@ int create_pipe_files(struct file **res, int flags)
 		return PTR_ERR(res[0]);
 	}
 	res[0]->private_data = inode->i_pipe;
+	res[0]->f_mode |= FMODE_NOWAIT;
 	res[1] = f;
 	return 0;
 }
@@ -996,6 +998,8 @@ static int fifo_open(struct inode *inode, struct file *filp)
 		goto err;
 	}
 
+	filp->f_mode |= FMODE_NOWAIT;
+
 	/* Ok! */
 	__pipe_unlock(pipe);
 	return 0;
-- 
2.20.1

