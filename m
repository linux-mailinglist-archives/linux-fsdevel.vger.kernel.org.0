Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C64D4168525
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 18:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgBURhi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 12:37:38 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53866 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgBURhi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 12:37:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=VwiptHm1mSl+Vnl+5J3QI8OHF+cEw/TKgSSpZHHbYMI=; b=LA5qn90U2myfLLlKsedRTmorGU
        bT2GuA/FspJ4A7dMuZXejKpHEFgJvlgjNn2nbs75ie78vCScAoSPLhUQ9BwFVvRdhoKpWSQ4Hty7m
        E2BkkzFfYyxXHpB2oZc5EI/xDx5fHSlCMv8sbE5NlHPjWGKE2csZJfwXfnkR6DGIt51/5I7swzQxu
        hgnc3oVGtqTaZ/iObth0fzksWNBADxg1GgVSTZrX60KssEixDTW3wEA5wbYXWrXyAUs0tG3u+AYja
        rILuvNd8apn7Y32H6EuEaxSveJEjLU890YnYTxA9K2HRdXE/NeSlgzvWe0WUBo7EzG6JxG/ieqjGi
        V2IOLuLw==;
Received: from [199.255.44.128] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j5CEz-0003UA-4G; Fri, 21 Feb 2020 17:37:29 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     agruenba@redhat.com, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs: move the posix_acl_fix_xattr_{to_from}_user out of xattr code
Date:   Fri, 21 Feb 2020 09:37:22 -0800
Message-Id: <20200221173722.538788-1-hch@lst.de>
X-Mailer: git-send-email 2.24.1
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
 fs/posix_acl.c                  | 62 ++-------------------------------
 fs/xattr.c                      |  8 +----
 include/linux/posix_acl_xattr.h | 12 -------
 3 files changed, 3 insertions(+), 79 deletions(-)

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
2.24.1

