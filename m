Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 454A754A28A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jun 2022 01:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236807AbiFMXUb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jun 2022 19:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236174AbiFMXU0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jun 2022 19:20:26 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B1E17A97;
        Mon, 13 Jun 2022 16:20:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3E0691F959;
        Mon, 13 Jun 2022 23:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1655162423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=49sNL+JXZC0xvhRBhT/jrprRMvF1g4wqNINkvpdWU1E=;
        b=BolQoJ8ewEmgzdSsf/nS6bIY0HzmeYMtTc6jYUn8MwSSvXnNCikGuGkicNulbJu03KlbcR
        rWsm5NRyuoz86HDX3aUI+HZfT3JilqqIFfwIcr0egwaOX1H8Za9MzoEUZyOaCebILatGbG
        HklNAU2MoqjOOQaz7u5t7JdPcFKH8xY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1655162423;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=49sNL+JXZC0xvhRBhT/jrprRMvF1g4wqNINkvpdWU1E=;
        b=m29J4WRcV1TkrUSuKc7s9YsqQYWcxjn8kaNGPA9SGHmYTOkHVMwFJyPa08FE243okQ2MYf
        TH8vtYk/7pYV4EDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 07989134CF;
        Mon, 13 Jun 2022 23:20:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2c4QLTTGp2K5bwAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 13 Jun 2022 23:20:20 +0000
Subject: [PATCH 03/12] VFS: move want_write checks into lookup_hash_update()
From:   NeilBrown <neilb@suse.de>
To:     Al Viro <viro@zeniv.linux.org.uk>, Daire Byrne <daire@dneg.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 14 Jun 2022 09:18:21 +1000
Message-ID: <165516230197.21248.171443631120298429.stgit@noble.brown>
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

mnt_want_write() is always called before lookup_hash_update(), so we can
simplify the code by moving the call into that function.

If lookup_hash_update() succeeds, it now will have claimed the
want_write lock.  If it fails, the want_write lock isn't held.

Also lookup_hash_update() now receives a 'struct path'.

