Return-Path: <linux-fsdevel+bounces-37909-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B269F8A74
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 04:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF31B166268
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 03:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38141A255C;
	Fri, 20 Dec 2024 03:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lNJjEqPD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wH0WjbXQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lNJjEqPD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wH0WjbXQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF904501A;
	Fri, 20 Dec 2024 03:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734664194; cv=none; b=aoqqaN4Uq05rQOQuMeYahES5dqFYOR3cz1CVvbVBRenDnXOupOACRE9Cr9pY0aXU5YYyEAnT5+B1gWgsw4bdgIN4kNpfuox/TOh8Va7O+E2faIQg4ZwD/nf+CiTAGIM+CzDyQVxZF3vqCfpBwPAlc7EJ3HiAVhaTY1W6XkzAq9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734664194; c=relaxed/simple;
	bh=OL1t/kJulixMtDs+kqNIcP5Pt8I1l1g8NdLP0mBsS4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CVULAVr5wNf8eflFVaVRDOCC/YQ8teM9Vlnoec8ITb+jC0aE2CgcfO4lVHqHTxrTgFXhBW7t72r0gfTz2ro+vrvqE2qLL3tOpWwsnMv1vOyhy/nbid8GFXjDmDcbMNmO4IbOhLG40mi89gWeD80KQYwmBcVdTANNk+++xTBsQSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lNJjEqPD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wH0WjbXQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lNJjEqPD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wH0WjbXQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 77F3D1F38C;
	Fri, 20 Dec 2024 03:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734664190; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xI6gwL32tvphmuKRm12RYhkNIgjqKyHE5XDqNpdqk98=;
	b=lNJjEqPDdKwr6prgG26AxIghOOdcy8cNKDuueupwxtqsUhKKdw9wKBQRsxlfUyIeMPm7EV
	qeGKI96gWFW2inmU9x2oetoM1GpxAmangwsGWr4LNSbv76u6hows4JF0Da0UPknVGYhTZc
	JETSzsC+f4i7lM0IFdZmF+CbcJ8Fu8w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734664190;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xI6gwL32tvphmuKRm12RYhkNIgjqKyHE5XDqNpdqk98=;
	b=wH0WjbXQXVnjstbMy5vRGuIvCM+iLJSw4PYjFMFEMJtVRw0YFm79ocppkHv+OE65shVNV2
	uPsNFZ+9AI73SXDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734664190; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xI6gwL32tvphmuKRm12RYhkNIgjqKyHE5XDqNpdqk98=;
	b=lNJjEqPDdKwr6prgG26AxIghOOdcy8cNKDuueupwxtqsUhKKdw9wKBQRsxlfUyIeMPm7EV
	qeGKI96gWFW2inmU9x2oetoM1GpxAmangwsGWr4LNSbv76u6hows4JF0Da0UPknVGYhTZc
	JETSzsC+f4i7lM0IFdZmF+CbcJ8Fu8w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734664190;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xI6gwL32tvphmuKRm12RYhkNIgjqKyHE5XDqNpdqk98=;
	b=wH0WjbXQXVnjstbMy5vRGuIvCM+iLJSw4PYjFMFEMJtVRw0YFm79ocppkHv+OE65shVNV2
	uPsNFZ+9AI73SXDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5E2EE13A32;
	Fri, 20 Dec 2024 03:09:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7T5EBfzfZGeHGAAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 20 Dec 2024 03:09:48 +0000
From: NeilBrown <neilb@suse.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/11] VFS: take a shared lock for create/remove directory operations.
Date: Fri, 20 Dec 2024 13:54:28 +1100
Message-ID: <20241220030830.272429-11-neilb@suse.de>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241220030830.272429-1-neilb@suse.de>
References: <20241220030830.272429-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-Spam-Score: -2.80
X-Spam-Flag: NO

With this patch the VFS takes a shared lock on the directory (i_rwsem)
when performing create or remove operations.  Rename is as yet
unchanged.

Not all callers are changed, only the common ones in fs/namei.c

While the directory only has a shared lock, the dentry being updated has
an exclusive lock using a bit in ->d_flags.  Waiters use
wait_var_event_spinlock(), and a wakeup is only sent in the unusual case
that some other task is actually waiting - indicated by another d_flags
bit.

Once the exclusive "update" lock is obtained on the dentry we must make
sure it wasn't unlinked or renamed while we slept.  If it was we repeat
the lookup.

The filesystem operations that expect an exclusive lock are still
provided with exclusion, but this is handled by inode_dir_lock().

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/dcache.c            |  9 ++++++-
 fs/namei.c             | 53 ++++++++++++++++++++++++++++++++++++++----
 include/linux/dcache.h |  4 ++++
 3 files changed, 60 insertions(+), 6 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index ebe849474bd8..3fb3af83add5 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1636,9 +1636,10 @@ EXPORT_SYMBOL(d_invalidate);
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
@@ -1697,6 +1698,8 @@ static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 	INIT_HLIST_NODE(&dentry->d_sib);
 	d_set_d_op(dentry, dentry->d_sb->s_d_op);
 
