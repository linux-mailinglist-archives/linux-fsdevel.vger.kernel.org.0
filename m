Return-Path: <linux-fsdevel+bounces-2479-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 683037E63BC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 07:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC6E62811CE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 06:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF373107AD;
	Thu,  9 Nov 2023 06:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="dkA6p3XF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEE9DF4C
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 06:21:02 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425A626B9
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 22:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Hu+eUF8RnXwLM8LdMLlLxA8gtrHEF5yGM0R5rTsJysg=; b=dkA6p3XF0T2Bj5I0umdl6QtXAC
	1Sth58bFEi7uAO5rw1at1xmPUDYKXre+m1TK8peBc3v293WIVjVaTXHggeMiMMQDnjB6Vneug4qTE
	kwj3mezI+zqWgteSJV580xG0qs1W8spkD7dyPp1MOorSR4GOtO2nBX0dDneTaJvgwcmL2Uyijqg8u
	pRz8zoCYUt34y96XFzUT5JzTG0WICjrVWjwV/uTHNtU3dwX8qoqBAa/WeDxIIB/K2hR3tlPzJPp/g
	Jwu05AKUeFhXReSQlBUO6MRpJuq2sMySDTsQP7JrxuVJY+VbsptqqBL8r9PdvUz6fwucA2BHOlcNG
	ZkGZAXBw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r0yPR-00DLju-2t;
	Thu, 09 Nov 2023 06:20:57 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 11/22] __dput_to_list(): do decrement of refcount in the callers
Date: Thu,  9 Nov 2023 06:20:45 +0000
Message-Id: <20231109062056.3181775-11-viro@zeniv.linux.org.uk>
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

... and rename it to to_shrink_list(), seeing that it no longer
does dropping any references

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 9a3eeee02500..1899376d0189 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -902,16 +902,13 @@ void dput(struct dentry *dentry)
 }
 EXPORT_SYMBOL(dput);
 
-static void __dput_to_list(struct dentry *dentry, struct list_head *list)
+static void to_shrink_list(struct dentry *dentry, struct list_head *list)
 __must_hold(&dentry->d_lock)
 {
-	if (dentry->d_flags & DCACHE_SHRINK_LIST) {
-		/* let the owner of the list it's on deal with it */
-		--dentry->d_lockref.count;
-	} else {
+	if (!(dentry->d_flags & DCACHE_SHRINK_LIST)) {
 		if (dentry->d_flags & DCACHE_LRU_LIST)
 			d_lru_del(dentry);
-		if (!--dentry->d_lockref.count)
+		if (!dentry->d_lockref.count)
 			d_shrink_add(dentry, list);
 	}
 }
@@ -925,8 +922,10 @@ void dput_to_list(struct dentry *dentry, struct list_head *list)
 	}
 	rcu_read_unlock();
 	dentry->d_lockref.count = 1;
-	if (!retain_dentry(dentry))
-		__dput_to_list(dentry, list);
+	if (!retain_dentry(dentry)) {
+		--dentry->d_lockref.count;
+		to_shrink_list(dentry, list);
+	}
 	spin_unlock(&dentry->d_lock);
 }
 
@@ -1160,8 +1159,10 @@ static bool shrink_lock_dentry(struct dentry *dentry)
 static inline void shrink_kill(struct dentry *victim, struct list_head *list)
 {
 	struct dentry *parent = victim->d_parent;
-	if (parent != victim)
-		__dput_to_list(parent, list);
+	if (parent != victim) {
+		--parent->d_lockref.count;
+		to_shrink_list(parent, list);
+	}
 	__dentry_kill(victim);
 }
 
-- 
2.39.2


