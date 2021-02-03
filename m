Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1839F30D5E3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Feb 2021 10:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbhBCJKh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Feb 2021 04:10:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbhBCJIl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Feb 2021 04:08:41 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E69BC061788
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 Feb 2021 01:07:51 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id bc11so13960548plb.17
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Feb 2021 01:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=13dtcE8Tzdt5sXg1CQ4cmgWOAj8IN0dd/Rcr5UaHsf0=;
        b=dDMgp/wvcBzYZPo8dgijxLWC8iLdrFhH6ptkwdLSYz/Aubcx3bVZLqX3vuqJKVCL0p
         UwKbOTqrlaHaude7xD3yzC1kqmHJMw0KOCeRvdnY3JooU4WMG6FDXSK5aUbzcIwnEFv7
         YB9HZLM3c/s/koS9GEHU1heKLDzOYD5ST2XTNvlYn6t4Ar4/UrSFiXUuiLF0nb7psjZ/
         67t8wm7dQ1j7ABbwF2NJ9ISqsrlIVahPMb6IgjaOhb29XqkLWSbsatMq5IYDkpvDPT2Q
         Q0IDvx5w8go+MYdpNYBO5Z95o67CBwLqCP2lexsEdsOXsIEDmJcXnbhE/kBf45BUTZCL
         bqjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=13dtcE8Tzdt5sXg1CQ4cmgWOAj8IN0dd/Rcr5UaHsf0=;
        b=IkLhnZaDkwMGNJxUNi26P2w+BHb5Z2OX5xy5cZvM6/MJrMuaVmyxqIpDnkYCm+HlSv
         Aic6UbJujUGuhlST51y3YgNp1WpwS5h130f9I141VzD4VqOYbMIwYIqNRH9mrCCYYPD/
         2lqGvWpbNlNGQmwsnIngI0eSZ0Y0im4vwMR77bhAh4WWwSHjoLWGLXZ4F3Y6fMpyANiF
         lBhHCuuTmmrew7+4imJ2h/I1D2FpX6GS3NnFWYrHlkuQGVOm+f3r6JKe9P843Otnw5N6
         9zv8FJhYwdEmd5MAjl6UP/VzE86XEWNaP2Y5B/GDuKwKeV0jbJSeTlbwZivSv7zEdYJC
         l+Jw==
X-Gm-Message-State: AOAM533r1VaaOB558WUBExvBiJLpfncTyHUhFC3zd++YqsBuhs8SgG3A
        xfzZBRpPxV7VD50Sl5qIGvB3MoJ3PjI=
X-Google-Smtp-Source: ABdhPJz/g8pYH7LFz2mIVJEej2Q80VNZP5y61nNFGZGIbfoPk7eTiA69c2SDTbpol9lAta3ltAKf4qFtShU=
Sender: "drosen via sendgmr" <drosen@drosen.c.googlers.com>
X-Received: from drosen.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:4e6f])
 (user=drosen job=sendgmr) by 2002:a17:90b:e8f:: with SMTP id
 fv15mr2291503pjb.178.1612343271060; Wed, 03 Feb 2021 01:07:51 -0800 (PST)
Date:   Wed,  3 Feb 2021 09:07:44 +0000
In-Reply-To: <20210203090745.4103054-1-drosen@google.com>
Message-Id: <20210203090745.4103054-2-drosen@google.com>
Mime-Version: 1.0
References: <20210203090745.4103054-1-drosen@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH 1/2] ext4: Handle casefolding with encryption
From:   Daniel Rosenberg <drosen@google.com>
To:     "Theodore Y . Ts'o" <tytso@mit.edu>,
        Eric Biggers <ebiggers@kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com, Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds support for encryption with casefolding.

Since the name on disk is case preserving, and also encrypted, we can no
longer just recompute the hash on the fly. Additionally, to avoid
leaking extra information from the hash of the unencrypted name, we use
siphash via an fscrypt v2 policy.

The hash is stored at the end of the directory entry for all entries
inside of an encrypted and casefolded directory apart from those that
deal with '.' and '..'. This way, the change is backwards compatible
with existing ext4 filesystems.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
Signed-off-by: Paul Lawrence <paullawrence@google.com>
---
 Documentation/filesystems/ext4/directory.rst |  27 ++
 fs/ext4/dir.c                                |  46 ++-
 fs/ext4/ext4.h                               |  62 +++-
 fs/ext4/hash.c                               |  25 +-
 fs/ext4/ialloc.c                             |   5 +-
 fs/ext4/inline.c                             |  41 +--
 fs/ext4/namei.c                              | 308 +++++++++++++------
 fs/ext4/super.c                              |   6 -
 8 files changed, 373 insertions(+), 147 deletions(-)

diff --git a/Documentation/filesystems/ext4/directory.rst b/Documentation/filesystems/ext4/directory.rst
index 073940cc64ed..55f618b37144 100644
--- a/Documentation/filesystems/ext4/directory.rst
+++ b/Documentation/filesystems/ext4/directory.rst
@@ -121,6 +121,31 @@ The directory file type is one of the following values:
    * - 0x7
      - Symbolic link.
 
+To support directories that are both encrypted and casefolded directories, we
+must also include hash information in the directory entry. We append
+``ext4_extended_dir_entry_2`` to ``ext4_dir_entry_2`` except for the entries
+for dot and dotdot, which are kept the same. The structure follows immediately
+after ``name`` and is included in the size listed by ``rec_len`` If a directory
+entry uses this extension, it may be up to 271 bytes.
+
+.. list-table::
+   :widths: 8 8 24 40
+   :header-rows: 1
+
+   * - Offset
+     - Size
+     - Name
+     - Description
+   * - 0x0
+     - \_\_le32
+     - hash
+     - The hash of the directory name
+   * - 0x4
+     - \_\_le32
+     - minor\_hash
+     - The minor hash of the directory name
+
+
 In order to add checksums to these classic directory blocks, a phony
 ``struct ext4_dir_entry`` is placed at the end of each leaf block to
 hold the checksum. The directory entry is 12 bytes long. The inode
@@ -322,6 +347,8 @@ The directory hash is one of the following values:
      - Half MD4, unsigned.
    * - 0x5
      - Tea, unsigned.
+   * - 0x6
+     - Siphash.
 
 Interior nodes of an htree are recorded as ``struct dx_node``, which is
 also the full length of a data block:
diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
index ca50c90adc4c..9da6db183d4f 100644
--- a/fs/ext4/dir.c
+++ b/fs/ext4/dir.c
@@ -30,6 +30,8 @@
 #include "ext4.h"
 #include "xattr.h"
 
+#define DOTDOT_OFFSET 12
+
 static int ext4_dx_readdir(struct file *, struct dir_context *);
 
 /**
@@ -55,6 +57,19 @@ static int is_dx_dir(struct inode *inode)
 	return 0;
 }
 
+static bool is_fake_entry(struct inode *dir, ext4_lblk_t lblk,
+			  unsigned int offset, unsigned int blocksize)
+{
+	/* Entries in the first block before this value refer to . or .. */
+	if (lblk == 0 && offset <= DOTDOT_OFFSET)
+		return true;
+	/* Check if this is likely the csum entry */
+	if (ext4_has_metadata_csum(dir->i_sb) && offset % blocksize ==
+				blocksize - sizeof(struct ext4_dir_entry_tail))
+		return true;
+	return false;
+}
+
 /*
  * Return 0 if the directory entry is OK, and 1 if there is a problem
  *
@@ -67,22 +82,28 @@ int __ext4_check_dir_entry(const char *function, unsigned int line,
 			   struct inode *dir, struct file *filp,
 			   struct ext4_dir_entry_2 *de,
 			   struct buffer_head *bh, char *buf, int size,
+			   ext4_lblk_t lblk,
 			   unsigned int offset)
 {
 	const char *error_msg = NULL;
 	const int rlen = ext4_rec_len_from_disk(de->rec_len,
 						dir->i_sb->s_blocksize);
 	const int next_offset = ((char *) de - buf) + rlen;
+	unsigned int blocksize = dir->i_sb->s_blocksize;
+	bool fake = is_fake_entry(dir, lblk, offset, blocksize);
+	bool next_fake = is_fake_entry(dir, lblk, next_offset, blocksize);
 
-	if (unlikely(rlen < EXT4_DIR_REC_LEN(1)))
+	if (unlikely(rlen < ext4_dir_rec_len(1, fake ? NULL : dir)))
 		error_msg = "rec_len is smaller than minimal";
 	else if (unlikely(rlen % 4 != 0))
 		error_msg = "rec_len % 4 != 0";
-	else if (unlikely(rlen < EXT4_DIR_REC_LEN(de->name_len)))
+	else if (unlikely(rlen < ext4_dir_rec_len(de->name_len,
+							fake ? NULL : dir)))
 		error_msg = "rec_len is too small for name_len";
 	else if (unlikely(next_offset > size))
 		error_msg = "directory entry overrun";
-	else if (unlikely(next_offset > size - EXT4_DIR_REC_LEN(1) &&
+	else if (unlikely(next_offset > size - ext4_dir_rec_len(1,
+						next_fake ? NULL : dir) &&
 			  next_offset != size))
 		error_msg = "directory entry too close to block end";
 	else if (unlikely(le32_to_cpu(de->inode) >
@@ -94,15 +115,15 @@ int __ext4_check_dir_entry(const char *function, unsigned int line,
 	if (filp)
 		ext4_error_file(filp, function, line, bh->b_blocknr,
 				"bad entry in directory: %s - offset=%u, "
-				"inode=%u, rec_len=%d, name_len=%d, size=%d",
+				"inode=%u, rec_len=%d, lblk=%d, size=%d fake=%d",
 				error_msg, offset, le32_to_cpu(de->inode),
-				rlen, de->name_len, size);
+				rlen, lblk, size, fake);
 	else
 		ext4_error_inode(dir, function, line, bh->b_blocknr,
 				"bad entry in directory: %s - offset=%u, "
-				"inode=%u, rec_len=%d, name_len=%d, size=%d",
+				"inode=%u, rec_len=%d, lblk=%d, size=%d fake=%d",
 				 error_msg, offset, le32_to_cpu(de->inode),
-				 rlen, de->name_len, size);
+				 rlen, lblk, size, fake);
 
 	return 1;
 }
@@ -226,7 +247,8 @@ static int ext4_readdir(struct file *file, struct dir_context *ctx)
 				 * failure will be detected in the
 				 * dirent test below. */
 				if (ext4_rec_len_from_disk(de->rec_len,
-					sb->s_blocksize) < EXT4_DIR_REC_LEN(1))
+					sb->s_blocksize) < ext4_dir_rec_len(1,
+									inode))
 					break;
 				i += ext4_rec_len_from_disk(de->rec_len,
 							    sb->s_blocksize);
