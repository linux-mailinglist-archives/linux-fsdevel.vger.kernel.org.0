Return-Path: <linux-fsdevel+bounces-3618-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1076D7F6C05
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 07:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B04641F20F62
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 06:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0B84699;
	Fri, 24 Nov 2023 06:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="KZ6ZsvVD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE3410DD;
	Thu, 23 Nov 2023 22:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=mKxWUgBkshDSs4B2WASlKAmLfggYuaL+kX3Oj3+r6FU=; b=KZ6ZsvVDsZiRhl7reMm8ZU+L/m
	ScsjbK3WrOdoVz/sBBeJn/QdnvAQi/uanyqsEH0Lv5oWj6k5JPC5wCk++l2SMeUNo3TmfOEosnjje
	EI3LsEb9OE83W97PXoGQD9BwKcFsHDSePwLoZQNykjv20m0xBBUAtaZdmDUZq8cTZ74D4x6LcVGz6
	HTnjNt+71FnlM2PapgKS5hwrWs1f+238sLxqjZ4se9M50FB5EYfg36z2x1JaT15NBaThPSlbh4nYg
	MKSErjtGs9+zHS8r4FpJYweRKRkT66tCmadTm7nUpmanwLXHWVkeR4RnbfJ69Xw3OzsAyhK8THQqO
	UZc+/cLA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r6PIg-002PvH-22;
	Fri, 24 Nov 2023 06:04:26 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 19/21] d_prune_aliases(): use a shrink list
Date: Fri, 24 Nov 2023 06:04:20 +0000
Message-Id: <20231124060422.576198-19-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231124060422.576198-1-viro@zeniv.linux.org.uk>
References: <20231124060200.GR38156@ZenIV>
 <20231124060422.576198-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Instead of dropping aliases one by one, restarting, etc., just
collect them into a shrink list and kill them off in one pass.

We don't really need the restarts - one alias can't pin another
(directory has only one alias, and couldn't be its own ancestor
anyway), so collecting everything that is not busy and taking it
out would take care of everything evictable that had been there
as we entered the function.  And new aliases added while we'd
been dropping old ones could just as easily have appeared right
as we return to caller...

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 30 +++++-------------------------
 1 file changed, 5 insertions(+), 25 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index f68fe7c863e0..a3cc612a80d5 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -647,20 +647,6 @@ static struct dentry *__lock_parent(struct dentry *dentry)
 	return parent;
 }
 
-static inline struct dentry *lock_parent(struct dentry *dentry)
-{
-	struct dentry *parent = dentry->d_parent;
-	if (IS_ROOT(dentry))
-		return NULL;
-	if (likely(spin_trylock(&parent->d_lock)))
-		return parent;
-	rcu_read_lock();
-	spin_unlock(&dentry->d_lock);
-	parent = __lock_parent(dentry);
-	rcu_read_unlock();
-	return parent;
-}
-
 /*
  * Lock a dentry for feeding it to __dentry_kill().
  * Called under rcu_read_lock() and dentry->d_lock; the former
@@ -1090,24 +1076,18 @@ struct dentry *d_find_alias_rcu(struct inode *inode)
  */
 void d_prune_aliases(struct inode *inode)
 {
+	LIST_HEAD(dispose);
 	struct dentry *dentry;
-restart:
+
 	spin_lock(&inode->i_lock);
 	hlist_for_each_entry(dentry, &inode->i_dentry, d_u.d_alias) {
 		spin_lock(&dentry->d_lock);
-		if (!dentry->d_lockref.count) {
-			struct dentry *parent = lock_parent(dentry);
-			if (likely(!dentry->d_lockref.count)) {
-				__dentry_kill(dentry);
-				dput(parent);
-				goto restart;
-			}
-			if (parent)
-				spin_unlock(&parent->d_lock);
-		}
+		if (!dentry->d_lockref.count)
+			to_shrink_list(dentry, &dispose);
 		spin_unlock(&dentry->d_lock);
 	}
 	spin_unlock(&inode->i_lock);
+	shrink_dentry_list(&dispose);
 }
 EXPORT_SYMBOL(d_prune_aliases);
 
-- 
2.39.2


