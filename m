Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36932E49F9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2019 13:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501903AbfJYL3i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Oct 2019 07:29:38 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48866 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2439673AbfJYL3h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Oct 2019 07:29:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572002974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UyrGPcKuXCpaWbrTq1rNsPhkOP4DpMOavc/jNfhdSsQ=;
        b=ep2tuKgCVNkUcZ6C4Htv5sBpchE9EON1Re8EPciMh8w8jgTDp285I+DElE+5pUGAYPcxWW
        xVmu7hUmiaZZe8MdfwAxCfapUQhtEn0fNNgpzQVCo9K3bso4CZNPTwaWFODUF0W6Ycmlkb
        basoar1nXj5kms+NQyWSE4hrLH4chXI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-zwV7zNVIO4OlsuIReomdbg-1; Fri, 25 Oct 2019 07:29:27 -0400
Received: by mail-wr1-f72.google.com with SMTP id e14so912728wrm.21
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Oct 2019 04:29:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ERGnjFEQ8XEB9SBe97EFYt7XL75LKIU0O5Ymd9oarIE=;
        b=Mk9WT71HzFT+zFy/rS5sJKt+s+hG2GdOGkYw2S9VTzmhLW+Yd8BfL9koOz+ih+kGNW
         kBRILX4kqtGa6uGSZPuLBF1VVq84WjSmfV9uLo9vulBw3EvKdmE5jJDmjqEuNhzj5VI+
         zakT5uv9rCIlaQY84KScWHwc3fPkY0P1drHYUwCwRPXoiduPLk8ci52sGSiqWthjcJdi
         4gAz+x6VsBfHSW1F4QtpPYwQTj9xPDlqQyElAC/+ukideXvYVjA2tmuZeFUkn52zajbJ
         K8Vi81Jl46k0mR7Z6ckj80aSk/39X7lpuP1GOMAsrBn/Z4ARWRkgF/g8OV9P267W00Ac
         AsFw==
X-Gm-Message-State: APjAAAWh83m+YAdbpkjKWJbHXsN2XDliAVOdA04cFbA56XjiqS0phPGl
        8oT42hMb8mqUXY4kQppZ5JMwGkUbiyVuXqHjbl2mcGr+NE6jvPOlgrL2YPITx7X8QJeE/YDIZ3l
        w84OOi6itviDzNNuOZG2n3scTFQ==
X-Received: by 2002:adf:fcc7:: with SMTP id f7mr2606657wrs.345.1572002965899;
        Fri, 25 Oct 2019 04:29:25 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzHTWJ+6JNVF2tZGyn1bS20ZPstuF8Bkvy0DQcVZbW9k6p2XSaSr2OEvpJDfp/yoldN4R/X2g==
X-Received: by 2002:adf:fcc7:: with SMTP id f7mr2606588wrs.345.1572002964864;
        Fri, 25 Oct 2019 04:29:24 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (185-79-95-246.pool.digikabel.hu. [185.79.95.246])
        by smtp.gmail.com with ESMTPSA id l18sm3974080wrn.48.2019.10.25.04.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 04:29:24 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 4/5] ovl: user xattr
Date:   Fri, 25 Oct 2019 13:29:16 +0200
Message-Id: <20191025112917.22518-5-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191025112917.22518-1-mszeredi@redhat.com>
References: <20191025112917.22518-1-mszeredi@redhat.com>
MIME-Version: 1.0
X-MC-Unique: zwV7zNVIO4OlsuIReomdbg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Optionally allow using "user.overlay" namespace instead
of"trusted.overlay".

This is necessary for overlayfs to be able to be mounted in an unprivileged
namepsace.

Make the option explicit, since it makes the filesystem format be
incompatible.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/copy_up.c   | 18 +++++----
 fs/overlayfs/dir.c       |  2 +-
 fs/overlayfs/export.c    |  2 +-
 fs/overlayfs/inode.c     | 39 +++++++++----------
 fs/overlayfs/namei.c     | 56 ++++++++++++++-------------
 fs/overlayfs/overlayfs.h | 81 +++++++++++++++++++++++++--------------
 fs/overlayfs/ovl_entry.h |  1 +
 fs/overlayfs/readdir.c   |  5 ++-
 fs/overlayfs/super.c     | 52 ++++++++++++++++++-------
 fs/overlayfs/util.c      | 82 ++++++++++++++++++++++++++++++++++------
 10 files changed, 229 insertions(+), 109 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index ed6e2d6cf7a1..a1896ce25d35 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -43,7 +43,8 @@ static bool ovl_must_copy_xattr(const char *name)
 =09       !strncmp(name, XATTR_SECURITY_PREFIX, XATTR_SECURITY_PREFIX_LEN)=
;
 }
=20
-int ovl_copy_xattr(struct dentry *old, struct dentry *new)
+int ovl_copy_xattr(struct super_block *sb, struct dentry *old,
+=09=09   struct dentry *new)
 {
 =09ssize_t list_size, size, value_size =3D 0;
 =09char *buf, *name, *value =3D NULL;
@@ -81,7 +82,7 @@ int ovl_copy_xattr(struct dentry *old, struct dentry *new=
)
 =09=09}
 =09=09list_size -=3D slen;
=20
-=09=09if (ovl_is_private_xattr(name))
+=09=09if (ovl_is_private_xattr(sb, name))
 =09=09=09continue;
 retry:
 =09=09size =3D vfs_getxattr(old, name, value, value_size);
@@ -320,7 +321,8 @@ int ovl_set_origin(struct dentry *dentry, struct dentry=
 *lower,
 }
=20
 /* Store file handle of @upper dir in @index dir entry */
