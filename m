Return-Path: <linux-fsdevel+bounces-9075-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1011883DE1A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 16:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BD6FB25755
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 15:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BDA1D555;
	Fri, 26 Jan 2024 15:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOcw1tme"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282781CF90
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 15:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706284649; cv=none; b=NnB9mA8niqRBqSg3WlrQnVEYD9YqtKHE6zKSYnkHaTgajYYHaitE7Z3DDXPLYNrLMMeCDOMEM9TPyAp+zO5gt4CjPYe3hMV0JuMMYna+m6dZPq0gldyf2I/ACiFklRC1vp6/xtQDZJXN+zrqmmUXa08VRPz2LBDticQI1hxRuGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706284649; c=relaxed/simple;
	bh=0HunhnbcX9ZsuXcrYeri9pRIk8CN08ig1jG63LXX8cA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X+4bRFQ/XqPI00GsZToz3GJekw/JgOhnv6QDA5DprBDBF/J/PkwOVhzZKndoX4ef+1KVmZRoIXQAcJQCaXK5GIZBkQAf8Zm2oVhHcX4QGswnkY+F96I9v8iTB4BQc6xW9evHfb/pd6iVJA311KGhhKVIUPsbb4FiOGVB0ek0otI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SOcw1tme; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5101f2dfdadso1044629e87.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 07:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706284646; x=1706889446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w6raLg7wD+sk36pQRjUXFDO6cKOlKJG0M4/2TT+m5hg=;
        b=SOcw1tmeizEK9FhjiYSKE9EK2WA55GbbjN+WVaC5ySGmljqCaMoGW9it6Nlk3jvcN4
         kJr55sZ1Du4v+3zCrm/NaCBVPYMC8G2Sap2W35som9efNMxZ9GbQXn0C3qvM8/p7W4EO
         4Agh9215rZvXdw+Bh4yFpznlYB8TNXtf6xGcKbRSUrTOlIlnLTwFbIZtQbCmO3JiIeQA
         iRLOGjusC6No5sbCsM8MLEuW1G8esoCEhYCnOX2ypw+lyeL/M8PbJL80gBSXAclPknRq
         EsnYL00Au6wDdrbu1OTCaykRR3DapIChAb9yiT94jOSSTTtdfrsE5ZkGNowuwXilH+sU
         bAKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706284646; x=1706889446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w6raLg7wD+sk36pQRjUXFDO6cKOlKJG0M4/2TT+m5hg=;
        b=Vpz3Pkr/CQLcoNcBQD+4T8xFT7X1pXHidr26C84cgb8XT6pvoiIxLToTXIbiw5Av3v
         VbWLLfw1uAKe9AHKT9ViRwH+V1VjxinCj2vOTcOr8itZJBWXA/edc7mFbgStg+2Nr+yq
         t3pmbBJ8Yo36z0pRRxXg86qH2alez9cQSSbReeOqsR292ST3PpLBPyxhxSpxA9pBTeQU
         u8BwigR5Z4FKkUPAtWXyOp3F840Xj9k90dHRM98+uJP6wyx4+Yo7zgsI/8s8eO2u5eDP
         q48trvai8Q+uvwHL/090nZ7WxV0kiSTiSdyQsbrOINTlFe3tneyTgOLMXmNO6GppZZnq
         E1ng==
X-Gm-Message-State: AOJu0YzG/WOE6urr5vTMqhfPpVwwE5m1HpkmamadIacE2c/h1XJd39Iq
	HA3b7nWEOnB0L1G0jsxUPgzzmE9XE2E7nDD5L+Wb5s0hEXEM6xls
X-Google-Smtp-Source: AGHT+IHtCIKW/8rRN2ks7tPh1m5WEKNzrV+kRkcGeOIPOG59QpbAROsERP5vqMJLDyFdcN7/sh/FCQ==
X-Received: by 2002:a2e:a681:0:b0:2ce:fc69:47f2 with SMTP id q1-20020a2ea681000000b002cefc6947f2mr926568lje.39.1706284645910;
        Fri, 26 Jan 2024 07:57:25 -0800 (PST)
Received: from localhost.localdomain ([147.235.201.119])
        by smtp.gmail.com with ESMTPSA id f8-20020a2e6a08000000b002ccdb771df0sm188598ljc.108.2024.01.26.07.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 07:57:25 -0800 (PST)
From: Tony Solomonik <tony.solomonik@gmail.com>
To: 
Cc: willy@infradead.org,
	axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	Tony Solomonik <tony.solomonik@gmail.com>
Subject: [PATCH v7 1/2] Add do_ftruncate that truncates a struct file
Date: Fri, 26 Jan 2024 17:57:19 +0200
Message-Id: <20240126155720.20385-2-tony.solomonik@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240126155720.20385-1-tony.solomonik@gmail.com>
References: <20240124083301.8661-1-tony.solomonik@gmail.com>
 <20240126155720.20385-1-tony.solomonik@gmail.com>
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
index 02dc608d40d8..9bbe8a73836b 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -154,49 +154,52 @@ COMPAT_SYSCALL_DEFINE2(truncate, const char __user *, path, compat_off_t, length
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
-
-	error = -EINVAL;
 	/* Cannot ftruncate over 2^31 bytes without large file support */
 	if (small && length > MAX_NON_LFS)
-		goto out_putf;
+		return -EINVAL;
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
 	fdput(f);
-out:
 	return error;
 }
 
-- 
2.34.1


