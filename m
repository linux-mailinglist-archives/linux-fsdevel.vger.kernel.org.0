Return-Path: <linux-fsdevel+bounces-6658-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF5E81B2F6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 10:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 204A7B23602
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 09:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93934D5A8;
	Thu, 21 Dec 2023 09:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePf8FBIR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB85F4CE1D;
	Thu, 21 Dec 2023 09:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40d05ebe642so10002625e9.0;
        Thu, 21 Dec 2023 01:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703152458; x=1703757258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bdjl6DHnRAQDl9Cy2avTCTNsQchdn1cLv97adEQptCY=;
        b=ePf8FBIR02jjiy7dxgLOn27KA/DXIi7sr7yeODd+EhardbH7X1pqsWAdsBQgB9ag0t
         gyZBoW64UP8xlaMWL2eDpYipZ2FU1sAysO1bRP+SS7HN9b22ZjObF3wGps7/UWxAzd9W
         htMtdy+O0iwx8mjVp+SfjJtsZVb90/oasOPWoosXLVKcoNJ/DF2yhgDCluG4bxBE2uoZ
         rDPcm352vuEgAApOQO54GIXUIc6w7TkI9/NYHsH04kS7Z2EGLtH51VeLZ7um3fCDOrpQ
         pv5TfaQWRu8/cjQ1Vvz2VCGpEpmL93T5C+4wBjQ8TWgIhuPCzuQ78M8kqYAHg7/qKEA8
         Lnvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703152458; x=1703757258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bdjl6DHnRAQDl9Cy2avTCTNsQchdn1cLv97adEQptCY=;
        b=qWyaAd23NL4f58Casog1xWfLfYnZMMX+8RMqJDv8dlOjwtnv28uoUMhyzJE1s7rjTg
         SuwjKDNAdwDbPXmlCwTunOMrTBlA3N+lMq6plMxhIJ9ZI6Y9VXozwJaVQ1Z3Ml4qkpuV
         W7FBaJAL1qYonDCsfhg5S6p3p730oHLksydVOHltqS88tagAbzKFbB4h2q9Fpra7Jml4
         g1nayQKLT/0EAHBw1d1eJLwdTZVSDOvn0PKfuGrULsXh38tGkjc1oPYO/nhbAaWndTG5
         xVrABv3KgczKDY7/4qbgsQYmJm+vF+7KI/vIKjHqpoQ8tZExPEXyn4KtHcmeLyCcJOtn
         F8RA==
X-Gm-Message-State: AOJu0YxDCBgq+acRCYbtmwMuvA7x0YfTEzV258HWGEL2fs797iCRrbSc
	TUHNNw8ksYdk5jC5i7Salgw=
X-Google-Smtp-Source: AGHT+IGi5vEpeZtoTHPqrEQl793oXLw63VPGGC6YgSlH/16+FP6aBCMh1syUV+BqHKEap67sbbl3rg==
X-Received: by 2002:a05:600c:354b:b0:40c:6e98:7c50 with SMTP id i11-20020a05600c354b00b0040c6e987c50mr298121wmq.165.1703152457971;
        Thu, 21 Dec 2023 01:54:17 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id f5-20020adff8c5000000b003367dad4a58sm1628082wrq.70.2023.12.21.01.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 01:54:17 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: [RFC][PATCH 3/4] fs: factor out backing_file_splice_{read,write}() helpers
Date: Thu, 21 Dec 2023 11:54:09 +0200
Message-Id: <20231221095410.801061-4-amir73il@gmail.com>
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

There is not much in those helpers, but it makes sense to have them
logically next to the backing_file_{read,write}_iter() helpers as they
may grow more common logic in the future.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/backing-file.c            | 45 ++++++++++++++++++++++++++++++++++++
 fs/overlayfs/file.c          | 33 +++++++++++---------------
 include/linux/backing-file.h |  8 +++++++
 3 files changed, 66 insertions(+), 20 deletions(-)

diff --git a/fs/backing-file.c b/fs/backing-file.c
index c1976ef5c210..46488de821a2 100644
--- a/fs/backing-file.c
+++ b/fs/backing-file.c
@@ -10,6 +10,7 @@
 
 #include <linux/fs.h>
 #include <linux/backing-file.h>
+#include <linux/splice.h>
 
 #include "internal.h"
 
@@ -239,6 +240,50 @@ ssize_t backing_file_write_iter(struct file *file, struct iov_iter *iter,
 }
 EXPORT_SYMBOL_GPL(backing_file_write_iter);
 
