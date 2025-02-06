Return-Path: <linux-fsdevel+bounces-41021-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 440F7A2A065
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 06:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFA5E1883EE9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 05:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAEB22541F;
	Thu,  6 Feb 2025 05:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="J2KRFxQM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zahueyYR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="J2KRFxQM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zahueyYR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16ED1226162;
	Thu,  6 Feb 2025 05:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738820906; cv=none; b=Qpb/4mdiE8xh3AUdRJUYKil31wQEya9qp8nIUsyeKV2f0lVrIy6zY2MLz8dnHFJo2o4X6JlkSpxCt0+cWIRvWfRc9y+fimDTaQvR3IFrdp3HOSqkfYORgmgJwlVdttfzeJ6DRNnBu9FoP4gA7CeHNp5zzSWr9giD1zzSnCqqhUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738820906; c=relaxed/simple;
	bh=dJB9W38a5aAx31v28nz34+/bjN6Z1cb6nXVPJ83bCf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IMpZUXLiOkjRGxUbyE7ThHz8vvFdqUBymTadByTh9evOmJNWZPaQG9PsMC8uoFed512xmfPLHUy6Hq+UtqRWzfuO/BVRy7JDJH/ZbVpH+3husHcu8Ir79IijN7qV9vUIlFtDYVKfBFx8We1xMMB4llJ9Vs2yZKdenfs4DbiF6ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=J2KRFxQM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zahueyYR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=J2KRFxQM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zahueyYR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 51B6521108;
	Thu,  6 Feb 2025 05:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738820902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FyPZVjbuo93GcMVwtHE8Q8fOTDh5z3A5/51maHi8lE8=;
	b=J2KRFxQMhTZxfH6OkHVz6gcDSEI+m75aOLA6BZBp09TQUt5Zu/zUYH2mTq9ejJEfZko7WB
	51h2RMeGkrIfJHN4runP34JozXUaD9kgfRWENYjybs9bST09CY+IYnW/dEXVdZHTWyvWXj
	Jt2BQuC6EvgMFMXxNB21jaHJVLngq4Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738820902;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FyPZVjbuo93GcMVwtHE8Q8fOTDh5z3A5/51maHi8lE8=;
	b=zahueyYR+ke83C3+XhLUIpKggIU1Brf8XGBHh/pQQkmsvpKwjut4AqX5lCXoys8NHgyp6r
	/I0qpRVwLw0P7ZAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=J2KRFxQM;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=zahueyYR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738820902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FyPZVjbuo93GcMVwtHE8Q8fOTDh5z3A5/51maHi8lE8=;
	b=J2KRFxQMhTZxfH6OkHVz6gcDSEI+m75aOLA6BZBp09TQUt5Zu/zUYH2mTq9ejJEfZko7WB
	51h2RMeGkrIfJHN4runP34JozXUaD9kgfRWENYjybs9bST09CY+IYnW/dEXVdZHTWyvWXj
	Jt2BQuC6EvgMFMXxNB21jaHJVLngq4Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738820902;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FyPZVjbuo93GcMVwtHE8Q8fOTDh5z3A5/51maHi8lE8=;
	b=zahueyYR+ke83C3+XhLUIpKggIU1Brf8XGBHh/pQQkmsvpKwjut4AqX5lCXoys8NHgyp6r
	/I0qpRVwLw0P7ZAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 42FBC13795;
	Thu,  6 Feb 2025 05:48:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MlvTOSJNpGcUCAAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 06 Feb 2025 05:48:18 +0000
From: NeilBrown <neilb@suse.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff Layton <jlayton@kernel.org>,
	Dave Chinner <david@fromorbit.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 19/19] nfs: switch to _async for all directory ops.
Date: Thu,  6 Feb 2025 16:42:56 +1100
Message-ID: <20250206054504.2950516-20-neilb@suse.de>
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
X-Rspamd-Queue-Id: 51B6521108
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

nfs doesn't benefit from exclusive locking by the VFS as all directory
ops are sent to the server which does any needed locking.

The interesting part is "silly-rename" which needs to create and lock
another dentry while an unlink or rename is happening.

nfs_sillyrename() now returns that locked dentry and
nfs_sillyrename_finish() is added to unlock it when appropriate.

