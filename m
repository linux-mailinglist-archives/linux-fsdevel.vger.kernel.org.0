Return-Path: <linux-fsdevel+bounces-3609-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0258C7F6BF9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 07:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86640B20EAD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 06:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CABBA39;
	Fri, 24 Nov 2023 06:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="SXf53u9P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A3D10DC;
	Thu, 23 Nov 2023 22:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=87MIlCCmIaOxd94yAXrGBYoVc4Rj/Kyxm+zk/qVQJ28=; b=SXf53u9Pl78qZ54zn362BHY3Iv
	SVYVUc4MqyLjILlzQN9B7dfqKIGeIjuhs+pya1X9gWtyEltTbTdNcyFJdXT+39q376/TVIafzHi5K
	ttAymuAEnduZEUwl3VgOCbAvIItw5aHVCJnIKahifzmwgSaGZXuv36p9FwiWdDP4fwXckmCOjsS0y
	6hprCPpPKLSLUdQ0Y/Nkj0eefMoH4D3R2d9dgzhQPPnnNvgkGp9X0hyuVf82uhxqP4p/yGtWfxEMq
	aK3gsxMDEzwpm5Pm+FL8chZvJ8Ac27h5WdmY+fRof/Q/76qWh0bV/1SU3Zw3sQ58G/xicT8UWX88L
	xOyTCNfQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r6PIg-002Puw-0L;
	Fri, 24 Nov 2023 06:04:26 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 16/21] fold dentry_kill() into dput()
Date: Fri, 24 Nov 2023 06:04:17 +0000
Message-Id: <20231124060422.576198-16-viro@zeniv.linux.org.uk>
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

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 37 ++++++++++++-------------------------
 1 file changed, 12 insertions(+), 25 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index a7f99d46c41b..5284b02747cd 100644
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