+ssize_t backing_file_splice_read(struct file *in, loff_t *ppos,
+				 struct pipe_inode_info *pipe, size_t len,
+				 unsigned int flags,
+				 struct backing_file_ctx *ctx)
+{
+	const struct cred *old_cred;
+	ssize_t ret;
+
+	old_cred = override_creds(ctx->cred);
+	ret = vfs_splice_read(in, ppos, pipe, len, flags);
+	revert_creds(old_cred);
+
+	if (ctx->accessed)
+		ctx->accessed(ctx->user_file);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(backing_file_splice_read);
+
+ssize_t backing_file_splice_write(struct pipe_inode_info *pipe,
+				  struct file *out, loff_t *ppos, size_t len,
+				  unsigned int flags,
+				  struct backing_file_ctx *ctx)
+{
+	const struct cred *old_cred;
+	ssize_t ret;
+
+	ret = file_remove_privs(ctx->user_file);
+	if (ret)
+		return ret;
+
+	old_cred = override_creds(ctx->cred);
+	file_start_write(out);
+	ret = iter_file_splice_write(pipe, out, ppos, len, flags);
+	file_end_write(out);
+	revert_creds(old_cred);
+
+	if (ctx->end_write)
+		ctx->end_write(ctx->user_file);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(backing_file_splice_write);
+
 static int __init backing_aio_init(void)
 {
 	backing_aio_cachep = kmem_cache_create("backing_aio",
diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 1b578cb27a26..69b52d2f9c74 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -9,7 +9,6 @@
 #include <linux/xattr.h>
 #include <linux/uio.h>
 #include <linux/uaccess.h>
-#include <linux/splice.h>
 #include <linux/security.h>
 #include <linux/mm.h>
 #include <linux/fs.h>
@@ -332,20 +331,21 @@ static ssize_t ovl_splice_read(struct file *in, loff_t *ppos,
 			       struct pipe_inode_info *pipe, size_t len,
 			       unsigned int flags)
 {
-	const struct cred *old_cred;
 	struct fd real;
 	ssize_t ret;
+	struct backing_file_ctx ctx = {
+		.cred = ovl_creds(file_inode(in)->i_sb),
+		.user_file = in,
+		.accessed = ovl_file_accessed,
+	};
 
 	ret = ovl_real_fdget(in, &real);
 	if (ret)
 		return ret;
 
-	old_cred = ovl_override_creds(file_inode(in)->i_sb);
-	ret = vfs_splice_read(real.file, ppos, pipe, len, flags);
-	revert_creds(old_cred);
-	ovl_file_accessed(in);
-
+	ret = backing_file_splice_read(real.file, ppos, pipe, len, flags, &ctx);
 	fdput(real);
+
 	return ret;
 }
 
@@ -361,30 +361,23 @@ static ssize_t ovl_splice_write(struct pipe_inode_info *pipe, struct file *out,
 				loff_t *ppos, size_t len, unsigned int flags)
 {
 	struct fd real;
-	const struct cred *old_cred;
 	struct inode *inode = file_inode(out);
 	ssize_t ret;
+	struct backing_file_ctx ctx = {
+		.cred = ovl_creds(inode->i_sb),
+		.user_file = out,
+		.end_write = ovl_file_modified,
+	};
 
 	inode_lock(inode);
 	/* Update mode */
 	ovl_copyattr(inode);
-	ret = file_remove_privs(out);
-	if (ret)
-		goto out_unlock;
 
 	ret = ovl_real_fdget(out, &real);
 	if (ret)
 		goto out_unlock;
 
-	old_cred = ovl_override_creds(inode->i_sb);
-	file_start_write(real.file);
-
-	ret = iter_file_splice_write(pipe, real.file, ppos, len, flags);
-
-	file_end_write(real.file);
-	/* Update size */
-	ovl_file_modified(out);
-	revert_creds(old_cred);
+	ret = backing_file_splice_write(pipe, real.file, ppos, len, flags, &ctx);
 	fdput(real);
 
 out_unlock:
diff --git a/include/linux/backing-file.h b/include/linux/backing-file.h
index 0648d548a418..0546d5b1c9f5 100644
--- a/include/linux/backing-file.h
+++ b/include/linux/backing-file.h
@@ -28,5 +28,13 @@ ssize_t backing_file_read_iter(struct file *file, struct iov_iter *iter,
 ssize_t backing_file_write_iter(struct file *file, struct iov_iter *iter,
 				struct kiocb *iocb, int flags,
 				struct backing_file_ctx *ctx);
+ssize_t backing_file_splice_read(struct file *in, loff_t *ppos,
+				 struct pipe_inode_info *pipe, size_t len,
+				 unsigned int flags,
+				 struct backing_file_ctx *ctx);
+ssize_t backing_file_splice_write(struct pipe_inode_info *pipe,
+				  struct file *out, loff_t *ppos, size_t len,
+				  unsigned int flags,
+				  struct backing_file_ctx *ctx);
 
 #endif /* _LINUX_BACKING_FILE_H */
-- 
2.34.1


