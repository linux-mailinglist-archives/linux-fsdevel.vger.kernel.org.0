Return-Path: <linux-fsdevel+bounces-16734-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B18148A1EB1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 20:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3B441C24C64
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 18:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4635256B62;
	Thu, 11 Apr 2024 18:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C5yXbvx1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C611754B
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Apr 2024 18:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712859978; cv=none; b=a2qrKDo5V1su/3PU9cf2awVo2Oj4KMQR4vgd2m0TNwe7Z5CMORRj58AHzdYu+J0tPDEMaFv7ihiRAZGnNgiWluhL/B20eoLXPJ5CBA6Qm80SLJUoVkwK/+eAiwrDQRUdCOsAp9dG4GDgzD6xKc/kYUa2XzahveSri0zJ8QBICVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712859978; c=relaxed/simple;
	bh=LlHyaLtG1YvNIQ1CFV+T9CQsPAP2A/k5hQvjMmkXKDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kk4P+TosGMbNCr7kw7ktv9Hioi72x36J/yYbxFCnQZDSqGtmWa+0qzRMdYC3YRxRD8Cfp6hwbKoaIqgnHxy5ewvLmBZKeQYQ4VfMGCvAhQ5JwyvvMCUbOkyZfrTRC+f+PmpOG/Ln8aR/WDjyN1attxorpq4fkjM9y6vK/7Cff+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C5yXbvx1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC84BC072AA;
	Thu, 11 Apr 2024 18:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712859978;
	bh=LlHyaLtG1YvNIQ1CFV+T9CQsPAP2A/k5hQvjMmkXKDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C5yXbvx1jrv9lNmAbJ2EsJBrqXxmBM3eiR6oNKWIRoC1F899cpZHpWNZ++JcVjc73
	 UzJ0PYbHkJM24Vu/cB52R1Qgd5zLJAdG8Mw5a8WuBGr5v8JEv0KYgTxFqLdfUaTRmk
	 k6mBQ4U7PcWWKdg4xBfY0P0W0uBsK5PIGzY9zfpgr6EIIKMjTsxHEB6LvMg3+eB/fT
	 4q3++BvbWDyTH8I9F+qxtvnoGVtO3i3wFCB2BmeDkcad/4CSfk5VNuCmDk0FKVzhag
	 patw11ykJaH357nsn2SqEj+/HVgdDL7+gN3Gj0RoVcja31X7iqg+32sHjQmC43MgBW
	 DbV1G7S8X/YdA==
From: cel@kernel.org
To: Christian Brauner <brauner@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1 1/2] shmem: Fix shmem_rename2()
Date: Thu, 11 Apr 2024 14:26:10 -0400
Message-ID: <20240411182611.203328-2-cel@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411182611.203328-1-cel@kernel.org>
References: <20240411182611.203328-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

When renaming onto an existing directory entry, user space expects
the replacement entry to have the same directory offset as the
original one.

The details of handling directory offsets during a rename are moved
to fs/libfs.c so that they can be reused by other API consumers.

For backporting to stable kernels: use xa_store() rather than
mtree_store(), and octx->xa rather than octx->mt. See commit
0e4a862174f2 ("libfs: Convert simple directory offsets to use a
Maple Tree") for details.

Link: https://gitlab.alpinelinux.org/alpine/aports/-/issues/15966
Fixes: a2e459555c5f ("shmem: stable directory offsets")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/libfs.c         | 53 ++++++++++++++++++++++++++++++++++++++++------
 include/linux/fs.h |  2 ++
 mm/shmem.c         |  3 +--
 3 files changed, 50 insertions(+), 8 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 3a6f2cb364f8..ff767288e5dd 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -295,6 +295,17 @@ int simple_offset_add(struct offset_ctx *octx, struct dentry *dentry)
 	return 0;
 }
 
