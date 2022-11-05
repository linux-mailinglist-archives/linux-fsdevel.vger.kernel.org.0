Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD4661D8FF
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Nov 2022 10:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiKEJLW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Nov 2022 05:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiKEJLV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Nov 2022 05:11:21 -0400
X-Greylist: delayed 391 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 05 Nov 2022 02:11:17 PDT
Received: from nibbler.cm4all.net (nibbler.cm4all.net [82.165.145.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FD326117
        for <linux-fsdevel@vger.kernel.org>; Sat,  5 Nov 2022 02:11:17 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by nibbler.cm4all.net (Postfix) with ESMTP id 3B6A2C00A5
        for <linux-fsdevel@vger.kernel.org>; Sat,  5 Nov 2022 10:04:44 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at nibbler.cm4all.net
Received: from nibbler.cm4all.net ([127.0.0.1])
        by localhost (nibbler.cm4all.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 821iXzsFLirX for <linux-fsdevel@vger.kernel.org>;
        Sat,  5 Nov 2022 10:04:37 +0100 (CET)
Received: from zero.intern.cm-ag (zero.intern.cm-ag [172.30.16.10])
        by nibbler.cm4all.net (Postfix) with SMTP id 1EDB1C007D
        for <linux-fsdevel@vger.kernel.org>; Sat,  5 Nov 2022 10:04:37 +0100 (CET)
Received: (qmail 10907 invoked from network); 5 Nov 2022 14:14:23 +0100
Received: from unknown (HELO rabbit.intern.cm-ag) (172.30.3.1)
  by zero.intern.cm-ag with SMTP; 5 Nov 2022 14:14:23 +0100
Received: by rabbit.intern.cm-ag (Postfix, from userid 1023)
        id E4E52460B43; Sat,  5 Nov 2022 10:04:36 +0100 (CET)
From:   Max Kellermann <mk@cm4all.com>
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH] fs/splice: don't block splice_direct_to_actor() after data was read
Date:   Sat,  5 Nov 2022 10:04:21 +0100
Message-Id: <20221105090421.21237-1-mk@cm4all.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Max Kellermann <max.kellermann@ionos.com>

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

To: Alexander Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/splice.c            | 14 ++++++++++++++
 include/linux/splice.h |  6 ++++++
 2 files changed, 20 insertions(+)

diff --git a/fs/splice.c b/fs/splice.c
index 0878b852b355..7a8d5fee0965 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -306,6 +306,8 @@ ssize_t generic_file_splice_read(struct file *in, loff_t *ppos,
 	iov_iter_pipe(&to, READ, pipe, len);
 	init_sync_kiocb(&kiocb, in);
 	kiocb.ki_pos = *ppos;
+	if (flags & SPLICE_F_NOWAIT)
+		kiocb.ki_flags |= IOCB_NOWAIT;
 	ret = call_read_iter(in, &kiocb, &to);
 	if (ret > 0) {
 		*ppos = kiocb.ki_pos;
@@ -866,6 +868,18 @@ ssize_t splice_direct_to_actor(struct file *in, struct splice_desc *sd,
 		if (unlikely(ret <= 0))
 			goto out_release;
 
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
index a55179fd60fc..14021bba7829 100644
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
2.30.2

