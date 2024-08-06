Return-Path: <linux-fsdevel+bounces-25182-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 292CF94992E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 22:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8BC61F23198
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 20:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D28D16F0CE;
	Tue,  6 Aug 2024 20:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dipEsmPR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24EE154C11;
	Tue,  6 Aug 2024 20:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722976449; cv=none; b=nC3Kf2k3gmCri7uWTm7lg89d/bkVSR4S+AZs/xmqwDFTBdHVrRF8G1yG6Nki3iBlAvNjcD7h/bBOTGEZZ6+MLDSWmOIkeSUktjLFujUPZeDhy1JT3A+I42D6HlfzZi/m6aLsaAXgPlSIr85ALszyk0GIFm1KUeqWg4KFOvLes84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722976449; c=relaxed/simple;
	bh=PrqrmgDOEOjhQrTvAc43Q5ZxJmSa2LFRxD64s+F2xr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jhvMpvJ/RBjp1PgqkfduXHj0rujIJSptodaJKQQnjDR9UEqDl1DxkFhZaHazwV7eIvuD0p8YpY/y2efhEsyorT9Qxy/lNZ4KOrWGrhLrQjEqZStUSBDLK5GU8bRRM144RMzjbJwmNAJpvytHdHSXPofc+XUH5Uweyxe3YETfbSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dipEsmPR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81BD8C32786;
	Tue,  6 Aug 2024 20:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722976448;
	bh=PrqrmgDOEOjhQrTvAc43Q5ZxJmSa2LFRxD64s+F2xr4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dipEsmPRMDQzrqHfQCHmrnTVEKNjvC+CnbOJLfDd/Y998kJ2To6Bqgr4GCyP9P6nV
	 IcsTZGTF+v+trvbTDSWPitO0HgKX2hCQNArYkp506Wf4VoAaxV4mEn4cbcCx6HaM5e
	 CsDQ5KeLIAT7InPX9M4kaDQyYysPd9CA3c82RaZ0IePE36klPDoWczPULYwrdTa/bU
	 eDnbI5gSMHFDiRUcdy8gYiE1LMng5Z05Wh0qfV4TlQXppKJIBi2o75+UYIFDPHXayp
	 gP96LYgL0aKEJklM0TAQb6ek2tgE6bIJdU3Z7I+A5le5xT247j1GtRHah3Zy7GbHCP
	 nOf+VvVpD2AwA==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
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
	liamwisehart@meta.com,
	lltang@meta.com,
	shankaran@meta.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v3 bpf-next 2/3] bpf: Add kfunc bpf_get_dentry_xattr() to read xattr from dentry
Date: Tue,  6 Aug 2024 13:33:39 -0700
Message-ID: <20240806203340.3503805-3-song@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240806203340.3503805-1-song@kernel.org>
References: <20240806203340.3503805-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This kfunc can be used in LSM hooks with dentry, such as:

  security_inode_listxattr
  security_inode_permission

and many more.

Acked-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Song Liu <song@kernel.org>
---
 fs/bpf_fs_kfuncs.c | 42 +++++++++++++++++++++++++++++++++---------
 1 file changed, 33 insertions(+), 9 deletions(-)

diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
index b13d00f7ad2b..3fe9f59ef867 100644
--- a/fs/bpf_fs_kfuncs.c
+++ b/fs/bpf_fs_kfuncs.c
@@ -94,26 +94,29 @@ __bpf_kfunc int bpf_path_d_path(struct path *path, char *buf, size_t buf__sz)
 }
 
 /**
- * bpf_get_file_xattr - get xattr of a file
- * @file: file to get xattr from
+ * bpf_get_dentry_xattr - get xattr of a dentry
+ * @dentry: dentry to get xattr from
  * @name__str: name of the xattr
  * @value_p: output buffer of the xattr value
  *
- * Get xattr *name__str* of *file* and store the output in *value_ptr*.
+ * Get xattr *name__str* of *dentry* and store the output in *value_ptr*.
  *
  * For security reasons, only *name__str* with prefix "user." is allowed.
  *
  * Return: 0 on success, a negative value on error.
  */
-__bpf_kfunc int bpf_get_file_xattr(struct file *file, const char *name__str,
-				   struct bpf_dynptr *value_p)
+__bpf_kfunc int bpf_get_dentry_xattr(struct dentry *dentry, const char *name__str,
+				     struct bpf_dynptr *value_p)
 {
 	struct bpf_dynptr_kern *value_ptr = (struct bpf_dynptr_kern *)value_p;
-	struct dentry *dentry;
+	struct inode *inode = d_inode(dentry);
 	u32 value_len;
 	void *value;
 	int ret;
 
+	if (WARN_ON(!inode))
+		return -EINVAL;
+
 	if (strncmp(name__str, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN))
 		return -EPERM;
 
@@ -122,11 +125,31 @@ __bpf_kfunc int bpf_get_file_xattr(struct file *file, const char *name__str,
 	if (!value)
 		return -EINVAL;
 
-	dentry = file_dentry(file);
-	ret = inode_permission(&nop_mnt_idmap, dentry->d_inode, MAY_READ);
+	ret = inode_permission(&nop_mnt_idmap, inode, MAY_READ);
 	if (ret)
 		return ret;
-	return __vfs_getxattr(dentry, dentry->d_inode, name__str, value, value_len);
+	return __vfs_getxattr(dentry, inode, name__str, value, value_len);
+}
+
+/**
+ * bpf_get_file_xattr - get xattr of a file
+ * @file: file to get xattr from
+ * @name__str: name of the xattr
+ * @value_p: output buffer of the xattr value
+ *
+ * Get xattr *name__str* of *file* and store the output in *value_ptr*.
+ *
+ * For security reasons, only *name__str* with prefix "user." is allowed.
+ *
+ * Return: 0 on success, a negative value on error.
+ */
+__bpf_kfunc int bpf_get_file_xattr(struct file *file, const char *name__str,
+				   struct bpf_dynptr *value_p)
+{
+	struct dentry *dentry;
+
+	dentry = file_dentry(file);
+	return bpf_get_dentry_xattr(dentry, name__str, value_p);
 }
 
 __bpf_kfunc_end_defs();
@@ -136,6 +159,7 @@ BTF_ID_FLAGS(func, bpf_get_task_exe_file,
 	     KF_ACQUIRE | KF_TRUSTED_ARGS | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_put_file, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_path_d_path, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_get_dentry_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
 BTF_KFUNCS_END(bpf_fs_kfunc_set_ids)
 
-- 
2.43.5


