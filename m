Return-Path: <linux-fsdevel+bounces-48740-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A7EAB3805
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 15:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84F7A3BEC99
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 13:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8AA293B72;
	Mon, 12 May 2025 13:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fvcSHSeN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80416292923
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 May 2025 13:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747054991; cv=none; b=cWY0qFbEev5CcHhs2urtDZ4OjCFkiEtUbCPIJGeKGm0t5iysNOmSCMHCafNlAUStn70cxSFm0+nK/3XBlSl0CyS8tEUjEXB4NPt4tV7LeDHw6kRgxIcD5pF2iQ9NiljIyEVBwlBfdj866JF2ZUyWJaJIzZQLTTM20W9R//z2fA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747054991; c=relaxed/simple;
	bh=1WUEWHEolQwC8720ZZECWxHjReWB0vujNXYAmpR1iCc=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=HVGymZgOaBhNn8A/dJeXK65deCp3vp4cOguMKcy8Ni+smHQvK+p5nqccSdaHg5qEAUm8pqs9CIf8PBBTf+MJHGGZd1zzjbzfsT0WsoYpbNE348v7os0iN3fO0afIGHYIL4G2VViEoqFCM57A0bCQmnG5ZVW8S332Mfj0rfc8o+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fvcSHSeN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747054988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rHw3xY0JnT4h9Q3NaKNlwMtkuyY4mD1BTf/wtxHKiQk=;
	b=fvcSHSeNNbzI3IxXwlzkFHJv4cHVEtfAdpFEv1AY3eqdx7vvdXlyrm66u9SnfP8bZCQZ3W
	oCkT9waTs81caxBRhs5Mryycoq2YrGuMtoVs/h8Q6mHKNvnzLCA5mEXvWQtn2k9rZALHZ9
	LAoWHz39jWvOX2ECpjr2MEZhvJW8WsM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-620-wCVkiRG3N6Cctfq4p2e1Lg-1; Mon,
 12 May 2025 09:02:54 -0400
X-MC-Unique: wCVkiRG3N6Cctfq4p2e1Lg-1
X-Mimecast-MFC-AGG-ID: wCVkiRG3N6Cctfq4p2e1Lg_1747054966
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CB4CA180048E;
	Mon, 12 May 2025 13:02:42 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.188])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ED1C81956095;
	Mon, 12 May 2025 13:02:38 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250509-deckung-glitschig-8d27cb12f09f@brauner>
References: <20250509-deckung-glitschig-8d27cb12f09f@brauner> <20250505-erproben-zeltlager-4c16f07b96ae@brauner> <433928.1745944651@warthog.procyon.org.uk> <1209711.1746527190@warthog.procyon.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: dhowells@redhat.com, Alexander Viro <viro@zeniv.linux.org.uk>,
    Etienne Champetier <champetier.etienne@gmail.com>,
    Marc Dionne <marc.dionne@auristor.com>,
    Jeffrey Altman <jaltman@auristor.com>,
    Chet Ramey <chet.ramey@case.edu>, Steve French <sfrench@samba.org>,
    linux-afs@lists.infradead.org, openafs-devel@openafs.org,
    linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH v2] afs, bash: Fix open(O_CREAT) on an extant AFS file in a sticky dir
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2086611.1747054957.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 May 2025 14:02:37 +0100
Message-ID: <2086612.1747054957@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Christian Brauner <brauner@kernel.org> wrote:

> > Now, in my patch, I added two inode ops because they VFS code involved=
 makes
> > two distinct evaluations and so I made an op for each and, as such, th=
ose
> > evaluations may be applicable elsewhere, but I could make a combined o=
p that
> > handles that specific situation instead.
> =

> Try to make it one, please.

Okay, see attached.

David
----
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

Fix this in the kernel by providing a ->may_create_in_sticky() inode op,
similar to ->permission(), that, if provided, is called to:

 (1) see if an inode has the same owner as the parent on the path walked;

 (2) determine if the caller owns the file instead of checking the i_uid t=
o
     current_fsuid().

For kafs, the hook is implemented to see if:

 (1) the AFS owner IDs retrieved on the file and its parent directory by
     FS.FetchStatus match;

 (2) if the server set the ADMINISTER bit in the access rights returned by
     the FS.FetchStatus and suchlike for the key, indicating ownership by
     the user specified by the key.

(Note that the owner IDs retrieved from an AuriStor YFS server may not fit
in the kuid_t being 64-bit, so they need comparing directly).

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
 fs/afs/dir.c       |    1 +
 fs/afs/file.c      |    1 +
 fs/afs/internal.h  |    2 ++
 fs/afs/security.c  |   52 +++++++++++++++++++++++++++++++++++++++++++++++=
