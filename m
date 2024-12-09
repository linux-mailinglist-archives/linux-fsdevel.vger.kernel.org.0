Return-Path: <linux-fsdevel+bounces-36720-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2485A9E8A06
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 04:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 293F8188532A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 03:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FAB614B06A;
	Mon,  9 Dec 2024 03:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="TVN39oOk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAD12572
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Dec 2024 03:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733716376; cv=none; b=bA5eEgBYdPC1w4J1283KkWLEvDWB3UPV6N4nMeOiKTg7Gfkm0fMkJEHPLgtAJoYO5nlEipw8aesBYrV6jMNORGqaSdvCQmMJsLCONVyxbeMvvSbSMG+zMOnPiXrZUlAVR83Tr/BBtAWiUd1G6R3P/PhBiIEe+KKmznLEbjWHhSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733716376; c=relaxed/simple;
	bh=80hjGVK7FxY6/1EgYHKSA+N39AJoBIGEs7deD7KXjbk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TBMndUXSc8hUsjwotaI0eLuyhNNBftRbG6hzcSKSHJKz1rIeKiO8ZVmpEbGNxp1kjFv/Myqjt8/D3EwzQrG5hl+0ljV8/SrzBJsTHHzqUGS0flC1TETMwHuLYoQ0Ar4gEh5B7AlRtUJKpYAC3TC4cOc/nzk4fmysi3dM+fZoy1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=TVN39oOk; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=1uMR2haWAKjLK/ZC/iSJQ4F2nkawoxBwMGZ0ogzYQO8=; b=TVN39oOk08DWTLN3PNQRSEcH/F
	VnSX2RVTBgrUYh6nS+u7DJFb4YUn4zEsxjN1BCfPLE2n33/73q3waY73cf9AJ7RpmF/7V3bDpONXi
	54Gj3KLS3u77vWIRXTSwI+PaYxDy+eVz8LgUItWgUOQ4pVRLDvprtP7ZjOUydpLLmrfAKsM8t+WLw
	/QFB8CbKXngoONWIGzJqNGkkGk9aUQkA99Ima+T4/HMe5gTO2LVsEmOilxltqp2hQNKV7nvN9QBMy
	xXtf8uwqaEuUoHmBXwCLFAcLSosVPkccBgqy2Egk9mAd2qF5IFjP0JQx161ZWEzyA0Dt8GYCBCiZx
	82kPmGEw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tKUpH-00000006R1n-254Z;
	Mon, 09 Dec 2024 03:52:51 +0000
Date: Mon, 9 Dec 2024 03:52:51 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH][RFC] make take_dentry_name_snapshot() lockless
Message-ID: <20241209035251.GV3387508@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

There's a bunch of places where we are accessing dentry names without
sufficient protection and where locking environment is not predictable
enough to fix the things that way; take_dentry_name_snapshot() is
one variant of solution.  It does, however, have a problem - copying
is cheap, but bouncing ->d_lock may be nasty on seriously shared dentries.

How about the following (completely untested)?

Use ->d_seq instead of grabbing ->d_lock; in case of shortname dentries
that avoids any stores to shared data objects and in case of long names
we are down to (unavoidable) atomic_inc on the external_name refcount.
    
Makes the thing safer as well - the areas where ->d_seq is held odd are
all nested inside the areas where ->d_lock is held, and the latter are
much more numerous.
    
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/dcache.c b/fs/dcache.c
index b4d5e9e1e43d..78fd7e2a3011 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -329,16 +329,34 @@ static inline int dname_external(const struct dentry *dentry)
 
 void take_dentry_name_snapshot(struct name_snapshot *name, struct dentry *dentry)
 {
-	spin_lock(&dentry->d_lock);
+	unsigned seq;
+
+	rcu_read_lock();
+retry:
+	seq = read_seqcount_begin(&dentry->d_seq);
 	name->name = dentry->d_name;
-	if (unlikely(dname_external(dentry))) {
-		atomic_inc(&external_name(dentry)->u.count);
-	} else {
-		memcpy(name->inline_name, dentry->d_iname,
-		       dentry->d_name.len + 1);
+	if (read_seqcount_retry(&dentry->d_seq, seq))
+		goto retry;
+	// ->name and ->len are at least consistent with each other, so if
+	// ->name points to dentry->d_iname, ->len is below DNAME_INLINE_LEN
+	if (likely(name->name.name == dentry->d_iname)) {
+		memcpy(name->inline_name, dentry->d_iname, name->name.len + 1);
 		name->name.name = name->inline_name;
+		if (read_seqcount_retry(&dentry->d_seq, seq))
+			goto retry;
+	} else {
+		struct external_name *p;
+		p = container_of(name->name.name, struct external_name, name[0]);
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
 

