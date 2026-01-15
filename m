Return-Path: <linux-fsdevel+bounces-73917-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E316BD24729
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 13:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 768F130A50DC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 12:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CD6394469;
	Thu, 15 Jan 2026 12:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aNhtvKk8";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q4VCCU0L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D39A3939AE
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 12:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768479830; cv=none; b=gJRRp8XMjVTlwh0q+zifc+35Bmm6ktKW3iL0H65HNMBn1ce3kL3PSvfZIYtYt0iV48p3PyaRFd61ly8b0Vmrj36je+OM5r6HhNXaK3zGQis9eRYsc/s6yfBZfVHD6byJSFM0QBFAxh3oKmTTI8P6Bg9Vxhj8r9vyEu9uyrYlfPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768479830; c=relaxed/simple;
	bh=yDcX+VR2ZB913VlzCxRsLl9YdwKzo5YmvjuBxTGHcpE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jOMQ4yYp6j5ar5dtkGXKvI2yDKFbgwwJu4KAYfzN4blXtpwAb0ZsXoasgRNtI+pVbs7NSlC98AJ4dfNGZe92lj5cojtY0bqx6Svjg9w0B96I4BM3Yu8/bKNhZpyGqAlVTlIlBCOiFFaaDATRPXSIymt3ThZWJbfdXn727YXYu4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aNhtvKk8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q4VCCU0L; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768479827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IKdL8/BtMTOi7PdLWRnF+aOaLZ+7pT0H4c/cXghhhKc=;
	b=aNhtvKk85QYdmkp1wBfHOxYtqWxN4KstBcXLGvR99hLXmbOehWrgfzof2YlxjSYFq+AeGf
	OMgm9CDzpVHuX3QeB99upueWGq7RMQEnWTDp3jLF27fZbtP/G1N4hkQXh5nkl+cIfIJdI9
	VcUTxTW553G7RQJtV/NMVMDLvHcbxjQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-7Nn9si7PNE6A8BpzTgtgsA-1; Thu, 15 Jan 2026 07:23:45 -0500
X-MC-Unique: 7Nn9si7PNE6A8BpzTgtgsA-1
X-Mimecast-MFC-AGG-ID: 7Nn9si7PNE6A8BpzTgtgsA_1768479825
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-64c7242a456so1369513a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 04:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768479824; x=1769084624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IKdL8/BtMTOi7PdLWRnF+aOaLZ+7pT0H4c/cXghhhKc=;
        b=Q4VCCU0LGnZGv+nf/9PljxcsT6H3+Tfn64KJWmRlxkNAzwdNjc1Fzwo+d6a8wMYzjP
         5hd/49k73GzNkGVG1xDnihKbhl9rd9q1j1JChlupCkmqXZU0qegU9LTyoFp52jYqERGG
         6jywZ8dTYjm8SbPUy1kjOk5M+E4qG9K0prnYKOyJye4aBmjEdVf7hVIzb+UhyMF3IHXO
         cRCmoySzngMKGzDm1W02domdSVeWXdHQah/eoSwBN+vYxTJ8qesSOTO/uyVdLi9jcv1i
         DqDdYVESlj91cqU6cgKFKSccI8X+T6qBW+RXEXXN+ON2uYjFaA280DOcV1YZON9M3MHl
         thXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768479824; x=1769084624;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IKdL8/BtMTOi7PdLWRnF+aOaLZ+7pT0H4c/cXghhhKc=;
        b=NsXazL8QMexaxk8xlfudMwBm7nBPqOc9MvhBU8k1uG1DBvNSVi6LhFCoqI1neiY610
         CSjSB1qCU1l3Z4yHH0yrxtWvLOj7gjiFlOZCkgbEA/cKRyN+py3MqAti9EbtDVtJjb9a
         OueY6N1037YmtYwe43y6wJq6FVWjscVahInIr3jgJFLvymbd7DUd3BVXZDRrASYtTh4r
         I3TqTzBw2b6aSWADLEFASexCaptxGWb4vI+6P4NlfGAdlvNVhy/bMTXeFaHvtEmamVy5
         L/CvGY+rPnSmqenE+eZxTX8RnQwQ+dvLRyJqXOjDjxPpx3D3SmMnzfssPDq7GZ+sfsfo
         JP0A==
