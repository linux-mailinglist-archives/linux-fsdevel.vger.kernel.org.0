Return-Path: <linux-fsdevel+bounces-31112-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E778C991D2C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 10:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9AD52810D4
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 08:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC65171092;
	Sun,  6 Oct 2024 08:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/j7TboT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7020616F0CA;
	Sun,  6 Oct 2024 08:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728203049; cv=none; b=FIb/seY3SO38CDC5sEaQOcn9r0xzhSEXURbFxcDWZtv5N9EhCP/BdkR+Q0I9X/+91KAow2AqwillIem3FNoZrzXlNQZlbf8V4utp4bNl839U8j24r+kafEBvKwcWZtZOnH0Od8EZOSWIeRi/s5TKZPC12YuKiW7Rub4Wk011Df8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728203049; c=relaxed/simple;
	bh=TpYa2ZF9v70fV4t+P8r9v/tYZzVgaE4wRIRTMijMiCs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TOM24hUvu/2C4F7gCI3aNBzgZ7K13th5wPD6pCI/8jdvBM7yvatPgLuoeN7dsuLk9kCu8Lo0Q4O3VbQlPbbLq52riGr9KPHr/MXKFYIYJOfjT+d7rnoUebB5jkq7YSb+YUopitOsnCk1f7t5UI6n/xwA+Ujh8YscU+dcinuMkj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/j7TboT; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a8d446adf6eso573805966b.2;
        Sun, 06 Oct 2024 01:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728203046; x=1728807846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1CnnpPyWPJ06gbK/tE0GjMr7wtsDf99fprWrcrmyV+k=;
        b=K/j7TboT5vcQ7VrHi6iIHeDf3nb+avSTLs2vSF+v4nhovJf/i5CKTYa1UdXPOsrAap
         OhzcoQ6uwt3No2n0sZqx+ekNRWx9Nwp1HqM3QtKXk+/APW4UT24nL30N+4Hjo27Az0bE
         Ovf2vBPlmUwfPXRzSe0K3sAXg8sLfZ/tPzv7zj/M+O8vsxN7UiuVU4BeuuDsGvezOodu
         +zjlJK02AoV/71hQkVXqdO1VZQXTEdAarR9pQ/Vp0/yKM92f1Fg5pH8QL+1/Nr+cr11E
         O6mlK35DNI0/pKkFJ1jo7wPMGR4UEV9vmtLPqkEX3YA2IT9UTA0Spek9t8uGZyfCmlio
         jqJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728203046; x=1728807846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1CnnpPyWPJ06gbK/tE0GjMr7wtsDf99fprWrcrmyV+k=;
        b=v2Qyea0/e93e8MM5F8++EC6hAXvGUuw2mDS3ueMcRy3ao2EEgjCCztIJcGQiUHnHav
         XpZjZp0UQzWL3x1imLgKQ8GTtGMghb3DxsnoCvoiRITXkpF9FVE38EohQGj43ESYhiUl
         zn0Wf/ZC0KXdmqzwofrduMCGf5zagOt+WSjK3MJK8EMQY9r4wxG75DTdqIqhdHN5PnOX
         LsRwxkgPa6z4WTKSv7OMHxR53/MGf+NqLuzNrNhUcIoM94ZAXjW/XHYXLIyfLc17hDOd
         hfm+BOb5ViVdyuCH2UmrLk05bXngNCV3di3AdXygAc8esq0/wm8tkDlWSz6Zlrvc1oSa
         63RA==
X-Forwarded-Encrypted: i=1; AJvYcCUHv344RmSIJyWn6KRRwRFrctLpUQagouoDg8C1ZRBHKofHBpu2kMiqWgnvr8MyxXJCapAPeGlDWqeotGYiDQ==@vger.kernel.org, AJvYcCXRBcZuH1N2JW195E/DcPq60gqHjuWQ7xlCytGR/h5DoD/eKtOiw8xWvK9ydPAIo2rColaCQV3sGOSnPNFK@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0gSB/tm8k9Z31hJhKlVbluJt4ODBbYT1mHFdI/Sq9P1qUSNaQ
	kWk/2viLwoBQOCMvXxBm7UrP/6obV+9XuImt98eiZQHWF+072QFo
X-Google-Smtp-Source: AGHT+IGt1KXIjbMMEtV8jX+Ueoj8H7c81DGsOhbXkF8oTWuI3WMZVCSNn8oHDP1MWS5Bxd+7UJof3g==
X-Received: by 2002:a17:907:70d:b0:a77:c30c:341 with SMTP id a640c23a62f3a-a991bac3142mr809270766b.0.1728203045312;
        Sun, 06 Oct 2024 01:24:05 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a993fdd2202sm153215766b.55.2024.10.06.01.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 01:24:04 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: [PATCH v2 1/4] ovl: do not open non-data lower file for fsync
