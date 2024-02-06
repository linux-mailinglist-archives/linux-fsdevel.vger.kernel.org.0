Return-Path: <linux-fsdevel+bounces-10483-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E3584B7CC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 15:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F7BE1F27C9A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 14:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5102613328C;
	Tue,  6 Feb 2024 14:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFPXNm/x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9215132C37
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Feb 2024 14:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707229514; cv=none; b=kAPXw1A/OExaJR0+3MxlPDtv+NQu6F1iNuatJSiqOBrxnvs5xNM2CIQVg5YHpdsYic8EyQnYYbyVoTMoDDFHSmLwD3IBKX3nelIJ8vHpGkb/ofAbwyASeP5dIZkPwwYBH0q1fzUMVGfyMP8frkr45hnJXzK9HTthY5iu1fSkDXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707229514; c=relaxed/simple;
	bh=uplzIYz81OjPNsqsXBnf8den2rH5SzRCaVDLZ7EAXMI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yyp2USwMJRGBZdLoZqE5qJCMV+ZVCeiMVXT+Ukjhlvt8krFDdNmHXH0FvBgH/wFVSjAM8anTP2W9KcbKk5ji2Hur7WntSsDJwqwDNNcPW/zr0XNiNK2FuPtgwY8vfmlEXFApTyDirRKpeXrPavBmeC0mg1m5tK7mb1BTY15OD9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dFPXNm/x; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33b466bc363so479781f8f.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Feb 2024 06:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707229511; x=1707834311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/hyy8pftoIAuFr3lIeUur4NLP4UN4IOZ33cfl3dry9Q=;
        b=dFPXNm/xQ555noyuVkMg3YFrubTtFh7tBppyBpxAV5LEVwy0Rtr0CKK2Eo0LDVhk1x
         QXVC8vvmdPufdmTrKKZVqD7weZsz6yyL+k5sM6jVw72Gw7hDcf9l9/dpmfSYX8Q2SvJ5
         W7AYdp2Z4vTBYExS7drM/FV8Aq2sw2U2en0omPndJPNISnbQBaDtXpyVQosdvz5spu+V
         kXFBmroRV4pZanm4hmsECrOFekdVUlL1YYHEFtQaCbY3nK2XD+dA8jXhoqMHGIdAF4cA
         hg6V65QW3Kuxpl4Bn/hYazTdUSLh2jFQNLd5idRqdhKBh6I4SMALpaNEiS+yi4Wv0Vb3
         Hm/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707229511; x=1707834311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/hyy8pftoIAuFr3lIeUur4NLP4UN4IOZ33cfl3dry9Q=;
        b=JeGecjsOmxeWkIh1AfOK8e41I0R0StvpSMDHDKX6L/ED1lUlSFodYbCRyIBB54JLIZ
         YqRKgLAT7dQqUTPGV56n8NROs/KsTWsLlvpFqR1XC4CCpSDzLcaHZnSS0fSaxPKRQYfi
         tA/udzhhPpxFph21Z1WV3P+AM1g2hF8cn6lJAV8ZVl7YPN0rtffaMImzdcKNXZWfPv1R
         eaYnPSwAVkKD4QJPelaIbEsn9wGyhzsoYgpOgsDMNgVdNTm8rPj8enHECt2CSMMVVB2o
         vEW9M6OxphaHjyDh1f0Wz4PEFf6ANMMQeiNuH37O6vOjeiHMfGyv9snvS5wvvqjigdjU
         Yh9Q==
X-Gm-Message-State: AOJu0YxDreF3GBX6AdzoU8JTxOeb8aN6zsd5M5DKTrT7XsE/0z84zmIg
	zjoublVUQR1bI1p4FM6/M6VazZrUZ1Y3YimHwUuZhDRU2xsnzGuAkhoaU7/N
X-Google-Smtp-Source: AGHT+IHYDOjW7uBDH+jJFqfhLAJyqDPF5kxeADXz6p7j08oUG95N+I5IDC8dgGd18hvkV3o3P2Ekgg==
X-Received: by 2002:a5d:66cd:0:b0:33b:2a02:61a8 with SMTP id k13-20020a5d66cd000000b0033b2a0261a8mr1366308wrw.45.1707229511188;
        Tue, 06 Feb 2024 06:25:11 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXt6y+UbNHp+RzN/iQRp0j/FbrWMM8B02A2d5QWkSrTSuKi+y5z3wc68EamLUwSflGcqDJdcw7hrDgUandXcNF8H4VvJLB7OiuUHsLD2w==
Received: from amir-ThinkPad-T480.lan (46-117-242-41.bb.netvision.net.il. [46.117.242.41])
        by smtp.gmail.com with ESMTPSA id c28-20020adfa31c000000b0033b4a6f46d7sm629728wrb.87.2024.02.06.06.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 06:25:10 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v15 9/9] fuse: auto-invalidate inode attributes in passthrough mode
Date: Tue,  6 Feb 2024 16:24:53 +0200
Message-Id: <20240206142453.1906268-10-amir73il@gmail.com>
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

After passthrough read/write, we invalidate a/c/mtime/size attributes
if the backing inode attributes differ from FUSE inode attributes.

Do the same in fuse_getattr() and after detach of backing inode, so that
passthrough mmap read/write changes to a/c/mtime/size attribute of the
backing inode will be propagated to the FUSE inode.

The rules of invalidating a/c/mtime/size attributes with writeback cache
are more complicated, so for now, writeback cache and passthrough cannot
be enabled on the same filesystem.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/fuse/dir.c         |  4 ++++
 fs/fuse/fuse_i.h      |  2 ++
 fs/fuse/inode.c       |  4 ++++
 fs/fuse/iomode.c      |  5 +++-
 fs/fuse/passthrough.c | 55 ++++++++++++++++++++++++++++++++++++-------
 5 files changed, 61 insertions(+), 9 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 95330c2ca3d8..7f9d002b8f23 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -2118,6 +2118,10 @@ static int fuse_getattr(struct mnt_idmap *idmap,
 		return -EACCES;
 	}
 
