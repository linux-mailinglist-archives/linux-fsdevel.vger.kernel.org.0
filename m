Return-Path: <linux-fsdevel+bounces-41004-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FFEA2A043
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 06:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E18D41888109
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 05:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A49D22489C;
	Thu,  6 Feb 2025 05:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OXgqSIvv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CEGTME0U";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OXgqSIvv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CEGTME0U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AA01F60A;
	Thu,  6 Feb 2025 05:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738820743; cv=none; b=RHYOCDLy5mROdqdOGFv0CL6xfjXh2+qFfLY5ScH2WBWaJUoi02CxFtixyzAZG4LJ3/y3HhrBvnwQm73a08NAiSuz8Vd7STfdSNLqFljxC8B4CDwpgVbdGtPpWuU7bUHQMdwOBVThS5L3Epr95MtVa8EYb3jbyHeBXYTa+lggBtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738820743; c=relaxed/simple;
	bh=+FLiyGgdWuvivHekHFyyWG0dyFY9K1XzzQbcMA079Zw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VMZi+Dl+gyOd+5LtEj+00LxAf9CBI/F1Lb+GsXMOUfIRYTmkDJWOwa6aRYZwvhY8x72B0YCThaCVQPS9UIBob4KncM4YF9J0j8oz5gr2c1JGjbsMNzyKUJrlObQ1ZgySYrB3tRVTdKxxKnRdbF2tIASVYB5vQwPws4DvPnn1JU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OXgqSIvv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CEGTME0U; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OXgqSIvv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CEGTME0U; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B1D5621108;
	Thu,  6 Feb 2025 05:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738820738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V4m+yfdJXG9Rz2h1YNdsawYoIyOXZNOniMpxRTLwcPo=;
	b=OXgqSIvv0P8oFsnVgdjqsctj9fsFk8/8x10FLkUX2ReKhc8WgQlSDvJE8dvfOk1lbA5QK0
	dFxG55kLaxl7eDZb7O4sPU2GJp2+p6HRBwWSkM0BhNNwnMwhHucPOpVAlscUO9fhHXXUq6
	fyh9zicSz+izN1/NSfCCeACkX5gTm68=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738820738;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V4m+yfdJXG9Rz2h1YNdsawYoIyOXZNOniMpxRTLwcPo=;
	b=CEGTME0Ua+aVfL5jWa3k3Qjetq81fN40m8qYWovWAzrh7tDZar2VgyujLzNOoECiqpWkGE
	KdjrOHKhmrwbH4DQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738820738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V4m+yfdJXG9Rz2h1YNdsawYoIyOXZNOniMpxRTLwcPo=;
	b=OXgqSIvv0P8oFsnVgdjqsctj9fsFk8/8x10FLkUX2ReKhc8WgQlSDvJE8dvfOk1lbA5QK0
	dFxG55kLaxl7eDZb7O4sPU2GJp2+p6HRBwWSkM0BhNNwnMwhHucPOpVAlscUO9fhHXXUq6
	fyh9zicSz+izN1/NSfCCeACkX5gTm68=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738820738;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V4m+yfdJXG9Rz2h1YNdsawYoIyOXZNOniMpxRTLwcPo=;
	b=CEGTME0Ua+aVfL5jWa3k3Qjetq81fN40m8qYWovWAzrh7tDZar2VgyujLzNOoECiqpWkGE
	KdjrOHKhmrwbH4DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A741113795;
	Thu,  6 Feb 2025 05:45:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bYDTFn9MpGc7BwAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 06 Feb 2025 05:45:35 +0000
From: NeilBrown <neilb@suse.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff Layton <jlayton@kernel.org>,
	Dave Chinner <david@fromorbit.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 02/19] VFS: use global wait-queue table for d_alloc_parallel()
Date: Thu,  6 Feb 2025 16:42:39 +1100
Message-ID: <20250206054504.2950516-3-neilb@suse.de>
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

d_alloc_parallel() currently requires a wait_queue_head to be passed in.
This must have a life time which extends until the lookup is completed.