In order to keep all dentries locked until the operation completes,
nfs_sillyrename() now uses d_exchange() to record the silly rename in
the dcache.  This has to be exported and permitted to work on a negative
second dentry.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/dcache.c            |  5 +++-
 fs/nfs/dir.c           | 55 ++++++++++++++++++++++++------------------
 fs/nfs/internal.h      | 20 +++++++++------
 fs/nfs/nfs3proc.c      | 16 ++++++------
 fs/nfs/nfs4_fs.h       |  2 +-
 fs/nfs/nfs4proc.c      | 16 ++++++------
 fs/nfs/proc.c          | 16 ++++++------
 fs/nfs/unlink.c        | 48 +++++++++++++++++++++++++-----------
 include/linux/namei.h  |  1 -
 include/linux/nfs_fs.h |  3 ---
 10 files changed, 106 insertions(+), 76 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 90dee859d138..203d71eb4789 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2981,7 +2981,9 @@ void d_exchange(struct dentry *dentry1, struct dentry *dentry2)
 	write_seqlock(&rename_lock);
 
 	WARN_ON(!dentry1->d_inode);
-	WARN_ON(!dentry2->d_inode);
+	/* allow dentry2 to be negative so we can do a rename but keep
+	 * both names locked with DCACHE_PAR_UPDATE.
+	 */
 	WARN_ON(IS_ROOT(dentry1));
 	WARN_ON(IS_ROOT(dentry2));
 
@@ -2989,6 +2991,7 @@ void d_exchange(struct dentry *dentry1, struct dentry *dentry2)
 
 	write_sequnlock(&rename_lock);
 }
+EXPORT_SYMBOL(d_exchange);
 
 /**
  * d_ancestor - search for an ancestor
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 2c69ec77d02c..c0116d44a6fc 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1956,10 +1956,14 @@ struct dentry *nfs_lookup(struct inode *dir, struct dentry * dentry, unsigned in
 		return ERR_PTR(-ENAMETOOLONG);
 
 	/*
-	 * If we're doing an exclusive create, optimize away the lookup
-	 * but don't hash the dentry.
+	 * If we're doing an exclusive create, or if this is the target
+	 * of a rename, optimize away the lookup but don't hash the dentry.
+	 * A silly_rename is uniquely marked exclusive (REALLY? FIXME) and a rename target,
+	 * sand it request and explicit lookup.
 	 */
-	if (nfs_is_exclusive_create(dir, flags) || flags & LOOKUP_RENAME_TARGET)
+	if (nfs_is_exclusive_create(dir, flags) || (flags & LOOKUP_RENAME_TARGET &&
+	    ((flags & (LOOKUP_EXCL | LOOKUP_RENAME_TARGET)) !=
+	     (LOOKUP_EXCL | LOOKUP_RENAME_TARGET))))
 		return NULL;
 
 	res = ERR_PTR(-ENOMEM);
@@ -2057,7 +2061,7 @@ static int nfs_finish_open(struct nfs_open_context *ctx,
 
 int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
 		    struct file *file, unsigned open_flags,
-		    umode_t mode)
+		    umode_t mode, struct dirop_ret *ret)
 {
 	struct nfs_open_context *ctx;
 	struct dentry *res;
@@ -2256,7 +2260,7 @@ nfs4_lookup_revalidate(struct inode *dir, const struct qstr *name,
 
 int nfs_atomic_open_v23(struct inode *dir, struct dentry *dentry,
 			struct file *file, unsigned int open_flags,
-			umode_t mode)
+			umode_t mode, struct dirop_ret *ret)
 {
 
 	/* Same as look+open from lookup_open(), but with different O_TRUNC
@@ -2383,7 +2387,8 @@ static int nfs_do_create(struct inode *dir, struct dentry *dentry,
 }
 
 int nfs_create(struct mnt_idmap *idmap, struct inode *dir,
-	       struct dentry *dentry, umode_t mode, bool excl)
+	       struct dentry *dentry, umode_t mode, bool excl,
+	       struct dirop_ret *ret)
 {
 	return nfs_do_create(dir, dentry, mode, excl ? O_EXCL : 0);
 }
@@ -2394,7 +2399,8 @@ EXPORT_SYMBOL_GPL(nfs_create);
  */
 int
 nfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
-	  struct dentry *dentry, umode_t mode, dev_t rdev)
+	  struct dentry *dentry, umode_t mode, dev_t rdev,
+	  struct dirop_ret *ret)
 {
 	struct iattr attr;
 	int status;
@@ -2466,7 +2472,7 @@ static void nfs_dentry_remove_handle_error(struct inode *dir,
 	}
 }
 
