Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D098C11251
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2019 06:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725730AbfEBEfp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 May 2019 00:35:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:50456 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725372AbfEBEfo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 May 2019 00:35:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1F9BDAE14;
        Thu,  2 May 2019 04:35:42 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu, 02 May 2019 14:35:33 +1000
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Andreas =?utf-8?Q?Gr=C3=BCnbacher?= 
        <andreas.gruenbacher@gmail.com>,
        Patrick Plagwitz <Patrick_Plagwitz@web.de>,
        "linux-unionfs\@vger.kernel.org" <linux-unionfs@vger.kernel.org>,
        Linux NFS list <linux-nfs@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] OVL: add honoracl=off mount option.
In-Reply-To: <87bm0l4nra.fsf@notabene.neil.brown.name>
References: <CAJfpeguwUtRWRGmNmimNp-FXzWqMCCQMb24iWPu0w_J0_rOnnw@mail.gmail.com> <20161205151933.GA17517@fieldses.org> <CAJfpegtpkavseTFLspaC7svbvHRq-0-7jvyh63+DK5iWHTGnaQ@mail.gmail.com> <20161205162559.GB17517@fieldses.org> <CAHpGcMKHjic6L+J0qvMYNG9hVCcDO1hEpx4BiEk0ZCKDV39BmA@mail.gmail.com> <266c571f-e4e2-7c61-5ee2-8ece0c2d06e9@web.de> <CAHpGcMKmtppfn7PVrGKEEtVphuLV=YQ2GDYKOqje4ZANhzSgDw@mail.gmail.com> <CAHpGcMKjscfhmrAhwGes0ag2xTkbpFvCO6eiLL_rHz87XE-ZmA@mail.gmail.com> <CAJfpegvRFGOc31gVuYzanzWJ=mYSgRgtAaPhYNxZwHin3Wc0Gw@mail.gmail.com> <CAHc6FU4JQ28BFZE9_8A06gtkMvvKDzFmw9=ceNPYvnMXEimDMw@mail.gmail.com> <20161206185806.GC31197@fieldses.org> <87bm0l4nra.fsf@notabene.neil.brown.name>
Message-ID: <8736lx4goa.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


If the upper and lower layers use incompatible ACL formats, it is not
possible to copy the ACL xttr from one to the other, so overlayfs
cannot work with them.
This happens particularly with NFSv4 which uses system.nfs4_acl, and
ext4 which uses system.posix_acl_access.

If all ACLs actually make to Unix permissions, then there is no need
to copy up the ACLs, but overlayfs cannot determine this.

So allow the sysadmin it assert that ACLs are not needed with a mount
option
  honoracl=3Doff
This causes the ACLs to not be copied, so filesystems with different
ACL formats can be overlaid together.

Signed-off-by: NeilBrown <neilb@suse.com>
=2D--
 Documentation/filesystems/overlayfs.txt | 24 ++++++++++++++++++++++++
 fs/overlayfs/copy_up.c                  |  9 +++++++--
 fs/overlayfs/dir.c                      |  2 +-
 fs/overlayfs/overlayfs.h                |  2 +-
 fs/overlayfs/ovl_entry.h                |  1 +
 fs/overlayfs/super.c                    | 15 +++++++++++++++
 6 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/Documentation/filesystems/overlayfs.txt b/Documentation/filesy=
stems/overlayfs.txt
index eef7d9d259e8..7ad675940c93 100644
=2D-- a/Documentation/filesystems/overlayfs.txt
+++ b/Documentation/filesystems/overlayfs.txt
@@ -245,6 +245,30 @@ filesystem - future operations on the file are barely =
noticed by the
 overlay filesystem (though an operation on the name of the file such as
 rename or unlink will of course be noticed and handled).
