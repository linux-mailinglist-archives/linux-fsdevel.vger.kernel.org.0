Return-Path: <linux-fsdevel+bounces-15929-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 115A4895D8C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 22:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 345DE1C22547
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 20:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A2615E5B7;
	Tue,  2 Apr 2024 20:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="rpSQ5AbF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F4D15E1FF
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Apr 2024 20:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712089537; cv=none; b=MELIoBf8AiZl2oiDixwktO8QszA7c6OGFWM2pLjBgantaQHUHxEsP1WY2xagFG/ovmKhpmN3tFFsdNvr1HqH1X+jHSIzlSPTE2B0wcRZsv/JRR3Dg58Uk0Vy2XMnoshpenREuEq5I5LO3kxoeklLGbFEOWXQwbyLztAPovSi9yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712089537; c=relaxed/simple;
	bh=lvxMY5xAb2LkORT4WJWhXdTw9IOcYUuS+QAu6zRgfeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=clogz2Rhu5gXCikgJgrQHNwDGhNdo6hvofbGnoIJ8flhPjQXFcfNxYKW78qX2magLyPV4G5CKmf5xd/N3lMcaiEKK9uL+YjueK1wUp7pfCdN5tVs60szI6tS39SQAiHbvxAHObZRkYPMpKQKahp0pxuRj6c2dypfKvy7L2T4yi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=rpSQ5AbF; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7c86e6f649aso18469439f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Apr 2024 13:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712089534; x=1712694334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wEISoDaReVBYlihnUfkRNegSHCa1fOWz9Nfv9lbetO4=;
        b=rpSQ5AbFmAhADrr5Wu0H8kGy+7W6gC8uCOb0gXT1WngH/NkwcM7sSOoAl3Gtf9+L2R
         +R6598YkJLVV31lhowcV+wut1UT/UbOtCWqQ3+lSPuKvn2Rs4p0OFcWgauEzemUbnqfT
         PkOtl/7AjqOBf3SgWreaLUAx3m95jvvm8kP3Ep3lyghYYbsuUZnmx5+9rabQFbUfSh4j
         m4sNnGto0z9th8Zdgb9qcenoZ65u49+KTUNWAkMKjUq09eVePvbfqSjJYOY5KeyIlqAM
         OIrf6P7V3w9jAAdHMa4b3LyPAsArfMrIudNLMMLxc+tzbI5xZuAu/i2wuHXR4fxGTrrR
         sd/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712089534; x=1712694334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wEISoDaReVBYlihnUfkRNegSHCa1fOWz9Nfv9lbetO4=;
        b=c5IbqHD5pTr0ZyRcjeLE2AAhHjfpBUqoytd8q8uwCuf/vEd3oe+mBflhT2pD9lBBXa
         9sIe6kK5ThJuruG/re0aen3bzbY/u7VXm6ZqKqHfgyr1j9WENPizv0LstNnS0lAzdniA
         Dakwd3qXQoDgOTuZgoWv8Cp9zk+BfN/mBy9FgH/V5lClXjweTQ34EPX2bGhRzv5qBJaV
         LmjHY7NjMy03/dVOtP9ARuVCryQTud6FXm5MBDB5p0Ux145u21oBbT77CxvMd5eAl1k9
         lkwJewL7/ZkK8Dl9NHD84Bnh5lWVaKDDqys6D7XfHyxKNnE6tdMyZ+h55BGevfuekP+z
         hxhA==
X-Gm-Message-State: AOJu0Yy6DAIa0Ipq3fYtxPf++U43fOuJ5hAgp98O/hPVJMKcqb0VZWbZ
	vM0pDL1iUG4/kQ5QTjsZNRwL1mBFT3INW4lAjV/OfEKJPGFe3UoKAoalSR8TaRSVvKxwfwtC/32
	l
X-Google-Smtp-Source: AGHT+IGJehSXeir2a4opOIryK4i/S+JB9yIPvNU+R1MfGhn5Hq5ofPKNTd0bOyXRTrjF2tYhZksXHA==
X-Received: by 2002:a6b:6d16:0:b0:7d0:c0e7:b577 with SMTP id a22-20020a6b6d16000000b007d0c0e7b577mr7956587iod.2.1712089534576;
        Tue, 02 Apr 2024 13:25:34 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id u9-20020a02cbc9000000b0047ec029412fsm3445956jaq.12.2024.04.02.13.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 13:25:33 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/3] signalfd: convert to ->read_iter()
Date: Tue,  2 Apr 2024 14:18:23 -0600
Message-ID: <20240402202524.1514963-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240402202524.1514963-1-axboe@kernel.dk>
References: <20240402202524.1514963-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rather than use the older style ->read() hook, use ->read_iter() so that
signalfd can support both O_NONBLOCK and IOCB_NOWAIT for non-blocking
read attempts.

