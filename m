Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF453F4410
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Aug 2021 06:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhHWEG4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Aug 2021 00:06:56 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:33676 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbhHWEGz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Aug 2021 00:06:55 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8C8A01FF64;
        Mon, 23 Aug 2021 04:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629691572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kTJSK/nOpJTwRwH5m9/+1Ty9EFKACF4xxFZSG57m9pk=;
        b=uArUm/LwjNAoiYoEOQIi2iANU39jkKgAMYD6Eu55QbQsguETSWvGOEw4FKL9ZJFOeqn8S8
        0hWWLwtK+ryPTYkbSESwX0HPoMHUCEtrt5Et4y1NpI2NmvpfHvK4er8/egQdlT3qef4nAN
        x2jOyQJ1s7yf+o9Tfm2WabUreIciHxg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629691572;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kTJSK/nOpJTwRwH5m9/+1Ty9EFKACF4xxFZSG57m9pk=;
        b=tyfAva2kIQHJgR61qBDFokyYhj3WaRF2D1Tysn2GKcJ7+TyrnsXc0MicE/S7y1nygeGn4/
        5mv5lFRMawc8XWAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 15BCA13A61;
        Mon, 23 Aug 2021 04:06:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id F6O4MLAeI2F7KQAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 23 Aug 2021 04:06:08 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chris Mason" <clm@fb.com>, "David Sterba" <dsterba@suse.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Josef Bacik" <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        "Chuck Lever" <chuck.lever@oracle.com>
Cc:     "Roman Mamedov" <rm@romanrm.net>,
        "Goffredo Baroncelli" <kreijack@libero.it>,
        "Alexander Viro" <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: [PATCH v2] BTRFS/NFSD: provide more unique inode number for btrfs export
In-reply-to: <162906585094.1695.15815972140753474778@noble.neil.brown.name>
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>,
 <162881913686.1695.12479588032010502384@noble.neil.brown.name>,
 <bf49ef31-0c86-62c8-7862-719935764036@libero.it>,
 <20210816003505.7b3e9861@natsu>,
 <162906585094.1695.15815972140753474778@noble.neil.brown.name>
Date:   Mon, 23 Aug 2021 14:05:54 +1000
Message-id: <162969155423.9892.18322100025025288277@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


BTRFS does not provide unique inode numbers across a filesystem.
It only provide unique inode numbers within a subvolume and
uses synthetic device numbers for different subvolumes to ensure
uniqueness for device+inode.

nfsd cannot use these varying synthetic device numbers.  If nfsd were to
synthesise different stable filesystem ids to give to the client, that
would cause subvolumes to appear in the mount table on the client, even
though they don't appear in the mount table on the server.  Also, NFSv3
doesn't support changing the filesystem id without a new explicit mount
on the client (this is partially supported in practice, but violates the
protocol specification and has problems in some edge cases).

So currently, the roots of all subvolumes report the same inode number
in the same filesystem to NFS clients and tools like 'find' notice that
a directory has the same identity as an ancestor, and so refuse to
enter that directory.

This patch allows btrfs (or any filesystem) to provide a 64bit number
that can be xored with the inode number to make the number more unique.
Rather than the client being certain to see duplicates, with this patch
it is possible but extremely rare.

The number that btrfs provides is a swab64() version of the subvolume
identifier.  This has most entropy in the high bits (the low bits of the
subvolume identifer), while the inode has most entropy in the low bits.
The result will always be unique within a subvolume, and will almost
always be unique across the filesystem.

If an upgrade of the NFS server caused all inode numbers in an exportfs
BTRFS filesystem to appear to the client to change, the client may not
handle this well.  The Linux client will cause any open files to become
'stale'.  If the mount point changed inode number, the whole mount would
become inaccessible.

To avoid this, an unused byte in the filehandle (fh_auth) has been
repurposed as "fh_options".  (The use of #defines make fh_flags a
problematic choice).  The new behaviour of uniquifying inode number is
only activated when this bit is set.

