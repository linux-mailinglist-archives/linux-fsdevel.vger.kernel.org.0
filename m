Return-Path: <linux-fsdevel+bounces-10482-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F4A84B7CB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 15:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C38D1C21182
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 14:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02989132470;
	Tue,  6 Feb 2024 14:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3Wahcxc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A51132C19
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Feb 2024 14:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707229513; cv=none; b=eaRkf2cI/UbhXhpRMQWEEtzoxSGAnaicrfcn7J+px+nPs5beVeLkJY7ZUFjcgxF6Iw9vDkwJVx0z+AuL+9BU9Z58tdnuxqYyPVjXmhOnk6zqhdpf6BY2LDIFifYmsZpaWcOI/uybbaNFamaNFgRl3331zOu8rFgq1VM6+Kr2Xj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707229513; c=relaxed/simple;
	bh=Ee+4G9M+hVE3/0FrDQNy7QjZiZttVJRp2tWdKTf5vkk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BPpfqvFrrqGP75OH6GUcVwwpP0Fe3641tf+wsWoWOfE9HQwo+IYZb3R49ILOvTwb+YJ2XyFDe6obTGIhEdrLIxR9G/VQYGdEW42WBGSu2c4aP7QOxV/DYbesDJogue8T5Npjbc49SVHfBgQfPkELeUohCZ1I+RCvL01FLdB+izY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T3Wahcxc; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40fc549ab9bso38268455e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Feb 2024 06:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707229510; x=1707834310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HTWT98yeBNfdBQwDTGSlxmuWSq3AOov4hX8TNCj0bRM=;
        b=T3WahcxcxTc26D1Aq/Brm/tUs2wuBB4Bj7EXaPjp+GDoDcHeWLnvi97O2vnAgQlV8i
         PH/Jb+2FtcC+veQ/wTB2ksSfWXYkWnFVGPzYdcev4kc/Jm293VhpalrwNF1d/FHy547t
         KzTN971S8home2rMFE+2w9NersPIEIlab5dpkXgRhVFoZXKEZj4tyShrXrhp5DnNExs9
         XbLBR7PcZp+b/xaG/ktGOwMnFFvUOiOexQOW+B5a0m8oHHo6ue2TpGrFuJuc84Coawcd
         I+VkHQXCSE96NLC3xg6zGqywARyVTVpd5seyeCDPRU2BUrun/RvnmO/wEwomgdKW2yfh
         eu+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707229510; x=1707834310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HTWT98yeBNfdBQwDTGSlxmuWSq3AOov4hX8TNCj0bRM=;
        b=Y7ICDdlwIBhpyuq/Lh+3DsxjZPrsAx2l+K5h2a8GqziPJnSNMa3m3WcJQI2WoCWAHJ
         zS2nMzBwnnIp4QaA0/IVdkPm8/Ed0WxogkkW7T4/33sVmv+RL680KDBaJ6gQCp06Qpeo
         XL4sR2tbLDGjNrPWIwN760ZvWtIT3hpnjftvvzQUg7xJCTTf9GP3KzYkvlGUzc7fGi1t
         b8Dj0RBaX+JMM/WwAdf+Vh4Z37c+V2fuZBqfKMbrhUlKkGi8QuZ3qC8r6Z7hdWcyaVCq
         3q3q/T6xQ+ZN3Knh0ICxv0jTwI1byQbgwD6KnoQS7g4sR0BBZfshB/dzCnkRjN/6Ej4i
         XoOw==
X-Gm-Message-State: AOJu0Yxoy2djITak1PItszbtKc8JjlxwXhq/GvQrqr5qfbRyxSw4MP9v
	ad3OGLkuRI1hKcex5RBEr1vpaE6NC/pEZeObtkdFkIW1sd0g6+W4eJV1e3Iv
X-Google-Smtp-Source: AGHT+IGxTlv3u/LASUXKij6lp5y34IkrHXTYqgltYTi1n4eCIWCA8D8wu70JSJXsSIXr3va/4hosKw==
X-Received: by 2002:a05:600c:524a:b0:40e:f9df:3531 with SMTP id fc10-20020a05600c524a00b0040ef9df3531mr2304573wmb.8.1707229509890;
        Tue, 06 Feb 2024 06:25:09 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUjO5sBflogMDoZUsWYKkq0P9evmPMFH0u6pOsWFvG9ouTnyyTiK/vcXzfh050U2aoasDXYJ6mYewAVV+i3kJ2PLqfRYSkhzCYbyzu0kQ==
Received: from amir-ThinkPad-T480.lan (46-117-242-41.bb.netvision.net.il. [46.117.242.41])
        by smtp.gmail.com with ESMTPSA id c28-20020adfa31c000000b0033b4a6f46d7sm629728wrb.87.2024.02.06.06.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 06:25:09 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v15 8/9] fuse: implement passthrough for mmap
Date: Tue,  6 Feb 2024 16:24:52 +0200
Message-Id: <20240206142453.1906268-9-amir73il@gmail.com>
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

An mmap request for a file open in passthrough mode, maps the memory
directly to the backing file.

