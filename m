Return-Path: <linux-fsdevel+bounces-28421-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 843C596A209
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 17:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11D0D1F223C1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 15:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5E01917F1;
	Tue,  3 Sep 2024 15:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="E1bLWoTR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436A518FDC9
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 15:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725376629; cv=none; b=jO5bWRqvrTQ82lAyUBV5PpJ4OWq8MJ08auBdXb08g+ElDHDD1GtLbkfjeaRkzGHGt4Et/coa5HEY7xA6nRz4PLiGSBVQhaM0nAkwGEVVhIrGyoUz+TIV7wEIyU5fqrn7l8mNiOvX0grNa+KNYe6Yzoz134CkeDcDdjx2GGI7G1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725376629; c=relaxed/simple;
	bh=d1QU9K0mCSLy9i49hu3VgHqnFt0IkZctbCF8EsYa5UY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j01V+n9Bto4XXZMuw8vZ1bAcXhIy7Oxelbom75SlE3RLZfQcvRlWQ8p4WdJ7msxyhNZIhV140yWezEgLIgfJwQhUksmu228u3KySxn0nn49JXXXcw9aw1lM/ClADClNLY8LNsmaXGxXWbMqWCWmjrQgdh3WGCbGJYWfTq3tpLPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=E1bLWoTR; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2A15F3FE21
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 15:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1725376626;
	bh=RUXBxrexsYj2ubgYvgii/4vTEm7ycdd5RVigA12ybdw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=E1bLWoTRCOyKNzFittU23kdpNS11Zsoh6FVhJLNoITB6/RISLApjqwLpEKRZGCLMS
	 BNrsodV7++g3mO1nLOVUt4CtCtvo9vk5UzkLR8GuCKuhDzAsMjX8IVSMRgfZyCBXYb
	 8NN74tvxySEcOQiOcTXRrplyb7vrrdrEhrjUX+pWHObxSZomMXeX0cyAai95dWi+on
	 fiD3LMKCmwlZBt34A/0aQzH6tMvDi32cGu4JCcpSk+gMeD46HPEUy+mrPWNiBYlU5o
	 +9WNTMFTC8b1nTwmv7pNXtlt+iXSh3rIBr5V7UBmD23dIy8XK509DcsWBqmj1pkue0
	 k9DBuyvSXbVYQ==
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5334656d5c3so5588676e87.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Sep 2024 08:17:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725376625; x=1725981425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RUXBxrexsYj2ubgYvgii/4vTEm7ycdd5RVigA12ybdw=;
        b=Nv23xdRbdtgqipT7GCaSh7CHcxJWPhD3M71ErJofj9jG5WeVYuuohissyG/GS8QqTq
         8sGgR7BSGb5hyBqmAtwqQukXEET7NPvp9nqXiorA5H0xui3EhjD0j2V2GI9IfQwD7dxb
         D8nWIrmvW//+MeOXvnr65k8U5ziXbmVBgH1X6UVgxMK+1j8VbIp2g8i3z8Q09n5dpFrw
         rDc/wB/aeWUEanyKftQ0HqoWajvQ14lXL0P3rxGzbClFGGe8YyFIksXuTMXbPqpNDak7
         aInqy/YoCKQ4FUlT8s3PLWu4ziChQwsCjWk+0MepMuynxJNV7pc4pjkE2bh8OmbGcIAf
         KewQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfjdjDen/b7c6n8pQIgJIDmWoj+piEBDtB8E93Y+68uSpUsBmbyw8quZgSukA9GDBDiPyMqDvKJicgjO5s@vger.kernel.org
X-Gm-Message-State: AOJu0YxOWcyjXkhh8BIGm59P65ghuylUywf6o55LkeITE0t+179lF4MB
	GTbpSN0j4+P0GGxF3i/gFm9h+h6ySP3d+DVaRzjvB8D+9+Pz34SMiLkmqofTZX2COhMSgSMhPxH
	+GzjOPp8dOGPoWGyD/oOm803l+11v7zTS8eGH/Mq/j8QK5A+vmiiZUwpvqlR8j/Ass6qpFjErBZ
	mkBv8=