NFSD will only set this bit in filehandles it reports if the filehandle
of the parent (provided by the client) contains the bit, or if
 - the filehandle for the parent is not provided or is for a different
   export and
 - the filehandle refers to a BTRFS filesystem.

Thus if you have a BTRFS filesystem originally mounted from a server
without this patch, the flag will never be set and the current behaviour
will continue.  Only once you re-mount the filesystem (or the filesystem
is re-auto-mounted) will the inode numbers change.  When that happens,
it is likely that the filesystem st_dev number seen on the client will
change anyway.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/btrfs/inode.c                |  4 ++++
 fs/nfsd/nfs3xdr.c               | 15 ++++++++++++++-
 fs/nfsd/nfs4xdr.c               |  7 ++++---
 fs/nfsd/nfsfh.c                 | 13 +++++++++++--
 fs/nfsd/nfsfh.h                 | 22 ++++++++++++++++++++++
 fs/nfsd/xdr3.h                  |  2 ++
 include/linux/stat.h            | 18 ++++++++++++++++++
 include/uapi/linux/nfsd/nfsfh.h | 18 ++++++++++++------
 8 files changed, 87 insertions(+), 12 deletions(-)

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
index 0a5ebc52e6a9..19d14f11f79a 100644
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
@@ -377,7 +378,8 @@ svcxdr_encode_fattr3(struct svc_rqst *rqstp, struct xdr_s=
tream *xdr,
 	p =3D xdr_encode_hyper(p, fsid);
=20
 	/* fileid */
-	p =3D xdr_encode_hyper(p, stat->ino);
+	ino =3D nfsd_uniquify_ino(fhp, stat);
+	p =3D xdr_encode_hyper(p, ino);
=20
 	p =3D encode_nfstime3(p, &stat->atime);
 	p =3D encode_nfstime3(p, &stat->mtime);
@@ -1151,6 +1153,17 @@ svcxdr_encode_entry3_common(struct nfsd3_readdirres *r=
esp, const char *name,
 	if (xdr_stream_encode_item_present(xdr) < 0)
 		return false;
 	/* fileid */
+	if (!resp->dir_have_uniquifier) {
+		struct kstat stat;
+		if (fh_getattr(&resp->fh, &stat) =3D=3D nfs_ok)
+			resp->dir_ino_uniquifier =3D
+				nfsd_ino_uniquifier(&resp->fh, &stat);
+		else
+			resp->dir_ino_uniquifier =3D 0;
+		resp->dir_have_uniquifier =3D true;
+	}
+	if (resp->dir_ino_uniquifier !=3D ino)
+		ino ^=3D resp->dir_ino_uniquifier;
 	if (xdr_stream_encode_u64(xdr, ino) < 0)
 		return false;
 	/* name */
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 7abeccb975b2..5ed894ceebb0 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3114,10 +3114,11 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc=
_fh *fhp,
 					fhp->fh_handle.fh_size);
 	}
 	if (bmval0 & FATTR4_WORD0_FILEID) {
+		u64 ino =3D nfsd_uniquify_ino(fhp, &stat);
 		p =3D xdr_reserve_space(xdr, 8);
 		if (!p)
 			goto out_resource;
-		p =3D xdr_encode_hyper(p, stat.ino);
+		p =3D xdr_encode_hyper(p, ino);
 	}
 	if (bmval0 & FATTR4_WORD0_FILES_AVAIL) {
 		p =3D xdr_reserve_space(xdr, 8);
@@ -3274,7 +3275,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_f=
h *fhp,
=20
 		p =3D xdr_reserve_space(xdr, 8);
 		if (!p)
-                	goto out_resource;
+			goto out_resource;
 		/*
 		 * Get parent's attributes if not ignoring crossmount
 		 * and this is the root of a cross-mounted filesystem.
@@ -3284,7 +3285,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_f=
h *fhp,
 			err =3D get_parent_attributes(exp, &parent_stat);
 			if (err)
 				goto out_nfserr;
-			ino =3D parent_stat.ino;
+			ino =3D nfsd_uniquify_ino(fhp, &parent_stat);
 		}
 		p =3D xdr_encode_hyper(p, ino);
 	}
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index c475d2271f9c..e97ed957a379 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -172,7 +172,7 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, =
struct svc_fh *fhp)
=20
 		if (--data_left < 0)
 			return error;
-		if (fh->fh_auth_type !=3D 0)
+		if ((fh->fh_options & ~NFSD_FH_OPTION_ALL) !=3D 0)
 			return error;
 		len =3D key_len(fh->fh_fsid_type) / 4;
 		if (len =3D=3D 0)
@@ -569,6 +569,7 @@ fh_compose(struct svc_fh *fhp, struct svc_export *exp, st=
ruct dentry *dentry,
=20
 	struct inode * inode =3D d_inode(dentry);
 	dev_t ex_dev =3D exp_sb(exp)->s_dev;
+	u8 options =3D 0;
=20
 	dprintk("nfsd: fh_compose(exp %02x:%02x/%ld %pd2, ino=3D%ld)\n",
 		MAJOR(ex_dev), MINOR(ex_dev),
@@ -585,6 +586,14 @@ fh_compose(struct svc_fh *fhp, struct svc_export *exp, s=
truct dentry *dentry,
 	/* If we have a ref_fh, then copy the fh_no_wcc setting from it. */
 	fhp->fh_no_wcc =3D ref_fh ? ref_fh->fh_no_wcc : false;
=20
+	if (ref_fh && ref_fh->fh_export =3D=3D exp) {
+		options =3D ref_fh->fh_handle.fh_options;
+	} else {
+		/* Set options as needed */
+		if (exp->ex_path.mnt->mnt_sb->s_magic =3D=3D BTRFS_SUPER_MAGIC)
+			options |=3D NFSD_FH_OPTION_INO_UNIQUIFY;
+	}
+
 	if (ref_fh =3D=3D fhp)
 		fh_put(ref_fh);
=20
@@ -615,7 +624,7 @@ fh_compose(struct svc_fh *fhp, struct svc_export *exp, st=
ruct dentry *dentry,
 	} else {
 		fhp->fh_handle.fh_size =3D
 			key_len(fhp->fh_handle.fh_fsid_type) + 4;
-		fhp->fh_handle.fh_auth_type =3D 0;
+		fhp->fh_handle.fh_options =3D options;
=20
 		mk_fsid(fhp->fh_handle.fh_fsid_type,
 			fhp->fh_handle.fh_fsid,
diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
index 6106697adc04..1144a98c2951 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -84,6 +84,28 @@ enum fsid_source {
 };
 extern enum fsid_source fsid_source(const struct svc_fh *fhp);
=20
+enum nfsd_fh_options {
+	NFSD_FH_OPTION_INO_UNIQUIFY =3D 1,	/* BTRFS only */
+
+	NFSD_FH_OPTION_ALL =3D 1
+};
+
+static inline u64 nfsd_ino_uniquifier(const struct svc_fh *fhp,
+				      const struct kstat *stat)
+{
+	if (fhp->fh_handle.fh_options & NFSD_FH_OPTION_INO_UNIQUIFY)
+		return stat->ino_uniquifier;
+	return 0;
+}
+
+static inline u64 nfsd_uniquify_ino(const struct svc_fh *fhp,
+				    const struct kstat *stat)
+{
+	u64 u =3D nfsd_ino_uniquifier(fhp, stat);
+	if (u !=3D stat->ino)
+		return stat->ino ^ u;
+	return stat->ino;
+}
=20
 /*
  * This might look a little large to "inline" but in all calls except
diff --git a/fs/nfsd/xdr3.h b/fs/nfsd/xdr3.h
index 933008382bbe..d9b6c8314bbb 100644
--- a/fs/nfsd/xdr3.h
+++ b/fs/nfsd/xdr3.h
@@ -179,6 +179,8 @@ struct nfsd3_readdirres {
 	struct xdr_buf		dirlist;
 	struct svc_fh		scratch;
 	struct readdir_cd	common;
+	u64			dir_ino_uniquifier;
+	bool			dir_have_uniquifier;
 	unsigned int		cookie_offset;
 	struct svc_rqst *	rqstp;
=20
diff --git a/include/linux/stat.h b/include/linux/stat.h
index fff27e603814..0f3f74d302f8 100644
--- a/include/linux/stat.h
+++ b/include/linux/stat.h
@@ -46,6 +46,24 @@ struct kstat {
 	struct timespec64 btime;			/* File creation time */
 	u64		blocks;
 	u64		mnt_id;
+	/*
+	 * BTRFS does not provide unique inode numbers within a filesystem,
+	 * depending on a synthetic 'dev' to provide uniqueness.
+	 * NFSd cannot make use of this 'dev' number so clients often see
+	 * duplicate inode numbers.
+	 * For BTRFS, 'ino' is unlikely to use the high bits until the filesystem
+	 * has created a great many inodes.
+	 * It puts another number in ino_uniquifier which:
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
diff --git a/include/uapi/linux/nfsd/nfsfh.h b/include/uapi/linux/nfsd/nfsfh.h
index 427294dd56a1..59311df4b476 100644
--- a/include/uapi/linux/nfsd/nfsfh.h
+++ b/include/uapi/linux/nfsd/nfsfh.h
@@ -38,11 +38,17 @@ struct nfs_fhbase_old {
  * The file handle starts with a sequence of four-byte words.
  * The first word contains a version number (1) and three descriptor bytes
  * that tell how the remaining 3 variable length fields should be handled.
- * These three bytes are auth_type, fsid_type and fileid_type.
+ * These three bytes are options, fsid_type and fileid_type.
  *
  * All four-byte values are in host-byte-order.
  *
- * The auth_type field is deprecated and must be set to 0.
+ * The options field (previously auth_type) can be used when nfsd behaviour
+ * needs to change in a non-compatible way, usually for some specific
+ * filesystem.  Options should only be set in filehandles for filesystems wh=
ich
+ * need them.
+ * Current values:
+ *   1  -  BTRFS only.  Cause stat->ino_uniquifier to be used to improve ino=
de
+ *         number uniqueness.
  *
  * The fsid_type identifies how the filesystem (or export point) is
  *    encoded.
@@ -67,7 +73,7 @@ struct nfs_fhbase_new {
 	union {
 		struct {
 			__u8		fb_version_aux;	/* =3D=3D 1, even =3D> nfs_fhbase_old */
-			__u8		fb_auth_type_aux;
+			__u8		fb_options_aux;
 			__u8		fb_fsid_type_aux;
 			__u8		fb_fileid_type_aux;
 			__u32		fb_auth[1];
@@ -76,7 +82,7 @@ struct nfs_fhbase_new {
 		};
 		struct {
 			__u8		fb_version;	/* =3D=3D 1, even =3D> nfs_fhbase_old */
-			__u8		fb_auth_type;
+			__u8		fb_options;
 			__u8		fb_fsid_type;
 			__u8		fb_fileid_type;
 			__u32		fb_auth_flex[]; /* flexible-array member */
@@ -106,11 +112,11 @@ struct knfsd_fh {
=20
 #define	fh_version		fh_base.fh_new.fb_version
 #define	fh_fsid_type		fh_base.fh_new.fb_fsid_type
-#define	fh_auth_type		fh_base.fh_new.fb_auth_type
+#define	fh_options		fh_base.fh_new.fb_options
 #define	fh_fileid_type		fh_base.fh_new.fb_fileid_type
 #define	fh_fsid			fh_base.fh_new.fb_auth_flex
=20
 /* Do not use, provided for userspace compatiblity. */
-#define	fh_auth			fh_base.fh_new.fb_auth
+#define	fh_auth			fh_base.fh_new.fb_options
=20
 #endif /* _UAPI_LINUX_NFSD_FH_H */
--=20
2.32.0

