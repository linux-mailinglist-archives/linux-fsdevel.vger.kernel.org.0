Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4698A54A295
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jun 2022 01:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238421AbiFMXVF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jun 2022 19:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241744AbiFMXVA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jun 2022 19:21:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502892E6AE;
        Mon, 13 Jun 2022 16:20:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9D09B21AA0;
        Mon, 13 Jun 2022 23:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1655162449; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jlt/wINlzSS0GRxWVBSPo25fgSIy4XUJj5J1aoakxuk=;
        b=Nh+91C5OTCqidSTSzCgGzRIS4INkPneU9bPgOhEx3qexdGmu5ZvtqVCZPlyyAopcKxmAdP
        jdgUCEc+lzqsCFxKvjksRpIYCVKcXt1NOjoPCD4yvjqASeyzpphDDlUcF9qe5bMha7XBHz
        SOYHncyCFS42xccsdLT++XuLLubrTUI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1655162449;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jlt/wINlzSS0GRxWVBSPo25fgSIy4XUJj5J1aoakxuk=;
        b=tX855rtC2qyuNJsSkTWZXqzUHJdQKOIAKwCH6vJ8wHbIDAJpYov+WUXIDQ2AH8s5fidgky
        dv4rJ5wO0rgFWiCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6B2E6134CF;
        Mon, 13 Jun 2022 23:20:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ufMOCk/Gp2LebwAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 13 Jun 2022 23:20:47 +0000
Subject: [PATCH 06/12] VFS: support concurrent renames.
From:   NeilBrown <neilb@suse.de>
To:     Al Viro <viro@zeniv.linux.org.uk>, Daire Byrne <daire@dneg.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 14 Jun 2022 09:18:22 +1000
Message-ID: <165516230199.21248.18142980966152036732.stgit@noble.brown>
In-Reply-To: <165516173293.21248.14587048046993234326.stgit@noble.brown>
References: <165516173293.21248.14587048046993234326.stgit@noble.brown>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

An object can now be renamed from or to a directory in which a create or
unlink is concurrently happening.
Two or more renames with the one directory can also be concurrent.

There is still only one cross-directory rename permitted at a time.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/namei.c            |  230 ++++++++++++++++++++++++++++++++++++++++++++-----
 include/linux/namei.h |    9 ++
 2 files changed, 216 insertions(+), 23 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 8ce7aa16b704..31ba4dbedfcf 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3172,6 +3172,197 @@ void unlock_rename(struct dentry *p1, struct dentry *p2)
 }
 EXPORT_SYMBOL(unlock_rename);
 
