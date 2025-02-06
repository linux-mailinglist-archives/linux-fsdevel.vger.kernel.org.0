Return-Path: <linux-fsdevel+bounces-41018-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 757E8A2A05F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 06:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0287E1622B6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 05:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BEB7224AFF;
	Thu,  6 Feb 2025 05:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Gmvi1V8G";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="k27+SP4+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="A21FoqMN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5AhaRVvX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C20158536;
	Thu,  6 Feb 2025 05:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738820883; cv=none; b=sXNm/z93aprrppee3twodcnwz5wBOV0NSxwMk46wMDa5QDhr7CYbI0VTpcNpNs5rmu9XqdL7dOhvvvzfLmV4qg56KdkgMXwXsMBqOMdYaQ5rnc+x7bgF12EcO/AnJTgpaicUERQq3s4TdUIaPDy8dWovm40DuyFC4dsOC/kVO64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738820883; c=relaxed/simple;
	bh=dcBHscAnQxKr/0nixkVMiN0m1RDGzqYV4BOPx4PsCVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AzXjluaVm828V9nrCb7VNz5AjAMh9nkVat5cq/fVlX43HtckmKZzql/ZTdT/hGb76zykYmuXo1bdLWWXfdtFUIJoN6m97S42x9uehwuDkEtp+zK6uET5/FaL7QWM3R25Rv+Pn+m/vYnTHKJy/yMK2Iy6cawQ2grGXurNtpLDsF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Gmvi1V8G; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=k27+SP4+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=A21FoqMN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5AhaRVvX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 288A01F381;
	Thu,  6 Feb 2025 05:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738820880; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gp0yvQZM52mSZiy5KRCGCyZJi/VYmp29uzHrGPUicVM=;
	b=Gmvi1V8Gi9T3VHZtuepi9KDpxKp403SrAneN/OG19Okg+UCG36YK+w3g4YVLv0HNc0uePk
	y8yn2P6EgtuJsunDf+eH60A7U8PyWtEhbSojjV+GSyv2itXFq3cfNTvZm/ITK0AD+ISNFc
	4IYIWTzPvWtr/ihIOwvLckujbt0sudA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738820880;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gp0yvQZM52mSZiy5KRCGCyZJi/VYmp29uzHrGPUicVM=;
	b=k27+SP4+IhZudppgZmpoRETTCKG7D2j12R1I7CbW4mAUUktYwpTpcKhd9r8bc0iLiz5tqF
	0dzfFA3/1yhmOAAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=A21FoqMN;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=5AhaRVvX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738820879; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gp0yvQZM52mSZiy5KRCGCyZJi/VYmp29uzHrGPUicVM=;
	b=A21FoqMNvTDoUB4C4831tj2CZdF8o+cdPjV+33r/mqcS/5ro49/1QtKOkc2P8rsQNdzo+5
	horeCsiDCLlwgLRqEivUod3l2gadZurXF5u/i0qlgLyqNjNeN5qP58l7PwNKEHMM2yO7wh
	ArMebu6MZGpEBvfQrjesBgkcCJnwO9M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738820879;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gp0yvQZM52mSZiy5KRCGCyZJi/VYmp29uzHrGPUicVM=;
	b=5AhaRVvXtm1Ru0iiG2Knn3Y4HMGdUQNeDFM+ShiCfXqMdrfjZzyQCHJ3H2iJnpRuGaIF92
	aybwwRqdQVIPItDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 17EDD13795;
	Thu,  6 Feb 2025 05:47:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CZhPLwtNpGf5BwAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 06 Feb 2025 05:47:55 +0000
From: NeilBrown <neilb@suse.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff Layton <jlayton@kernel.org>,
	Dave Chinner <david@fromorbit.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 16/19] VFS: add lookup_and_lock_rename()
Date: Thu,  6 Feb 2025 16:42:53 +1100
Message-ID: <20250206054504.2950516-17-neilb@suse.de>
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
X-Rspamd-Queue-Id: 288A01F381
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

lookup_and_lock_rename() combines locking and lookup for two names.
It uses the new lock_two_directories_shared() if that is appropriate for
the filesystem.

unlock_rename_shared() does either a shared unlock or an exclusive
unlock depending on how the filesystem wants rename to be handled.

lookup_and_lock_rename_one() and done_lookup_and_lock_rename() are
exported for other modules to use.

