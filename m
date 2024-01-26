Return-Path: <linux-fsdevel+bounces-9069-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BA483DD54
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 16:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F323BB21564
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 15:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD7D1D52B;
	Fri, 26 Jan 2024 15:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IiXr4xkd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AC91CF8F
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 15:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706282489; cv=none; b=eMQySW0X3PNyzynyb5tJMwyOAXepBJJmaw4MYkkqXAY1WjwAq7qDAHdvhPJCPc1ooTw6j6Rimnt73+zA0gpvFtixlGDRn+hntnxqQkjI4soU3G/YrHma5AIA+lBXLgMAjdTXMI7L1BOa06kmRs3/Wg+TOwi5HrJ+sfKcZQez1l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706282489; c=relaxed/simple;
	bh=qu9MebIgXCK2oZVRQ/fDV8Vis8po6FRI8tt9Ym3zsAs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VyzcxCtKTjcjP1IUQzJKPhGyTi/L/LdKusb0K4idQK+3EBpn1Z4lAgYrQbdK8+k69rS09ppgttFU/hTjJFG6kFagkjMZcM5efz3nuI1NAJoNO3IRvOgwr3rV5DiHEShKQUx3a7n55K2z2y4JR2uIwzhH0ucxezt4AEBLl4skabc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IiXr4xkd; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3392291b21bso703823f8f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 07:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706282486; x=1706887286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l7tl3ZXXLaYuRPJhUtawqYNe/HCu8Nw7RTBC/JyeS3k=;
        b=IiXr4xkdbtuweJtooWHHMFlm3DPBYqtaO5u7jcLmb+C2z7u5T2u25RUfg2y6BZZ1vr
         zUQ96a9dan85P5Trgf3WfBqbyrPsK9PPnp0z9WEN9Lst5MZuuz2fj30abmRGMRC37KoI
         Gva7+xRoDof36v+5oBlRa4DqHb38YVavJcEElj9UmFxFtMsUJahWik588WSWkmee8heH
         4x1A4rr0Ld4G3hvu13rBZI91r0I+UAILvuFkkTJ85uNq1sO07Wv72PHdIj3Sduq9Va3g
         EN0gh2c7J7yFPZpAlzCnWGi5sCRSITd4dhXZfsSFcZcwSOhBz/n3BZkhj4D40/MHhiKU
         jzbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706282486; x=1706887286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l7tl3ZXXLaYuRPJhUtawqYNe/HCu8Nw7RTBC/JyeS3k=;
        b=Kv3OeREr6ZxmQNJzEMoQjYtSVXDaypFADtEfM8wqWcVcEJ/7kVpgdnZ9IyJJYMOM07
         RXjlRR/reEMxXBaNsfEelzD8Nb5sU24L77pCLVZt72NtwesG0+/KQ7qCLMfl+NseIs9u
         9tisRxmdo5knT7tVOWT93tdM/A+SCka76NSryWBzuq8bBLbCiAmLbxabdriBBgrzBeh5
         1ECiyiPmmSVYfzyXThyaCS2ks5rIHliiuPs4jq2l7/CfS+Wpc5n+l9XkvvFyN8xns9m7
         zN2EK357MvLHTOO4yfdm8GxhHEVWYG5swrvlnFAu3jUdxdFx2LyPPJuVTL3J46bsDt/m
         zA+A==
X-Gm-Message-State: AOJu0YyrZ7/CP0/IO5a8tY/MsDPVk3O1nv/O8Lq1+vvv2LhKq5jv2bLx
	WWk6Y1jhTBTxqEYhJoZOCzXkjABqTsTFx8IQM6lMYT/z0IHTuZeP
X-Google-Smtp-Source: AGHT+IG5kJQbLIiAxfGfR+r6vyxl0rUemEezoqPUNHkgIgm7VojJ8MciSN5FpAzHqIS9eXmRi6sb9Q==
X-Received: by 2002:a5d:4524:0:b0:333:4c30:dae4 with SMTP id j4-20020a5d4524000000b003334c30dae4mr985201wra.45.1706282485615;
        Fri, 26 Jan 2024 07:21:25 -0800 (PST)
Received: from localhost.localdomain ([147.235.201.119])
        by smtp.gmail.com with ESMTPSA id bn7-20020a056000060700b0033946c0f9e7sm1493914wrb.17.2024.01.26.07.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 07:21:25 -0800 (PST)
From: Tony Solomonik <tony.solomonik@gmail.com>
To: 
Cc: willy@infradead.org,
	axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	Tony Solomonik <tony.solomonik@gmail.com>
Subject: [PATCH v6 1/2] Add do_ftruncate that truncates a struct file
Date: Fri, 26 Jan 2024 17:21:17 +0200
Message-Id: <20240126152118.14201-2-tony.solomonik@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240126152118.14201-1-tony.solomonik@gmail.com>
References: <20240124083301.8661-1-tony.solomonik@gmail.com>
 <20240126152118.14201-1-tony.solomonik@gmail.com>
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
 fs/open.c     | 57 +++++++++++++++++++++++++++------------------------
 2 files changed, 31 insertions(+), 27 deletions(-)

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
index 02dc608d40d8..77db60c416db 100644
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
+	int error;
+
+	dentry = file->f_path.dentry;
+	inode = dentry->d_inode;
+	if (!S_ISREG(inode->i_mode) || !(file->f_mode & FMODE_WRITE))
+		return -EINVAL;
+
+	/* Cannot ftruncate over 2^31 bytes without large file support */
+	if (small && length > MAX_NON_LFS)
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
+  return error;
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
-	error = -EINVAL;
-	if (!S_ISREG(inode->i_mode) || !(f.file->f_mode & FMODE_WRITE))
-		goto out_putf;
+	error = do_ftruncate(f.file, length, small);
 
-	error = -EINVAL;
-	/* Cannot ftruncate over 2^31 bytes without large file support */
-	if (small && length > MAX_NON_LFS)
-		goto out_putf;
-
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
 	fdput(f);
-out:
 	return error;
 }
 
-- 
2.34.1


