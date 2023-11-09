Return-Path: <linux-fsdevel+bounces-2488-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D50477E63C5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 07:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 116C91C20ACE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 06:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C77B11197;
	Thu,  9 Nov 2023 06:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="BHhlV0hk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B67FC1C
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 06:21:04 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E642701
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 22:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=k7SKMdAIr8mlWzKY3NVr+eITorVToK/c6RS5RJxeim0=; b=BHhlV0hkXmWSPynTj+ejbSWvzD
	o6vWTOxLZ5eccV4yHfoJTHex8E9Qa/omhhfMGsx/jPy3kmiuR8E+U+Bb59DbEbVBObPJNNj7uoV8x
	OdSkG/7c4VQCnbwba7gQR/tr3GKVa2vrh3y0QE+nu50UzGg/t2XhAjlkLWLWfhsLRTJxnSmTT/Jtz
	5VMGugEqDAR8IcxGfbv7ywWgwP8kDEAz2Rdbi6IZ14CQBVt9XQkJdcASbdQlbXAmT5i2TRbXhBMOO
	q10JYt/WIWfftQn39XtAmxnzhVZL09GZexYX4MMv7mkQRdqZESdb8bMCNEz+7sVsZCJHJ3Nl86VMy
	KldAVfkw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r0yPT-00DLko-1I;
	Thu, 09 Nov 2023 06:20:59 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 20/22] switch select_collect{,2}() to use of to_shrink_list()
Date: Thu,  9 Nov 2023 06:20:54 +0000
Message-Id: <20231109062056.3181775-20-viro@zeniv.linux.org.uk>
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

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 49585f2ad896..5fdb6342f659 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1490,13 +1490,9 @@ static enum d_walk_ret select_collect(void *_data, struct dentry *dentry)
 
 	if (dentry->d_flags & DCACHE_SHRINK_LIST) {
 		data->found++;
-	} else {
-		if (dentry->d_flags & DCACHE_LRU_LIST)
-			d_lru_del(dentry);
-		if (!dentry->d_lockref.count) {
-			d_shrink_add(dentry, &data->dispose);
-			data->found++;
-		}
+	} else if (!dentry->d_lockref.count) {
+		to_shrink_list(dentry, &data->dispose);
+		data->found++;
 	}
 	/*
 	 * We can return to the caller if we have found some (this
@@ -1517,17 +1513,13 @@ static enum d_walk_ret select_collect2(void *_data, struct dentry *dentry)
 	if (data->start == dentry)
 		goto out;
 
-	if (dentry->d_flags & DCACHE_SHRINK_LIST) {
-		if (!dentry->d_lockref.count) {
+	if (!dentry->d_lockref.count) {
+		if (dentry->d_flags & DCACHE_SHRINK_LIST) {
 			rcu_read_lock();
 			data->victim = dentry;
 			return D_WALK_QUIT;
 		}
-	} else {
-		if (dentry->d_flags & DCACHE_LRU_LIST)
-			d_lru_del(dentry);
-		if (!dentry->d_lockref.count)
-			d_shrink_add(dentry, &data->dispose);
+		to_shrink_list(dentry, &data->dispose);
 	}
 	/*
 	 * We can return to the caller if we have found some (this
-- 
2.39.2


