Return-Path: <linux-fsdevel+bounces-41013-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AFBA2A05A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 06:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 768363A798C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 05:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29DC22576F;
	Thu,  6 Feb 2025 05:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EKUCj0NW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FFqQ//Cf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EKUCj0NW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FFqQ//Cf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A44224893;
	Thu,  6 Feb 2025 05:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738820839; cv=none; b=Or8GTeGoeFX7BV92nZNNGNwoNc4xfSpveak1u1ccexyyxu9ncS2xB2nFzSNicmhu2g417Ek3iMLNy5NoqKuc89bvXjwsDkPjb/xTk4bZ5Wvnoa20TPeDZ6zK9U1cL/6t4mucPhoR6k5Wa0Ngyyai5PQMnFp/XUy1UpXWyrHnDNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738820839; c=relaxed/simple;
	bh=rCm6Se0pWsL4OLFAYwONdyuTr+zXx1uu6RKce+dNOIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f4/MkmnSR0UG/5aRnCVVis8N6DNYFngLN6NBuAWFT4YVKX0VEY6NuN+rU1WxLqRvQHf7r0bE7qErZ54JgJbRwkzWXNIpRXW5gZcmFbQhIhN9kSvN4MQZijqIVh6n04mq4ac6f8HRrGnJxVL7IudbhqrDWNwS+KCFC3hqPOD3d/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EKUCj0NW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FFqQ//Cf; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EKUCj0NW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FFqQ//Cf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9BC1E1F381;
	Thu,  6 Feb 2025 05:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738820835; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o1Nro+4aQorWavuPaXsykpJOlUA1+Wf7rHfEGVcjK+Y=;
	b=EKUCj0NWGFoWHFlQ8oZCRY/nmyJiojLAZNQ0zUJm5jEY/uj78+t0ls/fjk0yfJ6qjsaVVx
	ciGAn7xLPZdv5O2HnfpWdYkRyZEls63nC0jZmte1Qp67eOlVB4A5dtqzCAOT3wLLhH3wJl
	Gc9Jmv+k8enre1F66fqngOyzru5WPWg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738820835;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o1Nro+4aQorWavuPaXsykpJOlUA1+Wf7rHfEGVcjK+Y=;
	b=FFqQ//CfKo+JOB8ceqWB2JnydBUQrCCSvu/mWmE0Cqk95aKy0o5UMwJjO/+lvrO3cNx6C0
	WItQohZpgmSHTiCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738820835; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o1Nro+4aQorWavuPaXsykpJOlUA1+Wf7rHfEGVcjK+Y=;
	b=EKUCj0NWGFoWHFlQ8oZCRY/nmyJiojLAZNQ0zUJm5jEY/uj78+t0ls/fjk0yfJ6qjsaVVx
	ciGAn7xLPZdv5O2HnfpWdYkRyZEls63nC0jZmte1Qp67eOlVB4A5dtqzCAOT3wLLhH3wJl
	Gc9Jmv+k8enre1F66fqngOyzru5WPWg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738820835;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o1Nro+4aQorWavuPaXsykpJOlUA1+Wf7rHfEGVcjK+Y=;
	b=FFqQ//CfKo+JOB8ceqWB2JnydBUQrCCSvu/mWmE0Cqk95aKy0o5UMwJjO/+lvrO3cNx6C0
	WItQohZpgmSHTiCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D862313795;
	Thu,  6 Feb 2025 05:47:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id stXNIuBMpGfDBwAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 06 Feb 2025 05:47:12 +0000
From: NeilBrown <neilb@suse.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff Layton <jlayton@kernel.org>,
	Dave Chinner <david@fromorbit.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 11/19] VFS: Add ability to exclusively lock a dentry and use for create/remove  operations.
Date: Thu,  6 Feb 2025 16:42:48 +1100
Message-ID: <20250206054504.2950516-12-neilb@suse.de>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250206054504.2950516-1-neilb@suse.de>
References: <20250206054504.2950516-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

d_update_lock(), d_update_trylock(), d_update_unlock() are added which
can be used to get an exclusive lock on a dentry in preparation for
updating it.

As contention on a name is rare this is optimised for the uncontended
case.  A bit is set under the d_lock spinlock to claim as lock, and
wait_var_event_spinlock() is used when waiting is needed.  To avoid
sending a wakeup when not needed we have a second bit flag to indicate
if there are any waiters.

This locking is used in lookup_and_lock().

Once the exclusive "update" lock is obtained on the dentry we must make
sure it wasn't unlinked or renamed while we slept.  If it was we repeat
the lookup.

