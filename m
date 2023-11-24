Return-Path: <linux-fsdevel+bounces-3607-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E26D97F6BF4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 07:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A9AC1F20F5B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 06:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345F7B647;
	Fri, 24 Nov 2023 06:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="iVjIbodx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C15F10CA;
	Thu, 23 Nov 2023 22:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=mZvJUgRxfEvEdrlH7O9TVKc6h6Mv5I6q24XfY7mIkN4=; b=iVjIbodxYD/q7Nt0AI5CVAWDi9
	9D4i/vvHdj99R4D+9xtBtQnfNZmvX8Tgro9c8SdXIqnwcuZwgiy+6V8sCONBmXLkomc+0N7R/xwQC
	W0dHfK1fWGjT9qbcF1lzTuruayGDq7yaPZTIpWLnPJDSNJuI7iv1Mm6zVGYdYnme51Ymh0Am0jH0z
	VNv07AUe6zq0gyaYAqGLB9AS3AhIzJRdWTniFeBheMmGG5OrgATfN0+hu7bGUyIUDYELMVocEmmPE
	WrF+LgaBERkJM5OzgeQM9rnMmJA8lJizNthhoHXWMkCM/XBPHJvgC3VxW1V6Zaa7qsKvPN3I9UcXn
	dz0T0wLw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r6PId-002PuL-2q;
	Fri, 24 Nov 2023 06:04:24 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 10/21] make retain_dentry() neutral with respect to refcounting
Date: Fri, 24 Nov 2023 06:04:11 +0000
Message-Id: <20231124060422.576198-10-viro@zeniv.linux.org.uk>
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

retain_dentry() used to decrement refcount if and only if it returned
true.  Lift those decrements into the callers.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 0718b3895c12..2e74f3f2ce2e 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -680,7 +680,6 @@ static inline bool retain_dentry(struct dentry *dentry)
 		return false;
 
 	/* retain; LRU fodder */
-	dentry->d_lockref.count--;
 	if (unlikely(!(dentry->d_flags & DCACHE_LRU_LIST)))
 		d_lru_add(dentry);
 	else if (unlikely(!(dentry->d_flags & DCACHE_REFERENCED)))
@@ -744,6 +743,8 @@ static struct dentry *dentry_kill(struct dentry *dentry)
 	} else if (likely(!retain_dentry(dentry))) {
 		__dentry_kill(dentry);
 		return parent;
+	} else {
+		dentry->d_lockref.count--;
 	}
 	/* we are keeping it, after all */
 	if (inode)
@@ -893,6 +894,7 @@ void dput(struct dentry *dentry)
 		rcu_read_unlock();
 
 		if (likely(retain_dentry(dentry))) {
+			dentry->d_lockref.count--;
 			spin_unlock(&dentry->d_lock);
 			return;
 		}
@@ -925,6 +927,8 @@ void dput_to_list(struct dentry *dentry, struct list_head *list)
 	if (!retain_dentry(dentry)) {
 		--dentry->d_lockref.count;
 		to_shrink_list(dentry, list);
+	} else {
+		--dentry->d_lockref.count;
 	}
 	spin_unlock(&dentry->d_lock);
 }
-- 
2.39.2


