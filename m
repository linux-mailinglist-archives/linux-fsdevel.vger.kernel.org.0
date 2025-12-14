Return-Path: <linux-fsdevel+bounces-71265-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A88CBB676
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Dec 2025 04:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46285300F33B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Dec 2025 03:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C39261B8D;
	Sun, 14 Dec 2025 03:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="aMsawhgh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304AF2550D7;
	Sun, 14 Dec 2025 03:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765683019; cv=none; b=dMHDqcr2nMxAgEIKEqUyTK75uRApHOc1yV4oNKOZ6KMuDVVlA8ruYdgx4RikO1BZhyU771oBYi6PzdjoZDdCAjSIH5RDDXlOpLz1BC073TxaLPw27jLxVurAroxSQd5DTf+K1ayNtqEdtI2wTQjN9BEzzkuUEyDBUNaWo91a5EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765683019; c=relaxed/simple;
	bh=QgE6R0Oc/UN2zEIgyAS5qTWPI7aLZgm2RuG9HAFk2N0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e5qVn8hnybILmPKMIK1mEDLD/XNN2wcm5eN35CG8O3Yya5T3OrA5xVRLuYP6eGGu0IOARTZ3KVfBoVMOhr85OW86zn28NSHmt/JFVRzdFipYjsLMGq+pbNqGZSvjCjqtrxQKE3Kp+W/ayax4hizqTGX9kscQV4nBjhrWgbQsIdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=aMsawhgh; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KGi9KZh4n2dTU/mRqjBgfYapN1MvgzZFugI9Jrcbsco=; b=aMsawhgh9BwqrryYqi+W+63jCO
	/Uuz/A7YCu8QXbC/ErbOjU6LOwABRhf3q5lgdCSt0GA2xwcjXHUjz6f6lzEnVkGBMK/R08zXRR4Yh
	fikqIljLdNfWREWEJAb7ekS2vjlWfgzgH1ACqZI+/oEkmi9sb8e+o7ft8vgMyRAtW/BiicIJa1xa9
	8LPsI6nhMxZqyT4frifavmMcSGJkP6k68sldjPM+BCKrRwP2OG6Xt132Fw3K5rfqu8Pd8s4y2XGpg
	DGqdbiTbqwgH4uuR8BCZHo3K2Tjhi0b3IhKmMlP0sV2IIYNvViOgWQ/PTvnB5FCLeTqV12GBPlV1I
	u9GRaM+w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vUcor-00000001yMh-3YW7;
	Sun, 14 Dec 2025 03:30:49 +0000
Date: Sun, 14 Dec 2025 03:30:49 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Hugh Dickins <hughd@google.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Linus Torvalds <torvalds@linux-foundation.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC][PATCH 2/2] shmem: fix recovery on rename failures
Message-ID: <20251214033049.GB460900@ZenIV>
References: <47e9d03c-7a50-2c7d-247d-36f95a5329ed@google.com>
 <20251212050225.GD1712166@ZenIV>
 <20251212053452.GE1712166@ZenIV>
 <8ab63110-38b2-2188-91c5-909addfc9b23@google.com>
 <20251212063026.GF1712166@ZenIV>
 <2a102c6d-82d9-2751-cd31-c836b5c739b7@google.com>
 <bed18e79-ab2b-2a8f-0c32-77e6d27e2a05@google.com>
 <20251213072241.GH1712166@ZenIV>
 <20251214032734.GL1712166@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251214032734.GL1712166@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

maple_tree insertions can fail if we are seriously short on memory;
simple_offset_rename() does not recover well if it runs into that.
The same goes for simple_offset_rename_exchange().

Moreover, shmem_whiteout() expects that if it succeeds, the caller will
progress to d_move(), i.e. that shmem_rename2() won't fail past the
successful call of shmem_whiteout().

Not hard to fix, fortunately - mtree_store() can't fail if the index we
are trying to store into is already present in the tree as a singleton.

For simple_offset_rename_exchange() that's enough - we just need to be
careful about the order of operations.

For simple_offset_rename() solution is to preinsert the target into the
tree for new_dir; the rest can be done without any potentially failing
operations.

That preinsertion has to be done in shmem_rename2() rather than in
simple_offset_rename() itself - otherwise we'd need to deal with the
possibility of failure after successful shmem_whiteout().

Fixes: a2e459555c5f ("shmem: stable directory offsets")
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/libfs.c         | 50 +++++++++++++++++++---------------------------
 include/linux/fs.h |  2 +-
 mm/shmem.c         | 18 ++++++++++++-----
 3 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 9264523be85c..591eb649ebba 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -346,22 +346,22 @@ void simple_offset_remove(struct offset_ctx *octx, struct dentry *dentry)
  * User space expects the directory offset value of the replaced
  * (new) directory entry to be unchanged after a rename.
  *
- * Returns zero on success, a negative errno value on failure.
+ * Caller must have grabbed a slot for new_dentry in the maple_tree
+ * associated with new_dir, even if dentry is negative.
  */
