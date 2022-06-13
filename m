Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB13954A2A7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jun 2022 01:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241052AbiFMXWD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jun 2022 19:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344736AbiFMXVv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jun 2022 19:21:51 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA09D2B25E;
        Mon, 13 Jun 2022 16:21:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9A93321A94;
        Mon, 13 Jun 2022 23:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1655162497; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H2JdOUtYS+FdB9BrIAmOm6nhk+rYQ/dm6rYDIh55AvU=;
        b=COvRa52h8t3jlyOI2GLKfLw0FRdz9F/uwAnFIDQ2qhjfAZthIOeXjmVE09j9C5Wi8ibCXD
        UyIqZS1Ljm5/zzGz4ECoZConPG5hPUYybs5qBEnuYFuImz4/nmmx5n6LNRRNt+iR8Ue14A
        mvV4+DgVxa7fWelX9YlPuatTUXXSJMQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1655162497;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H2JdOUtYS+FdB9BrIAmOm6nhk+rYQ/dm6rYDIh55AvU=;
        b=8FO1rfDBUEXsdnOBT3BpxLyrw3HAjQeCz6ULNJlPwD6EGxHCnUVkQUcZ9d97e15Gdav3/S
        jQGZXPeP/bIUMTDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 624BE134CF;
        Mon, 13 Jun 2022 23:21:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id I5SpB3/Gp2IScAAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 13 Jun 2022 23:21:35 +0000
Subject: [PATCH 09/12] nfsd: support concurrent renames.
From:   NeilBrown <neilb@suse.de>
To:     Al Viro <viro@zeniv.linux.org.uk>, Daire Byrne <daire@dneg.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 14 Jun 2022 09:18:22 +1000
Message-ID: <165516230201.21248.13160043266041158437.stgit@noble.brown>
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

If the filesystem supports it, renames can now be concurrent with other
updates.
We use lock_rename_lookup_one() to do the appropriate locking in the
right order and to look up the names.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/vfs.c |   49 +++++++++++++++++++------------------------------
 1 file changed, 19 insertions(+), 30 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 6cdd5e407600..b0df216ab3e4 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1584,6 +1584,7 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 	__be32		err;
 	int		host_err;
 	bool		close_cached = false;
+	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 
 	err = fh_verify(rqstp, ffhp, S_IFDIR, NFSD_MAY_REMOVE);
 	if (err)
@@ -1611,41 +1612,37 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 
 	/* cannot use fh_lock as we need deadlock protective ordering
 	 * so do it by hand */
-	trap = lock_rename(tdentry, fdentry);
-	ffhp->fh_locked = tfhp->fh_locked = true;
-	fh_fill_pre_attrs(ffhp, true);
-	fh_fill_pre_attrs(tfhp, true);
-
-	odentry = lookup_one_len(fname, fdentry, flen);
-	host_err = PTR_ERR(odentry);
-	if (IS_ERR(odentry))
+	trap = lock_rename_lookup_one(tdentry, fdentry, &ndentry, &odentry,
+				      tname, tlen, fname, flen, 0, 0, &wq);
+	host_err = PTR_ERR(trap);
+	if (IS_ERR(trap))
 		goto out_nfserr;
+	ffhp->fh_locked = tfhp->fh_locked = true;
+	fh_fill_pre_attrs(ffhp, (ndentry->d_flags & DCACHE_PAR_UPDATE) == 0);
+	fh_fill_pre_attrs(tfhp, (ndentry->d_flags & DCACHE_PAR_UPDATE) == 0);
 
 	host_err = -ENOENT;
 	if (d_really_is_negative(odentry))
-		goto out_dput_old;
+		goto out_unlock;
 	host_err = -EINVAL;
 	if (odentry == trap)
-		goto out_dput_old;
+		goto out_unlock;
 
-	ndentry = lookup_one_len(tname, tdentry, tlen);
-	host_err = PTR_ERR(ndentry);
-	if (IS_ERR(ndentry))
-		goto out_dput_old;
 	host_err = -ENOTEMPTY;
 	if (ndentry == trap)
-		goto out_dput_new;
+		goto out_unlock;
 
 	host_err = -EXDEV;
 	if (ffhp->fh_export->ex_path.mnt != tfhp->fh_export->ex_path.mnt)
-		goto out_dput_new;
+		goto out_unlock;
 	if (ffhp->fh_export->ex_path.dentry != tfhp->fh_export->ex_path.dentry)
-		goto out_dput_new;
+		goto out_unlock;
 
 	if ((ndentry->d_sb->s_export_op->flags & EXPORT_OP_CLOSE_BEFORE_UNLINK) &&
 	    nfsd_has_cached_files(ndentry)) {
 		close_cached = true;
-		goto out_dput_old;
+		dget(ndentry);
+		goto out_unlock;
 	} else {
 		struct renamedata rd = {
 			.old_mnt_userns	= &init_user_ns,
@@ -1662,23 +1659,15 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 				host_err = commit_metadata(ffhp);
 		}
 	}
- out_dput_new:
-	dput(ndentry);
- out_dput_old:
-	dput(odentry);
- out_nfserr:
-	err = nfserrno(host_err);
-	/*
-	 * We cannot rely on fh_unlock on the two filehandles,
-	 * as that would do the wrong thing if the two directories
-	 * were the same, so again we do it by hand.
-	 */
 	if (!close_cached) {
 		fh_fill_post_attrs(ffhp);
 		fh_fill_post_attrs(tfhp);
 	}
-	unlock_rename(tdentry, fdentry);
+ out_unlock:
+	unlock_rename_lookup(tdentry, fdentry, ndentry, odentry);
 	ffhp->fh_locked = tfhp->fh_locked = false;
+ out_nfserr:
+	err = nfserrno(host_err);
 	fh_drop_write(ffhp);
 
 	/*


