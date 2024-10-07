Return-Path: <linux-fsdevel+bounces-31185-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3C9992EDF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 16:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ED6528560B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 14:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9EF1D7986;
	Mon,  7 Oct 2024 14:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pge6O+w0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9A21D8A1D;
	Mon,  7 Oct 2024 14:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728310774; cv=none; b=KB84tRiIbuZFQmJ0iUND9ulSg0XDvY+OteLu3QUWSzktL9PZgAC/Pl3ns7/J9Fwa1C/Lz8ocCY9+mzKQGuef3RWckYLU1LW03HIN7KnHveYpBx+W958zN95hhP8WxmNCsRbr9zYG2L9ArrGf0aDbzZSyv7DtxWPYR3LUKdRoRTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728310774; c=relaxed/simple;
	bh=u5uN/v0hcCXxJzVjMecqx8XNsYDzzBB91/lRJbyg+lQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QgnvqW2DMIbCw4kovW7hw8QwrNGFDs8wK35NZeZJoR6T6f2cEyo25icq9tdvcDa0LJtLwzZBVMyuG5C9cvtDHlBo2AzuitD2xr/SLTITb/MgD/KtBv49w4kmypLp+iO8rpEJ0b6EcrCMp8+V7dvGOdJa78ylg9NrnSVKWjRvLRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pge6O+w0; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42e7b7bef42so39740245e9.3;
        Mon, 07 Oct 2024 07:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728310771; x=1728915571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vkU+cfiiNTUBWGlMXTLsIHnT7e0/Q3j2lLd4OH/mVZQ=;
        b=Pge6O+w0mnxdqtjIiXHPVkiZQUfxj6SX17OKYzSt3/rrzjlH7Io5CjeGoagdy8PuSx
         JIh2teeu3xHV6OCkr2o04eOb0wWM71w4fhJPTXWfEAPnu6jcpEIG0dfSGfQtHDjD5g45
         06AxS9vK471H0cYVS7ia9vLID3WB0fPZnJ0oQaLtSav/I4SfVtRXGtxeV4zK1xVnxs0e
         i36xTKHDBHqODXPw+gnzlIrSI99sKJS0Cb5nqDhTZmQGnFoUeXLAXIxv85YeN7xkS7zl
         QVOG7G5Td1yDcfW7YsMDluss2+XsOYnl20ZBYp/G+ZiIV+l7m+icpv5iQhuUZdLZglgo
         nKUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728310771; x=1728915571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vkU+cfiiNTUBWGlMXTLsIHnT7e0/Q3j2lLd4OH/mVZQ=;
        b=dKKTVU523hexg2iH+MsU3rDU2aAHlrA45+eqrWQi8bsX9EtxCevHoOlclmXSrBwPyr
         eLqaagyrknpGq84JuNSDNbRD5tWnzkXL7r/M6PiX3OTGcDmP6A/hHnOohFK51N2Sow1X
         g2wvMmKInYSZnkGMCk/3lfTH+M8J7PTtHHWppZxVAi0pCF4Zy/i6iA0aiK74CRR/7Rj0
         CzA4okw5/uxnbWqc39zOzh4BYoeM9b/q0CkdNX+J9IDwfbGhohhsBg249QuH2Lr0ms9r
         Pogtgfh284zS/ZTZ9WPDpHz15/z4Ghqz5sy5dR9F6yc1XucoV79kqkL4fVqhRAxNWVjO
         8XRw==
X-Forwarded-Encrypted: i=1; AJvYcCVFjgGqRvESfU1jWjvVgq6orZfZV2XYN+0IaAJmCOcJoSqNK4pBoKd9e2lUwHacXhSZdt4W+GVp853EVCMxvA==@vger.kernel.org, AJvYcCWM+wbwgNg7bqgqFoJxHNegKqVfmfGpeupsPZw5gec1psN20tVUlZUPON1Hvp8TKtmY9O/zzsaSiHZfJGjF@vger.kernel.org
X-Gm-Message-State: AOJu0YzO0hRXN+Uydl8VVqKGyuk8eX9oAUGCz/DHD4C4n23doBM4nQPF
	RULTVWNcZ+kB+efJwNWtE6Pih/kqS1BGe+G03IlupOCxjjP+5b/o
X-Google-Smtp-Source: AGHT+IGKxDvdA09dWlHWXnHyK0wlYmqqaOmgsyBKkbb/tPoGFyLrB44dzfPBTJ4IFTFAZ29mEoADog==
X-Received: by 2002:a05:600c:5124:b0:426:6f17:531 with SMTP id 5b1f17b1804b1-42f947a79b8mr2643175e9.13.1728310770701;
        Mon, 07 Oct 2024 07:19:30 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d16970520sm5829396f8f.96.2024.10.07.07.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 07:19:29 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: [PATCH v3 1/5] ovl: do not open non-data lower file for fsync
