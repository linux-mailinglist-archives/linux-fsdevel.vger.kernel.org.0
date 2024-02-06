Return-Path: <linux-fsdevel+bounces-10480-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E63684B7C9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 15:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87CB01F27409
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 14:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3BA132C2F;
	Tue,  6 Feb 2024 14:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="btxJeXJ9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F69573195
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Feb 2024 14:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707229512; cv=none; b=fgvKn5kwZkvx9i8GdXOA9CVVZeGCpxmj4xr7540dB0RhtKaEknp2hyElkM3Lo+rkoE8SCmh0HKKuq+wqeHM3PUJ5wTgwlUOAe4k7ZowkesZb1oZEiw/AoDTuXfhwM5uJBsK3wR/aQuNB9qf796YxnVGneUOUFv137h64VQaRmYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707229512; c=relaxed/simple;
	bh=X/gXm1BOk2cs7PUctRvR123VKBpJaivRsDRFEllkC/w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lzTKtbnYS9+rgKPW/XT6ejCacENtyUb4Co811RsWMoAoc27RgYxRsLe0GUKzDva0STaSLmxWCVJXsAaZcAEJaVQtMMRS4qbm1v2NmFocT1bnZ0R/4z318xxb8xAtrh33CnpBIvS5ROC/ywBjMbcn7WtLOafljte4Oe9XmwSjCLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=btxJeXJ9; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33b4b121de1so73260f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Feb 2024 06:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707229508; x=1707834308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G0owb3I7frEqNojIjsVx2vGk6v+M8FrlQ1+POn5DDlc=;
        b=btxJeXJ9pJGbMU+f84KZCD4AuaaDhwiWzEV+rKYb2xUNe/JyM3XZ1vI6qY8p1/PKfR
         PLamGXAz5cCn+eLMxTw5Rdx4CPMCVTVcVDNkrJTBEQXG58Q4nmG1UzZZbxb73PeE7SZf
         x4vuAZWdGSSf+OG6XvDqJpufD+U5t4OwPDH8YeIRQPFp7RhzqnEXz04Q7yHM2LZfv3kj
         JcIalDM7HW0I78OWF1YtBDCYcpNZAL5EMRNKuUadzaVr+bwPAgdDoMMiYN56qIUbVpSl
         oEqlbDAdAmowlFCYfHRBwdWu+EN7vojDFao9MzIaV+htPmD215uNZrVNwJMeQ0f7oZ8C
         wp5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707229508; x=1707834308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G0owb3I7frEqNojIjsVx2vGk6v+M8FrlQ1+POn5DDlc=;
        b=oTLXd0NC3Gl2gT2t71O1v+vOglWj1SPFBDu0s78sCvHOqxTGVDV1w5fS/GWjouVC6e
         QhEKeokEnVyJ7TL0MbAYStAT64ZjeLpKQUc8Y3bQn9twllIF5iExB5/MswjTZfyhGQ8n
         xialwvDTpNuOwjzpaWLNBQ2GC58YelnQGHrmoLOr0vQwVz++jGb4Mzh/Y10A/r8ceN6N
         m2uYENqWZYgZyB8I0xDqK4CtIVChi9PJ+7WLQfR5wJ68rqOEZXUxq0VLiUDpp+qYPxub
         OyOwPNxlBO6dnHuTAoXoORMdmlH/CmcymiB0iVMqS9te/EhFpZURufdh1WEwAzybAcxi
         vP+Q==
X-Gm-Message-State: AOJu0YyY7x1X1JSOZlAUSTuB+ABsXNW5by61Zz9aKgj3NdWF+mkqnSeh
	DPEzmSoDhYFXVlrlOOXxdAAqa22+/ZYk/v4mTrxVk06g5XDcv2jg
X-Google-Smtp-Source: AGHT+IHEKTkswE4uzXtp4iCXsGM0VzSJPR+muG1++gqx9DecBkWYkAFri3bNt/csRGpng69hrAEj+w==
X-Received: by 2002:a5d:64eb:0:b0:33b:48f5:b5c7 with SMTP id g11-20020a5d64eb000000b0033b48f5b5c7mr1523129wri.11.1707229507763;
        Tue, 06 Feb 2024 06:25:07 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXyNNOU5GD9cYn9T5wwlswYcnzA0W3AXxtm53apyL45bg4LG3BqsNjn13FUn628zs8feXgaUmx5EOTwYkeceh5OqALiVqfJmFue9gQ8YQ==
Received: from amir-ThinkPad-T480.lan (46-117-242-41.bb.netvision.net.il. [46.117.242.41])
        by smtp.gmail.com with ESMTPSA id c28-20020adfa31c000000b0033b4a6f46d7sm629728wrb.87.2024.02.06.06.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 06:25:06 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v15 6/9] fuse: implement read/write passthrough
Date: Tue,  6 Feb 2024 16:24:50 +0200
Message-Id: <20240206142453.1906268-7-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206142453.1906268-1-amir73il@gmail.com>
References: <20240206142453.1906268-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the backing file read/write helpers to implement read/write
passthrough to a backing file.

After read/write, we invalidate a/c/mtime/size attributes if the
backing inode attributes differ from FUSE inode attributes.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/fuse/file.c        | 18 ++++++---
 fs/fuse/fuse_i.h      |  3 ++
 fs/fuse/passthrough.c | 86 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 101 insertions(+), 6 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index bdcee82fef9a..0f7c53ea2f13 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1688,10 +1688,13 @@ static ssize_t fuse_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	if (FUSE_IS_DAX(inode))
 		return fuse_dax_read_iter(iocb, to);
 
