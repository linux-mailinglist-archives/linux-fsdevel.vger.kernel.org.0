Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 753C646760B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Dec 2021 12:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380300AbhLCLVG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Dec 2021 06:21:06 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:47734 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380325AbhLCLVF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Dec 2021 06:21:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BF933B826A9
        for <linux-fsdevel@vger.kernel.org>; Fri,  3 Dec 2021 11:17:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7F10C53FC7;
        Fri,  3 Dec 2021 11:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638530259;
        bh=dgj35db/QmIDp78wYC4kD6ATW1vp/xFpo0/ZDZLgjgU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gucf7O4Aq5OT8pCUieQdNzwKrz3rRlZGLBoFb3khnjYXgc8vs1miNWcLZSb/GMn8H
         cIA1cbWPh271kuFX11I10z6OVR3vz6znwy/eMra/ITcV0pN604l/2YSZm6B85U+d8E
         o3Ks1v5WTN61D48YXKCcNPWia7SpO6zWgJ4fOW0lQ7/TG+j++odBwemJCZRfUah8RO
         lt+cCdGNNLkZua5nsM6UyD9VZOT2KSTKAebVSWiAOnsXjkwlHFN+WA9WzLbIDrwgxx
         lplemv7VLi6qM40KsHxCQs8TKcdmBYt9aejf80nMG8LmeR9twrv9YZB3deb2eDKucl
         5IfQBhVuVvW4A==
From:   Christian Brauner <brauner@kernel.org>
To:     Seth Forshee <sforshee@digitalocean.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v3 04/10] fs: account for filesystem mappings
Date:   Fri,  3 Dec 2021 12:17:01 +0100
Message-Id: <20211203111707.3901969-5-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211203111707.3901969-1-brauner@kernel.org>
References: <20211203111707.3901969-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13647; h=from:subject; bh=jjNGrNtoYJ7pOvFdgJtNyY+SCbQD+4DaDb6evReBR0k=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSSu/DNtnVj1V4GzDDr+G1aUMh99YTPz9PMpW4xun1nMvuV2 v5f9345SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJhPAwMtxK/tY/y3XeSbdr772zuZ jfi6rIy7DIb/5yo+al8rrX2WoMf7hnWs2ZcuSOpweX/nH+DRcsNfisNZ6fNetIuH5x8pxHZvwA
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Currently we only support idmapped mounts for filesystems mounted
without an idmapping. This was a conscious decision mentioned in
multiple places (cf. e.g. [1]).

As explained at length in [3] it is perfectly fine to extend support for
idmapped mounts to filesystem's mounted with an idmapping should the
need arise. The need has been there for some time now. Various container
projects in userspace need this to run unprivileged and nested
unprivileged containers (cf. [2]).

Before we can port any filesystem that is mountable with an idmapping to
support idmapped mounts we need to first extend the mapping helpers to
account for the filesystem's idmapping. This again, is explained at
length in our documentation at [3] but I'll give an overview here again.

Currently, the low-level mapping helpers implement the remapping
algorithms described in [3] in a simplified manner. Because we could
rely on the fact that all filesystems supporting idmapped mounts are
mounted without an idmapping the translation step from or into the
filesystem idmapping could be skipped.

In order to support idmapped mounts of filesystem's mountable with an
idmapping the translation step we were able to skip before cannot be
skipped anymore. A filesystem mounted with an idmapping is very likely
to not use an identity mapping and will instead use a non-identity
mapping. So the translation step from or into the filesystem's idmapping
in the remapping algorithm cannot be skipped for such filesystems. More
details with examples can be found in [3].

This patch adds a few new and prepares some already existing low-level
mapping helpers to perform the full translation algorithm explained in
[3]. The low-level helpers can be written in a way that they only
perform the additional translation step when the filesystem is indeed
mounted with an idmapping.

If the low-level helpers detect that they are not dealing with an
idmapped mount they can simply return the relevant k{g,u}id unchanged;
no remapping needs to be performed at all. The no_mapping() helper
detects whether the shortcut can be used.

If the low-level helpers detected that they are dealing with an idmapped
mount but the underlying filesystem is mounted without an idmapping we
can rely on the previous shorcut and can continue to skip the
translation step from or into the filesystem's idmapping.