X-Received: by 2002:a05:6512:2387:b0:530:c1fc:1c32 with SMTP id 2adb3069b0e04-53546b8e196mr10335870e87.45.1725376625246;
        Tue, 03 Sep 2024 08:17:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbdVNQw9JIGlffkc2qNWniuxTLPhkWGbYYHUXdBD/ban51LA6iUri9d3hyagPN6wYzcdu37w==
X-Received: by 2002:a05:6512:2387:b0:530:c1fc:1c32 with SMTP id 2adb3069b0e04-53546b8e196mr10335839e87.45.1725376624758;
        Tue, 03 Sep 2024 08:17:04 -0700 (PDT)
Received: from amikhalitsyn.. ([188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a19afb108sm156377166b.223.2024.09.03.08.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 08:17:04 -0700 (PDT)
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
Subject: [PATCH v4 08/15] fs/fuse: support idmapped ->setattr op
Date: Tue,  3 Sep 2024 17:16:19 +0200
Message-Id: <20240903151626.264609-9-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240903151626.264609-1-aleksandr.mikhalitsyn@canonical.com>
References: <20240903151626.264609-1-aleksandr.mikhalitsyn@canonical.com>
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
Reviewed-by: Christian Brauner <brauner@kernel.org>
---
v2:
	- pass idmap in more cases to make code easier to understand
---
 fs/fuse/dir.c    | 32 +++++++++++++++++++++-----------
 fs/fuse/file.c   |  2 +-
 fs/fuse/fuse_i.h |  4 ++--
 3 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 870932543aa0..08bf9cc51a65 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1748,17 +1748,27 @@ static bool update_mtime(unsigned ivalid, bool trust_local_mtime)
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
@@ -1878,8 +1888,8 @@ int fuse_flush_times(struct inode *inode, struct fuse_file *ff)
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
@@ -1899,7 +1909,7 @@ int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
 	if (!fc->default_permissions)
 		attr->ia_valid |= ATTR_FORCE;
 
-	err = setattr_prepare(&nop_mnt_idmap, dentry, attr);
+	err = setattr_prepare(idmap, dentry, attr);
 	if (err)
 		return err;
 
@@ -1958,7 +1968,7 @@ int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
 
 	memset(&inarg, 0, sizeof(inarg));
 	memset(&outarg, 0, sizeof(outarg));
-	iattr_to_fattr(fc, attr, &inarg, trust_local_cmtime);
+	iattr_to_fattr(idmap, fc, attr, &inarg, trust_local_cmtime);
 	if (file) {
 		struct fuse_file *ff = file->private_data;
 		inarg.valid |= FATTR_FH;
@@ -2093,7 +2103,7 @@ static int fuse_setattr(struct mnt_idmap *idmap, struct dentry *entry,
 	if (!attr->ia_valid)
 		return 0;
 
-	ret = fuse_do_setattr(entry, attr, file);
+	ret = fuse_do_setattr(idmap, entry, attr, file);
 	if (!ret) {
 		/*
 		 * If filesystem supports acls it may have updated acl xattrs in
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 7d14d533dad1..06ff4742ab08 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2966,7 +2966,7 @@ static void fuse_do_truncate(struct file *file)
 	attr.ia_file = file;
 	attr.ia_valid |= ATTR_FILE;
 
-	fuse_do_setattr(file_dentry(file), &attr, file);
+	fuse_do_setattr(file_mnt_idmap(file), file_dentry(file), &attr, file);
 }
 
 static inline loff_t fuse_round_up(struct fuse_conn *fc, loff_t off)
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 656575e3e4cf..de0ab2f14995 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1331,8 +1331,8 @@ bool fuse_write_update_attr(struct inode *inode, loff_t pos, ssize_t written);
 int fuse_flush_times(struct inode *inode, struct fuse_file *ff);
 int fuse_write_inode(struct inode *inode, struct writeback_control *wbc);
 
-int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
-		    struct file *file);
+int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
+		    struct iattr *attr, struct file *file);
 
 void fuse_set_initialized(struct fuse_conn *fc);
 
-- 
2.34.1