Future proposed patches will use d_alloc_parallel() for names being
created/unlinked etc.  Some filesystems combine lookup with create
making a longer code path that the wq needs to live for.  If it is still
to be allocated on-stack this can be cumbersome.

This patch replaces the on-stack wqs with a global array of wqs which
are used as needed.  A wq is NOT allocated when a dentry is first
created but only when a second thread attempts to use the same name and
so is forced to wait.  At this moment a wq is chosen using the
least-significant bits on the task's pid and that wq is assigned to
->d_wait.  The ->d_lock is then dropped and the task waits.

When the dentry is finally moved out of "in_lookup" a wake up is only
sent if ->d_wait is not NULL.  This avoids an (uncontended) spin
lock/unlock which saves a couple of atomic operations in a common case.

The wake up passes the dentry that the wake up is for as the "key" and
the waiter will only wake processes waiting on the same key.  This means
that when these global waitqueues are shared (which is inevitable
though unlikely to be frequent), a task will not be woken prematurely.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/afs/dir_silly.c      |  4 +--
 fs/dcache.c             | 69 +++++++++++++++++++++++++++++++++--------
 fs/fuse/readdir.c       |  3 +-
 fs/namei.c              |  6 ++--
 fs/nfs/dir.c            |  6 ++--
 fs/nfs/unlink.c         |  3 +-
 fs/proc/base.c          |  3 +-
 fs/proc/proc_sysctl.c   |  3 +-
 fs/smb/client/readdir.c |  3 +-
 include/linux/dcache.h  |  3 +-
 include/linux/nfs_xdr.h |  1 -
 11 files changed, 67 insertions(+), 37 deletions(-)

diff --git a/fs/afs/dir_silly.c b/fs/afs/dir_silly.c
index a1e581946b93..aa4363a1c6fa 100644
--- a/fs/afs/dir_silly.c
+++ b/fs/afs/dir_silly.c
@@ -239,13 +239,11 @@ int afs_silly_iput(struct dentry *dentry, struct inode *inode)
 	struct dentry *alias;
 	int ret;
 
-	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
-
 	_enter("%p{%pd},%llx", dentry, dentry, vnode->fid.vnode);
 
 	down_read(&dvnode->rmdir_lock);
 
