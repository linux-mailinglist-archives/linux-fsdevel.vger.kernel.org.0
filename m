Return-Path: <linux-fsdevel+bounces-20929-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD088FAEB1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 11:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83E94287AE1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 09:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9702B143C54;
	Tue,  4 Jun 2024 09:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="MVp24Rm2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C22D143724
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jun 2024 09:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717493096; cv=none; b=QkB+n5m0tSc7200WExZfeUIOcWo1TnoU8CMo9lFXlcukPslidNKqf1NsAn7XZ5X7kAMr2eElM8ER4GqRNn5wdwPuLWPw78EVuFXSPzXJzOmapNQ6fVX58dzVvdCW5Ao/4dy+zWazWKnEco59+vM/mhu02NHPQebx5YGppUneKXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717493096; c=relaxed/simple;
	bh=3M/8TKMtLd1tf0/P4+WGMCcoSzO6k4NIm/iHpw11Lhw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EGr4kkaF19Fv77I45CQ9ucP+pUqrNVG7yh+yeAPRxBpY4Oa0+h3y6ly/2ovT2JBo6Vp8TuKfTZoXHw4HgjTmBBeJFW15shnX4vSg/EqNyjzdtIA5bwB29CrIsFwC5UW0DXJwKV3LZfhtChhFyZfQYDqAw/Nbf9rWVRafeXIiQDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=MVp24Rm2; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-57a20ccafc6so4717721a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Jun 2024 02:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1717493091; x=1718097891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=51xd4qBif5qLulTsk7/5OKYHjeBwqmO8tvfG1w6sQz8=;
        b=MVp24Rm24/RMCNNCfkrS+XU2VDrxb3bkeNPfdySDU7uoVNm0e9JtcKdlUl+hybQLnA
         fOklqlkGU5JMB2r1BTlLJ0r37y39EuyvLvYGDllGbWrrfI1dh6skbacaMea4mHJ1jnRg
         WQydq7aQUmxiBJ4n669Fq/NdilXL+5hq/y6i9keD5hzWQQgyqE+RLuOy+xzZOfXjKM7C
         gXkvgPK2MjwU/hlH4IKxt7oa4vAmbV0TZJUhAuOUN765P0C78mDZep1FML93qUl6NyWu
         PqGib1f1hOvRUZdUBhkTVcymBI8t/oCI1R/iK05W9gzsAB7EeTiluKXhvpeHSiKQ3PDD
         QpXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717493091; x=1718097891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=51xd4qBif5qLulTsk7/5OKYHjeBwqmO8tvfG1w6sQz8=;
        b=TTeLL4UxLVQJ0trG0+L8R4e8pv8Yq6GeGcMCW4GGJxpCJzlWf8EyPrac70FLeqhh91
         WyIcY+METgvv6TxvJcMLVBcn21AYwqst1I2OkkLhfgc4gnVa6mm74Ge2XB2twAatTB8T
         nPYCqOIaPjKs854tLyr4XU4RokNOtqedIPxkCORoN8/Ncm8QHLfaYFc2h/wMY6TcQqxF
         YiP439dTKMdlQaOhEeVwey5J0UPUu1m8aNAQuTeGxkY/qgY++WtRFv8/4SIrpH5tFDQ+
         0/FX0Wanu1uBLfHqe2GkC7+ppZ6OuCeRe9lyuUgWGAxn+jcvLrAWEjTXaQ2m2T4AI8NG
         yhVw==
X-Forwarded-Encrypted: i=1; AJvYcCVOKy/dx1N8EuycLUREQWhbpWnnsgOOZ6Mk6aD7ZZog3jc2NtjQKEnlbpWm9AiTATMljWRf3ud1ecgDz6dirO7NbiA1CtAnKHNakpKctw==
X-Gm-Message-State: AOJu0YxcvZp5KWJcOBlP/QwpoZMCJY3pspuI1xoWw7xsROvnK7dTs9Me
	tYftUTIuxwG4eLGAM5hgfXjDNX19CyLW152incuRfoM8xcOPGf78mC2LyDWEa1I=
X-Google-Smtp-Source: AGHT+IFBu712jehkTGREuH0rS+RjNhRk0Wck7Jz32KlzUmxTUHlbcIESU2fsnsMpVNsUMLXvJHg3jA==
X-Received: by 2002:a50:d503:0:b0:57a:2f68:fe7b with SMTP id 4fb4d7f45d1cf-57a36419606mr7947320a12.31.1717493090867;
        Tue, 04 Jun 2024 02:24:50 -0700 (PDT)
Received: from raven.blarg.de (p200300dc6f4f9200023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f4f:9200:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a7e6a8e14sm1226873a12.87.2024.06.04.02.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 02:24:50 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: axboe@kernel.dk,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	hch@infradead.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v3] fs/splice: don't block splice_direct_to_actor() after data was read
Date: Tue,  4 Jun 2024 11:24:31 +0200
Message-Id: <20240604092431.2183929-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

---
Changes v1 -> v2:
- value of SPLICE_F_NOWAIT changed to 0x10
- added SPLICE_F_NOWAIT to SPLICE_F_ALL to make it part of uapi

v2 -> v3: repost and rebase on linus/master

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/splice.c            | 14 ++++++++++++++
 include/linux/splice.h |  4 +++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/fs/splice.c b/fs/splice.c
index 60aed8de21f8..6257fef93ec4 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -362,6 +362,8 @@ ssize_t copy_splice_read(struct file *in, loff_t *ppos,
 	iov_iter_bvec(&to, ITER_DEST, bv, npages, len);
 	init_sync_kiocb(&kiocb, in);
 	kiocb.ki_pos = *ppos;
+	if (flags & SPLICE_F_NOWAIT)
+		kiocb.ki_flags |= IOCB_NOWAIT;
 	ret = in->f_op->read_iter(&kiocb, &to);
 
 	if (ret > 0) {
@@ -1090,6 +1092,18 @@ ssize_t splice_direct_to_actor(struct file *in, struct splice_desc *sd,
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
index 9dec4861d09f..0deb87fb8055 100644
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


