Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3FE26956E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Sep 2020 21:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgINTR4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Sep 2020 15:17:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:39020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726031AbgINTRX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Sep 2020 15:17:23 -0400
Received: from tleilax.com (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BB95221E8;
        Mon, 14 Sep 2020 19:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600111040;
        bh=CZSroRiDVlLsR7BnsLG2EcEV6LlW+dVi5ozQK/Yx8lg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bIK8DNgsv1lacrIgFOUNS9nxcB3gWaZdWHEpbF75j+ioM+d22LWoONu88GFBZ4tYj
         rPi/RZOHvq/7c5YK+VXJAv0gG12NDbMl4h3rfOZNoNisELZ4ik/7bGcf03e8lpkcr6
         PhcIM1gw9VgWKhCoxi/zOrnfpBqZhzHp+XIHp3zA=
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v3 16/16] ceph: create symlinks with encrypted and base64-encoded targets
Date:   Mon, 14 Sep 2020 15:17:07 -0400
Message-Id: <20200914191707.380444-17-jlayton@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200914191707.380444-1-jlayton@kernel.org>
References: <20200914191707.380444-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When creating symlinks in encrypted directories, encrypt and
base64-encode the target with the new inode's key before sending to the
MDS.

When filling a symlinked inode, base64-decode it into a buffer that
we'll keep in ci->i_symlink. When get_link is called, decrypt the buffer
into a new one that will hang off i_link.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/dir.c   | 32 +++++++++++++++++++---
 fs/ceph/inode.c | 71 ++++++++++++++++++++++++++++++++++++++-----------
 fs/ceph/super.h |  2 ++
 3 files changed, 86 insertions(+), 19 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index e9fdb9c07320..65d82ab239b2 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -928,6 +928,7 @@ static int ceph_symlink(struct inode *dir, struct dentry *dentry,
 	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(dir->i_sb);
 	struct ceph_mds_request *req;
 	struct ceph_acl_sec_ctx as_ctx = {};
+	struct fscrypt_str osd_link = FSTR_INIT(NULL, 0);
 	umode_t mode = S_IFLNK | 0777;
 	int err;
 
@@ -953,11 +954,33 @@ static int ceph_symlink(struct inode *dir, struct dentry *dentry,
 		goto out_req;
 	}
 
-	req->r_path2 = kstrdup(dest, GFP_KERNEL);
-	if (!req->r_path2) {
-		err = -ENOMEM;
-		goto out_req;
+	if (IS_ENCRYPTED(req->r_new_inode)) {
+		int len = strlen(dest);
+
+		err = fscrypt_prepare_symlink(dir, dest, len, PATH_MAX, &osd_link);
+		if (err)
+			goto out_req;
+
+		err = fscrypt_encrypt_symlink(req->r_new_inode, dest, len, &osd_link);
+		if (err)
+			goto out_req;
+
+		req->r_path2 = kmalloc(FSCRYPT_BASE64_CHARS(osd_link.len) + 1, GFP_KERNEL);
+		if (!req->r_path2) {
+			err = -ENOMEM;
+			goto out_req;
+		}
+
+		len = fscrypt_base64_encode(osd_link.name, osd_link.len, req->r_path2);
+		req->r_path2[len] = '\0';
+	} else {
+		req->r_path2 = kstrdup(dest, GFP_KERNEL);
+		if (!req->r_path2) {
+			err = -ENOMEM;
+			goto out_req;
+		}
 	}
+
 	req->r_parent = dir;
 	set_bit(CEPH_MDS_R_PARENT_LOCKED, &req->r_req_flags);
 	req->r_dentry = dget(dentry);
@@ -977,6 +1000,7 @@ static int ceph_symlink(struct inode *dir, struct dentry *dentry,
 	if (err)
 		d_drop(dentry);
 	ceph_release_acl_sec_ctx(&as_ctx);
+	fscrypt_fname_free_buffer(&osd_link);
 	return err;
 }
 
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 8e9fb1311bb8..4ac267cc9085 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -33,8 +33,6 @@
  * (typically because they are in the message handler path).
  */
 
-static const struct inode_operations ceph_symlink_iops;
-
 static void ceph_inode_work(struct work_struct *work);
 
 /*
@@ -593,6 +591,7 @@ void ceph_free_inode(struct inode *inode)
 	struct ceph_inode_info *ci = ceph_inode(inode);
 
 	kfree(ci->i_symlink);
+	fscrypt_free_inode(inode);
 	kmem_cache_free(ceph_inode_cachep, ci);
 }
 
@@ -996,26 +995,39 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 		inode->i_fop = &ceph_file_fops;
 		break;
 	case S_IFLNK:
-		inode->i_op = &ceph_symlink_iops;
 		if (!ci->i_symlink) {
 			u32 symlen = iinfo->symlink_len;
 			char *sym;
 
 			spin_unlock(&ci->i_ceph_lock);
 
-			if (symlen != i_size_read(inode)) {
-				pr_err("%s %llx.%llx BAD symlink "
-					"size %lld\n", __func__,
-					ceph_vinop(inode),
-					i_size_read(inode));
+			if (IS_ENCRYPTED(inode)) {
+				/* Do base64 decode so that we get the right size (maybe?) */
+				err = -ENOMEM;
+				sym = kmalloc(symlen + 1, GFP_NOFS);
+				if (!sym)
+					goto out;
+
+				symlen = fscrypt_base64_decode(iinfo->symlink, symlen, sym);
+				/*
+				 * i_size as reported by the MDS may be wrong, due to base64
+				 * inflation and padding. Fix it up here.
+				 */
 				i_size_write(inode, symlen);
 				inode->i_blocks = calc_inode_blocks(symlen);
-			}
+			} else {
+				if (symlen != i_size_read(inode)) {
+					pr_err("%s %llx.%llx BAD symlink size %lld\n",
+						__func__, ceph_vinop(inode), i_size_read(inode));
+					i_size_write(inode, symlen);
+					inode->i_blocks = calc_inode_blocks(symlen);
+				}
 
-			err = -ENOMEM;
-			sym = kstrndup(iinfo->symlink, symlen, GFP_NOFS);
-			if (!sym)
-				goto out;
+				err = -ENOMEM;
+				sym = kstrndup(iinfo->symlink, symlen, GFP_NOFS);
+				if (!sym)
+					goto out;
+			}
 
 			spin_lock(&ci->i_ceph_lock);
 			if (!ci->i_symlink)