As a rename can continue asynchronously after the inode lock is dropped,
lock_two_directories() and lock_two_directories_shared() must ensure
that is not happening before looking at ->d_parent.  This requires a
call to d_update_wait().  Note that is the dentry is locked for update
it must be a rename.  It cannot be a create or a (successful) rmdir as
these dentries are not empty - except possibly the target directory, but
waiting for the rmdir there is still needed of course.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/namei.c            | 230 +++++++++++++++++++++++++++++++++++-------
 include/linux/namei.h |   7 ++
 2 files changed, 199 insertions(+), 38 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index c7b7445c770e..771e9d7b620c 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3451,8 +3451,14 @@ static struct dentry *lock_two_directories(struct dentry *p1, struct dentry *p2)
 {
 	struct dentry *p = p1, *q = p2, *r;
 
-	while ((r = p->d_parent) != p2 && r != p)
+	/* Ensure d_update_wait() tests are safe - one barrier for all */
+	smp_mb();
+
+	d_update_wait(p, I_MUTEX_NORMAL);
+	while ((r = p->d_parent) != p2 && r != p) {
 		p = r;
+		d_update_wait(p, I_MUTEX_NORMAL);
+	}
 	if (r == p2) {
 		// p is a child of p2 and an ancestor of p1 or p1 itself
 		inode_lock_nested(p2->d_inode, I_MUTEX_PARENT);
@@ -3461,8 +3467,11 @@ static struct dentry *lock_two_directories(struct dentry *p1, struct dentry *p2)
 	}
 	// p is the root of connected component that contains p1
 	// p2 does not occur on the path from p to p1
-	while ((r = q->d_parent) != p1 && r != p && r != q)
+	d_update_wait(q, I_MUTEX_NORMAL);
+	while ((r = q->d_parent) != p1 && r != p && r != q) {
 		q = r;
+		d_update_wait(q, I_MUTEX_NORMAL);
+	}
 	if (r == p1) {
 		// q is a child of p1 and an ancestor of p2 or p2 itself
 		inode_lock_nested(p1->d_inode, I_MUTEX_PARENT);
@@ -3479,6 +3488,46 @@ static struct dentry *lock_two_directories(struct dentry *p1, struct dentry *p2)
 	}
 }
 
+static struct dentry *lock_two_directories_shared(struct dentry *p1, struct dentry *p2)
+{
+	struct dentry *p = p1, *q = p2, *r;
+
+	/* Ensure d_update_wait() tests are safe - one barrier for all */
+	smp_mb();
+
+	d_update_wait(p1, I_MUTEX_NORMAL);
+	while ((r = p->d_parent) != p2 && r != p) {
+		p = r;
+		d_update_wait(p, I_MUTEX_NORMAL);
+	}
+	if (r == p2) {
+		// p is a child of p2 and an ancestor of p1 or p1 itself
+		inode_lock_shared_nested(p2->d_inode, I_MUTEX_PARENT);
+		inode_lock_shared_nested(p1->d_inode, I_MUTEX_PARENT2);
+		return p;
+	}
+	// p is the root of connected component that contains p1
+	// p2 does not occur on the path from p to p1
+	d_update_wait(q, I_MUTEX_NORMAL);
+	while ((r = q->d_parent) != p1 && r != p && r != q) {
+		q = r;
+		d_update_wait(q, I_MUTEX_NORMAL);
+	}
+	if (r == p1) {
+		// q is a child of p1 and an ancestor of p2 or p2 itself
+		inode_lock_shared_nested(p1->d_inode, I_MUTEX_PARENT);
+		inode_lock_shared_nested(p2->d_inode, I_MUTEX_PARENT2);
+		return q;
+	} else if (likely(r == p)) {
+		// both p2 and p1 are descendents of p
+		inode_lock_shared_nested(p1->d_inode, I_MUTEX_PARENT);
+		inode_lock_shared_nested(p2->d_inode, I_MUTEX_PARENT2);
+		return NULL;
+	} else { // no common ancestor at the time we'd been called
+		return ERR_PTR(-EXDEV);
+	}
+}
+
 /*
  * p1 and p2 should be directories on the same fs.
  */
@@ -3494,6 +3543,134 @@ struct dentry *lock_rename(struct dentry *p1, struct dentry *p2)
 }
 EXPORT_SYMBOL(lock_rename);
 