X-Gm-Message-State: AOJu0Yx8ZECPV8THl89ECz2MW5NpscwkIsF7008BG+18BFjT0RlLx5r5
	UhYfhz2VFOryc97ALlMgfNfpNhCPoWMl5301jJvZEotUfCpXaW/WP8dae9FerU6AM/KPhgNHj9K
	+lsWnCXHRDZ2ROdKKGEVrPYDSL5/Jtcgp2O6MfUhAngWvlslwcz6N0uOF4/OlsaypdLsGsMiJ+n
	EnmQlbPIcMa5ZTTV+hZQXViWVEC0SzKPty3z5vYK6OvsQ5+yXFVZU=
X-Gm-Gg: AY/fxX6jAaK6+ELF8n1I5Yn1kTi5yD2FFfGMHsTVDe77ooLcK4qa8tK4rktgu4glmhW
	2ZZOr9Kwp8B85n1MbyQMo0MktVXXmRAouBcMQKP9rHQDSdnO0sv80zi6NxB0pRd9v+2k+3/1upD
	zUFqcIlC+jm/mO3A51GQZl6W3BfIHPOhCwQtlPMym37DqBLIvGIkFpPTc6m3Z1qfiA53Tvg/alk
	bQsHMnWmrWcuG40zrLeKnO4axDqi7iGH0UC5ZoFADkf2edq747LdATaqOs9eS8WpRPWJv9gMfbe
	DRkCZRBCFInIZeRvej++WbssuCmPloOB+Yy3LLCXVQ4qdj8/n5uEt13r+5qGTmnx354lo/wIFn2
	mPGQPasiIATFhlA8z25s1v0cpf4GVaR/GDTT0eN6JK594/jZlYFOwWO2F9jf1Ijo6
X-Received: by 2002:a17:906:7312:b0:b7c:f5b6:bb52 with SMTP id a640c23a62f3a-b87612c0dffmr508690066b.43.1768479824092;
        Thu, 15 Jan 2026 04:23:44 -0800 (PST)
X-Received: by 2002:a17:906:7312:b0:b7c:f5b6:bb52 with SMTP id a640c23a62f3a-b87612c0dffmr508688166b.43.1768479823532;
        Thu, 15 Jan 2026 04:23:43 -0800 (PST)
