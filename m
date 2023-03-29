Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684CE6CF254
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 20:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjC2SlN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 14:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjC2SlF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 14:41:05 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD54E1FDA
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 11:41:03 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id bl9so7234784iob.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 11:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680115263; x=1682707263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DC1PRKIPWeSwJmEnC4u8bQghfT4SJuLeGzSfXQEaX64=;
        b=XMkysAG5kgc7/AQwMJFGJ3Cx++C0nMIt19OeWo+dMA5bB+K70IHOX8vJm0FrOySfhi
         fLFxfN6H54P2yip53Hwtx1zlgsX3CIn+gW6Jm64qYvuFd96VyLZYIPGvNMyQCYou4+cK
         CokCVreTCQhWO18DaVkafXVOokAJ7AByD/xVmhxWPodoZU+KbggQI4zLvuInnL2Mrawx
         qt5I94PPDvP0klXxyQnz+RkINfXZrkNhmFyw5oHJ1/kjTh5Sp+ebMtG3Oha9cPDimwng
         8lrNxW60rNrP1NREdcvwFBrLztB9GICjxPYMTxB+HnKJsjOhDu5hf6eXB/si0xcYKJaJ
         28vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680115263; x=1682707263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DC1PRKIPWeSwJmEnC4u8bQghfT4SJuLeGzSfXQEaX64=;
        b=2b6zwbv1gmjwKfRtiAPbiOuBawi4eCOfzaECbjqN8lXBB6c5q30LW6hJHKyUQ7n5bm
         Kfto/VgSUMBhc6UV76Ez/FrmurcELBOucsKzb1dmjcRg08Q/wDabO3eGiQf+GVQVvZKh
         Pb8iFAE+1oSVOUO/KOuh9j3VFl/eIeWxmYtbjb534pm0w5qseXME1JU/nL9ieOEC+cuL
         t+ucBYDMMtmKp+2GfgaRkMMq3eQ3mqb+ixWmcaCappofmrLVk9IYx09Uyy9DEAJeqC5G
         XTYFS8K+Q1BJ/sis8u1+4lfsNx6cpxSLljmMpba3ahcSyw9bfHDcDTTSKw05p8pWYfdF
         /sJA==
X-Gm-Message-State: AO0yUKV7NDCBQH2FNbiD/81yKvyZklqEGMWOq91KqKB3cVERHHhIJHW2
        fK3LOn00yOyhdgfc8YePo7zWCUcIo+qlICDy7WywoA==
X-Google-Smtp-Source: AK7set9SGE/l+jD1Q12SLn6zOemkfTfgQlkhrS2CqmKaDVbimHfLRdVLDiSvIX/6Vjpwa4B9GU6LGQ==
X-Received: by 2002:a05:6602:1246:b0:758:5525:860a with SMTP id o6-20020a056602124600b007585525860amr11266384iou.0.1680115262710;
        Wed, 29 Mar 2023 11:41:02 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id m36-20020a056638272400b004063e6fb351sm10468087jav.89.2023.03.29.11.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 11:41:02 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 03/11] iov_iter: add iter_iov_addr() and iter_iov_len() helpers
