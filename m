Return-Path: <linux-fsdevel+bounces-30957-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D439F9900E7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 12:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 631291F2203D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 10:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822E4155A25;
	Fri,  4 Oct 2024 10:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYNOm0hJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F8B145B11;
	Fri,  4 Oct 2024 10:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728037433; cv=none; b=qVuMo4QIOpKEW9olTQ1EbWe9wvrtMIYc2zqfjRENO69igsrI7bdM+zc8UlOdw+NZ/IyNN74B3HrRl8tDS0F+oyeUNqfZR8WkSHpu/A0Km8vrR+Ez9wRIBtDMfXlNRNkdAPrbYxr+arhSYWuMhsOAbdPQ9Y8at/9eLMxLBAOHsiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728037433; c=relaxed/simple;
	bh=pmc6qVUuMt/Z2bdiNOPAxptw/xU6ldFSqxts+MtiBqw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BXritaMjQHLj9kb5O9DPFUEtn1x80c4+3Y9q9P2pOmybou+1bi7H1I9dDsSrcVChnIYUX81JCgqJN8K3vevv7y0dkBdH8XGha2aQ4N1eh5FA1nZG5QZ7FIbu2YCZ4h5KqRoRTXbo3nvweKJq3GFVOoyYBMBUdQKkqE58tqKFhiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nYNOm0hJ; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5398ec2f3c3so2533023e87.1;
        Fri, 04 Oct 2024 03:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728037429; x=1728642229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CFRCww6R0ZI7wB7Odoqmaxpyf51HejdOq9ZuRGiYTYA=;
        b=nYNOm0hJZu8rD3d6p9YN3WijmqBmzH86MJyvvWwTw0t9/PUjhKGkf7s5/mHYDUkpDH
         D1+yWGbfeSZ3Y+oSDUYcejJvVS8Etx7UyT/3lrTIztDXxxwzt1k6oAd7mtDo6kVypYpG
         miyyDrOKi5AHOdmpQe7J/H8MjdYwIqywOCqc4qai/dCvIvsuVioTZmLWliwsAsNR8nh5
         fZA7U8HVMHHilVhZ4nWEOMu7mgrHv+wmIpgGpNGbAxN0jnPhhtVC6dYD0sXVxwf6axqr
         MHeo4+aLWkn6BupkXkUHKMgi2FNDzP11OhDWIOCqnFAqnzkvnK5QRb+yf3MmIUGiGR/o
         scLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728037429; x=1728642229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CFRCww6R0ZI7wB7Odoqmaxpyf51HejdOq9ZuRGiYTYA=;
        b=dLfG6GEHwweqXO0aPzdCFhufL6jLLuxO1gsCs2hHfF/0jlPGwP1f8Ukexk5VjXstkQ
         zo4AC8tSu1YgJo4AfZPFIiseaXWFE24B5Lw+4IPXkCtNIBIM+W4EOgP3/R8lPhAbsjv9
         ehDhkuXSqsUA3t3WUvCvKnGckRfwtZ0bfXX679PEjyN+CIDF5T7OpdhY0DrtMnH4XP49
         RqhLO6N58BZ1S9vXPtTku+u07QMl7mdBafU1kFtoqdl1Lf7Ocux0HiSKhSc0RjslX9Hz
         APyBvnbRl9APdNspKsZ2UkDJhkeGYwSRdzu4Oc/F7hRbYoiZEnnck6qUjG92zoQERxCj
         5/yA==
X-Forwarded-Encrypted: i=1; AJvYcCUKOu5pD8Hs0L7URMr5VPbHNv85t89on93xFCNNh+5NL/TyZUpZSAXG12QgfDaFeUq0faaEB5EeB9aY4GCE@vger.kernel.org, AJvYcCX9VF+86mdqXsoQinOxP1h0Hhs+V6uRt9k/rZlGJS/04eFNG9zKxmpjzUAiWbQWBQOC8kRzmK56rm+3+2KGnA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxku/dLvqTtKN4d6xoTWQ6RpqVQuiJJX0DvFlQoxd/3v2p74IiP
	SRU8E1dwveCZNZpivYXPVacieauZFnC5Qi0H+kSuA50GA1ET5cqT
X-Google-Smtp-Source: AGHT+IFmgnU6UxU+S8DwCSlcYkAC/+/F4OuiK10jHrCEX7FZ2FoLDvsdZTC3INRs9H4hBoIqQXmN4w==
X-Received: by 2002:a05:6512:3089:b0:539:918c:5124 with SMTP id 2adb3069b0e04-539ab88d663mr1299098e87.31.1728037428420;
        Fri, 04 Oct 2024 03:23:48 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99100a37cdsm207335066b.3.2024.10.04.03.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 03:23:48 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: [PATCH 3/4] ovl: convert ovl_real_fdget_meta() callers to ovl_real_file_meta()
Date: Fri,  4 Oct 2024 12:23:41 +0200
Message-Id: <20241004102342.179434-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241004102342.179434-1-amir73il@gmail.com>
References: <20241004102342.179434-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Stop using struct fd to return a real file from ovl_real_fdget_meta(),
because we no longer return a temporary file object and the callers
always get a borrowed file reference.

