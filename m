Return-Path: <linux-fsdevel+bounces-25902-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13010951A42
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 13:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCBDF282740
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 11:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038E11B4C3D;
	Wed, 14 Aug 2024 11:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="UqoZHq6z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9E81B4C21
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 11:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723635688; cv=none; b=qsc117R164u4z9mhkw3PxBXSDcwOggilUWzCbZldm5yaDlL2QduNe5wTB8lx4S5pa7wfKty0MrZC7QNVh8Kny5ikHG+sBuuyXoMpeVUlGDNGlel7Qnx1GujgYmRjoEw4FenIbebPiJi8941O4+c8IfPiZ6m9CenvU0/dTiBMDCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723635688; c=relaxed/simple;
	bh=4eTUDWhrEbeO6LacpkSTpWZsQS6mjvQhzRI0A/zxHU4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qDcZYQVyhNwGhPY8z/YMSjSR9tC6VwHLY90aVFY6NNEaOjpIS66FyV5EgKoIer+g0MNV7Lvp+wQgEYb7HoB+djOiz+oiskW9BnKubEfRIQNLFJp+e+Z+V84kUJk14oUGLbuzIe1h1+u33ouTzLBgSU23lR+kaUuzbi8S0iWrfRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=UqoZHq6z; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 768914596E
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 11:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1723635685;
	bh=cuULsUu9z+BvalrO9+cGgsIucfP8fxo4BNYi78/zGSU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=UqoZHq6zTGMAi6LaCTItI7q4lizIQQhQ87OCLeZBJfNRKL2TJbG4WnvlXiJkrR4+a
	 RBOQd9Bip3O5PA2VeeWEA2HQSW2k3N822x5NMQPJez0AgIhlZ+HddzByXMVMmjlNYX
	 juLM5fI+FqWXc8ycvm+n+4SM6mVcz2a6qtJNACgmTP538AYuPW8pgoDR/H1edJIn1Z
	 V0lE6KNl4RCWC/1Hd5nEjvIiQXI2dxQe1aKVagoOfQM4R30W5T0/CvR0R29+zkQSr0
	 L/GUMUTaYO3p21SqSZ9Y32bjtgxv4eqjGFN+vEwp1iG14cziuKVf/F3vAAin3L/5RO
	 cMFrjw/iKpRJw==
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a7a8281dba5so545934666b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 04:41:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723635685; x=1724240485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cuULsUu9z+BvalrO9+cGgsIucfP8fxo4BNYi78/zGSU=;
        b=SN83eJJcbCiOWTrEBmNGf7R7PjP2nIvl2nXoSz2MQVawaqgONnpuZLov+CqozRzYew
         DusWAyR26p+m+M29vfoqNEJ+0ViaQ1N1UFg1JE5tcm1DjwkAdy/d21KQMX4EC9o6fGEm
         7pAWsFztXTrkCUjUyezWNWb/tuaaNo0zMpV3iErwdwUDN0MwIYZ2/N9rp/5AjmCp5Vuu
         OH5tpOt7WsWygwuLQsdHyPFbyPZ7qHIJiXPiO9zB3mhkbXV5ysl670auR9da16KzwLGP
         GFHSr3r5AGswZgZRqNbosKAYe+3IQSRieKR+H8ipcJ3dfiATfww8vo17jx/huRT1+gd1
         Z+AA==
X-Forwarded-Encrypted: i=1; AJvYcCX0pNHm5FKhlsfMgcoZw0dNGlglcBq8ATjNlTBtZuPf8TBFMPgCYclZ+23foz5R/PXMkKCi5sCRA4DblAzc1JenRDIpYBOSBdF/Hx9uWQ==
X-Gm-Message-State: AOJu0YwPADrVKzygybjvP6AuCF8d3g/guVxncMzUxY6uALqVHQg+91Pg
	NufTk60psa0ifLfDMtmIXplY8hanDqZm5kmuTD8qie7nCMRoMAs7EPqhw/92ucTKbDQmfRBg2Cx
	G7o06oUfbsv06fJzdfz04CXRW6bQg+e4N1XPn3mw7VZ7RkANNBnHZJlkFZIGtDjAsOHA+4t7Fkc
	giSDw=
X-Received: by 2002:a17:907:e257:b0:a77:e0ed:8c4 with SMTP id a640c23a62f3a-a8366c10d6emr161899066b.7.1723635684819;
        Wed, 14 Aug 2024 04:41:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSJqi6p3D1QYD5zqxfrHLXoXcCcs9WXjsJL3AnIrFo/DOpEIxIBPJIbf9Ss6W7p94SVwH0Sg==
X-Received: by 2002:a17:907:e257:b0:a77:e0ed:8c4 with SMTP id a640c23a62f3a-a8366c10d6emr161897366b.7.1723635684266;
        Wed, 14 Aug 2024 04:41:24 -0700 (PDT)
