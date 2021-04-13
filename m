Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B53035E593
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Apr 2021 19:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347472AbhDMRvk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Apr 2021 13:51:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:44988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347434AbhDMRvZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Apr 2021 13:51:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 861A3613B1;
        Tue, 13 Apr 2021 17:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618336266;
        bh=tmmzziVbK6jn7h4O6pfIcATLwaj4RjubYLlj5YsWDrc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aLt6aQ0vdNMvJOHm8wiq1Y4FagU/K5j7EediL7BFc81qJxydK+iXYY6AyJxfDPn7T
         TPABnEYyll8wyHLB01/hv/qvhww2jQLyxhmTBcXxz9D8vkdUNU9gZD2+Y13sbL9rIx
         dPfA/Hr6YVwMOpSdsCUwNay1cyunf5jEZK1lVAhH6R0RuTqgLf5Nq8HO9zMGWgXk/G
         ScciuFoC+VSh5gmLMP27eh2co5dDN3jGWAF4rI34juy5z1Qe2iOeqqq6Dbt70nyEIW
         aODKZc+nCmUsrxPdvZyFt6c8fm5YHudReQRpTAX86O065jdDxkqORYDaEgg31HOQ5L
         MQ9i7996U2L6g==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        lhenriques@suse.de
Subject: [RFC PATCH v6 18/20] ceph: create symlinks with encrypted and base64-encoded targets
Date:   Tue, 13 Apr 2021 13:50:50 -0400
Message-Id: <20210413175052.163865-19-jlayton@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210413175052.163865-1-jlayton@kernel.org>
References: <20210413175052.163865-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 fs/ceph/dir.c   | 52 ++++++++++++++++++++++++---
 fs/ceph/inode.c | 95 ++++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 130 insertions(+), 17 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 7fe74c2f3911..e039534a5fab 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -947,6 +947,40 @@ static int ceph_create(struct user_namespace *mnt_userns, struct inode *dir,
 	return ceph_mknod(mnt_userns, dir, dentry, mode, 0);
 }
 
+#if IS_ENABLED(CONFIG_FS_ENCRYPTION)
+static int prep_encrypted_symlink_target(struct ceph_mds_request *req, const char *dest)
+{
+	int err;
+	int len = strlen(dest);
+	struct fscrypt_str osd_link = FSTR_INIT(NULL, 0);
+
+	err = fscrypt_prepare_symlink(req->r_parent, dest, len, PATH_MAX, &osd_link);
+	if (err)
+		goto out;
+
+	err = fscrypt_encrypt_symlink(req->r_new_inode, dest, len, &osd_link);
+	if (err)
+		goto out;
+
+	req->r_path2 = kmalloc(FSCRYPT_BASE64_CHARS(osd_link.len) + 1, GFP_KERNEL);
+	if (!req->r_path2) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	len = fscrypt_base64_encode(osd_link.name, osd_link.len, req->r_path2);
+	req->r_path2[len] = '\0';
+out:
+	fscrypt_fname_free_buffer(&osd_link);
+	return err;
+}
+#else
+static int prep_encrypted_symlink_target(struct ceph_mds_request *req, const char *dest)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
 static int ceph_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 			struct dentry *dentry, const char *dest)
 {
@@ -978,12 +1012,20 @@ static int ceph_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 		goto out_req;
 	}
 
-	req->r_path2 = kstrdup(dest, GFP_KERNEL);
-	if (!req->r_path2) {
-		err = -ENOMEM;
-		goto out_req;
-	}
 	req->r_parent = dir;
+
+	if (IS_ENCRYPTED(req->r_new_inode)) {
+		err = prep_encrypted_symlink_target(req, dest);
+		if (err)
+			goto out_req;
+	} else {
+		req->r_path2 = kstrdup(dest, GFP_KERNEL);
+		if (!req->r_path2) {
+			err = -ENOMEM;
+			goto out_req;
+		}
+	}
+
 	set_bit(CEPH_MDS_R_PARENT_LOCKED, &req->r_req_flags);
 	req->r_dentry = dget(dentry);
 	req->r_num_caps = 2;
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 5bd0717c030a..5afedf779dfc 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -35,6 +35,7 @@
  */
 
 static const struct inode_operations ceph_symlink_iops;
+static const struct inode_operations ceph_encrypted_symlink_iops;
 
 static void ceph_inode_work(struct work_struct *work);
 
@@ -618,6 +619,7 @@ void ceph_free_inode(struct inode *inode)
 	struct ceph_inode_info *ci = ceph_inode(inode);
 
 	kfree(ci->i_symlink);
+	fscrypt_free_inode(inode);
 	kmem_cache_free(ceph_inode_cachep, ci);
 }
 
@@ -818,6 +820,33 @@ void ceph_fill_file_time(struct inode *inode, int issued,
 		     inode, time_warp_seq, ci->i_time_warp_seq);
 }
 
+#if IS_ENABLED(CONFIG_FS_ENCRYPTION)
+static int decode_encrypted_symlink(const char *encsym, int enclen, u8 **decsym)
+{
+	int declen;
+	u8 *sym;
+
+	sym = kmalloc(enclen + 1, GFP_NOFS);
+	if (!sym)
+		return -ENOMEM;
+
+	declen = fscrypt_base64_decode(encsym, enclen, sym);
+	if (declen < 0) {
+		pr_err("%s: can't decode symlink (%d). Content: %.*s\n", __func__, declen, enclen, encsym);
+		kfree(sym);
+		return -EIO;
+	}
+	sym[declen + 1] = '\0';
+	*decsym = sym;
+	return declen;
+}
+#else
+static int decode_encrypted_symlink(const char *encsym, int symlen, u8 **decsym)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
 /*
  * Populate an inode based on info from mds.  May be called on new or
  * existing inodes.
@@ -1042,26 +1071,39 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
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
+				if (symlen != i_size_read(inode))
+					pr_err("%s %llx.%llx BAD symlink size %lld\n",
+						__func__, ceph_vinop(inode), i_size_read(inode));
+
+				err = decode_encrypted_symlink(iinfo->symlink, symlen, (u8 **)&sym);
+				if (err < 0) {
+					pr_err("%s decoding encrypted symlink failed: %d\n",
+						__func__, err);
+					goto out;
+				}
+				symlen = err;
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
@@ -1069,7 +1111,18 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
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
@@ -2141,6 +2194,17 @@ static void ceph_inode_work(struct work_struct *work)
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
+	return fscrypt_get_symlink(inode, ci->i_symlink, i_size_read(inode), done);
+}
+
 /*
  * symlinks
  */
@@ -2151,6 +2215,13 @@ static const struct inode_operations ceph_symlink_iops = {
 	.listxattr = ceph_listxattr,
 };
 
+static const struct inode_operations ceph_encrypted_symlink_iops = {
+	.get_link = ceph_encrypted_get_link,
+	.setattr = ceph_setattr,
+	.getattr = ceph_getattr,
+	.listxattr = ceph_listxattr,
+};
+
 int __ceph_setattr(struct inode *inode, struct iattr *attr)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
-- 
2.30.2

