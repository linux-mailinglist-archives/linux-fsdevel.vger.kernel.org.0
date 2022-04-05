Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A824F4D2B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 03:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1581650AbiDEXkS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Apr 2022 19:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573579AbiDETXC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Apr 2022 15:23:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D4D49C84;
        Tue,  5 Apr 2022 12:21:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EE80618CD;
        Tue,  5 Apr 2022 19:21:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8933C385A3;
        Tue,  5 Apr 2022 19:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649186462;
        bh=AWzsTg+UTHKEk8QehJZJCF5BnvPHMbE6gVQ/WVlXD74=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CDMkMuVHglb+rWTsUJfqPzgEB06jnyqqRgnZaA2bbXB+XHGmjqnPXsuSIq+jsHJrJ
         AKrKgtP9E9nEkZFLSQSlKUxn20XBSRcyCYZVhYb0Iax96PfpmmtkHSb4CL4VHM89vw
         vtTSoBSvPZseTRdOiwO2mqAW81J17pOwso4FtP5T4vYxWzKxXS+1Uv0OJ4o7nn8s0L
         wV0CDY/jvORblSCm1Nn+Ndx8yWlArMcdPHSw452smhJKbX5ra7/lQojjfroP99ORqA
         QePVt1bw8vzWpLEquTxh3YhVe+IlHcsUp63IEM45NU0kmv18OWTGNzRaXX9f0b8qCB
         5Qe5zpNlRbM/w==
From:   Jeff Layton <jlayton@kernel.org>
To:     idryomov@gmail.com, xiubli@redhat.com
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org,
        lhenriques@suse.de
Subject: [PATCH v13 33/59] ceph: create symlinks with encrypted and base64-encoded targets
Date:   Tue,  5 Apr 2022 15:20:04 -0400
Message-Id: <20220405192030.178326-34-jlayton@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405192030.178326-1-jlayton@kernel.org>
References: <20220405192030.178326-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 fs/ceph/dir.c   |  51 ++++++++++++++++++++---
 fs/ceph/inode.c | 107 ++++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 141 insertions(+), 17 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 5ce2a6384e55..82a5f37e9d4a 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -942,6 +942,40 @@ static int ceph_create(struct user_namespace *mnt_userns, struct inode *dir,
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
+	req->r_path2 = kmalloc(FSCRYPT_BASE64URL_CHARS(osd_link.len) + 1, GFP_KERNEL);
+	if (!req->r_path2) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	len = fscrypt_base64url_encode(osd_link.name, osd_link.len, req->r_path2);
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
@@ -973,14 +1007,21 @@ static int ceph_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 		goto out_req;
 	}
 
-	req->r_path2 = kstrdup(dest, GFP_KERNEL);
-	if (!req->r_path2) {
-		err = -ENOMEM;
-		goto out_req;
-	}
 	req->r_parent = dir;
 	ihold(dir);
 
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
index d1ade1651214..bb1b1a57970c 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -35,6 +35,7 @@
  */
 
 static const struct inode_operations ceph_symlink_iops;
+static const struct inode_operations ceph_encrypted_symlink_iops;
 
 static void ceph_inode_work(struct work_struct *work);
 
@@ -639,6 +640,7 @@ void ceph_free_inode(struct inode *inode)
 #ifdef CONFIG_FS_ENCRYPTION
 	kfree(ci->fscrypt_auth);
 #endif
+	fscrypt_free_inode(inode);
 	kmem_cache_free(ceph_inode_cachep, ci);
 }
 
@@ -836,6 +838,34 @@ void ceph_fill_file_time(struct inode *inode, int issued,
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
+	declen = fscrypt_base64url_decode(encsym, enclen, sym);
+	if (declen < 0) {
+		pr_err("%s: can't decode symlink (%d). Content: %.*s\n",
+		       __func__, declen, enclen, encsym);
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
@@ -1070,26 +1100,39 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
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
@@ -1097,7 +1140,17 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 			else
 				kfree(sym); /* lost a race */
 		}
-		inode->i_link = ci->i_symlink;
+
+		if (IS_ENCRYPTED(inode)) {
+			/*
+			 * Encrypted symlinks need to be decrypted before we can
+			 * cache their targets in i_link. Don't touch it here.
+			 */
+			inode->i_op = &ceph_encrypted_symlink_iops;
+		} else {
+			inode->i_link = ci->i_symlink;
+			inode->i_op = &ceph_symlink_iops;
+		}
 		break;
 	case S_IFDIR:
 		inode->i_op = &ceph_dir_iops;
@@ -2126,6 +2179,29 @@ static void ceph_inode_work(struct work_struct *work)
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
+static int ceph_encrypted_symlink_getattr(struct user_namespace *mnt_userns,
+					  const struct path *path, struct kstat *stat,
+					  u32 request_mask, unsigned int query_flags)
+{
+	int ret;
+
+	ret = ceph_getattr(mnt_userns, path, stat, request_mask, query_flags);
+	if (ret)
+		return ret;
+	return fscrypt_symlink_getattr(path, stat);
+}
+
 /*
  * symlinks
  */
@@ -2136,6 +2212,13 @@ static const struct inode_operations ceph_symlink_iops = {
 	.listxattr = ceph_listxattr,
 };
 
+static const struct inode_operations ceph_encrypted_symlink_iops = {
+	.get_link = ceph_encrypted_get_link,
+	.setattr = ceph_setattr,
+	.getattr = ceph_encrypted_symlink_getattr,
+	.listxattr = ceph_listxattr,
+};
+
 int __ceph_setattr(struct inode *inode, struct iattr *attr, struct ceph_iattr *cia)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
-- 
2.35.1