Date: Sun,  6 Oct 2024 10:23:56 +0200
Message-Id: <20241006082359.263755-2-amir73il@gmail.com>
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

ovl_fsync() with !datasync opens a backing file from the top most dentry
in the stack, checks if this dentry is non-upper and skips the fsync.

In case of an overlay dentry stack with lower data and lower metadata
above it, but without an upper metadata above it, the backing file is
opened from the top most lower metadata dentry and never used.

Refactor the helper ovl_real_fdget_meta() into ovl_real_fdget_path() and
ovl_upper_fdget() where the latter returns an empty struct fd in that
case to avoid the unneeded backing file open.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/file.c | 61 +++++++++++++++++++++++++++++----------------
 1 file changed, 39 insertions(+), 22 deletions(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 4504493b20be..d40c10a6bfac 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -89,32 +89,19 @@ static int ovl_change_flags(struct file *file, unsigned int flags)
 	return 0;
 }
 
-static int ovl_real_fdget_meta(const struct file *file, struct fd *real,
-			       bool allow_meta)
+static int ovl_real_fdget_path(const struct file *file, struct fd *real,
+			       struct path *realpath)
 {
-	struct dentry *dentry = file_dentry(file);
 	struct file *realfile = file->private_data;
-	struct path realpath;
-	int err;
 
 	real->word = (unsigned long)realfile;
 
-	if (allow_meta) {
-		ovl_path_real(dentry, &realpath);
-	} else {
-		/* lazy lookup and verify of lowerdata */
-		err = ovl_verify_lowerdata(dentry);
-		if (err)
-			return err;
-
-		ovl_path_realdata(dentry, &realpath);
-	}
-	if (!realpath.dentry)
+	if (WARN_ON_ONCE(!realpath->dentry))
 		return -EIO;
 
 	/* Has it been copied up since we'd opened it? */
-	if (unlikely(file_inode(realfile) != d_inode(realpath.dentry))) {
-		struct file *f = ovl_open_realfile(file, &realpath);
+	if (unlikely(file_inode(realfile) != d_inode(realpath->dentry))) {
+		struct file *f = ovl_open_realfile(file, realpath);
 		if (IS_ERR(f))
 			return PTR_ERR(f);
 		real->word = (unsigned long)f | FDPUT_FPUT;
@@ -130,7 +117,11 @@ static int ovl_real_fdget_meta(const struct file *file, struct fd *real,
 
 static int ovl_real_fdget(const struct file *file, struct fd *real)
 {
-	if (d_is_dir(file_dentry(file))) {
+	struct dentry *dentry = file_dentry(file);
+	struct path realpath;
+	int err;
+
+	if (d_is_dir(dentry)) {
 		struct file *f = ovl_dir_real_file(file, false);
 		if (IS_ERR(f))
 			return PTR_ERR(f);
@@ -138,7 +129,33 @@ static int ovl_real_fdget(const struct file *file, struct fd *real)
 		return 0;
 	}
 
-	return ovl_real_fdget_meta(file, real, false);
+	/* lazy lookup and verify of lowerdata */
+	err = ovl_verify_lowerdata(dentry);
+	if (err)
+		return err;
+
+	ovl_path_realdata(dentry, &realpath);
+
+	return ovl_real_fdget_path(file, real, &realpath);
+}
+
+static int ovl_upper_fdget(const struct file *file, struct fd *real, bool data)
+{
+	struct dentry *dentry = file_dentry(file);
+	struct path realpath;
+	enum ovl_path_type type;
+
+	if (data)
+		type = ovl_path_realdata(dentry, &realpath);
+	else
+		type = ovl_path_real(dentry, &realpath);
+
+	real->word = 0;
+	/* Not interested in lower nor in upper meta if data was requested */
+	if (!OVL_TYPE_UPPER(type) || (data && OVL_TYPE_MERGE(type)))
+		return 0;
+
+	return ovl_real_fdget_path(file, real, &realpath);
 }
 
 static int ovl_open(struct inode *inode, struct file *file)
@@ -394,8 +411,8 @@ static int ovl_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 	if (ret <= 0)
 		return ret;
 
-	ret = ovl_real_fdget_meta(file, &real, !datasync);
-	if (ret)
+	ret = ovl_upper_fdget(file, &real, datasync);
+	if (ret || fd_empty(real))
 		return ret;
 
 	/* Don't sync lower file for fear of receiving EROFS error */
-- 
2.34.1