-	alias = d_alloc_parallel(dentry->d_parent, &dentry->d_name, &wq);
+	alias = d_alloc_parallel(dentry->d_parent, &dentry->d_name);
 	if (IS_ERR(alias)) {
 		up_read(&dvnode->rmdir_lock);
 		return 0;
diff --git a/fs/dcache.c b/fs/dcache.c
index 96b21a47312e..e49607d00d2d 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2095,8 +2095,7 @@ struct dentry *d_add_ci(struct dentry *dentry, struct inode *inode,
 		return found;
 	}
 	if (d_in_lookup(dentry)) {
-		found = d_alloc_parallel(dentry->d_parent, name,
-					dentry->d_wait);
+		found = d_alloc_parallel(dentry->d_parent, name);
 		if (IS_ERR(found) || !d_in_lookup(found)) {
 			iput(inode);
 			return found;
@@ -2106,7 +2105,7 @@ struct dentry *d_add_ci(struct dentry *dentry, struct inode *inode,
 		if (!found) {
 			iput(inode);
 			return ERR_PTR(-ENOMEM);
-		} 
+		}
 	}
 	res = d_splice_alias(inode, found);
 	if (res) {
@@ -2476,30 +2475,70 @@ static inline unsigned start_dir_add(struct inode *dir)
 }
 
 static inline void end_dir_add(struct inode *dir, unsigned int n,
-			       wait_queue_head_t *d_wait)
+			       wait_queue_head_t *d_wait, struct dentry *de)
 {
 	smp_store_release(&dir->i_dir_seq, n + 2);
 	preempt_enable_nested();
-	wake_up_all(d_wait);
+	if (d_wait)
+		__wake_up(d_wait, TASK_NORMAL, 0, de);
+}
+
+#define	PAR_LOOKUP_WQS	256
+static wait_queue_head_t par_wait_table[PAR_LOOKUP_WQS] __cacheline_aligned;
+
+static int __init par_wait_init(void)
+{
+	int i;
+
+	for (i = 0; i < PAR_LOOKUP_WQS; i++)
+		init_waitqueue_head(&par_wait_table[i]);
+	return 0;
+}
+fs_initcall(par_wait_init);
+
+struct par_wait_key {
+	struct dentry *de;
+	struct wait_queue_entry wqe;
+};
+
+static int d_wait_wake_fn(struct wait_queue_entry *wq_entry,
+			  unsigned mode, int sync, void *key)
+{
+	struct par_wait_key *pwk = container_of(wq_entry,
+						 struct par_wait_key, wqe);
+	if (pwk->de == key)
+		return default_wake_function(wq_entry, mode, sync, key);
+	return 0;
 }
 
 static void d_wait_lookup(struct dentry *dentry)
 {
 	if (d_in_lookup(dentry)) {
-		DECLARE_WAITQUEUE(wait, current);
-		add_wait_queue(dentry->d_wait, &wait);
+		struct par_wait_key wk = {
+			.de = dentry,
+			.wqe = {
+				.private = current,
+				.func = d_wait_wake_fn,
+			},
+		};
+		struct wait_queue_head *wq;
+		if (!dentry->d_wait)
+			dentry->d_wait = &par_wait_table[current->pid %
+							 PAR_LOOKUP_WQS];
+		wq = dentry->d_wait;
+		add_wait_queue(wq, &wk.wqe);
 		do {
 			set_current_state(TASK_UNINTERRUPTIBLE);
 			spin_unlock(&dentry->d_lock);
 			schedule();
 			spin_lock(&dentry->d_lock);
 		} while (d_in_lookup(dentry));
+		remove_wait_queue(wq, &wk.wqe);
 	}
 }
 
 struct dentry *d_alloc_parallel(struct dentry *parent,
-				const struct qstr *name,
-				wait_queue_head_t *wq)
+				const struct qstr *name)
 {
 	unsigned int hash = name->hash;
 	struct hlist_bl_head *b = in_lookup_hash(parent, hash);
@@ -2596,7 +2635,7 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
 	rcu_read_unlock();
 	/* we can't take ->d_lock here; it's OK, though. */
 	new->d_flags |= DCACHE_PAR_LOOKUP;
-	new->d_wait = wq;
+	new->d_wait = NULL;
 	hlist_bl_add_head(&new->d_u.d_in_lookup_hash, b);
 	hlist_bl_unlock(b);
 	return new;
@@ -2633,8 +2672,12 @@ static wait_queue_head_t *__d_lookup_unhash(struct dentry *dentry)
 
 void __d_lookup_unhash_wake(struct dentry *dentry)
 {
+	wait_queue_head_t *d_wait;
+
 	spin_lock(&dentry->d_lock);
-	wake_up_all(__d_lookup_unhash(dentry));
+	d_wait = __d_lookup_unhash(dentry);
+	if (d_wait)
+		__wake_up(d_wait, TASK_NORMAL, 0, dentry);
 	spin_unlock(&dentry->d_lock);
 }
 EXPORT_SYMBOL(__d_lookup_unhash_wake);
@@ -2662,7 +2705,7 @@ static inline void __d_add(struct dentry *dentry, struct inode *inode)
 	}
 	__d_rehash(dentry);
 	if (dir)
-		end_dir_add(dir, n, d_wait);
+		end_dir_add(dir, n, d_wait, dentry);
 	spin_unlock(&dentry->d_lock);
 	if (inode)
 		spin_unlock(&inode->i_lock);