=20
+ACL copy-up
+-----------
+
+When a file that only exists on the lower layer is modified it needs
+to be copied up to the upper layer.  This means copying the metadata
+and (usually) the data (though see "Metadata only copy up" below).
+One part of the metadata can be problematic: the ACLs.
+
+Now all filesystems support ACLs, and when they do they don't all use
+the same format.  A significant conflict appears between POSIX acls
+used on many local filesystems, and NFSv4 ACLs used with NFSv4.  There
+two formats are, in general, not inter-convertible.
+
+If a site only uses regular Unix permissions (Read, Write, eXecute by
+User, Group and Other), then as these permissions are compatible with
+all ACLs, there is no need to copy ACLs.  overlayfs cannot determine
+if this is the case itself.
+
+For this reason, overlayfs supports a mount option "honoracl=3Doff"
+which causes ACLs, any "system." extended attribute, on the lower
+layer to be ignored and, particularly, not copied to the upper later.
+This allows NFSv4 to be overlaid with a local filesystem, but should
+only be used if the only access controls used on the filesystem are
+Unix permission bits.
=20
 Multiple lower layers
 ---------------------
diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 68b3303e4b46..032aa88f21c1 100644
=2D-- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -39,7 +39,7 @@ static int ovl_ccup_get(char *buf, const struct kernel_pa=
ram *param)
 module_param_call(check_copy_up, ovl_ccup_set, ovl_ccup_get, NULL, 0644);
 MODULE_PARM_DESC(ovl_check_copy_up, "Obsolete; does nothing");
=20
=2Dint ovl_copy_xattr(struct dentry *old, struct dentry *new)
+int ovl_copy_xattr(struct dentry *old, struct dentry *new, struct ovl_fs *=
ofs)
 {
 	ssize_t list_size, size, value_size =3D 0;
 	char *buf, *name, *value =3D NULL;
@@ -77,6 +77,10 @@ int ovl_copy_xattr(struct dentry *old, struct dentry *ne=
w)
 		}
 		list_size -=3D slen;
=20
+		if (strncmp(name, XATTR_SYSTEM_PREFIX, XATTR_SYSTEM_PREFIX_LEN) =3D=3D 0=
 &&
+		    !ofs->config.honoracl)
+			continue;
+
 		if (ovl_is_private_xattr(name))
 			continue;
 retry:
@@ -461,7 +465,8 @@ static int ovl_copy_up_inode(struct ovl_copy_up_ctx *c,=
 struct dentry *temp)
 			return err;
 	}
=20
=2D	err =3D ovl_copy_xattr(c->lowerpath.dentry, temp);
+	err =3D ovl_copy_xattr(c->lowerpath.dentry, temp,
+			     c->dentry->d_sb->s_fs_info);
 	if (err)
 		return err;
