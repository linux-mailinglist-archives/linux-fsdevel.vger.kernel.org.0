Return-Path: <linux-fsdevel+bounces-50904-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A47AD0D38
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jun 2025 13:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C38A93B2D48
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jun 2025 11:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A525622173F;
	Sat,  7 Jun 2025 11:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZg3dHxK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601251F151C
	for <linux-fsdevel@vger.kernel.org>; Sat,  7 Jun 2025 11:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749297193; cv=none; b=JY0lglhMKQt7WnbiOaDl3kllmi7JTSUrs+5f5eYpvLD3l3diM8MAKU+HcaGVXour4apmbiEfIJpBl3r7k+XsHX5bspkkD1Z7GVYxIq6rlwPOKxRuTr0Tw8QqWTUKdxpugQ5pabFYOAacIq59+ie6wR5/IARuUcJWoNNttu/oyag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749297193; c=relaxed/simple;
	bh=O3AmMdSVCVvA2byTNTRfLmdE40LDTF8cMSwjK2MF97Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ugu/5yY1ujLhzFbKj9dTg0Rgic61qpEDc+GXT6zXBk7zgEB7HJld+rhLr8C8xmEiwKC59JRnataWKzYyP6+gRLKBK1AA8ECuXhgOaaaPppmLwG5T85u69sRxehZG/VNUCM8f84xDGvv2y7On8CBTDS1EnhL2sBf92TKmHFDY4xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZg3dHxK; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ad51ba0af48so753816966b.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 Jun 2025 04:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749297190; x=1749901990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YPpDTdf9e9OdrTEDdAClzqG7dtzs03KQUmygM9lIb5w=;
        b=fZg3dHxKj3VDAXXmUJhQg6yCCsMdaA4aw62eUOu5Am0h+eU8ObjJKAq27GGyxwpkHg
         sjT/Xy5yniwd79ALEWZyH8poqbaRI6gtoEPvrAzlP3dRIrvD6aaGURYv7ggHxEmffW9Y
         cfNbKgmrjXPMjlcGwCmdJAKTOYEjeIabiSOhamsam8kr5RSHSokdxtJG+RlOPtMSNlQx
         5h9yslpX83WfYwSATaNdxiSTsKssJCmYgq27HAB9C1NG72gQbg+Zx3zSGi2ME+nvL60C
         tGL0Zlhb1SEASirL+XsG+4Tc5XA3Fs+ZvPi2Wzd3/LPHtoJgzaGeGeOwPZdaLa+Tr0rf
         +1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749297190; x=1749901990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YPpDTdf9e9OdrTEDdAClzqG7dtzs03KQUmygM9lIb5w=;
        b=bhAJI0PpqP6CsgeqQJg2lZqouWSaiB4E8SghNEc/G9g1sxalhxJRd7giXmWENQ8Qxd
         9cy7zKKxukEufW2ke1b3h88WJEmgo635KDWT+hwUYJh3UhR0OfGE+0W9aFW73kFjVqBw
         f3O73REvMrYDDi0wbxQBYfijkFGyvO3gYPRcIhljkT3VOafEYgcktGLOuWe0DGgrJS4d
         tSGYW5gdI8WQkuqAjRNOLTzVSHL7rIUEuF6os9OBrOfMsJqOnFTLqjQzJeDLNjCDvvft
         1czfvi2njBpxcYGT76A7RdT/hZKLGi5VewzFpNCehl9ePSKiwjhxQXOD2jSX4EOx0PiS
         6qsw==
X-Forwarded-Encrypted: i=1; AJvYcCVm72OjoB8LfX1ViyLt2HGq8CNiK6FoUM+E9C9Rp5ZvfucBcNmH/JUaWmQMM+fNLJiycQVEHlBE1wRHy/l5@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ3YdhlMtG9OwahZJquN8FDpKW6J1M3gUeRWE2T3e2Wmw4/zTg
	tRfb2986NVkp8CNtRhs4xCLhOTDhcZbwCctZqJ6nvKbwGnHiqOKhyvt1
X-Gm-Gg: ASbGncuQfiaHjXdGUpxfGgPNU7hudEhT3yf7giYhk0iXxOIAWNIaIIiWG7Klqhsoo8B
	FWwpxSEM1v7IYdo1bFbfpzZFC5nblTy8nwJTkyu+HC2Ln34t54FhbCuysvVAHS/JlPhg7voY8Rc
	wMN2p1b/VRSDAcvmqjBgydgFZ02u/JDHMBySNCxYkM5FnkVPKCTlYmRmLTCGqOJbI6Xk6hNaBb6
	sYSX+fgMHFOtlHblq2h0mIXn0TogfsLAv9a4nYuGgtrqKOB9hUCIrnDoeNk46kOzI1chBKV42R0
	CEimUhZV2dLMtreQDytReHqeJvQkLc/khrJcA5dgXReBNNox6LCU2L5kbPzAtubkJd4ZdNjbrrl
	g/On1wA4F//UfUO39xHccYdpdkicDbyl8B6jyCZIsaFSZFTBL
