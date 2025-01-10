Return-Path: <linux-fsdevel+bounces-38777-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DAD1A08577
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 03:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B80083A8A3F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 02:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AAF0205E13;
	Fri, 10 Jan 2025 02:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="f6bxkUAJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3251E0E0B;
	Fri, 10 Jan 2025 02:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736476987; cv=none; b=AXoOoX1T8iVmZ85q+8dToBvh9299N0WPuGy6ZlyC8aTWAfwn5CH1msbiT8UOR9fOibBnv7RBZC190/20TQIbqiMAQzJylBzM1UZUmtbIjmVqqDkyISeUoY3mxa5641rEp5mswuPJND7+ieROTjZoZzpWI2g8Y6V85GVRkALb7/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736476987; c=relaxed/simple;
	bh=DToQ4ZYaWssBLRAqq+US/eiA3DvwM0ksgDaUPoRvpIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IPedmrJdwKGPK62w7d7o22eI0wlwz7Sj2nRWPLnd0RD0S5cI93RoCDg/GYtOkES49bEB3r0h71KKBERW1KZN+E46/0SnxjE76cedNPH9OGgCbMy0QVykybYjR1lF1431MPf9HpVn/Rhvbi7kHAMsKqDTflHER0DShdQxE9aCPEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=f6bxkUAJ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=rxYGbb1SegvqU74IuANusA/2x1qXjTRuy8QebddHC6o=; b=f6bxkUAJyXOa6Whj8yDrbGgxGf
	G+GXjY+V0nULnuRBN0gQd6vuEO3qH5h0ugA0Mx3R78XN+JUWPNO9IaMu7ci9bb/qTMex/e9XuSxXQ
	l2xLB0aXwSnCLR5YKn/Xaolea4qxB++Bt/NOQy65M6CNjo3HHa8UvehE2e4OCpzU0IxMRDgc8+N4Q
	LvScueaJpOYHsjtLl9Tb3U/+/xRF5L/SOl/aFKmaWuydzhOEMpTzpAYatcIekR3BnZyDO3vt5kXY7
	7b3K2uMCqUrc2EwTi+km4c3zxVPbZ683Qx6odUbq7gYlzsiKmS55iFSc+X6+OOpB8qaIwd3t4Q+uC
	EBiTtaNw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tW4zH-0000000HRay-2zFu;
	Fri, 10 Jan 2025 02:43:03 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: agruenba@redhat.com,
	amir73il@gmail.com,
	brauner@kernel.org,
	ceph-devel@vger.kernel.org,
	dhowells@redhat.com,
	hubcap@omnibond.com,
	jack@suse.cz,
	krisman@kernel.org,
	linux-nfs@vger.kernel.org,
	miklos@szeredi.hu,
	torvalds@linux-foundation.org
Subject: [PATCH 03/20] make take_dentry_name_snapshot() lockless
Date: Fri, 10 Jan 2025 02:42:46 +0000
Message-ID: <20250110024303.4157645-3-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110024303.4157645-1-viro@zeniv.linux.org.uk>
References: <20250110023854.GS1977892@ZenIV>
 <20250110024303.4157645-1-viro@zeniv.linux.org.uk>
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

NOTE: now that there is a lockless path where we might try to grab
a reference to an already doomed external_name instance, it is no
longer possible for external_name.u.count and external_name.u.head
to share space (kudos to Linus for spotting that).

To reduce the noice this commit just turns external_name.u into
a struct (instead of union); the next commit will dissolve it.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 52662a5d08e4..f387dc97df86 100644
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
@@ -329,15 +329,30 @@ static inline int dname_external(const struct dentry *dentry)
 
 void take_dentry_name_snapshot(struct name_snapshot *name, struct dentry *dentry)
 {
-	spin_lock(&dentry->d_lock);
-	name->name = dentry->d_name;
-	if (unlikely(dname_external(dentry))) {
-		atomic_inc(&external_name(dentry)->u.count);
-	} else {
+	unsigned seq;
+	const unsigned char *s;
+
+	rcu_read_lock();
+retry:
+	seq = read_seqcount_begin(&dentry->d_seq);
+	s = READ_ONCE(dentry->d_name.name);
+	name->name.hash_len = dentry->d_name.hash_len;
+	name->name.name = name->inline_name.string;
+	if (likely(s == dentry->d_shortname.string)) {
 		name->inline_name = dentry->d_shortname;
-		name->name.name = name->inline_name.string;
+	} else {
+		struct external_name *p;
+		p = container_of(s, struct external_name, name[0]);
+		// get a valid reference
+		if (unlikely(!atomic_inc_not_zero(&p->u.count)))
+			goto retry;
+		name->name.name = s;
 	}
-	spin_unlock(&dentry->d_lock);
+	if (read_seqcount_retry(&dentry->d_seq, seq)) {
+		release_dentry_name_snapshot(name);
+		goto retry;
+	}
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL(take_dentry_name_snapshot);
 
-- 
2.39.5


