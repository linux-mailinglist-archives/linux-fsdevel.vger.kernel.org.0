Return-Path: <linux-fsdevel+bounces-10478-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A3284B7C3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 15:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A7E31C218B2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 14:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E37132C0F;
	Tue,  6 Feb 2024 14:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/gfPgtY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE73132C01
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Feb 2024 14:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707229508; cv=none; b=g/f/186FCxqfsRXbF+NH/tbaMjMxE95aoM12bd07q07Dff+eLDZK2BjXzop2R1wExcdxPlcKL+b8wgP5zDy/orBmcEYdHcbXnmZmBJZRy1gIR3TIqHtC+MIuEt/UiCeDGF0y9zFT/xpKd4ZnzeanDmrR4RAquI9alujryMgWdxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707229508; c=relaxed/simple;
	bh=qk3g+eB8rHG+CqGuXWL6Kq+fKCGENQ/QF4MzcDMzfm4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jLJLfXe4UMB0oiP9zh1vL30TvboPp8e5mwDFDjzY/I77F+p2K4nyiiuAhxOov5G8hjqSJkbOouYmdMAg1ttofxdjIunJaHlRaUZTAxNN0nKB3IHyJp3LL4FOlotSvIrIsPMGigZe+aM28Ud+FRjFgl4cGXqYpZXutt1xwqiZx0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/gfPgtY; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40fe2ed8746so5805805e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Feb 2024 06:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707229505; x=1707834305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6w+6IpIzqyBB0prz82XVFsSS1wwVL5Tjm5Oc10QusGY=;
        b=W/gfPgtYlLgEE4DbCsOwLtibE7D0z6gboQ9swPWziYPyz/zdzV8w7gGgWIv3JmVf7X
         /5BdCTYovKyfNAR2rEYv8w2UapTrc0D5aXW9LLEqyOPCr8cBkHLY9JnUEb1PWzvJ5lhM
         jHHdvjjAv0vo8AsxPKuMCw/BKeMroyUEOcSpVD9HyUOpYOsWbx71pomoGBVkHJvAr29H
         3NHwoOtE3FHwwSHNBHs5S8DTY0ROa10KN56H0o4/QpxCdq2nCSzbCCFcjAv59apIVu9F
         Euz92XvecLOUCbIxKOU5brLUbEJ3jktPgmLIPFcu0ishd2bjrrCHd80Qu3bM1HZ6IvpN
         RoZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707229505; x=1707834305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6w+6IpIzqyBB0prz82XVFsSS1wwVL5Tjm5Oc10QusGY=;
        b=Hyh1fT025jZI1PuwByUcNzbl1Fr7EwiWRhxZBBjLyHfqg1noGGAq3gNZXav88udhpN
         XXMHEiWyMSvarzySFtaFzc+kzfFNmAh3Nc5T34OyUpJaA9vT9DHNbxi+/WxjFXAHBECB
         /SSNCjQ7U95j1BbNyD2m4/oPHxxExhmvw6wwLIzg5mqWgKTkZuyUoK2xOje7HC8XFwtg
         OySDu+/f5ppATHcyopJahy0hHPIF42KRlPLdaEdCDtWexH7mQKZPMvCIYDgn00MjEl9n
         Dxb6+w3GzjfRJn3ZDhyCBDdECjjOfMHuSmmMeGYHCQANva5NfVtEvdU2Tev40iPj/5xK
         qf2g==
X-Gm-Message-State: AOJu0YwDEO2OYCyF0l11V6PuIUWcuS/FyRcXLzooHL9AIa4nZciIPM4u
	9TtD6ABdgB+oR21+zGl8CTsBKNUu74BbbMcOMRNED9oYLjmZ80JsRvswlF/Q
X-Google-Smtp-Source: AGHT+IE6m8gdN64i+z/OQg7rZinLsYVp9H6PdbSutx8bUnYDNFXCUx8goaeIs8a0NWg+o+YzCUY7Zw==
X-Received: by 2002:a05:600c:4f90:b0:40f:df20:3bc3 with SMTP id n16-20020a05600c4f9000b0040fdf203bc3mr1568279wmq.3.1707229504772;
        Tue, 06 Feb 2024 06:25:04 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUjoQ9r3JC8cMZufVoxxKQtBnKqx6NZtxKO+SZElmE/gsTqtAqCMZl9CdIlox/fNKhsHbDMDodgHSeXH2hTfqmYApyIupnnhuS2GUvM7g==