@@ -242,7 +264,7 @@ static int ext4_readdir(struct file *file, struct dir_context *ctx)
 			de = (struct ext4_dir_entry_2 *) (bh->b_data + offset);
 			if (ext4_check_dir_entry(inode, file, de, bh,
 						 bh->b_data, bh->b_size,
-						 offset)) {
+						 map.m_lblk, offset)) {
 				/*
 				 * On error, skip to the next block
 				 */
@@ -267,7 +289,9 @@ static int ext4_readdir(struct file *file, struct dir_context *ctx)
 
 					/* Directory is encrypted */
 					err = fscrypt_fname_disk_to_usr(inode,
-						0, 0, &de_name, &fstr);
+						EXT4_DIRENT_HASH(de),
+						EXT4_DIRENT_MINOR_HASH(de),
+						&de_name, &fstr);
 					de_name = fstr;
 					fstr.len = save_len;
 					if (err)
@@ -643,7 +667,7 @@ int ext4_check_all_de(struct inode *dir, struct buffer_head *bh, void *buf,
 	top = buf + buf_size;
 	while ((char *) de < top) {
 		if (ext4_check_dir_entry(dir, NULL, de, bh,
-					 buf, buf_size, offset))
+					 buf, buf_size, 0, offset))
 			return -EFSCORRUPTED;
 		rlen = ext4_rec_len_from_disk(de->rec_len, buf_size);
 		de = (struct ext4_dir_entry_2 *)((char *)de + rlen);
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 64f25ea2fa7a..90a2c182e4d7 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2195,6 +2195,17 @@ struct ext4_dir_entry {
 	char	name[EXT4_NAME_LEN];	/* File name */
 };
 
+
+/*
+ * Encrypted Casefolded entries require saving the hash on disk. This structure
+ * followed ext4_dir_entry_2's name[name_len] at the next 4 byte aligned
+ * boundary.
+ */
+struct ext4_dir_entry_hash {
+	__le32 hash;
+	__le32 minor_hash;
+};
+
 /*
  * The new version of the directory entry.  Since EXT4 structures are
  * stored in intel byte order, and the name_len field could never be
@@ -2209,6 +2220,22 @@ struct ext4_dir_entry_2 {
 	char	name[EXT4_NAME_LEN];	/* File name */
 };
 
+/*
+ * Access the hashes at the end of ext4_dir_entry_2
+ */
+#define EXT4_DIRENT_HASHES(entry) \
+	((struct ext4_dir_entry_hash *) \
+		(((void *)(entry)) + \
+		((8 + (entry)->name_len + EXT4_DIR_ROUND) & ~EXT4_DIR_ROUND)))
+#define EXT4_DIRENT_HASH(entry) le32_to_cpu(EXT4_DIRENT_HASHES(de)->hash)
+#define EXT4_DIRENT_MINOR_HASH(entry) \
+		le32_to_cpu(EXT4_DIRENT_HASHES(de)->minor_hash)
+
+static inline bool ext4_hash_in_dirent(const struct inode *inode)
+{
+	return IS_CASEFOLDED(inode) && IS_ENCRYPTED(inode);
+}
+
 /*
  * This is a bogus directory entry at the end of each leaf block that
  * records checksums.
@@ -2250,10 +2277,24 @@ struct ext4_dir_entry_tail {
  */
 #define EXT4_DIR_PAD			4
 #define EXT4_DIR_ROUND			(EXT4_DIR_PAD - 1)
-#define EXT4_DIR_REC_LEN(name_len)	(((name_len) + 8 + EXT4_DIR_ROUND) & \
-					 ~EXT4_DIR_ROUND)
 #define EXT4_MAX_REC_LEN		((1<<16)-1)
 
+/*
+ * The rec_len is dependent on the type of directory. Directories that are
+ * casefolded and encrypted need to store the hash as well, so we add room for
+ * ext4_extended_dir_entry_2. For all entries related to '.' or '..' you should
+ * pass NULL for dir, as those entries do not use the extra fields.
+ */
+static inline unsigned int ext4_dir_rec_len(__u8 name_len,
+						const struct inode *dir)
+{
+	int rec_len = (name_len + 8 + EXT4_DIR_ROUND);
+
+	if (dir && ext4_hash_in_dirent(dir))
+		rec_len += sizeof(struct ext4_dir_entry_hash);
+	return (rec_len & ~EXT4_DIR_ROUND);
+}
+
 /*
  * If we ever get support for fs block sizes > page_size, we'll need
  * to remove the #if statements in the next two functions...
@@ -2310,6 +2351,7 @@ static inline __le16 ext4_rec_len_to_disk(unsigned len, unsigned blocksize)
 #define DX_HASH_LEGACY_UNSIGNED		3
 #define DX_HASH_HALF_MD4_UNSIGNED	4
 #define DX_HASH_TEA_UNSIGNED		5
+#define DX_HASH_SIPHASH			6
 
 static inline u32 ext4_chksum(struct ext4_sb_info *sbi, u32 crc,
 			      const void *address, unsigned int length)
@@ -2364,6 +2406,7 @@ struct ext4_filename {
 };
 
 #define fname_name(p) ((p)->disk_name.name)
+#define fname_usr_name(p) ((p)->usr_fname->name)
 #define fname_len(p)  ((p)->disk_name.len)
 
 /*
@@ -2705,21 +2748,22 @@ extern int __ext4_check_dir_entry(const char *, unsigned int, struct inode *,
 				  struct file *,
 				  struct ext4_dir_entry_2 *,
 				  struct buffer_head *, char *, int,
-				  unsigned int);
-#define ext4_check_dir_entry(dir, filp, de, bh, buf, size, offset)	\
+				  ext4_lblk_t, unsigned int);
+#define ext4_check_dir_entry(dir, filp, de, bh, buf, size, lblk, offset) \
 	unlikely(__ext4_check_dir_entry(__func__, __LINE__, (dir), (filp), \
-					(de), (bh), (buf), (size), (offset)))
+				(de), (bh), (buf), (size), (lblk), (offset)))
 extern int ext4_htree_store_dirent(struct file *dir_file, __u32 hash,
 				__u32 minor_hash,
 				struct ext4_dir_entry_2 *dirent,
 				struct fscrypt_str *ent_name);
 extern void ext4_htree_free_dir_info(struct dir_private_info *p);
 extern int ext4_find_dest_de(struct inode *dir, struct inode *inode,
+			     ext4_lblk_t lblk,
 			     struct buffer_head *bh,
 			     void *buf, int buf_size,
 			     struct ext4_filename *fname,
 			     struct ext4_dir_entry_2 **dest_de);
-void ext4_insert_dentry(struct inode *inode,
+void ext4_insert_dentry(struct inode *dir, struct inode *inode,
 			struct ext4_dir_entry_2 *de,
 			int buf_size,
 			struct ext4_filename *fname);
@@ -2941,10 +2985,11 @@ extern int ext4_search_dir(struct buffer_head *bh,
 			   int buf_size,
 			   struct inode *dir,
 			   struct ext4_filename *fname,
-			   unsigned int offset,
+			   ext4_lblk_t lblk, unsigned int offset,
 			   struct ext4_dir_entry_2 **res_dir);
 extern int ext4_generic_delete_entry(struct inode *dir,
 				     struct ext4_dir_entry_2 *de_del,
+				     ext4_lblk_t lblk,
 				     struct buffer_head *bh,
 				     void *entry_buf,
 				     int buf_size,
@@ -3516,9 +3561,6 @@ extern void ext4_initialize_dirent_tail(struct buffer_head *bh,
 					unsigned int blocksize);
 extern int ext4_handle_dirty_dirblock(handle_t *handle, struct inode *inode,
 				      struct buffer_head *bh);
-extern int ext4_ci_compare(const struct inode *parent,
-			   const struct qstr *fname,
-			   const struct qstr *entry, bool quick);
 extern int __ext4_unlink(handle_t *handle, struct inode *dir, const struct qstr *d_name,
 			 struct inode *inode);
 extern int __ext4_link(struct inode *dir, struct inode *inode,
diff --git a/fs/ext4/hash.c b/fs/ext4/hash.c
index a92eb79de0cc..f34f4176c1e7 100644
--- a/fs/ext4/hash.c
+++ b/fs/ext4/hash.c
@@ -197,7 +197,7 @@ static void str2hashbuf_unsigned(const char *msg, int len, __u32 *buf, int num)
  * represented, and whether or not the returned hash is 32 bits or 64
  * bits.  32 bit hashes will return 0 for the minor hash.
  */
