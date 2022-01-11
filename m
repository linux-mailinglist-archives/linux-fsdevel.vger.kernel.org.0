Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 945F248B6BE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jan 2022 20:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350536AbiAKTQi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jan 2022 14:16:38 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:36190 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350438AbiAKTQV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jan 2022 14:16:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 774C361771;
        Tue, 11 Jan 2022 19:16:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E337C36AE9;
        Tue, 11 Jan 2022 19:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641928580;
        bh=tnqpmLYIHYiHzY42RTnNBuR0pFkwKobt1Bs6E26UL9E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sTx+Mkl6cTFuhzZCQ8tYah/QEdRw+DUBbLAk0dukVBi9Y9zGYfC9c4H+Tc7dKsL8d
         obJldx554yYgmhrVNPH3Rn53x+QJhhTpjF9CMOYuKWuTtmnvfbChs8lQlUHUioyp4J
         MvT9i/lJPM6xeqFBeA84hj2/L8LoMN37U94DUnE1hlCEnr7umwQkT4b2R78GEpEKpZ
         26UmuGlVGjMvENa+k7b0hTj8CUfq0Z8Ft/0K8jhQQ/XFWBLAwpVIbGslc8Yv3bTutl
         O1h3CXKpLVPae2/TiyJvFFXjtUAjwmrTWTE1KXsbaIrEPkjXPclA7hp0DXVPGNLxkB
         8SDD4BnL9DzUw==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, idryomov@gmail.com
Subject: [RFC PATCH v10 14/48] ceph: add encrypted fname handling to ceph_mdsc_build_path
Date:   Tue, 11 Jan 2022 14:15:34 -0500
Message-Id: <20220111191608.88762-15-jlayton@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220111191608.88762-1-jlayton@kernel.org>
References: <20220111191608.88762-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Allow ceph_mdsc_build_path to encrypt and base64 encode the filename
when the parent is encrypted and we're sending the path to the MDS.

In most cases, we just encrypt the filenames and base64 encode them,
but when the name is longer than CEPH_NOHASH_NAME_MAX, we use a similar
scheme to fscrypt proper, and hash the remaning bits with sha256.

When doing this, we then send along the full crypttext of the name in
the new alternate_name field of the MClientRequest. The MDS can then
send that along in readdir responses and traces.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/crypto.c     | 48 ++++++++++++++++++++++++++
 fs/ceph/crypto.h     | 26 ++++++++++++++
 fs/ceph/mds_client.c | 80 ++++++++++++++++++++++++++++++++++----------
 3 files changed, 136 insertions(+), 18 deletions(-)

diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
index 017f31eacb74..1f54e948b656 100644
--- a/fs/ceph/crypto.c
+++ b/fs/ceph/crypto.c
@@ -127,3 +127,51 @@ void ceph_fscrypt_as_ctx_to_req(struct ceph_mds_request *req, struct ceph_acl_se
 {
 	swap(req->r_fscrypt_auth, as->fscrypt_auth);
 }
+
+int ceph_encode_encrypted_fname(const struct inode *parent, struct dentry *dentry, char *buf)
+{
+	u32 len;
+	int elen;
+	int ret;
+	u8 *cryptbuf;
+
+	WARN_ON_ONCE(!fscrypt_has_encryption_key(parent));
+
+	/*
+	 * convert cleartext dentry name to ciphertext
+	 * if result is longer than CEPH_NOKEY_NAME_MAX,
+	 * sha256 the remaining bytes
+	 *
+	 * See: fscrypt_setup_filename
+	 */
+	if (!fscrypt_fname_encrypted_size(parent, dentry->d_name.len, NAME_MAX, &len))
+		return -ENAMETOOLONG;
+
+	/* Allocate a buffer appropriate to hold the result */
+	cryptbuf = kmalloc(len > CEPH_NOHASH_NAME_MAX ? NAME_MAX : len, GFP_KERNEL);
+	if (!cryptbuf)
+		return -ENOMEM;
+
+	ret = fscrypt_fname_encrypt(parent, &dentry->d_name, cryptbuf, len);
+	if (ret) {
+		kfree(cryptbuf);
+		return ret;
+	}
+
+	/* hash the end if the name is long enough */
+	if (len > CEPH_NOHASH_NAME_MAX) {
+		u8 hash[SHA256_DIGEST_SIZE];
+		u8 *extra = cryptbuf + CEPH_NOHASH_NAME_MAX;
+
+		/* hash the extra bytes and overwrite crypttext beyond that point with it */
+		sha256(extra, len - CEPH_NOHASH_NAME_MAX, hash);
+		memcpy(extra, hash, SHA256_DIGEST_SIZE);
+		len = CEPH_NOHASH_NAME_MAX + SHA256_DIGEST_SIZE;
+	}
+
+	/* base64 encode the encrypted name */
+	elen = fscrypt_base64url_encode(cryptbuf, len, buf);
+	kfree(cryptbuf);
+	dout("base64-encoded ciphertext name = %.*s\n", elen, buf);
+	return elen;
+}
diff --git a/fs/ceph/crypto.h b/fs/ceph/crypto.h
index cb00fe42d5b7..d5e298383b3e 100644
--- a/fs/ceph/crypto.h
+++ b/fs/ceph/crypto.h
@@ -6,6 +6,7 @@
 #ifndef _CEPH_CRYPTO_H
 #define _CEPH_CRYPTO_H
 
+#include <crypto/sha2.h>
 #include <linux/fscrypt.h>
 
 struct ceph_fs_client;
@@ -27,6 +28,24 @@ static inline u32 ceph_fscrypt_auth_len(struct ceph_fscrypt_auth *fa)
 }
 
 #ifdef CONFIG_FS_ENCRYPTION
