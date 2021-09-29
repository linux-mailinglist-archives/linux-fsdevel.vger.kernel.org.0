Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2823A41CA9B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Sep 2021 18:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245177AbhI2QwF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Sep 2021 12:52:05 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:56393 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243893AbhI2QwF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Sep 2021 12:52:05 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id 4C4408230F;
        Wed, 29 Sep 2021 19:50:22 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1632934222;
        bh=7X851HtkJPAS2V8WLLShNqW7WJirdJyqwC0kSN9mDpA=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=IjsvK9i2qTNeA/REhvpVP/JOxZWdTYh9VqEcBNke30esEF4W7iiDZSF0ihmPJKpBn
         bg4xkGZvXVBHhKAmsDvx6voXl3vOCRZp+zr+U6YgBx3aL9BblQMAcjTRafsNOVI6oi
         q0PGLtq/Oly4fwpkIAeWyDK4MssavDoI2Zr/cEhU=
Received: from [192.168.211.131] (192.168.211.131) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 29 Sep 2021 19:50:21 +0300
Message-ID: <7584e179-eade-fef9-9da1-39cbb4d1ef32@paragon-software.com>
Date:   Wed, 29 Sep 2021 19:50:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: [PATCH v3 2/3] fs/ntfs3: Remove locked argument in ntfs_set_ea
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <kari.argillander@gmail.com>
References: <1514c7ce-9b2c-fc12-75c4-3b4cfd2639a5@paragon-software.com>
In-Reply-To: <1514c7ce-9b2c-fc12-75c4-3b4cfd2639a5@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.131]
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We always need to lock now, because locks became smaller
(see d562e901f25d
"fs/ntfs3: Move ni_lock_dir and ni_unlock into ntfs_create_inode").

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/xattr.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index 253a07d9aa7b..29f571b53083 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -257,7 +257,7 @@ static int ntfs_get_ea(struct inode *inode, const char *name, size_t name_len,
 
 static noinline int ntfs_set_ea(struct inode *inode, const char *name,
 				size_t name_len, const void *value,
-				size_t val_size, int flags, int locked)
+				size_t val_size, int flags)
 {
 	struct ntfs_inode *ni = ntfs_i(inode);
 	struct ntfs_sb_info *sbi = ni->mi.sbi;
@@ -276,8 +276,7 @@ static noinline int ntfs_set_ea(struct inode *inode, const char *name,
 	u64 new_sz;
 	void *p;
 
-	if (!locked)
-		ni_lock(ni);
+	ni_lock(ni);
 
 	run_init(&ea_run);
 
@@ -465,8 +464,7 @@ static noinline int ntfs_set_ea(struct inode *inode, const char *name,
 	mark_inode_dirty(&ni->vfs_inode);
 
 out:
-	if (!locked)
-		ni_unlock(ni);
+	ni_unlock(ni);
 
 	run_close(&ea_run);
 	kfree(ea_all);
@@ -537,7 +535,7 @@ struct posix_acl *ntfs_get_acl(struct inode *inode, int type)
 
 static noinline int ntfs_set_acl_ex(struct user_namespace *mnt_userns,
 				    struct inode *inode, struct posix_acl *acl,
-				    int type, int locked)
+				    int type)
 {
 	const char *name;
 	size_t size, name_len;
@@ -594,7 +592,7 @@ static noinline int ntfs_set_acl_ex(struct user_namespace *mnt_userns,
 		flags = 0;
 	}
 
-	err = ntfs_set_ea(inode, name, name_len, value, size, flags, locked);
+	err = ntfs_set_ea(inode, name, name_len, value, size, flags);
 	if (err == -ENODATA && !size)
 		err = 0; /* Removing non existed xattr. */
 	if (!err)
@@ -612,7 +610,7 @@ static noinline int ntfs_set_acl_ex(struct user_namespace *mnt_userns,
 int ntfs_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
 		 struct posix_acl *acl, int type)
 {
-	return ntfs_set_acl_ex(mnt_userns, inode, acl, type, 0);
+	return ntfs_set_acl_ex(mnt_userns, inode, acl, type);
 }
 
 static int ntfs_xattr_get_acl(struct user_namespace *mnt_userns,
@@ -693,7 +691,7 @@ int ntfs_init_acl(struct user_namespace *mnt_userns, struct inode *inode,
 
 	if (default_acl) {
 		err = ntfs_set_acl_ex(mnt_userns, inode, default_acl,
-				      ACL_TYPE_DEFAULT, 1);
+				      ACL_TYPE_DEFAULT);
 		posix_acl_release(default_acl);
 	} else {
 		inode->i_default_acl = NULL;
@@ -704,7 +702,7 @@ int ntfs_init_acl(struct user_namespace *mnt_userns, struct inode *inode,
 	else {
 		if (!err)
 			err = ntfs_set_acl_ex(mnt_userns, inode, acl,
-					      ACL_TYPE_ACCESS, 1);
+					      ACL_TYPE_ACCESS);
 		posix_acl_release(acl);
 	}
 
@@ -988,7 +986,7 @@ static noinline int ntfs_setxattr(const struct xattr_handler *handler,
 	}
 #endif
 	/* Deal with NTFS extended attribute. */
-	err = ntfs_set_ea(inode, name, name_len, value, size, flags, 0);
+	err = ntfs_set_ea(inode, name, name_len, value, size, flags);
 
 out:
 	return err;
@@ -1004,28 +1002,29 @@ int ntfs_save_wsl_perm(struct inode *inode)
 	int err;
 	__le32 value;
 
+	/* TODO: refactor this, so we don't lock 4 times in ntfs_set_ea */
 	value = cpu_to_le32(i_uid_read(inode));
 	err = ntfs_set_ea(inode, "$LXUID", sizeof("$LXUID") - 1, &value,
-			  sizeof(value), 0, 0);
+			  sizeof(value), 0);
 	if (err)
 		goto out;
 
 	value = cpu_to_le32(i_gid_read(inode));
 	err = ntfs_set_ea(inode, "$LXGID", sizeof("$LXGID") - 1, &value,
-			  sizeof(value), 0, 0);
+			  sizeof(value), 0);
 	if (err)
 		goto out;
 
 	value = cpu_to_le32(inode->i_mode);
 	err = ntfs_set_ea(inode, "$LXMOD", sizeof("$LXMOD") - 1, &value,
-			  sizeof(value), 0, 0);
+			  sizeof(value), 0);
 	if (err)
 		goto out;
 
 	if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode)) {
 		value = cpu_to_le32(inode->i_rdev);
 		err = ntfs_set_ea(inode, "$LXDEV", sizeof("$LXDEV") - 1, &value,
-				  sizeof(value), 0, 0);
+				  sizeof(value), 0);
 		if (err)
 			goto out;
 	}
-- 
2.33.0

