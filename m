Return-Path: <linux-fsdevel+bounces-31188-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 758B6992EE5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 16:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F0F91C23722
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 14:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D751D8DE3;
	Mon,  7 Oct 2024 14:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iVNLE7iJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CE31D8DFB;
	Mon,  7 Oct 2024 14:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728310777; cv=none; b=SOynv0UQwkslzEnSTwd2nUGZeqjLMH5nwCxvLZTMvRaHo42PEkA+Clc9jS5ZYE1jra+YiSfMk6YsRKSZxLZYSPdQm9KxJdTymO71LWc97khJAnfdxeVXhw5vs1/SmsxnvpP8tn0/fKsZgzOXqadtxW3syWMSgsV6WbvEV/UfWgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728310777; c=relaxed/simple;
	bh=ShLWCnLy37MvRFlXnqMMASukN/oTTXfwXOi0kGFCvYc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iHBbipuaEVv5REG/RCMzSS/IxNTTW6fzTlJtQ9erJFH9v+mppRDKAxBdHpuWbq5FXPGawXooz8UO7CCaiZKH42RkkMCi47fGomIrgjB5Fl1j3OvNh6Aq7Rix0Ujr1YD676il1QyZR3rJdghzvrmgly0npQCkrjO9mGNdXTY4g9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iVNLE7iJ; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37cdbcb139cso3535327f8f.1;
        Mon, 07 Oct 2024 07:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728310773; x=1728915573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w3aPZorWQGjj1ymVuXXU2EaIpRVEVNJmdpk026ZQD5M=;
        b=iVNLE7iJTsDfSBGqjZfBd7+o6ju6q+ZHiqY0IFazJMlpoJtWXFykHrbwnonYh/9s4e
         wdeZm+F3tp8M9gcPA9QBmKlQzB0sEishYKarVBRKFvJZFyGZYMEOtHBTEQsdNc582CCo
         2M4nEPu1/TfW5uMwT4wZaX/xcfSEX+8n720tyG23kYPi8wXwUKNeGDVTbksb6qx5Nrvb
         l3vk1al0WAeNlX/CEKzsmaPFfRFeafKY70ClH79CBfRS+ejvg02Cr9vsIdgTKDCPx9Hq
         5BNXu9DUrN1xmcDa0mrP38CgNsArTrjYwT1ZKCbK1huWeiupbbF/xiKJMNvvFpqyAwOo
         INHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728310773; x=1728915573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w3aPZorWQGjj1ymVuXXU2EaIpRVEVNJmdpk026ZQD5M=;
        b=aXJuP8COBF/HXbTEiRdC0MyrAAO9t2LTXuHC3YbtC8ecqTYxjTsXIxsmcpyt5Sue5z
         oaMkuzeQ+EhgD1NfVd+8zKhhC0uqopNNJ07cSLCNS3czmyqu+JZR4CA7VGPhqVsxW3/D
         6OXmaWCXFVQAqoFGNPlRs6unpYnAvo9iCufcIrsoRvM2LQznyANGwuMspUWBCHs017By
         gFwLifUfj9VXxbp55ETguMNdYb4PPc2FcUzFEqsIEiMQgJE1S/1uEB1ljypGFQUcxgW2
         8tsNYXUyDU2zRI55Vwcnjr94Y+DIavjWhD2oaD+kIanp3F0lCqfQKVSY8atOlXUjkWOH
         IgWA==
X-Forwarded-Encrypted: i=1; AJvYcCVg5tc9KdS/siZLtYoSdD0lVrFV8ohQ5hOHLi2747/1X8gQvC7XX0T8cQIQNaLNnDH2+TWTWW5YgsFp1mvq@vger.kernel.org, AJvYcCXLHxFLafWpSobq/pRVwMFPgOwXVboLP8JhAl9V93AwDpz0xg0WGtDLfrsXNk40hn1CJ9I4xTWhqI7hNVfsSw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxM26KiLl7MrMlk1OBrujzsJAGAnIbO1wiEALQ/mTp1+xxQCJ/r
	t11ggNkVRfl112dQZk1aqNAggG3KoRPrMftY+ndmw3G5lMnE2Czx
X-Google-Smtp-Source: AGHT+IFFCLNMa7ozCLRyuQwffwAl/1LKN9IarPzd4fugtBrwPtOc+bNIHnX9YVRivQldcUJnydmx/Q==
X-Received: by 2002:adf:f987:0:b0:374:cbe8:6f43 with SMTP id ffacd0b85a97d-37d0e7902b2mr6953417f8f.33.1728310773065;
        Mon, 07 Oct 2024 07:19:33 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d16970520sm5829396f8f.96.2024.10.07.07.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 07:19:32 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: [PATCH v3 4/5] ovl: convert ovl_real_fdget_path() callers to ovl_real_file_path()
Date: Mon,  7 Oct 2024 16:19:24 +0200
Message-Id: <20241007141925.327055-5-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241007141925.327055-1-amir73il@gmail.com>
References: <20241007141925.327055-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Stop using struct fd to return a real file from ovl_real_fdget_path(),
because we no longer return a temporary file object and the callers
always get a borrowed file reference.

