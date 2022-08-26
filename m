Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05875A1EBA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Aug 2022 04:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243013AbiHZCTk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Aug 2022 22:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiHZCTi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Aug 2022 22:19:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72FEBCC33E;
        Thu, 25 Aug 2022 19:19:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BFAAF20684;
        Fri, 26 Aug 2022 02:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1661480365; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5652YvS1xa2Qe9hIcsZbOxfW+QuG+ADDYX81GrYMHlk=;
        b=X6xQvAOc2qsbJ9MzbPY5xErByR+Hc8rrq8ln5j1eTMSAruTCjtgxaly7c0cdb6S1bwXVt1
        CGXvoKr3WP/+itGQ6cxMZwG7uWC3Ua9PyiX7V13zlb7ExTwixUfYF+X9HhQl2BvTRf3vwH
        gJ567FdpvwSb8DHYrMr1rxu2RJf4LZo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1661480365;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5652YvS1xa2Qe9hIcsZbOxfW+QuG+ADDYX81GrYMHlk=;
        b=LHTjuaxJ4Z7DaUu11xbnGvvoLrpn49/MxSTlK6Km37JbDRklg9K+0IhpIQV+KVyoQIdXRN
        oN0P/aQGRhkA4DDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9E18813A65;
        Fri, 26 Aug 2022 02:19:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /lZSF6otCGP7MQAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 26 Aug 2022 02:19:22 +0000
Subject: [PATCH 10/10] NFS: support parallel updates in the one directory.
From:   NeilBrown <neilb@suse.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Daire Byrne <daire@dneg.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Date:   Fri, 26 Aug 2022 12:10:43 +1000
Message-ID: <166147984378.25420.4023980607067991846.stgit@noble.brown>
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

NFS can easily support parallel updates as the locking is done on the
server, so this patch enables parallel updates for NFS.

Handling of silly-rename - both for unlink and for the rename target -
requires some care as we need to get an exclusive lock on the chosen
silly name and for rename we need to keep the original target name
locked after it has been renamed to the silly name.

So nfs_sillyrename() now uses d_exchange() to swap the target and the
silly name after the silly-rename has happened on the server, and the
silly dentry - which now has the name of the target - is returned.

For unlink(), this is immediately unlocked and discarded with a call to
nfs_sillyrename_finish().  For rename it is kept locked until the
originally requested rename completes.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/dcache.c         |    5 ++++-
 fs/nfs/dir.c        |   28 ++++++++++++++++------------
 fs/nfs/fs_context.c |    6 ++++--
 fs/nfs/internal.h   |    3 ++-
 fs/nfs/unlink.c     |   51 ++++++++++++++++++++++++++++++++++++++-------------
 5 files changed, 64 insertions(+), 29 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 9bf346a9de52..a5eaab16d39f 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -3056,7 +3056,9 @@ void d_exchange(struct dentry *dentry1, struct dentry *dentry2)
 	write_seqlock(&rename_lock);
 
 	WARN_ON(!dentry1->d_inode);
-	WARN_ON(!dentry2->d_inode);
+	/* Allow dentry2 to be negative, so we can do a rename
+	 * but keep both names locked (DCACHE_PAR_UPDATE)
+	 */
 	WARN_ON(IS_ROOT(dentry1));
 	WARN_ON(IS_ROOT(dentry2));
 
@@ -3064,6 +3066,7 @@ void d_exchange(struct dentry *dentry1, struct dentry *dentry2)
 
 	write_sequnlock(&rename_lock);
 }
+EXPORT_SYMBOL(d_exchange);
 
 /**
  * d_ancestor - search for an ancestor
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 5d6c2ddc7ea6..fbb608fbe6bf 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1935,8 +1935,12 @@ struct dentry *nfs_lookup(struct inode *dir, struct dentry * dentry, unsigned in
 	/*
 	 * If we're doing an exclusive create, optimize away the lookup
 	 * but don't hash the dentry.
+	 * A silly_rename is marked exclusive, but we need to do an
+	 * explicit lookup.
 	 */
-	if (nfs_is_exclusive_create(dir, flags) || flags & LOOKUP_RENAME_TARGET)
+	if ((nfs_is_exclusive_create(dir, flags) ||
+	     flags & LOOKUP_RENAME_TARGET) &&
+	    !(flags & LOOKUP_SILLY_RENAME))
 		return NULL;
 
 	res = ERR_PTR(-ENOMEM);
@@ -2472,10 +2476,14 @@ int nfs_unlink(struct inode *dir, struct dentry *dentry)
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
+		error = PTR_ERR_OR_ZERO(silly);
+		nfs_sillyrename_finish(dir, silly);
 		goto out;
 	}
 	/* We must prevent any concurrent open until the unlink
@@ -2685,16 +2693,12 @@ int nfs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 
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
@@ -2750,9 +2754,9 @@ int nfs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 	} else if (error == -ENOENT)
 		nfs_dentry_handle_enoent(old_dentry);
 
-	/* new dentry created? */
 	if (dentry)
-		dput(dentry);
+		nfs_sillyrename_finish(new_dir, dentry);
+
 	return error;
 }
 EXPORT_SYMBOL_GPL(nfs_rename);
diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index 4da701fd1424..7133ca9433d2 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -1577,7 +1577,8 @@ struct file_system_type nfs_fs_type = {
 	.init_fs_context	= nfs_init_fs_context,
 	.parameters		= nfs_fs_parameters,
 	.kill_sb		= nfs_kill_super,
-	.fs_flags		= FS_RENAME_DOES_D_MOVE|FS_BINARY_MOUNTDATA,
+	.fs_flags		= FS_RENAME_DOES_D_MOVE|FS_BINARY_MOUNTDATA|
+				  FS_PAR_DIR_UPDATE,
 };
 MODULE_ALIAS_FS("nfs");
 EXPORT_SYMBOL_GPL(nfs_fs_type);
