Return-Path: <linux-fsdevel+bounces-3419-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A207F463F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 13:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5263B21673
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 12:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5F14D124;
	Wed, 22 Nov 2023 12:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJ+ky1e7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAACD12C
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 04:27:38 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40b2b3da41eso12047975e9.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 04:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700656057; x=1701260857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hsld6spmg+4PUomJeDt2E9WPc9grEAJuZEZ8rbrPmT8=;
        b=bJ+ky1e7c6qwO74ZRb3nh+M0MoXYxQMhNavsSOhZbsDkFcEFOxh2DJkguurp3bHO4K
         Vohc7izoQW4+luIE/EiGSKiBZ+qKPOAHgyb8fXR4t/jMabzUlvs3avfV3jgWuT7nobgd
         Z//GzprCi78cy6gqnK1qacDdn1jHtdrscyMjSR+m3LUcs3RP+OzofDRlAoD3qKNkV3xe
         TpOQC1ausYhyJ0vVKFZjkksljZbbkS8hsviNXLbD6KCC9IZlmluEwRpe1ttiG0f3ovg0
         EmzIJyMCw6qxQRLkciLwaP8dDVC5X8Rnq61DP2oCuHDJ8G7IdfxaRcyLlor9bFrAnkNl
         Ngcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700656057; x=1701260857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hsld6spmg+4PUomJeDt2E9WPc9grEAJuZEZ8rbrPmT8=;
        b=c6cuLxepz3s4CzGG0/UQ+k8GpcsifJFJ3U2oYXhBKb9C/87KPdcUVfgQBkIiHKsAVp
         MzS1ZjFUSyu7Ay6yO+uXooZZ4MO1eoYsy+34OgTfB8GFweYHVPnF8vU2HUN2YB7L6dTh
         ZYo+4KPa9qq7S9KtjvC007LLK880tSZWLK4k0pYVBHD0HdeQe5HglP0B/D62dMGj7RFP
         P72qKeqxcE7EI+he/iw4eZ+05W/M/jdWr+vBZiFc++w60JRI8x0mB0wfafwIemhqWmE5
         psylWV79OwNDtv/+pzo76FQbeGSchyn7MptyN4v19+YsylPPO8zUYl/9skJd2H8r6gIH
         Gzvw==
X-Gm-Message-State: AOJu0YxoiBJG1U5E3C+Ef2aGagkDmJqTm6XZxquNjmD3AaiSutel9CzL
	sdxa79XF+qKKCaFNSRAwB0Mstlf+o64=
X-Google-Smtp-Source: AGHT+IGSVmoHJSoStoViIMM1YcW4dZUje+1bZ8XrAQFJh7Q6jmfwP87HDefZg1I/MDgmf5cluQwdMQ==
X-Received: by 2002:a05:600c:4592:b0:40a:463c:1d8c with SMTP id r18-20020a05600c459200b0040a463c1d8cmr1761593wmo.21.1700656057169;
        Wed, 22 Nov 2023 04:27:37 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id f14-20020a05600c154e00b0040588d85b3asm2055556wmg.15.2023.11.22.04.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 04:27:36 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Josef Bacik <josef@toxicpanda.com>,
	David Howells <dhowells@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 12/16] fs: move permission hook out of do_iter_read()
Date: Wed, 22 Nov 2023 14:27:11 +0200
Message-Id: <20231122122715.2561213-13-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231122122715.2561213-1-amir73il@gmail.com>
References: <20231122122715.2561213-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We recently moved fsnotify hook, rw_verify_area() and other checks from
do_iter_write() out to its two callers.

for consistency, do the same thing for do_iter_read() - move the
rw_verify_area() checks and fsnotify hook to the callers vfs_iter_read()
and vfs_readv().

This aligns those vfs helpers with the pattern used in vfs_read() and
vfs_iocb_iter_read() and the vfs write helpers, where all the checks are
in the vfs helpers and the do_* or call_* helpers do the work.

This is needed for fanotify "pre content" events.

Suggested-by: Jan Kara <jack@suse.cz>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/read_write.c | 74 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 48 insertions(+), 26 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 6c40468efe19..9410c3e6a04e 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -784,12 +784,27 @@ static ssize_t do_loop_readv_writev(struct file *filp, struct iov_iter *iter,
 	return ret;
 }
 
