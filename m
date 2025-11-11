Return-Path: <linux-fsdevel+bounces-67822-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59622C4BEA6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 08:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E7133A74A4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 07:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0093570CD;
	Tue, 11 Nov 2025 06:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="w3HzJj6d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BE2346FD0;
	Tue, 11 Nov 2025 06:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762844133; cv=none; b=bdGdS/mzxO9cDsoSa1DnEwpfAto4GSdJ1B3Mn64jMZ9GB1Ocir6+9Nind+1wLbpjnUBMVbo+4M28YJkv+wju+CfcKBe5TkLp1JrDbwM5Jq8+M5lMRGAy3h12pH86EqT4rcyT+H4bHY/c4lST3eNGB46wUqbSxz779XWHIcHC7Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762844133; c=relaxed/simple;
	bh=UehzoAqkMMtpS1CZkgeVCnyi1TakQfRHnSW/Mdx4B8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TPhOONZOvcOTItkqUjEkUqIimNLItS+g17P84QyxhGHGfy7lY9M+rrJCv0WNZRgq5APGkR3J64+svWBKKdJosqBZVPzQdxaiGVORNh6LPZsQrihpWVzWmt5BQ6BfJCcYIOZbhMP2bvxEkP9mOrTHeHUfZdqjTjJByYleF/VsPZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=w3HzJj6d; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=0rQmwI4wUCW4CFIUjCTrKY3EBmJE6MZ3qh3WAaCxCww=; b=w3HzJj6dIjUGvVtuH9EW2+M/oX
	l2sQlAQ9o3B9CyZUYYA4OXaizv62M7NjTVobql1V02v22x7GXnZ8QNDFLN1uc/kCnoLwYhr9nAxZC
	wCkoEamKxQMJPivBMdxeCtsVnuJHyct5ys4qSehrBLtSNh/JI5Z5el/50nGhUV9xnRpjcrtgRtQTM
	jnxdeI8xRzQEVH9WzI6PB7UsboUJRoseob9UIqEJNKhXhJZfU1ddIPB6CYm9QPiWF17Htr5r4XITD
	53c068+7s255nbfMCbX+eSz2Ms0ldTle1KLXxVXEVLlcDMewriy1w9Qfr89wD1ERdYdXtMTPhCuMU
	0HRk00bw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIiHi-0000000Bwx0-19u5;
	Tue, 11 Nov 2025 06:55:22 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: torvalds@linux-foundation.org,
	brauner@kernel.org,
	jack@suse.cz,
	raven@themaw.net,
	miklos@szeredi.hu,
	neil@brown.name,
	a.hindborg@kernel.org,
	linux-mm@kvack.org,
	linux-efi@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	kees@kernel.org,
	rostedt@goodmis.org,
	gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	paul@paul-moore.com,
	casey@schaufler-ca.com,
	linuxppc-dev@lists.ozlabs.org,
	john.johansen@canonical.com,
	selinux@vger.kernel.org,
	borntraeger@linux.ibm.com,
	bpf@vger.kernel.org
Subject: [PATCH v3 06/50] primitives for maintaining persisitency
Date: Tue, 11 Nov 2025 06:54:35 +0000
Message-ID: <20251111065520.2847791-7-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251111065520.2847791-1-viro@zeniv.linux.org.uk>
References: <20251111065520.2847791-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

* d_make_persistent(dentry, inode) - bump refcount, mark persistent and
make hashed positive.  Return value is a borrowed reference to dentry;
it can be used until something removes persistency (at the very least,
until the parent gets unlocked, but some filesystems may have stronger
exclusion).

* d_make_discardable() - remove persistency mark and drop reference.

d_make_persistent() is similar to combination of d_instantiate(), dget()
and setting flag.  The only difference is that unlike d_instantiate()
it accepts hashed and unhashed negatives alike.  It is always called in
strong locking environment (parent held exclusive, or, in some cases,
dentry coming from d_alloc_name()); if we ever start using it with parent
held only shared and dentry coming from d_alloc_parallel(), we'll need
to copy the in-lookup logics from __d_add().

d_make_discardable() is eqiuvalent to combination of removing flag and
dput(); since flag removal requires ->d_lock, there's no point trying
to avoid taking that for refcount decrement as fast_dput() does.
The slow path of dput() has been taken into a helper and reused in
d_make_discardable() instead.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c            | 74 +++++++++++++++++++++++++++++++++---------
 include/linux/dcache.h |  2 ++
 2 files changed, 61 insertions(+), 15 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index f2c9f4fef2a2..3cc6c3876177 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -869,6 +869,24 @@ static inline bool fast_dput(struct dentry *dentry)
 	return false;
 }
 
