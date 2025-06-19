Return-Path: <linux-fsdevel+bounces-52268-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 170DEAE0F5A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 00:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACC433A4E7A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 22:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D5B28DB4A;
	Thu, 19 Jun 2025 22:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tz5ScZlS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345B921B9FE;
	Thu, 19 Jun 2025 22:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750370510; cv=none; b=iCgC0VGxUgVgAMz3ujTwTDA7+Wu24dQcuhiRmQJbItYNRIsW7wdrkGLJHHZSqcmbrGQ1dcOa81J8jNS3pA4Lg04ugLwJNQpkY4StyMmKO9lRCh4VkcO6OzsXvXtaosXNK0V3cQYHS1XS0E+zk8nE92kYxk7dwHSfJZPHngfYXAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750370510; c=relaxed/simple;
	bh=70QcfvF6VIZudb7XIiCFkMwfwY4Krq2D+z7j36ghyg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PVwnZuyclH0aGVWWv54WD7FCHvkm+TyKlAyuYi/olmyeEuX+rHPYXz4i6q7n1z0mrcC73pXWMnQPCN13nOUK8vxi0waYDSjSuePRm8+ot1cWuV3ZFJtFKS+bxth+rE/h9gMqPXF6KGIMtgPVAhzIO9jRlaG1MfqNUlA66heOGl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tz5ScZlS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8866C4CEEA;
	Thu, 19 Jun 2025 22:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750370509;
	bh=70QcfvF6VIZudb7XIiCFkMwfwY4Krq2D+z7j36ghyg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tz5ScZlShMWxSHIYYWt4/9louCP4rzQvAH/9q+GYQHcW0cFPxujDkb/hMVGIL/vZ0
	 GQg6tb4wX1jjokBZg2KqkhKzuCnysN6r2lNJXRjsqOMKQUHjsx6mvO+tPdNkq9Ax0y
	 0wTzqdEJUSxRDY8HSfyOaHY8XkrFYwgoAcMXwWfHtH6biyZ8NUADo3wp3BP7PrM56F
	 w7M0Gk5zN1xE5OY6oO0NCxvfvx3O9VU5Um+cVJy/MI8JtkA5/rACTCyTjTAuY0S6AT
	 4FUlaX4nrLBvk0qZY5kSkpJ1ymSJld2T8GM73FdK/NKMIHh+HWlf/Farqx2D967So3
	 YrpbNyLWOauwQ==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: kernel-team@meta.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	kpsingh@kernel.org,
	mattbobrowski@google.com,
	amir73il@gmail.com,
	gregkh@linuxfoundation.org,
	tj@kernel.org,
	daan.j.demeyer@gmail.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v2 bpf-next 1/5] kernfs: remove iattr_mutex
Date: Thu, 19 Jun 2025 15:01:10 -0700
Message-ID: <20250619220114.3956120-2-song@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250619220114.3956120-1-song@kernel.org>
References: <20250619220114.3956120-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Brauner <brauner@kernel.org>

All allocations of struct kernfs_iattrs are serialized through a global
mutex. Simply do a racy allocation and let the first one win. I bet most
callers are under inode->i_rwsem anyway and it wouldn't be needed but
let's not require that.

Signed-off-by: Christian Brauner <brauner@kernel.org>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Song Liu <song@kernel.org>
---
 fs/kernfs/inode.c | 74 +++++++++++++++++++++++++----------------------
 1 file changed, 40 insertions(+), 34 deletions(-)

diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index b83054da68b3..f4b73b9482b7 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -24,45 +24,46 @@ static const struct inode_operations kernfs_iops = {
 	.listxattr	= kernfs_iop_listxattr,
 };
 
