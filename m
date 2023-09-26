Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBDF7AE60D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Sep 2023 08:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233747AbjIZGg6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Sep 2023 02:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233614AbjIZGg5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Sep 2023 02:36:57 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D794E6
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Sep 2023 23:36:50 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-4053c6f1087so71245965e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Sep 2023 23:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1695710208; x=1696315008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KreDf2vqHk/Hd5rmmn0d7G8cM8MDnpKHn6UOoJPSFwk=;
        b=dtEv8mgHJPdjmzfVbT04HtND1Su4mHTU2nsycQ295kRVY3zBadjWmZ39p1d+zR4hMl
         TzoXc7fbzz97+N/ITZA2w9xL0NZal6iU+f+IXq+oEIYaFBqcVV1vGusXkDe0o0Pmk8uI
         bIlikl1bBkd5JCEi4DFBYKWOq+a4AhW3X0VDZinvcg+fSikVscxX6k6B4s5y5cl/u2w9
         9LbOEe2LXtz6RHFvi/oD/SN11Fwv/ztRQDY3JiH137O4nZRcdnFoIeV3X2bASjEsdWz3
         mUHxDcNq0dH/1a/Eq43Vhbk1MFHEqw1WueH3tv7rxK5DHt4IXrsrUDgLLUkJYNTaer8+
         Cp1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695710208; x=1696315008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KreDf2vqHk/Hd5rmmn0d7G8cM8MDnpKHn6UOoJPSFwk=;
        b=huXbBbCw571uavJ0jvXirJ72qLjKi9z3oJqyMlhEQN8z1u4/jFabIUI+dEilmFE5IC
         3uiweeC7S++Nv5ohwqfoDyMVYjxoiLfW+dJ+sM82e+64g6v95aAR551QbfU92DgqcX1M
         hGFU+dS1cEtDRnqTjYVQkjiJg2ThcicFvxHF4IUxsF0IYWR3/ceBp0NxyXEI1An75GX5
         nxzppb+3vakF2HIHS2AI/F1zxRtlJbuhvIVZXsJvV/FeUhXhCk9Yj6fYab3/ZVCO6qHm
         TxYjo3M40ue6lieP9ftVHfV2bbo+W9ruXOuESNN/W4ghoFnYSVMksN3vS4xUbCDh+uSW
         iUgQ==
X-Gm-Message-State: AOJu0YwTrdWrO+THLPZMmFqIQzk9wjwTMlU5sGlyQ1kt17vjMkklo/Q4
        cYx8QXUIjFC6GZ5R6wq94LHqoQ==
X-Google-Smtp-Source: AGHT+IEaU5YkQqHlQmnHzRUHg7mR59R0MLXXsISp7ntSN3OgCFSbPjBCBjUuOPnmuwQypcZA3pjocg==
X-Received: by 2002:a05:600c:22d8:b0:3fb:b3aa:1c8a with SMTP id 24-20020a05600c22d800b003fbb3aa1c8amr7142927wmg.16.1695710208403;
        Mon, 25 Sep 2023 23:36:48 -0700 (PDT)
Received: from heron.intern.cm-ag (p200300dc6f49a600529a4cfffe3dd983.dip0.t-ipconnect.de. [2003:dc:6f49:a600:529a:4cff:fe3d:d983])
        by smtp.gmail.com with ESMTPSA id s16-20020a7bc390000000b00401c595fcc7sm11270639wmj.11.2023.09.25.23.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 23:36:48 -0700 (PDT)
From:   Max Kellermann <max.kellermann@ionos.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     Max Kellermann <max.kellermann@ionos.com>,
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] fs/splice: don't block splice_direct_to_actor() after data was read
Date:   Tue, 26 Sep 2023 08:36:09 +0200
Message-Id: <20230926063609.2451260-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230925-erstklassig-flausen-48e1bc11be30@brauner>
References: <20230925-erstklassig-flausen-48e1bc11be30@brauner>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
splice().  It translates to IOCB_NOWAIT for regular files, just like
RWF_NOWAIT does.

Changes v1 -> v2:
- value of SPLICE_F_NOWAIT changed to 0x10
- added SPLICE_F_NOWAIT to SPLICE_F_ALL to make it part of uapi

Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/splice.c            | 14 ++++++++++++++
 include/linux/splice.h |  4 +++-
 2 files changed, 17 insertions(+), 1 deletion(-)

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
index 6c461573434d..06ce58b1f408 100644
--- a/include/linux/splice.h
+++ b/include/linux/splice.h
@@ -21,7 +21,9 @@
 #define SPLICE_F_MORE	(0x04)	/* expect more data */
 #define SPLICE_F_GIFT	(0x08)	/* pages passed in are a gift */
 
-#define SPLICE_F_ALL (SPLICE_F_MOVE|SPLICE_F_NONBLOCK|SPLICE_F_MORE|SPLICE_F_GIFT)
+#define SPLICE_F_NOWAIT	(0x10) /* do not wait for data which is not immediately available */
+
+#define SPLICE_F_ALL (SPLICE_F_MOVE|SPLICE_F_NONBLOCK|SPLICE_F_MORE|SPLICE_F_GIFT|SPLICE_F_NOWAIT)
 
 /*
  * Passed to the actors
-- 
2.39.2

