Return-Path: <linux-fsdevel+bounces-64135-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AE3BD9C1A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 15:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D1A464F52D0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 13:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166F2314B6F;
	Tue, 14 Oct 2025 13:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ErvIChzD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066AB314B60
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 13:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760448982; cv=none; b=vCHBxka7j5DCRYmgOvFgiA9zP1GRm73WbSssDMeqU/KQXayneLuPX2b994SbaYRIRgZ1cNl3ZadKNEjuVAHd4UArOD9SMNHwMRQvp+GSu9iXD4nIdzISTEqFSMPVGLCcVfhE7Kbu/BpZSHQBvdD06AH6NaOaWTXXxsd7VZHMUVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760448982; c=relaxed/simple;
	bh=gISsGTQ0aXQpswLpvFrcGGmGumvR9Un/GGD97Jwd8WE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pNQ+l9Was2BHegGgdC/3ksrnAWYH2NaFpr+Wl4DaLDYFYzCeTMwTk1gKP9xzlWcH6JIi+M3phRyHdJAIpSUUexFmYZZc6rqoB23t2v28dthufuQ3xoywSibPQDxkSZbw0RfJZArw8//PxpD3rjyC0qmugauJbcMxmdbyq1Nc/aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ErvIChzD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760448979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uL4W1ez+ekl31ezOH5xVCbd9/6guQHJSNPizx0SNCxE=;
	b=ErvIChzDVASZBwYf7+ueZEFwiYOH9/e1EkWYFd8EXwXPdGz/LWN4EiVvD2e1d1caevvSDC
	bogbBz9Nh4xacME/JhyseoTubU22xu6v899YskBat4VKEAOVPRP0wUkFAOA0DB8WRXTsu6
	aKD2qCEFueXgXnpdJ8yhhDqvBFaAHN8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-101-xr4G6-cMPFimZL9-IKNm9g-1; Tue,
 14 Oct 2025 09:36:13 -0400
X-MC-Unique: xr4G6-cMPFimZL9-IKNm9g-1
X-Mimecast-MFC-AGG-ID: xr4G6-cMPFimZL9-IKNm9g_1760448971
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B6AA218004D8;
	Tue, 14 Oct 2025 13:36:04 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.157])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 00BCD1955F21;
	Tue, 14 Oct 2025 13:35:59 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jeffrey Altman <jaltman@auristor.com>,
	Steve French <sfrench@samba.org>,
	linux-afs@lists.infradead.org,
	openafs-devel@openafs.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Etienne Champetier <champetier.etienne@gmail.com>,
	Chet Ramey <chet.ramey@case.edu>,
	Cheyenne Wills <cwills@sinenomine.net>,
	Christian Brauner <brauner@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-integrity@vger.kernel.org
Subject: [PATCH 1/2] vfs: Allow filesystems with foreign owner IDs to override UID checks
Date: Tue, 14 Oct 2025 14:35:44 +0100
Message-ID: <20251014133551.82642-2-dhowells@redhat.com>
In-Reply-To: <20251014133551.82642-1-dhowells@redhat.com>
References: <20251014133551.82642-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

A number of ownership checks made by the VFS make a number of assumptions:

 (1) that it is meaningful to compare inode->i_uid to a second ->i_uid or
     to current_fsuid(),

 (2) that current_fsuid() represents the subject of the action,

 (3) that the number in ->i_uid belong to the system's ID space and

 (4) that the IDs can be represented by 32-bit integers.

Network filesystems, however, may violate all four of these assumptions.
Indeed, a network filesystem may not even have an actual concept of a UNIX
integer UID (cifs without POSIX extensions, for example).  Plug-in block
filesystems (e.g. USB drives) may also violate this assumption.

In particular, AFS implements its own ACL security model with its own
per-cell user ID space with 64-bit IDs for some server variants.  The
subject is represented by a token in a key, not current_fsuid().  The AFS
user IDs and the system user IDs for a cell may be numerically equivalent,
but that's matter of administrative policy and should perhaps be noted in
the cell definition or by mount option.  A subsequent patch will address
AFS.