+static void unlock_rename_shared(struct dentry *p1, struct dentry *p2)
+{
+	if (!(p1->d_inode->i_flags & S_ASYNC_RENAME))
+		unlock_rename(p1, p2);
+	else {
+		inode_unlock_shared(p1->d_inode);
+		if (p1 != p2) {
+			inode_unlock_shared(p2->d_inode);
+			mutex_unlock(&p1->d_sb->s_vfs_rename_mutex);
+		}
+	}
+}
+
+static int
+lookup_and_lock_rename(struct dentry *p1, struct dentry *p2,
+		       struct dentry **d1p, struct dentry **d2p,
+		       struct qstr *last1, struct qstr *last2,
+		       unsigned int flags1, unsigned int flags2)
+{
+	struct dentry *p = NULL;
+	struct dentry *d1, *d2;
+	bool ok1, ok2;
+
+	if (p1->d_inode->i_flags & S_ASYNC_RENAME) {
+		if (p1 == p2) {
+			/* same parent - only one parent lock needed and
+			 * no s_vfs_rename_mutex */
+			inode_lock_shared_nested(p1->d_inode, I_MUTEX_PARENT);
+		} else {
+			mutex_lock(&p1->d_sb->s_vfs_rename_mutex);
+
+			p = lock_two_directories_shared(p1, p2);
+			if (IS_ERR(p)) {
+				mutex_unlock(&p1->d_sb->s_vfs_rename_mutex);
+				return PTR_ERR(p);
+			}
+		}
+	} else
+		lock_rename(p1, p2);
+retry:
+	d1 = lookup_one_qstr(last1, p1, flags1);
+	if (IS_ERR(d1))
+		goto out_unlock_1;
+	d2 = lookup_one_qstr(last2, p2, flags2);
+	if (IS_ERR(d2))
+		goto out_unlock_2;
+
+	if (d1 == p) {
+		dput(d1); dput(d2);
+		unlock_rename_shared(p1, p2);
+		if (flags1 & LOOKUP_CREATE)
+			return -EINVAL;
+		else
+			return -ENOTEMPTY;
+	}
+
+	if (d2 == p) {
+		dput(d1); dput(d2);
+		unlock_rename_shared(p1, p2);
+		if (flags2 & LOOKUP_CREATE)
+			return -EINVAL;
+		else
+			return -ENOTEMPTY;
+	}
+
+	if (d1 < d2) {
+		ok1 = d_update_lock(d1, p1, last1, I_MUTEX_PARENT);
+		ok2 = d_update_lock(d2, p2, last2, I_MUTEX_PARENT2);
+	} else if (d1 > d2) {
+		ok2 = d_update_lock(d2, p2, last2, I_MUTEX_PARENT);
+		ok1 = d_update_lock(d1, p1, last1, I_MUTEX_PARENT2);
+	} else {
+		ok1 = ok2 = d_update_lock(d1, p1, last1, I_MUTEX_PARENT);
+	}
+	if (!ok1 || !ok2) {
+		if (ok1)
+			d_update_unlock(d1);
+		if (ok2 && d2 != d1)
+			d_update_unlock(d2);
+		dput(d1);
+		dput(d2);
+		goto retry;
+	}
+	*d1p = d1; *d2p = d2;
+	return 0;
+
+out_unlock_2:
+	dput(d1);
+	d1 = d2;
+out_unlock_1:
+	unlock_rename_shared(p1, p2);
+	return PTR_ERR(d1);
+}
+
+int lookup_and_lock_rename_one(struct dentry *p1, struct dentry *p2,
+			       struct dentry **d1p, struct dentry **d2p,
+			       const char *name1, int nlen1,
+			       const char *name2, int nlen2,
+			       unsigned int flags1, unsigned int flags2)
+{
+	struct qstr this1, this2;
+	int err;
+
+	err = lookup_one_common(&nop_mnt_idmap, name1, p1, nlen1, &this1);
+	if (err)
+		return err;
+	err = lookup_one_common(&nop_mnt_idmap, name2, p2, nlen2, &this2);
+	if (err)
+		return err;
+	return lookup_and_lock_rename(p1, p2, d1p, d2p, &this1, &this2,
+				      flags1, flags2);
+}
+EXPORT_SYMBOL(lookup_and_lock_rename_one);
+
+void done_lookup_and_lock_rename(struct dentry *p1, struct dentry *p2,
+				 struct dentry *d1, struct dentry *d2)
+{
+	d_lookup_done(d1);
+	d_lookup_done(d2);
+	d_update_unlock(d1);
+	if (d2 != d1)
+		d_update_unlock(d2);
+	unlock_rename_shared(p1, p2);
+	dput(d1);
+	dput(d2);
+}
+EXPORT_SYMBOL(done_lookup_and_lock_rename);
+
 /*
  * c1 and p2 should be on the same fs.
  */