Date: Mon,  7 Oct 2024 16:19:21 +0200
Message-Id: <20241007141925.327055-2-amir73il@gmail.com>
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

ovl_fsync() with !datasync opens a backing file from the top most dentry
in the stack, checks if this dentry is non-upper and skips the fsync.

In case of an overlay dentry stack with lower data and lower metadata
above it, but without an upper metadata above it, the backing file is
opened from the top most lower metadata dentry and never used.

Refactor the helper ovl_real_fdget_meta() into ovl_real_fdget_path() and
ovl_upper_fdget() where the latter returns an empty struct fd in that
case to avoid the unneeded backing file open.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/file.c | 71 +++++++++++++++++++++++++++------------------
 1 file changed, 43 insertions(+), 28 deletions(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 4504493b20be..f5d0498355d0 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -89,32 +89,19 @@ static int ovl_change_flags(struct file *file, unsigned int flags)
 	return 0;
 }
 
-static int ovl_real_fdget_meta(const struct file *file, struct fd *real,
-			       bool allow_meta)
+static int ovl_real_fdget_path(const struct file *file, struct fd *real,
+			       struct path *realpath)
 {
-	struct dentry *dentry = file_dentry(file);
 	struct file *realfile = file->private_data;
-	struct path realpath;
-	int err;
 
 	real->word = (unsigned long)realfile;
 
-	if (allow_meta) {
-		ovl_path_real(dentry, &realpath);
-	} else {
-		/* lazy lookup and verify of lowerdata */
-		err = ovl_verify_lowerdata(dentry);
-		if (err)
-			return err;
-
-		ovl_path_realdata(dentry, &realpath);
-	}
-	if (!realpath.dentry)
+	if (WARN_ON_ONCE(!realpath->dentry))
 		return -EIO;
 
 	/* Has it been copied up since we'd opened it? */
-	if (unlikely(file_inode(realfile) != d_inode(realpath.dentry))) {
-		struct file *f = ovl_open_realfile(file, &realpath);
+	if (unlikely(file_inode(realfile) != d_inode(realpath->dentry))) {
+		struct file *f = ovl_open_realfile(file, realpath);
 		if (IS_ERR(f))
 			return PTR_ERR(f);
 		real->word = (unsigned long)f | FDPUT_FPUT;
@@ -130,7 +117,11 @@ static int ovl_real_fdget_meta(const struct file *file, struct fd *real,
 
 static int ovl_real_fdget(const struct file *file, struct fd *real)
 {
-	if (d_is_dir(file_dentry(file))) {
+	struct dentry *dentry = file_dentry(file);
+	struct path realpath;
+	int err;
+
+	if (d_is_dir(dentry)) {
 		struct file *f = ovl_dir_real_file(file, false);
 		if (IS_ERR(f))
 			return PTR_ERR(f);
@@ -138,7 +129,33 @@ static int ovl_real_fdget(const struct file *file, struct fd *real)
 		return 0;
 	}
 
-	return ovl_real_fdget_meta(file, real, false);
+	/* lazy lookup and verify of lowerdata */
+	err = ovl_verify_lowerdata(dentry);
+	if (err)
+		return err;
+
+	ovl_path_realdata(dentry, &realpath);
+
+	return ovl_real_fdget_path(file, real, &realpath);
+}
+
+static int ovl_upper_fdget(const struct file *file, struct fd *real, bool data)
+{
+	struct dentry *dentry = file_dentry(file);
+	struct path realpath;
+	enum ovl_path_type type;
+
+	if (data)
+		type = ovl_path_realdata(dentry, &realpath);
+	else
+		type = ovl_path_real(dentry, &realpath);
+
+	real->word = 0;
+	/* Not interested in lower nor in upper meta if data was requested */
+	if (!OVL_TYPE_UPPER(type) || (data && OVL_TYPE_MERGE(type)))
+		return 0;
+
+	return ovl_real_fdget_path(file, real, &realpath);
 }
 
 static int ovl_open(struct inode *inode, struct file *file)
@@ -394,16 +411,14 @@ static int ovl_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 	if (ret <= 0)
 		return ret;
 
-	ret = ovl_real_fdget_meta(file, &real, !datasync);
-	if (ret)
+	/* Don't sync lower file for fear of receiving EROFS error */
+	ret = ovl_upper_fdget(file, &real, datasync);
+	if (ret || fd_empty(real))
 		return ret;
 
-	/* Don't sync lower file for fear of receiving EROFS error */
-	if (file_inode(fd_file(real)) == ovl_inode_upper(file_inode(file))) {
-		old_cred = ovl_override_creds(file_inode(file)->i_sb);
-		ret = vfs_fsync_range(fd_file(real), start, end, datasync);
-		revert_creds(old_cred);
-	}
+	old_cred = ovl_override_creds(file_inode(file)->i_sb);
+	ret = vfs_fsync_range(fd_file(real), start, end, datasync);
+	revert_creds(old_cred);
 
 	fdput(real);
 
-- 
2.34.1


