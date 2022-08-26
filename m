Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F3E5A1EA1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Aug 2022 04:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244736AbiHZCRW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Aug 2022 22:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244739AbiHZCRS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Aug 2022 22:17:18 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAB9CB5D9;
        Thu, 25 Aug 2022 19:17:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 60F5A20781;
        Fri, 26 Aug 2022 02:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1661480230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IAy5RIlK+BKXr3TtbnQGrDhGvJvfQnV3J6gfvsVI2SI=;
        b=Y6yj7S4oNnQdmlZED4Sv2odlp45fzx1VpVUavURqmBrMe1lS8cFAWL7Vr+fDDacDg86PBP
        xlvopoqEdpGN90wF/FxrX0wXM+JlFXMjdgunwCGmCPt3lUXRcZ1z+75W46z72RDtladjCl
        Xmgy1l2RHbiBbHMnt2HUgbQqm5i7H48=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1661480230;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IAy5RIlK+BKXr3TtbnQGrDhGvJvfQnV3J6gfvsVI2SI=;
        b=Ua0xxjneF59o45AsOnrN7VuFr9bOCgaBvcGGtWeZBzHmtOxoOIbXZjZ66XIWEE++e7f+I0
        QZ6LBjQNCDAYrTAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4057313A65;
        Fri, 26 Aug 2022 02:16:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id J8SJOhotCGNZMQAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 26 Aug 2022 02:16:58 +0000
Subject: [PATCH 02/10] VFS: move EEXIST and ENOENT tests into
 lookup_hash_update()
From:   NeilBrown <neilb@suse.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Daire Byrne <daire@dneg.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Date:   Fri, 26 Aug 2022 12:10:43 +1000
Message-ID: <166147984373.25420.5973159222199992210.stgit@noble.brown>
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

Moving common error handling into lookup_hash_update() simplifies
callers.
A future patch will export this functionality to nfsd, and the more code
we put in the interface, the less code will be needed in nfsd.

EEXIST is returned if LOOKUP_EXCL is set and dentry is positivie.
ENOENT is returned if LOOKUP_CREAT is NOT set and dentry is negative.

This involves seting LOOKUP_EXCL in cases where it wasn't before.
In particular, when creating a non-dir named "foo/", we want the
EEXIST error, but don't want to actually create anything.
Some filesystems assume LOOKUP_EXCL implies LOOKUP_CREATE, so ensure it
does when calling ->lookup().

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/namei.c |   58 ++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 34 insertions(+), 24 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index c008dfd01e30..09c2d007814a 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1562,7 +1562,13 @@ static struct dentry *lookup_dcache(const struct qstr *name,
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
 static struct dentry *lookup_hash_update(
 	const struct qstr *name,
@@ -1651,6 +1659,24 @@ static struct dentry *lookup_hash_update(
 		dput(dentry);
 		goto retry;
 	}
+	if (flags & LOOKUP_EXCL) {
+		if (d_is_positive(dentry)) {
+			d_lookup_done(dentry);
+			d_unlock_update(dentry);
+			dput(dentry);
+			err = -EEXIST;
+			goto out_err;
+		}
+	}
+	if (!(flags & LOOKUP_CREATE)) {
+		if (!dentry->d_inode) {
+			d_lookup_done(dentry);
+			d_unlock_update(dentry);
+			dput(dentry);
+			err = -ENOENT;
+			goto out_err;
+		}
+	}
 	return dentry;
 
 out_err:
@@ -3868,7 +3894,7 @@ static struct dentry *filename_create_one(struct qstr *last, struct path *path,
 	struct dentry *dentry;
 	bool want_dir = lookup_flags & LOOKUP_DIRECTORY;
 	unsigned int reval_flag = lookup_flags & LOOKUP_REVAL;
-	unsigned int create_flags = LOOKUP_CREATE | LOOKUP_EXCL;
+	unsigned int create_flag = LOOKUP_CREATE;
 	int err2;
 	int error;
 
@@ -3879,26 +3905,16 @@ static struct dentry *filename_create_one(struct qstr *last, struct path *path,
 	 * '/', and a directory wasn't requested.
 	 */
 	if (last->name[last->len] && !want_dir)
-		create_flags = 0;
+		/* Name was foo/bar/ but not creating a directory, so
+		 * we won't try to create - result will be either -ENOENT
+		 * or -EEXIST.
+		 */
+		create_flag = 0;
 	dentry = lookup_hash_update(last, path->dentry,
-				    reval_flag | create_flags,  wq);
+				    reval_flag | create_flag | LOOKUP_EXCL, wq);
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
@@ -4292,10 +4308,6 @@ int do_rmdir(int dfd, struct filename *name)
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
@@ -4435,8 +4447,6 @@ int do_unlinkat(int dfd, struct filename *name)
 		if (last.name[last.len])
 			goto slashes;
 		inode = dentry->d_inode;
-		if (d_is_negative(dentry))
-			goto slashes;
 		ihold(inode);
 		error = security_path_unlink(&path, dentry);
 		if (error)


