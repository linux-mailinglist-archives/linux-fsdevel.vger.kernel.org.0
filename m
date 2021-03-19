Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7CD3416B0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Mar 2021 08:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234246AbhCSHeq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Mar 2021 03:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbhCSHeV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Mar 2021 03:34:21 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A69C061760
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Mar 2021 00:34:21 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id z5so3536435qvo.16
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Mar 2021 00:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=87gdpquAlO8I9ll0l2ABIeLD3meMvxpeCa3PoDkNX+Q=;
        b=CkS+63Tsc+4iQrMFFmf/JRTyY1IHd87/qKPUvu1eJh9MKyl51OcfSF1a5ZBx2r5jVK
         kyE6yfdKF8MNiHmO9SXmE7OJ5h9VK2RW8865aTD0R+O956YjRmovu4/+ZJxmooVPViUA
         yAVeCZCjo8TT6AslY9wE5TuQNKradwDBN+1Os3O39Uf8W3hBYlZXoK4M+n5HO+auOdTA
         L0HWEiTE2Wtz6hU8tcv/wPrTj2mQS0hPTqUAvt4e8pF9hvlFH2esDYc9Amk0G93xowex
         DTcPYVOZkzAB8X7+31idMkJ0SW0iInX53AysWOgh32Yw6JWvVJ4B3yrYk38arwfbWAbS
         xfUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=87gdpquAlO8I9ll0l2ABIeLD3meMvxpeCa3PoDkNX+Q=;
        b=EIxZd/Jz2V+kHQzLa/gHxRmB/9xQDnBWPO3YKyK5FlNZHKsMDsBBxKMpTiOeuirb/P
         hI07NA6pJNEJ7u9yd/NiwCVNbUwaKXz/q/oL8dBsJQL4ZhA1uTf0K1ZovIVQeofuTlhk
         9rCUcoHstjj6cONWIXe+d0F+H+uDDeOhxa27a4oAFsReZaONfXstRWC++id9kg+/4Cy3
         eKS24yNnw/cjYKXdLD/Vhm+zVMopSw+kuXunFsj4kAnpebFGRlWnjAKF4Qq4+tmpKBEe
         0pTGW5/7XD38vM3/QC4Fd3z4P1JmLAlrAiWKu5jHmeDCHcxatcCMhOpZsZxzZcjwkYgm
         T+SA==
X-Gm-Message-State: AOAM531JUZdjAg6/JCVj9fJRYZmf0I4SwBF8d2GtkV21USF5KBTVW7jC
        lR7z/2Wa9GJptk2oWyI1cIW3dG0QRfE=
X-Google-Smtp-Source: ABdhPJyTVF/ZOZplqJAz18BFnyCwT2D8BkBOPyQBiGX1ZYkMY7lP+EQ/GrRVmRPOSme4PlHxmQXdXrhLDZI=
X-Received: from drosen.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:4e6f])
 (user=drosen job=sendgmr) by 2002:a05:6214:f69:: with SMTP id
 iy9mr8075062qvb.15.1616139260095; Fri, 19 Mar 2021 00:34:20 -0700 (PDT)
Date:   Fri, 19 Mar 2021 07:34:13 +0000
In-Reply-To: <20210319073414.1381041-1-drosen@google.com>
Message-Id: <20210319073414.1381041-2-drosen@google.com>
Mime-Version: 1.0
References: <20210319073414.1381041-1-drosen@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v2 1/2] ext4: Handle casefolding with encryption
From:   Daniel Rosenberg <drosen@google.com>
To:     "Theodore Y . Ts'o" <tytso@mit.edu>,
        Eric Biggers <ebiggers@kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com, Daniel Rosenberg <drosen@google.com>
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
---
 Documentation/filesystems/ext4/directory.rst |  27 +++
 fs/ext4/dir.c                                |  37 +++-
 fs/ext4/ext4.h                               |  56 +++++-
 fs/ext4/hash.c                               |  25 ++-
 fs/ext4/inline.c                             |  25 ++-
 fs/ext4/namei.c                              | 198 ++++++++++++++-----
 fs/ext4/super.c                              |   6 -
 7 files changed, 285 insertions(+), 89 deletions(-)

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
index 5ed870614c8d..21a98288de49 100644
--- a/fs/ext4/dir.c
+++ b/fs/ext4/dir.c
@@ -55,6 +55,18 @@ static int is_dx_dir(struct inode *inode)
 	return 0;
 }
 
