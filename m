Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9E535E57E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Apr 2021 19:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347437AbhDMRv0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Apr 2021 13:51:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:44782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347373AbhDMRvU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Apr 2021 13:51:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 25D0A61244;
        Tue, 13 Apr 2021 17:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618336260;
        bh=6ZTKuG+d544jLbASv8uz3PEyZtjsZ2nkcyqeh1EalEs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A4CnQMo4OU4s3is+0WaEjej7kILPs7EDdMuP93b9SMbjEbGaIUrqausmHwJArNo8f
         I3oTyegZwJCDd57eVLgwwFMkNAnVKj6jBjPY3+l07BbZl2AaVBi8zHiqt6jUVDnIav
         aGdBFF5GBnDpLF561CU73yTBqOWPy80ntzjFw1/FJIYPfXZZMP9xoxVxooDQ8Ob+Od
         JeB2HzoRwqlWXbiHlLttKdamynG/ECS9bg8jY2u0W8zorybFhaiva5725AguxRZDE6
         qprXtucfhnJX/GXBMow2tNTbY5uaKNYFoLK6gIqztQT+0emYcBGqP//+Az1iefxg4a
         T4LgXYBwQijgQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        lhenriques@suse.de
Subject: [RFC PATCH v6 10/20] ceph: add encrypted fname handling to ceph_mdsc_build_path
Date:   Tue, 13 Apr 2021 13:50:42 -0400
Message-Id: <20210413175052.163865-11-jlayton@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210413175052.163865-1-jlayton@kernel.org>
References: <20210413175052.163865-1-jlayton@kernel.org>
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
 fs/ceph/crypto.h     |  16 +++++
 fs/ceph/mds_client.c | 138 +++++++++++++++++++++++++++++++++++++------
 2 files changed, 136 insertions(+), 18 deletions(-)

diff --git a/fs/ceph/crypto.h b/fs/ceph/crypto.h
index cc4e481bf13a..331b9c8da7fb 100644
--- a/fs/ceph/crypto.h
+++ b/fs/ceph/crypto.h
@@ -6,11 +6,27 @@
 #ifndef _CEPH_CRYPTO_H
 #define _CEPH_CRYPTO_H
 
+#include <crypto/sha2.h>
 #include <linux/fscrypt.h>
 
 #define	CEPH_XATTR_NAME_ENCRYPTION_CONTEXT	"encryption.ctx"
 
 #ifdef CONFIG_FS_ENCRYPTION
+
+/*
+ * We want to encrypt filenames when creating them, but the encrypted
+ * versions of those names may have illegal characters in them. To mitigate
+ * that, we base64 encode them, but that gives us a result that can exceed
+ * NAME_MAX.
+ *
+ * Follow a similar scheme to fscrypt itself, and cap the filename to a
+ * smaller size. If the cleartext name is longer than the value below, then
+ * sha256 hash the remaining bytes.
+ *
+ * 189 bytes => 252 bytes base64-encoded, which is <= NAME_MAX (255)
+ */
+#define CEPH_NOHASH_NAME_MAX (189 - SHA256_DIGEST_SIZE)
+
 void ceph_fscrypt_set_ops(struct super_block *sb);
 
 static inline void ceph_fscrypt_free_dummy_policy(struct ceph_fs_client *fsc)
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index ad0754a45811..85e8f578d555 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -13,6 +13,7 @@
 #include <linux/ktime.h>
 
 #include "super.h"
+#include "crypto.h"
 #include "mds_client.h"
 
 #include <linux/ceph/ceph_features.h>
@@ -2344,18 +2345,85 @@ static inline  u64 __get_oldest_tid(struct ceph_mds_client *mdsc)
 	return mdsc->oldest_tid;
 }
 
-/*
- * Build a dentry's path.  Allocate on heap; caller must kfree.  Based
- * on build_path_from_dentry in fs/cifs/dir.c.
+#if IS_ENABLED(CONFIG_FS_ENCRYPTION)
+static int encode_encrypted_fname(const struct inode *parent, struct dentry *dentry, char *buf)
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
+	/* If we have to hash the end, then we need a full-length buffer */
+	if (len > CEPH_NOHASH_NAME_MAX)
+		len = NAME_MAX;
+
+	cryptbuf = kmalloc(len, GFP_KERNEL);
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
+	elen = fscrypt_base64_encode(cryptbuf, len, buf);
+	kfree(cryptbuf);
+	dout("base64-encoded ciphertext name = %.*s\n", len, buf);
+	return elen;
+}
+#else
+static int encode_encrypted_fname(const struct inode *parent, struct dentry *dentry, char *buf)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
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
@@ -2377,30 +2445,65 @@ char *ceph_mdsc_build_path(struct dentry *dentry, int *plen, u64 *pbase,
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
+			char buf[FSCRYPT_BASE64_CHARS(NAME_MAX)];
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
+				len = encode_encrypted_fname(d_inode(parent), cur, buf);
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
@@ -2424,8 +2527,7 @@ char *ceph_mdsc_build_path(struct dentry *dentry, int *plen, u64 *pbase,
 		 * A rename didn't occur, but somehow we didn't end up where
 		 * we thought we would. Throw a warning and try again.
 		 */
-		pr_warn("build_path did not end path lookup where "
-			"expected, pos is %d\n", pos);
+		pr_warn("build_path did not end path lookup where expected (pos = %d)\n", pos);
 		goto retry;
 	}
 
@@ -2445,7 +2547,7 @@ static int build_dentry_path(struct dentry *dentry, struct inode *dir,
 	rcu_read_lock();
 	if (!dir)
 		dir = d_inode_rcu(dentry->d_parent);
-	if (dir && parent_locked && ceph_snap(dir) == CEPH_NOSNAP) {
+	if (dir && parent_locked && ceph_snap(dir) == CEPH_NOSNAP && !IS_ENCRYPTED(dir)) {
 		*pino = ceph_ino(dir);
 		rcu_read_unlock();
 		*ppath = dentry->d_name.name;
-- 
2.30.2

