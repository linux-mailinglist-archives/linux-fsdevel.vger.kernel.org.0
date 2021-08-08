Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9C453E3B79
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Aug 2021 18:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbhHHQZ7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Aug 2021 12:25:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:47642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231967AbhHHQZi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Aug 2021 12:25:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6F85D61028;
        Sun,  8 Aug 2021 16:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628439919;
        bh=Xjiv1V1kbObBq09/duKu+NNtCwH+mfEyS1BKpAACXoo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=kiYoPRKsI5tsT4xbdCejBqO3jTq5lo5wRlSzXg/xA/jNy/5SGxnS8/XnUr17EFzAl
         dOllXqmy1G7ym/6f8VQ9qOMUMpp8Omk7hW5yirERfPLUsFvqcPHKq3XxKbNvjVtJMG
         gjorDMUhCR3Uw8TTbMLnynRJiH4K4t26l4tOxjQqfMDDAl2+fRFIGbLvQdbgT9dgeL
         1jhp1j93dcAN4wL8RLUPy8loa5Ihjlfi0O4wkxWsNlkB0dm0BhuILclWbXzlKbVNnN
         Zr68+oOBNF+vwJ6ZmW4igUxxmo44XO6R1NuCk9un+xUDHcderBG7mVVOY9O329fBxN
         3/1hKzGpYyuGg==
Received: by pali.im (Postfix)
        id 2D3CC13DC; Sun,  8 Aug 2021 18:25:19 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     linux-fsdevel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        Anton Altaparmakov <anton@tuxera.com>,
        Pavel Machek <pavel@ucw.cz>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
        Christoph Hellwig <hch@infradead.org>
Subject: [RFC PATCH 13/20] hfsplus: Do not use broken utf8 NLS table for iocharset=utf8 mount option
Date:   Sun,  8 Aug 2021 18:24:46 +0200
Message-Id: <20210808162453.1653-14-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210808162453.1653-1-pali@kernel.org>
References: <20210808162453.1653-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

NLS table for utf8 is broken and cannot be fixed.

So instead of broken utf8 nls functions char2uni() and uni2char() use
functions utf8_to_utf32() and utf32_to_utf8() which implements correct
encoding and decoding between Unicode code points and UTF-8 sequence.

Note that this fs driver does not support full Unicode range, specially
UTF-16 surrogate pairs are unsupported. This patch does not change this
limitation and support for UTF-16 surrogate pairs stay unimplemented.

When iochatset=utf8 is used then set sbi->nls to NULL and use it for
distinguish between the fact if NLS table or native UTF-8 functions should
be used.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 fs/hfsplus/dir.c            |  6 ++++--
 fs/hfsplus/options.c        | 32 ++++++++++++++++++--------------
 fs/hfsplus/super.c          |  7 +------
 fs/hfsplus/unicode.c        | 31 ++++++++++++++++++++++++++++---
 fs/hfsplus/xattr.c          | 14 +++++++++-----
 fs/hfsplus/xattr_security.c |  3 ++-
 6 files changed, 62 insertions(+), 31 deletions(-)

diff --git a/fs/hfsplus/dir.c b/fs/hfsplus/dir.c
index 84714bbccc12..2caf0cd82221 100644
--- a/fs/hfsplus/dir.c
+++ b/fs/hfsplus/dir.c
@@ -144,7 +144,8 @@ static int hfsplus_readdir(struct file *file, struct dir_context *ctx)
 	err = hfs_find_init(HFSPLUS_SB(sb)->cat_tree, &fd);
 	if (err)
 		return err;
