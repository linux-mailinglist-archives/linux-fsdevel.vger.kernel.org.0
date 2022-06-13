Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A44754A2A3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jun 2022 01:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241188AbiFMXVQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jun 2022 19:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238757AbiFMXVC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jun 2022 19:21:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4016F3193F;
        Mon, 13 Jun 2022 16:20:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F2A431F97B;
        Mon, 13 Jun 2022 23:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1655162455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hi+NJU1EkxRpFX0rhWMXFKN8RYkXI07hcWLLJcSj+Iw=;
        b=Qk8MM4lxyxuscFI/U5jyjURjSgu+7yXFJVTxm/b9ReVhvhBZmz2iewmFxjoVfx91PrN2iB
        7MW//rnmUk05e1Ka/VaW10Od8QVd3J6QK+3JZ8C5glTPvti/KXQZelT69OSymITsYqz4XL
        PTPFUF/WwwJR7xJHZF3Oal/EmxhN3ns=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1655162455;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hi+NJU1EkxRpFX0rhWMXFKN8RYkXI07hcWLLJcSj+Iw=;
        b=3yD38L5wibetd93L5oFyPOLph9zHt6MstIvpHDuOGSAKa0kgCCeWPPbn1vWxmBGA9MQa2B
        W8pR0qZLoA6dcSAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DB3AF134CF;
        Mon, 13 Jun 2022 23:20:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WdEhJlTGp2LobwAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 13 Jun 2022 23:20:52 +0000
Subject: [PATCH 07/12] NFS: support parallel updates in the one directory.
From:   NeilBrown <neilb@suse.de>
To:     Al Viro <viro@zeniv.linux.org.uk>, Daire Byrne <daire@dneg.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 14 Jun 2022 09:18:22 +1000
Message-ID: <165516230200.21248.14713533079253477888.stgit@noble.brown>
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

NFS can easily support parallel updates as the locking is done on the
server, so this patch enables parallel updates for NFS.

NFS unlink needs to block concurrent opens() once it decides to actually
unlink the file, rather than rename it to .nfsXXXX (aka sillyrename).
It currently does this by temporarily unhashing the dentry and relying
on the exclusive lock on the directory to block a ->lookup().  That
doesn't work now that unlink uses a shared lock, so an alternate
approach is needed.

__nfs_lookup_revalidate (->d_revalidate) now blocks if DCACHE_PAR_UPDATE
is set, and if nfs_unlink() happens to be called with an exclusive lock
and DCACHE_PAR_UPDATE is not set, it get set during the potential race window.

I'd rather use some other indicator in the dentry to tell
_nfs_lookup_revalidate() to wait, but we are nearly out of d_flags bits,
and NFS doesn't have a general-purpose d_fsdata.

