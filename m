Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 855B345A1C7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Nov 2021 12:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236446AbhKWLqJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 06:46:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:37496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236427AbhKWLqG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 06:46:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F40A860E05;
        Tue, 23 Nov 2021 11:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637667778;
        bh=/rTjeTPWBvcLK8wr+cO1MZN2iy1dh3v+tLbcaaytnu8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rIzIg8nIW12AWqzxNA/jub8lHMyk5SI8VB9oEF2Tuppu2SAm8LM3hjtZekhYT7y3U
         nzhM9V1cEALr+2G4hyPi2tY3Nk0evg3w9vZOvt/P/Ke5i2JsgygK8BdESLs68yGlhV
         CKehiUJoOCxCuLIeDjfR+4bP97Rh3+uhTrLWJZG9m+I0s6RbtvnzSt2wux6/c7TOMT
         zJAc8EJrd33mj3tI9JfDYjnrCmYmYmyS1EGG3z9NGu35OrOURi0iPvyJ7NWHsq5QNX
         x1i8GBi/b8d6SrFpK1S9PctzvIfegmyWHU9BhrzR9huphLBAzsuMh+lrGrb0ip7yKN
         VecJG175gPAeg==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Seth Forshee <sforshee@digitalocean.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 06/10] fs: use low-level mapping helpers
Date:   Tue, 23 Nov 2021 12:42:23 +0100
Message-Id: <20211123114227.3124056-7-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211123114227.3124056-1-brauner@kernel.org>
References: <20211123114227.3124056-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7819; h=from:subject; bh=xvtF5aZHVHe4SS8zPrO55/0FHCocop3aQUOcbCD9wr4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSTOuVwquics4Vvm9nNavC8K6/3DmUuWzZ3mPU3yeoTus+73 skuzOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACay+S4jw4N6oynbLxVkPL/jGrF45t zDIatuTPN4o9+2nm22X+m6VyGMDBume2R0SeucYnLkjnNaFTcvsKFCxelDcPNvvmdqv4ufMwIA
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

In a few places the vfs needs to interact with bare k{g,u}ids directly
instead of struct inode. These are just a few. In previous patches we
introduced low-level mapping helpers that are able to support
filesystems mounted an idmapping. This patch simply converts the places
to use these new helpers.

Cc: Seth Forshee <sforshee@digitalocean.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>
CC: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/ksmbd/smbacl.c    | 18 ++----------------
 fs/ksmbd/smbacl.h    |  4 ++--
 fs/open.c            |  4 ++--
 fs/posix_acl.c       | 16 ++++++++++------
 security/commoncap.c | 13 ++++++++-----
 5 files changed, 24 insertions(+), 31 deletions(-)

