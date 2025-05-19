Return-Path: <linux-fsdevel+bounces-49433-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F23CCABC417
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 18:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 886053A8DD4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 16:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6B5289804;
	Mon, 19 May 2025 16:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QQEbWKXh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD4128980D
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 May 2025 16:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747671119; cv=none; b=by+aKxoofWWYtAm7+9X/5s1iEzLgzxmKE76mmIZhZMpbnDUAM0sFXhgijdrUFf2Sq+mlJRivRKnwtVeRjVkOI332Rc8TqoXKw/URj6Tatwpggs2CgtZb5+sMvXEylyss4892dewjuGx7EAvAoBNas2PFg/QZ/zw4CXADCKFimP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747671119; c=relaxed/simple;
	bh=qdUEjr0o3Loh5jJb54EHdWN7nxxaG+JTaVGIjKDdt6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uR7R1CYVsSyYtwcA1DkI8wKWxL8PayQtkQElzLFaQY8UOyl6PjHu0mz7sYQhUBkbInNw0in4fJmDQH8G6DnvbcOvJL9EH9hSQG1yjWPwGYUbue/Xx+Ez/PcRvdgfbf4PENg5DkPIYArZI4LL2TqY8LE/XPXfM453RSbLeciH8QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QQEbWKXh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747671115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UKCLX6wUxa17ZeR6w14OcNdKezZe2LB8Wh0QVRX/Q1o=;
	b=QQEbWKXhmIImuwyg/FECF4DfP85T3hAo+M/vpqbPHmOlJ2DqDv5qhBO73ajLiaykvtREnj
	+NDsT+CWB0NtqiBOWMVByKLhtjhPD0V9z6jTiLAX6iJUGUhOcllx5u8FZv5DnFm0fA045X
	b1MXZ4BpVP3IMEF0OfaTLEYYe55FQqo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-dAhIxSivP-2MC3fpxUnfHA-1; Mon,
 19 May 2025 12:11:51 -0400
X-MC-Unique: dAhIxSivP-2MC3fpxUnfHA-1
X-Mimecast-MFC-AGG-ID: dAhIxSivP-2MC3fpxUnfHA_1747671108
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7E5841800360;
	Mon, 19 May 2025 16:11:47 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.188])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 36B0B1956095;
	Mon, 19 May 2025 16:11:43 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Etienne Champetier <champetier.etienne@gmail.com>,
	Jeffrey Altman <jaltman@auristor.com>,
	Chet Ramey <chet.ramey@case.edu>,
	Cheyenne Wills <cwills@sinenomine.net>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Steve French <sfrench@samba.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	openafs-devel@openafs.org,
	linux-cifs@vger.kernel.org,
	linux-integrity@vger.kernel.org
Subject: [PATCH 2/2] vfs: Fix inode ownership checks with regard to foreign ownership
Date: Mon, 19 May 2025 17:11:23 +0100
Message-ID: <20250519161125.2981681-3-dhowells@redhat.com>
In-Reply-To: <20250519161125.2981681-1-dhowells@redhat.com>
References: <20250519161125.2981681-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Fix a number of ownership checks made by the VFS that assume that
inode->i_uid is meaningful with respect to the UID space of the system
performing the check.  Network filesystems, however, may violate this
assumption - and, indeed, a network filesystem may not even have an actual
concept of a UNIX integer UID (cifs, for example).

There are a number of places within the VFS where UID checks are made and
some of these should be deferring the interpretation to the filesystem by
way of the previously added vfs_inode_is_owned_by_me() and
vfs_inodes_have_same_owner():

 (*) chown_ok()
 (*) chgrp_ok()

     These should call vfs_inode_is_owned_by_me().  Possibly these need to
     defer all their checks to the network filesystem as the interpretation
     of the new UID/GID depends on the netfs too, but the ->setattr()
     method gets a chance to deal with that.

 (*) do_coredump()

     Should probably call vfs_is_owned_by_me() to check that the file
     created is owned by the caller - but the check that's there might be
     sufficient.

 (*) inode_owner_or_capable()

     Should call vfs_is_owned_by_me().  I'm not sure whether the namespace
     mapping makes sense in such a case, but it probably could be used.

 (*) vfs_setlease()

     Should call vfs_is_owned_by_me().  Actually, it should query if
     leasing is permitted.

     Also, setting locks could perhaps do with a permission call to the
     filesystem driver as AFS, for example, has a lock permission bit in
     the ACL, but since the AFS server checks that when the RPC call is
     made, it's probably unnecessary.

 (*) acl_permission_check()
 (*) posix_acl_permission()

     These functions are only used by generic_permission() which is
     overridden if ->permission() is supplied, and when evaluating a POSIX
     ACL, it should arguably be checking the UID anyway.

     AFS, for example, implements its own ACLs and evaluates them in
     ->permission() and on the server.

 (*) may_follow_link()

     Should call vfs_is_owned_by_me() and also vfs_have_same_owner() on the
     the link and its parent dir.  The latter only applies on
     world-writable sticky dirs.

 (*) may_create_in_sticky()

     The initial subject of this patch.  Should call vfs_is_owned_by_me()
     and also vfs_have_same_owner() both.

 (*) __check_sticky()

     Should call vfs_is_owned_by_me() on both the dir and the inode.

 (*) may_dedupe_file()

     Should call vfs_is_owned_by_me().

 (*) IMA policy ops.

     I'm not sure what the best way to deal with this is - if, indeed, it
     needs any changes.

