Return-Path: <linux-fsdevel+bounces-16326-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0E589B2C4
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Apr 2024 17:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D89AA28247A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Apr 2024 15:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C2C3A1BF;
	Sun,  7 Apr 2024 15:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HyA0fYS8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FD539FE5
	for <linux-fsdevel@vger.kernel.org>; Sun,  7 Apr 2024 15:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712505490; cv=none; b=nRxwT0SUPy1OAcfIZ1RAoEd9FU+ItlPui/a1GKssAEsyD9Q86sxfCAjKVqRNfmJ8dra8zgxlfplUK3VLbbPhhmLjlNCYuc7o1YXCIoi4Mv/RPEPBjQus1+MU1oaSZGYzNOwr96udmMHpHpm7BzFJc1HL9YqWARy+aYSLNW7dyDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712505490; c=relaxed/simple;
	bh=cG1eNuk1oDJmntU1jWgkSKnKrc8KbRN5OATM/Fk52TA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d2xzFkmpKqtY/hQXG+0Rw+9VBKxNb80TUJxijmx41i/eLx5F78OhrO0ZEV3Jo7j0RyXcjyIv6/JiMzj2oIj8/LYJx03FhHvN3yiWSSIfzZ5JexrpcpWGn9tOgDdCJSqozX8Co7lTs/mtthIG117/bsvJtWciPZkZaW1pbl9dpQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HyA0fYS8; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d6c9678cbdso46996831fa.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 07 Apr 2024 08:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712505486; x=1713110286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t0v8T1lr/jYsYgMin8n0wnlgLBXUf0Am8mRTes43pTg=;
        b=HyA0fYS8YzqDOFVk5CEQrXGZTsutBQio6JmNisYPu2t69zygf/tWd1oEuVfQkFQZ62
         ucX1/rMy131CI99LyJO8xuEIe0vQ5kodhnWwAFJAbXPf/ushF9KtIfC/cpx/hnlaDghG
         8jbpHkmjkX3Lq8fc+x7bLxC15OqQpisZb4OAhiaPpf4CO5JPIUFR1BIEJFxigB+N+Lis
         L4WWNivGmoJCn4i7DHVHhKFZYBg9QDSr9pEaOYODJJyISP3sSbzqUkka6h+SkcuwH2pj
         QT4ky9sADBaSGSgVXlfZZ0dUDrtjeXu3dQyocQNcRJvvqqFoKrpNe6OyDLzAGOcRGFKm
         UI5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712505486; x=1713110286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t0v8T1lr/jYsYgMin8n0wnlgLBXUf0Am8mRTes43pTg=;
        b=mvTUxH9l/yKvTGHpxlx5uMU7rN59VShIuDtz1QyxT4uoxUwHYD4OKRWJAu8Bl0mHd6
         akDqLV3XYik+uHdVsHKiPf+b0PqHb06buqYWY3Rz/1GgvhKqQm2eC93sZC837TtzwKW2
         wXCUZFZ8kJ2vKIIGFGhh4mqQgP9GwVjS5Ll0NCIh7HeVseAbzn5wGjmP1I7y4cZvdO77
         fUaeue0rmvdVYwhlXv+qjXrm3ob2GnRY8ORXPYfy72bEQup6WpK1ZU9BXM0v5geyk81/
         FzICdKzlir9+HJHSZJK6p8WhYb1bGmF8UAReY/+dKFtUK0w16yo2MO6iw9DGJsk411l9
         86pA==
X-Forwarded-Encrypted: i=1; AJvYcCXQqJVy8gPXoK6Cdy7wvhuEmFPXs5F39UlesYUSmgDkWGWedjAh2ajBmTfnR4IqA1E8R62gxAsgYyQ9g1zmN8zS1JNzHw2mQ9mfijsvJw==
X-Gm-Message-State: AOJu0Yx0WHrkYVfvBQqarCo801uoGUgu9SczqlW2s/ks9t5Soq+kvV3c
	C9sQ0bdbdOQ1ad44y2jGktOVMzC+J2JLEy9JyO0RFlrRPZ4ogP4l
