Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7466118BA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Oct 2022 19:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbiJ1REh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Oct 2022 13:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbiJ1REK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Oct 2022 13:04:10 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7857D7CE0B;
        Fri, 28 Oct 2022 10:03:26 -0700 (PDT)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 97669218D;
        Fri, 28 Oct 2022 17:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1666976445;
        bh=Ls7WiocB2yL0aysOFrJdtUMz+tZ1iGtxcZz+VnGx4UU=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=B13mD9jDlaE4YIXPyBWy6kl77Zf4g00kUZ4cnlFynxV+alTW8AbZ/JCvCtJPMneXF
         ZkGqYMfMl5qb5IH0SmpULWJt0qAMmPCOVcb9vQBU97xgPBVoOeFCZG0ZnLsKwLEKrV
         Ti014Xqg8xc34npJBlD3g078+1h9vqR37ErU7bA4=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 28 Oct 2022 20:03:24 +0300
Message-ID: <bf00061d-0b78-ddd7-9bf4-8c8e7c3a45f3@paragon-software.com>
Date:   Fri, 28 Oct 2022 20:03:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: [PATCH 04/14] fs/ntfs3: atomic_open implementation
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <fc5957cc-a71b-cfa3-f291-cb63b23800d1@paragon-software.com>
In-Reply-To: <fc5957cc-a71b-cfa3-f291-cb63b23800d1@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.30.8.65]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Added ntfs_atomic_open function.
Relaxed locking in ntfs_create_inode.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/inode.c |  24 ++++++++++--
  fs/ntfs3/namei.c | 100 +++++++++++++++++++++++++++++++++++++++++++++++
  2 files changed, 120 insertions(+), 4 deletions(-)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index df0d30a3218a..405afb54cc19 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -1183,6 +1183,18 @@ ntfs_create_reparse_buffer(struct ntfs_sb_info *sbi, const char *symname,
  	return ERR_PTR(err);
  }
  
