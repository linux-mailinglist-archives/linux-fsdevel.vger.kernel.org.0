Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60928722C5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2019 01:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfGWXHC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Jul 2019 19:07:02 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:37259 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbfGWXHB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Jul 2019 19:07:01 -0400
Received: by mail-pl1-f202.google.com with SMTP id n4so22387654plp.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jul 2019 16:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Atf22sFG/YJh9MfdgOcKtg39e85eyhIZpv4qCdIqrNY=;
        b=Pd9+QUMFUKG4QcSRPmN/av8uPR5wX8zRgnjAJ19j+nUtNxttXerXndjKf24lOFs337
         LMsrHUgLksJxbcifcDhx+x82tHNpgtunDYjsMLkTWmGmw+zNt8Ra1vXjjd8wy+w3kZCQ
         VcxPYhLcZqxE/xkC+ydwXmIit+TLvmLhU0EQITnoA5h5kM5QdienlKvou18K1zJB6G+v
         rLx+P1gzZnJ2Mo4jCXu/7CMEYFKkrajc4BO4jbRB4b0+B8EnJ62dgPffQmPI3zobgGqy
         5At706KjS75PwAW9reCD5JYZkPmGX+nWwKVMMPmUoGN80z7wvStZp979D8X+JlS3kGeF
         e6eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Atf22sFG/YJh9MfdgOcKtg39e85eyhIZpv4qCdIqrNY=;
        b=bJsYyFOthcxQE+/92RSJGJ6N3ImE0lm/Gtn/uUagoWOroJDs4fNivwXVVd+O1wav12
         2w3AQNUeIzmAIPoNuGN95owz/cAgFKlQPH09zSRmYdlAjLeGlNVF/lkx8M4QVXIjfQ0P
         t6jXacVO0AWGmmYdQvD+axExPJU19ei6XfYog8RjOpF03gFAh8eFa1WJ5fZlGLmeXCC4
         I0FgowdWfONuUSv3Ki8b3Lp6ShVH/fDwCaC30JebJ6GmstFcZGaDXvDfgZuZ0oDAyl6v
         bFHa5IUMybA9WuDi0cU8UjlwqFrclOwwYmYt7X1P4I8R4oER13dgP8DyLLWCIEGNdCE8
         IQqQ==
X-Gm-Message-State: APjAAAU1Vcd7WNt7cCwixKgzi2cqq8y/SaA4/GaLQFKr8eVOFxR/U45C
        /poO+VFGETFHRrRxE6HflJZ17tnTKeM=
X-Google-Smtp-Source: APXvYqzinYFZj3xqXmFTc4YMGqEoGg1zlqe+KUEkVVBloCBndHd5ad54oxfyqGMpoYG8K8CzK2h2vYG/mgc=
X-Received: by 2002:a63:4041:: with SMTP id n62mr7523617pga.312.1563923220366;
 Tue, 23 Jul 2019 16:07:00 -0700 (PDT)
