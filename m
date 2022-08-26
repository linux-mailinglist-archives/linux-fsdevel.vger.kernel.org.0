Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776345A1EAD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Aug 2022 04:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244758AbiHZCSQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Aug 2022 22:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244753AbiHZCSI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Aug 2022 22:18:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2541BCC311;
        Thu, 25 Aug 2022 19:18:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BBAD337C4A;
        Fri, 26 Aug 2022 02:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1661480284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ohYWj3ZdjfHRt86tXw/kKwWt3bxrD9pOKcmPMT9kEcY=;
        b=z81KLXkWXjeVBfHywZ5OItrPtCTOdh0H2vDMGa059trs3yytcOa7MZ4qF/0FEck6ub4U4L
        21VmstNx2VMVeUbj543idTCoQiYfqzflz6CyG0D0qu9Yh7nK3kEG+yVeh0PxGSlsZmPyBo
        a+yAhYf+iu04SXCN3I/Cy+2/XgjrY4s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1661480284;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ohYWj3ZdjfHRt86tXw/kKwWt3bxrD9pOKcmPMT9kEcY=;
        b=RBnzKXXcnp+eFTWlUXfN8d1xPIgGW+K+Z/PABCEIwyqKgEGHhZ3Evi+vmE/4Fb8jasls96
        r/8hFVU5rUZmi6DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2627213A65;
        Fri, 26 Aug 2022 02:17:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JNYFNEctCGOSMQAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 26 Aug 2022 02:17:43 +0000
Subject: [PATCH 06/10] VFS: support concurrent renames.
From:   NeilBrown <neilb@suse.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Daire Byrne <daire@dneg.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Date:   Fri, 26 Aug 2022 12:10:43 +1000
Message-ID: <166147984375.25420.13018600986239729815.stgit@noble.brown>
In-Reply-To: <166147828344.25420.13834885828450967910.stgit@noble.brown>
References: <166147828344.25420.13834885828450967910.stgit@noble.brown>
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

Allow object can now be renamed from or to a directory in which a create
or unlink is concurrently happening.

Two or more renames with the one directory can also be concurrent.
s_vfs_rename_mutex still serialises lookups for cross-directory renames,
but the renames themselves can proceed concurrently.

A core part of this change is introducing lock_rename_lookup()
which both locks the directories and performs the lookups.
If the filesystem supports shared-lock updates and a wq is provided,
shared locks are used on directories, otherwise exclusive locks.
DCACHE_PAR_UPDATE is always set on the found dentries.

unlock_rename_lookup() performs appropriate unlocking.  It needs to be
told if a wq was provided to lock_rename_lookup().

As we may use alloc_dentry_parallel() which can block, we need to be
careful of the case where both names are the same, in the same
directory.  If the first ->lookup() chooses not to complete the lookup -
as may happen with LOOKUP_RENAME_TARGET - then the second will block.
LOOKUP_RENAME_TARGET is only expected on the first name listed, so we
make sure to lookup the second name given first.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/namei.c            |  221 ++++++++++++++++++++++++++++++++++++++++++++-----
 include/linux/namei.h |   10 ++
 2 files changed, 208 insertions(+), 23 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 13f8ac9721be..a7c458cc787c 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3156,6 +3156,187 @@ void unlock_rename(struct dentry *p1, struct dentry *p2)
 }
 EXPORT_SYMBOL(unlock_rename);
 