-int simple_offset_rename(struct inode *old_dir, struct dentry *old_dentry,
-			 struct inode *new_dir, struct dentry *new_dentry)
+void simple_offset_rename(struct inode *old_dir, struct dentry *old_dentry,
+			  struct inode *new_dir, struct dentry *new_dentry)
 {
 	struct offset_ctx *old_ctx = old_dir->i_op->get_offset_ctx(old_dir);
 	struct offset_ctx *new_ctx = new_dir->i_op->get_offset_ctx(new_dir);
 	long new_offset = dentry2offset(new_dentry);
 
-	simple_offset_remove(old_ctx, old_dentry);
+	if (WARN_ON(!new_offset))
+		return;
 
-	if (new_offset) {
-		offset_set(new_dentry, 0);
-		return simple_offset_replace(new_ctx, old_dentry, new_offset);
-	}
-	return simple_offset_add(new_ctx, old_dentry);
+	simple_offset_remove(old_ctx, old_dentry);
+	offset_set(new_dentry, 0);
+	WARN_ON(simple_offset_replace(new_ctx, old_dentry, new_offset));
 }
 
 /**
@@ -388,31 +388,23 @@ int simple_offset_rename_exchange(struct inode *old_dir,
 	long new_index = dentry2offset(new_dentry);
 	int ret;
 
-	simple_offset_remove(old_ctx, old_dentry);
-	simple_offset_remove(new_ctx, new_dentry);
+	if (WARN_ON(!old_index || !new_index))
+		return -EINVAL;
 
-	ret = simple_offset_replace(new_ctx, old_dentry, new_index);
-	if (ret)
-		goto out_restore;
+	ret = mtree_store(&new_ctx->mt, new_index, old_dentry, GFP_KERNEL);
+	if (WARN_ON(ret))
+		return ret;
 
-	ret = simple_offset_replace(old_ctx, new_dentry, old_index);
-	if (ret) {
-		simple_offset_remove(new_ctx, old_dentry);
-		goto out_restore;
+	ret = mtree_store(&old_ctx->mt, old_index, new_dentry, GFP_KERNEL);
+	if (WARN_ON(ret)) {
+		mtree_store(&new_ctx->mt, new_index, new_dentry, GFP_KERNEL);
+		return ret;
 	}
 
-	ret = simple_rename_exchange(old_dir, old_dentry, new_dir, new_dentry);
-	if (ret) {
-		simple_offset_remove(new_ctx, old_dentry);
-		simple_offset_remove(old_ctx, new_dentry);
-		goto out_restore;
-	}
+	offset_set(old_dentry, new_index);
+	offset_set(new_dentry, old_index);
+	simple_rename_exchange(old_dir, old_dentry, new_dir, new_dentry);
 	return 0;
-
-out_restore:
-	(void)simple_offset_replace(old_ctx, old_dentry, old_index);
-	(void)simple_offset_replace(new_ctx, new_dentry, new_index);
-	return ret;
 }
 
 /**
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 04ceeca12a0d..f5c9cf28c4dc 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3247,7 +3247,7 @@ struct offset_ctx {
 void simple_offset_init(struct offset_ctx *octx);
 int simple_offset_add(struct offset_ctx *octx, struct dentry *dentry);
 void simple_offset_remove(struct offset_ctx *octx, struct dentry *dentry);
-int simple_offset_rename(struct inode *old_dir, struct dentry *old_dentry,
+void simple_offset_rename(struct inode *old_dir, struct dentry *old_dentry,
 			 struct inode *new_dir, struct dentry *new_dentry);
 int simple_offset_rename_exchange(struct inode *old_dir,
 				  struct dentry *old_dentry,
diff --git a/mm/shmem.c b/mm/shmem.c
index d3edc809e2e7..4232f8a39a43 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -4039,6 +4039,7 @@ static int shmem_rename2(struct mnt_idmap *idmap,
 	struct inode *inode = d_inode(old_dentry);
 	int they_are_dirs = S_ISDIR(inode->i_mode);
 	int error;
+	int had_offset = false;
 
 	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE | RENAME_WHITEOUT))
 		return -EINVAL;
@@ -4050,16 +4051,23 @@ static int shmem_rename2(struct mnt_idmap *idmap,
 	if (!simple_empty(new_dentry))
 		return -ENOTEMPTY;
 
+	error = simple_offset_add(shmem_get_offset_ctx(new_dir), new_dentry);
+	if (error == -EBUSY)
+		had_offset = true;
+	else if (unlikely(error))
+		return error;
+
 	if (flags & RENAME_WHITEOUT) {
 		error = shmem_whiteout(idmap, old_dir, old_dentry);
-		if (error)
+		if (error) {
+			if (!had_offset)
+				simple_offset_remove(shmem_get_offset_ctx(new_dir),
+						     new_dentry);
 			return error;
+		}
 	}
 
-	error = simple_offset_rename(old_dir, old_dentry, new_dir, new_dentry);
-	if (error)
-		return error;
-
+	simple_offset_rename(old_dir, old_dentry, new_dir, new_dentry);
 	if (d_really_is_positive(new_dentry)) {
 		(void) shmem_unlink(new_dir, new_dentry);
 		if (they_are_dirs) {
-- 
2.47.3