-static struct kernfs_iattrs *__kernfs_iattrs(struct kernfs_node *kn, int alloc)
+static struct kernfs_iattrs *__kernfs_iattrs(struct kernfs_node *kn, bool alloc)
 {
-	static DEFINE_MUTEX(iattr_mutex);
-	struct kernfs_iattrs *ret;
+	struct kernfs_iattrs *ret __free(kfree) = NULL;
+	struct kernfs_iattrs *attr;
 
-	mutex_lock(&iattr_mutex);
+	attr = READ_ONCE(kn->iattr);
+	if (attr || !alloc)
+		return attr;
 
-	if (kn->iattr || !alloc)
-		goto out_unlock;
-
-	kn->iattr = kmem_cache_zalloc(kernfs_iattrs_cache, GFP_KERNEL);
-	if (!kn->iattr)
-		goto out_unlock;
+	ret = kmem_cache_zalloc(kernfs_iattrs_cache, GFP_KERNEL);
+	if (!ret)
+		return NULL;
 
 	/* assign default attributes */
-	kn->iattr->ia_uid = GLOBAL_ROOT_UID;
-	kn->iattr->ia_gid = GLOBAL_ROOT_GID;
-
-	ktime_get_real_ts64(&kn->iattr->ia_atime);
-	kn->iattr->ia_mtime = kn->iattr->ia_atime;
-	kn->iattr->ia_ctime = kn->iattr->ia_atime;
-
-	simple_xattrs_init(&kn->iattr->xattrs);
-	atomic_set(&kn->iattr->nr_user_xattrs, 0);
-	atomic_set(&kn->iattr->user_xattr_size, 0);
-out_unlock:
-	ret = kn->iattr;
-	mutex_unlock(&iattr_mutex);
-	return ret;
+	ret->ia_uid = GLOBAL_ROOT_UID;
+	ret->ia_gid = GLOBAL_ROOT_GID;
+
+	ktime_get_real_ts64(&ret->ia_atime);
+	ret->ia_mtime = ret->ia_atime;
+	ret->ia_ctime = ret->ia_atime;
+
+	simple_xattrs_init(&ret->xattrs);
+	atomic_set(&ret->nr_user_xattrs, 0);
+	atomic_set(&ret->user_xattr_size, 0);
+
+	/* If someone raced us, recognize it. */
+	if (!try_cmpxchg(&kn->iattr, &attr, ret))
+		return READ_ONCE(kn->iattr);
+
+	return no_free_ptr(ret);
 }
 
 static struct kernfs_iattrs *kernfs_iattrs(struct kernfs_node *kn)
 {
-	return __kernfs_iattrs(kn, 1);
+	return __kernfs_iattrs(kn, true);
 }
 
 static struct kernfs_iattrs *kernfs_iattrs_noalloc(struct kernfs_node *kn)
 {
-	return __kernfs_iattrs(kn, 0);
+	return __kernfs_iattrs(kn, false);
 }
 
 int __kernfs_setattr(struct kernfs_node *kn, const struct iattr *iattr)
@@ -141,9 +142,9 @@ ssize_t kernfs_iop_listxattr(struct dentry *dentry, char *buf, size_t size)
 	struct kernfs_node *kn = kernfs_dentry_node(dentry);
 	struct kernfs_iattrs *attrs;
 
-	attrs = kernfs_iattrs(kn);
+	attrs = kernfs_iattrs_noalloc(kn);
 	if (!attrs)
-		return -ENOMEM;
+		return -ENODATA;
 
 	return simple_xattr_list(d_inode(dentry), &attrs->xattrs, buf, size);
 }
@@ -166,9 +167,10 @@ static inline void set_inode_attr(struct inode *inode,
 
 static void kernfs_refresh_inode(struct kernfs_node *kn, struct inode *inode)
 {
-	struct kernfs_iattrs *attrs = kn->iattr;
+	struct kernfs_iattrs *attrs;
 
 	inode->i_mode = kn->mode;
+	attrs = kernfs_iattrs_noalloc(kn);
 	if (attrs)
 		/*
 		 * kernfs_node has non-default attributes get them from
@@ -306,7 +308,9 @@ int kernfs_xattr_set(struct kernfs_node *kn, const char *name,
 		     const void *value, size_t size, int flags)
 {
 	struct simple_xattr *old_xattr;
-	struct kernfs_iattrs *attrs = kernfs_iattrs(kn);
+	struct kernfs_iattrs *attrs;
+
+	attrs = kernfs_iattrs(kn);
 	if (!attrs)
 		return -ENOMEM;
 
@@ -345,8 +349,9 @@ static int kernfs_vfs_user_xattr_add(struct kernfs_node *kn,
 				     struct simple_xattrs *xattrs,
 				     const void *value, size_t size, int flags)
 {
-	atomic_t *sz = &kn->iattr->user_xattr_size;
-	atomic_t *nr = &kn->iattr->nr_user_xattrs;
+	struct kernfs_iattrs *attr = kernfs_iattrs_noalloc(kn);
+	atomic_t *sz = &attr->user_xattr_size;
+	atomic_t *nr = &attr->nr_user_xattrs;
 	struct simple_xattr *old_xattr;
 	int ret;
 
@@ -384,8 +389,9 @@ static int kernfs_vfs_user_xattr_rm(struct kernfs_node *kn,
 				    struct simple_xattrs *xattrs,
 				    const void *value, size_t size, int flags)
 {
-	atomic_t *sz = &kn->iattr->user_xattr_size;
-	atomic_t *nr = &kn->iattr->nr_user_xattrs;
+	struct kernfs_iattrs *attr = kernfs_iattrs(kn);
+	atomic_t *sz = &attr->user_xattr_size;
+	atomic_t *nr = &attr->nr_user_xattrs;
 	struct simple_xattr *old_xattr;
 
 	old_xattr = simple_xattr_set(xattrs, full_name, value, size, flags);
-- 
2.47.1


