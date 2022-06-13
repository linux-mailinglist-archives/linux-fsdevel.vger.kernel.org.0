Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C640454A29D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jun 2022 01:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244914AbiFMXWJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jun 2022 19:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiFMXV5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jun 2022 19:21:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B8531934;
        Mon, 13 Jun 2022 16:21:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5F64A21A94;
        Mon, 13 Jun 2022 23:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1655162515; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QYs285JaZzfqdkUZfAfHwZpMuNRbKqBl3ciDgYuYxqA=;
        b=et/ijtr4zzBtQZn1hpaR6U+mm7mUKnkcxTlgtxuIQ0Z4Qv48UR3hXQwkv6aC7j+52+0kCW
        HlfWzUYjkombYWtdjMcbXd5p6cSWMJ+9KffQFAteJqUjmQf2ld6D/Q+r5FxclXYtmEs4nU
        Y/vQ2fNm0xc8Be0tEzKl1B+Bqkfqckg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1655162515;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QYs285JaZzfqdkUZfAfHwZpMuNRbKqBl3ciDgYuYxqA=;
        b=TxYsvrvWSN89CQtbx6XuyaMg6ZA3tcc/EDJkxSydFMBqczlr+4Woyl6sXnE3CDfqY5N3v3
        0+CftBQ93RtT6dAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 27176134CF;
        Mon, 13 Jun 2022 23:21:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JbXBNJDGp2IqcAAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 13 Jun 2022 23:21:52 +0000
Subject: [PATCH 12/12] nfsd: discard fh_locked flag and fh_lock/fh_unlock
From:   NeilBrown <neilb@suse.de>
To:     Al Viro <viro@zeniv.linux.org.uk>, Daire Byrne <daire@dneg.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 14 Jun 2022 09:18:22 +1000
Message-ID: <165516230204.21248.4630581281540290265.stgit@noble.brown>
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

fh_lock() and fh_unlock() are no longer used, so discard them.
They are the only real users of ->fh_locked, so discard that too.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfsfh.c |    2 +-
 fs/nfsd/nfsfh.h |   48 ++++--------------------------------------------
 fs/nfsd/vfs.c   |    4 ----
 3 files changed, 5 insertions(+), 49 deletions(-)

diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index ae270e4f921f..a3dbe9f34c0e 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -548,7 +548,7 @@ fh_compose(struct svc_fh *fhp, struct svc_export *exp, struct dentry *dentry,
 	if (ref_fh == fhp)
 		fh_put(ref_fh);
 
-	if (fhp->fh_locked || fhp->fh_dentry) {
+	if (fhp->fh_dentry) {
 		printk(KERN_ERR "fh_compose: fh %pd2 not initialized!\n",
 		       dentry);
 	}
diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
index c5061cdb1016..559912b1d794 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -81,7 +81,6 @@ typedef struct svc_fh {
 	struct dentry *		fh_dentry;	/* validated dentry */
 	struct svc_export *	fh_export;	/* export pointer */
 
-	bool			fh_locked;	/* inode locked by us */
 	bool			fh_want_write;	/* remount protection taken */
 	bool			fh_no_wcc;	/* no wcc data needed */
 	bool			fh_no_atomic_attr;
@@ -93,7 +92,7 @@ typedef struct svc_fh {
 	bool			fh_post_saved;	/* post-op attrs saved */
 	bool			fh_pre_saved;	/* pre-op attrs saved */
 
-	/* Pre-op attributes saved during fh_lock */
+	/* Pre-op attributes saved when inode exclusively locked */
 	__u64			fh_pre_size;	/* size before operation */
 	struct timespec64	fh_pre_mtime;	/* mtime before oper */
 	struct timespec64	fh_pre_ctime;	/* ctime before oper */
@@ -103,7 +102,7 @@ typedef struct svc_fh {
 	 */
 	u64			fh_pre_change;
 
-	/* Post-op attributes saved in fh_unlock */
+	/* Post-op attributes saved in fh_fill_post_attrs() */
 	struct kstat		fh_post_attr;	/* full attrs after operation */
 	u64			fh_post_change; /* nfsv4 change; see above */
 } svc_fh;
@@ -223,8 +222,8 @@ void	fh_put(struct svc_fh *);
 static __inline__ struct svc_fh *
 fh_copy(struct svc_fh *dst, struct svc_fh *src)
 {
-	WARN_ON(src->fh_dentry || src->fh_locked);
-			
+	WARN_ON(src->fh_dentry);
+
 	*dst = *src;
 	return dst;
 }
@@ -323,43 +322,4 @@ static inline u64 nfsd4_change_attribute(struct kstat *stat,
 extern void fh_fill_pre_attrs(struct svc_fh *fhp, bool atomic);
 extern void fh_fill_post_attrs(struct svc_fh *fhp);
 
-static inline void
-fh_lock_nested(struct svc_fh *fhp, unsigned int subclass)
-{
-	struct dentry	*dentry = fhp->fh_dentry;
-	struct inode	*inode;
-
-	BUG_ON(!dentry);
-
-	if (fhp->fh_locked) {
-		printk(KERN_WARNING "fh_lock: %pd2 already locked!\n",
-			dentry);
-		return;
-	}
-
-	inode = d_inode(dentry);
-	inode_lock_nested(inode, subclass);
-	fh_fill_pre_attrs(fhp, true);
-	fhp->fh_locked = true;
-}
-
-static inline void
-fh_lock(struct svc_fh *fhp)
-{
-	fh_lock_nested(fhp, I_MUTEX_NORMAL);
-}
-
-/*
- * Unlock a file handle/inode
- */
-static inline void
-fh_unlock(struct svc_fh *fhp)
-{
-	if (fhp->fh_locked) {
-		fh_fill_post_attrs(fhp);
-		inode_unlock(d_inode(fhp->fh_dentry));
-		fhp->fh_locked = false;
-	}
-}
-
 #endif /* _LINUX_NFSD_NFSFH_H */
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index f2f4868618bb..0e07b19a0289 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1623,14 +1623,11 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 		goto out;
 	}
 
-	/* cannot use fh_lock as we need deadlock protective ordering
-	 * so do it by hand */
 	trap = lock_rename_lookup_one(tdentry, fdentry, &ndentry, &odentry,
 				      tname, tlen, fname, flen, 0, 0, &wq);
 	host_err = PTR_ERR(trap);
 	if (IS_ERR(trap))
 		goto out_nfserr;
-	ffhp->fh_locked = tfhp->fh_locked = true;
 	fh_fill_pre_attrs(ffhp, (ndentry->d_flags & DCACHE_PAR_UPDATE) == 0);
 	fh_fill_pre_attrs(tfhp, (ndentry->d_flags & DCACHE_PAR_UPDATE) == 0);
 
@@ -1678,7 +1675,6 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 	}
  out_unlock:
 	unlock_rename_lookup(tdentry, fdentry, ndentry, odentry);
-	ffhp->fh_locked = tfhp->fh_locked = false;
  out_nfserr:
 	err = nfserrno(host_err);
 	fh_drop_write(ffhp);


