Return-Path: <linux-fsdevel+bounces-2484-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6947E63C1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 07:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70D35281686
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 06:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7018B10A10;
	Thu,  9 Nov 2023 06:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="SYyU9Jw9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0D9F9EE
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 06:21:03 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F14B26BE
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 22:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=wC5MrqC19y5tPs0/NQr3BfdHwd4jtwlwzmqo3EzkzDU=; b=SYyU9Jw9tKUj6N3p1RUdVLp0S3
	Vy895DrsQ+kDJ2wYrki76kCxiCZmDXitdt07ANUslfx6YxHwMfmA6y8W87UeP5PmtuJ/N+qHnKBdw
	qhQ1oTlo4nX1suIPQTol2fXt1YFRcEMYOYTep6N+Fwn4rDJFKk1XP+e13CfBNjfPP+/rBAbESc/Z0
	VY29JM9Y8TA2hmnsZfimuS0SFwLnSGIpgEH37W8A3Kwd6Z1su4sKWjfmBHPAMH7BhbtLu/KJj3bHX
	PaX2e9AFRSen6qLvQqcf0ZVXPg6TgXCLqyefMZtuOP0lIshAss+nH8Un+WK0sxYxYzfJWT/zqpv0j
	S8FfD04g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r0yPS-00DLkQ-2U;
	Thu, 09 Nov 2023 06:20:58 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 16/22] fold the call of retain_dentry() into fast_dput()
Date: Thu,  9 Nov 2023 06:20:50 +0000
Message-Id: <20231109062056.3181775-16-viro@zeniv.linux.org.uk>
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

Calls of retain_dentry() happen immediately after getting false
from fast_dput() and getting true from retain_dentry() is
treated the same way as non-zero refcount would be treated by
fast_dput() - unlock dentry and bugger off.

Doing that in fast_dput() itself is simpler.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 3179156e0ad9..23afcd48c1a9 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -757,6 +757,8 @@ static struct dentry *dentry_kill(struct dentry *dentry)
  * Try to do a lockless dput(), and return whether that was successful.
  *
  * If unsuccessful, we return false, having already taken the dentry lock.
+ * In that case refcount is guaranteed to be zero and we have already
+ * decided that it's not worth keeping around.
  *
  * The caller needs to hold the RCU read lock, so that the dentry is
  * guaranteed to stay around even if the refcount goes down to zero!
@@ -842,7 +844,7 @@ static inline bool fast_dput(struct dentry *dentry)
 	 * don't need to do anything else.
 	 */
 locked:
-	if (dentry->d_lockref.count) {
+	if (dentry->d_lockref.count || retain_dentry(dentry)) {
 		spin_unlock(&dentry->d_lock);
 		return true;
 	}
@@ -889,12 +891,6 @@ void dput(struct dentry *dentry)
 
 		/* Slow case: now with the dentry lock held */
 		rcu_read_unlock();
-
-		if (likely(retain_dentry(dentry))) {
-			spin_unlock(&dentry->d_lock);
-			return;
-		}
-
 		dentry->d_lockref.count = 1;
 		dentry = dentry_kill(dentry);
 	}
@@ -920,8 +916,7 @@ void dput_to_list(struct dentry *dentry, struct list_head *list)
 		return;
 	}
 	rcu_read_unlock();
-	if (!retain_dentry(dentry))
-		to_shrink_list(dentry, list);
+	to_shrink_list(dentry, list);
 	spin_unlock(&dentry->d_lock);
 }
 
-- 
2.39.2


