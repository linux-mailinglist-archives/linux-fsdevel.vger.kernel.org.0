Return-Path: <linux-fsdevel+bounces-15927-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE19D895D87
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 22:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 214791F22ACB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 20:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98EB615E1E6;
	Tue,  2 Apr 2024 20:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="2gtWnPGf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B5C15D5C1
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Apr 2024 20:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712089534; cv=none; b=tuzsbT6IaPGxrXGXb/FL1B0qpNXPPbRT7XVEcCWhkxol/xvmn61W9BCp91YqyE/FZ86nlguHPc45+w8bQiyf9zz/r3xNqBfikgYddezxHp3ElawPtvR2talZXUiUmYitWeqx0u6GWlCXgMZyIVHmK+oITh2pEJKt4beu7HAYEKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712089534; c=relaxed/simple;
	bh=nKnUH95th5iYE+E4iFcTgJ/16TGJIT26Qlwp258+K5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ns+BfVPgPVA3vcFL2BAkn4At6j/+c7zkNd+CXfpzmiXGfTleORa/IY4bYYzkz7g2b/HFkLTu/Pxb5PIEBMCeXqqT+PItB/XhBcnTTYvPv+t9LN3bu6fzcuJD2GX8xdakrSO4VzbJ/++eNnuT0Ugz5AhdiBV176ehXDjH6H1jlN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=2gtWnPGf; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7cc0e831e11so42168239f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Apr 2024 13:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712089531; x=1712694331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0FZepTNIuSDeEcz8U+UNewgZo+OZhoLKPwuweNfu0j4=;
        b=2gtWnPGf5fqzADevdBAFp2Ldv/vvHexZ0YgDDDUHikM1VtL+bIGWOifz9I3kY52S/W
         cuL2TdVyELFAxPXlCTP1VG20bRS5eEj3uj/SuDZoF8ssZ9iwVkmTJxwYN8kYL1OJWkik
         GxHH9A2qx7g5XojFDK9wv+3jpbjV5puKvrtJCnMKcmFNdNdJ3JV7iFvr6igvpftZAmKb
         5rfU0rRzAgHKtWRm4jBUVKFobvtPeoufGeGtTBvDRBmMWKVgvQ9eS9+tCYJtpGTYxPcQ
         4JrCnsNWUh/Yfg04LBUunmXJUtmhfwaan9vLICa3AVX96mTuWxNZWrYf0iiyBHj469WS
         G5tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712089531; x=1712694331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0FZepTNIuSDeEcz8U+UNewgZo+OZhoLKPwuweNfu0j4=;
        b=Gxx8tWCx8hAbdNQW8JCfHAA7x8D9XrA9WdIVdwXUG3UgG5E/vHqy4HsDteFG3cpQLP
         H092zy07sRxYnUViAfSPRkmMjvRgc4SQDjDb/jkpokMg9PPXS9DjU55VsvOwGZmiB63A
         CoxayzQcr17GInro91mTgfUU0bHlDu/OWYZ/WiBYa1XAX8emmHxavdt+a4U+H9FBBUNE
         MSMmOqFODo/kIGklmy5GwQuLwhpZDd9EeAhc7o/lbg0r26mNyDBeewHFnqi3DCS4iDhm
         /HnD3fJxiVJQjnpiZsohF0FFaOUnL82wHxy75rvlbRax/T48VejCRmIJvOxOpm2orEp7
         ROHQ==
X-Gm-Message-State: AOJu0YzlIdu66d4XuD3zIdtL3KaDuZhEqkA6OvH0z2SKJOY5xv4jfK6M
	eVjGjdp1qjJtCafnDuB/VH3LBM0KTXhvv2S3abMAYKjRK+B5GzM6jqPye9Idn5YtkTf9kv+wICg
	6
X-Google-Smtp-Source: AGHT+IFF7DMoRqbCY2mzvlWMvINoCoSms6BJpXeiJeD49z0rUXhgZSmI6hVa5k8tSH1ih5v7pQIr3Q==
X-Received: by 2002:a6b:6d16:0:b0:7d0:c0e7:b577 with SMTP id a22-20020a6b6d16000000b007d0c0e7b577mr7956399iod.2.1712089530753;
        Tue, 02 Apr 2024 13:25:30 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id u9-20020a02cbc9000000b0047ec029412fsm3445956jaq.12.2024.04.02.13.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 13:25:29 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/3] timerfd: convert to ->read_iter()
Date: Tue,  2 Apr 2024 14:18:21 -0600
Message-ID: <20240402202524.1514963-2-axboe@kernel.dk>
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
 fs/timerfd.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/fs/timerfd.c b/fs/timerfd.c
index e9c96a0c79f1..b96690b46c1f 100644
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
@@ -313,7 +314,7 @@ static ssize_t timerfd_read(struct file *file, char __user *buf, size_t count,
 	}
 	spin_unlock_irq(&ctx->wqh.lock);
 	if (ticks)
-		res = put_user(ticks, (u64 __user *) buf) ? -EFAULT: sizeof(ticks);
+		res = copy_to_iter(&ticks, sizeof(ticks), to);
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
+	ufd = get_unused_fd_flags(O_RDWR | (flags & TFD_SHARED_FCNTL_FLAGS));
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