X-Google-Smtp-Source: AGHT+IEsxfPWbBEC1DkUqrTEjDQMXxA2OfPa9PM18zX6ToIrbg2EcSmVxbGzGqS3FPZzLt9FAQe/PQ==
X-Received: by 2002:a17:907:6ea6:b0:ad8:9ca4:af7c with SMTP id a640c23a62f3a-ade076350e8mr1023480866b.17.1749297189034;
        Sat, 07 Jun 2025 04:53:09 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1d7542b1sm264876766b.35.2025.06.07.04.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jun 2025 04:53:08 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2] fs: constify file ptr in backing_file accessor helpers
Date: Sat,  7 Jun 2025 13:53:03 +0200
Message-Id: <20250607115304.2521155-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250607115304.2521155-1-amir73il@gmail.com>
References: <20250607115304.2521155-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add internal helper backing_file_set_user_path() for the only
two cases that need to modify backing_file fields.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/backing-file.c  |  4 ++--
 fs/file_table.c    | 13 ++++++++-----
 fs/internal.h      |  1 +
 include/linux/fs.h |  6 +++---
 4 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/fs/backing-file.c b/fs/backing-file.c
index 763fbe9b72b2..8c7396bff121 100644
--- a/fs/backing-file.c
+++ b/fs/backing-file.c
@@ -41,7 +41,7 @@ struct file *backing_file_open(const struct path *user_path, int flags,
 		return f;
 
 	path_get(user_path);
-	*backing_file_user_path(f) = *user_path;
+	backing_file_set_user_path(f, user_path);
 	error = vfs_open(real_path, f);
 	if (error) {
 		fput(f);
@@ -65,7 +65,7 @@ struct file *backing_tmpfile_open(const struct path *user_path, int flags,
 		return f;
 
 	path_get(user_path);
-	*backing_file_user_path(f) = *user_path;
+	backing_file_set_user_path(f, user_path);
 	error = vfs_tmpfile(real_idmap, real_parentpath, f, mode);
 	if (error) {
 		fput(f);
diff --git a/fs/file_table.c b/fs/file_table.c
index 138114d64307..f09d79a98111 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -52,17 +52,20 @@ struct backing_file {
 	};
 };
 
-static inline struct backing_file *backing_file(struct file *f)
-{
-	return container_of(f, struct backing_file, file);
-}
+#define backing_file(f) container_of(f, struct backing_file, file)
 
-struct path *backing_file_user_path(struct file *f)
+struct path *backing_file_user_path(const struct file *f)
 {
 	return &backing_file(f)->user_path;
 }
 EXPORT_SYMBOL_GPL(backing_file_user_path);
 
+void backing_file_set_user_path(struct file *f, const struct path *path)
+{
+	backing_file(f)->user_path = *path;
+}
+EXPORT_SYMBOL_GPL(backing_file_set_user_path);
+
 static inline void file_free(struct file *f)
 {
 	security_file_free(f);
diff --git a/fs/internal.h b/fs/internal.h
index 393f6c5c24f6..d733d8bb3d1f 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -101,6 +101,7 @@ extern void chroot_fs_refs(const struct path *, const struct path *);
 struct file *alloc_empty_file(int flags, const struct cred *cred);
 struct file *alloc_empty_file_noaccount(int flags, const struct cred *cred);
 struct file *alloc_empty_backing_file(int flags, const struct cred *cred);
+void backing_file_set_user_path(struct file *f, const struct path *path);
 
 static inline void file_put_write_access(struct file *file)
 {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 96c7925a6551..fbcd74ae2a50 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2864,7 +2864,7 @@ struct file *dentry_open_nonotify(const struct path *path, int flags,
 				  const struct cred *cred);
 struct file *dentry_create(const struct path *path, int flags, umode_t mode,
 			   const struct cred *cred);
-struct path *backing_file_user_path(struct file *f);
+struct path *backing_file_user_path(const struct file *f);
 
 /*
  * When mmapping a file on a stackable filesystem (e.g., overlayfs), the file
@@ -2876,14 +2876,14 @@ struct path *backing_file_user_path(struct file *f);
  * by fstat() on that same fd.
  */
 /* Get the path to display in /proc/<pid>/maps */
-static inline const struct path *file_user_path(struct file *f)
+static inline const struct path *file_user_path(const struct file *f)
 {
 	if (unlikely(f->f_mode & FMODE_BACKING))
 		return backing_file_user_path(f);
 	return &f->f_path;
 }
 /* Get the inode whose inode number to display in /proc/<pid>/maps */
-static inline const struct inode *file_user_inode(struct file *f)
+static inline const struct inode *file_user_inode(const struct file *f)
 {
 	if (unlikely(f->f_mode & FMODE_BACKING))
 		return d_inode(backing_file_user_path(f)->dentry);
-- 
2.34.1


