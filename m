Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5A67A5C33
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 10:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjISINR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 04:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjISINQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 04:13:16 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3B612C
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 01:13:06 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-52a4737a08fso6517498a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 01:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1695111185; x=1695715985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VOwLl+YW9hr+Qj82oq/m7sO0HACM7+bf3qhUZRem7Dk=;
        b=SZ14L/A0IlHoqPLHNBi/qRFW3QHhQzr59dX7wwTWib800Sh1HboWuiNA0iWv0jwbrf
         wLWg+Vk4e8iHHc6+0LuQcWi+tHfgyJD9gk+J1/BMwDW9oZclOpdaQWYM6CpGFnhYNmSo
         ILEdGPRsEcjkFCPThxheTgnIXdgjw1k+RVKhXu9QdJW5aBWzva2D2wfF9kaE+evwlJL9
         D5qb0P/Crj0gEaRLp9L9w8JnYZcGC3vyrafwgAkLX70xuBKWO1EJNvC4SqUf8iqTILLa
         6edhHjNPlQQb6bnJjEJUB3/004hWoI7/9rY8/fyOdNR8/efZP9mMPmZFqdtDc79obd0o
         NLeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695111185; x=1695715985;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VOwLl+YW9hr+Qj82oq/m7sO0HACM7+bf3qhUZRem7Dk=;
        b=i8xOScTChhzq69yT3NmAHLZsNRnMjGoOOmcr3hkeNCAPeRNRRSoyTjiGydgLF4DRD8
         ONzWlPBT7OxgBEB7NeTMFxI5MSQ3pD9A6EmSvdwBdfHd0qthNmbQ4xZXwHYtUmJCGz2O
         MvyU8t2OIdj4J37rZ86p5O/RpLynDSN/UX+DU7AbNwSGj5VeWenO77OAGxmxuLq02mcN
         17/JsLOKccESgdXQufEKFaqlagYp4Y/eAPnajhnJR4HBQVFa4LiPr3W8+698MzSFOcT8
         +Tza5PTWEK5gp4XTXCUn7spGtU/QMyG4W5WjoCiYt4QvR6adbzke3ZNQXoIYOvulInl3
         cZXw==
X-Gm-Message-State: AOJu0YxIbWqY7Rf09iRf6JwMnMGUlejKXLTA8kSzZeOSzhE/cvUIMTRW
        2S2+vLXN6TClcQPg5NvKu7a+GA1mgTiuNDEyvAlyMw==
X-Google-Smtp-Source: AGHT+IGMjgPDlgwkrQCtpajvXpNWxBxJuYPIneQ3Uy7GncOB/3hmk2GrJEXPGx8v+epOTVA9GyHtPw==
X-Received: by 2002:a05:6402:74d:b0:525:7234:52b7 with SMTP id p13-20020a056402074d00b00525723452b7mr9282824edy.19.1695111185366;
        Tue, 19 Sep 2023 01:13:05 -0700 (PDT)
Received: from heron.intern.cm-ag (p200300dc6f209c00529a4cfffe3dd983.dip0.t-ipconnect.de. [2003:dc:6f20:9c00:529a:4cff:fe3d:d983])
        by smtp.gmail.com with ESMTPSA id m20-20020a056402431400b00532b88fc984sm564466edc.24.2023.09.19.01.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 01:13:05 -0700 (PDT)
From:   Max Kellermann <max.kellermann@ionos.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     Max Kellermann <max.kellermann@ionos.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/splice: don't block splice_direct_to_actor() after data was read
Date:   Tue, 19 Sep 2023 10:12:58 +0200
Message-Id: <20230919081259.1094971-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If userspace calls sendfile() with a very large "count" parameter, the
kernel can block for a very long time until 2 GiB (0x7ffff000 bytes)
have been read from the hard disk and pushed into the socket buffer.

Usually, that is not a problem, because the socket write buffer gets
filled quickly, and if the socket is non-blocking, the last
direct_splice_actor() call will return -EAGAIN, causing
splice_direct_to_actor() to break from the loop, and sendfile() will
return a partial transfer.

However, if the network happens to be faster than the hard disk, and
the socket buffer keeps getting drained between two
generic_file_read_iter() calls, the sendfile() system call can keep
running for a long time, blocking for disk I/O over and over.

