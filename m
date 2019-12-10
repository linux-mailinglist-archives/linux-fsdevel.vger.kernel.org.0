Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D95AA1187B2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2019 13:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfLJMKi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 07:10:38 -0500
Received: from mail.loongson.cn ([114.242.206.163]:58424 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727333AbfLJMKi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 07:10:38 -0500
Received: from linux.localdomain (unknown [123.138.236.242])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxn9Yti+9d5i0JAA--.38S2;
        Tue, 10 Dec 2019 20:10:22 +0800 (CST)
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
Subject: [PATCH v4] fs: introduce is_dot_or_dotdot helper for cleanup
Date:   Tue, 10 Dec 2019 20:10:01 +0800
Message-Id: <1575979801-32569-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9Dxn9Yti+9d5i0JAA--.38S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuF43uFyxGw1xWw1fWrWrGrg_yoW7Jw4fpF
        sxJFyxtrs7Gry5ur95tr1rCw1Yv3s7Wr17JrZxGa4vyryaqrn5XrWIyw109wn3JFWDWFn0
        ga98Gw1rCry5JFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvmb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkI
        wI1lc2xSY4AK67AK6ryUMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI
        8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
        xVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI
        8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2
        z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
        UI43ZEXa7IU5qfO3UUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There exists many similar and duplicate codes to check "." and "..",
so introduce is_dot_or_dotdot helper to make the code more clean.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---

v4:
  - rename is_dot_dotdot() to is_dot_or_dotdot()

v3:
  - use "name" and "len" as arguments instead of qstr
  - move is_dot_dotdot() to include/linux/namei.h

v2:
  - use the better performance implementation of is_dot_dotdot
  - make it static inline and move it to include/linux/fs.h

 fs/crypto/fname.c     | 16 +++-------------
 fs/ecryptfs/crypto.c  | 10 ----------
 fs/f2fs/f2fs.h        | 11 -----------
 fs/f2fs/hash.c        |  3 ++-
 fs/namei.c            |  6 ++----
 include/linux/namei.h | 10 ++++++++++
 6 files changed, 17 insertions(+), 39 deletions(-)

diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
index 3da3707..ef7eba8 100644
--- a/fs/crypto/fname.c
+++ b/fs/crypto/fname.c
@@ -11,21 +11,11 @@
  * This has not yet undergone a rigorous security audit.
  */
 
+#include <linux/namei.h>
 #include <linux/scatterlist.h>
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
@@ -255,7 +245,7 @@ int fscrypt_fname_disk_to_usr(struct inode *inode,
 	const struct qstr qname = FSTR_TO_QSTR(iname);
 	struct fscrypt_digested_name digested_name;
 
-	if (fscrypt_is_dot_dotdot(&qname)) {
+	if (is_dot_or_dotdot(qname.name, qname.len)) {
 		oname->name[0] = '.';
 		oname->name[iname->len - 1] = '.';
 		oname->len = iname->len;
@@ -323,7 +313,7 @@ int fscrypt_setup_filename(struct inode *dir, const struct qstr *iname,
 	memset(fname, 0, sizeof(struct fscrypt_name));
 	fname->usr_fname = iname;
 
-	if (!IS_ENCRYPTED(dir) || fscrypt_is_dot_dotdot(iname)) {
+	if (!IS_ENCRYPTED(dir) || is_dot_or_dotdot(iname->name, iname->len)) {
 		fname->disk_name.name = (unsigned char *)iname->name;
 		fname->disk_name.len = iname->len;
 		return 0;
diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index f91db24..2014f8f 100644
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
diff --git a/fs/f2fs/hash.c b/fs/f2fs/hash.c
index 5bc4dcd..ef155c2 100644
--- a/fs/f2fs/hash.c
+++ b/fs/f2fs/hash.c
@@ -15,6 +15,7 @@
 #include <linux/cryptohash.h>
 #include <linux/pagemap.h>
 #include <linux/unicode.h>
+#include <linux/namei.h>
 
 #include "f2fs.h"
 
@@ -82,7 +83,7 @@ static f2fs_hash_t __f2fs_dentry_hash(const struct qstr *name_info,
 	if (fname && !fname->disk_name.name)
 		return cpu_to_le32(fname->hash);
 
-	if (is_dot_dotdot(name_info))
+	if (is_dot_or_dotdot(name, len))
 		return 0;
 
 	/* Initialize the default seed for the hash checksum functions */
diff --git a/fs/namei.c b/fs/namei.c
index d6c91d1..f3a4439 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2451,10 +2451,8 @@ static int lookup_one_len_common(const char *name, struct dentry *base,
 	if (!len)
 		return -EACCES;
 
-	if (unlikely(name[0] == '.')) {
-		if (len < 2 || (len == 2 && name[1] == '.'))
-			return -EACCES;
-	}
+	if (is_dot_or_dotdot(name, len))
+		return -EACCES;
 
 	while (len--) {
 		unsigned int c = *(const unsigned char *)name++;
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 7fe7b87..aba114a 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -92,4 +92,14 @@ retry_estale(const long error, const unsigned int flags)
 	return error == -ESTALE && !(flags & LOOKUP_REVAL);
 }
 
+static inline bool is_dot_or_dotdot(const unsigned char *name, size_t len)
+{
+	if (unlikely(name[0] == '.')) {
+		if (len < 2 || (len == 2 && name[1] == '.'))
+			return true;
+	}
+
+	return false;
+}
+
 #endif /* _LINUX_NAMEI_H */
-- 
2.1.0

