Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCEA746760D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Dec 2021 12:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380341AbhLCLVL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Dec 2021 06:21:11 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:47812 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380325AbhLCLVL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Dec 2021 06:21:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 80B93B826A4
        for <linux-fsdevel@vger.kernel.org>; Fri,  3 Dec 2021 11:17:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB9ADC53FC7;
        Fri,  3 Dec 2021 11:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638530265;
        bh=v2NXuqcAO4EU3aQhWLkXjH40Vj3LxVSvmWhwv7c80T0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CEH3vHERL59vGHhKpR+ys80UEviwNSb6EyIYLSfNnOIyTZD2gpDhBZPy+MRgndRYk
         aBWtPKr+QpVPOtuFul9POR0sGq9oxIo8DlzpokkeRX2ZdUdD3l9BgByjPMIARLxd0q
         XCdc8FksgfIJXS6GUgw5Tgl2bCmUNPZ2sfrF3r1I56pUGmFCsovdcwKReSP5+HKe2a
         SDWO/UaXmAk29kSDqEx/hJFBR/cewgA/I+X5QX0LlwYkYNt3Dz+C8EOe+YVm4c1Rjg
         neK1qf61cw5tEwKHwFSdl368e0ixh6GNtAU4IabiKPPPDuCziRW9QuJxozHY99TMmp
         fBDbP+z6DogLw==
From:   Christian Brauner <brauner@kernel.org>
To:     Seth Forshee <sforshee@digitalocean.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v3 06/10] fs: use low-level mapping helpers
Date:   Fri,  3 Dec 2021 12:17:03 +0100
Message-Id: <20211203111707.3901969-7-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211203111707.3901969-1-brauner@kernel.org>
References: <20211203111707.3901969-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8128; h=from:subject; bh=q3VnJNooWAw11UasTJaSpNe6iMx6zv0Tn3UmUTfWyJk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSSu/DN9I0vt2ujUFQou2WHnVrMXmhsJqDOkxS+Z0ltSdivm RglLRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwER2OzEytP2awCQk7G73IPJulMOvY2 zvjuwz38E8K+bIO48LanO8FjEy9K813Vauuu5A2Awx2Twrr/lvgg0Cl68w8DvnLRg8KaSTCQA=
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

Link: https://lore.kernel.org/r/20211123114227.3124056-7-brauner@kernel.org (v1)
Link: https://lore.kernel.org/r/20211130121032.3753852-7-brauner@kernel.org (v2)
Cc: Seth Forshee <sforshee@digitalocean.com>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>
CC: linux-fsdevel@vger.kernel.org
Reviewed-by: Seth Forshee <sforshee@digitalocean.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
unchanged

/* v3 */
unchanged
---
 fs/ksmbd/smbacl.c    | 18 ++----------------
 fs/ksmbd/smbacl.h    |  4 ++--
 fs/open.c            |  4 ++--
 fs/posix_acl.c       | 16 ++++++++++------
 security/commoncap.c | 13 ++++++++-----
 5 files changed, 24 insertions(+), 31 deletions(-)