+	/* Maybe update/invalidate attributes from backing inode */
+	if (fuse_inode_backing(get_fuse_inode(inode)))
+		fuse_backing_update_attr_mask(inode, request_mask);
+
 	return fuse_update_get_attr(inode, NULL, stat, request_mask, flags);
 }
 
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 98f878a52af1..4b011d31012f 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1456,6 +1456,8 @@ void fuse_backing_files_init(struct fuse_conn *fc);
 void fuse_backing_files_free(struct fuse_conn *fc);
 int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map);
 int fuse_backing_close(struct fuse_conn *fc, int backing_id);
+void fuse_backing_update_attr(struct inode *inode, struct fuse_backing *fb);
+void fuse_backing_update_attr_mask(struct inode *inode, u32 request_mask);
 
 struct fuse_backing *fuse_passthrough_open(struct file *file,
 					   struct inode *inode,
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index c26a84439934..c68f005b6e86 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1302,9 +1302,13 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 			 * on a stacked fs (e.g. overlayfs) themselves and with
 			 * max_stack_depth == 1, FUSE fs can be stacked as the
 			 * underlying fs of a stacked fs (e.g. overlayfs).
+			 *
+			 * For now, writeback cache and passthrough cannot be
+			 * enabled on the same filesystem.
 			 */
 			if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH) &&
 			    (flags & FUSE_PASSTHROUGH) &&
+			    !fc->writeback_cache &&
 			    arg->max_stack_depth > 0 &&
 			    arg->max_stack_depth <= FILESYSTEM_MAX_STACK_DEPTH) {
 				fc->passthrough = 1;
diff --git a/fs/fuse/iomode.c b/fs/fuse/iomode.c
index c545058a01e1..96eb311fe7bd 100644
--- a/fs/fuse/iomode.c
+++ b/fs/fuse/iomode.c
@@ -157,8 +157,11 @@ void fuse_file_uncached_io_end(struct inode *inode)
 	spin_unlock(&fi->lock);
 	if (!uncached_io)
 		wake_up(&fi->direct_io_waitq);
-	if (oldfb)
+	if (oldfb) {
+		/* Maybe update attributes after detaching backing inode */
+		fuse_backing_update_attr(inode, oldfb);
 		fuse_backing_put(oldfb);
+	}
 }
 
 /*
diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
index 260e76fc72d5..c1bb80a6e536 100644
--- a/fs/fuse/passthrough.c
+++ b/fs/fuse/passthrough.c
@@ -11,11 +11,8 @@
 #include <linux/backing-file.h>
 #include <linux/splice.h>
 
-static void fuse_file_accessed(struct file *file)
+static void fuse_backing_accessed(struct inode *inode, struct fuse_backing *fb)
 {
-	struct inode *inode = file_inode(file);
-	struct fuse_inode *fi = get_fuse_inode(inode);
-	struct fuse_backing *fb = fuse_inode_backing(fi);
 	struct inode *backing_inode = file_inode(fb->file);
 	struct timespec64 atime = inode_get_atime(inode);
 	struct timespec64 batime = inode_get_atime(backing_inode);
@@ -25,11 +22,8 @@ static void fuse_file_accessed(struct file *file)
 		fuse_invalidate_atime(inode);
 }
 
-static void fuse_file_modified(struct file *file)
+static void fuse_backing_modified(struct inode *inode, struct fuse_backing *fb)
 {
-	struct inode *inode = file_inode(file);
-	struct fuse_inode *fi = get_fuse_inode(inode);
-	struct fuse_backing *fb = fuse_inode_backing(fi);
 	struct inode *backing_inode = file_inode(fb->file);
 	struct timespec64 ctime = inode_get_ctime(inode);
 	struct timespec64 mtime = inode_get_mtime(inode);
@@ -42,6 +36,51 @@ static void fuse_file_modified(struct file *file)
 		fuse_invalidate_attr_mask(inode, FUSE_STATX_MODSIZE);
 }
 
+/* Called from fuse_file_uncached_io_end() after detach of backing inode */
+void fuse_backing_update_attr(struct inode *inode, struct fuse_backing *fb)
+{
+	fuse_backing_modified(inode, fb);
+	fuse_backing_accessed(inode, fb);
+}
+
+/* Called from fuse_getattr() - may race with detach of backing inode */
+void fuse_backing_update_attr_mask(struct inode *inode, u32 request_mask)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct fuse_backing *fb;
+
+	rcu_read_lock();
+	fb = fuse_backing_get(fuse_inode_backing(fi));
+	rcu_read_unlock();
+	if (!fb)
+		return;
+
+	if (request_mask & FUSE_STATX_MODSIZE)
+		fuse_backing_modified(inode, fb);
+	if (request_mask & STATX_ATIME)
+		fuse_backing_accessed(inode, fb);
+
+	fuse_backing_put(fb);
+}
+
+static void fuse_file_accessed(struct file *file)
+{
+	struct inode *inode = file_inode(file);
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct fuse_backing *fb = fuse_inode_backing(fi);
+
+	fuse_backing_accessed(inode, fb);
+}
+
+static void fuse_file_modified(struct file *file)
+{
+	struct inode *inode = file_inode(file);
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct fuse_backing *fb = fuse_inode_backing(fi);
+
+	fuse_backing_modified(inode, fb);
+}
+
 ssize_t fuse_passthrough_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 {
 	struct file *file = iocb->ki_filp;
-- 
2.34.1