+/*
+ * ntfs_create_inode
+ *
+ * Helper function for:
+ * - ntfs_create
+ * - ntfs_mknod
+ * - ntfs_symlink
+ * - ntfs_mkdir
+ * - ntfs_atomic_open
+ *
+ * NOTE: if fnd != NULL (ntfs_atomic_open) then @dir is locked
+ */
  struct inode *ntfs_create_inode(struct user_namespace *mnt_userns,
  				struct inode *dir, struct dentry *dentry,
  				const struct cpu_str *uni, umode_t mode,
@@ -1212,7 +1224,8 @@ struct inode *ntfs_create_inode(struct user_namespace *mnt_userns,
  	struct REPARSE_DATA_BUFFER *rp = NULL;
  	bool rp_inserted = false;
  
-	ni_lock_dir(dir_ni);
+	if (!fnd)
+		ni_lock_dir(dir_ni);
  
  	dir_root = indx_get_root(&dir_ni->dir, dir_ni, NULL, NULL);
  	if (!dir_root) {
@@ -1575,7 +1588,8 @@ struct inode *ntfs_create_inode(struct user_namespace *mnt_userns,
  		goto out6;
  
  	/* Unlock parent directory before ntfs_init_acl. */
-	ni_unlock(dir_ni);
+	if (!fnd)
+		ni_unlock(dir_ni);
  
  	inode->i_generation = le16_to_cpu(rec->seq);
  
@@ -1635,7 +1649,8 @@ struct inode *ntfs_create_inode(struct user_namespace *mnt_userns,
  out7:
  
  	/* Undo 'indx_insert_entry'. */
-	ni_lock_dir(dir_ni);
+	if (!fnd)
+		ni_lock_dir(dir_ni);
  	indx_delete_entry(&dir_ni->dir, dir_ni, new_de + 1,
  			  le16_to_cpu(new_de->key_size), sbi);
  	/* ni_unlock(dir_ni); will be called later. */
@@ -1663,7 +1678,8 @@ struct inode *ntfs_create_inode(struct user_namespace *mnt_userns,
  
  out1:
  	if (err) {
-		ni_unlock(dir_ni);
+		if (!fnd)
+			ni_unlock(dir_ni);
  		return ERR_PTR(err);
  	}
  
diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index ff76389475ad..1af02d4f6b4d 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -8,6 +8,7 @@
  #include <linux/fs.h>
  #include <linux/nls.h>
  #include <linux/ctype.h>
+#include <linux/posix_acl.h>
  
  #include "debug.h"
  #include "ntfs.h"
@@ -334,6 +335,104 @@ static int ntfs_rename(struct user_namespace *mnt_userns, struct inode *dir,
  	return err;
  }
  
+/*
+ * ntfs_atomic_open
+ *
+ * inode_operations::atomic_open
+ */
+static int ntfs_atomic_open(struct inode *dir, struct dentry *dentry,
+			    struct file *file, u32 flags, umode_t mode)
+{
+	int err;
+	struct inode *inode;
+	struct ntfs_fnd *fnd = NULL;
+	struct ntfs_inode *ni = ntfs_i(dir);
+	struct dentry *d = NULL;
+	struct cpu_str *uni = __getname();
+	bool locked = false;
+
+	if (!uni)
+		return -ENOMEM;
+
+	err = ntfs_nls_to_utf16(ni->mi.sbi, dentry->d_name.name,
+				dentry->d_name.len, uni, NTFS_NAME_LEN,
+				UTF16_HOST_ENDIAN);
+	if (err < 0)
+		goto out;
+
+#ifdef CONFIG_NTFS3_FS_POSIX_ACL
+	if (IS_POSIXACL(dir)) {
+		/*
+		 * Load in cache current acl to avoid ni_lock(dir):
+		 * ntfs_create_inode -> ntfs_init_acl -> posix_acl_create ->
+		 * ntfs_get_acl -> ntfs_get_acl_ex -> ni_lock
+		 */
+		struct posix_acl *p = get_acl(dir, ACL_TYPE_DEFAULT);
+
+		if (IS_ERR(p)) {
+			err = PTR_ERR(p);
+			goto out;
+		}
+		posix_acl_release(p);
+	}
+#endif
+
+	if (d_in_lookup(dentry)) {
+		ni_lock_dir(ni);
+		locked = true;
+		fnd = fnd_get();
+		if (!fnd) {
+			err = -ENOMEM;
+			goto out1;
+		}
+
+		d = d_splice_alias(dir_search_u(dir, uni, fnd), dentry);
+		if (IS_ERR(d)) {
+			err = PTR_ERR(d);
+			d = NULL;
+			goto out2;
+		}
+
+		if (d)
+			dentry = d;
+	}
+
+	if (!(flags & O_CREAT) || d_really_is_positive(dentry)) {
+		err = finish_no_open(file, d);
+		goto out2;
+	}
+
+	file->f_mode |= FMODE_CREATED;
+
+	/*
+	 * fnd contains tree's path to insert to.
+	 * If fnd is not NULL then dir is locked.
+	 */
+
+	/*
+	 * Unfortunately I don't know how to get here correct 'struct nameidata *nd'
+	 * or 'struct user_namespace *mnt_userns'.
+	 * See atomic_open in fs/namei.c.
+	 * This is why xfstest/633 failed.
+	 * Looks like ntfs_atomic_open must accept 'struct user_namespace *mnt_userns' as argument.
+	 */
+
+	inode = ntfs_create_inode(&init_user_ns, dir, dentry, uni, mode, 0,
+				  NULL, 0, fnd);
+	err = IS_ERR(inode) ? PTR_ERR(inode)
+			    : finish_open(file, dentry, ntfs_file_open);
+	dput(d);
+
+out2:
+	fnd_put(fnd);
+out1:
+	if (locked)
+		ni_unlock(ni);
+out:
+	__putname(uni);
+	return err;
+}
+
  struct dentry *ntfs3_get_parent(struct dentry *child)
  {
  	struct inode *inode = d_inode(child);
@@ -504,6 +603,7 @@ const struct inode_operations ntfs_dir_inode_operations = {
  	.setattr	= ntfs3_setattr,
  	.getattr	= ntfs_getattr,
  	.listxattr	= ntfs_listxattr,
+	.atomic_open	= ntfs_atomic_open,
  	.fiemap		= ntfs_fiemap,
  };
  
-- 
2.37.0


