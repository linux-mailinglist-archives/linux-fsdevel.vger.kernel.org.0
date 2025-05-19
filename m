Return-Path: <linux-fsdevel+bounces-49432-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F272FABC415
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 18:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87EE83AF619
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 16:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3897289376;
	Mon, 19 May 2025 16:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FHo+UK6u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F039328936F
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 May 2025 16:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747671115; cv=none; b=drBuySm9bvNz6GencycTSc/s/gU15xBBTjBkR/t3j5yXNGZx/xqTg+eW96NxGOYlxdMiFvVoYpwGQjmoj7FoEwzQelTM2VdEWQJz0a2xro9ku9lD4jCXHQeSuVfLO4k0EVtykvYfHl+auTu7KWvKLM4ARmIUSaJ2RmHJB+Ugsf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747671115; c=relaxed/simple;
	bh=ISTczGxadcUclkDXLZV3Eskuo03uqtJ5PbSQWhYAFf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ngfCi+vFYFa7JU6/ENizuawGx31doruImc9c2nevsFy5NtMQNTkty/XjIjzW6CWM86Xvg2Nt+Ly86zoG4/bIl3hyTz/naOuJDR/cCP1/MRiUBtOJnSb1YYLXpfgP4/LSoe1bNuivAcmlclJT8oDh8jo0Kpqei3RDNfF6jPya2W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FHo+UK6u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747671110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=twf/BYD5BbQPuvJN3ljwkR3vFlDrn0agjdPwKHC7ADw=;
	b=FHo+UK6ukWZfYguegIP372yY2GRFcyytJbktGhGHu+NgpnNzzOUFF4+2Q4bwIeCdOFRVzm
	ETD7ZLDhZb3EEIoQdfn9gjZAOAGjxz5rBVrSuhsy7xIHRxvfZzvA1L9YcQn0pGxSzZL/5W
	ip+p4QHeAW88c+v9dQzXdHFZPoUfRa8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-491-K69R6ugYPU-q2QQQMtf50Q-1; Mon,
 19 May 2025 12:11:44 -0400
X-MC-Unique: K69R6ugYPU-q2QQQMtf50Q-1
X-Mimecast-MFC-AGG-ID: K69R6ugYPU-q2QQQMtf50Q_1747671102
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B30A01956046;
	Mon, 19 May 2025 16:11:41 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.188])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 74A8830001AA;
	Mon, 19 May 2025 16:11:37 +0000 (UTC)
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
	openafs-devel@openafs.org,
	linux-cifs@vger.kernel.org
Subject: [PATCH 1/2] afs, bash: Fix open(O_CREAT) on an extant AFS file in a sticky dir
Date: Mon, 19 May 2025 17:11:22 +0100
Message-ID: <20250519161125.2981681-2-dhowells@redhat.com>
In-Reply-To: <20250519161125.2981681-1-dhowells@redhat.com>
References: <20250519161125.2981681-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Since version 1.11 (January 1992) Bash has a work around in redir_open()
that causes open(O_CREAT) of a file to be retried without O_CREAT if open()
fails with an EACCES error if bash was built with AFS workarounds
configured:

        #if defined (AFS)
              if ((fd < 0) && (errno == EACCES))
            {
              fd = open (filename, flags & ~O_CREAT, mode);
              errno = EACCES;    /* restore errno */
            }

        #endif /* AFS */

The ~O_CREAT fallback logic was introduced to workaround a bug[1] in the
IBM AFS 3.1 cache manager and server which can return EACCES in preference
to EEXIST if the requested file exists but the caller is neither granted
explicit PRSFS_READ permission nor is the file owner and is granted
PRSFS_INSERT permission on the directory.  IBM AFS 3.2 altered the cache
manager permission checks but failed to correct the permission checks in
the AFS server.  As of this writing, all IBM AFS derived servers continue
to return EACCES in preference to EEXIST when these conditions are met.
Bug reports have been filed with all implementations.