+++++
 fs/namei.c         |   17 ++++++++++++-----
 include/linux/fs.h |    2 ++
 6 files changed, 70 insertions(+), 5 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 9e7b1fe82c27..27e565612bde 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -65,6 +65,7 @@ const struct inode_operations afs_dir_inode_operations =3D=
 {
 	.permission	=3D afs_permission,
 	.getattr	=3D afs_getattr,
 	.setattr	=3D afs_setattr,
+	.may_create_in_sticky =3D afs_may_create_in_sticky,
 };
 =

 const struct address_space_operations afs_dir_aops =3D {
diff --git a/fs/afs/file.c b/fs/afs/file.c
index fc15497608c6..dff48d0adec3 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -47,6 +47,7 @@ const struct inode_operations afs_file_inode_operations =
=3D {
 	.getattr	=3D afs_getattr,
 	.setattr	=3D afs_setattr,
 	.permission	=3D afs_permission,
+	.may_create_in_sticky =3D afs_may_create_in_sticky,
 };
 =

 const struct address_space_operations afs_file_aops =3D {
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 440b0e731093..4a5bb01606a8 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1495,6 +1495,8 @@ extern struct key *afs_request_key(struct afs_cell *=
);
 extern struct key *afs_request_key_rcu(struct afs_cell *);
 extern int afs_check_permit(struct afs_vnode *, struct key *, afs_access_=
t *);
 extern int afs_permission(struct mnt_idmap *, struct inode *, int);
+int afs_may_create_in_sticky(struct mnt_idmap *idmap, struct inode *inode=
,
+			     struct path *path);
 extern void __exit afs_clean_up_permit_cache(void);
 =

 /*
diff --git a/fs/afs/security.c b/fs/afs/security.c
index 6a7744c9e2a2..9fd6e4b5c228 100644
--- a/fs/afs/security.c
+++ b/fs/afs/security.c
@@ -477,6 +477,58 @@ int afs_permission(struct mnt_idmap *idmap, struct in=
ode *inode,
 	return ret;
 }
 =

+/*
+ * Perform the ownership checks for a file in a sticky directory on AFS.
+ *
+ * In the case of AFS, this means that:
+ *
+ * (1) the file and the directory have the same AFS ownership or
+ *
+ * (2) the file is owned by the AFS user represented by the token (e.g. f=
rom a
+ *     kerberos server) held in a key.
+ *
+ * Returns 0 if owned by me or has same owner as parent dir, 1 if not; ca=
n also
+ * return an error.
+ */
+int afs_may_create_in_sticky(struct mnt_idmap *idmap, struct inode *inode=
,
+			     struct path *path)
+{
+	struct afs_vnode *dvnode, *vnode =3D AFS_FS_I(inode);
+	struct dentry *parent;
+	struct key *key;
+	afs_access_t access;
+	int ret;
+	s64 owner;
+
+	key =3D afs_request_key(vnode->volume->cell);
+	if (IS_ERR(key))
+		return PTR_ERR(key);
+
+	/* Get the owner's ID for the directory.  Ideally, we'd use RCU to
+	 * access the parent rather than getting a ref.
+	 */
+	parent =3D dget_parent(path->dentry);
+	dvnode =3D AFS_FS_I(d_backing_inode(parent));
+	owner =3D dvnode->status.owner;
+	dput(parent);
+
+	if (vnode->status.owner =3D=3D owner) {
+		ret =3D 0;
+		goto error;
+	}
+
+	/* Get the access rights for the key on this file. */
+	ret =3D afs_check_permit(vnode, key, &access);
+	if (ret < 0)
+		goto error;
+
+	/* We get the ADMINISTER bit if we own the file. */
+	ret =3D (access & AFS_ACE_ADMINISTER) ? 1 : 0;
+error:
+	key_put(key);
+	return ret;
+}
+
 void __exit afs_clean_up_permit_cache(void)
 {
 	int i;
diff --git a/fs/namei.c b/fs/namei.c
index 84a0e0b0111c..e52c91cbed2a 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1316,13 +1316,20 @@ static int may_create_in_sticky(struct mnt_idmap *=
idmap, struct nameidata *nd,
 	if (S_ISFIFO(inode->i_mode) && !sysctl_protected_fifos)
 		return 0;
 =

-	i_vfsuid =3D i_uid_into_vfsuid(idmap, inode);
+	if (unlikely(inode->i_op->may_create_in_sticky)) {
+		int ret =3D inode->i_op->may_create_in_sticky(idmap, inode, &nd->path);
 =

-	if (vfsuid_eq(i_vfsuid, dir_vfsuid))
-		return 0;
+		if (ret <=3D 0) /* 1 if not owned by me or by parent dir. */
+			return ret;
+	} else {
+		i_vfsuid =3D i_uid_into_vfsuid(idmap, inode);
 =

-	if (vfsuid_eq_kuid(i_vfsuid, current_fsuid()))
-		return 0;
+		if (vfsuid_eq(i_vfsuid, dir_vfsuid))
+			return 0;
+
+		if (vfsuid_eq_kuid(i_vfsuid, current_fsuid()))
+			return 0;
+	}
 =

 	if (likely(dir_mode & 0002)) {
 		audit_log_path_denied(AUDIT_ANOM_CREAT, "sticky_create");
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 016b0fe1536e..11122e169719 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2236,6 +2236,8 @@ struct inode_operations {
 			    struct dentry *dentry, struct fileattr *fa);
 	int (*fileattr_get)(struct dentry *dentry, struct fileattr *fa);
 	struct offset_ctx *(*get_offset_ctx)(struct inode *inode);
+	int (*may_create_in_sticky)(struct mnt_idmap *idmap, struct inode *inode=
,
+				    struct path *path);
 } ____cacheline_aligned;
 =

 static inline int call_mmap(struct file *file, struct vm_area_struct *vma=
)