Date:   Tue, 23 Jul 2019 16:05:29 -0700
In-Reply-To: <20190723230529.251659-1-drosen@google.com>
Message-Id: <20190723230529.251659-4-drosen@google.com>
Mime-Version: 1.0
References: <20190723230529.251659-1-drosen@google.com>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
Subject: [PATCH v4 3/3] f2fs: Support case-insensitive file name lookups
From:   Daniel Rosenberg <drosen@google.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        kernel-team@android.com, Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Modeled after commit b886ee3e778e ("ext4: Support case-insensitive file
name lookups")

"""
This patch implements the actual support for case-insensitive file name
lookups in f2fs, based on the feature bit and the encoding stored in the
superblock.

A filesystem that has the casefold feature set is able to configure
directories with the +F (F2FS_CASEFOLD_FL) attribute, enabling lookups
to succeed in that directory in a case-insensitive fashion, i.e: match
a directory entry even if the name used by userspace is not a byte per
byte match with the disk name, but is an equivalent case-insensitive
version of the Unicode string.  This operation is called a
case-insensitive file name lookup.

The feature is configured as an inode attribute applied to directories
and inherited by its children.  This attribute can only be enabled on
empty directories for filesystems that support the encoding feature,
thus preventing collision of file names that only differ by case.

* dcache handling:

For a +F directory, F2Fs only stores the first equivalent name dentry
used in the dcache. This is done to prevent unintentional duplication of
dentries in the dcache, while also allowing the VFS code to quickly find
the right entry in the cache despite which equivalent string was used in
a previous lookup, without having to resort to ->lookup().

d_hash() of casefolded directories is implemented as the hash of the
casefolded string, such that we always have a well-known bucket for all
the equivalencies of the same string. d_compare() uses the
utf8_strncasecmp() infrastructure, which handles the comparison of
equivalent, same case, names as well.

For now, negative lookups are not inserted in the dcache, since they
would need to be invalidated anyway, because we can't trust missing file
dentries.  This is bad for performance but requires some leveraging of
the vfs layer to fix.  We can live without that for now, and so does
everyone else.

* on-disk data:

Despite using a specific version of the name as the internal
representation within the dcache, the name stored and fetched from the
disk is a byte-per-byte match with what the user requested, making this
implementation 'name-preserving'. i.e. no actual information is lost
when writing to storage.

DX is supported by modifying the hashes used in +F directories to make
them case/encoding-aware.  The new disk hashes are calculated as the
hash of the full casefolded string, instead of the string directly.
This allows us to efficiently search for file names in the htree without
requiring the user to provide an exact name.

* Dealing with invalid sequences:

By default, when a invalid UTF-8 sequence is identified, ext4 will treat
it as an opaque byte sequence, ignoring the encoding and reverting to
the old behavior for that unique file.  This means that case-insensitive
file name lookup will not work only for that file.  An optional bit can
be set in the superblock telling the filesystem code and userspace tools
to enforce the encoding.  When that optional bit is set, any attempt to
create a file name using an invalid UTF-8 sequence will fail and return
an error to userspace.

* Normalization algorithm:

The UTF-8 algorithms used to compare strings in f2fs is implemented
in fs/unicode, and is based on a previous version developed by
SGI.  It implements the Canonical decomposition (NFD) algorithm
described by the Unicode specification 12.1, or higher, combined with
the elimination of ignorable code points (NFDi) and full
case-folding (CF) as documented in fs/unicode/utf8_norm.c.

NFD seems to be the best normalization method for F2FS because:

  - It has a lower cost than NFC/NFKC (which requires
    decomposing to NFD as an intermediary step)
  - It doesn't eliminate important semantic meaning like
    compatibility decompositions.

Although:

- This implementation is not completely linguistic accurate, because
different languages have conflicting rules, which would require the
specialization of the filesystem to a given locale, which brings all
sorts of problems for removable media and for users who use more than
one language.
"""

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 fs/f2fs/dir.c    | 126 +++++++++++++++++++++++++++++++++++++++++++----
 fs/f2fs/f2fs.h   |  15 ++++--
 fs/f2fs/file.c   |  16 +++++-
 fs/f2fs/hash.c   |  35 ++++++++++++-
 fs/f2fs/inline.c |   4 +-
 fs/f2fs/inode.c  |   4 +-
 fs/f2fs/namei.c  |  21 ++++++++
 fs/f2fs/super.c  |   1 +
 8 files changed, 203 insertions(+), 19 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 85a1528f319f2..2913483473f30 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -8,6 +8,7 @@
 #include <linux/fs.h>
 #include <linux/f2fs_fs.h>
 #include <linux/sched/signal.h>
+#include <linux/unicode.h>
 #include "f2fs.h"
 #include "node.h"
 #include "acl.h"
@@ -81,7 +82,8 @@ static unsigned long dir_block_index(unsigned int level,
 	return bidx;
 }
 
-static struct f2fs_dir_entry *find_in_block(struct page *dentry_page,
+static struct f2fs_dir_entry *find_in_block(struct inode *dir,
+				struct page *dentry_page,
 				struct fscrypt_name *fname,
 				f2fs_hash_t namehash,
 				int *max_slots,
@@ -93,7 +95,7 @@ static struct f2fs_dir_entry *find_in_block(struct page *dentry_page,
 
 	dentry_blk = (struct f2fs_dentry_block *)page_address(dentry_page);
 
-	make_dentry_ptr_block(NULL, &d, dentry_blk);
+	make_dentry_ptr_block(dir, &d, dentry_blk);
 	de = f2fs_find_target_dentry(fname, namehash, max_slots, &d);
 	if (de)
 		*res_page = dentry_page;
@@ -101,6 +103,39 @@ static struct f2fs_dir_entry *find_in_block(struct page *dentry_page,
 	return de;
 }
 
+#ifdef CONFIG_UNICODE
+/*
+ * Test whether a case-insensitive directory entry matches the filename
+ * being searched for.
+ *
+ * Returns: 0 if the directory entry matches, more than 0 if it
+ * doesn't match or less than zero on error.
+ */
+int f2fs_ci_compare(const struct inode *parent, const struct qstr *name,
+		    const struct qstr *entry)
+{
+	const struct f2fs_sb_info *sbi = F2FS_SB(parent->i_sb);
+	const struct unicode_map *um = sbi->s_encoding;
+	int ret;
+
+	ret = utf8_strncasecmp(um, name, entry);
+	if (ret < 0) {
+		/* Handle invalid character sequence as either an error
+		 * or as an opaque byte sequence.
+		 */
+		if (f2fs_has_strict_mode(sbi))
+			return -EINVAL;
+
+		if (name->len != entry->len)
+			return 1;
+
+		return !!memcmp(name->name, entry->name, name->len);
+	}
+
+	return ret;
+}
+#endif
+
 struct f2fs_dir_entry *f2fs_find_target_dentry(struct fscrypt_name *fname,
 			f2fs_hash_t namehash, int *max_slots,
 			struct f2fs_dentry_ptr *d)
@@ -108,6 +143,9 @@ struct f2fs_dir_entry *f2fs_find_target_dentry(struct fscrypt_name *fname,
 	struct f2fs_dir_entry *de;
 	unsigned long bit_pos = 0;
 	int max_len = 0;
+#ifdef CONFIG_UNICODE
+	struct qstr entry;
+#endif
 
 	if (max_slots)
 		*max_slots = 0;
@@ -119,16 +157,28 @@ struct f2fs_dir_entry *f2fs_find_target_dentry(struct fscrypt_name *fname,
 		}
 
 		de = &d->dentry[bit_pos];
+#ifdef CONFIG_UNICODE
+		entry.name = d->filename[bit_pos];
+		entry.len = de->name_len;
+#endif
 
 		if (unlikely(!de->name_len)) {
 			bit_pos++;
 			continue;
 		}
+		if (de->hash_code == namehash) {
+#ifdef CONFIG_UNICODE
+			if (F2FS_SB(d->inode->i_sb)->s_encoding &&
+					IS_CASEFOLDED(d->inode) &&
+					!f2fs_ci_compare(d->inode,
+						fname->usr_fname, &entry))
+				goto found;
 
-		if (de->hash_code == namehash &&
-		    fscrypt_match_name(fname, d->filename[bit_pos],
-				       le16_to_cpu(de->name_len)))
-			goto found;
+#endif
+			if (fscrypt_match_name(fname, d->filename[bit_pos],
+						le16_to_cpu(de->name_len)))
+				goto found;
+		}
 
 		if (max_slots && max_len > *max_slots)
 			*max_slots = max_len;
@@ -157,7 +207,7 @@ static struct f2fs_dir_entry *find_in_level(struct inode *dir,
 	struct f2fs_dir_entry *de = NULL;
 	bool room = false;
 	int max_slots;
-	f2fs_hash_t namehash = f2fs_dentry_hash(&name, fname);
+	f2fs_hash_t namehash = f2fs_dentry_hash(dir, &name, fname);
 
 	nbucket = dir_buckets(level, F2FS_I(dir)->i_dir_level);
 	nblock = bucket_blocks(level);
@@ -179,8 +229,8 @@ static struct f2fs_dir_entry *find_in_level(struct inode *dir,
 			}
 		}
 
-		de = find_in_block(dentry_page, fname, namehash, &max_slots,
-								res_page);
+		de = find_in_block(dir, dentry_page, fname, namehash,
+							&max_slots, res_page);
 		if (de)
 			break;
 
@@ -250,6 +300,14 @@ struct f2fs_dir_entry *f2fs_find_entry(struct inode *dir,
 	struct fscrypt_name fname;
 	int err;
 
+#ifdef CONFIG_UNICODE
+	if (f2fs_has_strict_mode(F2FS_I_SB(dir)) && IS_CASEFOLDED(dir) &&
+			utf8_validate(F2FS_I_SB(dir)->s_encoding, child)) {
+		*res_page = ERR_PTR(-EINVAL);
+		return NULL;
+	}
+#endif
+
 	err = fscrypt_setup_filename(dir, child, 1, &fname);
 	if (err) {
 		if (err == -ENOENT)
@@ -504,7 +562,7 @@ int f2fs_add_regular_entry(struct inode *dir, const struct qstr *new_name,
 
 	level = 0;
 	slots = GET_DENTRY_SLOTS(new_name->len);
-	dentry_hash = f2fs_dentry_hash(new_name, NULL);
+	dentry_hash = f2fs_dentry_hash(dir, new_name, NULL);
 
 	current_depth = F2FS_I(dir)->i_current_depth;
 	if (F2FS_I(dir)->chash == dentry_hash) {
@@ -943,3 +1001,51 @@ const struct file_operations f2fs_dir_operations = {
 	.compat_ioctl   = f2fs_compat_ioctl,
 #endif
 };
+
+#ifdef CONFIG_UNICODE
+static int f2fs_d_compare(const struct dentry *dentry, unsigned int len,
+			  const char *str, const struct qstr *name)
+{
+	struct qstr qstr = {.name = str, .len = len };
+
+	if (!IS_CASEFOLDED(dentry->d_parent->d_inode)) {
+		if (len != name->len)
+			return -1;
+		return memcmp(str, name, len);
+	}
+
+	return f2fs_ci_compare(dentry->d_parent->d_inode, name, &qstr);
+}
+
+static int f2fs_d_hash(const struct dentry *dentry, struct qstr *str)
+{
+	struct f2fs_sb_info *sbi = F2FS_SB(dentry->d_sb);
+	const struct unicode_map *um = sbi->s_encoding;
+	unsigned char *norm;
+	int len, ret = 0;
+
+	if (!IS_CASEFOLDED(dentry->d_inode))
+		return 0;
+
+	norm = f2fs_kmalloc(sbi, PATH_MAX, GFP_ATOMIC);
+	if (!norm)
+		return -ENOMEM;
+
+	len = utf8_casefold(um, str, norm, PATH_MAX);
+	if (len < 0) {
+		if (f2fs_has_strict_mode(sbi))
+			ret = -EINVAL;
+		goto out;
+	}
+	str->hash = full_name_hash(dentry, norm, len);
+out:
+	kvfree(norm);
+	return ret;
+}
+
+const struct dentry_operations f2fs_dentry_ops = {
+	.d_hash = f2fs_d_hash,
+	.d_compare = f2fs_d_compare,
+};
+#endif
+
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c6c7904572d0d..31fd2a268ba14 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2364,10 +2364,12 @@ static inline void f2fs_change_bit(unsigned int nr, char *addr)
 #define F2FS_INDEX_FL			0x00001000 /* hash-indexed directory */
 #define F2FS_DIRSYNC_FL			0x00010000 /* dirsync behaviour (directories only) */
 #define F2FS_PROJINHERIT_FL		0x20000000 /* Create with parents projid */
+#define F2FS_CASEFOLD_FL		0x40000000 /* Casefolded file */
 
 /* Flags that should be inherited by new inodes from their parent. */
 #define F2FS_FL_INHERITED (F2FS_SYNC_FL | F2FS_NODUMP_FL | F2FS_NOATIME_FL | \
-			   F2FS_DIRSYNC_FL | F2FS_PROJINHERIT_FL)
+			   F2FS_DIRSYNC_FL | F2FS_PROJINHERIT_FL | \
+			   F2FS_CASEFOLD_FL)
 
 /* Flags that are appropriate for regular files (all but dir-specific ones). */
 #define F2FS_REG_FLMASK		(~(F2FS_DIRSYNC_FL | F2FS_PROJINHERIT_FL))
@@ -2930,6 +2932,10 @@ int f2fs_update_extension_list(struct f2fs_sb_info *sbi, const char *name,
 							bool hot, bool set);
 struct dentry *f2fs_get_parent(struct dentry *child);
 
+extern int f2fs_ci_compare(const struct inode *parent,
+			   const struct qstr *name,
+			   const struct qstr *entry);
+
 /*
  * dir.c
  */
@@ -2993,8 +2999,8 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi);
 /*
  * hash.c
  */
-f2fs_hash_t f2fs_dentry_hash(const struct qstr *name_info,
-				struct fscrypt_name *fname);
+f2fs_hash_t f2fs_dentry_hash(const struct inode *dir,
+		const struct qstr *name_info, struct fscrypt_name *fname);
 
 /*
  * node.c
@@ -3437,6 +3443,9 @@ static inline void f2fs_destroy_root_stats(void) { }
 #endif
 
 extern const struct file_operations f2fs_dir_operations;
+#ifdef CONFIG_UNICODE
+extern const struct dentry_operations f2fs_dentry_ops;
+#endif
 extern const struct file_operations f2fs_file_operations;
 extern const struct inode_operations f2fs_file_inode_operations;
 extern const struct address_space_operations f2fs_dblock_aops;
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index f8d46df8fa9ee..7ab2e6fea5b82 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1660,7 +1660,16 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
 		return -EPERM;
 
 	oldflags = fi->i_flags;
+	if ((iflags ^ oldflags) & F2FS_CASEFOLD_FL) {
+		if (!f2fs_sb_has_casefold(F2FS_I_SB(inode)))
+			return -EOPNOTSUPP;
+
+		if (!S_ISDIR(inode->i_mode))
+			return -ENOTDIR;
 
+		if (!f2fs_empty_dir(inode))
+			return -ENOTEMPTY;
+	}
 	if ((iflags ^ oldflags) & (F2FS_APPEND_FL | F2FS_IMMUTABLE_FL))
 		if (!capable(CAP_LINUX_IMMUTABLE))
 			return -EPERM;
@@ -1699,6 +1708,7 @@ static const struct {
 	{ F2FS_INDEX_FL,	FS_INDEX_FL },
 	{ F2FS_DIRSYNC_FL,	FS_DIRSYNC_FL },
 	{ F2FS_PROJINHERIT_FL,	FS_PROJINHERIT_FL },
+	{ F2FS_CASEFOLD_FL,	FS_CASEFOLD_FL },
 };
 
 #define F2FS_GETTABLE_FS_FL (		\
@@ -1712,7 +1722,8 @@ static const struct {
 		FS_PROJINHERIT_FL |	\
 		FS_ENCRYPT_FL |		\
 		FS_INLINE_DATA_FL |	\
-		FS_NOCOW_FL)
+		FS_NOCOW_FL |		\
+		FS_CASEFOLD_FL)
 
 #define F2FS_SETTABLE_FS_FL (		\
 		FS_SYNC_FL |		\
@@ -1721,7 +1732,8 @@ static const struct {
 		FS_NODUMP_FL |		\
 		FS_NOATIME_FL |		\
 		FS_DIRSYNC_FL |		\
-		FS_PROJINHERIT_FL)
+		FS_PROJINHERIT_FL |	\
+		FS_CASEFOLD_FL)
 
 /* Convert f2fs on-disk i_flags to FS_IOC_{GET,SET}FLAGS flags */
 static inline u32 f2fs_iflags_to_fsflags(u32 iflags)
diff --git a/fs/f2fs/hash.c b/fs/f2fs/hash.c
index cc82f142f811f..99e79934f5088 100644
--- a/fs/f2fs/hash.c
+++ b/fs/f2fs/hash.c
@@ -14,6 +14,7 @@
 #include <linux/f2fs_fs.h>
 #include <linux/cryptohash.h>
 #include <linux/pagemap.h>
+#include <linux/unicode.h>
 
 #include "f2fs.h"
 
@@ -67,7 +68,7 @@ static void str2hashbuf(const unsigned char *msg, size_t len,
 		*buf++ = pad;
 }
 
-f2fs_hash_t f2fs_dentry_hash(const struct qstr *name_info,
+static f2fs_hash_t __f2fs_dentry_hash(const struct qstr *name_info,
 				struct fscrypt_name *fname)
 {
 	__u32 hash;
@@ -103,3 +104,35 @@ f2fs_hash_t f2fs_dentry_hash(const struct qstr *name_info,
 	f2fs_hash = cpu_to_le32(hash & ~F2FS_HASH_COL_BIT);
 	return f2fs_hash;
 }
+
+f2fs_hash_t f2fs_dentry_hash(const struct inode *dir,
+		const struct qstr *name_info, struct fscrypt_name *fname)
+{
+#ifdef CONFIG_UNICODE
+	struct f2fs_sb_info *sbi = F2FS_SB(dir->i_sb);
+	const struct unicode_map *um = sbi->s_encoding;
+	int r, dlen;
+	unsigned char *buff;
+	struct qstr *folded;
+
+	if (name_info->len && IS_CASEFOLDED(dir)) {
+		buff = f2fs_kzalloc(sbi, sizeof(char) * PATH_MAX, GFP_KERNEL);
+		if (!buff)
+			return -ENOMEM;
+
+		dlen = utf8_casefold(um, name_info, buff, PATH_MAX);
+		if (dlen < 0) {
+			kvfree(buff);
+			goto opaque_seq;
+		}
+		folded->name = buff;
+		folded->len = dlen;
+		r = __f2fs_dentry_hash(folded, fname);
+
+		kvfree(buff);
+		return r;
+	}
+opaque_seq:
+#endif
+	return __f2fs_dentry_hash(name_info, fname);
+}
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 3613efca8c00c..354f71cf9e6ba 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -320,7 +320,7 @@ struct f2fs_dir_entry *f2fs_find_in_inline_dir(struct inode *dir,
 		return NULL;
 	}
 
-	namehash = f2fs_dentry_hash(&name, fname);
+	namehash = f2fs_dentry_hash(dir, &name, fname);
 
 	inline_dentry = inline_data_addr(dir, ipage);
 
@@ -580,7 +580,7 @@ int f2fs_add_inline_entry(struct inode *dir, const struct qstr *new_name,
 
 	f2fs_wait_on_page_writeback(ipage, NODE, true, true);
 
-	name_hash = f2fs_dentry_hash(new_name, NULL);
+	name_hash = f2fs_dentry_hash(dir, new_name, NULL);
 	f2fs_update_dentry(ino, mode, &d, new_name, name_hash, bit_pos);
 
 	set_page_dirty(ipage);
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index a33d7a849b2df..9a1f0d6616577 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -46,9 +46,11 @@ void f2fs_set_inode_flags(struct inode *inode)
 		new_fl |= S_DIRSYNC;
 	if (file_is_encrypt(inode))
 		new_fl |= S_ENCRYPTED;
+	if (flags & F2FS_CASEFOLD_FL)
+		new_fl |= S_CASEFOLD;
 	inode_set_flags(inode, new_fl,
 			S_SYNC|S_APPEND|S_IMMUTABLE|S_NOATIME|S_DIRSYNC|
-			S_ENCRYPTED);
+			S_ENCRYPTED|S_CASEFOLD);
 }
 
 static void __get_inode_rdev(struct inode *inode, struct f2fs_inode *ri)
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index c5b99042e6f2b..727de2f8620f2 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -489,6 +489,17 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
 		goto out_iput;
 	}
 out_splice:
+#ifdef CONFIG_UNICODE
+	if (!inode && IS_CASEFOLDED(dir)) {
+		/* Eventually we want to call d_add_ci(dentry, NULL)
+		 * for negative dentries in the encoding case as
+		 * well.  For now, prevent the negative dentry
+		 * from being cached.
+		 */
+		trace_f2fs_lookup_end(dir, dentry, ino, err);
+		return NULL;
+	}
+#endif
 	new = d_splice_alias(inode, dentry);
 	err = PTR_ERR_OR_ZERO(new);
 	trace_f2fs_lookup_end(dir, dentry, ino, err);
@@ -537,6 +548,16 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
 		goto fail;
 	}
 	f2fs_delete_entry(de, page, dir, inode);
+#ifdef CONFIG_UNICODE
+	/* VFS negative dentries are incompatible with Encoding and
+	 * Case-insensitiveness. Eventually we'll want avoid
+	 * invalidating the dentries here, alongside with returning the
+	 * negative dentries at f2fs_lookup(), when it is  better
+	 * supported by the VFS for the CI case.
+	 */
+	if (IS_CASEFOLDED(dir))
+		d_invalidate(dentry);
+#endif
 	f2fs_unlock_op(sbi);
 
 	if (IS_DIRSYNC(dir))
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 068db78a1e03e..20bf5fc3c5333 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3108,6 +3108,7 @@ static int f2fs_setup_casefold(struct f2fs_sb_info *sbi)
 
 		sbi->s_encoding = encoding;
 		sbi->s_encoding_flags = encoding_flags;
+		sbi->sb->s_d_op = &f2fs_dentry_ops;
 	}
 #else
 	if (f2fs_sb_has_casefold(sbi)) {
-- 
2.22.0.657.g960e92d24f-goog