X-Google-Smtp-Source: AGHT+IGgCceZMrQy9ZwXKItVNIKtgSI2nJW/uhgHgpNYX4AGKsXud5rofoe/rU1wnnJfeFKEjJ8OFg==
X-Received: by 2002:a2e:99d3:0:b0:2d8:5084:f5b9 with SMTP id l19-20020a2e99d3000000b002d85084f5b9mr4280608ljj.28.1712505486018;
        Sun, 07 Apr 2024 08:58:06 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan (85-250-214-4.bb.netvision.net.il. [85.250.214.4])
        by smtp.gmail.com with ESMTPSA id l11-20020a05600c1d0b00b0041645193a55sm4600171wms.21.2024.04.07.08.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 08:58:05 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/3] fuse: fix wrong ff->iomode state changes from parallel dio write
Date: Sun,  7 Apr 2024 18:57:56 +0300
Message-Id: <20240407155758.575216-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240407155758.575216-1-amir73il@gmail.com>
References: <20240407155758.575216-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a confusion with fuse_file_uncached_io_{start,end} interface.
These helpers do two things when called from passthrough open()/release():
1. Take/drop negative refcount of fi->iocachectr (inode uncached io mode)
2. State change ff->iomode IOM_NONE <-> IOM_UNCACHED (file uncached open)

The calls from parallel dio write path need to take a reference on
fi->iocachectr, but they should not be changing ff->iomode state,
because in this case, the fi->iocachectr reference does not stick around
until file release().

Factor out helpers fuse_inode_uncached_io_{start,end}, to be used from
parallel dio write path and rename fuse_file_*cached_io_{start,end}
helpers to fuse_file_*cached_io_{open,release} to clarify the difference.

Add a check of ff->iomode in mmap(), so that fuse_file_cached_io_open()
is called only on first mmap of direct_io file.