+static bool is_fake_dir_entry(struct ext4_dir_entry_2 *de)
+{
+	/* Check if . or .. , or skip if namelen is 0 */
+	if ((de->name_len > 0) && (de->name_len <= 2) && (de->name[0] == '.') &&
+	    (de->name[1] == '.' || de->name[1] == '\0'))
+		return true;
+	/* Check if this is a csum entry */
+	if (de->file_type == EXT4_FT_DIR_CSUM)
+		return true;
+	return false;
+}
+
 /*
  * Return 0 if the directory entry is OK, and 1 if there is a problem
  *
@@ -73,16 +85,20 @@ int __ext4_check_dir_entry(const char *function, unsigned int line,
 	const int rlen = ext4_rec_len_from_disk(de->rec_len,
 						dir->i_sb->s_blocksize);
 	const int next_offset = ((char *) de - buf) + rlen;
+	bool fake = is_fake_dir_entry(de);
+	bool has_csum = ext4_has_metadata_csum(dir->i_sb);
 
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
+						  has_csum ? NULL : dir) &&
 			  next_offset != size))
 		error_msg = "directory entry too close to block end";
 	else if (unlikely(le32_to_cpu(de->inode) >
@@ -94,15 +110,15 @@ int __ext4_check_dir_entry(const char *function, unsigned int line,
 	if (filp)
 		ext4_error_file(filp, function, line, bh->b_blocknr,
 				"bad entry in directory: %s - offset=%u, "
-				"inode=%u, rec_len=%d, name_len=%d, size=%d",
+				"inode=%u, rec_len=%d, size=%d fake=%d",
 				error_msg, offset, le32_to_cpu(de->inode),
-				rlen, de->name_len, size);
+				rlen, size, fake);
 	else
 		ext4_error_inode(dir, function, line, bh->b_blocknr,
 				"bad entry in directory: %s - offset=%u, "
-				"inode=%u, rec_len=%d, name_len=%d, size=%d",
+				"inode=%u, rec_len=%d, size=%d fake=%d",
 				 error_msg, offset, le32_to_cpu(de->inode),
-				 rlen, de->name_len, size);
+				 rlen, size, fake);
 
 	return 1;
 }
@@ -224,7 +240,8 @@ static int ext4_readdir(struct file *file, struct dir_context *ctx)
 				 * failure will be detected in the
 				 * dirent test below. */
 				if (ext4_rec_len_from_disk(de->rec_len,
-					sb->s_blocksize) < EXT4_DIR_REC_LEN(1))
+					sb->s_blocksize) < ext4_dir_rec_len(1,
+									inode))
 					break;
 				i += ext4_rec_len_from_disk(de->rec_len,
 							    sb->s_blocksize);
@@ -265,7 +282,9 @@ static int ext4_readdir(struct file *file, struct dir_context *ctx)
 
 					/* Directory is encrypted */
 					err = fscrypt_fname_disk_to_usr(inode,
-						0, 0, &de_name, &fstr);
+						EXT4_DIRENT_HASH(de),
+						EXT4_DIRENT_MINOR_HASH(de),
+						&de_name, &fstr);
 					de_name = fstr;
 					fstr.len = save_len;
 					if (err)
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 644fd69185d3..dafa528c4d9f 100644
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
@@ -2706,9 +2749,9 @@ extern int __ext4_check_dir_entry(const char *, unsigned int, struct inode *,
 				  struct ext4_dir_entry_2 *,
 				  struct buffer_head *, char *, int,
 				  unsigned int);