Note that wrapping stuff up into vfs_inode_is_owned_by_me() isn't
necessarily the most efficient as it means we may end up doing the uid
idmapping an extra time - though mostly this is in places where I'm not
sure it matters so much.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Etienne Champetier <champetier.etienne@gmail.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeffrey Altman <jaltman@auristor.com>
cc: Chet Ramey <chet.ramey@case.edu>
cc: Cheyenne Wills <cwills@sinenomine.net>
cc: Alexander Viro <viro@zeniv.linux.org.uk>
cc: Christian Brauner <brauner@kernel.org>
cc: Steve French <sfrench@samba.org>
cc: Mimi Zohar <zohar@linux.ibm.com>
cc: linux-afs@lists.infradead.org
cc: openafs-devel@openafs.org
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-integrity@vger.kernel.org
Link: https://groups.google.com/g/gnu.bash.bug/c/6PPTfOgFdL4/m/2AQU-S1N76UJ
Link: https://git.savannah.gnu.org/cgit/bash.git/tree/redir.c?h=bash-5.3-rc1#n733
---
 fs/attr.c        | 58 +++++++++++++++++++++++++++++-------------------
 fs/coredump.c    |  3 +--
 fs/inode.c       |  8 +++++--
 fs/locks.c       |  7 ++++--
 fs/namei.c       | 30 +++++++++++++------------
 fs/remap_range.c | 20 +++++++++--------
 6 files changed, 74 insertions(+), 52 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index 9caf63d20d03..fefd92af56a2 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -16,6 +16,7 @@
 #include <linux/fcntl.h>
 #include <linux/filelock.h>
 #include <linux/security.h>
+#include "internal.h"
 
 /**
  * setattr_should_drop_sgid - determine whether the setgid bit needs to be
@@ -91,19 +92,21 @@ EXPORT_SYMBOL(setattr_should_drop_suidgid);
  * permissions. On non-idmapped mounts or if permission checking is to be
  * performed on the raw inode simply pass @nop_mnt_idmap.
  */
-static bool chown_ok(struct mnt_idmap *idmap,
-		     const struct inode *inode, vfsuid_t ia_vfsuid)
+static int chown_ok(struct mnt_idmap *idmap,
+		    const struct inode *inode, vfsuid_t ia_vfsuid)
 {
 	vfsuid_t vfsuid = i_uid_into_vfsuid(idmap, inode);
-	if (vfsuid_eq_kuid(vfsuid, current_fsuid()) &&
-	    vfsuid_eq(ia_vfsuid, vfsuid))
-		return true;
+	int ret;
+
+	ret = vfs_inode_is_owned_by_me(idmap, inode);
+	if (ret <= 0)
+		return ret;
 	if (capable_wrt_inode_uidgid(idmap, inode, CAP_CHOWN))
-		return true;
+		return 0;
 	if (!vfsuid_valid(vfsuid) &&
 	    ns_capable(inode->i_sb->s_user_ns, CAP_CHOWN))
-		return true;
-	return false;
+		return 0;
+	return -EPERM;
 }
 
 /**
@@ -118,23 +121,27 @@ static bool chown_ok(struct mnt_idmap *idmap,
  * permissions. On non-idmapped mounts or if permission checking is to be
  * performed on the raw inode simply pass @nop_mnt_idmap.
  */