diff --git a/fs/ksmbd/smbacl.c b/fs/ksmbd/smbacl.c
index ab8099e0fd7f..6ecf55ea1fed 100644
--- a/fs/ksmbd/smbacl.c
+++ b/fs/ksmbd/smbacl.c
@@ -275,14 +275,7 @@ static int sid_to_id(struct user_namespace *user_ns,
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
@@ -292,14 +285,7 @@ static int sid_to_id(struct user_namespace *user_ns,
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
index eba1ebb9e92e..811af3309429 100644
--- a/fs/ksmbd/smbacl.h
+++ b/fs/ksmbd/smbacl.h
@@ -217,7 +217,7 @@ static inline uid_t posix_acl_uid_translate(struct user_namespace *mnt_userns,
 	kuid_t kuid;
 
 	/* If this is an idmapped mount, apply the idmapping. */
-	kuid = kuid_into_mnt(mnt_userns, pace->e_uid);
+	kuid = mapped_kuid_fs(mnt_userns, &init_user_ns, pace->e_uid);
 
 	/* Translate the kuid into a userspace id ksmbd would see. */
 	return from_kuid(&init_user_ns, kuid);
@@ -229,7 +229,7 @@ static inline gid_t posix_acl_gid_translate(struct user_namespace *mnt_userns,
 	kgid_t kgid;
 
 	/* If this is an idmapped mount, apply the idmapping. */
-	kgid = kgid_into_mnt(mnt_userns, pace->e_gid);
+	kgid = mapped_kgid_fs(mnt_userns, &init_user_ns, pace->e_gid);
 
 	/* Translate the kgid into a userspace id ksmbd would see. */
 	return from_kgid(&init_user_ns, kgid);
diff --git a/fs/open.c b/fs/open.c
index 2450cc1a2f64..40a00e71865b 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -653,8 +653,8 @@ int chown_common(const struct path *path, uid_t user, gid_t group)
 	gid = make_kgid(current_user_ns(), group);
 
 	mnt_userns = mnt_user_ns(path->mnt);
-	uid = kuid_from_mnt(mnt_userns, uid);
-	gid = kgid_from_mnt(mnt_userns, gid);
+	uid = mapped_kuid_user(mnt_userns, &init_user_ns, uid);
+	gid = mapped_kgid_user(mnt_userns, &init_user_ns, gid);
 
 retry_deleg:
 	newattrs.ia_valid =  ATTR_CTIME;
diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 632bfdcf7cc0..4b5fb9a9b90f 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -375,7 +375,9 @@ posix_acl_permission(struct user_namespace *mnt_userns, struct inode *inode,
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
@@ -388,7 +390,9 @@ posix_acl_permission(struct user_namespace *mnt_userns, struct inode *inode,
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
@@ -735,17 +739,17 @@ static void posix_acl_fix_xattr_userns(
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
index 09479f71ee2e..d288a62e2999 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -419,7 +419,7 @@ int cap_inode_getsecurity(struct user_namespace *mnt_userns,
 	kroot = make_kuid(fs_ns, root);
 
 	/* If this is an idmapped mount shift the kuid. */
-	kroot = kuid_into_mnt(mnt_userns, kroot);
+	kroot = mapped_kuid_fs(mnt_userns, &init_user_ns, kroot);
 
 	/* If the root kuid maps to a valid uid in current ns, then return
 	 * this as a nscap. */
@@ -489,6 +489,7 @@ int cap_inode_getsecurity(struct user_namespace *mnt_userns,
  * @size:	size of @ivalue
  * @task_ns:	user namespace of the caller
  * @mnt_userns:	user namespace of the mount the inode was found from
+ * @fs_userns:	user namespace of the filesystem
  *
  * If the inode has been found through an idmapped mount the user namespace of
  * the vfsmount must be passed through @mnt_userns. This function will then
@@ -498,7 +499,8 @@ int cap_inode_getsecurity(struct user_namespace *mnt_userns,
  */
 static kuid_t rootid_from_xattr(const void *value, size_t size,
 				struct user_namespace *task_ns,
-				struct user_namespace *mnt_userns)
+				struct user_namespace *mnt_userns,
+				struct user_namespace *fs_userns)
 {
 	const struct vfs_ns_cap_data *nscap = value;
 	kuid_t rootkid;
@@ -508,7 +510,7 @@ static kuid_t rootid_from_xattr(const void *value, size_t size,
 		rootid = le32_to_cpu(nscap->rootid);
 
 	rootkid = make_kuid(task_ns, rootid);
-	return kuid_from_mnt(mnt_userns, rootkid);
+	return mapped_kuid_user(mnt_userns, fs_userns, rootkid);
 }
 
 static bool validheader(size_t size, const struct vfs_cap_data *cap)
@@ -559,7 +561,8 @@ int cap_convert_nscap(struct user_namespace *mnt_userns, struct dentry *dentry,
 			/* user is privileged, just write the v2 */
 			return size;
 
-	rootid = rootid_from_xattr(*ivalue, size, task_ns, mnt_userns);
+	rootid = rootid_from_xattr(*ivalue, size, task_ns, mnt_userns,
+				   &init_user_ns);
 	if (!uid_valid(rootid))
 		return -EINVAL;
 
@@ -700,7 +703,7 @@ int get_vfs_caps_from_disk(struct user_namespace *mnt_userns,
 	/* Limit the caps to the mounter of the filesystem
 	 * or the more limited uid specified in the xattr.
 	 */
-	rootkuid = kuid_into_mnt(mnt_userns, rootkuid);
+	rootkuid = mapped_kuid_fs(mnt_userns, &init_user_ns, rootkuid);
 	if (!rootid_owns_currentns(rootkuid))
 		return -ENODATA;
 
-- 
2.30.2

