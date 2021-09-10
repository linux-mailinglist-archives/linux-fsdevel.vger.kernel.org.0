Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEC8406A66
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Sep 2021 12:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbhIJKzy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Sep 2021 06:55:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27878 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232513AbhIJKzy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Sep 2021 06:55:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631271282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Rp5Lxa5h9ZVQAdx0fPblnQhNdn9SeHUlbTUr8Itj62s=;
        b=XroW+o+3Ivz1YqsxeRmvlUGd0P1UOs9wnOR1dfLhTmh59KQnc0W4me+Xe6JeubXh6CZajo
        TND0lNoxgVvbRn4jolEjlnW8KCYEwURfkB1z9aOHHalkYYxQYAamZS2uRM4BntfulvRs+b
        yLkisO9GFcrzMW2oDHV1vTKfGV+JzkI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-549-MXUVxTCSMU-xK9Kf36QZDA-1; Fri, 10 Sep 2021 06:54:41 -0400
X-MC-Unique: MXUVxTCSMU-xK9Kf36QZDA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 834931006AA0;
        Fri, 10 Sep 2021 10:54:39 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2348B10016FE;
        Fri, 10 Sep 2021 10:54:36 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
cc:     dhowells@redhat.com, torvalds@linux-foundation.org, hch@lst.de,
        linux-fsdevel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] vfs, afs: Pass the file from fstat()/statx() to the fs for auth purposes
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <826634.1631271276.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 10 Sep 2021 11:54:36 +0100
Message-ID: <826635.1631271276@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

    =

read(), write() and ftruncate() all have the file available from which the=
y
can extract the information needed to perform authenticated operations to =
a
network filesystem server for that filesystem, but fstat() and statx() do
not.

This could lead to the situation where a read(), say, on a file descriptor
will work, but fstat() will fail because the calling process doesn't
intrinsically have the right to do that.

Change this by passing the file, if we have it, in struct kstat from which
the filesystem can pick it up and use it, similar to the way ftruncate()
passes the information in struct iattr.

Make use of this in the afs filesystem to pass to validation in case we
need to refetch the inode attributes from the server.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Alexander Viro <viro@zeniv.linux.org.uk>
cc: linux-fsdevel@vger.kernel.org
cc: linux-afs@lists.infradead.org
---
 fs/afs/inode.c       |   10 ++++++++-
 fs/exportfs/expfs.c  |    2 -
 fs/stat.c            |   56 ++++++++++++++++++++++++++++++++++++++-------=
------
 include/linux/fs.h   |    3 +-
 include/linux/stat.h |    1 =

 5 files changed, 55 insertions(+), 17 deletions(-)

diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 8fcffea2daf5..7d732a38c739 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -670,6 +670,9 @@ int afs_validate(struct afs_vnode *vnode, struct key *=
key)
 	       vnode->fid.vid, vnode->fid.vnode, vnode->flags,
 	       key_serial(key));
 =