+struct dentry *lock_rename_lookup_excl(struct dentry *p1, struct dentry *p2,
+				       struct dentry **d1p, struct dentry **d2p,
+				       struct qstr *last1, struct qstr *last2,
+				       unsigned int flags1, unsigned int flags2)
+{
+	struct dentry *p;
+	struct dentry *d1, *d2;
+
+	if (p1 == p2) {
+		inode_lock_nested(p1->d_inode, I_MUTEX_PARENT);
+		d1 = __lookup_hash(last1, p1, flags1, NULL);
+		if (IS_ERR(d1))
+			goto out_unlock_1;
+		d2 = __lookup_hash(last2, p2, flags2, NULL);
+		if (IS_ERR(d2))
+			goto out_unlock_2;
+		*d1p = d1; *d2p = d2;
+		return NULL;
+	out_unlock_2:
+		dput(d1);
+		d1 = d2;
+	out_unlock_1:
+		inode_unlock(p1->d_inode);
+		return d1;
+	}
+
+	mutex_lock(&p1->d_sb->s_vfs_rename_mutex);
+
+	if ((p = d_ancestor(p2, p1)) != NULL) {
+		inode_lock_nested(p2->d_inode, I_MUTEX_PARENT);
+		inode_lock_nested(p1->d_inode, I_MUTEX_CHILD);
+	} else if ((p = d_ancestor(p1, p2)) != NULL) {
+		inode_lock_nested(p1->d_inode, I_MUTEX_PARENT);
+		inode_lock_nested(p2->d_inode, I_MUTEX_CHILD);
+	} else {
+		inode_lock_nested(p1->d_inode, I_MUTEX_PARENT);
+		inode_lock_nested(p2->d_inode, I_MUTEX_PARENT2);
+	}
+	d1 = __lookup_hash(last1, p1, flags1, NULL);
+	if (IS_ERR(d1))
+		goto unlock_out_3;
+	d2 = __lookup_hash(last2, p2, flags2, NULL);
+	if (IS_ERR(d2))
+		goto unlock_out_4;
+
+	*d1p = d1;
+	*d2p = d2;
+	return p;
+unlock_out_4:
+	dput(d1);
+	d1 = d2;
+unlock_out_3:
+	inode_unlock(p1->d_inode);
+	inode_unlock(p2->d_inode);
+	mutex_unlock(&p1->d_sb->s_vfs_rename_mutex);
+	return d1;
+}
+
+static struct dentry *lock_rename_lookup(struct dentry *p1, struct dentry *p2,
+					 struct dentry **d1p, struct dentry **d2p,
+					 struct qstr *last1, struct qstr *last2,
+					 unsigned int flags1, unsigned int flags2,
+					 wait_queue_head_t *wq)
+{
+	struct dentry *p;
+	struct dentry *d1, *d2;
+	bool ok1, ok2;
+
+	if (!wq || (p1->d_inode->i_flags & S_PAR_UPDATE) == 0)
+		return lock_rename_lookup_excl(p1, p2, d1p, d2p, last1, last2,
+					       flags1, flags2);
+
+	if (p1 == p2) {
+		inode_lock_shared_nested(p1->d_inode, I_MUTEX_PARENT);
+	retry:
+		d1 = __lookup_hash(last1, p1, flags1, wq);
+		if (IS_ERR(d1))
+			goto out_unlock_1;
+		d2 = __lookup_hash(last2, p2, flags2, wq);
+		if (IS_ERR(d2))
+			goto out_unlock_2;
+		*d1p = d1; *d2p = d2;
+
+		if (d1 < d2) {
+			ok1 = d_lock_update(d1, p1, last1);
+			ok2 = d_lock_update(d2, p2, last2);
+		} else {
+			ok2 = d_lock_update(d2, p2, last2);
+			ok1 = d_lock_update(d1, p1, last1);
+		}
+		if (!ok1 || !ok2) {
+			if (ok1)
+				d_unlock_update(d1);
+			if (ok2)
+				d_unlock_update(d2);
+			dput(d1);
+			dput(d2);
+			goto retry;
+		}
+		return NULL;
+	out_unlock_2:
+		dput(d1);
+		d1 = d2;
+	out_unlock_1:
+		inode_unlock_shared(p1->d_inode);
+		return d1;
+	}
+
+	mutex_lock(&p1->d_sb->s_vfs_rename_mutex);
+
+	if ((p = d_ancestor(p2, p1)) != NULL) {
+		inode_lock_shared_nested(p2->d_inode, I_MUTEX_PARENT);
+		inode_lock_shared_nested(p1->d_inode, I_MUTEX_CHILD);
+	} else if ((p = d_ancestor(p1, p2)) != NULL) {
+		inode_lock_shared_nested(p1->d_inode, I_MUTEX_PARENT);
+		inode_lock_shared_nested(p2->d_inode, I_MUTEX_CHILD);
+	} else {
+		inode_lock_shared_nested(p1->d_inode, I_MUTEX_PARENT);
+		inode_lock_shared_nested(p2->d_inode, I_MUTEX_PARENT2);
+	}
+retry2:
+	d1 = __lookup_hash(last1, p1, flags1, wq);
+	if (IS_ERR(d1))
+		goto unlock_out_3;
+	d2 = __lookup_hash(last2, p2, flags2, wq);
+	if (IS_ERR(d2))
+		goto unlock_out_4;
+
+	ok1 = d_lock_update(d1, p1, last1);
+	ok2 = d_lock_update(d2, p2, last2);
+	if (!ok1 || !ok2) {
+		if (ok1)
+			d_unlock_update(d1);
+		if (ok2)
+			d_unlock_update(d2);
+		dput(d1);
+		dput(d2);
+		goto retry2;
+	}
+	*d1p = d1;
+	*d2p = d2;
+	return p;
+unlock_out_4:
+	dput(d1);
+	d1 = d2;
+unlock_out_3:
+	inode_unlock_shared(p1->d_inode);
+	inode_unlock_shared(p2->d_inode);
+	mutex_unlock(&p1->d_sb->s_vfs_rename_mutex);
+	return d1;
+}
+
+struct dentry *lock_rename_lookup_one(struct dentry *p1, struct dentry *p2,
+				      struct dentry **d1p, struct dentry **d2p,
+				      const char *name1, int nlen1,
+				      const char *name2, int nlen2,
+				      unsigned int flags1, unsigned int flags2,
+				      wait_queue_head_t *wq)
+{
+	struct qstr this1, this2;
+	int err;
+
+	err = lookup_one_common(&init_user_ns, name1, p1, nlen1, &this1);
+	if (err)
+		return ERR_PTR(err);
+	err = lookup_one_common(&init_user_ns, name2, p2, nlen2, &this2);
+	if (err)
+		return ERR_PTR(err);
+	return lock_rename_lookup(p1, p2, d1p, d2p, &this1, &this2,
+				  flags1, flags2, wq);
+}
+EXPORT_SYMBOL(lock_rename_lookup_one);
+
+void unlock_rename_lookup(struct dentry *p1, struct dentry *p2,
+			  struct dentry *d1, struct dentry *d2)
+{
+	if (d1->d_flags & DCACHE_PAR_UPDATE) {
+		d_lookup_done(d1);
+		d_lookup_done(d2);
+		inode_unlock_shared(p1->d_inode);
+		if (p1 != p2) {
+			inode_unlock_shared(p2->d_inode);
+			mutex_unlock(&p1->d_sb->s_vfs_rename_mutex);
+		}
+	} else
+		unlock_rename(p1, p2);
+	dput(d1);
+	dput(d2);
+}
+EXPORT_SYMBOL(unlock_rename_lookup);
+
 /**
  * vfs_create - create new file
  * @mnt_userns:	user namespace of the mount the inode was found from
@@ -4910,6 +5101,7 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
 	unsigned int lookup_flags = 0, target_flags = LOOKUP_RENAME_TARGET;
 	bool should_retry = false;
 	int error = -EINVAL;
+	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 
 	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE | RENAME_WHITEOUT))
 		goto put_names;
@@ -4950,58 +5142,53 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
 		goto exit2;
 
 retry_deleg:
-	trap = lock_rename(new_path.dentry, old_path.dentry);
-
-	old_dentry = __lookup_hash(&old_last, old_path.dentry,
-				   lookup_flags, NULL);
-	error = PTR_ERR(old_dentry);
-	if (IS_ERR(old_dentry))
+	trap = lock_rename_lookup(new_path.dentry, old_path.dentry,
+				  &new_dentry, &old_dentry,
+				  &new_last, &old_last,
+				  lookup_flags | target_flags, lookup_flags,
+				  &wq);
+	if (IS_ERR(trap))
 		goto exit3;
 	/* source must exist */
 	error = -ENOENT;
 	if (d_is_negative(old_dentry))
 		goto exit4;