@@ -5497,7 +5674,6 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
 {
 	struct renamedata rd;
 	struct dentry *old_dentry, *new_dentry;
-	struct dentry *trap;
 	struct path old_path, new_path;
 	struct qstr old_last, new_last;
 	int old_type, new_type;
@@ -5548,51 +5724,33 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
 		goto exit2;
 
 retry_deleg:
-	trap = lock_rename(new_path.dentry, old_path.dentry);
-	if (IS_ERR(trap)) {
-		error = PTR_ERR(trap);
+	error = lookup_and_lock_rename(old_path.dentry, new_path.dentry,
+				       &old_dentry, &new_dentry,
+				       &old_last, &new_last,
+				       lookup_flags, lookup_flags | target_flags);
+	if (error)
 		goto exit_lock_rename;
-	}
 
-	old_dentry = lookup_one_qstr(&old_last, old_path.dentry,
-				     lookup_flags);
-	error = PTR_ERR(old_dentry);
-	if (IS_ERR(old_dentry))
-		goto exit3;
-	new_dentry = lookup_one_qstr(&new_last, new_path.dentry,
-				     lookup_flags | target_flags);
-	error = PTR_ERR(new_dentry);
-	if (IS_ERR(new_dentry))
-		goto exit4;
 	if (flags & RENAME_EXCHANGE) {
 		if (!d_is_dir(new_dentry)) {
 			error = -ENOTDIR;
 			if (new_last.name[new_last.len])
-				goto exit5;
+				goto exit_unlock;
 		}
 	}
 	/* unless the source is a directory trailing slashes give -ENOTDIR */
 	if (!d_is_dir(old_dentry)) {
 		error = -ENOTDIR;
 		if (old_last.name[old_last.len])
-			goto exit5;
+			goto exit_unlock;
 		if (!(flags & RENAME_EXCHANGE) && new_last.name[new_last.len])
-			goto exit5;
-	}
-	/* source should not be ancestor of target */
-	error = -EINVAL;
-	if (old_dentry == trap)
-		goto exit5;
-	/* target should not be an ancestor of source */
-	if (!(flags & RENAME_EXCHANGE))
-		error = -ENOTEMPTY;
-	if (new_dentry == trap)
-		goto exit5;
+			goto exit_unlock;
+	}
 
 	error = security_path_rename(&old_path, old_dentry,
 				     &new_path, new_dentry, flags);
 	if (error)
-		goto exit5;
+		goto exit_unlock;
 
 	rd.old_dir	   = old_path.dentry->d_inode;
 	rd.old_dentry	   = old_dentry;
@@ -5603,13 +5761,9 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
 	rd.delegated_inode = &delegated_inode;
 	rd.flags	   = flags;
 	error = vfs_rename(&rd);
-exit5:
-	d_lookup_done(new_dentry);
-	dput(new_dentry);
-exit4:
-	dput(old_dentry);
-exit3:
-	unlock_rename(new_path.dentry, old_path.dentry);
+exit_unlock:
+	done_lookup_and_lock_rename(new_path.dentry, old_path.dentry,
+				    new_dentry, old_dentry);
 exit_lock_rename:
 	if (delegated_inode) {
 		error = break_deleg_wait(&delegated_inode);
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 72e351640406..8ef7aa6ed64c 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -104,6 +104,13 @@ extern int follow_up(struct path *);
 extern struct dentry *lock_rename(struct dentry *, struct dentry *);
 extern struct dentry *lock_rename_child(struct dentry *, struct dentry *);
 extern void unlock_rename(struct dentry *, struct dentry *);
+int lookup_and_lock_rename_one(struct dentry *p1, struct dentry *p2,
+			       struct dentry **d1p, struct dentry **d2p,
+			       const char *name1, int nlen1,
+			       const char *name2, int nlen2,
+			       unsigned int flags1, unsigned int flags2);
+void done_lookup_and_lock_rename(struct dentry *p1, struct dentry *p2,
+				struct dentry *d1, struct dentry *d2);
 
 /**
  * mode_strip_umask - handle vfs umask stripping
-- 
2.47.1


