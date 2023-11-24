Return-Path: <linux-fsdevel+bounces-3601-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 964637F6BEC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 07:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C57711C20D24
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 06:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A73D8F67;
	Fri, 24 Nov 2023 06:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="MLII4i6g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D15DD68;
	Thu, 23 Nov 2023 22:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=0tQBbiZlI24neTVN15zbLpMxjHiF2IHNOLvdhPYA7ZM=; b=MLII4i6gunvW4TyTnwYmnWFHAQ
	CiK80snCVMQ2Kx3j1JznykIfbeMxFzTrCb6/SH0lI1pWhsJmU/5zrKcvh2eTFaggxTk2GRi78uprH
	3XEfkcpX2oJaJ9V9ZEpuHSGzCzRXI1ddIov9+ObRNIWSJkErrEQr0hQvAyI1eUOk0sy9T0DSQ54BE
	LGud80p9XsKJScHtaBZDXJ3lMwgJhz1qedBIUG0hapGTHZi8AjrQwCCvuaV+OaB6uFYVInZf+gw7j
	U5vmOXvLmqkZDq8eWHJGsUiqTYKwqg9VqETnTOsNZacpeVSoPrEAfowIeTB1x0EXYVSu64BdE4Dsj
	8JLMEfMw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r6PId-002Ptv-0c;
	Fri, 24 Nov 2023 06:04:23 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 06/21] fast_dput(): having ->d_delete() is not reason to delay refcount decrement
Date: Fri, 24 Nov 2023 06:04:07 +0000
Message-Id: <20231124060422.576198-6-viro@zeniv.linux.org.uk>
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

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index c1025921f8d3..00c19041adf3 100644
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


