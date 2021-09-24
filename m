Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26FB5417850
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Sep 2021 18:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347340AbhIXQR0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Sep 2021 12:17:26 -0400
Received: from relayfre-01.paragon-software.com ([176.12.100.13]:55400 "EHLO
        relayfre-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347180AbhIXQRZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Sep 2021 12:17:25 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id F36081D45;
        Fri, 24 Sep 2021 19:15:50 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1632500151;
        bh=VkQc8QexnqnEiUiAFw9cRFlj7JXyyv50oUIPsw+VZnU=;
        h=Date:Subject:From:To:References:CC:In-Reply-To;
        b=ZeE9kDW/jUOcLNk36PRgtIHYVjx6NF1sgBIuxgJaC517RLsD2UMYxLffKhglT9s01
         HWJw5CqXvuqQKRHf7NvHfXN1+Fc0L3IZ73Zkf+H3r65tsFtYdwX5nDMV+vPkOLp2FS
         Rul0Uno+KUtAjZuK9WHCiRKHRcJ+Ec+6QoOAtXAw=
Received: from [192.168.211.101] (192.168.211.101) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 24 Sep 2021 19:15:50 +0300
Message-ID: <b988b38f-ccca-df01-d90d-10f83dd3ad2e@paragon-software.com>
Date:   Fri, 24 Sep 2021 19:15:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: [PATCH 2/3] fs/ntfs3: Remove locked argument in ntfs_set_ea
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
References: <eb131ee0-3e89-da58-650c-5b84dd792a49@paragon-software.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
In-Reply-To: <eb131ee0-3e89-da58-650c-5b84dd792a49@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.101]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We always need to lock now, because locks became smaller
(see "Move ni_lock_dir and ni_unlock into ntfs_create_inode").

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


