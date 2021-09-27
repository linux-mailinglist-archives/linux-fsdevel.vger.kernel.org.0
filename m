Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 171234197ED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Sep 2021 17:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235192AbhI0P3y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Sep 2021 11:29:54 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:38593 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234848AbhI0P3x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Sep 2021 11:29:53 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id 96E0F821CB;
        Mon, 27 Sep 2021 18:28:14 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1632756494;
        bh=rprZNUrtIjgbo5BWc8+1kJnJEzUKH9ICwZpB71LnXQc=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=QQg2GGIZcsydKqwJ4M3AlEpOTPlarcWnBPTnmdrTpkq3aWTZKqEfu4R03EZIFf84R
         28kJFxlelcLl9ePyi9A+L/VgbegUhNusoe0zvMAXQ+evMCmJ9+j3/HNxRHRHYyLPTm
         IWRYYPTNIalnBTtsoQT8lJOUPFNMvKFAL8Zg8YEY=
Received: from [192.168.211.27] (192.168.211.27) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 27 Sep 2021 18:28:14 +0300
Message-ID: <60ce825b-90be-4494-e9b6-daaca89fef19@paragon-software.com>
Date:   Mon, 27 Sep 2021 18:28:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: [PATCH v2 2/3] fs/ntfs3: Remove locked argument in ntfs_set_ea
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <a1204ce8-80e6-bf44-e7d1-f1674ff28dcd@paragon-software.com>
In-Reply-To: <a1204ce8-80e6-bf44-e7d1-f1674ff28dcd@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.27]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We always need to lock now, because locks became smaller
(see d562e901f25d
"fs/ntfs3: Move ni_lock_dir and ni_unlock into ntfs_create_inode").

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/xattr.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index 253a07d9aa7b..1ab109723b10 100644
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
@@ -1006,26 +1004,26 @@ int ntfs_save_wsl_perm(struct inode *inode)
 
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