Received: from maszat.piliscsaba.szeredi.hu (193-226-246-7.pool.digikabel.hu. [193.226.246.7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b871081b04bsm1272398266b.53.2026.01.15.04.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 04:23:43 -0800 (PST)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>
Subject: [PATCH] posix_acl: make posix_acl_to_xattr() alloc the buffer
Date: Thu, 15 Jan 2026 13:23:40 +0100
Message-ID: <20260115122341.556026-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Without exception all caller do that.  So move the allocation into the
helper.

This reduces boilerplate and removes unnecessary error checking.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
Tested fuse only.

 fs/9p/acl.c                     | 16 ++---------
 fs/btrfs/acl.c                  | 10 ++-----
 fs/ceph/acl.c                   | 51 ++++++++++++++-------------------
 fs/fuse/acl.c                   | 12 +++-----
 fs/gfs2/acl.c                   | 13 ++-------
 fs/jfs/acl.c                    |  9 ++----
 fs/ntfs3/xattr.c                |  6 +---
 fs/orangefs/acl.c               |  8 +-----
 fs/posix_acl.c                  | 21 +++++++-------
 include/linux/posix_acl_xattr.h |  5 ++--
 10 files changed, 53 insertions(+), 98 deletions(-)

diff --git a/fs/9p/acl.c b/fs/9p/acl.c
index 633da5e37299..ae7e7cf7523a 100644
--- a/fs/9p/acl.c
+++ b/fs/9p/acl.c
@@ -167,17 +167,11 @@ int v9fs_iop_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		if (retval)
 			goto err_out;
 
-		size = posix_acl_xattr_size(acl->a_count);
-
-		value = kzalloc(size, GFP_NOFS);
+		value = posix_acl_to_xattr(&init_user_ns, acl, &size, GFP_NOFS);
 		if (!value) {
 			retval = -ENOMEM;
 			goto err_out;
 		}
-
-		retval = posix_acl_to_xattr(&init_user_ns, acl, value, size);
-		if (retval < 0)
-			goto err_out;
 	}
 
 	/*
@@ -257,13 +251,10 @@ static int v9fs_set_acl(struct p9_fid *fid, int type, struct posix_acl *acl)
 		return 0;
 
 	/* Set a setxattr request to server */
-	size = posix_acl_xattr_size(acl->a_count);
-	buffer = kmalloc(size, GFP_KERNEL);
+	buffer = posix_acl_to_xattr(&init_user_ns, acl, &size, GFP_KERNEL);
 	if (!buffer)
 		return -ENOMEM;
-	retval = posix_acl_to_xattr(&init_user_ns, acl, buffer, size);
-	if (retval < 0)
-		goto err_free_out;
+
 	switch (type) {
 	case ACL_TYPE_ACCESS:
 		name = XATTR_NAME_POSIX_ACL_ACCESS;
@@ -275,7 +266,6 @@ static int v9fs_set_acl(struct p9_fid *fid, int type, struct posix_acl *acl)
 		BUG();
 	}
 	retval = v9fs_fid_xattr_set(fid, name, buffer, size, 0);
-err_free_out:
 	kfree(buffer);
 	return retval;
 }
