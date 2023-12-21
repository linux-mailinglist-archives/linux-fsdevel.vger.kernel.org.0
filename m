Return-Path: <linux-fsdevel+bounces-6659-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2777E81B2F7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 10:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A6091C20E90
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 09:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078BB4E1A3;
	Thu, 21 Dec 2023 09:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5DJ2CVz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4084CE14;
	Thu, 21 Dec 2023 09:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-336897b6bd6so342225f8f.2;
        Thu, 21 Dec 2023 01:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703152459; x=1703757259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7DzaZHZbIpywo6AcRCsHP1wRx00TK4+WoZWo2iso5VM=;
        b=k5DJ2CVzUYREbiTwFA1l/l2x3+zbYI8lBcOA7h35ptwd8M520FWa0SBcnfSvZLDIl/
         N1VZCf5CB7JpJduS4Wfc1Xly2i7HE8C19E4QUkTKsjZnr+ShV14Xi+PCjtxy2FSDCUoW
         jVjZXtulFVI8VdXTyraniq47U5DGjg60NSSPXszajgFGgtb6pn7tMsEUT5zqqm7tAl57
         Wqdx1d3/hp6WgbKHgsyK6jhcpwvvtF/TCZeb+9fqXwUwAqlkTMPBpsSrJH1EtX9svvR1
         E7zk8PaOoetbq6Erl5rGQ2P9EIDmDOum9TPThh9c8kIGlAhtO2USiJ4GqaaoVsceRHyq
         cuJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703152459; x=1703757259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7DzaZHZbIpywo6AcRCsHP1wRx00TK4+WoZWo2iso5VM=;
        b=bU/XleAiXbSWGBkzPKUVfKLGPfqYlxqvoyQG8cfo9vqEuur9GeAlNVpysgJeKTxrSt
         kJBXF03qxTJLb8mNkPSayPkQG16E+m06e4jroXKItrJvX4NKNTRclk53+ojCdOfuCGie
         UIQb8yTdspjAZE4oEtV73jKeYf6uv51CqLENRP2puYLRIzlbjvQU274dVuZZgj41ukd4
         IcHACcYYk7dgWksDahXnYgN6WvUsZw3XS2p4AvTndGI9vJ7FnsZE/Mx6Gjf8ZMBL4AVD
         C3knUYYfSYHgjDMzmxpp0ml1twTAZ5bPEK72IJPMH5cprQ6vCX330w8rH5heiSwzhpyz
         zRVQ==
X-Gm-Message-State: AOJu0YzdcA80lDC9dnnqb1g67KZKKiB9cthk0Yg2prNa1Np5jiANaNdP
	MA2zTGVcShtCpYPa/qKGID5PBSsMT0A=
X-Google-Smtp-Source: AGHT+IEFOo6yh5innVrPRk3V/DK/hR2sQgYBmMYCa5EXtiNz4bDAouq8MgBzf4wB3ZrvgoucQG/ydA==
X-Received: by 2002:a05:600c:a05:b0:40d:3785:10b0 with SMTP id z5-20020a05600c0a0500b0040d378510b0mr543755wmp.95.1703152459067;
        Thu, 21 Dec 2023 01:54:19 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id f5-20020adff8c5000000b003367dad4a58sm1628082wrq.70.2023.12.21.01.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 01:54:18 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: [RFC][PATCH 4/4] fs: factor out backing_file_mmap() helper
Date: Thu, 21 Dec 2023 11:54:10 +0200
Message-Id: <20231221095410.801061-5-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221095410.801061-1-amir73il@gmail.com>
References: <20231221095410.801061-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Assert that the file object is allocated in a backing_file container
so that file_user_path() could be used to display the user path and
not the backing file's path in /proc/<pid>/maps.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/backing-file.c            | 27 +++++++++++++++++++++++++++
 fs/overlayfs/file.c          | 23 ++++++-----------------
 include/linux/backing-file.h |  2 ++
 3 files changed, 35 insertions(+), 17 deletions(-)

diff --git a/fs/backing-file.c b/fs/backing-file.c
index 46488de821a2..1ad8c252ec8d 100644
--- a/fs/backing-file.c
+++ b/fs/backing-file.c
@@ -11,6 +11,7 @@
 #include <linux/fs.h>
 #include <linux/backing-file.h>
 #include <linux/splice.h>
+#include <linux/mm.h>
 
 #include "internal.h"
 
@@ -284,6 +285,32 @@ ssize_t backing_file_splice_write(struct pipe_inode_info *pipe,
 }
 EXPORT_SYMBOL_GPL(backing_file_splice_write);
 
+int backing_file_mmap(struct file *file, struct vm_area_struct *vma,
+		      struct backing_file_ctx *ctx)
+{
+	const struct cred *old_cred;
+	int ret;
+
+	if (WARN_ON_ONCE(!(file->f_mode & FMODE_BACKING)) ||
+	    WARN_ON_ONCE(ctx->user_file != vma->vm_file))
+		return -EIO;
+
+	if (!file->f_op->mmap)
+		return -ENODEV;
+
+	vma_set_file(vma, file);
+
+	old_cred = override_creds(ctx->cred);
+	ret = call_mmap(vma->vm_file, vma);
+	revert_creds(old_cred);
+
+	if (ctx->accessed)
+		ctx->accessed(ctx->user_file);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(backing_file_mmap);
+
 static int __init backing_aio_init(void)
 {
 	backing_aio_cachep = kmem_cache_create("backing_aio",
diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 69b52d2f9c74..05536964d37f 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -10,7 +10,6 @@
 #include <linux/uio.h>
 #include <linux/uaccess.h>
 #include <linux/security.h>
-#include <linux/mm.h>
 #include <linux/fs.h>
 #include <linux/backing-file.h>
 #include "overlayfs.h"
@@ -415,23 +414,13 @@ static int ovl_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 static int ovl_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct file *realfile = file->private_data;
-	const struct cred *old_cred;
-	int ret;
-
-	if (!realfile->f_op->mmap)
-		return -ENODEV;
-
-	if (WARN_ON(file != vma->vm_file))
-		return -EIO;
-
-	vma_set_file(vma, realfile);
-
-	old_cred = ovl_override_creds(file_inode(file)->i_sb);
-	ret = call_mmap(vma->vm_file, vma);
-	revert_creds(old_cred);
-	ovl_file_accessed(file);
+	struct backing_file_ctx ctx = {
+		.cred = ovl_creds(file_inode(file)->i_sb),
+		.user_file = file,
+		.accessed = ovl_file_accessed,
+	};
 
-	return ret;
+	return backing_file_mmap(realfile, vma, &ctx);
 }
 
 static long ovl_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
diff --git a/include/linux/backing-file.h b/include/linux/backing-file.h
index 0546d5b1c9f5..3f1fe1774f1b 100644
--- a/include/linux/backing-file.h
+++ b/include/linux/backing-file.h
@@ -36,5 +36,7 @@ ssize_t backing_file_splice_write(struct pipe_inode_info *pipe,
 				  struct file *out, loff_t *ppos, size_t len,
 				  unsigned int flags,
 				  struct backing_file_ctx *ctx);
+int backing_file_mmap(struct file *file, struct vm_area_struct *vma,
+		      struct backing_file_ctx *ctx);
 
 #endif /* _LINUX_BACKING_FILE_H */
-- 
2.34.1


