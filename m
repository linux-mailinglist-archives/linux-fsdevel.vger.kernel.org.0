Return-Path: <linux-fsdevel+bounces-10011-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A00B847006
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 13:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E6031C26AF4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 12:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AFB14199F;
	Fri,  2 Feb 2024 12:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aRYIa02F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5674614199B
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Feb 2024 12:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706876251; cv=none; b=dlJKnJWGAYt70s6CTRpi6HOkt6vaENsAyVpsfzCWYCa1IrgnlWhBwgr5OK+DtRAZDbLD4QMRVWQLP22ktaDJqXKkcLycHDfFzatmhGHfiVqdevg0eilt7GVzkLZzUGonCcb+TWHsI/J9w/7yQa6kRppRI+AprnN1XTb/iO7oy3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706876251; c=relaxed/simple;
	bh=6Z1UFD0kroXDRNEM4NSvOZy4Cf2mFfzGwhePnG7ddn4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SiaGSyxhDr0ogWJzf3i/OaawW2U1xWWL3LX5EF+j3jbkqhONbG+wEUOZsbK2JR+il+3y7Yi2mRXH952RLmxRlOVSIvSEJXcVDIv23KElMf16OfyphQaoEBiseGCF3x4OzqS14JWjia376IYgF53ygPIuCS0+ezPsFT0fUQ6ta2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aRYIa02F; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40fc65783e5so4719715e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Feb 2024 04:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706876248; x=1707481048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5d/3sNnp2k6dQtn/Ob1OYWqbah+3zA3k9UloZ9tj3k=;
        b=aRYIa02FvwZSifCyznWp3kCN0yPD3KDEdcpPmUlSRUbQ9bnf0A1pVnAoSYeX3dMdm0
         m9RNBXFRdCYemAzEB6K1G5GHtngo30zacp8yZvsCfdhvI4vQw0ckB2NTZE/b0dDUi+z4
         KEG2StxDu4rkwow9QaIHfAoCHQwjV0DR9o1HGXkrl9vSYXi6zt9TeT3ODyypE7ldKNbT
         ZNvFUSvaiKitFmDuRXJK18kh7L+WSUsE1l0VMe9YK2+alJcEH4apfTKoCxYDVXxySBlC
         a8PpBAP39C1li+HoGsH1Yg7N9ahmiR0Z5mjW8BUxjgzM0l+YYP3n0WFlo20ccLawBEWb
         duSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706876248; x=1707481048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V5d/3sNnp2k6dQtn/Ob1OYWqbah+3zA3k9UloZ9tj3k=;
        b=q+kDmm7n06K5wKZOnqf0mGKgEAhp8VP/LWDRrk5uZpzmT4Hw8gVnCvMGtco6GTQj/V
         jTOajGhQydVf373J/TypMgivpwa6pmloyo9lcIyqFl8LfbrQGTB1YzBreca3iVoG7sJ7
         3JdT9zed6g5ZB50NKs3zYVHA7iyYcPU4+f/NY/wIXv/+hkOCbtocv/klZ7vgtcrZU0Bg
         gDd7va4mnKcBJJ/gIv6AepoQQ6OVO+nJUUsHyNuxnRIWNGlWHTuosdqVceE9jyKBzFie
         rg8c90rEJDFetplVyNlK+81wOJewM3vUIQVjeCMkEz+xyaK1Mv0wOdjmHdhmsHm/FWM8
         ENIA==
X-Gm-Message-State: AOJu0YzXaK4cCcWz5PJTTngI9nXzFb9WOMB94cB8olhtNsBFJk/BKbZh
	tuih+b8FTB6z9mXXbeOCmmZgkb/NBtTUJ4kwO3SC2+t6EtzUeF28
X-Google-Smtp-Source: AGHT+IG5IIESw588ZOZ96XKWTvnNLb4tO6LIwJoRhN88pxfpIqPRVUL4eJq6AZ9o6sPBciKLLuAocw==
X-Received: by 2002:a05:600c:1e29:b0:40f:c6ab:6cdc with SMTP id ay41-20020a05600c1e2900b0040fc6ab6cdcmr1240487wmb.21.1706876248656;
        Fri, 02 Feb 2024 04:17:28 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXQCwfInt93MPAVffZIygLmEO/cSk9q9yFeJQtWlHcNeNtfH+69Mw3AAcXIUaUtajauA6tfXdwRTseXjeNI10lt0E/+hM04IHu/U7F1GNRt9Lqg7gekSC8YIAjub2rvrQfAGZWfS4YJpwh8HLO6Wt/yVxddsoil81kcH1gwGk3A8b1ykmpqUwJLZCLs7Q==
