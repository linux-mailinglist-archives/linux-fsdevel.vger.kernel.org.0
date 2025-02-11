Return-Path: <linux-fsdevel+bounces-41505-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B29CA306F2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 10:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E12271889BC0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2025 09:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5931F130D;
	Tue, 11 Feb 2025 09:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="sxQ81AtR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338911E4106;
	Tue, 11 Feb 2025 09:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739265973; cv=none; b=mJW4w6Xx3Ka4rzbdBQdLUG37OAYNBJyiGgjmoSJsEMI5pW4aMAp40fyEve4OaqZzITRQCgjpA2bUMusH9e/ndh3EYURLvsLYd1wlNL18ciG1J1zoEzZf2pktDNvSS93UzSUOQsTlAnOsMyw462S3xHxIYkfVh4x7CNaPjwBA5Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739265973; c=relaxed/simple;
	bh=0/6SlMvqxzhB7Qlw/3nmpge/TZTMVnJdiiMq8WXc0i8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EC5EA0YiGghmUNeY0UHQOrHHK4BXI4kCUeAFRvH1qPV2d8UjtPy0g18OsqWMqEOZXuol936JGwIzKj1fJefUI61BmLypjz3GQ/0YRotOeQd782GlhyYVeGMU8iwfJPt685PCwVVwiZ5hQuoWuE3SpLOjYtjGMbr0cAVU8mLpNxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=sxQ81AtR; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=OEfvOJJA+O1fPUax0iJ9whI9+BMjOivJ72Lg/TWzn/c=; b=sxQ81AtRIcHkT5S5isVmbl9i1l
	4ACoSmRN5Oz/c4UHiaRF87Fc+eBzKGLsLThI5d8CkCQtPw8fl8pI6nNZEAygpHZa2rhdEwRRBp6RV
	UJXwY9E1At0p3CKxM3m7K1fcYuaAkTJGMi2Ckh5kuXrntl/Ne4bcJTKW2mSbKtfcPT5F3iifUkzXC
	dib8gh3SEVkbL4llbbd7TwiudA6yRhcbeXAnHIWLnofntoVkFSwILF/XIC1/JFmCWKfGcHSMpyfZM
	poO/CwB4UCEtFXb90HUMpJAJdAZMIT/X93GyRtm0OdOy2H9Ts3S2TIdORqLGR53nuIhaBlgUlXK7P
	gaC3O9sw==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1thmWm-007fB4-3W; Tue, 11 Feb 2025 10:26:05 +0100
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matt Harvey <mharvey@jumptrading.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Luis Henriques <luis@igalia.com>
Subject: [PATCH v4] fuse: add new function to invalidate cache for all inodes
Date: Tue, 11 Feb 2025 09:26:04 +0000
Message-ID: <20250211092604.15160-1-luis@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently userspace is able to notify the kernel to invalidate the cache
for an inode.  This means that, if all the inodes in a filesystem need to
be invalidated, then userspace needs to iterate through all of them and do
this kernel notification separately.

This patch adds a new option that allows userspace to invalidate all the
inodes with a single notification operation.  In addition to invalidate
all the inodes, it also shrinks the sb dcache.

Signed-off-by: Luis Henriques <luis@igalia.com>
---
* Changes since v3
- Added comments to clarify semantic changes in fuse_reverse_inval_inode()
  when called with FUSE_INVAL_ALL_INODES (suggested by Bernd).
- Added comments to inodes iteration loop to clarify __iget/iput usage
  (suggested by Joanne)
- Dropped get_fuse_mount() call -- fuse_mount can be obtained from
  fuse_ilookup() directly (suggested by Joanne)

(Also dropped the RFC from the subject.)

* Changes since v2
- Use the new helper from fuse_reverse_inval_inode(), as suggested by Bernd.
- Also updated patch description as per checkpatch.pl suggestion.

* Changes since v1
As suggested by Bernd, this patch v2 simply adds an helper function that
will make it easier to replace most of it's code by a call to function
super_iter_inodes() when Dave Chinner's patch[1] eventually gets merged.

