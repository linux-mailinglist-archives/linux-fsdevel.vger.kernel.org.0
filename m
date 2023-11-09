Return-Path: <linux-fsdevel+bounces-2475-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EA07E63B7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 07:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F05A0281274
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 06:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01224101F4;
	Thu,  9 Nov 2023 06:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="YlaEhQIc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC46D51B
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 06:21:00 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D5426B5
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 22:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=dLo5pAAV7Npze4hue4nwU/De/4gQdpB3djuF9lnNgJE=; b=YlaEhQIc2ScoxzT6Cj5igZW8Qo
	c7SmAWUI3/+4RBnRFY4DaUzi1tkQ3GCHbm7oDtezkEi8boSbxXRUGCCd6mtWHozM4Snml4XI+nuQa
	G9967cgSkJJuq3jsmdT1dti3o8P2JLl7XkEz8LtPuEKN0D8DWiTWIngaYwjYB+7ejQp3+Xh1dV3sg
	NdiCXBwqjcHdeiST/Fetaa5orZBpp43kfBQsCusdWKs3IFu2C/QGSdIx/A++TR5+WlucZudyflJHP
	PXSQV2g31k7RuXdw1oI0Qj6QwcuKbGJtYvT1FlU7GYr4TTJ42fiXIF7kdZM0wvCLT7zMcfgfjozGL
	0BVvTxzQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r0yPR-00DLjb-1H;
	Thu, 09 Nov 2023 06:20:57 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 08/22] fast_dput(): having ->d_delete() is not reason to delay refcount decrement
Date: Thu,  9 Nov 2023 06:20:42 +0000
Message-Id: <20231109062056.3181775-8-viro@zeniv.linux.org.uk>
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

->d_delete() is a way for filesystem to tell that dentry is not worth
keeping cached.  It is not guaranteed to be called every time a dentry
has refcount drop down to zero; it is not guaranteed to be called before
dentry gets evicted.  In other words, it is not suitable for any kind
of keeping track of dentry state.

None of the in-tree filesystems attempt to use it that way, fortunately.

So the contortions done by fast_dput() (as well as dentry_kill()) are
not warranted.  fast_dput() certainly should treat having ->d_delete()
instance as "can't assume we'll be keeping it", but that's not different
from the way we treat e.g. DCACHE_DONTCACHE (which is rather similar
to making ->d_delete() returns true when called).

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 5371f32eb4bb..0d15e8852ac1 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -768,15 +768,7 @@ static inline bool fast_dput(struct dentry *dentry)
 	unsigned int d_flags;
 
 	/*
-	 * If we have a d_op->d_delete() operation, we sould not
-	 * let the dentry count go to zero, so use "put_or_lock".
-	 */
-	if (unlikely(dentry->d_flags & DCACHE_OP_DELETE))
-		return lockref_put_or_lock(&dentry->d_lockref);
-
-	/*
-	 * .. otherwise, we can try to just decrement the
-	 * lockref optimistically.
+	 * try to decrement the lockref optimistically.
 	 */
 	ret = lockref_put_return(&dentry->d_lockref);
 
@@ -830,7 +822,7 @@ static inline bool fast_dput(struct dentry *dentry)
 	 */
 	smp_rmb();
 	d_flags = READ_ONCE(dentry->d_flags);
-	d_flags &= DCACHE_REFERENCED | DCACHE_LRU_LIST |
+	d_flags &= DCACHE_REFERENCED | DCACHE_LRU_LIST | DCACHE_OP_DELETE |
 			DCACHE_DISCONNECTED | DCACHE_DONTCACHE;
 
 	/* Nothing to do? Dropping the reference was all we needed? */
-- 
2.39.2


