Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC38269559
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Sep 2020 21:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgINTRm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Sep 2020 15:17:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:38982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbgINTRT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Sep 2020 15:17:19 -0400
Received: from tleilax.com (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D8E521D24;
        Mon, 14 Sep 2020 19:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600111033;
        bh=th1iFXKZJswLCWuErXYnHse38+yHoxNNbEL70BUsCe0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C/jZCVGv5s42iku8F3pjbic+8Har/T8kIYH6Y5OgDXhdfcEKK6pr7lrCYAo8EbMEV
         ORmmVGc0yCqVXlNZUZRwi4UhOMFIhoEQmhbYI8hcMYHH+fqCdascyrjPLGfOioHLGT
         QN0SgM9GtAFlcPvq7v4+A2JDV0UGkPhCf+u+33QQ=
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v3 05/16] fscrypt: make fscrypt_fname_disk_to_usr return whether result is nokey name
Date:   Mon, 14 Sep 2020 15:16:56 -0400
Message-Id: <20200914191707.380444-6-jlayton@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200914191707.380444-1-jlayton@kernel.org>
References: <20200914191707.380444-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ceph will sometimes need to know whether the resulting name from this
function is a nokey name, in order to set the dentry flags without
racy checks on the parent inode.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/crypto/fname.c       | 5 ++++-
 fs/crypto/hooks.c       | 4 ++--
 fs/ext4/dir.c           | 3 ++-
 fs/ext4/namei.c         | 6 ++++--
 fs/f2fs/dir.c           | 3 ++-
 fs/ubifs/dir.c          | 4 +++-
 include/linux/fscrypt.h | 4 ++--
 7 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
index 0d41eb4a5493..b97a81ccd838 100644
--- a/fs/crypto/fname.c
+++ b/fs/crypto/fname.c
@@ -353,6 +353,7 @@ EXPORT_SYMBOL(fscrypt_encode_nokey_name);
  * @oname: output buffer for the user-presentable filename.  The caller must
  *	   have allocated enough space for this, e.g. using
  *	   fscrypt_fname_alloc_buffer().
+ * @is_nokey: set to true if oname is a no-key name
  *
  * If the key is available, we'll decrypt the disk name.  Otherwise, we'll
  * encode it for presentation in fscrypt_nokey_name format.
@@ -363,7 +364,8 @@ EXPORT_SYMBOL(fscrypt_encode_nokey_name);
 int fscrypt_fname_disk_to_usr(const struct inode *inode,
 			      u32 hash, u32 minor_hash,
 			      const struct fscrypt_str *iname,
-			      struct fscrypt_str *oname)
+			      struct fscrypt_str *oname,
+			      bool *is_nokey)
 {
 	const struct qstr qname = FSTR_TO_QSTR(iname);
 	struct fscrypt_nokey_name nokey_name;
@@ -411,6 +413,7 @@ int fscrypt_fname_disk_to_usr(const struct inode *inode,
 		size = FSCRYPT_NOKEY_NAME_MAX;
 	}
 	oname->len = fscrypt_base64_encode((const u8 *)&nokey_name, size, oname->name);
+	*is_nokey = true;
 	return 0;
 }
 EXPORT_SYMBOL(fscrypt_fname_disk_to_usr);