That is undesirable, because it can block the calling process for too
long.  I discovered a problem where nginx would block for so long that
it would drop the HTTP connection because the kernel had just
transferred 2 GiB in one call, and the HTTP socket was not writable
(EPOLLOUT) for more than 60 seconds, resulting in a timeout:

  sendfile(4, 12, [5518919528] => [5884939344], 1813448856) = 366019816 <3.033067>
  sendfile(4, 12, [5884939344], 1447429040) = -1 EAGAIN (Resource temporarily unavailable) <0.000037>
  epoll_wait(9, [{EPOLLOUT, {u32=2181955104, u64=140572166585888}}], 512, 60000) = 1 <0.003355>
  gettimeofday({tv_sec=1667508799, tv_usec=201201}, NULL) = 0 <0.000024>
  sendfile(4, 12, [5884939344] => [8032418896], 2147480496) = 2147479552 <10.727970>
  writev(4, [], 0) = 0 <0.000439>
  epoll_wait(9, [], 512, 60000) = 0 <60.060430>
  gettimeofday({tv_sec=1667508869, tv_usec=991046}, NULL) = 0 <0.000078>
  write(5, "10.40.5.23 - - [03/Nov/2022:21:5"..., 124) = 124 <0.001097>
  close(12) = 0 <0.000063>
  close(4)  = 0 <0.000091>

In newer nginx versions (since 1.21.4), this problem was worked around
by defaulting "sendfile_max_chunk" to 2 MiB:

 https://github.com/nginx/nginx/commit/5636e7f7b4

Instead of asking userspace to provide an artificial upper limit, I'd
like the kernel to block for disk I/O at most once, and then pass back
control to userspace.

There is prior art for this kind of behavior in filemap_read():

	/*
	 * If we've already successfully copied some data, then we
	 * can no longer safely return -EIOCBQUEUED. Hence mark
	 * an async read NOWAIT at that point.
	 */
	if ((iocb->ki_flags & IOCB_WAITQ) && already_read)
		iocb->ki_flags |= IOCB_NOWAIT;

This modifies the caller-provided "struct kiocb", which has an effect
on repeated filemap_read() calls.  This effect however vanishes
because the "struct kiocb" is not persistent; splice_direct_to_actor()
doesn't have one, and each generic_file_splice_read() call initializes
a new one, losing the "IOCB_NOWAIT" flag that was injected by
filemap_read().

There was no way to make generic_file_splice_read() aware that
IOCB_NOWAIT was desired because some data had already been transferred
in a previous call:

- checking whether the input file has O_NONBLOCK doesn't work because
  this should be fixed even if the input file is not non-blocking

- the SPLICE_F_NONBLOCK flag is not appropriate because it affects
  only whether pipe operations are non-blocking, not whether
  file/socket operations are non-blocking

Since there are no other parameters, I suggest adding the
SPLICE_F_NOWAIT flag, which is similar to SPLICE_F_NONBLOCK, but
affects the "non-pipe" file descriptor passed to sendfile() or
splice().  It translates to IOCB_NOWAIT for regular files.  For now, I
have documented the flag to be kernel-internal with a high bit, like
io_uring does with SPLICE_F_FD_IN_FIXED, but making this part of the
system call ABI may be a good idea as well.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/splice.c            | 14 ++++++++++++++
 include/linux/splice.h |  6 ++++++
 2 files changed, 20 insertions(+)

diff --git a/fs/splice.c b/fs/splice.c
index d983d375ff11..c192321d5e37 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -361,6 +361,8 @@ ssize_t copy_splice_read(struct file *in, loff_t *ppos,
 	iov_iter_bvec(&to, ITER_DEST, bv, npages, len);
 	init_sync_kiocb(&kiocb, in);
 	kiocb.ki_pos = *ppos;
+	if (flags & SPLICE_F_NOWAIT)
+		kiocb.ki_flags |= IOCB_NOWAIT;
 	ret = call_read_iter(in, &kiocb, &to);
 
 	if (ret > 0) {
@@ -1070,6 +1072,18 @@ ssize_t splice_direct_to_actor(struct file *in, struct splice_desc *sd,
 		if (unlikely(ret <= 0))
 			goto read_failure;
 
+		/*
+		 * After at least one byte was read from the input
+		 * file, don't wait for blocking I/O in the following
+		 * loop iterations; instead of blocking for arbitrary
+		 * amounts of time in the kernel, let userspace decide
+		 * how to proceed.  This avoids excessive latency if
+		 * the output is being consumed faster than the input
+		 * file can fill it (e.g. sendfile() from a slow hard
+		 * disk to a fast network).
+		 */
+		flags |= SPLICE_F_NOWAIT;
+
 		read_len = ret;
 		sd->total_len = read_len;
 
diff --git a/include/linux/splice.h b/include/linux/splice.h
index 6c461573434d..abdf94759138 100644
--- a/include/linux/splice.h
+++ b/include/linux/splice.h
@@ -23,6 +23,12 @@
 
 #define SPLICE_F_ALL (SPLICE_F_MOVE|SPLICE_F_NONBLOCK|SPLICE_F_MORE|SPLICE_F_GIFT)
 
+/*
+ * Don't wait for I/O (internal flag for the splice_direct_to_actor()
+ * loop).
+ */
+#define SPLICE_F_NOWAIT	(1U << 30)
+
 /*
  * Passed to the actors
  */
-- 
2.39.2