We also ensure that the parent isn't similarly locked.  This is will be
used to protect a directory during rmdir.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/dcache.c            |   5 +-
 fs/internal.h          |  18 +++++++
 fs/namei.c             | 110 ++++++++++++++++++++++++++++++++++++++++-
 include/linux/dcache.h |   4 ++
 4 files changed, 134 insertions(+), 3 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 37c0f655166d..e705696ca57e 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1675,9 +1675,10 @@ EXPORT_SYMBOL(d_invalidate);
  * available. On a success the dentry is returned. The name passed in is
  * copied and the copy passed in may be reused after this call.
  */
- 
+
 static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 {
+	static struct lock_class_key __key;
 	struct dentry *dentry;
 	char *dname;
 	int err;
@@ -1735,6 +1736,8 @@ static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 	INIT_HLIST_NODE(&dentry->d_sib);
 	d_set_d_op(dentry, dentry->d_sb->s_d_op);
 
+	lockdep_init_map(&dentry->d_update_map, "DCACHE_PAR_UPDATE", &__key, 0);
+
 	if (dentry->d_op && dentry->d_op->d_init) {
 		err = dentry->d_op->d_init(dentry);
 		if (err) {
diff --git a/fs/internal.h b/fs/internal.h
index e7f02ae1e098..5cb9a34e26e8 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -225,6 +225,24 @@ extern struct dentry *__d_lookup_rcu(const struct dentry *parent,
 				const struct qstr *name, unsigned *seq);
 extern void d_genocide(struct dentry *);
 
+extern bool d_update_lock(struct dentry *dentry,
+			  struct dentry *base, const struct qstr *last,
+			  unsigned int subclass);
+
+extern bool d_update_trylock(struct dentry *dentry,
+			     struct dentry *base,
+			     const struct qstr *last);
+
+static inline void d_update_unlock(struct dentry *dentry)
+{
+	lock_map_release(&dentry->d_update_map);
+	spin_lock(&dentry->d_lock);
+	if (dentry->d_flags & DCACHE_PAR_WAITER)
+		wake_up_var_locked(&dentry->d_flags, &dentry->d_lock);
+	dentry->d_flags &= ~(DCACHE_PAR_UPDATE | DCACHE_PAR_WAITER);
+	spin_unlock(&dentry->d_lock);
+}
+
 /*
  * pipe.c
  */
diff --git a/fs/namei.c b/fs/namei.c
index eadde9de73bf..145ae07f9b8c 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1750,6 +1750,110 @@ struct dentry *lookup_one_qstr(const struct qstr *name,
 }
 EXPORT_SYMBOL(lookup_one_qstr);
 
+/*
+ * dentry locking for updates.
+ * When modifying a directory the target dentry will be locked by
+ * setting DCACHE_PAR_UPDATE under ->d_lock.  If it is already set,
+ * DCACHE_PAR_WAITER is set to ensure a wakeup is sent, and we wait
+ * using wait_var_event_spinlock().
+ * The DCACHE_PAR_UPDATE bit will only be set in a denty if it is
+ * NOT set in the parent.  This avoids commensing a new operation in
+ * a directory that is being asynchronously deleted using ->mkdir_async.
+ * Instead of holding ->d_lock on the parent while testing the flag, we
+ * use memory ordering to ensure correctness.  Locking a child
+ * retests the parent *after* setting the bit, and deleting a directory
+ * requires testing all children *after* setting the bit in the parent.
+ */
+
+static bool check_dentry_locked(struct dentry *de)
+{
+	if (de->d_flags & DCACHE_PAR_UPDATE) {
+		de->d_flags |= DCACHE_PAR_WAITER;
+		return true;
+	}
+	return false;
+}
+
+bool d_update_lock(struct dentry *dentry,
+		   struct dentry *base, const struct qstr *last,
+		   unsigned int subclass)
+{
+	lock_acquire_exclusive(&dentry->d_update_map, subclass, 0, NULL, _THIS_IP_);
+again:
+	spin_lock(&dentry->d_lock);
+	wait_var_event_spinlock(&dentry->d_flags,
+				!check_dentry_locked(dentry),
+				&dentry->d_lock);
+	if (d_is_positive(dentry)) {
+		rcu_read_lock(); /* needed for d_same_name() */
+		if (
+			/* Was unlinked while we waited ?*/
+			d_unhashed(dentry) ||
+			/* Or was dentry renamed ?? */
+			dentry->d_parent != base ||
+			dentry->d_name.hash != last->hash ||
+			!d_same_name(dentry, base, last)
+		) {
+			rcu_read_unlock();
+			spin_unlock(&dentry->d_lock);
+			lock_map_release(&dentry->d_update_map);
+			return false;
+		}
+		rcu_read_unlock();
+	}
+	/* Must ensure DCACHE_PAR_UPDATE in child is visible before reading
+	 * from parent
+	 */
+	smp_store_mb(dentry->d_flags, dentry->d_flags | DCACHE_PAR_UPDATE);
+	if (base->d_flags & DCACHE_PAR_UPDATE) {
+		/* We cannot grant DCACHE_PAR_UPDATE on a dentry while
+		 * it is held on the parent
+		 */
+		dentry->d_flags &= ~DCACHE_PAR_UPDATE;
+		spin_unlock(&dentry->d_lock);
+		spin_lock(&base->d_lock);
+		wait_var_event_spinlock(&base->d_flags,
+					!check_dentry_locked(base),
+					&base->d_lock);
+		spin_unlock(&base->d_lock);
+		goto again;
+	}
+	spin_unlock(&dentry->d_lock);
+	return true;
+}
+
+bool d_update_trylock(struct dentry *dentry,
+		      struct dentry *base,
+		      const struct qstr *last)
+{
+	int ret = false;
+
+	spin_lock(&dentry->d_lock);
+	rcu_read_lock(); /* needed for d_same_name() */
+	if (!(smp_load_acquire(&dentry->d_flags) & DCACHE_PAR_UPDATE) &&
+	    !(dentry->d_parent->d_flags & DCACHE_PAR_UPDATE)) {
+		if (!base || !(
+			/* Was unlinked before we got spinlock ?*/
+			d_unhashed(dentry) ||
+			/* Or was dentry renamed ?? */
+			dentry->d_parent != base ||
+			dentry->d_name.hash != last->hash ||
+			!d_same_name(dentry, base, last)
+		)) {
+			lock_map_acquire_try(&dentry->d_update_map);
+			smp_store_mb(dentry->d_flags,
+				     dentry->d_flags | DCACHE_PAR_UPDATE);
+			if (dentry->d_parent->d_flags & DCACHE_PAR_UPDATE)
+				dentry->d_flags &= ~DCACHE_PAR_UPDATE;
+			else
+				ret = true;
+		}
+	}
+	rcu_read_unlock();
+	spin_unlock(&dentry->d_lock);
+	return ret;
+}
+
 static struct dentry *lookup_and_lock_nested(const struct qstr *last,
 					     struct dentry *base,
 					     unsigned int lookup_flags,
@@ -1759,8 +1863,9 @@ static struct dentry *lookup_and_lock_nested(const struct qstr *last,
 
 	if (!(lookup_flags & LOOKUP_PARENT_LOCKED))
 		inode_lock_nested(base->d_inode, subclass);
-
-	dentry = lookup_one_qstr(last, base, lookup_flags);
+	do {
+		dentry = lookup_one_qstr(last, base, lookup_flags);
+	} while (!IS_ERR(dentry) && !d_update_lock(dentry, base, last, subclass));
 	if (IS_ERR(dentry) && !(lookup_flags & LOOKUP_PARENT_LOCKED)) {
 			inode_unlock(base->d_inode);
 	}
@@ -1779,6 +1884,7 @@ void done_lookup_and_lock(struct dentry *base, struct dentry *dentry,
 			  unsigned int lookup_flags)
 {
 	d_lookup_done(dentry);
+	d_update_unlock(dentry);
 	dput(dentry);
 	if (!(lookup_flags & LOOKUP_PARENT_LOCKED))
 		inode_unlock(base->d_inode);
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index d5816cf19538..f891fb1be63b 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -111,6 +111,8 @@ struct dentry {
 					 * possible!
 					 */
 
+	/* lockdep tracking of DCACHE_PAR_UPDATE locks */
+	struct lockdep_map		d_update_map;
 	union {
 		struct list_head d_lru;		/* LRU list */
 		wait_queue_head_t *d_wait;	/* in-lookup ones only */
@@ -232,6 +234,8 @@ struct dentry_operations {
 #define DCACHE_DENTRY_CURSOR		BIT(25)
 #define DCACHE_NORCU			BIT(26) /* No RCU delay for freeing */
 
+#define DCACHE_PAR_UPDATE		BIT(27) /* Locked for update */
+#define DCACHE_PAR_WAITER		BIT(28) /* someone is waiting for PAR_UPDATE */
 extern seqlock_t rename_lock;
 
 /*
-- 
2.47.1