+/*
+ * We want to encrypt filenames when creating them, but the encrypted
+ * versions of those names may have illegal characters in them. To mitigate
+ * that, we base64 encode them, but that gives us a result that can exceed
+ * NAME_MAX.
+ *
+ * Follow a similar scheme to fscrypt itself, and cap the filename to a
+ * smaller size. If the ciphertext name is longer than the value below, then
+ * sha256 hash the remaining bytes.
+ *
+ * 189 bytes => 252 bytes base64-encoded, which is <= NAME_MAX (255)
+ *
+ * Note that for long names that end up having their tail portion hashed, we
+ * must also store the full encrypted name (in the dentry's alternate_name
+ * field).
+ */
+#define CEPH_NOHASH_NAME_MAX (189 - SHA256_DIGEST_SIZE)
+
 void ceph_fscrypt_set_ops(struct super_block *sb);
 
 void ceph_fscrypt_free_dummy_policy(struct ceph_fs_client *fsc);
@@ -34,6 +53,7 @@ void ceph_fscrypt_free_dummy_policy(struct ceph_fs_client *fsc);
 int ceph_fscrypt_prepare_context(struct inode *dir, struct inode *inode,
 				 struct ceph_acl_sec_ctx *as);
 void ceph_fscrypt_as_ctx_to_req(struct ceph_mds_request *req, struct ceph_acl_sec_ctx *as);
+int ceph_encode_encrypted_fname(const struct inode *parent, struct dentry *dentry, char *buf);
 
 #else /* CONFIG_FS_ENCRYPTION */
 
@@ -57,6 +77,12 @@ static inline void ceph_fscrypt_as_ctx_to_req(struct ceph_mds_request *req,
 						struct ceph_acl_sec_ctx *as_ctx)
 {
 }
+
+static inline int ceph_encode_encrypted_fname(const struct inode *parent,
+						struct dentry *dentry, char *buf)
+{
+	return -EOPNOTSUPP;
+}
 #endif /* CONFIG_FS_ENCRYPTION */
 
 #endif
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 68552cee3e8e..9552a2eb3e10 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -14,6 +14,7 @@
 #include <linux/bitmap.h>
 
 #include "super.h"
+#include "crypto.h"
 #include "mds_client.h"
 #include "crypto.h"
 
@@ -2355,18 +2356,27 @@ static inline  u64 __get_oldest_tid(struct ceph_mds_client *mdsc)
 	return mdsc->oldest_tid;
 }
 
-/*
- * Build a dentry's path.  Allocate on heap; caller must kfree.  Based
- * on build_path_from_dentry in fs/cifs/dir.c.
+/**
+ * ceph_mdsc_build_path - build a path string to a given dentry
+ * @dentry: dentry to which path should be built
+ * @plen: returned length of string
+ * @pbase: returned base inode number
+ * @for_wire: is this path going to be sent to the MDS?
+ *
+ * Build a string that represents the path to the dentry. This is mostly called
+ * for two different purposes:
  *
- * If @stop_on_nosnap, generate path relative to the first non-snapped
- * inode.
+ * 1) we need to build a path string to send to the MDS (for_wire == true)
+ * 2) we need a path string for local presentation (e.g. debugfs) (for_wire == false)
+ *
+ * The path is built in reverse, starting with the dentry. Walk back up toward
+ * the root, building the path until the first non-snapped inode is reached (for_wire)
+ * or the root inode is reached (!for_wire).
  *
  * Encode hidden .snap dirs as a double /, i.e.
  *   foo/.snap/bar -> foo//bar
  */
