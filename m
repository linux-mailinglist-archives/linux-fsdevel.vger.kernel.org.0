Return-Path: <linux-fsdevel+bounces-36882-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2329D9EA5FC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 03:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D47552842F2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 02:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FAA1D0E28;
	Tue, 10 Dec 2024 02:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="taJ0EkwI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D1E1AB6EB;
	Tue, 10 Dec 2024 02:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733798912; cv=none; b=bQiU0gDMrtRbkyyghGJ0ado77PFhvR4cm+aHZIgPqm3IlXOJWDg8iXcpFJdA3jm0RzyART3t0L0TQXHSUWm1Ygu//0n+Pca90TLv2DUpnmmQULIbnXCvEtOTV5Cyq5MswzhMU3KvVOaooywODMb+cC+mmAFI+oaDrydDJwSWBsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733798912; c=relaxed/simple;
	bh=13y3cZyhTP/Hfvy1e1EVP7Q5/Ew2YMV6nCjpyOiYypY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K3EF9ylIvo20Qoe73Oo3JOiVBVldFSRv2r4ODKG7kK9GJndYoBz+0d6eQLq7LGFOnWZ13+xnB0ZRvamuQN3TFDaTo4LTTLjDEoFMWUZdbk6jzfayv40YPDihAZ+SRSibwihLf79whU0y0/oz7nTRp4mTzCS7aGS2W+qGL7ZFdto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=taJ0EkwI; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ZEZWZj1hEX4mTQDSnscf9Mv90kDmsF2fSkjlmj7fzhM=; b=taJ0EkwIxZ9l2Ggw9zKenszibt
	EMzm+PleqY6JZlblRbzW5OLOuSGXmP6j9QwJJkN0m52Yx5ldiIslv6l3JIfucGbxPZG7ILGOoVaIz
	T3RvBgkcCvihMPzIE5WHPY86PUsxQkDMVEzRqN4n+l94Pt/9c/B5GLkeDBgf30iVL9s7pwmoFBBAn
	mvSka+E3rYYgTaHLwUoYSP0utCxE+9cYMMHp9XCZeotQ/7EH2BaiuQHVkdkkHMIBjwOGsGvIlOpOR
	t5px8sSrP/G4QeCLAS52DxdqfDITywRZxsAc6tNoMPZvAstTHB7ySmhcZDdQ9n7K/oFv0kgj6BQT6
	qs+Sziug==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tKqIV-00000006lS0-3WWD;
	Tue, 10 Dec 2024 02:48:27 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: [PATCH 4/5] dissolve external_name.u into separate members
Date: Tue, 10 Dec 2024 02:48:26 +0000
Message-ID: <20241210024827.1612355-4-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241210024827.1612355-1-viro@zeniv.linux.org.uk>
References: <20241210024523.GD3387508@ZenIV>
 <20241210024827.1612355-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

kept separate from the previous commit to keep the noise separate
from actual changes...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index ae13e89ce7d7..163bb0953b4f 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -296,10 +296,8 @@ static inline int dentry_cmp(const struct dentry *dentry, const unsigned char *c
 }
 
 struct external_name {
-	struct {
-		atomic_t count;		// ->count and ->head can't be combined
-		struct rcu_head head;	// see take_dentry_name_snapshot()
-	} u;
+	atomic_t count;		// ->count and ->head can't be combined
+	struct rcu_head head;	// see take_dentry_name_snapshot()
 	unsigned char name[];
 };
 
@@ -347,11 +345,11 @@ void take_dentry_name_snapshot(struct name_snapshot *name, struct dentry *dentry
 		p = container_of(s, struct external_name, name[0]);
 		name->name.name = s;
 		// get a valid reference
-		if (unlikely(!atomic_inc_not_zero(&p->u.count)))
+		if (unlikely(!atomic_inc_not_zero(&p->count)))
 			goto retry;
 		if (read_seqcount_retry(&dentry->d_seq, seq)) {
-			if (unlikely(atomic_dec_and_test(&p->u.count)))
-				kfree_rcu(p, u.head);
+			if (unlikely(atomic_dec_and_test(&p->count)))
+				kfree_rcu(p, head);
 			goto retry;
 		}
 	}
@@ -364,8 +362,8 @@ void release_dentry_name_snapshot(struct name_snapshot *name)
 	if (unlikely(name->name.name != name->inline_name)) {
 		struct external_name *p;
 		p = container_of(name->name.name, struct external_name, name[0]);
-		if (unlikely(atomic_dec_and_test(&p->u.count)))
-			kfree_rcu(p, u.head);
+		if (unlikely(atomic_dec_and_test(&p->count)))
+			kfree_rcu(p, head);
 	}
 }
 EXPORT_SYMBOL(release_dentry_name_snapshot);
@@ -403,7 +401,7 @@ static void dentry_free(struct dentry *dentry)
 	WARN_ON(!hlist_unhashed(&dentry->d_u.d_alias));
 	if (unlikely(dname_external(dentry))) {
 		struct external_name *p = external_name(dentry);
-		if (likely(atomic_dec_and_test(&p->u.count))) {
+		if (likely(atomic_dec_and_test(&p->count))) {
 			call_rcu(&dentry->d_u.d_rcu, __d_free_external);
 			return;
 		}
@@ -1684,7 +1682,7 @@ static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 			kmem_cache_free(dentry_cache, dentry); 
 			return NULL;
 		}
-		atomic_set(&p->u.count, 1);
+		atomic_set(&p->count, 1);
 		dname = p->name;
 	} else  {
 		dname = dentry->d_iname;
@@ -2777,15 +2775,15 @@ static void copy_name(struct dentry *dentry, struct dentry *target)
 	if (unlikely(dname_external(dentry)))
 		old_name = external_name(dentry);
 	if (unlikely(dname_external(target))) {
-		atomic_inc(&external_name(target)->u.count);
+		atomic_inc(&external_name(target)->count);
 		dentry->d_name = target->d_name;
 	} else {
 		dentry->d_iname_words = target->d_iname_words;
 		dentry->d_name.name = dentry->d_iname;
 		dentry->d_name.hash_len = target->d_name.hash_len;
 	}
-	if (old_name && likely(atomic_dec_and_test(&old_name->u.count)))
-		kfree_rcu(old_name, u.head);
+	if (old_name && likely(atomic_dec_and_test(&old_name->count)))
+		kfree_rcu(old_name, head);
 }
 
 /*
-- 
2.39.5


