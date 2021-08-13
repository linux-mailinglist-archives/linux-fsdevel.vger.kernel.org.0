Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD2EE3EAE3E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Aug 2021 03:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238296AbhHMBqK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 21:46:10 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:47116 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238266AbhHMBqJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 21:46:09 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CB45F1FF80;
        Fri, 13 Aug 2021 01:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1628819142; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LamDGYFppAFdL7WCvYoQSTIDfJ7v5NOZ+rmKtnq+i8o=;
        b=ApNf9lb0Q7HdntXHacOQkOGQ6oxP2VJSVLUgv8JqWyY124KVBpb/BNVeIFlY934SZ5w9mO
        VYHg2stE4hINYwm9bH3C0TPkq2apKhKCUAo9ld4owkRzFcSHdH5xfL/pr4fU7tNsnSHhxi
        davfFx52nHTYCzSm3sfjlUJI+QA+tZI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1628819142;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LamDGYFppAFdL7WCvYoQSTIDfJ7v5NOZ+rmKtnq+i8o=;
        b=auLJcE/GO4pW3gWrYHGNqNuOeSqcgRU5a5HQnGqpFj2lGLJhXsvARY6SDS/oQmRHrej/On
        mZRsHneH0bhQufDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E2F9113BB4;
        Fri, 13 Aug 2021 01:45:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id POzTJ8POFWEWIAAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 13 Aug 2021 01:45:39 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Christoph Hellwig" <hch@infradead.org>,
        "Josef Bacik" <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        "Chuck Lever" <chuck.lever@oracle.com>, "Chris Mason" <clm@fb.com>,
        "David Sterba" <dsterba@suse.com>,
        "Alexander Viro" <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: [PATCH] VFS/BTRFS/NFSD: provide more unique inode number for btrfs export
In-reply-to: <162742539595.32498.13687924366155737575.stgit@noble.brown>
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>
Date:   Fri, 13 Aug 2021 11:45:36 +1000
Message-id: <162881913686.1695.12479588032010502384@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


[[This patch is a minimal patch which addresses the current problems
  with nfsd and btrfs, in a way which I think is most supportable, least
  surprising, and least likely to impact any future attempts to more
  completely fix the btrfs file-identify problem]]

BTRFS does not provide unique inode numbers across a filesystem.
It *does* provide unique inode numbers with a subvolume and
uses synthetic device numbers for different subvolumes to ensure
uniqueness for device+inode.

nfsd cannot use these varying device numbers.  If nfsd were to
synthesise different stable filesystem ids to give to the client, that
would cause subvolumes to appear in the mount table on the client, even
though they don't appear in the mount table on the server.  Also, NFSv3
doesn't support changing the filesystem id without a new explicit
mount on the client (this is partially supported in practice, but
violates the protocol specification).

So currently, the roots of all subvolumes report the same inode number
in the same filesystem to NFS clients and tools like 'find' notice that
a directory has the same identity as an ancestor, and so refuse to
enter that directory.

This patch allows btrfs (or any filesystem) to provide a 64bit number
that can be xored with the inode number to make the number more unique.
Rather than the client being certain to see duplicates, with this patch
it is possible but extremely rare.

