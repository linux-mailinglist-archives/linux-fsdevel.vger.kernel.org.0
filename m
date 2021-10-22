Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02B20437A70
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 17:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233327AbhJVP6C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 11:58:02 -0400
Received: from relayfre-01.paragon-software.com ([176.12.100.13]:39306 "EHLO
        relayfre-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229484AbhJVP6C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 11:58:02 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 2D2E1120;
        Fri, 22 Oct 2021 18:55:43 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1634918143;
        bh=Wn/r66Xo92cyYiPwrwn5OvVSntGoTZBUeMOL1dDTl/I=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=DWrRPyL3zuCWToOCbHU/xZp28ezdMWx0UN7j9R8zX71M9FfhnGs4qLUUQ6EDnp6Fm
         WU8e2nQOmwEGgX0JQOdmB1Q/8qGuuBxiB6EKfg3jLnYsbzNEJ7YI8rK4xsQu6j/xE/
         VdhLOSWQsnA77ooFmLGLacYQCl7ZIjotDCpIB4fk=
Received: from [192.168.211.69] (192.168.211.69) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 22 Oct 2021 18:55:42 +0300
Message-ID: <f8c4d63d-1296-ede2-50b9-242f52b856ed@paragon-software.com>
Date:   Fri, 22 Oct 2021 18:55:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: [PATCH 3/4] fs/ntfs3: Optimize locking in ntfs_save_wsl_perm
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <09b42386-3e6d-df23-12c2-23c2718f766b@paragon-software.com>
In-Reply-To: <09b42386-3e6d-df23-12c2-23c2718f766b@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.69]
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Right now in ntfs_save_wsl_perm we lock/unlock 4 times.
This commit fixes this situation.
We add "locked" argument to ntfs_set_ea.

Suggested-by: Kari Argillander <kari.argillander@gmail.com>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/xattr.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index 62605781790b..bc3144608ce1 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -259,7 +259,7 @@ static int ntfs_get_ea(struct inode *inode, const char *name, size_t name_len,
 
 static noinline int ntfs_set_ea(struct inode *inode, const char *name,
 				size_t name_len, const void *value,
-				size_t val_size, int flags)
+				size_t val_size, int flags, bool locked)
 {
 	struct ntfs_inode *ni = ntfs_i(inode);
 	struct ntfs_sb_info *sbi = ni->mi.sbi;
@@ -278,7 +278,8 @@ static noinline int ntfs_set_ea(struct inode *inode, const char *name,
 	u64 new_sz;
 	void *p;
 
-	ni_lock(ni);
+	if (!locked)
+		ni_lock(ni);
 
 	run_init(&ea_run);
 
@@ -467,7 +468,8 @@ static noinline int ntfs_set_ea(struct inode *inode, const char *name,
 	mark_inode_dirty(&ni->vfs_inode);
 
 out:
-	ni_unlock(ni);
+	if (!locked)
+		ni_unlock(ni);
 
 	run_close(&ea_run);
 	kfree(ea_all);
@@ -595,7 +597,7 @@ static noinline int ntfs_set_acl_ex(struct user_namespace *mnt_userns,
 		flags = 0;
 	}
 
-	err = ntfs_set_ea(inode, name, name_len, value, size, flags);
+	err = ntfs_set_ea(inode, name, name_len, value, size, flags, 0);
 	if (err == -ENODATA && !size)
 		err = 0; /* Removing non existed xattr. */
 	if (!err)
@@ -989,7 +991,7 @@ static noinline int ntfs_setxattr(const struct xattr_handler *handler,
 	}
 #endif
 	/* Deal with NTFS extended attribute. */
-	err = ntfs_set_ea(inode, name, name_len, value, size, flags);
+	err = ntfs_set_ea(inode, name, name_len, value, size, flags, 0);
 
 out:
 	return err;
@@ -1004,35 +1006,37 @@ int ntfs_save_wsl_perm(struct inode *inode)
 {
 	int err;
 	__le32 value;
+	struct ntfs_inode *ni = ntfs_i(inode);
 
-	/* TODO: refactor this, so we don't lock 4 times in ntfs_set_ea */
+	ni_lock(ni);
 	value = cpu_to_le32(i_uid_read(inode));
 	err = ntfs_set_ea(inode, "$LXUID", sizeof("$LXUID") - 1, &value,
-			  sizeof(value), 0);
+			  sizeof(value), 0, true); /* true == already locked. */
 	if (err)
 		goto out;
 
 	value = cpu_to_le32(i_gid_read(inode));
 	err = ntfs_set_ea(inode, "$LXGID", sizeof("$LXGID") - 1, &value,
-			  sizeof(value), 0);
+			  sizeof(value), 0, true);
 	if (err)
 		goto out;
 
 	value = cpu_to_le32(inode->i_mode);
 	err = ntfs_set_ea(inode, "$LXMOD", sizeof("$LXMOD") - 1, &value,
-			  sizeof(value), 0);
+			  sizeof(value), 0, true);
 	if (err)
 		goto out;
 
 	if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode)) {
 		value = cpu_to_le32(inode->i_rdev);
 		err = ntfs_set_ea(inode, "$LXDEV", sizeof("$LXDEV") - 1, &value,
-				  sizeof(value), 0);
+				  sizeof(value), 0, true);
 		if (err)
 			goto out;
 	}
 
 out:
+	ni_unlock(ni);
 	/* In case of error should we delete all WSL xattr? */
 	return err;
 }
-- 
2.33.0


