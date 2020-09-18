Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA6B27022B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Sep 2020 18:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgIRQ3y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Sep 2020 12:29:54 -0400
Received: from relayfre-01.paragon-software.com ([176.12.100.13]:47988 "EHLO
        relayfre-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725955AbgIRQ3j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Sep 2020 12:29:39 -0400
X-Greylist: delayed 319 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Sep 2020 12:29:31 EDT
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id B6DF91F00;
        Fri, 18 Sep 2020 19:24:12 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1600446253;
        bh=AZZKY9avpcW8XtP0Wz1MmKY2cS7/lCeKjutJxrb6hOQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=CQSso7YpJiI34IxarkAEQ2V2nRTF+jhArTY9gVMdhc4U9wekA282d8zrS+52ZcbHa
         MtyfZ4mJdMrMs8Z7p+4Hjvnh8tUEG3ankCqRu2x137H8ZZygJ3V2Y0bbD7gnuJkvgN
         fdqyGxoFvQsNTb8MEvyoMPGZD4yMI7EqIvWQnr7I=
Received: from fsd-lkpg.ufsd.paragon-software.com (172.30.114.105) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 18 Sep 2020 19:24:11 +0300
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <linux-fsdevel@vger.kernel.org>
CC:     <viro@zeniv.linux.org.uk>, <linux-kernel@vger.kernel.org>,
        <pali@kernel.org>, <dsterba@suse.cz>, <aaptel@suse.com>,
        <willy@infradead.org>, <rdunlap@infradead.org>, <joe@perches.com>,
        <mark@harmstone.com>, <nborisov@suse.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH v6 04/10] fs/ntfs3: Add file operations and implementation
Date:   Fri, 18 Sep 2020 19:21:58 +0300
Message-ID: <20200918162204.3706029-5-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200918162204.3706029-1-almaz.alexandrovich@paragon-software.com>
References: <20200918162204.3706029-1-almaz.alexandrovich@paragon-software.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.30.114.105]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds file operations and implementation

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/dir.c     |  607 +++++++++++
 fs/ntfs3/file.c    | 1217 ++++++++++++++++++++++
 fs/ntfs3/frecord.c | 2388 ++++++++++++++++++++++++++++++++++++++++++++
 fs/ntfs3/namei.c   |  577 +++++++++++
 fs/ntfs3/record.c  |  612 ++++++++++++
 fs/ntfs3/run.c     | 1156 +++++++++++++++++++++
 6 files changed, 6557 insertions(+)
 create mode 100644 fs/ntfs3/dir.c
 create mode 100644 fs/ntfs3/file.c
 create mode 100644 fs/ntfs3/frecord.c
 create mode 100644 fs/ntfs3/namei.c
 create mode 100644 fs/ntfs3/record.c
 create mode 100644 fs/ntfs3/run.c

