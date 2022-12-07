Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 016AC64559E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Dec 2022 09:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiLGInh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Dec 2022 03:43:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiLGIna (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Dec 2022 03:43:30 -0500
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997D7B1CA;
        Wed,  7 Dec 2022 00:43:27 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 9EB3A64BA9D6;
        Wed,  7 Dec 2022 09:43:25 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id LY6Z9iYN4mWg; Wed,  7 Dec 2022 09:43:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 0CE646226232;
        Wed,  7 Dec 2022 09:43:25 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zw7q6RHb6S87; Wed,  7 Dec 2022 09:43:24 +0100 (CET)
Received: from blindfold.corp.sigma-star.at (unknown [82.150.214.1])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 6544E64BA9AE;
        Wed,  7 Dec 2022 09:43:24 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     linux-nfs@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        jlayton@kernel.org, chuck.lever@oracle.com, anna@kernel.org,
        trond.myklebust@hammerspace.com, viro@zeniv.linux.org.uk,
        raven@themaw.net, chris.chilvers@appsbroker.com,
        david.young@appsbroker.com, luis.turcitu@appsbroker.com,
        david@sigma-star.at, benmaynard@google.com,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 2/3] fs: namei: Allow follow_down() to uncover auto mounts
Date:   Wed,  7 Dec 2022 09:43:08 +0100
Message-Id: <20221207084309.8499-3-richard@nod.at>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20221207084309.8499-1-richard@nod.at>
References: <20221207084309.8499-1-richard@nod.at>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This function is only used by NFSD to cross mount points.
If a mount point is of type auto mount, follow_down() will
not uncover it. Add LOOKUP_AUTOMOUNT to the lookup flags
to have ->d_automount() called when NFSD walks down the
mount tree.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 fs/namei.c            | 6 +++---
 fs/nfsd/vfs.c         | 6 +++++-
 include/linux/namei.h | 2 +-
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 578c2110df02..a6bb6863bf0c 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1458,11 +1458,11 @@ EXPORT_SYMBOL(follow_down_one);
  * point, the filesystem owning that dentry may be queried as to whether=
 the
  * caller is permitted to proceed or not.
  */
-int follow_down(struct path *path)
+int follow_down(struct path *path, unsigned int flags)
 {
 	struct vfsmount *mnt =3D path->mnt;
 	bool jumped;
-	int ret =3D traverse_mounts(path, &jumped, NULL, 0);
+	int ret =3D traverse_mounts(path, &jumped, NULL, flags);
=20
 	if (path->mnt !=3D mnt)
 		mntput(mnt);
@@ -2864,7 +2864,7 @@ int path_pts(struct path *path)
=20
 	path->dentry =3D child;
 	dput(parent);
-	follow_down(path);
+	follow_down(path, 0);
 	return 0;
 }
 #endif
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 157f0df0e93a..ced04fc2b947 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -63,9 +63,13 @@ nfsd_cross_mnt(struct svc_rqst *rqstp, struct dentry *=
*dpp,
 	struct dentry *dentry =3D *dpp;
 	struct path path =3D {.mnt =3D mntget(exp->ex_path.mnt),
 			    .dentry =3D dget(dentry)};
+	unsigned int follow_flags =3D 0;
 	int err =3D 0;
=20
-	err =3D follow_down(&path);
+	if (exp->ex_flags & NFSEXP_CROSSMOUNT)
+		follow_flags =3D LOOKUP_AUTOMOUNT;
+
+	err =3D follow_down(&path, follow_flags);
 	if (err < 0)
 		goto out;
 	if (path.mnt =3D=3D exp->ex_path.mnt && path.dentry =3D=3D dentry &&
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 00fee52df842..6f96db73a70a 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -77,7 +77,7 @@ struct dentry *lookup_one_positive_unlocked(struct user=
_namespace *mnt_userns,
 					    struct dentry *base, int len);
=20
 extern int follow_down_one(struct path *);
-extern int follow_down(struct path *);
+extern int follow_down(struct path *, unsigned int flags);
 extern int follow_up(struct path *);
=20
 extern struct dentry *lock_rename(struct dentry *, struct dentry *);
--=20
2.26.2