+/*
+ * Low-level helpers don't perform rw sanity checks.
+ * The caller is responsible for that.
+ */
 static ssize_t do_iter_read(struct file *file, struct iov_iter *iter,
-		loff_t *pos, rwf_t flags)
+			    loff_t *pos, rwf_t flags)
+{
+	if (file->f_op->read_iter)
+		return do_iter_readv_writev(file, iter, pos, READ, flags);
+
+	return do_loop_readv_writev(file, iter, pos, READ, flags);
+}
+
+ssize_t vfs_iocb_iter_read(struct file *file, struct kiocb *iocb,
+			   struct iov_iter *iter)
 {
 	size_t tot_len;
 	ssize_t ret = 0;
 
+	if (!file->f_op->read_iter)
+		return -EINVAL;
 	if (!(file->f_mode & FMODE_READ))
 		return -EBADF;
 	if (!(file->f_mode & FMODE_CAN_READ))
@@ -798,22 +813,20 @@ static ssize_t do_iter_read(struct file *file, struct iov_iter *iter,
 	tot_len = iov_iter_count(iter);
 	if (!tot_len)
 		goto out;
-	ret = rw_verify_area(READ, file, pos, tot_len);
+	ret = rw_verify_area(READ, file, &iocb->ki_pos, tot_len);
 	if (ret < 0)
 		return ret;
 
-	if (file->f_op->read_iter)
-		ret = do_iter_readv_writev(file, iter, pos, READ, flags);
-	else
-		ret = do_loop_readv_writev(file, iter, pos, READ, flags);
+	ret = call_read_iter(file, iocb, iter);
 out:
 	if (ret >= 0)
 		fsnotify_access(file);
 	return ret;
 }
+EXPORT_SYMBOL(vfs_iocb_iter_read);
 
-ssize_t vfs_iocb_iter_read(struct file *file, struct kiocb *iocb,
-			   struct iov_iter *iter)
+ssize_t vfs_iter_read(struct file *file, struct iov_iter *iter, loff_t *ppos,
+		      rwf_t flags)
 {
 	size_t tot_len;
 	ssize_t ret = 0;
@@ -828,25 +841,16 @@ ssize_t vfs_iocb_iter_read(struct file *file, struct kiocb *iocb,
 	tot_len = iov_iter_count(iter);
 	if (!tot_len)
 		goto out;
-	ret = rw_verify_area(READ, file, &iocb->ki_pos, tot_len);
+	ret = rw_verify_area(READ, file, ppos, tot_len);
 	if (ret < 0)
 		return ret;
 
-	ret = call_read_iter(file, iocb, iter);
+	ret = do_iter_read(file, iter, ppos, flags);
 out:
 	if (ret >= 0)
 		fsnotify_access(file);
 	return ret;
 }
-EXPORT_SYMBOL(vfs_iocb_iter_read);
-
-ssize_t vfs_iter_read(struct file *file, struct iov_iter *iter, loff_t *ppos,
-		rwf_t flags)
-{
-	if (!file->f_op->read_iter)
-		return -EINVAL;
-	return do_iter_read(file, iter, ppos, flags);
-}
 EXPORT_SYMBOL(vfs_iter_read);
 
 static ssize_t do_iter_write(struct file *file, struct iov_iter *iter,
@@ -918,19 +922,37 @@ ssize_t vfs_iter_write(struct file *file, struct iov_iter *iter, loff_t *ppos,
 EXPORT_SYMBOL(vfs_iter_write);
 
 static ssize_t vfs_readv(struct file *file, const struct iovec __user *vec,
-		  unsigned long vlen, loff_t *pos, rwf_t flags)
+			 unsigned long vlen, loff_t *pos, rwf_t flags)
 {
 	struct iovec iovstack[UIO_FASTIOV];
 	struct iovec *iov = iovstack;
 	struct iov_iter iter;
-	ssize_t ret;
+	size_t tot_len;
+	ssize_t ret = 0;
 
-	ret = import_iovec(ITER_DEST, vec, vlen, ARRAY_SIZE(iovstack), &iov, &iter);
-	if (ret >= 0) {
-		ret = do_iter_read(file, &iter, pos, flags);
-		kfree(iov);
-	}
+	if (!(file->f_mode & FMODE_READ))
+		return -EBADF;
+	if (!(file->f_mode & FMODE_CAN_READ))
+		return -EINVAL;
 
+	ret = import_iovec(ITER_DEST, vec, vlen, ARRAY_SIZE(iovstack), &iov,
+			   &iter);
+	if (ret < 0)
+		return ret;
+
+	tot_len = iov_iter_count(&iter);
+	if (!tot_len)
+		goto out;
+
+	ret = rw_verify_area(READ, file, pos, tot_len);
+	if (ret < 0)
+		goto out;
+
+	ret = do_iter_read(file, &iter, pos, flags);
+out:
+	if (ret >= 0)
+		fsnotify_access(file);
+	kfree(iov);
 	return ret;
 }
 
-- 
2.34.1