An mmap of a file in direct io mode, usually uses cached mmap and puts
the inode in caching io mode, which denies new passthrough opens of that
inode, because caching io mode is conflicting with passthrough io mode.

For the same reason, trying to mmap a direct io file, while there is
a passthrough file open on the same inode will fail with -ENODEV.

An mmap of a file in direct io mode, also needs to wait for parallel
dio writes in-progress to complete.

If a passthrough file is opened, while an mmap of another direct io
file is waiting for parallel dio writes to complete, the wait is aborted
and mmap fails with -ENODEV.

A FUSE server that uses passthrough and direct io opens on the same inode
that may also be mmaped, is advised to provide a backing fd also for the
files that are open in direct io mode (i.e. use the flags combination
FOPEN_DIRECT_IO | FOPEN_PASSTHROUGH), so that mmap will always use the
backing file, even if read/write do not passthrough.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/fuse/file.c        | 13 ++++++++++---
 fs/fuse/fuse_i.h      |  1 +
 fs/fuse/iomode.c      |  9 ++++++++-
 fs/fuse/passthrough.c | 16 ++++++++++++++++
 4 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 80f98affbe7d..edbcb9ceb7e7 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2550,14 +2550,21 @@ static int fuse_file_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct fuse_file *ff = file->private_data;
 	struct fuse_conn *fc = ff->fm->fc;
+	struct inode *inode = file_inode(file);
 	int rc;
 
 	/* DAX mmap is superior to direct_io mmap */
-	if (FUSE_IS_DAX(file_inode(file)))
+	if (FUSE_IS_DAX(inode))
 		return fuse_dax_mmap(file, vma);
 
-	/* TODO: implement mmap to backing file */
+	/*
+	 * If inode is in passthrough io mode, because it has some file open
+	 * in passthrough mode, either mmap to backing file or fail mmap,
+	 * because mixing cached mmap and passthrough io mode is not allowed.
+	 */
 	if (fuse_file_passthrough(ff))
+		return fuse_passthrough_mmap(file, vma);
+	else if (fuse_inode_backing(get_fuse_inode(inode)))
 		return -ENODEV;
 
 	/*
@@ -2579,7 +2586,7 @@ static int fuse_file_mmap(struct file *file, struct vm_area_struct *vma)
 		 * Also waits for parallel dio writers to go into serial mode
 		 * (exclusive instead of shared lock).
 		 */
-		rc = fuse_file_io_mmap(ff, file_inode(file));
+		rc = fuse_file_io_mmap(ff, inode);
 		if (rc)
 			return rc;
 
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index c495eaa11b49..98f878a52af1 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1479,5 +1479,6 @@ ssize_t fuse_passthrough_splice_read(struct file *in, loff_t *ppos,
 ssize_t fuse_passthrough_splice_write(struct pipe_inode_info *pipe,
 				      struct file *out, loff_t *ppos,
 				      size_t len, unsigned int flags);
+ssize_t fuse_passthrough_mmap(struct file *file, struct vm_area_struct *vma);
 
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/iomode.c b/fs/fuse/iomode.c
index dce369f3b201..c545058a01e1 100644
--- a/fs/fuse/iomode.c
+++ b/fs/fuse/iomode.c
@@ -17,7 +17,7 @@
  */
 static inline bool fuse_is_io_cache_wait(struct fuse_inode *fi)
 {
-	return READ_ONCE(fi->iocachectr) < 0;
+	return READ_ONCE(fi->iocachectr) < 0 && !fuse_inode_backing(fi);
 }
 
 /*
@@ -42,6 +42,13 @@ static int fuse_inode_get_io_cache(struct fuse_inode *fi)
 					  !fuse_is_io_cache_wait(fi));
 		spin_lock(&fi->lock);
 	}
+	/*
+	 * Check if inode entered passthrough io mode while waiting for parallel
+	 * dio write completion.
+	 */
+	if (fuse_inode_backing(fi))
+		err = -ETXTBSY;
+
 	/*
 	 * Enter caching mode or clear the FUSE_I_CACHE_IO_MODE bit if we
 	 * failed to enter caching mode and no other caching open exists.
diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
index df8343cebd0a..260e76fc72d5 100644
--- a/fs/fuse/passthrough.c
+++ b/fs/fuse/passthrough.c
@@ -141,6 +141,22 @@ ssize_t fuse_passthrough_splice_write(struct pipe_inode_info *pipe,
 	return ret;
 }
 
+ssize_t fuse_passthrough_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct fuse_file *ff = file->private_data;
+	struct file *backing_file = fuse_file_passthrough(ff);
+	struct backing_file_ctx ctx = {
+		.cred = ff->cred,
+		.user_file = file,
+		.accessed = fuse_file_accessed,
+	};
+
+	pr_debug("%s: backing_file=0x%p, start=%lu, end=%lu\n", __func__,
+		 backing_file, vma->vm_start, vma->vm_end);
+
+	return backing_file_mmap(backing_file, vma, &ctx);
+}
+
 struct fuse_backing *fuse_backing_get(struct fuse_backing *fb)
 {
 	if (fb && refcount_inc_not_zero(&fb->count))
-- 
2.34.1