@@ -1023,7 +1035,18 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 			else
 				kfree(sym); /* lost a race */
 		}
-		inode->i_link = ci->i_symlink;
+
+		if (IS_ENCRYPTED(inode)) {
+			/*
+			 * Encrypted symlinks need to be decrypted before we can
+			 * cache their targets in i_link. Leave it blank for now.
+			 */
+			inode->i_link = NULL;
+			inode->i_op = &ceph_encrypted_symlink_iops;
+		} else {
+			inode->i_link = ci->i_symlink;
+			inode->i_op = &ceph_symlink_iops;
+		}
 		break;
 	case S_IFDIR:
 		inode->i_op = &ceph_dir_iops;
@@ -2124,16 +2147,34 @@ static void ceph_inode_work(struct work_struct *work)
 	iput(inode);
 }
 
+static const char *ceph_encrypted_get_link(struct dentry *dentry, struct inode *inode,
+					   struct delayed_call *done)
+{
+	struct ceph_inode_info *ci = ceph_inode(inode);
+
+	if (!dentry)
+		return ERR_PTR(-ECHILD);
+
+	return fscrypt_get_symlink(inode, ci->i_symlink, ksize(ci->i_symlink), done);
+}
+
 /*
  * symlinks
  */
-static const struct inode_operations ceph_symlink_iops = {
+const struct inode_operations ceph_symlink_iops = {
 	.get_link = simple_get_link,
 	.setattr = ceph_setattr,
 	.getattr = ceph_getattr,
 	.listxattr = ceph_listxattr,
 };
 
+const struct inode_operations ceph_encrypted_symlink_iops = {
+	.get_link = ceph_encrypted_get_link,
+	.setattr = ceph_setattr,
+	.getattr = ceph_getattr,
+	.listxattr = ceph_listxattr,
+};
+
 int __ceph_setattr(struct inode *inode, struct iattr *attr)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 5d5283552c03..d58296bd8235 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -939,6 +939,8 @@ struct ceph_mds_reply_dirfrag;
 struct ceph_acl_sec_ctx;
 
 extern const struct inode_operations ceph_file_iops;
+extern const struct inode_operations ceph_symlink_iops;
+extern const struct inode_operations ceph_encrypted_symlink_iops;
 
 extern struct inode *ceph_alloc_inode(struct super_block *sb);
 extern void ceph_evict_inode(struct inode *inode);
-- 
2.26.2