-static int __ext4fs_dirhash(const char *name, int len,
+static int __ext4fs_dirhash(const struct inode *dir, const char *name, int len,
 			    struct dx_hash_info *hinfo)
 {
 	__u32	hash;
@@ -259,6 +259,22 @@ static int __ext4fs_dirhash(const char *name, int len,
 		hash = buf[0];
 		minor_hash = buf[1];
 		break;
+	case DX_HASH_SIPHASH:
+	{
+		struct qstr qname = QSTR_INIT(name, len);
+		__u64	combined_hash;
+
+		if (fscrypt_has_encryption_key(dir)) {
+			combined_hash = fscrypt_fname_siphash(dir, &qname);
+		} else {
+			ext4_warning_inode(dir, "Siphash requires key");
+			return -1;
+		}
+
+		hash = (__u32)(combined_hash >> 32);
+		minor_hash = (__u32)combined_hash;
+		break;
+	}
 	default:
 		hinfo->hash = 0;
 		return -1;
@@ -280,7 +296,8 @@ int ext4fs_dirhash(const struct inode *dir, const char *name, int len,
 	unsigned char *buff;
 	struct qstr qstr = {.name = name, .len = len };
 
-	if (len && IS_CASEFOLDED(dir) && um) {
+	if (len && IS_CASEFOLDED(dir) && um &&
+	   (!IS_ENCRYPTED(dir) || fscrypt_has_encryption_key(dir))) {
 		buff = kzalloc(sizeof(char) * PATH_MAX, GFP_KERNEL);
 		if (!buff)
 			return -ENOMEM;
@@ -291,12 +308,12 @@ int ext4fs_dirhash(const struct inode *dir, const char *name, int len,
 			goto opaque_seq;
 		}
 
-		r = __ext4fs_dirhash(buff, dlen, hinfo);
+		r = __ext4fs_dirhash(dir, buff, dlen, hinfo);
 
 		kfree(buff);
 		return r;
 	}
 opaque_seq:
 #endif
-	return __ext4fs_dirhash(name, len, hinfo);
+	return __ext4fs_dirhash(dir, name, len, hinfo);
 }
diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index b215c564bc31..14aef148a968 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -457,7 +457,10 @@ static int find_group_orlov(struct super_block *sb, struct inode *parent,
 		int ret = -1;
 
 		if (qstr) {
-			hinfo.hash_version = DX_HASH_HALF_MD4;
+			if (ext4_hash_in_dirent(parent))
+				hinfo.hash_version = DX_HASH_SIPHASH;
+			else
+				hinfo.hash_version = DX_HASH_HALF_MD4;
 			hinfo.seed = sbi->s_hash_seed;
 			ext4fs_dirhash(parent, qstr->name, qstr->len, &hinfo);
 			grp = hinfo.hash;
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index b41512d1badc..46b06be15d0a 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -996,7 +996,7 @@ void ext4_show_inline_dir(struct inode *dir, struct buffer_head *bh,
 			     offset, de_len, de->name_len, de->name,
 			     de->name_len, le32_to_cpu(de->inode));
 		if (ext4_check_dir_entry(dir, NULL, de, bh,
-					 inline_start, inline_size, offset))
+					 inline_start, inline_size, 0, offset))
 			BUG();
 
 		offset += de_len;
@@ -1022,7 +1022,7 @@ static int ext4_add_dirent_to_inline(handle_t *handle,
 	int		err;
 	struct ext4_dir_entry_2 *de;
 
-	err = ext4_find_dest_de(dir, inode, iloc->bh, inline_start,
+	err = ext4_find_dest_de(dir, inode, 0, iloc->bh, inline_start,
 				inline_size, fname, &de);
 	if (err)
 		return err;
@@ -1031,7 +1031,7 @@ static int ext4_add_dirent_to_inline(handle_t *handle,
 	err = ext4_journal_get_write_access(handle, iloc->bh);
 	if (err)
 		return err;
-	ext4_insert_dentry(inode, de, inline_size, fname);
+	ext4_insert_dentry(dir, inode, de, inline_size, fname);
 
 	ext4_show_inline_dir(dir, iloc->bh, inline_start, inline_size);
 
@@ -1100,7 +1100,7 @@ static int ext4_update_inline_dir(handle_t *handle, struct inode *dir,
 	int old_size = EXT4_I(dir)->i_inline_size - EXT4_MIN_INLINE_DATA_SIZE;
 	int new_size = get_max_inline_xattr_value_size(dir, iloc);
 
-	if (new_size - old_size <= EXT4_DIR_REC_LEN(1))
+	if (new_size - old_size <= ext4_dir_rec_len(1, NULL))
 		return -ENOSPC;
 
 	ret = ext4_update_inline_data(handle, dir,
@@ -1380,8 +1380,8 @@ int ext4_inlinedir_to_tree(struct file *dir_file,
 			fake.name_len = 1;
 			strcpy(fake.name, ".");
 			fake.rec_len = ext4_rec_len_to_disk(
-						EXT4_DIR_REC_LEN(fake.name_len),
-						inline_size);
+					  ext4_dir_rec_len(fake.name_len, NULL),
+					  inline_size);
 			ext4_set_de_type(inode->i_sb, &fake, S_IFDIR);
 			de = &fake;
 			pos = EXT4_INLINE_DOTDOT_OFFSET;
@@ -1390,8 +1390,8 @@ int ext4_inlinedir_to_tree(struct file *dir_file,
 			fake.name_len = 2;
 			strcpy(fake.name, "..");
 			fake.rec_len = ext4_rec_len_to_disk(
-						EXT4_DIR_REC_LEN(fake.name_len),
-						inline_size);
+					  ext4_dir_rec_len(fake.name_len, NULL),
+					  inline_size);
 			ext4_set_de_type(inode->i_sb, &fake, S_IFDIR);
 			de = &fake;
 			pos = EXT4_INLINE_DOTDOT_SIZE;
@@ -1400,13 +1400,18 @@ int ext4_inlinedir_to_tree(struct file *dir_file,
 			pos += ext4_rec_len_from_disk(de->rec_len, inline_size);
 			if (ext4_check_dir_entry(inode, dir_file, de,
 					 iloc.bh, dir_buf,
-					 inline_size, pos)) {
+					 inline_size, block, pos)) {
 				ret = count;
 				goto out;
 			}
 		}
 
-		ext4fs_dirhash(dir, de->name, de->name_len, hinfo);
+		if (ext4_hash_in_dirent(dir)) {
+			hinfo->hash = EXT4_DIRENT_HASH(de);
+			hinfo->minor_hash = EXT4_DIRENT_MINOR_HASH(de);
+		} else {
+			ext4fs_dirhash(dir, de->name, de->name_len, hinfo);
+		}
 		if ((hinfo->hash < start_hash) ||
 		    ((hinfo->hash == start_hash) &&
 		     (hinfo->minor_hash < start_minor_hash)))
@@ -1488,8 +1493,8 @@ int ext4_read_inline_dir(struct file *file,
 	 * So we will use extra_offset and extra_size to indicate them
 	 * during the inline dir iteration.
 	 */
-	dotdot_offset = EXT4_DIR_REC_LEN(1);
-	dotdot_size = dotdot_offset + EXT4_DIR_REC_LEN(2);
+	dotdot_offset = ext4_dir_rec_len(1, NULL);
+	dotdot_size = dotdot_offset + ext4_dir_rec_len(2, NULL);
 	extra_offset = dotdot_size - EXT4_INLINE_DOTDOT_SIZE;
 	extra_size = extra_offset + inline_size;
 
@@ -1524,7 +1529,7 @@ int ext4_read_inline_dir(struct file *file,
 			 * failure will be detected in the
 			 * dirent test below. */
 			if (ext4_rec_len_from_disk(de->rec_len, extra_size)
-				< EXT4_DIR_REC_LEN(1))
+				< ext4_dir_rec_len(1, NULL))
 				break;
 			i += ext4_rec_len_from_disk(de->rec_len,
 						    extra_size);
@@ -1552,7 +1557,7 @@ int ext4_read_inline_dir(struct file *file,
 		de = (struct ext4_dir_entry_2 *)
 			(dir_buf + ctx->pos - extra_offset);
 		if (ext4_check_dir_entry(inode, file, de, iloc.bh, dir_buf,
-					 extra_size, ctx->pos))
+					 extra_size, 0, ctx->pos))
 			goto out;
 		if (le32_to_cpu(de->inode)) {
 			if (!dir_emit(ctx, de->name, de->name_len,
@@ -1644,7 +1649,7 @@ struct buffer_head *ext4_find_inline_entry(struct inode *dir,
 						EXT4_INLINE_DOTDOT_SIZE;
 	inline_size = EXT4_MIN_INLINE_DATA_SIZE - EXT4_INLINE_DOTDOT_SIZE;
 	ret = ext4_search_dir(iloc.bh, inline_start, inline_size,
-			      dir, fname, 0, res_dir);
+			      dir, fname, 0, 0, res_dir);
 	if (ret == 1)
 		goto out_find;
 	if (ret < 0)
@@ -1657,7 +1662,7 @@ struct buffer_head *ext4_find_inline_entry(struct inode *dir,
 	inline_size = ext4_get_inline_size(dir) - EXT4_MIN_INLINE_DATA_SIZE;
 
 	ret = ext4_search_dir(iloc.bh, inline_start, inline_size,
-			      dir, fname, 0, res_dir);
+			      dir, fname, 0, 0, res_dir);
 	if (ret == 1)
 		goto out_find;
 
@@ -1706,7 +1711,7 @@ int ext4_delete_inline_entry(handle_t *handle,
 	if (err)
 		goto out;
 
-	err = ext4_generic_delete_entry(dir, de_del, bh,
+	err = ext4_generic_delete_entry(dir, de_del, 0, bh,
 					inline_start, inline_size, 0);
 	if (err)
 		goto out;
@@ -1791,7 +1796,7 @@ bool empty_inline_dir(struct inode *dir, int *has_inline_data)
 					   &inline_pos, &inline_size);
 		if (ext4_check_dir_entry(dir, NULL, de,
 					 iloc.bh, inline_pos,
-					 inline_size, offset)) {
+					 inline_size, 0, offset)) {
 			ext4_warning(dir->i_sb,
 				     "bad inline directory (dir #%lu) - "
 				     "inode %u, rec_len %u, name_len %d"
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index fa625a247e9a..00b0b0cb4600 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -280,9 +280,11 @@ static int dx_make_map(struct inode *dir, struct ext4_dir_entry_2 *de,
 		       unsigned blocksize, struct dx_hash_info *hinfo,
 		       struct dx_map_entry map[]);
 static void dx_sort_map(struct dx_map_entry *map, unsigned count);
-static struct ext4_dir_entry_2 *dx_move_dirents(char *from, char *to,
-		struct dx_map_entry *offsets, int count, unsigned blocksize);
-static struct ext4_dir_entry_2* dx_pack_dirents(char *base, unsigned blocksize);
+static struct ext4_dir_entry_2 *dx_move_dirents(struct inode *dir, char *from,
+					char *to, struct dx_map_entry *offsets,
+					int count, unsigned int blocksize);
+static struct ext4_dir_entry_2 *dx_pack_dirents(struct inode *dir, char *base,
+						unsigned int blocksize);
 static void dx_insert_block(struct dx_frame *frame,
 					u32 hash, ext4_lblk_t block);
 static int ext4_htree_next_block(struct inode *dir, __u32 hash,
@@ -291,7 +293,7 @@ static int ext4_htree_next_block(struct inode *dir, __u32 hash,
 				 __u32 *start_hash);
 static struct buffer_head * ext4_dx_find_entry(struct inode *dir,
 		struct ext4_filename *fname,
-		struct ext4_dir_entry_2 **res_dir);
+		struct ext4_dir_entry_2 **res_dir, ext4_lblk_t *lblk);
 static int ext4_dx_add_entry(handle_t *handle, struct ext4_filename *fname,
 			     struct inode *dir, struct inode *inode);
 
@@ -574,8 +576,9 @@ static inline void dx_set_limit(struct dx_entry *entries, unsigned value)
 
 static inline unsigned dx_root_limit(struct inode *dir, unsigned infosize)
 {
-	unsigned entry_space = dir->i_sb->s_blocksize - EXT4_DIR_REC_LEN(1) -
-		EXT4_DIR_REC_LEN(2) - infosize;
+	unsigned int entry_space = dir->i_sb->s_blocksize -
+			ext4_dir_rec_len(1, NULL) -
+			ext4_dir_rec_len(2, NULL) - infosize;
 
 	if (ext4_has_metadata_csum(dir->i_sb))
 		entry_space -= sizeof(struct dx_tail);
@@ -584,7 +587,8 @@ static inline unsigned dx_root_limit(struct inode *dir, unsigned infosize)
 
 static inline unsigned dx_node_limit(struct inode *dir)
 {
-	unsigned entry_space = dir->i_sb->s_blocksize - EXT4_DIR_REC_LEN(0);
+	unsigned int entry_space = dir->i_sb->s_blocksize -
+			ext4_dir_rec_len(0, dir);
 
 	if (ext4_has_metadata_csum(dir->i_sb))
 		entry_space -= sizeof(struct dx_tail);
@@ -679,7 +683,10 @@ static struct stats dx_show_leaf(struct inode *dir,
 						name = fname_crypto_str.name;
 						len = fname_crypto_str.len;
 					}
-					ext4fs_dirhash(dir, de->name,
+					if (IS_CASEFOLDED(dir))
+						h.hash = EXT4_DIRENT_HASH(de);
+					else
+						ext4fs_dirhash(dir, de->name,
 						       de->name_len, &h);
 					printk("%*.s:(E)%x.%u ", len, name,
 					       h.hash, (unsigned) ((char *) de
@@ -695,7 +702,7 @@ static struct stats dx_show_leaf(struct inode *dir,
 				       (unsigned) ((char *) de - base));
 #endif
 			}
-			space += EXT4_DIR_REC_LEN(de->name_len);
+			space += ext4_dir_rec_len(de->name_len, dir);
 			names++;
 		}
 		de = ext4_next_entry(de, size);
@@ -767,11 +774,25 @@ dx_probe(struct ext4_filename *fname, struct inode *dir,
 	root = (struct dx_root *) frame->bh->b_data;
 	if (root->info.hash_version != DX_HASH_TEA &&
 	    root->info.hash_version != DX_HASH_HALF_MD4 &&
-	    root->info.hash_version != DX_HASH_LEGACY) {
+	    root->info.hash_version != DX_HASH_LEGACY &&
+	    root->info.hash_version != DX_HASH_SIPHASH) {
 		ext4_warning_inode(dir, "Unrecognised inode hash code %u",
 				   root->info.hash_version);
 		goto fail;
 	}
+	if (ext4_hash_in_dirent(dir)) {
+		if (root->info.hash_version != DX_HASH_SIPHASH) {
+			ext4_warning_inode(dir,
+				"Hash in dirent, but hash is not SIPHASH");
+			goto fail;
+		}
+	} else {
+		if (root->info.hash_version == DX_HASH_SIPHASH) {
+			ext4_warning_inode(dir,
+				"Hash code is SIPHASH, but hash not in dirent");
+			goto fail;
+		}
+	}
 	if (fname)
 		hinfo = &fname->hinfo;
 	hinfo->hash_version = root->info.hash_version;
@@ -993,6 +1014,7 @@ static int htree_dirblock_to_tree(struct file *dir_file,
 	struct ext4_dir_entry_2 *de, *top;
 	int err = 0, count = 0;
 	struct fscrypt_str fname_crypto_str = FSTR_INIT(NULL, 0), tmp_str;
+	int csum = ext4_has_metadata_csum(dir->i_sb);
 
 	dxtrace(printk(KERN_INFO "In htree dirblock_to_tree: block %lu\n",
 							(unsigned long)block));
@@ -1001,9 +1023,11 @@ static int htree_dirblock_to_tree(struct file *dir_file,
 		return PTR_ERR(bh);
 
 	de = (struct ext4_dir_entry_2 *) bh->b_data;
+	/* csum entries are not larger in the casefolded encrypted case */
 	top = (struct ext4_dir_entry_2 *) ((char *) de +
 					   dir->i_sb->s_blocksize -
-					   EXT4_DIR_REC_LEN(0));
+					   ext4_dir_rec_len(0,
+							   csum ? NULL : dir));
 	/* Check if the directory is encrypted */
 	if (IS_ENCRYPTED(dir)) {
 		err = fscrypt_get_encryption_info(dir);
@@ -1021,13 +1045,23 @@ static int htree_dirblock_to_tree(struct file *dir_file,
 
 	for (; de < top; de = ext4_next_entry(de, dir->i_sb->s_blocksize)) {
 		if (ext4_check_dir_entry(dir, NULL, de, bh,
-				bh->b_data, bh->b_size,
+				bh->b_data, bh->b_size, block,
 				(block<<EXT4_BLOCK_SIZE_BITS(dir->i_sb))
 					 + ((char *)de - bh->b_data))) {
 			/* silently ignore the rest of the block */
 			break;
 		}
-		ext4fs_dirhash(dir, de->name, de->name_len, hinfo);
+		if (ext4_hash_in_dirent(dir)) {
+			if (de->name_len && de->inode) {
+				hinfo->hash = EXT4_DIRENT_HASH(de);
+				hinfo->minor_hash = EXT4_DIRENT_MINOR_HASH(de);
+			} else {
+				hinfo->hash = 0;
+				hinfo->minor_hash = 0;
+			}
+		} else {
+			ext4fs_dirhash(dir, de->name, de->name_len, hinfo);
+		}
 		if ((hinfo->hash < start_hash) ||
 		    ((hinfo->hash == start_hash) &&
 		     (hinfo->minor_hash < start_minor_hash)))
@@ -1096,7 +1130,11 @@ int ext4_htree_fill_tree(struct file *dir_file, __u32 start_hash,
 		       start_hash, start_minor_hash));
 	dir = file_inode(dir_file);
 	if (!(ext4_test_inode_flag(dir, EXT4_INODE_INDEX))) {
-		hinfo.hash_version = EXT4_SB(dir->i_sb)->s_def_hash_version;
+		if (ext4_hash_in_dirent(dir))
+			hinfo.hash_version = DX_HASH_SIPHASH;
+		else
+			hinfo.hash_version =
+					EXT4_SB(dir->i_sb)->s_def_hash_version;
 		if (hinfo.hash_version <= DX_HASH_TEA)
 			hinfo.hash_version +=
 				EXT4_SB(dir->i_sb)->s_hash_unsigned;
@@ -1189,11 +1227,12 @@ int ext4_htree_fill_tree(struct file *dir_file, __u32 start_hash,
 static inline int search_dirblock(struct buffer_head *bh,
 				  struct inode *dir,
 				  struct ext4_filename *fname,
+				  ext4_lblk_t lblk,
 				  unsigned int offset,
 				  struct ext4_dir_entry_2 **res_dir)
 {
 	return ext4_search_dir(bh, bh->b_data, dir->i_sb->s_blocksize, dir,
-			       fname, offset, res_dir);
+			       fname, lblk, offset, res_dir);
 }
 
 /*
@@ -1214,7 +1253,10 @@ static int dx_make_map(struct inode *dir, struct ext4_dir_entry_2 *de,
 
 	while ((char *) de < base + blocksize) {
 		if (de->name_len && de->inode) {
-			ext4fs_dirhash(dir, de->name, de->name_len, &h);
+			if (ext4_hash_in_dirent(dir))
+				h.hash = EXT4_DIRENT_HASH(de);
+			else
+				ext4fs_dirhash(dir, de->name, de->name_len, &h);
 			map_tail--;
 			map_tail->hash = h.hash;
 			map_tail->offs = ((char *) de - base)>>2;
@@ -1278,31 +1320,47 @@ static void dx_insert_block(struct dx_frame *frame, u32 hash, ext4_lblk_t block)
  * Returns: 0 if the directory entry matches, more than 0 if it
  * doesn't match or less than zero on error.
  */
-int ext4_ci_compare(const struct inode *parent, const struct qstr *name,
-		    const struct qstr *entry, bool quick)
+static int ext4_ci_compare(const struct inode *parent, const struct qstr *name,
+			   u8 *de_name, size_t de_name_len, bool quick)
 {
 	const struct super_block *sb = parent->i_sb;
 	const struct unicode_map *um = sb->s_encoding;
+	struct fscrypt_str decrypted_name = FSTR_INIT(NULL, de_name_len);
+	struct qstr entry = QSTR_INIT(de_name, de_name_len);
 	int ret;
 
+	if (IS_ENCRYPTED(parent)) {
+		const struct fscrypt_str encrypted_name =
+				FSTR_INIT(de_name, de_name_len);
+
+		decrypted_name.name = kmalloc(de_name_len, GFP_KERNEL);
+		if (!decrypted_name.name)
+			return -ENOMEM;
+		ret = fscrypt_fname_disk_to_usr(parent, 0, 0, &encrypted_name,
+						&decrypted_name);
+		if (ret < 0)
+			goto out;
+		entry.name = decrypted_name.name;
+		entry.len = decrypted_name.len;
+	}
+
 	if (quick)
-		ret = utf8_strncasecmp_folded(um, name, entry);
+		ret = utf8_strncasecmp_folded(um, name, &entry);
 	else
-		ret = utf8_strncasecmp(um, name, entry);
-
+		ret = utf8_strncasecmp(um, name, &entry);
 	if (ret < 0) {
 		/* Handle invalid character sequence as either an error
 		 * or as an opaque byte sequence.
 		 */
 		if (sb_has_strict_encoding(sb))
-			return -EINVAL;
-
-		if (name->len != entry->len)
-			return 1;
-
-		return !!memcmp(name->name, entry->name, name->len);
+			ret = -EINVAL;
+		else if (name->len != entry.len)
+			ret = 1;
+		else
+			ret = !!memcmp(name->name, entry.name, entry.len);
 	}
-
+out:
+	kfree(decrypted_name.name);
 	return ret;
 }
 
@@ -1338,14 +1396,11 @@ void ext4_fname_setup_ci_filename(struct inode *dir, const struct qstr *iname,
  *
  * Return: %true if the directory entry matches, otherwise %false.
  */
-static inline bool ext4_match(const struct inode *parent,
+static bool ext4_match(struct inode *parent,
 			      const struct ext4_filename *fname,
-			      const struct ext4_dir_entry_2 *de)
+			      struct ext4_dir_entry_2 *de)
 {
 	struct fscrypt_name f;
-#ifdef CONFIG_UNICODE
-	const struct qstr entry = {.name = de->name, .len = de->name_len};
-#endif
 
 	if (!de->inode)
 		return false;
@@ -1361,10 +1416,23 @@ static inline bool ext4_match(const struct inode *parent,
 		if (fname->cf_name.name) {
 			struct qstr cf = {.name = fname->cf_name.name,
 					  .len = fname->cf_name.len};
-			return !ext4_ci_compare(parent, &cf, &entry, true);
+			if (IS_ENCRYPTED(parent)) {
+				struct dx_hash_info hinfo;
+
+				hinfo.hash_version = DX_HASH_SIPHASH;
+				hinfo.seed = NULL;
+				ext4fs_dirhash(parent, fname->cf_name.name,
+						fname_len(fname), &hinfo);
+				if (hinfo.hash != EXT4_DIRENT_HASH(de) ||
+						hinfo.minor_hash !=
+						    EXT4_DIRENT_MINOR_HASH(de))
+					return 0;
+			}
+			return !ext4_ci_compare(parent, &cf, de->name,
+							de->name_len, true);
 		}
-		return !ext4_ci_compare(parent, fname->usr_fname, &entry,
-					false);
+		return !ext4_ci_compare(parent, fname->usr_fname, de->name,
+						de->name_len, false);
 	}
 #endif
 
@@ -1376,7 +1444,8 @@ static inline bool ext4_match(const struct inode *parent,
  */
 int ext4_search_dir(struct buffer_head *bh, char *search_buf, int buf_size,
 		    struct inode *dir, struct ext4_filename *fname,
-		    unsigned int offset, struct ext4_dir_entry_2 **res_dir)
+		    ext4_lblk_t lblk, unsigned int offset,
+		    struct ext4_dir_entry_2 **res_dir)
 {
 	struct ext4_dir_entry_2 * de;
 	char * dlimit;
@@ -1392,7 +1461,7 @@ int ext4_search_dir(struct buffer_head *bh, char *search_buf, int buf_size,
 			/* found a match - just to be sure, do
 			 * a full check */
 			if (ext4_check_dir_entry(dir, NULL, de, bh, search_buf,
-						 buf_size, offset))
+						 buf_size, lblk, offset))
 				return -1;
 			*res_dir = de;
 			return 1;
@@ -1438,7 +1507,7 @@ static int is_dx_internal_node(struct inode *dir, ext4_lblk_t block,
 static struct buffer_head *__ext4_find_entry(struct inode *dir,
 					     struct ext4_filename *fname,
 					     struct ext4_dir_entry_2 **res_dir,
-					     int *inlined)
+					     int *inlined, ext4_lblk_t *lblk)
 {
 	struct super_block *sb;
 	struct buffer_head *bh_use[NAMEI_RA_SIZE];
@@ -1462,6 +1531,8 @@ static struct buffer_head *__ext4_find_entry(struct inode *dir,
 		int has_inline_data = 1;
 		ret = ext4_find_inline_entry(dir, fname, res_dir,
 					     &has_inline_data);
+		if (lblk)
+			*lblk = 0;
 		if (has_inline_data) {
 			if (inlined)
 				*inlined = 1;
@@ -1480,7 +1551,7 @@ static struct buffer_head *__ext4_find_entry(struct inode *dir,
 		goto restart;
 	}
 	if (is_dx(dir)) {
-		ret = ext4_dx_find_entry(dir, fname, res_dir);
+		ret = ext4_dx_find_entry(dir, fname, res_dir, lblk);
 		/*
 		 * On success, or if the error was file not found,
 		 * return.  Otherwise, fall back to doing a search the
@@ -1546,9 +1617,11 @@ static struct buffer_head *__ext4_find_entry(struct inode *dir,
 			goto cleanup_and_exit;
 		}
 		set_buffer_verified(bh);
-		i = search_dirblock(bh, dir, fname,
+		i = search_dirblock(bh, dir, fname, block,
 			    block << EXT4_BLOCK_SIZE_BITS(sb), res_dir);
 		if (i == 1) {
+			if (lblk)
+				*lblk = block;
 			EXT4_I(dir)->i_dir_start_lookup = block;
 			ret = bh;
 			goto cleanup_and_exit;
@@ -1583,7 +1656,7 @@ static struct buffer_head *__ext4_find_entry(struct inode *dir,
 static struct buffer_head *ext4_find_entry(struct inode *dir,
 					   const struct qstr *d_name,
 					   struct ext4_dir_entry_2 **res_dir,
-					   int *inlined)
+					   int *inlined, ext4_lblk_t *lblk)
 {
 	int err;
 	struct ext4_filename fname;
@@ -1595,7 +1668,7 @@ static struct buffer_head *ext4_find_entry(struct inode *dir,
 	if (err)
 		return ERR_PTR(err);
 
-	bh = __ext4_find_entry(dir, &fname, res_dir, inlined);
+	bh = __ext4_find_entry(dir, &fname, res_dir, inlined, lblk);
 
 	ext4_fname_free_filename(&fname);
 	return bh;
@@ -1615,7 +1688,7 @@ static struct buffer_head *ext4_lookup_entry(struct inode *dir,
 	if (err)
 		return ERR_PTR(err);
 
-	bh = __ext4_find_entry(dir, &fname, res_dir, NULL);
+	bh = __ext4_find_entry(dir, &fname, res_dir, NULL, NULL);
 
 	ext4_fname_free_filename(&fname);
 	return bh;
@@ -1623,7 +1696,7 @@ static struct buffer_head *ext4_lookup_entry(struct inode *dir,
 
 static struct buffer_head * ext4_dx_find_entry(struct inode *dir,
 			struct ext4_filename *fname,
-			struct ext4_dir_entry_2 **res_dir)
+			struct ext4_dir_entry_2 **res_dir, ext4_lblk_t *lblk)
 {
 	struct super_block * sb = dir->i_sb;
 	struct dx_frame frames[EXT4_HTREE_LEVEL], *frame;
@@ -1639,11 +1712,13 @@ static struct buffer_head * ext4_dx_find_entry(struct inode *dir,
 		return (struct buffer_head *) frame;
 	do {
 		block = dx_get_block(frame->at);
+		if (lblk)
+			*lblk = block;
 		bh = ext4_read_dirblock(dir, block, DIRENT_HTREE);
 		if (IS_ERR(bh))
 			goto errout;
 
-		retval = search_dirblock(bh, dir, fname,
+		retval = search_dirblock(bh, dir, fname, block,
 					 block << EXT4_BLOCK_SIZE_BITS(sb),
 					 res_dir);
 		if (retval == 1)
@@ -1738,7 +1813,7 @@ struct dentry *ext4_get_parent(struct dentry *child)
 	struct ext4_dir_entry_2 * de;
 	struct buffer_head *bh;
 
-	bh = ext4_find_entry(d_inode(child), &dotdot, &de, NULL);
+	bh = ext4_find_entry(d_inode(child), &dotdot, &de, NULL, NULL);
 	if (IS_ERR(bh))
 		return ERR_CAST(bh);
 	if (!bh)
@@ -1760,7 +1835,8 @@ struct dentry *ext4_get_parent(struct dentry *child)
  * Returns pointer to last entry moved.
  */
 static struct ext4_dir_entry_2 *
-dx_move_dirents(char *from, char *to, struct dx_map_entry *map, int count,
+dx_move_dirents(struct inode *dir, char *from, char *to,
+		struct dx_map_entry *map, int count,
 		unsigned blocksize)
 {
 	unsigned rec_len = 0;
@@ -1768,7 +1844,8 @@ dx_move_dirents(char *from, char *to, struct dx_map_entry *map, int count,
 	while (count--) {
 		struct ext4_dir_entry_2 *de = (struct ext4_dir_entry_2 *)
 						(from + (map->offs<<2));
-		rec_len = EXT4_DIR_REC_LEN(de->name_len);
+		rec_len = ext4_dir_rec_len(de->name_len, dir);
+
 		memcpy (to, de, rec_len);
 		((struct ext4_dir_entry_2 *) to)->rec_len =
 				ext4_rec_len_to_disk(rec_len, blocksize);
@@ -1783,7 +1860,8 @@ dx_move_dirents(char *from, char *to, struct dx_map_entry *map, int count,
  * Compact each dir entry in the range to the minimal rec_len.
  * Returns pointer to last entry in range.
  */
-static struct ext4_dir_entry_2* dx_pack_dirents(char *base, unsigned blocksize)
+static struct ext4_dir_entry_2 *dx_pack_dirents(struct inode *dir, char *base,
+							unsigned int blocksize)
 {
 	struct ext4_dir_entry_2 *next, *to, *prev, *de = (struct ext4_dir_entry_2 *) base;
 	unsigned rec_len = 0;
@@ -1792,7 +1870,7 @@ static struct ext4_dir_entry_2* dx_pack_dirents(char *base, unsigned blocksize)
 	while ((char*)de < base + blocksize) {
 		next = ext4_next_entry(de, blocksize);
 		if (de->inode && de->name_len) {
-			rec_len = EXT4_DIR_REC_LEN(de->name_len);
+			rec_len = ext4_dir_rec_len(de->name_len, dir);
 			if (de > to)
 				memmove(to, de, rec_len);
 			to->rec_len = ext4_rec_len_to_disk(rec_len, blocksize);
@@ -1810,13 +1888,12 @@ static struct ext4_dir_entry_2* dx_pack_dirents(char *base, unsigned blocksize)
  * Returns pointer to de in block into which the new entry will be inserted.
  */
 static struct ext4_dir_entry_2 *do_split(handle_t *handle, struct inode *dir,
-			struct buffer_head **bh,struct dx_frame *frame,
-			struct dx_hash_info *hinfo)
+			struct buffer_head **bh, struct dx_frame *frame,
+			struct dx_hash_info *hinfo, ext4_lblk_t *newblock)
 {
 	unsigned blocksize = dir->i_sb->s_blocksize;
 	unsigned count, continued;
 	struct buffer_head *bh2;
-	ext4_lblk_t newblock;
 	u32 hash2;
 	struct dx_map_entry *map;
 	char *data1 = (*bh)->b_data, *data2;
@@ -1828,7 +1905,7 @@ static struct ext4_dir_entry_2 *do_split(handle_t *handle, struct inode *dir,
 	if (ext4_has_metadata_csum(dir->i_sb))
 		csum_size = sizeof(struct ext4_dir_entry_tail);
 
-	bh2 = ext4_append(handle, dir, &newblock);
+	bh2 = ext4_append(handle, dir, newblock);
 	if (IS_ERR(bh2)) {
 		brelse(*bh);
 		*bh = NULL;
@@ -1882,9 +1959,9 @@ static struct ext4_dir_entry_2 *do_split(handle_t *handle, struct inode *dir,
 					hash2, split, count-split));
 
 	/* Fancy dance to stay within two buffers */
-	de2 = dx_move_dirents(data1, data2, map + split, count - split,
+	de2 = dx_move_dirents(dir, data1, data2, map + split, count - split,
 			      blocksize);
-	de = dx_pack_dirents(data1, blocksize);
+	de = dx_pack_dirents(dir, data1, blocksize);
 	de->rec_len = ext4_rec_len_to_disk(data1 + (blocksize - csum_size) -
 					   (char *) de,
 					   blocksize);
@@ -1906,7 +1983,7 @@ static struct ext4_dir_entry_2 *do_split(handle_t *handle, struct inode *dir,
 		swap(*bh, bh2);
 		de = de2;
 	}
-	dx_insert_block(frame, hash2 + continued, newblock);
+	dx_insert_block(frame, hash2 + continued, *newblock);
 	err = ext4_handle_dirty_dirblock(handle, dir, bh2);
 	if (err)
 		goto journal_error;
@@ -1926,13 +2003,14 @@ static struct ext4_dir_entry_2 *do_split(handle_t *handle, struct inode *dir,
 }
 
 int ext4_find_dest_de(struct inode *dir, struct inode *inode,
+		      ext4_lblk_t lblk,
 		      struct buffer_head *bh,
 		      void *buf, int buf_size,
 		      struct ext4_filename *fname,
 		      struct ext4_dir_entry_2 **dest_de)
 {
 	struct ext4_dir_entry_2 *de;
-	unsigned short reclen = EXT4_DIR_REC_LEN(fname_len(fname));
+	unsigned short reclen = ext4_dir_rec_len(fname_len(fname), dir);
 	int nlen, rlen;
 	unsigned int offset = 0;
 	char *top;
@@ -1941,11 +2019,11 @@ int ext4_find_dest_de(struct inode *dir, struct inode *inode,
 	top = buf + buf_size - reclen;
 	while ((char *) de <= top) {
 		if (ext4_check_dir_entry(dir, NULL, de, bh,
-					 buf, buf_size, offset))
+					 buf, buf_size, lblk, offset))
 			return -EFSCORRUPTED;
 		if (ext4_match(dir, fname, de))
 			return -EEXIST;
-		nlen = EXT4_DIR_REC_LEN(de->name_len);
+		nlen = ext4_dir_rec_len(de->name_len, dir);
 		rlen = ext4_rec_len_from_disk(de->rec_len, buf_size);
 		if ((de->inode ? rlen - nlen : rlen) >= reclen)
 			break;
@@ -1959,7 +2037,8 @@ int ext4_find_dest_de(struct inode *dir, struct inode *inode,
 	return 0;
 }
 
-void ext4_insert_dentry(struct inode *inode,
+void ext4_insert_dentry(struct inode *dir,
+			struct inode *inode,
 			struct ext4_dir_entry_2 *de,
 			int buf_size,
 			struct ext4_filename *fname)
@@ -1967,7 +2046,7 @@ void ext4_insert_dentry(struct inode *inode,
 
 	int nlen, rlen;
 
-	nlen = EXT4_DIR_REC_LEN(de->name_len);
+	nlen = ext4_dir_rec_len(de->name_len, dir);
 	rlen = ext4_rec_len_from_disk(de->rec_len, buf_size);
 	if (de->inode) {
 		struct ext4_dir_entry_2 *de1 =
@@ -1981,6 +2060,17 @@ void ext4_insert_dentry(struct inode *inode,
 	ext4_set_de_type(inode->i_sb, de, inode->i_mode);
 	de->name_len = fname_len(fname);
 	memcpy(de->name, fname_name(fname), fname_len(fname));
+	if (ext4_hash_in_dirent(dir)) {
+		struct dx_hash_info hinfo;
+
+		hinfo.hash_version = DX_HASH_SIPHASH;
+		hinfo.seed = NULL;
+		ext4fs_dirhash(dir, fname_usr_name(fname),
+				fname_len(fname), &hinfo);
+		EXT4_DIRENT_HASHES(de)->hash = cpu_to_le32(hinfo.hash);
+		EXT4_DIRENT_HASHES(de)->minor_hash =
+				cpu_to_le32(hinfo.minor_hash);
+	}
 }
 
 /*
@@ -1994,6 +2084,7 @@ void ext4_insert_dentry(struct inode *inode,
 static int add_dirent_to_buf(handle_t *handle, struct ext4_filename *fname,
 			     struct inode *dir,
 			     struct inode *inode, struct ext4_dir_entry_2 *de,
+			     ext4_lblk_t blk,
 			     struct buffer_head *bh)
 {
 	unsigned int	blocksize = dir->i_sb->s_blocksize;
@@ -2004,7 +2095,7 @@ static int add_dirent_to_buf(handle_t *handle, struct ext4_filename *fname,
 		csum_size = sizeof(struct ext4_dir_entry_tail);
 
 	if (!de) {
-		err = ext4_find_dest_de(dir, inode, bh, bh->b_data,
+		err = ext4_find_dest_de(dir, inode, blk, bh, bh->b_data,
 					blocksize - csum_size, fname, &de);
 		if (err)
 			return err;
@@ -2017,7 +2108,7 @@ static int add_dirent_to_buf(handle_t *handle, struct ext4_filename *fname,
 	}
 
 	/* By now the buffer is marked for journaling */
-	ext4_insert_dentry(inode, de, blocksize, fname);
+	ext4_insert_dentry(dir, inode, de, blocksize, fname);
 
 	/*
 	 * XXX shouldn't update any times until successful
@@ -2109,11 +2200,16 @@ static int make_indexed_dir(handle_t *handle, struct ext4_filename *fname,
 
 	/* Initialize the root; the dot dirents already exist */
 	de = (struct ext4_dir_entry_2 *) (&root->dotdot);
-	de->rec_len = ext4_rec_len_to_disk(blocksize - EXT4_DIR_REC_LEN(2),
-					   blocksize);
+	de->rec_len = ext4_rec_len_to_disk(
+			blocksize - ext4_dir_rec_len(2, NULL), blocksize);
 	memset (&root->info, 0, sizeof(root->info));
 	root->info.info_length = sizeof(root->info);
-	root->info.hash_version = EXT4_SB(dir->i_sb)->s_def_hash_version;
+	if (ext4_hash_in_dirent(dir))
+		root->info.hash_version = DX_HASH_SIPHASH;
+	else
+		root->info.hash_version =
+				EXT4_SB(dir->i_sb)->s_def_hash_version;
+
 	entries = root->entries;
 	dx_set_block(entries, 1);
 	dx_set_count(entries, 1);
@@ -2124,7 +2220,12 @@ static int make_indexed_dir(handle_t *handle, struct ext4_filename *fname,
 	if (fname->hinfo.hash_version <= DX_HASH_TEA)
 		fname->hinfo.hash_version += EXT4_SB(dir->i_sb)->s_hash_unsigned;
 	fname->hinfo.seed = EXT4_SB(dir->i_sb)->s_hash_seed;
-	ext4fs_dirhash(dir, fname_name(fname), fname_len(fname), &fname->hinfo);
+	if (ext4_hash_in_dirent(dir))
+		ext4fs_dirhash(dir, fname_usr_name(fname),
+				fname_len(fname), &fname->hinfo);
+	else
+		ext4fs_dirhash(dir, fname_name(fname),
+				fname_len(fname), &fname->hinfo);
 
 	memset(frames, 0, sizeof(frames));
 	frame = frames;
@@ -2139,13 +2240,13 @@ static int make_indexed_dir(handle_t *handle, struct ext4_filename *fname,
 	if (retval)
 		goto out_frames;	
 
-	de = do_split(handle,dir, &bh2, frame, &fname->hinfo);
+	de = do_split(handle, dir, &bh2, frame, &fname->hinfo, &block);
 	if (IS_ERR(de)) {
 		retval = PTR_ERR(de);
 		goto out_frames;
 	}
 
-	retval = add_dirent_to_buf(handle, fname, dir, inode, de, bh2);
+	retval = add_dirent_to_buf(handle, fname, dir, inode, de, block, bh2);
 out_frames:
 	/*
 	 * Even if the block split failed, we have to properly write
@@ -2242,7 +2343,7 @@ static int ext4_add_entry(handle_t *handle, struct dentry *dentry,
 			goto out;
 		}
 		retval = add_dirent_to_buf(handle, &fname, dir, inode,
-					   NULL, bh);
+					   NULL, block, bh);
 		if (retval != -ENOSPC)
 			goto out;
 
@@ -2269,7 +2370,7 @@ static int ext4_add_entry(handle_t *handle, struct dentry *dentry,
 	if (csum_size)
 		ext4_initialize_dirent_tail(bh, blocksize);
 
-	retval = add_dirent_to_buf(handle, &fname, dir, inode, de, bh);
+	retval = add_dirent_to_buf(handle, &fname, dir, inode, de, block, bh);
 out:
 	ext4_fname_free_filename(&fname);
 	brelse(bh);
@@ -2291,6 +2392,7 @@ static int ext4_dx_add_entry(handle_t *handle, struct ext4_filename *fname,
 	struct ext4_dir_entry_2 *de;
 	int restart;
 	int err;
+	ext4_lblk_t lblk;
 
 again:
 	restart = 0;
@@ -2299,7 +2401,8 @@ static int ext4_dx_add_entry(handle_t *handle, struct ext4_filename *fname,
 		return PTR_ERR(frame);
 	entries = frame->entries;
 	at = frame->at;
-	bh = ext4_read_dirblock(dir, dx_get_block(frame->at), DIRENT_HTREE);
+	lblk = dx_get_block(frame->at);
+	bh = ext4_read_dirblock(dir, lblk, DIRENT_HTREE);
 	if (IS_ERR(bh)) {
 		err = PTR_ERR(bh);
 		bh = NULL;
@@ -2311,7 +2414,7 @@ static int ext4_dx_add_entry(handle_t *handle, struct ext4_filename *fname,
 	if (err)
 		goto journal_error;
 
-	err = add_dirent_to_buf(handle, fname, dir, inode, NULL, bh);
+	err = add_dirent_to_buf(handle, fname, dir, inode, NULL, lblk, bh);
 	if (err != -ENOSPC)
 		goto cleanup;
 
@@ -2431,12 +2534,12 @@ static int ext4_dx_add_entry(handle_t *handle, struct ext4_filename *fname,
 			goto journal_error;
 		}
 	}
-	de = do_split(handle, dir, &bh, frame, &fname->hinfo);
+	de = do_split(handle, dir, &bh, frame, &fname->hinfo, &lblk);
 	if (IS_ERR(de)) {
 		err = PTR_ERR(de);
 		goto cleanup;
 	}
-	err = add_dirent_to_buf(handle, fname, dir, inode, de, bh);
+	err = add_dirent_to_buf(handle, fname, dir, inode, de, lblk, bh);
 	goto cleanup;
 
 journal_error:
@@ -2458,6 +2561,7 @@ static int ext4_dx_add_entry(handle_t *handle, struct ext4_filename *fname,
  */
 int ext4_generic_delete_entry(struct inode *dir,
 			      struct ext4_dir_entry_2 *de_del,
+			      ext4_lblk_t lblk,
 			      struct buffer_head *bh,
 			      void *entry_buf,
 			      int buf_size,
@@ -2472,7 +2576,7 @@ int ext4_generic_delete_entry(struct inode *dir,
 	de = (struct ext4_dir_entry_2 *)entry_buf;
 	while (i < buf_size - csum_size) {
 		if (ext4_check_dir_entry(dir, NULL, de, bh,
-					 entry_buf, buf_size, i))
+					 entry_buf, buf_size, lblk, i))
 			return -EFSCORRUPTED;
 		if (de == de_del)  {
 			if (pde)
@@ -2497,6 +2601,7 @@ int ext4_generic_delete_entry(struct inode *dir,
 static int ext4_delete_entry(handle_t *handle,
 			     struct inode *dir,
 			     struct ext4_dir_entry_2 *de_del,
+			     ext4_lblk_t lblk,
 			     struct buffer_head *bh)
 {
 	int err, csum_size = 0;
@@ -2517,7 +2622,7 @@ static int ext4_delete_entry(handle_t *handle,
 	if (unlikely(err))
 		goto out;
 
-	err = ext4_generic_delete_entry(dir, de_del, bh, bh->b_data,
+	err = ext4_generic_delete_entry(dir, de_del, lblk, bh, bh->b_data,
 					dir->i_sb->s_blocksize, csum_size);
 	if (err)
 		goto out;
@@ -2714,7 +2819,7 @@ struct ext4_dir_entry_2 *ext4_init_dot_dotdot(struct inode *inode,
 {
 	de->inode = cpu_to_le32(inode->i_ino);
 	de->name_len = 1;
-	de->rec_len = ext4_rec_len_to_disk(EXT4_DIR_REC_LEN(de->name_len),
+	de->rec_len = ext4_rec_len_to_disk(ext4_dir_rec_len(de->name_len, NULL),
 					   blocksize);
 	strcpy(de->name, ".");
 	ext4_set_de_type(inode->i_sb, de, S_IFDIR);
@@ -2724,11 +2829,12 @@ struct ext4_dir_entry_2 *ext4_init_dot_dotdot(struct inode *inode,
 	de->name_len = 2;
 	if (!dotdot_real_len)
 		de->rec_len = ext4_rec_len_to_disk(blocksize -
-					(csum_size + EXT4_DIR_REC_LEN(1)),
+					(csum_size + ext4_dir_rec_len(1, NULL)),
 					blocksize);
 	else
 		de->rec_len = ext4_rec_len_to_disk(
-				EXT4_DIR_REC_LEN(de->name_len), blocksize);
+					ext4_dir_rec_len(de->name_len, NULL),
+					blocksize);
 	strcpy(de->name, "..");
 	ext4_set_de_type(inode->i_sb, de, S_IFDIR);
 
@@ -2860,7 +2966,8 @@ bool ext4_empty_dir(struct inode *inode)
 	}
 
 	sb = inode->i_sb;
-	if (inode->i_size < EXT4_DIR_REC_LEN(1) + EXT4_DIR_REC_LEN(2)) {
+	if (inode->i_size < ext4_dir_rec_len(1, NULL) +
+					ext4_dir_rec_len(2, NULL)) {
 		EXT4_ERROR_INODE(inode, "invalid size");
 		return true;
 	}
@@ -2872,7 +2979,7 @@ bool ext4_empty_dir(struct inode *inode)
 		return true;
 
 	de = (struct ext4_dir_entry_2 *) bh->b_data;
-	if (ext4_check_dir_entry(inode, NULL, de, bh, bh->b_data, bh->b_size,
+	if (ext4_check_dir_entry(inode, NULL, de, bh, bh->b_data, bh->b_size, 0,
 				 0) ||
 	    le32_to_cpu(de->inode) != inode->i_ino || strcmp(".", de->name)) {
 		ext4_warning_inode(inode, "directory missing '.'");
@@ -2881,7 +2988,7 @@ bool ext4_empty_dir(struct inode *inode)
 	}
 	offset = ext4_rec_len_from_disk(de->rec_len, sb->s_blocksize);
 	de = ext4_next_entry(de, sb->s_blocksize);
-	if (ext4_check_dir_entry(inode, NULL, de, bh, bh->b_data, bh->b_size,
+	if (ext4_check_dir_entry(inode, NULL, de, bh, bh->b_data, bh->b_size, 0,
 				 offset) ||
 	    le32_to_cpu(de->inode) == 0 || strcmp("..", de->name)) {
 		ext4_warning_inode(inode, "directory missing '..'");
@@ -2905,7 +3012,7 @@ bool ext4_empty_dir(struct inode *inode)
 		de = (struct ext4_dir_entry_2 *) (bh->b_data +
 					(offset & (sb->s_blocksize - 1)));
 		if (ext4_check_dir_entry(inode, NULL, de, bh,
-					 bh->b_data, bh->b_size, offset)) {
+					 bh->b_data, bh->b_size, 0, offset)) {
 			offset = (offset | (sb->s_blocksize - 1)) + 1;
 			continue;
 		}
@@ -3106,6 +3213,8 @@ static int ext4_rmdir(struct inode *dir, struct dentry *dentry)
 	struct buffer_head *bh;
 	struct ext4_dir_entry_2 *de;
 	handle_t *handle = NULL;
+	ext4_lblk_t lblk;
+
 
 	if (unlikely(ext4_forced_shutdown(EXT4_SB(dir->i_sb))))
 		return -EIO;
@@ -3120,7 +3229,7 @@ static int ext4_rmdir(struct inode *dir, struct dentry *dentry)
 		return retval;
 
 	retval = -ENOENT;
-	bh = ext4_find_entry(dir, &dentry->d_name, &de, NULL);
+	bh = ext4_find_entry(dir, &dentry->d_name, &de, NULL, &lblk);
 	if (IS_ERR(bh))
 		return PTR_ERR(bh);
 	if (!bh)
@@ -3147,7 +3256,7 @@ static int ext4_rmdir(struct inode *dir, struct dentry *dentry)
 	if (IS_DIRSYNC(dir))
 		ext4_handle_sync(handle);
 
-	retval = ext4_delete_entry(handle, dir, de, bh);
+	retval = ext4_delete_entry(handle, dir, de, lblk, bh);
 	if (retval)
 		goto end_rmdir;
 	if (!EXT4_DIR_LINK_EMPTY(inode))
@@ -3196,8 +3305,9 @@ int __ext4_unlink(handle_t *handle, struct inode *dir, const struct qstr *d_name
 	struct buffer_head *bh;
 	struct ext4_dir_entry_2 *de;
 	int skip_remove_dentry = 0;
+	ext4_lblk_t lblk;
 
-	bh = ext4_find_entry(dir, d_name, &de, NULL);
+	bh = ext4_find_entry(dir, d_name, &de, NULL, &lblk);
 	if (IS_ERR(bh))
 		return PTR_ERR(bh);
 
@@ -3220,7 +3330,7 @@ int __ext4_unlink(handle_t *handle, struct inode *dir, const struct qstr *d_name
 		ext4_handle_sync(handle);
 
 	if (!skip_remove_dentry) {
-		retval = ext4_delete_entry(handle, dir, de, bh);
+		retval = ext4_delete_entry(handle, dir, de, lblk, bh);
 		if (retval)
 			goto out;
 		dir->i_ctime = dir->i_mtime = current_time(dir);
@@ -3526,6 +3636,7 @@ struct ext4_renament {
 	int dir_nlink_delta;
 
 	/* entry for "dentry" */
+	ext4_lblk_t lblk;
 	struct buffer_head *bh;
 	struct ext4_dir_entry_2 *de;
 	int inlined;
@@ -3610,12 +3721,13 @@ static int ext4_find_delete_entry(handle_t *handle, struct inode *dir,
 	int retval = -ENOENT;
 	struct buffer_head *bh;
 	struct ext4_dir_entry_2 *de;
+	ext4_lblk_t lblk;
 
-	bh = ext4_find_entry(dir, d_name, &de, NULL);
+	bh = ext4_find_entry(dir, d_name, &de, NULL, &lblk);
 	if (IS_ERR(bh))
 		return PTR_ERR(bh);
 	if (bh) {
-		retval = ext4_delete_entry(handle, dir, de, bh);
+		retval = ext4_delete_entry(handle, dir, de, lblk, bh);
 		brelse(bh);
 	}
 	return retval;
@@ -3639,7 +3751,8 @@ static void ext4_rename_delete(handle_t *handle, struct ext4_renament *ent,
 		retval = ext4_find_delete_entry(handle, ent->dir,
 						&ent->dentry->d_name);
 	} else {
-		retval = ext4_delete_entry(handle, ent->dir, ent->de, ent->bh);
+		retval = ext4_delete_entry(handle, ent->dir, ent->de,
+						ent->lblk, ent->bh);
 		if (retval == -ENOENT) {
 			retval = ext4_find_delete_entry(handle, ent->dir,
 							&ent->dentry->d_name);
@@ -3752,7 +3865,8 @@ static int ext4_rename(struct inode *old_dir, struct dentry *old_dentry,
 			return retval;
 	}
 
-	old.bh = ext4_find_entry(old.dir, &old.dentry->d_name, &old.de, NULL);
+	old.bh = ext4_find_entry(old.dir, &old.dentry->d_name, &old.de, NULL,
+				&old.lblk);
 	if (IS_ERR(old.bh))
 		return PTR_ERR(old.bh);
 	/*
@@ -3766,7 +3880,7 @@ static int ext4_rename(struct inode *old_dir, struct dentry *old_dentry,
 		goto end_rename;
 
 	new.bh = ext4_find_entry(new.dir, &new.dentry->d_name,
-				 &new.de, &new.inlined);
+				 &new.de, &new.inlined, NULL);
 	if (IS_ERR(new.bh)) {
 		retval = PTR_ERR(new.bh);
 		new.bh = NULL;
@@ -3976,7 +4090,7 @@ static int ext4_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 		return retval;
 
 	old.bh = ext4_find_entry(old.dir, &old.dentry->d_name,
-				 &old.de, &old.inlined);
+				 &old.de, &old.inlined, NULL);
 	if (IS_ERR(old.bh))
 		return PTR_ERR(old.bh);
 	/*
@@ -3990,7 +4104,7 @@ static int ext4_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 		goto end_rename;
 
 	new.bh = ext4_find_entry(new.dir, &new.dentry->d_name,
-				 &new.de, &new.inlined);
+				 &new.de, &new.inlined, NULL);
 	if (IS_ERR(new.bh)) {
 		retval = PTR_ERR(new.bh);
 		new.bh = NULL;
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 0f0db49031dc..83322ad93178 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4292,12 +4292,6 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 		struct unicode_map *encoding;
 		__u16 encoding_flags;
 
-		if (ext4_has_feature_encrypt(sb)) {
-			ext4_msg(sb, KERN_ERR,
-				 "Can't mount with encoding and encryption");
-			goto failed_mount;
-		}
-
 		if (ext4_sb_read_encoding(es, &encoding_info,
 					  &encoding_flags)) {
 			ext4_msg(sb, KERN_ERR,
-- 
2.30.0.365.g02bc693789-goog

