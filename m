Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5F813D8347
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jul 2021 00:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbhG0Wnh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 18:43:37 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:54054 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232449AbhG0Wnh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 18:43:37 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 767CC1FF31;
        Tue, 27 Jul 2021 22:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627425815; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9Vs3Pylsgp5mwqAihPx4If4U0ooiHOgHgod8MkA49/Q=;
        b=1imyhpcQPAElE++MT1bROHAJ2lTK3+5vRY8kRdiflawAsfgMVAvxfhBm/z4RrWSLyZNyuM
        VRUeU0HW0l0asfs/VrDtVik6+V4UtClsgesqbCP8JstiBrzlllW8PWrdMtxDARVxcm6xRP
        LGIiA4zW10+jtIhYRkYGQ3nKYTkR9/w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627425815;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9Vs3Pylsgp5mwqAihPx4If4U0ooiHOgHgod8MkA49/Q=;
        b=/Zf8YFdWKv+6CsF5e9OCySNWlNamfX/vsFct8llyCkILATrZ4U9GB7XtT+udmdEcdRDUN/
        WSxZriRMjkfbcZDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 890E213A5D;
        Tue, 27 Jul 2021 22:43:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ErgmEhSMAGHaVQAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 27 Jul 2021 22:43:32 +0000
Subject: [PATCH 08/11] nfsd: change get_parent_attributes() to
 nfsd_get_mounted_on()
From:   NeilBrown <neilb@suse.de>
To:     Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Date:   Wed, 28 Jul 2021 08:37:45 +1000
Message-ID: <162742546555.32498.13169105043649293291.stgit@noble.brown>
In-Reply-To: <162742539595.32498.13687924366155737575.stgit@noble.brown>
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

get_parent_attributes() is only used to get the inode number of the
mounted-on directory.  So change it to only do that and call it
nfsd_get_mounted_on().

It will eventually be use by nfs3 as well as nfs4, so move it to vfs.c.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4xdr.c |   29 +++++------------------------
 fs/nfsd/vfs.c     |   18 ++++++++++++++++++
 fs/nfsd/vfs.h     |    2 ++
 3 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 21c277fa28ae..d5683b6a74b2 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2768,22 +2768,6 @@ static __be32 fattr_handle_absent_fs(u32 *bmval0, u32 *bmval1, u32 *bmval2, u32
 	return 0;
 }
 
-
-static int get_parent_attributes(struct svc_export *exp, struct kstat *stat)
-{
-	struct path path = exp->ex_path;
-	int err;
-
-	path_get(&path);
-	while (follow_up(&path)) {
-		if (path.dentry != path.mnt->mnt_root)
-			break;
-	}
-	err = vfs_getattr(&path, stat, STATX_BASIC_STATS, AT_STATX_SYNC_AS_STAT);
-	path_put(&path);
-	return err;
-}
-
 static __be32
 nfsd4_encode_bitmap(struct xdr_stream *xdr, u32 bmval0, u32 bmval1, u32 bmval2)
 {
@@ -3269,8 +3253,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 		*p++ = cpu_to_be32(stat.mtime.tv_nsec);
 	}
 	if (bmval1 & FATTR4_WORD1_MOUNTED_ON_FILEID) {
-		struct kstat parent_stat;
-		u64 ino = stat.ino;
+		u64 ino;
 
 		p = xdr_reserve_space(xdr, 8);
 		if (!p)
@@ -3279,12 +3262,10 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 		 * Get parent's attributes if not ignoring crossmount
 		 * and this is the root of a cross-mounted filesystem.
 		 */
-		if (ignore_crossmnt == 0 && dentry == mnt->mnt_root) {
-			err = get_parent_attributes(exp, &parent_stat);
-			if (err)
-				goto out_nfserr;
-			ino = parent_stat.ino;
-		}
+		if (ignore_crossmnt == 0 && dentry == mnt->mnt_root)
+			ino = nfsd_get_mounted_on(mnt);
+		if (!ino)
+			ino = stat.ino;
 		p = xdr_encode_hyper(p, ino);
 	}
 #ifdef CONFIG_NFSD_PNFS
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index c0c6920f25a4..baa12ac36ece 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -2445,3 +2445,21 @@ nfsd_permission(struct svc_rqst *rqstp, struct svc_export *exp,
 
 	return err? nfserrno(err) : 0;
 }
+
+unsigned long nfsd_get_mounted_on(struct vfsmount *mnt)
+{
+	struct kstat stat;
+	struct path path = { .mnt = mnt, .dentry = mnt->mnt_root };
+	int err;
+
+	path_get(&path);
+	while (follow_up(&path)) {
+		if (path.dentry != path.mnt->mnt_root)
+			break;
+	}
+	err = vfs_getattr(&path, &stat, STATX_INO, AT_STATX_DONT_SYNC);
+	path_put(&path);
+	if (err)
+		return 0;
+	return stat.ino;
+}
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index 52f587716208..11ac36b21b4c 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -132,6 +132,8 @@ __be32		nfsd_statfs(struct svc_rqst *, struct svc_fh *,
 __be32		nfsd_permission(struct svc_rqst *, struct svc_export *,
 				struct dentry *, int);
 
+unsigned long	nfsd_get_mounted_on(struct vfsmount *mnt);
+
 static inline int fh_want_write(struct svc_fh *fh)
 {
 	int ret;


