Return-Path: <linux-fsdevel+bounces-16454-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 562E489DF02
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 17:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A22B288D96
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 15:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC8913AD21;
	Tue,  9 Apr 2024 15:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="VNU7G2WX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93119137C24
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Apr 2024 15:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712676287; cv=none; b=O3wpWnLjXHpchitKfxfWOUoXBaMeHYUwjy2BNsxQpUAJXmSJ8D8OoOPmc8GMxeZduCXAxaqbsGMXgqif5LFnk+iJ+95PO3E5aFXJrc67fVkthgZJc7z3huuvM9fIrXXbrmqisXkEez1YwTPpPLE1BzeEYsNsZruDPs5zcmU5cuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712676287; c=relaxed/simple;
	bh=rWWuEYi9ShXfHZjkkkoQhNS8w7ijwDS4w1AKkq3X00g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lv+v0c/IrBWjjYXR8wy9B0nPe6PGzrHUozY0VIGiVVsRLGZGExeGMoF+5g0mJAivXUeEWesqlqXtienZpyo1PQJdJHlj7BcaN31h5BMwFnLZ7xT3kMQfiBmuC4TS/w5khvhfAB1te7BkfIsx4as7EXdrg0dBomSp6jKxZCcOx0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=VNU7G2WX; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2a532498cc5so537294a91.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Apr 2024 08:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712676284; x=1713281084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jsdceta1AaxRkUhJQPij5NrIk0Ek1AVLknMfi/yNTxc=;
        b=VNU7G2WXIpl+VxtWSq919rpi+aNwX5MxtLmNBIE5Awc7q4qf18aEQkzLUGjZgHCLI3
         L5UUJSiRlJ0wyTPy2zggwjWJrhrxfG3Pzn2vPrZh4X3S+tCwSFyb5rYZoSE5RDl6uRgQ
         uW2iX0aXyKbKFbNB0CsZfdDQ0EwvO8OWgCBaE5w+lD6HJvCrb1ivIBqeApPSif+MICgC
         dKqu4Jb1GRAL6gRPmHLt/HAgGHywMiF+8PSamZBVZSuElCZ+U4RGpoWimPk0Fd0nyDQ0
         OgY+HDhcivRin8QIqVtu103o50+pG6rXxqn7l9Qi5F30N7vbyS+9ne7tnweT08wUJfhP
         uYNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712676284; x=1713281084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jsdceta1AaxRkUhJQPij5NrIk0Ek1AVLknMfi/yNTxc=;
        b=gzzMD3QgBCWYbiG63IyF8FJ/0FnNvL5jn5RZDmCd/CYA5MFJc4dUrjMFvzMuSy3+A6
         MgWKSk7vl3+ptF72JZja9nKW29OSE3x/ZpCJgi+wgr/IQkXpU9CliRU/Kz7AVriED+MK
         64smuugja6LrLmDbtKp8LeqTJBBKSb1ZN8IXsEUn190K2LcJB5xP8QFvATd5/+uV0UeZ
         usacH34CoEhgQaD1cDtfD9SCNat3gMzgI06gAl435QXz86bBIHJ1SSu/Le4iCXjEf/ag
         AOJLeLB2/hxIAKBXqxGamClDM4k/4sXtfBWFvvjyA6P5vK9LHZk1g5ejAS/kB9vIeeoh
         jzVg==
X-Gm-Message-State: AOJu0YyMgDliy1HDqm1TCIkLwFUjB3YyECT68nf01Sxg+aDivxbepLlu
	fB2XTO9KPZkEvp6GFZ2/fU/i7ZSxdCPCNfEAObaIiYclpmspBxuFum08eIVCMk+c4Dg3BI1f7Kf
	h
X-Google-Smtp-Source: AGHT+IFg1ehXZz9w6GoGvEWU+n/J/Z6E+G0lahpjmT0VcsXojamezh1lQriskRTyuGcovOQMhHnIJQ==
X-Received: by 2002:a17:90a:8988:b0:29c:7697:d2dc with SMTP id v8-20020a17090a898800b0029c7697d2dcmr11491534pjn.4.1712676284393;
        Tue, 09 Apr 2024 08:24:44 -0700 (PDT)