diff --git a/fs/btrfs/acl.c b/fs/btrfs/acl.c
index c336e2ab7f8a..e55b686fe1ab 100644
--- a/fs/btrfs/acl.c
+++ b/fs/btrfs/acl.c
@@ -57,7 +57,8 @@ struct posix_acl *btrfs_get_acl(struct inode *inode, int type, bool rcu)
 int __btrfs_set_acl(struct btrfs_trans_handle *trans, struct inode *inode,
 		    struct posix_acl *acl, int type)
 {
-	int ret, size = 0;
+	int ret;
+	size_t size = 0;
 	const char *name;
 	char AUTO_KFREE(value);
 
@@ -77,20 +78,15 @@ int __btrfs_set_acl(struct btrfs_trans_handle *trans, struct inode *inode,
 	if (acl) {
 		unsigned int nofs_flag;
 
-		size = posix_acl_xattr_size(acl->a_count);
 		/*
 		 * We're holding a transaction handle, so use a NOFS memory
 		 * allocation context to avoid deadlock if reclaim happens.
 		 */
 		nofs_flag = memalloc_nofs_save();
-		value = kmalloc(size, GFP_KERNEL);
+		value = posix_acl_to_xattr(&init_user_ns, acl, &size, GFP_KERNEL);
 		memalloc_nofs_restore(nofs_flag);
 		if (!value)
 			return -ENOMEM;
-
-		ret = posix_acl_to_xattr(&init_user_ns, acl, value, size);
-		if (ret < 0)
-			return ret;
 	}
 
 	if (trans)
diff --git a/fs/ceph/acl.c b/fs/ceph/acl.c
index 1564eacc253d..34e853fdd0a9 100644
--- a/fs/ceph/acl.c
+++ b/fs/ceph/acl.c
@@ -90,7 +90,8 @@ struct posix_acl *ceph_get_acl(struct inode *inode, int type, bool rcu)
 int ceph_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		 struct posix_acl *acl, int type)
 {
-	int ret = 0, size = 0;
+	int ret = 0;
+	size_t size = 0;
 	const char *name = NULL;
 	char *value = NULL;
 	struct iattr newattrs;
@@ -126,16 +127,11 @@ int ceph_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 	}
 
 	if (acl) {
-		size = posix_acl_xattr_size(acl->a_count);
-		value = kmalloc(size, GFP_NOFS);
+		value = posix_acl_to_xattr(&init_user_ns, acl, &size, GFP_NOFS);
 		if (!value) {
 			ret = -ENOMEM;
 			goto out;
 		}
-
-		ret = posix_acl_to_xattr(&init_user_ns, acl, value, size);
-		if (ret < 0)
-			goto out_free;
 	}
 
 	if (new_mode != old_mode) {
@@ -172,7 +168,7 @@ int ceph_pre_init_acls(struct inode *dir, umode_t *mode,
 	struct posix_acl *acl, *default_acl;
 	size_t val_size1 = 0, val_size2 = 0;
 	struct ceph_pagelist *pagelist = NULL;
-	void *tmp_buf = NULL;
+	void *tmp_buf1 = NULL, *tmp_buf2 = NULL;
 	int err;
 
 	err = posix_acl_create(dir, mode, &default_acl, &acl);
@@ -192,15 +188,6 @@ int ceph_pre_init_acls(struct inode *dir, umode_t *mode,
 	if (!default_acl && !acl)
 		return 0;
 
-	if (acl)
-		val_size1 = posix_acl_xattr_size(acl->a_count);
-	if (default_acl)
-		val_size2 = posix_acl_xattr_size(default_acl->a_count);
-
-	err = -ENOMEM;
-	tmp_buf = kmalloc(max(val_size1, val_size2), GFP_KERNEL);
-	if (!tmp_buf)
-		goto out_err;
 	pagelist = ceph_pagelist_alloc(GFP_KERNEL);
 	if (!pagelist)
 		goto out_err;
@@ -213,34 +200,39 @@ int ceph_pre_init_acls(struct inode *dir, umode_t *mode,
 
 	if (acl) {
 		size_t len = strlen(XATTR_NAME_POSIX_ACL_ACCESS);
+
+		err = -ENOMEM;
+		tmp_buf1 = posix_acl_to_xattr(&init_user_ns, acl,
+					      &val_size1, GFP_KERNEL);
+		if (!tmp_buf1)
+			goto out_err;
 		err = ceph_pagelist_reserve(pagelist, len + val_size1 + 8);
 		if (err)
 			goto out_err;
 		ceph_pagelist_encode_string(pagelist, XATTR_NAME_POSIX_ACL_ACCESS,
 					    len);
-		err = posix_acl_to_xattr(&init_user_ns, acl,
-					 tmp_buf, val_size1);
-		if (err < 0)
-			goto out_err;
 		ceph_pagelist_encode_32(pagelist, val_size1);
-		ceph_pagelist_append(pagelist, tmp_buf, val_size1);
+		ceph_pagelist_append(pagelist, tmp_buf1, val_size1);
 	}
 	if (default_acl) {
 		size_t len = strlen(XATTR_NAME_POSIX_ACL_DEFAULT);
+
+		err = -ENOMEM;
+		tmp_buf2 = posix_acl_to_xattr(&init_user_ns, default_acl,
+					      &val_size2, GFP_KERNEL);
+		if (!tmp_buf2)
+			goto out_err;
 		err = ceph_pagelist_reserve(pagelist, len + val_size2 + 8);
 		if (err)
 			goto out_err;
 		ceph_pagelist_encode_string(pagelist,
 					  XATTR_NAME_POSIX_ACL_DEFAULT, len);
-		err = posix_acl_to_xattr(&init_user_ns, default_acl,
-					 tmp_buf, val_size2);
-		if (err < 0)
-			goto out_err;
 		ceph_pagelist_encode_32(pagelist, val_size2);
-		ceph_pagelist_append(pagelist, tmp_buf, val_size2);
+		ceph_pagelist_append(pagelist, tmp_buf2, val_size2);
 	}
 
-	kfree(tmp_buf);
+	kfree(tmp_buf1);
+	kfree(tmp_buf2);
 
 	as_ctx->acl = acl;
 	as_ctx->default_acl = default_acl;
@@ -250,7 +242,8 @@ int ceph_pre_init_acls(struct inode *dir, umode_t *mode,
 out_err:
 	posix_acl_release(acl);
 	posix_acl_release(default_acl);
-	kfree(tmp_buf);
+	kfree(tmp_buf1);
+	kfree(tmp_buf2);
 	if (pagelist)
 		ceph_pagelist_release(pagelist);
 	return err;
diff --git a/fs/fuse/acl.c b/fs/fuse/acl.c
index 8f484b105f13..cbde6ac1add3 100644
--- a/fs/fuse/acl.c
+++ b/fs/fuse/acl.c
@@ -122,20 +122,16 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		 * them to be refreshed the next time they are used,
 		 * and it also updates i_ctime.
 		 */
-		size_t size = posix_acl_xattr_size(acl->a_count);
+		size_t size;
 		void *value;
 
-		if (size > PAGE_SIZE)
-			return -E2BIG;
-
-		value = kmalloc(size, GFP_KERNEL);
+		value = posix_acl_to_xattr(fc->user_ns, acl, &size, GFP_KERNEL);
 		if (!value)
 			return -ENOMEM;
 
-		ret = posix_acl_to_xattr(fc->user_ns, acl, value, size);
-		if (ret < 0) {
+		if (size > PAGE_SIZE) {
 			kfree(value);
-			return ret;
+			return -E2BIG;
 		}
 
 		/*
diff --git a/fs/gfs2/acl.c b/fs/gfs2/acl.c
index 443640e6fb9c..01789c23e31c 100644
--- a/fs/gfs2/acl.c
+++ b/fs/gfs2/acl.c
@@ -83,21 +83,14 @@ struct posix_acl *gfs2_get_acl(struct inode *inode, int type, bool rcu)
 int __gfs2_set_acl(struct inode *inode, struct posix_acl *acl, int type)
 {
 	int error;
-	size_t len;
-	char *data;
+	size_t len = 0;
+	char *data = 0;
 	const char *name = gfs2_acl_name(type);
 
 	if (acl) {
-		len = posix_acl_xattr_size(acl->a_count);
-		data = kmalloc(len, GFP_NOFS);
+		data = posix_acl_to_xattr(&init_user_ns, acl, &len, GFP_NOFS);
 		if (data == NULL)
 			return -ENOMEM;
-		error = posix_acl_to_xattr(&init_user_ns, acl, data, len);
-		if (error < 0)
-			goto out;
-	} else {
-		data = NULL;
-		len = 0;
 	}
 
 	error = __gfs2_xattr_set(inode, name, data, len, 0, GFS2_EATYPE_SYS);
diff --git a/fs/jfs/acl.c b/fs/jfs/acl.c
index 1de3602c98de..16b71a23ff1e 100644
--- a/fs/jfs/acl.c
+++ b/fs/jfs/acl.c
@@ -61,7 +61,7 @@ static int __jfs_set_acl(tid_t tid, struct inode *inode, int type,
 {
 	char *ea_name;
 	int rc;
-	int size = 0;
+	size_t size = 0;
 	char *value = NULL;
 
 	switch (type) {
@@ -76,16 +76,11 @@ static int __jfs_set_acl(tid_t tid, struct inode *inode, int type,
 	}
 
 	if (acl) {
-		size = posix_acl_xattr_size(acl->a_count);
-		value = kmalloc(size, GFP_KERNEL);
+		value = posix_acl_to_xattr(&init_user_ns, acl, &size, GFP_KERNEL);
 		if (!value)
 			return -ENOMEM;
-		rc = posix_acl_to_xattr(&init_user_ns, acl, value, size);
-		if (rc < 0)
-			goto out;
 	}
 	rc = __jfs_setxattr(tid, inode, ea_name, value, size, 0);
-out:
 	kfree(value);
 
 	if (!rc)
diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index c93df55e98d0..37a69a75ce68 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -641,13 +641,9 @@ static noinline int ntfs_set_acl_ex(struct mnt_idmap *idmap,
 		value = NULL;
 		flags = XATTR_REPLACE;
 	} else {
-		size = posix_acl_xattr_size(acl->a_count);
-		value = kmalloc(size, GFP_NOFS);
+		value = posix_acl_to_xattr(&init_user_ns, acl, &size, GFP_NOFS);
 		if (!value)
 			return -ENOMEM;
-		err = posix_acl_to_xattr(&init_user_ns, acl, value, size);
-		if (err < 0)
-			goto out;
 		flags = 0;
 	}
 
diff --git a/fs/orangefs/acl.c b/fs/orangefs/acl.c
index 5aefb705bcc8..a01ef0c1b1bf 100644
--- a/fs/orangefs/acl.c
+++ b/fs/orangefs/acl.c
@@ -90,14 +90,9 @@ int __orangefs_set_acl(struct inode *inode, struct posix_acl *acl, int type)
 		     type);
 
 	if (acl) {
-		size = posix_acl_xattr_size(acl->a_count);
-		value = kmalloc(size, GFP_KERNEL);
+		value = posix_acl_to_xattr(&init_user_ns, acl, &size, GFP_KERNEL);
 		if (!value)
 			return -ENOMEM;
-
-		error = posix_acl_to_xattr(&init_user_ns, acl, value, size);
-		if (error < 0)
-			goto out;
 	}
 
 	gossip_debug(GOSSIP_ACL_DEBUG,
@@ -111,7 +106,6 @@ int __orangefs_set_acl(struct inode *inode, struct posix_acl *acl, int type)
 	 */
 	error = orangefs_inode_setxattr(inode, name, value, size, 0);
 
-out:
 	kfree(value);
 	if (!error)
 		set_cached_acl(inode, type, acl);
diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 768f027c1428..4ef6f9d2b8d6 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -829,19 +829,19 @@ EXPORT_SYMBOL (posix_acl_from_xattr);
 /*
  * Convert from in-memory to extended attribute representation.
  */
-int
+void *
 posix_acl_to_xattr(struct user_namespace *user_ns, const struct posix_acl *acl,
-		   void *buffer, size_t size)
+		   size_t *sizep, gfp_t gfp)
 {
-	struct posix_acl_xattr_header *ext_acl = buffer;
+	struct posix_acl_xattr_header *ext_acl;
 	struct posix_acl_xattr_entry *ext_entry;
-	int real_size, n;
+	size_t size;
+	int n;
 
-	real_size = posix_acl_xattr_size(acl->a_count);
-	if (!buffer)
-		return real_size;
-	if (real_size > size)
-		return -ERANGE;
+	size = posix_acl_xattr_size(acl->a_count);
+	ext_acl = kmalloc(size, gfp);
+	if (!ext_acl)
+		return NULL;
 
 	ext_entry = (void *)(ext_acl + 1);
 	ext_acl->a_version = cpu_to_le32(POSIX_ACL_XATTR_VERSION);
@@ -864,7 +864,8 @@ posix_acl_to_xattr(struct user_namespace *user_ns, const struct posix_acl *acl,
 			break;
 		}
 	}
-	return real_size;
+	*sizep = size;
+	return ext_acl;
 }
 EXPORT_SYMBOL (posix_acl_to_xattr);
 
diff --git a/include/linux/posix_acl_xattr.h b/include/linux/posix_acl_xattr.h
index e86f3b731da2..9e1892525eac 100644
--- a/include/linux/posix_acl_xattr.h
+++ b/include/linux/posix_acl_xattr.h
@@ -44,8 +44,9 @@ posix_acl_from_xattr(struct user_namespace *user_ns, const void *value,
 }
 #endif
 
-int posix_acl_to_xattr(struct user_namespace *user_ns,
-		       const struct posix_acl *acl, void *buffer, size_t size);
+extern void *posix_acl_to_xattr(struct user_namespace *user_ns, const struct posix_acl *acl,
+				size_t *sizep, gfp_t gfp);
+
 static inline const char *posix_acl_xattr_name(int type)
 {
 	switch (type) {
-- 
2.52.0