diff --git a/fs/crypto/hooks.c b/fs/crypto/hooks.c
index 42f5ee9f592d..cdad06b4e521 100644
--- a/fs/crypto/hooks.c
+++ b/fs/crypto/hooks.c
@@ -310,7 +310,7 @@ const char *fscrypt_get_symlink(struct inode *inode, const void *caddr,
 {
 	const struct fscrypt_symlink_data *sd;
 	struct fscrypt_str cstr, pstr;
-	bool has_key;
+	bool has_key, is_nokey = false;
 	int err;
 
 	/* This is for encrypted symlinks only */
@@ -352,7 +352,7 @@ const char *fscrypt_get_symlink(struct inode *inode, const void *caddr,
 	if (err)
 		return ERR_PTR(err);
 
-	err = fscrypt_fname_disk_to_usr(inode, 0, 0, &cstr, &pstr);
+	err = fscrypt_fname_disk_to_usr(inode, 0, 0, &cstr, &pstr, &is_nokey);
 	if (err)
 		goto err_kfree;
 
diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
index efe77cffc322..ac6b04bebcf6 100644
--- a/fs/ext4/dir.c
+++ b/fs/ext4/dir.c
@@ -260,6 +260,7 @@ static int ext4_readdir(struct file *file, struct dir_context *ctx)
 					    get_dtype(sb, de->file_type)))
 						goto done;
 				} else {
+					bool is_nokey = false;
 					int save_len = fstr.len;
 					struct fscrypt_str de_name =
 							FSTR_INIT(de->name,
@@ -267,7 +268,7 @@ static int ext4_readdir(struct file *file, struct dir_context *ctx)
 
 					/* Directory is encrypted */
 					err = fscrypt_fname_disk_to_usr(inode,
-						0, 0, &de_name, &fstr);
+						0, 0, &de_name, &fstr, &is_nokey);
 					de_name = fstr;
 					fstr.len = save_len;
 					if (err)
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 0d74615fcce3..3ba407833be5 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -658,6 +658,7 @@ static struct stats dx_show_leaf(struct inode *dir,
 					       (unsigned) ((char *) de
 							   - base));
 				} else {
+					bool is_nokey = false;
 					struct fscrypt_str de_name =
 						FSTR_INIT(name, len);
 
@@ -671,7 +672,7 @@ static struct stats dx_show_leaf(struct inode *dir,
 							"crypto\n");
 					res = fscrypt_fname_disk_to_usr(dir,
 						0, 0, &de_name,
-						&fname_crypto_str);
+						&fname_crypto_str, &is_nokey);
 					if (res) {
 						printk(KERN_WARNING "Error "
 							"converting filename "
@@ -1045,6 +1046,7 @@ static int htree_dirblock_to_tree(struct file *dir_file,
 				   hinfo->hash, hinfo->minor_hash, de,
 				   &tmp_str);
 		} else {
+			bool is_nokey = false;
 			int save_len = fname_crypto_str.len;
 			struct fscrypt_str de_name = FSTR_INIT(de->name,
 								de->name_len);
@@ -1052,7 +1054,7 @@ static int htree_dirblock_to_tree(struct file *dir_file,
 			/* Directory is encrypted */
 			err = fscrypt_fname_disk_to_usr(dir, hinfo->hash,
 					hinfo->minor_hash, &de_name,
-					&fname_crypto_str);
+					&fname_crypto_str, &is_nokey);
 			if (err) {
 				count = err;
 				goto errout;
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 414bc94fbd54..d235e40210cf 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -985,11 +985,12 @@ int f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
 		}
 
 		if (IS_ENCRYPTED(d->inode)) {
+			bool is_nokey = false;
 			int save_len = fstr->len;
 
 			err = fscrypt_fname_disk_to_usr(d->inode,
 						(u32)le32_to_cpu(de->hash_code),
-						0, &de_name, fstr);
+						0, &de_name, fstr, &is_nokey);
 			if (err)
 				goto out;
 
diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index 155521e51ac5..da1a4bc861d5 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -584,12 +584,14 @@ static int ubifs_readdir(struct file *file, struct dir_context *ctx)
 		fname_name(&nm) = dent->name;
 
 		if (encrypted) {
+			bool is_nokey = false;
+
 			fstr.len = fstr_real_len;
 
 			err = fscrypt_fname_disk_to_usr(dir, key_hash_flash(c,
 							&dent->key),
 							le32_to_cpu(dent->cookie),
-							&nm.disk_name, &fstr);
+							&nm.disk_name, &fstr, &is_nokey);
 			if (err)
 				goto out;
 		} else {
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index a57d2a9869eb..bae18aa4173a 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -201,7 +201,7 @@ void fscrypt_fname_free_buffer(struct fscrypt_str *crypto_str);
 int fscrypt_fname_disk_to_usr(const struct inode *inode,
 			      u32 hash, u32 minor_hash,
 			      const struct fscrypt_str *iname,
-			      struct fscrypt_str *oname);
+			      struct fscrypt_str *oname, bool *is_nokey);
 bool fscrypt_match_name(const struct fscrypt_name *fname,
 			const u8 *de_name, u32 de_name_len);
 u64 fscrypt_fname_siphash(const struct inode *dir, const struct qstr *name);
@@ -442,7 +442,7 @@ static inline void fscrypt_fname_free_buffer(struct fscrypt_str *crypto_str)
 static inline int fscrypt_fname_disk_to_usr(const struct inode *inode,
 					    u32 hash, u32 minor_hash,
 					    const struct fscrypt_str *iname,
-					    struct fscrypt_str *oname)
+					    struct fscrypt_str *oname, bool *is_nokey)
 {
 	return -EOPNOTSUPP;
 }
-- 
2.26.2

