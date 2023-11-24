Return-Path: <linux-fsdevel+bounces-3623-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 788427F6C14
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 07:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32B4628199E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 06:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CEEB8F63;
	Fri, 24 Nov 2023 06:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="UBrbvawT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8964C10;
	Thu, 23 Nov 2023 22:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Xmww8r5ig2fUYT59ftS8BPHn7cU0Mxl+K2HS3DJQsIo=; b=UBrbvawTihhsVHqYYAoI1O1DJ/
	1wflT1cuHwCnclxm7b2lOtJUQ+s8g6swpeQoROE/HANQGH/ma4ajem3sxNmhQSpEESLKGgx7Ilj+e
	Y0scL/zC35jy4tSWIZNCu0fkZ341Xy0x7Kmt6FjKq/boBR8fciJHPVO2WUcmEC8zrYNHwrnRf9anl
	92w5S/3UdVqeAt8jskuDHzUsdu+fNQDeWZsSa6q/WkUP+wqiFpW7Kb5JEHG9O7hODs5dKafg0mxJj
	XzN2JcAGVxuX9n73vASm7+ZlIyrKWpFwpgJS00dsh6ingd4AEaozc2zN4mF5awbp7ZVWgA4O9KXFg
	sA0ciZaA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r6PKw-002Q17-1D;
	Fri, 24 Nov 2023 06:06:46 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 11/20] kill d_instantate_anon(), fold __d_instantiate_anon() into remaining caller
Date: Fri, 24 Nov 2023 06:06:35 +0000
Message-Id: <20231124060644.576611-11-viro@zeniv.linux.org.uk>
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

now that the only user of d_instantiate_anon() is gone...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c            | 88 ++++++++++++++++--------------------------
 include/linux/dcache.h |  1 -
 2 files changed, 33 insertions(+), 56 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 9f5b2b5c1e6d..6dde21dbdd1a 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2054,75 +2054,53 @@ struct dentry *d_make_root(struct inode *root_inode)
 }
 EXPORT_SYMBOL(d_make_root);
 
-static struct dentry *__d_instantiate_anon(struct dentry *dentry,
-					   struct inode *inode,
-					   bool disconnected)
-{
-	struct dentry *res;
-	unsigned add_flags;
-
-	security_d_instantiate(dentry, inode);
-	spin_lock(&inode->i_lock);
-	res = __d_find_any_alias(inode);
-	if (res) {
-		spin_unlock(&inode->i_lock);
-		dput(dentry);
-		goto out_iput;
-	}
-
-	/* attach a disconnected dentry */
-	add_flags = d_flags_for_inode(inode);
-
-	if (disconnected)
-		add_flags |= DCACHE_DISCONNECTED;
-
-	spin_lock(&dentry->d_lock);
-	__d_set_inode_and_type(dentry, inode, add_flags);
-	hlist_add_head(&dentry->d_u.d_alias, &inode->i_dentry);
-	if (!disconnected) {
-		hlist_bl_lock(&dentry->d_sb->s_roots);
-		hlist_bl_add_head(&dentry->d_hash, &dentry->d_sb->s_roots);
-		hlist_bl_unlock(&dentry->d_sb->s_roots);
-	}
-	spin_unlock(&dentry->d_lock);
-	spin_unlock(&inode->i_lock);
-
-	return dentry;
-
- out_iput:
-	iput(inode);
-	return res;
-}
-
-struct dentry *d_instantiate_anon(struct dentry *dentry, struct inode *inode)
-{
-	return __d_instantiate_anon(dentry, inode, true);
-}
-EXPORT_SYMBOL(d_instantiate_anon);
-
 static struct dentry *__d_obtain_alias(struct inode *inode, bool disconnected)
 {
-	struct dentry *tmp;
-	struct dentry *res;
+	struct super_block *sb = inode->i_sb;
+	struct dentry *new, *res;
 
 	if (!inode)
 		return ERR_PTR(-ESTALE);
 	if (IS_ERR(inode))
 		return ERR_CAST(inode);
 
-	res = d_find_any_alias(inode);
+	res = d_find_any_alias(inode); /* existing alias? */
 	if (res)
-		goto out_iput;
+		goto out;
 
-	tmp = d_alloc_anon(inode->i_sb);
-	if (!tmp) {
+	new = d_alloc_anon(sb);
+	if (!new) {
 		res = ERR_PTR(-ENOMEM);
-		goto out_iput;
+		goto out;
 	}
 
-	return __d_instantiate_anon(tmp, inode, disconnected);
+	security_d_instantiate(new, inode);
+	spin_lock(&inode->i_lock);
+	res = __d_find_any_alias(inode); /* recheck under lock */
+	if (likely(!res)) { /* still no alias, attach a disconnected dentry */
+		unsigned add_flags = d_flags_for_inode(inode);
+
+		if (disconnected)
+			add_flags |= DCACHE_DISCONNECTED;
+
+		spin_lock(&new->d_lock);
+		__d_set_inode_and_type(new, inode, add_flags);
+		hlist_add_head(&new->d_u.d_alias, &inode->i_dentry);
+		if (!disconnected) {
+			hlist_bl_lock(&sb->s_roots);
+			hlist_bl_add_head(&new->d_hash, &sb->s_roots);
+			hlist_bl_unlock(&sb->s_roots);
+		}
+		spin_unlock(&new->d_lock);
+		spin_unlock(&inode->i_lock);
+		inode = NULL; /* consumed by new->d_inode */
+		res = new;
+	} else {
+		spin_unlock(&inode->i_lock);
+		dput(new);
+	}
 
-out_iput:
+ out:
 	iput(inode);
 	return res;
 }
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index fa0414cff85c..8c5e3bdf1147 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -218,7 +218,6 @@ extern seqlock_t rename_lock;
  */
 extern void d_instantiate(struct dentry *, struct inode *);
 extern void d_instantiate_new(struct dentry *, struct inode *);
-extern struct dentry * d_instantiate_anon(struct dentry *, struct inode *);
 extern void __d_drop(struct dentry *dentry);
 extern void d_drop(struct dentry *dentry);
 extern void d_delete(struct dentry *);
-- 
2.39.2


