Return-Path: <linux-fsdevel+bounces-1694-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A0E7DDC85
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 07:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA3E4B212C4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 06:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C4163BB;
	Wed,  1 Nov 2023 06:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="lSmNgkBD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BF95259
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 06:21:18 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525EF10D
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 23:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=zpdnSFVugoDtmYk3R2KgP33Suti6PPLm/8GkpqINmE0=; b=lSmNgkBD+li+gSyezQY7Eq4CxI
	Lr4G/yapEImmI35E+hJvEiUdkfIr2mt2wry6VQkXnw1J2o5UsxWxEQo5JfMt0GIzhdCnQ9PodPyAm
	Pch+n+ClcsK0gtl86Srlf44W94cIAJtP9hU6XuYlJ+a2XmzauTuAOh1+FnrYXNPsQR76p7cI9oBQM
	koedFHn2NeMjj0uOdYXpeL34dAdG8z2cGYwc05QtMzDFXcZ/OA7CAqCR0wkPwczzR7A3HiVFdhUhK
	9dOcd4hZil7zIxFHPBOY6DVd0CbQNYDcoZofgSmL5eMTh7t81gyjgNVeCeiaS3FZk6m/6VUpyChKv
	vzp1PkFw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qy4bB-008pbX-2T;
	Wed, 01 Nov 2023 06:21:05 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH 09/15] fold the call of retain_dentry() into fast_dput()
Date: Wed,  1 Nov 2023 06:20:58 +0000
Message-Id: <20231101062104.2104951-9-viro@zeniv.linux.org.uk>
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
index 30bebec591db..6f79d452af81 100644
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


