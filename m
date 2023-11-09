Return-Path: <linux-fsdevel+bounces-2485-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D263F7E63C2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 07:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B6C6281766
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 06:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4D110A21;
	Thu,  9 Nov 2023 06:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="cOHpkUe5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CA8101FA
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 06:21:04 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D462702
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 22:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=8JrfYu8MGPKD0zyqknMnZOhQ00UwCqeYF/nP0UHd/bQ=; b=cOHpkUe5eoF7PyczzdDMPXWYiT
	kLymMwHO8bGvBs3j6mpTObqFoGv1L2vQOPujlD8VYTp6rg9/AAJg+Ot9P9MgcJRALLJG8gl6n6RQS
	+RadjgKifpNBIfTINJS4QVlTN4CFzEDRE19RmDH2Z5kkdZJbl7KufNezYeTZ0SYpk+TweCdMdy34I
	dGeqUjRAqCCFyIoaBKH5SB4UB/+QycIlVcLuAU0V0HHBE9Mb1cIvuHA571pwkrfUtR7vRyHlbPSy4
	Q9daB92SCHPGoG06pGYkUfHc8PqLzKOXlG7nrkd8tz+mpeHCorNJu5tCVKevBOyIOzj2R8OkUqjWp
	iTAzU0oA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r0yPT-00DLkw-26;
	Thu, 09 Nov 2023 06:20:59 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 21/22] d_prune_aliases(): use a shrink list
Date: Thu,  9 Nov 2023 06:20:55 +0000
Message-Id: <20231109062056.3181775-21-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231109062056.3181775-1-viro@zeniv.linux.org.uk>
References: <20231109061932.GA3181489@ZenIV>
 <20231109062056.3181775-1-viro@zeniv.linux.org.uk>
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

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 30 +++++-------------------------
 1 file changed, 5 insertions(+), 25 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 5fdb6342f659..cea707a77e28 100644
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
@@ -1085,24 +1071,18 @@ struct dentry *d_find_alias_rcu(struct inode *inode)
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


