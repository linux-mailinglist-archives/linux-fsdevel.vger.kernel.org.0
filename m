Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D722710FE38
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2019 13:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbfLCM5a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Dec 2019 07:57:30 -0500
Received: from mail.loongson.cn ([114.242.206.163]:55734 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725957AbfLCM5a (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Dec 2019 07:57:30 -0500
Received: from linux.localdomain (unknown [123.138.236.242])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxLxelW+ZdeWkGAA--.10S2;
        Tue, 03 Dec 2019 20:57:10 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Tyler Hicks <tyhicks@canonical.com>
Cc:     linux-fsdevel@vger.kernel.org, ecryptfs@vger.kernel.org,
        linux-fscrypt@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] fs: introduce is_dot_dotdot helper for cleanup
Date:   Tue,  3 Dec 2019 20:56:50 +0800
Message-Id: <1575377810-3574-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9DxLxelW+ZdeWkGAA--.10S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCFWktry5XFykKr13Zr43Wrg_yoWrKrWxpF
        43JF97Jrn7JFyY9rn5tF1rA34Yv34xGr17GrZ7Ga4Iyry2qrnYqrWIyryF93Z3JFZ8Zws0
        gan5G34rCa43taDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvvb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwV
        C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY
        04v7MxkIecxEwVAFwVW5JwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
        C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
        wI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
        v20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E
        87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
        IFyTuYvjxUg0JmDUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There exists many similar and duplicate codes to check "." and "..",
so introduce is_dot_dotdot helper to make the code more clean.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---

v2:
  - use the better performance implementation of is_dot_dotdot
  - make it static inline and move it to include/linux/fs.h

 fs/crypto/fname.c    | 15 ++-------------
 fs/ecryptfs/crypto.c | 13 ++-----------
 fs/f2fs/f2fs.h       | 11 -----------
 fs/namei.c           |  6 ++----
 include/linux/fs.h   | 10 ++++++++++
 5 files changed, 16 insertions(+), 39 deletions(-)

diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
index 3da3707..36be864 100644
--- a/fs/crypto/fname.c
+++ b/fs/crypto/fname.c
@@ -15,17 +15,6 @@
 #include <crypto/skcipher.h>
 #include "fscrypt_private.h"
 
-static inline bool fscrypt_is_dot_dotdot(const struct qstr *str)
-{
-	if (str->len == 1 && str->name[0] == '.')
-		return true;
-
-	if (str->len == 2 && str->name[0] == '.' && str->name[1] == '.')
-		return true;
-
-	return false;
-}
-
 /**
  * fname_encrypt() - encrypt a filename
  *
@@ -255,7 +244,7 @@ int fscrypt_fname_disk_to_usr(struct inode *inode,
 	const struct qstr qname = FSTR_TO_QSTR(iname);
 	struct fscrypt_digested_name digested_name;
 
-	if (fscrypt_is_dot_dotdot(&qname)) {
+	if (is_dot_dotdot(&qname)) {
 		oname->name[0] = '.';
 		oname->name[iname->len - 1] = '.';
 		oname->len = iname->len;
@@ -323,7 +312,7 @@ int fscrypt_setup_filename(struct inode *dir, const struct qstr *iname,
 	memset(fname, 0, sizeof(struct fscrypt_name));
 	fname->usr_fname = iname;
 
-	if (!IS_ENCRYPTED(dir) || fscrypt_is_dot_dotdot(iname)) {
+	if (!IS_ENCRYPTED(dir) || is_dot_dotdot(iname)) {
 		fname->disk_name.name = (unsigned char *)iname->name;
 		fname->disk_name.len = iname->len;
 		return 0;
diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index f91db24..6f4db74 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -1991,16 +1991,6 @@ int ecryptfs_encrypt_and_encode_filename(
 	return rc;
 }
 
-static bool is_dot_dotdot(const char *name, size_t name_size)
-{
-	if (name_size == 1 && name[0] == '.')
-		return true;
-	else if (name_size == 2 && name[0] == '.' && name[1] == '.')
-		return true;
-
-	return false;
-}
-
 /**
  * ecryptfs_decode_and_decrypt_filename - converts the encoded cipher text name to decoded plaintext
  * @plaintext_name: The plaintext name
@@ -2020,6 +2010,7 @@ int ecryptfs_decode_and_decrypt_filename(char **plaintext_name,
 {
 	struct ecryptfs_mount_crypt_stat *mount_crypt_stat =
 		&ecryptfs_superblock_to_private(sb)->mount_crypt_stat;
+	const struct qstr file_name = {.name = name, .len = name_size};
 	char *decoded_name;
 	size_t decoded_name_size;
 	size_t packet_size;
@@ -2027,7 +2018,7 @@ int ecryptfs_decode_and_decrypt_filename(char **plaintext_name,
 
 	if ((mount_crypt_stat->flags & ECRYPTFS_GLOBAL_ENCRYPT_FILENAMES) &&
 	    !(mount_crypt_stat->flags & ECRYPTFS_ENCRYPTED_VIEW_ENABLED)) {
-		if (is_dot_dotdot(name, name_size)) {
+		if (is_dot_dotdot(&file_name)) {
 			rc = ecryptfs_copy_filename(plaintext_name,
 						    plaintext_name_size,
 						    name, name_size);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 5a888a0..3d5e684 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2767,17 +2767,6 @@ static inline bool f2fs_cp_error(struct f2fs_sb_info *sbi)
 	return is_set_ckpt_flags(sbi, CP_ERROR_FLAG);
 }
 
-static inline bool is_dot_dotdot(const struct qstr *str)
-{
-	if (str->len == 1 && str->name[0] == '.')
-		return true;
-
-	if (str->len == 2 && str->name[0] == '.' && str->name[1] == '.')
-		return true;
-
-	return false;
-}
-
 static inline bool f2fs_may_extent_tree(struct inode *inode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
diff --git a/fs/namei.c b/fs/namei.c
index 2dda552..babe7e8 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2458,10 +2458,8 @@ static int lookup_one_len_common(const char *name, struct dentry *base,
 	if (!len)
 		return -EACCES;
 
-	if (unlikely(name[0] == '.')) {
-		if (len < 2 || (len == 2 && name[1] == '.'))
-			return -EACCES;
-	}
+	if (is_dot_dotdot(this))
+		return -EACCES;
 
 	while (len--) {
 		unsigned int c = *(const unsigned char *)name++;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 98e0349..78a2932 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3627,4 +3627,14 @@ static inline int inode_drain_writes(struct inode *inode)
 	return filemap_write_and_wait(inode->i_mapping);
 }
 
+static inline bool is_dot_dotdot(const struct qstr *str)
+{
+	if (unlikely(str->name[0] == '.')) {
+		if (str->len < 2 || (str->len == 2 && str->name[1] == '.'))
+			return true;
+	}
+
+	return false;
+}
+
 #endif /* _LINUX_FS_H */
-- 
2.1.0