Received: from amikhalitsyn.. ([188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f3fa782csm162586166b.60.2024.08.14.04.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 04:41:23 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: mszeredi@redhat.com
Cc: brauner@kernel.org,
	stgraber@stgraber.org,
	linux-fsdevel@vger.kernel.org,
	Seth Forshee <sforshee@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/9] fs/fuse: support idmap for mkdir/mknod/symlink/create
Date: Wed, 14 Aug 2024 13:40:27 +0200
Message-Id: <20240814114034.113953-3-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240814114034.113953-1-aleksandr.mikhalitsyn@canonical.com>
References: <20240814114034.113953-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have all the infrastructure in place, we just need
to pass an idmapping here.

Cc: Christian Brauner <brauner@kernel.org>
Cc: Seth Forshee <sforshee@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bschubert@ddn.com>
Cc: <linux-fsdevel@vger.kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/fuse/dir.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 30d27d4f3b5a..1e45c6157af4 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -637,9 +637,9 @@ static void free_ext_value(struct fuse_args *args)
  * If the filesystem doesn't support this, then fall back to separate
  * 'mknod' + 'open' requests.
  */
-static int fuse_create_open(struct inode *dir, struct dentry *entry,
-			    struct file *file, unsigned int flags,
-			    umode_t mode, u32 opcode)
+static int fuse_create_open(struct mnt_idmap *idmap, struct inode *dir,
+			    struct dentry *entry, struct file *file,
+			    unsigned int flags, umode_t mode, u32 opcode)
 {
 	int err;
 	struct inode *inode;
@@ -696,7 +696,7 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 	args.out_args[1].size = sizeof(*outopenp);
 	args.out_args[1].value = outopenp;
 
-	err = get_create_ext(&nop_mnt_idmap, &args, dir, entry, mode);
+	err = get_create_ext(idmap, &args, dir, entry, mode);
 	if (err)
 		goto out_put_forget_req;
 
@@ -757,6 +757,7 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
 			    umode_t mode)
 {
 	int err;
+	struct mnt_idmap *idmap = file_mnt_idmap(file);
 	struct fuse_conn *fc = get_fuse_conn(dir);
 	struct dentry *res = NULL;
 
@@ -781,7 +782,7 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
 	if (fc->no_create)
 		goto mknod;
 
-	err = fuse_create_open(dir, entry, file, flags, mode, FUSE_CREATE);
+	err = fuse_create_open(idmap, dir, entry, file, flags, mode, FUSE_CREATE);
 	if (err == -ENOSYS) {
 		fc->no_create = 1;
 		goto mknod;
@@ -792,7 +793,7 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
 	return err;
 
 mknod:
-	err = fuse_mknod(&nop_mnt_idmap, dir, entry, mode, 0);
+	err = fuse_mknod(idmap, dir, entry, mode, 0);
 	if (err)
 		goto out_dput;
 no_open:
@@ -802,9 +803,9 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
 /*
  * Code shared between mknod, mkdir, symlink and link
  */
-static int create_new_entry(struct fuse_mount *fm, struct fuse_args *args,
-			    struct inode *dir, struct dentry *entry,
-			    umode_t mode)
+static int create_new_entry(struct mnt_idmap *idmap, struct fuse_mount *fm,
+			    struct fuse_args *args, struct inode *dir,
+			    struct dentry *entry, umode_t mode)
 {
 	struct fuse_entry_out outarg;
 	struct inode *inode;
@@ -826,7 +827,7 @@ static int create_new_entry(struct fuse_mount *fm, struct fuse_args *args,
 	args->out_args[0].value = &outarg;
 
 	if (args->opcode != FUSE_LINK) {
-		err = get_create_ext(&nop_mnt_idmap, args, dir, entry, mode);
+		err = get_create_ext(idmap, args, dir, entry, mode);
 		if (err)
 			goto out_put_forget_req;
 	}
@@ -892,13 +893,13 @@ static int fuse_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	args.in_args[0].value = &inarg;
 	args.in_args[1].size = entry->d_name.len + 1;
 	args.in_args[1].value = entry->d_name.name;
-	return create_new_entry(fm, &args, dir, entry, mode);
+	return create_new_entry(idmap, fm, &args, dir, entry, mode);
 }
 
 static int fuse_create(struct mnt_idmap *idmap, struct inode *dir,
 		       struct dentry *entry, umode_t mode, bool excl)
 {
-	return fuse_mknod(&nop_mnt_idmap, dir, entry, mode, 0);
+	return fuse_mknod(idmap, dir, entry, mode, 0);
 }
 
 static int fuse_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
@@ -910,7 +911,7 @@ static int fuse_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
 	if (fc->no_tmpfile)
 		return -EOPNOTSUPP;
 
-	err = fuse_create_open(dir, file->f_path.dentry, file, file->f_flags, mode, FUSE_TMPFILE);
+	err = fuse_create_open(idmap, dir, file->f_path.dentry, file, file->f_flags, mode, FUSE_TMPFILE);
 	if (err == -ENOSYS) {
 		fc->no_tmpfile = 1;
 		err = -EOPNOTSUPP;
@@ -937,7 +938,7 @@ static int fuse_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	args.in_args[0].value = &inarg;
 	args.in_args[1].size = entry->d_name.len + 1;
 	args.in_args[1].value = entry->d_name.name;
-	return create_new_entry(fm, &args, dir, entry, S_IFDIR);
+	return create_new_entry(idmap, fm, &args, dir, entry, S_IFDIR);
 }
 
 static int fuse_symlink(struct mnt_idmap *idmap, struct inode *dir,
@@ -953,7 +954,7 @@ static int fuse_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	args.in_args[0].value = entry->d_name.name;
 	args.in_args[1].size = len;
 	args.in_args[1].value = link;
-	return create_new_entry(fm, &args, dir, entry, S_IFLNK);
+	return create_new_entry(idmap, fm, &args, dir, entry, S_IFLNK);
 }
 
 void fuse_flush_time_update(struct inode *inode)
@@ -1147,7 +1148,7 @@ static int fuse_link(struct dentry *entry, struct inode *newdir,
 	args.in_args[0].value = &inarg;
 	args.in_args[1].size = newent->d_name.len + 1;
 	args.in_args[1].value = newent->d_name.name;
-	err = create_new_entry(fm, &args, newdir, newent, inode->i_mode);
+	err = create_new_entry(&nop_mnt_idmap, fm, &args, newdir, newent, inode->i_mode);
 	if (!err)
 		fuse_update_ctime_in_cache(inode);
 	else if (err == -EINTR)
-- 
2.34.1


