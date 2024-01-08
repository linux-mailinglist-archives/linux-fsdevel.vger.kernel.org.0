Return-Path: <linux-fsdevel+bounces-7542-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B7F826D82
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 13:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C48BA1F21CAB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 12:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D825141770;
	Mon,  8 Jan 2024 12:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="O3ONM7m+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57824123B
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jan 2024 12:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C64843F45F
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jan 2024 12:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1704715816;
	bh=9JOCkZnahtYcjH5f/6OzDGT6n3cRWHJ6WXIUPPzUvyw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=O3ONM7m+eFjSrc/qCOGyOSDoP9mzxvpW4mg13LZQzt8raSR+yZG6qNs2lC2pPNcMk
	 dadoWRzbK4UGfN4gTf9E/0DaukJwudqo02FI8BWvdETQ7OGtHkavTqX4rxGD6rLRwL
	 vPRhArHbHXFnX0RwZwebAV0XbY+T2Pg8efOatTJOygVazKdVjOQjSjI4irgxSb1IAW
	 bROfPJFdaQp6nYlT7AMvpxq7eHAhyXgM7XR1xaoCW7aL0qlkAiaE/6NMCKkbRwRigj
	 E9HA/A/dwFNroT5HcsaAYlRfbUQDJIBDKFceJ92Yc0DCCaxvRywXEPX0ijlebi3pio
	 Ad1Mp63ezzmcg==
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-55369c474e1so939784a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Jan 2024 04:10:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704715816; x=1705320616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9JOCkZnahtYcjH5f/6OzDGT6n3cRWHJ6WXIUPPzUvyw=;
        b=svgGGhIQYNuX6qygsm9mq0IojcWdnmMeEnkv8TaaW+/RptHAvFn2LJxAmPQCOQM6UD
         ZzN0+qBbJVUC1GUUFuEP0qv4u93Xxxc3V38pDIeWPVFW8k2GBehj36WmVZLd+F5TPSLe
         6pOu2BazueViMSkfrgDbS+CNRBQo0uWV1Uyi7GBBDR3QHThgaPpG7u8Vd9KHKTx3+rul
         HlDG3XF2lbpWgGVKEucu5YEFerianuY9k3y6iE54D6KPbu/uOLTWZ/Tk/G107XOPXl8e
         QQ07KV0GtwKDMGC2XCAkb3lr8KLk6zKyN5+Q1X9ZHRuiMIXl0tXfwbnvYNT04xjNqAuo
         BG8Q==
X-Gm-Message-State: AOJu0YzhDt3OFC7OnlWJFfp3NiMer+M0xFid638G6mUThzY/2rv9dbGa
	+HV5s4f5t0W0nzrsEliAqNocmwMckaNNOpzp7rRf1MJ7HUGJTGlfji06lY/6V2rwKkaAJGb+e8i
	9z0u9VNRg6j2CPWcUYVnaFgND4eVY9uPMA/rEUtB9J/219tXvhw==
X-Received: by 2002:a50:9e24:0:b0:557:2213:bc4e with SMTP id z33-20020a509e24000000b005572213bc4emr1414495ede.57.1704715816370;
        Mon, 08 Jan 2024 04:10:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHw8peZwjRNS6HnIeq6gf9kiSM/PadeOHzJBqN/8B3lBmvGk2+H+2sR5ks64RD0Cx44QtvI+w==
X-Received: by 2002:a50:9e24:0:b0:557:2213:bc4e with SMTP id z33-20020a509e24000000b005572213bc4emr1414490ede.57.1704715816191;
        Mon, 08 Jan 2024 04:10:16 -0800 (PST)
Received: from localhost.localdomain ([91.64.72.41])
        by smtp.gmail.com with ESMTPSA id fi21-20020a056402551500b005578b816f20sm1767959edb.29.2024.01.08.04.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 04:10:14 -0800 (PST)
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
Subject: [PATCH v1 6/9] fs/fuse: support idmapped ->setattr op
Date: Mon,  8 Jan 2024 13:08:21 +0100
Message-Id: <20240108120824.122178-7-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240108120824.122178-1-aleksandr.mikhalitsyn@canonical.com>
References: <20240108120824.122178-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cc: Christian Brauner <brauner@kernel.org>
Cc: Seth Forshee <sforshee@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bschubert@ddn.com>
Cc: <linux-fsdevel@vger.kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/fuse/dir.c    | 32 +++++++++++++++++++++-----------
 fs/fuse/file.c   |  2 +-
 fs/fuse/fuse_i.h |  4 ++--
 3 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index f7c2c54f7122..5fbb7100ad1c 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1739,17 +1739,27 @@ static bool update_mtime(unsigned ivalid, bool trust_local_mtime)
 	return true;
 }
 