Split the fd setup into two parts, so that signalfd can mark the file
mode with FMODE_NOWAIT before installing it into the process table.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/signalfd.c | 44 ++++++++++++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/fs/signalfd.c b/fs/signalfd.c
index e20d1484c663..9b4ff83d816d 100644
--- a/fs/signalfd.c
+++ b/fs/signalfd.c
@@ -68,8 +68,7 @@ static __poll_t signalfd_poll(struct file *file, poll_table *wait)
 /*
  * Copied from copy_siginfo_to_user() in kernel/signal.c
  */
-static int signalfd_copyinfo(struct signalfd_siginfo __user *uinfo,
-			     kernel_siginfo_t const *kinfo)
+static int signalfd_copyinfo(struct iov_iter *to, kernel_siginfo_t const *kinfo)
 {
 	struct signalfd_siginfo new;
 
@@ -146,10 +145,7 @@ static int signalfd_copyinfo(struct signalfd_siginfo __user *uinfo,
 		break;
 	}
 
-	if (copy_to_user(uinfo, &new, sizeof(struct signalfd_siginfo)))
-		return -EFAULT;
-
-	return sizeof(*uinfo);
+	return copy_to_iter(&new, sizeof(struct signalfd_siginfo), to);
 }
 
 static ssize_t signalfd_dequeue(struct signalfd_ctx *ctx, kernel_siginfo_t *info,
@@ -199,25 +195,26 @@ static ssize_t signalfd_dequeue(struct signalfd_ctx *ctx, kernel_siginfo_t *info
  * error code. The "count" parameter must be at least the size of a
  * "struct signalfd_siginfo".
  */
-static ssize_t signalfd_read(struct file *file, char __user *buf, size_t count,
-			     loff_t *ppos)
+static ssize_t signalfd_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
+	struct file *file = iocb->ki_filp;
 	struct signalfd_ctx *ctx = file->private_data;
 	struct signalfd_siginfo __user *siginfo;
-	int nonblock = file->f_flags & O_NONBLOCK;
+	size_t count = iov_iter_count(to);
 	ssize_t ret, total = 0;
 	kernel_siginfo_t info;
+	bool nonblock;
 
 	count /= sizeof(struct signalfd_siginfo);
 	if (!count)
 		return -EINVAL;
 
-	siginfo = (struct signalfd_siginfo __user *) buf;
+	nonblock = file->f_flags & O_NONBLOCK || iocb->ki_flags & IOCB_NOWAIT;
 	do {
 		ret = signalfd_dequeue(ctx, &info, nonblock);
 		if (unlikely(ret <= 0))
 			break;
-		ret = signalfd_copyinfo(siginfo, &info);
+		ret = signalfd_copyinfo(to, &info);
 		if (ret < 0)
 			break;
 		siginfo++;
@@ -246,7 +243,7 @@ static const struct file_operations signalfd_fops = {
 #endif
 	.release	= signalfd_release,
 	.poll		= signalfd_poll,
-	.read		= signalfd_read,
+	.read_iter	= signalfd_read_iter,
 	.llseek		= noop_llseek,
 };
 
@@ -265,20 +262,35 @@ static int do_signalfd4(int ufd, sigset_t *mask, int flags)
 	signotset(mask);
 
 	if (ufd == -1) {
+		struct file *file;
+
 		ctx = kmalloc(sizeof(*ctx), GFP_KERNEL);
 		if (!ctx)
 			return -ENOMEM;
 
 		ctx->sigmask = *mask;
 
+		ufd = get_unused_fd_flags(O_RDWR |
+					  (flags & (O_CLOEXEC | O_NONBLOCK)));
+		if (ufd < 0) {
+			kfree(ctx);
+			return ufd;
+		}
+
+		file = anon_inode_getfile("[signalfd]", &signalfd_fops, ctx,
+				       O_RDWR | (flags & (O_CLOEXEC | O_NONBLOCK)));
+		if (IS_ERR(file)) {
+			put_unused_fd(ufd);
+			kfree(ctx);
+			return ufd;
+		}
+		file->f_mode |= FMODE_NOWAIT;
+
 		/*
 		 * When we call this, the initialization must be complete, since
 		 * anon_inode_getfd() will install the fd.
 		 */
-		ufd = anon_inode_getfd("[signalfd]", &signalfd_fops, ctx,
-				       O_RDWR | (flags & (O_CLOEXEC | O_NONBLOCK)));
-		if (ufd < 0)
-			kfree(ctx);
+		fd_install(ufd, file);
 	} else {
 		struct fd f = fdget(ufd);
 		if (!f.file)
-- 
2.43.0