-int nfs_rmdir(struct inode *dir, struct dentry *dentry)
+int nfs_rmdir(struct inode *dir, struct dentry *dentry, struct dirop_ret *ret)
 {
 	int error;
 
@@ -2535,7 +2541,7 @@ static int nfs_safe_remove(struct dentry *dentry)
  *
  *  If sillyrename() returns 0, we do nothing, otherwise we unlink.
  */
-int nfs_unlink(struct inode *dir, struct dentry *dentry)
+int nfs_unlink(struct inode *dir, struct dentry *dentry, struct dirop_ret *ret)
 {
 	int error;
 
@@ -2546,10 +2552,14 @@ int nfs_unlink(struct inode *dir, struct dentry *dentry)
 	spin_lock(&dentry->d_lock);
 	if (d_count(dentry) > 1 && !test_bit(NFS_INO_PRESERVE_UNLINKED,
 					     &NFS_I(d_inode(dentry))->flags)) {
+		struct dentry *silly;
+
 		spin_unlock(&dentry->d_lock);
 		/* Start asynchronous writeout of the inode */
 		write_inode_now(d_inode(dentry), 0);
-		error = nfs_sillyrename(dir, dentry);
+		silly = nfs_sillyrename(dir, dentry);
+		nfs_sillyrename_finish(silly);
+		error = PTR_ERR_OR_ZERO(silly);
 		goto out;
 	}
 	/* We must prevent any concurrent open until the unlink
@@ -2591,7 +2601,7 @@ EXPORT_SYMBOL_GPL(nfs_unlink);
  * and move the raw page into its mapping.
  */
 int nfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
-		struct dentry *dentry, const char *symname)
+		struct dentry *dentry, const char *symname, struct dirop_ret *ret)
 {
 	struct folio *folio;
 	char *kaddr;
@@ -2647,7 +2657,8 @@ int nfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 EXPORT_SYMBOL_GPL(nfs_symlink);
 
 int
-nfs_link(struct dentry *old_dentry, struct inode *dir, struct dentry *dentry)
+nfs_link(struct dentry *old_dentry, struct inode *dir, struct dentry *dentry,
+	 struct dirop_ret *ret)
 {
 	struct inode *inode = d_inode(old_dentry);
 	int error;
@@ -2688,7 +2699,7 @@ nfs_unblock_rename(struct rpc_task *task, struct nfs_renamedata *data)
  * file in old_dir will go away when the last process iput()s the inode.
  *
  * FIXED.
- * 
+ *
  * It actually works quite well. One needs to have the possibility for
  * at least one ".nfs..." file in each directory the file ever gets
  * moved or linked to which happens automagically with the new
@@ -2704,7 +2715,8 @@ nfs_unblock_rename(struct rpc_task *task, struct nfs_renamedata *data)
  */
 int nfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	       struct dentry *old_dentry, struct inode *new_dir,
-	       struct dentry *new_dentry, unsigned int flags)
+	       struct dentry *new_dentry, unsigned int flags,
+	       struct dirop_ret *ret)
 {
 	struct inode *old_inode = d_inode(old_dentry);
 	struct inode *new_inode = d_inode(new_dentry);
@@ -2744,16 +2756,12 @@ int nfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 
 			spin_unlock(&new_dentry->d_lock);
 
-			/* copy the target dentry's name */
-			dentry = d_alloc(new_dentry->d_parent,
-					 &new_dentry->d_name);
-			if (!dentry)
-				goto out;
-
 			/* silly-rename the existing target ... */
-			err = nfs_sillyrename(new_dir, new_dentry);
-			if (err)
+			dentry = nfs_sillyrename(new_dir, new_dentry);
+			if (IS_ERR(dentry)) {
+				err = PTR_ERR(dentry);
 				goto out;
+			}
 
 			new_dentry = dentry;
 			new_inode = NULL;
@@ -2811,9 +2819,8 @@ int nfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	} else if (error == -ENOENT)
 		nfs_dentry_handle_enoent(old_dentry);
 
