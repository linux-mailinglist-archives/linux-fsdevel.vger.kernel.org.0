Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBF61437A6E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 17:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233362AbhJVP5a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 11:57:30 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:45285 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232835AbhJVP53 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 11:57:29 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id 2C9BD822B4;
        Fri, 22 Oct 2021 18:55:10 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1634918110;
        bh=NGm3n9EZ89JB++7YslZ4cPMC8+rhK+zY0A+tJ4XHVLo=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=EeW58w0/AgVrR2NK/DAi/L60A6mrViXJ9kRcu72zCeqtnXb3fmBkBQDPXGT3Y66X7
         /6c/Ymdft00VeyAZ126xtaf1S/mWAEJgBPBy5L1G2fyQ9GhtbvE8s454CQ0VlgTKje
         MD3U0Uv635pKLYQgsIDLzhAAXtmELUOu42PVxrhM=
Received: from [192.168.211.69] (192.168.211.69) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 22 Oct 2021 18:55:09 +0300
Message-ID: <0aad4d9e-983b-6a79-15c1-61743081a1b3@paragon-software.com>
Date:   Fri, 22 Oct 2021 18:55:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: [PATCH 2/4] fs/ntfs3: Restore ntfs_xattr_get_acl and
 ntfs_xattr_set_acl functions
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

Apparently we need to maintain these functions with
ntfs_get_acl_ex and ntfs_set_acl_ex.
This commit fixes xfstest generic/099
Fixes: 95dd8b2c1ed0 ("fs/ntfs3: Remove unnecessary functions")

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/xattr.c | 96 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 95 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index 2143099cffdf..62605781790b 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -112,7 +112,7 @@ static int ntfs_read_ea(struct ntfs_inode *ni, struct EA_FULL **ea,
 		return -ENOMEM;
 
 	if (!size) {
-		;
+		/* EA info persists, but xattr is empty. Looks like EA problem. */
 	} else if (attr_ea->non_res) {
 		struct runs_tree run;
 
@@ -616,6 +616,67 @@ int ntfs_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
 	return ntfs_set_acl_ex(mnt_userns, inode, acl, type);
 }
 
+static int ntfs_xattr_get_acl(struct user_namespace *mnt_userns,
+			      struct inode *inode, int type, void *buffer,
+			      size_t size)
+{
+	struct posix_acl *acl;
+	int err;
+
+	if (!(inode->i_sb->s_flags & SB_POSIXACL)) {
+		ntfs_inode_warn(inode, "add mount option \"acl\" to use acl");
+		return -EOPNOTSUPP;
+	}
+
+	acl = ntfs_get_acl(inode, type, false);
+	if (IS_ERR(acl))
+		return PTR_ERR(acl);
+
+	if (!acl)
+		return -ENODATA;
+
+	err = posix_acl_to_xattr(mnt_userns, acl, buffer, size);
+	posix_acl_release(acl);
+
+	return err;
+}
+
+static int ntfs_xattr_set_acl(struct user_namespace *mnt_userns,
+			      struct inode *inode, int type, const void *value,
+			      size_t size)
+{
+	struct posix_acl *acl;
+	int err;
+
+	if (!(inode->i_sb->s_flags & SB_POSIXACL)) {
+		ntfs_inode_warn(inode, "add mount option \"acl\" to use acl");
+		return -EOPNOTSUPP;
+	}
+
+	if (!inode_owner_or_capable(mnt_userns, inode))
+		return -EPERM;
+
+	if (!value) {
+		acl = NULL;
+	} else {
+		acl = posix_acl_from_xattr(mnt_userns, value, size);
+		if (IS_ERR(acl))
+			return PTR_ERR(acl);
+
+		if (acl) {
+			err = posix_acl_valid(mnt_userns, acl);
+			if (err)
+				goto release_and_out;
+		}
+	}
+
+	err = ntfs_set_acl(mnt_userns, inode, acl, type);
+
+release_and_out:
+	posix_acl_release(acl);
+	return err;
+}
+
 /*
  * ntfs_init_acl - Initialize the ACLs of a new inode.
  *
@@ -782,6 +843,23 @@ static int ntfs_getxattr(const struct xattr_handler *handler, struct dentry *de,
 		goto out;
 	}
 
+#ifdef CONFIG_NTFS3_FS_POSIX_ACL
+	if ((name_len == sizeof(XATTR_NAME_POSIX_ACL_ACCESS) - 1 &&
+	     !memcmp(name, XATTR_NAME_POSIX_ACL_ACCESS,
+		     sizeof(XATTR_NAME_POSIX_ACL_ACCESS))) ||
+	    (name_len == sizeof(XATTR_NAME_POSIX_ACL_DEFAULT) - 1 &&
+	     !memcmp(name, XATTR_NAME_POSIX_ACL_DEFAULT,
+		     sizeof(XATTR_NAME_POSIX_ACL_DEFAULT)))) {
+		/* TODO: init_user_ns? */
+		err = ntfs_xattr_get_acl(
+			&init_user_ns, inode,
+			name_len == sizeof(XATTR_NAME_POSIX_ACL_ACCESS) - 1
+				? ACL_TYPE_ACCESS
+				: ACL_TYPE_DEFAULT,
+			buffer, size);
+		goto out;
+	}
+#endif
 	/* Deal with NTFS extended attribute. */
 	err = ntfs_get_ea(inode, name, name_len, buffer, size, NULL);
 
@@ -894,6 +972,22 @@ static noinline int ntfs_setxattr(const struct xattr_handler *handler,
 		goto out;
 	}
 
+#ifdef CONFIG_NTFS3_FS_POSIX_ACL
+	if ((name_len == sizeof(XATTR_NAME_POSIX_ACL_ACCESS) - 1 &&
+	     !memcmp(name, XATTR_NAME_POSIX_ACL_ACCESS,
+		     sizeof(XATTR_NAME_POSIX_ACL_ACCESS))) ||
+	    (name_len == sizeof(XATTR_NAME_POSIX_ACL_DEFAULT) - 1 &&
+	     !memcmp(name, XATTR_NAME_POSIX_ACL_DEFAULT,
+		     sizeof(XATTR_NAME_POSIX_ACL_DEFAULT)))) {
+		err = ntfs_xattr_set_acl(
+			mnt_userns, inode,
+			name_len == sizeof(XATTR_NAME_POSIX_ACL_ACCESS) - 1
+				? ACL_TYPE_ACCESS
+				: ACL_TYPE_DEFAULT,
+			value, size);
+		goto out;
+	}
+#endif
 	/* Deal with NTFS extended attribute. */
 	err = ntfs_set_ea(inode, name, name_len, value, size, flags);
 
-- 
2.33.0