-	strbuf = kmalloc(NLS_MAX_CHARSET_SIZE * HFSPLUS_MAX_STRLEN + 1, GFP_KERNEL);
+	strbuf = kmalloc((HFSPLUS_SB(sb)->nls ? NLS_MAX_CHARSET_SIZE : 4) *
+			HFSPLUS_MAX_STRLEN + 1, GFP_KERNEL);
 	if (!strbuf) {
 		err = -ENOMEM;
 		goto out;
@@ -203,7 +204,8 @@ static int hfsplus_readdir(struct file *file, struct dir_context *ctx)
 		hfs_bnode_read(fd.bnode, &entry, fd.entryoffset,
 			fd.entrylength);
 		type = be16_to_cpu(entry.type);
-		len = NLS_MAX_CHARSET_SIZE * HFSPLUS_MAX_STRLEN;
+		len = (HFSPLUS_SB(sb)->nls ? NLS_MAX_CHARSET_SIZE : 4) *
+		      HFSPLUS_MAX_STRLEN;
 		err = hfsplus_uni2asc(sb, &fd.key->cat.name, strbuf, &len);
 		if (err)
 			goto out;
diff --git a/fs/hfsplus/options.c b/fs/hfsplus/options.c
index a975548f6b91..16c08cb5c4f8 100644
--- a/fs/hfsplus/options.c
+++ b/fs/hfsplus/options.c
@@ -104,6 +104,9 @@ int hfsplus_parse_options(char *input, struct hfsplus_sb_info *sbi)
 	char *p;
 	substring_t args[MAX_OPT_ARGS];
 	int tmp, token;
+	int have_iocharset;
+
+	have_iocharset = 0;
 
 	if (!input)
 		goto done;
@@ -171,20 +174,24 @@ int hfsplus_parse_options(char *input, struct hfsplus_sb_info *sbi)
 			pr_warn("option nls= is deprecated, use iocharset=\n");
 			/* fallthrough */
 		case opt_iocharset:
-			if (sbi->nls) {
+			if (have_iocharset) {
 				pr_err("unable to change nls mapping\n");
 				return 0;
 			}
 			p = match_strdup(&args[0]);
-			if (p)
-				sbi->nls = load_nls(p);
-			if (!sbi->nls) {
-				pr_err("unable to load nls mapping \"%s\"\n",
-				       p);
-				kfree(p);
+			if (!p)
 				return 0;
+			if (strcmp(p, "utf8") != 0) {
+				sbi->nls = load_nls(p);
+				if (!sbi->nls) {
+					pr_err("unable to load nls mapping "
+						"\"%s\"\n", p);
+					kfree(p);
+					return 0;
+				}
 			}
 			kfree(p);
+			have_iocharset = 1;
 			break;
 		case opt_decompose:
 			clear_bit(HFSPLUS_SB_NODECOMPOSE, &sbi->flags);
@@ -207,13 +214,10 @@ int hfsplus_parse_options(char *input, struct hfsplus_sb_info *sbi)
 	}
 
 done:
-	if (!sbi->nls) {
-		/* try utf8 first, as this is the old default behaviour */
-		sbi->nls = load_nls("utf8");
-		if (!sbi->nls)
-			sbi->nls = load_nls_default();
-		if (!sbi->nls)
-			return 0;
+	if (!have_iocharset) {
+		/* use utf8, as this is the old default behaviour */
+		pr_debug("using native UTF-8 without nls\n");
+		/* no sbi->nls means that native UTF-8 code is used */
 	}
 
 	return 1;
diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index b9e3db3f855f..985662451bfc 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -403,11 +403,7 @@ static int hfsplus_fill_super(struct super_block *sb, void *data, int silent)
 
 	/* temporarily use utf8 to correctly find the hidden dir below */
 	nls = sbi->nls;
-	sbi->nls = load_nls("utf8");
-	if (!sbi->nls) {
-		pr_err("unable to load nls for utf8\n");
-		goto out_unload_nls;
-	}
+	sbi->nls = NULL;
 
 	/* Grab the volume header */
 	if (hfsplus_read_wrapper(sb)) {
@@ -585,7 +581,6 @@ static int hfsplus_fill_super(struct super_block *sb, void *data, int silent)
 		}
 	}
 
-	unload_nls(sbi->nls);
 	sbi->nls = nls;
 	return 0;
 
diff --git a/fs/hfsplus/unicode.c b/fs/hfsplus/unicode.c
index 73342c925a4b..1d8c31c5126f 100644
--- a/fs/hfsplus/unicode.c
+++ b/fs/hfsplus/unicode.c
@@ -190,7 +190,12 @@ int hfsplus_uni2asc(struct super_block *sb,
 				c0 = ':';
 				break;
 			}
-			res = nls->uni2char(c0, op, len);
+			if (nls)
+				res = nls->uni2char(c0, op, len);
+			else (len > 0)
+				res = utf32_to_utf8(c0, op, len);
+			else
+				res = -ENAMETOOLONG;
 			if (res < 0) {
 				if (res == -ENAMETOOLONG)
 					goto out;
@@ -233,7 +238,12 @@ int hfsplus_uni2asc(struct super_block *sb,
 			cc = c0;
 		}
 done:
-		res = nls->uni2char(cc, op, len);
+		if (nls)
+			res = nls->uni2char(cc, op, len);
+		else (len > 0)
+			res = utf32_to_utf8(cc, op, len);
+		else
+			res = -ENAMETOOLONG;
 		if (res < 0) {
 			if (res == -ENAMETOOLONG)
 				goto out;
@@ -256,7 +266,22 @@ int hfsplus_uni2asc(struct super_block *sb,
 static inline int asc2unichar(struct super_block *sb, const char *astr, int len,
 			      wchar_t *uc)
 {
-	int size = HFSPLUS_SB(sb)->nls->char2uni(astr, len, uc);
+	struct nls_table *nls = HFSPLUS_SB(sb)->nls;
+	unicode_t u;
+	int size;
+
+	if (nls)
+		size = nls->char2uni(astr, len, uc);
+	else {
+		size = utf8_to_utf32(astr, len, &u);
+		if (size >= 0) {
+			/* TODO: Add support for UTF-16 surrogate pairs */
+			if (u <= MAX_WCHAR_T)
+				*uc = u;
+			else
+				size = -EINVAL;
+		}
+	}
 	if (size <= 0) {
 		*uc = '?';
 		size = 1;
diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
index e2855ceefd39..9b2653f08a5f 100644
--- a/fs/hfsplus/xattr.c
+++ b/fs/hfsplus/xattr.c
@@ -425,7 +425,8 @@ int hfsplus_setxattr(struct inode *inode, const char *name,
 	char *xattr_name;
 	int res;
 
-	xattr_name = kmalloc(NLS_MAX_CHARSET_SIZE * HFSPLUS_ATTR_MAX_STRLEN + 1,
+	xattr_name = kmalloc((HFSPLUS_SB(sb)->nls ? NLS_MAX_CHARSET_SIZE : 4) *
+			     HFSPLUS_ATTR_MAX_STRLEN + 1,
 		GFP_KERNEL);
 	if (!xattr_name)
 		return -ENOMEM;
@@ -579,7 +580,8 @@ ssize_t hfsplus_getxattr(struct inode *inode, const char *name,
 	int res;
 	char *xattr_name;
 
-	xattr_name = kmalloc(NLS_MAX_CHARSET_SIZE * HFSPLUS_ATTR_MAX_STRLEN + 1,
+	xattr_name = kmalloc((HFSPLUS_SB(sb)->nls ? NLS_MAX_CHARSET_SIZE : 4) *
+			     HFSPLUS_ATTR_MAX_STRLEN + 1,
 			     GFP_KERNEL);
 	if (!xattr_name)
 		return -ENOMEM;
@@ -699,8 +701,9 @@ ssize_t hfsplus_listxattr(struct dentry *dentry, char *buffer, size_t size)
 		return err;
 	}
 
-	strbuf = kmalloc(NLS_MAX_CHARSET_SIZE * HFSPLUS_ATTR_MAX_STRLEN +
-			XATTR_MAC_OSX_PREFIX_LEN + 1, GFP_KERNEL);
+	strbuf = kmalloc((HFSPLUS_SB(sb)->nls ? NLS_MAX_CHARSET_SIZE : 4) *
+			HFSPLUS_ATTR_MAX_STRLEN + XATTR_MAC_OSX_PREFIX_LEN + 1,
+			GFP_KERNEL);
 	if (!strbuf) {
 		res = -ENOMEM;
 		goto out;
@@ -732,7 +735,8 @@ ssize_t hfsplus_listxattr(struct dentry *dentry, char *buffer, size_t size)
 		if (be32_to_cpu(attr_key.cnid) != inode->i_ino)
 			goto end_listxattr;
 
-		xattr_name_len = NLS_MAX_CHARSET_SIZE * HFSPLUS_ATTR_MAX_STRLEN;
+		xattr_name_len = (HFSPLUS_SB(sb)->nls ? NLS_MAX_CHARSET_SIZE : 4)
+				* HFSPLUS_ATTR_MAX_STRLEN;
 		if (hfsplus_uni2asc(inode->i_sb,
 			(const struct hfsplus_unistr *)&fd.key->attr.key_name,
 					strbuf, &xattr_name_len)) {
diff --git a/fs/hfsplus/xattr_security.c b/fs/hfsplus/xattr_security.c
index c1c7a16cbf21..438ebcd1359b 100644
--- a/fs/hfsplus/xattr_security.c
+++ b/fs/hfsplus/xattr_security.c
@@ -41,7 +41,8 @@ static int hfsplus_initxattrs(struct inode *inode,
 	char *xattr_name;
 	int err = 0;
 
-	xattr_name = kmalloc(NLS_MAX_CHARSET_SIZE * HFSPLUS_ATTR_MAX_STRLEN + 1,
+	xattr_name = kmalloc((HFSPLUS_SB(sb)->nls ? NLS_MAX_CHARSET_SIZE : 4) *
+			     HFSPLUS_ATTR_MAX_STRLEN + 1,
 		GFP_KERNEL);
 	if (!xattr_name)
 		return -ENOMEM;
-- 
2.20.1