Date:   Wed, 29 Mar 2023 12:40:47 -0600
Message-Id: <20230329184055.1307648-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329184055.1307648-1-axboe@kernel.dk>
References: <20230329184055.1307648-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These just return the address and length of the current iovec segment
in the iterator. Convert existing iov_iter_iovec() users to use them
instead of getting a copy of the current vec.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/read_write.c     | 11 +++++------
 include/linux/uio.h |  2 ++
 io_uring/rw.c       | 27 +++++++++++++--------------
 mm/madvise.c        |  9 ++++-----
 4 files changed, 24 insertions(+), 25 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 7a2ff6157eda..a21ba3be7dbe 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -749,15 +749,14 @@ static ssize_t do_loop_readv_writev(struct file *filp, struct iov_iter *iter,
 		return -EOPNOTSUPP;
 
 	while (iov_iter_count(iter)) {
-		struct iovec iovec = iov_iter_iovec(iter);
 		ssize_t nr;
 
 		if (type == READ) {
-			nr = filp->f_op->read(filp, iovec.iov_base,
-					      iovec.iov_len, ppos);
+			nr = filp->f_op->read(filp, iter_iov_addr(iter),
+						iter_iov_len(iter), ppos);
 		} else {
-			nr = filp->f_op->write(filp, iovec.iov_base,
-					       iovec.iov_len, ppos);
+			nr = filp->f_op->write(filp, iter_iov_addr(iter),
+						iter_iov_len(iter), ppos);
 		}
 
 		if (nr < 0) {
@@ -766,7 +765,7 @@ static ssize_t do_loop_readv_writev(struct file *filp, struct iov_iter *iter,
 			break;
 		}
 		ret += nr;
-		if (nr != iovec.iov_len)
+		if (nr != iter_iov_len(iter))
 			break;
 		iov_iter_advance(iter, nr);
 	}
diff --git a/include/linux/uio.h b/include/linux/uio.h
index 4218624b7f78..b7fce87b720e 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -70,6 +70,8 @@ struct iov_iter {
 };
 
 #define iter_iov(iter)	(iter)->__iov
+#define iter_iov_addr(iter)	(iter_iov(iter)->iov_base + (iter)->iov_offset)
+#define iter_iov_len(iter)	(iter_iov(iter)->iov_len - (iter)->iov_offset)
 
 static inline enum iter_type iov_iter_type(const struct iov_iter *i)
 {
diff --git a/io_uring/rw.c b/io_uring/rw.c
index 7573a34ea42a..f33ba6f28247 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -447,26 +447,25 @@ static ssize_t loop_rw_iter(int ddir, struct io_rw *rw, struct iov_iter *iter)
 	ppos = io_kiocb_ppos(kiocb);
 
 	while (iov_iter_count(iter)) {
-		struct iovec iovec;
+		void __user *addr;
+		size_t len;
 		ssize_t nr;
 
 		if (iter_is_ubuf(iter)) {
-			iovec.iov_base = iter->ubuf + iter->iov_offset;
-			iovec.iov_len = iov_iter_count(iter);
+			addr = iter->ubuf + iter->iov_offset;
+			len = iov_iter_count(iter);
 		} else if (!iov_iter_is_bvec(iter)) {
-			iovec = iov_iter_iovec(iter);
+			addr = iter_iov_addr(iter);
+			len = iter_iov_len(iter);
 		} else {
-			iovec.iov_base = u64_to_user_ptr(rw->addr);
-			iovec.iov_len = rw->len;
+			addr = u64_to_user_ptr(rw->addr);
+			len = rw->len;
 		}
 
-		if (ddir == READ) {
-			nr = file->f_op->read(file, iovec.iov_base,
-					      iovec.iov_len, ppos);
-		} else {
-			nr = file->f_op->write(file, iovec.iov_base,
-					       iovec.iov_len, ppos);
-		}
+		if (ddir == READ)
+			nr = file->f_op->read(file, addr, len, ppos);
+		else
+			nr = file->f_op->write(file, addr, len, ppos);
 
 		if (nr < 0) {
 			if (!ret)
@@ -482,7 +481,7 @@ static ssize_t loop_rw_iter(int ddir, struct io_rw *rw, struct iov_iter *iter)
 			if (!rw->len)
 				break;
 		}
-		if (nr != iovec.iov_len)
+		if (nr != len)
 			break;
 	}
 
diff --git a/mm/madvise.c b/mm/madvise.c
index 340125d08c03..9f389c5304d2 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1456,7 +1456,7 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
 		size_t, vlen, int, behavior, unsigned int, flags)
 {
 	ssize_t ret;
-	struct iovec iovstack[UIO_FASTIOV], iovec;
+	struct iovec iovstack[UIO_FASTIOV];
 	struct iovec *iov = iovstack;
 	struct iov_iter iter;
 	struct task_struct *task;
@@ -1503,12 +1503,11 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
 	total_len = iov_iter_count(&iter);
 
 	while (iov_iter_count(&iter)) {
-		iovec = iov_iter_iovec(&iter);
-		ret = do_madvise(mm, (unsigned long)iovec.iov_base,
-					iovec.iov_len, behavior);
+		ret = do_madvise(mm, (unsigned long)iter_iov_addr(&iter),
+					iter_iov_len(&iter), behavior);
 		if (ret < 0)
 			break;
-		iov_iter_advance(&iter, iovec.iov_len);
+		iov_iter_advance(&iter, iter_iov_len(&iter));
 	}
 
 	ret = (total_len - iov_iter_count(&iter)) ? : ret;
-- 
2.39.2