diff --git a/fs/ksmbd/smbacl.c b/fs/ksmbd/smbacl.c
index bd792db32623..abd5e60a26bb 100644
--- a/fs/ksmbd/smbacl.c
+++ b/fs/ksmbd/smbacl.c
@@ -274,14 +274,7 @@ static int sid_to_id(struct user_namespace *user_ns,
 		uid_t id;
 
 		id = le32_to_cpu(psid->sub_auth[psid->num_subauth - 1]);
-		/*
-		 * Translate raw sid into kuid in the server's user
-		 * namespace.
-		 */
-		uid = make_kuid(&init_user_ns, id);
-
-		/* If this is an idmapped mount, apply the idmapping. */
-		uid = kuid_from_mnt(user_ns, uid);
+		uid = mapped_kuid_user(user_ns, &init_user_ns, KUIDT_INIT(id));
 		if (uid_valid(uid)) {
 			fattr->cf_uid = uid;
 			rc = 0;
@@ -291,14 +284,7 @@ static int sid_to_id(struct user_namespace *user_ns,
 		gid_t id;
 
 		id = le32_to_cpu(psid->sub_auth[psid->num_subauth - 1]);
-		/*
-		 * Translate raw sid into kgid in the server's user
-		 * namespace.
-		 */
-		gid = make_kgid(&init_user_ns, id);
-
-		/* If this is an idmapped mount, apply the idmapping. */
-		gid = kgid_from_mnt(user_ns, gid);
+		gid = mapped_kgid_user(user_ns, &init_user_ns, KGIDT_INIT(id));
 		if (gid_valid(gid)) {
 			fattr->cf_gid = gid;
 			rc = 0;
diff --git a/fs/ksmbd/smbacl.h b/fs/ksmbd/smbacl.h
index 73e08cad412b..49030b22a545 100644
--- a/fs/ksmbd/smbacl.h
+++ b/fs/ksmbd/smbacl.h
@@ -216,7 +216,7 @@ static inline uid_t posix_acl_uid_translate(struct user_namespace *mnt_userns,
 	kuid_t kuid;
 
 	/* If this is an idmapped mount, apply the idmapping. */
-	kuid = kuid_into_mnt(mnt_userns, pace->e_uid);
+	kuid = mapped_kuid_fs(mnt_userns, &init_user_ns, pace->e_uid);
 
 	/* Translate the kuid into a userspace id ksmbd would see. */
 	return from_kuid(&init_user_ns, kuid);
@@ -228,7 +228,7 @@ static inline gid_t posix_acl_gid_translate(struct user_namespace *mnt_userns,
 	kgid_t kgid;
 
 	/* If this is an idmapped mount, apply the idmapping. */
-	kgid = kgid_into_mnt(mnt_userns, pace->e_gid);
+	kgid = mapped_kgid_fs(mnt_userns, &init_user_ns, pace->e_gid);
 
 	/* Translate the kgid into a userspace id ksmbd would see. */
 	return from_kgid(&init_user_ns, kgid);
diff --git a/fs/open.c b/fs/open.c
index f732fb94600c..64f799d96356 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -652,8 +652,8 @@ int chown_common(const struct path *path, uid_t user, gid_t group)
 	gid = make_kgid(current_user_ns(), group);
 
 	mnt_userns = mnt_user_ns(path->mnt);
-	uid = kuid_from_mnt(mnt_userns, uid);
-	gid = kgid_from_mnt(mnt_userns, gid);
+	uid = mapped_kuid_user(mnt_userns, &init_user_ns, uid);
+	gid = mapped_kgid_user(mnt_userns, &init_user_ns, gid);
 
 retry_deleg:
 	newattrs.ia_valid =  ATTR_CTIME;
diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 9323a854a60a..e45b3ffb6de1 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -374,7 +374,9 @@ posix_acl_permission(struct user_namespace *mnt_userns, struct inode *inode,
                                         goto check_perm;
                                 break;
                         case ACL_USER:
-				uid = kuid_into_mnt(mnt_userns, pa->e_uid);
+				uid = mapped_kuid_fs(mnt_userns,
+						      &init_user_ns,
+						      pa->e_uid);
 				if (uid_eq(uid, current_fsuid()))
                                         goto mask;
 				break;
@@ -387,7 +389,9 @@ posix_acl_permission(struct user_namespace *mnt_userns, struct inode *inode,
                                 }
 				break;
                         case ACL_GROUP:
-				gid = kgid_into_mnt(mnt_userns, pa->e_gid);
+				gid = mapped_kgid_fs(mnt_userns,
+						      &init_user_ns,
+						      pa->e_gid);
 				if (in_group_p(gid)) {
 					found = 1;
 					if ((pa->e_perm & want) == want)
@@ -734,17 +738,17 @@ static void posix_acl_fix_xattr_userns(
 		case ACL_USER:
 			uid = make_kuid(from, le32_to_cpu(entry->e_id));
 			if (from_user)
-				uid = kuid_from_mnt(mnt_userns, uid);
+				uid = mapped_kuid_user(mnt_userns, &init_user_ns, uid);
 			else
-				uid = kuid_into_mnt(mnt_userns, uid);
+				uid = mapped_kuid_fs(mnt_userns, &init_user_ns, uid);
 			entry->e_id = cpu_to_le32(from_kuid(to, uid));
 			break;
 		case ACL_GROUP:
 			gid = make_kgid(from, le32_to_cpu(entry->e_id));
 			if (from_user)
-				gid = kgid_from_mnt(mnt_userns, gid);
+				gid = mapped_kgid_user(mnt_userns, &init_user_ns, gid);
 			else
-				gid = kgid_into_mnt(mnt_userns, gid);
+				gid = mapped_kgid_fs(mnt_userns, &init_user_ns, gid);
 			entry->e_id = cpu_to_le32(from_kgid(to, gid));
 			break;
 		default:
diff --git a/security/commoncap.c b/security/commoncap.c
index 3f810d37b71b..77d319f62710 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -418,7 +418,7 @@ int cap_inode_getsecurity(struct user_namespace *mnt_userns,
 	kroot = make_kuid(fs_ns, root);
 
 	/* If this is an idmapped mount shift the kuid. */
-	kroot = kuid_into_mnt(mnt_userns, kroot);
+	kroot = mapped_kuid_fs(mnt_userns, &init_user_ns, kroot);
 
 	/* If the root kuid maps to a valid uid in current ns, then return
 	 * this as a nscap. */
@@ -488,6 +488,7 @@ int cap_inode_getsecurity(struct user_namespace *mnt_userns,
  * @size:	size of @ivalue
  * @task_ns:	user namespace of the caller
  * @mnt_userns:	user namespace of the mount the inode was found from
+ * @fs_userns:	user namespace of the filesystem
  *
  * If the inode has been found through an idmapped mount the user namespace of
  * the vfsmount must be passed through @mnt_userns. This function will then
@@ -497,7 +498,8 @@ int cap_inode_getsecurity(struct user_namespace *mnt_userns,
  */
 static kuid_t rootid_from_xattr(const void *value, size_t size,
 				struct user_namespace *task_ns,
-				struct user_namespace *mnt_userns)
+				struct user_namespace *mnt_userns,
+				struct user_namespace *fs_userns)
 {
 	const struct vfs_ns_cap_data *nscap = value;
 	kuid_t rootkid;
@@ -507,7 +509,7 @@ static kuid_t rootid_from_xattr(const void *value, size_t size,
 		rootid = le32_to_cpu(nscap->rootid);
 
 	rootkid = make_kuid(task_ns, rootid);
-	return kuid_from_mnt(mnt_userns, rootkid);
+	return mapped_kuid_user(mnt_userns, fs_userns, rootkid);
 }
 
 static bool validheader(size_t size, const struct vfs_cap_data *cap)
@@ -558,7 +560,8 @@ int cap_convert_nscap(struct user_namespace *mnt_userns, struct dentry *dentry,
 			/* user is privileged, just write the v2 */
 			return size;
 
-	rootid = rootid_from_xattr(*ivalue, size, task_ns, mnt_userns);
+	rootid = rootid_from_xattr(*ivalue, size, task_ns, mnt_userns,
+				   &init_user_ns);
 	if (!uid_valid(rootid))
 		return -EINVAL;
 
@@ -699,7 +702,7 @@ int get_vfs_caps_from_disk(struct user_namespace *mnt_userns,
 	/* Limit the caps to the mounter of the filesystem
 	 * or the more limited uid specified in the xattr.
 	 */
-	rootkuid = kuid_into_mnt(mnt_userns, rootkuid);
+	rootkuid = mapped_kuid_fs(mnt_userns, &init_user_ns, rootkuid);
 	if (!rootid_owns_currentns(rootkuid))
 		return -ENODATA;
 
-- 
2.30.2