These checks guarantee that only the minimal amount of work is
performed. As before, if idmapped mounts aren't used the low-level
helpers are idempotent and no work is performed at all.

This patch adds the helpers mapped_k{g,u}id_fs() and
mapped_k{g,u}id_user(). Following patches will port all places to
replace the old k{g,u}id_into_mnt() and k{g,u}id_from_mnt() with these
two new helpers. After the conversion is done k{g,u}id_into_mnt() and
k{g,u}id_from_mnt() will be removed. This also concludes the renaming of
the mapping helpers we started in [4]. Now, all mapping helpers will
started with the "mapped_" prefix making everything nice and consistent.

The mapped_k{g,u}id_fs() helpers replace the k{g,u}id_into_mnt()
helpers. They are to be used when k{g,u}ids are to be mapped from the
vfs, e.g. from from struct inode's i_{g,u}id.  Conversely, the
mapped_k{g,u}id_user() helpers replace the k{g,u}id_from_mnt() helpers.
They are to be used when k{g,u}ids are to be written to disk, e.g. when
entering from a system call to change ownership of a file.

This patch only introduces the helpers. It doesn't yet convert the
relevant places to account for filesystem mounted with an idmapping.

[1]: commit 2ca4dcc4909d ("fs/mount_setattr: tighten permission checks")
[2]: https://github.com/containers/podman/issues/10374
[3]: Documentations/filesystems/idmappings.rst
[4]: commit a65e58e791a1 ("fs: document and rename fsid helpers")

