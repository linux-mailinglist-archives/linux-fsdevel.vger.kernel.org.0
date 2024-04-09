Return-Path: <linux-fsdevel+bounces-16456-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A632789DF08
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 17:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A9C01F23AF3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 15:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D98A13BC0A;
	Tue,  9 Apr 2024 15:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="gwF1hrwX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DB913B2A5
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Apr 2024 15:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712676290; cv=none; b=pXf/H3Ljkt3INR4tmYhZkPyYFc4encvmZ0ynynd01809aHvtPJwijY2CtBp27Uf82isB8B4Ct0DausVD75X2wXIs6cpbNmtj1D0Gr1N2LvbulvBrU7SJsYqstb1ZPnUCGXbEp2rFxp8ji6s2i3gd3BPZKVq2tgQ9GwCq7yRiM84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712676290; c=relaxed/simple;
	bh=Efu3b8ru21S0lD5Y5zsjwcGOYAOC7NOARCbE3B0sUCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tWxCGIT/T4Yt4OWN/3uTq1/f9nimh0b1elRb38JbdVab1vMPoiXKJB8LUuiT/Y4sDLRehd5mPZIbKSlfpM3Ay3LCGhHKUuF4g3FPy8Y6Y4QPNaTfVZUcVuU8cLw15QkQLeQ4jiUsWBwoGYbXA0mY9IKbNKOPLopdPIVBxDKVi18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=gwF1hrwX; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e694337fffso1158909b3a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Apr 2024 08:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712676288; x=1713281088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E0BoB0+iqRCepoqzaDLrQ1/6U1zOxuhY81V8gRabkwc=;
        b=gwF1hrwXAiD3TmmIefe+QCwKV9T0Q4UGEbgqoReYIXQhDnZ77cC/Jwv2SenUcMKQ6t
         VgmF8DNK6gmpLaZwxApHJMECImF9dgNWIsB9ulXFBjB0YhdIrhWwS/R+NXX6ElDwSlHH
         rKHgFeJLTR4emwluwfSP7VJBLXDcBNKAfQjQcXVBY2xNAMO4la/AFn9logRz+f48My5t
         xppTDBGUFY8SYfk/cAJ+rOoa+v3XZ6pDRKbQcdiEGQDRuELzcRPzurbYlG64vKCRtM/F
         3zt1REap02THPzQJRTWRx+LtMUiovxyk+SjFEBGoIupnO4VcS1rabJWQos1EL1SbkZ7R
         YX8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712676288; x=1713281088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E0BoB0+iqRCepoqzaDLrQ1/6U1zOxuhY81V8gRabkwc=;
        b=NR3b9cyIvqrFpX2mrCwkprwq1FwaPwVfY9KsjNdElPa1oM8A8HeRvL0UOX53RyXw+F
         /dCJzVEK6PAKfeXUWHKigoNp4kg450p9YYKsih9AIMf4m4nWCR3CdHIDD9sSqdTv77Hr
         B3z+8QxlxEyyF4mO1nRQK1VsN44/lrCChNAeoqwPZ3pDwPUtRxEVVTEHzAQYsWvGqSkm
         2mPnBuKwPx4415sfbN/EgS9Mgsk//l/yvrC3gcuqhSDw5Rh2y3WD7hL8GTxhc3mKyIaa
         pZJLZLc91kOhiMdS26fFKwLhc98MTX9GAR+qe2oDGnkvfeDFLNb8qumPoHW2rk+UOgGG
         C5vw==
X-Gm-Message-State: AOJu0YzK4fbWCyouuZ2+RwP4CIVbda/5Ktp8iZgkdJ0gB1wWNF2mB1Ac
	B7KQagiCRg7FNFUj35cDq2vlGJdQvwXSBwzvtTmycvtiNhEM1OYbu8bUbuRXBPtBgdLsCsFYtWD
	e
X-Google-Smtp-Source: AGHT+IESaWswrduf3sLVbA5ib5/pMDBwW8iN7ZUU3AI4oslIDVZKjcURQLDu0lwwVU4+E5t/zf46CA==
X-Received: by 2002:a05:6a20:4323:b0:1a7:199:8ac5 with SMTP id h35-20020a056a20432300b001a701998ac5mr151095pzk.4.1712676288122;
        Tue, 09 Apr 2024 08:24:48 -0700 (PDT)
Received: from localhost.localdomain ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id ev6-20020a17090aeac600b002a513cc466esm3945558pjb.45.2024.04.09.08.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 08:24:46 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4/4] signalfd: convert to ->read_iter()
Date: Tue,  9 Apr 2024 09:22:18 -0600
Message-ID: <20240409152438.77960-5-axboe@kernel.dk>
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
index e20d1484c663..4a5614442dbf 100644
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
 
@@ -146,10 +145,10 @@ static int signalfd_copyinfo(struct signalfd_siginfo __user *uinfo,
 		break;
 	}
 
-	if (copy_to_user(uinfo, &new, sizeof(struct signalfd_siginfo)))
+	if (!copy_to_iter_full(&new, sizeof(struct signalfd_siginfo), to))
 		return -EFAULT;
 
-	return sizeof(*uinfo);
+	return sizeof(struct signalfd_siginfo);
 }
 
 static ssize_t signalfd_dequeue(struct signalfd_ctx *ctx, kernel_siginfo_t *info,
@@ -199,28 +198,27 @@ static ssize_t signalfd_dequeue(struct signalfd_ctx *ctx, kernel_siginfo_t *info
  * error code. The "count" parameter must be at least the size of a
  * "struct signalfd_siginfo".
  */
-static ssize_t signalfd_read(struct file *file, char __user *buf, size_t count,
-			     loff_t *ppos)
+static ssize_t signalfd_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
+	struct file *file = iocb->ki_filp;
 	struct signalfd_ctx *ctx = file->private_data;
-	struct signalfd_siginfo __user *siginfo;
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
-		siginfo++;
 		total += ret;
 		nonblock = 1;
 	} while (--count);
@@ -246,7 +244,7 @@ static const struct file_operations signalfd_fops = {
 #endif
 	.release	= signalfd_release,
 	.poll		= signalfd_poll,
-	.read		= signalfd_read,
+	.read_iter	= signalfd_read_iter,
 	.llseek		= noop_llseek,
 };
 
@@ -265,20 +263,34 @@ static int do_signalfd4(int ufd, sigset_t *mask, int flags)
 	signotset(mask);
 
 	if (ufd == -1) {
+		struct file *file;
+
 		ctx = kmalloc(sizeof(*ctx), GFP_KERNEL);
 		if (!ctx)
 			return -ENOMEM;
 
 		ctx->sigmask = *mask;
 
+		ufd = get_unused_fd_flags(flags & O_CLOEXEC);
+		if (ufd < 0) {
+			kfree(ctx);
+			return ufd;
+		}
+
+		file = anon_inode_getfile("[signalfd]", &signalfd_fops, ctx,
+				       O_RDWR | (flags & O_NONBLOCK));
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


