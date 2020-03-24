Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC8A01906CB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Mar 2020 08:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbgCXHu1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Mar 2020 03:50:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55450 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbgCXHu1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Mar 2020 03:50:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=9oASgj5S/eOaO9siKdS9EbfS3uyef2jnrdmIdIh+T+w=; b=SZDUdxLKtkAAoEib7yWUeAeR64
        Jyq1u0Gz8S03wILe1oSD5fxrre9nCsMOa7cAH+PMXtGD5tBhe7FTBQTAJWjRoVI/vG/czrP4y8k3p
        sNh0qJhyufycdOmdPeBflVqPk35YM1ErDxKIQd7L7hFCcd1KYXCkvnAzmQlAfdEaGSWi5yMpg91S2
        AWbGGJ1+kSPJn0WojfKIsYWDWIDgytbJIXFksehzNh8KopCyDoqqyIcVLzDCxYEGR/JQKZAlZfPIV
        Dc6Kfvszc3Fiqw3UVtA9kis147FdeFlME0u/2Gppq1sOTO/rhAciOvPT0iPfgcFI8itG1qHVOT9ZQ
        mj8kfObQ==;
Received: from [2001:4bb8:18c:2a9e:999c:283e:b14a:9189] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGeKJ-0002cf-Ml; Tue, 24 Mar 2020 07:50:20 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     viro@zeniv.linux.org.uk, agruenba@redhat.com
Cc:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs: move the posix_acl_fix_xattr_{to_from}_user out of xattr code
Date:   Tue, 24 Mar 2020 08:50:17 +0100
Message-Id: <20200324075017.545209-1-hch@lst.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is no excuse to ever perform actions related to a specific handler
directly from the generic xattr code as we have handler that understand
the specific data in given attrs.  As a nice sideeffect this removes
tons of pointless boilerplate code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---

Changes since v1:
 - fix up file systems that have their own ACL xattr handlers

 fs/9p/acl.c                     |  4 +--
 fs/overlayfs/dir.c              |  2 +-
 fs/overlayfs/super.c            |  2 +-
 fs/posix_acl.c                  | 62 ++-------------------------------
 fs/xattr.c                      |  8 +----
 include/linux/posix_acl_xattr.h | 12 -------
 6 files changed, 7 insertions(+), 83 deletions(-)

