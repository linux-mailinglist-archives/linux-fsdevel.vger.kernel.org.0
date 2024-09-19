Return-Path: <linux-fsdevel+bounces-29713-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C3397CABD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 16:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77B8D284A41
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 14:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172FC1A00E2;
	Thu, 19 Sep 2024 14:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWs0D8W5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1ED019FA8C;
	Thu, 19 Sep 2024 14:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726754785; cv=none; b=mYvbowcaXRjvmm2ZGjbUq91us4ubTCTIM5foPsH/uoOm5u38pFBHk3/Qu+Gr1C/hbbzs3mjeJYvNu3GpxmdMfDTWfbpQUsrBX+nel12c3eKVAQpS/jiTC22+PyXLtKUB2/8E6XZag+XIzK74Z4KtvTBncdFeyelTGiRgJyplDmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726754785; c=relaxed/simple;
	bh=+xo4QouCGQEXsiBSHU5dsvdiemZw73K9CLdh9XdR2sY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pea0YHi7liLali9A5ggY75xJwfVAfPNPzOIdMmtQJfS7WkLE06Ig5VB3VdV4UBr1TmWoAUHtno3yL+MpJLN6lfFWvA3PqK7/LvHBF3yA6hfkhB4UwJFQFBVsTSPEE6WfRe3bfPFmFS4Yk34Isney7jwbYZVg9j9PWCZFucNS4T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VWs0D8W5; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a8a7cdfdd80so115737266b.0;
        Thu, 19 Sep 2024 07:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726754782; x=1727359582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XUnDyBgoHRg3B4M6pmpbrK0J6zwK3/f7HDaqme+W9a4=;
        b=VWs0D8W5jDQ5pCSwOWk/xmoBNSQU8Gb5JaJg0XYQqFP5LAkbNLOmlcDYdIyvZJqVQ+
         q6HWX0+qhgf2kOwF5zl9b0JMBtSBK9xIHE+FBBEfsIUKqHinh2Fw+GXA6JdToSJxHGco
         TtfZN/oeA5hQbrP2D1Gx4hbyfD/8eMtOp5emABn5quOgz7ZifcpjHMJaoCy6RD5OturN
         GfFzUczjgpgwxWo0Ag/n/7WoEhp+3zTI5mEcOQ12RVS57sBbz1nlMr9WhaaMGTrBxISM
         KjSzGzLrdsRbHOziwvow7cGQHE/MgkHMXkRLtN7FKFjs6cuK8aYvn+3SGNU4+hvJj6Tq
         dDPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726754782; x=1727359582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XUnDyBgoHRg3B4M6pmpbrK0J6zwK3/f7HDaqme+W9a4=;
        b=MeelPQwRfiUJV41814vbO7yZ1De4ZA3kC55WfA7SKBx9R7RfU+xMVxIuundMJsnfZK
         xnsMSeL89yZfH6x/xk+lhCfh+dhtrxLtPIGvaDlTX5P9Sn99mVEMZl67NleNKrDjjkaA
         7kLZZnHkE7Lro8emcXQhndVliqgNc7T/vk/Wdk9JkvD1VssHqcW8w1yHnPnNVmIf9QTY
         ++eaZ9zodGHkxdpfqJ/dwKOyvYsf0dRkBFJLplpkVnR1oduRU0ZuVGNbXkwuWZHDwP+v
         0Q+XtmGIaHwoRY1CHleQbnG/b3Gtc62fuQLCEvZGqTG15uiZeyR3bUK682KM2BwztOLv
         gyPw==
X-Forwarded-Encrypted: i=1; AJvYcCUcJ+v649nmX5fhJGaKhL7SFBqq1jvUzIT3nuVLTjAow0qtRwbKZRNri9kY+ZINkliUwQyTc3P26OFV@vger.kernel.org, AJvYcCWF4n3/qNcEmGShW+XqfHRn+yO4Nu8puG2Q6oFvaxLfgfu81etjaFauOzUEJsFHV2WrR4gl8hVd1em277ne@vger.kernel.org
X-Gm-Message-State: AOJu0YzNLtWHTre9YabfePq5n0D08eFoY9wyshApy7I4h059NWbbaC/g
	xJpK1f7A42Hf4WozxjQXPdcEStnVOLHJfBzhMJ7qaULE13r0d6uI
X-Google-Smtp-Source: AGHT+IF6/Qb1dLqyVL46HmJF14+d93NYlTJRKZFhAQCAVHYhgmPEt3qgX1bOGbyHIXr0M5ieO3hF6A==
X-Received: by 2002:a17:907:7f20:b0:a86:7514:e649 with SMTP id a640c23a62f3a-a9048108f9fmr2095117066b.52.1726754779993;
        Thu, 19 Sep 2024 07:06:19 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9061330c1fsm719503266b.206.2024.09.19.07.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 07:06:18 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [RFC PATCH 2/2] fs: open_by_handle_at() support for decoding connectable file handles
Date: Thu, 19 Sep 2024 16:06:11 +0200
Message-Id: <20240919140611.1771651-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240919140611.1771651-1-amir73il@gmail.com>
References: <20240919140611.1771651-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow using an O_PATH fd as mount fd argument of open_by_handle_at(2).
This was not allowed before, so we use it to enable a new API for
decoding "connectable" file handles that were created using the
AT_HANDLE_CONNECTABLE flag to name_to_handle_at(2).

When mount fd is an O_PATH fd and decoding an O_PATH fd is requested,
use that as a hint to try to decode a "connected" fd with known path,
which is accessible (to capable user) from mount fd path.