diff --git a/fs/ntfs3/dir.c b/fs/ntfs3/dir.c
new file mode 100644
index 000000000000..329758c9554d
--- /dev/null
+++ b/fs/ntfs3/dir.c
@@ -0,0 +1,607 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  linux/fs/ntfs3/dir.c
+ *
+ * Copyright (C) 2019-2020 Paragon Software GmbH, All rights reserved.
+ *
+ *  directory handling functions for ntfs-based filesystems
+ *
+ */
+#include <linux/blkdev.h>
+#include <linux/buffer_head.h>
+#include <linux/fs.h>
+#include <linux/iversion.h>
+#include <linux/nls.h>
+
+#include "debug.h"
+#include "ntfs.h"
+#include "ntfs_fs.h"
+
+/*
+ * Convert little endian utf16 to nls string
+ */
+int ntfs_utf16_to_nls(struct ntfs_sb_info *sbi, const struct le_str *uni,
+		      u8 *buf, int buf_len)
+{
+	int ret, uni_len;
+	const __le16 *ip;
+	u8 *op;
+	struct nls_table *nls = sbi->nls[0];
+
+	static_assert(sizeof(wchar_t) == sizeof(__le16));
+
+	if (!nls) {
+		/* utf16 -> utf8 */
+		ret = utf16s_to_utf8s((wchar_t *)uni->name, uni->len,
+				      UTF16_LITTLE_ENDIAN, buf, buf_len);
+		buf[ret] = '\0';
+		return ret;
+	}
+
+	ip = uni->name;
+	op = buf;
+	uni_len = uni->len;
+
+	while (uni_len--) {
+		u16 ec;
+		int charlen;
+
+		if (buf_len < NLS_MAX_CHARSET_SIZE) {
+			ntfs_warn(sbi->sb,
+				  "filename was truncated while converting.");
+			break;
+		}
+
+		ec = le16_to_cpu(*ip++);
+		charlen = nls->uni2char(ec, op, buf_len);
+
+		if (charlen > 0) {
+			op += charlen;
+			buf_len -= charlen;
+		} else {
+			*op++ = ':';
+			op = hex_byte_pack(op, ec >> 8);
+			op = hex_byte_pack(op, ec);
+			buf_len -= 5;
+		}
+	}
+
+	*op = '\0';
+	return op - buf;
+}
+
+#define PLANE_SIZE 0x00010000
+
+#define SURROGATE_PAIR 0x0000d800
+#define SURROGATE_LOW 0x00000400
+#define SURROGATE_BITS 0x000003ff
+
+static inline void put_utf16(wchar_t *s, unsigned c, enum utf16_endian endian)
+{
+	switch (endian) {
+	default:
+		*s = (wchar_t)c;
+		break;
+	case UTF16_LITTLE_ENDIAN:
+		*s = __cpu_to_le16(c);
+		break;
+	case UTF16_BIG_ENDIAN:
+		*s = __cpu_to_be16(c);
+		break;
+	}
+}
+
+/*
+ * modified version of 'utf8s_to_utf16s' allows to
+ * detect -ENAMETOOLONG without writing out of expected maximum
+ */
+static int _utf8s_to_utf16s(const u8 *s, int inlen, enum utf16_endian endian,
+			    wchar_t *pwcs, int maxout)
+{
+	u16 *op;
+	int size;
+	unicode_t u;
+
+	op = pwcs;
+	while (inlen > 0 && *s) {
+		if (*s & 0x80) {
+			size = utf8_to_utf32(s, inlen, &u);
+			if (size < 0)
+				return -EINVAL;
+			s += size;
+			inlen -= size;
+
+			if (u >= PLANE_SIZE) {
+				if (maxout < 2)
+					return -ENAMETOOLONG;
+				u -= PLANE_SIZE;
+				put_utf16(op++,
+					  SURROGATE_PAIR |
+						  ((u >> 10) & SURROGATE_BITS),
+					  endian);
+				put_utf16(op++,
+					  SURROGATE_PAIR | SURROGATE_LOW |
+						  (u & SURROGATE_BITS),
+					  endian);
+				maxout -= 2;
+			} else {
+				if (maxout < 1)
+					return -ENAMETOOLONG;
+
+				put_utf16(op++, u, endian);
+				maxout--;
+			}
+		} else {
+			if (maxout < 1)
+				return -ENAMETOOLONG;
+
+			put_utf16(op++, *s++, endian);
+			inlen--;
+			maxout--;
+		}
+	}
+	return op - pwcs;
+}
+
+/* helper for ntfs_nls_to_utf16 */
+static int _ntfs_nls_to_utf16(struct nls_table *nls, const u8 *name,
+			      u32 name_len, wchar_t *uname, u32 max_ulen,
+			      enum utf16_endian endian)
+{
+	int ret, slen;
+	const u8 *end;
+
+	if (!nls) {
+		/* utf8 -> utf16 */
+		return _utf8s_to_utf16s(name, name_len, endian, uname,
+					max_ulen);
+	}
+
+	ret = 0;
+
+	for (end = name + name_len; name < end; ret++, name += slen) {
+		if (ret >= max_ulen)
+			return -ENAMETOOLONG;
+
+		slen = nls->char2uni(name, end - name, uname + ret);
+		if (!slen)
+			return -EINVAL;
+		if (slen < 0)
+			return slen;
+	}
+
+#ifdef __BIG_ENDIAN
+	if (endian == UTF16_LITTLE_ENDIAN) {
+		int i = ret;
+
+		while (i--) {
+			__cpu_to_le16s(uname);
+			uname++;
+		}
+	}
+#else
+	if (endian == UTF16_BIG_ENDIAN) {
+		int i = ret;
+
+		while (i--) {
+			__cpu_to_be16s(uname);
+			uname++;
+		}
+	}
+#endif
+
+	return ret;
+}
+
+/*
+ * Convert input string to utf16
+ *
+ * name, name_len - input name
+ * uni, max_ulen - destination memory
+ * endian - endian of target utf16 string
+ *
+ * This function is called:
+ * - to create ntfs name
+ * - to create symlink
+ *
+ * returns utf16 string length or error (if negative)
+ */
+int ntfs_nls_to_utf16(struct ntfs_sb_info *sbi, const u8 *name, u32 name_len,
+		      struct cpu_str *uni, u32 max_ulen,
+		      enum utf16_endian endian)
+{
+	int ret;
+	struct nls_table *nls = sbi->nls[0];
+
+	static_assert(sizeof(wchar_t) == sizeof(u16));
+
+	/* use primary nls (may be NULL) */
+	ret = _ntfs_nls_to_utf16(nls, name, name_len, uni->name, max_ulen,
+				 endian);
+
+	if (ret == -ENAMETOOLONG)
+		return -ENAMETOOLONG;
+
+	if (ret > 0)
+		return uni->len = ret;
+
+	if (!sbi->nls[1]) {
+		ntfs_warn(sbi->sb, "%s failed to convert \"%.*s\" into utf16",
+			  nls ? nls->charset : "utf8", name_len, name);
+		return ret;
+	}
+
+	/* use alternative nls */
+	ret = _ntfs_nls_to_utf16(sbi->nls[1], name, name_len, uni->name,
+				 max_ulen, endian);
+
+	if (ret == -ENAMETOOLONG)
+		return -ENAMETOOLONG;
+
+	if (ret > 0) {
+		/*
+		 * primary nls failed but aternative nls ok
+		 * should we print something?
+		 */
+		return uni->len = ret;
+	}
+
+	ntfs_warn(sbi->sb, "%s and %s failed to convert \"%.*s\" into utf16",
+		  nls ? nls->charset : "utf8", sbi->nls[1]->charset, name_len,
+		  name);
+	return ret;
+}
+
+/* helper function */
+struct inode *dir_search_u(struct inode *dir, const struct cpu_str *uni,
+			   struct ntfs_fnd *fnd)
+{
+	int err = 0;
+	struct super_block *sb = dir->i_sb;
+	struct ntfs_sb_info *sbi = sb->s_fs_info;
+	struct ntfs_inode *ni = ntfs_i(dir);
+	struct NTFS_DE *e;
+	int diff;
+	struct inode *inode = NULL;
+	struct ntfs_fnd *fnd_a = NULL;
+
+	if (!fnd) {
+		fnd_a = fnd_get(&ni->dir);
+		if (!fnd_a) {
+			err = -ENOMEM;
+			goto out;
+		}
+		fnd = fnd_a;
+	}
+
+	err = indx_find(&ni->dir, ni, NULL, uni, 0, sbi, &diff, &e, fnd);
+
+	if (err)
+		goto out;
+
+	if (diff) {
+		err = -ENOENT;
+		goto out;
+	}
+
+	inode = ntfs_iget5(sb, &e->ref, uni);
+	if (!IS_ERR(inode) && is_bad_inode(inode)) {
+		iput(inode);
+		err = -EINVAL;
+	}
+out:
+	fnd_put(fnd_a);
+
+	return err == -ENOENT ? NULL : err ? ERR_PTR(err) : inode;
+}
+
+static inline int ntfs_filldir(struct ntfs_sb_info *sbi, struct ntfs_inode *ni,
+			       const struct NTFS_DE *e, u8 *name,
+			       struct dir_context *ctx)
+{
+	const struct ATTR_FILE_NAME *fname;
+	unsigned long ino;
+	int name_len;
+	u32 dt_type;
+
+	fname = Add2Ptr(e, sizeof(struct NTFS_DE));
+
+	if (fname->type == FILE_NAME_DOS)
+		return 0;
+
+	if (!mi_is_ref(&ni->mi, &fname->home))
+		return 0;
+
+	ino = ino_get(&e->ref);
+
+	if (ino == MFT_REC_ROOT)
+		return 0;
+
+	/* Skip meta files ( unless option to show metafiles is set ) */
+	if (!sbi->options.showmeta && ntfs_is_meta_file(sbi, ino))
+		return 0;
+
+	if (sbi->options.nohidden && (fname->dup.fa & FILE_ATTRIBUTE_HIDDEN))
+		return 0;
+
+	name_len = ntfs_utf16_to_nls(sbi, (struct le_str *)&fname->name_len,
+				     name, PATH_MAX);
+	if (name_len <= 0) {
+		ntfs_warn(sbi->sb, "failed to convert name for inode %lx.",
+			  ino);
+		return 0;
+	}
+
+	dt_type = (fname->dup.fa & FILE_ATTRIBUTE_DIRECTORY) ? DT_DIR : DT_REG;
+
+	return !dir_emit(ctx, (s8 *)name, name_len, ino, dt_type);
+}
+
+/*
+ * ntfs_read_hdr
+ *
+ * helper function 'ntfs_readdir'
+ */
+static int ntfs_read_hdr(struct ntfs_sb_info *sbi, struct ntfs_inode *ni,
+			 const struct INDEX_HDR *hdr, u64 vbo, u64 pos,
+			 u8 *name, struct dir_context *ctx)
+{
+	int err;
+	const struct NTFS_DE *e;
+	u32 e_size;
+	u32 end = le32_to_cpu(hdr->used);
+	u32 off = le32_to_cpu(hdr->de_off);
+
+	for (;; off += e_size) {
+		if (off + sizeof(struct NTFS_DE) > end)
+			return -1;
+
+		e = Add2Ptr(hdr, off);
+		e_size = le16_to_cpu(e->size);
+		if (e_size < sizeof(struct NTFS_DE) || off + e_size > end)
+			return -1;
+
+		if (de_is_last(e))
+			return 0;
+
+		/* Skip already enumerated*/
+		if (vbo + off < pos)
+			continue;
+
+		if (le16_to_cpu(e->key_size) < SIZEOF_ATTRIBUTE_FILENAME)
+			return -1;
+
+		ctx->pos = vbo + off;
+
+		/* Submit the name to the filldir callback. */
+		err = ntfs_filldir(sbi, ni, e, name, ctx);
+		if (err)
+			return err;
+	}
+}
+
+/*
+ * file_operations::iterate_shared
+ *
+ * Use non sorted enumeration.
+ * We have an example of broken volume where sorted enumeration
+ * counts each name twice
+ */
+static int ntfs_readdir(struct file *file, struct dir_context *ctx)
+{
+	const struct INDEX_ROOT *root;
+	u64 vbo;
+	size_t bit;
+	loff_t eod;
+	int err = 0;
+	struct inode *dir = file_inode(file);
+	struct ntfs_inode *ni = ntfs_i(dir);
+	struct super_block *sb = dir->i_sb;
+	struct ntfs_sb_info *sbi = sb->s_fs_info;
+	loff_t i_size = dir->i_size;
+	u32 pos = ctx->pos;
+	u8 *name = NULL;
+	struct indx_node *node = NULL;
+	u8 index_bits = ni->dir.index_bits;
+
+	/* name is a buffer of PATH_MAX length */
+	static_assert(NTFS_NAME_LEN * 4 < PATH_MAX);
+
+	if (ni->dir.changed) {
+		ni->dir.changed = false;
+		pos = 0;
+	}
+
+	eod = i_size + sbi->record_size;
+
+	if (pos >= eod)
+		return 0;
+
+	if (!dir_emit_dots(file, ctx))
+		return 0;
+
+	name = __getname();
+	if (!name)
+		return -ENOMEM;
+
+	ni_lock(ni);
+
+	root = indx_get_root(&ni->dir, ni, NULL, NULL);
+	if (!root) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	if (pos >= sbi->record_size) {
+		bit = (pos - sbi->record_size) >> index_bits;
+	} else {
+		err = ntfs_read_hdr(sbi, ni, &root->ihdr, 0, pos, name, ctx);
+		if (err)
+			goto out;
+		bit = 0;
+	}
+
+	if (!i_size) {
+		ctx->pos = eod;
+		goto out;
+	}
+
+	for (;;) {
+		vbo = (u64)bit << index_bits;
+		if (vbo >= i_size) {
+			ctx->pos = eod;
+			goto out;
+		}
+
+		err = indx_used_bit(&ni->dir, ni, &bit);
+		if (err)
+			goto out;
+
+		if (bit == MINUS_ONE_T) {
+			ctx->pos = eod;
+			goto out;
+		}
+
+		vbo = (u64)bit << index_bits;
+		if (vbo >= i_size) {
+			ntfs_inode_err(dir, "Looks like your dir is corrupt");
+			err = -EINVAL;
+			goto out;
+		}
+
+		err = indx_read(&ni->dir, ni, bit << ni->dir.idx2vbn_bits,
+				&node);
+		if (err)
+			goto out;
+
+		err = ntfs_read_hdr(sbi, ni, &node->index->ihdr,
+				    vbo + sbi->record_size, pos, name, ctx);
+		if (err)
+			goto out;
+
+		bit += 1;
+	}
+
+out:
+
+	__putname(name);
+	put_indx_node(node);
+
+	if (err == -ENOENT) {
+		err = 0;
+		ctx->pos = pos;
+	}
+
+	ni_unlock(ni);
+
+	return err;
+}
+
+static int ntfs_dir_count(struct inode *dir, bool *is_empty, size_t *dirs,
+			  size_t *files)
+{
+	int err = 0;
+	struct ntfs_inode *ni = ntfs_i(dir);
+	struct NTFS_DE *e = NULL;
+	struct INDEX_ROOT *root;
+	struct INDEX_HDR *hdr;
+	const struct ATTR_FILE_NAME *fname;
+	u32 e_size, off, end;
+	u64 vbo = 0;
+	size_t drs = 0, fles = 0, bit = 0;
+	loff_t i_size = ni->vfs_inode.i_size;
+	struct indx_node *node = NULL;
+	u8 index_bits = ni->dir.index_bits;
+
+	if (is_empty)
+		*is_empty = true;
+
+	root = indx_get_root(&ni->dir, ni, NULL, NULL);
+	if (!root)
+		return -EINVAL;
+
+	hdr = &root->ihdr;
+
+	for (;;) {
+		end = le32_to_cpu(hdr->used);
+		off = le32_to_cpu(hdr->de_off);
+
+		for (; off + sizeof(struct NTFS_DE) <= end; off += e_size) {
+			e = Add2Ptr(hdr, off);
+			e_size = le16_to_cpu(e->size);
+			if (e_size < sizeof(struct NTFS_DE) ||
+			    off + e_size > end)
+				break;
+
+			if (de_is_last(e))
+				break;
+
+			fname = de_get_fname(e);
+			if (!fname)
+				continue;
+
+			if (fname->type == FILE_NAME_DOS)
+				continue;
+
+			if (is_empty) {
+				*is_empty = false;
+				if (!dirs && !files)
+					goto out;
+			}
+
+			if (fname->dup.fa & FILE_ATTRIBUTE_DIRECTORY)
+				drs += 1;
+			else
+				fles += 1;
+		}
+
+		if (vbo >= i_size)
+			goto out;
+
+		err = indx_used_bit(&ni->dir, ni, &bit);
+		if (err)
+			goto out;
+
+		if (bit == MINUS_ONE_T)
+			goto out;
+
+		vbo = (u64)bit << index_bits;
+		if (vbo >= i_size)
+			goto out;
+
+		err = indx_read(&ni->dir, ni, bit << ni->dir.idx2vbn_bits,
+				&node);
+		if (err)
+			goto out;
+
+		hdr = &node->index->ihdr;
+		bit += 1;
+		vbo = (u64)bit << ni->dir.idx2vbn_bits;
+	}
+
+out:
+	put_indx_node(node);
+	if (dirs)
+		*dirs = drs;
+	if (files)
+		*files = fles;
+
+	return err;
+}
+
+bool dir_is_empty(struct inode *dir)
+{
+	bool is_empty = false;
+
+	ntfs_dir_count(dir, &is_empty, NULL, NULL);
+
+	return is_empty;
+}
+
+const struct file_operations ntfs_dir_operations = {
+	.llseek = generic_file_llseek,
+	.read = generic_read_dir,
+	.iterate = ntfs_readdir,
+	.fsync = ntfs_file_fsync,
+	.open = ntfs_file_open,
+};
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
new file mode 100644
index 000000000000..ed823e6ee7b7
--- /dev/null
+++ b/fs/ntfs3/file.c
@@ -0,0 +1,1217 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  linux/fs/ntfs3/file.c
+ *
+ * Copyright (C) 2019-2020 Paragon Software GmbH, All rights reserved.
+ *
+ *  regular file handling primitives for ntfs-based filesystems
+ */
+#include <linux/backing-dev.h>
+#include <linux/buffer_head.h>
+#include <linux/compat.h>
+#include <linux/falloc.h>
+#include <linux/fiemap.h>
+#include <linux/msdos_fs.h> /* FAT_IOCTL_XXX */
+#include <linux/nls.h>
+
+#include "debug.h"
+#include "ntfs.h"
+#include "ntfs_fs.h"
+
+static int ntfs_ioctl_fitrim(struct ntfs_sb_info *sbi, unsigned long arg)
+{
+	struct fstrim_range __user *user_range;
+	struct fstrim_range range;
+	struct request_queue *q = bdev_get_queue(sbi->sb->s_bdev);
+	int err;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (!blk_queue_discard(q))
+		return -EOPNOTSUPP;
+
+	user_range = (struct fstrim_range __user *)arg;
+	if (copy_from_user(&range, user_range, sizeof(range)))
+		return -EFAULT;
+
+	range.minlen = max_t(u32, range.minlen, q->limits.discard_granularity);
+
+	err = ntfs_trim_fs(sbi, &range);
+	if (err < 0)
+		return err;
+
+	if (copy_to_user(user_range, &range, sizeof(range)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static long ntfs_ioctl(struct file *filp, u32 cmd, unsigned long arg)
+{
+	struct inode *inode = file_inode(filp);
+	struct ntfs_sb_info *sbi = inode->i_sb->s_fs_info;
+	u32 __user *user_attr = (u32 __user *)arg;
+
+	switch (cmd) {
+	case FAT_IOCTL_GET_ATTRIBUTES:
+		return put_user(le32_to_cpu(ntfs_i(inode)->std_fa), user_attr);
+
+	case FAT_IOCTL_GET_VOLUME_ID:
+		return put_user(sbi->volume.ser_num, user_attr);
+
+	case FITRIM:
+		return ntfs_ioctl_fitrim(sbi, arg);
+	}
+	return -ENOTTY; /* Inappropriate ioctl for device */
+}
+
+#ifdef CONFIG_COMPAT
+static long ntfs_compat_ioctl(struct file *filp, u32 cmd, unsigned long arg)
+
+{
+	return ntfs_ioctl(filp, cmd, (unsigned long)compat_ptr(arg));
+}
+#endif
+
+/*
+ * inode_operations::getattr
+ */
+int ntfs_getattr(const struct path *path, struct kstat *stat, u32 request_mask,
+		 u32 flags)
+{
+	struct inode *inode = d_inode(path->dentry);
+	struct super_block *sb = inode->i_sb;
+	struct ntfs_sb_info *sbi = sb->s_fs_info;
+	struct ntfs_inode *ni = ntfs_i(inode);
+
+	if (is_compressed(ni))
+		stat->attributes |= STATX_ATTR_COMPRESSED;
+
+	if (is_encrypted(ni))
+		stat->attributes |= STATX_ATTR_ENCRYPTED;
+
+	stat->attributes_mask |= STATX_ATTR_COMPRESSED | STATX_ATTR_ENCRYPTED;
+
+	generic_fillattr(inode, stat);
+
+	stat->result_mask |= STATX_BTIME;
+	stat->btime = ni->i_crtime;
+	stat->blksize = sbi->cluster_size;
+	stat->blocks <<= sbi->cluster_bits - 9;
+
+	return 0;
+}
+
+static int ntfs_extend_initialized_size(struct file *file,
+					struct ntfs_inode *ni,
+					const loff_t valid,
+					const loff_t new_valid)
+{
+	struct inode *inode = &ni->vfs_inode;
+	struct address_space *mapping = inode->i_mapping;
+	struct ntfs_sb_info *sbi = inode->i_sb->s_fs_info;
+	loff_t pos = valid;
+	int err;
+
+	WARN_ON(is_compressed(ni));
+	WARN_ON(valid >= new_valid);
+
+	for (;;) {
+		u32 zerofrom, len;
+		struct page *page;
+		void *fsdata;
+		u8 bits;
+		CLST vcn, lcn, clen;
+
+		if (is_sparsed(ni)) {
+			bits = sbi->cluster_bits;
+			vcn = pos >> bits;
+
+			err = attr_data_get_block(ni, vcn, 0, &lcn, &clen,
+						  NULL);
+			if (err)
+				goto out;
+
+			if (lcn == SPARSE_LCN) {
+				loff_t vbo = (loff_t)vcn << bits;
+				loff_t to = vbo + ((loff_t)clen << bits);
+
+				if (to <= new_valid) {
+					ni->i_valid = to;
+					pos = to;
+					goto next;
+				}
+
+				if (vbo < pos) {
+					pos = vbo;
+				} else {
+					to = (new_valid >> bits) << bits;
+					if (pos < to) {
+						ni->i_valid = to;
+						pos = to;
+						goto next;
+					}
+				}
+			}
+		}
+
+		zerofrom = pos & (PAGE_SIZE - 1);
+		len = PAGE_SIZE - zerofrom;
+
+		if (pos + len > new_valid)
+			len = new_valid - pos;
+
+		err = pagecache_write_begin(file, mapping, pos, len, 0, &page,
+					    &fsdata);
+		if (err)
+			goto out;
+
+		zero_user_segment(page, zerofrom, PAGE_SIZE);
+
+		/* this function in any case puts page*/
+		err = pagecache_write_end(file, mapping, pos, len, len, page,
+					  fsdata);
+		if (err < 0)
+			goto out;
+		pos += len;
+
+next:
+		if (pos >= new_valid)
+			break;
+		balance_dirty_pages_ratelimited(mapping);
+	}
+
+	mark_inode_dirty(inode);
+
+	return 0;
+
+out:
+	ni->i_valid = valid;
+	ntfs_inode_warn(inode, "failed to extend initialized size to %llx.",
+			new_valid);
+	return err;
+}
+
+static int ntfs_extend_initialized_size_cmpr(struct file *file,
+					     struct ntfs_inode *ni,
+					     const loff_t valid,
+					     const loff_t new_valid)
+{
+	struct inode *inode = &ni->vfs_inode;
+	struct address_space *mapping = inode->i_mapping;
+	struct ntfs_sb_info *sbi = inode->i_sb->s_fs_info;
+	loff_t pos = valid;
+	u8 bits = NTFS_LZNT_CUNIT + sbi->cluster_bits;
+	int err;
+
+	WARN_ON(!is_compressed(ni));
+	WARN_ON(valid >= new_valid);
+
+	for (;;) {
+		u32 zerofrom, len;
+		struct page *page;
+		CLST frame, vcn, lcn, clen;
+
+		frame = pos >> bits;
+		vcn = frame << NTFS_LZNT_CUNIT;
+
+		err = attr_data_get_block(ni, vcn, 0, &lcn, &clen, NULL);
+		if (err)
+			goto out;
+
+		if (lcn == SPARSE_LCN) {
+			loff_t vbo = (loff_t)frame << bits;
+			loff_t to = vbo + ((u64)clen << sbi->cluster_bits);
+
+			if (to <= new_valid) {
+				ni->i_valid = to;
+				pos = to;
+				goto next;
+			}
+
+			if (vbo >= pos) {
+				to = (new_valid >> bits) << bits;
+				if (pos < to) {
+					ni->i_valid = to;
+					pos = to;
+					goto next;
+				}
+			}
+		}
+
+		zerofrom = pos & (PAGE_SIZE - 1);
+		len = PAGE_SIZE - zerofrom;
+
+		if (pos + len > new_valid)
+			len = new_valid - pos;
+again:
+		page = find_or_create_page(mapping, pos >> PAGE_SHIFT,
+					   mapping_gfp_constraint(mapping,
+								  ~__GFP_FS));
+
+		if (!page) {
+			err = -ENOMEM;
+			goto out;
+		}
+
+		if (zerofrom && !PageUptodate(page)) {
+			err = ntfs_readpage(NULL, page);
+			lock_page(page);
+			if (page->mapping != mapping) {
+				unlock_page(page);
+				put_page(page);
+				goto again;
+			}
+			if (!PageUptodate(page)) {
+				err = -EIO;
+				unlock_page(page);
+				put_page(page);
+				goto out;
+			}
+		}
+
+		wait_on_page_writeback(page);
+
+		zero_user_segment(page, zerofrom, PAGE_SIZE);
+		if (!zerofrom)
+			SetPageUptodate(page);
+
+		ClearPageChecked(page);
+		set_page_dirty(page);
+		unlock_page(page);
+		put_page(page);
+		pos += len;
+		ni->i_valid = pos;
+next:
+		if (pos >= new_valid)
+			break;
+		balance_dirty_pages_ratelimited(mapping);
+	}
+
+	mark_inode_dirty(inode);
+
+	return 0;
+
+out:
+	ni->i_valid = valid;
+	ntfs_inode_warn(inode,
+			"failed to extend initialized compressed size to %llx.",
+			new_valid);
+	return err;
+}
+
+/*
+ * ntfs_sparse_cluster
+ *
+ * Helper function to zero a new allocated clusters
+ */
+void ntfs_sparse_cluster(struct inode *inode, struct page *page0, loff_t vbo,
+			 u32 bytes)
+{
+	struct address_space *mapping = inode->i_mapping;
+	struct ntfs_sb_info *sbi = inode->i_sb->s_fs_info;
+	u32 blocksize = 1 << inode->i_blkbits;
+	pgoff_t idx0 = page0 ? page0->index : -1;
+	loff_t vbo_clst = vbo & sbi->cluster_mask_inv;
+	loff_t end = ntfs_up_cluster(sbi, vbo + bytes);
+	pgoff_t idx = vbo_clst >> PAGE_SHIFT;
+	u32 from = vbo_clst & (PAGE_SIZE - 1);
+	pgoff_t idx_end = (end + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	loff_t page_off;
+	u32 to;
+	bool partial;
+	struct page *page;
+
+	for (; idx < idx_end; idx += 1, from = 0) {
+		page = idx == idx0 ? page0 : grab_cache_page(mapping, idx);
+
+		if (!page)
+			continue;
+
+		page_off = (loff_t)idx << PAGE_SHIFT;
+		to = (page_off + PAGE_SIZE) > end ? (end - page_off) :
+						    PAGE_SIZE;
+		partial = false;
+
+		if ((from || PAGE_SIZE != to) &&
+		    likely(!page_has_buffers(page))) {
+			create_empty_buffers(page, blocksize, 0);
+			if (!page_has_buffers(page)) {
+				ntfs_inode_err(
+					inode,
+					"failed to allocate page buffers.");
+				/*err = -ENOMEM;*/
+				goto unlock_page;
+			}
+		}
+
+		if (page_has_buffers(page)) {
+			struct buffer_head *head, *bh;
+			u32 bh_off = 0;
+
+			bh = head = page_buffers(page);
+			do {
+				u32 bh_next = bh_off + blocksize;
+
+				if (from <= bh_off && bh_next <= to) {
+					set_buffer_uptodate(bh);
+					mark_buffer_dirty(bh);
+				} else if (!buffer_uptodate(bh)) {
+					partial = true;
+				}
+				bh_off = bh_next;
+			} while (head != (bh = bh->b_this_page));
+		}
+
+		zero_user_segment(page, from, to);
+
+		if (!partial) {
+			if (!PageUptodate(page))
+				SetPageUptodate(page);
+			set_page_dirty(page);
+		}
+
+unlock_page:
+		if (idx != idx0) {
+			unlock_page(page);
+			put_page(page);
+		}
+	}
+
+	mark_inode_dirty(inode);
+}
+
+struct ntfs_file_vm_ops {
+	atomic_t refcnt;
+	loff_t to;
+
+	const struct vm_operations_struct *base;
+	struct vm_operations_struct vm_ops;
+};
+
+/*
+ * vm_operations_struct::open
+ */
+static void ntfs_filemap_open(struct vm_area_struct *vma)
+{
+	struct ntfs_file_vm_ops *vm_ops;
+	const struct vm_operations_struct *base;
+
+	vm_ops = container_of(vma->vm_ops, struct ntfs_file_vm_ops, vm_ops);
+	base = vm_ops->base;
+
+	atomic_inc(&vm_ops->refcnt);
+
+	if (base->open)
+		base->open(vma);
+}
+
+/*
+ * vm_operations_struct::close
+ */
+static void ntfs_filemap_close(struct vm_area_struct *vma)
+{
+	struct ntfs_file_vm_ops *vm_ops;
+	const struct vm_operations_struct *base;
+	struct inode *inode;
+	struct ntfs_inode *ni;
+
+	vm_ops = container_of(vma->vm_ops, struct ntfs_file_vm_ops, vm_ops);
+
+	if (!atomic_dec_and_test(&vm_ops->refcnt))
+		return;
+
+	base = vm_ops->base;
+	if (vma->vm_flags & VM_WRITE) {
+		inode = file_inode(vma->vm_file);
+		ni = ntfs_i(inode);
+
+		// Update valid size
+		ni->i_valid =
+			max_t(loff_t, ni->i_valid,
+			      min_t(loff_t, i_size_read(inode), vm_ops->to));
+	}
+
+	if (base->close)
+		base->close(vma);
+
+	vma->vm_ops = base;
+	ntfs_free(vm_ops);
+}
+
+/*
+ * vm_operations_struct::fault
+ */
+static vm_fault_t ntfs_filemap_fault(struct vm_fault *vmf)
+{
+	vm_fault_t ret;
+	struct ntfs_file_vm_ops *vm_ops;
+	struct vm_area_struct *vma = vmf->vma;
+
+	vm_ops = container_of(vma->vm_ops, struct ntfs_file_vm_ops, vm_ops);
+
+	/* Call base function */
+	ret = vm_ops->base->fault(vmf);
+
+	if (VM_FAULT_LOCKED & ret) {
+		/* Update maximum mapped range */
+		loff_t to = (loff_t)(vmf->pgoff + 1) << PAGE_SHIFT;
+
+		if (vm_ops->to < to)
+			vm_ops->to = to;
+	}
+
+	return ret;
+}
+
+/*
+ * file_operations::mmap
+ */
+static int ntfs_file_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct inode *inode = file->f_mapping->host;
+	struct ntfs_inode *ni = ntfs_i(inode);
+	u64 to, from = ((u64)vma->vm_pgoff << PAGE_SHIFT);
+	bool rw = vma->vm_flags & VM_WRITE;
+	struct ntfs_file_vm_ops *vm_ops = NULL;
+	int err;
+
+	if (is_encrypted(ni)) {
+		err = -EOPNOTSUPP;
+		goto out;
+	}
+
+	if (!rw)
+		goto generic;
+
+	if (is_compressed(ni)) {
+		err = -EOPNOTSUPP;
+		goto out;
+	}
+
+	/*
+	 * Allocate and init small struct to keep track the mapping operations
+	 * It is useful when mmap(size) + truncate(size/2) + unmap(). see
+	 * xfstests/generic/039
+	 */
+	vm_ops = ntfs_alloc(sizeof(struct ntfs_file_vm_ops), 1);
+	if (unlikely(!vm_ops)) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	// map for write
+	inode_lock(inode);
+
+	to = from + vma->vm_end - vma->vm_start;
+
+	if (to > inode->i_size)
+		to = inode->i_size;
+
+	if (is_sparsed(ni)) {
+		/* allocate clusters for rw map */
+		struct ntfs_sb_info *sbi = inode->i_sb->s_fs_info;
+		CLST vcn, lcn, len;
+		CLST end = bytes_to_cluster(sbi, to);
+		bool new;
+
+		for (vcn = from >> sbi->cluster_bits; vcn < end; vcn += len) {
+			err = attr_data_get_block(ni, vcn, 1, &lcn, &len, &new);
+			if (err) {
+				inode_unlock(inode);
+				goto out;
+			}
+			if (!new)
+				continue;
+			ntfs_sparse_cluster(inode, NULL,
+					    (u64)vcn << sbi->cluster_bits,
+					    sbi->cluster_size);
+		}
+	}
+
+	err = ni->i_valid < to ?
+		      ntfs_extend_initialized_size(file, ni, ni->i_valid, to) :
+		      0;
+
+	inode_unlock(inode);
+	if (err)
+		goto out;
+
+generic:
+	err = generic_file_mmap(file, vma);
+	if (err)
+		goto out;
+
+	if (rw) {
+		atomic_set(&vm_ops->refcnt, 1);
+		vm_ops->to = to;
+		vm_ops->base = vma->vm_ops;
+		memcpy(&vm_ops->vm_ops, vma->vm_ops,
+		       sizeof(struct vm_operations_struct));
+		vm_ops->vm_ops.fault = &ntfs_filemap_fault;
+		vm_ops->vm_ops.open = &ntfs_filemap_open;
+		vm_ops->vm_ops.close = &ntfs_filemap_close;
+		vma->vm_ops = &vm_ops->vm_ops;
+	}
+
+out:
+	if (err)
+		ntfs_free(vm_ops);
+
+	return err;
+}
+
+/*
+ * file_operations::fsync
+ */
+int ntfs_file_fsync(struct file *filp, loff_t start, loff_t end, int datasync)
+{
+	return generic_file_fsync(filp, start, end, datasync);
+}
+
+static int ntfs_extend_ex(struct inode *inode, loff_t pos, size_t count,
+			  struct file *file)
+{
+	struct ntfs_inode *ni = ntfs_i(inode);
+	struct address_space *mapping = inode->i_mapping;
+	loff_t end = pos + count;
+	int err;
+	bool extend_init = file && pos > ni->i_valid;
+
+	if (end <= inode->i_size && !extend_init)
+		return 0;
+
+	/*mark rw ntfs as dirty. it will be cleared at umount*/
+	ntfs_set_state(ni->mi.sbi, NTFS_DIRTY_DIRTY);
+
+	if (end > inode->i_size) {
+		err = ntfs_set_size(inode, end);
+		if (err)
+			goto out;
+		inode->i_size = end;
+	}
+
+	if (extend_init) {
+		err = (is_compressed(ni) ? ntfs_extend_initialized_size_cmpr :
+					   ntfs_extend_initialized_size)(
+			file, ni, ni->i_valid, pos);
+		if (err)
+			goto out;
+	}
+
+	inode->i_ctime = inode->i_mtime = current_time(inode);
+	mark_inode_dirty(inode);
+
+	if (IS_SYNC(inode)) {
+		int err2;
+
+		err = filemap_fdatawrite_range(mapping, pos, end - 1);
+		err2 = sync_mapping_buffers(mapping);
+		if (!err)
+			err = err2;
+		err2 = write_inode_now(inode, 1);
+		if (!err)
+			err = err2;
+		if (!err)
+			err = filemap_fdatawait_range(mapping, pos, end - 1);
+	}
+
+out:
+	return err;
+}
+
+/*
+ * Preallocate space for a file. This implements ntfs's fallocate file
+ * operation, which gets called from sys_fallocate system call. User
+ * space requests 'len' bytes at 'vbo'. If FALLOC_FL_KEEP_SIZE is set
+ * we just allocate clusters without zeroing them out. Otherwise we
+ * allocate and zero out clusters via an expanding truncate.
+ */
+static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)
+{
+	struct inode *inode = file->f_mapping->host;
+	struct super_block *sb = inode->i_sb;
+	struct ntfs_sb_info *sbi = sb->s_fs_info;
+	struct ntfs_inode *ni = ntfs_i(inode);
+	loff_t i_size;
+	loff_t end;
+	int err;
+
+	/* No support for dir */
+	if (!S_ISREG(inode->i_mode))
+		return -EOPNOTSUPP;
+
+	/* Return error if mode is not supported */
+	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |
+		     FALLOC_FL_COLLAPSE_RANGE))
+		return -EOPNOTSUPP;
+
+	inode_lock(inode);
+	i_size = inode->i_size;
+
+	if (mode & FALLOC_FL_PUNCH_HOLE) {
+		if (!(mode & FALLOC_FL_KEEP_SIZE)) {
+			err = -EINVAL;
+			goto out;
+		}
+		/*TODO: add support*/
+		err = -EOPNOTSUPP;
+		goto out;
+	}
+
+	if (mode & FALLOC_FL_COLLAPSE_RANGE) {
+		if (mode & ~FALLOC_FL_COLLAPSE_RANGE) {
+			err = -EINVAL;
+			goto out;
+		}
+
+		/*TODO: add support*/
+		err = -EOPNOTSUPP;
+		goto out;
+	}
+
+	end = vbo + len;
+
+	ntfs_set_state(sbi, NTFS_DIRTY_DIRTY);
+
+	/*
+	 * normal file: allocate clusters, do not change 'valid' size
+	 */
+	err = ntfs_set_size(inode, max(end, i_size));
+	if (err)
+		goto out;
+
+	if (is_sparsed(ni) || is_compressed(ni)) {
+		CLST vcn = vbo >> sbi->cluster_bits;
+		CLST cend = bytes_to_cluster(sbi, end);
+		CLST lcn, clen;
+		bool new;
+
+		/*
+		 * allocate but not zero new clusters
+		 * this breaks security (one can read unused on-disk areas)
+		 * zeroing these clusters may be too long
+		 * may be we should check here for root rights?
+		 */
+		for (; vcn < cend; vcn += clen) {
+			err = attr_data_get_block(ni, vcn, cend - vcn, &lcn,
+						  &clen, &new);
+			if (err)
+				goto out;
+		}
+	}
+
+	if (mode & FALLOC_FL_KEEP_SIZE) {
+		ni_lock(ni);
+		/*true - keep preallocated*/
+		err = attr_set_size(ni, ATTR_DATA, NULL, 0, &ni->file.run,
+				    i_size, &ni->i_valid, true, NULL);
+		ni_unlock(ni);
+		if (err)
+			goto out;
+	}
+
+	inode->i_ctime = inode->i_mtime = current_time(inode);
+	mark_inode_dirty(inode);
+
+out:
+	if (err == -EFBIG)
+		err = -ENOSPC;
+
+	inode_unlock(inode);
+	return err;
+}
+
+void ntfs_truncate_blocks(struct inode *inode, loff_t new_size)
+{
+	struct super_block *sb = inode->i_sb;
+	struct ntfs_sb_info *sbi = sb->s_fs_info;
+	struct ntfs_inode *ni = ntfs_i(inode);
+	int err, dirty = 0;
+	u32 vcn;
+	u64 new_valid;
+
+	if (!S_ISREG(inode->i_mode))
+		return;
+
+	vcn = bytes_to_cluster(sbi, new_size);
+	new_valid = ntfs_up_block(sb, min(ni->i_valid, new_size));
+
+	ni_lock(ni);
+
+	truncate_setsize(inode, new_size);
+
+	if (new_valid < ni->i_valid)
+		ni->i_valid = new_valid;
+
+	ni_unlock(ni);
+
+	ni->std_fa |= FILE_ATTRIBUTE_ARCHIVE;
+	inode->i_ctime = inode->i_mtime = current_time(inode);
+	if (!IS_DIRSYNC(inode)) {
+		dirty = 1;
+	} else {
+		err = ntfs_sync_inode(inode);
+		if (err)
+			return;
+	}
+
+	inode->i_blocks = vcn;
+
+	if (dirty)
+		mark_inode_dirty(inode);
+
+	/*ntfs_flush_inodes(inode->i_sb, inode, NULL);*/
+}
+
+/*
+ * inode_operations::setattr
+ */
+int ntfs_setattr(struct dentry *dentry, struct iattr *attr)
+{
+	struct super_block *sb = dentry->d_sb;
+	struct ntfs_sb_info *sbi = sb->s_fs_info;
+	struct inode *inode = d_inode(dentry);
+	struct ntfs_inode *ni = ntfs_i(inode);
+	u32 ia_valid = attr->ia_valid;
+	umode_t mode = inode->i_mode;
+	int err;
+
+	if (sbi->options.no_acs_rules) {
+		/* "no access rules" - force any changes of time etc. */
+		attr->ia_valid |= ATTR_FORCE;
+		/* and disable for editing some attributes */
+		attr->ia_valid &= ~(ATTR_UID | ATTR_GID | ATTR_MODE);
+		ia_valid = attr->ia_valid;
+	}
+
+	err = setattr_prepare(dentry, attr);
+	if (err)
+		goto out;
+
+	if (ia_valid & ATTR_SIZE) {
+		loff_t oldsize = inode->i_size;
+
+		inode_dio_wait(inode);
+
+		if (attr->ia_size < oldsize) {
+			err = block_truncate_page(inode->i_mapping,
+						  attr->ia_size,
+						  ntfs_get_block);
+			if (err)
+				goto out;
+			ntfs_truncate_blocks(inode, attr->ia_size);
+		} else if (attr->ia_size > oldsize) {
+			err = ntfs_extend_ex(inode, attr->ia_size, 0, NULL);
+			if (err)
+				goto out;
+		}
+
+		ni->ni_flags |= NI_FLAG_UPDATE_PARENT;
+	}
+
+	setattr_copy(inode, attr);
+
+	if (mode != inode->i_mode) {
+		err = ntfs_acl_chmod(inode);
+		if (err)
+			goto out;
+
+		/* linux 'w' -> windows 'ro' */
+		if (0222 & inode->i_mode)
+			ni->std_fa &= ~FILE_ATTRIBUTE_READONLY;
+		else
+			ni->std_fa |= FILE_ATTRIBUTE_READONLY;
+	}
+
+	mark_inode_dirty(inode);
+out:
+
+	return err;
+}
+
+static ssize_t ntfs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
+{
+	ssize_t err;
+	size_t count = iov_iter_count(iter);
+	struct file *file = iocb->ki_filp;
+	struct inode *inode = file->f_mapping->host;
+	struct ntfs_inode *ni = ntfs_i(inode);
+
+	if (is_encrypted(ni)) {
+		ntfs_inode_warn(inode, "encrypted i/o not supported");
+		return -EOPNOTSUPP;
+	}
+
+	if (is_compressed(ni) && (iocb->ki_flags & IOCB_DIRECT)) {
+		ntfs_inode_warn(inode, "direct i/o + compressed not supported");
+		return -EOPNOTSUPP;
+	}
+
+	if (ni->ni_flags & NI_FLAG_COMPRESSED_MASK) {
+		ntfs_inode_warn(
+			inode,
+			"read external compressed file not supported (temporary)");
+		return -EOPNOTSUPP;
+	}
+
+	if (is_dedup(ni)) {
+		ntfs_inode_warn(inode, "read deduplicated not supported");
+		return -EOPNOTSUPP;
+	}
+
+	err = count ? generic_file_read_iter(iocb, iter) : 0;
+
+	return err;
+}
+
+/*
+ * on error we return an unlocked page and the error value
+ * on success we return a locked page and 0
+ */
+static int prepare_uptodate_page(struct inode *inode, struct page *page,
+				 u64 pos, bool force_uptodate)
+{
+	int err = 0;
+
+	if (((pos & (PAGE_SIZE - 1)) || force_uptodate) &&
+	    !PageUptodate(page)) {
+		err = ntfs_readpage(NULL, page);
+		if (err)
+			return err;
+		lock_page(page);
+		if (!PageUptodate(page)) {
+			unlock_page(page);
+			return -EIO;
+		}
+		if (page->mapping != inode->i_mapping) {
+			unlock_page(page);
+			return -EAGAIN;
+		}
+	}
+	return 0;
+}
+
+/*helper for ntfs_file_write_iter (compressed files)*/
+static noinline ssize_t ntfs_compress_write(struct kiocb *iocb,
+					    struct iov_iter *from)
+{
+	int err;
+	struct file *file = iocb->ki_filp;
+	size_t count = iov_iter_count(from);
+	loff_t pos = iocb->ki_pos;
+	loff_t end = pos + count;
+	struct inode *inode = file_inode(file);
+	struct address_space *mapping = inode->i_mapping;
+	struct ntfs_inode *ni = ntfs_i(inode);
+	struct page *page, **pages = NULL;
+	size_t ip, max_pages, written = 0;
+	bool force_uptodate = false;
+	pgoff_t from_idx, end_idx;
+	u32 off;
+	gfp_t mask = mapping_gfp_constraint(mapping, ~__GFP_FS) | __GFP_WRITE;
+
+	from_idx = pos >> PAGE_SHIFT;
+	end_idx = (end + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	max_pages = end_idx - from_idx;
+	if (max_pages > 16)
+		max_pages = 16;
+	WARN_ON(end_idx <= from_idx);
+
+	pages = ntfs_alloc(max_pages * sizeof(struct page *), 1);
+	if (!pages)
+		return -ENOMEM;
+
+	current->backing_dev_info = inode_to_bdi(inode);
+	err = file_remove_privs(file);
+	if (err)
+		goto out;
+
+	err = file_update_time(file);
+	if (err)
+		goto out;
+
+	while (count) {
+		pgoff_t index = pos >> PAGE_SHIFT;
+		size_t offset = offset_in_page(pos);
+		size_t bytes = max_pages * PAGE_SIZE - offset;
+		size_t wpages, copied;
+
+		if (bytes > count)
+			bytes = count;
+
+		wpages = (offset + bytes + PAGE_SIZE - 1) >> PAGE_SHIFT;
+
+		WARN_ON(wpages > max_pages);
+
+		if (unlikely(iov_iter_fault_in_readable(from, bytes))) {
+			err = -EFAULT;
+			goto out;
+		}
+
+		for (ip = 0; ip < wpages; ip++) {
+again:
+			page = find_or_create_page(mapping, index + ip, mask);
+			if (!page) {
+				err = -ENOMEM;
+fail:
+				while (ip--) {
+					page = pages[ip];
+					unlock_page(page);
+					put_page(page);
+				}
+
+				goto out;
+			}
+
+			pages[ip] = page;
+
+			if (!ip)
+				err = prepare_uptodate_page(inode, page, pos,
+							    force_uptodate);
+
+			if (!err && ip == wpages - 1)
+				err = prepare_uptodate_page(inode, page,
+							    pos + bytes, false);
+
+			if (err) {
+				put_page(page);
+				if (err == -EAGAIN) {
+					err = 0;
+					goto again;
+				}
+				goto fail;
+			}
+			wait_on_page_writeback(page);
+		}
+
+		WARN_ON(!bytes);
+		copied = 0;
+		ip = 0;
+		off = offset_in_page(pos);
+
+		for (;;) {
+			size_t tail = PAGE_SIZE - off;
+			size_t count = min(tail, bytes);
+			size_t cp;
+
+			page = pages[ip];
+
+			cp = iov_iter_copy_from_user_atomic(page, from, off,
+							    count);
+
+			flush_dcache_page(page);
+
+			if (!PageUptodate(page) && cp < count)
+				cp = 0;
+
+			iov_iter_advance(from, cp);
+			copied += cp;
+			bytes -= cp;
+			if (!bytes || !cp)
+				break;
+
+			if (cp < tail) {
+				off += cp;
+			} else {
+				ip++;
+				off = 0;
+			}
+		}
+
+		if (!copied) {
+			force_uptodate = true;
+		} else {
+			size_t dpages;
+
+			force_uptodate = false;
+			dpages =
+				(offset + copied + PAGE_SIZE - 1) >> PAGE_SHIFT;
+
+			for (ip = 0; ip < dpages; ip++) {
+				page = pages[ip];
+				SetPageUptodate(page);
+				ClearPageChecked(page);
+				set_page_dirty(page);
+			}
+		}
+
+		for (ip = 0; ip < wpages; ip++) {
+			page = pages[ip];
+			ClearPageChecked(page);
+			unlock_page(page);
+			put_page(page);
+		}
+
+		cond_resched();
+
+		balance_dirty_pages_ratelimited(mapping);
+
+		pos += copied;
+		written += copied;
+
+		count = iov_iter_count(from);
+	}
+
+out:
+	ntfs_free(pages);
+
+	current->backing_dev_info = NULL;
+
+	if (err < 0)
+		return err;
+
+	iocb->ki_pos += written;
+	if (iocb->ki_pos > ni->i_valid)
+		ni->i_valid = iocb->ki_pos;
+
+	return written;
+}
+
+/*
+ * file_operations::write_iter
+ */
+static ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
+{
+	struct file *file = iocb->ki_filp;
+	struct address_space *mapping = file->f_mapping;
+	struct inode *inode = mapping->host;
+	ssize_t ret;
+	struct ntfs_inode *ni = ntfs_i(inode);
+
+	if (is_encrypted(ni)) {
+		ntfs_inode_warn(inode, "encrypted i/o not supported");
+		return -EOPNOTSUPP;
+	}
+
+	if (is_compressed(ni) && (iocb->ki_flags & IOCB_DIRECT)) {
+		ntfs_inode_warn(inode, "direct i/o + compressed not supported");
+		return -EOPNOTSUPP;
+	}
+
+	if (ni->ni_flags & NI_FLAG_COMPRESSED_MASK) {
+		ntfs_inode_warn(
+			inode,
+			"write into external compressed file not supported (temporary)");
+		return -EOPNOTSUPP;
+	}
+
+	if (is_dedup(ni)) {
+		ntfs_inode_warn(inode, "write into deduplicated not supported");
+		return -EOPNOTSUPP;
+	}
+
+	if (!inode_trylock(inode)) {
+		if (iocb->ki_flags & IOCB_NOWAIT)
+			return -EAGAIN;
+		inode_lock(inode);
+	}
+
+	ret = generic_write_checks(iocb, from);
+	if (ret <= 0)
+		goto out;
+
+	ret = ntfs_extend_ex(inode, iocb->ki_pos, ret, file);
+	if (ret)
+		goto out;
+
+	ret = is_compressed(ni) ? ntfs_compress_write(iocb, from) :
+				  __generic_file_write_iter(iocb, from);
+
+out:
+	inode_unlock(inode);
+
+	if (ret > 0)
+		ret = generic_write_sync(iocb, ret);
+
+	return ret;
+}
+
+/*
+ * file_operations::open
+ */
+int ntfs_file_open(struct inode *inode, struct file *file)
+{
+	struct ntfs_inode *ni = ntfs_i(inode);
+
+	if (unlikely((is_compressed(ni) || is_encrypted(ni)) &&
+		     (file->f_flags & O_DIRECT))) {
+		return -ENOTBLK;
+	}
+
+	return generic_file_open(inode, file);
+}
+
+/*
+ * file_operations::release
+ */
+static int ntfs_file_release(struct inode *inode, struct file *file)
+{
+	struct ntfs_inode *ni = ntfs_i(inode);
+	struct ntfs_sb_info *sbi;
+	int err;
+
+	/* if we are the last writer on the inode, drop the block reservation */
+	if (!(file->f_mode & FMODE_WRITE) ||
+	    atomic_read(&inode->i_writecount) != 1)
+		return 0;
+
+	sbi = ni->mi.sbi;
+
+	ni_lock(ni);
+	down_write(&ni->file.run_lock);
+
+	err = attr_set_size(ni, ATTR_DATA, NULL, 0, &ni->file.run,
+			    inode->i_size, &ni->i_valid, false, NULL);
+	up_write(&ni->file.run_lock);
+	ni_unlock(ni);
+
+	return err;
+}
+
+/* file_operations::fiemap */
+int ntfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
+		__u64 start, __u64 len)
+{
+	int err;
+	struct ntfs_inode *ni = ntfs_i(inode);
+
+	if (fieinfo->fi_flags & FIEMAP_FLAG_XATTR)
+		return -EOPNOTSUPP;
+
+	ni_lock(ni);
+
+	err = ni_fiemap(ni, fieinfo, start, len);
+
+	ni_unlock(ni);
+
+	return err;
+}
+
+const struct inode_operations ntfs_file_inode_operations = {
+	.getattr = ntfs_getattr,
+	.setattr = ntfs_setattr,
+	.listxattr = ntfs_listxattr,
+	.permission = ntfs_permission,
+	.get_acl = ntfs_get_acl,
+	.set_acl = ntfs_set_acl,
+	.fiemap = ntfs_fiemap,
+};
+
+const struct file_operations ntfs_file_operations = {
+	.llseek = generic_file_llseek,
+	.read_iter = ntfs_file_read_iter,
+	.write_iter = ntfs_file_write_iter,
+	.unlocked_ioctl = ntfs_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl = ntfs_compat_ioctl,
+#endif
+	.splice_read = generic_file_splice_read,
+	.mmap = ntfs_file_mmap,
+	.open = ntfs_file_open,
+	.fsync = ntfs_file_fsync,
+	.splice_write = iter_file_splice_write,
+	.fallocate = ntfs_fallocate,
+	.release = ntfs_file_release,
+};
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
new file mode 100644
index 000000000000..4ef2ead733ce
--- /dev/null
+++ b/fs/ntfs3/frecord.c
@@ -0,0 +1,2388 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  linux/fs/ntfs3/frecord.c
+ *
+ * Copyright (C) 2019-2020 Paragon Software GmbH, All rights reserved.
+ *
+ */
+
+#include <linux/blkdev.h>
+#include <linux/buffer_head.h>
+#include <linux/fiemap.h>
+#include <linux/fs.h>
+#include <linux/nls.h>
+#include <linux/sched/signal.h>
+
+#include "debug.h"
+#include "ntfs.h"
+#include "ntfs_fs.h"
+
+static inline void get_mi_ref(const struct mft_inode *mi, struct MFT_REF *ref)
+{
+#ifdef NTFS3_64BIT_CLUSTER
+	ref->low = cpu_to_le32(mi->rno);
+	ref->high = cpu_to_le16(mi->rno >> 32);
+#else
+	ref->low = cpu_to_le32(mi->rno);
+	ref->high = 0;
+#endif
+	ref->seq = mi->mrec->seq;
+}
+
+static struct mft_inode *ni_ins_mi(struct ntfs_inode *ni, struct rb_root *tree,
+				   CLST ino, struct rb_node *ins)
+{
+	struct rb_node **p = &tree->rb_node;
+	struct rb_node *pr = NULL;
+
+	while (*p) {
+		struct mft_inode *mi;
+
+		pr = *p;
+		mi = rb_entry(pr, struct mft_inode, node);
+		if (mi->rno > ino)
+			p = &pr->rb_left;
+		else if (mi->rno < ino)
+			p = &pr->rb_right;
+		else
+			return mi;
+	}
+
+	if (!ins)
+		return NULL;
+
+	rb_link_node(ins, pr, p);
+	rb_insert_color(ins, tree);
+	return rb_entry(ins, struct mft_inode, node);
+}
+
+/*
+ * ni_find_mi
+ *
+ * finds mft_inode by record number
+ */
+static struct mft_inode *ni_find_mi(struct ntfs_inode *ni, CLST rno)
+{
+	return ni_ins_mi(ni, &ni->mi_tree, rno, NULL);
+}
+
+/*
+ * ni_add_mi
+ *
+ * adds new mft_inode into ntfs_inode
+ */
+static void ni_add_mi(struct ntfs_inode *ni, struct mft_inode *mi)
+{
+	ni_ins_mi(ni, &ni->mi_tree, mi->rno, &mi->node);
+}
+
+/*
+ * ni_remove_mi
+ *
+ * removes mft_inode from ntfs_inode
+ */
+void ni_remove_mi(struct ntfs_inode *ni, struct mft_inode *mi)
+{
+	rb_erase(&mi->node, &ni->mi_tree);
+}
+
+/*
+ * ni_std
+ *
+ * returns pointer into std_info from primary record
+ */
+struct ATTR_STD_INFO *ni_std(struct ntfs_inode *ni)
+{
+	const struct ATTRIB *attr;
+
+	attr = mi_find_attr(&ni->mi, NULL, ATTR_STD, NULL, 0, NULL);
+	return attr ? resident_data_ex(attr, sizeof(struct ATTR_STD_INFO)) :
+		      NULL;
+}
+
+/*
+ * ni_std5
+ *
+ * returns pointer into std_info from primary record
+ */
+struct ATTR_STD_INFO5 *ni_std5(struct ntfs_inode *ni)
+{
+	const struct ATTRIB *attr;
+
+	attr = mi_find_attr(&ni->mi, NULL, ATTR_STD, NULL, 0, NULL);
+
+	return attr ? resident_data_ex(attr, sizeof(struct ATTR_STD_INFO5)) :
+		      NULL;
+}
+
+/*
+ * ni_clear
+ *
+ * clears resources allocated by ntfs_inode
+ */
+void ni_clear(struct ntfs_inode *ni)
+{
+	struct rb_node *node;
+
+	if (!ni->vfs_inode.i_nlink && is_rec_inuse(ni->mi.mrec))
+		ni_delete_all(ni);
+
+	al_destroy(ni);
+
+	for (node = rb_first(&ni->mi_tree); node;) {
+		struct rb_node *next = rb_next(node);
+		struct mft_inode *mi = rb_entry(node, struct mft_inode, node);
+
+		rb_erase(node, &ni->mi_tree);
+		mi_put(mi);
+		node = next;
+	}
+
+	/* bad inode always has mode == S_IFREG */
+	if (ni->ni_flags & NI_FLAG_DIR)
+		indx_clear(&ni->dir);
+	else
+		run_close(&ni->file.run);
+
+	mi_clear(&ni->mi);
+}
+
+/*
+ * ni_load_mi_ex
+ *
+ * finds mft_inode by record number.
+ */
+int ni_load_mi_ex(struct ntfs_inode *ni, CLST rno, struct mft_inode **mi)
+{
+	int err;
+	struct mft_inode *r;
+
+	r = ni_find_mi(ni, rno);
+	if (r)
+		goto out;
+
+	err = mi_get(ni->mi.sbi, rno, &r);
+	if (err)
+		return err;
+
+	ni_add_mi(ni, r);
+
+out:
+	if (mi)
+		*mi = r;
+	return 0;
+}
+
+/*
+ * ni_load_mi
+ *
+ * load mft_inode corresponded list_entry
+ */
+int ni_load_mi(struct ntfs_inode *ni, struct ATTR_LIST_ENTRY *le,
+	       struct mft_inode **mi)
+{
+	CLST rno;
+
+	if (!le) {
+		*mi = &ni->mi;
+		return 0;
+	}
+
+	rno = ino_get(&le->ref);
+	if (rno == ni->mi.rno) {
+		*mi = &ni->mi;
+		return 0;
+	}
+	return ni_load_mi_ex(ni, rno, mi);
+}
+
+/*
+ * ni_find_attr
+ *
+ * returns attribute and record this attribute belongs to
+ */
+struct ATTRIB *ni_find_attr(struct ntfs_inode *ni, struct ATTRIB *attr,
+			    struct ATTR_LIST_ENTRY **le_o, enum ATTR_TYPE type,
+			    const __le16 *name, u8 name_len, const CLST *vcn,
+			    struct mft_inode **mi)
+{
+	struct ATTR_LIST_ENTRY *le;
+	struct mft_inode *m;
+
+	if (!ni->attr_list.size ||
+	    (!name_len && (type == ATTR_LIST || type == ATTR_STD))) {
+		if (le_o)
+			*le_o = NULL;
+		if (mi)
+			*mi = &ni->mi;
+
+		/* Look for required attribute in primary record */
+		return mi_find_attr(&ni->mi, attr, type, name, name_len, NULL);
+	}
+
+	/* first look for list entry of required type */
+	le = al_find_ex(ni, le_o ? *le_o : NULL, type, name, name_len, vcn);
+	if (!le)
+		return NULL;
+
+	if (le_o)
+		*le_o = le;
+
+	/* Load record that contains this attribute */
+	if (ni_load_mi(ni, le, &m))
+		return NULL;
+
+	/* Look for required attribute */
+	attr = mi_find_attr(m, NULL, type, name, name_len, &le->id);
+
+	if (!attr)
+		goto out;
+
+	if (!attr->non_res) {
+		if (vcn && *vcn)
+			goto out;
+	} else if (!vcn) {
+		if (attr->nres.svcn)
+			goto out;
+	} else if (le64_to_cpu(attr->nres.svcn) > *vcn ||
+		   *vcn > le64_to_cpu(attr->nres.evcn)) {
+		goto out;
+	}
+
+	if (mi)
+		*mi = m;
+	return attr;
+
+out:
+	ntfs_set_state(ni->mi.sbi, NTFS_DIRTY_ERROR);
+	return NULL;
+}
+
+/*
+ * ni_enum_attr_ex
+ *
+ * enumerates attributes in ntfs_inode
+ */
+struct ATTRIB *ni_enum_attr_ex(struct ntfs_inode *ni, struct ATTRIB *attr,
+			       struct ATTR_LIST_ENTRY **le)
+{
+	struct mft_inode *mi;
+	struct ATTR_LIST_ENTRY *le2;
+
+	/* Do we have an attribute list? */
+	if (!ni->attr_list.size) {
+		*le = NULL;
+		/* Enum attributes in primary record */
+		return mi_enum_attr(&ni->mi, attr);
+	}
+
+	/* get next list entry */
+	le2 = *le = al_enumerate(ni, attr ? *le : NULL);
+	if (!le2)
+		return NULL;
+
+	/* Load record that contains the required attribute */
+	if (ni_load_mi(ni, le2, &mi))
+		return NULL;
+
+	/* Find attribute in loaded record */
+	attr = rec_find_attr_le(mi, le2);
+	return attr;
+}
+
+/*
+ * ni_load_attr
+ *
+ * loads attribute that contains given vcn
+ */
+struct ATTRIB *ni_load_attr(struct ntfs_inode *ni, enum ATTR_TYPE type,
+			    const __le16 *name, u8 name_len, CLST vcn,
+			    struct mft_inode **pmi)
+{
+	struct ATTR_LIST_ENTRY *le;
+	struct ATTRIB *attr;
+	struct mft_inode *mi;
+	struct ATTR_LIST_ENTRY *next;
+
+	if (!ni->attr_list.size) {
+		if (pmi)
+			*pmi = &ni->mi;
+		return mi_find_attr(&ni->mi, NULL, type, name, name_len, NULL);
+	}
+
+	le = al_find_ex(ni, NULL, type, name, name_len, NULL);
+	if (!le)
+		return NULL;
+
+	/*
+	 * Unfortunately ATTR_LIST_ENTRY contains only start vcn
+	 * So to find the ATTRIB segment that contains 'vcn' we should
+	 * enumerate some entries
+	 */
+	if (vcn) {
+		for (;; le = next) {
+			next = al_find_ex(ni, le, type, name, name_len, NULL);
+			if (!next || le64_to_cpu(next->vcn) > vcn)
+				break;
+		}
+	}
+
+	if (ni_load_mi(ni, le, &mi))
+		return NULL;
+
+	if (pmi)
+		*pmi = mi;
+
+	attr = mi_find_attr(mi, NULL, type, name, name_len, &le->id);
+	if (!attr)
+		return NULL;
+
+	if (!attr->non_res)
+		return attr;
+
+	if (le64_to_cpu(attr->nres.svcn) <= vcn &&
+	    vcn <= le64_to_cpu(attr->nres.evcn))
+		return attr;
+
+	return NULL;
+}
+
+/*
+ * ni_load_all_mi
+ *
+ * loads all subrecords
+ */
+int ni_load_all_mi(struct ntfs_inode *ni)
+{
+	int err;
+	struct ATTR_LIST_ENTRY *le;
+
+	if (!ni->attr_list.size)
+		return 0;
+
+	le = NULL;
+
+	while ((le = al_enumerate(ni, le))) {
+		CLST rno = ino_get(&le->ref);
+
+		if (rno == ni->mi.rno)
+			continue;
+
+		err = ni_load_mi_ex(ni, rno, NULL);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+/*
+ * ni_add_subrecord
+ *
+ * allocate + format + attach a new subrecord
+ */
+bool ni_add_subrecord(struct ntfs_inode *ni, CLST rno, struct mft_inode **mi)
+{
+	struct mft_inode *m;
+
+	m = ntfs_alloc(sizeof(struct mft_inode), 1);
+	if (!m)
+		return false;
+
+	if (mi_format_new(m, ni->mi.sbi, rno, 0, ni->mi.rno == MFT_REC_MFT)) {
+		mi_put(m);
+		return false;
+	}
+
+	get_mi_ref(&ni->mi, &m->mrec->parent_ref);
+
+	ni_add_mi(ni, m);
+	*mi = m;
+	return true;
+}
+
+/*
+ * ni_remove_attr
+ *
+ * removes all attributes for the given type/name/id
+ */
+int ni_remove_attr(struct ntfs_inode *ni, enum ATTR_TYPE type,
+		   const __le16 *name, size_t name_len, bool base_only,
+		   const __le16 *id)
+{
+	int err;
+	struct ATTRIB *attr;
+	struct ATTR_LIST_ENTRY *le;
+	struct mft_inode *mi;
+	u32 type_in;
+	int diff;
+
+	if (base_only || type == ATTR_LIST || !ni->attr_list.size) {
+		attr = mi_find_attr(&ni->mi, NULL, type, name, name_len, id);
+		if (!attr)
+			return -ENOENT;
+
+		mi_remove_attr(&ni->mi, attr);
+		return 0;
+	}
+
+	type_in = le32_to_cpu(type);
+	le = NULL;
+
+	for (;;) {
+		le = al_enumerate(ni, le);
+		if (!le)
+			return 0;
+
+next_le2:
+		diff = le32_to_cpu(le->type) - type_in;
+		if (diff < 0)
+			continue;
+
+		if (diff > 0)
+			return 0;
+
+		if (le->name_len != name_len)
+			continue;
+
+		if (name_len &&
+		    memcmp(le_name(le), name, name_len * sizeof(short)))
+			continue;
+
+		if (id && le->id != *id)
+			continue;
+		err = ni_load_mi(ni, le, &mi);
+		if (err)
+			return err;
+
+		al_remove_le(ni, le);
+
+		attr = mi_find_attr(mi, NULL, type, name, name_len, id);
+		if (!attr)
+			return -ENOENT;
+
+		mi_remove_attr(mi, attr);
+
+		if (PtrOffset(ni->attr_list.le, le) >= ni->attr_list.size)
+			return 0;
+		goto next_le2;
+	}
+}
+
+/*
+ * ni_ins_new_attr
+ *
+ * inserts the attribute into record
+ * Returns not full constructed attribute or NULL if not possible to create
+ */
+static struct ATTRIB *ni_ins_new_attr(struct ntfs_inode *ni,
+				      struct mft_inode *mi,
+				      struct ATTR_LIST_ENTRY *le,
+				      enum ATTR_TYPE type, const __le16 *name,
+				      u8 name_len, u32 asize, u16 name_off,
+				      CLST svcn)
+{
+	int err;
+	struct ATTRIB *attr;
+	bool le_added = false;
+	struct MFT_REF ref;
+
+	get_mi_ref(mi, &ref);
+
+	if (type != ATTR_LIST && !le && ni->attr_list.size) {
+		err = al_add_le(ni, type, name, name_len, svcn, cpu_to_le16(-1),
+				&ref, &le);
+		if (err) {
+			/* no memory or no space */
+			return NULL;
+		}
+		le_added = true;
+
+		/*
+		 * al_add_le -> attr_set_size (list) -> ni_expand_list
+		 * which moves some attributes out of primary record
+		 * this means that name may point into moved memory
+		 * reinit 'name' from le
+		 */
+		name = le->name;
+	}
+
+	attr = mi_insert_attr(mi, type, name, name_len, asize, name_off);
+	if (!attr) {
+		if (le_added)
+			al_remove_le(ni, le);
+		return NULL;
+	}
+
+	if (type == ATTR_LIST) {
+		/*attr list is not in list entry array*/
+		goto out;
+	}
+
+	if (!le)
+		goto out;
+
+	/* Update ATTRIB Id and record reference */
+	le->id = attr->id;
+	ni->attr_list.dirty = true;
+	le->ref = ref;
+
+out:
+
+	return attr;
+}
+
+/*
+ * ni_create_attr_list
+ *
+ * generates an attribute list for this primary record
+ */
+int ni_create_attr_list(struct ntfs_inode *ni)
+{
+	struct ntfs_sb_info *sbi = ni->mi.sbi;
+	int err;
+	u32 lsize;
+	struct ATTRIB *attr;
+	struct ATTRIB *arr_move[7];
+	struct ATTR_LIST_ENTRY *le, *le_b[7];
+	struct MFT_REC *rec;
+	bool is_mft;
+	CLST rno = 0;
+	struct mft_inode *mi;
+	u32 free_b, nb, to_free, rs;
+	u16 sz;
+
+	is_mft = ni->mi.rno == MFT_REC_MFT;
+	rec = ni->mi.mrec;
+	rs = sbi->record_size;
+
+	/*
+	 * Skip estimating exact memory requirement
+	 * Looks like one record_size is always enough
+	 */
+	le = ntfs_alloc(al_aligned(rs), 0);
+	if (!le) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	get_mi_ref(&ni->mi, &le->ref);
+	ni->attr_list.le = le;
+
+	attr = NULL;
+	nb = 0;
+	free_b = 0;
+	attr = NULL;
+
+	for (; (attr = mi_enum_attr(&ni->mi, attr)); le = Add2Ptr(le, sz)) {
+		sz = le_size(attr->name_len);
+		WARN_ON(PtrOffset(ni->attr_list.le, le) + sz > rs);
+
+		le->type = attr->type;
+		le->size = cpu_to_le16(sz);
+		le->name_len = attr->name_len;
+		le->name_off = offsetof(struct ATTR_LIST_ENTRY, name);
+		le->vcn = 0;
+		if (le != ni->attr_list.le)
+			le->ref = ni->attr_list.le->ref;
+		le->id = attr->id;
+
+		if (attr->name_len)
+			memcpy(le->name, attr_name(attr),
+			       sizeof(short) * attr->name_len);
+		else if (attr->type == ATTR_STD)
+			continue;
+		else if (attr->type == ATTR_LIST)
+			continue;
+		else if (is_mft && attr->type == ATTR_DATA)
+			continue;
+
+		if (!nb || nb < ARRAY_SIZE(arr_move)) {
+			le_b[nb] = le;
+			arr_move[nb++] = attr;
+			free_b += le32_to_cpu(attr->size);
+		}
+	}
+
+	lsize = PtrOffset(ni->attr_list.le, le);
+	ni->attr_list.size = lsize;
+
+	to_free = le32_to_cpu(rec->used) + lsize + SIZEOF_RESIDENT;
+	if (to_free <= rs) {
+		to_free = 0;
+	} else {
+		to_free -= rs;
+
+		if (to_free > free_b) {
+			err = -EINVAL;
+			goto out1;
+		}
+	}
+
+	/* Allocate child mft. */
+	err = ntfs_look_free_mft(sbi, &rno, is_mft, ni, &mi);
+	if (err)
+		goto out1;
+
+	/* Call 'mi_remove_attr' in reverse order to keep pointers 'arr_move' valid */
+	while (to_free > 0) {
+		struct ATTRIB *b = arr_move[--nb];
+		u32 asize = le32_to_cpu(b->size);
+		u16 name_off = le16_to_cpu(b->name_off);
+
+		attr = mi_insert_attr(mi, b->type, Add2Ptr(b, name_off),
+				      b->name_len, asize, name_off);
+		WARN_ON(!attr);
+
+		get_mi_ref(mi, &le_b[nb]->ref);
+		le_b[nb]->id = attr->id;
+
+		/* copy all except id */
+		memcpy(attr, b, asize);
+		attr->id = le_b[nb]->id;
+
+		WARN_ON(!mi_remove_attr(&ni->mi, b));
+
+		if (to_free <= asize)
+			break;
+		to_free -= asize;
+		WARN_ON(!nb);
+	}
+
+	attr = mi_insert_attr(&ni->mi, ATTR_LIST, NULL, 0,
+			      lsize + SIZEOF_RESIDENT, SIZEOF_RESIDENT);
+	WARN_ON(!attr);
+
+	attr->non_res = 0;
+	attr->flags = 0;
+	attr->res.data_size = cpu_to_le32(lsize);
+	attr->res.data_off = SIZEOF_RESIDENT_LE;
+	attr->res.flags = 0;
+	attr->res.res = 0;
+
+	memcpy(resident_data_ex(attr, lsize), ni->attr_list.le, lsize);
+
+	ni->attr_list.dirty = false;
+
+	mark_inode_dirty(&ni->vfs_inode);
+	goto out;
+
+out1:
+	ntfs_free(ni->attr_list.le);
+	ni->attr_list.le = NULL;
+	ni->attr_list.size = 0;
+
+out:
+	return err;
+}
+
+/*
+ * ni_ins_attr_ext
+ *
+ * This method adds an external attribute to the ntfs_inode.
+ */
+static int ni_ins_attr_ext(struct ntfs_inode *ni, struct ATTR_LIST_ENTRY *le,
+			   enum ATTR_TYPE type, const __le16 *name, u8 name_len,
+			   u32 asize, CLST svcn, u16 name_off, bool force_ext,
+			   struct ATTRIB **ins_attr, struct mft_inode **ins_mi)
+{
+	struct ATTRIB *attr;
+	struct mft_inode *mi;
+	CLST rno;
+	u64 vbo;
+	struct rb_node *node;
+	int err;
+	bool is_mft, is_mft_data;
+	struct ntfs_sb_info *sbi = ni->mi.sbi;
+
+	is_mft = ni->mi.rno == MFT_REC_MFT;
+	is_mft_data = is_mft && type == ATTR_DATA && !name_len;
+
+	if (asize > sbi->max_bytes_per_attr) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	/*
+	 * standard information and attr_list cannot be made external.
+	 * The Log File cannot have any external attributes
+	 */
+	if (type == ATTR_STD || type == ATTR_LIST ||
+	    ni->mi.rno == MFT_REC_LOG) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	/* Create attribute list if it is not already existed */
+	if (!ni->attr_list.size) {
+		err = ni_create_attr_list(ni);
+		if (err)
+			goto out;
+	}
+
+	vbo = is_mft_data ? ((u64)svcn << sbi->cluster_bits) : 0;
+
+	if (force_ext)
+		goto insert_ext;
+
+	/* Load all subrecords into memory. */
+	err = ni_load_all_mi(ni);
+	if (err)
+		goto out;
+
+	/* Check each of loaded subrecord */
+	for (node = rb_first(&ni->mi_tree); node; node = rb_next(node)) {
+		mi = rb_entry(node, struct mft_inode, node);
+
+		if (is_mft_data &&
+		    (mi_enum_attr(mi, NULL) ||
+		     vbo <= ((u64)mi->rno << sbi->record_bits))) {
+			/* We can't accept this record 'case MFT's bootstrapping */
+			continue;
+		}
+		if (is_mft &&
+		    mi_find_attr(mi, NULL, ATTR_DATA, NULL, 0, NULL)) {
+			/*
+			 * This child record already has a ATTR_DATA.
+			 * So it can't accept any other records.
+			 */
+			continue;
+		}
+
+		if ((type != ATTR_NAME || name_len) &&
+		    mi_find_attr(mi, NULL, type, name, name_len, NULL)) {
+			/* Only indexed attributes can share same record */
+			continue;
+		}
+
+		/* Try to insert attribute into this subrecord */
+		attr = ni_ins_new_attr(ni, mi, le, type, name, name_len, asize,
+				       name_off, svcn);
+		if (!attr)
+			continue;
+
+		if (ins_attr)
+			*ins_attr = attr;
+		return 0;
+	}
+
+insert_ext:
+	/* We have to allocate a new child subrecord*/
+	err = ntfs_look_free_mft(sbi, &rno, is_mft_data, ni, &mi);
+	if (err)
+		goto out;
+
+	if (is_mft_data && vbo <= ((u64)rno << sbi->record_bits)) {
+		err = -EINVAL;
+		goto out1;
+	}
+
+	attr = ni_ins_new_attr(ni, mi, le, type, name, name_len, asize,
+			       name_off, svcn);
+	if (!attr)
+		goto out2;
+
+	if (ins_attr)
+		*ins_attr = attr;
+	if (ins_mi)
+		*ins_mi = mi;
+
+	return 0;
+
+out2:
+	ni_remove_mi(ni, mi);
+	mi_put(mi);
+	err = -EINVAL;
+
+out1:
+	ntfs_mark_rec_free(sbi, rno);
+
+out:
+	return err;
+}
+
+/*
+ * ni_insert_attr
+ *
+ * inserts an attribute into the file.
+ *
+ * If the primary record has room, it will just insert the attribute.
+ * If not, it may make the attribute external.
+ * For $MFT::Data it may make room for the attribute by
+ * making other attributes external.
+ *
+ * NOTE:
+ * The ATTR_LIST and ATTR_STD cannot be made external.
+ * This function does not fill new attribute full
+ * It only fills 'size'/'type'/'id'/'name_len' fields
+ */
+static int ni_insert_attr(struct ntfs_inode *ni, enum ATTR_TYPE type,
+			  const __le16 *name, u8 name_len, u32 asize,
+			  u16 name_off, CLST svcn, struct ATTRIB **ins_attr,
+			  struct mft_inode **ins_mi)
+{
+	struct ntfs_sb_info *sbi = ni->mi.sbi;
+	int err;
+	struct ATTRIB *attr, *eattr;
+	struct MFT_REC *rec;
+	bool is_mft;
+	struct ATTR_LIST_ENTRY *le;
+	u32 list_reserve, max_free, free, used, t32;
+	__le16 id;
+	u16 t16;
+
+	is_mft = ni->mi.rno == MFT_REC_MFT;
+	rec = ni->mi.mrec;
+
+	list_reserve = SIZEOF_NONRESIDENT + 3 * (1 + 2 * sizeof(u32));
+	used = le32_to_cpu(rec->used);
+	free = sbi->record_size - used;
+
+	if (is_mft && type != ATTR_LIST) {
+		/* Reserve space for the ATTRIB List. */
+		if (free < list_reserve)
+			free = 0;
+		else
+			free -= list_reserve;
+	}
+
+	if (asize <= free) {
+		attr = ni_ins_new_attr(ni, &ni->mi, NULL, type, name, name_len,
+				       asize, name_off, svcn);
+		if (attr) {
+			if (ins_attr)
+				*ins_attr = attr;
+			if (ins_mi)
+				*ins_mi = &ni->mi;
+			err = 0;
+			goto out;
+		}
+	}
+
+	if (!is_mft || type != ATTR_DATA || svcn) {
+		/* This ATTRIB will be external. */
+		err = ni_ins_attr_ext(ni, NULL, type, name, name_len, asize,
+				      svcn, name_off, false, ins_attr, ins_mi);
+		goto out;
+	}
+
+	/*
+	 * Here we have: "is_mft && type == ATTR_DATA && !svcn
+	 *
+	 * The first chunk of the $MFT::Data ATTRIB must be the base record.
+	 * Evict as many other attributes as possible.
+	 */
+	max_free = free;
+
+	/* Estimate the result of moving all possible attributes away.*/
+	attr = NULL;
+
+	while ((attr = mi_enum_attr(&ni->mi, attr))) {
+		if (attr->type == ATTR_STD)
+			continue;
+		if (attr->type == ATTR_LIST)
+			continue;
+		max_free += le32_to_cpu(attr->size);
+	}
+
+	if (max_free < asize + list_reserve) {
+		/* Impossible to insert this attribute into primary record */
+		err = -EINVAL;
+		goto out;
+	}
+
+	/* Start real attribute moving */
+	attr = NULL;
+
+	for (;;) {
+		attr = mi_enum_attr(&ni->mi, attr);
+		if (!attr) {
+			/* We should never be here 'cause we have already check this case */
+			err = -EINVAL;
+			goto out;
+		}
+
+		/* Skip attributes that MUST be primary record */
+		if (attr->type == ATTR_STD || attr->type == ATTR_LIST)
+			continue;
+
+		le = NULL;
+		if (ni->attr_list.size) {
+			le = al_find_le(ni, NULL, attr);
+			if (!le) {
+				/* Really this is a serious bug */
+				err = -EINVAL;
+				goto out;
+			}
+		}
+
+		t32 = le32_to_cpu(attr->size);
+		t16 = le16_to_cpu(attr->name_off);
+		err = ni_ins_attr_ext(ni, le, attr->type, Add2Ptr(attr, t16),
+				      attr->name_len, t32, attr_svcn(attr), t16,
+				      false, &eattr, NULL);
+		if (err)
+			return err;
+
+		id = eattr->id;
+		memcpy(eattr, attr, t32);
+		eattr->id = id;
+
+		/* remove attrib from primary record */
+		mi_remove_attr(&ni->mi, attr);
+
+		/* attr now points to next attribute */
+		if (attr->type == ATTR_END)
+			goto out;
+	}
+	while (asize + list_reserve > sbi->record_size - le32_to_cpu(rec->used))
+		;
+
+	attr = ni_ins_new_attr(ni, &ni->mi, NULL, type, name, name_len, asize,
+			       name_off, svcn);
+	if (!attr) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	if (ins_attr)
+		*ins_attr = attr;
+	if (ins_mi)
+		*ins_mi = &ni->mi;
+
+out:
+	return err;
+}
+
+/*
+ * ni_expand_mft_list
+ *
+ * This method splits ATTR_DATA of $MFT
+ */
+static int ni_expand_mft_list(struct ntfs_inode *ni)
+{
+	int err = 0;
+	struct runs_tree *run = &ni->file.run;
+	u32 asize, run_size, done = 0;
+	struct ATTRIB *attr;
+	struct rb_node *node;
+	CLST mft_min, mft_new, svcn, evcn, plen;
+	struct mft_inode *mi, *mi_min, *mi_new;
+	struct ntfs_sb_info *sbi = ni->mi.sbi;
+
+	/* Find the nearest Mft */
+	mft_min = 0;
+	mft_new = 0;
+	mi_min = NULL;
+
+	for (node = rb_first(&ni->mi_tree); node; node = rb_next(node)) {
+		mi = rb_entry(node, struct mft_inode, node);
+
+		attr = mi_enum_attr(mi, NULL);
+
+		if (!attr) {
+			mft_min = mi->rno;
+			mi_min = mi;
+			break;
+		}
+	}
+
+	if (ntfs_look_free_mft(sbi, &mft_new, true, ni, &mi_new)) {
+		mft_new = 0;
+		// really this is not critical
+	} else if (mft_min > mft_new) {
+		mft_min = mft_new;
+		mi_min = mi_new;
+	} else {
+		ntfs_mark_rec_free(sbi, mft_new);
+		mft_new = 0;
+		ni_remove_mi(ni, mi_new);
+	}
+
+	attr = mi_find_attr(&ni->mi, NULL, ATTR_DATA, NULL, 0, NULL);
+	if (!attr) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	asize = le32_to_cpu(attr->size);
+
+	evcn = le64_to_cpu(attr->nres.evcn);
+	svcn = bytes_to_cluster(sbi, (u64)(mft_min + 1) << sbi->record_bits);
+	if (evcn + 1 >= svcn) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	/*
+	 * split primary attribute [0 evcn] in two parts [0 svcn) + [svcn evcn]
+	 *
+	 * Update first part of ATTR_DATA in 'primary MFT
+	 */
+	err = run_pack(run, 0, svcn, Add2Ptr(attr, SIZEOF_NONRESIDENT),
+		       asize - SIZEOF_NONRESIDENT, &plen);
+	if (err < 0)
+		goto out;
+
+	run_size = QuadAlign(err);
+	err = 0;
+
+	if (plen < svcn) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	attr->nres.evcn = cpu_to_le64(svcn - 1);
+	attr->size = cpu_to_le32(run_size + SIZEOF_NONRESIDENT);
+	/* 'done' - how many bytes of primary MFT becomes free */
+	done = asize - run_size - SIZEOF_NONRESIDENT;
+	le32_sub_cpu(&ni->mi.mrec->used, done);
+
+	/* Estimate the size of second part: run_buf=NULL */
+	err = run_pack(run, svcn, evcn + 1 - svcn, NULL, sbi->record_size,
+		       &plen);
+	if (err < 0)
+		goto out;
+
+	run_size = QuadAlign(err);
+	err = 0;
+
+	if (plen < evcn + 1 - svcn) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	/*
+	 * This function may implicitly call expand attr_list
+	 * Insert second part of ATTR_DATA in 'mi_min'
+	 */
+	attr = ni_ins_new_attr(ni, mi_min, NULL, ATTR_DATA, NULL, 0,
+			       SIZEOF_NONRESIDENT + run_size,
+			       SIZEOF_NONRESIDENT, svcn);
+	if (!attr) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	attr->non_res = 1;
+	attr->name_off = SIZEOF_NONRESIDENT_LE;
+	attr->flags = 0;
+
+	run_pack(run, svcn, evcn + 1 - svcn, Add2Ptr(attr, SIZEOF_NONRESIDENT),
+		 run_size, &plen);
+
+	attr->nres.svcn = cpu_to_le64(svcn);
+	attr->nres.evcn = cpu_to_le64(evcn);
+	attr->nres.run_off = cpu_to_le16(SIZEOF_NONRESIDENT);
+
+out:
+	if (mft_new) {
+		ntfs_mark_rec_free(sbi, mft_new);
+		ni_remove_mi(ni, mi_new);
+	}
+
+	return !err && !done ? -EOPNOTSUPP : err;
+}
+
+/*
+ * ni_expand_list
+ *
+ * This method moves all possible attributes out of primary record
+ */
+int ni_expand_list(struct ntfs_inode *ni)
+{
+	int err = 0;
+	u32 asize, done = 0;
+	struct ATTRIB *attr, *ins_attr;
+	struct ATTR_LIST_ENTRY *le;
+	bool is_mft = ni->mi.rno == MFT_REC_MFT;
+	struct MFT_REF ref;
+
+	get_mi_ref(&ni->mi, &ref);
+	le = NULL;
+
+	while ((le = al_enumerate(ni, le))) {
+		if (le->type == ATTR_STD)
+			continue;
+
+		if (memcmp(&ref, &le->ref, sizeof(struct MFT_REF)))
+			continue;
+
+		if (is_mft && le->type == ATTR_DATA)
+			continue;
+
+		/* Find attribute in primary record */
+		attr = rec_find_attr_le(&ni->mi, le);
+		if (!attr) {
+			err = -EINVAL;
+			goto out;
+		}
+
+		asize = le32_to_cpu(attr->size);
+
+		/* Always insert into new record to avoid collisions (deep recursive) */
+		err = ni_ins_attr_ext(ni, le, attr->type, attr_name(attr),
+				      attr->name_len, asize, attr_svcn(attr),
+				      le16_to_cpu(attr->name_off), true,
+				      &ins_attr, NULL);
+
+		if (err)
+			goto out;
+
+		memcpy(ins_attr, attr, asize);
+		ins_attr->id = le->id;
+		mi_remove_attr(&ni->mi, attr);
+
+		done += asize;
+		goto out;
+	}
+
+	if (!is_mft) {
+		err = -EFBIG; /* attr list is too big(?) */
+		goto out;
+	}
+
+	/* split mft data as much as possible */
+	err = ni_expand_mft_list(ni);
+	if (err)
+		goto out;
+
+out:
+	return !err && !done ? -EOPNOTSUPP : err;
+}
+
+/*
+ * ni_insert_nonresident
+ *
+ * inserts new nonresident attribute
+ */
+int ni_insert_nonresident(struct ntfs_inode *ni, enum ATTR_TYPE type,
+			  const __le16 *name, u8 name_len,
+			  const struct runs_tree *run, CLST svcn, CLST len,
+			  __le16 flags, struct ATTRIB **new_attr,
+			  struct mft_inode **mi)
+{
+	int err;
+	CLST plen;
+	struct ATTRIB *attr;
+	bool is_ext =
+		(flags & (ATTR_FLAG_SPARSED | ATTR_FLAG_COMPRESSED)) && !svcn;
+	u32 name_size = QuadAlign(name_len * sizeof(short));
+	u32 name_off = is_ext ? SIZEOF_NONRESIDENT_EX : SIZEOF_NONRESIDENT;
+	u32 run_off = name_off + name_size;
+	u32 run_size, asize;
+	struct ntfs_sb_info *sbi = ni->mi.sbi;
+
+	err = run_pack(run, svcn, len, NULL, sbi->max_bytes_per_attr - run_off,
+		       &plen);
+	if (err < 0)
+		goto out;
+
+	run_size = QuadAlign(err);
+
+	if (plen < len) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	asize = run_off + run_size;
+
+	if (asize > sbi->max_bytes_per_attr) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	err = ni_insert_attr(ni, type, name, name_len, asize, name_off, svcn,
+			     &attr, mi);
+
+	if (err)
+		goto out;
+
+	attr->non_res = 1;
+	attr->name_off = cpu_to_le16(name_off);
+	attr->flags = flags;
+
+	run_pack(run, svcn, len, Add2Ptr(attr, run_off), run_size, &plen);
+
+	attr->nres.svcn = cpu_to_le64(svcn);
+	attr->nres.evcn = cpu_to_le64((u64)svcn + len - 1);
+
+	err = 0;
+	if (new_attr)
+		*new_attr = attr;
+
+	*(__le64 *)&attr->nres.run_off = cpu_to_le64(run_off);
+
+	attr->nres.alloc_size =
+		svcn ? 0 : cpu_to_le64((u64)len << ni->mi.sbi->cluster_bits);
+	attr->nres.data_size = attr->nres.alloc_size;
+	attr->nres.valid_size = attr->nres.alloc_size;
+
+	if (is_ext) {
+		if (flags & ATTR_FLAG_COMPRESSED)
+			attr->nres.c_unit = COMPRESSION_UNIT;
+		attr->nres.total_size = attr->nres.alloc_size;
+	}
+
+out:
+	return err;
+}
+
+/*
+ * ni_insert_resident
+ *
+ * inserts new resident attribute
+ */
+int ni_insert_resident(struct ntfs_inode *ni, u32 data_size,
+		       enum ATTR_TYPE type, const __le16 *name, u8 name_len,
+		       struct ATTRIB **new_attr, struct mft_inode **mi)
+{
+	int err;
+	u32 name_size = QuadAlign(name_len * sizeof(short));
+	u32 asize = SIZEOF_RESIDENT + name_size + QuadAlign(data_size);
+	struct ATTRIB *attr;
+
+	err = ni_insert_attr(ni, type, name, name_len, asize, SIZEOF_RESIDENT,
+			     0, &attr, mi);
+	if (err)
+		return err;
+
+	attr->non_res = 0;
+	attr->flags = 0;
+
+	attr->res.data_size = cpu_to_le32(data_size);
+	attr->res.data_off = cpu_to_le16(SIZEOF_RESIDENT + name_size);
+	if (type == ATTR_NAME)
+		attr->res.flags = RESIDENT_FLAG_INDEXED;
+	attr->res.res = 0;
+
+	if (new_attr)
+		*new_attr = attr;
+
+	return 0;
+}
+
+/*
+ * ni_remove_attr_le
+ *
+ * removes attribute from record
+ */
+int ni_remove_attr_le(struct ntfs_inode *ni, struct ATTRIB *attr,
+		      struct ATTR_LIST_ENTRY *le)
+{
+	int err;
+	struct mft_inode *mi;
+
+	err = ni_load_mi(ni, le, &mi);
+	if (err)
+		return err;
+
+	mi_remove_attr(mi, attr);
+
+	if (le)
+		al_remove_le(ni, le);
+
+	return 0;
+}
+
+/*
+ * ni_delete_all
+ *
+ * removes all attributes and frees allocates space
+ * ntfs_evict_inode->ntfs_clear_inode->ni_delete_all (if no links)
+ */
+int ni_delete_all(struct ntfs_inode *ni)
+{
+	int err;
+	struct ATTR_LIST_ENTRY *le = NULL;
+	struct ATTRIB *attr = NULL;
+	struct rb_node *node;
+	u16 roff;
+	u32 asize;
+	CLST svcn, evcn;
+	struct ntfs_sb_info *sbi = ni->mi.sbi;
+	bool nt3 = is_ntfs3(sbi);
+	struct MFT_REF ref;
+
+	while ((attr = ni_enum_attr_ex(ni, attr, &le))) {
+		if (!nt3 || attr->name_len) {
+			;
+		} else if (attr->type == ATTR_REPARSE) {
+			get_mi_ref(&ni->mi, &ref);
+			ntfs_remove_reparse(sbi, 0, &ref);
+		} else if (attr->type == ATTR_ID && !attr->non_res &&
+			   le32_to_cpu(attr->res.data_size) >=
+				   sizeof(struct GUID)) {
+			ntfs_objid_remove(sbi, resident_data(attr));
+		}
+
+		if (!attr->non_res)
+			continue;
+
+		svcn = le64_to_cpu(attr->nres.svcn);
+		evcn = le64_to_cpu(attr->nres.evcn);
+
+		if (evcn + 1 <= svcn)
+			continue;
+
+		asize = le32_to_cpu(attr->size);
+		roff = le16_to_cpu(attr->nres.run_off);
+
+		/*run==1 means unpack and deallocate*/
+		run_unpack_ex((struct runs_tree *)(size_t)1, sbi, ni->mi.rno,
+			      svcn, evcn, Add2Ptr(attr, roff), asize - roff);
+	}
+
+	if (ni->attr_list.size) {
+		run_deallocate(ni->mi.sbi, &ni->attr_list.run, true);
+		al_destroy(ni);
+	}
+
+	/* Free all subrecords */
+	for (node = rb_first(&ni->mi_tree); node;) {
+		struct rb_node *next = rb_next(node);
+		struct mft_inode *mi = rb_entry(node, struct mft_inode, node);
+
+		clear_rec_inuse(mi->mrec);
+		mi->dirty = true;
+		mi_write(mi, 0);
+
+		ntfs_mark_rec_free(sbi, mi->rno);
+		ni_remove_mi(ni, mi);
+		mi_put(mi);
+		node = next;
+	}
+
+	// Free base record
+	clear_rec_inuse(ni->mi.mrec);
+	ni->mi.dirty = true;
+	err = mi_write(&ni->mi, 0);
+
+	ntfs_mark_rec_free(sbi, ni->mi.rno);
+
+	return err;
+}
+
+/*
+ * ni_fname_name
+ *
+ * returns file name attribute by its value
+ */
+struct ATTR_FILE_NAME *ni_fname_name(struct ntfs_inode *ni,
+				     const struct cpu_str *uni,
+				     const struct MFT_REF *home_dir,
+				     struct ATTR_LIST_ENTRY **le)
+{
+	struct ATTRIB *attr = NULL;
+	struct ATTR_FILE_NAME *fname;
+
+	*le = NULL;
+
+	/* Enumerate all names */
+next:
+	attr = ni_find_attr(ni, attr, le, ATTR_NAME, NULL, 0, NULL, NULL);
+	if (!attr)
+		return NULL;
+
+	fname = resident_data_ex(attr, SIZEOF_ATTRIBUTE_FILENAME);
+	if (!fname)
+		goto next;
+
+	if (home_dir && memcmp(home_dir, &fname->home, sizeof(*home_dir)))
+		goto next;
+
+	if (!uni)
+		goto next;
+
+	if (uni->len != fname->name_len)
+		goto next;
+
+	if (ntfs_cmp_names_cpu(uni, (struct le_str *)&fname->name_len, NULL))
+		goto next;
+
+	return fname;
+}
+
+/*
+ * ni_fname_type
+ *
+ * returns file name attribute with given type
+ */
+struct ATTR_FILE_NAME *ni_fname_type(struct ntfs_inode *ni, u8 name_type,
+				     struct ATTR_LIST_ENTRY **le)
+{
+	struct ATTRIB *attr = NULL;
+	struct ATTR_FILE_NAME *fname;
+
+	*le = NULL;
+
+	/* Enumerate all names */
+	for (;;) {
+		attr = ni_find_attr(ni, attr, le, ATTR_NAME, NULL, 0, NULL,
+				    NULL);
+		if (!attr)
+			return NULL;
+
+		fname = resident_data_ex(attr, SIZEOF_ATTRIBUTE_FILENAME);
+		if (fname && name_type == fname->type)
+			return fname;
+	}
+}
+
+/*
+ * ni_init_compress
+ *
+ * allocates and fill 'compress_ctx'
+ * used to decompress lzx and xpress
+ */
+int ni_init_compress(struct ntfs_inode *ni, struct COMPRESS_CTX *ctx)
+{
+	u32 c_format = ((ni->ni_flags & NI_FLAG_COMPRESSED_MASK) >> 8) - 1;
+	u32 chunk_bits;
+
+	switch (c_format) {
+	case WOF_COMPRESSION_XPRESS4K:
+		chunk_bits = 12; // 4k
+		break;
+	case WOF_COMPRESSION_LZX:
+		chunk_bits = 15; // 32k
+		break;
+	case WOF_COMPRESSION_XPRESS8K:
+		chunk_bits = 13; // 8k
+		break;
+	case WOF_COMPRESSION_XPRESS16K:
+		chunk_bits = 14; // 16k
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	ctx->chunk_bits = chunk_bits;
+	ctx->offset_bits = ni->vfs_inode.i_size < 0x100000000ull ?
+				   2 :
+				   3; // 32 or 64 bits per offsets
+
+	ctx->compress_format = c_format;
+	ctx->chunk_size = 1u << chunk_bits;
+	ctx->chunk_num = -1;
+	ctx->first_chunk = -1;
+	ctx->total_chunks = (ni->vfs_inode.i_size - 1) >> chunk_bits;
+	ctx->chunk0_off = ctx->total_chunks << ctx->offset_bits;
+
+	return 0;
+}
+
+/*
+ * ni_parse_reparse
+ *
+ * buffer is at least 24 bytes
+ */
+enum REPARSE_SIGN ni_parse_reparse(struct ntfs_inode *ni, struct ATTRIB *attr,
+				   void *buffer)
+{
+	const struct REPARSE_DATA_BUFFER *rp = NULL;
+	u32 c_format;
+	u16 len;
+	typeof(rp->CompressReparseBuffer) *cmpr;
+
+	/* Try to estimate reparse point */
+	if (!attr->non_res) {
+		rp = resident_data_ex(attr, sizeof(struct REPARSE_DATA_BUFFER));
+	} else if (le64_to_cpu(attr->nres.data_size) >=
+		   sizeof(struct REPARSE_DATA_BUFFER)) {
+		struct runs_tree run;
+
+		run_init(&run);
+
+		if (!attr_load_runs_vcn(ni, ATTR_REPARSE, NULL, 0, &run, 0) &&
+		    !ntfs_read_run_nb(ni->mi.sbi, &run, 0, buffer,
+				      sizeof(struct REPARSE_DATA_BUFFER),
+				      NULL)) {
+			rp = buffer;
+		}
+
+		run_close(&run);
+	}
+
+	if (!rp)
+		return REPARSE_NONE;
+
+	len = le16_to_cpu(rp->ReparseDataLength);
+	switch (rp->ReparseTag) {
+	case (IO_REPARSE_TAG_MICROSOFT | IO_REPARSE_TAG_SYMBOLIC_LINK):
+		break; /* Symbolic link */
+	case IO_REPARSE_TAG_MOUNT_POINT:
+		break; /* Mount points and junctions */
+	case IO_REPARSE_TAG_SYMLINK:
+		break;
+	case IO_REPARSE_TAG_COMPRESS:
+		cmpr = &rp->CompressReparseBuffer;
+		if (len < sizeof(*cmpr) ||
+		    cmpr->WofVersion != WOF_CURRENT_VERSION ||
+		    cmpr->WofProvider != WOF_PROVIDER_SYSTEM ||
+		    cmpr->ProviderVer != WOF_PROVIDER_CURRENT_VERSION) {
+			return REPARSE_NONE;
+		}
+		c_format = le32_to_cpu(cmpr->CompressionFormat);
+		if (c_format > 3)
+			return REPARSE_NONE;
+
+		ni->ni_flags |= (c_format + 1) << 8;
+		return REPARSE_COMPRESSED;
+
+	case IO_REPARSE_TAG_DEDUP:
+		ni->ni_flags |= NI_FLAG_DEDUPLICATED;
+		return REPARSE_DEDUPLICATED;
+
+	default:
+		if (rp->ReparseTag & IO_REPARSE_TAG_NAME_SURROGATE)
+			break;
+
+		return REPARSE_NONE;
+	}
+
+	/* Looks like normal symlink */
+	return REPARSE_LINK;
+}
+
+/*
+ * helper for file_fiemap
+ * assumed ni_lock
+ * TODO: less aggressive locks
+ */
+int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
+	      __u64 vbo, __u64 len)
+{
+	int err = 0;
+	struct ntfs_sb_info *sbi = ni->mi.sbi;
+	u8 cluster_bits = sbi->cluster_bits;
+	struct runs_tree *run;
+	struct rw_semaphore *run_lock;
+	struct ATTRIB *attr;
+	CLST vcn = vbo >> cluster_bits;
+	CLST lcn, clen;
+	u64 valid = ni->i_valid;
+	u64 lbo, bytes;
+	u64 end, alloc_size;
+	size_t idx = -1;
+	u32 flags;
+	bool ok;
+
+	if (S_ISDIR(ni->vfs_inode.i_mode)) {
+		run = &ni->dir.alloc_run;
+		attr = ni_find_attr(ni, NULL, NULL, ATTR_ALLOC, I30_NAME,
+				    ARRAY_SIZE(I30_NAME), NULL, NULL);
+		run_lock = NULL;
+	} else {
+		run = &ni->file.run;
+		attr = ni_find_attr(ni, NULL, NULL, ATTR_DATA, NULL, 0, NULL,
+				    NULL);
+		if (!attr) {
+			err = -EINVAL;
+			goto out;
+		}
+		run_lock = &ni->file.run_lock;
+	}
+
+	if (!attr || !attr->non_res) {
+		err = fiemap_fill_next_extent(
+			fieinfo, 0, 0,
+			attr ? le32_to_cpu(attr->res.data_size) : 0,
+			FIEMAP_EXTENT_DATA_INLINE | FIEMAP_EXTENT_LAST |
+				FIEMAP_EXTENT_MERGED);
+		goto out;
+	}
+
+	end = vbo + len;
+	alloc_size = le64_to_cpu(attr->nres.alloc_size);
+	if (end > alloc_size)
+		end = alloc_size;
+
+	if (run_lock)
+		down_read(run_lock);
+
+	while (vbo < end) {
+		if (idx == -1) {
+			ok = run_lookup_entry(run, vcn, &lcn, &clen, &idx);
+		} else {
+			CLST next_vcn = vcn;
+
+			ok = run_get_entry(run, ++idx, &vcn, &lcn, &clen);
+			if (ok && vcn != next_vcn) {
+				ok = false;
+				vcn = next_vcn;
+			}
+		}
+
+		if (!ok) {
+			if (run_lock) {
+				up_read(run_lock);
+				down_write(run_lock);
+			}
+
+			err = attr_load_runs_vcn(ni, attr->type,
+						 attr_name(attr),
+						 attr->name_len, run, vcn);
+
+			if (run_lock) {
+				up_write(run_lock);
+				down_read(run_lock);
+			}
+
+			if (err)
+				break;
+
+			ok = run_lookup_entry(run, vcn, &lcn, &clen, &idx);
+
+			if (!ok) {
+				err = -EINVAL;
+				break;
+			}
+		}
+
+		if (!clen) {
+			err = -EINVAL; // ?
+			break;
+		}
+
+		if (lcn == SPARSE_LCN) {
+			vcn += clen;
+			vbo = (u64)vcn << cluster_bits;
+			continue;
+		}
+
+		flags = FIEMAP_EXTENT_MERGED;
+		if (S_ISDIR(ni->vfs_inode.i_mode)) {
+			;
+		} else if (is_attr_compressed(attr)) {
+			bool is_compr;
+			CLST clst_data;
+
+			err = attr_is_frame_compressed(ni, attr,
+						       vcn >> attr->nres.c_unit,
+						       &clst_data, &is_compr);
+			if (err)
+				break;
+			if (is_compr)
+				flags |= FIEMAP_EXTENT_ENCODED;
+		} else if (is_attr_encrypted(attr)) {
+			flags |= FIEMAP_EXTENT_DATA_ENCRYPTED;
+		}
+
+		vbo = (u64)vcn << cluster_bits;
+		bytes = (u64)clen << cluster_bits;
+		lbo = (u64)lcn << cluster_bits;
+
+		vcn += clen;
+
+		if (vbo + bytes >= end) {
+			bytes = end - vbo;
+			flags |= FIEMAP_EXTENT_LAST;
+		}
+
+		if (vbo + bytes <= valid) {
+			;
+		} else if (vbo >= valid) {
+			flags |= FIEMAP_EXTENT_UNWRITTEN;
+		} else {
+			/* vbo < valid && valid < vbo + bytes */
+			u64 dlen = valid - vbo;
+
+			err = fiemap_fill_next_extent(fieinfo, vbo, lbo, dlen,
+						      flags);
+			if (err < 0)
+				break;
+			if (err == 1) {
+				err = 0;
+				break;
+			}
+
+			vbo = valid;
+			bytes -= dlen;
+			if (!bytes)
+				continue;
+
+			lbo += dlen;
+			flags |= FIEMAP_EXTENT_UNWRITTEN;
+		}
+
+		err = fiemap_fill_next_extent(fieinfo, vbo, lbo, bytes, flags);
+		if (err < 0)
+			break;
+		if (err == 1) {
+			err = 0;
+			break;
+		}
+
+		vbo += bytes;
+	}
+
+	if (run_lock)
+		up_read(run_lock);
+
+out:
+	return err;
+}
+
+/*
+ * When decompressing, we typically obtain more than one page per reference.
+ * We inject the additional pages into the page cache.
+ */
+int ni_readpage_cmpr(struct ntfs_inode *ni, struct page *page)
+{
+	int err;
+	struct ntfs_sb_info *sbi = ni->mi.sbi;
+	struct address_space *mapping = page->mapping;
+	struct ATTR_LIST_ENTRY *le;
+	struct ATTRIB *attr;
+	u8 frame_bits;
+	u32 frame_size, i, idx;
+	CLST frame, clst_data;
+	struct page *pg;
+	pgoff_t index = page->index, end_index;
+	u64 vbo = (u64)index << PAGE_SHIFT;
+	u32 pages_per_frame = 0;
+	struct page **pages = NULL;
+	char *frame_buf = NULL;
+	char *frame_unc;
+	u32 cmpr_size, unc_size;
+	u64 frame_vbo, valid_size;
+	size_t unc_size_fin;
+	struct COMPRESS_CTX *ctx = NULL;
+	bool is_compr = false;
+
+	end_index = (ni->vfs_inode.i_size + PAGE_SIZE - 1) >> PAGE_SHIFT;
+
+	if (index >= end_index) {
+		SetPageUptodate(page);
+		err = 0;
+		goto out;
+	}
+
+	le = NULL;
+	attr = ni_find_attr(ni, NULL, &le, ATTR_DATA, NULL, 0, NULL, NULL);
+	if (!attr) {
+		err = -ENOENT;
+		goto out;
+	}
+
+	WARN_ON(!attr->non_res);
+
+	if (ni->ni_flags & NI_FLAG_COMPRESSED_MASK) {
+		ctx = ntfs_alloc(sizeof(*ctx), 1);
+		if (!ctx) {
+			err = -ENOMEM;
+			goto out;
+		}
+		err = ni_init_compress(ni, ctx);
+		if (err)
+			goto out;
+
+		frame_bits = ctx->chunk_bits;
+		frame_size = ctx->chunk_size;
+		frame = vbo >> frame_bits;
+		frame_vbo = (u64)frame << frame_bits;
+
+		/* TODO: port lzx/xpress */
+		err = -EOPNOTSUPP;
+		goto out;
+	} else if (is_attr_compressed(attr)) {
+		if (sbi->cluster_size > NTFS_LZNT_MAX_CLUSTER) {
+			err = -EOPNOTSUPP;
+			goto out;
+		}
+
+		if (attr->nres.c_unit != NTFS_LZNT_CUNIT) {
+			err = -EOPNOTSUPP;
+			goto out;
+		}
+
+		frame_bits = NTFS_LZNT_CUNIT + sbi->cluster_bits;
+		frame_size = sbi->cluster_size << NTFS_LZNT_CUNIT;
+		frame = vbo >> frame_bits;
+		frame_vbo = (u64)frame << frame_bits;
+
+		err = attr_is_frame_compressed(ni, attr, frame, &clst_data,
+					       &is_compr);
+		if (err)
+			goto out;
+	} else {
+		WARN_ON(1);
+		err = -EINVAL;
+		goto out;
+	}
+
+	pages_per_frame = frame_size >> PAGE_SHIFT;
+	pages = ntfs_alloc(pages_per_frame * sizeof(*pages), 1);
+	if (!pages) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	idx = (vbo - frame_vbo) >> PAGE_SHIFT;
+	pages[idx] = page;
+	index = frame_vbo >> PAGE_SHIFT;
+	kmap(page);
+
+	for (i = 0; i < pages_per_frame && index < end_index; i++, index++) {
+		if (i == idx)
+			continue;
+
+		pg = grab_cache_page_nowait(mapping, index);
+		if (!pg)
+			continue;
+
+		pages[i] = pg;
+		if (!PageDirty(pg) && (!PageUptodate(pg) || PageError(pg)))
+			ClearPageError(pg);
+		kmap(pg);
+	}
+
+	valid_size = ni->i_valid;
+
+	if (frame_vbo >= valid_size || !clst_data) {
+		for (i = 0; i < pages_per_frame; i++) {
+			pg = pages[i];
+			if (!pg || PageDirty(pg) ||
+			    (PageUptodate(pg) && !PageError(pg)))
+				continue;
+
+			memset(page_address(pg), 0, PAGE_SIZE);
+			flush_dcache_page(pg);
+			SetPageUptodate(pg);
+		}
+		err = 0;
+		goto out1;
+	}
+
+	unc_size = frame_vbo + frame_size > valid_size ?
+			   (valid_size - frame_vbo) :
+			   frame_size;
+
+	/* read 'clst_data' clusters from disk */
+	cmpr_size = clst_data << sbi->cluster_bits;
+	frame_buf = ntfs_alloc(cmpr_size, 0);
+	if (!frame_buf) {
+		err = -ENOMEM;
+		goto out1;
+	}
+
+	err = ntfs_read_run_nb(sbi, &ni->file.run, frame_vbo, frame_buf,
+			       cmpr_size, NULL);
+	if (err)
+		goto out2;
+
+	spin_lock(&sbi->compress.lock);
+	frame_unc = sbi->compress.frame_unc;
+
+	if (!is_compr) {
+		unc_size_fin = unc_size;
+		frame_unc = frame_buf;
+	} else {
+		/* decompress: frame_buf -> frame_unc */
+		unc_size_fin = decompress_lznt(frame_buf, cmpr_size, frame_unc,
+					       frame_size);
+		if ((ssize_t)unc_size_fin < 0) {
+			err = unc_size_fin;
+			goto out3;
+		}
+
+		if (!unc_size_fin || unc_size_fin > frame_size) {
+			err = -EINVAL;
+			goto out3;
+		}
+	}
+
+	for (i = 0; i < pages_per_frame; i++) {
+		u8 *pa;
+		u32 use, done;
+		loff_t vbo;
+
+		pg = pages[i];
+		if (!pg)
+			continue;
+
+		if (PageDirty(pg) || (PageUptodate(pg) && !PageError(pg)))
+			continue;
+
+		pa = page_address(pg);
+
+		use = 0;
+		done = i * PAGE_SIZE;
+		vbo = frame_vbo + done;
+
+		if (vbo < valid_size && unc_size_fin > done) {
+			use = unc_size_fin - done;
+			if (use > PAGE_SIZE)
+				use = PAGE_SIZE;
+			if (vbo + use > valid_size)
+				use = valid_size - vbo;
+			memcpy(pa, frame_unc + done, use);
+		}
+
+		if (use < PAGE_SIZE)
+			memset(pa + use, 0, PAGE_SIZE - use);
+
+		flush_dcache_page(pg);
+		SetPageUptodate(pg);
+	}
+
+out3:
+	spin_unlock(&sbi->compress.lock);
+
+out2:
+	ntfs_free(frame_buf);
+out1:
+	for (i = 0; i < pages_per_frame; i++) {
+		pg = pages[i];
+		if (i == idx || !pg)
+			continue;
+		kunmap(pg);
+		unlock_page(pg);
+		put_page(pg);
+	}
+
+	if (err)
+		SetPageError(page);
+	kunmap(page);
+
+out:
+	/* At this point, err contains 0 or -EIO depending on the "critical" page */
+	ntfs_free(pages);
+	unlock_page(page);
+
+	ntfs_free(ctx);
+
+	return err;
+}
+
+/*
+ * ni_writepage_cmpr
+ *
+ * helper for ntfs_writepage_cmpr
+ */
+int ni_writepage_cmpr(struct page *page, int sync)
+{
+	int err;
+	struct address_space *mapping = page->mapping;
+	struct inode *inode = mapping->host;
+	loff_t i_size = i_size_read(inode);
+	struct ntfs_inode *ni = ntfs_i(inode);
+	struct ntfs_sb_info *sbi = ni->mi.sbi;
+	pgoff_t index = page->index, end_index;
+	u64 vbo = (u64)index << PAGE_SHIFT;
+	u32 pages_per_frame = 0;
+	struct page **pages = NULL;
+	char *frame_buf = NULL;
+	struct ATTR_LIST_ENTRY *le;
+	struct ATTRIB *attr;
+	u8 frame_bits;
+	u32 frame_size, i, idx, unc_size;
+	CLST frame;
+	struct page *pg;
+	char *frame_unc;
+	u64 frame_vbo;
+	size_t cmpr_size_fin, cmpr_size_clst;
+	gfp_t mask;
+
+	end_index = (i_size + PAGE_SIZE - 1) >> PAGE_SHIFT;
+
+	if (index >= end_index) {
+		SetPageUptodate(page);
+		err = 0;
+		goto out;
+	}
+
+	le = NULL;
+	attr = ni_find_attr(ni, NULL, &le, ATTR_DATA, NULL, 0, NULL, NULL);
+	if (!attr) {
+		err = -ENOENT;
+		goto out;
+	}
+
+	if (!attr->non_res) {
+		WARN_ON(1);
+		err = 0;
+		goto out;
+	}
+
+	if (!is_attr_compressed(attr)) {
+		WARN_ON(1);
+		err = -EINVAL;
+		goto out;
+	}
+
+	if (sbi->cluster_size > NTFS_LZNT_MAX_CLUSTER) {
+		err = -EOPNOTSUPP;
+		goto out;
+	}
+
+	if (attr->nres.c_unit != NTFS_LZNT_CUNIT) {
+		err = -EOPNOTSUPP;
+		goto out;
+	}
+
+	frame_bits = NTFS_LZNT_CUNIT + sbi->cluster_bits;
+	frame_size = sbi->cluster_size << NTFS_LZNT_CUNIT;
+	frame = vbo >> frame_bits;
+	frame_vbo = (u64)frame << frame_bits;
+	unc_size = frame_vbo + frame_size > i_size ? (i_size - frame_vbo) :
+						     frame_size;
+
+	frame_buf = ntfs_alloc(frame_size, 0);
+	if (!frame_buf) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	pages_per_frame = frame_size >> PAGE_SHIFT;
+	pages = ntfs_alloc(pages_per_frame * sizeof(*pages), 1);
+	if (!pages) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	idx = (vbo - frame_vbo) >> PAGE_SHIFT;
+	pages[idx] = page;
+	index = frame_vbo >> PAGE_SHIFT;
+	mask = mapping_gfp_mask(mapping);
+	kmap(page);
+
+	for (i = 0; i < pages_per_frame && index < end_index; i++, index++) {
+		if (i == idx)
+			continue;
+
+		// added FGP_CREAT
+		pg = pagecache_get_page(
+			mapping, index,
+			FGP_LOCK | FGP_NOFS | FGP_CREAT | FGP_NOWAIT, mask);
+		if (!pg)
+			continue;
+
+		pages[i] = pg;
+
+		if (PageError(pg)) {
+			err = -EIO;
+			goto out2;
+		}
+
+		if (!PageDirty(pg) && !PageUptodate(pg)) {
+			memset(page_address(pg), 0, PAGE_SIZE);
+			flush_dcache_page(pg);
+			SetPageUptodate(pg);
+		}
+
+		kmap(pg);
+	}
+
+	spin_lock(&sbi->compress.lock);
+	frame_unc = sbi->compress.frame_unc;
+
+	for (i = 0; i < pages_per_frame; i++) {
+		pg = pages[i];
+		if (pg)
+			memcpy(frame_unc + i * PAGE_SIZE, page_address(pg),
+			       PAGE_SIZE);
+		else
+			memset(frame_unc + i * PAGE_SIZE, 0, PAGE_SIZE);
+	}
+
+	/* compress: frame_unc -> frame_buf */
+	cmpr_size_fin = compress_lznt(frame_unc, unc_size, frame_buf,
+				      frame_size, sbi->compress.ctx);
+
+	cmpr_size_clst = ntfs_up_cluster(sbi, cmpr_size_fin);
+	if (cmpr_size_clst + sbi->cluster_size > frame_size) {
+		/* write frame as is */
+		memcpy(frame_buf, frame_unc, frame_size);
+		cmpr_size_fin = frame_size;
+	} else if (cmpr_size_fin) {
+		memset(frame_buf + cmpr_size_fin, 0,
+		       cmpr_size_clst - cmpr_size_fin);
+	}
+	spin_unlock(&sbi->compress.lock);
+
+	err = attr_allocate_frame(ni, frame, cmpr_size_fin, ni->i_valid);
+	if (err)
+		goto out2;
+
+	if (!cmpr_size_clst)
+		goto out2;
+
+	err = ntfs_sb_write_run(sbi, &ni->file.run, frame_vbo, frame_buf,
+				cmpr_size_clst);
+	if (err)
+		goto out2;
+
+out2:
+	ntfs_free(frame_buf);
+	for (i = 0; i < pages_per_frame; i++) {
+		pg = pages[i];
+		if (!pg || i == idx)
+			continue;
+		kunmap(pg);
+		SetPageUptodate(pg);
+		/* clear page dirty so that writepages wouldn't work for us. */
+		ClearPageDirty(pg);
+		unlock_page(pg);
+		put_page(pg);
+	}
+
+	if (err)
+		SetPageError(page);
+	kunmap(page);
+
+out:
+	/* At this point, err contains 0 or -EIO depending on the "critical" page */
+	ntfs_free(pages);
+	set_page_writeback(page);
+	unlock_page(page);
+	end_page_writeback(page);
+
+	return err;
+}
+
+/*
+ * update duplicate info of ATTR_FILE_NAME in MFT and in parent directories
+ */
+static bool ni_update_parent(struct ntfs_inode *ni, struct NTFS_DUP_INFO *dup,
+			     int sync)
+{
+	struct ATTRIB *attr;
+	struct mft_inode *mi;
+	struct ATTR_LIST_ENTRY *le = NULL;
+	struct ntfs_sb_info *sbi = ni->mi.sbi;
+	struct super_block *sb = sbi->sb;
+	bool re_dirty = false;
+	bool active = sb->s_flags & SB_ACTIVE;
+	bool upd_parent = ni->ni_flags & NI_FLAG_UPDATE_PARENT;
+
+	if (ni->mi.mrec->flags & RECORD_FLAG_DIR) {
+		dup->fa |= FILE_ATTRIBUTE_DIRECTORY;
+		attr = NULL;
+		dup->alloc_size = 0;
+		dup->data_size = 0;
+	} else {
+		dup->fa &= ~FILE_ATTRIBUTE_DIRECTORY;
+
+		attr = ni_find_attr(ni, NULL, &le, ATTR_DATA, NULL, 0, NULL,
+				    &mi);
+		if (!attr) {
+			dup->alloc_size = dup->data_size = 0;
+		} else if (!attr->non_res) {
+			u32 data_size = le32_to_cpu(attr->res.data_size);
+
+			dup->alloc_size = cpu_to_le64(QuadAlign(data_size));
+			dup->data_size = cpu_to_le64(data_size);
+		} else {
+			u64 new_valid = ni->i_valid;
+			u64 data_size = le64_to_cpu(attr->nres.data_size);
+			__le64 valid_le;
+
+			dup->alloc_size = is_attr_ext(attr) ?
+						  attr->nres.total_size :
+						  attr->nres.alloc_size;
+			dup->data_size = attr->nres.data_size;
+
+			if (new_valid > data_size)
+				new_valid = data_size;
+
+			valid_le = cpu_to_le64(new_valid);
+			if (valid_le != attr->nres.valid_size) {
+				attr->nres.valid_size = valid_le;
+				mi->dirty = true;
+			}
+		}
+	}
+
+	/* TODO: fill reparse info */
+	dup->reparse = 0;
+	dup->ea_size = 0;
+
+	if (ni->ni_flags & NI_FLAG_EA) {
+		attr = ni_find_attr(ni, attr, &le, ATTR_EA_INFO, NULL, 0, NULL,
+				    NULL);
+		if (attr) {
+			const struct EA_INFO *info;
+
+			info = resident_data_ex(attr, sizeof(struct EA_INFO));
+
+			dup->ea_size = info->size_pack;
+		}
+	}
+
+	attr = NULL;
+	le = NULL;
+
+	while ((attr = ni_find_attr(ni, attr, &le, ATTR_NAME, NULL, 0, NULL,
+				    &mi))) {
+		struct inode *dir;
+		struct ATTR_FILE_NAME *fname;
+
+		fname = resident_data_ex(attr, SIZEOF_ATTRIBUTE_FILENAME);
+		if (!fname)
+			continue;
+
+		if (memcmp(&fname->dup, dup, sizeof(fname->dup))) {
+			memcpy(&fname->dup, dup, sizeof(fname->dup));
+			mi->dirty = true;
+		} else if (!upd_parent) {
+			continue;
+		}
+
+		if (!active)
+			continue; /*avoid __wait_on_freeing_inode(inode); */
+
+		/*ntfs_iget5 may sleep*/
+		dir = ntfs_iget5(sb, &fname->home, NULL);
+		if (IS_ERR(dir)) {
+			ntfs_inode_warn(
+				&ni->vfs_inode,
+				"failed to open parent directory r=%lx to update",
+				(long)ino_get(&fname->home));
+			continue;
+		}
+
+		if (!is_bad_inode(dir)) {
+			struct ntfs_inode *dir_ni = ntfs_i(dir);
+
+			if (!ni_trylock(dir_ni)) {
+				re_dirty = true;
+			} else {
+				indx_update_dup(dir_ni, sbi, fname, dup, sync);
+				ni_unlock(dir_ni);
+			}
+		}
+		iput(dir);
+	}
+
+	return re_dirty;
+}
+
+/*
+ * ni_write_inode
+ *
+ * write mft base record and all subrecords to disk
+ */
+int ni_write_inode(struct inode *inode, int sync, const char *hint)
+{
+	int err = 0, err2;
+	struct ntfs_inode *ni = ntfs_i(inode);
+	struct super_block *sb = inode->i_sb;
+	struct ntfs_sb_info *sbi = sb->s_fs_info;
+	bool re_dirty = false;
+	struct ATTR_STD_INFO *std;
+	struct rb_node *node, *next;
+	struct NTFS_DUP_INFO dup;
+
+	if (is_bad_inode(inode))
+		return 0;
+
+	if (!ni_trylock(ni)) {
+		/* 'ni' is under modification, skip for now */
+		mark_inode_dirty_sync(inode);
+		return 0;
+	}
+
+	if (is_rec_inuse(ni->mi.mrec) &&
+	    !(sbi->flags & NTFS_FLAGS_LOG_REPLAYING) && inode->i_nlink) {
+		bool modified = false;
+
+		/* update times in standard attribute */
+		std = ni_std(ni);
+		if (!std) {
+			err = -EINVAL;
+			goto out;
+		}
+
+		/* Update the access times if they have changed. */
+		dup.m_time = kernel2nt(&inode->i_mtime);
+		if (std->m_time != dup.m_time) {
+			std->m_time = dup.m_time;
+			modified = true;
+		}
+
+		dup.c_time = kernel2nt(&inode->i_ctime);
+		if (std->c_time != dup.c_time) {
+			std->c_time = dup.c_time;
+			modified = true;
+		}
+
+		dup.a_time = kernel2nt(&inode->i_atime);
+		if (std->a_time != dup.a_time) {
+			std->a_time = dup.a_time;
+			modified = true;
+		}
+
+		dup.fa = ni->std_fa;
+		if (std->fa != dup.fa) {
+			std->fa = dup.fa;
+			modified = true;
+		}
+
+		if (modified)
+			ni->mi.dirty = true;
+
+		if (!ntfs_is_meta_file(sbi, inode->i_ino) &&
+		    (modified || ni->ni_flags & NI_FLAG_UPDATE_PARENT)) {
+			dup.cr_time = std->cr_time;
+			/* Not critical if this function fail */
+			re_dirty = ni_update_parent(ni, &dup, sync);
+
+			if (re_dirty)
+				ni->ni_flags |= NI_FLAG_UPDATE_PARENT;
+			else
+				ni->ni_flags &= ~NI_FLAG_UPDATE_PARENT;
+		}
+
+		/* update attribute list */
+		err = al_update(ni);
+		if (err)
+			goto out;
+	}
+
+	for (node = rb_first(&ni->mi_tree); node; node = next) {
+		struct mft_inode *mi = rb_entry(node, struct mft_inode, node);
+		bool is_empty;
+
+		next = rb_next(node);
+
+		if (!mi->dirty)
+			continue;
+
+		is_empty = !mi_enum_attr(mi, NULL);
+
+		if (is_empty)
+			clear_rec_inuse(mi->mrec);
+
+		err2 = mi_write(mi, sync);
+		if (!err && err2)
+			err = err2;
+
+		if (is_empty) {
+			ntfs_mark_rec_free(sbi, mi->rno);
+			rb_erase(node, &ni->mi_tree);
+			mi_put(mi);
+		}
+	}
+
+	err2 = mi_write(&ni->mi, sync);
+	if (!err && err2)
+		err = err2;
+out:
+	ni_unlock(ni);
+
+	if (err) {
+		ntfs_err(sb, "%s r=%lx failed, %d.", hint, inode->i_ino, err);
+		ntfs_set_state(sbi, NTFS_DIRTY_ERROR);
+		return err;
+	}
+
+	if (re_dirty && (sb->s_flags & SB_ACTIVE))
+		mark_inode_dirty_sync(inode);
+
+	if (inode->i_ino < sbi->mft.recs_mirr)
+		sbi->flags |= NTFS_FLAGS_MFTMIRR;
+
+	return 0;
+}
diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
new file mode 100644
index 000000000000..6ce13d7f238c
--- /dev/null
+++ b/fs/ntfs3/namei.c
@@ -0,0 +1,577 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  linux/fs/ntfs3/namei.c
+ *
+ * Copyright (C) 2019-2020 Paragon Software GmbH, All rights reserved.
+ *
+ */
+
+#include <linux/blkdev.h>
+#include <linux/buffer_head.h>
+#include <linux/fs.h>
+#include <linux/iversion.h>
+#include <linux/namei.h>
+#include <linux/nls.h>
+
+#include "debug.h"
+#include "ntfs.h"
+#include "ntfs_fs.h"
+
+/*
+ * fill_name_de
+ *
+ * formats NTFS_DE in 'buf'
+ */
+int fill_name_de(struct ntfs_sb_info *sbi, void *buf, const struct qstr *name,
+		 const struct cpu_str *uni)
+{
+	int err;
+	struct NTFS_DE *e = buf;
+	u16 data_size;
+	struct ATTR_FILE_NAME *fname = (struct ATTR_FILE_NAME *)(e + 1);
+
+#ifndef NTFS3_64BIT_CLUSTER
+	e->ref.high = fname->home.high = 0;
+#endif
+	if (uni) {
+#ifdef __BIG_ENDIAN
+		int ulen = uni->len;
+		__le16 *uname = fname->name;
+		const u16 *name_cpu = uni->name;
+
+		while (ulen--)
+			*uname++ = cpu_to_le16(*name_cpu++);
+#else
+		memcpy(fname->name, uni->name, uni->len * sizeof(u16));
+#endif
+		fname->name_len = uni->len;
+
+	} else {
+		/* Convert input string to unicode */
+		err = ntfs_nls_to_utf16(sbi, name->name, name->len,
+					(struct cpu_str *)&fname->name_len,
+					NTFS_NAME_LEN, UTF16_LITTLE_ENDIAN);
+		if (err < 0)
+			return err;
+	}
+
+	fname->type = FILE_NAME_POSIX;
+	data_size = fname_full_size(fname);
+
+	e->size = cpu_to_le16(QuadAlign(data_size) + sizeof(struct NTFS_DE));
+	e->key_size = cpu_to_le16(data_size);
+	e->flags = 0;
+	e->res = 0;
+
+	return 0;
+}
+
+/*
+ * ntfs_lookup
+ *
+ * inode_operations::lookup
+ */
+static struct dentry *ntfs_lookup(struct inode *dir, struct dentry *dentry,
+				  u32 flags)
+{
+	struct ntfs_inode *ni = ntfs_i(dir);
+	struct cpu_str *uni = __getname();
+	struct inode *inode;
+	int err;
+
+	if (!uni)
+		inode = ERR_PTR(-ENOMEM);
+	else {
+		err = ntfs_nls_to_utf16(ni->mi.sbi, dentry->d_name.name,
+					dentry->d_name.len, uni, NTFS_NAME_LEN,
+					UTF16_HOST_ENDIAN);
+		if (err < 0)
+			inode = ERR_PTR(err);
+		else {
+			ni_lock(ni);
+			inode = dir_search_u(dir, uni, NULL);
+			ni_unlock(ni);
+		}
+		__putname(uni);
+	}
+
+	return d_splice_alias(inode, dentry);
+}
+
+/*
+ * ntfs_create
+ *
+ * inode_operations::create
+ */
+static int ntfs_create(struct inode *dir, struct dentry *dentry, umode_t mode,
+		       bool excl)
+{
+	int err;
+	struct ntfs_inode *ni = ntfs_i(dir);
+	struct inode *inode;
+
+	ni_lock(ni);
+
+	err = ntfs_create_inode(dir, dentry, NULL, NULL, S_IFREG | mode, 0,
+				NULL, 0, excl, NULL, &inode);
+
+	ni_unlock(ni);
+
+	return err;
+}
+
+/*
+ * ntfs_link
+ *
+ * inode_operations::link
+ */
+static int ntfs_link(struct dentry *ode, struct inode *dir, struct dentry *de)
+{
+	int err;
+	struct inode *inode = d_inode(ode);
+	struct ntfs_inode *ni = ntfs_i(inode);
+
+	if (S_ISDIR(inode->i_mode))
+		return -EPERM;
+
+	if (inode->i_nlink >= NTFS_LINK_MAX)
+		return -EMLINK;
+
+	ni_lock(ni);
+	if (inode != dir)
+		ni_lock(ntfs_i(dir));
+
+	dir->i_ctime = dir->i_mtime = inode->i_ctime = current_time(inode);
+	inc_nlink(inode);
+	ihold(inode);
+
+	err = ntfs_link_inode(inode, de);
+	if (!err) {
+		mark_inode_dirty(inode);
+		mark_inode_dirty(dir);
+		d_instantiate(de, inode);
+	} else {
+		drop_nlink(inode);
+		iput(inode);
+	}
+
+	if (inode != dir)
+		ni_unlock(ntfs_i(dir));
+	ni_unlock(ni);
+
+	return err;
+}
+
+/*
+ * ntfs_unlink
+ *
+ * inode_operations::unlink
+ */
+static int ntfs_unlink(struct inode *dir, struct dentry *dentry)
+{
+	struct ntfs_inode *ni = ntfs_i(dir);
+	int err;
+
+	ni_lock(ni);
+
+	err = ntfs_unlink_inode(dir, dentry);
+
+	ni_unlock(ni);
+
+	return err;
+}
+
+/*
+ * ntfs_symlink
+ *
+ * inode_operations::symlink
+ */
+static int ntfs_symlink(struct inode *dir, struct dentry *dentry,
+			const char *symname)
+{
+	int err;
+	u32 size = strlen(symname);
+	struct inode *inode;
+	struct ntfs_inode *ni = ntfs_i(dir);
+
+	ni_lock(ni);
+
+	err = ntfs_create_inode(dir, dentry, NULL, NULL, S_IFLNK | 0777, 0,
+				symname, size, 0, NULL, &inode);
+
+	ni_unlock(ni);
+
+	return err;
+}
+
+/*
+ * ntfs_mkdir
+ *
+ * inode_operations::mkdir
+ */
+static int ntfs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
+{
+	int err;
+	struct inode *inode;
+	struct ntfs_inode *ni = ntfs_i(dir);
+
+	ni_lock(ni);
+
+	err = ntfs_create_inode(dir, dentry, NULL, NULL, S_IFDIR | mode, 0,
+				NULL, -1, 0, NULL, &inode);
+
+	ni_unlock(ni);
+
+	return err;
+}
+
+/*
+ * ntfs_rmdir
+ *
+ * inode_operations::rm_dir
+ */
+static int ntfs_rmdir(struct inode *dir, struct dentry *dentry)
+{
+	struct ntfs_inode *ni = ntfs_i(dir);
+	int err;
+
+	ni_lock(ni);
+
+	err = ntfs_unlink_inode(dir, dentry);
+
+	ni_unlock(ni);
+
+	return err;
+}
+
+/*
+ * ntfs_rename
+ *
+ * inode_operations::rename
+ */
+static int ntfs_rename(struct inode *old_dir, struct dentry *old_dentry,
+		       struct inode *new_dir, struct dentry *new_dentry,
+		       u32 flags)
+{
+	int err;
+	struct super_block *sb = old_dir->i_sb;
+	struct ntfs_sb_info *sbi = sb->s_fs_info;
+	struct ntfs_inode *old_diri = ntfs_i(old_dir);
+	struct ntfs_inode *new_diri = ntfs_i(new_dir);
+	struct ntfs_inode *ni;
+	struct ATTR_FILE_NAME *old_name, *new_name, *fname;
+	u8 name_type;
+	bool is_same;
+	struct inode *old_inode, *new_inode;
+	struct NTFS_DE *old_de, *new_de;
+	struct ATTRIB *attr;
+	struct ATTR_LIST_ENTRY *le;
+	u16 new_de_key_size;
+
+	static_assert(SIZEOF_ATTRIBUTE_FILENAME_MAX + SIZEOF_RESIDENT < 1024);
+	static_assert(SIZEOF_ATTRIBUTE_FILENAME_MAX + sizeof(struct NTFS_DE) <
+		      1024);
+	static_assert(PATH_MAX >= 4 * 1024);
+
+	if (flags & ~RENAME_NOREPLACE)
+		return -EINVAL;
+
+	old_inode = d_inode(old_dentry);
+	new_inode = d_inode(new_dentry);
+
+	ni = ntfs_i(old_inode);
+
+	ni_lock(ni);
+	ni_lock(old_diri);
+
+	is_same = old_dentry->d_name.len == new_dentry->d_name.len &&
+		  !memcmp(old_dentry->d_name.name, new_dentry->d_name.name,
+			  old_dentry->d_name.len);
+
+	if (is_same && old_dir == new_dir) {
+		/* Nothing to do */
+		err = 0;
+		goto out1;
+	}
+
+	if (ntfs_is_meta_file(sbi, old_inode->i_ino)) {
+		err = -EINVAL;
+		goto out1;
+	}
+
+	if (new_inode) {
+		/*target name exists. unlink it*/
+		dget(new_dentry);
+		if (old_diri != new_diri)
+			ni_lock(new_diri);
+		err = ntfs_unlink_inode(new_dir, new_dentry);
+		if (old_diri != new_diri)
+			ni_unlock(new_diri);
+
+		dput(new_dentry);
+		if (err)
+			goto out1;
+	}
+
+	old_de = __getname();
+	if (!old_de) {
+		err = -ENOMEM;
+		goto out1;
+	}
+
+	err = fill_name_de(sbi, old_de, &old_dentry->d_name, NULL);
+	if (err < 0)
+		goto out2;
+
+	old_name = (struct ATTR_FILE_NAME *)(old_de + 1);
+
+	if (is_same) {
+		new_de = old_de;
+	} else {
+		new_de = Add2Ptr(old_de, 1024);
+		err = fill_name_de(sbi, new_de, &new_dentry->d_name, NULL);
+		if (err < 0)
+			goto out2;
+	}
+
+	old_name->home.low = cpu_to_le32(old_dir->i_ino);
+#ifdef NTFS3_64BIT_CLUSTER
+	old_name->home.high = cpu_to_le16(old_dir->i_ino >> 32);
+#endif
+	old_name->home.seq = ntfs_i(old_dir)->mi.mrec->seq;
+
+	/*get pointer to file_name in mft*/
+	fname = ni_fname_name(ni, (struct cpu_str *)&old_name->name_len,
+			      &old_name->home, &le);
+	if (!fname) {
+		err = -EINVAL;
+		goto out2;
+	}
+
+	/* Copy fname info from record into new fname */
+	new_name = (struct ATTR_FILE_NAME *)(new_de + 1);
+	memcpy(&new_name->dup, &fname->dup, sizeof(fname->dup));
+
+	name_type = paired_name(fname->type);
+
+	/* remove first name from directory */
+	err = indx_delete_entry(&old_diri->dir, old_diri, old_de + 1,
+				le16_to_cpu(old_de->key_size), sbi);
+	if (err)
+		goto out3;
+
+	/* remove first name from mft */
+	err = ni_remove_attr_le(ni, attr_from_name(fname), le);
+	if (err)
+		goto out4;
+
+	le16_add_cpu(&ni->mi.mrec->hard_links, -1);
+	ni->mi.dirty = true;
+
+	if (name_type != FILE_NAME_POSIX) {
+		/* get paired name */
+		fname = ni_fname_type(ni, name_type, &le);
+		if (fname) {
+			/* remove second name from directory */
+			err = indx_delete_entry(&old_diri->dir, old_diri, fname,
+						fname_full_size(fname), sbi);
+			if (err)
+				goto out5;
+
+			/* remove second name from mft */
+			err = ni_remove_attr_le(ni, attr_from_name(fname), le);
+			if (err)
+				goto out6;
+
+			le16_add_cpu(&ni->mi.mrec->hard_links, -1);
+			ni->mi.dirty = true;
+		}
+	}
+
+	/* Add new name */
+	new_de->ref.low = cpu_to_le32(old_inode->i_ino);
+#ifdef NTFS3_64BIT_CLUSTER
+	new_de->ref.high = cpu_to_le16(old_inode->i_ino >> 32);
+	new_name->home.high = cpu_to_le16(new_dir->i_ino >> 32);
+#endif
+	new_de->ref.seq = ni->mi.mrec->seq;
+
+	new_name->home.low = cpu_to_le32(new_dir->i_ino);
+	new_name->home.seq = ntfs_i(new_dir)->mi.mrec->seq;
+
+	new_de_key_size = le16_to_cpu(new_de->key_size);
+
+	/* insert new name in mft */
+	err = ni_insert_resident(ni, new_de_key_size, ATTR_NAME, NULL, 0, &attr,
+				 NULL);
+	if (err)
+		goto out7;
+
+	attr->res.flags = RESIDENT_FLAG_INDEXED;
+
+	memcpy(Add2Ptr(attr, SIZEOF_RESIDENT), new_name, new_de_key_size);
+
+	le16_add_cpu(&ni->mi.mrec->hard_links, 1);
+	ni->mi.dirty = true;
+
+	/* insert new name in directory */
+	err = indx_insert_entry(&new_diri->dir, new_diri, new_de, sbi, NULL);
+	if (err)
+		goto out8;
+
+	if (IS_DIRSYNC(new_dir))
+		err = ntfs_sync_inode(old_inode);
+	else
+		mark_inode_dirty(old_inode);
+
+	old_dir->i_ctime = old_dir->i_mtime = current_time(old_dir);
+	if (IS_DIRSYNC(old_dir))
+		(void)ntfs_sync_inode(old_dir);
+	else
+		mark_inode_dirty(old_dir);
+
+	if (old_dir != new_dir) {
+		new_dir->i_mtime = new_dir->i_ctime = old_dir->i_ctime;
+		mark_inode_dirty(new_dir);
+#ifdef NTFS_COUNT_CONTAINED
+		if (S_ISDIR(old_inode->i_mode)) {
+			drop_nlink(old_dir);
+			if (!new_inode)
+				inc_nlink(new_dir);
+		}
+#endif
+	}
+
+	if (old_inode) {
+		old_inode->i_ctime = old_dir->i_ctime;
+		mark_inode_dirty(old_inode);
+	}
+
+	err = 0;
+	goto out2;
+
+out8:
+	mi_remove_attr(&ni->mi, attr);
+
+out7:
+out6:
+out5:
+out4:
+	/* Undo:
+	 *err = indx_delete_entry(&old_diri->dir, old_diri, old_de + 1,
+	 *			old_de->key_size, NULL);
+	 */
+
+out3:
+out2:
+	__putname(old_de);
+out1:
+	ni_unlock(old_diri);
+	ni_unlock(ni);
+
+	return err;
+}
+
+/*
+ * ntfs_atomic_open
+ *
+ * inode_operations::atomic_open
+ */
+static int ntfs_atomic_open(struct inode *dir, struct dentry *dentry,
+			    struct file *file, u32 flags, umode_t mode)
+{
+	int err;
+	bool excl = !!(flags & O_EXCL);
+	struct inode *inode;
+	struct ntfs_fnd *fnd = NULL;
+	struct ntfs_inode *ni = ntfs_i(dir);
+	struct dentry *d = NULL;
+	struct cpu_str *uni = __getname();
+
+	if (!uni)
+		return -ENOMEM;
+
+	err = ntfs_nls_to_utf16(ni->mi.sbi, dentry->d_name.name,
+				dentry->d_name.len, uni, NTFS_NAME_LEN,
+				UTF16_HOST_ENDIAN);
+	if (err < 0)
+		goto out;
+
+	ni_lock(ni);
+
+	if (d_in_lookup(dentry)) {
+		fnd = fnd_get(&ntfs_i(dir)->dir);
+		if (!fnd) {
+			err = -ENOMEM;
+			goto out1;
+		}
+
+		d = d_splice_alias(dir_search_u(dir, uni, fnd), dentry);
+		if (IS_ERR(d)) {
+			err = PTR_ERR(d);
+			d = NULL;
+			goto out2;
+		}
+
+		if (d)
+			dentry = d;
+	}
+
+	if (!(flags & O_CREAT) || d_really_is_positive(dentry)) {
+		err = finish_no_open(file, d);
+		goto out2;
+	}
+
+	/*fnd contains tree's path to insert to*/
+	err = ntfs_create_inode(dir, dentry, uni, file, mode, 0, NULL, 0, excl,
+				fnd, &inode);
+out2:
+	fnd_put(fnd);
+out1:
+	ni_unlock(ni);
+out:
+	__putname(uni);
+
+	return err;
+}
+
+struct dentry *ntfs_get_parent(struct dentry *child)
+{
+	struct inode *inode = d_inode(child);
+	struct ntfs_inode *ni = ntfs_i(inode);
+
+	struct ATTR_LIST_ENTRY *le = NULL;
+	struct ATTRIB *attr = NULL;
+	struct ATTR_FILE_NAME *fname;
+
+	while ((attr = ni_find_attr(ni, attr, &le, ATTR_NAME, NULL, 0, NULL,
+				    NULL))) {
+		fname = resident_data_ex(attr, SIZEOF_ATTRIBUTE_FILENAME);
+		if (!fname)
+			continue;
+
+		return d_obtain_alias(
+			ntfs_iget5(inode->i_sb, &fname->home, NULL));
+	}
+
+	return ERR_PTR(-ENOENT);
+}
+
+const struct inode_operations ntfs_dir_inode_operations = {
+	.lookup = ntfs_lookup,
+	.create = ntfs_create,
+	.link = ntfs_link,
+	.unlink = ntfs_unlink,
+	.symlink = ntfs_symlink,
+	.mkdir = ntfs_mkdir,
+	.rmdir = ntfs_rmdir,
+	.rename = ntfs_rename,
+	.permission = ntfs_permission,
+	.get_acl = ntfs_get_acl,
+	.set_acl = ntfs_set_acl,
+	.setattr = ntfs_setattr,
+	.getattr = ntfs_getattr,
+	.listxattr = ntfs_listxattr,
+	.atomic_open = ntfs_atomic_open,
+	.fiemap = ntfs_fiemap,
+};
diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
new file mode 100644
index 000000000000..d96b8fd29c05
--- /dev/null
+++ b/fs/ntfs3/record.c
@@ -0,0 +1,612 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  linux/fs/ntfs3/record.c
+ *
+ * Copyright (C) 2019-2020 Paragon Software GmbH, All rights reserved.
+ *
+ */
+
+#include <linux/blkdev.h>
+#include <linux/buffer_head.h>
+#include <linux/fs.h>
+#include <linux/nls.h>
+#include <linux/sched/signal.h>
+
+#include "debug.h"
+#include "ntfs.h"
+#include "ntfs_fs.h"
+
+static inline int compare_attr(const struct ATTRIB *left, enum ATTR_TYPE type,
+			       const __le16 *name, u8 name_len,
+			       const u16 *upcase)
+{
+	/* First, compare the type codes: */
+	int diff = le32_to_cpu(left->type) - le32_to_cpu(type);
+
+	if (diff)
+		return diff;
+
+	/*
+	 * They have the same type code, so we have to compare the names.
+	 * First compare case insensitive
+	 */
+	diff = ntfs_cmp_names(attr_name(left), left->name_len, name, name_len,
+			      upcase);
+	if (diff)
+		return diff;
+
+	/* Second compare case sensitive */
+	return ntfs_cmp_names(attr_name(left), left->name_len, name, name_len,
+			      NULL);
+}
+
+/*
+ * mi_new_attt_id
+ *
+ * returns unused attribute id that is less than mrec->next_attr_id
+ */
+static __le16 mi_new_attt_id(struct mft_inode *mi)
+{
+	u16 free_id, max_id, t16;
+	struct MFT_REC *rec = mi->mrec;
+	struct ATTRIB *attr;
+	__le16 id;
+
+	id = rec->next_attr_id;
+	free_id = le16_to_cpu(id);
+	if (free_id < 0x7FFF) {
+		rec->next_attr_id = cpu_to_le16(free_id + 1);
+		return id;
+	}
+
+	/* One record can store up to 1024/24 ~= 42 attributes */
+	free_id = 0;
+	max_id = 0;
+
+	attr = NULL;
+
+	for (;;) {
+		attr = mi_enum_attr(mi, attr);
+		if (!attr) {
+			rec->next_attr_id = cpu_to_le16(max_id + 1);
+			mi->dirty = true;
+			return cpu_to_le16(free_id);
+		}
+
+		t16 = le16_to_cpu(attr->id);
+		if (t16 == free_id) {
+			free_id += 1;
+			attr = NULL;
+		} else if (max_id < t16)
+			max_id = t16;
+	}
+}
+
+int mi_get(struct ntfs_sb_info *sbi, CLST rno, struct mft_inode **mi)
+{
+	int err;
+	struct mft_inode *m = ntfs_alloc(sizeof(struct mft_inode), 1);
+
+	if (!m)
+		return -ENOMEM;
+
+	err = mi_init(m, sbi, rno);
+	if (!err)
+		err = mi_read(m, false);
+
+	if (err) {
+		mi_put(m);
+		return err;
+	}
+
+	*mi = m;
+	return 0;
+}
+
+void mi_put(struct mft_inode *mi)
+{
+	mi_clear(mi);
+	ntfs_free(mi);
+}
+
+int mi_init(struct mft_inode *mi, struct ntfs_sb_info *sbi, CLST rno)
+{
+	mi->sbi = sbi;
+	mi->rno = rno;
+	mi->mrec = ntfs_alloc(sbi->record_size, 0);
+	if (!mi->mrec)
+		return -ENOMEM;
+
+	return 0;
+}
+
+/*
+ * mi_read
+ *
+ * reads MFT data
+ */
+int mi_read(struct mft_inode *mi, bool is_mft)
+{
+	int err;
+	struct MFT_REC *rec = mi->mrec;
+	struct ntfs_sb_info *sbi = mi->sbi;
+	u32 bpr = sbi->record_size;
+	u64 vbo = (u64)mi->rno << sbi->record_bits;
+	struct ntfs_inode *mft_ni = sbi->mft.ni;
+	struct runs_tree *run = mft_ni ? &mft_ni->file.run : NULL;
+	struct rw_semaphore *rw_lock = NULL;
+
+	if (is_mounted(sbi)) {
+		if (!is_mft) {
+			rw_lock = &mft_ni->file.run_lock;
+			down_read(rw_lock);
+		}
+	}
+
+	err = ntfs_read_bh(sbi, run, vbo, &rec->rhdr, bpr, &mi->nb);
+	if (rw_lock)
+		up_read(rw_lock);
+	if (!err)
+		goto ok;
+
+	if (err == 1) {
+		mi->dirty = true;
+		goto ok;
+	}
+
+	if (err != -ENOENT)
+		goto out;
+
+	if (rw_lock) {
+		ni_lock(mft_ni);
+		down_write(rw_lock);
+	}
+	err = attr_load_runs_vcn(mft_ni, ATTR_DATA, NULL, 0, &mft_ni->file.run,
+				 vbo >> sbi->cluster_bits);
+	if (rw_lock) {
+		up_write(rw_lock);
+		ni_unlock(mft_ni);
+	}
+	if (err)
+		goto out;
+
+	if (rw_lock)
+		down_read(rw_lock);
+	err = ntfs_read_bh(sbi, run, vbo, &rec->rhdr, bpr, &mi->nb);
+	if (rw_lock)
+		up_read(rw_lock);
+
+	if (err == 1) {
+		mi->dirty = true;
+		goto ok;
+	}
+	if (err)
+		goto out;
+
+ok:
+	/* check field 'total' only here */
+	if (le32_to_cpu(rec->total) != bpr) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	return 0;
+
+out:
+	return err;
+}
+
+struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
+{
+	const struct MFT_REC *rec = mi->mrec;
+	u32 used = le32_to_cpu(rec->used);
+	u32 t32, off, asize;
+	u16 t16;
+
+	if (!attr) {
+		u32 total = le32_to_cpu(rec->total);
+
+		off = le16_to_cpu(rec->attr_off);
+
+		if (used > total)
+			goto out;
+
+		if (off >= used || off < MFTRECORD_FIXUP_OFFSET_1 ||
+		    !IsDwordAligned(off)) {
+			goto out;
+		}
+
+		/* Skip non-resident records */
+		if (!is_rec_inuse(rec))
+			goto out;
+
+		attr = Add2Ptr(rec, off);
+	} else {
+		/* Check if input attr inside record */
+		off = PtrOffset(rec, attr);
+		if (off >= used)
+			goto out;
+
+		asize = le32_to_cpu(attr->size);
+		if (asize < SIZEOF_RESIDENT)
+			goto out;
+
+		attr = Add2Ptr(attr, asize);
+		off += asize;
+	}
+
+	asize = le32_to_cpu(attr->size);
+
+	/* Can we use the first field (attr->type) */
+	if (off + 8 > used) {
+		static_assert(QuadAlign(sizeof(enum ATTR_TYPE)) == 8);
+		goto out;
+	}
+
+	if (attr->type == ATTR_END) {
+		if (used != off + 8)
+			goto out;
+		return NULL;
+	}
+
+	t32 = le32_to_cpu(attr->type);
+	if ((t32 & 0xf) || (t32 > 0x100))
+		goto out;
+
+	/* Check boundary */
+	if (off + asize > used)
+		goto out;
+
+	/* Check size of attribute */
+	if (!attr->non_res) {
+		if (asize < SIZEOF_RESIDENT)
+			goto out;
+
+		t16 = le16_to_cpu(attr->res.data_off);
+
+		if (t16 > asize)
+			goto out;
+
+		t32 = le32_to_cpu(attr->res.data_size);
+		if (t16 + t32 > asize)
+			goto out;
+
+		return attr;
+	}
+
+	/* Check some nonresident fields */
+	if (attr->name_len &&
+	    le16_to_cpu(attr->name_off) + sizeof(short) * attr->name_len >
+		    le16_to_cpu(attr->nres.run_off)) {
+		goto out;
+	}
+
+	if (attr->nres.svcn || !is_attr_ext(attr)) {
+		if (asize + 8 < SIZEOF_NONRESIDENT)
+			goto out;
+
+		if (attr->nres.c_unit)
+			goto out;
+	} else if (asize + 8 < SIZEOF_NONRESIDENT_EX)
+		goto out;
+
+	return attr;
+
+out:
+	return NULL;
+}
+
+/*
+ * mi_find_attr
+ *
+ * finds the attribute by type and name and id
+ */
+struct ATTRIB *mi_find_attr(struct mft_inode *mi, struct ATTRIB *attr,
+			    enum ATTR_TYPE type, const __le16 *name,
+			    size_t name_len, const __le16 *id)
+{
+	u32 type_in = le32_to_cpu(type);
+	u32 atype;
+
+next_attr:
+	attr = mi_enum_attr(mi, attr);
+	if (!attr)
+		return NULL;
+
+	atype = le32_to_cpu(attr->type);
+	if (atype > type_in)
+		return NULL;
+
+	if (atype < type_in)
+		goto next_attr;
+
+	if (attr->name_len != name_len)
+		goto next_attr;
+
+	if (name_len && memcmp(attr_name(attr), name, name_len * sizeof(short)))
+		goto next_attr;
+
+	if (id && *id != attr->id)
+		goto next_attr;
+
+	return attr;
+}
+
+int mi_write(struct mft_inode *mi, int wait)
+{
+	struct MFT_REC *rec;
+	int err;
+	struct ntfs_sb_info *sbi;
+
+	if (!mi->dirty)
+		return 0;
+
+	sbi = mi->sbi;
+	rec = mi->mrec;
+
+	err = ntfs_write_bh(sbi, &rec->rhdr, &mi->nb, wait);
+	if (err)
+		return err;
+
+	mi->dirty = false;
+
+	return 0;
+}
+
+int mi_format_new(struct mft_inode *mi, struct ntfs_sb_info *sbi, CLST rno,
+		  __le16 flags, bool is_mft)
+{
+	int err;
+	u16 seq = 1;
+	struct MFT_REC *rec;
+	u64 vbo = (u64)rno << sbi->record_bits;
+
+	err = mi_init(mi, sbi, rno);
+	if (err)
+		return err;
+
+	rec = mi->mrec;
+
+	if (rno == MFT_REC_MFT) {
+		;
+	} else if (rno < MFT_REC_FREE) {
+		seq = rno;
+	} else if (rno >= sbi->mft.used) {
+		;
+	} else if (mi_read(mi, is_mft)) {
+		;
+	} else if (rec->rhdr.sign == NTFS_FILE_SIGNATURE) {
+		/* Record is reused. Update its sequence number */
+		seq = le16_to_cpu(rec->seq) + 1;
+		if (!seq)
+			seq = 1;
+	}
+
+	memcpy(rec, sbi->new_rec, sbi->record_size);
+
+	rec->seq = cpu_to_le16(seq);
+	rec->flags = RECORD_FLAG_IN_USE | flags;
+
+	mi->dirty = true;
+
+	if (!mi->nb.nbufs) {
+		struct ntfs_inode *ni = sbi->mft.ni;
+		bool lock = false;
+
+		if (is_mounted(sbi) && !is_mft) {
+			down_read(&ni->file.run_lock);
+			lock = true;
+		}
+
+		err = ntfs_get_bh(sbi, &ni->file.run, vbo, sbi->record_size,
+				  &mi->nb);
+		if (lock)
+			up_read(&ni->file.run_lock);
+	}
+
+	return err;
+}
+
+/*
+ * mi_mark_free
+ *
+ * marks record as unused and marks it as free in bitmap
+ */
+void mi_mark_free(struct mft_inode *mi)
+{
+	CLST rno = mi->rno;
+	struct ntfs_sb_info *sbi = mi->sbi;
+
+	if (rno >= MFT_REC_RESERVED && rno < MFT_REC_FREE) {
+		ntfs_clear_mft_tail(sbi, rno, rno + 1);
+		mi->dirty = false;
+		return;
+	}
+
+	if (mi->mrec) {
+		clear_rec_inuse(mi->mrec);
+		mi->dirty = true;
+		mi_write(mi, 0);
+	}
+	ntfs_mark_rec_free(sbi, rno);
+}
+
+/*
+ * mi_insert_attr
+ *
+ * reserves space for new attribute
+ * returns not full constructed attribute or NULL if not possible to create
+ */
+struct ATTRIB *mi_insert_attr(struct mft_inode *mi, enum ATTR_TYPE type,
+			      const __le16 *name, u8 name_len, u32 asize,
+			      u16 name_off)
+{
+	size_t tail;
+	struct ATTRIB *attr;
+	__le16 id;
+	struct MFT_REC *rec = mi->mrec;
+	struct ntfs_sb_info *sbi = mi->sbi;
+	u32 used = le32_to_cpu(rec->used);
+	const u16 *upcase = sbi->upcase;
+	int diff;
+
+	/* Can we insert mi attribute? */
+	if (used + asize > mi->sbi->record_size)
+		return NULL;
+
+	/*
+	 * Scan through the list of attributes to find the point
+	 * at which we should insert it.
+	 */
+	attr = NULL;
+	while ((attr = mi_enum_attr(mi, attr))) {
+		diff = compare_attr(attr, type, name, name_len, upcase);
+		if (diff > 0)
+			break;
+		if (diff < 0)
+			continue;
+
+		if (!is_attr_indexed(attr))
+			return NULL;
+		break;
+	}
+
+	if (!attr) {
+		tail = 8; /* not used, just to suppress warning */
+		attr = Add2Ptr(rec, used - 8);
+	} else {
+		tail = used - PtrOffset(rec, attr);
+	}
+
+	id = mi_new_attt_id(mi);
+
+	memmove(Add2Ptr(attr, asize), attr, tail);
+	memset(attr, 0, asize);
+
+	attr->type = type;
+	attr->size = cpu_to_le32(asize);
+	attr->name_len = name_len;
+	attr->name_off = cpu_to_le16(name_off);
+	attr->id = id;
+
+	memmove(Add2Ptr(attr, name_off), name, name_len * sizeof(short));
+	rec->used = cpu_to_le32(used + asize);
+
+	mi->dirty = true;
+
+	return attr;
+}
+
+/*
+ * mi_remove_attr
+ *
+ * removes the attribute from record
+ * NOTE: The source attr will point to next attribute
+ */
+bool mi_remove_attr(struct mft_inode *mi, struct ATTRIB *attr)
+{
+	struct MFT_REC *rec = mi->mrec;
+	u32 aoff = PtrOffset(rec, attr);
+	u32 used = le32_to_cpu(rec->used);
+	u32 asize = le32_to_cpu(attr->size);
+
+	if (aoff + asize > used)
+		return false;
+
+	used -= asize;
+	memmove(attr, Add2Ptr(attr, asize), used - aoff);
+	rec->used = cpu_to_le32(used);
+	mi->dirty = true;
+
+	return true;
+}
+
+bool mi_resize_attr(struct mft_inode *mi, struct ATTRIB *attr, int bytes)
+{
+	struct MFT_REC *rec = mi->mrec;
+	u32 aoff = PtrOffset(rec, attr);
+	u32 total, used = le32_to_cpu(rec->used);
+	u32 nsize, asize = le32_to_cpu(attr->size);
+	u32 rsize = le32_to_cpu(attr->res.data_size);
+	int tail = (int)(used - aoff - asize);
+	int dsize;
+	char *next;
+
+	if (tail < 0 || aoff >= used)
+		return false;
+
+	if (!bytes)
+		return true;
+
+	total = le32_to_cpu(rec->total);
+	next = Add2Ptr(attr, asize);
+
+	if (bytes > 0) {
+		dsize = QuadAlign(bytes);
+		if (used + dsize > total)
+			return false;
+		nsize = asize + dsize;
+		// move tail
+		memmove(next + dsize, next, tail);
+		memset(next, 0, dsize);
+		used += dsize;
+		rsize += dsize;
+	} else {
+		dsize = QuadAlign(-bytes);
+		if (dsize > asize)
+			return false;
+		nsize = asize - dsize;
+		memmove(next - dsize, next, tail);
+		used -= dsize;
+		rsize -= dsize;
+	}
+
+	rec->used = cpu_to_le32(used);
+	attr->size = cpu_to_le32(nsize);
+	if (!attr->non_res)
+		attr->res.data_size = cpu_to_le32(rsize);
+	mi->dirty = true;
+
+	return true;
+}
+
+int mi_pack_runs(struct mft_inode *mi, struct ATTRIB *attr,
+		 struct runs_tree *run, CLST len)
+{
+	int err = 0;
+	struct ntfs_sb_info *sbi = mi->sbi;
+	u32 new_run_size;
+	CLST plen;
+	struct MFT_REC *rec = mi->mrec;
+	CLST svcn = le64_to_cpu(attr->nres.svcn);
+	u32 used = le32_to_cpu(rec->used);
+	u32 aoff = PtrOffset(rec, attr);
+	u32 asize = le32_to_cpu(attr->size);
+	char *next = Add2Ptr(attr, asize);
+	u16 run_off = le16_to_cpu(attr->nres.run_off);
+	u32 run_size = asize - run_off;
+	u32 tail = used - aoff - asize;
+	u32 dsize = sbi->record_size - used;
+
+	/* Make a maximum gap in current record */
+	memmove(next + dsize, next, tail);
+
+	/* Pack as much as possible */
+	err = run_pack(run, svcn, len, Add2Ptr(attr, run_off), run_size + dsize,
+		       &plen);
+	if (err < 0) {
+		memmove(next, next + dsize, tail);
+		return err;
+	}
+
+	new_run_size = QuadAlign(err);
+
+	memmove(next + new_run_size - run_size, next + dsize, tail);
+
+	attr->size = cpu_to_le32(asize + new_run_size - run_size);
+	attr->nres.evcn = cpu_to_le64(svcn + plen - 1);
+	rec->used = cpu_to_le32(used + new_run_size - run_size);
+	mi->dirty = true;
+
+	return 0;
+}
diff --git a/fs/ntfs3/run.c b/fs/ntfs3/run.c
new file mode 100644
index 000000000000..b559122bbeab
--- /dev/null
+++ b/fs/ntfs3/run.c
@@ -0,0 +1,1156 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  linux/fs/ntfs3/run.c
+ *
+ * Copyright (C) 2019-2020 Paragon Software GmbH, All rights reserved.
+ *
+ */
+
+#include <linux/blkdev.h>
+#include <linux/buffer_head.h>
+#include <linux/fs.h>
+#include <linux/nls.h>
+
+#include "debug.h"
+#include "ntfs.h"
+#include "ntfs_fs.h"
+
+struct ntfs_run {
+	CLST vcn; /* virtual cluster number */
+	CLST len; /* length in clusters */
+	CLST lcn; /* logical cluster number */
+};
+
+/*
+ * run_lookup
+ *
+ * Lookup the index of a MCB entry that is first <= vcn.
+ * case of success it will return non-zero value and set
+ * 'index' parameter to index of entry been found.
+ * case of entry missing from list 'index' will be set to
+ * point to insertion position for the entry question.
+ */
+bool run_lookup(const struct runs_tree *run, CLST vcn, size_t *index)
+{
+	size_t min_idx, max_idx, mid_idx;
+	struct ntfs_run *r;
+
+	if (!run->count) {
+		*index = 0;
+		return false;
+	}
+
+	min_idx = 0;
+	max_idx = run->count - 1;
+
+	/* Check boundary cases specially, 'cause they cover the often requests */
+	r = run->runs_;
+	if (vcn < r->vcn) {
+		*index = 0;
+		return false;
+	}
+
+	if (vcn < r->vcn + r->len) {
+		*index = 0;
+		return true;
+	}
+
+	r += max_idx;
+	if (vcn >= r->vcn + r->len) {
+		*index = run->count;
+		return false;
+	}
+
+	if (vcn >= r->vcn) {
+		*index = max_idx;
+		return true;
+	}
+
+	do {
+		mid_idx = min_idx + ((max_idx - min_idx) >> 1);
+		r = run->runs_ + mid_idx;
+
+		if (vcn < r->vcn) {
+			max_idx = mid_idx - 1;
+			if (!mid_idx)
+				break;
+		} else if (vcn >= r->vcn + r->len) {
+			min_idx = mid_idx + 1;
+		} else {
+			*index = mid_idx;
+			return true;
+		}
+	} while (min_idx <= max_idx);
+
+	*index = max_idx + 1;
+	return false;
+}
+
+/*
+ * run_consolidate
+ *
+ * consolidate runs starting from a given one.
+ */
+static void run_consolidate(struct runs_tree *run, size_t index)
+{
+	size_t i;
+	struct ntfs_run *r = run->runs_ + index;
+
+	while (index + 1 < run->count) {
+		/*
+		 * I should merge current run with next
+		 * if start of the next run lies inside one being tested.
+		 */
+		struct ntfs_run *n = r + 1;
+		CLST end = r->vcn + r->len;
+		CLST dl;
+
+		/* Stop if runs are not aligned one to another. */
+		if (n->vcn > end)
+			break;
+
+		dl = end - n->vcn;
+
+		/*
+		 * If range at index overlaps with next one
+		 * then I will either adjust it's start position
+		 * or (if completely matches) dust remove one from the list.
+		 */
+		if (dl > 0) {
+			if (n->len <= dl)
+				goto remove_next_range;
+
+			n->len -= dl;
+			n->vcn += dl;
+			if (n->lcn != SPARSE_LCN)
+				n->lcn += dl;
+		}
+
+		/*
+		 * Stop if sparse mode does not match
+		 * both current and next runs.
+		 */
+		if ((n->lcn == SPARSE_LCN) != (r->lcn == SPARSE_LCN)) {
+			index += 1;
+			r = n;
+			continue;
+		}
+
+		/*
+		 * Check if volume block
+		 * of a next run lcn does not match
+		 * last volume block of the current run.
+		 */
+		if (n->lcn != SPARSE_LCN && n->lcn != r->lcn + r->len)
+			break;
+
+		/*
+		 * Next and current are siblings.
+		 * Eat/join.
+		 */
+		r->len += n->len - dl;
+
+remove_next_range:
+		i = run->count - (index + 1);
+		if (i > 1)
+			memmove(n, n + 1, sizeof(*n) * (i - 1));
+
+		run->count -= 1;
+	}
+}
+
+bool run_is_mapped_full(const struct runs_tree *run, CLST svcn, CLST evcn)
+{
+	size_t index;
+
+	if (!run_lookup(run, svcn, &index))
+		return false;
+
+	do {
+		const struct ntfs_run *m = run->runs_ + index;
+		CLST end = m->vcn + m->len;
+
+		if (end > evcn)
+			return true;
+	} while (++index < run->count);
+
+	return false;
+}
+
+bool run_lookup_entry(const struct runs_tree *run, CLST vcn, CLST *lcn,
+		      CLST *len, size_t *index)
+{
+	size_t idx;
+	CLST gap;
+	struct ntfs_run *r;
+
+	/* Fail immediately if nrun was not touched yet. */
+	if (!run->runs_)
+		return false;
+
+	if (!run_lookup(run, vcn, &idx))
+		return false;
+
+	r = run->runs_ + idx;
+
+	if (vcn >= r->vcn + r->len)
+		return false;
+
+	gap = vcn - r->vcn;
+	if (r->len <= gap)
+		return false;
+
+	*lcn = r->lcn == SPARSE_LCN ? SPARSE_LCN : (r->lcn + gap);
+
+	if (len)
+		*len = r->len - gap;
+	if (index)
+		*index = idx;
+
+	return true;
+}
+
+/*
+ * run_truncate_head
+ *
+ * decommit the range before vcn
+ */
+void run_truncate_head(struct runs_tree *run, CLST vcn)
+{
+	size_t index;
+	struct ntfs_run *r;
+
+	if (run_lookup(run, vcn, &index)) {
+		r = run->runs_ + index;
+
+		if (vcn > r->vcn) {
+			CLST dlen = vcn - r->vcn;
+
+			r->vcn = vcn;
+			r->len -= dlen;
+			if (r->lcn != SPARSE_LCN)
+				r->lcn += dlen;
+		}
+
+		if (!index)
+			return;
+	}
+	r = run->runs_;
+	memmove(r, r + index, sizeof(*r) * (run->count - index));
+
+	run->count -= index;
+
+	if (!run->count) {
+		ntfs_free(run->runs_);
+		run->runs_ = NULL;
+		run->allocated = 0;
+	}
+}
+
+/*
+ * run_truncate
+ *
+ * decommit the range after vcn
+ */
+void run_truncate(struct runs_tree *run, CLST vcn)
+{
+	size_t index;
+
+	/*
+	 * If I hit the range then
+	 * I have to truncate one.
+	 * If range to be truncated is becoming empty
+	 * then it will entirely be removed.
+	 */
+	if (run_lookup(run, vcn, &index)) {
+		struct ntfs_run *r = run->runs_ + index;
+
+		r->len = vcn - r->vcn;
+
+		if (r->len > 0)
+			index += 1;
+	}
+
+	/*
+	 * At this point 'index' is set to
+	 * position that should be thrown away (including index itself)
+	 * Simple one - just set the limit.
+	 */
+	run->count = index;
+
+	/* Do not reallocate array 'runs'. Only free if possible */
+	if (!index) {
+		ntfs_free(run->runs_);
+		run->runs_ = NULL;
+		run->allocated = 0;
+	}
+}
+
+/*
+ * run_add_entry
+ *
+ * sets location to known state.
+ * run to be added may overlap with existing location.
+ * returns false if of memory
+ */
+bool run_add_entry(struct runs_tree *run, CLST vcn, CLST lcn, CLST len)
+{
+	size_t used, index;
+	struct ntfs_run *r;
+	bool inrange;
+	CLST tail_vcn = 0, tail_len = 0, tail_lcn = 0;
+	bool should_add_tail = false;
+
+	/*
+	 * Lookup the insertion point.
+	 *
+	 * Execute bsearch for the entry containing
+	 * start position question.
+	 */
+	inrange = run_lookup(run, vcn, &index);
+
+	/*
+	 * Shortcut here would be case of
+	 * range not been found but one been added
+	 * continues previous run.
+	 * this case I can directly make use of
+	 * existing range as my start point.
+	 */
+	if (!inrange && index > 0) {
+		struct ntfs_run *t = run->runs_ + index - 1;
+
+		if (t->vcn + t->len == vcn &&
+		    (t->lcn == SPARSE_LCN) == (lcn == SPARSE_LCN) &&
+		    (lcn == SPARSE_LCN || lcn == t->lcn + t->len)) {
+			inrange = true;
+			index -= 1;
+		}
+	}
+
+	/*
+	 * At this point 'index' either points to the range
+	 * containing start position or to the insertion position
+	 * for a new range.
+	 * So first let's check if range I'm probing is here already.
+	 */
+	if (!inrange) {
+requires_new_range:
+		/*
+		 * Range was not found.
+		 * Insert at position 'index'
+		 */
+		used = run->count * sizeof(struct ntfs_run);
+
+		/*
+		 * Check allocated space.
+		 * If one is not enough to get one more entry
+		 * then it will be reallocated
+		 */
+		if (run->allocated < used + sizeof(struct ntfs_run)) {
+			size_t bytes;
+			struct ntfs_run *new_ptr;
+
+			/* Use power of 2 for 'bytes'*/
+			if (!used) {
+				bytes = 64;
+			} else if (used <= 16 * PAGE_SIZE) {
+				if (is_power_of2(run->allocated))
+					bytes = run->allocated << 1;
+				else
+					bytes = (size_t)1
+						<< (2 + blksize_bits(used));
+			} else {
+				bytes = run->allocated + (16 * PAGE_SIZE);
+			}
+
+			new_ptr = ntfs_alloc(bytes, 0);
+			if (!new_ptr)
+				return false;
+
+			r = new_ptr + index;
+			memcpy(new_ptr, run->runs_,
+			       index * sizeof(struct ntfs_run));
+			memcpy(r + 1, run->runs_ + index,
+			       sizeof(struct ntfs_run) * (run->count - index));
+
+			ntfs_free(run->runs_);
+			run->runs_ = new_ptr;
+			run->allocated = bytes;
+
+		} else {
+			size_t i = run->count - index;
+
+			r = run->runs_ + index;
+
+			/* memmove appears to be a bottle neck here... */
+			if (i > 0)
+				memmove(r + 1, r, sizeof(struct ntfs_run) * i);
+		}
+
+		r->vcn = vcn;
+		r->lcn = lcn;
+		r->len = len;
+		run->count += 1;
+	} else {
+		r = run->runs_ + index;
+
+		/*
+		 * If one of ranges was not allocated
+		 * then I have to split location I just matched.
+		 * and insert current one
+		 * a common case this requires tail to be reinserted
+		 * a recursive call.
+		 */
+		if (((lcn == SPARSE_LCN) != (r->lcn == SPARSE_LCN)) ||
+		    (lcn != SPARSE_LCN && lcn != r->lcn + (vcn - r->vcn))) {
+			CLST to_eat = vcn - r->vcn;
+			CLST Tovcn = to_eat + len;
+
+			should_add_tail = Tovcn < r->len;
+
+			if (should_add_tail) {
+				tail_lcn = r->lcn == SPARSE_LCN ?
+						   SPARSE_LCN :
+						   (r->lcn + Tovcn);
+				tail_vcn = r->vcn + Tovcn;
+				tail_len = r->len - Tovcn;
+			}
+
+			if (to_eat > 0) {
+				r->len = to_eat;
+				inrange = false;
+				index += 1;
+				goto requires_new_range;
+			}
+
+			/* lcn should match one I'm going to add. */
+			r->lcn = lcn;
+		}
+
+		/*
+		 * If existing range fits then I'm done.
+		 * Otherwise extend found one and fall back to range jocode.
+		 */
+		if (r->vcn + r->len < vcn + len)
+			r->len += len - ((r->vcn + r->len) - vcn);
+	}
+
+	/*
+	 * And normalize it starting from insertion point.
+	 * It's possible that no insertion needed case if
+	 * start point lies withthe range of an entry
+	 * that 'index' points to.
+	 */
+	if (inrange && index > 0)
+		index -= 1;
+	run_consolidate(run, index);
+	run_consolidate(run, index + 1);
+
+	/*
+	 * a special case
+	 * I have to add extra range a tail.
+	 */
+	if (should_add_tail &&
+	    !run_add_entry(run, tail_vcn, tail_lcn, tail_len))
+		return false;
+
+	return true;
+}
+
+/*
+ * run_get_entry
+ *
+ * returns index-th mapped region
+ */
+bool run_get_entry(const struct runs_tree *run, size_t index, CLST *vcn,
+		   CLST *lcn, CLST *len)
+{
+	const struct ntfs_run *r;
+
+	if (index >= run->count)
+		return false;
+
+	r = run->runs_ + index;
+
+	if (!r->len)
+		return false;
+
+	if (vcn)
+		*vcn = r->vcn;
+	if (lcn)
+		*lcn = r->lcn;
+	if (len)
+		*len = r->len;
+	return true;
+}
+
+/*
+ * run_packed_size
+ *
+ * calculates the size of packed int64
+ */
+static inline int run_packed_size(const s64 *n)
+{
+#ifdef __BIG_ENDIAN
+	const u8 *p = (const u8 *)n + sizeof(*n) - 1;
+
+	if (*n >= 0) {
+		if (p[-7] || p[-6] || p[-5] || p[-4])
+			p -= 4;
+		if (p[-3] || p[-2])
+			p -= 2;
+		if (p[-1])
+			p -= 1;
+		if (p[0] & 0x80)
+			p -= 1;
+	} else {
+		if (p[-7] != 0xff || p[-6] != 0xff || p[-5] != 0xff ||
+		    p[-4] != 0xff)
+			p -= 4;
+		if (p[-3] != 0xff || p[-2] != 0xff)
+			p -= 2;
+		if (p[-1] != 0xff)
+			p -= 1;
+		if (!(p[0] & 0x80))
+			p -= 1;
+	}
+	return (const u8 *)n + sizeof(*n) - p;
+#else
+	const u8 *p = (const u8 *)n;
+
+	if (*n >= 0) {
+		if (p[7] || p[6] || p[5] || p[4])
+			p += 4;
+		if (p[3] || p[2])
+			p += 2;
+		if (p[1])
+			p += 1;
+		if (p[0] & 0x80)
+			p += 1;
+	} else {
+		if (p[7] != 0xff || p[6] != 0xff || p[5] != 0xff ||
+		    p[4] != 0xff)
+			p += 4;
+		if (p[3] != 0xff || p[2] != 0xff)
+			p += 2;
+		if (p[1] != 0xff)
+			p += 1;
+		if (!(p[0] & 0x80))
+			p += 1;
+	}
+
+	return 1 + p - (const u8 *)n;
+#endif
+}
+
+/*
+ * run_pack
+ *
+ * packs runs into buffer
+ * packed_vcns - how much runs we have packed
+ * packed_size - how much bytes we have used run_buf
+ */
+int run_pack(const struct runs_tree *run, CLST svcn, CLST len, u8 *run_buf,
+	     u32 run_buf_size, CLST *packed_vcns)
+{
+	CLST next_vcn, vcn, lcn;
+	CLST prev_lcn = 0;
+	CLST evcn1 = svcn + len;
+	int packed_size = 0;
+	size_t i;
+	bool ok;
+	s64 dlcn, len64;
+	int offset_size, size_size, t;
+	const u8 *p;
+
+	next_vcn = vcn = svcn;
+
+	*packed_vcns = 0;
+
+	if (!len)
+		goto out;
+
+	ok = run_lookup_entry(run, vcn, &lcn, &len, &i);
+
+	if (!ok)
+		goto error;
+
+	if (next_vcn != vcn)
+		goto error;
+
+	for (;;) {
+		/* offset of current fragment relatively to previous fragment */
+		dlcn = 0;
+		next_vcn = vcn + len;
+
+		if (next_vcn > evcn1)
+			len = evcn1 - vcn;
+
+		/*
+		 * mirror of len, but signed, because run_packed_size()
+		 * works with signed int only
+		 */
+		len64 = len;
+
+		/* how much bytes is packed len64 */
+		size_size = run_packed_size(&len64);
+
+		/* offset_size - how much bytes is packed dlcn */
+		if (lcn == SPARSE_LCN) {
+			offset_size = 0;
+		} else {
+			/* NOTE: lcn can be less than prev_lcn! */
+			dlcn = (s64)lcn - prev_lcn;
+			offset_size = run_packed_size(&dlcn);
+			prev_lcn = lcn;
+		}
+
+		t = run_buf_size - packed_size - 2 - offset_size;
+		if (t <= 0)
+			goto out;
+
+		/* can we store this entire run */
+		if (t < size_size)
+			goto out;
+
+		if (run_buf) {
+			p = (u8 *)&len64;
+
+			/* pack run header */
+			run_buf[0] = ((u8)(size_size | (offset_size << 4)));
+			run_buf += 1;
+
+			/* Pack the length of run */
+			switch (size_size) {
+#ifdef __BIG_ENDIAN
+			case 8:
+				run_buf[7] = p[0];
+				fallthrough;
+			case 7:
+				run_buf[6] = p[1];
+				fallthrough;
+			case 6:
+				run_buf[5] = p[2];
+				fallthrough;
+			case 5:
+				run_buf[4] = p[3];
+				fallthrough;
+			case 4:
+				run_buf[3] = p[4];
+				fallthrough;
+			case 3:
+				run_buf[2] = p[5];
+				fallthrough;
+			case 2:
+				run_buf[1] = p[6];
+				fallthrough;
+			case 1:
+				run_buf[0] = p[7];
+#else
+			case 8:
+				run_buf[7] = p[7];
+				fallthrough;
+			case 7:
+				run_buf[6] = p[6];
+				fallthrough;
+			case 6:
+				run_buf[5] = p[5];
+				fallthrough;
+			case 5:
+				run_buf[4] = p[4];
+				fallthrough;
+			case 4:
+				run_buf[3] = p[3];
+				fallthrough;
+			case 3:
+				run_buf[2] = p[2];
+				fallthrough;
+			case 2:
+				run_buf[1] = p[1];
+				fallthrough;
+			case 1:
+				run_buf[0] = p[0];
+#endif
+			}
+
+			run_buf += size_size;
+			p = (u8 *)&dlcn;
+
+			/* Pack the offset from previous lcn */
+			switch (offset_size) {
+#ifdef __BIG_ENDIAN
+			case 8:
+				run_buf[7] = p[0];
+				fallthrough;
+			case 7:
+				run_buf[6] = p[1];
+				fallthrough;
+			case 6:
+				run_buf[5] = p[2];
+				fallthrough;
+			case 5:
+				run_buf[4] = p[3];
+				fallthrough;
+			case 4:
+				run_buf[3] = p[4];
+				fallthrough;
+			case 3:
+				run_buf[2] = p[5];
+				fallthrough;
+			case 2:
+				run_buf[1] = p[6];
+				fallthrough;
+			case 1:
+				run_buf[0] = p[7];
+#else
+			case 8:
+				run_buf[7] = p[7];
+				fallthrough;
+			case 7:
+				run_buf[6] = p[6];
+				fallthrough;
+			case 6:
+				run_buf[5] = p[5];
+				fallthrough;
+			case 5:
+				run_buf[4] = p[4];
+				fallthrough;
+			case 4:
+				run_buf[3] = p[3];
+				fallthrough;
+			case 3:
+				run_buf[2] = p[2];
+				fallthrough;
+			case 2:
+				run_buf[1] = p[1];
+				fallthrough;
+			case 1:
+				run_buf[0] = p[0];
+#endif
+			}
+
+			run_buf += offset_size;
+		}
+
+		packed_size += 1 + offset_size + size_size;
+		*packed_vcns += len;
+
+		if (packed_size + 1 >= run_buf_size || next_vcn >= evcn1)
+			goto out;
+
+		ok = run_get_entry(run, ++i, &vcn, &lcn, &len);
+		if (!ok)
+			goto error;
+
+		if (next_vcn != vcn)
+			goto error;
+	}
+
+out:
+	/* Store last zero */
+	if (run_buf)
+		run_buf[0] = 0;
+
+	return packed_size + 1;
+
+error:
+	return -EOPNOTSUPP;
+}
+
+/*
+ * run_unpack
+ *
+ * unpacks packed runs from "run_buf"
+ * returns error, if negative, or real used bytes
+ */
+int run_unpack(struct runs_tree *run, struct ntfs_sb_info *sbi, CLST ino,
+	       CLST svcn, CLST evcn, const u8 *run_buf, u32 run_buf_size)
+{
+	u64 prev_lcn, vcn;
+	const u8 *run_last, *run_0;
+	u64 lcn;
+	/* size_size - how much bytes is packed len */
+	u8 size_size;
+	u64 next_vcn;
+
+	/* Check for empty */
+	if (evcn + 1 == svcn)
+		return 0;
+
+	if (evcn < svcn)
+		return -EINVAL;
+
+	run_0 = run_buf;
+	run_last = run_buf + run_buf_size;
+	prev_lcn = 0;
+	vcn = svcn;
+
+	/* Read all runs the chain */
+	/* size_size - how much bytes is packed len */
+	while (run_buf < run_last && (size_size = *run_buf & 0xF)) {
+		/* offset_size - how much bytes is packed dlcn */
+		u8 offset_size = *run_buf++ >> 4;
+		u64 len = 0;
+		u8 *p = (u8 *)&len;
+
+		/*
+		 * Unpack runs.
+		 * NOTE: runs are stored little endian order
+		 * "len" is unsigned value, "dlcn" is signed
+		 * Large positive number requires to store 5 bytes
+		 * e.g.: 05 FF 7E FF FF 00 00 00
+		 */
+
+		switch (size_size) {
+		default:
+error:
+			return -EINVAL;
+
+#ifdef __BIG_ENDIAN
+		case 8:
+			p[0] = run_buf[7];
+			fallthrough;
+		case 7:
+			p[1] = run_buf[6];
+			fallthrough;
+		case 6:
+			p[2] = run_buf[5];
+			fallthrough;
+		case 5:
+			p[3] = run_buf[4];
+			fallthrough;
+		case 4:
+			p[4] = run_buf[3];
+			fallthrough;
+		case 3:
+			p[5] = run_buf[2];
+			fallthrough;
+		case 2:
+			p[6] = run_buf[1];
+			fallthrough;
+		case 1:
+			p[7] = run_buf[0];
+#else
+		case 8:
+			p[7] = run_buf[7];
+			fallthrough;
+		case 7:
+			p[6] = run_buf[6];
+			fallthrough;
+		case 6:
+			p[5] = run_buf[5];
+			fallthrough;
+		case 5:
+			p[4] = run_buf[4];
+			fallthrough;
+		case 4:
+			p[3] = run_buf[3];
+			fallthrough;
+		case 3:
+			p[2] = run_buf[2];
+			fallthrough;
+		case 2:
+			p[1] = run_buf[1];
+			fallthrough;
+		case 1:
+			p[0] = run_buf[0];
+#endif
+		}
+
+		/* skip size_size */
+		run_buf += size_size;
+
+		if (!len)
+			goto error;
+
+		if (!offset_size) {
+			lcn = SPARSE_LCN;
+		} else {
+			/* Check sign */
+			s64 dlcn =
+				(run_buf[offset_size - 1] & 0x80) ? (s64)-1 : 0;
+
+			p = (u8 *)&dlcn;
+
+			switch (offset_size) {
+			default:
+				goto error;
+
+#ifdef __BIG_ENDIAN
+			case 8:
+				p[0] = run_buf[7];
+				fallthrough;
+			case 7:
+				p[1] = run_buf[6];
+				fallthrough;
+			case 6:
+				p[2] = run_buf[5];
+				fallthrough;
+			case 5:
+				p[3] = run_buf[4];
+				fallthrough;
+			case 4:
+				p[4] = run_buf[3];
+				fallthrough;
+			case 3:
+				p[5] = run_buf[2];
+				fallthrough;
+			case 2:
+				p[6] = run_buf[1];
+				fallthrough;
+			case 1:
+				p[7] = run_buf[0];
+#else
+			case 8:
+				p[7] = run_buf[7];
+				fallthrough;
+			case 7:
+				p[6] = run_buf[6];
+				fallthrough;
+			case 6:
+				p[5] = run_buf[5];
+				fallthrough;
+			case 5:
+				p[4] = run_buf[4];
+				fallthrough;
+			case 4:
+				p[3] = run_buf[3];
+				fallthrough;
+			case 3:
+				p[2] = run_buf[2];
+				fallthrough;
+			case 2:
+				p[1] = run_buf[1];
+				fallthrough;
+			case 1:
+				p[0] = run_buf[0];
+#endif
+			}
+
+			/* skip offset_size */
+			run_buf += offset_size;
+			lcn = prev_lcn + dlcn;
+			prev_lcn = lcn;
+		}
+
+		next_vcn = vcn + len;
+		/* check boundary */
+		if (next_vcn > evcn + 1)
+			goto error;
+
+#ifndef NTFS3_64BIT_CLUSTER
+		if ((vcn >> 32)
+		    /* 0xffffffffffffffff is a valid 'lcn' */
+		    || (lcn + 1) > 0x100000000ull || (len >> 32)) {
+			goto error;
+		}
+#endif
+
+		if (!run)
+			; /* called from check_attr(fslog.c) to check run */
+		else if ((size_t)run == 1) {
+			/* called from ni_delete_all to free clusters without storing in run */
+			if (lcn != SPARSE_LCN)
+				mark_as_free_ex(sbi, lcn, len, true);
+		} else if (!run_add_entry(run, vcn, lcn, len))
+			return -ENOMEM;
+
+		if (lcn != SPARSE_LCN && lcn + len > sbi->used.bitmap.nbits)
+			return -EINVAL;
+
+		vcn = next_vcn;
+	}
+
+	/* Check vcn consistency */
+	if (vcn == evcn + 1)
+		return run_buf - run_0;
+
+	return -EINVAL;
+}
+
+#ifdef NTFS3_CHECK_FREE_CLST
+/*
+ * run_unpack_ex
+ *
+ * unpacks packed runs from "run_buf"
+ * checks unpacked runs to be used in bitmap
+ * returns error, if negative, or real used bytes
+ */
+int run_unpack_ex(struct runs_tree *run, struct ntfs_sb_info *sbi, CLST ino,
+		  CLST svcn, CLST evcn, const u8 *run_buf, u32 run_buf_size)
+{
+	int ret, err;
+	CLST next_vcn, vcn, lcn, len;
+	size_t index;
+	bool ok;
+	struct wnd_bitmap *wnd;
+
+	ret = run_unpack(run, sbi, ino, svcn, evcn, run_buf, run_buf_size);
+	if (ret < 0)
+		return ret;
+
+	if (!sbi->used.bitmap.sb || !run || (size_t)run == 1)
+		return ret;
+
+	if (ino == MFT_REC_BADCLUST)
+		return ret;
+
+	next_vcn = vcn = svcn;
+	wnd = &sbi->used.bitmap;
+
+	for (ok = run_lookup_entry(run, vcn, &lcn, &len, &index);
+	     next_vcn <= evcn;
+	     ok = run_get_entry(run, ++index, &vcn, &lcn, &len)) {
+		CLST real_free, i;
+
+		if (!ok || next_vcn != vcn)
+			return -EINVAL;
+
+		next_vcn = vcn + len;
+
+		if (lcn == SPARSE_LCN)
+			continue;
+
+		if (sbi->flags & NTFS_FLAGS_NEED_REPLAY)
+			continue;
+
+next:
+		down_read_nested(&wnd->rw_lock, BITMAP_MUTEX_CLUSTERS);
+		/* Check for free blocks */
+		ok = wnd_is_used(wnd, lcn, len);
+		up_read(&wnd->rw_lock);
+		if (ok)
+			continue;
+
+		ntfs_set_state(sbi, NTFS_DIRTY_ERROR);
+
+		if (!down_write_trylock(&wnd->rw_lock))
+			continue;
+
+		/* Find first free */
+		real_free = len;
+		while (real_free && !wnd_is_free(wnd, lcn, 1)) {
+			lcn += 1;
+			real_free -= 1;
+		}
+
+		if (!real_free) {
+			up_write(&wnd->rw_lock);
+			continue;
+		}
+
+		/* Find total free */
+		i = 1;
+		while (i < real_free && wnd_is_free(wnd, lcn + i, 1))
+			i += 1;
+
+		real_free = i;
+
+		err = wnd_set_used(wnd, lcn, real_free);
+		up_write(&wnd->rw_lock);
+
+		if (err)
+			return err;
+
+		if (len != real_free) {
+			len -= real_free + 1;
+			lcn += real_free + 1;
+			goto next;
+		}
+	}
+
+	return ret;
+}
+#endif
+
+/*
+ * run_get_highest_vcn
+ *
+ * returns the highest vcn from a mapping pairs array
+ * it used while replaying log file
+ */
+int run_get_highest_vcn(CLST vcn, const u8 *run_buf, u64 *highest_vcn)
+{
+	const u8 *run = run_buf;
+	u64 vcn64 = vcn;
+	u8 size_size;
+
+	while ((size_size = *run & 0xF)) {
+		u8 offset_size = *run++ >> 4;
+		u64 len = 0;
+		u8 *p = (u8 *)&len;
+
+		switch (size_size) {
+		default:
+error:
+			return -EINVAL;
+
+#ifdef __BIG_ENDIAN
+		case 8:
+			p[0] = run[7];
+			fallthrough;
+		case 7:
+			p[1] = run[6];
+			fallthrough;
+		case 6:
+			p[2] = run[5];
+			fallthrough;
+		case 5:
+			p[3] = run[4];
+			fallthrough;
+		case 4:
+			p[4] = run[3];
+			fallthrough;
+		case 3:
+			p[5] = run[2];
+			fallthrough;
+		case 2:
+			p[6] = run[1];
+			fallthrough;
+		case 1:
+			p[7] = run[0];
+#else
+		case 8:
+			p[7] = run[7];
+			fallthrough;
+		case 7:
+			p[6] = run[6];
+			fallthrough;
+		case 6:
+			p[5] = run[5];
+			fallthrough;
+		case 5:
+			p[4] = run[4];
+			fallthrough;
+		case 4:
+			p[3] = run[3];
+			fallthrough;
+		case 3:
+			p[2] = run[2];
+			fallthrough;
+		case 2:
+			p[1] = run[1];
+			fallthrough;
+		case 1:
+			p[0] = run[0];
+#endif
+		}
+
+		/* skip size_size */
+		run += size_size;
+
+		if (!len)
+			goto error;
+
+		run += offset_size;
+
+#ifdef NTFS3_64BIT_CLUSTER
+		if ((vcn >> 32) || (len >> 32))
+			goto error;
+#endif
+		vcn64 += len;
+	}
+
+	*highest_vcn = vcn64 - 1;
+	return 0;
+}
-- 
2.25.4