Note that when creating a name, any error from mnt_want_write() does not
get reported unless there is no other error.  For unlink/rmdir though,
an error from mnt_want_write() is immediately fatal - overriding ENOENT
for example.  This behaviour seems strange, but this patch is careful to
preserve it.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/namei.c |   71 +++++++++++++++++++++++++-----------------------------------
 1 file changed, 29 insertions(+), 42 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index e7a56d6e2472..83ce2f7083be 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1631,12 +1631,22 @@ static struct dentry *__lookup_hash(const struct qstr *name,
  * If not LOOKUP_CREATE, name should already exist, else -ENOENT
  */
 static struct dentry *lookup_hash_update(const struct qstr *name,
-					 struct dentry *base, unsigned int flags,
+					 struct path *path, unsigned int flags,
 					 wait_queue_head_t *wq)
 {
 	struct dentry *dentry;
+	struct dentry *base = path->dentry;
 	struct inode *dir = base->d_inode;
-	int err;
+	int err, err2;
+
+	/* For create, don't fail immediately if it's r/o,
+	 * at least try to report other errors.
+	 * For unlink/rmdir where LOOKUP_REVAl is the only
+	 * flag, fail immediately if r/o.
+	 */
+	err2 = mnt_want_write(path->mnt);
+	if (err2 && (flags & ~LOOKUP_REVAL) == 0)
+		return ERR_PTR(err2);
 
 	if (!(dir->i_flags & S_PAR_UPDATE))
 		wq = NULL;
@@ -1675,6 +1685,11 @@ static struct dentry *lookup_hash_update(const struct qstr *name,
 		dput(dentry);
 		goto retry;
 	}
+	if (err2) {
+		err = err2;
+		dput(dentry);
+		goto out_err;
+	}
 	return dentry;
 
 out_err:
@@ -1682,6 +1697,8 @@ static struct dentry *lookup_hash_update(const struct qstr *name,
 		inode_unlock_shared(dir);
 	else
 		inode_unlock(dir);
+	if (!err2)
+		mnt_drop_write(path->mnt);
 	return ERR_PTR(err);
 }
 
@@ -1698,7 +1715,7 @@ struct dentry *lookup_hash_update_len(const char *name, int nlen,
 				    path->dentry, nlen, &this);
 	if (err)
 		return ERR_PTR(err);
-	return lookup_hash_update(&this, path->dentry, flags, wq);
+	return lookup_hash_update(&this, path, flags, wq);
 }
 EXPORT_SYMBOL(lookup_hash_update_len);
 
@@ -3857,15 +3874,10 @@ static struct dentry *filename_create_one(struct qstr *last, struct path *path,
 					  unsigned int lookup_flags,
 					  wait_queue_head_t *wq)
 {
-	struct dentry *dentry;
 	bool want_dir = lookup_flags & LOOKUP_DIRECTORY;
 	unsigned int reval_flag = lookup_flags & LOOKUP_REVAL;
 	unsigned int create_flag = LOOKUP_CREATE;
-	int err2;
-	int error;
 
-	/* don't fail immediately if it's r/o, at least try to report other errors */
-	err2 = mnt_want_write(path->mnt);
 	/*
 	 * Do the final lookup.  Suppress 'create' if there is a trailing
 	 * '/', and a directory wasn't requested.
@@ -3876,25 +3888,9 @@ static struct dentry *filename_create_one(struct qstr *last, struct path *path,
 		 * or -EEXIST.
 		 */
 		create_flag = 0;
-	dentry = lookup_hash_update(last, path->dentry,
-				    reval_flag | create_flag | LOOKUP_EXCL,
-				    wq);
-	if (IS_ERR(dentry))
-		goto drop_write;
-
-	if (unlikely(err2)) {
-		error = err2;
-		goto fail;
-	}
-	return dentry;
-fail:
-	done_path_update(path, dentry, wq);
-	dput(dentry);
-	dentry = ERR_PTR(error);
-drop_write:
-	if (!err2)
-		mnt_drop_write(path->mnt);
-	return dentry;
+	return lookup_hash_update(last, path,
+				  reval_flag | create_flag | LOOKUP_EXCL,
+				  wq);
 }
 
 struct dentry *filename_create_one_len(const char *name, int nlen,
@@ -4269,23 +4265,18 @@ int do_rmdir(int dfd, struct filename *name)
 		goto exit2;
 	}
 
-	error = mnt_want_write(path.mnt);
-	if (error)
-		goto exit2;
-
-	dentry = lookup_hash_update(&last, path.dentry, lookup_flags, &wq);
+	dentry = lookup_hash_update(&last, &path, lookup_flags, &wq);
 	error = PTR_ERR(dentry);
 	if (IS_ERR(dentry))
-		goto exit3;
+		goto exit2;
 	error = security_path_rmdir(&path, dentry);
 	if (error)
-		goto exit4;
+		goto exit3;
 	mnt_userns = mnt_user_ns(path.mnt);
 	error = vfs_rmdir(mnt_userns, path.dentry->d_inode, dentry);
-exit4:
+exit3:
 	done_path_update(&path, dentry, &wq);
 	dput(dentry);
-exit3:
 	mnt_drop_write(path.mnt);
 exit2:
 	path_put(&path);
@@ -4402,12 +4393,8 @@ int do_unlinkat(int dfd, struct filename *name)
 	if (type != LAST_NORM)
 		goto exit2;
 
-	error = mnt_want_write(path.mnt);
-	if (error)
-		goto exit2;
-
 retry_deleg:
-	dentry = lookup_hash_update(&last, path.dentry, lookup_flags, &wq);
+	dentry = lookup_hash_update(&last, &path, lookup_flags, &wq);
 	error = PTR_ERR(dentry);
 	if (!IS_ERR(dentry)) {
 		struct user_namespace *mnt_userns;
@@ -4426,6 +4413,7 @@ int do_unlinkat(int dfd, struct filename *name)
 exit3:
 		done_path_update(&path, dentry, &wq);
 		dput(dentry);
+		mnt_drop_write(path.mnt);
 	}
 	if (inode)
 		iput(inode);	/* truncate the inode here */
@@ -4435,7 +4423,6 @@ int do_unlinkat(int dfd, struct filename *name)
 		if (!error)
 			goto retry_deleg;
 	}
-	mnt_drop_write(path.mnt);
 exit2:
 	path_put(&path);
 	if (retry_estale(error, lookup_flags)) {