+/*
+ * Internal helper for use when it is known that the tree entry at
+ * @index is already NULL.
+ */
+static int simple_offset_store(struct offset_ctx *octx, struct dentry *dentry,
+			       long index)
+{
+	offset_set(dentry, index);
+	return mtree_store(&octx->mt, index, dentry, GFP_KERNEL);
+}
+
 /**
  * simple_offset_remove - Remove an entry to a directory's offset map
  * @octx: directory offset ctx to be updated
@@ -345,6 +356,35 @@ int simple_offset_empty(struct dentry *dentry)
 	return ret;
 }
 
+/**
+ * simple_offset_rename - handle directory offsets for rename
+ * @old_dir: parent directory of source entry
+ * @old_dentry: dentry of source entry
+ * @new_dir: parent_directory of destination entry
+ * @new_dentry: dentry of destination
+ *
+ * Caller provides appropriate serialization.
+ *
+ * Returns zero on success, a negative errno value on failure.
+ */
+int simple_offset_rename(struct inode *old_dir, struct dentry *old_dentry,
+			 struct inode *new_dir, struct dentry *new_dentry)
+{
+	struct offset_ctx *old_ctx = old_dir->i_op->get_offset_ctx(old_dir);
+	struct offset_ctx *new_ctx = new_dir->i_op->get_offset_ctx(new_dir);
+	long new_index = dentry2offset(new_dentry);
+
+	simple_offset_remove(old_ctx, old_dentry);
+
+	/*
+	 * When the destination entry already exists, user space expects
+	 * its directory offset value to be unchanged after the rename.
+	 */
+	if (new_index)
+		return simple_offset_store(new_ctx, old_dentry, new_index);
+	return simple_offset_add(new_ctx, old_dentry);
+}
+
 /**
  * simple_offset_rename_exchange - exchange rename with directory offsets
  * @old_dir: parent of dentry being moved
@@ -352,6 +392,9 @@ int simple_offset_empty(struct dentry *dentry)
  * @new_dir: destination parent
  * @new_dentry: destination dentry
  *
+ * This API preserves the directory offset values. Caller provides
+ * appropriate serialization.
+ *
  * Returns zero on success. Otherwise a negative errno is returned and the
  * rename is rolled back.
  */
@@ -369,11 +412,11 @@ int simple_offset_rename_exchange(struct inode *old_dir,
 	simple_offset_remove(old_ctx, old_dentry);
 	simple_offset_remove(new_ctx, new_dentry);
 
-	ret = simple_offset_add(new_ctx, old_dentry);
+	ret = simple_offset_store(new_ctx, old_dentry, new_index);
 	if (ret)
 		goto out_restore;
 
-	ret = simple_offset_add(old_ctx, new_dentry);
+	ret = simple_offset_store(old_ctx, new_dentry, old_index);
 	if (ret) {
 		simple_offset_remove(new_ctx, old_dentry);
 		goto out_restore;
@@ -388,10 +431,8 @@ int simple_offset_rename_exchange(struct inode *old_dir,
 	return 0;
 
 out_restore:
-	offset_set(old_dentry, old_index);
-	mtree_store(&old_ctx->mt, old_index, old_dentry, GFP_KERNEL);
-	offset_set(new_dentry, new_index);
-	mtree_store(&new_ctx->mt, new_index, new_dentry, GFP_KERNEL);
+	(void)simple_offset_store(old_ctx, old_dentry, old_index);
+	(void)simple_offset_store(new_ctx, new_dentry, new_index);
 	return ret;
 }
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 8dfd53b52744..b09f14132110 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3340,6 +3340,8 @@ void simple_offset_init(struct offset_ctx *octx);
 int simple_offset_add(struct offset_ctx *octx, struct dentry *dentry);
 void simple_offset_remove(struct offset_ctx *octx, struct dentry *dentry);
 int simple_offset_empty(struct dentry *dentry);
+int simple_offset_rename(struct inode *old_dir, struct dentry *old_dentry,
+			 struct inode *new_dir, struct dentry *new_dentry);
 int simple_offset_rename_exchange(struct inode *old_dir,
 				  struct dentry *old_dentry,
 				  struct inode *new_dir,
diff --git a/mm/shmem.c b/mm/shmem.c
index 0aad0d9a621b..c0fb65223963 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3473,8 +3473,7 @@ static int shmem_rename2(struct mnt_idmap *idmap,
 			return error;
 	}
 
-	simple_offset_remove(shmem_get_offset_ctx(old_dir), old_dentry);
-	error = simple_offset_add(shmem_get_offset_ctx(new_dir), old_dentry);
+	error = simple_offset_rename(old_dir, old_dentry, new_dir, new_dentry);
 	if (error)
 		return error;
 
-- 
2.44.0


