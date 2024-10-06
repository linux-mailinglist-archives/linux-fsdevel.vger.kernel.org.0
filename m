Return-Path: <linux-fsdevel+bounces-31114-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24EB2991D30
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 10:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 490FC1C2163D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 08:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F3916BE0B;
	Sun,  6 Oct 2024 08:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qu5yIkF7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0061A155C97;
	Sun,  6 Oct 2024 08:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728203050; cv=none; b=leLV9ENqtEQzo4lmzvfDgccgpI/5TGR3lTWg06+woE0O/IZ1Lzim2wRC53svyvXCE+bEQCzlChbtpJpq8qHSyYkWh04kviTEf55DysTSqKlz87MAuON+IAmqVnNOoXr0t9rD4XF60goEkd+2JiSa1eQwX4hrgfGIcaUN7yhkcw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728203050; c=relaxed/simple;
	bh=dIjw98HIv0YoVPu2QAz3/lYrwRh6CuVZ1oKwRx0Plbw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mQ+g8SSEf2Wv/1/EV5BHoiWje1/EcF9kJ/v4d3xMBkt/DA8oyIqJTc/oLH/rv8E1io1tYrI6nYadLjHl9x/hAIRkjacxQ28SR1IJVlBjfpAQEbGd66dopBtL304ZwFtBcrJS/gETrANHaXFU6Cgb4bsCLiUJ1tMVjpCKzWpZJ98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qu5yIkF7; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a993302fa02so149192666b.0;
        Sun, 06 Oct 2024 01:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728203047; x=1728807847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s8e2JY6Sb9s49zoQBWf54t+HgfcDEXFKWbnObt6EfRM=;
        b=Qu5yIkF7TTzGVPchXGeaAuNLqA1wtjT5Qjrw8fZDWQZeJdst1wcgTRc8ksyGkoHxa4
         E/NTQH56yAM7MsS+r1JZmfchQ3RL2gAf8AbreNJIH8yxSivvWvmctnSTCarNjiKI1G9S
         qq+lKNFMM5OwVbVSU18XUglEmWUKHMIgU5Ny3DrD0m/2fl8cNt3urMaZ62YCeTt/lBmF
         xJSOVw5TXm10mV3zxUE5AyXATkfZCxHB7PgbOkBRSrNB0A9GROdwdwYk3Lza2i1VsvmQ
         zX33T3xBjZn/dMa9ToeR8nzbCXgICvwt/OU2EzJwHkkGS1s8qUVqxHpW1AF1TCDv6o8Y
         MobQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728203047; x=1728807847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s8e2JY6Sb9s49zoQBWf54t+HgfcDEXFKWbnObt6EfRM=;
        b=F2NFJutuXrumNIrK9CyX3WJDnZHT96aUozFROwyEZ+QcSMJiQp6U6pJDwjWBOoQ5eF
         bSMPy5gcHITxvQjaVWD5ZW0Nc9jDj7jagqmmIniY8FQpEJvu/CnAHSVlKOrdI+wIBPru
         HESwKwCC7dCV0w8CcV/OWoiwZYb3HImUn3k58UX8CHv+EFD8N3m5OQ8qwRwRgxJ1RpZy
         hPqw/4szu5D04bSs8I6742YUJRpmRBrtXNKNIPrFFzsdfw47W1E4T74iXAaiJAGWEOF9
         nUpBa/CSPJ6Ccyum37a7jV6B+HZf9ChrxJm9JL61MB9cNfjKNjBSL7U0YsMLsiSCmDrd
         mQ3A==
X-Forwarded-Encrypted: i=1; AJvYcCU2DkOo0YiJo7Nqg9ufijP/KWjteuf7W84/L/QDyz8B9Xd1/giy0mb7lt+/awogrcSKUq5YlKRFfttoqa+8@vger.kernel.org, AJvYcCV1FZdNgd1jcXP7BTvCf7BhX56MX1CeTEFJzJzLu9IGPPY9dHID3QDWPUqUT0bGPvbweLDt1Vm+hy3wb7aW0w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxgvBaZPmWoTuyyeL/xW/cMI+b9x+MbTcPjqjR09+rtO6tTkJ0v
	ZOCf7Wym3UPnY9EWUQw89L3Zya/IINOwcI3vcFfANPDVfvYqQSfR
X-Google-Smtp-Source: AGHT+IGi5VDBtRaqHuyQKaUXVA62T87DqCeSvB984i2MKQoCfGJjw6W+vkhPhF5+q01G7kT7TfhPIw==
X-Received: by 2002:a17:907:efd5:b0:a86:78fd:1df0 with SMTP id a640c23a62f3a-a991bd7950fmr851397166b.34.1728203046729;
        Sun, 06 Oct 2024 01:24:06 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a993fdd2202sm153215766b.55.2024.10.06.01.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 01:24:06 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: [PATCH v2 3/4] ovl: convert ovl_real_fdget_path() callers to ovl_real_file_path()
Date: Sun,  6 Oct 2024 10:23:58 +0200
Message-Id: <20241006082359.263755-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241006082359.263755-1-amir73il@gmail.com>
References: <20241006082359.263755-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Stop using struct fd to return a real file from ovl_real_fdget_path(),
because we no longer return a temporary file object and the callers
always get a borrowed file reference.