-	if (!(ff->open_flags & FOPEN_DIRECT_IO))
-		return fuse_cache_read_iter(iocb, to);
-	else
+	/* FOPEN_DIRECT_IO overrides FOPEN_PASSTHROUGH */
+	if (ff->open_flags & FOPEN_DIRECT_IO)
 		return fuse_direct_read_iter(iocb, to);
+	else if (fuse_file_passthrough(ff))
+		return fuse_passthrough_read_iter(iocb, to);
+	else
+		return fuse_cache_read_iter(iocb, to);
 }
 
 static ssize_t fuse_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
@@ -1706,10 +1709,13 @@ static ssize_t fuse_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (FUSE_IS_DAX(inode))
 		return fuse_dax_write_iter(iocb, from);
 
-	if (!(ff->open_flags & FOPEN_DIRECT_IO))
-		return fuse_cache_write_iter(iocb, from);
-	else
+	/* FOPEN_DIRECT_IO overrides FOPEN_PASSTHROUGH */
+	if (ff->open_flags & FOPEN_DIRECT_IO)
 		return fuse_direct_write_iter(iocb, from);
+	else if (fuse_file_passthrough(ff))
+		return fuse_passthrough_write_iter(iocb, from);
+	else
+		return fuse_cache_write_iter(iocb, from);
 }
 
 static void fuse_writepage_free(struct fuse_writepage_args *wpa)
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 407b24c79ebb..e47d7e8e4285 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1471,4 +1471,7 @@ static inline struct file *fuse_file_passthrough(struct fuse_file *ff)
 #endif
 }
 
+ssize_t fuse_passthrough_read_iter(struct kiocb *iocb, struct iov_iter *iter);
+ssize_t fuse_passthrough_write_iter(struct kiocb *iocb, struct iov_iter *iter);
+
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
index 098a1f765e99..206eedbf6bf8 100644
--- a/fs/fuse/passthrough.c
+++ b/fs/fuse/passthrough.c
@@ -10,6 +10,92 @@
 #include <linux/file.h>
 #include <linux/backing-file.h>
 
+static void fuse_file_accessed(struct file *file)
+{
+	struct inode *inode = file_inode(file);
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct fuse_backing *fb = fuse_inode_backing(fi);
+	struct inode *backing_inode = file_inode(fb->file);
+	struct timespec64 atime = inode_get_atime(inode);
+	struct timespec64 batime = inode_get_atime(backing_inode);
+
+	/* Mimic atime update policy of backing inode, not the actual value */
+	if (!timespec64_equal(&batime, &atime))
+		fuse_invalidate_atime(inode);
+}
+
+static void fuse_file_modified(struct file *file)
+{
+	struct inode *inode = file_inode(file);
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct fuse_backing *fb = fuse_inode_backing(fi);
+	struct inode *backing_inode = file_inode(fb->file);
+	struct timespec64 ctime = inode_get_ctime(inode);
+	struct timespec64 mtime = inode_get_mtime(inode);
+	struct timespec64 bctime = inode_get_ctime(backing_inode);
+	struct timespec64 bmtime = inode_get_mtime(backing_inode);
+
+	if (!timespec64_equal(&bctime, &ctime) ||
+	    !timespec64_equal(&bmtime, &mtime) ||
+	    i_size_read(backing_inode) != i_size_read(inode))
+		fuse_invalidate_attr_mask(inode, FUSE_STATX_MODSIZE);
+}
+
+ssize_t fuse_passthrough_read_iter(struct kiocb *iocb, struct iov_iter *iter)
+{
+	struct file *file = iocb->ki_filp;
+	struct fuse_file *ff = file->private_data;
+	struct file *backing_file = fuse_file_passthrough(ff);
+	size_t count = iov_iter_count(iter);
+	ssize_t ret;
+	struct backing_file_ctx ctx = {
+		.cred = ff->cred,
+		.user_file = file,
+		.accessed = fuse_file_accessed,
+	};
+
+
+	pr_debug("%s: backing_file=0x%p, pos=%lld, len=%zu\n", __func__,
+		 backing_file, iocb->ki_pos, count);
+
+	if (!count)
+		return 0;
+
+	ret = backing_file_read_iter(backing_file, iter, iocb, iocb->ki_flags,
+				     &ctx);
+
+	return ret;
+}
+
+ssize_t fuse_passthrough_write_iter(struct kiocb *iocb,
+				    struct iov_iter *iter)
+{
+	struct file *file = iocb->ki_filp;
+	struct inode *inode = file_inode(file);
+	struct fuse_file *ff = file->private_data;
+	struct file *backing_file = fuse_file_passthrough(ff);
+	size_t count = iov_iter_count(iter);
+	ssize_t ret;
+	struct backing_file_ctx ctx = {
+		.cred = ff->cred,
+		.user_file = file,
+		.end_write = fuse_file_modified,
+	};
+
+	pr_debug("%s: backing_file=0x%p, pos=%lld, len=%zu\n", __func__,
+		 backing_file, iocb->ki_pos, count);
+
+	if (!count)
+		return 0;
+
+	inode_lock(inode);
+	ret = backing_file_write_iter(backing_file, iter, iocb, iocb->ki_flags,
+				      &ctx);
+	inode_unlock(inode);
+
+	return ret;
+}
+
 struct fuse_backing *fuse_backing_get(struct fuse_backing *fb)
 {
 	if (fb && refcount_inc_not_zero(&fb->count))
-- 
2.34.1