Rename the helper to ovl_real_file_path(), return a borrowed reference
of the real file that is referenced from the overlayfs file or an error.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/file.c | 66 +++++++++++++++++++++++++--------------------
 1 file changed, 37 insertions(+), 29 deletions(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 525bcddb49e5..b6d6ccc39dad 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -100,16 +100,14 @@ static bool ovl_is_real_file(const struct file *realfile,
 	return file_inode(realfile) == d_inode(realpath->dentry);
 }
 
-static int ovl_real_fdget_path(const struct file *file, struct fd *real,
-			       struct path *realpath)
+static struct file *ovl_real_file_path(const struct file *file,
+				       struct path *realpath)
 {
 	struct ovl_file *of = file->private_data;
 	struct file *realfile = of->realfile;
 
-	real->word = 0;
-
 	if (WARN_ON_ONCE(!realpath->dentry))
-		return -EIO;
+		return ERR_PTR(-EIO);
 
 	/*
 	 * If the realfile that we want is not where the data used to be at
@@ -124,7 +122,7 @@ static int ovl_real_fdget_path(const struct file *file, struct fd *real,
 		if (!upperfile) { /* Nobody opened upperfile yet */
 			upperfile = ovl_open_realfile(file, realpath);
 			if (IS_ERR(upperfile))
-				return PTR_ERR(upperfile);
+				return upperfile;
 
 			/* Store the upperfile for later */
 			old = cmpxchg_release(&of->upperfile, NULL, upperfile);
@@ -138,20 +136,23 @@ static int ovl_real_fdget_path(const struct file *file, struct fd *real,
 		 * been corrupting the upper layer.
 		 */
 		if (WARN_ON_ONCE(!ovl_is_real_file(upperfile, realpath)))
-			return -EIO;
+			return ERR_PTR(-EIO);
 
 		realfile = upperfile;
 	}
 
 	/* Did the flags change since open? */
-	if (unlikely((file->f_flags ^ realfile->f_flags) & ~OVL_OPEN_FLAGS))
-		return ovl_change_flags(realfile, file->f_flags);
+	if (unlikely((file->f_flags ^ realfile->f_flags) & ~OVL_OPEN_FLAGS)) {
+		int err = ovl_change_flags(realfile, file->f_flags);
 
-	real->word = (unsigned long)realfile;
-	return 0;
+		if (err)
+			return ERR_PTR(err);
+	}
+
+	return realfile;
 }
 
-static int ovl_real_fdget(const struct file *file, struct fd *real)
+static struct file *ovl_real_file(const struct file *file)
 {
 	struct dentry *dentry = file_dentry(file);
 	struct path realpath;
@@ -159,23 +160,33 @@ static int ovl_real_fdget(const struct file *file, struct fd *real)
 
 	if (d_is_dir(dentry)) {
 		struct file *f = ovl_dir_real_file(file, false);
-		if (IS_ERR(f))
-			return PTR_ERR(f);
-		real->word = (unsigned long)f;
-		return 0;
+
+		if (WARN_ON_ONCE(!f))
+			return ERR_PTR(-EIO);
+		return f;
 	}
 
 	/* lazy lookup and verify of lowerdata */
 	err = ovl_verify_lowerdata(dentry);
 	if (err)
-		return err;
+		return ERR_PTR(err);
 
 	ovl_path_realdata(dentry, &realpath);
 
-	return ovl_real_fdget_path(file, real, &realpath);
+	return ovl_real_file_path(file, &realpath);
 }
 
-static int ovl_upper_fdget(const struct file *file, struct fd *real, bool data)
+static int ovl_real_fdget(const struct file *file, struct fd *real)
+{
+	struct file *f = ovl_real_file(file);
+
+	if (IS_ERR(f))
+		return PTR_ERR(f);
+	real->word = (unsigned long)f;
+	return 0;
+}
+
+static struct file *ovl_upper_file(const struct file *file, bool data)
 {
 	struct dentry *dentry = file_dentry(file);
 	struct path realpath;
@@ -186,12 +197,11 @@ static int ovl_upper_fdget(const struct file *file, struct fd *real, bool data)
 	else
 		type = ovl_path_real(dentry, &realpath);
 
-	real->word = 0;
 	/* Not interested in lower nor in upper meta if data was requested */
 	if (!OVL_TYPE_UPPER(type) || (data && OVL_TYPE_MERGE(type)))
-		return 0;
+		return NULL;
 
-	return ovl_real_fdget_path(file, real, &realpath);
+	return ovl_real_file_path(file, &realpath);
 }
 
 static int ovl_open(struct inode *inode, struct file *file)
@@ -452,7 +462,7 @@ static ssize_t ovl_splice_write(struct pipe_inode_info *pipe, struct file *out,
 
 static int ovl_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 {
-	struct fd real;
+	struct file *upperfile;
 	const struct cred *old_cred;
 	int ret;
 
@@ -461,16 +471,14 @@ static int ovl_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 		return ret;
 
 	/* Don't sync lower file for fear of receiving EROFS error */
-	ret = ovl_upper_fdget(file, &real, datasync);
-	if (ret || fd_empty(real))
-		return ret;
+	upperfile = ovl_upper_file(file, datasync);
+	if (IS_ERR_OR_NULL(upperfile))
+		return PTR_ERR(upperfile);
 
 	old_cred = ovl_override_creds(file_inode(file)->i_sb);
-	ret = vfs_fsync_range(fd_file(real), start, end, datasync);
+	ret = vfs_fsync_range(upperfile, start, end, datasync);
 	revert_creds(old_cred);
 
-	fdput(real);
-
 	return ret;
 }
 
-- 
2.34.1