[1] https://lore.kernel.org/r/20241002014017.3801899-3-david@fromorbit.com

 fs/fuse/inode.c           | 83 +++++++++++++++++++++++++++++++++++----
 include/uapi/linux/fuse.h |  3 ++
 2 files changed, 79 insertions(+), 7 deletions(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index e9db2cb8c150..5aa49856731a 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -547,25 +547,94 @@ struct inode *fuse_ilookup(struct fuse_conn *fc, u64 nodeid,
 	return NULL;
 }
 
+static void inval_single_inode(struct inode *inode, struct fuse_conn *fc)
+{
+	struct fuse_inode *fi;
+
+	fi = get_fuse_inode(inode);
+	spin_lock(&fi->lock);
+	fi->attr_version = atomic64_inc_return(&fc->attr_version);
+	spin_unlock(&fi->lock);
+	fuse_invalidate_attr(inode);
+	forget_all_cached_acls(inode);
+}
+
+static int fuse_reverse_inval_all(struct fuse_conn *fc)
+{
+	struct fuse_mount *fm;
+	struct super_block *sb;
+	struct inode *inode, *old_inode = NULL;
+
+	inode = fuse_ilookup(fc, FUSE_ROOT_ID, &fm);
+	if (!inode || !fm)
+		return -ENOENT;
+
+	iput(inode);
+	sb = fm->sb;
+
+	spin_lock(&sb->s_inode_list_lock);
+	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
+		spin_lock(&inode->i_lock);
+		if ((inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW)) ||
+		    !atomic_read(&inode->i_count)) {
+			spin_unlock(&inode->i_lock);
+			continue;
+		}
+
+		/*
+		 * This __iget()/iput() dance is required so that we can release
+		 * the sb lock and continue the iteration on the previous
+		 * inode.  If we don't keep a ref to the old inode it could have
+		 * disappear.  This way we can safely call cond_resched() when
+		 * there's a huge amount of inodes to iterate.
+		 */
+		__iget(inode);
+		spin_unlock(&inode->i_lock);
+		spin_unlock(&sb->s_inode_list_lock);
+		iput(old_inode);
+
+		inval_single_inode(inode, fc);
+
+		old_inode = inode;
+		cond_resched();
+		spin_lock(&sb->s_inode_list_lock);
+	}
+	spin_unlock(&sb->s_inode_list_lock);
+	iput(old_inode);
+
+	shrink_dcache_sb(sb);
+
+	return 0;
+}
+
+/*
+ * Notify to invalidate inodes cache.  It can be called with @nodeid set to
+ * either:
+ *
+ * - An inode number - Any pending writebacks within the rage [@offset @len]
+ *   will be triggered and the inode will be validated.  To invalidate the whole
+ *   cache @offset has to be set to '0' and @len needs to be <= '0'; if @offset
+ *   is negative, only the inode attributes are invalidated.
+ *
+ * - FUSE_INVAL_ALL_INODES - All the inodes in the superblock are invalidated
+ *   and the whole dcache is shrinked.
+ */
 int fuse_reverse_inval_inode(struct fuse_conn *fc, u64 nodeid,
 			     loff_t offset, loff_t len)
 {
-	struct fuse_inode *fi;
 	struct inode *inode;
 	pgoff_t pg_start;
 	pgoff_t pg_end;
 
+	if (nodeid == FUSE_INVAL_ALL_INODES)
+		return fuse_reverse_inval_all(fc);
+
 	inode = fuse_ilookup(fc, nodeid, NULL);
 	if (!inode)
 		return -ENOENT;
 
-	fi = get_fuse_inode(inode);
-	spin_lock(&fi->lock);
-	fi->attr_version = atomic64_inc_return(&fc->attr_version);
-	spin_unlock(&fi->lock);
+	inval_single_inode(inode, fc);
 
-	fuse_invalidate_attr(inode);
-	forget_all_cached_acls(inode);
 	if (offset >= 0) {
 		pg_start = offset >> PAGE_SHIFT;
 		if (len <= 0)
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 5e0eb41d967e..e5852b63f99f 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -669,6 +669,9 @@ enum fuse_notify_code {
 	FUSE_NOTIFY_CODE_MAX,
 };
 
+/* The nodeid to request to invalidate all inodes */
+#define FUSE_INVAL_ALL_INODES 0
+
 /* The read buffer is required to be at least 8k, but may be much larger */
 #define FUSE_MIN_READ_BUFFER 8192
 

