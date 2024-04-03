Return-Path: <linux-fsdevel+bounces-16031-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5008971F4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 16:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5093FB2ABEC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 14:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F471494BB;
	Wed,  3 Apr 2024 14:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Su8LpXo+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FC7148FF1
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Apr 2024 14:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712153094; cv=none; b=ANTCyNknG5rY62Zb3uzkU+L7wZso7X5QR1bMj03IVmls7rjS5yHTIuYLdJo39cdU12elCq4hqS0tcOSAipfx6V+WxwW9VRZhCH9jpRC57oI9GItZQWm2FugOdxmqDTQe4fVFDYLYSBEtYCULaO5+qfIjhayxaJ1dWVlX3xN1eCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712153094; c=relaxed/simple;
	bh=nKnUH95th5iYE+E4iFcTgJ/16TGJIT26Qlwp258+K5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uOyytkQqxx4GWxFzDmQW+NQKHcDmGSsX828yM/iNzmPQhDnwco9ufiPiZJG/OSq5JtzuV1PGHOzJcbPvzABHVpHYfwPi3W0oezgaGQtLeZqn3ZiJ2gNZ4K6uMReSTKT4heKWxn/Iad6/Lg0xkpM6KyQc6z7hQP95VdjeEJMzvHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Su8LpXo+; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-369f8526c85so323125ab.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Apr 2024 07:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712153092; x=1712757892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0FZepTNIuSDeEcz8U+UNewgZo+OZhoLKPwuweNfu0j4=;
        b=Su8LpXo+iaQgc5KHnGAZQxWAVgnI4jhgA6qwGfcN86I2hFcui6Vlxo7YrKANwPqwzs
         jtNs6+aOAyx0bDE0xyYrgjIIeciXPCTyCemNH5ubb8PkKfHeI8SV0h8hHGJ4pEZwHYph
         ljhuV7CXvhZmoXxc8cHxaZOwfw5GPdedQjUgPXP1kgqwKDQe2bpArO4wKFmkTMxs4J5g
         K2bMXk0mBYCOjOMATX+2NDEvchOfkiqXIIyrvrnAl0j0/8QnlgEAs83t4XPXrz9P7jMf
         +XOCVv9nagwHM28LStvtmjnnqLPFDjbrwGxqxgY+GpVaMmCW3CRf/Dpwy4gvfTrzUxuC
         K45g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712153092; x=1712757892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0FZepTNIuSDeEcz8U+UNewgZo+OZhoLKPwuweNfu0j4=;
        b=G4WRQw7+Z5WsaCHJ4eLeOw08cVFz2dRVEhDIUevbpN/TFeNuCWfbAm9cgKcEtW+pQq
         B3V5H6sx+An6brTrS9/ow7FmzMBtHrjOWeikY3mJxFvQ5NiOqU92J9DqFD9D1kND7kYy
         60DXIO+cD3fnirgxpNuGvgcdob+K4GzvqbGSuUTXibcotvtl+MKrXxVBx3VvEyzNAlsY
         2exzjYOuyIpdTxMbDuSNXDlSz8fh6u2NiLzTyzONgGo4nqH3sQe7ygKOhK/8nRNoolJb
         672w2vIpJk085xFqD6wxi10rJ1IM+3a2B52iADqr7MjGzejn2Ew3KGEB4RUasAfXxHfI
         ZF9w==
X-Gm-Message-State: AOJu0YzLaVeXjEv8/me/ErO23OCvQJl0/GsJVcD9lLRbTrBRALH05cEj
	AqzVJT7AaG2FGXFm/59bH/N6yGrVAdAZPMb1XuQNnOUwelbpqAKqGTCBuol5jWlvQizEiObQWfC
	e
X-Google-Smtp-Source: AGHT+IH3lPKHfU1vOwHJ/4ZtYjlERZYHr6v/CLWGbUSbvDeAFa+fQqeqsFzVoIPeJCMXReEoqMi23Q==
X-Received: by 2002:a05:6e02:2218:b0:365:2bd4:2f74 with SMTP id j24-20020a056e02221800b003652bd42f74mr17975319ilf.0.1712153091747;
        Wed, 03 Apr 2024 07:04:51 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id a3-20020a056638164300b0047ef3ea2bdfsm2027098jat.78.2024.04.03.07.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 07:04:50 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/3] timerfd: convert to ->read_iter()
Date: Wed,  3 Apr 2024 08:02:52 -0600
Message-ID: <20240403140446.1623931-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403140446.1623931-1-axboe@kernel.dk>
References: <20240403140446.1623931-1-axboe@kernel.dk>
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