As an unintended side effect, the Bash fallback logic also undermines the
Linux kernel protections against O_CREAT opening FIFOs and regular files
not owned by the user in world writeable sticky directories - unless the
owner is the same as that of the directory - as was added in commit
30aba6656f61e ("namei: allow restricted O_CREAT of FIFOs and regular
files").

As a result the Bash fallback logic masks an incompatibility between the
ownership checks performed by may_create_in_sticky() and network
filesystems such as AFS where the uid namespace is disjoint from the uid
namespace of the local system.

However, the bash work around is going to be removed[2].

Fix this in the kernel by:

 (1) Provide an ->is_owned_by_me() inode op, similar to ->permission(),
     and, if provided, call that to determine if the caller owns the file
     instead of checking the i_uid to current_fsuid().

 (2) Provide a ->have_same_owner() inode op, that, if provided, can be
     called to see if an inode has the same owner as the parent on the path
     walked.

For kafs, use the first hook to check to see if the server indicated the
ADMINISTER bit in the access rights returned by the FS.FetchStatus and
suchlike and the second hook to compare the AFS user IDs retrieved by
FS.FetchStatus (which may not fit in a kuid if AuriStor's YFS variant).

These hooks should probably be used in other places too, and a follow-up
patch will be submitted for that.

This can be tested by creating a sticky directory (the user must have a
token to do this) and creating a file in it.  Then strace bash doing "echo
foo >>file" and look at whether bash does a single, successful O_CREAT open
on the file or whether that one fails and then bash does one without
O_CREAT that succeeds.

Fixes: 30aba6656f61 ("namei: allow restricted O_CREAT of FIFOs and regular files")
Reported-by: Etienne Champetier <champetier.etienne@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeffrey Altman <jaltman@auristor.com>
cc: Chet Ramey <chet.ramey@case.edu>
cc: Cheyenne Wills <cwills@sinenomine.net>
cc: Alexander Viro <viro@zeniv.linux.org.uk>
cc: Christian Brauner <brauner@kernel.org>
cc: Steve French <sfrench@samba.org>
cc: linux-afs@lists.infradead.org
cc: openafs-devel@openafs.org
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
Link: https://groups.google.com/g/gnu.bash.bug/c/6PPTfOgFdL4/m/2AQU-S1N76UJ [1]
Link: https://git.savannah.gnu.org/cgit/bash.git/tree/redir.c?h=bash-5.3-rc1#n733 [2]
---
 fs/afs/dir.c       |  2 ++
 fs/afs/file.c      |  2 ++
 fs/afs/internal.h  |  3 +++
 fs/afs/security.c  | 52 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/internal.h      |  1 +
 fs/namei.c         | 50 +++++++++++++++++++++++++++++++++++---------
 include/linux/fs.h |  3 +++
 7 files changed, 103 insertions(+), 10 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 9e7b1fe82c27..6360db1673b0 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -65,6 +65,8 @@ const struct inode_operations afs_dir_inode_operations = {
 	.permission	= afs_permission,
 	.getattr	= afs_getattr,
 	.setattr	= afs_setattr,
+	.is_owned_by_me	= afs_is_owned_by_me,
+	.have_same_owner = afs_have_same_owner,
 };
 
 const struct address_space_operations afs_dir_aops = {
diff --git a/fs/afs/file.c b/fs/afs/file.c
index fc15497608c6..0317f0a36cf2 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -47,6 +47,8 @@ const struct inode_operations afs_file_inode_operations = {
 	.getattr	= afs_getattr,
 	.setattr	= afs_setattr,
 	.permission	= afs_permission,
+	.is_owned_by_me	= afs_is_owned_by_me,
+	.have_same_owner = afs_have_same_owner,
 };
 
 const struct address_space_operations afs_file_aops = {
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 440b0e731093..fbfbf615abe3 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1495,6 +1495,9 @@ extern struct key *afs_request_key(struct afs_cell *);
 extern struct key *afs_request_key_rcu(struct afs_cell *);
 extern int afs_check_permit(struct afs_vnode *, struct key *, afs_access_t *);
 extern int afs_permission(struct mnt_idmap *, struct inode *, int);
+int afs_is_owned_by_me(struct mnt_idmap *idmap, struct inode *inode);
+int afs_have_same_owner(struct mnt_idmap *idmap, struct inode *inode,
+			struct dentry *dentry);
 extern void __exit afs_clean_up_permit_cache(void);
 
 /*
diff --git a/fs/afs/security.c b/fs/afs/security.c
index 6a7744c9e2a2..a49070c8342d 100644
--- a/fs/afs/security.c
+++ b/fs/afs/security.c
@@ -477,6 +477,58 @@ int afs_permission(struct mnt_idmap *idmap, struct inode *inode,
 	return ret;
 }
 
+/*
+ * Determine if an inode is owned by 'me' - whatever that means for the
+ * filesystem.  In the case of AFS, this means that the file is owned by the
+ * AFS user represented by the token (e.g. from a kerberos server) held in a
+ * key.  Returns 0 if owned by me, 1 if not; can also return an error.
+ */
+int afs_is_owned_by_me(struct mnt_idmap *idmap, struct inode *inode)
+{
+	struct afs_vnode *vnode = AFS_FS_I(inode);
+	afs_access_t access;
+	struct key *key;
+	int ret;
+
+	key = afs_request_key(vnode->volume->cell);
+	if (IS_ERR(key))
+		return PTR_ERR(key);
+
+	/* Get the access rights for the key on this file. */
+	ret = afs_check_permit(vnode, key, &access);
+	if (ret < 0)
+		goto error;
+
+	/* We get the ADMINISTER bit if we own the file. */
+	ret = (access & AFS_ACE_ADMINISTER) ? 0 : 1;
+error:
+	key_put(key);
+	return ret;
+}
+
+/*
+ * Determine if a file has the same owner as its parent - whatever that means
+ * for the filesystem.  In the case of AFS, this means comparing their AFS
+ * UIDs.  Returns 0 if same, 1 if not same; can also return an error.
+ */
+int afs_have_same_owner(struct mnt_idmap *idmap, struct inode *inode,
+			struct dentry *dentry)
+{
+	struct afs_vnode *vnode = AFS_FS_I(inode), *dvnode;
+	struct dentry *parent;
+	s64 owner;
+
+	/* Get the owner's ID for the directory.  Ideally, we'd use RCU to
+	 * access the parent rather than getting a ref.
+	 */
+	parent = dget_parent(dentry);
+	dvnode = AFS_FS_I(d_backing_inode(parent));
+	owner = dvnode->status.owner;
+	dput(parent);
+
+	return vnode->status.owner != owner;
+}
+
 void __exit afs_clean_up_permit_cache(void)
 {
 	int i;
diff --git a/fs/internal.h b/fs/internal.h
index b9b3e29a73fd..9e84bfc5aee6 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -52,6 +52,7 @@ extern int finish_clean_context(struct fs_context *fc);
 /*
  * namei.c
  */
+int vfs_inode_is_owned_by_me(struct mnt_idmap *idmap, struct inode *inode);
 extern int filename_lookup(int dfd, struct filename *name, unsigned flags,
 			   struct path *path, struct path *root);
 int do_rmdir(int dfd, struct filename *name);
diff --git a/fs/namei.c b/fs/namei.c
index 84a0e0b0111c..9f42dc46322f 100644
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
@@ -1149,6 +1149,36 @@ fs_initcall(init_fs_namei_sysctls);
 
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
+
+	return vfsuid_eq_kuid(i_uid_into_vfsuid(idmap, inode),
+			      current_fsuid()) ? 1 : 0;
+}
+
+/*
+ * Determine if two inodes have the same owner, returning 0 if so, 1 if not and
+ * a negative error code if there was a problem making the determination.
+ */
+static int vfs_inodes_have_same_owner(struct mnt_idmap *idmap, struct inode *inode,
+				      const struct nameidata *nd)
+{
+	if (unlikely(inode->i_op->have_same_owner))
+		return inode->i_op->have_same_owner(idmap, inode, nd->path.dentry);
+
+	if (vfsuid_valid(nd->dir_vfsuid) &&
+	    vfsuid_eq(i_uid_into_vfsuid(idmap, inode), nd->dir_vfsuid))
+		return 0;
+	return 1; /* Not same. */
+}
+
 /**
  * may_follow_link - Check symlink following for unsafe situations
  * @nd: nameidata pathwalk data
@@ -1302,10 +1332,10 @@ int may_linkat(struct mnt_idmap *idmap, const struct path *link)
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
@@ -1316,13 +1346,13 @@ static int may_create_in_sticky(struct mnt_idmap *idmap, struct nameidata *nd,
 	if (S_ISFIFO(inode->i_mode) && !sysctl_protected_fifos)
 		return 0;
 
-	i_vfsuid = i_uid_into_vfsuid(idmap, inode);
-
-	if (vfsuid_eq(i_vfsuid, dir_vfsuid))
-		return 0;
+	ret = vfs_inodes_have_same_owner(idmap, inode, nd);
+	if (ret <= 0)
+		return ret;
 
-	if (vfsuid_eq_kuid(i_vfsuid, current_fsuid()))
-		return 0;
+	ret = vfs_inode_is_owned_by_me(idmap, inode);
+	if (ret <= 0)
+		return ret;
 
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
 
 static inline int call_mmap(struct file *file, struct vm_area_struct *vma)


