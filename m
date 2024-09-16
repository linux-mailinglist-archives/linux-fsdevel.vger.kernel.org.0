Return-Path: <linux-fsdevel+bounces-29433-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB62979A66
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 06:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F536B22CF9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 04:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1DC2209F;
	Mon, 16 Sep 2024 04:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oVbOUF4E";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="e/b2wQGG";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Mt54R6LP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1sstr+PJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014771BC58;
	Mon, 16 Sep 2024 04:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726461318; cv=none; b=nSCPOJdy47qWaEWcYRnyEn9MoAu+4/SW4aETt4yboHE1795FK5Oxw5OsWzP1KJGxNZ6NaFHaHIjx/o44m836LRB37d0Zj3JVaIOt7d8a3PcUtdzfcdHK/29HfrIhFQ6xECkViSA8BRBRXo/cTIhQ347iJud0EZ7bKKRSaHug93Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726461318; c=relaxed/simple;
	bh=nHoLAyX4zZSezM+zjEdPKxZ4oHcVClEoTmbW8cA53h8=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-id; b=cCt4SZpAA9F811mjyyqlURUFSMb+u0JuJT/BrBuMvrBPyDHKXiFKfzmt169pWHhxEozsXQlEdZyMTC6lvLJoJ/4oF4qud6UJix0wJDvzr5QefDexf1K49hxcQdzF3t5kkJ7an1BSyGh12bJ/uMWBFQv1ZwWxknz5UeA5hWdHvOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oVbOUF4E; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=e/b2wQGG; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Mt54R6LP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1sstr+PJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E3EFF1F84E;
	Mon, 16 Sep 2024 04:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726461314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7dNuTHXZ4WIWGC0E564ffqTTPBBbVw3MMz+tbSK1doI=;
	b=oVbOUF4E9TReDIRPt8Xw8bNtrQlEoC9scr9TNUutzgxP0Kwk9agtmFepZPOrpDvIiddAgY
	2vVZ3dLPXn4AX3W3Upu9cQZJX8K1OmUINZymOkxpi9N6yGcKfUXselC3NOC9itpdTguXYp
	RCyhEpniTWkZzbEZxkqABntlwJ2epFg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726461314;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7dNuTHXZ4WIWGC0E564ffqTTPBBbVw3MMz+tbSK1doI=;
	b=e/b2wQGG+nPQQJsyswA8NrxWQ4WmXvVTX2xT6oVy9l+JABzsB/cQMiAfqn4j05P8o756/x
	dvZ/Oo6SX2H80jCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Mt54R6LP;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=1sstr+PJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726461313; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7dNuTHXZ4WIWGC0E564ffqTTPBBbVw3MMz+tbSK1doI=;
	b=Mt54R6LPC42wWf51g7FUEjvdjjuQVcCmiyAdanSH1xtk7XgNhk+vZayM7cdOZ0Lo/1CVT/
	d/CNHEof0C4v2HsVG1doRZjb4wTMjcM5DMmEJEmbpadV1FcNrCj3YY2whERw7S0LqcJ268
	6st5/v76eGw0iAVnzoZtnLKDonWbJLU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726461313;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7dNuTHXZ4WIWGC0E564ffqTTPBBbVw3MMz+tbSK1doI=;
	b=1sstr+PJnCMNxnBjAyuaD+Y4fhA4C1Ml538fEnrBJzJGFkSj3+n1WfPnEiOIIYMwtsNhBS
	7R0jOhJMQvUf90Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3A1AF139CE;
	Mon, 16 Sep 2024 04:35:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2AweOH6152YbfAAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 16 Sep 2024 04:35:10 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: Jeff Layton <jlayton@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>, Olga Kornievskaia <okorniev@redhat.com>,
 linux-nfs@vger.kernel.org
Subject: [PATCH - RFC] VFS: disable new delegations during delegation-breaking
 operations
