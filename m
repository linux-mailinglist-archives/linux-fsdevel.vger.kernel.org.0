Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F5D6D0BAD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 18:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbjC3Qr1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Mar 2023 12:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232359AbjC3QrN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Mar 2023 12:47:13 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A109CDF7
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Mar 2023 09:47:12 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id h11so10096539ild.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Mar 2023 09:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680194831; x=1682786831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DC1PRKIPWeSwJmEnC4u8bQghfT4SJuLeGzSfXQEaX64=;
        b=vK0pwwvRHfp2UyZEksH4vvb6R5y05R0iGbZ47EXC1Kd1UcFymwZP1+Bo4PTi1MMl7Q
         eelKBq55vwV9icNVODWTZ8LpKki6ZaW/pq7hbt39chyboNCMEi6rYHP5o+XUCaac0MVD
         ipvFuV0GZiCRXkTArd8ab56JMt90PKAa8+Yk2xKqh7mCBpy7Yume+o5Mls5eN5bl8sUL
         PMAgg5ShN0xvjQbA3UxmY6ObnPbLMPfiSo8f8AG+lFaslshpclTB/LXl+iMqsT/MarQX
         5rz3+QcFTem4oDghGuiNE8ipAORp4RaQegUCBM5pnnmkC/NZd0WzNDL4Q4U2O/Y98uQX
         eZjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680194831; x=1682786831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DC1PRKIPWeSwJmEnC4u8bQghfT4SJuLeGzSfXQEaX64=;
        b=RYAwXYvR4lIjOmkhGNLhh1z16gakPCkCqymw6gFvs739S6nmrkTKZO5U6pN4QKGw0p
         YETf/klYSl89zLv2dXHHIYYNbhY47OubL1krhWROBPaXMsgyie6NTpgV4EQYo/VySAvo
         vajPV/MYsViwKO+CHAr0BMwbdTaS4vNmu0mxW4rlDyIHd/ivdHNf3Ji5QBanHuOquPh7
         76iT6GqnQxgihst3N3TFjTVToKRy9hh0fmc+obpLV3aSehzMNdShLrpWPHQs3aI8Q0HF
         swJEknBcRUzJ8OKHXWdyHzItvyCIWLwd9queFfHneuEciZEfQpwKo0I87G14yOE7HeeF
         +wrA==
X-Gm-Message-State: AAQBX9dy2jrzFau9/b8Rx2zycSw9KfntUx0blLp+NR1PAVL0mKzdoq1N
        zlPXV+aYhGKBpr2jCuo3PCyarfbpg3vWqJgM91fruQ==
X-Google-Smtp-Source: AKy350Yr0i+KT7q0jbNq2PAtT5AmB6DDEFYrlOwnVhRJxG6+qq5F7JKQVCNqEfxEAxs6snJ/Hw7LUg==
X-Received: by 2002:a05:6e02:13e2:b0:313:fb1b:2f86 with SMTP id w2-20020a056e0213e200b00313fb1b2f86mr1553389ilj.0.1680194831655;
        Thu, 30 Mar 2023 09:47:11 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id v21-20020a056638251500b003a53692d6dbsm20876jat.124.2023.03.30.09.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 09:47:11 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 06/11] iov_iter: add iter_iov_addr() and iter_iov_len() helpers
Date:   Thu, 30 Mar 2023 10:46:57 -0600
Message-Id: <20230330164702.1647898-7-axboe@kernel.dk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330164702.1647898-1-axboe@kernel.dk>
References: <20230330164702.1647898-1-axboe@kernel.dk>
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