Received: from localhost.localdomain ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id ev6-20020a17090aeac600b002a513cc466esm3945558pjb.45.2024.04.09.08.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 08:24:43 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/4] timerfd: convert to ->read_iter()
Date: Tue,  9 Apr 2024 09:22:16 -0600
Message-ID: <20240409152438.77960-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240409152438.77960-1-axboe@kernel.dk>
References: <20240409152438.77960-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch timerfd to using fops->read_iter(), so it can support not just
O_NONBLOCK but IOCB_NOWAIT as well. With the latter, users like io_uring
interact with timerfds a lot better, as they can be driven purely
by the poll trigger.

Manually get and install the required fd, so that FMODE_NOWAIT can be
set before the file is installed into the file table.

No functional changes intended in this patch, it's purely a straight
conversion to using the read iterator method.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/timerfd.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/fs/timerfd.c b/fs/timerfd.c
index e9c96a0c79f1..f0d82dcbffef 100644
--- a/fs/timerfd.c
+++ b/fs/timerfd.c
@@ -262,17 +262,18 @@ static __poll_t timerfd_poll(struct file *file, poll_table *wait)
 	return events;
 }
 
-static ssize_t timerfd_read(struct file *file, char __user *buf, size_t count,
-			    loff_t *ppos)
+static ssize_t timerfd_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
+	struct file *file = iocb->ki_filp;
 	struct timerfd_ctx *ctx = file->private_data;
 	ssize_t res;
 	u64 ticks = 0;
 
-	if (count < sizeof(ticks))
+	if (iov_iter_count(to) < sizeof(ticks))
 		return -EINVAL;
+
 	spin_lock_irq(&ctx->wqh.lock);
-	if (file->f_flags & O_NONBLOCK)
+	if (file->f_flags & O_NONBLOCK || iocb->ki_flags & IOCB_NOWAIT)
 		res = -EAGAIN;
 	else
 		res = wait_event_interruptible_locked_irq(ctx->wqh, ctx->ticks);
@@ -312,8 +313,8 @@ static ssize_t timerfd_read(struct file *file, char __user *buf, size_t count,
 		ctx->ticks = 0;
 	}
 	spin_unlock_irq(&ctx->wqh.lock);
-	if (ticks)
-		res = put_user(ticks, (u64 __user *) buf) ? -EFAULT: sizeof(ticks);
+	if (ticks && !copy_to_iter_full(&ticks, sizeof(ticks), to))
+		res = -EFAULT;
 	return res;
 }
 
@@ -384,7 +385,7 @@ static long timerfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg
 static const struct file_operations timerfd_fops = {
 	.release	= timerfd_release,
 	.poll		= timerfd_poll,
-	.read		= timerfd_read,
+	.read_iter	= timerfd_read_iter,
 	.llseek		= noop_llseek,
 	.show_fdinfo	= timerfd_show,
 	.unlocked_ioctl	= timerfd_ioctl,
@@ -407,6 +408,7 @@ SYSCALL_DEFINE2(timerfd_create, int, clockid, int, flags)
 {
 	int ufd;
 	struct timerfd_ctx *ctx;
+	struct file *file;
 
 	/* Check the TFD_* constants for consistency.  */
 	BUILD_BUG_ON(TFD_CLOEXEC != O_CLOEXEC);
@@ -443,11 +445,22 @@ SYSCALL_DEFINE2(timerfd_create, int, clockid, int, flags)
 
 	ctx->moffs = ktime_mono_to_real(0);
 
-	ufd = anon_inode_getfd("[timerfd]", &timerfd_fops, ctx,
-			       O_RDWR | (flags & TFD_SHARED_FCNTL_FLAGS));
-	if (ufd < 0)
+	ufd = get_unused_fd_flags(flags & TFD_SHARED_FCNTL_FLAGS);
+	if (ufd < 0) {
 		kfree(ctx);
+		return ufd;
+	}
+
+	file = anon_inode_getfile("[timerfd]", &timerfd_fops, ctx,
+				    O_RDWR | (flags & TFD_SHARED_FCNTL_FLAGS));
+	if (IS_ERR(file)) {
+		put_unused_fd(ufd);
+		kfree(ctx);
+		return PTR_ERR(file);
+	}
 
+	file->f_mode |= FMODE_NOWAIT;
+	fd_install(ufd, file);
 	return ufd;
 }
 
-- 
2.43.0


