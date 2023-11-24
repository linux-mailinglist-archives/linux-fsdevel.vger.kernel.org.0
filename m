Return-Path: <linux-fsdevel+bounces-3600-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1DF7F6BEB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 07:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CC251C209C0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 06:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445128F63;
	Fri, 24 Nov 2023 06:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="RVHwwP0l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C46B10C2;
	Thu, 23 Nov 2023 22:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=NNW7eyzMcI2LQ3OolbCUFLUMx0n0E1owvlb4SGLrw/w=; b=RVHwwP0loCq6wICs5dQMVN4Ati
	oHq0j5R1MyYh3PzyNWZQog0WFqNxD/Bl8na6R6SmYUG4xbW0kqMWhtWw769z/r0gLcsEgTZ1ezO/s
	oeMGR6EWm8ba+OpafSYW9F8pRWVUhxJ8KcJgEbx+La3WtEbMTTTC6XDE+7huTeejVXM6fNVsqc4Tg
	puf4o8ku8+7NYiM+vW5vcW94uqsCqs8VJ8iCddHFb8Kbc4m+g4fvjg0XidMWxC5eKVVfnGggnmhCr
	WojB5qfWup0FdHoPnXLqYJNZuvLRFm/R+p/uUY6oSZXFnzN697BmFSGYpLnsnvHnC4T66MWlorAI2
	fzCK4anA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r6PId-002Ptr-0H;
	Fri, 24 Nov 2023 06:04:23 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 05/21] shrink_dentry_list(): no need to check that dentry refcount is marked dead
Date: Fri, 24 Nov 2023 06:04:06 +0000
Message-Id: <20231124060422.576198-5-viro@zeniv.linux.org.uk>
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

... we won't see DCACHE_MAY_FREE on anything that is *not* dead
and checking d_flags is just as cheap as checking refcount.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index bb862a304e1b..c1025921f8d3 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1191,11 +1191,10 @@ void shrink_dentry_list(struct list_head *list)
 		spin_lock(&dentry->d_lock);
 		rcu_read_lock();
 		if (!shrink_lock_dentry(dentry)) {
-			bool can_free = false;
+			bool can_free;
 			rcu_read_unlock();
 			d_shrink_del(dentry);
-			if (dentry->d_lockref.count < 0)
-				can_free = dentry->d_flags & DCACHE_MAY_FREE;
+			can_free = dentry->d_flags & DCACHE_MAY_FREE;
 			spin_unlock(&dentry->d_lock);
 			if (can_free)
 				dentry_free(dentry);
-- 
2.39.2


