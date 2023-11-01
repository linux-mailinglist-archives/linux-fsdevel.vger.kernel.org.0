Return-Path: <linux-fsdevel+bounces-1703-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 572D77DDC8C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 07:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC7F8B21151
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 06:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772A8525D;
	Wed,  1 Nov 2023 06:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="i1Seu3Z3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE92525C
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 06:21:18 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0940B10C
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 23:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Lkp+2fm9lMJNrMAa25F2i48vZRPL8r1UmkUGziNmOMk=; b=i1Seu3Z39FiN0LqmCJDhmuxVTk
	nZ5P8VhCQ2wI1EYv5IUNZhq5gXm+F0H/35tEW16hP0zMmNETuL4Zv3t8RFAYzevONIngYEmefzGvu
	FgaZpqlmpWbBpraR8D31vi0ZKUf1JemILnzl4cR7o4i/+feNWyQgQdkdFaSHFQGlGbH2xpdSmFJ6C
	7d6ai8BuQJbnb+JoXFWtZZ9eRJr+ZyNbjT191AB9ivwPYTLcXj4Z1ApdiGrO8XLtesE3ghLziHwtq
	03YD9fFR6wFc8Ji1rW3qwlq/rFYDZ12KvZqfd5YB37c5WEMqRPZvlEbHAlxDa9dMhO6Cjzrd3bP4o
	9QgK/5lQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qy4bB-008pbT-2A;
	Wed, 01 Nov 2023 06:21:05 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH 08/15] Call retain_dentry() with refcount 0
Date: Wed,  1 Nov 2023 06:20:57 +0000
Message-Id: <20231101062104.2104951-8-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231101062104.2104951-1-viro@zeniv.linux.org.uk>
References: <20231031061226.GC1957730@ZenIV>
 <20231101062104.2104951-1-viro@zeniv.linux.org.uk>
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
 fs/dcache.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 7931f5108581..30bebec591db 100644
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