Link: https://lore.kernel.org/r/20211123114227.3124056-5-brauner@kernel.org (v1)
Link: https://lore.kernel.org/r/20211130121032.3753852-5-brauner@kernel.org (v2)
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
 include/linux/fs.h            |   4 +-
 include/linux/mnt_idmapping.h | 193 +++++++++++++++++++++++++++++++++-
 2 files changed, 191 insertions(+), 6 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index db5ee15e36b1..57aee6ebba72 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1636,7 +1636,7 @@ static inline void i_gid_write(struct inode *inode, gid_t gid)
 static inline kuid_t i_uid_into_mnt(struct user_namespace *mnt_userns,
 				    const struct inode *inode)
 {
-	return kuid_into_mnt(mnt_userns, inode->i_uid);
+	return mapped_kuid_fs(mnt_userns, &init_user_ns, inode->i_uid);
 }
 
 /**
@@ -1650,7 +1650,7 @@ static inline kuid_t i_uid_into_mnt(struct user_namespace *mnt_userns,
 static inline kgid_t i_gid_into_mnt(struct user_namespace *mnt_userns,
 				    const struct inode *inode)
 {
-	return kgid_into_mnt(mnt_userns, inode->i_gid);
+	return mapped_kgid_fs(mnt_userns, &init_user_ns, inode->i_gid);
 }
 
 /**
diff --git a/include/linux/mnt_idmapping.h b/include/linux/mnt_idmapping.h
index 7ff8b66b80cb..1c75d4e0b123 100644
--- a/include/linux/mnt_idmapping.h
+++ b/include/linux/mnt_idmapping.h
@@ -6,6 +6,11 @@
 #include <linux/uidgid.h>
 
 struct user_namespace;
+/*
+ * Carries the initial idmapping of 0:0:4294967295 which is an identity
+ * mapping. This means that {g,u}id 0 is mapped to {g,u}id 0, {g,u}id 1 is
+ * mapped to {g,u}id 1, [...], {g,u}id 1000 to {g,u}id 1000, [...].
+ */
 extern struct user_namespace init_user_ns;
 
 /**
@@ -64,9 +69,189 @@ static inline kgid_t kgid_from_mnt(struct user_namespace *mnt_userns,
 	return KGIDT_INIT(from_kgid(mnt_userns, kgid));
 }
 
+/**
+ * initial_mapping - check whether this is the initial mapping
+ * @ns: idmapping to check
+ *
+ * Check whether this is the initial mapping, mapping 0 to 0, 1 to 1,
+ * [...], 1000 to 1000 [...].
+ *
+ * Return: true if this is the initial mapping, false if not.
+ */
+static inline bool initial_mapping(const struct user_namespace *ns)
+{
+	return ns == &init_user_ns;
+}
+
+/**
+ * no_mapping - check whether we can skip remapping a kuid/gid
+ * @mnt_userns: the mount's idmapping
+ * @fs_userns: the filesystem's idmapping
+ *
+ * This function can be used to check whether a remapping between two
+ * idmappings is required.
+ * An idmapped mount is a mount that has an idmapping attached to it that
+ * is different from the filsystem's idmapping and the initial idmapping.
+ * If the initial mapping is used or the idmapping of the mount and the
+ * filesystem are identical no remapping is required.
+ *
+ * Return: true if remapping can be skipped, false if not.
+ */
+static inline bool no_mapping(const struct user_namespace *mnt_userns,
+			      const struct user_namespace *fs_userns)
+{
+	return initial_mapping(mnt_userns) || mnt_userns == fs_userns;
+}
+
+/**
+ * mapped_kuid_fs - map a filesystem kuid into a mnt_userns
+ * @mnt_userns: the mount's idmapping
+ * @fs_userns: the filesystem's idmapping
+ * @kuid : kuid to be mapped
+ *
+ * Take a @kuid and remap it from @fs_userns into @mnt_userns. Use this
+ * function when preparing a @kuid to be reported to userspace.
+ *
+ * If no_mapping() determines that this is not an idmapped mount we can
+ * simply return @kuid unchanged.
+ * If initial_mapping() tells us that the filesystem is not mounted with an
+ * idmapping we know the value of @kuid won't change when calling
+ * from_kuid() so we can simply retrieve the value via __kuid_val()
+ * directly.
+ *
+ * Return: @kuid mapped according to @mnt_userns.
+ * If @kuid has no mapping in either @mnt_userns or @fs_userns INVALID_UID is
+ * returned.
+ */
+static inline kuid_t mapped_kuid_fs(struct user_namespace *mnt_userns,
+				    struct user_namespace *fs_userns,
+				    kuid_t kuid)
+{
+	uid_t uid;
+
+	if (no_mapping(mnt_userns, fs_userns))
+		return kuid;
+	if (initial_mapping(fs_userns))
+		uid = __kuid_val(kuid);
+	else
+		uid = from_kuid(fs_userns, kuid);
+	if (uid == (uid_t)-1)
+		return INVALID_UID;
+	return make_kuid(mnt_userns, uid);
+}
+
+/**
+ * mapped_kgid_fs - map a filesystem kgid into a mnt_userns
+ * @mnt_userns: the mount's idmapping
+ * @fs_userns: the filesystem's idmapping
+ * @kgid : kgid to be mapped
+ *
+ * Take a @kgid and remap it from @fs_userns into @mnt_userns. Use this
+ * function when preparing a @kgid to be reported to userspace.
+ *
+ * If no_mapping() determines that this is not an idmapped mount we can
+ * simply return @kgid unchanged.
+ * If initial_mapping() tells us that the filesystem is not mounted with an
+ * idmapping we know the value of @kgid won't change when calling
+ * from_kgid() so we can simply retrieve the value via __kgid_val()
+ * directly.
+ *
+ * Return: @kgid mapped according to @mnt_userns.
+ * If @kgid has no mapping in either @mnt_userns or @fs_userns INVALID_GID is
+ * returned.
+ */
+static inline kgid_t mapped_kgid_fs(struct user_namespace *mnt_userns,
+				    struct user_namespace *fs_userns,
+				    kgid_t kgid)
+{
+	gid_t gid;
+
+	if (no_mapping(mnt_userns, fs_userns))
+		return kgid;
+	if (initial_mapping(fs_userns))
+		gid = __kgid_val(kgid);
+	else
+		gid = from_kgid(fs_userns, kgid);
+	if (gid == (gid_t)-1)
+		return INVALID_GID;
+	return make_kgid(mnt_userns, gid);
+}
+
+/**
+ * mapped_kuid_user - map a user kuid into a mnt_userns
+ * @mnt_userns: the mount's idmapping
+ * @fs_userns: the filesystem's idmapping
+ * @kuid : kuid to be mapped
+ *
+ * Use the idmapping of @mnt_userns to remap a @kuid into @fs_userns. Use this
+ * function when preparing a @kuid to be written to disk or inode.
+ *
+ * If no_mapping() determines that this is not an idmapped mount we can
+ * simply return @kuid unchanged.
+ * If initial_mapping() tells us that the filesystem is not mounted with an
+ * idmapping we know the value of @kuid won't change when calling
+ * make_kuid() so we can simply retrieve the value via KUIDT_INIT()
+ * directly.
+ *
+ * Return: @kuid mapped according to @mnt_userns.
+ * If @kuid has no mapping in either @mnt_userns or @fs_userns INVALID_UID is
+ * returned.
+ */
+static inline kuid_t mapped_kuid_user(struct user_namespace *mnt_userns,
+				      struct user_namespace *fs_userns,
+				      kuid_t kuid)
+{
+	uid_t uid;
+
+	if (no_mapping(mnt_userns, fs_userns))
+		return kuid;
+	uid = from_kuid(mnt_userns, kuid);
+	if (uid == (uid_t)-1)
+		return INVALID_UID;
+	if (initial_mapping(fs_userns))
+		return KUIDT_INIT(uid);
+	return make_kuid(fs_userns, uid);
+}
+
+/**
+ * mapped_kgid_user - map a user kgid into a mnt_userns
+ * @mnt_userns: the mount's idmapping
+ * @fs_userns: the filesystem's idmapping
+ * @kgid : kgid to be mapped
+ *
+ * Use the idmapping of @mnt_userns to remap a @kgid into @fs_userns. Use this
+ * function when preparing a @kgid to be written to disk or inode.
+ *
+ * If no_mapping() determines that this is not an idmapped mount we can
+ * simply return @kgid unchanged.
+ * If initial_mapping() tells us that the filesystem is not mounted with an
+ * idmapping we know the value of @kgid won't change when calling
+ * make_kgid() so we can simply retrieve the value via KGIDT_INIT()
+ * directly.
+ *
+ * Return: @kgid mapped according to @mnt_userns.
+ * If @kgid has no mapping in either @mnt_userns or @fs_userns INVALID_GID is
+ * returned.
+ */
+static inline kgid_t mapped_kgid_user(struct user_namespace *mnt_userns,
+				      struct user_namespace *fs_userns,
+				      kgid_t kgid)
+{
+	gid_t gid;
+
+	if (no_mapping(mnt_userns, fs_userns))
+		return kgid;
+	gid = from_kgid(mnt_userns, kgid);
+	if (gid == (gid_t)-1)
+		return INVALID_GID;
+	if (initial_mapping(fs_userns))
+		return KGIDT_INIT(gid);
+	return make_kgid(fs_userns, gid);
+}
+
 /**
  * mapped_fsuid - return caller's fsuid mapped up into a mnt_userns
- * @mnt_userns: user namespace of the relevant mount
+ * @mnt_userns: the mount's idmapping
  *
  * Use this helper to initialize a new vfs or filesystem object based on
  * the caller's fsuid. A common example is initializing the i_uid field of
@@ -78,12 +263,12 @@ static inline kgid_t kgid_from_mnt(struct user_namespace *mnt_userns,
  */
 static inline kuid_t mapped_fsuid(struct user_namespace *mnt_userns)
 {
-	return kuid_from_mnt(mnt_userns, current_fsuid());
+	return mapped_kuid_user(mnt_userns, &init_user_ns, current_fsuid());
 }
 
 /**
  * mapped_fsgid - return caller's fsgid mapped up into a mnt_userns
- * @mnt_userns: user namespace of the relevant mount
+ * @mnt_userns: the mount's idmapping
  *
  * Use this helper to initialize a new vfs or filesystem object based on
  * the caller's fsgid. A common example is initializing the i_gid field of
@@ -95,7 +280,7 @@ static inline kuid_t mapped_fsuid(struct user_namespace *mnt_userns)
  */
 static inline kgid_t mapped_fsgid(struct user_namespace *mnt_userns)
 {
-	return kgid_from_mnt(mnt_userns, current_fsgid());
+	return mapped_kgid_user(mnt_userns, &init_user_ns, current_fsgid());
 }
 
 #endif /* _LINUX_MNT_MAPPING_H */
-- 
2.30.2