To help fix this, three functions are defined to perform UID comparison
within the VFS:

 (1) vfs_inode_is_owned_by_me().  This defaults to comparing i_uid to
     current_fsuid(), with appropriate namespace mapping, assuming that the
     fsuid identifies the subject of the action.  The filesystem may
     override it by implementing an inode op:

	int (*is_owned_by_me)(struct mnt_idmap *idmap, struct inode *inode);

     This should return 0 if owned, 1 if not or an error if there's some
     sort of lookup failure.  It may use a means of identifying the subject
     of the action other than fsuid, for example by using an authentication
     token stored in a key.

 (2) vfs_inodes_have_same_owner().  This defaults to comparing the i_uids
     of two different inodes with appropriate namespace mapping.  The
     filesystem may override it by implementing another inode op:

	int (*have_same_owner)(struct mnt_idmap *idmap, struct inode *inode1,
			       struct inode *inode2);

     Again, this should return 0 if matching, 1 if not or an error if
     there's some sort of lookup failure.

 (3) vfs_inode_and_dir_have_same_owner().  This is similar to (2), but
     assumes that the second inode is the parent directory to the first and
     takes a nameidata struct instead of a second inode pointer.

Fix a number of places within the VFS where such UID checks are made that
should be deferring interpretation to the filesystem.

 (*) chown_ok()
 (*) chgrp_ok()

     Call vfs_inode_is_owned_by_me().  Possibly these need to defer all
     their checks to the network filesystem as the interpretation of the
     new UID/GID depends on the netfs too, but the ->setattr() method gets
     a chance to deal with that.

 (*) coredump_file()

     Call vfs_is_owned_by_me() to check that the file created is owned by
     the caller - but the check that's there might be sufficient.

 (*) inode_owner_or_capable()

     Call vfs_is_owned_by_me().  I'm not sure whether the namespace mapping
     makes sense in such a case, but it probably could be used.

 (*) vfs_setlease()

     Call vfs_is_owned_by_me().  Actually, it should query if leasing is
     permitted.

     Also, setting locks could perhaps do with a permission call to the
     filesystem driver as AFS, for example, has a lock permission bit in
     the ACL, but since the AFS server checks that when the RPC call is
     made, it's probably unnecessary.

 (*) acl_permission_check()
 (*) posix_acl_permission()

     Unchanged.  These functions are only used by generic_permission()
     which is overridden if ->permission() is supplied, and when evaluating
     a POSIX ACL, it should arguably be checking the UID anyway.

     AFS, for example, implements its own ACLs and evaluates them in
     ->permission() and on the server.

 (*) may_follow_link()

     Call vfs_inode_and_dir_have_same_owner() and vfs_is_owned_by_me() on
     the the link and its parent dir.

 (*) may_create_in_sticky()

     Call vfs_is_owned_by_me() and also vfs_inode_and_dir_have_same_owner()
     both.

     [?] Should this return ok immediately if the open call we're in
     created the file being checked.

 (*) __check_sticky()

     Call vfs_is_owned_by_me() on both the dir and the inode, but for AFS
     vfs_is_owned_by_me() on a directory doesn't work, so call
     vfs_inodes_have_same_owner() instead to check the directory (as is
     done in may_create_in_sticky()).

 (*) may_dedupe_file()

     Call vfs_is_owned_by_me().

 (*) IMA policy ops.

     Unchanged for now.  I'm not sure what the best way to deal with this
     is - if, indeed, it needs any changes.

Note that wrapping stuff up into vfs_inode_is_owned_by_me() isn't
necessarily the most efficient as it means we may end up doing the uid
idmapping an extra time - though this is only done in three places, all to
do with world-writable sticky dir checks.

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
 Documentation/filesystems/vfs.rst |  21 ++++
 fs/attr.c                         |  58 ++++++-----
 fs/coredump.c                     |   2 +-
 fs/inode.c                        |  11 +-
 fs/internal.h                     |   1 +
 fs/locks.c                        |   7 +-
 fs/namei.c                        | 161 ++++++++++++++++++++++++------
 fs/remap_range.c                  |  20 ++--
 include/linux/fs.h                |   6 +-
 9 files changed, 216 insertions(+), 71 deletions(-)

diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 4f13b01e42eb..5acbad3be4fd 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -495,6 +495,9 @@ As of kernel 2.6.22, the following members are defined:
 				    struct dentry *dentry, struct file_kattr *fa);
 		int (*fileattr_get)(struct dentry *dentry, struct file_kattr *fa);
 	        struct offset_ctx *(*get_offset_ctx)(struct inode *inode);