-static int ovl_set_upper_fh(struct dentry *upper, struct dentry *index)
+static int ovl_set_upper_fh(struct ovl_fs *ofs, struct dentry *upper,
+=09=09=09    struct dentry *index)
 {
 =09const struct ovl_fh *fh;
 =09int err;
@@ -329,7 +331,7 @@ static int ovl_set_upper_fh(struct dentry *upper, struc=
t dentry *index)
 =09if (IS_ERR(fh))
 =09=09return PTR_ERR(fh);
=20
-=09err =3D ovl_do_setxattr(index, OVL_XATTR_UPPER, fh, fh->len, 0);
+=09err =3D ovl_own_setxattr(ofs, index, OVL_XATTR_UPPER, fh, fh->len);
=20
 =09kfree(fh);
 =09return err;
@@ -343,6 +345,7 @@ static int ovl_set_upper_fh(struct dentry *upper, struc=
t dentry *index)
 static int ovl_create_index(struct dentry *dentry, struct dentry *origin,
 =09=09=09    struct dentry *upper)
 {
+=09struct ovl_fs *ofs =3D dentry->d_sb->s_fs_info;
 =09struct dentry *indexdir =3D ovl_indexdir(dentry->d_sb);
 =09struct inode *dir =3D d_inode(indexdir);
 =09struct dentry *index =3D NULL;
@@ -374,7 +377,7 @@ static int ovl_create_index(struct dentry *dentry, stru=
ct dentry *origin,
 =09if (IS_ERR(temp))
 =09=09goto free_name;
=20
-=09err =3D ovl_set_upper_fh(upper, temp);
+=09err =3D ovl_set_upper_fh(ofs, upper, temp);
 =09if (err)
 =09=09goto out;
=20
@@ -470,7 +473,7 @@ static int ovl_copy_up_inode(struct ovl_copy_up_ctx *c,=
 struct dentry *temp)
 =09=09=09return err;
 =09}
=20
-=09err =3D ovl_copy_xattr(c->lowerpath.dentry, temp);
+=09err =3D ovl_copy_xattr(c->dentry->d_sb, c->lowerpath.dentry, temp);
 =09if (err)
 =09=09return err;
=20
@@ -749,6 +752,7 @@ static bool ovl_need_meta_copy_up(struct dentry *dentry=
, umode_t mode,
 /* Copy up data of an inode which was copied up metadata only in the past.=
 */
 static int ovl_copy_up_meta_inode_data(struct ovl_copy_up_ctx *c)
 {
+=09struct ovl_fs *ofs =3D c->dentry->d_sb->s_fs_info;
 =09struct path upperpath, datapath;
 =09int err;
 =09char *capability =3D NULL;
@@ -785,7 +789,7 @@ static int ovl_copy_up_meta_inode_data(struct ovl_copy_=
up_ctx *c)
 =09}
=20
=20
-=09err =3D vfs_removexattr(upperpath.dentry, OVL_XATTR_METACOPY);
+=09err =3D ovl_own_removexattr(ofs, upperpath.dentry, OVL_XATTR_METACOPY);
 =09if (err)
 =09=09goto out_free;
=20
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 702aa63f6774..17ffaa67fdb3 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -365,7 +365,7 @@ static struct dentry *ovl_clear_empty(struct dentry *de=
ntry,
 =09if (IS_ERR(opaquedir))
 =09=09goto out_unlock;
=20
-=09err =3D ovl_copy_xattr(upper, opaquedir);
+=09err =3D ovl_copy_xattr(dentry->d_sb, upper, opaquedir);
 =09if (err)
 =09=09goto out_cleanup;
=20
diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
index 73c9775215b3..5cdcd42c6280 100644
--- a/fs/overlayfs/export.c
+++ b/fs/overlayfs/export.c
@@ -759,7 +759,7 @@ static struct dentry *ovl_lower_fh_to_d(struct super_bl=
ock *sb,
 =09=09=09goto out_err;
 =09}
 =09if (index) {
-=09=09err =3D ovl_verify_origin(index, origin.dentry, false);
+=09=09err =3D ovl_verify_origin(ofs, index, origin.dentry, false);
 =09=09if (err)
 =09=09=09goto out_err;
 =09}
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index bc14781886bf..bf15ce4081ba 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -312,12 +312,6 @@ static const char *ovl_get_link(struct dentry *dentry,
 =09return p;
 }
=20
-bool ovl_is_private_xattr(const char *name)
-{
-=09return strncmp(name, OVL_XATTR_PREFIX,
-=09=09       sizeof(OVL_XATTR_PREFIX) - 1) =3D=3D 0;
-}
-
 int ovl_xattr_set(struct dentry *dentry, struct inode *inode, const char *=
name,
 =09=09  const void *value, size_t size, int flags)
 {
@@ -376,15 +370,18 @@ int ovl_xattr_get(struct dentry *dentry, struct inode=
 *inode, const char *name,
 =09return res;
 }
=20
-static bool ovl_can_list(const char *s)
+static bool ovl_can_list(struct super_block *sb, const char *s)
 {
+=09/* Never list private (.overlay) */
+=09if (ovl_is_private_xattr(sb, s))
+=09=09return false;
+
 =09/* List all non-trusted xatts */
 =09if (strncmp(s, XATTR_TRUSTED_PREFIX, XATTR_TRUSTED_PREFIX_LEN) !=3D 0)
 =09=09return true;
=20
-=09/* Never list trusted.overlay, list other trusted for superuser only */
-=09return !ovl_is_private_xattr(s) &&
-=09       ns_capable_noaudit(&init_user_ns, CAP_SYS_ADMIN);
+=09/* list other trusted for superuser only */
+=09return ns_capable_noaudit(&init_user_ns, CAP_SYS_ADMIN);
 }
=20
 ssize_t ovl_listxattr(struct dentry *dentry, char *list, size_t size)
@@ -410,7 +407,7 @@ ssize_t ovl_listxattr(struct dentry *dentry, char *list=
, size_t size)
 =09=09=09return -EIO;
=20
 =09=09len -=3D slen;
-=09=09if (!ovl_can_list(s)) {
+=09=09if (!ovl_can_list(dentry->d_sb, s)) {
 =09=09=09res -=3D slen;
 =09=09=09memmove(s, s + slen, len);
 =09=09} else {
@@ -635,6 +632,7 @@ static int ovl_set_nlink_common(struct dentry *dentry,
 {
 =09struct inode *inode =3D d_inode(dentry);
 =09struct inode *realinode =3D d_inode(realdentry);
+=09struct ovl_fs *ofs =3D inode->i_sb->s_fs_info;
 =09char buf[13];
 =09int len;
=20
@@ -644,8 +642,8 @@ static int ovl_set_nlink_common(struct dentry *dentry,
 =09if (WARN_ON(len >=3D sizeof(buf)))
 =09=09return -EIO;
=20
-=09return ovl_do_setxattr(ovl_dentry_upper(dentry),
-=09=09=09       OVL_XATTR_NLINK, buf, len, 0);
+=09return ovl_own_setxattr(ofs, ovl_dentry_upper(dentry),
+=09=09=09=09OVL_XATTR_NLINK, buf, len);
 }
=20
 int ovl_set_nlink_upper(struct dentry *dentry)
@@ -658,7 +656,7 @@ int ovl_set_nlink_lower(struct dentry *dentry)
 =09return ovl_set_nlink_common(dentry, ovl_dentry_lower(dentry), "L%+i");
 }
=20
-unsigned int ovl_get_nlink(struct dentry *lowerdentry,
+unsigned int ovl_get_nlink(struct ovl_fs *ofs, struct dentry *lowerdentry,
 =09=09=09   struct dentry *upperdentry,
 =09=09=09   unsigned int fallback)
 {
@@ -670,7 +668,8 @@ unsigned int ovl_get_nlink(struct dentry *lowerdentry,
 =09if (!lowerdentry || !upperdentry || d_inode(lowerdentry)->i_nlink =3D=
=3D 1)
 =09=09return fallback;
=20
-=09err =3D vfs_getxattr(upperdentry, OVL_XATTR_NLINK, &buf, sizeof(buf) - =
1);
+=09err =3D ovl_own_getxattr(ofs, upperdentry, OVL_XATTR_NLINK,
+=09=09=09       &buf, sizeof(buf) - 1);
 =09if (err < 0)
 =09=09goto fail;
=20
@@ -868,6 +867,7 @@ static struct inode *ovl_iget5(struct super_block *sb, =
struct inode *newinode,
 struct inode *ovl_get_inode(struct super_block *sb,
 =09=09=09    struct ovl_inode_params *oip)
 {
+=09struct ovl_fs *ofs =3D sb->s_fs_info;
 =09struct dentry *upperdentry =3D oip->upperdentry;
 =09struct ovl_path *lowerpath =3D oip->lowerpath;
 =09struct inode *realinode =3D upperdentry ? d_inode(upperdentry) : NULL;
@@ -915,7 +915,8 @@ struct inode *ovl_get_inode(struct super_block *sb,
=20
 =09=09/* Recalculate nlink for non-dir due to indexing */
 =09=09if (!is_dir)
-=09=09=09nlink =3D ovl_get_nlink(lowerdentry, upperdentry, nlink);
+=09=09=09nlink =3D ovl_get_nlink(ofs, lowerdentry, upperdentry,
+=09=09=09=09=09      nlink);
 =09=09set_nlink(inode, nlink);
 =09=09ino =3D key->i_ino;
 =09} else {
@@ -929,14 +930,14 @@ struct inode *ovl_get_inode(struct super_block *sb,
 =09ovl_fill_inode(inode, realinode->i_mode, realinode->i_rdev, ino, fsid);
 =09ovl_inode_init(inode, upperdentry, lowerdentry, oip->lowerdata);
=20
-=09if (upperdentry && ovl_is_impuredir(upperdentry))
+=09if (upperdentry && ovl_is_impuredir(sb, upperdentry))
 =09=09ovl_set_flag(OVL_IMPURE, inode);
=20
 =09if (oip->index)
 =09=09ovl_set_flag(OVL_INDEX, inode);
=20
 =09if (upperdentry) {
-=09=09err =3D ovl_check_metacopy_xattr(upperdentry);
+=09=09err =3D ovl_check_metacopy_xattr(ofs, upperdentry);
 =09=09if (err < 0)
 =09=09=09goto out_err;
 =09=09metacopy =3D err;
@@ -952,7 +953,7 @@ struct inode *ovl_get_inode(struct super_block *sb,
 =09/* Check for non-merge dir that may have whiteouts */
 =09if (is_dir) {
 =09=09if (((upperdentry && lowerdentry) || oip->numlower > 1) ||
-=09=09    ovl_check_origin_xattr(upperdentry ?: lowerdentry)) {
+=09=09    ovl_check_origin_xattr(ofs, upperdentry ?: lowerdentry)) {
 =09=09=09ovl_set_flag(OVL_WHITEOUTS, inode);
 =09=09}
 =09}
diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index e9717c2f7d45..34712bd0cd3f 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -30,8 +30,9 @@ static int ovl_check_redirect(struct dentry *dentry, stru=
ct ovl_lookup_data *d,
 {
 =09int res;
 =09char *buf;
+=09struct ovl_fs *ofs =3D d->sb->s_fs_info;
=20
-=09buf =3D ovl_get_redirect_xattr(dentry, prelen + strlen(post));
+=09buf =3D ovl_get_redirect_xattr(ofs, dentry, prelen + strlen(post));
 =09if (IS_ERR_OR_NULL(buf))
 =09=09return PTR_ERR(buf);
=20
@@ -104,12 +105,13 @@ int ovl_check_fh_len(struct ovl_fh *fh, int fh_len)
 =09return 0;
 }
=20
-static struct ovl_fh *ovl_get_fh(struct dentry *dentry, const char *name)
+static struct ovl_fh *ovl_get_fh(struct ovl_fs *ofs, struct dentry *dentry=
,
+=09=09=09=09 enum ovl_xattr ox)
 {
 =09int res, err;
 =09struct ovl_fh *fh =3D NULL;
=20
-=09res =3D vfs_getxattr(dentry, name, NULL, 0);
+=09res =3D ovl_own_getxattr(ofs, dentry, ox, NULL, 0);
 =09if (res < 0) {
 =09=09if (res =3D=3D -ENODATA || res =3D=3D -EOPNOTSUPP)
 =09=09=09return NULL;
@@ -123,7 +125,7 @@ static struct ovl_fh *ovl_get_fh(struct dentry *dentry,=
 const char *name)
 =09if (!fh)
 =09=09return ERR_PTR(-ENOMEM);
=20
-=09res =3D vfs_getxattr(dentry, name, fh, res);
+=09res =3D ovl_own_getxattr(ofs, dentry, ox, fh, res);
 =09if (res < 0)
 =09=09goto fail;
=20
@@ -186,9 +188,9 @@ struct dentry *ovl_decode_real_fh(struct ovl_fh *fh, st=
ruct vfsmount *mnt,
 =09return real;
 }
=20
-static bool ovl_is_opaquedir(struct dentry *dentry)
+static bool ovl_is_opaquedir(struct super_block *sb, struct dentry *dentry=
)
 {
-=09return ovl_check_dir_xattr(dentry, OVL_XATTR_OPAQUE);
+=09return ovl_check_dir_xattr(sb, dentry, OVL_XATTR_OPAQUE);
 }
=20
 static int ovl_lookup_single(struct dentry *base, struct ovl_lookup_data *=
d,
@@ -196,6 +198,7 @@ static int ovl_lookup_single(struct dentry *base, struc=
t ovl_lookup_data *d,
 =09=09=09     size_t prelen, const char *post,
 =09=09=09     struct dentry **ret)
 {
+=09struct ovl_fs *ofs =3D d->sb->s_fs_info;
 =09struct dentry *this;
 =09int err;
 =09bool last_element =3D !post[0];
@@ -233,7 +236,7 @@ static int ovl_lookup_single(struct dentry *base, struc=
t ovl_lookup_data *d,
 =09=09=09d->stop =3D true;
 =09=09=09goto put_and_out;
 =09=09}
-=09=09err =3D ovl_check_metacopy_xattr(this);
+=09=09err =3D ovl_check_metacopy_xattr(ofs, this);
 =09=09if (err < 0)
 =09=09=09goto out_err;
=20
@@ -253,7 +256,7 @@ static int ovl_lookup_single(struct dentry *base, struc=
t ovl_lookup_data *d,
 =09=09if (d->last)
 =09=09=09goto out;
=20
-=09=09if (ovl_is_opaquedir(this)) {
+=09=09if (ovl_is_opaquedir(d->sb, this)) {
 =09=09=09d->stop =3D true;
 =09=09=09if (last_element)
 =09=09=09=09d->opaque =3D true;
@@ -364,7 +367,7 @@ int ovl_check_origin_fh(struct ovl_fs *ofs, struct ovl_=
fh *fh, bool connected,
 static int ovl_check_origin(struct ovl_fs *ofs, struct dentry *upperdentry=
,
 =09=09=09    struct ovl_path **stackp, unsigned int *ctrp)
 {
-=09struct ovl_fh *fh =3D ovl_get_fh(upperdentry, OVL_XATTR_ORIGIN);
+=09struct ovl_fh *fh =3D ovl_get_fh(ofs, upperdentry, OVL_XATTR_ORIGIN);
 =09int err;
=20
 =09if (IS_ERR_OR_NULL(fh))
@@ -390,10 +393,10 @@ static int ovl_check_origin(struct ovl_fs *ofs, struc=
t dentry *upperdentry,
  * Verify that @fh matches the file handle stored in xattr @name.
  * Return 0 on match, -ESTALE on mismatch, < 0 on error.
  */
-static int ovl_verify_fh(struct dentry *dentry, const char *name,
-=09=09=09 const struct ovl_fh *fh)
+static int ovl_verify_fh(struct ovl_fs *ofs, struct dentry *dentry,
+=09=09=09 enum ovl_xattr ox, const struct ovl_fh *fh)
 {
-=09struct ovl_fh *ofh =3D ovl_get_fh(dentry, name);
+=09struct ovl_fh *ofh =3D ovl_get_fh(ofs, dentry, ox);
 =09int err =3D 0;
=20
 =09if (!ofh)
@@ -417,8 +420,9 @@ static int ovl_verify_fh(struct dentry *dentry, const c=
har *name,
  *
  * Return 0 on match, -ESTALE on mismatch, -ENODATA on no xattr, < 0 on er=
ror.
  */
-int ovl_verify_set_fh(struct dentry *dentry, const char *name,
-=09=09      struct dentry *real, bool is_upper, bool set)
+int ovl_verify_set_fh(struct ovl_fs *ofs, struct dentry *dentry,
+=09=09      enum ovl_xattr ox, struct dentry *real, bool is_upper,
+=09=09      bool set)
 {
 =09struct inode *inode;
 =09struct ovl_fh *fh;
@@ -431,9 +435,9 @@ int ovl_verify_set_fh(struct dentry *dentry, const char=
 *name,
 =09=09goto fail;
 =09}
=20
-=09err =3D ovl_verify_fh(dentry, name, fh);
+=09err =3D ovl_verify_fh(ofs, dentry, ox, fh);
 =09if (set && err =3D=3D -ENODATA)
-=09=09err =3D ovl_do_setxattr(dentry, name, fh, fh->len, 0);
+=09=09err =3D ovl_own_setxattr(ofs, dentry, ox, fh, fh->len);
 =09if (err)
 =09=09goto fail;
=20
@@ -458,7 +462,7 @@ struct dentry *ovl_index_upper(struct ovl_fs *ofs, stru=
ct dentry *index)
 =09if (!d_is_dir(index))
 =09=09return dget(index);
=20
-=09fh =3D ovl_get_fh(index, OVL_XATTR_UPPER);
+=09fh =3D ovl_get_fh(ofs, index, OVL_XATTR_UPPER);
 =09if (IS_ERR_OR_NULL(fh))
 =09=09return ERR_CAST(fh);
=20
@@ -562,7 +566,7 @@ int ovl_verify_index(struct ovl_fs *ofs, struct dentry =
*index)
 =09=09goto fail;
 =09}
=20
-=09err =3D ovl_verify_fh(upper, OVL_XATTR_ORIGIN, fh);
+=09err =3D ovl_verify_fh(ofs, upper, OVL_XATTR_ORIGIN, fh);
 =09dput(upper);
 =09if (err)
 =09=09goto fail;
@@ -573,7 +577,7 @@ int ovl_verify_index(struct ovl_fs *ofs, struct dentry =
*index)
 =09=09if (err)
 =09=09=09goto fail;
=20
-=09=09if (ovl_get_nlink(origin.dentry, index, 0) =3D=3D 0)
+=09=09if (ovl_get_nlink(ofs, origin.dentry, index, 0) =3D=3D 0)
 =09=09=09goto orphan;
 =09}
=20
@@ -733,7 +737,7 @@ struct dentry *ovl_lookup_index(struct ovl_fs *ofs, str=
uct dentry *upper,
 =09=09}
=20
 =09=09/* Verify that dir index 'upper' xattr points to upper dir */
-=09=09err =3D ovl_verify_upper(index, upper, false);
+=09=09err =3D ovl_verify_upper(ofs, index, upper, false);
 =09=09if (err) {
 =09=09=09if (err =3D=3D -ESTALE) {
 =09=09=09=09pr_warn_ratelimited("overlayfs: suspected multiply redirected =
dir found (upper=3D%pd2, origin=3D%pd2, index=3D%pd2).\n",
@@ -782,12 +786,12 @@ int ovl_path_next(int idx, struct dentry *dentry, str=
uct path *path)
 }
=20
 /* Fix missing 'origin' xattr */
-static int ovl_fix_origin(struct dentry *dentry, struct dentry *lower,
-=09=09=09  struct dentry *upper)
+static int ovl_fix_origin(struct ovl_fs *ofs, struct dentry *dentry,
+=09=09=09  struct dentry *lower, struct dentry *upper)
 {
 =09int err;
=20
-=09if (ovl_check_origin_xattr(upper))
+=09if (ovl_check_origin_xattr(ofs, upper))
 =09=09return 0;
=20
 =09err =3D ovl_want_write(dentry);
@@ -909,7 +913,7 @@ struct dentry *ovl_lookup(struct inode *dir, struct den=
try *dentry,
 =09=09 * of lower dir and set upper parent "impure".
 =09=09 */
 =09=09if (upperdentry && !ctr && !ofs->noxattr && d.is_dir) {
-=09=09=09err =3D ovl_fix_origin(dentry, this, upperdentry);
+=09=09=09err =3D ovl_fix_origin(ofs, dentry, this, upperdentry);
 =09=09=09if (err) {
 =09=09=09=09dput(this);
 =09=09=09=09goto out_put;
@@ -928,7 +932,7 @@ struct dentry *ovl_lookup(struct inode *dir, struct den=
try *dentry,
 =09=09if (upperdentry && !ctr &&
 =09=09    ((d.is_dir && ovl_verify_lower(dentry->d_sb)) ||
 =09=09     (!d.is_dir && ofs->config.index && origin_path))) {
-=09=09=09err =3D ovl_verify_origin(upperdentry, this, false);
+=09=09=09err =3D ovl_verify_origin(ofs, upperdentry, this, false);
 =09=09=09if (err) {
 =09=09=09=09dput(this);
 =09=09=09=09if (d.is_dir)
@@ -1049,7 +1053,7 @@ struct dentry *ovl_lookup(struct inode *dir, struct d=
entry *dentry,
 =09=09ovl_dentry_set_upper_alias(dentry);
 =09else if (index) {
 =09=09upperdentry =3D dget(index);
-=09=09upperredirect =3D ovl_get_redirect_xattr(upperdentry, 0);
+=09=09upperredirect =3D ovl_get_redirect_xattr(ofs, upperdentry, 0);
 =09=09if (IS_ERR(upperredirect)) {
 =09=09=09err =3D PTR_ERR(upperredirect);
 =09=09=09upperredirect =3D NULL;
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 6934bcf030f0..8d09bd92ec24 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -19,14 +19,27 @@ enum ovl_path_type {
 #define OVL_TYPE_MERGE(type)=09((type) & __OVL_PATH_MERGE)
 #define OVL_TYPE_ORIGIN(type)=09((type) & __OVL_PATH_ORIGIN)
=20
-#define OVL_XATTR_PREFIX XATTR_TRUSTED_PREFIX "overlay."
-#define OVL_XATTR_OPAQUE OVL_XATTR_PREFIX "opaque"
-#define OVL_XATTR_REDIRECT OVL_XATTR_PREFIX "redirect"
-#define OVL_XATTR_ORIGIN OVL_XATTR_PREFIX "origin"
-#define OVL_XATTR_IMPURE OVL_XATTR_PREFIX "impure"
-#define OVL_XATTR_NLINK OVL_XATTR_PREFIX "nlink"
-#define OVL_XATTR_UPPER OVL_XATTR_PREFIX "upper"
-#define OVL_XATTR_METACOPY OVL_XATTR_PREFIX "metacopy"
+#define OVL_XATTR_NAMESPACE "overlay."
+#define OVL_XATTR_TRUSTED_PREFIX XATTR_TRUSTED_PREFIX OVL_XATTR_NAMESPACE
+#define OVL_XATTR_USER_PREFIX XATTR_USER_PREFIX OVL_XATTR_NAMESPACE
+
+#define OVL_XATTR_OPAQUE_POSTFIX=09"opaque"
+#define OVL_XATTR_REDIRECT_POSTFIX=09"redirect"
+#define OVL_XATTR_ORIGIN_POSTFIX=09"origin"
+#define OVL_XATTR_IMPURE_POSTFIX=09"impure"
+#define OVL_XATTR_NLINK_POSTFIX=09=09"nlink"
+#define OVL_XATTR_UPPER_POSTFIX=09=09"upper"
+#define OVL_XATTR_METACOPY_POSTFIX=09"metacopy"
+
+enum ovl_xattr {
+=09OVL_XATTR_OPAQUE,
+=09OVL_XATTR_REDIRECT,
+=09OVL_XATTR_ORIGIN,
+=09OVL_XATTR_IMPURE,
+=09OVL_XATTR_NLINK,
+=09OVL_XATTR_UPPER,
+=09OVL_XATTR_METACOPY,
+};
=20
 enum ovl_inode_flag {
 =09/* Pure upper dir that may contain non pure upper entries */
@@ -256,10 +269,11 @@ struct file *ovl_path_open(struct path *path, int fla=
gs);
 int ovl_copy_up_start(struct dentry *dentry, int flags);
 void ovl_copy_up_end(struct dentry *dentry);
 bool ovl_already_copied_up(struct dentry *dentry, int flags);
-bool ovl_check_origin_xattr(struct dentry *dentry);
-bool ovl_check_dir_xattr(struct dentry *dentry, const char *name);
+bool ovl_check_origin_xattr(struct ovl_fs *ofs, struct dentry *dentry);
+bool ovl_check_dir_xattr(struct super_block *sb, struct dentry *dentry,
+=09=09=09 enum ovl_xattr ox);
 int ovl_check_setxattr(struct dentry *dentry, struct dentry *upperdentry,
-=09=09       const char *name, const void *value, size_t size,
+=09=09       enum ovl_xattr ox, const void *value, size_t size,
 =09=09       int xerr);
 int ovl_set_impure(struct dentry *dentry, struct dentry *upperdentry);
 void ovl_set_flag(unsigned long flag, struct inode *inode);
@@ -272,15 +286,24 @@ bool ovl_need_index(struct dentry *dentry);
 int ovl_nlink_start(struct dentry *dentry);
 void ovl_nlink_end(struct dentry *dentry);
 int ovl_lock_rename_workdir(struct dentry *workdir, struct dentry *upperdi=
r);
-int ovl_check_metacopy_xattr(struct dentry *dentry);
+int ovl_check_metacopy_xattr(struct ovl_fs *ofs, struct dentry *dentry);
 bool ovl_is_metacopy_dentry(struct dentry *dentry);
-char *ovl_get_redirect_xattr(struct dentry *dentry, int padding);
-ssize_t ovl_getxattr(struct dentry *dentry, char *name, char **value,
-=09=09     size_t padding);
-
-static inline bool ovl_is_impuredir(struct dentry *dentry)
+char *ovl_get_redirect_xattr(struct ovl_fs *ofs, struct dentry *dentry,
+=09=09=09     int padding);
+ssize_t ovl_getxattr(struct dentry *dentry, const char *name,
+=09=09     char **value, size_t padding);
+int ovl_own_setxattr(struct ovl_fs *ofs, struct dentry *dentry,
+=09=09     enum ovl_xattr ox, const void *value, size_t size);
+int ovl_own_removexattr(struct ovl_fs *ofs, struct dentry *dentry,
+=09=09=09enum ovl_xattr ox);
+ssize_t ovl_own_getxattr(struct ovl_fs *ofs, struct dentry *dentry,
+=09=09=09 enum ovl_xattr ox, void *value, size_t size);
+bool ovl_is_private_xattr(struct super_block *sb, const char *name);
+
+static inline bool ovl_is_impuredir(struct super_block *sb,
+=09=09=09=09    struct dentry *dentry)
 {
-=09return ovl_check_dir_xattr(dentry, OVL_XATTR_IMPURE);
+=09return ovl_check_dir_xattr(sb, dentry, OVL_XATTR_IMPURE);
 }
=20
 static inline unsigned int ovl_xino_bits(struct super_block *sb)
@@ -307,8 +330,9 @@ struct dentry *ovl_decode_real_fh(struct ovl_fh *fh, st=
ruct vfsmount *mnt,
 =09=09=09=09  bool connected);
 int ovl_check_origin_fh(struct ovl_fs *ofs, struct ovl_fh *fh, bool connec=
ted,
 =09=09=09struct dentry *upperdentry, struct ovl_path **stackp);
-int ovl_verify_set_fh(struct dentry *dentry, const char *name,
-=09=09      struct dentry *real, bool is_upper, bool set);
+int ovl_verify_set_fh(struct ovl_fs *ofs, struct dentry *dentry,
+=09=09      enum ovl_xattr ox, struct dentry *real, bool is_upper,
+=09=09      bool set);
 struct dentry *ovl_index_upper(struct ovl_fs *ofs, struct dentry *index);
 int ovl_verify_index(struct ovl_fs *ofs, struct dentry *index);
 int ovl_get_index_name(struct dentry *origin, struct qstr *name);
@@ -320,16 +344,17 @@ struct dentry *ovl_lookup(struct inode *dir, struct d=
entry *dentry,
 =09=09=09  unsigned int flags);
 bool ovl_lower_positive(struct dentry *dentry);
=20
-static inline int ovl_verify_origin(struct dentry *upper,
+static inline int ovl_verify_origin(struct ovl_fs *ofs, struct dentry *upp=
er,
 =09=09=09=09    struct dentry *origin, bool set)
 {
-=09return ovl_verify_set_fh(upper, OVL_XATTR_ORIGIN, origin, false, set);
+=09return ovl_verify_set_fh(ofs, upper, OVL_XATTR_ORIGIN, origin,
+=09=09=09=09 false, set);
 }
=20
-static inline int ovl_verify_upper(struct dentry *index,
-=09=09=09=09    struct dentry *upper, bool set)
+static inline int ovl_verify_upper(struct ovl_fs *ofs, struct dentry *inde=
x,
+=09=09=09=09   struct dentry *upper, bool set)
 {
-=09return ovl_verify_set_fh(index, OVL_XATTR_UPPER, upper, true, set);
+=09return ovl_verify_set_fh(ofs, index, OVL_XATTR_UPPER, upper, true, set)=
;
 }
=20
 /* readdir.c */
@@ -346,7 +371,7 @@ int ovl_indexdir_cleanup(struct ovl_fs *ofs);
 /* inode.c */
 int ovl_set_nlink_upper(struct dentry *dentry);
 int ovl_set_nlink_lower(struct dentry *dentry);
-unsigned int ovl_get_nlink(struct dentry *lowerdentry,
+unsigned int ovl_get_nlink(struct ovl_fs *ofs, struct dentry *lowerdentry,
 =09=09=09   struct dentry *upperdentry,
 =09=09=09   unsigned int fallback);
 int ovl_setattr(struct dentry *dentry, struct iattr *attr);
@@ -360,7 +385,6 @@ int ovl_xattr_get(struct dentry *dentry, struct inode *=
inode, const char *name,
 ssize_t ovl_listxattr(struct dentry *dentry, char *list, size_t size);
 struct posix_acl *ovl_get_acl(struct inode *inode, int type);
 int ovl_update_time(struct inode *inode, struct timespec64 *ts, int flags)=
;
-bool ovl_is_private_xattr(const char *name);
=20
 struct ovl_inode_params {
 =09struct inode *newinode;
@@ -422,7 +446,8 @@ int ovl_copy_up(struct dentry *dentry);
 int ovl_copy_up_with_data(struct dentry *dentry);
 int ovl_copy_up_flags(struct dentry *dentry, int flags);
 int ovl_maybe_copy_up(struct dentry *dentry, int flags);
-int ovl_copy_xattr(struct dentry *old, struct dentry *new);
+int ovl_copy_xattr(struct super_block *sb, struct dentry *old,
+=09=09   struct dentry *new);
 int ovl_set_attr(struct dentry *upper, struct kstat *stat);
 struct ovl_fh *ovl_encode_real_fh(struct dentry *real, bool is_upper);
 int ovl_set_origin(struct dentry *dentry, struct dentry *lower,
diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
index a8279280e88d..e2ea474a2650 100644
--- a/fs/overlayfs/ovl_entry.h
+++ b/fs/overlayfs/ovl_entry.h
@@ -17,6 +17,7 @@ struct ovl_config {
 =09bool nfs_export;
 =09int xino;
 =09bool metacopy;
+=09bool userxattr;
 };
=20
 struct ovl_sb {
diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 47a91c9733a5..3cf24dffc3b9 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -591,6 +591,7 @@ static struct ovl_dir_cache *ovl_cache_get_impure(struc=
t path *path)
 {
 =09int res;
 =09struct dentry *dentry =3D path->dentry;
+=09struct ovl_fs *ofs =3D dentry->d_sb->s_fs_info;
 =09struct ovl_dir_cache *cache;
=20
 =09cache =3D ovl_dir_cache(d_inode(dentry));
@@ -617,8 +618,8 @@ static struct ovl_dir_cache *ovl_cache_get_impure(struc=
t path *path)
 =09=09 * Removing the "impure" xattr is best effort.
 =09=09 */
 =09=09if (!ovl_want_write(dentry)) {
-=09=09=09ovl_do_removexattr(ovl_dentry_upper(dentry),
-=09=09=09=09=09   OVL_XATTR_IMPURE);
+=09=09=09ovl_own_removexattr(ofs, ovl_dentry_upper(dentry),
+=09=09=09=09=09    OVL_XATTR_IMPURE);
 =09=09=09ovl_drop_write(dentry);
 =09=09}
 =09=09ovl_clear_flag(OVL_IMPURE, d_inode(dentry));
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index afbcb116a7f1..d122c07f2a43 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -403,6 +403,7 @@ enum {
 =09OPT_XINO_AUTO,
 =09OPT_METACOPY_ON,
 =09OPT_METACOPY_OFF,
+=09OPT_USERXATTR,
 =09OPT_ERR,
 };
=20
@@ -421,6 +422,7 @@ static const match_table_t ovl_tokens =3D {
 =09{OPT_XINO_AUTO,=09=09=09"xino=3Dauto"},
 =09{OPT_METACOPY_ON,=09=09"metacopy=3Don"},
 =09{OPT_METACOPY_OFF,=09=09"metacopy=3Doff"},
+=09{OPT_USERXATTR,=09=09=09"userxattr"},
 =09{OPT_ERR,=09=09=09NULL}
 };
=20
@@ -559,6 +561,10 @@ static int ovl_parse_opt(char *opt, struct ovl_config =
*config)
 =09=09=09config->metacopy =3D false;
 =09=09=09break;
=20
+=09=09case OPT_USERXATTR:
+=09=09=09config->userxattr =3D true;
+=09=09=09break;
+
 =09=09default:
 =09=09=09pr_err("overlayfs: unrecognized mount option \"%s\" or missing va=
lue\n", p);
 =09=09=09return -EINVAL;
@@ -964,8 +970,14 @@ ovl_posix_acl_default_xattr_handler =3D {
 =09.set =3D ovl_posix_acl_xattr_set,
 };
=20
-static const struct xattr_handler ovl_own_xattr_handler =3D {
-=09.prefix=09=3D OVL_XATTR_PREFIX,
+static const struct xattr_handler ovl_own_trusted_xattr_handler =3D {
+=09.prefix=09=3D OVL_XATTR_TRUSTED_PREFIX,
+=09.get =3D ovl_own_xattr_get,
+=09.set =3D ovl_own_xattr_set,
+};
+
+static const struct xattr_handler ovl_own_user_xattr_handler =3D {
+=09.prefix=09=3D OVL_XATTR_USER_PREFIX,
 =09.get =3D ovl_own_xattr_get,
 =09.set =3D ovl_own_xattr_set,
 };
@@ -976,12 +988,22 @@ static const struct xattr_handler ovl_other_xattr_han=
dler =3D {
 =09.set =3D ovl_other_xattr_set,
 };
=20
-static const struct xattr_handler *ovl_xattr_handlers[] =3D {
+static const struct xattr_handler *ovl_trusted_xattr_handlers[] =3D {
 #ifdef CONFIG_FS_POSIX_ACL
 =09&ovl_posix_acl_access_xattr_handler,
 =09&ovl_posix_acl_default_xattr_handler,
 #endif
-=09&ovl_own_xattr_handler,
+=09&ovl_own_trusted_xattr_handler,
+=09&ovl_other_xattr_handler,
+=09NULL
+};
+
+static const struct xattr_handler *ovl_user_xattr_handlers[] =3D {
+#ifdef CONFIG_FS_POSIX_ACL
+=09&ovl_posix_acl_access_xattr_handler,
+=09&ovl_posix_acl_default_xattr_handler,
+#endif
+=09&ovl_own_user_xattr_handler,
 =09&ovl_other_xattr_handler,
 =09NULL
 };
@@ -1121,7 +1143,7 @@ static int ovl_make_workdir(struct super_block *sb, s=
truct ovl_fs *ofs,
 =09/*
 =09 * Check if upper/work fs supports trusted.overlay.* xattr
 =09 */
-=09err =3D ovl_do_setxattr(ofs->workdir, OVL_XATTR_OPAQUE, "0", 1, 0);
+=09err =3D ovl_own_setxattr(ofs, ofs->workdir, OVL_XATTR_OPAQUE, "0", 1);
 =09if (err) {
 =09=09ofs->noxattr =3D true;
 =09=09ofs->config.index =3D false;
@@ -1129,7 +1151,7 @@ static int ovl_make_workdir(struct super_block *sb, s=
truct ovl_fs *ofs,
 =09=09pr_warn("overlayfs: upper fs does not support xattr, falling back to=
 index=3Doff and metacopy=3Doff.\n");
 =09=09err =3D 0;
 =09} else {
-=09=09vfs_removexattr(ofs->workdir, OVL_XATTR_OPAQUE);
+=09=09ovl_own_removexattr(ofs, ofs->workdir, OVL_XATTR_OPAQUE);
 =09}
=20
 =09/* Check if upper/work fs supports file handles */
@@ -1207,8 +1229,8 @@ static int ovl_get_indexdir(struct super_block *sb, s=
truct ovl_fs *ofs,
 =09=09return err;
=20
 =09/* Verify lower root is upper root origin */
-=09err =3D ovl_verify_origin(upperpath->dentry, oe->lowerstack[0].dentry,
-=09=09=09=09true);
+=09err =3D ovl_verify_origin(ofs, upperpath->dentry,
+=09=09=09=09oe->lowerstack[0].dentry, true);
 =09if (err) {
 =09=09pr_err("overlayfs: failed to verify upper root origin\n");
 =09=09goto out;
@@ -1229,13 +1251,15 @@ static int ovl_get_indexdir(struct super_block *sb,=
 struct ovl_fs *ofs,
 =09=09 * "trusted.overlay.upper" to indicate that index may have
 =09=09 * directory entries.
 =09=09 */
-=09=09if (ovl_check_origin_xattr(ofs->indexdir)) {
-=09=09=09err =3D ovl_verify_set_fh(ofs->indexdir, OVL_XATTR_ORIGIN,
+=09=09if (ovl_check_origin_xattr(ofs, ofs->indexdir)) {
+=09=09=09err =3D ovl_verify_set_fh(ofs, ofs->indexdir,
+=09=09=09=09=09=09OVL_XATTR_ORIGIN,
 =09=09=09=09=09=09upperpath->dentry, true, false);
 =09=09=09if (err)
 =09=09=09=09pr_err("overlayfs: failed to verify index dir 'origin' xattr\n=
");
 =09=09}
-=09=09err =3D ovl_verify_upper(ofs->indexdir, upperpath->dentry, true);
+=09=09err =3D ovl_verify_upper(ofs, ofs->indexdir, upperpath->dentry,
+=09=09=09=09       true);
 =09=09if (err)
 =09=09=09pr_err("overlayfs: failed to verify index dir 'upper' xattr\n");
=20
@@ -1588,7 +1612,6 @@ static int ovl_fill_super(struct super_block *sb, voi=
d *data, int silent)
 =09=09=09pr_err("overlayfs: missing 'lowerdir'\n");
 =09=09goto out_err;
 =09}
-
 =09sb->s_stack_depth =3D 0;
 =09sb->s_maxbytes =3D MAX_LFS_FILESIZE;
 =09/* Assume underlaying fs uses 32bit inodes unless proven otherwise */
@@ -1667,7 +1690,8 @@ static int ovl_fill_super(struct super_block *sb, voi=
d *data, int silent)
 =09cap_lower(cred->cap_effective, CAP_SYS_RESOURCE);
=20
 =09sb->s_magic =3D OVERLAYFS_SUPER_MAGIC;
-=09sb->s_xattr =3D ovl_xattr_handlers;
+=09sb->s_xattr =3D ofs->config.userxattr ? ovl_user_xattr_handlers :
+=09=09ovl_trusted_xattr_handlers;
 =09sb->s_fs_info =3D ofs;
 =09sb->s_flags |=3D SB_POSIXACL;
=20
@@ -1681,7 +1705,7 @@ static int ovl_fill_super(struct super_block *sb, voi=
d *data, int silent)
 =09mntput(upperpath.mnt);
 =09if (upperpath.dentry) {
 =09=09ovl_dentry_set_upper_alias(root_dentry);
-=09=09if (ovl_is_impuredir(upperpath.dentry))
+=09=09if (ovl_is_impuredir(sb, upperpath.dentry))
 =09=09=09ovl_set_flag(OVL_IMPURE, d_inode(root_dentry));
 =09}
=20
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index f5678a3f8350..5eaa92445fe2 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -535,11 +535,11 @@ void ovl_copy_up_end(struct dentry *dentry)
 =09ovl_inode_unlock(d_inode(dentry));
 }
=20
-bool ovl_check_origin_xattr(struct dentry *dentry)
+bool ovl_check_origin_xattr(struct ovl_fs *ofs, struct dentry *dentry)
 {
 =09int res;
=20
-=09res =3D vfs_getxattr(dentry, OVL_XATTR_ORIGIN, NULL, 0);
+=09res =3D ovl_own_getxattr(ofs, dentry, OVL_XATTR_ORIGIN, NULL, 0);
=20
 =09/* Zero size value means "copied up but origin unknown" */
 =09if (res >=3D 0)
@@ -548,27 +548,49 @@ bool ovl_check_origin_xattr(struct dentry *dentry)
 =09return false;
 }
=20
-bool ovl_check_dir_xattr(struct dentry *dentry, const char *name)
+bool ovl_check_dir_xattr(struct super_block *sb, struct dentry *dentry,
+=09=09=09 enum ovl_xattr ox)
 {
 =09int res;
 =09char val;
+=09struct ovl_fs *ofs =3D sb->s_fs_info;
=20
 =09if (!d_is_dir(dentry))
 =09=09return false;
=20
-=09res =3D vfs_getxattr(dentry, name, &val, 1);
+=09res =3D ovl_own_getxattr(ofs, dentry, ox, &val, 1);
 =09if (res =3D=3D 1 && val =3D=3D 'y')
 =09=09return true;
=20
 =09return false;
 }
=20
+#define OVL_XATTR_TAB_ENTRY(x) \
+=09[x] =3D { [false] =3D OVL_XATTR_TRUSTED_PREFIX x ## _POSTFIX, \
+=09=09[true] =3D OVL_XATTR_USER_PREFIX x ## _POSTFIX }
+
+static const char *ovl_xattr_table[][2] =3D {
+=09OVL_XATTR_TAB_ENTRY(OVL_XATTR_OPAQUE),
+=09OVL_XATTR_TAB_ENTRY(OVL_XATTR_REDIRECT),
+=09OVL_XATTR_TAB_ENTRY(OVL_XATTR_ORIGIN),
+=09OVL_XATTR_TAB_ENTRY(OVL_XATTR_IMPURE),
+=09OVL_XATTR_TAB_ENTRY(OVL_XATTR_NLINK),
+=09OVL_XATTR_TAB_ENTRY(OVL_XATTR_UPPER),
+=09OVL_XATTR_TAB_ENTRY(OVL_XATTR_METACOPY),
+};
+
+static const char *ovl_xattr(struct ovl_fs *ofs, enum ovl_xattr ox)
+{
+=09return ovl_xattr_table[ox][ofs->config.userxattr];
+}
+
 int ovl_check_setxattr(struct dentry *dentry, struct dentry *upperdentry,
-=09=09       const char *name, const void *value, size_t size,
+=09=09       enum ovl_xattr ox, const void *value, size_t size,
 =09=09       int xerr)
 {
 =09int err;
 =09struct ovl_fs *ofs =3D dentry->d_sb->s_fs_info;
+=09const char *name =3D ovl_xattr(ofs, ox);
=20
 =09if (ofs->noxattr)
 =09=09return xerr;
@@ -584,6 +606,18 @@ int ovl_check_setxattr(struct dentry *dentry, struct d=
entry *upperdentry,
 =09return err;
 }
=20
+bool ovl_is_private_xattr(struct super_block *sb, const char *name)
+{
+=09struct ovl_fs *ofs =3D sb->s_fs_info;
+
+=09if (ofs->config.userxattr)
+=09=09return strncmp(name, OVL_XATTR_USER_PREFIX,
+=09=09=09       sizeof(OVL_XATTR_USER_PREFIX) - 1) =3D=3D 0;
+=09else
+=09=09return strncmp(name, OVL_XATTR_TRUSTED_PREFIX,
+=09=09=09       sizeof(OVL_XATTR_TRUSTED_PREFIX) - 1) =3D=3D 0;
+}
+
 int ovl_set_impure(struct dentry *dentry, struct dentry *upperdentry)
 {
 =09int err;
@@ -835,7 +869,7 @@ int ovl_lock_rename_workdir(struct dentry *workdir, str=
uct dentry *upperdir)
 }
=20
 /* err < 0, 0 if no metacopy xattr, 1 if metacopy xattr found */
-int ovl_check_metacopy_xattr(struct dentry *dentry)
+int ovl_check_metacopy_xattr(struct ovl_fs *ofs, struct dentry *dentry)
 {
 =09int res;
=20
@@ -843,7 +877,7 @@ int ovl_check_metacopy_xattr(struct dentry *dentry)
 =09if (!S_ISREG(d_inode(dentry)->i_mode))
 =09=09return 0;
=20
-=09res =3D vfs_getxattr(dentry, OVL_XATTR_METACOPY, NULL, 0);
+=09res =3D ovl_own_getxattr(ofs, dentry, OVL_XATTR_METACOPY, NULL, 0);
 =09if (res < 0) {
 =09=09if (res =3D=3D -ENODATA || res =3D=3D -EOPNOTSUPP)
 =09=09=09return 0;
@@ -872,8 +906,8 @@ bool ovl_is_metacopy_dentry(struct dentry *dentry)
 =09return (oe->numlower > 1);
 }
=20
-ssize_t ovl_getxattr(struct dentry *dentry, char *name, char **value,
-=09=09     size_t padding)
+ssize_t ovl_getxattr(struct dentry *dentry, const char *name,
+=09=09     char **value, size_t padding)
 {
 =09ssize_t res;
 =09char *buf =3D NULL;
@@ -905,12 +939,14 @@ ssize_t ovl_getxattr(struct dentry *dentry, char *nam=
e, char **value,
 =09return res;
 }
=20
-char *ovl_get_redirect_xattr(struct dentry *dentry, int padding)
+char *ovl_get_redirect_xattr(struct ovl_fs *ofs, struct dentry *dentry,
+=09=09=09     int padding)
 {
 =09int res;
 =09char *s, *next, *buf =3D NULL;
+=09const char *name =3D ovl_xattr(ofs, OVL_XATTR_REDIRECT);
=20
-=09res =3D ovl_getxattr(dentry, OVL_XATTR_REDIRECT, &buf, padding + 1);
+=09res =3D ovl_getxattr(dentry, name, &buf, padding + 1);
 =09if (res =3D=3D -ENODATA)
 =09=09return NULL;
 =09if (res < 0)
@@ -936,3 +972,27 @@ char *ovl_get_redirect_xattr(struct dentry *dentry, in=
t padding)
 =09kfree(buf);
 =09return ERR_PTR(res);
 }
+
+int ovl_own_setxattr(struct ovl_fs *ofs, struct dentry *dentry,
+=09=09     enum ovl_xattr ox, const void *value, size_t size)
+{
+=09const char *name =3D ovl_xattr(ofs, ox);
+
+=09return ovl_do_setxattr(dentry, name, value, size, 0);
+}
+
+int ovl_own_removexattr(struct ovl_fs *ofs, struct dentry *dentry,
+=09=09=09enum ovl_xattr ox)
+{
+=09const char *name =3D ovl_xattr(ofs, ox);
+
+=09return ovl_do_removexattr(dentry, name);
+}
+
+ssize_t ovl_own_getxattr(struct ovl_fs *ofs, struct dentry *dentry,
+=09=09=09 enum ovl_xattr ox, void *value, size_t size)
+{
+=09const char *name =3D ovl_xattr(ofs, ox);
+
+=09return vfs_getxattr(dentry, name, value, size);
+}
--=20
2.21.0