+	lockdep_init_map(&dentry->d_update_map, "DCACHE_PAR_UPDATE", &__key, 0);
+
 	if (dentry->d_op && dentry->d_op->d_init) {
 		err = dentry->d_op->d_init(dentry);
 		if (err) {
@@ -3030,6 +3033,10 @@ static int __d_unalias(struct dentry *dentry, struct dentry *alias)
  * In that case, we know that the inode will be a regular file, and also this
  * will only occur during atomic_open. So we need to check for the dentry
  * being already hashed only in the final case.
+ *
+ * @dentry must have a valid ->d_parent and that directory must be
+ * locked (i_rwsem) either exclusively or shared.  If shared then
+ * @dentry must have %DCACHE_PAR_LOOKUP or %DCACHE_PAR_UPDATE set.
  */
 struct dentry *d_splice_alias(struct inode *inode, struct dentry *dentry)
 {
diff --git a/fs/namei.c b/fs/namei.c
index 68750b15dbf4..fb40ae64dc8d 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1703,6 +1703,15 @@ struct dentry *lookup_one_qstr_excl(const struct qstr *name,
 }
 EXPORT_SYMBOL(lookup_one_qstr_excl);
 
+static bool check_dentry_locked(struct dentry *de)
+{
+	if (de->d_flags & DCACHE_PAR_UPDATE) {
+		de->d_flags |= DCACHE_PAR_WAITER;
+		return true;
+	}
+	return false;
+}
+
 static struct dentry *lookup_and_lock(const struct qstr *last,
 				      struct dentry *base,
 				      unsigned int lookup_flags)
@@ -1710,10 +1719,36 @@ static struct dentry *lookup_and_lock(const struct qstr *last,
 	struct dentry *dentry;
 	int err;
 
-	inode_lock_nested(base->d_inode, I_MUTEX_PARENT);
+	inode_lock_shared_nested(base->d_inode, I_MUTEX_PARENT);
+retry:
 	dentry = lookup_one_qstr_excl(last, base, lookup_flags);
 	if (IS_ERR(dentry))
 		goto out;
+	lock_acquire_exclusive(&dentry->d_update_map, 0, 0, NULL, _THIS_IP_);
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
+			dput(dentry);
+			goto retry;
+		}
+		rcu_read_unlock();
+	}
+	dentry->d_flags |= DCACHE_PAR_UPDATE;
+	spin_unlock(&dentry->d_lock);
 	err = -EEXIST;
 	if ((lookup_flags & LOOKUP_EXCL) && d_is_positive(dentry))
 		goto err;
@@ -1723,10 +1758,11 @@ static struct dentry *lookup_and_lock(const struct qstr *last,
 	return dentry;
 
 err:
-	dput(dentry);
-	dentry = ERR_PTR(err);
+	done_lookup_and_lock(base, dentry);
+	return ERR_PTR(err);
+
 out:
-	inode_unlock(base->d_inode);
+	inode_unlock_shared(base->d_inode);
 	return dentry;
 }
 
@@ -2795,8 +2831,15 @@ EXPORT_SYMBOL(user_path_locked_at);
 
 void done_lookup_and_lock(struct dentry *parent, struct dentry *child)
 {
+	lock_map_release(&child->d_update_map);
+	spin_lock(&child->d_lock);
+	if (child->d_flags & DCACHE_PAR_WAITER)
+		wake_up_var_locked(&child->d_flags, &child->d_lock);
+	child->d_flags &= ~(DCACHE_PAR_UPDATE | DCACHE_PAR_WAITER);
+	spin_unlock(&child->d_lock);
+
+	inode_unlock_shared(parent->d_inode);
 	dput(child);
-	inode_unlock(d_inode(parent));
 }
 EXPORT_SYMBOL(done_lookup_and_lock);
 
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index fc7f571bd5bb..6d404c296ac0 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -102,6 +102,8 @@ struct dentry {
 					 * possible!
 					 */
 
+	/* lockdep tracking of DCACHE_PAR_UPDATE locks */
+	struct lockdep_map		d_update_map;
 	union {
 		struct list_head d_lru;		/* LRU list */
 		wait_queue_head_t *d_wait;	/* in-lookup ones only */
@@ -220,6 +222,8 @@ struct dentry_operations {
 #define DCACHE_DENTRY_CURSOR		BIT(25)
 #define DCACHE_NORCU			BIT(26) /* No RCU delay for freeing */
 
+#define DCACHE_PAR_UPDATE		BIT(27) /* Locked for update */
+#define DCACHE_PAR_WAITER		BIT(28) /* someone is waiting for PAR_UPDATE */
 extern seqlock_t rename_lock;
 
 /*
-- 
2.47.0