-	/* new dentry created? */
 	if (dentry)
-		dput(dentry);
+		nfs_sillyrename_finish(dentry);
 	return error;
 }
 EXPORT_SYMBOL_GPL(nfs_rename);
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index f7dea7fe5ebc..ba00ffeb70ac 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -399,18 +399,21 @@ extern unsigned long nfs_access_cache_scan(struct shrinker *shrink,
 struct dentry *nfs_lookup(struct inode *, struct dentry *, unsigned int);
 void nfs_d_prune_case_insensitive_aliases(struct inode *inode);
 int nfs_create(struct mnt_idmap *, struct inode *, struct dentry *,
-	       umode_t, bool);
+	       umode_t, bool, struct dirop_ret *);
 struct dentry *nfs_mkdir(struct mnt_idmap *, struct inode *, struct dentry *,
 			 umode_t, struct dirop_ret *);
-int nfs_rmdir(struct inode *, struct dentry *);
-int nfs_unlink(struct inode *, struct dentry *);
+int nfs_rmdir(struct inode *, struct dentry *, struct dirop_ret *);
+int nfs_unlink(struct inode *, struct dentry *, struct dirop_ret *);
 int nfs_symlink(struct mnt_idmap *, struct inode *, struct dentry *,
-		const char *);
-int nfs_link(struct dentry *, struct inode *, struct dentry *);
+		const char *, struct dirop_ret *);
+int nfs_link(struct dentry *, struct inode *, struct dentry *, struct dirop_ret *);
 int nfs_mknod(struct mnt_idmap *, struct inode *, struct dentry *, umode_t,
-	      dev_t);
+	      dev_t, struct dirop_ret *);
 int nfs_rename(struct mnt_idmap *, struct inode *, struct dentry *,
-	       struct inode *, struct dentry *, unsigned int);
+	       struct inode *, struct dentry *, unsigned int, struct dirop_ret *);
+int nfs_atomic_open_v23(struct inode *dir, struct dentry *dentry,
+			struct file *file, unsigned int open_flags,
+			umode_t mode, struct dirop_ret *);
 
 #ifdef CONFIG_NFS_V4_2
 static inline __u32 nfs_access_xattr_mask(const struct nfs_server *server)
@@ -707,7 +710,8 @@ extern struct rpc_task *
 nfs_async_rename(struct inode *old_dir, struct inode *new_dir,
 		 struct dentry *old_dentry, struct dentry *new_dentry,
 		 void (*complete)(struct rpc_task *, struct nfs_renamedata *));