Note that this does not check if the path is accessible to the calling
user, just that it is accessible wrt the mount namesapce, so if there
is no "connected" alias, or if parts of the path are hidden in the
mount namespace, open_by_handle_at(2) will return -ESTALE.

Note that the file handles used to decode a "connected" fd do not have
to be encoded with the AT_HANDLE_CONNECTABLE flag.  Specifically,
directory file handles are always "connectable", regardless of using
the AT_HANDLE_CONNECTABLE flag.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/fhandle.c | 61 +++++++++++++++++++++++++++++++---------------------
 1 file changed, 37 insertions(+), 24 deletions(-)

diff --git a/fs/fhandle.c b/fs/fhandle.c
index 956d9b25d4f7..1fabfb79fd55 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -146,37 +146,45 @@ SYSCALL_DEFINE5(name_to_handle_at, int, dfd, const char __user *, name,
 	return err;
 }
 
-static int get_path_from_fd(int fd, struct path *root)
+enum handle_to_path_flags {
+	HANDLE_CHECK_PERMS   = (1 << 0),
+	HANDLE_CHECK_SUBTREE = (1 << 1),
+};
+
+struct handle_to_path_ctx {
+	struct path root;
+	enum handle_to_path_flags flags;
+	unsigned int fh_flags;
+	unsigned int o_flags;
+};
+
+static int get_path_from_fd(int fd, struct handle_to_path_ctx *ctx)
 {
 	if (fd == AT_FDCWD) {
 		struct fs_struct *fs = current->fs;
 		spin_lock(&fs->lock);
-		*root = fs->pwd;
-		path_get(root);
+		ctx->root = fs->pwd;
+		path_get(&ctx->root);
 		spin_unlock(&fs->lock);
 	} else {
-		struct fd f = fdget(fd);
+		struct fd f = fdget_raw(fd);
 		if (!f.file)
 			return -EBADF;
-		*root = f.file->f_path;
-		path_get(root);
+		ctx->root = f.file->f_path;
+		path_get(&ctx->root);
+		/*
+		 * Use O_PATH mount fd and requested O_PATH fd as a hint for
+		 * decoding an fd with connected path, that is accessible from
+		 * the mount fd path.
+		 */
+		if (ctx->o_flags & O_PATH && f.file->f_mode & FMODE_PATH)
+			ctx->flags |= HANDLE_CHECK_SUBTREE;
 		fdput(f);
 	}
 
 	return 0;
 }
 
-enum handle_to_path_flags {
-	HANDLE_CHECK_PERMS   = (1 << 0),
-	HANDLE_CHECK_SUBTREE = (1 << 1),
-};
-
-struct handle_to_path_ctx {
-	struct path root;
-	enum handle_to_path_flags flags;
-	unsigned int fh_flags;
-};
-
 static int vfs_dentry_acceptable(void *context, struct dentry *dentry)
 {
 	struct handle_to_path_ctx *ctx = context;
@@ -224,7 +232,13 @@ static int vfs_dentry_acceptable(void *context, struct dentry *dentry)
 
 	if (!(ctx->flags & HANDLE_CHECK_SUBTREE) || d == root)
 		retval = 1;
-	WARN_ON_ONCE(d != root && d != root->d_sb->s_root);
+	/*
+	 * exportfs_decode_fh_raw() does not call acceptable() callback with
+	 * a disconnected directory dentry, so we should have reached either
+	 * mount fd directory or sb root.
+	 */
+	if (ctx->fh_flags & EXPORT_FH_DIR_ONLY)
+		WARN_ON_ONCE(d != root && d != root->d_sb->s_root);
 	dput(d);
 	return retval;
 }
@@ -265,8 +279,7 @@ static int do_handle_to_path(struct file_handle *handle, struct path *path,
  * filesystem but that only applies to procfs and sysfs neither of which
  * support decoding file handles.
  */
-static inline bool may_decode_fh(struct handle_to_path_ctx *ctx,
-				 unsigned int o_flags)
+static inline bool may_decode_fh(struct handle_to_path_ctx *ctx)
 {
 	struct path *root = &ctx->root;
 
@@ -276,7 +289,7 @@ static inline bool may_decode_fh(struct handle_to_path_ctx *ctx,
 	 *
 	 * There's only one dentry for each directory inode (VFS rule)...
 	 */
-	if (!(o_flags & O_DIRECTORY))
+	if (!(ctx->o_flags & O_DIRECTORY))
 		return false;
 
 	if (ns_capable(root->mnt->mnt_sb->s_user_ns, CAP_SYS_ADMIN))
@@ -303,13 +316,13 @@ static int handle_to_path(int mountdirfd, struct file_handle __user *ufh,
 	int retval = 0;
 	struct file_handle f_handle;
 	struct file_handle *handle = NULL;
-	struct handle_to_path_ctx ctx = {};
+	struct handle_to_path_ctx ctx = { .o_flags = o_flags };
 
-	retval = get_path_from_fd(mountdirfd, &ctx.root);
+	retval = get_path_from_fd(mountdirfd, &ctx);
 	if (retval)
 		goto out_err;
 
-	if (!capable(CAP_DAC_READ_SEARCH) && !may_decode_fh(&ctx, o_flags)) {
+	if (!capable(CAP_DAC_READ_SEARCH) && !may_decode_fh(&ctx)) {
 		retval = -EPERM;
 		goto out_path;
 	}
-- 
2.34.1