-	new_dentry = __lookup_hash(&new_last, new_path.dentry,
-				   lookup_flags | target_flags, NULL);
-	error = PTR_ERR(new_dentry);
-	if (IS_ERR(new_dentry))
-		goto exit4;
 	error = -EEXIST;
 	if ((flags & RENAME_NOREPLACE) && d_is_positive(new_dentry))
-		goto exit5;
+		goto exit4;
 	if (flags & RENAME_EXCHANGE) {
 		error = -ENOENT;
 		if (d_is_negative(new_dentry))
-			goto exit5;
+			goto exit4;
 
 		if (!d_is_dir(new_dentry)) {
 			error = -ENOTDIR;
 			if (new_last.name[new_last.len])
-				goto exit5;
+				goto exit4;
 		}
 	}
 	/* unless the source is a directory trailing slashes give -ENOTDIR */
 	if (!d_is_dir(old_dentry)) {
 		error = -ENOTDIR;
 		if (old_last.name[old_last.len])
-			goto exit5;
+			goto exit4;
 		if (!(flags & RENAME_EXCHANGE) && new_last.name[new_last.len])
-			goto exit5;
+			goto exit4;
 	}
 	/* source should not be ancestor of target */
 	error = -EINVAL;
 	if (old_dentry == trap)
-		goto exit5;
+		goto exit4;
 	/* target should not be an ancestor of source */
 	if (!(flags & RENAME_EXCHANGE))
 		error = -ENOTEMPTY;
 	if (new_dentry == trap)
-		goto exit5;
+		goto exit4;
 
 	error = security_path_rename(&old_path, old_dentry,
 				     &new_path, new_dentry, flags);
 	if (error)
-		goto exit5;
+		goto exit4;
 
 	rd.old_dir	   = old_path.dentry->d_inode;
 	rd.old_dentry	   = old_dentry;
@@ -5012,12 +5199,9 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
 	rd.delegated_inode = &delegated_inode;
 	rd.flags	   = flags;
 	error = vfs_rename(&rd);
-exit5:
-	dput(new_dentry);
 exit4:
-	dput(old_dentry);
+	unlock_rename_lookup(new_path.dentry, old_path.dentry, new_dentry, old_dentry);
 exit3:
-	unlock_rename(new_path.dentry, old_path.dentry);
 	if (delegated_inode) {
 		error = break_deleg_wait(&delegated_inode);
 		if (!error)
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 217aa6de9f25..b1ea89568de8 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -101,6 +101,15 @@ extern int follow_up(struct path *);
 
 extern struct dentry *lock_rename(struct dentry *, struct dentry *);
 extern void unlock_rename(struct dentry *, struct dentry *);
+extern struct dentry *lock_rename_lookup_one(
+	struct dentry *p1, struct dentry *p2,
+	struct dentry **d1p, struct dentry **d2p,
+	const char *name1, int nlen1,
+	const char *name2, int nlen2,
+	unsigned int flags1, unsigned int flags2,
+	wait_queue_head_t *wq);
+extern void unlock_rename_lookup(struct dentry *p1, struct dentry *p2,
+				 struct dentry *d1, struct dentry *d2);
 
 extern int __must_check nd_jump_link(struct path *path);
 