-char *ceph_mdsc_build_path(struct dentry *dentry, int *plen, u64 *pbase,
-			   int stop_on_nosnap)
+char *ceph_mdsc_build_path(struct dentry *dentry, int *plen, u64 *pbase, int for_wire)
 {
 	struct dentry *cur;
 	struct inode *inode;
@@ -2388,30 +2398,65 @@ char *ceph_mdsc_build_path(struct dentry *dentry, int *plen, u64 *pbase,
 	seq = read_seqbegin(&rename_lock);
 	cur = dget(dentry);
 	for (;;) {
-		struct dentry *temp;
+		struct dentry *parent;
 
 		spin_lock(&cur->d_lock);
 		inode = d_inode(cur);
 		if (inode && ceph_snap(inode) == CEPH_SNAPDIR) {
 			dout("build_path path+%d: %p SNAPDIR\n",
 			     pos, cur);
-		} else if (stop_on_nosnap && inode && dentry != cur &&
-			   ceph_snap(inode) == CEPH_NOSNAP) {
+			spin_unlock(&cur->d_lock);
+			parent = dget_parent(cur);
+		} else if (for_wire && inode && dentry != cur && ceph_snap(inode) == CEPH_NOSNAP) {
 			spin_unlock(&cur->d_lock);
 			pos++; /* get rid of any prepended '/' */
 			break;
-		} else {
+		} else if (!for_wire || !IS_ENCRYPTED(d_inode(cur->d_parent))) {
 			pos -= cur->d_name.len;
 			if (pos < 0) {
 				spin_unlock(&cur->d_lock);
 				break;
 			}
 			memcpy(path + pos, cur->d_name.name, cur->d_name.len);
+			spin_unlock(&cur->d_lock);
+			parent = dget_parent(cur);
+		} else {
+			int len, ret;
+			char buf[FSCRYPT_BASE64URL_CHARS(NAME_MAX)];
+
+			/*
+			 * Proactively copy name into buf, in case we need to present
+			 * it as-is.
+			 */
+			memcpy(buf, cur->d_name.name, cur->d_name.len);
+			len = cur->d_name.len;
+			spin_unlock(&cur->d_lock);
+			parent = dget_parent(cur);
+
+			ret = __fscrypt_prepare_readdir(d_inode(parent));
+			if (ret < 0) {
+				dput(parent);
+				dput(cur);
+				return ERR_PTR(ret);
+			}
+
+			if (fscrypt_has_encryption_key(d_inode(parent))) {
+				len = ceph_encode_encrypted_fname(d_inode(parent), cur, buf);
+				if (len < 0) {
+					dput(parent);
+					dput(cur);
+					return ERR_PTR(len);
+				}
+			}
+			pos -= len;
+			if (pos < 0) {
+				dput(parent);
+				break;
+			}
+			memcpy(path + pos, buf, len);
 		}
-		temp = cur;
-		spin_unlock(&temp->d_lock);
-		cur = dget_parent(temp);
-		dput(temp);
+		dput(cur);
+		cur = parent;
 
 		/* Are we at the root? */
 		if (IS_ROOT(cur))
@@ -2435,8 +2480,7 @@ char *ceph_mdsc_build_path(struct dentry *dentry, int *plen, u64 *pbase,
 		 * A rename didn't occur, but somehow we didn't end up where
 		 * we thought we would. Throw a warning and try again.
 		 */
-		pr_warn("build_path did not end path lookup where "
-			"expected, pos is %d\n", pos);
+		pr_warn("build_path did not end path lookup where expected (pos = %d)\n", pos);
 		goto retry;
 	}
 
@@ -2456,7 +2500,7 @@ static int build_dentry_path(struct dentry *dentry, struct inode *dir,
 	rcu_read_lock();
 	if (!dir)
 		dir = d_inode_rcu(dentry->d_parent);
-	if (dir && parent_locked && ceph_snap(dir) == CEPH_NOSNAP) {
+	if (dir && parent_locked && ceph_snap(dir) == CEPH_NOSNAP && !IS_ENCRYPTED(dir)) {
 		*pino = ceph_ino(dir);
 		rcu_read_unlock();
 		*ppath = dentry->d_name.name;
-- 
2.34.1

