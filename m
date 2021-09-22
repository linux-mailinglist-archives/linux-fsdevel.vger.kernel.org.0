Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04160414DEB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Sep 2021 18:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236593AbhIVQSq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Sep 2021 12:18:46 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:40374 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236557AbhIVQSp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Sep 2021 12:18:45 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id 1574282304;
        Wed, 22 Sep 2021 19:17:14 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1632327434;
        bh=hY+vfq95riCX9pMhxP7mNgEHJVadtIj5d45qze3HwuA=;
        h=Date:Subject:From:To:References:CC:In-Reply-To;
        b=InNJDE55M2hFYoj3UfrP6JcuBsbIyBURWh5jWjfUJqwEGrsBKpVN/txgyG08OoOJR
         J9nswDbenO9F/4hAES9l9wgm47dGjelzq6XfFlIbjlygS/EHiPBsSFEmRPXlR22HWZ
         L+NrNE1tpN79m/s+smekQoVorwCxdKbQ+AQyfhWA=
Received: from [192.168.211.195] (192.168.211.195) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 22 Sep 2021 19:17:13 +0300
Message-ID: <a269be2f-4ab6-b1c6-790c-9d3052bf22cc@paragon-software.com>
Date:   Wed, 22 Sep 2021 19:17:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: [PATCH 1/5] fs/ntfs3: Move ni_lock_dir and ni_unlock into
 ntfs_create_inode
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
References: <2771ff62-e612-a8ed-4b93-5534c26aef9e@paragon-software.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
In-Reply-To: <2771ff62-e612-a8ed-4b93-5534c26aef9e@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.195]
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now ntfs3 locks mutex for smaller time.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/inode.c | 17 ++++++++++++++---
 fs/ntfs3/namei.c | 20 --------------------
 2 files changed, 14 insertions(+), 23 deletions(-)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index d583b71bec50..6fc99eebd1c1 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -1198,9 +1198,13 @@ struct inode *ntfs_create_inode(struct user_namespace *mnt_userns,
 	struct REPARSE_DATA_BUFFER *rp = NULL;
 	bool rp_inserted = false;
 
+	ni_lock_dir(dir_ni);
+
 	dir_root = indx_get_root(&dir_ni->dir, dir_ni, NULL, NULL);
-	if (!dir_root)
-		return ERR_PTR(-EINVAL);
+	if (!dir_root) {
+		err = -EINVAL;
+		goto out1;
+	}
 
 	if (S_ISDIR(mode)) {
 		/* Use parent's directory attributes. */
@@ -1549,6 +1553,9 @@ struct inode *ntfs_create_inode(struct user_namespace *mnt_userns,
 	if (err)
 		goto out6;
 
+	/* Unlock parent directory before ntfs_init_acl. */
+	ni_unlock(dir_ni);
+
 	inode->i_generation = le16_to_cpu(rec->seq);
 
 	dir->i_mtime = dir->i_ctime = inode->i_atime;
@@ -1605,8 +1612,10 @@ struct inode *ntfs_create_inode(struct user_namespace *mnt_userns,
 out7:
 
 	/* Undo 'indx_insert_entry'. */
+	ni_lock_dir(dir_ni);
 	indx_delete_entry(&dir_ni->dir, dir_ni, new_de + 1,
 			  le16_to_cpu(new_de->key_size), sbi);
+	/* ni_unlock(dir_ni); will be called later. */
 out6:
 	if (rp_inserted)
 		ntfs_remove_reparse(sbi, IO_REPARSE_TAG_SYMLINK, &new_de->ref);
@@ -1630,8 +1639,10 @@ struct inode *ntfs_create_inode(struct user_namespace *mnt_userns,
 	kfree(rp);
 
 out1:
-	if (err)
+	if (err) {
+		ni_unlock(dir_ni);
 		return ERR_PTR(err);
+	}
 
 	unlock_new_inode(inode);
 
diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index 1c475da4e19d..bc741213ad84 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -95,16 +95,11 @@ static struct dentry *ntfs_lookup(struct inode *dir, struct dentry *dentry,
 static int ntfs_create(struct user_namespace *mnt_userns, struct inode *dir,
 		       struct dentry *dentry, umode_t mode, bool excl)
 {
-	struct ntfs_inode *ni = ntfs_i(dir);
 	struct inode *inode;
 
-	ni_lock_dir(ni);
-
 	inode = ntfs_create_inode(mnt_userns, dir, dentry, NULL, S_IFREG | mode,
 				  0, NULL, 0, NULL);
 
-	ni_unlock(ni);
-
 	return IS_ERR(inode) ? PTR_ERR(inode) : 0;
 }
 
@@ -116,16 +111,11 @@ static int ntfs_create(struct user_namespace *mnt_userns, struct inode *dir,
 static int ntfs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
 		      struct dentry *dentry, umode_t mode, dev_t rdev)
 {
-	struct ntfs_inode *ni = ntfs_i(dir);
 	struct inode *inode;
 
-	ni_lock_dir(ni);
-
 	inode = ntfs_create_inode(mnt_userns, dir, dentry, NULL, mode, rdev,
 				  NULL, 0, NULL);
 
-	ni_unlock(ni);
-
 	return IS_ERR(inode) ? PTR_ERR(inode) : 0;
 }
 
@@ -196,15 +186,10 @@ static int ntfs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 {
 	u32 size = strlen(symname);
 	struct inode *inode;
-	struct ntfs_inode *ni = ntfs_i(dir);
-
-	ni_lock_dir(ni);
 
 	inode = ntfs_create_inode(mnt_userns, dir, dentry, NULL, S_IFLNK | 0777,
 				  0, symname, size, NULL);
 
-	ni_unlock(ni);
-
 	return IS_ERR(inode) ? PTR_ERR(inode) : 0;
 }
 
@@ -215,15 +200,10 @@ static int ntfs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 		      struct dentry *dentry, umode_t mode)
 {
 	struct inode *inode;
-	struct ntfs_inode *ni = ntfs_i(dir);
-
-	ni_lock_dir(ni);
 
 	inode = ntfs_create_inode(mnt_userns, dir, dentry, NULL, S_IFDIR | mode,
 				  0, NULL, 0, NULL);
 
-	ni_unlock(ni);
-
 	return IS_ERR(inode) ? PTR_ERR(inode) : 0;
 }
 
-- 
2.33.0

