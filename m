Return-Path: <linux-fsdevel+bounces-36885-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D2C9EA602
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 03:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C3B8188B54F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 02:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC9D1D6DAD;
	Tue, 10 Dec 2024 02:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="DcKT+mUr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275C01AAA2E;
	Tue, 10 Dec 2024 02:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733798913; cv=none; b=Q2JdSDCOIpZvpurnY2wpKmkYz6WSgJpsKxdH54XVVZJSnKER+K+C8DS+C05F+FVdDicvC4TqaoWeINLyGBNXLc1CXwS44uQORZJibqHGTe7n+QHGPwPnvnLNQabvRIz9X9UiRI+WoQuwMNxf6UgvpkjriqlQPrBMlJE7T0hV+Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733798913; c=relaxed/simple;
	bh=J3kXarI6VfE3ubZPnhnT/VfrRk0OoyVolinamsq6msw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ByD8B5dOUsbO+EPQjzof5Lr94ipbKUywjrYho+Je+QHKY6L45YstsZoxm054ZvlI/+QXjK5GPCA+eSoczIPKRMOJFkoD+cL9oYjv/uLaQzSVH1N7c52F6LzNb8F8mRPGHW/VBwsTlyRVH5E+eyCQNjP33w0WwHSBUbdLyBm3M1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=DcKT+mUr; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=apmt3CdIEMCI+pB2xWtd2xgUIxQVHjMWICuGg7hFcwM=; b=DcKT+mUrmx74Sk/+1e23PZ7h5U
	O/H+3rgeoWx3V39kvgi0ijPF/ULz5hR4a6OTw0W+G5hQCNRvKEDAT/KLxVHMQa05kcEUig0ozHfuh
	6oU7csSvaQdl7h/Jei9GQR2Yt7g33JgSLqP7OZtlqw0U5Ore5hR0qqtPg4ls7pgZg31iB008gj1fP
	XkQkd7SbJlAHH5Q9utAKepOQSDVkbmT1Ufwj4o9/RV4GMhCSE0eAxrza1+QdEyj0ZrmWVu/e9SoWs
	UmLjcunY/FJiG7QL1eOpSmUL8vkjgB5hlugxSXcbCUYzBXc4/dUetFY0+jPLjpqhYAB/V9XkeaB0+
	T3+qKCnw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tKqIV-00000006lRw-2zE5;
	Tue, 10 Dec 2024 02:48:27 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: [PATCH 3/5] make take_dentry_name_snapshot() lockless
Date: Tue, 10 Dec 2024 02:48:25 +0000
Message-ID: <20241210024827.1612355-3-viro@zeniv.linux.org.uk>
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

Use ->d_seq instead of grabbing ->d_lock; in case of shortname dentries
that avoids any stores to shared data objects and in case of long names
we are down to (unavoidable) atomic_inc on the external_name refcount.

Makes the thing safer as well - the areas where ->d_seq is held odd are
all nested inside the areas where ->d_lock is held, and the latter are
much more numerous.

NOTE: we no longer can have external_name.u.count and external_name.u.head
sharing space, now that we have lockless path that might try to grab
a reference on already doomed instance (kudos to Linus for spotting that).
For now just turn that external_name.u into a struct (instead of union)
to reduce the noise in this commit; the next commit will dissolve it.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 38 ++++++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 007e582c3e68..ae13e89ce7d7 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -296,9 +296,9 @@ static inline int dentry_cmp(const struct dentry *dentry, const unsigned char *c
 }
 
 struct external_name {
-	union {
-		atomic_t count;
-		struct rcu_head head;
+	struct {
+		atomic_t count;		// ->count and ->head can't be combined
+		struct rcu_head head;	// see take_dentry_name_snapshot()
 	} u;
 	unsigned char name[];
 };
@@ -329,15 +329,33 @@ static inline int dname_external(const struct dentry *dentry)
 
 void take_dentry_name_snapshot(struct name_snapshot *name, struct dentry *dentry)
 {
-	spin_lock(&dentry->d_lock);
-	name->name = dentry->d_name;
-	if (unlikely(dname_external(dentry))) {
-		atomic_inc(&external_name(dentry)->u.count);
-	} else {
-		name->inline_name_words = dentry->d_iname_words;
+	unsigned seq;
+	const unsigned char *s;
+
+	rcu_read_lock();
+retry:
+	seq = read_seqcount_begin(&dentry->d_seq);
+	s = READ_ONCE(dentry->d_name.name);
+	name->name.hash_len = dentry->d_name.hash_len;
+	if (likely(s == dentry->d_iname)) {
 		name->name.name = name->inline_name;
+		name->inline_name_words = dentry->d_iname_words;
+		if (read_seqcount_retry(&dentry->d_seq, seq))
+			goto retry;
+	} else {
+		struct external_name *p;
+		p = container_of(s, struct external_name, name[0]);
+		name->name.name = s;
+		// get a valid reference
+		if (unlikely(!atomic_inc_not_zero(&p->u.count)))
+			goto retry;
+		if (read_seqcount_retry(&dentry->d_seq, seq)) {
+			if (unlikely(atomic_dec_and_test(&p->u.count)))
+				kfree_rcu(p, u.head);
+			goto retry;
+		}
 	}
-	spin_unlock(&dentry->d_lock);
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL(take_dentry_name_snapshot);
 
-- 
2.39.5