+		int (*is_owned_by_me)(struct mnt_idmap *idmap, struct inode *inode);
+		int (*have_same_owner)(struct mnt_idmap *idmap, struct inode *inode,
+				       struct dentry *dentry);
 	};
 
 Again, all methods are called without any locks being held, unless
@@ -679,6 +682,24 @@ otherwise noted.
         filesystem must define this operation to use
         simple_offset_dir_operations.
 
+``is_owned_by_me``
+	called to determine if the file can be considered to be 'owned' by
+	the owner of the process or if the process has a token that grants
+	it ownership privileges.  If unset, the default is to compare i_uid
+	to current_fsuid() - but this may give incorrect results for some
+	network or plug-in block filesystems.  For example, AFS determines
+	ownership entirely according to an obtained token and i_uid may not
+	even be from the same ID space as current_uid().
+
+``have_same_owner``
+	called to determine if an inode has the same owner as its immediate
+	parent on the path walked.  If unset, the default is to simply
+	compare the i_uid of both.  For example, AFS compares the owner IDs
+	of both - but these are a 64-bit values on some variants that might
+	not fit into a kuid_t and cifs has GUIDs that cannot be compared to
+	kuid_t.
+
+
 The Address Space Object
 ========================
 
diff --git a/fs/attr.c b/fs/attr.c
index 795f231d00e8..096401a4815d 100644
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
+		    struct inode *inode, vfsuid_t ia_vfsuid)
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
+		    struct inode *inode, vfsgid_t ia_vfsgid)
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
index b5fc06a092a4..ac113e41d090 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -951,7 +951,7 @@ static bool coredump_file(struct core_name *cn, struct coredump_params *cprm,
 	 * filesystem.
 	 */
 	idmap = file_mnt_idmap(file);
-	if (!vfsuid_eq_kuid(i_uid_into_vfsuid(idmap, inode), current_fsuid())) {
+	if (vfs_inode_is_owned_by_me(idmap, inode) != 0) {
 		coredump_report_failure("Core dump to %s aborted: cannot preserve file owner", cn->corename);
 		return false;
 	}
diff --git a/fs/inode.c b/fs/inode.c
index ec9339024ac3..61e6b1d71e86 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2628,16 +2628,19 @@ EXPORT_SYMBOL(inode_init_owner);
  * On non-idmapped mounts or if permission checking is to be performed on the
  * raw inode simply pass @nop_mnt_idmap.
  */
-bool inode_owner_or_capable(struct mnt_idmap *idmap,
-			    const struct inode *inode)
+bool inode_owner_or_capable(struct mnt_idmap *idmap, struct inode *inode)
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
diff --git a/fs/internal.h b/fs/internal.h
index 9b2b4d116880..29682c6edecd 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -52,6 +52,7 @@ extern int finish_clean_context(struct fs_context *fc);
 /*
  * namei.c
  */
+int vfs_inode_is_owned_by_me(struct mnt_idmap *idmap, struct inode *inode);
 extern int filename_lookup(int dfd, struct filename *name, unsigned flags,
 			   struct path *path, const struct path *root);
 int do_rmdir(int dfd, struct filename *name);
diff --git a/fs/locks.c b/fs/locks.c
index 04a3f0e20724..b710bf0733b0 100644
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
index 7377020a2cba..7dbcb5d50339 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -53,8 +53,8 @@
  * The new code replaces the old recursive symlink resolution with
  * an iterative one (in case of non-nested symlink chains).  It does
  * this with calls to <fs>_follow_link().
- * As a side effect, dir_namei(), _namei() and follow_link() are now 
- * replaced with a single function lookup_dentry() that can handle all 
+ * As a side effect, dir_namei(), _namei() and follow_link() are now
+ * replaced with a single function lookup_dentry() that can handle all
  * the special cases of the former code.
  *
  * With the new dcache, the pathname is stored at each inode, at least as
@@ -1149,6 +1149,72 @@ fs_initcall(init_fs_namei_sysctls);
 
 #endif /* CONFIG_SYSCTL */
 
+/*
+ * Determine if an inode is owned by the process (allowing for fsuid override),
+ * returning 0 if so, 1 if not and a negative error code if there was a problem
+ * making the determination.
+ */
+int vfs_inode_is_owned_by_me(struct mnt_idmap *idmap, struct inode *inode)
+{
+	if (unlikely(inode->i_op->is_owned_by_me))
+		return inode->i_op->is_owned_by_me(idmap, inode);
+	if (vfsuid_eq_kuid(i_uid_into_vfsuid(idmap, inode), current_fsuid()))
+		return 0;
+	return 1; /* Not same. */
+}
+
+/*
+ * Determine if an inode has the same owner as its parent, returning 0 if so, 1
+ * if not and a negative error code if there was a problem making the
+ * determination.
+ */
+static int vfs_inode_and_dir_have_same_owner(struct mnt_idmap *idmap, struct inode *inode,
+					     const struct nameidata *nd)
+{
+	if (unlikely(inode->i_op->have_same_owner)) {
+		struct dentry *parent;
+		struct inode *dir;
+		int ret;
+
+		if (inode != nd->inode) {
+			dir = nd->inode;
+			ret = inode->i_op->have_same_owner(idmap, inode, dir);
+		} else if (nd->flags & LOOKUP_RCU) {
+			parent = READ_ONCE(nd->path.dentry);
+			dir = READ_ONCE(parent->d_inode);
+			if (!dir)
+				return -ECHILD;
+			ret = inode->i_op->have_same_owner(idmap, inode, dir);
+		} else {
+			parent = dget_parent(nd->path.dentry);
+			dir = parent->d_inode;
+			ret = inode->i_op->have_same_owner(idmap, inode, dir);
+			dput(parent);
+		}
+		return ret;
+	}
+
+	if (vfsuid_valid(nd->dir_vfsuid) &&
+	    vfsuid_eq(i_uid_into_vfsuid(idmap, inode), nd->dir_vfsuid))
+		return 0;
+	return 1; /* Not same. */
+}
+
+/*
+ * Determine if two inodes have the same owner, returning 0 if so, 1 if not and
+ * a negative error code if there was a problem making the determination.
+ */
+static int vfs_inodes_have_same_owner(struct mnt_idmap *idmap, struct inode *inode,
+				      struct inode *dir)
+{
+	if (unlikely(inode->i_op->have_same_owner))
+		return inode->i_op->have_same_owner(idmap, inode, dir);
+	if (vfsuid_eq(i_uid_into_vfsuid(idmap, inode),
+		      i_uid_into_vfsuid(idmap, dir)))
+		return 0;
+	return 1; /* Not same. */
+}
+
 /**
  * may_follow_link - Check symlink following for unsafe situations
  * @nd: nameidata pathwalk data
@@ -1165,27 +1231,28 @@ fs_initcall(init_fs_namei_sysctls);
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
-		return 0;
+	ret = vfs_inode_and_dir_have_same_owner(idmap, inode, nd);
+	if (ret <= 0)
+		return ret;
 
 	if (nd->flags & LOOKUP_RCU)
 		return -ECHILD;
@@ -1283,12 +1350,12 @@ int may_linkat(struct mnt_idmap *idmap, const struct path *link)
  * @inode: the inode of the file to open
  *
  * Block an O_CREAT open of a FIFO (or a regular file) when:
- *   - sysctl_protected_fifos (or sysctl_protected_regular) is enabled
- *   - the file already exists
- *   - we are in a sticky directory
- *   - we don't own the file
+ *   - sysctl_protected_fifos (or sysctl_protected_regular) is enabled,
+ *   - the file already exists,
+ *   - we are in a sticky directory,
+ *   - the directory is world writable,
+ *   - we don't own the file and
  *   - the owner of the directory doesn't own the file
- *   - the directory is world writable
  * If the sysctl_protected_fifos (or sysctl_protected_regular) is set to 2
  * the directory doesn't have to be world writable: being group writable will
  * be enough.
@@ -1299,13 +1366,45 @@ int may_linkat(struct mnt_idmap *idmap, const struct path *link)
  * On non-idmapped mounts or if permission checking is to be performed on the
  * raw inode simply pass @nop_mnt_idmap.
  *
+ * For a filesystem (e.g. a network filesystem) that has a separate ID space
+ * and has foreign IDs (maybe even non-integer IDs), i_uid cannot be compared
+ * to current_fsuid() and may not be directly comparable to another i_uid.
+ * Instead, the filesystem is asked to perform the comparisons.  With network
+ * filesystems, there also exists the possibility of doing anonymous
+ * operations and having anonymously-owned objects.
+ *
+ * We have the following scenarios:
+ *
+ *	USER	DIR	FILE	FILE	ALLOWED
+ *		OWNER	OWNER	STATE
+ *	=======	=======	=======	=======	=======
+ *	A	A	-	New	Yes
+ *	A	A	A	Exists	Yes
+ *	A	A	C	Exists	No
+ *	A	B	-	New	Yes
+ *	A	B	A	Exists	Yes, FO==U
+ *	A	B	B	Exists	Yes, FO==DO
+ *	A	B	C	Exists	No
+ *	A	anon[1]	-	New	Yes
+ *	A	anon[1]	A	Exists	Yes
+ *	A	anon[1]	C	Exists	No
+ *	anon	A	-	New	Yes
+ *	anon	A	A	Exists	Yes, FO==DO
+ *	anon	anon[1]	-	New	Yes
+ *	anon	anon[1]	-	Exists	No
+ *	anon	A	A	Exists	Yes, FO==DO
+ *	anon	A	C	Exists	No
+ *	anon	A	anon	Exists	No
+ *
+ * [1] Can anonymously-owned dirs be sticky?
+ *
  * Returns 0 if the open is allowed, -ve on error.
  */
 static int may_create_in_sticky(struct mnt_idmap *idmap, struct nameidata *nd,
-				struct inode *const inode)
+				struct inode *inode)
 {
 	umode_t dir_mode = nd->dir_mode;
-	vfsuid_t dir_vfsuid = nd->dir_vfsuid, i_vfsuid;
+	int ret;
 
 	if (likely(!(dir_mode & S_ISVTX)))
 		return 0;
@@ -1316,13 +1415,13 @@ static int may_create_in_sticky(struct mnt_idmap *idmap, struct nameidata *nd,
 	if (S_ISFIFO(inode->i_mode) && !sysctl_protected_fifos)
 		return 0;
 
-	i_vfsuid = i_uid_into_vfsuid(idmap, inode);
-
-	if (vfsuid_eq(i_vfsuid, dir_vfsuid))
-		return 0;
+	ret = vfs_inode_and_dir_have_same_owner(idmap, inode, nd);
+	if (ret <= 0)
+		return ret;
 
-	if (vfsuid_eq_kuid(i_vfsuid, current_fsuid()))
-		return 0;
+	ret = vfs_inode_is_owned_by_me(idmap, inode);
+	if (ret <= 0)
+		return ret;
 
 	if (likely(dir_mode & 0002)) {
 		audit_log_path_denied(AUDIT_ANOM_CREAT, "sticky_create");
@@ -3222,12 +3321,14 @@ EXPORT_SYMBOL(user_path_at);
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
+	ret = vfs_inodes_have_same_owner(idmap, inode, dir);
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
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c895146c1444..f59a7456852f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2104,8 +2104,7 @@ static inline bool sb_start_intwrite_trylock(struct super_block *sb)
 	return __sb_start_write_trylock(sb, SB_FREEZE_FS);
 }
 
-bool inode_owner_or_capable(struct mnt_idmap *idmap,
-			    const struct inode *inode);
+bool inode_owner_or_capable(struct mnt_idmap *idmap, struct inode *inode);
 
 /*
  * VFS helper functions..
@@ -2376,6 +2375,9 @@ struct inode_operations {
 			    struct dentry *dentry, struct file_kattr *fa);
 	int (*fileattr_get)(struct dentry *dentry, struct file_kattr *fa);
 	struct offset_ctx *(*get_offset_ctx)(struct inode *inode);
+	int (*is_owned_by_me)(struct mnt_idmap *idmap, struct inode *inode);
+	int (*have_same_owner)(struct mnt_idmap *idmap, struct inode *inode1,
+			       struct inode *inode2);
 } ____cacheline_aligned;
 
 /* Did the driver provide valid mmap hook configuration? */


