Return-Path: <linux-fsdevel+bounces-2487-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D367E63C4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 07:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDD042815FB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 06:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1016810A3E;
	Thu,  9 Nov 2023 06:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="em8166ug"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E5E101C3
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 06:21:04 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A882F2700
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 22:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=CoNG7RM/Qk8hwAjsykczrRFcU4ltOzOlM2mSsueSOJ8=; b=em8166ugkSKtKb7VFrx9mtrlHI
	7zgt4msQZaTcWLLmG0ZnP1PgUqv9VSJUdIL3/IXD0LDo1GlEwMDIb3qPVj2aQdKdwOKdgRT5qG8oH
	zEXISTeaqbNssgGEb7eoAjBlLiLDuVoc0PVgE/Pc/PRViLCHiAwv3CYEWkg1zjjxzLkPqVYCzCOz0
	++iqM/kzF7+BVmWv0in6y37xcsqbz83jRVuEtGrq34wVYB4HcjIRdYaePe2sdBiw8/J3RrK2RFBeD
	SWYRlCqry4QleUEOkCciwhuz32qgQCb07l/qc1P1m8N5GeG1UyBJOfSfZkcuLiN2zY3U/TPFqLmDk
	Zq8MJmCw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r0yPT-00DLki-0s;
	Thu, 09 Nov 2023 06:20:59 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 19/22] to_shrink_list(): call only if refcount is 0
Date: Thu,  9 Nov 2023 06:20:53 +0000
Message-Id: <20231109062056.3181775-19-viro@zeniv.linux.org.uk>
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

The only thing it does if refcount is not zero is d_lru_del(); no
point, IMO, seeing that plain dput() does nothing of that sort...

Note that 2 of 3 current callers are guaranteed that refcount is 0.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index aa9f7ee7a603..49585f2ad896 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -915,8 +915,7 @@ __must_hold(&dentry->d_lock)
 	if (!(dentry->d_flags & DCACHE_SHRINK_LIST)) {
 		if (dentry->d_flags & DCACHE_LRU_LIST)
 			d_lru_del(dentry);
-		if (!dentry->d_lockref.count)
-			d_shrink_add(dentry, list);
+		d_shrink_add(dentry, list);
 	}
 }
 
@@ -1110,10 +1109,8 @@ EXPORT_SYMBOL(d_prune_aliases);
 static inline void shrink_kill(struct dentry *victim, struct list_head *list)
 {
 	struct dentry *parent = victim->d_parent;
-	if (parent != victim) {
-		--parent->d_lockref.count;
+	if (parent != victim && !--parent->d_lockref.count)
 		to_shrink_list(parent, list);
-	}
 	__dentry_kill(victim);
 }
 
-- 
2.39.2


