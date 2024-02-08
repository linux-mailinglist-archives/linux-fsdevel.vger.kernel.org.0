Return-Path: <linux-fsdevel+bounces-10790-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F276584E65A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 18:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 226C51C237DB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 17:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1EC127B78;
	Thu,  8 Feb 2024 17:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRFaLx/Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29190127B75
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Feb 2024 17:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707412147; cv=none; b=alnbthpWBr1Z0WrAQ8LeCrjsDvtBMvCqrrcJ+cqh8GJYhU89tCo4+vJfOpMOMONZZbFtF2f4yMMEdnblqGUcKzsCxeLvBn78/FXLjzGlXtk4Hs5tTqF7yGLU5ov86XUr00SDEjH4fEZiGj/yGwRmxcPNukgN72NvE9oEmTlmPZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707412147; c=relaxed/simple;
	bh=zyjyxPTQgrqxwaG8OXsYqkMgWcx/wbKPulw+D0pMW4I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O5pz51jsQoK6ZNP43yYMGCG2DrU8qsEGvbp+euyAXCFjNdY7S1+MzbgF2tf47HnWZkqHsFY7kaEpa+Q50/Be8nfOEVYu1aIfUxJaTCnBGCJS/MGwqut004kv7xZ6/whli5sorynSdkLPL8JNSghH9f8RU5ZlWpfxSJd5TdTHKws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GRFaLx/Q; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33b45e8a670so1140511f8f.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Feb 2024 09:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707412143; x=1708016943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fOTxTU5+HD6XsbChPm3oRlAV/zAmgK3t6GH4Uq33wG0=;
        b=GRFaLx/QYa8jMx1KDx2oYuV3S3kAYERuExA3YBjvKt+a1jhs/BaadiuuQqbs43koJ6
         Y9zEU2kcoD3QWPnCeh3QTAkebJv+kR9KGrN8aBjam2GcKOXI9M5UPfHel4ax7Bajk/nP
         aHbbY5ejyRb21XETZQoNicAAONsZVKG/q4mNbfHg4l3g0JAG5d0jdYyA3d6cNJKv+VWj
         PruM2D6W0Cb7iG9BASf9lGdoX+rLt6CzNt4om1a9HwfXrSdiSxfSdjwyJrSM3RwpDtSC
         4tVsCdp2LjyRYbYV9oVpc9s42TFQJ1ZgxTryBTtYs/I8jWOf6tPdsjor8Kf7rlRU4xA9
         9Erw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707412143; x=1708016943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fOTxTU5+HD6XsbChPm3oRlAV/zAmgK3t6GH4Uq33wG0=;
        b=rXXQ0p7JXSPt+h7GoP/mBFZein6uQDJhhx8cBRhpfvgcpYDfqNFn4t8zcXYb1XRCvc
         cOqnvhvOL+zdQaZCSK1S0RaIsBEkCjit2i3kfFcCcK/ZTLWeaEI5c7MeC0f5rr+lprbJ
         MrDtToQ4LvbYyQlKLwjwTaqkCcuFFduPB5AR2iuPKG/fNDC8LL8S+frlJbRu01o1Fo8r
         YAZ+XVj1s1zjuhzfzYiBYo4hYZ1Vu2CTOfkohM1Th/jwXvW+G3gt8S3yAFRXwinLBmtM
         UpbPGuBXj0GrEaY149b5Y22VE2DUnW66zMQj8C0RpAnWD/XdKnB1QTbWVTmorQ1E1hlh
         mbOQ==
X-Gm-Message-State: AOJu0Yxi1MeS8u5BabTwSFIlwkRC0Kf5d4Hl4p5WRWPLFTkSlJZUNR5l
	u7r2oNF9in7xTE4IPNAZviClzH0MLLrd7+gQNqI2kkHPQJwb9D9r
X-Google-Smtp-Source: AGHT+IF4xYnUSkwxKbeAGCNxoB+TMiTaDt4iruEBALAJhWFThFymzYlq9Gg1xc4OdIr6qUOmt+b5uQ==
X-Received: by 2002:a5d:5f92:0:b0:33b:2e57:904a with SMTP id dr18-20020a5d5f92000000b0033b2e57904amr75412wrb.42.1707412143329;
        Thu, 08 Feb 2024 09:09:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUb/IC/4sAjUSMuE1J9yarO8tKtsBydm2bIRr/CZ7hsoHLYVVLemxu2lWpPoc2TL6ZhZhzeP60ZI+U+SvYF1AXwgIS9FaFEe7TSGq7d+Q==
Received: from amir-ThinkPad-T480.lan (85-250-217-151.bb.netvision.net.il. [85.250.217.151])
        by smtp.gmail.com with ESMTPSA id f5-20020adfe905000000b0033b4a77b2c7sm4005682wrm.82.2024.02.08.09.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 09:08:58 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 5/9] fuse: allocate ff->release_args only if release is needed
