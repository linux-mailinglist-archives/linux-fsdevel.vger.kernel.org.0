Return-Path: <linux-fsdevel+bounces-47613-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 036D2AA11AE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 18:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5410416EE30
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 16:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0904D2459FF;
	Tue, 29 Apr 2025 16:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LfCKzisC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903B4221719
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Apr 2025 16:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745944665; cv=none; b=R2Jd87Nhge1UcwkYFnwzQSpZW/1gQlJcHHyUK1ZT0tW9v4VI8fIsraSbQtjE+41JqoSC4ZG++dExboeiVEsWHQs61sQbtJI8S7d6W0LPCjStGcazDk5MuXLLr+rdlh4XM9AE0NRnrpabLGnQanO+AQ/b+7QMNyQ2CbyrTIuTPp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745944665; c=relaxed/simple;
	bh=GTBwZABLBbNP1w6oTnGAs8DazHtwqpwsSWLbCx8V+J0=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=kqX9J44ryl9BphgWCvUmDAeYnrKVC43JhaYZXVf3hp3TvfmCDX/pgJ1TAqqJSLgdVYxVjoF1+chZisFSL0s26VFlj0NKwlaL67OEejgGC5rQYMkZI3qf1EXfTD5UXgNLBNT0LdoP6thF7E21y7J5LaWbpFDdZtUgm64Dk7Ca2v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LfCKzisC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745944662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=v4Z7IYlxZGIUKwJwhWYGYh06tJAodt68SWJ/LkN2PlU=;
	b=LfCKzisCmflNKQxZcRgDENjysK3Apxvb4TNZmncey5STMewUb8LpH4aSIuKVJOODJBOh+k
	2lYv4LuiZ6Rl3fwh+b+ErZmXzHQUoRFVfv9Pogn/hasKg7wwHKnfiFjcjJwbJPFbpOkBds
	nMnjSFGoQaORTLIWSQ8BCiEJ4GvgF50=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-152-eRO5V1PWO2ysRFZJIgC9aA-1; Tue,
 29 Apr 2025 12:37:39 -0400
X-MC-Unique: eRO5V1PWO2ysRFZJIgC9aA-1
X-Mimecast-MFC-AGG-ID: eRO5V1PWO2ysRFZJIgC9aA_1745944657
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6F24F1800EC9;
	Tue, 29 Apr 2025 16:37:36 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.188])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9F810180047F;
	Tue, 29 Apr 2025 16:37:32 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
    Christian Brauner <brauner@kernel.org>
cc: dhowells@redhat.com,
    Etienne Champetier <champetier.etienne@gmail.com>,
    Marc Dionne <marc.dionne@auristor.com>,
    Jeffrey Altman <jaltman@auristor.com>,
    Chet Ramey <chet.ramey@case.edu>, Steve French <sfrench@samba.org>,
    linux-afs@lists.infradead.org, openafs-devel@openafs.org,
    linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] afs, bash: Fix open(O_CREAT) on an extant AFS file in a sticky dir
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <433927.1745944651.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Apr 2025 17:37:31 +0100
Message-ID: <433928.1745944651@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

    =

Bash has a work around in redir_open() that causes open(O_CREAT) of a file
in a sticky directory to be retried without O_CREAT if bash was built with
AFS workarounds configured:

        #if defined (AFS)
              if ((fd < 0) && (errno =3D=3D EACCES))
            {
              fd =3D open (filename, flags & ~O_CREAT, mode);
              errno =3D EACCES;    /* restore errno */
            }

        #endif /* AFS */

This works around the kernel not being able to validly check the
current_fsuid() against i_uid on the file or the directory because the
uidspaces of the system and of AFS may well be disjoint.  The problem lies
with the uid checks in may_create_in_sticky().

However, the bash work around is going to be removed:

        https://git.savannah.gnu.org/cgit/bash.git/tree/redir.c?h=3Dbash-5=
.3-rc1#n733

