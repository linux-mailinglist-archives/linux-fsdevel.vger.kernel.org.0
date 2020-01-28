Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55CE914C35A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2020 00:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgA1XEv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jan 2020 18:04:51 -0500
Received: from mail-qk1-f202.google.com ([209.85.222.202]:50256 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbgA1XEe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jan 2020 18:04:34 -0500
Received: by mail-qk1-f202.google.com with SMTP id k7so7149799qkk.17
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jan 2020 15:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+Jh3nVi9XbgTy84mnTwk3F18Yn6ubMohb3U2BrhS2wk=;
        b=laDD9vkrYQoXVTSH3oRzu9KdlLdVaO5YHOndFS1AJCUPWRxvka7LA+45Gg6dczSWqE
         aPteHhr84J9Jt8eccOXmE4kNYQgmdBUnlY5Mk4hEmu7yYyjl+awnmpN84TecjdgizWf3
         V6spNaQ6ifmOyWPAaYaG3fuDUTxyCH3t+scJMNIjOYtXGoAVk6qYuVG/S7dm8X7JbFCb
         QwOh4TzLTFoworoAHlIIjUJ4P/Kvt3+Gm7KcGsVQApIRW2ZQGEki7qvLIytcf6GIcGmf
         0yG4Nj0AVaDYcNYaRknUB3XVnSsiYjdoaxbKBcNAdikVrO0ntHcno6Lza7sTP0cWGB+N
         6pyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+Jh3nVi9XbgTy84mnTwk3F18Yn6ubMohb3U2BrhS2wk=;
        b=EpRVCKSC14JRmJVaunniW1DxnCYKZENiPokoRVuSPD/bbd/P7/DU94n3boxbNhUuPG
         GWa5oul8inPrlAw7YzJVUjcYX2w5Qgg5zR2JHoD/gJ/okSnG63V6foKHU3mHCFvUeQ6J
         7vh0o+dBWcaZM/O6vyCQbsWWcrrstg0+ndxQgSL0U+7KrdMc560BVGCs0yTMeJwz+tw9
         0x2A1IRV03t+mVAtr/2dDpQVBdMf0D6cTnry0ODejqvaxMWenAZIjweyKvw9WJRfLkBL
         r3s+pg/TbrWycW7RP6DmWciqHOIF1M4WZvXNDQSZM8n0Mqn7IVdbxymuwTiPRHHxS0tz
         4Vxw==
X-Gm-Message-State: APjAAAVg0Qovi8S+B/HuRdjOR/y3dR8UbKHB31/jk1yUHKiUTdx0YYL+
        FBXRwgWiPYoh5JM96GSi2v4VIh0ryuY=
X-Google-Smtp-Source: APXvYqyGxf+7xB5ZubeJ4nD41pBp2kyHe3HCo83O/+05KiyjcVipTB7ExslZmZm/zA2KCOQu9k63BTX1Ayk=
X-Received: by 2002:ad4:514d:: with SMTP id g13mr24262319qvq.190.1580252672571;
 Tue, 28 Jan 2020 15:04:32 -0800 (PST)
Date:   Tue, 28 Jan 2020 15:03:27 -0800
In-Reply-To: <20200128230328.183524-1-drosen@google.com>
Message-Id: <20200128230328.183524-5-drosen@google.com>
Mime-Version: 1.0
References: <20200128230328.183524-1-drosen@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v6 4/5] ext4: Hande casefolding with encryption
From:   Daniel Rosenberg <drosen@google.com>
To:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Eric Biggers <ebiggers@kernel.org>,
        linux-fscrypt@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Richard Weinberger <richard@nod.at>
Cc:     linux-mtd@lists.infradead.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com, Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
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
---
 Documentation/filesystems/ext4/directory.rst |  27 ++
 fs/ext4/dir.c                                |  27 +-
 fs/ext4/ext4.h                               |  64 +++-
 fs/ext4/hash.c                               |  24 +-
 fs/ext4/ialloc.c                             |   5 +-
 fs/ext4/inline.c                             |  41 +--
 fs/ext4/namei.c                              | 291 +++++++++++++------
 fs/ext4/super.c                              |   6 -
 8 files changed, 343 insertions(+), 142 deletions(-)

diff --git a/Documentation/filesystems/ext4/directory.rst b/Documentation/filesystems/ext4/directory.rst
index 073940cc64edd..55f618b371445 100644
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
index c98c788301e9c..21bd858108f3a 100644
--- a/fs/ext4/dir.c
+++ b/fs/ext4/dir.c
@@ -30,6 +30,8 @@
 #include "ext4.h"
 #include "xattr.h"
 
+#define DOTDOT_OFFSET 12
+
 static int ext4_dx_readdir(struct file *, struct dir_context *);
 
 /**
@@ -67,22 +69,26 @@ int __ext4_check_dir_entry(const char *function, unsigned int line,
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
+	bool fake = (lblk == 0) && (offset <= DOTDOT_OFFSET);
 
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
+							fake ? NULL : dir) &&
 			  next_offset != size))
 		error_msg = "directory entry too close to block end";
 	else if (unlikely(le32_to_cpu(de->inode) >
@@ -94,15 +100,15 @@ int __ext4_check_dir_entry(const char *function, unsigned int line,
 	if (filp)
 		ext4_error_file(filp, function, line, bh->b_blocknr,
 				"bad entry in directory: %s - offset=%u, "
-				"inode=%u, rec_len=%d, name_len=%d, size=%d",
+				"inode=%u, rec_len=%d, lblk=%d, size=%d",
 				error_msg, offset, le32_to_cpu(de->inode),
-				rlen, de->name_len, size);
+				rlen, lblk, size);
 	else
 		ext4_error_inode(dir, function, line, bh->b_blocknr,
 				"bad entry in directory: %s - offset=%u, "
-				"inode=%u, rec_len=%d, name_len=%d, size=%d",
+				"inode=%u, rec_len=%d, lblk=%d, size=%d",
 				 error_msg, offset, le32_to_cpu(de->inode),
-				 rlen, de->name_len, size);
+				 rlen, lblk, size);
 
 	return 1;
 }
@@ -224,7 +230,8 @@ static int ext4_readdir(struct file *file, struct dir_context *ctx)
 				 * failure will be detected in the
 				 * dirent test below. */
 				if (ext4_rec_len_from_disk(de->rec_len,
-					sb->s_blocksize) < EXT4_DIR_REC_LEN(1))
+					sb->s_blocksize) < ext4_dir_rec_len(1,
+									inode))
 					break;
 				i += ext4_rec_len_from_disk(de->rec_len,
 							    sb->s_blocksize);