@@ -2874,7 +2917,7 @@ static void __d_move(struct dentry *dentry, struct dentry *target,
 	write_seqcount_end(&dentry->d_seq);
 
 	if (dir)
-		end_dir_add(dir, n, d_wait);
+		end_dir_add(dir, n, d_wait, target);
 
 	if (dentry->d_parent != old_parent)
 		spin_unlock(&dentry->d_parent->d_lock);
diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index 17ce9636a2b1..c6b646a3f1bd 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -160,7 +160,6 @@ static int fuse_direntplus_link(struct file *file,
 	struct inode *dir = d_inode(parent);
 	struct fuse_conn *fc;
 	struct inode *inode;
-	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 
 	if (!o->nodeid) {
 		/*
@@ -195,7 +194,7 @@ static int fuse_direntplus_link(struct file *file,
 	dentry = d_lookup(parent, &name);
 	if (!dentry) {
 retry:
-		dentry = d_alloc_parallel(parent, &name, &wq);
+		dentry = d_alloc_parallel(parent, &name);
 		if (IS_ERR(dentry))
 			return PTR_ERR(dentry);
 	}
diff --git a/fs/namei.c b/fs/namei.c
index d98caf36e867..5cdbd2eb4056 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1769,13 +1769,12 @@ static struct dentry *__lookup_slow(const struct qstr *name,
 {
 	struct dentry *dentry, *old;
 	struct inode *inode = dir->d_inode;
-	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 
 	/* Don't go there if it's already dead */
 	if (unlikely(IS_DEADDIR(inode)))
 		return ERR_PTR(-ENOENT);
 again:
-	dentry = d_alloc_parallel(dir, name, &wq);
+	dentry = d_alloc_parallel(dir, name);
 	if (IS_ERR(dentry))
 		return dentry;
 	if (unlikely(!d_in_lookup(dentry))) {
@@ -3561,7 +3560,6 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	struct dentry *dentry;
 	int error, create_error = 0;
 	umode_t mode = op->mode;
-	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 
 	if (unlikely(IS_DEADDIR(dir_inode)))
 		return ERR_PTR(-ENOENT);
@@ -3570,7 +3568,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	dentry = d_lookup(dir, &nd->last);
 	for (;;) {
 		if (!dentry) {
-			dentry = d_alloc_parallel(dir, &nd->last, &wq);
+			dentry = d_alloc_parallel(dir, &nd->last);
 			if (IS_ERR(dentry))
 				return dentry;
 		}
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 2b04038b0e40..27c7a5c4e91b 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -725,7 +725,6 @@ void nfs_prime_dcache(struct dentry *parent, struct nfs_entry *entry,
 		unsigned long dir_verifier)
 {
 	struct qstr filename = QSTR_INIT(entry->name, entry->len);
-	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 	struct dentry *dentry;
 	struct dentry *alias;
 	struct inode *inode;
@@ -754,7 +753,7 @@ void nfs_prime_dcache(struct dentry *parent, struct nfs_entry *entry,
 	dentry = d_lookup(parent, &filename);
 again:
 	if (!dentry) {
-		dentry = d_alloc_parallel(parent, &filename, &wq);
+		dentry = d_alloc_parallel(parent, &filename);
 		if (IS_ERR(dentry))
 			return;
 	}
@@ -2059,7 +2058,6 @@ int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
 		    struct file *file, unsigned open_flags,
 		    umode_t mode)
 {
-	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 	struct nfs_open_context *ctx;
 	struct dentry *res;
 	struct iattr attr = { .ia_valid = ATTR_OPEN };
@@ -2115,7 +2113,7 @@ int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
 		d_drop(dentry);
 		switched = true;
 		dentry = d_alloc_parallel(dentry->d_parent,
-					  &dentry->d_name, &wq);
+					  &dentry->d_name);
 		if (IS_ERR(dentry))
 			return PTR_ERR(dentry);
 		if (unlikely(!d_in_lookup(dentry)))
diff --git a/fs/nfs/unlink.c b/fs/nfs/unlink.c
index bf77399696a7..d44162d3a8f1 100644
--- a/fs/nfs/unlink.c
+++ b/fs/nfs/unlink.c
@@ -124,7 +124,7 @@ static int nfs_call_unlink(struct dentry *dentry, struct inode *inode, struct nf
 	struct dentry *alias;
 
 	down_read_non_owner(&NFS_I(dir)->rmdir_sem);
-	alias = d_alloc_parallel(dentry->d_parent, &data->args.name, &data->wq);
+	alias = d_alloc_parallel(dentry->d_parent, &data->args.name);
 	if (IS_ERR(alias)) {
 		up_read_non_owner(&NFS_I(dir)->rmdir_sem);
 		return 0;
@@ -185,7 +185,6 @@ nfs_async_unlink(struct dentry *dentry, const struct qstr *name)
 
 	data->cred = get_current_cred();
 	data->res.dir_attr = &data->dir_attr;
-	init_waitqueue_head(&data->wq);
 
 	status = -EBUSY;
 	spin_lock(&dentry->d_lock);
diff --git a/fs/proc/base.c b/fs/proc/base.c
index cd89e956c322..c8bcbdac87d5 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2126,8 +2126,7 @@ bool proc_fill_cache(struct file *file, struct dir_context *ctx,
 
 	child = d_hash_and_lookup(dir, &qname);
 	if (!child) {
-		DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
-		child = d_alloc_parallel(dir, &qname, &wq);
+		child = d_alloc_parallel(dir, &qname);
 		if (IS_ERR(child))
 			goto end_instantiate;
 		if (d_in_lookup(child)) {
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index cc9d74a06ff0..9f1088f138f4 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -693,8 +693,7 @@ static bool proc_sys_fill_cache(struct file *file,
 
 	child = d_lookup(dir, &qname);
 	if (!child) {
-		DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
-		child = d_alloc_parallel(dir, &qname, &wq);
+		child = d_alloc_parallel(dir, &qname);
 		if (IS_ERR(child))
 			return false;
 		if (d_in_lookup(child)) {
diff --git a/fs/smb/client/readdir.c b/fs/smb/client/readdir.c
index 50f96259d9ad..39d8a18cd443 100644
--- a/fs/smb/client/readdir.c
+++ b/fs/smb/client/readdir.c
@@ -73,7 +73,6 @@ cifs_prime_dcache(struct dentry *parent, struct qstr *name,
 	struct cifs_sb_info *cifs_sb = CIFS_SB(sb);
 	bool posix = cifs_sb_master_tcon(cifs_sb)->posix_extensions;
 	bool reparse_need_reval = false;
-	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 	int rc;
 
 	cifs_dbg(FYI, "%s: for %s\n", __func__, name->name);
@@ -105,7 +104,7 @@ cifs_prime_dcache(struct dentry *parent, struct qstr *name,
 		    (fattr->cf_flags & CIFS_FATTR_NEED_REVAL))
 			return;
 
-		dentry = d_alloc_parallel(parent, name, &wq);
+		dentry = d_alloc_parallel(parent, name);
 	}
 	if (IS_ERR(dentry))
 		return;
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 4afb60365675..b03cbb0177a3 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -247,8 +247,7 @@ extern void d_set_d_op(struct dentry *dentry, const struct dentry_operations *op
 /* allocate/de-allocate */
 extern struct dentry * d_alloc(struct dentry *, const struct qstr *);
 extern struct dentry * d_alloc_anon(struct super_block *);
-extern struct dentry * d_alloc_parallel(struct dentry *, const struct qstr *,
-					wait_queue_head_t *);
+extern struct dentry * d_alloc_parallel(struct dentry *, const struct qstr *);
 extern struct dentry * d_splice_alias(struct inode *, struct dentry *);
 extern struct dentry * d_add_ci(struct dentry *, struct inode *, struct qstr *);
 extern bool d_same_name(const struct dentry *dentry, const struct dentry *parent,
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 9155a6ffc370..d0473e0d4aba 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1731,7 +1731,6 @@ struct nfs_unlinkdata {
 	struct nfs_removeargs args;
 	struct nfs_removeres res;
 	struct dentry *dentry;
-	wait_queue_head_t wq;
 	const struct cred *cred;
 	struct nfs_fattr dir_attr;
 	long timeout;
-- 
2.47.1


