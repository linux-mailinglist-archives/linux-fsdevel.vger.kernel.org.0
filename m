Return-Path: <linux-fsdevel+bounces-2486-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFBE67E63C3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 07:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 919B92815ED
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 06:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93BD10A35;
	Thu,  9 Nov 2023 06:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="rTL3odkZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE95F9E6
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 06:21:03 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB1826BD
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 22:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=LRStAQRG1xPuZNqdA9lfkj9lOCP32UT35l5hG/N2K/Q=; b=rTL3odkZa+UVc+nferHu3Z+go1
	KWH4cj5uvumPjMCkJNOU8f2+Cl7fGVZw3VF0JIcdeMkxTQv2Qz0KR9jP4qiPhC96DE6mzvSt3E2Lg
	KclYUyEl9CfVWM2VmYd8LaR12IrM2xIVuteApL91DdxhpQ7i+KAyyHpI3vAv1TEIOMwCm8K5vciIa
	jEd73SuB3L1MQ8TAiyONfiwl4VJN27l853JjE3CyD40D3hIu2yqfNN+PugRaRDc80E4nljJGFVxlB
	wxno7Ic7/kBr88bhTTPy6Xi6gLGq5vOIuVxLN6l1xDcb+SInbJJqoicumlxOwYEWHeIqBbHn0XcLb
	wmOERhyg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r0yPS-00DLkM-24;
	Thu, 09 Nov 2023 06:20:58 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 15/22] Call retain_dentry() with refcount 0
Date: Thu,  9 Nov 2023 06:20:49 +0000
Message-Id: <20231109062056.3181775-15-viro@zeniv.linux.org.uk>
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

Instead of bumping it from 0 to 1, calling retain_dentry(), then
decrementing it back to 0 (with ->d_lock held all the way through),
just leave refcount at 0 through all of that.

It will have a visible effect for ->d_delete() - now it can be
called with refcount 0 instead of 1 and it can no longer play
silly buggers with dropping/regaining ->d_lock.  Not that any
in-tree instances tried to (it's pretty hard to get right).

Any out-of-tree ones will have to adjust (assuming they need any
changes).

Note that we do not need to extend rcu-critical area here - we have
verified that refcount is non-negative after having grabbed ->d_lock,
so nobody will be able to free dentry until they get into __dentry_kill(),
which won't happen until they manage to grab ->d_lock.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 Documentation/filesystems/porting.rst |  8 ++++++++
 fs/dcache.c                           | 10 ++--------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 58627f0baf3e..6b058362938c 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -1054,3 +1054,11 @@ The list of children anchored in parent dentry got turned into hlist now.
 Field names got changed (->d_children/->d_sib instead of ->d_subdirs/->d_child
 for anchor/entries resp.), so any affected places will be immediately caught
 by compiler.
+
+---
+
+**mandatory**
+
+	->d_delete() instances are now called for dentries with ->d_lock held
+and refcount equal to 0.  They are not permitted to drop/regain ->d_lock.
+None of in-tree instances did anything of that sort.  Make sure yours do not...
diff --git a/fs/dcache.c b/fs/dcache.c
index 916b978bfd98..3179156e0ad9 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -888,15 +888,14 @@ void dput(struct dentry *dentry)
 		}
 
 		/* Slow case: now with the dentry lock held */
-		dentry->d_lockref.count = 1;
 		rcu_read_unlock();
 
 		if (likely(retain_dentry(dentry))) {
-			dentry->d_lockref.count--;
 			spin_unlock(&dentry->d_lock);
 			return;
 		}
 
+		dentry->d_lockref.count = 1;
 		dentry = dentry_kill(dentry);
 	}
 }
@@ -921,13 +920,8 @@ void dput_to_list(struct dentry *dentry, struct list_head *list)
 		return;
 	}
 	rcu_read_unlock();
-	dentry->d_lockref.count = 1;
-	if (!retain_dentry(dentry)) {
-		--dentry->d_lockref.count;
+	if (!retain_dentry(dentry))
 		to_shrink_list(dentry, list);
-	} else {
-		--dentry->d_lockref.count;
-	}
 	spin_unlock(&dentry->d_lock);
 }
 
-- 
2.39.2


