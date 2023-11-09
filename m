Return-Path: <linux-fsdevel+bounces-2490-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A58F7E63C6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 07:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 534EA28165F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 06:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D17C111B2;
	Thu,  9 Nov 2023 06:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="hC2w0bY7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170C4FC10
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 06:21:03 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B7826A9
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 22:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=cvSkCD6Y5Lu7XfPcNtGN7XQGq4nsRS8djzBQjlp4Gtc=; b=hC2w0bY7JAaQTOdY/yWMdGx9Ji
	l3kSH+yW3i8djo1xUTECKVs1R8RD1FEp9Ex820mkdjFdChyILEclwlVT7uYlTXErW7f1eN6c3MMD2
	g4ir8TANnDr+j+nC3CNWo+25kC3zz0Ot5Ll52+3CUiPqFik2ZZi5wcmPwky0W6GA4vVTWYnlpSnx1
	HIKa7K4Ro+WMYG+Gik+Dcyau5eBgtviUSP1I1q3z3SGU2IxABGYEaZ0yIAR6GPuXH/wJ8XV4N9fwA
	ssnHAqEHSEEMl0/yCTfMo14FVY1wBfjGq0TrGfOy7WRY+XsUCqPAq7ZXnYWKWIjYvFzKX8mKme0h9
	N+nTfDiQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r0yPT-00DLka-0D;
	Thu, 09 Nov 2023 06:20:59 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 18/22] fold dentry_kill() into dput()
Date: Thu,  9 Nov 2023 06:20:52 +0000
Message-Id: <20231109062056.3181775-18-viro@zeniv.linux.org.uk>
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

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 37 ++++++++++++-------------------------
 1 file changed, 12 insertions(+), 25 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 801502871671..aa9f7ee7a603 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -756,28 +756,6 @@ void d_mark_dontcache(struct inode *inode)
 }
 EXPORT_SYMBOL(d_mark_dontcache);
 
-/*
- * Finish off a dentry we've decided to kill.
- * dentry->d_lock must be held, returns with it unlocked.
- * Returns dentry requiring refcount drop, or NULL if we're done.
- */
-static struct dentry *dentry_kill(struct dentry *dentry)
-	__releases(dentry->d_lock)
-{
-
-	dentry->d_lockref.count--;
-	rcu_read_lock();
-	if (likely(lock_for_kill(dentry))) {
-		struct dentry *parent = dentry->d_parent;
-		rcu_read_unlock();
-		__dentry_kill(dentry);
-		return parent != dentry ? parent : NULL;
-	}
-	rcu_read_unlock();
-	spin_unlock(&dentry->d_lock);
-	return NULL;
-}
-
 /*
  * Try to do a lockless dput(), and return whether that was successful.
  *
@@ -915,9 +893,18 @@ void dput(struct dentry *dentry)
 		}
 
 		/* Slow case: now with the dentry lock held */
-		rcu_read_unlock();
-		dentry->d_lockref.count = 1;
-		dentry = dentry_kill(dentry);
+		if (likely(lock_for_kill(dentry))) {
+			struct dentry *parent = dentry->d_parent;
+			rcu_read_unlock();
+			__dentry_kill(dentry);
+			if (dentry == parent)
+				return;
+			dentry = parent;
+		} else {
+			rcu_read_unlock();
+			spin_unlock(&dentry->d_lock);
+			return;
+		}
 	}
 }
 EXPORT_SYMBOL(dput);
-- 
2.39.2


