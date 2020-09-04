Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE2A825DF20
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Sep 2020 18:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbgIDQGb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Sep 2020 12:06:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:51326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727969AbgIDQFx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Sep 2020 12:05:53 -0400
Received: from tleilax.com (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E57E420829;
        Fri,  4 Sep 2020 16:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599235553;
        bh=QzbxtHS3+Lm/aqHBZG+er39st6vN5vnrx+888HiKRxg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U+eTGRggMxd2NI4ma7gSyXv25V00uWF+UiPSAq5xiIUIXoD+514cQBNZhVoBDhCPd
         YeM68XQcr3XP3tJfR1w7XZqpyxC86SLd234IdS3hHJWN7KE9e5XVFCCD/XvetwuLH6
         f2vJUXfv1Gan5v4y9dTFuMZMqeW3do5x7Y5cjZHY=
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        ebiggers@kernel.org
Subject: [RFC PATCH v2 18/18] ceph: create symlinks with encrypted and base64-encoded targets
Date:   Fri,  4 Sep 2020 12:05:37 -0400
Message-Id: <20200904160537.76663-19-jlayton@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200904160537.76663-1-jlayton@kernel.org>
References: <20200904160537.76663-1-jlayton@kernel.org>
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
 fs/ceph/dir.c   | 32 ++++++++++++++++---
 fs/ceph/inode.c | 82 +++++++++++++++++++++++++++++++++++++++----------
 fs/ceph/super.h |  3 ++
 3 files changed, 96 insertions(+), 21 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 0ba17c592fe1..7ff8921dd3a7 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -948,6 +948,7 @@ static int ceph_symlink(struct inode *dir, struct dentry *dentry,
 	struct ceph_mds_client *mdsc = fsc->mdsc;
 	struct ceph_mds_request *req;
 	struct ceph_acl_sec_ctx as_ctx = {};
+	struct fscrypt_str osd_link = FSTR_INIT(NULL, 0);
 	umode_t mode = S_IFLNK | 0777;
 	int err;
 
@@ -973,11 +974,33 @@ static int ceph_symlink(struct inode *dir, struct dentry *dentry,
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
+		req->r_path2 = kmalloc(BASE64_CHARS(osd_link.len) + 1, GFP_KERNEL);
+		if (!req->r_path2) {
+			err = -ENOMEM;
+			goto out_req;
+		}
+
+		len = base64_encode_fname(osd_link.name, osd_link.len, req->r_path2);
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
@@ -997,6 +1020,7 @@ static int ceph_symlink(struct inode *dir, struct dentry *dentry,
 	if (err)
 		d_drop(dentry);
 	ceph_release_acl_sec_ctx(&as_ctx);
+	fscrypt_fname_free_buffer(&osd_link);
 	return err;
 }
 
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index e578e4cdcf30..dd39f886b03c 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -14,6 +14,7 @@
 #include <linux/random.h>
 #include <linux/sort.h>
 #include <linux/iversion.h>
+#include <linux/base64_fname.h>
 
 #include "super.h"
 #include "mds_client.h"
@@ -33,8 +34,6 @@
  * (typically because they are in the message handler path).
  */
 
-static const struct inode_operations ceph_symlink_iops;
-
 static void ceph_inode_work(struct work_struct *work);
 
 /*
@@ -503,6 +502,7 @@ struct inode *ceph_alloc_inode(struct super_block *sb)
 	atomic64_set(&ci->i_complete_seq[0], 0);
 	atomic64_set(&ci->i_complete_seq[1], 0);
 	ci->i_symlink = NULL;
+	ci->i_symlink_len = 0;
 
 	ci->i_max_bytes = 0;
 	ci->i_max_files = 0;
@@ -590,6 +590,7 @@ void ceph_free_inode(struct inode *inode)
 	struct ceph_inode_info *ci = ceph_inode(inode);
 
 	kfree(ci->i_symlink);
+	fscrypt_free_inode(inode);
 	kmem_cache_free(ceph_inode_cachep, ci);
 }
 
@@ -991,34 +992,60 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
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
+				symlen = base64_decode_fname(iinfo->symlink, symlen, sym);
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
-			if (!ci->i_symlink)
+			if (!ci->i_symlink) {
 				ci->i_symlink = sym;
-			else
+				ci->i_symlink_len = symlen;
+			} else {
 				kfree(sym); /* lost a race */
+			}
+		}
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
 		}
-		inode->i_link = ci->i_symlink;
 		break;
 	case S_IFDIR:
 		inode->i_op = &ceph_dir_iops;
@@ -2123,16 +2150,37 @@ static void ceph_inode_work(struct work_struct *work)
 	iput(inode);
 }
 
+static const char *ceph_encrypted_get_link(struct dentry *dentry, struct inode *inode,
+					   struct delayed_call *done)
+{
+	struct ceph_inode_info *ci = ceph_inode(inode);
+
+	if (inode->i_link)
+		return inode->i_link;
+
+	if (!dentry)
+		return ERR_PTR(-ECHILD);
+
+	return fscrypt_get_symlink(inode, ci->i_symlink, ci->i_symlink_len, done);
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
index 7c859824f64c..eea0ee17b747 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -344,6 +344,7 @@ struct ceph_inode_info {
 	u64 i_max_bytes, i_max_files;
 
 	s32 i_dir_pin;
+	u32 i_symlink_len;
 
 	struct rb_root i_fragtree;
 	int i_fragtree_nsplits;
@@ -932,6 +933,8 @@ struct ceph_mds_reply_dirfrag;
 struct ceph_acl_sec_ctx;
 
 extern const struct inode_operations ceph_file_iops;
+extern const struct inode_operations ceph_symlink_iops;
+extern const struct inode_operations ceph_encrypted_symlink_iops;
 
 extern struct inode *ceph_alloc_inode(struct super_block *sb);
 extern void ceph_evict_inode(struct inode *inode);
-- 
2.26.2

