Return-Path: <linux-fsdevel+bounces-1689-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDC47DDC7E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 07:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 166AA281061
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 06:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E675236;
	Wed,  1 Nov 2023 06:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="n6n/YGdr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC574C6D
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 06:21:14 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B09F4
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 23:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=dULO1MrYIGKbdAvnmF64PNnJJ6Gu1Nu6TZCBBlHRCiU=; b=n6n/YGdrepzzVQEFhfkoD3ZqXA
	+rR24fzJy37d/MT6xJYm6zKB3/KMs26ap4kDdh1xG5xMqdqlgjvTCxyTYfLd82e9r3LP7EOdzbVlU
	rGu8yOj543fmaA6ZQS7awZTBJ28zMvenqQa7XAZZK/ZOMhKT+84f10YdQcGVjRoQNsjtLOSA/Ndzw
	6GBwNIxzlFOxnAxiV6ZGp7GI69d+as4hbGYaO1TTNQAGWowUVsAYj8A8OGepLv7tnOg+f8eXfsFAz
	oZeneiw8F/AfxJOYhDlPjclk8KAAWoQ6JscvHD6tEIJ67GZ4wuQjFSleWpUZlNGnNhrOXEMZA21hd
	MSNHGGjw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qy4bA-008paw-1I;
	Wed, 01 Nov 2023 06:21:04 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH 01/15] fast_dput(): having ->d_delete() is not reason to delay refcount decrement
Date: Wed,  1 Nov 2023 06:20:50 +0000
Message-Id: <20231101062104.2104951-1-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231031061226.GC1957730@ZenIV>
References: <20231031061226.GC1957730@ZenIV>
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
index 25ac74d30bff..5ec14df04f11 100644
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