+static struct dentry *lock_rename_lookup(struct dentry *p1, struct dentry *p2,
+					 struct dentry **d1p, struct dentry **d2p,
+					 struct qstr *last1, struct qstr *last2,
+					 unsigned int flags1, unsigned int flags2,
+					 wait_queue_head_t *wq)
+{
+	struct dentry *p;
+	struct dentry *d1, *d2;
+	bool ok1, ok2;
+	bool shared = wq && IS_PAR_UPDATE(p1->d_inode);
+
+	if (p1 == p2) {
+		if (shared)
+			inode_lock_shared_nested(p1->d_inode, I_MUTEX_PARENT);
+		else
+			inode_lock_nested(p1->d_inode, I_MUTEX_PARENT);
+	retry:
+		/* last1 is expected to be target so and might be looked up
+		 * lazily.  So look up last2 first to avoid the second look up
+		 * waiting for the first.
+		 */
+		d2 = __lookup_hash(last2, p2, flags2, wq);
+		if (IS_ERR(d2))
+			goto out_unlock_2;
+		d1 = __lookup_hash(last1, p1, flags1, wq);
+		if (IS_ERR(d1))
+			goto out_unlock_1;
+		*d1p = d1; *d2p = d2;
+
+		if (d1 < d2) {
+			ok1 = d_lock_update_nested(d1, p1, last1,
+						   I_MUTEX_PARENT);
+			ok2 = d_lock_update_nested(d2, p2, last2,
+						   I_MUTEX_PARENT2);
+		} else if (d1 > d2) {
+			ok2 = d_lock_update_nested(d2, p2, last2,
+						   I_MUTEX_PARENT);
+			ok1 = d_lock_update_nested(d1, p1, last1,
+						   I_MUTEX_PARENT2);
+		} else {
+			/* d1 == d2 !! */
+			ok1 = d_lock_update_nested(d1, p1, last1,
+						   I_MUTEX_PARENT);
+			ok2 = ok1;
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
+	out_unlock_1:
+		d_lookup_done(d2);
+		dput(d2);
+		d2 = d1;
+	out_unlock_2:
+		if (shared)
+			inode_unlock_shared(p1->d_inode);
+		else
+			inode_unlock(p1->d_inode);
+		return d1;
+	}
+
+	mutex_lock(&p1->d_sb->s_vfs_rename_mutex);
+
+	if ((p = d_ancestor(p2, p1)) != NULL) {
+		if (shared) {
+			inode_lock_shared_nested(p2->d_inode, I_MUTEX_PARENT);
+			inode_lock_shared_nested(p1->d_inode, I_MUTEX_CHILD);
+		} else {
+			inode_lock_nested(p2->d_inode, I_MUTEX_PARENT);
+			inode_lock_nested(p1->d_inode, I_MUTEX_CHILD);
+		}
+	} else if ((p = d_ancestor(p1, p2)) != NULL) {
+		if (shared) {
+			inode_lock_shared_nested(p1->d_inode, I_MUTEX_PARENT);
+			inode_lock_shared_nested(p2->d_inode, I_MUTEX_CHILD);
+		} else {
+			inode_lock_nested(p1->d_inode, I_MUTEX_PARENT);
+			inode_lock_nested(p2->d_inode, I_MUTEX_CHILD);
+		}
+	} else {
+		if (shared) {
+			inode_lock_shared_nested(p1->d_inode, I_MUTEX_PARENT);
+			inode_lock_shared_nested(p2->d_inode, I_MUTEX_PARENT2);
+		} else {
+			inode_lock_nested(p1->d_inode, I_MUTEX_PARENT);
+			inode_lock_nested(p2->d_inode, I_MUTEX_PARENT2);
+		}
+	}
+retry2:
+	d1 = __lookup_hash(last1, p1, flags1, wq);
+	if (IS_ERR(d1))
+		goto unlock_out_3;
+	d2 = __lookup_hash(last2, p2, flags2, wq);
+	if (IS_ERR(d2))
+		goto unlock_out_4;
+
+	if (d1 < d2) {
+		ok1 = d_lock_update_nested(d1, p1, last1, I_MUTEX_PARENT);
+		ok2 = d_lock_update_nested(d2, p2, last2, I_MUTEX_PARENT2);
+	} else {
+		ok2 = d_lock_update_nested(d2, p2, last2, I_MUTEX_PARENT);
+		ok1 = d_lock_update_nested(d1, p1, last1, I_MUTEX_PARENT2);
+	}
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
+	d_lookup_done(d1);
+	dput(d1);
+	d1 = d2;
+unlock_out_3:
+	if (shared) {
+		inode_unlock_shared(p1->d_inode);
+		inode_unlock_shared(p2->d_inode);
+	} else {
+		inode_unlock(p1->d_inode);
+		inode_unlock(p2->d_inode);
+	}
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
+			  struct dentry *d1, struct dentry *d2,
+			  bool with_wq)
+{
+	bool shared = with_wq && IS_PAR_UPDATE(p1->d_inode);
+	d_lookup_done(d1);
+	d_lookup_done(d2);
+	d_unlock_update(d1);
+	if (d2 != d1)
+		d_unlock_update(d2);
+	if (shared) {
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
  * mode_strip_umask - handle vfs umask stripping
  * @dir:	parent directory of the new inode
@@ -4945,6 +5126,7 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
 	unsigned int lookup_flags = 0, target_flags = LOOKUP_RENAME_TARGET;
 	bool should_retry = false;
 	int error = -EINVAL;
+	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 
 	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE | RENAME_WHITEOUT))
 		goto put_names;
@@ -4985,58 +5167,53 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
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
@@ -5047,12 +5224,10 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
 	rd.delegated_inode = &delegated_inode;
 	rd.flags	   = flags;
 	error = vfs_rename(&rd);
-exit5:
-	dput(new_dentry);
 exit4:
-	dput(old_dentry);
+	unlock_rename_lookup(new_path.dentry, old_path.dentry, new_dentry, old_dentry,
+			     true);
 exit3:
-	unlock_rename(new_path.dentry, old_path.dentry);
 	if (delegated_inode) {
 		error = break_deleg_wait(&delegated_inode);
 		if (!error)
diff --git a/include/linux/namei.h b/include/linux/namei.h
index b1a210a51210..29756921f69b 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -108,6 +108,16 @@ extern int follow_up(struct path *);
 
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
+				 struct dentry *d1, struct dentry *d2,
+				 bool withwq);
 
 extern int __must_check nd_jump_link(struct path *path);
 