Fix this in the kernel by:

 (1) Provide an ->is_owned_by_me() inode op, similar to ->permission(),
     and, if provided, call that to determine if the caller owns the file
     instead of checking the i_uid to current_fsuid().

 (2) Provide a ->have_same_owner() inode op, that, if provided, can be
     called to see if an inode has the same owner as the parent on the pat=
h
     walked.

For kafs, use the first hook to check to see if the server indicated the
ADMINISTER bit in the access rights returned by the FS.FetchStatus and
suchlike and the second hook to compare the AFS user IDs retrieved by
FS.FetchStatus (which may not fit in a kuid if AuriStor's YFS variant).

This can be tested by creating a sticky directory (the user must have a
token to do this) and creating a file in it.  Then strace bash doing "echo
foo >>file" and look at whether bash does a single, successful O_CREAT ope=
n
on the file or whether that one fails and then bash does one without
O_CREAT that succeeds.

Reported-by: Etienne Champetier <champetier.etienne@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeffrey Altman <jaltman@auristor.com>
cc: Chet Ramey <chet.ramey@case.edu>
cc: Alexander Viro <viro@zeniv.linux.org.uk>
cc: Christian Brauner <brauner@kernel.org>
cc: Steve French <sfrench@samba.org>
cc: linux-afs@lists.infradead.org
cc: openafs-devel@openafs.org
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/afs/dir.c       |    2 ++
 fs/afs/file.c      |    2 ++
 fs/afs/internal.h  |    3 +++
 fs/afs/security.c  |   52 +++++++++++++++++++++++++++++++++++++++++++++++=
+++++
 fs/namei.c         |   22 ++++++++++++++++++----
 include/linux/fs.h |    3 +++
 6 files changed, 80 insertions(+), 4 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 9e7b1fe82c27..6360db1673b0 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -65,6 +65,8 @@ const struct inode_operations afs_dir_inode_operations =3D=
 {
 	.permission	=3D afs_permission,
 	.getattr	=3D afs_getattr,
 	.setattr	=3D afs_setattr,
+	.is_owned_by_me	=3D afs_is_owned_by_me,
+	.have_same_owner =3D afs_have_same_owner,
 };
 =

 const struct address_space_operations afs_dir_aops =3D {
diff --git a/fs/afs/file.c b/fs/afs/file.c
index fc15497608c6..0317f0a36cf2 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -47,6 +47,8 @@ const struct inode_operations afs_file_inode_operations =
=3D {
 	.getattr	=3D afs_getattr,
 	.setattr	=3D afs_setattr,
 	.permission	=3D afs_permission,
+	.is_owned_by_me	=3D afs_is_owned_by_me,
+	.have_same_owner =3D afs_have_same_owner,
 };
 =

 const struct address_space_operations afs_file_aops =3D {
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 440b0e731093..fbfbf615abe3 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1495,6 +1495,9 @@ extern struct key *afs_request_key(struct afs_cell *=
);
 extern struct key *afs_request_key_rcu(struct afs_cell *);
 extern int afs_check_permit(struct afs_vnode *, struct key *, afs_access_=
t *);
 extern int afs_permission(struct mnt_idmap *, struct inode *, int);
+int afs_is_owned_by_me(struct mnt_idmap *idmap, struct inode *inode);
+int afs_have_same_owner(struct mnt_idmap *idmap, struct inode *inode,
+			struct dentry *dentry);
 extern void __exit afs_clean_up_permit_cache(void);
 =

 /*
diff --git a/fs/afs/security.c b/fs/afs/security.c
index 6a7744c9e2a2..cc9689fbed47 100644
--- a/fs/afs/security.c
+++ b/fs/afs/security.c
@@ -477,6 +477,58 @@ int afs_permission(struct mnt_idmap *idmap, struct in=
ode *inode,
 	return ret;
 }
 =

+/*
+ * Determine if an inode is owned by 'me' - whatever that means for the
+ * filesystem.  In the case of AFS, this means that the file is owned by =
the
+ * AFS user represented by the token (e.g. from a kerberos server) held i=
n a
+ * key.  Returns 0 if owned by me, 1 if not; can also return an error.
+ */
+int afs_is_owned_by_me(struct mnt_idmap *idmap, struct inode *inode)
+{
+	struct afs_vnode *vnode =3D AFS_FS_I(inode);
+	afs_access_t access;
+	struct key *key;
+	int ret;
+
+	key =3D afs_request_key(vnode->volume->cell);
+	if (IS_ERR(key))
+		return PTR_ERR(key);
+
+	/* Get the access rights for the key on this file. */
+	ret =3D afs_check_permit(vnode, key, &access);
+	if (ret < 0)
+		goto error;
+
+	/* We get the ADMINISTER bit if we own the file. */
+	ret =3D (access & AFS_ACE_ADMINISTER) ? 0 : 1;
+error:
+	key_put(key);
+	return ret;
+}
+
+/*
+ * Determine if a file has the same owner as its parent - whatever that m=
eans
+ * for the filesystem.  In the case of AFS, this means comparing their AF=
S
+ * UIDs.  Returns 0 if same, 1 if not same; can also return an error.
+ */
+int afs_have_same_owner(struct mnt_idmap *idmap, struct inode *inode,
+			struct dentry *dentry)
+{
+	struct afs_vnode *vnode =3D AFS_FS_I(inode);
+	struct dentry *parent;
+	s64 owner;
+
+	/* Get the owner's ID for the directory.  Ideally, we'd use RCU to
+	 * access the parent rather than getting a ref.
+	 */
+	parent =3D dget_parent(dentry);
+	vnode =3D AFS_FS_I(d_backing_inode(parent));
+	owner =3D vnode->status.owner;
+	dput(parent);
+
+	return vnode->status.owner !=3D owner;
+}
+
 void __exit afs_clean_up_permit_cache(void)
 {
 	int i;
diff --git a/fs/namei.c b/fs/namei.c
index 84a0e0b0111c..79e8ef1b6900 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1318,11 +1318,25 @@ static int may_create_in_sticky(struct mnt_idmap *=
idmap, struct nameidata *nd,
 =

 	i_vfsuid =3D i_uid_into_vfsuid(idmap, inode);
 =

-	if (vfsuid_eq(i_vfsuid, dir_vfsuid))
-		return 0;
+	if (unlikely(inode->i_op->have_same_owner)) {
+		int ret =3D inode->i_op->have_same_owner(idmap, inode, nd->path.dentry)=
;
 =

-	if (vfsuid_eq_kuid(i_vfsuid, current_fsuid()))
-		return 0;
+		if (ret <=3D 0)
+			return ret;
+	} else {
+		if (vfsuid_eq(i_vfsuid, dir_vfsuid))
+			return 0;
+	}
+
+	if (unlikely(inode->i_op->is_owned_by_me)) {
+		int ret =3D inode->i_op->is_owned_by_me(idmap, inode);
+
+		if (ret <=3D 0)
+			return ret;
+	} else {
+		if (vfsuid_eq_kuid(i_vfsuid, current_fsuid()))
+			return 0;
+	}
 =

 	if (likely(dir_mode & 0002)) {
 		audit_log_path_denied(AUDIT_ANOM_CREAT, "sticky_create");
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 016b0fe1536e..ec278d2d362a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2236,6 +2236,9 @@ struct inode_operations {
 			    struct dentry *dentry, struct fileattr *fa);
 	int (*fileattr_get)(struct dentry *dentry, struct fileattr *fa);
 	struct offset_ctx *(*get_offset_ctx)(struct inode *inode);
+	int (*is_owned_by_me)(struct mnt_idmap *idmap, struct inode *inode);
+	int (*have_same_owner)(struct mnt_idmap *idmap, struct inode *inode,
+			       struct dentry *dentry);
 } ____cacheline_aligned;
 =

 static inline int call_mmap(struct file *file, struct vm_area_struct *vma=
)