+static void finish_dput(struct dentry *dentry)
+	__releases(dentry->d_lock)
+	__releases(RCU)
+{
+	while (lock_for_kill(dentry)) {
+		rcu_read_unlock();
+		dentry = __dentry_kill(dentry);
+		if (!dentry)
+			return;
+		if (retain_dentry(dentry, true)) {
+			spin_unlock(&dentry->d_lock);
+			return;
+		}
+		rcu_read_lock();
+	}
+	rcu_read_unlock();
+	spin_unlock(&dentry->d_lock);
+}
 
 /* 
  * This is dput
@@ -906,22 +924,28 @@ void dput(struct dentry *dentry)
 		rcu_read_unlock();
 		return;
 	}
-	while (lock_for_kill(dentry)) {
-		rcu_read_unlock();
-		dentry = __dentry_kill(dentry);
-		if (!dentry)
-			return;
-		if (retain_dentry(dentry, true)) {
-			spin_unlock(&dentry->d_lock);
-			return;
-		}
-		rcu_read_lock();
-	}
-	rcu_read_unlock();
-	spin_unlock(&dentry->d_lock);
+	finish_dput(dentry);
 }
 EXPORT_SYMBOL(dput);
 
+void d_make_discardable(struct dentry *dentry)
+{
+	spin_lock(&dentry->d_lock);
+	/*
+	 * By the end of the series we'll add
+	 * WARN_ON(!(dentry->d_flags & DCACHE_PERSISTENT);
+	 * here, but while object removal is done by a few common helpers,
+	 * object creation tends to be open-coded (if nothing else, new inode
+	 * needs to be set up), so adding a warning from the very beginning
+	 * would make for much messier patch series.
+	 */
+	dentry->d_flags &= ~DCACHE_PERSISTENT;
+	dentry->d_lockref.count--;
+	rcu_read_lock();
+	finish_dput(dentry);
+}
+EXPORT_SYMBOL(d_make_discardable);
+
 static void to_shrink_list(struct dentry *dentry, struct list_head *list)
 __must_hold(&dentry->d_lock)
 {
@@ -1939,7 +1963,6 @@ static void __d_instantiate(struct dentry *dentry, struct inode *inode)
 	unsigned add_flags = d_flags_for_inode(inode);
 	WARN_ON(d_in_lookup(dentry));
 
-	spin_lock(&dentry->d_lock);
 	/*
 	 * The negative counter only tracks dentries on the LRU. Don't dec if
 	 * d_lru is on another list.
@@ -1952,7 +1975,6 @@ static void __d_instantiate(struct dentry *dentry, struct inode *inode)
 	__d_set_inode_and_type(dentry, inode, add_flags);
 	raw_write_seqcount_end(&dentry->d_seq);
 	fsnotify_update_flags(dentry);
-	spin_unlock(&dentry->d_lock);
 }
 
 /**
@@ -1976,7 +1998,9 @@ void d_instantiate(struct dentry *entry, struct inode * inode)
 	if (inode) {
 		security_d_instantiate(entry, inode);
 		spin_lock(&inode->i_lock);
+		spin_lock(&entry->d_lock);
 		__d_instantiate(entry, inode);
+		spin_unlock(&entry->d_lock);
 		spin_unlock(&inode->i_lock);
 	}
 }
@@ -1995,7 +2019,9 @@ void d_instantiate_new(struct dentry *entry, struct inode *inode)
 	lockdep_annotate_inode_mutex_key(inode);
 	security_d_instantiate(entry, inode);
 	spin_lock(&inode->i_lock);
+	spin_lock(&entry->d_lock);
 	__d_instantiate(entry, inode);
+	spin_unlock(&entry->d_lock);
 	WARN_ON(!(inode->i_state & I_NEW));
 	inode->i_state &= ~I_NEW & ~I_CREATING;
 	/*
@@ -2754,6 +2780,24 @@ void d_add(struct dentry *entry, struct inode *inode)
 }
 EXPORT_SYMBOL(d_add);
 
+struct dentry *d_make_persistent(struct dentry *dentry, struct inode *inode)
+{
+	WARN_ON(!hlist_unhashed(&dentry->d_u.d_alias));
+	WARN_ON(!inode);
+	security_d_instantiate(dentry, inode);
+	spin_lock(&inode->i_lock);
+	spin_lock(&dentry->d_lock);
+	__d_instantiate(dentry, inode);
+	dentry->d_flags |= DCACHE_PERSISTENT;
+	dget_dlock(dentry);
+	if (d_unhashed(dentry))
+		__d_rehash(dentry);
+	spin_unlock(&dentry->d_lock);
+	spin_unlock(&inode->i_lock);
+	return dentry;
+}
+EXPORT_SYMBOL(d_make_persistent);
+
 static void swap_names(struct dentry *dentry, struct dentry *target)
 {
 	if (unlikely(dname_external(target))) {
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 94b58655322a..6ec4066825e3 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -611,5 +611,7 @@ static inline struct dentry *d_next_sibling(const struct dentry *dentry)
 }
 
 void set_default_d_op(struct super_block *, const struct dentry_operations *);
+struct dentry *d_make_persistent(struct dentry *, struct inode *);
+void d_make_discardable(struct dentry *dentry);
 
 #endif	/* __LINUX_DCACHE_H */
-- 
2.47.3