@@ -240,7 +247,7 @@ static int ext4_readdir(struct file *file, struct dir_context *ctx)
 			de = (struct ext4_dir_entry_2 *) (bh->b_data + offset);
 			if (ext4_check_dir_entry(inode, file, de, bh,
 						 bh->b_data, bh->b_size,
-						 offset)) {
+						 map.m_lblk, offset)) {
 				/*
 				 * On error, skip to the next block
 				 */
@@ -642,7 +649,7 @@ int ext4_check_all_de(struct inode *dir, struct buffer_head *bh, void *buf,
 	top = buf + buf_size;
 	while ((char *) de < top) {
 		if (ext4_check_dir_entry(dir, NULL, de, bh,
-					 buf, buf_size, offset))
+					 buf, buf_size, 0, offset))
 			return -EFSCORRUPTED;
 		rlen = ext4_rec_len_from_disk(de->rec_len, buf_size);
 		de = (struct ext4_dir_entry_2 *)((char *)de + rlen);
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 9dc0e2c6f7d7c..64c7375bc3f65 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1955,6 +1955,19 @@ struct ext4_dir_entry {
 	char	name[EXT4_NAME_LEN];	/* File name */
 };
 
+
+/*
+ * Extended entry for ext4_dir_entry_2, since we can't easily store values after
+ * an arbitrary sized field, and would prefer not to break the format. For
+ * entries that are both encrypted and casefolded, we need to include the hash
+ * in the entry.
+ */
+
+struct ext4_extended_dir_entry_2 {
+	__le32 hash;
+	__le32 minor_hash;
+};
+
 /*
  * The new version of the directory entry.  Since EXT4 structures are
  * stored in intel byte order, and the name_len field could never be
@@ -1967,8 +1980,24 @@ struct ext4_dir_entry_2 {
 	__u8	name_len;		/* Name length */
 	__u8	file_type;
 	char	name[EXT4_NAME_LEN];	/* File name */
+	char	padding[sizeof(struct ext4_extended_dir_entry_2)];
 };
 
+/*
+ * Access the extended section of ext4_dir_entry_2
+ */
+#define EXT4_EXTENDED_DIRENT(entry) \
+	((struct ext4_extended_dir_entry_2 *) \
+		(((void *)(entry)) + 8 + (entry)->name_len))
+#define EXT4_DIRENT_HASH(entry) le32_to_cpu(EXT4_EXTENDED_DIRENT(de)->hash)
+#define EXT4_DIRENT_MINOR_HASH(entry) \
+		le32_to_cpu(EXT4_EXTENDED_DIRENT(de)->minor_hash)
+
+static inline bool ext4_hash_in_dirent(const struct inode *inode)
+{
+	return IS_CASEFOLDED(inode) && IS_ENCRYPTED(inode);
+}
+
 /*
  * This is a bogus directory entry at the end of each leaf block that
  * records checksums.
@@ -2010,10 +2039,25 @@ struct ext4_dir_entry_tail {
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
+
+static inline unsigned int ext4_dir_rec_len(__u8 name_len,
+						const struct inode *dir)
+{
+	int rec_len = (name_len + 8 + EXT4_DIR_ROUND);
+
+	if (dir && ext4_hash_in_dirent(dir))
+		rec_len += sizeof(struct ext4_extended_dir_entry_2);
+	return (rec_len & ~EXT4_DIR_ROUND);
+}
+
 /*
  * If we ever get support for fs block sizes > page_size, we'll need
  * to remove the #if statements in the next two functions...
@@ -2070,6 +2114,7 @@ static inline __le16 ext4_rec_len_to_disk(unsigned len, unsigned blocksize)
 #define DX_HASH_LEGACY_UNSIGNED		3
 #define DX_HASH_HALF_MD4_UNSIGNED	4
 #define DX_HASH_TEA_UNSIGNED		5
+#define DX_HASH_SIPHASH			6
 
 static inline u32 ext4_chksum(struct ext4_sb_info *sbi, u32 crc,
 			      const void *address, unsigned int length)
@@ -2124,6 +2169,7 @@ struct ext4_filename {
 };
 
 #define fname_name(p) ((p)->disk_name.name)
+#define fname_usr_name(p) ((p)->usr_fname->name)
 #define fname_len(p)  ((p)->disk_name.len)
 
 /*
@@ -2458,21 +2504,22 @@ extern int __ext4_check_dir_entry(const char *, unsigned int, struct inode *,
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
@@ -2651,11 +2698,12 @@ extern int ext4_search_dir(struct buffer_head *bh,
 			   int buf_size,
 			   struct inode *dir,
 			   struct ext4_filename *fname,
-			   unsigned int offset,
+			   ext4_lblk_t lblk, unsigned int offset,
 			   struct ext4_dir_entry_2 **res_dir);
 extern int ext4_generic_delete_entry(handle_t *handle,
 				     struct inode *dir,
 				     struct ext4_dir_entry_2 *de_del,
+				     ext4_lblk_t lblk,
 				     struct buffer_head *bh,
 				     void *entry_buf,
 				     int buf_size,
@@ -3191,7 +3239,7 @@ extern int ext4_handle_dirty_dirblock(handle_t *handle, struct inode *inode,
 				      struct buffer_head *bh);
 extern int ext4_ci_compare(const struct inode *parent,
 			   const struct qstr *fname,
-			   const struct qstr *entry, bool quick);
+			   unsigned char *name2, size_t len, bool quick);
 
 #define S_SHIFT 12
 static const unsigned char ext4_type_by_mode[(S_IFMT >> S_SHIFT) + 1] = {
diff --git a/fs/ext4/hash.c b/fs/ext4/hash.c
index 143b0073b3f46..035b57b936732 100644
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
@@ -280,7 +296,7 @@ int ext4fs_dirhash(const struct inode *dir, const char *name, int len,
 	unsigned char *buff;
 	struct qstr qstr = {.name = name, .len = len };
 
-	if (len && IS_CASEFOLDED(dir) && um) {
+	if (len && needs_casefold(dir) && um) {
 		buff = kzalloc(sizeof(char) * PATH_MAX, GFP_KERNEL);
 		if (!buff)
 			return -ENOMEM;
@@ -291,12 +307,12 @@ int ext4fs_dirhash(const struct inode *dir, const char *name, int len,
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
index 8ca4a23129aaf..fbf3f915c4871 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -448,7 +448,10 @@ static int find_group_orlov(struct super_block *sb, struct inode *parent,
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
index 2fec62d764fa9..4dd04c06bdabe 100644
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
@@ -1378,8 +1378,8 @@ int ext4_inlinedir_to_tree(struct file *dir_file,
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
@@ -1388,8 +1388,8 @@ int ext4_inlinedir_to_tree(struct file *dir_file,
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
@@ -1398,13 +1398,18 @@ int ext4_inlinedir_to_tree(struct file *dir_file,
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
@@ -1486,8 +1491,8 @@ int ext4_read_inline_dir(struct file *file,
 	 * So we will use extra_offset and extra_size to indicate them
 	 * during the inline dir iteration.
 	 */