-extern int nfs_sillyrename(struct inode *dir, struct dentry *dentry);
+extern struct dentry *nfs_sillyrename(struct inode *dir, struct dentry *dentry);
+extern void nfs_sillyrename_finish(struct dentry *dentry);
 
 /* direct.c */
 void nfs_init_cinfo_from_dreq(struct nfs_commit_info *cinfo,
diff --git a/fs/nfs/nfs3proc.c b/fs/nfs/nfs3proc.c
index 41797cbbb8dc..833e679d0a2b 100644
--- a/fs/nfs/nfs3proc.c
+++ b/fs/nfs/nfs3proc.c
@@ -1032,16 +1032,16 @@ static int nfs3_return_delegation(struct inode *inode)
 }
 
 static const struct inode_operations nfs3_dir_inode_operations = {
-	.create		= nfs_create,
-	.atomic_open	= nfs_atomic_open_v23,
+	.create_async	= nfs_create,
+	.atomic_open_async = nfs_atomic_open_v23,
 	.lookup		= nfs_lookup,
-	.link		= nfs_link,
-	.unlink		= nfs_unlink,
-	.symlink	= nfs_symlink,
+	.link_async	= nfs_link,
+	.unlink_async	= nfs_unlink,
+	.symlink_async	= nfs_symlink,
 	.mkdir_async	= nfs_mkdir,
-	.rmdir		= nfs_rmdir,
-	.mknod		= nfs_mknod,
-	.rename		= nfs_rename,
+	.rmdir_async	= nfs_rmdir,
+	.mknod_async	= nfs_mknod,
+	.rename_async	= nfs_rename,
 	.permission	= nfs_permission,
 	.getattr	= nfs_getattr,
 	.setattr	= nfs_setattr,
diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index 7d383d29a995..65fbcef5830e 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -273,7 +273,7 @@ extern const struct dentry_operations nfs4_dentry_operations;
 
 /* dir.c */
 int nfs_atomic_open(struct inode *, struct dentry *, struct file *,
-		    unsigned, umode_t);
+		    unsigned, umode_t, struct dirop_ret *);
 
 /* fs_context.c */
 extern struct file_system_type nfs4_fs_type;
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index ef219968ed22..4fd312838bd3 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -10878,16 +10878,16 @@ static void nfs4_disable_swap(struct inode *inode)
 }
 
 static const struct inode_operations nfs4_dir_inode_operations = {
-	.create		= nfs_create,
+	.create_async	= nfs_create,
 	.lookup		= nfs_lookup,
-	.atomic_open	= nfs_atomic_open,
-	.link		= nfs_link,
-	.unlink		= nfs_unlink,
-	.symlink	= nfs_symlink,
+	.atomic_open_async = nfs_atomic_open,
+	.link_async	= nfs_link,
+	.unlink_async	= nfs_unlink,
+	.symlink_async	= nfs_symlink,
 	.mkdir_async	= nfs_mkdir,
-	.rmdir		= nfs_rmdir,
-	.mknod		= nfs_mknod,
-	.rename		= nfs_rename,
+	.rmdir_async	= nfs_rmdir,
+	.mknod_async	= nfs_mknod,
+	.rename_async	= nfs_rename,
 	.permission	= nfs_permission,
 	.getattr	= nfs_getattr,
 	.setattr	= nfs_setattr,
diff --git a/fs/nfs/proc.c b/fs/nfs/proc.c
index 7e8f6d8f02b4..211edd9f5115 100644
--- a/fs/nfs/proc.c
+++ b/fs/nfs/proc.c
@@ -704,16 +704,16 @@ static int nfs_return_delegation(struct inode *inode)
 }
 
 static const struct inode_operations nfs_dir_inode_operations = {
-	.create		= nfs_create,
+	.create_async	= nfs_create,
 	.lookup		= nfs_lookup,
-	.atomic_open	= nfs_atomic_open_v23,
-	.link		= nfs_link,
-	.unlink		= nfs_unlink,
-	.symlink	= nfs_symlink,
+	.atomic_open_async = nfs_atomic_open_v23,
+	.link_async	= nfs_link,
+	.unlink_async	= nfs_unlink,
+	.symlink_async	= nfs_symlink,
 	.mkdir_async	= nfs_mkdir,
-	.rmdir		= nfs_rmdir,
-	.mknod		= nfs_mknod,
-	.rename		= nfs_rename,
+	.rmdir_async	= nfs_rmdir,
+	.mknod_async	= nfs_mknod,
+	.rename_async	= nfs_rename,
 	.permission	= nfs_permission,
 	.getattr	= nfs_getattr,
 	.setattr	= nfs_setattr,
diff --git a/fs/nfs/unlink.c b/fs/nfs/unlink.c
index d44162d3a8f1..06b71ec9520c 100644
--- a/fs/nfs/unlink.c
+++ b/fs/nfs/unlink.c
@@ -430,6 +430,10 @@ nfs_complete_sillyrename(struct rpc_task *task, struct nfs_renamedata *data)
  *
  * The final cleanup is done during dentry_iput.
  *
+ * We exchange the original with the new (silly) dentries, and return
+ * the new dentry which will now have the original name.  This ensures that
+ * the target name remains locked until the rename completes.
+ *
  * (Note: NFSv4 is stateful, and has opens, so in theory an NFSv4 server
  * could take responsibility for keeping open files referenced.  The server
  * would also need to ensure that opened-but-deleted files were kept over
@@ -438,7 +442,7 @@ nfs_complete_sillyrename(struct rpc_task *task, struct nfs_renamedata *data)
  * use to advertise that it does this; some day we may take advantage of
  * it.))
  */