Received: from amir-ThinkPad-T480.lan (46-117-242-41.bb.netvision.net.il. [46.117.242.41])
        by smtp.gmail.com with ESMTPSA id c28-20020adfa31c000000b0033b4a6f46d7sm629728wrb.87.2024.02.06.06.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 06:25:03 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v15 4/9] fuse: prepare for opening file in passthrough mode
Date: Tue,  6 Feb 2024 16:24:48 +0200
Message-Id: <20240206142453.1906268-5-amir73il@gmail.com>
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

In preparation for opening file in passthrough mode, store the
fuse_open_out argument in ff->args to be passed into fuse_file_io_open()
with the optional backing_id member.

This will be used for setting up passthrough to backing file on open
reply with FOPEN_PASSTHROUGH flag and a valid backing_id.

Opening a file in passthrough mode may fail for several reasons, such as
missing capability, conflicting open flags or inode in caching mode.
Return EIO from fuse_file_io_open() in those cases.

The combination of FOPEN_PASSTHROUGH and FOPEN_DIRECT_IO is allowed -
it mean that read/write operations will go directly to the server,
but mmap will be done to the backing file.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/fuse/dir.c    | 12 +++++++-----
 fs/fuse/file.c   | 34 +++++++++++++++-------------------
 fs/fuse/fuse_i.h | 19 ++++++++++++++++---
 fs/fuse/iomode.c | 48 +++++++++++++++++++++++++++++++++++++++++-------
 4 files changed, 79 insertions(+), 34 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index ea635c17572a..95330c2ca3d8 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -615,7 +615,7 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 	FUSE_ARGS(args);
 	struct fuse_forget_link *forget;
 	struct fuse_create_in inarg;
-	struct fuse_open_out outopen;
+	struct fuse_open_out *outopenp;
 	struct fuse_entry_out outentry;
 	struct fuse_inode *fi;
 	struct fuse_file *ff;
@@ -659,8 +659,10 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 	args.out_numargs = 2;
 	args.out_args[0].size = sizeof(outentry);
 	args.out_args[0].value = &outentry;
-	args.out_args[1].size = sizeof(outopen);
-	args.out_args[1].value = &outopen;
+	/* Store outarg for fuse_finish_open() */
+	outopenp = &ff->args->open_outarg;
+	args.out_args[1].size = sizeof(*outopenp);
+	args.out_args[1].value = outopenp;
 
 	err = get_create_ext(&args, dir, entry, mode);
 	if (err)
@@ -676,9 +678,9 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 	    fuse_invalid_attr(&outentry.attr))
 		goto out_free_ff;
 
-	ff->fh = outopen.fh;
+	ff->fh = outopenp->fh;
 	ff->nodeid = outentry.nodeid;
