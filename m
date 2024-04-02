Return-Path: <linux-fsdevel+bounces-15928-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D9C895D89
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 22:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96C0328A93F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 20:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF3F15E209;
	Tue,  2 Apr 2024 20:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="d4IitUln"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2A215DBC4
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Apr 2024 20:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712089535; cv=none; b=aV9k5R2x8MXr1WoBKzgtPO/Bfva2whxTXDIo/aIetEJOsLZnFYwLFBmeehdCwsI1Q+wHjH8uXqUGVD9Y20zBGVhPy1ICCrnn2FYH1YSE2k9MEPQbSqfhRRIVJATpdHZ+Ui5cgOG18EnYx2Tn5CThti0u3K4U/VbUovKLp4ThH8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712089535; c=relaxed/simple;
	bh=OIR2Y5io1QhHTLei1BSk8STk0MqP9Cy7Pory5o7tlKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BwSXOEfWem8olfk5ij5KH8d5V9QQSAdb7Cy9K62cBlropxwAnKTU4VnTeFgVe45cmee9b8ZHVr7ErjP+Bz+2QCxkF15odw6RrFl6gTXoxyzWvADZufotYL42MsFxQL9YQrv5HtalP3+/RCSsDNgLDJNA2PBlHck34zcsE6SPlDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=d4IitUln; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7cc0e831e11so42169039f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Apr 2024 13:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712089532; x=1712694332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xLz/H2XFRBrWVV5Gb4xnS/5GtE0qd548o457X3QGvso=;
        b=d4IitUlno+PuogJ8NCl7dVSEOq176jVoZrWzBNZXyTbn/swjwxqIvBtrZOi891h0pY
         lIKtL79G7INaAgvEVMCcIKvG9BwpqaytpNNXz5WPdGVwTQY+17iJJmG1zqeh97XImOO/
         Bd/m92nwuMJ3fGAhDT+vKpMQGwpjGki1ZCafFw+dFzU+ul7h/BrGHC6GfCI7Ec+rL+Wg
         P6UGtibQAdiIyIqQWaUxRONMT8Do8YVJBoSqfgLpSf9jqRe2dkT2SFAHe1hG42kvfIMN
         4fPy7eDnm/OsHSi6v2IAnF/IzMqGRuhJPvugqktAiXVm3tP87YKBMjuI6j4sgpxU0yfD
         gT4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712089532; x=1712694332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xLz/H2XFRBrWVV5Gb4xnS/5GtE0qd548o457X3QGvso=;
        b=AVpXdo0qepnGMv9pQkdHX8bnBkQGcvDPahgt5nq1e6ZNzBbNKUi5NQk+tvj4cLgGMp
         ztDsw+uie0ZjfSafaTwFYjC7+6o31sTGC8c7HdsI9RTGeDY/vFu/6AafdRLDWF6t6Hv1
         px11mqO2/4z3cC1hq4BatOoOLjSWTmzi6OMHJf40iG6vDcj6SyAxuRnlNisgiSW9Qx5x
         jlca5sJjye32nb9DKQ0S2uxF+q1r0P/XZjpI/PcY9BIPoMcXgD6o3xaY8+u/h0zynnst
         S/nMhGfSF8i60DoEQ4+pZmjl8T9xgzvbxB40sIQhCZJyBLcSYRFS2Fm+n7BECrr6tCv+
         0npw==
X-Gm-Message-State: AOJu0YykPINsEcuSpPoSPLtNPs9/iknZb12LMqkPO0TNl2vCYi45K+Sp
	bKYI+ZlUImEcF55tuBqaYdbloGnqwTFXHB5oXO/f9AYxCAcw5FwrlJO1ilzvllOCJEE6y35gPwO
	d
X-Google-Smtp-Source: AGHT+IHYbMpQf4s8TRlHSc+tS+jQrOmVzcT6LSF5ihsLdx9ND8J3x+gOfbJS39lohHw+Z7Bh3px49w==
X-Received: by 2002:a6b:c949:0:b0:7d0:bd2b:43ba with SMTP id z70-20020a6bc949000000b007d0bd2b43bamr9340547iof.0.1712089532551;
        Tue, 02 Apr 2024 13:25:32 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id u9-20020a02cbc9000000b0047ec029412fsm3445956jaq.12.2024.04.02.13.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 13:25:31 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/3] userfaultfd: convert to ->read_iter()
Date: Tue,  2 Apr 2024 14:18:22 -0600
Message-ID: <20240402202524.1514963-3-axboe@kernel.dk>
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
userfaultfd can support both O_NONBLOCK and IOCB_NOWAIT for non-blocking
read attempts.