-int
+struct dentry *
 nfs_sillyrename(struct inode *dir, struct dentry *dentry)
 {
 	static unsigned int sillycounter;
@@ -447,7 +451,8 @@ nfs_sillyrename(struct inode *dir, struct dentry *dentry)
 	struct dentry *sdentry;
 	struct inode *inode = d_inode(dentry);
 	struct rpc_task *task;
-	int            error = -EBUSY;
+	struct dentry *base;
+	int error = -EBUSY;
 
 	dfprintk(VFS, "NFS: silly-rename(%pd2, ct=%d)\n",
 		dentry, d_count(dentry));
@@ -461,10 +466,11 @@ nfs_sillyrename(struct inode *dir, struct dentry *dentry)
 
 	fileid = NFS_FILEID(d_inode(dentry));
 
+	base = d_find_alias(dir);
 	sdentry = NULL;
 	do {
 		int slen;
-		dput(sdentry);
+
 		sillycounter++;
 		slen = scnprintf(silly, sizeof(silly),
 				SILLYNAME_PREFIX "%0*llx%0*x",
@@ -474,14 +480,19 @@ nfs_sillyrename(struct inode *dir, struct dentry *dentry)
 		dfprintk(VFS, "NFS: trying to rename %pd to %s\n",
 				dentry, silly);
 
-		sdentry = lookup_one_len(silly, dentry->d_parent, slen);
-		/*
-		 * N.B. Better to return EBUSY here ... it could be
-		 * dangerous to delete the file while it's in use.
-		 */
-		if (IS_ERR(sdentry))
-			goto out;
-	} while (d_inode(sdentry) != NULL); /* need negative lookup */
+		sdentry = lookup_and_lock_one(NULL, silly, slen,
+					      base,
+					      LOOKUP_CREATE | LOOKUP_EXCL
+					      | LOOKUP_RENAME_TARGET
+					      | LOOKUP_PARENT_LOCKED);
+	} while (PTR_ERR_OR_ZERO(sdentry) == -EEXIST); /* need negative lookup */
+	dput(base);
+	/*
+	 * N.B. Better to return EBUSY here ... it could be
+	 * dangerous to delete the file while it's in use.
+	 */
+	if (IS_ERR(sdentry))
+		goto out;
 
 	ihold(inode);
 
@@ -515,7 +526,7 @@ nfs_sillyrename(struct inode *dir, struct dentry *dentry)
 						     NFS_INO_INVALID_CTIME |
 						     NFS_INO_REVAL_FORCED);
 		spin_unlock(&inode->i_lock);
-		d_move(dentry, sdentry);
+		d_exchange(dentry, sdentry);
 		break;
 	case -ERESTARTSYS:
 		/* The result of the rename is unknown. Play it safe by
@@ -526,7 +537,16 @@ nfs_sillyrename(struct inode *dir, struct dentry *dentry)
 	rpc_put_task(task);
 out_dput:
 	iput(inode);
-	dput(sdentry);
+	if (!error)
+		return dentry;
+	done_lookup_and_lock(NULL, sdentry, LOOKUP_PARENT_LOCKED);
+
 out:
-	return error;
+	return ERR_PTR(error);
+}
+
+void nfs_sillyrename_finish(struct dentry *dentry)
+{
+	if (!IS_ERR(dentry))
+		done_lookup_and_lock(NULL, dentry, LOOKUP_PARENT_LOCKED);
 }
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 8ef7aa6ed64c..29903e2cdf97 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -95,7 +95,6 @@ struct dentry *__lookup_and_lock_one(struct mnt_idmap *idmap,
 				     unsigned int lookup_flags);
 void done_lookup_and_lock(struct dentry *base, struct dentry *dentry,
 			  unsigned int lookup_flags);
-void __done_lookup_and_lock(struct dentry *dentry);
 
 extern int follow_down_one(struct path *);
 extern int follow_down(struct path *path, unsigned int flags);
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 67ae2c3f41d2..6f9f4adfdf4c 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -579,9 +579,6 @@ extern int nfs_may_open(struct inode *inode, const struct cred *cred, int openfl
 extern void nfs_access_zap_cache(struct inode *inode);
 extern int nfs_access_get_cached(struct inode *inode, const struct cred *cred,
 				 u32 *mask, bool may_block);
-extern int nfs_atomic_open_v23(struct inode *dir, struct dentry *dentry,
-			       struct file *file, unsigned int open_flags,
-			       umode_t mode);
 
 /*
  * linux/fs/nfs/symlink.c
-- 
2.47.1


