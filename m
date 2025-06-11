Return-Path: <linux-fsdevel+bounces-51241-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBE4AD4D8D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 09:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE8791BC0709
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 07:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1797223F417;
	Wed, 11 Jun 2025 07:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ZxqpBDrL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2222233D88
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 07:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749628481; cv=none; b=O7YMhzzfhATaUtRNEkEdcVcNnDKH9lkXUpMMPMlCqiclkSy94ODP7H1UpGtB0smFXnKfbk1uHX1lLFctifqOQh222yrXXxQQJ0hqcG72X0fNE4Cr24P0VICeSRXs7SG0HsWi/w/qMKFtxih6TPR4ORW3FlJdV9dFHvAw5Dx4I+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749628481; c=relaxed/simple;
	bh=VSot6F5+/W2iNPZByDL6vG6xAPEtBG34A6b6abMmRYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sn5/pEnxljZESeZCy6hPV1ND6+AsVIXnAwsCwPhcGq9p1V3Jp63lCG5zCMu9aUZyo7fjOvVfYunpOajZHyoiMlsiBl6Ky1herjzurGmWDss5YeVLkvdkIPHNNCyXMK64gfY8vILtlMzDj35TMY91zaVY9uTl3n9JFM8IIRr8Kq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ZxqpBDrL; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=viJISd1ufrWElyOzBjC1xz5QLQx3LszWCQP09hqrcFo=; b=ZxqpBDrLUY3/mBmQHcLkCyHCI3
	B3KCGh6KhmTwjtnK2wbh+IWhDR/dUtqLxsN8psjwQ85GoTuTp80Vam4tdrlX5hTl8tjNhQ/o7K9sR
	HCfZwUymKYSKh8/9WSc1VxbQlUpUChdo7me0clN//OOwMkaBNIsHA9mr332XW4PgNuaolGnTNhlsb
	3e3XYLcG2VCEHHAiQcWllr7S9jUEjaifOapJWIgVVcd1OVqV3N/qANT8lUvmqwIgn/5Kilsmif+3x
	iSejanXXyD4OqPT8Pqj0dAzQg4ifKp0AtLcn7atQDibqWb9IScJge7VGKfOUyBwBYHVWRmSp/BysY
	PhpnaoQA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPGIA-0000000HTwK-1FJf;
	Wed, 11 Jun 2025 07:54:38 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	miklos@szeredi.hu,
	neilb@suse.de,
	torvalds@linux-foundation.org
Subject: [PATCH v2 05/21] fuse: no need for special dentry_operations for root dentry
Date: Wed, 11 Jun 2025 08:54:21 +0100
Message-ID: <20250611075437.4166635-5-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611075437.4166635-1-viro@zeniv.linux.org.uk>
References: <20250611075023.GJ299672@ZenIV>
 <20250611075437.4166635-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

->d_revalidate() is never called for root anyway...

Reviewed-by: Christian Brauner <brauner@kernel.org>
Acked-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/fuse/dir.c    | 7 -------
 fs/fuse/fuse_i.h | 1 -
 fs/fuse/inode.c  | 4 +---
 3 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 45b4c3cc1396..2d817d7cab26 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -338,13 +338,6 @@ const struct dentry_operations fuse_dentry_operations = {
 	.d_automount	= fuse_dentry_automount,
 };
 
-const struct dentry_operations fuse_root_dentry_operations = {
-#if BITS_PER_LONG < 64
-	.d_init		= fuse_dentry_init,
-	.d_release	= fuse_dentry_release,
-#endif
-};
-
 int fuse_valid_type(int m)
 {
 	return S_ISREG(m) || S_ISDIR(m) || S_ISLNK(m) || S_ISCHR(m) ||
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index b54f4f57789f..fb885376db6a 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1109,7 +1109,6 @@ static inline void fuse_sync_bucket_dec(struct fuse_sync_bucket *bucket)
 extern const struct file_operations fuse_dev_operations;
 
 extern const struct dentry_operations fuse_dentry_operations;
-extern const struct dentry_operations fuse_root_dentry_operations;
 
 /**
  * Get a filled in inode
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index bfe8d8af46f3..eb6177508598 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1850,12 +1850,10 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 
 	err = -ENOMEM;
 	root = fuse_get_root_inode(sb, ctx->rootmode);
-	sb->s_d_op = &fuse_root_dentry_operations;
+	sb->s_d_op = &fuse_dentry_operations;
 	root_dentry = d_make_root(root);
 	if (!root_dentry)
 		goto err_dev_free;
-	/* Root dentry doesn't have .d_revalidate */
-	sb->s_d_op = &fuse_dentry_operations;
 
 	mutex_lock(&fuse_mutex);
 	err = -EINVAL;
-- 
2.39.5


