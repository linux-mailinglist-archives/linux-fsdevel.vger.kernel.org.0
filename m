Return-Path: <linux-fsdevel+bounces-31186-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9E4992EE1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 16:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05897285808
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 14:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50DD1D8E09;
	Mon,  7 Oct 2024 14:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xpda9vS9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BC71D54D4;
	Mon,  7 Oct 2024 14:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728310775; cv=none; b=BkAZun6FT25zadg+RRvNc/rYDSh3QilGHu62hUyBPCM1XSWJBPz+6M1qeY1x8Axq0aa6f8uJuLEIifzDiMeQGawTnluleBrFW2JMMu5UeWLGF5dBMwqKxEzwgpcFT3rhf3fdUTGbzb5KMoQw9eWM8al84h5KfwR7vwThYEZFMvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728310775; c=relaxed/simple;
	bh=pubetNtaZBB6HQRWyxq/zdamFrw+VN9WayJdV93bV24=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aH46L05aDbKAtQ667VNxoW9P5PGwiunReasJrGEXQg+LbgiTg54ArhkV+NzdMfEVwg7GdJYHwTvkLJHc3Vnb+2XNYiKurH2wNiMg5lOdgI4p89HZvGgMjvRs/HljjOJMlU9dlzAnmadBqsa9TUyiVxg0M4es28Ess6y9+Q41YHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xpda9vS9; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37ccfada422so2744301f8f.2;
        Mon, 07 Oct 2024 07:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728310772; x=1728915572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1GE/dxQSdo3FDX8cP0cmk86KhCkq//3GbFgRlty45nI=;
        b=Xpda9vS9xsHSJ2up4cJXswBYsDu+RPE9z00/jfyM7Xo8KLJLmnwW8ZIPI9U26sM4nZ
         5dj2Ql6+RY5i3OEudTAu/Mj8c0ixW5QaQ9fDhIiE5XKhnEYEY54ttsmLkkqy9CxoGD72
         UGZm8OmwXbyxSM/m1GbYJ73x8cgAxdPU+k6SoyvLmT0QDB9pm4MpU8mppmhMW6kqNm5Q
         lpR/XWW6oEkj+H8psausK3K5NFoZBtNYWne0loImx7StluzqTLZ5ht8KQf5Q7WMx5cFc
         lUVyZWBnKJXi4mfe69t31prC2LzSXeICu6R9eNyJuFINRzNL/tgBUS8/jadFf8DjtsBt
         pM2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728310772; x=1728915572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1GE/dxQSdo3FDX8cP0cmk86KhCkq//3GbFgRlty45nI=;
        b=Fg3QeW51BCzzee98YfexjXosnRoLhhf5mBnjy7akeCj/y4HGEde6t3yXTDzUyMo1Mo
         miAX+fGL5hb+fKl6EHfNXhGSTDD75qd1b3lkSAuIOBEqrUBp7c6TkiNYajSXrOOL9d6P
         Y/Op2GcRJ3EZb0CUH3I3+d5fyl+eEcqgqFzddiMywPXxpTfppCr/3gTTJaBwppS5VDI6
         rLIOw2dbBb2/sajCXjCOjCu7w/LQr9O51A/Jj7Zr7emq1pKIkVmPTsah2cgHVo2dR2wL
         xFyj/eAUaHYTrQzpg+/ly27KEjr8x1vMiDvVFaWzG4JL3upd1zLT9cMOtLx5tf+Qv6/U
         K0oQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJIyty0zM+ZyLx6TRrvnif8WOGO8/BKTLV1QJLjGtoDhBXHxiIz9pxMf+lMGUr4kH1w2Rl8vKGsYr5R07C@vger.kernel.org, AJvYcCWsdf7guNYZKqklnVyfSX95zA9kszqynpwmo/mfU57U9d693p/XoVzW/+zktSO4MvYTGhCKS7UNfRCG9vKtYQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4KW30RJh8AI3t+BYkCblHqtPappkmQp+ias2VGrTIExY0DDOZ
	Fzy9mqVeOgZmk+FD32t6BitIpHW3QTlHr8JPr5H0fFFHj/vqH5/b
X-Google-Smtp-Source: AGHT+IFO2GfE0BBrw7is/zr+2wdjYgBDzcLwPn8HYeouW1s4YXjUEqKhcSG1e6mvxD0XHBfNxfRagg==
X-Received: by 2002:a5d:648a:0:b0:375:1b02:1e3c with SMTP id ffacd0b85a97d-37d0e8de99dmr10227229f8f.45.1728310771496;
        Mon, 07 Oct 2024 07:19:31 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d16970520sm5829396f8f.96.2024.10.07.07.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 07:19:31 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: [PATCH v3 2/5] ovl: allocate a container struct ovl_file for ovl private context
Date: Mon,  7 Oct 2024 16:19:22 +0200
Message-Id: <20241007141925.327055-3-amir73il@gmail.com>
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

Instead of using ->private_data to point at realfile directly, so
that we can add more context per ovl open file.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/file.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index f5d0498355d0..03bf6037b129 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -89,10 +89,15 @@ static int ovl_change_flags(struct file *file, unsigned int flags)
 	return 0;
 }
 
+struct ovl_file {
+	struct file *realfile;
+};
+
 static int ovl_real_fdget_path(const struct file *file, struct fd *real,
 			       struct path *realpath)
 {
-	struct file *realfile = file->private_data;
+	struct ovl_file *of = file->private_data;
+	struct file *realfile = of->realfile;
 
 	real->word = (unsigned long)realfile;
 
@@ -163,6 +168,7 @@ static int ovl_open(struct inode *inode, struct file *file)
 	struct dentry *dentry = file_dentry(file);
 	struct file *realfile;
 	struct path realpath;
+	struct ovl_file *of;
 	int err;
 
 	/* lazy lookup and verify lowerdata */
@@ -181,18 +187,28 @@ static int ovl_open(struct inode *inode, struct file *file)
 	if (!realpath.dentry)
 		return -EIO;
 
+	of = kzalloc(sizeof(struct ovl_file), GFP_KERNEL);
+	if (!of)
+		return -ENOMEM;
+
 	realfile = ovl_open_realfile(file, &realpath);
-	if (IS_ERR(realfile))
+	if (IS_ERR(realfile)) {
+		kfree(of);
 		return PTR_ERR(realfile);
+	}
 
-	file->private_data = realfile;
+	of->realfile = realfile;
+	file->private_data = of;
 
 	return 0;
 }
 
 static int ovl_release(struct inode *inode, struct file *file)
 {
-	fput(file->private_data);
+	struct ovl_file *of = file->private_data;
+
+	fput(of->realfile);
+	kfree(of);
 
 	return 0;
 }
@@ -427,14 +443,14 @@ static int ovl_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 
 static int ovl_mmap(struct file *file, struct vm_area_struct *vma)
 {
-	struct file *realfile = file->private_data;
+	struct ovl_file *of = file->private_data;
 	struct backing_file_ctx ctx = {
 		.cred = ovl_creds(file_inode(file)->i_sb),
 		.user_file = file,
 		.accessed = ovl_file_accessed,
 	};
 
-	return backing_file_mmap(realfile, vma, &ctx);
+	return backing_file_mmap(of->realfile, vma, &ctx);
 }
 
 static long ovl_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
-- 
2.34.1