diff --git a/fs/9p/acl.c b/fs/9p/acl.c
index 6261719f6f2a..f3455ba2a84d 100644
--- a/fs/9p/acl.c
+++ b/fs/9p/acl.c
@@ -232,7 +232,7 @@ static int v9fs_xattr_get_acl(const struct xattr_handler *handler,
 		return PTR_ERR(acl);
 	if (acl == NULL)
 		return -ENODATA;
-	error = posix_acl_to_xattr(&init_user_ns, acl, buffer, size);
+	error = posix_acl_to_xattr(current_user_ns(), acl, buffer, size);
 	posix_acl_release(acl);
 
 	return error;
@@ -262,7 +262,7 @@ static int v9fs_xattr_set_acl(const struct xattr_handler *handler,
 		return -EPERM;
 	if (value) {
 		/* update the cached acl value */
-		acl = posix_acl_from_xattr(&init_user_ns, value, size);
+		acl = posix_acl_from_xattr(current_user_ns(), value, size);
 		if (IS_ERR(acl))
 			return PTR_ERR(acl);
 		else if (acl) {
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 8e57d5372b8f..0b07e99475fd 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -416,7 +416,7 @@ static int ovl_set_upper_acl(struct dentry *upperdentry, const char *name,
 	if (!buffer)
 		return -ENOMEM;
 
-	err = posix_acl_to_xattr(&init_user_ns, acl, buffer, size);
+	err = posix_acl_to_xattr(current_user_ns(), acl, buffer, size);
 	if (err < 0)
 		goto out_free;
 
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 319fe0d355b0..4c62636f295b 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -874,7 +874,7 @@ ovl_posix_acl_xattr_set(const struct xattr_handler *handler,
 
 	/* Check that everything is OK before copy-up */
 	if (value) {
-		acl = posix_acl_from_xattr(&init_user_ns, value, size);
+		acl = posix_acl_from_xattr(current_user_ns(), value, size);
 		if (IS_ERR(acl))
 			return PTR_ERR(acl);
 	}
diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 249672bf54fe..09f1b7d186f0 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -663,64 +663,6 @@ int posix_acl_update_mode(struct inode *inode, umode_t *mode_p,
 }
 EXPORT_SYMBOL(posix_acl_update_mode);
 
-/*
- * Fix up the uids and gids in posix acl extended attributes in place.
- */
-static void posix_acl_fix_xattr_userns(
-	struct user_namespace *to, struct user_namespace *from,
-	void *value, size_t size)
-{
-	struct posix_acl_xattr_header *header = value;
-	struct posix_acl_xattr_entry *entry = (void *)(header + 1), *end;
-	int count;
-	kuid_t uid;
-	kgid_t gid;
-
-	if (!value)
-		return;
-	if (size < sizeof(struct posix_acl_xattr_header))
-		return;
-	if (header->a_version != cpu_to_le32(POSIX_ACL_XATTR_VERSION))
-		return;
-
-	count = posix_acl_xattr_count(size);
-	if (count < 0)
-		return;
-	if (count == 0)
-		return;
-
-	for (end = entry + count; entry != end; entry++) {
-		switch(le16_to_cpu(entry->e_tag)) {
-		case ACL_USER:
-			uid = make_kuid(from, le32_to_cpu(entry->e_id));
-			entry->e_id = cpu_to_le32(from_kuid(to, uid));
-			break;
-		case ACL_GROUP:
-			gid = make_kgid(from, le32_to_cpu(entry->e_id));
-			entry->e_id = cpu_to_le32(from_kgid(to, gid));
-			break;
-		default:
-			break;
-		}
-	}
-}
-
-void posix_acl_fix_xattr_from_user(void *value, size_t size)
-{
-	struct user_namespace *user_ns = current_user_ns();
-	if (user_ns == &init_user_ns)
-		return;
-	posix_acl_fix_xattr_userns(&init_user_ns, user_ns, value, size);
-}
-
-void posix_acl_fix_xattr_to_user(void *value, size_t size)
-{
-	struct user_namespace *user_ns = current_user_ns();
-	if (user_ns == &init_user_ns)
-		return;
-	posix_acl_fix_xattr_userns(user_ns, &init_user_ns, value, size);
-}
-
 /*
  * Convert from extended attribute to in-memory representation.
  */
@@ -851,7 +793,7 @@ posix_acl_xattr_get(const struct xattr_handler *handler,
 	if (acl == NULL)
 		return -ENODATA;
 
-	error = posix_acl_to_xattr(&init_user_ns, acl, value, size);
+	error = posix_acl_to_xattr(current_user_ns(), acl, value, size);
 	posix_acl_release(acl);
 
 	return error;
@@ -889,7 +831,7 @@ posix_acl_xattr_set(const struct xattr_handler *handler,
 	int ret;
 
 	if (value) {
-		acl = posix_acl_from_xattr(&init_user_ns, value, size);
+		acl = posix_acl_from_xattr(current_user_ns(), value, size);
 		if (IS_ERR(acl))
 			return PTR_ERR(acl);
 	}
diff --git a/fs/xattr.c b/fs/xattr.c
index 90dd78f0eb27..c31e9a9ea172 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -437,10 +437,7 @@ setxattr(struct dentry *d, const char __user *name, const void __user *value,
 			error = -EFAULT;
 			goto out;
 		}
-		if ((strcmp(kname, XATTR_NAME_POSIX_ACL_ACCESS) == 0) ||
-		    (strcmp(kname, XATTR_NAME_POSIX_ACL_DEFAULT) == 0))
-			posix_acl_fix_xattr_from_user(kvalue, size);
-		else if (strcmp(kname, XATTR_NAME_CAPS) == 0) {
+		if (strcmp(kname, XATTR_NAME_CAPS) == 0) {
 			error = cap_convert_nscap(d, &kvalue, size);
 			if (error < 0)
 				goto out;
@@ -537,9 +534,6 @@ getxattr(struct dentry *d, const char __user *name, void __user *value,
 
 	error = vfs_getxattr(d, kname, kvalue, size);
 	if (error > 0) {
-		if ((strcmp(kname, XATTR_NAME_POSIX_ACL_ACCESS) == 0) ||
-		    (strcmp(kname, XATTR_NAME_POSIX_ACL_DEFAULT) == 0))
-			posix_acl_fix_xattr_to_user(kvalue, error);
 		if (size && copy_to_user(value, kvalue, error))
 			error = -EFAULT;
 	} else if (error == -ERANGE && size >= XATTR_SIZE_MAX) {
diff --git a/include/linux/posix_acl_xattr.h b/include/linux/posix_acl_xattr.h
index 2387709991b5..8f5e70a1bd05 100644
--- a/include/linux/posix_acl_xattr.h
+++ b/include/linux/posix_acl_xattr.h
@@ -32,18 +32,6 @@ posix_acl_xattr_count(size_t size)
 	return size / sizeof(struct posix_acl_xattr_entry);
 }
 
-#ifdef CONFIG_FS_POSIX_ACL
-void posix_acl_fix_xattr_from_user(void *value, size_t size);
-void posix_acl_fix_xattr_to_user(void *value, size_t size);
-#else
-static inline void posix_acl_fix_xattr_from_user(void *value, size_t size)
-{
-}
-static inline void posix_acl_fix_xattr_to_user(void *value, size_t size)
-{
-}
-#endif
-
 struct posix_acl *posix_acl_from_xattr(struct user_namespace *user_ns, 
 				       const void *value, size_t size);
 int posix_acl_to_xattr(struct user_namespace *user_ns,
-- 
2.25.1