-#define ext4_check_dir_entry(dir, filp, de, bh, buf, size, offset)	\
+#define ext4_check_dir_entry(dir, filp, de, bh, buf, size, offset) \
 	unlikely(__ext4_check_dir_entry(__func__, __LINE__, (dir), (filp), \
-					(de), (bh), (buf), (size), (offset)))
+				(de), (bh), (buf), (size), (offset)))
 extern int ext4_htree_store_dirent(struct file *dir_file, __u32 hash,
 				__u32 minor_hash,
 				struct ext4_dir_entry_2 *dirent,
@@ -2719,7 +2762,7 @@ extern int ext4_find_dest_de(struct inode *dir, struct inode *inode,
 			     void *buf, int buf_size,
 			     struct ext4_filename *fname,
 			     struct ext4_dir_entry_2 **dest_de);
-void ext4_insert_dentry(struct inode *inode,
+void ext4_insert_dentry(struct inode *dir, struct inode *inode,
 			struct ext4_dir_entry_2 *de,
 			int buf_size,
 			struct ext4_filename *fname);
@@ -3516,9 +3559,6 @@ extern void ext4_initialize_dirent_tail(struct buffer_head *bh,
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
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index b41512d1badc..ba960e6e7e3a 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
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
@@ -1406,7 +1406,12 @@ int ext4_inlinedir_to_tree(struct file *dir_file,
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
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 686bf982c84e..97d2755b9775 100644
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
@@ -673,7 +677,10 @@ static struct stats dx_show_leaf(struct inode *dir,
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
@@ -689,7 +696,7 @@ static struct stats dx_show_leaf(struct inode *dir,
 				       (unsigned) ((char *) de - base));
 #endif
 			}
-			space += EXT4_DIR_REC_LEN(de->name_len);
+			space += ext4_dir_rec_len(de->name_len, dir);
 			names++;
 		}
 		de = ext4_next_entry(de, size);
@@ -784,11 +791,25 @@ dx_probe(struct ext4_filename *fname, struct inode *dir,
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
@@ -997,6 +1018,7 @@ static int htree_dirblock_to_tree(struct file *dir_file,
 	struct ext4_dir_entry_2 *de, *top;
 	int err = 0, count = 0;
 	struct fscrypt_str fname_crypto_str = FSTR_INIT(NULL, 0), tmp_str;
+	int csum = ext4_has_metadata_csum(dir->i_sb);
 
 	dxtrace(printk(KERN_INFO "In htree dirblock_to_tree: block %lu\n",
 							(unsigned long)block));
@@ -1005,9 +1027,11 @@ static int htree_dirblock_to_tree(struct file *dir_file,
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
 		err = fscrypt_prepare_readdir(dir);
@@ -1031,7 +1055,17 @@ static int htree_dirblock_to_tree(struct file *dir_file,
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
@@ -1100,7 +1134,11 @@ int ext4_htree_fill_tree(struct file *dir_file, __u32 start_hash,
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
@@ -1218,7 +1256,10 @@ static int dx_make_map(struct inode *dir, struct ext4_dir_entry_2 *de,
 
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
@@ -1282,31 +1323,47 @@ static void dx_insert_block(struct dx_frame *frame, u32 hash, ext4_lblk_t block)
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
 
@@ -1342,14 +1399,11 @@ void ext4_fname_setup_ci_filename(struct inode *dir, const struct qstr *iname,
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
@@ -1365,10 +1419,23 @@ static inline bool ext4_match(const struct inode *parent,
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
 
@@ -1765,7 +1832,8 @@ struct dentry *ext4_get_parent(struct dentry *child)
  * Returns pointer to last entry moved.
  */
 static struct ext4_dir_entry_2 *
-dx_move_dirents(char *from, char *to, struct dx_map_entry *map, int count,
+dx_move_dirents(struct inode *dir, char *from, char *to,
+		struct dx_map_entry *map, int count,
 		unsigned blocksize)
 {
 	unsigned rec_len = 0;
@@ -1773,7 +1841,8 @@ dx_move_dirents(char *from, char *to, struct dx_map_entry *map, int count,
 	while (count--) {
 		struct ext4_dir_entry_2 *de = (struct ext4_dir_entry_2 *)
 						(from + (map->offs<<2));
-		rec_len = EXT4_DIR_REC_LEN(de->name_len);
+		rec_len = ext4_dir_rec_len(de->name_len, dir);
+
 		memcpy (to, de, rec_len);
 		((struct ext4_dir_entry_2 *) to)->rec_len =
 				ext4_rec_len_to_disk(rec_len, blocksize);
@@ -1788,7 +1857,8 @@ dx_move_dirents(char *from, char *to, struct dx_map_entry *map, int count,
  * Compact each dir entry in the range to the minimal rec_len.
  * Returns pointer to last entry in range.
  */
-static struct ext4_dir_entry_2* dx_pack_dirents(char *base, unsigned blocksize)
+static struct ext4_dir_entry_2 *dx_pack_dirents(struct inode *dir, char *base,
+							unsigned int blocksize)
 {
 	struct ext4_dir_entry_2 *next, *to, *prev, *de = (struct ext4_dir_entry_2 *) base;
 	unsigned rec_len = 0;
@@ -1797,7 +1867,7 @@ static struct ext4_dir_entry_2* dx_pack_dirents(char *base, unsigned blocksize)
 	while ((char*)de < base + blocksize) {
 		next = ext4_next_entry(de, blocksize);
 		if (de->inode && de->name_len) {
-			rec_len = EXT4_DIR_REC_LEN(de->name_len);
+			rec_len = ext4_dir_rec_len(de->name_len, dir);
 			if (de > to)
 				memmove(to, de, rec_len);
 			to->rec_len = ext4_rec_len_to_disk(rec_len, blocksize);
@@ -1887,9 +1957,9 @@ static struct ext4_dir_entry_2 *do_split(handle_t *handle, struct inode *dir,
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
@@ -1937,7 +2007,7 @@ int ext4_find_dest_de(struct inode *dir, struct inode *inode,
 		      struct ext4_dir_entry_2 **dest_de)
 {
 	struct ext4_dir_entry_2 *de;
-	unsigned short reclen = EXT4_DIR_REC_LEN(fname_len(fname));
+	unsigned short reclen = ext4_dir_rec_len(fname_len(fname), dir);
 	int nlen, rlen;
 	unsigned int offset = 0;
 	char *top;
@@ -1950,7 +2020,7 @@ int ext4_find_dest_de(struct inode *dir, struct inode *inode,
 			return -EFSCORRUPTED;
 		if (ext4_match(dir, fname, de))
 			return -EEXIST;
-		nlen = EXT4_DIR_REC_LEN(de->name_len);
+		nlen = ext4_dir_rec_len(de->name_len, dir);
 		rlen = ext4_rec_len_from_disk(de->rec_len, buf_size);
 		if ((de->inode ? rlen - nlen : rlen) >= reclen)
 			break;
@@ -1964,7 +2034,8 @@ int ext4_find_dest_de(struct inode *dir, struct inode *inode,
 	return 0;
 }
 
-void ext4_insert_dentry(struct inode *inode,
+void ext4_insert_dentry(struct inode *dir,
+			struct inode *inode,
 			struct ext4_dir_entry_2 *de,
 			int buf_size,
 			struct ext4_filename *fname)
@@ -1972,7 +2043,7 @@ void ext4_insert_dentry(struct inode *inode,
 
 	int nlen, rlen;
 
-	nlen = EXT4_DIR_REC_LEN(de->name_len);
+	nlen = ext4_dir_rec_len(de->name_len, dir);
 	rlen = ext4_rec_len_from_disk(de->rec_len, buf_size);
 	if (de->inode) {
 		struct ext4_dir_entry_2 *de1 =
@@ -1986,6 +2057,17 @@ void ext4_insert_dentry(struct inode *inode,
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
@@ -2022,7 +2104,7 @@ static int add_dirent_to_buf(handle_t *handle, struct ext4_filename *fname,
 	}
 
 	/* By now the buffer is marked for journaling */
-	ext4_insert_dentry(inode, de, blocksize, fname);
+	ext4_insert_dentry(dir, inode, de, blocksize, fname);
 
 	/*
 	 * XXX shouldn't update any times until successful
@@ -2114,11 +2196,16 @@ static int make_indexed_dir(handle_t *handle, struct ext4_filename *fname,
 
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
@@ -2129,7 +2216,12 @@ static int make_indexed_dir(handle_t *handle, struct ext4_filename *fname,
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
@@ -2722,7 +2814,7 @@ struct ext4_dir_entry_2 *ext4_init_dot_dotdot(struct inode *inode,
 {
 	de->inode = cpu_to_le32(inode->i_ino);
 	de->name_len = 1;
-	de->rec_len = ext4_rec_len_to_disk(EXT4_DIR_REC_LEN(de->name_len),
+	de->rec_len = ext4_rec_len_to_disk(ext4_dir_rec_len(de->name_len, NULL),
 					   blocksize);
 	strcpy(de->name, ".");
 	ext4_set_de_type(inode->i_sb, de, S_IFDIR);
@@ -2732,11 +2824,12 @@ struct ext4_dir_entry_2 *ext4_init_dot_dotdot(struct inode *inode,
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
 
@@ -2869,7 +2962,8 @@ bool ext4_empty_dir(struct inode *inode)
 	}
 
 	sb = inode->i_sb;
-	if (inode->i_size < EXT4_DIR_REC_LEN(1) + EXT4_DIR_REC_LEN(2)) {
+	if (inode->i_size < ext4_dir_rec_len(1, NULL) +
+					ext4_dir_rec_len(2, NULL)) {
 		EXT4_ERROR_INODE(inode, "invalid size");
 		return true;
 	}
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index ad34a37278cd..312c7c03f401 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4291,12 +4291,6 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
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
2.31.0.rc2.261.g7f71774620-goog