NFS "silly-rename" may now be called with only a shared lock on the
directory, so it needs a bit of extra care to get exclusive access to
the new name. d_lock_update_nested() and d_unlock_update() help here.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfs/dir.c    |   29 +++++++++++++++++++++++------
 fs/nfs/inode.c  |    2 ++
 fs/nfs/unlink.c |    5 ++++-
 3 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index a8ecdd527662..54c2c7adcd56 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1778,6 +1778,9 @@ __nfs_lookup_revalidate(struct dentry *dentry, unsigned int flags,
 	int ret;
 
 	if (flags & LOOKUP_RCU) {
+		if (dentry->d_flags & DCACHE_PAR_UPDATE)
+			/* Pending unlink */
+			return -ECHILD;
 		parent = READ_ONCE(dentry->d_parent);
 		dir = d_inode_rcu(parent);
 		if (!dir)
@@ -1786,6 +1789,9 @@ __nfs_lookup_revalidate(struct dentry *dentry, unsigned int flags,
 		if (parent != READ_ONCE(dentry->d_parent))
 			return -ECHILD;
 	} else {
+		/* Wait for unlink to complete */
+		wait_var_event(&dentry->d_flags,
+			       !(dentry->d_flags & DCACHE_PAR_UPDATE));
 		parent = dget_parent(dentry);
 		ret = reval(d_inode(parent), dentry, flags);
 		dput(parent);
@@ -2453,7 +2459,7 @@ static int nfs_safe_remove(struct dentry *dentry)
 int nfs_unlink(struct inode *dir, struct dentry *dentry)
 {
 	int error;
-	int need_rehash = 0;
+	bool did_set_par_update = false;
 
 	dfprintk(VFS, "NFS: unlink(%s/%lu, %pd)\n", dir->i_sb->s_id,
 		dir->i_ino, dentry);
@@ -2468,15 +2474,26 @@ int nfs_unlink(struct inode *dir, struct dentry *dentry)
 		error = nfs_sillyrename(dir, dentry);
 		goto out;
 	}
-	if (!d_unhashed(dentry)) {
-		__d_drop(dentry);
-		need_rehash = 1;
+	/* We must prevent any concurrent open until the unlink
+	 * completes.  ->d_revalidate will wait for DCACHE_PAR_UPDATE
+	 * to clear, but if this happens to a non-parallel update, we
+	 * still want to block opens.  So set DCACHE_PAR_UPDATE
+	 * temporarily.
+	 */
+	if (!(dentry->d_flags & DCACHE_PAR_UPDATE)) {
+		/* Must have exclusive lock on parent */
+		did_set_par_update = true;
+		dentry->d_flags |= DCACHE_PAR_UPDATE;
 	}
+
 	spin_unlock(&dentry->d_lock);
 	error = nfs_safe_remove(dentry);
 	nfs_dentry_remove_handle_error(dir, dentry, error);
-	if (need_rehash)
-		d_rehash(dentry);
+	if (did_set_par_update) {
+		spin_lock(&dentry->d_lock);
+		dentry->d_flags &= ~DCACHE_PAR_UPDATE;
+		spin_unlock(&dentry->d_lock);
+	}
 out:
 	trace_nfs_unlink_exit(dir, dentry, error);
 	return error;
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index b4e46b0ffa2d..cea2554710d2 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -481,6 +481,8 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr)
 
 		/* We can't support update_atime(), since the server will reset it */
 		inode->i_flags |= S_NOATIME|S_NOCMTIME;
+		/* Parallel updates to directories are trivial */
+		inode->i_flags |= S_PAR_UPDATE;
 		inode->i_mode = fattr->mode;
 		nfsi->cache_validity = 0;
 		if ((fattr->valid & NFS_ATTR_FATTR_MODE) == 0
diff --git a/fs/nfs/unlink.c b/fs/nfs/unlink.c
index 9697cd5d2561..52a20eb6131c 100644
--- a/fs/nfs/unlink.c
+++ b/fs/nfs/unlink.c
@@ -462,6 +462,7 @@ nfs_sillyrename(struct inode *dir, struct dentry *dentry)
 	sdentry = NULL;
 	do {
 		int slen;
+		d_unlock_update(sdentry);
 		dput(sdentry);
 		sillycounter++;
 		slen = scnprintf(silly, sizeof(silly),
@@ -479,7 +480,8 @@ nfs_sillyrename(struct inode *dir, struct dentry *dentry)
 		 */
 		if (IS_ERR(sdentry))
 			goto out;
-	} while (d_inode(sdentry) != NULL); /* need negative lookup */
+	} while (!d_lock_update_nested(sdentry, NULL, NULL,
+				       SINGLE_DEPTH_NESTING));
 
 	ihold(inode);
 
@@ -524,6 +526,7 @@ nfs_sillyrename(struct inode *dir, struct dentry *dentry)
 	rpc_put_task(task);
 out_dput:
 	iput(inode);
+	d_unlock_update(sdentry);
 	dput(sdentry);
 out:
 	return error;


