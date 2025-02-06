Return-Path: <linux-fsdevel+bounces-41005-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7B7A2A045
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 06:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7083E3A7E7E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 05:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A712248B3;
	Thu,  6 Feb 2025 05:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PElTk/1U";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jDPXUkMD";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PElTk/1U";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jDPXUkMD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01911223326;
	Thu,  6 Feb 2025 05:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738820756; cv=none; b=mAT0M0YWHC8cItP18dhGSzCOxuObVG/AE7c2zNt76A6afN4pk1P4K3DqeU37Pp5FXRI+raFfV5XbBFMLoVGMXEAjGEmAFtfP6JwORkjVSIPBRVm7wVzzryCWsWU8Pg7Y1IwI+Bx3JVFEN8EO2shczliP+6X/5IKed0qIGdbEwbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738820756; c=relaxed/simple;
	bh=GQsP3oUsMZBcSdxCqZVtkC71SFLhhLzFmy3z7fFKcg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W4uxcbmZhTDRq9Qh7u/uAZm7HgBjkGJY9CVjX/ROw9+QH12b984M6C+frlNUYgr+CRORsc1UId1yWOENjy8qXbqsi6vUEir6iAYOOqWboLaV2JbgmcrM0SvuSKq35gPBG++fxAdDzf31txX+qOGwqC1LcR+91S8oOUSQjPGJTrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PElTk/1U; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jDPXUkMD; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PElTk/1U; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jDPXUkMD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 01CE11F381;
	Thu,  6 Feb 2025 05:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738820753; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DpRrOyHext/vKwSVHPvryUafdoA8729VpIBcf15u5hs=;
	b=PElTk/1UtEhyEl4c3urC3M3tsst2UfqiVeyxF8WArIIJthbzDknTwK9dUBJtIn9+xvFoEQ
	UzvLorrt52p3mENGcc14wceWCCNHxbtBPNXT6/4xB5+23gv/Thqtlttv2+JRZRwnf2oPu/
	TRfM08pIzBpHCchHP6AtkLZTvAiAU3s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738820753;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DpRrOyHext/vKwSVHPvryUafdoA8729VpIBcf15u5hs=;
	b=jDPXUkMD3jqZBXgT93yBd/R5KuvaLbCi3tjG4YR/LxsOJI7Qgx+vOKGJuH0rQRXw1R3SX4
	SrieCb4N8YPmcQAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738820753; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DpRrOyHext/vKwSVHPvryUafdoA8729VpIBcf15u5hs=;
	b=PElTk/1UtEhyEl4c3urC3M3tsst2UfqiVeyxF8WArIIJthbzDknTwK9dUBJtIn9+xvFoEQ
	UzvLorrt52p3mENGcc14wceWCCNHxbtBPNXT6/4xB5+23gv/Thqtlttv2+JRZRwnf2oPu/
	TRfM08pIzBpHCchHP6AtkLZTvAiAU3s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738820753;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DpRrOyHext/vKwSVHPvryUafdoA8729VpIBcf15u5hs=;
	b=jDPXUkMD3jqZBXgT93yBd/R5KuvaLbCi3tjG4YR/LxsOJI7Qgx+vOKGJuH0rQRXw1R3SX4
	SrieCb4N8YPmcQAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3FFC613795;
	Thu,  6 Feb 2025 05:45:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 39U5OY1MpGdeBwAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 06 Feb 2025 05:45:49 +0000
From: NeilBrown <neilb@suse.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff Layton <jlayton@kernel.org>,
	Dave Chinner <david@fromorbit.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/19] VFS: use d_alloc_parallel() in lookup_one_qstr_excl() and rename it.
Date: Thu,  6 Feb 2025 16:42:40 +1100
Message-ID: <20250206054504.2950516-4-neilb@suse.de>
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
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

lookup_one_qstr_excl() is used for lookups prior to directory
modifications, whether create, unlink, rename, or whatever.

To prepare for allowing modification to happen in parallel, change
lookup_one_qstr_excl() to use d_alloc_parallel().

To reflect this, name is changed to lookup_one_qtr() - as the directory
may be locked shared.