-static void iattr_to_fattr(struct fuse_conn *fc, struct iattr *iattr,
-			   struct fuse_setattr_in *arg, bool trust_local_cmtime)
+static void iattr_to_fattr(struct mnt_idmap *idmap, struct fuse_conn *fc,
+			   struct iattr *iattr, struct fuse_setattr_in *arg,
+			   bool trust_local_cmtime)
 {
 	unsigned ivalid = iattr->ia_valid;
 
 	if (ivalid & ATTR_MODE)
 		arg->valid |= FATTR_MODE,   arg->mode = iattr->ia_mode;
-	if (ivalid & ATTR_UID)
-		arg->valid |= FATTR_UID,    arg->uid = from_kuid(fc->user_ns, iattr->ia_uid);
-	if (ivalid & ATTR_GID)
-		arg->valid |= FATTR_GID,    arg->gid = from_kgid(fc->user_ns, iattr->ia_gid);
+
+	if (ivalid & ATTR_UID) {
+		kuid_t fsuid = from_vfsuid(idmap, fc->user_ns, iattr->ia_vfsuid);
+		arg->valid |= FATTR_UID;
+		arg->uid = from_kuid(fc->user_ns, fsuid);
+	}
+
+	if (ivalid & ATTR_GID) {
+		kgid_t fsgid = from_vfsgid(idmap, fc->user_ns, iattr->ia_vfsgid);
+		arg->valid |= FATTR_GID;
+		arg->gid = from_kgid(fc->user_ns, fsgid);
+	}
+
 	if (ivalid & ATTR_SIZE)
 		arg->valid |= FATTR_SIZE,   arg->size = iattr->ia_size;
 	if (ivalid & ATTR_ATIME) {
@@ -1869,8 +1879,8 @@ int fuse_flush_times(struct inode *inode, struct fuse_file *ff)
  * vmtruncate() doesn't allow for this case, so do the rlimit checking
  * and the actual truncation by hand.
  */
-int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
-		    struct file *file)
+int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
+		    struct iattr *attr, struct file *file)
 {
 	struct inode *inode = d_inode(dentry);
 	struct fuse_mount *fm = get_fuse_mount(inode);
@@ -1890,7 +1900,7 @@ int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
 	if (!fc->default_permissions)
 		attr->ia_valid |= ATTR_FORCE;
 
-	err = setattr_prepare(&nop_mnt_idmap, dentry, attr);
+	err = setattr_prepare(idmap, dentry, attr);
 	if (err)
 		return err;
 
@@ -1949,7 +1959,7 @@ int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
 
 	memset(&inarg, 0, sizeof(inarg));
 	memset(&outarg, 0, sizeof(outarg));
-	iattr_to_fattr(fc, attr, &inarg, trust_local_cmtime);
+	iattr_to_fattr(idmap, fc, attr, &inarg, trust_local_cmtime);
 	if (file) {
 		struct fuse_file *ff = file->private_data;
 		inarg.valid |= FATTR_FH;
@@ -2084,7 +2094,7 @@ static int fuse_setattr(struct mnt_idmap *idmap, struct dentry *entry,
 	if (!attr->ia_valid)
 		return 0;
 
-	ret = fuse_do_setattr(entry, attr, file);
+	ret = fuse_do_setattr(idmap, entry, attr, file);
 	if (!ret) {
 		/*
 		 * If filesystem supports acls it may have updated acl xattrs in
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index a660f1f21540..e0fe5497a548 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2870,7 +2870,7 @@ static void fuse_do_truncate(struct file *file)
 	attr.ia_file = file;
 	attr.ia_valid |= ATTR_FILE;
 
-	fuse_do_setattr(file_dentry(file), &attr, file);
+	fuse_do_setattr(&nop_mnt_idmap, file_dentry(file), &attr, file);
 }
 
 static inline loff_t fuse_round_up(struct fuse_conn *fc, loff_t off)
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 15ec95dea276..94b25ea5344a 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1288,8 +1288,8 @@ bool fuse_write_update_attr(struct inode *inode, loff_t pos, ssize_t written);
 int fuse_flush_times(struct inode *inode, struct fuse_file *ff);
 int fuse_write_inode(struct inode *inode, struct writeback_control *wbc);
 
-int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
-		    struct file *file);
+int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
+		    struct iattr *attr, struct file *file);
 
 void fuse_set_initialized(struct fuse_conn *fc);
 
-- 
2.34.1