-static bool chgrp_ok(struct mnt_idmap *idmap,
-		     const struct inode *inode, vfsgid_t ia_vfsgid)
+static int chgrp_ok(struct mnt_idmap *idmap,
+		    const struct inode *inode, vfsgid_t ia_vfsgid)
 {
 	vfsgid_t vfsgid = i_gid_into_vfsgid(idmap, inode);
-	vfsuid_t vfsuid = i_uid_into_vfsuid(idmap, inode);
-	if (vfsuid_eq_kuid(vfsuid, current_fsuid())) {
+	int ret;
+
+	ret = vfs_inode_is_owned_by_me(idmap, inode);
+	if (ret < 0)
+		return ret;
+	if (ret == 0) {
 		if (vfsgid_eq(ia_vfsgid, vfsgid))
-			return true;
+			return 0;
 		if (vfsgid_in_group_p(ia_vfsgid))
-			return true;
+			return 0;
 	}
 	if (capable_wrt_inode_uidgid(idmap, inode, CAP_CHOWN))
-		return true;
+		return 0;
 	if (!vfsgid_valid(vfsgid) &&
 	    ns_capable(inode->i_sb->s_user_ns, CAP_CHOWN))
-		return true;
-	return false;
+		return 0;
+	return -EPERM;
 }
 
 /**
@@ -163,6 +170,7 @@ int setattr_prepare(struct mnt_idmap *idmap, struct dentry *dentry,
 {
 	struct inode *inode = d_inode(dentry);
 	unsigned int ia_valid = attr->ia_valid;
+	int ret;
 
 	/*
 	 * First check size constraints.  These can't be overriden using
@@ -179,14 +187,18 @@ int setattr_prepare(struct mnt_idmap *idmap, struct dentry *dentry,
 		goto kill_priv;
 
 	/* Make sure a caller can chown. */
-	if ((ia_valid & ATTR_UID) &&
-	    !chown_ok(idmap, inode, attr->ia_vfsuid))
-		return -EPERM;
+	if (ia_valid & ATTR_UID) {
+		ret = chown_ok(idmap, inode, attr->ia_vfsuid);
+		if (ret < 0)
+			return ret;
+	}
 
 	/* Make sure caller can chgrp. */
-	if ((ia_valid & ATTR_GID) &&
-	    !chgrp_ok(idmap, inode, attr->ia_vfsgid))
-		return -EPERM;
+	if (ia_valid & ATTR_GID) {
+		ret = chgrp_ok(idmap, inode, attr->ia_vfsgid);
+		if (ret < 0)
+			return ret;
+	}
 
 	/* Make sure a caller can chmod. */
 	if (ia_valid & ATTR_MODE) {
diff --git a/fs/coredump.c b/fs/coredump.c
index c33c177a701b..ded3936b2067 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -720,8 +720,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 		 * filesystem.
 		 */
 		idmap = file_mnt_idmap(cprm.file);
-		if (!vfsuid_eq_kuid(i_uid_into_vfsuid(idmap, inode),
-				    current_fsuid())) {
+		if (vfs_inode_is_owned_by_me(idmap, inode) != 0) {
 			coredump_report_failure("Core dump to %s aborted: "
 				"cannot preserve file owner", cn.corename);
 			goto close_fail;
diff --git a/fs/inode.c b/fs/inode.c
index 99318b157a9a..7e91b6f87757 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2586,11 +2586,15 @@ bool inode_owner_or_capable(struct mnt_idmap *idmap,
 {
 	vfsuid_t vfsuid;
 	struct user_namespace *ns;
+	int ret;
 
-	vfsuid = i_uid_into_vfsuid(idmap, inode);
-	if (vfsuid_eq_kuid(vfsuid, current_fsuid()))
+	ret = vfs_inode_is_owned_by_me(idmap, inode);
+	if (ret == 0)
 		return true;
+	if (ret < 0)
+		return false;
 
+	vfsuid = i_uid_into_vfsuid(idmap, inode);
 	ns = current_user_ns();
 	if (vfsuid_has_mapping(ns, vfsuid) && ns_capable(ns, CAP_FOWNER))
 		return true;
diff --git a/fs/locks.c b/fs/locks.c
index 1619cddfa7a4..b7a2a3ab7529 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -68,6 +68,7 @@
 #include <trace/events/filelock.h>
 
 #include <linux/uaccess.h>
+#include "internal.h"
 
 static struct file_lock *file_lock(struct file_lock_core *flc)
 {
@@ -2013,10 +2014,12 @@ int
 vfs_setlease(struct file *filp, int arg, struct file_lease **lease, void **priv)
 {
 	struct inode *inode = file_inode(filp);
-	vfsuid_t vfsuid = i_uid_into_vfsuid(file_mnt_idmap(filp), inode);
 	int error;
 
-	if ((!vfsuid_eq_kuid(vfsuid, current_fsuid())) && !capable(CAP_LEASE))
+	error = vfs_inode_is_owned_by_me(file_mnt_idmap(filp), inode);
+	if (error < 0)
+		return error;
+	if (error != 0 && !capable(CAP_LEASE))
 		return -EACCES;
 	if (!S_ISREG(inode->i_mode))
 		return -EINVAL;
diff --git a/fs/namei.c b/fs/namei.c
index 9f42dc46322f..6ede952d424a 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1195,26 +1195,26 @@ static int vfs_inodes_have_same_owner(struct mnt_idmap *idmap, struct inode *ino
  *
  * Returns 0 if following the symlink is allowed, -ve on error.
  */
-static inline int may_follow_link(struct nameidata *nd, const struct inode *inode)
+static inline int may_follow_link(struct nameidata *nd, struct inode *inode)
 {
 	struct mnt_idmap *idmap;
-	vfsuid_t vfsuid;
+	int ret;
 
 	if (!sysctl_protected_symlinks)
 		return 0;
 
-	idmap = mnt_idmap(nd->path.mnt);
-	vfsuid = i_uid_into_vfsuid(idmap, inode);
-	/* Allowed if owner and follower match. */
-	if (vfsuid_eq_kuid(vfsuid, current_fsuid()))
-		return 0;
-
 	/* Allowed if parent directory not sticky and world-writable. */
 	if ((nd->dir_mode & (S_ISVTX|S_IWOTH)) != (S_ISVTX|S_IWOTH))
 		return 0;
 
+	idmap = mnt_idmap(nd->path.mnt);
+	/* Allowed if owner and follower match. */
+	ret = vfs_inode_is_owned_by_me(idmap, inode);
+	if (ret <= 0)
+		return ret;
+
 	/* Allowed if parent directory and link owner match. */
-	if (vfsuid_valid(nd->dir_vfsuid) && vfsuid_eq(nd->dir_vfsuid, vfsuid))
+	if (vfs_inodes_have_same_owner(idmap, inode, nd))
 		return 0;
 
 	if (nd->flags & LOOKUP_RCU)
@@ -3157,12 +3157,14 @@ EXPORT_SYMBOL(user_path_at);
 int __check_sticky(struct mnt_idmap *idmap, struct inode *dir,
 		   struct inode *inode)
 {
-	kuid_t fsuid = current_fsuid();
+	int ret;
 
-	if (vfsuid_eq_kuid(i_uid_into_vfsuid(idmap, inode), fsuid))
-		return 0;
-	if (vfsuid_eq_kuid(i_uid_into_vfsuid(idmap, dir), fsuid))
-		return 0;
+	ret = vfs_inode_is_owned_by_me(idmap, inode);
+	if (ret <= 0)
+		return ret;
+	ret = vfs_inode_is_owned_by_me(idmap, dir);
+	if (ret <= 0)
+		return ret;
 	return !capable_wrt_inode_uidgid(idmap, inode, CAP_FOWNER);
 }
 EXPORT_SYMBOL(__check_sticky);
diff --git a/fs/remap_range.c b/fs/remap_range.c
index 26afbbbfb10c..9eee93c27001 100644
--- a/fs/remap_range.c
+++ b/fs/remap_range.c
@@ -413,20 +413,22 @@ loff_t vfs_clone_file_range(struct file *file_in, loff_t pos_in,
 EXPORT_SYMBOL(vfs_clone_file_range);
 
 /* Check whether we are allowed to dedupe the destination file */
-static bool may_dedupe_file(struct file *file)
+static int may_dedupe_file(struct file *file)
 {
 	struct mnt_idmap *idmap = file_mnt_idmap(file);
 	struct inode *inode = file_inode(file);
+	int ret;
 
 	if (capable(CAP_SYS_ADMIN))
-		return true;
+		return 0;
 	if (file->f_mode & FMODE_WRITE)
-		return true;
-	if (vfsuid_eq_kuid(i_uid_into_vfsuid(idmap, inode), current_fsuid()))
-		return true;
+		return 0;
+	ret = vfs_inode_is_owned_by_me(idmap, inode);
+	if (ret <= 0)
+		return ret;
 	if (!inode_permission(idmap, inode, MAY_WRITE))
-		return true;
-	return false;
+		return 0;
+	return -EPERM;
 }
 
 loff_t vfs_dedupe_file_range_one(struct file *src_file, loff_t src_pos,
@@ -459,8 +461,8 @@ loff_t vfs_dedupe_file_range_one(struct file *src_file, loff_t src_pos,
 	if (ret)
 		return ret;
 
-	ret = -EPERM;
-	if (!may_dedupe_file(dst_file))
+	ret = may_dedupe_file(dst_file);
+	if (ret < 0)
 		goto out_drop_write;
 
 	ret = -EXDEV;


