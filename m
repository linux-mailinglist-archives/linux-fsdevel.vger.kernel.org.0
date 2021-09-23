Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA0BC416258
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 17:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242081AbhIWPsg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Sep 2021 11:48:36 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:40508 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242016AbhIWPsU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Sep 2021 11:48:20 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id A7DFA82255;
        Thu, 23 Sep 2021 18:45:44 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1632411944;
        bh=1Rg2zXZ/vgixRrUZ0go+XppCVTwHrFXwMt2I9sXaE38=;
        h=Date:Subject:From:To:References:CC:In-Reply-To;
        b=H7Y1VQG4nfpOb2qXJVQVZXs/x7vb9PI2NnD363MYSKG/mxYaylCn4lpFS0m/lqcXc
         FhVOtOZRN4hv7INYOOJfSu5nF3pMn7lhoi5gwzvCx9UnuigzCVOA7gNakFsq1xARSy
         69bhEfKSbLPWBXCoGcjULONIiW9VRBjK9WZkerag=
Received: from [192.168.211.73] (192.168.211.73) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 23 Sep 2021 18:45:44 +0300
Message-ID: <894082b3-16c2-d9bd-13c3-476c0a80308a@paragon-software.com>
Date:   Thu, 23 Sep 2021 18:45:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: [PATCH v2 6/6] fs/ntfs3: Refactoring lock in ntfs_init_acl
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
References: <a740b507-40d5-0712-af7c-9706d0b11706@paragon-software.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
In-Reply-To: <a740b507-40d5-0712-af7c-9706d0b11706@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.73]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is possible because of moving lock into ntfs_create_inode.

Reviewed-by: Kari Argillander <kari.argillander@gmail.com>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/xattr.c | 55 ++++++++++++------------------------------------
 1 file changed, 14 insertions(+), 41 deletions(-)

diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index 59ec5e61a239..83bbee277e12 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -693,54 +693,27 @@ int ntfs_init_acl(struct user_namespace *mnt_userns, struct inode *inode,
 	struct posix_acl *default_acl, *acl;
 	int err;
 
-	/*
-	 * TODO: Refactoring lock.
-	 * ni_lock(dir) ... -> posix_acl_create(dir,...) -> ntfs_get_acl -> ni_lock(dir)
-	 */
-	inode->i_default_acl = NULL;
-
-	default_acl = ntfs_get_acl_ex(mnt_userns, dir, ACL_TYPE_DEFAULT, 1);
-
-	if (!default_acl || default_acl == ERR_PTR(-EOPNOTSUPP)) {
-		inode->i_mode &= ~current_umask();
-		err = 0;
-		goto out;
-	}
-
-	if (IS_ERR(default_acl)) {
-		err = PTR_ERR(default_acl);
-		goto out;
-	}
-
-	acl = default_acl;
-	err = __posix_acl_create(&acl, GFP_NOFS, &inode->i_mode);
-	if (err < 0)
-		goto out1;
-	if (!err) {
-		posix_acl_release(acl);
-		acl = NULL;
-	}
-
-	if (!S_ISDIR(inode->i_mode)) {
-		posix_acl_release(default_acl);
-		default_acl = NULL;
-	}
+	err = posix_acl_create(dir, &inode->i_mode, &default_acl, &acl);
+	if (err)
+		return err;
 
-	if (default_acl)
+	if (default_acl) {
 		err = ntfs_set_acl_ex(mnt_userns, inode, default_acl,
 				      ACL_TYPE_DEFAULT, 1);
+		posix_acl_release(default_acl);
+	} else {
+		inode->i_default_acl = NULL;
+	}
 
 	if (!acl)
 		inode->i_acl = NULL;
-	else if (!err)
-		err = ntfs_set_acl_ex(mnt_userns, inode, acl, ACL_TYPE_ACCESS,
-				      1);
-
-	posix_acl_release(acl);
-out1:
-	posix_acl_release(default_acl);
+	else {
+		if (!err)
+			err = ntfs_set_acl_ex(mnt_userns, inode, acl,
+					      ACL_TYPE_ACCESS, 1);
+		posix_acl_release(acl);
+	}
 
-out:
 	return err;
 }
 #endif
-- 
2.33.0