Received: from localhost.localdomain ([147.235.201.119])
        by smtp.gmail.com with ESMTPSA id s15-20020a05600c45cf00b0040e3635ca65sm7364736wmo.2.2024.02.02.04.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 04:17:28 -0800 (PST)
From: Tony Solomonik <tony.solomonik@gmail.com>
To: 
Cc: willy@infradead.org,
	axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	Tony Solomonik <tony.solomonik@gmail.com>
Subject: [PATCH v9 1/2] Add do_ftruncate that truncates a struct file
Date: Fri,  2 Feb 2024 14:17:23 +0200
Message-Id: <20240202121724.17461-2-tony.solomonik@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202121724.17461-1-tony.solomonik@gmail.com>
References: <20240124083301.8661-1-tony.solomonik@gmail.com>
 <20240202121724.17461-1-tony.solomonik@gmail.com>
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
 fs/open.c     | 53 +++++++++++++++++++++++++++------------------------
 2 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index 58e43341aebf..bb3df26a9a13 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -182,6 +182,7 @@ extern struct open_how build_open_how(int flags, umode_t mode);
 extern int build_open_flags(const struct open_how *how, struct open_flags *op);
 extern struct file *__close_fd_get_file(unsigned int fd);
 
+long do_ftruncate(struct file *file, loff_t length, int small);
 long do_sys_ftruncate(unsigned int fd, loff_t length, int small);
 int chmod_common(const struct path *path, umode_t mode);
 int do_fchownat(int dfd, const char __user *filename, uid_t user, gid_t group,
diff --git a/fs/open.c b/fs/open.c
index 02dc608d40d8..050631c84bf4 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -154,49 +154,52 @@ COMPAT_SYSCALL_DEFINE2(truncate, const char __user *, path, compat_off_t, length
 }
 #endif
 
-long do_sys_ftruncate(unsigned int fd, loff_t length, int small)
+long do_ftruncate(struct file *file, loff_t length, int small)
 {
 	struct inode *inode;
 	struct dentry *dentry;
-	struct fd f;
 	int error;
 
-	error = -EINVAL;
-	if (length < 0)
-		goto out;
-	error = -EBADF;
-	f = fdget(fd);
-	if (!f.file)
-		goto out;
-
 	/* explicitly opened as large or we are on 64-bit box */
-	if (f.file->f_flags & O_LARGEFILE)
+	if (file->f_flags & O_LARGEFILE)
 		small = 0;
 
-	dentry = f.file->f_path.dentry;
+	dentry = file->f_path.dentry;
 	inode = dentry->d_inode;
-	error = -EINVAL;
-	if (!S_ISREG(inode->i_mode) || !(f.file->f_mode & FMODE_WRITE))
-		goto out_putf;
+	if (!S_ISREG(inode->i_mode) || !(file->f_mode & FMODE_WRITE))
+		return -EINVAL;
 
-	error = -EINVAL;
 	/* Cannot ftruncate over 2^31 bytes without large file support */
 	if (small && length > MAX_NON_LFS)
-		goto out_putf;
+		return -EINVAL;
 
-	error = -EPERM;
 	/* Check IS_APPEND on real upper inode */
-	if (IS_APPEND(file_inode(f.file)))
-		goto out_putf;
+	if (IS_APPEND(file_inode(file)))
+		return -EPERM;
 	sb_start_write(inode->i_sb);
-	error = security_file_truncate(f.file);
+	error = security_file_truncate(file);
 	if (!error)
-		error = do_truncate(file_mnt_idmap(f.file), dentry, length,
-				    ATTR_MTIME | ATTR_CTIME, f.file);
+		error = do_truncate(file_mnt_idmap(file), dentry, length,
+				    ATTR_MTIME | ATTR_CTIME, file);
 	sb_end_write(inode->i_sb);
-out_putf:
+
+	return error;
+}
+
+long do_sys_ftruncate(unsigned int fd, loff_t length, int small)
+{
+	struct fd f;
+	int error;
+
+	if (length < 0)
+		return -EINVAL;
+	f = fdget(fd);
+	if (!f.file)
+		return -EBADF;
+
+	error = do_ftruncate(f.file, length, small);
+
 	fdput(f);
-out:
 	return error;
 }
 
-- 
2.34.1


