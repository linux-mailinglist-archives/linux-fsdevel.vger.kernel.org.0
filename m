Return-Path: <linux-fsdevel+bounces-9389-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7853840974
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 16:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15CB41C2173A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 15:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08AEB153BC3;
	Mon, 29 Jan 2024 15:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TpYvwfbO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55D71534FC
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jan 2024 15:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706541318; cv=none; b=A9couu0hudPFiapWa8Elr3VmW/Anjr9WlcNOR/3O/jmr9NhS8oixIOONIqOGff1bAz5msP3xD6leDSkZ48htC3dwrntIY3/v3+l5PKTU9d6IZ6x8C53y83S/FRLhqF5UemEsc4jD9kPzh5mEsMUSKgHtRCg0SvDCsRxX7TXSagE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706541318; c=relaxed/simple;
	bh=U7p7DBiwt36LOyfZjNcbX/+PeKY1AyT03L1jkN/LZPI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z3QNM7M70yCNUoS0Rx/UjHz5wBduhq6rFy2o2a/ZJy7R8shHmbUYucemKzMmVYqce4MHStPJRnDPJN4dvIMP6VBFL+jThRhVSylpHnizGe2t3LwGmngO85Ma5nTOVLv9V7yRSDszSwyxkD1Kz7/GPA4+/BR7ORfSDW8iSmivdS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TpYvwfbO; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40e775695c6so25297265e9.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jan 2024 07:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706541315; x=1707146115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v71HBMYaLKl569swmb2xVX3+a05lKxuFejdDN7gWubU=;
        b=TpYvwfbOHas0dMlSIajpszsamQ/PvtzM4JfloUhOEvcLV2+QLx7zn02OpM/6i5gxOy
         kiBBItF78qBg4ZiKX/xxMRrU5AlrjDXRyF+otmzmSFC8E/iZs0rW9fRqQiJaldDJT0Et
         R5EkM5dp/wP/sHCYNgeoYKD3hAQRuTyX6vr2EYi33jJxQIFeVrJpCb5QcqVZTGYHZF89
         knUMC1GlbP8nhkY0RN/gLlTt2IB0hXwxisUOpY8Pqx3kaAdlhv7IEiDL8tK3uqK0zATV
         rzI5GsvPKfU0YJ9MaaWnvwYGkMW+pfP/qtwFgLEG1Meyp8OGA8y9ql97XA8XzXBb19dL
         Y33Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706541315; x=1707146115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v71HBMYaLKl569swmb2xVX3+a05lKxuFejdDN7gWubU=;
        b=WnHF5DhQx11oXFzr95jXelCg5DnUEyEcC3WLiZYPxI7IXsgni3EyXerTbQ+D1lSRkN
         94FMidNH2XMhsd64WFMxfjKzZfrDrDxy465pE35i7ZlCO20lrlxWNkYFqTD8odGfyOCA
         DGlDM27727OAmfzVTZdftlIspwa8rWqNX0l8VpywZoUgIjXyx4OfxqWtZBK7NibGsmAq
         tVQG8rgQmyMh3NnNFUT/whqaKII6CSMJD3QnMJ9i9WmJJxSKfIAOTHiygjU1j9bBOLFS
         3MkGW9mvsPDdhPmS4WdOFi0kX4DJmstbIpHDpnTWftuY+ClESyibPA7X/iilpbcWB0Lv
         ecuA==
X-Gm-Message-State: AOJu0YxebGc0xTj2Zmn4RVzEdjGAvL4BjIfH4Oqi5CE5rqOdok5v+hlw
	+t21zDETeU4pzNQzr8wq4tbxu1wZuCG01BpnFOQiw9unIbFO7mrc
X-Google-Smtp-Source: AGHT+IFHBi0is3gZyF09Tsk9tKmWCYjEVQ/EtrVffTvXjS7+432bJ8oZP/Bri9eYQKfItyFEmYh5Og==
X-Received: by 2002:adf:f18d:0:b0:33a:eae4:aaf7 with SMTP id h13-20020adff18d000000b0033aeae4aaf7mr3344009wro.48.1706541314990;
        Mon, 29 Jan 2024 07:15:14 -0800 (PST)
Received: from localhost.localdomain ([147.235.201.119])
        by smtp.gmail.com with ESMTPSA id r6-20020adfca86000000b0033aed7423e8sm3060353wrh.11.2024.01.29.07.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 07:15:14 -0800 (PST)