Fixes: 205c1d802683 ("fuse: allow parallel dio writes with FUSE_DIRECT_IO_ALLOW_MMAP")
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/fuse/file.c   | 18 +++++++++------
 fs/fuse/fuse_i.h |  7 +++---
 fs/fuse/inode.c  |  1 +
 fs/fuse/iomode.c | 59 ++++++++++++++++++++++++++++++++----------------
 4 files changed, 56 insertions(+), 29 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index a56e7bffd000..fcf20b304093 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1362,7 +1362,7 @@ static void fuse_dio_lock(struct kiocb *iocb, struct iov_iter *from,
 			  bool *exclusive)
 {
 	struct inode *inode = file_inode(iocb->ki_filp);
-	struct fuse_file *ff = iocb->ki_filp->private_data;
+	struct fuse_inode *fi = get_fuse_inode(inode);
 
 	*exclusive = fuse_dio_wr_exclusive_lock(iocb, from);
 	if (*exclusive) {
@@ -1377,7 +1377,7 @@ static void fuse_dio_lock(struct kiocb *iocb, struct iov_iter *from,
 		 * have raced, so check it again.
 		 */
 		if (fuse_io_past_eof(iocb, from) ||
-		    fuse_file_uncached_io_start(inode, ff, NULL) != 0) {
+		    fuse_inode_uncached_io_start(fi, NULL) != 0) {
 			inode_unlock_shared(inode);
 			inode_lock(inode);
 			*exclusive = true;
@@ -1388,13 +1388,13 @@ static void fuse_dio_lock(struct kiocb *iocb, struct iov_iter *from,
 static void fuse_dio_unlock(struct kiocb *iocb, bool exclusive)
 {
 	struct inode *inode = file_inode(iocb->ki_filp);
-	struct fuse_file *ff = iocb->ki_filp->private_data;
+	struct fuse_inode *fi = get_fuse_inode(inode);
 
 	if (exclusive) {
 		inode_unlock(inode);
 	} else {
 		/* Allow opens in caching mode after last parallel dio end */
-		fuse_file_uncached_io_end(inode, ff);
+		fuse_inode_uncached_io_end(fi);
 		inode_unlock_shared(inode);
 	}
 }
@@ -2574,10 +2574,14 @@ static int fuse_file_mmap(struct file *file, struct vm_area_struct *vma)
 		 * First mmap of direct_io file enters caching inode io mode.
 		 * Also waits for parallel dio writers to go into serial mode
 		 * (exclusive instead of shared lock).
+		 * After first mmap, the inode stays in caching io mode until
+		 * the direct_io file release.
 		 */
-		rc = fuse_file_cached_io_start(inode, ff);
-		if (rc)
-			return rc;
+		if (READ_ONCE(ff->iomode) != IOM_CACHED) {
+			rc = fuse_file_cached_io_open(inode, ff);
+			if (rc)
+				return rc;
+		}
 	}
 
 	if ((vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_MAYWRITE))
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index b24084b60864..f23919610313 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1394,9 +1394,10 @@ int fuse_fileattr_set(struct mnt_idmap *idmap,
 		      struct dentry *dentry, struct fileattr *fa);
 
 /* iomode.c */
-int fuse_file_cached_io_start(struct inode *inode, struct fuse_file *ff);
-int fuse_file_uncached_io_start(struct inode *inode, struct fuse_file *ff, struct fuse_backing *fb);
-void fuse_file_uncached_io_end(struct inode *inode, struct fuse_file *ff);
+int fuse_file_cached_io_open(struct inode *inode, struct fuse_file *ff);
+int fuse_inode_uncached_io_start(struct fuse_inode *fi,
+				 struct fuse_backing *fb);
+void fuse_inode_uncached_io_end(struct fuse_inode *fi);
 
 int fuse_file_io_open(struct file *file, struct inode *inode);
 void fuse_file_io_release(struct fuse_file *ff, struct inode *inode);
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 3a5d88878335..99e44ea7d875 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -175,6 +175,7 @@ static void fuse_evict_inode(struct inode *inode)
 		}
 	}
 	if (S_ISREG(inode->i_mode) && !fuse_is_bad(inode)) {
+		WARN_ON(fi->iocachectr != 0);
 		WARN_ON(!list_empty(&fi->write_files));
 		WARN_ON(!list_empty(&fi->queued_writes));
 	}
diff --git a/fs/fuse/iomode.c b/fs/fuse/iomode.c
index c653ddcf0578..1519f895f0a9 100644
--- a/fs/fuse/iomode.c
+++ b/fs/fuse/iomode.c
@@ -21,12 +21,13 @@ static inline bool fuse_is_io_cache_wait(struct fuse_inode *fi)
 }
 
 /*
- * Start cached io mode.
+ * Called on cached file open() and on first mmap() of direct_io file.
+ * Takes cached_io inode mode reference to be dropped on file release.
  *
  * Blocks new parallel dio writes and waits for the in-progress parallel dio
  * writes to complete.
  */
-int fuse_file_cached_io_start(struct inode *inode, struct fuse_file *ff)
+int fuse_file_cached_io_open(struct inode *inode, struct fuse_file *ff)
 {
 	struct fuse_inode *fi = get_fuse_inode(inode);
 
@@ -56,8 +57,7 @@ int fuse_file_cached_io_start(struct inode *inode, struct fuse_file *ff)
 		return -ETXTBSY;
 	}
 
-	WARN_ON(ff->iomode == IOM_UNCACHED);
-	if (ff->iomode == IOM_NONE) {
+	if (!WARN_ON(ff->iomode != IOM_NONE)) {
 		ff->iomode = IOM_CACHED;
 		if (fi->iocachectr == 0)
 			set_bit(FUSE_I_CACHE_IO_MODE, &fi->state);
@@ -67,10 +67,9 @@ int fuse_file_cached_io_start(struct inode *inode, struct fuse_file *ff)
 	return 0;
 }
 
-static void fuse_file_cached_io_end(struct inode *inode, struct fuse_file *ff)
+static void fuse_file_cached_io_release(struct fuse_file *ff,
+					struct fuse_inode *fi)
 {
-	struct fuse_inode *fi = get_fuse_inode(inode);
-
 	spin_lock(&fi->lock);
 	WARN_ON(fi->iocachectr <= 0);
 	WARN_ON(ff->iomode != IOM_CACHED);
@@ -82,9 +81,8 @@ static void fuse_file_cached_io_end(struct inode *inode, struct fuse_file *ff)
 }
 
 /* Start strictly uncached io mode where cache access is not allowed */
-int fuse_file_uncached_io_start(struct inode *inode, struct fuse_file *ff, struct fuse_backing *fb)
+int fuse_inode_uncached_io_start(struct fuse_inode *fi, struct fuse_backing *fb)
 {
-	struct fuse_inode *fi = get_fuse_inode(inode);
 	struct fuse_backing *oldfb;
 	int err = 0;
 
@@ -99,9 +97,7 @@ int fuse_file_uncached_io_start(struct inode *inode, struct fuse_file *ff, struc
 		err = -ETXTBSY;
 		goto unlock;
 	}
-	WARN_ON(ff->iomode != IOM_NONE);
 	fi->iocachectr--;
-	ff->iomode = IOM_UNCACHED;
 
 	/* fuse inode holds a single refcount of backing file */
 	if (!oldfb) {
@@ -115,15 +111,29 @@ int fuse_file_uncached_io_start(struct inode *inode, struct fuse_file *ff, struc
 	return err;
 }
 
-void fuse_file_uncached_io_end(struct inode *inode, struct fuse_file *ff)
+/* Takes uncached_io inode mode reference to be dropped on file release */
+static int fuse_file_uncached_io_open(struct inode *inode,
+				      struct fuse_file *ff,
+				      struct fuse_backing *fb)
 {
 	struct fuse_inode *fi = get_fuse_inode(inode);
+	int err;
+
+	err = fuse_inode_uncached_io_start(fi, fb);
+	if (err)
+		return err;
+
+	WARN_ON(ff->iomode != IOM_NONE);
+	ff->iomode = IOM_UNCACHED;
+	return 0;
+}
+
+void fuse_inode_uncached_io_end(struct fuse_inode *fi)
+{
 	struct fuse_backing *oldfb = NULL;
 
 	spin_lock(&fi->lock);
 	WARN_ON(fi->iocachectr >= 0);
-	WARN_ON(ff->iomode != IOM_UNCACHED);
-	ff->iomode = IOM_NONE;
 	fi->iocachectr++;
 	if (!fi->iocachectr) {
 		wake_up(&fi->direct_io_waitq);
@@ -134,6 +144,15 @@ void fuse_file_uncached_io_end(struct inode *inode, struct fuse_file *ff)
 		fuse_backing_put(oldfb);
 }
 
+/* Drop uncached_io reference from passthrough open */
+static void fuse_file_uncached_io_release(struct fuse_file *ff,
+					  struct fuse_inode *fi)
+{
+	WARN_ON(ff->iomode != IOM_UNCACHED);
+	ff->iomode = IOM_NONE;
+	fuse_inode_uncached_io_end(fi);
+}
+
 /*
  * Open flags that are allowed in combination with FOPEN_PASSTHROUGH.
  * A combination of FOPEN_PASSTHROUGH and FOPEN_DIRECT_IO means that read/write
@@ -163,7 +182,7 @@ static int fuse_file_passthrough_open(struct inode *inode, struct file *file)
 		return PTR_ERR(fb);
 
 	/* First passthrough file open denies caching inode io mode */
-	err = fuse_file_uncached_io_start(inode, ff, fb);
+	err = fuse_file_uncached_io_open(inode, ff, fb);
 	if (!err)
 		return 0;
 
@@ -216,7 +235,7 @@ int fuse_file_io_open(struct file *file, struct inode *inode)
 	if (ff->open_flags & FOPEN_PASSTHROUGH)
 		err = fuse_file_passthrough_open(inode, file);
 	else
-		err = fuse_file_cached_io_start(inode, ff);
+		err = fuse_file_cached_io_open(inode, ff);
 	if (err)
 		goto fail;
 
@@ -236,8 +255,10 @@ int fuse_file_io_open(struct file *file, struct inode *inode)
 /* No more pending io and no new io possible to inode via open/mmapped file */
 void fuse_file_io_release(struct fuse_file *ff, struct inode *inode)
 {
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
 	/*
-	 * Last parallel dio close allows caching inode io mode.
+	 * Last passthrough file close allows caching inode io mode.
 	 * Last caching file close exits caching inode io mode.
 	 */
 	switch (ff->iomode) {
@@ -245,10 +266,10 @@ void fuse_file_io_release(struct fuse_file *ff, struct inode *inode)
 		/* Nothing to do */
 		break;
 	case IOM_UNCACHED:
-		fuse_file_uncached_io_end(inode, ff);
+		fuse_file_uncached_io_release(ff, fi);
 		break;
 	case IOM_CACHED:
-		fuse_file_cached_io_end(inode, ff);
+		fuse_file_cached_io_release(ff, fi);
 		break;
 	}
 }
-- 
2.34.1