Split the fd setup into two parts, so that userfaultfd can mark the file
mode with FMODE_NOWAIT before installing it into the process table. With
that, we can also defer grabbing the mm until we know the rest will
succeed, as the fd isn't visible before then.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/userfaultfd.c | 42 ++++++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 60dcfafdc11a..7864c2dba858 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -282,7 +282,7 @@ static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
 /*
  * Verify the pagetables are still not ok after having reigstered into
  * the fault_pending_wqh to avoid userland having to UFFDIO_WAKE any
- * userfault that has already been resolved, if userfaultfd_read and
+ * userfault that has already been resolved, if userfaultfd_read_iter and
  * UFFDIO_COPY|ZEROPAGE are being run simultaneously on two different
  * threads.
  */
@@ -1177,34 +1177,34 @@ static ssize_t userfaultfd_ctx_read(struct userfaultfd_ctx *ctx, int no_wait,
 	return ret;
 }
 
-static ssize_t userfaultfd_read(struct file *file, char __user *buf,
-				size_t count, loff_t *ppos)
+static ssize_t userfaultfd_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
+	struct file *file = iocb->ki_filp;
 	struct userfaultfd_ctx *ctx = file->private_data;
 	ssize_t _ret, ret = 0;
 	struct uffd_msg msg;
-	int no_wait = file->f_flags & O_NONBLOCK;
 	struct inode *inode = file_inode(file);
+	bool no_wait;
 
 	if (!userfaultfd_is_initialized(ctx))
 		return -EINVAL;
 
+	no_wait = file->f_flags & O_NONBLOCK || iocb->ki_flags & IOCB_NOWAIT;
 	for (;;) {
-		if (count < sizeof(msg))
+		if (iov_iter_count(to) < sizeof(msg))
 			return ret ? ret : -EINVAL;
 		_ret = userfaultfd_ctx_read(ctx, no_wait, &msg, inode);
 		if (_ret < 0)
 			return ret ? ret : _ret;
-		if (copy_to_user((__u64 __user *) buf, &msg, sizeof(msg)))
+		_ret = copy_to_iter(&msg, sizeof(msg), to);
+		if (_ret < 0)
 			return ret ? ret : -EFAULT;
 		ret += sizeof(msg);
-		buf += sizeof(msg);
-		count -= sizeof(msg);
 		/*
 		 * Allow to read more than one fault at time but only
 		 * block if waiting for the very first one.
 		 */
-		no_wait = O_NONBLOCK;
+		no_wait = true;
 	}
 }
 
@@ -2172,7 +2172,7 @@ static const struct file_operations userfaultfd_fops = {
 #endif
 	.release	= userfaultfd_release,
 	.poll		= userfaultfd_poll,
-	.read		= userfaultfd_read,
+	.read_iter	= userfaultfd_read_iter,
 	.unlocked_ioctl = userfaultfd_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
 	.llseek		= noop_llseek,
@@ -2192,6 +2192,7 @@ static void init_once_userfaultfd_ctx(void *mem)
 static int new_userfaultfd(int flags)
 {
 	struct userfaultfd_ctx *ctx;
+	struct file *file;
 	int fd;
 
 	BUG_ON(!current->mm);
@@ -2215,16 +2216,25 @@ static int new_userfaultfd(int flags)
 	init_rwsem(&ctx->map_changing_lock);
 	atomic_set(&ctx->mmap_changing, 0);
 	ctx->mm = current->mm;
-	/* prevent the mm struct to be freed */
-	mmgrab(ctx->mm);
+
+	fd = get_unused_fd_flags(O_RDONLY | (flags & UFFD_SHARED_FCNTL_FLAGS));
+	if (fd < 0)
+		goto err_out;
 
 	/* Create a new inode so that the LSM can block the creation.  */
-	fd = anon_inode_create_getfd("[userfaultfd]", &userfaultfd_fops, ctx,
+	file = anon_inode_create_getfile("[userfaultfd]", &userfaultfd_fops, ctx,
 			O_RDONLY | (flags & UFFD_SHARED_FCNTL_FLAGS), NULL);
-	if (fd < 0) {
-		mmdrop(ctx->mm);
-		kmem_cache_free(userfaultfd_ctx_cachep, ctx);
+	if (IS_ERR(file)) {
+		fd = PTR_ERR(file);
+		goto err_out;
 	}
+	/* prevent the mm struct to be freed */
+	mmgrab(ctx->mm);
+	file->f_mode |= FMODE_NOWAIT;
+	fd_install(fd, file);
+	return fd;
+err_out:
+	kmem_cache_free(userfaultfd_ctx_cachep, ctx);
 	return fd;
 }
 
-- 
2.43.0