If any for the "intent" LOOKUP flags are passed, the caller must ensure
d_lookup_done() is called at an appropriate time.  If none are passed
then we can be sure ->lookup() will do a real lookup and d_lookup_done()
is called internally.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/namei.c            | 47 +++++++++++++++++++++++++------------------
 fs/smb/server/vfs.c   |  7 ++++---
 include/linux/namei.h |  9 ++++++---
 3 files changed, 37 insertions(+), 26 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 5cdbd2eb4056..d684102d873d 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1665,15 +1665,13 @@ static struct dentry *lookup_dcache(const struct qstr *name,
 }
 
 /*
- * Parent directory has inode locked exclusive.  This is one
- * and only case when ->lookup() gets called on non in-lookup
- * dentries - as the matter of fact, this only gets called
- * when directory is guaranteed to have no in-lookup children
- * at all.
+ * Parent directory has inode locked: exclusive or shared.
+ * If @flags contains any LOOKUP_INTENT_FLAGS then d_lookup_done()
+ * must be called after the intended operation is performed - or aborted.
  */
-struct dentry *lookup_one_qstr_excl(const struct qstr *name,
-				    struct dentry *base,
-				    unsigned int flags)
+struct dentry *lookup_one_qstr(const struct qstr *name,
+			       struct dentry *base,
+			       unsigned int flags)
 {
 	struct dentry *dentry = lookup_dcache(name, base, flags);
 	struct dentry *old;
@@ -1686,18 +1684,25 @@ struct dentry *lookup_one_qstr_excl(const struct qstr *name,
 	if (unlikely(IS_DEADDIR(dir)))
 		return ERR_PTR(-ENOENT);
 
-	dentry = d_alloc(base, name);
-	if (unlikely(!dentry))
+	dentry = d_alloc_parallel(base, name);
+	if (unlikely(IS_ERR_OR_NULL(dentry)))
 		return ERR_PTR(-ENOMEM);
+	if (!d_in_lookup(dentry))
+		/* Raced with another thread which did the lookup */
+		return dentry;
 
 	old = dir->i_op->lookup(dir, dentry, flags);
 	if (unlikely(old)) {
+		d_lookup_done(dentry);
 		dput(dentry);
 		dentry = old;
 	}
+	if ((flags & LOOKUP_INTENT_FLAGS) == 0)
+		/* ->lookup must have given final answer */
+		d_lookup_done(dentry);
 	return dentry;
 }
-EXPORT_SYMBOL(lookup_one_qstr_excl);
+EXPORT_SYMBOL(lookup_one_qstr);
 
 /**
  * lookup_fast - do fast lockless (but racy) lookup of a dentry
@@ -2739,7 +2744,7 @@ static struct dentry *__kern_path_locked(int dfd, struct filename *name, struct
 		return ERR_PTR(-EINVAL);
 	}
 	inode_lock_nested(path->dentry->d_inode, I_MUTEX_PARENT);
-	d = lookup_one_qstr_excl(&last, path->dentry, 0);
+	d = lookup_one_qstr(&last, path->dentry, 0);
 	if (IS_ERR(d)) {
 		inode_unlock(path->dentry->d_inode);
 		path_put(path);
@@ -4078,8 +4083,8 @@ static struct dentry *filename_create(int dfd, struct filename *name,
 	if (last.name[last.len] && !want_dir)
 		create_flags = 0;
 	inode_lock_nested(path->dentry->d_inode, I_MUTEX_PARENT);
-	dentry = lookup_one_qstr_excl(&last, path->dentry,
-				      reval_flag | create_flags);
+	dentry = lookup_one_qstr(&last, path->dentry,
+				 reval_flag | create_flags);
 	if (IS_ERR(dentry))
 		goto unlock;
 
@@ -4103,6 +4108,7 @@ static struct dentry *filename_create(int dfd, struct filename *name,
 	}
 	return dentry;
 fail:
+	d_lookup_done(dentry);
 	dput(dentry);
 	dentry = ERR_PTR(error);
 unlock:
@@ -4508,7 +4514,7 @@ int do_rmdir(int dfd, struct filename *name)
 		goto exit2;
 
 	inode_lock_nested(path.dentry->d_inode, I_MUTEX_PARENT);
-	dentry = lookup_one_qstr_excl(&last, path.dentry, lookup_flags);
+	dentry = lookup_one_qstr(&last, path.dentry, lookup_flags);
 	error = PTR_ERR(dentry);
 	if (IS_ERR(dentry))
 		goto exit3;
@@ -4641,7 +4647,7 @@ int do_unlinkat(int dfd, struct filename *name)
 		goto exit2;
 retry_deleg:
 	inode_lock_nested(path.dentry->d_inode, I_MUTEX_PARENT);
-	dentry = lookup_one_qstr_excl(&last, path.dentry, lookup_flags);
+	dentry = lookup_one_qstr(&last, path.dentry, lookup_flags);
 	error = PTR_ERR(dentry);
 	if (!IS_ERR(dentry)) {
 
@@ -5231,8 +5237,8 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
 		goto exit_lock_rename;
 	}
 
-	old_dentry = lookup_one_qstr_excl(&old_last, old_path.dentry,
-					  lookup_flags);
+	old_dentry = lookup_one_qstr(&old_last, old_path.dentry,
+				     lookup_flags);
 	error = PTR_ERR(old_dentry);
 	if (IS_ERR(old_dentry))
 		goto exit3;
@@ -5240,8 +5246,8 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
 	error = -ENOENT;
 	if (d_is_negative(old_dentry))
 		goto exit4;
-	new_dentry = lookup_one_qstr_excl(&new_last, new_path.dentry,
-					  lookup_flags | target_flags);
+	new_dentry = lookup_one_qstr(&new_last, new_path.dentry,
+				     lookup_flags | target_flags);
 	error = PTR_ERR(new_dentry);
 	if (IS_ERR(new_dentry))
 		goto exit4;
@@ -5292,6 +5298,7 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
 	rd.flags	   = flags;
 	error = vfs_rename(&rd);
 exit5:
+	d_lookup_done(new_dentry);
 	dput(new_dentry);
 exit4:
 	dput(old_dentry);
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 4e580bb7baf8..89b3823f6405 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -109,7 +109,7 @@ static int ksmbd_vfs_path_lookup_locked(struct ksmbd_share_config *share_conf,
 	}
 
 	inode_lock_nested(parent_path->dentry->d_inode, I_MUTEX_PARENT);
-	d = lookup_one_qstr_excl(&last, parent_path->dentry, 0);
+	d = lookup_one_qstr(&last, parent_path->dentry, 0);
 	if (IS_ERR(d))
 		goto err_out;
 
@@ -726,8 +726,8 @@ int ksmbd_vfs_rename(struct ksmbd_work *work, const struct path *old_path,
 		ksmbd_fd_put(work, parent_fp);
 	}
 
-	new_dentry = lookup_one_qstr_excl(&new_last, new_path.dentry,
-					  lookup_flags | LOOKUP_RENAME_TARGET);
+	new_dentry = lookup_one_qstr(&new_last, new_path.dentry,
+				     lookup_flags | LOOKUP_RENAME_TARGET);
 	if (IS_ERR(new_dentry)) {
 		err = PTR_ERR(new_dentry);
 		goto out3;
@@ -771,6 +771,7 @@ int ksmbd_vfs_rename(struct ksmbd_work *work, const struct path *old_path,
 		ksmbd_debug(VFS, "vfs_rename failed err %d\n", err);
 
 out4:
+	d_lookup_done(new_dentry);
 	dput(new_dentry);
 out3:
 	dput(old_parent);
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 8ec8fed3bce8..06bb3ea65beb 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -34,6 +34,9 @@ enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT};
 #define LOOKUP_EXCL		0x0400	/* ... in exclusive creation */
 #define LOOKUP_RENAME_TARGET	0x0800	/* ... in destination of rename() */
 
+#define LOOKUP_INTENT_FLAGS	(LOOKUP_OPEN | LOOKUP_CREATE | LOOKUP_EXCL |	\
+				 LOOKUP_RENAME_TARGET)
+
 /* internal use only */
 #define LOOKUP_PARENT		0x0010
 
@@ -52,9 +55,9 @@ extern int path_pts(struct path *path);
 
 extern int user_path_at(int, const char __user *, unsigned, struct path *);
 
-struct dentry *lookup_one_qstr_excl(const struct qstr *name,
-				    struct dentry *base,
-				    unsigned int flags);
+struct dentry *lookup_one_qstr(const struct qstr *name,
+			       struct dentry *base,
+			       unsigned int flags);
 extern int kern_path(const char *, unsigned, struct path *);
 
 extern struct dentry *kern_path_create(int, const char *, struct path *, unsigned int);
-- 
2.47.1