@@ -1589,7 +1590,8 @@ struct file_system_type nfs4_fs_type = {
 	.init_fs_context	= nfs_init_fs_context,
 	.parameters		= nfs_fs_parameters,
 	.kill_sb		= nfs_kill_super,
-	.fs_flags		= FS_RENAME_DOES_D_MOVE|FS_BINARY_MOUNTDATA,
+	.fs_flags		= FS_RENAME_DOES_D_MOVE|FS_BINARY_MOUNTDATA|
+				  FS_PAR_DIR_UPDATE,
 };
 MODULE_ALIAS_FS("nfs4");
 MODULE_ALIAS("nfs4");
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 27c720d71b4e..3a7fd30a8e29 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -611,7 +611,8 @@ extern struct rpc_task *
 nfs_async_rename(struct inode *old_dir, struct inode *new_dir,
 		 struct dentry *old_dentry, struct dentry *new_dentry,
 		 void (*complete)(struct rpc_task *, struct nfs_renamedata *));
-extern int nfs_sillyrename(struct inode *dir, struct dentry *dentry);
+extern struct dentry *nfs_sillyrename(struct inode *dir, struct dentry *dentry);
+extern void nfs_sillyrename_finish(struct inode *dir, struct dentry *dentry);
 
 /* direct.c */
 void nfs_init_cinfo_from_dreq(struct nfs_commit_info *cinfo,
diff --git a/fs/nfs/unlink.c b/fs/nfs/unlink.c
index 9697cd5d2561..c8a718f09fe6 100644
--- a/fs/nfs/unlink.c
+++ b/fs/nfs/unlink.c
@@ -428,6 +428,10 @@ nfs_complete_sillyrename(struct rpc_task *task, struct nfs_renamedata *data)
  *
  * The final cleanup is done during dentry_iput.
  *
+ * We exchange the original with the new (silly) dentries, and return
+ * the new dentry which will have the original name.  This ensures that
+ * the target name remains locked until the rename completes.
+ *
  * (Note: NFSv4 is stateful, and has opens, so in theory an NFSv4 server
  * could take responsibility for keeping open files referenced.  The server
  * would also need to ensure that opened-but-deleted files were kept over
@@ -436,7 +440,7 @@ nfs_complete_sillyrename(struct rpc_task *task, struct nfs_renamedata *data)
  * use to advertise that it does this; some day we may take advantage of
  * it.))
  */
-int
+struct dentry *
 nfs_sillyrename(struct inode *dir, struct dentry *dentry)
 {
 	static unsigned int sillycounter;
@@ -445,6 +449,8 @@ nfs_sillyrename(struct inode *dir, struct dentry *dentry)
 	struct dentry *sdentry;
 	struct inode *inode = d_inode(dentry);
 	struct rpc_task *task;
+	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
+	struct path path = {};
 	int            error = -EBUSY;
 
 	dfprintk(VFS, "NFS: silly-rename(%pd2, ct=%d)\n",
@@ -459,10 +465,11 @@ nfs_sillyrename(struct inode *dir, struct dentry *dentry)
 
 	fileid = NFS_FILEID(d_inode(dentry));
 
+	path.dentry = d_find_alias(dir);
 	sdentry = NULL;
 	do {
 		int slen;
-		dput(sdentry);
+
 		sillycounter++;
 		slen = scnprintf(silly, sizeof(silly),
 				SILLYNAME_PREFIX "%0*llx%0*x",
@@ -472,14 +479,19 @@ nfs_sillyrename(struct inode *dir, struct dentry *dentry)
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
+		sdentry = filename_create_one_len(silly, slen,
+						  &path,
+						  LOOKUP_CREATE | LOOKUP_EXCL |
+						  LOOKUP_SILLY_RENAME,
+						  &wq);
+	} while (PTR_ERR_OR_ZERO(sdentry) == -EEXIST);
+	dput(path.dentry);
+	/*
+	 * N.B. Better to return EBUSY here ... it could be
+	 * dangerous to delete the file while it's in use.
+	 */
+	if (IS_ERR(sdentry))
+		goto out;
 
 	ihold(inode);
 
@@ -513,7 +525,7 @@ nfs_sillyrename(struct inode *dir, struct dentry *dentry)
 						     NFS_INO_INVALID_CTIME |
 						     NFS_INO_REVAL_FORCED);
 		spin_unlock(&inode->i_lock);
-		d_move(dentry, sdentry);
+		d_exchange(dentry, sdentry);
 		break;
 	case -ERESTARTSYS:
 		/* The result of the rename is unknown. Play it safe by
@@ -524,7 +536,20 @@ nfs_sillyrename(struct inode *dir, struct dentry *dentry)
 	rpc_put_task(task);
 out_dput:
 	iput(inode);
-	dput(sdentry);
+	if (!error)
+		return sdentry;
+
+	d_lookup_done(sdentry);
+	__done_path_update(&path, sdentry, true, LOOKUP_SILLY_RENAME);
 out:
-	return error;
+	return ERR_PTR(error);
+}
+
+void nfs_sillyrename_finish(struct inode *dir, struct dentry *dentry)
+{
+	struct path path = { .dentry = d_find_alias(dir) };
+
+	if (!IS_ERR(dentry))
+		__done_path_update(&path, dentry, true, LOOKUP_SILLY_RENAME);
+	dput(path.dentry);
 }