Rename the helper to ovl_real_file_meta(), return a borrowed reference
of the real file that is referenced from the overlayfs file or an error.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/file.c | 62 ++++++++++++++++++++++-----------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 60a543b9a834..d383ff22ccdb 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -91,8 +91,7 @@ static int ovl_change_flags(struct file *file, unsigned int flags)
 	return 0;
 }
 
-static int ovl_real_fdget_meta(const struct file *file, struct fd *real,
-			       bool upper_meta)
+static struct file *ovl_real_file_meta(const struct file *file, bool upper_meta)
 {
 	struct dentry *dentry = file_dentry(file);
 	struct file *realfile = file->private_data;
@@ -100,22 +99,20 @@ static int ovl_real_fdget_meta(const struct file *file, struct fd *real,
 	struct path realpath;
 	int err;
 
-	real->word = 0;
-
 	if (upper_meta) {
 		ovl_path_upper(dentry, &realpath);
 		if (!realpath.dentry)
-			return 0;
+			return NULL;
 	} else {
 		/* lazy lookup and verify of lowerdata */
 		err = ovl_verify_lowerdata(dentry);
 		if (err)
-			return err;
+			return ERR_PTR(err);
 
 		ovl_path_realdata(dentry, &realpath);
 	}
 	if (!realpath.dentry)
-		return -EIO;
+		return ERR_PTR(-EIO);
 
 stashed_upper:
 	if (upperfile && file_inode(upperfile) == d_inode(realpath.dentry))
@@ -130,11 +127,11 @@ static int ovl_real_fdget_meta(const struct file *file, struct fd *real,
 
 		/* Stashed upperfile has a mismatched inode */
 		if (unlikely(upperfile))
-			return -EIO;
+			return ERR_PTR(-EIO);
 
 		upperfile = ovl_open_realfile(file, &realpath);
 		if (IS_ERR(upperfile))
-			return PTR_ERR(upperfile);
+			return upperfile;
 
 		old = cmpxchg_release(backing_file_private_ptr(realfile), NULL,
 				      upperfile);
@@ -146,26 +143,31 @@ static int ovl_real_fdget_meta(const struct file *file, struct fd *real,
 		goto stashed_upper;
 	}
 
-	real->word = (unsigned long)realfile;
-
 	/* Did the flags change since open? */
-	if (unlikely((file->f_flags ^ realfile->f_flags) & ~OVL_OPEN_FLAGS))
-		return ovl_change_flags(realfile, file->f_flags);
+	if (unlikely((file->f_flags ^ realfile->f_flags) & ~OVL_OPEN_FLAGS)) {
+		err = ovl_change_flags(realfile, file->f_flags);
+		if (err)
+			return ERR_PTR(err);
+	}
 
-	return 0;
+	return realfile;
 }
 
-static int ovl_real_fdget(const struct file *file, struct fd *real)
+static struct file *ovl_real_file(const struct file *file)
 {
-	if (d_is_dir(file_dentry(file))) {
-		struct file *f = ovl_dir_real_file(file, false);
-		if (IS_ERR(f))
-			return PTR_ERR(f);
-		real->word = (unsigned long)f;
-		return 0;
-	}
+	if (d_is_dir(file_dentry(file)))
+		return ovl_dir_real_file(file, false);
 
-	return ovl_real_fdget_meta(file, real, false);
+	return ovl_real_file_meta(file, false);
+}
+
+static int ovl_real_fdget(const struct file *file, struct fd *real)
+{
+	struct file *f = ovl_real_file(file, false);
+	if (IS_ERR(f))
+		return PTR_ERR(f);
+	real->word = (unsigned long)f;
+	return 0;
 }
 
 static int ovl_open(struct inode *inode, struct file *file)
@@ -422,7 +424,7 @@ static ssize_t ovl_splice_write(struct pipe_inode_info *pipe, struct file *out,
 
 static int ovl_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 {
-	struct fd real;
+	struct file *realfile;
 	const struct cred *old_cred;
 	int ret;
 
@@ -430,19 +432,17 @@ static int ovl_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 	if (ret <= 0)
 		return ret;
 
-	ret = ovl_real_fdget_meta(file, &real, !datasync);
-	if (ret || fd_empty(real))
-		return ret;
+	realfile = ovl_real_file_meta(file, !datasync);
+	if (IS_ERR_OR_NULL(realfile))
+		return PTR_ERR(realfile);
 
 	/* Don't sync lower file for fear of receiving EROFS error */
-	if (file_inode(fd_file(real)) == ovl_inode_upper(file_inode(file))) {
+	if (file_inode(realfile) == ovl_inode_upper(file_inode(file))) {
 		old_cred = ovl_override_creds(file_inode(file)->i_sb);
-		ret = vfs_fsync_range(fd_file(real), start, end, datasync);
+		ret = vfs_fsync_range(realfile, start, end, datasync);
 		revert_creds(old_cred);
 	}
 
-	fdput(real);
-
 	return ret;
 }
 
-- 
2.34.1


