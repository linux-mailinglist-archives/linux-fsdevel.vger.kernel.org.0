Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E27C43D8351
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jul 2021 00:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbhG0Wnt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 18:43:49 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57288 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233162AbhG0Wnp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 18:43:45 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C19DA22236;
        Tue, 27 Jul 2021 22:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627425823; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9I86czI1fNP5NdLjZctZyiavaatPy8v72YtRXA3YdQI=;
        b=SXdOAfHSMW1DgAuiFY0EfuDmnvc1yrNE8dpub++9OMNIrzebAIBzEgnvStJ1keSSbCNDXE
        e8uPn7J1/AMU12E+KflRmCjo3S8ZtjgIntoUxkvbqdHgpX/OZSVvou2O+2bWQ1lTCUnCbz
        LOvpLOLFYLbaUtkGN4CbBAmwPRQQC7g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627425823;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9I86czI1fNP5NdLjZctZyiavaatPy8v72YtRXA3YdQI=;
        b=Q1GO7xH+bIjb6SBBTG0/CAWxdQzelw72uxiT4R/6ubW3+5sGZbd6uMHbLMMggYRa4CPPWA
        0K2XIV8imdNAPDDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DC1C713A5D;
        Tue, 27 Jul 2021 22:43:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bEZIJhyMAGHiVQAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 27 Jul 2021 22:43:40 +0000
Subject: [PATCH 09/11] nfsd: Allow filehandle lookup to cross internal mount
 points.
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
Message-ID: <162742546556.32498.16708762469227881912.stgit@noble.brown>
In-Reply-To: <162742539595.32498.13687924366155737575.stgit@noble.brown>
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Enhance nfsd to detect internal mounts and to cross them without
requiring a new export.

Also ensure the fsid reported is different for different submounts.  We
do this by xoring in the ino of the mounted-on directory.  This makes
sense for btrfs at least.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs3xdr.c |   28 +++++++++++++++++++++-------
 fs/nfsd/nfs4xdr.c |   34 +++++++++++++++++++++++-----------
 fs/nfsd/nfsfh.c   |    7 ++++++-
 fs/nfsd/vfs.c     |   11 +++++++++--
 4 files changed, 59 insertions(+), 21 deletions(-)

diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 67af0c5c1543..80b1cc0334fa 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -370,6 +370,8 @@ svcxdr_encode_fattr3(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 	case FSIDSOURCE_UUID:
 		fsid = ((u64 *)fhp->fh_export->ex_uuid)[0];
 		fsid ^= ((u64 *)fhp->fh_export->ex_uuid)[1];
+		if (fhp->fh_mnt != fhp->fh_export->ex_path.mnt)
+			fsid ^= nfsd_get_mounted_on(fhp->fh_mnt);
 		break;
 	default:
 		fsid = (u64)huge_encode_dev(fhp->fh_dentry->d_sb->s_dev);
@@ -1094,8 +1096,8 @@ compose_entry_fh(struct nfsd3_readdirres *cd, struct svc_fh *fhp,
 	__be32 rv = nfserr_noent;
 
 	dparent = cd->fh.fh_dentry;
-	exp  = cd->fh.fh_export;
-	child.mnt = cd->fh.fh_mnt;
+	exp  = exp_get(cd->fh.fh_export);
+	child.mnt = mntget(cd->fh.fh_mnt);
 
 	if (isdotent(name, namlen)) {
 		if (namlen == 2) {
@@ -1112,15 +1114,27 @@ compose_entry_fh(struct nfsd3_readdirres *cd, struct svc_fh *fhp,
 			child.dentry = dget(dparent);
 	} else
 		child.dentry = lookup_positive_unlocked(name, dparent, namlen);
-	if (IS_ERR(child.dentry))
+	if (IS_ERR(child.dentry)) {
+		mntput(child.mnt);
+		exp_put(exp);
 		return rv;
-	if (d_mountpoint(child.dentry))
-		goto out;
-	if (child.dentry->d_inode->i_ino != ino)
+	}
+	/* If child is a mountpoint, then we want to expose the fact
+	 * so client can create a mountpoint.  If not, then a different
+	 * ino number probably means a race with rename, so avoid providing
+	 * too much detail.
+	 */
+	if (nfsd_mountpoint(child.dentry, exp)) {
+		int err;
+		err = nfsd_cross_mnt(cd->rqstp, &child, &exp);
+		if (err)
+			goto out;
+	} else if (child.dentry->d_inode->i_ino != ino)
 		goto out;
 	rv = fh_compose(fhp, exp, &child, &cd->fh);
 out:
-	dput(child.dentry);
+	path_put(&child);
+	exp_put(exp);
 	return rv;
 }
 
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index d5683b6a74b2..4dbc99ed2c8b 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2817,6 +2817,8 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 	struct kstat stat;
 	struct svc_fh *tempfh = NULL;
 	struct kstatfs statfs;
+	u64 mounted_on_ino;
+	u64 sub_fsid;
 	__be32 *p;
 	int starting_len = xdr->buf->len;
 	int attrlen_offset;
@@ -2871,6 +2873,24 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 			goto out;
 		fhp = tempfh;
 	}
+	if ((bmval0 & FATTR4_WORD0_FSID) ||
+	    (bmval1 & FATTR4_WORD1_MOUNTED_ON_FILEID)) {
+		mounted_on_ino = stat.ino;
+		sub_fsid = 0;
+		/*
+		 * The inode number that the current mnt is mounted on is
+		 * used for MOUNTED_ON_FILED if we are at the root,
+		 * and for sub_fsid if mnt is not the export mnt.
+		 */
+		if (ignore_crossmnt == 0) {
+			u64 moi = nfsd_get_mounted_on(mnt);
+
+			if (dentry == mnt->mnt_root && moi)
+				mounted_on_ino = moi;
+			if (mnt != exp->ex_path.mnt)
+				sub_fsid = moi;
+		}
+	}
 	if (bmval0 & FATTR4_WORD0_ACL) {
 		err = nfsd4_get_nfs4_acl(rqstp, dentry, &acl);
 		if (err == -EOPNOTSUPP)
@@ -3008,6 +3028,8 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 		case FSIDSOURCE_UUID:
 			p = xdr_encode_opaque_fixed(p, exp->ex_uuid,
 								EX_UUID_LEN);
+			if (mnt != exp->ex_path.mnt)
+				*(u64*)(p-2) ^= sub_fsid;
 			break;
 		}
 	}
@@ -3253,20 +3275,10 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 		*p++ = cpu_to_be32(stat.mtime.tv_nsec);
 	}
 	if (bmval1 & FATTR4_WORD1_MOUNTED_ON_FILEID) {
-		u64 ino;
-
 		p = xdr_reserve_space(xdr, 8);
 		if (!p)
 			goto out_resource;
-		/*
-		 * Get parent's attributes if not ignoring crossmount
-		 * and this is the root of a cross-mounted filesystem.
-		 */
-		if (ignore_crossmnt == 0 && dentry == mnt->mnt_root)
-			ino = nfsd_get_mounted_on(mnt);
-		if (!ino)
-			ino = stat.ino;
-		p = xdr_encode_hyper(p, ino);
+		p = xdr_encode_hyper(p, mounted_on_ino);
 	}
 #ifdef CONFIG_NFSD_PNFS
 	if (bmval1 & FATTR4_WORD1_FS_LAYOUT_TYPES) {
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 4023046f63e2..4b53838bca89 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -9,7 +9,7 @@
  */
 
 #include <linux/exportfs.h>
-
+#include <linux/namei.h>
 #include <linux/sunrpc/svcauth_gss.h>
 #include "nfsd.h"
 #include "vfs.h"
@@ -285,6 +285,11 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp)
 			default:
 				dentry = ERR_PTR(-ESTALE);
 			}
+		} else if (nfsd_mountpoint(dentry, exp)) {
+			struct path path = { .mnt = mnt, .dentry = dentry };
+			follow_down(&path, LOOKUP_AUTOMOUNT);
+			mnt = path.mnt;
+			dentry = path.dentry;
 		}
 	}
 	if (dentry == NULL)
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index baa12ac36ece..22523e1cd478 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -64,7 +64,7 @@ nfsd_cross_mnt(struct svc_rqst *rqstp, struct path *path_parent,
 			    .dentry = dget(path_parent->dentry)};
 	int err = 0;
 
-	err = follow_down(&path, 0);
+	err = follow_down(&path, LOOKUP_AUTOMOUNT);
 	if (err < 0)
 		goto out;
 	if (path.mnt == path_parent->mnt && path.dentry == path_parent->dentry &&
@@ -73,6 +73,13 @@ nfsd_cross_mnt(struct svc_rqst *rqstp, struct path *path_parent,
 		path_put(&path);
 		goto out;
 	}
+	if (mount_is_internal(path.mnt)) {
+		/* Use the new path, but don't look for a new export */
+		/* FIXME should I check NOHIDE in this case?? */
+		path_put(path_parent);
+		*path_parent = path;
+		goto out;
+	}
 
 	exp2 = rqst_exp_get_by_name(rqstp, &path);
 	if (IS_ERR(exp2)) {
@@ -157,7 +164,7 @@ int nfsd_mountpoint(struct dentry *dentry, struct svc_export *exp)
 		return 1;
 	if (nfsd4_is_junction(dentry))
 		return 1;
-	if (d_mountpoint(dentry))
+	if (d_managed(dentry))
 		/*
 		 * Might only be a mountpoint in a different namespace,
 		 * but we need to check.


