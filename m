Return-Path: <linux-fsdevel+bounces-3637-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 199DB7F6C22
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 07:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5CAD281A33
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 06:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27221DDC9;
	Fri, 24 Nov 2023 06:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="oXDbRqxP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6FF19A8;
	Thu, 23 Nov 2023 22:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=uud4Az9231ko7tk7A1bNl98UxSG7XErvn05RMfWl0uQ=; b=oXDbRqxPFa2x9i+aiM0FcBqE33
	qFRaKsAYytPJkAXMK5bXk18SQFZ5gqcDbt3QEOrx19Bt4UmqU1rT9SXpf0ScGLK73DRAUOmBz2Oi8
	aaoPoKm6STpjzRu/ZlpIUn8DZKBEF97fPiqlXkPjmiFFZZd/RtLCItKLIuEYLYVT+hMjeSPKaKe5u
	KDWlPmKceEbpWJRKir2RkaYPCM3XJnLln+7U4LkEvS4XxNNmVCMeoI+EApgrXAEM2NkgEcjEZMGdt
	x/AFNvtjcCYgZi16vEkd495slbaOTBhVp3V4l3Vh2AJ3Bb7do7INfTWL7T1RI1yvDz5btTMDo0LLE
	xuGjn2CQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r6PKv-002Q0n-2P;
	Fri, 24 Nov 2023 06:06:45 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 07/20] kill d_{is,set}_fallthru()
Date: Fri, 24 Nov 2023 06:06:31 +0000
Message-Id: <20231124060644.576611-7-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231124060644.576611-1-viro@zeniv.linux.org.uk>
References: <20231124060553.GA575483@ZenIV>
 <20231124060644.576611-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Introduced in 2015 and never had any in-tree users...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c            | 20 ++------------------
 include/linux/dcache.h | 17 ++++-------------
 2 files changed, 6 insertions(+), 31 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index b8f1b54a1492..9f5b2b5c1e6d 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -344,7 +344,7 @@ static inline void __d_set_inode_and_type(struct dentry *dentry,
 
 	dentry->d_inode = inode;
 	flags = READ_ONCE(dentry->d_flags);
-	flags &= ~(DCACHE_ENTRY_TYPE | DCACHE_FALLTHRU);
+	flags &= ~DCACHE_ENTRY_TYPE;
 	flags |= type_flags;
 	smp_store_release(&dentry->d_flags, flags);
 }
@@ -353,7 +353,7 @@ static inline void __d_clear_type_and_inode(struct dentry *dentry)
 {
 	unsigned flags = READ_ONCE(dentry->d_flags);
 
-	flags &= ~(DCACHE_ENTRY_TYPE | DCACHE_FALLTHRU);
+	flags &= ~DCACHE_ENTRY_TYPE;
 	WRITE_ONCE(dentry->d_flags, flags);
 	dentry->d_inode = NULL;
 	if (dentry->d_flags & DCACHE_LRU_LIST)
@@ -1936,22 +1936,6 @@ void d_set_d_op(struct dentry *dentry, const struct dentry_operations *op)
 }
 EXPORT_SYMBOL(d_set_d_op);
 
-
-/*
- * d_set_fallthru - Mark a dentry as falling through to a lower layer
- * @dentry - The dentry to mark
- *
- * Mark a dentry as falling through to the lower layer (as set with
- * d_pin_lower()).  This flag may be recorded on the medium.
- */
-void d_set_fallthru(struct dentry *dentry)
-{
-	spin_lock(&dentry->d_lock);
-	dentry->d_flags |= DCACHE_FALLTHRU;
-	spin_unlock(&dentry->d_lock);
-}
-EXPORT_SYMBOL(d_set_fallthru);
-
 static unsigned d_flags_for_inode(struct inode *inode)
 {
 	unsigned add_flags = DCACHE_REGULAR_TYPE;
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 92c0b2a1ae2e..8cd937bb2292 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -195,16 +195,15 @@ struct dentry_operations {
 #define DCACHE_LRU_LIST			BIT(19)
 
 #define DCACHE_ENTRY_TYPE		(7 << 20) /* bits 20..22 are for storing type: */
-#define DCACHE_MISS_TYPE		(0 << 20) /* Negative dentry (maybe fallthru to nowhere) */
+#define DCACHE_MISS_TYPE		(0 << 20) /* Negative dentry */
 #define DCACHE_WHITEOUT_TYPE		(1 << 20) /* Whiteout dentry (stop pathwalk) */
 #define DCACHE_DIRECTORY_TYPE		(2 << 20) /* Normal directory */
 #define DCACHE_AUTODIR_TYPE		(3 << 20) /* Lookupless directory (presumed automount) */
-#define DCACHE_REGULAR_TYPE		(4 << 20) /* Regular file type (or fallthru to such) */
-#define DCACHE_SPECIAL_TYPE		(5 << 20) /* Other file type (or fallthru to such) */
-#define DCACHE_SYMLINK_TYPE		(6 << 20) /* Symlink (or fallthru to such) */
+#define DCACHE_REGULAR_TYPE		(4 << 20) /* Regular file type */
+#define DCACHE_SPECIAL_TYPE		(5 << 20) /* Other file type */
+#define DCACHE_SYMLINK_TYPE		(6 << 20) /* Symlink */
 
 #define DCACHE_MAY_FREE			BIT(23)
-#define DCACHE_FALLTHRU			BIT(24) /* Fall through to lower layer */
 #define DCACHE_NOKEY_NAME		BIT(25) /* Encrypted name encoded without key */
 #define DCACHE_OP_REAL			BIT(26)
 
@@ -489,14 +488,6 @@ static inline int simple_positive(const struct dentry *dentry)
 	return d_really_is_positive(dentry) && !d_unhashed(dentry);
 }
 
-extern void d_set_fallthru(struct dentry *dentry);
-
-static inline bool d_is_fallthru(const struct dentry *dentry)
-{
-	return dentry->d_flags & DCACHE_FALLTHRU;
-}
-
-
 extern int sysctl_vfs_cache_pressure;
 
 static inline unsigned long vfs_pressure_ratio(unsigned long val)
-- 
2.39.2