=20
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 82c129bfe58d..cc8fb9eeb7df 100644
=2D-- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -368,7 +368,7 @@ static struct dentry *ovl_clear_empty(struct dentry *de=
ntry,
 	if (IS_ERR(opaquedir))
 		goto out_unlock;
=20
=2D	err =3D ovl_copy_xattr(upper, opaquedir);
+	err =3D ovl_copy_xattr(upper, opaquedir, upper->d_sb->s_fs_info);
 	if (err)
 		goto out_cleanup;
=20
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 9c6018287d57..4a104a4732af 100644
=2D-- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -422,7 +422,7 @@ int ovl_copy_up(struct dentry *dentry);
 int ovl_copy_up_with_data(struct dentry *dentry);
 int ovl_copy_up_flags(struct dentry *dentry, int flags);
 int ovl_open_maybe_copy_up(struct dentry *dentry, unsigned int file_flags);
=2Dint ovl_copy_xattr(struct dentry *old, struct dentry *new);
+int ovl_copy_xattr(struct dentry *old, struct dentry *new, struct ovl_fs *=
ofs);
 int ovl_set_attr(struct dentry *upper, struct kstat *stat);
 struct ovl_fh *ovl_encode_real_fh(struct dentry *real, bool is_upper);
 int ovl_set_origin(struct dentry *dentry, struct dentry *lower,
diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
index ec237035333a..c541e3fed5b9 100644
=2D-- a/fs/overlayfs/ovl_entry.h
+++ b/fs/overlayfs/ovl_entry.h
@@ -20,6 +20,7 @@ struct ovl_config {
 	bool nfs_export;
 	int xino;
 	bool metacopy;
+	bool honoracl;
 };
=20
 struct ovl_sb {
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 0116735cc321..ceb8fdb7ce14 100644
=2D-- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -362,6 +362,8 @@ static int ovl_show_options(struct seq_file *m, struct =
dentry *dentry)
 	if (ofs->config.metacopy !=3D ovl_metacopy_def)
 		seq_printf(m, ",metacopy=3D%s",
 			   ofs->config.metacopy ? "on" : "off");
+	if (!ofs->config.honoracl)
+		seq_puts(m, ",honoracl=3Doff");
 	return 0;
 }
=20
@@ -401,6 +403,8 @@ enum {
 	OPT_XINO_AUTO,
 	OPT_METACOPY_ON,
 	OPT_METACOPY_OFF,
+	OPT_HONORACL_ON,
+	OPT_HONORACL_OFF,
 	OPT_ERR,
 };
=20
@@ -419,6 +423,8 @@ static const match_table_t ovl_tokens =3D {
 	{OPT_XINO_AUTO,			"xino=3Dauto"},
 	{OPT_METACOPY_ON,		"metacopy=3Don"},
 	{OPT_METACOPY_OFF,		"metacopy=3Doff"},
+	{OPT_HONORACL_ON,		"honoracl=3Don"},
+	{OPT_HONORACL_OFF,		"honoracl=3Doff"},
 	{OPT_ERR,			NULL}
 };
=20
@@ -557,6 +563,14 @@ static int ovl_parse_opt(char *opt, struct ovl_config =
*config)
 			config->metacopy =3D false;
 			break;
=20
+		case OPT_HONORACL_ON:
+			config->honoracl =3D true;
+			break;
+
+		case OPT_HONORACL_OFF:
+			config->honoracl =3D false;
+			break;
+
 		default:
 			pr_err("overlayfs: unrecognized mount option \"%s\" or missing value\n"=
, p);
 			return -EINVAL;
@@ -1440,6 +1454,7 @@ static int ovl_fill_super(struct super_block *sb, voi=
d *data, int silent)
 	ofs->config.nfs_export =3D ovl_nfs_export_def;
 	ofs->config.xino =3D ovl_xino_def();
 	ofs->config.metacopy =3D ovl_metacopy_def;
+	ofs->config.honoracl =3D true;
 	err =3D ovl_parse_opt((char *) data, &ofs->config);
 	if (err)
 		goto out_err;
=2D-=20
2.14.0.rc0.dirty


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlzKc5YACgkQOeye3VZi
gbknKw//cHWYK4v8NTYkB32zrzYkvCsfot2QkrCl00BgTAg/6tMiZYJcRj25lcwj
ByDsw6J9gQxh2jsiPsC6BVJ7CjscbVgTdiBLYv/kcOMLj3citnEI43v+9crTvEer
8Kb0K1uz2zXR9WDqQNuCW0PQvnvpiTEB2mKIlRSEg5+/o5dt4xeUwC+J/SH/bYjd
KCb7BujAPdnUmWhGZfG4M2B1fDSLSdPU8tCpgY0FlpQp3aQ2MvYfV04hfpmzlDi+
X6cvGm5Iie3GzT4sNi990+KxZ50byqC9ERxUDbB2PseDvxhqd7fHLTjhtz9oYuqw
dQXJYeB/SdLd8pNKcmyQoc5e1kloI8fUmTe+eHqhSwMFE26U5IG8RgI0/X4XdCBM
CUmQn2EPisKnui2pza/RonNPQHzjTKx6GuNV/Z8XYN4rL1Po5g5MokoJ9RFpnXK9
8luGOmep3846F7XGAJVXeDUeAZohcqtqA5lKlkaeTGEWk0Wwi4gc2aW2R9HejylT
MkIFmVxKyL/GeQOYdZ6ySPpP/o1R2wbgZtb79mRUuFaxVMEHV/qDQVaje4vK/zgq
PenWiGfWqtpasewgjs4W1pEg9Y+L3FYBy6tUlnZlpD6qbCywFluJBq1iIBy7kOuE
aHRI/Tygrc+0IS/nknrnqmGECNziBqjj1CQeRThQRnxt+qfKivg=
=pZL4
-----END PGP SIGNATURE-----
--=-=-=--
