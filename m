Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C4854A28C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jun 2022 01:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235333AbiFMXUU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jun 2022 19:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235127AbiFMXUO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jun 2022 19:20:14 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F246EDF05;
        Mon, 13 Jun 2022 16:20:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7BDA11F959;
        Mon, 13 Jun 2022 23:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1655162411; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=82DjfRBW99HvcPcA756zHmAdDUvmWlAbNLkjBBig1RU=;
        b=onyQo7w/F0j7JWAstX/Wf8oR9psNhx1SG23FAe2QRj3Dl8qx03/yLvA+O/XM7M23wHrmOc
        pH9zLJIvsBz8c0/ne+N1laY26Y9dnQeJYqQVXG5DPaVfQvXpO+ZTMSnpO+QUUHJ+xywWBs
        NBk6PDAZBPlHpGuLznAgyxxzCp4qkTw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1655162411;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=82DjfRBW99HvcPcA756zHmAdDUvmWlAbNLkjBBig1RU=;
        b=bKil98UTCl04ew4EmOoqlArjuqiVuARFlR9KJdTnnLaClKo9d1GorIumVTGQ7m9E2oobVn
        T20lIhtIhAndPqDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0DDE2134CF;
        Mon, 13 Jun 2022 23:20:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kkCnLifGp2K1bwAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 13 Jun 2022 23:20:07 +0000
Subject: [PATCH 02/12] VFS: move EEXIST and ENOENT tests into
 lookup_hash_update()
From:   NeilBrown <neilb@suse.de>
To:     Al Viro <viro@zeniv.linux.org.uk>, Daire Byrne <daire@dneg.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 14 Jun 2022 09:18:21 +1000
Message-ID: <165516230197.21248.5856192432755210577.stgit@noble.brown>
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

Moving common error handling into lookup_hash_update() simplifies
callers.
A future patch will export this functionality to nfsd, and the more code
we put in the interface, the less code will be needed in nfsd.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/namei.c |   55 +++++++++++++++++++++++++++++++------------------------
 1 file changed, 31 insertions(+), 24 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 9a2ca515c219..e7a56d6e2472 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1563,7 +1563,13 @@ static struct dentry *lookup_dcache(const struct qstr *name,
 {
 	struct dentry *dentry = d_lookup(dir, name);
 	if (dentry) {
-		int error = d_revalidate(dentry, flags);
+		int error;
+		/* Some filesystems assume EXCL -> CREATE, so make
+		 * sure it does.
+		 */
+		if (!(flags & LOOKUP_CREATE))
+			flags &= ~LOOKUP_EXCL;
+		error = d_revalidate(dentry, flags);
 		if (unlikely(error <= 0)) {
 			if (!error)
 				d_invalidate(dentry);
@@ -1621,6 +1627,8 @@ static struct dentry *__lookup_hash(const struct qstr *name,
  * or shared lock depending on the fs preference, then do a lookup,
  * and then set the DCACHE_PAR_UPDATE bit on the child if a shared lock
  * was taken on the parent.
+ * If LOOKUP_EXCL, name should not already exist, else -EEXIST
+ * If not LOOKUP_CREATE, name should already exist, else -ENOENT
  */
 static struct dentry *lookup_hash_update(const struct qstr *name,
 					 struct dentry *base, unsigned int flags,
@@ -1644,6 +1652,20 @@ static struct dentry *lookup_hash_update(const struct qstr *name,
 		err = PTR_ERR(dentry);
 		goto out_err;
 	}
+	if (flags & LOOKUP_EXCL) {
+		if (d_is_positive(dentry)) {
+			dput(dentry);
+			err = -EEXIST;
+			goto out_err;
+		}
+	}
+	if (!(flags & LOOKUP_CREATE)) {
+		if (!dentry->d_inode) {
+			dput(dentry);
+			err = -ENOENT;
+			goto out_err;
+		}
+	}
 	if (wq && !d_lock_update(dentry, base, name)) {
 		/*
 		 * Failed to get lock due to race with unlink or rename
@@ -3838,7 +3860,7 @@ static struct dentry *filename_create_one(struct qstr *last, struct path *path,
 	struct dentry *dentry;
 	bool want_dir = lookup_flags & LOOKUP_DIRECTORY;
 	unsigned int reval_flag = lookup_flags & LOOKUP_REVAL;
-	unsigned int create_flags = LOOKUP_CREATE | LOOKUP_EXCL;
+	unsigned int create_flag = LOOKUP_CREATE;
 	int err2;
 	int error;
 
@@ -3849,26 +3871,17 @@ static struct dentry *filename_create_one(struct qstr *last, struct path *path,
 	 * '/', and a directory wasn't requested.
 	 */
 	if (last->name[last->len] && !want_dir)
-		create_flags = 0;
+		/* Name was foo/bar/ but not creating a directory, so
+		 * we won't try to create - result with be either -ENOENT
+		 * or -EEXIST.
+		 */
+		create_flag = 0;
 	dentry = lookup_hash_update(last, path->dentry,
-				    reval_flag | create_flags,  wq);
+				    reval_flag | create_flag | LOOKUP_EXCL,
+				    wq);
 	if (IS_ERR(dentry))
 		goto drop_write;
 
-	error = -EEXIST;
-	if (d_is_positive(dentry))
-		goto fail;
-
-	/*
-	 * Special case - lookup gave negative, but... we had foo/bar/
-	 * From the vfs_mknod() POV we just have a negative dentry -
-	 * all is fine. Let's be bastards - you had / on the end, you've
-	 * been asking for (non-existent) directory. -ENOENT for you.
-	 */
-	if (unlikely(!create_flags)) {
-		error = -ENOENT;
-		goto fail;
-	}
 	if (unlikely(err2)) {
 		error = err2;
 		goto fail;
@@ -4264,10 +4277,6 @@ int do_rmdir(int dfd, struct filename *name)
 	error = PTR_ERR(dentry);
 	if (IS_ERR(dentry))
 		goto exit3;
-	if (!dentry->d_inode) {
-		error = -ENOENT;
-		goto exit4;
-	}
 	error = security_path_rmdir(&path, dentry);
 	if (error)
 		goto exit4;
@@ -4407,8 +4416,6 @@ int do_unlinkat(int dfd, struct filename *name)
 		if (last.name[last.len])
 			goto slashes;
 		inode = dentry->d_inode;
-		if (d_is_negative(dentry))
-			goto slashes;
 		ihold(inode);
 		error = security_path_unlink(&path, dentry);
 		if (error)