Date: Thu,  8 Feb 2024 19:05:59 +0200
Message-Id: <20240208170603.2078871-6-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208170603.2078871-1-amir73il@gmail.com>
References: <20240208170603.2078871-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This removed the need to pass isdir argument to fuse_put_file().

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/fuse/dir.c    |  2 +-
 fs/fuse/file.c   | 69 +++++++++++++++++++++++++++---------------------
 fs/fuse/fuse_i.h |  2 +-
 3 files changed, 41 insertions(+), 32 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index d19cbf34c634..b8fc3a6b87fe 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -630,7 +630,7 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 		goto out_err;
 
 	err = -ENOMEM;
-	ff = fuse_file_alloc(fm);
+	ff = fuse_file_alloc(fm, true);
 	if (!ff)
 		goto out_put_forget_req;
 
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 151658692eda..0ca471c5d184 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -56,7 +56,7 @@ struct fuse_release_args {
 	struct inode *inode;
 };
 
-struct fuse_file *fuse_file_alloc(struct fuse_mount *fm)
+struct fuse_file *fuse_file_alloc(struct fuse_mount *fm, bool release)
 {
 	struct fuse_file *ff;
 
@@ -65,11 +65,13 @@ struct fuse_file *fuse_file_alloc(struct fuse_mount *fm)
 		return NULL;
 
 	ff->fm = fm;
-	ff->release_args = kzalloc(sizeof(*ff->release_args),
-				   GFP_KERNEL_ACCOUNT);
-	if (!ff->release_args) {
-		kfree(ff);
-		return NULL;
+	if (release) {
+		ff->release_args = kzalloc(sizeof(*ff->release_args),
+					   GFP_KERNEL_ACCOUNT);
+		if (!ff->release_args) {
+			kfree(ff);
+			return NULL;
+		}
 	}
 
 	INIT_LIST_HEAD(&ff->write_entry);
@@ -105,14 +107,14 @@ static void fuse_release_end(struct fuse_mount *fm, struct fuse_args *args,
 	kfree(ra);
 }
 
-static void fuse_file_put(struct fuse_file *ff, bool sync, bool isdir)
+static void fuse_file_put(struct fuse_file *ff, bool sync)
 {
 	if (refcount_dec_and_test(&ff->count)) {
-		struct fuse_args *args = &ff->release_args->args;
+		struct fuse_release_args *ra = ff->release_args;
+		struct fuse_args *args = (ra ? &ra->args : NULL);
 
-		if (isdir ? ff->fm->fc->no_opendir : ff->fm->fc->no_open) {
-			/* Do nothing when client does not implement 'open' */
-			fuse_release_end(ff->fm, args, 0);
+		if (!args) {
+			/* Do nothing when server does not implement 'open' */
 		} else if (sync) {
 			fuse_simple_request(ff->fm, args);
 			fuse_release_end(ff->fm, args, 0);
@@ -132,15 +134,16 @@ struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
 	struct fuse_conn *fc = fm->fc;
 	struct fuse_file *ff;
 	int opcode = isdir ? FUSE_OPENDIR : FUSE_OPEN;
+	int noopen = isdir ? fc->no_opendir : fc->no_open;
 
-	ff = fuse_file_alloc(fm);
+	ff = fuse_file_alloc(fm, !noopen);
 	if (!ff)
 		return ERR_PTR(-ENOMEM);
 
 	ff->fh = 0;
 	/* Default for no-open */
 	ff->open_flags = FOPEN_KEEP_CACHE | (isdir ? FOPEN_CACHE_DIR : 0);
-	if (isdir ? !fc->no_opendir : !fc->no_open) {
+	if (!noopen) {
 		struct fuse_open_out outarg;
 		int err;
 
@@ -148,11 +151,13 @@ struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
 		if (!err) {
 			ff->fh = outarg.fh;
 			ff->open_flags = outarg.open_flags;
-
 		} else if (err != -ENOSYS) {
 			fuse_file_free(ff);
 			return ERR_PTR(err);
 		} else {
+			/* No release needed */
+			kfree(ff->release_args);
+			ff->release_args = NULL;
 			if (isdir)
 				fc->no_opendir = 1;
 			else
@@ -278,7 +283,7 @@ int fuse_open_common(struct inode *inode, struct file *file, bool isdir)
 }
 
 static void fuse_prepare_release(struct fuse_inode *fi, struct fuse_file *ff,
-				 unsigned int flags, int opcode)
+				 unsigned int flags, int opcode, bool sync)
 {
 	struct fuse_conn *fc = ff->fm->fc;
 	struct fuse_release_args *ra = ff->release_args;
@@ -296,6 +301,9 @@ static void fuse_prepare_release(struct fuse_inode *fi, struct fuse_file *ff,
 
 	wake_up_interruptible_all(&ff->poll_wait);
 
+	if (!ra)
+		return;
+
 	ra->inarg.fh = ff->fh;
 	ra->inarg.flags = flags;
 	ra->args.in_numargs = 1;
@@ -305,6 +313,13 @@ static void fuse_prepare_release(struct fuse_inode *fi, struct fuse_file *ff,
 	ra->args.nodeid = ff->nodeid;
 	ra->args.force = true;
 	ra->args.nocreds = true;
+
+	/*
+	 * Hold inode until release is finished.
+	 * From fuse_sync_release() the refcount is 1 and everything's
+	 * synchronous, so we are fine with not doing igrab() here.
+	 */
+	ra->inode = sync ? NULL : igrab(&fi->inode);
 }
 
 void fuse_file_release(struct inode *inode, struct fuse_file *ff,
@@ -314,14 +329,12 @@ void fuse_file_release(struct inode *inode, struct fuse_file *ff,
 	struct fuse_release_args *ra = ff->release_args;
 	int opcode = isdir ? FUSE_RELEASEDIR : FUSE_RELEASE;
 
-	fuse_prepare_release(fi, ff, open_flags, opcode);
+	fuse_prepare_release(fi, ff, open_flags, opcode, false);
 
-	if (ff->flock) {
+	if (ra && ff->flock) {
 		ra->inarg.release_flags |= FUSE_RELEASE_FLOCK_UNLOCK;
 		ra->inarg.lock_owner = fuse_lock_owner_id(ff->fm->fc, id);
 	}
-	/* Hold inode until release is finished */
-	ra->inode = igrab(inode);
 
 	/*
 	 * Normally this will send the RELEASE request, however if
@@ -332,7 +345,7 @@ void fuse_file_release(struct inode *inode, struct fuse_file *ff,
 	 * synchronous RELEASE is allowed (and desirable) in this case
 	 * because the server can be trusted not to screw up.
 	 */
-	fuse_file_put(ff, ff->fm->fc->destroy, isdir);
+	fuse_file_put(ff, ff->fm->fc->destroy);
 }
 
 void fuse_release_common(struct file *file, bool isdir)
@@ -367,12 +380,8 @@ void fuse_sync_release(struct fuse_inode *fi, struct fuse_file *ff,
 		       unsigned int flags)
 {
 	WARN_ON(refcount_read(&ff->count) > 1);
-	fuse_prepare_release(fi, ff, flags, FUSE_RELEASE);
-	/*
-	 * iput(NULL) is a no-op and since the refcount is 1 and everything's
-	 * synchronous, we are fine with not doing igrab() here"
-	 */
-	fuse_file_put(ff, true, false);
+	fuse_prepare_release(fi, ff, flags, FUSE_RELEASE, true);
+	fuse_file_put(ff, true);
 }
 EXPORT_SYMBOL_GPL(fuse_sync_release);
 
@@ -929,7 +938,7 @@ static void fuse_readpages_end(struct fuse_mount *fm, struct fuse_args *args,
 		put_page(page);
 	}
 	if (ia->ff)
-		fuse_file_put(ia->ff, false, false);
+		fuse_file_put(ia->ff, false);
 
 	fuse_io_free(ia);
 }
@@ -1703,7 +1712,7 @@ static void fuse_writepage_free(struct fuse_writepage_args *wpa)
 		__free_page(ap->pages[i]);
 
 	if (wpa->ia.ff)
-		fuse_file_put(wpa->ia.ff, false, false);
+		fuse_file_put(wpa->ia.ff, false);
 
 	kfree(ap->pages);
 	kfree(wpa);
@@ -1945,7 +1954,7 @@ int fuse_write_inode(struct inode *inode, struct writeback_control *wbc)
 	ff = __fuse_write_file_get(fi);
 	err = fuse_flush_times(inode, ff);
 	if (ff)
-		fuse_file_put(ff, false, false);
+		fuse_file_put(ff, false);
 
 	return err;
 }
@@ -2343,7 +2352,7 @@ static int fuse_writepages(struct address_space *mapping,
 		fuse_writepages_send(&data);
 	}
 	if (data.ff)
-		fuse_file_put(data.ff, false, false);
+		fuse_file_put(data.ff, false);
 
 	kfree(data.orig_pages);
 out:
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 1df83eebda92..daf7036cd692 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1036,7 +1036,7 @@ void fuse_read_args_fill(struct fuse_io_args *ia, struct file *file, loff_t pos,
  */
 int fuse_open_common(struct inode *inode, struct file *file, bool isdir);
 
-struct fuse_file *fuse_file_alloc(struct fuse_mount *fm);
+struct fuse_file *fuse_file_alloc(struct fuse_mount *fm, bool release);
 void fuse_file_free(struct fuse_file *ff);
 void fuse_finish_open(struct inode *inode, struct file *file);
 
-- 
2.34.1