Rename the helper to ovl_real_file_path(), return a borrowed reference
of the real file that is referenced from the overlayfs file or an error.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/file.c | 70 +++++++++++++++++++++++++--------------------
 1 file changed, 39 insertions(+), 31 deletions(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 42f9bbdd65b4..ead805e9f2d6 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -97,16 +97,14 @@ static bool ovl_is_real_file(const struct file *realfile,
 	return file_inode(realfile) == d_inode(realpath->dentry);
 }
 
-static int ovl_real_fdget_path(const struct file *file, struct fd *real,
-			       struct path *realpath)
+static struct file *ovl_real_file_path(const struct file *file,
+				       struct path *realpath)
 {
 	struct file *realfile = file->private_data;
 	struct file *upperfile = backing_file_private(realfile);
 
-	real->word = 0;
-
 	if (WARN_ON_ONCE(!realpath->dentry))
-		return -EIO;
+		return ERR_PTR(-EIO);
 
 	/*
 	 * Usually, if we operated on a stashed upperfile once, all following
@@ -129,11 +127,11 @@ static int ovl_real_fdget_path(const struct file *file, struct fd *real,
 
 		/* Either stashed realfile or upperfile must match realinode */
 		if (WARN_ON_ONCE(upperfile))
-			return -EIO;
+			return ERR_PTR(-EIO);
 
 		upperfile = ovl_open_realfile(file, realpath);
 		if (IS_ERR(upperfile))
-			return PTR_ERR(upperfile);
+			return upperfile;
 
 		old = cmpxchg_release(backing_file_private_ptr(realfile), NULL,
 				      upperfile);
@@ -144,21 +142,24 @@ static int ovl_real_fdget_path(const struct file *file, struct fd *real,
 
 		/* Stashed upperfile that won the race must match realinode */
 		if (WARN_ON_ONCE(!ovl_is_real_file(upperfile, realpath)))
-			return -EIO;
+			return ERR_PTR(-EIO);
 
 		realfile = upperfile;
 	}
 
 checkflags:
 	/* Did the flags change since open? */
-	if (unlikely((file->f_flags ^ realfile->f_flags) & ~OVL_OPEN_FLAGS))
-		return ovl_change_flags(realfile, file->f_flags);
+	if (unlikely((file->f_flags ^ realfile->f_flags) & ~OVL_OPEN_FLAGS)) {
+		int err = ovl_change_flags(realfile, file->f_flags);
 
-	real->word = (unsigned long)realfile;
-	return 0;
+		if (err)
+			return ERR_PTR(err);
+	}
+
+	return realfile;
 }
 
-static int ovl_real_fdget(const struct file *file, struct fd *real)
+static struct file *ovl_real_file(const struct file *file)
 {
 	struct dentry *dentry = file_dentry(file);
 	struct path realpath;
@@ -166,23 +167,33 @@ static int ovl_real_fdget(const struct file *file, struct fd *real)
 
 	if (d_is_dir(dentry)) {
 		struct file *f = ovl_dir_real_file(file, false);
-		if (IS_ERR(f))
-			return PTR_ERR(f);
-		real->word = (unsigned long)f;
-		return 0;
+
+		if (WARN_ON_ONCE(!f))
+			return ERR_PTR(-EIO);
+		return f;
 	}
 
 	/* lazy lookup and verify of lowerdata */
 	err = ovl_verify_lowerdata(dentry);
 	if (err)
-		return err;
+		return ERR_PTR(err);
 
 	ovl_path_realdata(dentry, &realpath);
 
-	return ovl_real_fdget_path(file, real, &realpath);
+	return ovl_real_file_path(file, &realpath);
+}
+
+static int ovl_real_fdget(const struct file *file, struct fd *real)
+{
+	struct file *f = ovl_real_file(file);
+
+	if (IS_ERR(f))
+		return PTR_ERR(f);
+	real->word = (unsigned long)f;
+	return 0;
 }
 
-static int ovl_upper_fdget(const struct file *file, struct fd *real, bool data)
+static struct file *ovl_upper_file(const struct file *file, bool data)
 {
 	struct dentry *dentry = file_dentry(file);
 	struct path realpath;
@@ -193,12 +204,11 @@ static int ovl_upper_fdget(const struct file *file, struct fd *real, bool data)
 	else
 		type = ovl_path_real(dentry, &realpath);
 
-	real->word = 0;
 	/* Not interested in lower nor in upper meta if data was requested */
 	if (!OVL_TYPE_UPPER(type) || (data && OVL_TYPE_MERGE(type)))
-		return 0;
+		return NULL;
 
-	return ovl_real_fdget_path(file, real, &realpath);
+	return ovl_real_file_path(file, &realpath);
 }
 
 static int ovl_open(struct inode *inode, struct file *file)
@@ -455,7 +465,7 @@ static ssize_t ovl_splice_write(struct pipe_inode_info *pipe, struct file *out,
 
 static int ovl_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 {
-	struct fd real;
+	struct file *realfile;
 	const struct cred *old_cred;
 	int ret;
 
@@ -463,19 +473,17 @@ static int ovl_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 	if (ret <= 0)
 		return ret;
 
-	ret = ovl_upper_fdget(file, &real, datasync);
-	if (ret || fd_empty(real))
-		return ret;
+	realfile = ovl_upper_file(file, datasync);
+	if (IS_ERR_OR_NULL(realfile))
+		return PTR_ERR(realfile);
 
 	/* Don't sync lower file for fear of receiving EROFS error */
-	if (file_inode(fd_file(real)) == ovl_inode_upper(file_inode(file))) {
+	if (file_inode(realfile) == ovl_inode_upper(file_inode(file))) {
 		old_cred = ovl_override_creds(file_inode(file)->i_sb);
-		ret = vfs_fsync_range(fd_file(real), start, end, datasync);
+		ret = vfs_fsync_range(realfile, start, end, datasync);
 		revert_creds(old_cred);
 	}
 
-	fdput(real);
-
 	return ret;
 }
 
-- 
2.34.1


