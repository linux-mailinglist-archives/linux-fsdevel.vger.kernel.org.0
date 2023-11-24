Return-Path: <linux-fsdevel+bounces-3603-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEA27F6BF0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 07:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E3361C20C56
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 06:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D682EA947;
	Fri, 24 Nov 2023 06:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="iTslkxVq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D3410C9;
	Thu, 23 Nov 2023 22:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=rwrYa0ZG4BhKzoZJnT7hD4obIICVmp0PYWpt5r0DLZA=; b=iTslkxVqcE3fNcRd/dfxoL6H8N
	RN4tz9z1Zfv4kEhhHiNJprCk9+cVZRuIyyFg+8VO9hWYeRVcgdt88EAwtvStc7Rb2aPfVDWL3FDLq
	np8N/Qbd2cVqQuikxDzPb2CBL0eCYqi/llJfQkwKweEN46hFjsmKGBVDvuYJc0J7qryZrSLjSeZgf
	3ZIFOykh9eZfB1wvxa4CdQCGratzJa16QpbrplcDQ1OW2qzgY7tiOKXTesvdEieeGrHRFK9BhlYKi
	SVxlhAUXCftobhULyxe/r9SrspnXscdpdQI+c6a3N3iqtTssP/+DCCYLKMNo9QCqJRAsr2L0nGa0h
	B7hxuKwQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r6PId-002PuH-2S;
	Fri, 24 Nov 2023 06:04:23 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 09/21] __dput_to_list(): do decrement of refcount in the callers
Date: Fri, 24 Nov 2023 06:04:10 +0000
Message-Id: <20231124060422.576198-9-viro@zeniv.linux.org.uk>
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

... and rename it to to_shrink_list(), seeing that it no longer
does dropping any references

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index a00e9ba22480..0718b3895c12 100644
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
 
@@ -1165,8 +1164,10 @@ static bool shrink_lock_dentry(struct dentry *dentry)
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