-	ff->open_flags = outopen.open_flags;
+	ff->open_flags = outopenp->open_flags;
 	inode = fuse_iget(dir->i_sb, outentry.nodeid, outentry.generation,
 			  &outentry.attr, ATTR_TIMEOUT(&outentry), 0);
 	if (!inode) {
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index eb226457c4bd..04be04b6b2af 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -50,12 +50,6 @@ static int fuse_send_open(struct fuse_mount *fm, u64 nodeid,
 	return fuse_simple_request(fm, &args);
 }
 
-struct fuse_release_args {
-	struct fuse_args args;
-	struct fuse_release_in inarg;
-	struct inode *inode;
-};
-
 struct fuse_file *fuse_file_alloc(struct fuse_mount *fm, bool release)
 {
 	struct fuse_file *ff;
@@ -66,9 +60,8 @@ struct fuse_file *fuse_file_alloc(struct fuse_mount *fm, bool release)
 
 	ff->fm = fm;
 	if (release) {
-		ff->release_args = kzalloc(sizeof(*ff->release_args),
-					   GFP_KERNEL_ACCOUNT);
-		if (!ff->release_args) {
+		ff->args = kzalloc(sizeof(*ff->args), GFP_KERNEL_ACCOUNT);
+		if (!ff->args) {
 			kfree(ff);
 			return NULL;
 		}
@@ -87,7 +80,7 @@ struct fuse_file *fuse_file_alloc(struct fuse_mount *fm, bool release)
 
 void fuse_file_free(struct fuse_file *ff)
 {
-	kfree(ff->release_args);
+	kfree(ff->args);
 	mutex_destroy(&ff->readdir.lock);
 	kfree(ff);
 }
@@ -110,7 +103,7 @@ static void fuse_release_end(struct fuse_mount *fm, struct fuse_args *args,
 static void fuse_file_put(struct fuse_file *ff, bool sync)
 {
 	if (refcount_dec_and_test(&ff->count)) {
-		struct fuse_release_args *ra = ff->release_args;
+		struct fuse_release_args *ra = &ff->args->release_args;
 		struct fuse_args *args = (ra ? &ra->args : NULL);
 
 		if (ra && ra->inode)
@@ -147,20 +140,21 @@ struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
 	/* Default for no-open */
 	ff->open_flags = FOPEN_KEEP_CACHE | (isdir ? FOPEN_CACHE_DIR : 0);
 	if (!noopen) {
-		struct fuse_open_out outarg;
+		/* Store outarg for fuse_finish_open() */
+		struct fuse_open_out *outargp = &ff->args->open_outarg;
 		int err;
 
-		err = fuse_send_open(fm, nodeid, open_flags, opcode, &outarg);
+		err = fuse_send_open(fm, nodeid, open_flags, opcode, outargp);
 		if (!err) {
-			ff->fh = outarg.fh;
-			ff->open_flags = outarg.open_flags;
+			ff->fh = outargp->fh;
+			ff->open_flags = outargp->open_flags;
 		} else if (err != -ENOSYS) {
 			fuse_file_free(ff);
 			return ERR_PTR(err);
 		} else {
 			/* No release needed */
-			kfree(ff->release_args);
-			ff->release_args = NULL;
+			kfree(ff->args);
+			ff->args = NULL;
 			if (isdir)
 				fc->no_opendir = 1;
 			else
@@ -299,7 +293,7 @@ static void fuse_prepare_release(struct fuse_inode *fi, struct fuse_file *ff,
 				 unsigned int flags, int opcode, bool sync)
 {
 	struct fuse_conn *fc = ff->fm->fc;
-	struct fuse_release_args *ra = ff->release_args;
+	struct fuse_release_args *ra = &ff->args->release_args;
 
 	/* Inode is NULL on error path of fuse_create_open() */
 	if (likely(fi)) {
@@ -317,6 +311,8 @@ static void fuse_prepare_release(struct fuse_inode *fi, struct fuse_file *ff,
 	if (!ra)
 		return;
 
+	/* ff->args was used for open outarg */
+	memset(ff->args, 0, sizeof(*ff->args));
 	ra->inarg.fh = ff->fh;
 	ra->inarg.flags = flags;
 	ra->args.in_numargs = 1;
@@ -339,7 +335,7 @@ void fuse_file_release(struct inode *inode, struct fuse_file *ff,
 		       unsigned int open_flags, fl_owner_t id, bool isdir)
 {
 	struct fuse_inode *fi = get_fuse_inode(inode);
-	struct fuse_release_args *ra = ff->release_args;
+	struct fuse_release_args *ra = &ff->args->release_args;
 	int opcode = isdir ? FUSE_RELEASEDIR : FUSE_RELEASE;
 
 	fuse_prepare_release(fi, ff, open_flags, opcode, false);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index fb9ef02cbf45..eea8f1ffc766 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -213,15 +213,15 @@ enum {
 
 struct fuse_conn;
 struct fuse_mount;
-struct fuse_release_args;
+union fuse_file_args;
 
 /** FUSE specific file data */
 struct fuse_file {
 	/** Fuse connection for this file */
 	struct fuse_mount *fm;
 
-	/* Argument space reserved for release */
-	struct fuse_release_args *release_args;
+	/* Argument space reserved for open/release */
+	union fuse_file_args *args;
 
 	/** Kernel file handle guaranteed to be unique */
 	u64 kh;
@@ -320,6 +320,19 @@ struct fuse_args_pages {
 	unsigned int num_pages;
 };
 
+struct fuse_release_args {
+	struct fuse_args args;
+	struct fuse_release_in inarg;
+	struct inode *inode;
+};
+
+union fuse_file_args {
+	/* Used during open() */
+	struct fuse_open_out open_outarg;
+	/* Used during release() */
+	struct fuse_release_args release_args;
+};
+
 #define FUSE_ARGS(args) struct fuse_args args = {}
 
 /** The request IO state (for asynchronous processing) */
diff --git a/fs/fuse/iomode.c b/fs/fuse/iomode.c
index acd0833ae873..48105f3c00f6 100644
--- a/fs/fuse/iomode.c
+++ b/fs/fuse/iomode.c
@@ -138,9 +138,40 @@ void fuse_file_uncached_io_end(struct inode *inode)
 		wake_up(&fi->direct_io_waitq);
 }
 
+/*
+ * Open flags that are allowed in combination with FOPEN_PASSTHROUGH.
+ * A combination of FOPEN_PASSTHROUGH and FOPEN_DIRECT_IO means that read/write
+ * operations go directly to the server, but mmap is done on the backing file.
+ * FOPEN_PASSTHROUGH mode should not co-exist with any users of the fuse inode
+ * page cache, so FOPEN_KEEP_CACHE is a strange and undesired combination.
+ */
+#define FOPEN_PASSTHROUGH_MASK \
+	(FOPEN_PASSTHROUGH | FOPEN_DIRECT_IO | FOPEN_PARALLEL_DIRECT_WRITES | \
+	 FOPEN_NOFLUSH)
+
+static int fuse_file_passthrough_open(struct file *file, struct inode *inode)
+{
+	struct fuse_file *ff = file->private_data;
+	struct fuse_conn *fc = get_fuse_conn(inode);
+	int err;
+
+	/* Check allowed conditions for file open in passthrough mode */
+	if (!IS_ENABLED(CONFIG_FUSE_PASSTHROUGH) || !fc->passthrough ||
+	    (ff->open_flags & ~FOPEN_PASSTHROUGH_MASK))
+		return -EINVAL;
+
+	/* TODO: implement backing file open */
+	return -EOPNOTSUPP;
+
+	/* First passthrough file open denies caching inode io mode */
+	err = fuse_file_uncached_io_start(inode);
+
+	return err;
+}
+
 /* Open flags to determine regular file io mode */
 #define FOPEN_IO_MODE_MASK \
-	(FOPEN_DIRECT_IO | FOPEN_CACHE_IO)
+	(FOPEN_DIRECT_IO | FOPEN_CACHE_IO | FOPEN_PASSTHROUGH)
 
 /* Request access to submit new io to inode via open file */
 int fuse_file_io_open(struct file *file, struct inode *inode)
@@ -162,7 +193,7 @@ int fuse_file_io_open(struct file *file, struct inode *inode)
 	 * implement open.
 	 */
 	err = -EINVAL;
-	if (FUSE_IS_DAX(inode) || !ff->release_args) {
+	if (FUSE_IS_DAX(inode) || !ff->args) {
 		if (iomode_flags)
 			goto fail;
 		return 0;
@@ -170,7 +201,7 @@ int fuse_file_io_open(struct file *file, struct inode *inode)
 
 	/*
 	 * FOPEN_CACHE_IO is an internal flag that is set on file not open in
-	 * direct io mode and it cannot be set explicitly by the server.
+	 * direct io or passthrough mode and it cannot be set by the server.
 	 * This includes a file open with O_DIRECT, but server did not specify
 	 * FOPEN_DIRECT_IO. In this case, a later fcntl() could remove O_DIRECT,
 	 * so we put the inode in caching mode to prevent parallel dio.
@@ -178,7 +209,7 @@ int fuse_file_io_open(struct file *file, struct inode *inode)
 	 */
 	if (ff->open_flags & FOPEN_CACHE_IO) {
 		goto fail;
-	} else if (!(ff->open_flags & FOPEN_DIRECT_IO)) {
+	} else if (!(ff->open_flags & FOPEN_IO_MODE_MASK)) {
 		ff->open_flags |= FOPEN_CACHE_IO;
 		ff->open_flags &= ~FOPEN_PARALLEL_DIRECT_WRITES;
 	}
@@ -189,6 +220,8 @@ int fuse_file_io_open(struct file *file, struct inode *inode)
 	err = 0;
 	if (ff->open_flags & FOPEN_CACHE_IO)
 		err = fuse_file_cached_io_start(inode);
+	else if (ff->open_flags & FOPEN_PASSTHROUGH)
+		err = fuse_file_passthrough_open(file, inode);
 	if (err)
 		goto fail;
 
@@ -206,17 +239,18 @@ int fuse_file_io_open(struct file *file, struct inode *inode)
 	return -EIO;
 }
 
-/* Request access to submit new io to inode via mmap */
+/* Request access to submit cached io to inode via mmap */
 int fuse_file_io_mmap(struct fuse_file *ff, struct inode *inode)
 {
 	struct fuse_inode *fi = get_fuse_inode(inode);
 	int err = 0;
 
 	/* There are no io modes if server does not implement open */
-	if (!ff->release_args)
+	if (!ff->args)
 		return 0;
 
-	if (WARN_ON(!ff->io_opened))
+	if (WARN_ON(ff->open_flags & FOPEN_PASSTHROUGH) ||
+	    WARN_ON(!ff->io_opened))
 		return -ENODEV;
 
 	spin_lock(&fi->lock);
-- 
2.34.1


