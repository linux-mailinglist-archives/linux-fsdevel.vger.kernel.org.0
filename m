Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 731715A1EA3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Aug 2022 04:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244767AbiHZCRb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Aug 2022 22:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244746AbiHZCRX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Aug 2022 22:17:23 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8F6CB5DB;
        Thu, 25 Aug 2022 19:17:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A1F1E2298A;
        Fri, 26 Aug 2022 02:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1661480239; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5oQjdZ4RU13qv7ERg7wUf7fqXZRo2xGMUxfTKvystxA=;
        b=K8TMCl0dzuN7diDZUyyOSvTgk3rs7dP3YNTF/SkXDwRx2jhMqqd1XITc+aMCww1u3YCgO2
        1hX4VSOkpnyo/Q0+Zam4eRai05jEnIZ7ujrI/AQ8CbnMyGgGtpe1/C4qs2hIOgtCQwJn67
        yUz0RKZwyVHtS4oscsZ4CCz8lFGwCtk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1661480239;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5oQjdZ4RU13qv7ERg7wUf7fqXZRo2xGMUxfTKvystxA=;
        b=WulEif6gsEbqX0y/kzjG+IfUQfXjh9oKaMAMkjof9HLt6hnuZiAZf05zE06CrWk+oOtwAC
        EPNS7aEswe1OMWAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 48AD913A65;
        Fri, 26 Aug 2022 02:17:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Pc1dAi0tCGNwMQAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 26 Aug 2022 02:17:17 +0000
Subject: [PATCH 03/10] VFS: move want_write checks into lookup_hash_update()
From:   NeilBrown <neilb@suse.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Daire Byrne <daire@dneg.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Date:   Fri, 26 Aug 2022 12:10:43 +1000
Message-ID: <166147984374.25420.3477094952897986387.stgit@noble.brown>
In-Reply-To: <166147828344.25420.13834885828450967910.stgit@noble.brown>
References: <166147828344.25420.13834885828450967910.stgit@noble.brown>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

mnt_want_write() is always called before lookup_hash_update(), so
we can simplify the code by moving the call into that function.

If lookup_hash_update() succeeds, it now will have claimed the
want_write lock.  If it fails, the want_write lock isn't held.

To allow this, lookup_hash_update() now receives a 'struct path *'
instead of 'struct dentry *'

Note that when creating a name, any error from mnt_want_write() does not
get reported unless there is no other error.  For unlink/rmdir though,
an error from mnt_want_write() is immediately fatal - overriding ENOENT
for example.  This behaviour seems strange, but this patch is careful to
preserve it.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/namei.c |   72 ++++++++++++++++++++++++++----------------------------------
 1 file changed, 31 insertions(+), 41 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 09c2d007814a..73c3319a1703 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1632,12 +1632,22 @@ static struct dentry *__lookup_hash(const struct qstr *name,
  */
 static struct dentry *lookup_hash_update(
 	const struct qstr *name,
-	struct dentry *base, unsigned int flags,
+	struct path *path, unsigned int flags,
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
 
 	if (wq && IS_PAR_UPDATE(dir))
 		inode_lock_shared_nested(dir, I_MUTEX_PARENT);
@@ -1677,6 +1687,13 @@ static struct dentry *lookup_hash_update(
 			goto out_err;
 		}
 	}
+	if (err2) {
+		err = err2;
+		d_lookup_done(dentry);
+		d_unlock_update(dentry);
+		dput(dentry);
+		goto out_err;
+	}
 	return dentry;
 
 out_err:
@@ -1684,6 +1701,8 @@ static struct dentry *lookup_hash_update(
 		inode_unlock_shared(dir);
 	else
 		inode_unlock(dir);
+	if (!err2)
+		mnt_drop_write(path->mnt);
 	return ERR_PTR(err);
 }
 
@@ -1700,7 +1719,7 @@ struct dentry *lookup_hash_update_len(const char *name, int nlen,
 				    path->dentry, nlen, &this);
 	if (err)
 		return ERR_PTR(err);
-	return lookup_hash_update(&this, path->dentry, flags, wq);
+	return lookup_hash_update(&this, path, flags, wq);
 }
 EXPORT_SYMBOL(lookup_hash_update_len);
 
@@ -3891,15 +3910,10 @@ static struct dentry *filename_create_one(struct qstr *last, struct path *path,
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
@@ -3910,24 +3924,9 @@ static struct dentry *filename_create_one(struct qstr *last, struct path *path,
 		 * or -EEXIST.
 		 */
 		create_flag = 0;
-	dentry = lookup_hash_update(last, path->dentry,
-				    reval_flag | create_flag | LOOKUP_EXCL, wq);
-	if (IS_ERR(dentry))
-		goto drop_write;
-
-	if (unlikely(err2)) {
-		error = err2;
-		goto fail;
-	}
-	return dentry;
-fail:
-	done_path_update(path, dentry, !!wq);
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
@@ -4300,23 +4299,18 @@ int do_rmdir(int dfd, struct filename *name)
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
 	done_path_update(&path, dentry, true);
 	dput(dentry);
-exit3:
 	mnt_drop_write(path.mnt);
 exit2:
 	path_put(&path);
@@ -4433,12 +4427,8 @@ int do_unlinkat(int dfd, struct filename *name)
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
@@ -4457,6 +4447,7 @@ int do_unlinkat(int dfd, struct filename *name)
 exit3:
 		done_path_update(&path, dentry, true);
 		dput(dentry);
+		mnt_drop_write(path.mnt);
 	}
 	if (inode)
 		iput(inode);	/* truncate the inode here */
@@ -4466,7 +4457,6 @@ int do_unlinkat(int dfd, struct filename *name)
 		if (!error)
 			goto retry_deleg;
 	}
-	mnt_drop_write(path.mnt);
 exit2:
 	path_put(&path);
 	if (retry_estale(error, lookup_flags)) {