+	if (!vnode->volume)
+		goto valid; /* Dynroot */
+
 	if (unlikely(test_bit(AFS_VNODE_DELETED, &vnode->flags))) {
 		if (vnode->vfs_inode.i_nlink)
 			clear_nlink(&vnode->vfs_inode);
@@ -728,10 +731,15 @@ int afs_getattr(struct user_namespace *mnt_userns, c=
onst struct path *path,
 {
 	struct inode *inode =3D d_inode(path->dentry);
 	struct afs_vnode *vnode =3D AFS_FS_I(inode);
-	int seq =3D 0;
+	struct afs_file *af =3D stat->file ? stat->file->private_data : NULL;
+	int ret, seq =3D 0;
 =

 	_enter("{ ino=3D%lu v=3D%u }", inode->i_ino, inode->i_generation);
 =

+	ret =3D afs_validate(vnode, af ? af->key : NULL);
+	if (ret < 0)
+		return ret;
+
 	do {
 		read_seqbegin_or_lock(&vnode->cb_lock, &seq);
 		generic_fillattr(&init_user_ns, inode, stat);
diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
index 0106eba46d5a..d3fba1aea432 100644
--- a/fs/exportfs/expfs.c
+++ b/fs/exportfs/expfs.c
@@ -303,7 +303,7 @@ static int get_name(const struct path *path, char *nam=
e, struct dentry *child)
 	 * actually call ->getattr, not just read i_ino:
 	 */
 	error =3D vfs_getattr_nosec(&child_path, &stat,
-				  STATX_INO, AT_STATX_SYNC_AS_STAT);
+				  STATX_INO, AT_STATX_SYNC_AS_STAT, NULL);
 	if (error)
 		return error;
 	buffer.ino =3D stat.ino;
diff --git a/fs/stat.c b/fs/stat.c
index 1fa38bdec1a6..c3410e809b4d 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -65,6 +65,7 @@ EXPORT_SYMBOL(generic_fillattr);
  * @stat: structure to return attributes in
  * @request_mask: STATX_xxx flags indicating what the caller wants
  * @query_flags: Query mode (AT_STATX_SYNC_TYPE)
+ * @file: File with credential info or NULL
  *
  * Get attributes without calling security_inode_getattr.
  *
@@ -73,12 +74,14 @@ EXPORT_SYMBOL(generic_fillattr);
  * attributes to any user.  Any other code probably wants vfs_getattr.
  */
 int vfs_getattr_nosec(const struct path *path, struct kstat *stat,
-		      u32 request_mask, unsigned int query_flags)
+		      u32 request_mask, unsigned int query_flags,
+		      struct file *file)
 {
 	struct user_namespace *mnt_userns;
 	struct inode *inode =3D d_backing_inode(path->dentry);
 =

 	memset(stat, 0, sizeof(*stat));
+	stat->file =3D file;
 	stat->result_mask |=3D STATX_BASIC_STATS;
 	query_flags &=3D AT_STATX_SYNC_TYPE;
 =

@@ -139,7 +142,7 @@ int vfs_getattr(const struct path *path, struct kstat =
*stat,
 	retval =3D security_inode_getattr(path);
 	if (retval)
 		return retval;
-	return vfs_getattr_nosec(path, stat, request_mask, query_flags);
+	return vfs_getattr_nosec(path, stat, request_mask, query_flags, NULL);
 }
 EXPORT_SYMBOL(vfs_getattr);
 =

@@ -161,7 +164,11 @@ int vfs_fstat(int fd, struct kstat *stat)
 	f =3D fdget_raw(fd);
 	if (!f.file)
 		return -EBADF;
-	error =3D vfs_getattr(&f.file->f_path, stat, STATX_BASIC_STATS, 0);
+
+	error =3D security_inode_getattr(&f.file->f_path);
+	if (!error)
+		error =3D vfs_getattr_nosec(&f.file->f_path, stat,
+					  STATX_BASIC_STATS, 0, f.file);
 	fdput(f);
 	return error;
 }
@@ -185,7 +192,9 @@ static int vfs_statx(int dfd, const char __user *filen=
ame, int flags,
 	      struct kstat *stat, u32 request_mask)
 {
 	struct path path;
+	struct fd f;
 	unsigned lookup_flags =3D 0;
+	bool put_fd =3D false;
 	int error;
 =

 	if (flags & ~(AT_SYMLINK_NOFOLLOW | AT_NO_AUTOMOUNT | AT_EMPTY_PATH |
@@ -200,17 +209,36 @@ static int vfs_statx(int dfd, const char __user *fil=
ename, int flags,
 		lookup_flags |=3D LOOKUP_EMPTY;
 =

 retry:
-	error =3D user_path_at(dfd, filename, lookup_flags, &path);
-	if (error)
-		goto out;
-
-	error =3D vfs_getattr(&path, stat, request_mask, flags);
-	stat->mnt_id =3D real_mount(path.mnt)->mnt_id;
-	stat->result_mask |=3D STATX_MNT_ID;
-	if (path.mnt->mnt_root =3D=3D path.dentry)
-		stat->attributes |=3D STATX_ATTR_MOUNT_ROOT;
-	stat->attributes_mask |=3D STATX_ATTR_MOUNT_ROOT;
-	path_put(&path);
+	if ((lookup_flags & LOOKUP_EMPTY) &&
+	    dfd >=3D 0 &&
+	    filename &&
+	    strnlen_user(filename, 2) =3D=3D 0) {
+		/* Should we use ESTALE retry for direct-fd? */
+		f =3D fdget_raw(dfd);
+		if (!f.file)
+			return -EBADF;
+		path =3D f.file->f_path;
+		put_fd =3D true;
+	} else {
+		f.file =3D NULL;
+		error =3D user_path_at(dfd, filename, lookup_flags, &path);
+		if (error)
+			goto out;
+	}
+
+	error =3D security_inode_getattr(&path);
+	if (!error) {
+		error =3D vfs_getattr_nosec(&path, stat, request_mask, flags, f.file);
+		stat->mnt_id =3D real_mount(path.mnt)->mnt_id;
+		stat->result_mask |=3D STATX_MNT_ID;
+		if (path.mnt->mnt_root =3D=3D path.dentry)
+			stat->attributes |=3D STATX_ATTR_MOUNT_ROOT;
+		stat->attributes_mask |=3D STATX_ATTR_MOUNT_ROOT;
+	}
+	if (put_fd)
+		fdput(f);
+	else
+		path_put(&path);
 	if (retry_estale(error, lookup_flags)) {
 		lookup_flags |=3D LOOKUP_REVAL;
 		goto retry;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c58c2611a195..3f31f739f9a6 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3312,7 +3312,8 @@ extern int page_symlink(struct inode *inode, const c=
har *symname, int len);
 extern const struct inode_operations page_symlink_inode_operations;
 extern void kfree_link(void *);
 void generic_fillattr(struct user_namespace *, struct inode *, struct kst=
at *);
-extern int vfs_getattr_nosec(const struct path *, struct kstat *, u32, un=
signed int);
+extern int vfs_getattr_nosec(const struct path *, struct kstat *, u32, un=
signed int,
+			     struct file *);
 extern int vfs_getattr(const struct path *, struct kstat *, u32, unsigned=
 int);
 void __inode_add_bytes(struct inode *inode, loff_t bytes);
 void inode_add_bytes(struct inode *inode, loff_t bytes);
diff --git a/include/linux/stat.h b/include/linux/stat.h
index fff27e603814..b9986688cc59 100644
--- a/include/linux/stat.h
+++ b/include/linux/stat.h
@@ -20,6 +20,7 @@
 #include <linux/uidgid.h>
 =

 struct kstat {
+	struct file	*file;		/* File if called from fstat() equivalent or NULL */
 	u32		result_mask;	/* What fields the user got */
 	umode_t		mode;
 	unsigned int	nlink;