The number than btrfs provides is a swab64() version of the subvolume
identifier.  This has most entropy in the high bits (the low bits of the
subvolume identifer), while the inoe has most entropy in the low bits.
The result will always be unique within a subvolume, and will almost
always be unique across the filesystem.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/btrfs/inode.c     |  4 ++++
 fs/nfsd/nfs3xdr.c    | 17 ++++++++++++++++-
 fs/nfsd/nfs4xdr.c    |  9 ++++++++-
 fs/nfsd/xdr3.h       |  2 ++
 include/linux/stat.h | 17 +++++++++++++++++
 5 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 0117d867ecf8..989fdf2032d5 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9195,6 +9195,10 @@ static int btrfs_getattr(struct user_namespace *mnt_us=
erns,
 	generic_fillattr(&init_user_ns, inode, stat);
 	stat->dev =3D BTRFS_I(inode)->root->anon_dev;
=20
+	if (BTRFS_I(inode)->root->root_key.objectid !=3D BTRFS_FS_TREE_OBJECTID)
+		stat->ino_uniquifier =3D
+			swab64(BTRFS_I(inode)->root->root_key.objectid);
+
 	spin_lock(&BTRFS_I(inode)->lock);
 	delalloc_bytes =3D BTRFS_I(inode)->new_delalloc_bytes;
 	inode_bytes =3D inode_get_bytes(inode);
diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 0a5ebc52e6a9..669e2437362a 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -340,6 +340,7 @@ svcxdr_encode_fattr3(struct svc_rqst *rqstp, struct xdr_s=
tream *xdr,
 {
 	struct user_namespace *userns =3D nfsd_user_namespace(rqstp);
 	__be32 *p;
+	u64 ino;
 	u64 fsid;
=20
 	p =3D xdr_reserve_space(xdr, XDR_UNIT * 21);
@@ -377,7 +378,10 @@ svcxdr_encode_fattr3(struct svc_rqst *rqstp, struct xdr_=
stream *xdr,
 	p =3D xdr_encode_hyper(p, fsid);
=20
 	/* fileid */
-	p =3D xdr_encode_hyper(p, stat->ino);
+	ino =3D stat->ino;
+	if (stat->ino_uniquifier && stat->ino_uniquifier !=3D ino)
+		ino ^=3D stat->ino_uniquifier;
+	p =3D xdr_encode_hyper(p, ino);
=20
 	p =3D encode_nfstime3(p, &stat->atime);
 	p =3D encode_nfstime3(p, &stat->mtime);
@@ -1151,6 +1155,17 @@ svcxdr_encode_entry3_common(struct nfsd3_readdirres *r=
esp, const char *name,
 	if (xdr_stream_encode_item_present(xdr) < 0)
 		return false;
 	/* fileid */
+	if (!resp->dir_have_uniquifier) {
+		struct kstat stat;
+		if (fh_getattr(&resp->fh, &stat) =3D=3D nfs_ok)
+			resp->dir_ino_uniquifier =3D stat.ino_uniquifier;
+		else
+			resp->dir_ino_uniquifier =3D 0;
+		resp->dir_have_uniquifier =3D 1;
+	}
+	if (resp->dir_ino_uniquifier &&
+	    resp->dir_ino_uniquifier !=3D ino)
+		ino ^=3D resp->dir_ino_uniquifier;
 	if (xdr_stream_encode_u64(xdr, ino) < 0)
 		return false;
 	/* name */
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 7abeccb975b2..ddccf849c29c 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3114,10 +3114,14 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc=
_fh *fhp,
 					fhp->fh_handle.fh_size);
 	}
 	if (bmval0 & FATTR4_WORD0_FILEID) {
+		u64 ino =3D stat.ino;
+		if (stat.ino_uniquifier &&
+		    stat.ino_uniquifier !=3D stat.ino)
+			ino ^=3D stat.ino_uniquifier;
 		p =3D xdr_reserve_space(xdr, 8);
 		if (!p)
 			goto out_resource;
-		p =3D xdr_encode_hyper(p, stat.ino);
+		p =3D xdr_encode_hyper(p, ino);
 	}
 	if (bmval0 & FATTR4_WORD0_FILES_AVAIL) {
 		p =3D xdr_reserve_space(xdr, 8);
@@ -3285,6 +3289,9 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_f=
h *fhp,
 			if (err)
 				goto out_nfserr;
 			ino =3D parent_stat.ino;
+			if (parent_stat.ino_uniquifier &&
+			    parent_stat.ino_uniquifier !=3D ino)
+				ino ^=3D parent_stat.ino_uniquifier;
 		}
 		p =3D xdr_encode_hyper(p, ino);
 	}
diff --git a/fs/nfsd/xdr3.h b/fs/nfsd/xdr3.h
index 933008382bbe..b4f9f3c71f72 100644
--- a/fs/nfsd/xdr3.h
+++ b/fs/nfsd/xdr3.h
@@ -179,6 +179,8 @@ struct nfsd3_readdirres {
 	struct xdr_buf		dirlist;
 	struct svc_fh		scratch;
 	struct readdir_cd	common;
+	u64			dir_ino_uniquifier;
+	int			dir_have_uniquifier;
 	unsigned int		cookie_offset;
 	struct svc_rqst *	rqstp;
=20
diff --git a/include/linux/stat.h b/include/linux/stat.h
index fff27e603814..a5188f42ed81 100644
--- a/include/linux/stat.h
+++ b/include/linux/stat.h
@@ -46,6 +46,23 @@ struct kstat {
 	struct timespec64 btime;			/* File creation time */
 	u64		blocks;
 	u64		mnt_id;
+	/*
+	 * BTRFS does not provide unique inode numbers within a filesystem,
+	 * depending on a synthetic 'dev' to provide uniqueness.
+	 * NFSd cannot make use of this 'dev' number so clients often see
+	 * duplicate inode numbers.
+	 * For BTRFS, 'ino' is unlikely to use the high bits.  It puts
+	 * another number in ino_uniquifier which:
+	 * - has most entropy in the high bits
+	 * - is different precisely when 'dev' is different
+	 * - is stable across unmount/remount
+	 * NFSd can xor this with 'ino' to get a substantially more unique
+	 * number for reporting to the client.
+	 * The ino_uniquifier for a directory can reasonably be applied
+	 * to inode numbers reported by the readdir filldir callback.
+	 * It is NOT currently exported to user-space.
+	 */
+	u64		ino_uniquifier;
 };
=20
 #endif
--=20
2.32.0