Date: Mon, 16 Sep 2024 14:34:59 +1000
Message-id: <172646129988.17050.4729474250083101679@noble.neil.brown.name>
X-Rspamd-Queue-Id: E3EFF1F84E
X-Spam-Level: 
X-Spamd-Result: default: False [-6.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -6.51
X-Spam-Flag: NO


Various operations such as rename and unlink must break any delegations
before they proceed.
do_dentry_open() and vfs_truncate(), which use break_lease(), increment
i_writecount and/or i_readcount which blocks delegations until the
counter is decremented, but the various callers of try_break_deleg() do
not impose any such barrier.  They hold the inode lock while performing
the operation which blocks delegations, but must drop it while waiting
for a delegation to be broken, which leaves an opportunity for a new
delegation to be added.

nfsd - the only current user of delegations - records any files on which
it is called to break a delegation in a manner which blocks further
delegations for 30-60 seconds.  This is normally sufficient.  However
there is talk of reducing the timeout and it would be best if operations
that needed delegations to be blocked used something more definitive
than a timer.

This patch adds that definitive blocking by adding a counter to struct
file_lock_context of the number of concurrent operations which require
delegations to be blocked.  check_conflicting_open() checks that counter
when a delegation is requested and denies the delegation if the counter
is elevated.

try_break_deleg() now increments that counter when it records the inode
as a 'delegated_inode'.

break_deleg_wait() now leaves the inode pointer in *delegated_inode when
it signals that the operation should be retried, and then clears it -
decrementing the new counter - when the operation has completed, whether
successfully or not.  To achieve this we now pass the current error
status in to break_deleg_wait().

vfs_rename() now uses two delegated_inode pointers, one for the
source and one for the destination in the case of replacement.  This is
needed as it may be necessary to block further delegations to both
inodes while the rename completes.

The net result is that we no longer depend on the delay that nfsd
imposes on new delegation in order for various functions that break
delegations to be sure that new delegations won't be added while they wait
with the inode unlocked.  This gives more freedom to nfsd to make more
subtle choices about when and for how long to block delegations when
there is no active contention.

try_break_deleg() is possibly now large enough that it shouldn't be
inline.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/locks.c               | 12 ++++++++++--
 fs/namei.c               | 32 ++++++++++++++++++++------------
 fs/open.c                |  8 ++++----
 fs/posix_acl.c           |  8 ++++----
 fs/utimes.c              |  4 ++--
 fs/xattr.c               |  8 ++++----
 include/linux/filelock.h | 31 ++++++++++++++++++++++++-------
 include/linux/fs.h       |  3 ++-
 8 files changed, 70 insertions(+), 36 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index e45cad40f8b6..171628094daa 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -191,6 +191,7 @@ locks_get_lock_context(struct inode *inode, int type)
 	INIT_LIST_HEAD(&ctx->flc_flock);
 	INIT_LIST_HEAD(&ctx->flc_posix);
 	INIT_LIST_HEAD(&ctx->flc_lease);
+	atomic_set(&ctx->flc_deleg_blockers, 0);
=20
 	/*
 	 * Assign the pointer if it's not already assigned. If it is, then
@@ -255,6 +256,7 @@ locks_free_lock_context(struct inode *inode)
 	struct file_lock_context *ctx =3D locks_inode_context(inode);
=20
 	if (unlikely(ctx)) {
+		WARN_ON(atomic_read(&ctx->flc_deleg_blockers) !=3D 0);
 		locks_check_ctx_lists(inode);
 		kmem_cache_free(flctx_cache, ctx);
 	}
@@ -1743,9 +1745,15 @@ check_conflicting_open(struct file *filp, const int ar=
g, int flags)
=20
 	if (flags & FL_LAYOUT)
 		return 0;
-	if (flags & FL_DELEG)
-		/* We leave these checks to the caller */
+	if (flags & FL_DELEG) {
+		struct file_lock_context *ctx =3D locks_inode_context(inode);
+
+		if (ctx && atomic_read(&ctx->flc_deleg_blockers) > 0)
+			return -EAGAIN;
+
+		/* We leave the remaining checks to the caller */
 		return 0;
+	}
=20
 	if (arg =3D=3D F_RDLCK)
 		return inode_is_open_for_write(inode) ? -EAGAIN : 0;
diff --git a/fs/namei.c b/fs/namei.c
index 5512cb10fa89..3054da90276b 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4493,8 +4493,8 @@ int do_unlinkat(int dfd, struct filename *name)
 		iput(inode);	/* truncate the inode here */
 	inode =3D NULL;
 	if (delegated_inode) {
-		error =3D break_deleg_wait(&delegated_inode);
-		if (!error)
+		error =3D break_deleg_wait(&delegated_inode, error);
+		if (error =3D=3D -EWOULDBLOCK)
 			goto retry_deleg;
 	}
 	mnt_drop_write(path.mnt);
@@ -4764,8 +4764,8 @@ int do_linkat(int olddfd, struct filename *old, int new=
dfd,
 out_dput:
 	done_path_create(&new_path, new_dentry);
 	if (delegated_inode) {
-		error =3D break_deleg_wait(&delegated_inode);
-		if (!error) {
+		error =3D break_deleg_wait(&delegated_inode, error);
+		if (error =3D=3D -EWOULDBLOCK) {
 			path_put(&old_path);
 			goto retry;
 		}
@@ -4848,7 +4848,8 @@ int vfs_rename(struct renamedata *rd)
 	struct inode *old_dir =3D rd->old_dir, *new_dir =3D rd->new_dir;
 	struct dentry *old_dentry =3D rd->old_dentry;
 	struct dentry *new_dentry =3D rd->new_dentry;
-	struct inode **delegated_inode =3D rd->delegated_inode;
+	struct inode **delegated_inode_old =3D rd->delegated_inode_old;
+	struct inode **delegated_inode_new =3D rd->delegated_inode_new;
 	unsigned int flags =3D rd->flags;
 	bool is_dir =3D d_is_dir(old_dentry);
 	struct inode *source =3D old_dentry->d_inode;
@@ -4954,12 +4955,12 @@ int vfs_rename(struct renamedata *rd)
 			goto out;
 	}
 	if (!is_dir) {
-		error =3D try_break_deleg(source, delegated_inode);
+		error =3D try_break_deleg(source, delegated_inode_old);
 		if (error)
 			goto out;
 	}
 	if (target && !new_is_dir) {
-		error =3D try_break_deleg(target, delegated_inode);
+		error =3D try_break_deleg(target, delegated_inode_new);
 		if (error)
 			goto out;
 	}
@@ -5011,7 +5012,8 @@ int do_renameat2(int olddfd, struct filename *from, int=
 newdfd,
 	struct path old_path, new_path;
 	struct qstr old_last, new_last;
 	int old_type, new_type;
-	struct inode *delegated_inode =3D NULL;
+	struct inode *delegated_inode_old =3D NULL;
+	struct inode *delegated_inode_new =3D NULL;
 	unsigned int lookup_flags =3D 0, target_flags =3D LOOKUP_RENAME_TARGET;
 	bool should_retry =3D false;
 	int error =3D -EINVAL;
@@ -5118,7 +5120,8 @@ int do_renameat2(int olddfd, struct filename *from, int=
 newdfd,
 	rd.new_dir	   =3D new_path.dentry->d_inode;
 	rd.new_dentry	   =3D new_dentry;
 	rd.new_mnt_idmap   =3D mnt_idmap(new_path.mnt);
-	rd.delegated_inode =3D &delegated_inode;
+	rd.delegated_inode_old =3D &delegated_inode_old;
+	rd.delegated_inode_new =3D &delegated_inode_new;
 	rd.flags	   =3D flags;
 	error =3D vfs_rename(&rd);
 exit5:
@@ -5128,9 +5131,14 @@ int do_renameat2(int olddfd, struct filename *from, in=
t newdfd,
 exit3:
 	unlock_rename(new_path.dentry, old_path.dentry);
 exit_lock_rename:
-	if (delegated_inode) {
-		error =3D break_deleg_wait(&delegated_inode);
-		if (!error)
+	if (delegated_inode_old) {
+		error =3D break_deleg_wait(&delegated_inode_old, error);
+		if (error =3D=3D -EWOULDBLOCK)
+			goto retry_deleg;
+	}
+	if (delegated_inode_new) {
+		error =3D break_deleg_wait(&delegated_inode_new, error);
+		if (error =3D=3D -EWOULDBLOCK)
 			goto retry_deleg;
 	}
 	mnt_drop_write(old_path.mnt);
diff --git a/fs/open.c b/fs/open.c
index 22adbef7ecc2..6b6d20a68dd8 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -656,8 +656,8 @@ int chmod_common(const struct path *path, umode_t mode)
 out_unlock:
 	inode_unlock(inode);
 	if (delegated_inode) {
-		error =3D break_deleg_wait(&delegated_inode);
-		if (!error)
+		error =3D break_deleg_wait(&delegated_inode, error);
+		if (error =3D=3D -EWOULDBLOCK)
 			goto retry_deleg;
 	}
 	mnt_drop_write(path->mnt);
@@ -795,8 +795,8 @@ int chown_common(const struct path *path, uid_t user, gid=
_t group)
 				      &delegated_inode);
 	inode_unlock(inode);
 	if (delegated_inode) {
-		error =3D break_deleg_wait(&delegated_inode);
-		if (!error)
+		error =3D break_deleg_wait(&delegated_inode, error);
+		if (error =3D=3D -EWOULDBLOCK)
 			goto retry_deleg;
 	}
 	return error;
diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 3f87297dbfdb..5eb3635d1067 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -1143,8 +1143,8 @@ int vfs_set_acl(struct mnt_idmap *idmap, struct dentry =
*dentry,
 	inode_unlock(inode);
=20
 	if (delegated_inode) {
-		error =3D break_deleg_wait(&delegated_inode);
-		if (!error)
+		error =3D break_deleg_wait(&delegated_inode, error);
+		if (error =3D=3D -EWOULDBLOCK)
 			goto retry_deleg;
 	}
=20
@@ -1251,8 +1251,8 @@ int vfs_remove_acl(struct mnt_idmap *idmap, struct dent=
ry *dentry,
 	inode_unlock(inode);
=20
 	if (delegated_inode) {
-		error =3D break_deleg_wait(&delegated_inode);
-		if (!error)
+		error =3D break_deleg_wait(&delegated_inode, error);
+		if (error =3D=3D -EWOULDBLOCK)
 			goto retry_deleg;
 	}
=20
diff --git a/fs/utimes.c b/fs/utimes.c
index 3701b3946f88..21b7605551dc 100644
--- a/fs/utimes.c
+++ b/fs/utimes.c
@@ -67,8 +67,8 @@ int vfs_utimes(const struct path *path, struct timespec64 *=
times)
 			      &delegated_inode);
 	inode_unlock(inode);
 	if (delegated_inode) {
-		error =3D break_deleg_wait(&delegated_inode);
-		if (!error)
+		error =3D break_deleg_wait(&delegated_inode, error);
+		if (error =3D=3D -EWOULDBLOCK)
 			goto retry_deleg;
 	}
=20
diff --git a/fs/xattr.c b/fs/xattr.c
index 7672ce5486c5..63e0b067dab9 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -323,8 +323,8 @@ vfs_setxattr(struct mnt_idmap *idmap, struct dentry *dent=
ry,
 	inode_unlock(inode);
=20
 	if (delegated_inode) {
-		error =3D break_deleg_wait(&delegated_inode);
-		if (!error)
+		error =3D break_deleg_wait(&delegated_inode, error);
+		if (error =3D=3D -EWOULDBLOCK)
 			goto retry_deleg;
 	}
 	if (value !=3D orig_value)
@@ -577,8 +577,8 @@ vfs_removexattr(struct mnt_idmap *idmap, struct dentry *d=
entry,
 	inode_unlock(inode);
=20
 	if (delegated_inode) {
-		error =3D break_deleg_wait(&delegated_inode);
-		if (!error)
+		error =3D break_deleg_wait(&delegated_inode, error);
+		if (error =3D=3D -EWOULDBLOCK)
 			goto retry_deleg;
 	}
=20
diff --git a/include/linux/filelock.h b/include/linux/filelock.h
index daee999d05f3..66470ba9658c 100644
--- a/include/linux/filelock.h
+++ b/include/linux/filelock.h
@@ -144,6 +144,7 @@ struct file_lock_context {
 	struct list_head	flc_flock;
 	struct list_head	flc_posix;
 	struct list_head	flc_lease;
+	atomic_t		flc_deleg_blockers;
 };
=20
 #ifdef CONFIG_FILE_LOCKING
@@ -450,21 +451,37 @@ static inline int try_break_deleg(struct inode *inode, =
struct inode **delegated_
 {
 	int ret;
=20
+	if (delegated_inode && *delegated_inode) {
+		if (*delegated_inode =3D=3D inode)
+			/* Don't need to count this */
+			return break_deleg(inode, O_WRONLY|O_NONBLOCK);
+
+		/* inode changed, forget the old one */
+		atomic_dec(&(*delegated_inode)->i_flctx->flc_deleg_blockers);
+		iput(*delegated_inode);
+		*delegated_inode =3D NULL;
+	}
 	ret =3D break_deleg(inode, O_WRONLY|O_NONBLOCK);
 	if (ret =3D=3D -EWOULDBLOCK && delegated_inode) {
 		*delegated_inode =3D inode;
+		atomic_inc(&(*delegated_inode)->i_flctx->flc_deleg_blockers);
 		ihold(inode);
 	}
 	return ret;
 }
=20
-static inline int break_deleg_wait(struct inode **delegated_inode)
+static inline int break_deleg_wait(struct inode **delegated_inode, int ret)
 {
-	int ret;
-
-	ret =3D break_deleg(*delegated_inode, O_WRONLY);
-	iput(*delegated_inode);
-	*delegated_inode =3D NULL;
+	if (ret =3D=3D -EWOULDBLOCK) {
+		ret =3D break_deleg(*delegated_inode, O_WRONLY);
+		if (ret =3D=3D 0)
+			ret =3D -EWOULDBLOCK;
+	}
+	if (ret !=3D -EWOULDBLOCK) {
+		atomic_dec(&(*delegated_inode)->i_flctx->flc_deleg_blockers);
+		iput(*delegated_inode);
+		*delegated_inode =3D NULL;
+	}
 	return ret;
 }
=20
@@ -494,7 +511,7 @@ static inline int try_break_deleg(struct inode *inode, st=
ruct inode **delegated_
 	return 0;
 }
=20
-static inline int break_deleg_wait(struct inode **delegated_inode)
+static inline int break_deleg_wait(struct inode **delegated_inode, int ret)
 {
 	BUG();
 	return 0;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 6ca11e241a24..50957d9e1c2b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1902,7 +1902,8 @@ struct renamedata {
 	struct mnt_idmap *new_mnt_idmap;
 	struct inode *new_dir;
 	struct dentry *new_dentry;
-	struct inode **delegated_inode;
+	struct inode **delegated_inode_old;
+	struct inode **delegated_inode_new;
 	unsigned int flags;
 } __randomize_layout;
=20

base-commit: 98f7e32f20d28ec452afb208f9cffc08448a2652
--=20
2.46.0