From: Tony Solomonik <tony.solomonik@gmail.com>
To: 
Cc: willy@infradead.org,
	axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	Tony Solomonik <tony.solomonik@gmail.com>
Subject: [PATCH v8 1/2] Add do_ftruncate that truncates a struct file
Date: Mon, 29 Jan 2024 17:15:06 +0200
Message-Id: <20240129151507.14885-2-tony.solomonik@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129151507.14885-1-tony.solomonik@gmail.com>
References: <20240124083301.8661-1-tony.solomonik@gmail.com>
 <20240129151507.14885-1-tony.solomonik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

do_sys_ftruncate receives a file descriptor, fgets the struct file, and
finally actually truncates the file.

do_ftruncate allows for passing in a file directly, with the caller
already holding a reference to it.

Signed-off-by: Tony Solomonik <tony.solomonik@gmail.com>
---
 fs/internal.h |  1 +
 fs/open.c     | 52 ++++++++++++++++++++++++++++-----------------------
 2 files changed, 30 insertions(+), 23 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index 58e43341aebf..d35b1c05cf6d 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -182,6 +182,7 @@ extern struct open_how build_open_how(int flags, umode_t mode);
 extern int build_open_flags(const struct open_how *how, struct open_flags *op);
 extern struct file *__close_fd_get_file(unsigned int fd);
 
+long do_ftruncate(struct file *file, loff_t length);
 long do_sys_ftruncate(unsigned int fd, loff_t length, int small);
 int chmod_common(const struct path *path, umode_t mode);
 int do_fchownat(int dfd, const char __user *filename, uid_t user, gid_t group,
diff --git a/fs/open.c b/fs/open.c
index 02dc608d40d8..6d608ff4a3f7 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -154,49 +154,55 @@ COMPAT_SYSCALL_DEFINE2(truncate, const char __user *, path, compat_off_t, length
 }
 #endif
 
-long do_sys_ftruncate(unsigned int fd, loff_t length, int small)
+long do_ftruncate(struct file *file, loff_t length)
 {
 	struct inode *inode;
 	struct dentry *dentry;
+	int error;
+
+	dentry = file->f_path.dentry;
+	inode = dentry->d_inode;
+	if (!S_ISREG(inode->i_mode) || !(file->f_mode & FMODE_WRITE))
+		return -EINVAL;
+
+	/* Check IS_APPEND on real upper inode */
+	if (IS_APPEND(file_inode(file)))
+		return -EPERM;
+	sb_start_write(inode->i_sb);
+	error = security_file_truncate(file);
+	if (!error)
+		error = do_truncate(file_mnt_idmap(file), dentry, length,
+				    ATTR_MTIME | ATTR_CTIME, file);
+	sb_end_write(inode->i_sb);
+
+	return error;
+}
+
+long do_sys_ftruncate(unsigned int fd, loff_t length, int small)
+{
 	struct fd f;
 	int error;
 
-	error = -EINVAL;
 	if (length < 0)
-		goto out;
-	error = -EBADF;
+		return -EINVAL;
 	f = fdget(fd);
 	if (!f.file)
-		goto out;
+		return -EBADF;
 
 	/* explicitly opened as large or we are on 64-bit box */
 	if (f.file->f_flags & O_LARGEFILE)
 		small = 0;
 
-	dentry = f.file->f_path.dentry;
-	inode = dentry->d_inode;
 	error = -EINVAL;
-	if (!S_ISREG(inode->i_mode) || !(f.file->f_mode & FMODE_WRITE))
-		goto out_putf;
 
-	error = -EINVAL;
 	/* Cannot ftruncate over 2^31 bytes without large file support */
 	if (small && length > MAX_NON_LFS)
-		goto out_putf;
+		goto out;
+
+	error = do_ftruncate(f.file, length);
 
-	error = -EPERM;
-	/* Check IS_APPEND on real upper inode */
-	if (IS_APPEND(file_inode(f.file)))
-		goto out_putf;
-	sb_start_write(inode->i_sb);
-	error = security_file_truncate(f.file);
-	if (!error)
-		error = do_truncate(file_mnt_idmap(f.file), dentry, length,
-				    ATTR_MTIME | ATTR_CTIME, f.file);
-	sb_end_write(inode->i_sb);
-out_putf:
-	fdput(f);
 out:
+	fdput(f);
 	return error;
 }
 
-- 
2.34.1