-	dotdot_offset = EXT4_DIR_REC_LEN(1);
-	dotdot_size = dotdot_offset + EXT4_DIR_REC_LEN(2);
+	dotdot_offset = ext4_dir_rec_len(1, NULL);
+	dotdot_size = dotdot_offset + ext4_dir_rec_len(2, NULL);
 	extra_offset = dotdot_size - EXT4_INLINE_DOTDOT_SIZE;
 	extra_size = extra_offset + inline_size;
 
@@ -1522,7 +1527,7 @@ int ext4_read_inline_dir(struct file *file,
 			 * failure will be detected in the
 			 * dirent test below. */
 			if (ext4_rec_len_from_disk(de->rec_len, extra_size)
-				< EXT4_DIR_REC_LEN(1))
+				< ext4_dir_rec_len(1, NULL))
 				break;
 			i += ext4_rec_len_from_disk(de->rec_len,
 						    extra_size);
@@ -1550,7 +1555,7 @@ int ext4_read_inline_dir(struct file *file,
 		de = (struct ext4_dir_entry_2 *)
 			(dir_buf + ctx->pos - extra_offset);
 		if (ext4_check_dir_entry(inode, file, de, iloc.bh, dir_buf,
-					 extra_size, ctx->pos))
+					 extra_size, 0, ctx->pos))
 			goto out;
 		if (le32_to_cpu(de->inode)) {
 			if (!dir_emit(ctx, de->name, de->name_len,
@@ -1642,7 +1647,7 @@ struct buffer_head *ext4_find_inline_entry(struct inode *dir,
 						EXT4_INLINE_DOTDOT_SIZE;
 	inline_size = EXT4_MIN_INLINE_DATA_SIZE - EXT4_INLINE_DOTDOT_SIZE;
 	ret = ext4_search_dir(iloc.bh, inline_start, inline_size,
-			      dir, fname, 0, res_dir);
+			      dir, fname, 0, 0, res_dir);
 	if (ret == 1)
 		goto out_find;
 	if (ret < 0)
@@ -1655,7 +1660,7 @@ struct buffer_head *ext4_find_inline_entry(struct inode *dir,
 	inline_size = ext4_get_inline_size(dir) - EXT4_MIN_INLINE_DATA_SIZE;
 
 	ret = ext4_search_dir(iloc.bh, inline_start, inline_size,
-			      dir, fname, 0, res_dir);
+			      dir, fname, 0, 0, res_dir);
 	if (ret == 1)
 		goto out_find;
 
@@ -1704,7 +1709,7 @@ int ext4_delete_inline_entry(handle_t *handle,
 	if (err)
 		goto out;
 
-	err = ext4_generic_delete_entry(handle, dir, de_del, bh,
+	err = ext4_generic_delete_entry(handle, dir, de_del, 0, bh,
 					inline_start, inline_size, 0);
 	if (err)
 		goto out;
@@ -1788,7 +1793,7 @@ bool empty_inline_dir(struct inode *dir, int *has_inline_data)
 					   &inline_pos, &inline_size);
 		if (ext4_check_dir_entry(dir, NULL, de,
 					 iloc.bh, inline_pos,
-					 inline_size, offset)) {
+					 inline_size, 0, offset)) {
 			ext4_warning(dir->i_sb,
 				     "bad inline directory (dir #%lu) - "
 				     "inode %u, rec_len %u, name_len %d"
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 80b5cc41851f3..4fc543f459aed 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -277,9 +277,11 @@ static int dx_make_map(struct inode *dir, struct ext4_dir_entry_2 *de,
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
@@ -288,7 +290,7 @@ static int ext4_htree_next_block(struct inode *dir, __u32 hash,
 				 __u32 *start_hash);
 static struct buffer_head * ext4_dx_find_entry(struct inode *dir,
 		struct ext4_filename *fname,
-		struct ext4_dir_entry_2 **res_dir);
+		struct ext4_dir_entry_2 **res_dir, ext4_lblk_t *lblk);
 static int ext4_dx_add_entry(handle_t *handle, struct ext4_filename *fname,
 			     struct inode *dir, struct inode *inode);
 
@@ -571,8 +573,9 @@ static inline void dx_set_limit(struct dx_entry *entries, unsigned value)
 
 static inline unsigned dx_root_limit(struct inode *dir, unsigned infosize)
 {
-	unsigned entry_space = dir->i_sb->s_blocksize - EXT4_DIR_REC_LEN(1) -
-		EXT4_DIR_REC_LEN(2) - infosize;
+	unsigned int entry_space = dir->i_sb->s_blocksize -
+			ext4_dir_rec_len(1, NULL) -
+			ext4_dir_rec_len(2, NULL) - infosize;
 
 	if (ext4_has_metadata_csum(dir->i_sb))
 		entry_space -= sizeof(struct dx_tail);
@@ -581,7 +584,8 @@ static inline unsigned dx_root_limit(struct inode *dir, unsigned infosize)
 
 static inline unsigned dx_node_limit(struct inode *dir)
 {
-	unsigned entry_space = dir->i_sb->s_blocksize - EXT4_DIR_REC_LEN(0);
+	unsigned int entry_space = dir->i_sb->s_blocksize -
+			ext4_dir_rec_len(0, dir);
 
 	if (ext4_has_metadata_csum(dir->i_sb))
 		entry_space -= sizeof(struct dx_tail);
@@ -677,7 +681,10 @@ static struct stats dx_show_leaf(struct inode *dir,
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
@@ -693,7 +700,7 @@ static struct stats dx_show_leaf(struct inode *dir,
 				       (unsigned) ((char *) de - base));
 #endif
 			}
-			space += EXT4_DIR_REC_LEN(de->name_len);
+			space += ext4_dir_rec_len(de->name_len, dir);
 			names++;
 		}
 		de = ext4_next_entry(de, size);
@@ -765,7 +772,8 @@ dx_probe(struct ext4_filename *fname, struct inode *dir,
 	root = (struct dx_root *) frame->bh->b_data;
 	if (root->info.hash_version != DX_HASH_TEA &&
 	    root->info.hash_version != DX_HASH_HALF_MD4 &&
-	    root->info.hash_version != DX_HASH_LEGACY) {
+	    root->info.hash_version != DX_HASH_LEGACY &&
+	    root->info.hash_version != DX_HASH_SIPHASH) {
 		ext4_warning_inode(dir, "Unrecognised inode hash code %u",
 				   root->info.hash_version);
 		goto fail;
@@ -1001,7 +1009,7 @@ static int htree_dirblock_to_tree(struct file *dir_file,
 	de = (struct ext4_dir_entry_2 *) bh->b_data;
 	top = (struct ext4_dir_entry_2 *) ((char *) de +
 					   dir->i_sb->s_blocksize -
-					   EXT4_DIR_REC_LEN(0));
+					   ext4_dir_rec_len(0, dir));
 #ifdef CONFIG_FS_ENCRYPTION
 	/* Check if the directory is encrypted */
 	if (IS_ENCRYPTED(dir)) {
@@ -1020,13 +1028,18 @@ static int htree_dirblock_to_tree(struct file *dir_file,
 #endif
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
+			hinfo->hash = EXT4_DIRENT_HASH(de);
+			hinfo->minor_hash = EXT4_DIRENT_MINOR_HASH(de);
+		} else {
+			ext4fs_dirhash(dir, de->name, de->name_len, hinfo);
+		}
 		if ((hinfo->hash < start_hash) ||
 		    ((hinfo->hash == start_hash) &&
 		     (hinfo->minor_hash < start_minor_hash)))
@@ -1097,7 +1110,11 @@ int ext4_htree_fill_tree(struct file *dir_file, __u32 start_hash,
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
@@ -1190,11 +1207,12 @@ int ext4_htree_fill_tree(struct file *dir_file, __u32 start_hash,
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
@@ -1215,7 +1233,10 @@ static int dx_make_map(struct inode *dir, struct ext4_dir_entry_2 *de,
 
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
@@ -1280,30 +1301,54 @@ static void dx_insert_block(struct dx_frame *frame, u32 hash, ext4_lblk_t block)
  * doesn't match or less than zero on error.
  */
 int ext4_ci_compare(const struct inode *parent, const struct qstr *name,
-		    const struct qstr *entry, bool quick)
+		unsigned char *name2, size_t len, bool quick)
 {
 	const struct super_block *sb = parent->i_sb;
 	const struct unicode_map *um = sb->s_encoding;
+	const struct fscrypt_str crypt_entry = FSTR_INIT(name2, len);
+	struct fscrypt_str decrypted_entry;
+	struct qstr entry = QSTR_INIT(name2, len);
 	int ret;
 
+	decrypted_entry.name = NULL;
+	decrypted_entry.len = 0;
+	if (IS_ENCRYPTED(parent) && fscrypt_has_encryption_key(parent)) {
+		decrypted_entry.name = kmalloc(len, GFP_ATOMIC);
+		decrypted_entry.len = len;
+		if (!decrypted_entry.name)
+			return -ENOMEM;
+		ret = fscrypt_fname_disk_to_usr(parent, 0, 0, &crypt_entry,
+							&decrypted_entry);
+		if (ret < 0)
+			goto err;
+	}
+
+	{
+	struct qstr decrypted = FSTR_TO_QSTR(&decrypted_entry);
 	if (quick)
-		ret = utf8_strncasecmp_folded(um, name, entry);
+		ret = utf8_strncasecmp_folded(um, name,
+				decrypted_entry.name ? &decrypted : &entry);
 	else
-		ret = utf8_strncasecmp(um, name, entry);
+		ret = utf8_strncasecmp(um, name,
+				decrypted_entry.name ? &decrypted : &entry);
+	}
 
 	if (ret < 0) {
 		/* Handle invalid character sequence as either an error
 		 * or as an opaque byte sequence.
 		 */
-		if (sb_has_enc_strict_mode(sb))
-			return -EINVAL;
-
-		if (name->len != entry->len)
-			return 1;
+		if (sb_has_enc_strict_mode(sb)) {
+			ret = -EINVAL;
+			goto err;
+		}
 
-		return !!memcmp(name->name, entry->name, name->len);
+		if (name->len != entry.len)
+			ret = 1;
+		else
+			ret = !!memcmp(name->name, entry.name, name->len);
 	}
-
+err:
+	kfree(decrypted_entry.name);
 	return ret;
 }
 
@@ -1339,14 +1384,11 @@ void ext4_fname_setup_ci_filename(struct inode *dir, const struct qstr *iname,
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
@@ -1362,10 +1404,23 @@ static inline bool ext4_match(const struct inode *parent,
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
 
@@ -1377,7 +1432,8 @@ static inline bool ext4_match(const struct inode *parent,
  */
 int ext4_search_dir(struct buffer_head *bh, char *search_buf, int buf_size,
 		    struct inode *dir, struct ext4_filename *fname,
-		    unsigned int offset, struct ext4_dir_entry_2 **res_dir)
+		    ext4_lblk_t lblk, unsigned int offset,
+		    struct ext4_dir_entry_2 **res_dir)
 {
 	struct ext4_dir_entry_2 * de;
 	char * dlimit;
@@ -1393,7 +1449,7 @@ int ext4_search_dir(struct buffer_head *bh, char *search_buf, int buf_size,
 			/* found a match - just to be sure, do
 			 * a full check */
 			if (ext4_check_dir_entry(dir, NULL, de, bh, bh->b_data,
-						 bh->b_size, offset))
+						 bh->b_size, lblk, offset))
 				return -1;
 			*res_dir = de;
 			return 1;
@@ -1439,7 +1495,7 @@ static int is_dx_internal_node(struct inode *dir, ext4_lblk_t block,
 static struct buffer_head *__ext4_find_entry(struct inode *dir,
 					     struct ext4_filename *fname,
 					     struct ext4_dir_entry_2 **res_dir,
-					     int *inlined)
+					     int *inlined, ext4_lblk_t *lblk)
 {
 	struct super_block *sb;
 	struct buffer_head *bh_use[NAMEI_RA_SIZE];
@@ -1463,6 +1519,8 @@ static struct buffer_head *__ext4_find_entry(struct inode *dir,
 		int has_inline_data = 1;
 		ret = ext4_find_inline_entry(dir, fname, res_dir,
 					     &has_inline_data);
+		if (lblk)
+			*lblk = 0;
 		if (has_inline_data) {
 			if (inlined)
 				*inlined = 1;
@@ -1481,7 +1539,7 @@ static struct buffer_head *__ext4_find_entry(struct inode *dir,
 		goto restart;
 	}
 	if (is_dx(dir)) {
-		ret = ext4_dx_find_entry(dir, fname, res_dir);
+		ret = ext4_dx_find_entry(dir, fname, res_dir, lblk);
 		/*
 		 * On success, or if the error was file not found,
 		 * return.  Otherwise, fall back to doing a search the
@@ -1544,9 +1602,11 @@ static struct buffer_head *__ext4_find_entry(struct inode *dir,
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
@@ -1581,7 +1641,7 @@ static struct buffer_head *__ext4_find_entry(struct inode *dir,
 static struct buffer_head *ext4_find_entry(struct inode *dir,
 					   const struct qstr *d_name,
 					   struct ext4_dir_entry_2 **res_dir,
-					   int *inlined)
+					   int *inlined, ext4_lblk_t *lblk)
 {
 	int err;
 	struct ext4_filename fname;
@@ -1593,7 +1653,7 @@ static struct buffer_head *ext4_find_entry(struct inode *dir,
 	if (err)
 		return ERR_PTR(err);
 
-	bh = __ext4_find_entry(dir, &fname, res_dir, inlined);
+	bh = __ext4_find_entry(dir, &fname, res_dir, inlined, lblk);
 
 	ext4_fname_free_filename(&fname);
 	return bh;
@@ -1614,7 +1674,7 @@ static struct buffer_head *ext4_lookup_entry(struct inode *dir,
 	if (err)
 		return ERR_PTR(err);
 
-	bh = __ext4_find_entry(dir, &fname, res_dir, NULL);
+	bh = __ext4_find_entry(dir, &fname, res_dir, NULL, NULL);
 
 	ext4_fname_free_filename(&fname);
 	return bh;
@@ -1622,7 +1682,7 @@ static struct buffer_head *ext4_lookup_entry(struct inode *dir,
 
 static struct buffer_head * ext4_dx_find_entry(struct inode *dir,
 			struct ext4_filename *fname,
-			struct ext4_dir_entry_2 **res_dir)
+			struct ext4_dir_entry_2 **res_dir, ext4_lblk_t *lblk)
 {
 	struct super_block * sb = dir->i_sb;
 	struct dx_frame frames[EXT4_HTREE_LEVEL], *frame;
@@ -1638,11 +1698,13 @@ static struct buffer_head * ext4_dx_find_entry(struct inode *dir,
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
@@ -1737,7 +1799,7 @@ struct dentry *ext4_get_parent(struct dentry *child)
 	struct ext4_dir_entry_2 * de;
 	struct buffer_head *bh;
 
-	bh = ext4_find_entry(d_inode(child), &dotdot, &de, NULL);
+	bh = ext4_find_entry(d_inode(child), &dotdot, &de, NULL, NULL);
 	if (IS_ERR(bh))
 		return ERR_CAST(bh);
 	if (!bh)
@@ -1759,7 +1821,8 @@ struct dentry *ext4_get_parent(struct dentry *child)
  * Returns pointer to last entry moved.
  */
 static struct ext4_dir_entry_2 *
-dx_move_dirents(char *from, char *to, struct dx_map_entry *map, int count,
+dx_move_dirents(struct inode *dir, char *from, char *to,
+		struct dx_map_entry *map, int count,
 		unsigned blocksize)
 {
 	unsigned rec_len = 0;
@@ -1767,7 +1830,8 @@ dx_move_dirents(char *from, char *to, struct dx_map_entry *map, int count,
 	while (count--) {
 		struct ext4_dir_entry_2 *de = (struct ext4_dir_entry_2 *)
 						(from + (map->offs<<2));
-		rec_len = EXT4_DIR_REC_LEN(de->name_len);
+		rec_len = ext4_dir_rec_len(de->name_len, dir);
+
 		memcpy (to, de, rec_len);
 		((struct ext4_dir_entry_2 *) to)->rec_len =
 				ext4_rec_len_to_disk(rec_len, blocksize);
@@ -1782,7 +1846,8 @@ dx_move_dirents(char *from, char *to, struct dx_map_entry *map, int count,
  * Compact each dir entry in the range to the minimal rec_len.
  * Returns pointer to last entry in range.
  */
-static struct ext4_dir_entry_2* dx_pack_dirents(char *base, unsigned blocksize)
+static struct ext4_dir_entry_2 *dx_pack_dirents(struct inode *dir, char *base,
+							unsigned int blocksize)
 {
 	struct ext4_dir_entry_2 *next, *to, *prev, *de = (struct ext4_dir_entry_2 *) base;
 	unsigned rec_len = 0;
@@ -1791,7 +1856,7 @@ static struct ext4_dir_entry_2* dx_pack_dirents(char *base, unsigned blocksize)
 	while ((char*)de < base + blocksize) {
 		next = ext4_next_entry(de, blocksize);
 		if (de->inode && de->name_len) {
-			rec_len = EXT4_DIR_REC_LEN(de->name_len);
+			rec_len = ext4_dir_rec_len(de->name_len, dir);
 			if (de > to)
 				memmove(to, de, rec_len);
 			to->rec_len = ext4_rec_len_to_disk(rec_len, blocksize);
@@ -1809,13 +1874,12 @@ static struct ext4_dir_entry_2* dx_pack_dirents(char *base, unsigned blocksize)
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
@@ -1827,7 +1891,7 @@ static struct ext4_dir_entry_2 *do_split(handle_t *handle, struct inode *dir,
 	if (ext4_has_metadata_csum(dir->i_sb))
 		csum_size = sizeof(struct ext4_dir_entry_tail);
 
-	bh2 = ext4_append(handle, dir, &newblock);
+	bh2 = ext4_append(handle, dir, newblock);
 	if (IS_ERR(bh2)) {
 		brelse(*bh);
 		*bh = NULL;
@@ -1871,9 +1935,9 @@ static struct ext4_dir_entry_2 *do_split(handle_t *handle, struct inode *dir,
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
@@ -1895,7 +1959,7 @@ static struct ext4_dir_entry_2 *do_split(handle_t *handle, struct inode *dir,
 		swap(*bh, bh2);
 		de = de2;
 	}
-	dx_insert_block(frame, hash2 + continued, newblock);
+	dx_insert_block(frame, hash2 + continued, *newblock);
 	err = ext4_handle_dirty_dirblock(handle, dir, bh2);
 	if (err)
 		goto journal_error;
@@ -1915,13 +1979,14 @@ static struct ext4_dir_entry_2 *do_split(handle_t *handle, struct inode *dir,
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
@@ -1930,11 +1995,11 @@ int ext4_find_dest_de(struct inode *dir, struct inode *inode,
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
@@ -1948,7 +2013,8 @@ int ext4_find_dest_de(struct inode *dir, struct inode *inode,
 	return 0;
 }
 
-void ext4_insert_dentry(struct inode *inode,
+void ext4_insert_dentry(struct inode *dir,
+			struct inode *inode,
 			struct ext4_dir_entry_2 *de,
 			int buf_size,
 			struct ext4_filename *fname)
@@ -1956,7 +2022,7 @@ void ext4_insert_dentry(struct inode *inode,
 
 	int nlen, rlen;
 
-	nlen = EXT4_DIR_REC_LEN(de->name_len);
+	nlen = ext4_dir_rec_len(de->name_len, dir);
 	rlen = ext4_rec_len_from_disk(de->rec_len, buf_size);
 	if (de->inode) {
 		struct ext4_dir_entry_2 *de1 =
@@ -1970,6 +2036,17 @@ void ext4_insert_dentry(struct inode *inode,
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
+		EXT4_EXTENDED_DIRENT(de)->hash = cpu_to_le32(hinfo.hash);
+		EXT4_EXTENDED_DIRENT(de)->minor_hash =
+				cpu_to_le32(hinfo.minor_hash);
+	}
 }
 
 /*
@@ -1983,6 +2060,7 @@ void ext4_insert_dentry(struct inode *inode,
 static int add_dirent_to_buf(handle_t *handle, struct ext4_filename *fname,
 			     struct inode *dir,
 			     struct inode *inode, struct ext4_dir_entry_2 *de,
+			     ext4_lblk_t blk,
 			     struct buffer_head *bh)
 {
 	unsigned int	blocksize = dir->i_sb->s_blocksize;
@@ -1993,7 +2071,7 @@ static int add_dirent_to_buf(handle_t *handle, struct ext4_filename *fname,
 		csum_size = sizeof(struct ext4_dir_entry_tail);
 
 	if (!de) {
-		err = ext4_find_dest_de(dir, inode, bh, bh->b_data,
+		err = ext4_find_dest_de(dir, inode, blk, bh, bh->b_data,
 					blocksize - csum_size, fname, &de);
 		if (err)
 			return err;
@@ -2006,7 +2084,7 @@ static int add_dirent_to_buf(handle_t *handle, struct ext4_filename *fname,
 	}
 
 	/* By now the buffer is marked for journaling */
-	ext4_insert_dentry(inode, de, blocksize, fname);
+	ext4_insert_dentry(dir, inode, de, blocksize, fname);
 
 	/*
 	 * XXX shouldn't update any times until successful
@@ -2098,11 +2176,16 @@ static int make_indexed_dir(handle_t *handle, struct ext4_filename *fname,
 
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
@@ -2113,7 +2196,12 @@ static int make_indexed_dir(handle_t *handle, struct ext4_filename *fname,
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
@@ -2128,13 +2216,13 @@ static int make_indexed_dir(handle_t *handle, struct ext4_filename *fname,
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
@@ -2222,7 +2310,7 @@ static int ext4_add_entry(handle_t *handle, struct dentry *dentry,
 			goto out;
 		}
 		retval = add_dirent_to_buf(handle, &fname, dir, inode,
-					   NULL, bh);
+					   NULL, block, bh);
 		if (retval != -ENOSPC)
 			goto out;
 
@@ -2249,7 +2337,7 @@ static int ext4_add_entry(handle_t *handle, struct dentry *dentry,
 	if (csum_size)
 		ext4_initialize_dirent_tail(bh, blocksize);
 
-	retval = add_dirent_to_buf(handle, &fname, dir, inode, de, bh);
+	retval = add_dirent_to_buf(handle, &fname, dir, inode, de, block, bh);
 out:
 	ext4_fname_free_filename(&fname);
 	brelse(bh);
@@ -2271,6 +2359,7 @@ static int ext4_dx_add_entry(handle_t *handle, struct ext4_filename *fname,
 	struct ext4_dir_entry_2 *de;
 	int restart;
 	int err;
+	ext4_lblk_t lblk;
 
 again:
 	restart = 0;
@@ -2279,7 +2368,8 @@ static int ext4_dx_add_entry(handle_t *handle, struct ext4_filename *fname,
 		return PTR_ERR(frame);
 	entries = frame->entries;
 	at = frame->at;
-	bh = ext4_read_dirblock(dir, dx_get_block(frame->at), DIRENT_HTREE);
+	lblk = dx_get_block(frame->at);
+	bh = ext4_read_dirblock(dir, lblk, DIRENT_HTREE);
 	if (IS_ERR(bh)) {
 		err = PTR_ERR(bh);
 		bh = NULL;
@@ -2291,7 +2381,7 @@ static int ext4_dx_add_entry(handle_t *handle, struct ext4_filename *fname,
 	if (err)
 		goto journal_error;
 
-	err = add_dirent_to_buf(handle, fname, dir, inode, NULL, bh);
+	err = add_dirent_to_buf(handle, fname, dir, inode, NULL, lblk, bh);
 	if (err != -ENOSPC)
 		goto cleanup;
 
@@ -2411,12 +2501,12 @@ static int ext4_dx_add_entry(handle_t *handle, struct ext4_filename *fname,
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
@@ -2439,6 +2529,7 @@ static int ext4_dx_add_entry(handle_t *handle, struct ext4_filename *fname,
 int ext4_generic_delete_entry(handle_t *handle,
 			      struct inode *dir,
 			      struct ext4_dir_entry_2 *de_del,
+			      ext4_lblk_t lblk,
 			      struct buffer_head *bh,
 			      void *entry_buf,
 			      int buf_size,
@@ -2453,7 +2544,7 @@ int ext4_generic_delete_entry(handle_t *handle,
 	de = (struct ext4_dir_entry_2 *)entry_buf;
 	while (i < buf_size - csum_size) {
 		if (ext4_check_dir_entry(dir, NULL, de, bh,
-					 bh->b_data, bh->b_size, i))
+					 bh->b_data, bh->b_size, lblk, i))
 			return -EFSCORRUPTED;
 		if (de == de_del)  {
 			if (pde)
@@ -2478,6 +2569,7 @@ int ext4_generic_delete_entry(handle_t *handle,
 static int ext4_delete_entry(handle_t *handle,
 			     struct inode *dir,
 			     struct ext4_dir_entry_2 *de_del,
+			     ext4_lblk_t lblk,
 			     struct buffer_head *bh)
 {
 	int err, csum_size = 0;
@@ -2498,7 +2590,7 @@ static int ext4_delete_entry(handle_t *handle,
 	if (unlikely(err))
 		goto out;
 
-	err = ext4_generic_delete_entry(handle, dir, de_del,
+	err = ext4_generic_delete_entry(handle, dir, de_del, lblk,
 					bh, bh->b_data,
 					dir->i_sb->s_blocksize, csum_size);
 	if (err)
@@ -2692,7 +2784,7 @@ struct ext4_dir_entry_2 *ext4_init_dot_dotdot(struct inode *inode,
 {
 	de->inode = cpu_to_le32(inode->i_ino);
 	de->name_len = 1;
-	de->rec_len = ext4_rec_len_to_disk(EXT4_DIR_REC_LEN(de->name_len),
+	de->rec_len = ext4_rec_len_to_disk(ext4_dir_rec_len(de->name_len, NULL),
 					   blocksize);
 	strcpy(de->name, ".");
 	ext4_set_de_type(inode->i_sb, de, S_IFDIR);
@@ -2702,11 +2794,12 @@ struct ext4_dir_entry_2 *ext4_init_dot_dotdot(struct inode *inode,
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
 
@@ -2834,7 +2927,8 @@ bool ext4_empty_dir(struct inode *inode)
 	}
 
 	sb = inode->i_sb;
-	if (inode->i_size < EXT4_DIR_REC_LEN(1) + EXT4_DIR_REC_LEN(2)) {
+	if (inode->i_size < ext4_dir_rec_len(1, NULL) +
+					ext4_dir_rec_len(2, NULL)) {
 		EXT4_ERROR_INODE(inode, "invalid size");
 		return true;
 	}
@@ -2846,7 +2940,7 @@ bool ext4_empty_dir(struct inode *inode)
 		return true;
 
 	de = (struct ext4_dir_entry_2 *) bh->b_data;
-	if (ext4_check_dir_entry(inode, NULL, de, bh, bh->b_data, bh->b_size,
+	if (ext4_check_dir_entry(inode, NULL, de, bh, bh->b_data, bh->b_size, 0,
 				 0) ||
 	    le32_to_cpu(de->inode) != inode->i_ino || strcmp(".", de->name)) {
 		ext4_warning_inode(inode, "directory missing '.'");
@@ -2855,7 +2949,7 @@ bool ext4_empty_dir(struct inode *inode)
 	}
 	offset = ext4_rec_len_from_disk(de->rec_len, sb->s_blocksize);
 	de = ext4_next_entry(de, sb->s_blocksize);
-	if (ext4_check_dir_entry(inode, NULL, de, bh, bh->b_data, bh->b_size,
+	if (ext4_check_dir_entry(inode, NULL, de, bh, bh->b_data, bh->b_size, 0,
 				 offset) ||
 	    le32_to_cpu(de->inode) == 0 || strcmp("..", de->name)) {
 		ext4_warning_inode(inode, "directory missing '..'");
@@ -2879,7 +2973,7 @@ bool ext4_empty_dir(struct inode *inode)
 		de = (struct ext4_dir_entry_2 *) (bh->b_data +
 					(offset & (sb->s_blocksize - 1)));
 		if (ext4_check_dir_entry(inode, NULL, de, bh,
-					 bh->b_data, bh->b_size, offset)) {
+					 bh->b_data, bh->b_size, 0, offset)) {
 			offset = (offset | (sb->s_blocksize - 1)) + 1;
 			continue;
 		}
@@ -3074,6 +3168,8 @@ static int ext4_rmdir(struct inode *dir, struct dentry *dentry)
 	struct buffer_head *bh;
 	struct ext4_dir_entry_2 *de;
 	handle_t *handle = NULL;
+	ext4_lblk_t lblk;
+
 
 	if (unlikely(ext4_forced_shutdown(EXT4_SB(dir->i_sb))))
 		return -EIO;
@@ -3088,7 +3184,7 @@ static int ext4_rmdir(struct inode *dir, struct dentry *dentry)
 		return retval;
 
 	retval = -ENOENT;
-	bh = ext4_find_entry(dir, &dentry->d_name, &de, NULL);
+	bh = ext4_find_entry(dir, &dentry->d_name, &de, NULL, &lblk);
 	if (IS_ERR(bh))
 		return PTR_ERR(bh);
 	if (!bh)
@@ -3115,7 +3211,7 @@ static int ext4_rmdir(struct inode *dir, struct dentry *dentry)
 	if (IS_DIRSYNC(dir))
 		ext4_handle_sync(handle);
 
-	retval = ext4_delete_entry(handle, dir, de, bh);
+	retval = ext4_delete_entry(handle, dir, de, lblk, bh);
 	if (retval)
 		goto end_rmdir;
 	if (!EXT4_DIR_LINK_EMPTY(inode))
@@ -3161,6 +3257,7 @@ static int ext4_unlink(struct inode *dir, struct dentry *dentry)
 	struct buffer_head *bh;
 	struct ext4_dir_entry_2 *de;
 	handle_t *handle = NULL;
+	ext4_lblk_t lblk;
 
 	if (unlikely(ext4_forced_shutdown(EXT4_SB(dir->i_sb))))
 		return -EIO;
@@ -3176,7 +3273,7 @@ static int ext4_unlink(struct inode *dir, struct dentry *dentry)
 		return retval;
 
 	retval = -ENOENT;
-	bh = ext4_find_entry(dir, &dentry->d_name, &de, NULL);
+	bh = ext4_find_entry(dir, &dentry->d_name, &de, NULL, &lblk);
 	if (IS_ERR(bh))
 		return PTR_ERR(bh);
 	if (!bh)
@@ -3199,7 +3296,7 @@ static int ext4_unlink(struct inode *dir, struct dentry *dentry)
 	if (IS_DIRSYNC(dir))
 		ext4_handle_sync(handle);
 
-	retval = ext4_delete_entry(handle, dir, de, bh);
+	retval = ext4_delete_entry(handle, dir, de, lblk, bh);
 	if (retval)
 		goto end_unlink;
 	dir->i_ctime = dir->i_mtime = current_time(dir);
@@ -3460,6 +3557,7 @@ struct ext4_renament {
 	int dir_nlink_delta;
 
 	/* entry for "dentry" */
+	ext4_lblk_t lblk;
 	struct buffer_head *bh;
 	struct ext4_dir_entry_2 *de;
 	int inlined;
@@ -3547,12 +3645,13 @@ static int ext4_find_delete_entry(handle_t *handle, struct inode *dir,
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
@@ -3576,7 +3675,8 @@ static void ext4_rename_delete(handle_t *handle, struct ext4_renament *ent,
 		retval = ext4_find_delete_entry(handle, ent->dir,
 						&ent->dentry->d_name);
 	} else {
-		retval = ext4_delete_entry(handle, ent->dir, ent->de, ent->bh);
+		retval = ext4_delete_entry(handle, ent->dir, ent->de,
+						ent->lblk, ent->bh);
 		if (retval == -ENOENT) {
 			retval = ext4_find_delete_entry(handle, ent->dir,
 							&ent->dentry->d_name);
@@ -3689,7 +3789,8 @@ static int ext4_rename(struct inode *old_dir, struct dentry *old_dentry,
 			return retval;
 	}
 
-	old.bh = ext4_find_entry(old.dir, &old.dentry->d_name, &old.de, NULL);
+	old.bh = ext4_find_entry(old.dir, &old.dentry->d_name, &old.de, NULL,
+				&old.lblk);
 	if (IS_ERR(old.bh))
 		return PTR_ERR(old.bh);
 	/*
@@ -3703,7 +3804,7 @@ static int ext4_rename(struct inode *old_dir, struct dentry *old_dentry,
 		goto end_rename;
 
 	new.bh = ext4_find_entry(new.dir, &new.dentry->d_name,
-				 &new.de, &new.inlined);
+				 &new.de, &new.inlined, NULL);
 	if (IS_ERR(new.bh)) {
 		retval = PTR_ERR(new.bh);
 		new.bh = NULL;
@@ -3883,7 +3984,7 @@ static int ext4_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 		return retval;
 
 	old.bh = ext4_find_entry(old.dir, &old.dentry->d_name,
-				 &old.de, &old.inlined);
+				 &old.de, &old.inlined, NULL);
 	if (IS_ERR(old.bh))
 		return PTR_ERR(old.bh);
 	/*
@@ -3897,7 +3998,7 @@ static int ext4_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 		goto end_rename;
 
 	new.bh = ext4_find_entry(new.dir, &new.dentry->d_name,
-				 &new.de, &new.inlined);
+				 &new.de, &new.inlined, NULL);
 	if (IS_ERR(new.bh)) {
 		retval = PTR_ERR(new.bh);
 		new.bh = NULL;
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 11584bdc3e237..ab6bc300b6b6e 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3855,12 +3855,6 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
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
2.25.0.341.g760bfbb309-goog

