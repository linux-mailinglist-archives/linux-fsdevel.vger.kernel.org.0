Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237B065633C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Dec 2022 15:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbiLZOWy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Dec 2022 09:22:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbiLZOWk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Dec 2022 09:22:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA453626F;
        Mon, 26 Dec 2022 06:22:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC8AA60EBD;
        Mon, 26 Dec 2022 14:22:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F32A9C433EF;
        Mon, 26 Dec 2022 14:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672064533;
        bh=y7MXoqLkJePjPQXj3TFzpaNKan0GSNj9EZYy1FjI9g4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=S3ViSU88TaCehP3ML1X9O0tbfUFnzVxZAaKgV1lWa4jeRpmGD7Yo8jaoIGA84PNL7
         L0JMUibflgJbT3PuFYAEM7tLDxz8lY/TNmxgQd8IB4j0ScHQf1H8HTmitora8vDBiV
         6NKhpgoaNEHDmgDZI/0BgjB/Xw92r9UOLjsC8i8kSKfXQwr3+/CI6wpTuIrlLXdOqg
         90g0hWvdyFlXX06PJWdSDJXhG4DfhNhn6hlhkEP+gvkKFSuGORNmP3M4KRsci/4Cx5
         2B7t0F5CStktntNVl049TvyQmvSaVXbf32PqNmBdznjno2ekvADz/+YlmSDbws9wPh
         7f4LbuEO54lIA==
Received: by pali.im (Postfix)
        id AE1A99D7; Mon, 26 Dec 2022 15:22:12 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     linux-fsdevel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, "Theodore Y . Ts'o" <tytso@mit.edu>,
        Anton Altaparmakov <anton@tuxera.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>,
        Steve French <sfrench@samba.org>, Paulo Alcantara <pc@cjr.nz>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>, Dave Kleikamp <shaggy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Machek <pavel@ucw.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Kari Argillander <kari.argillander@gmail.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH v2 11/18] hfsplus: Do not use broken utf8 NLS table for iocharset=utf8 mount option
Date:   Mon, 26 Dec 2022 15:21:43 +0100
Message-Id: <20221226142150.13324-12-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221226142150.13324-1-pali@kernel.org>
References: <20221226142150.13324-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 fs/hfsplus/dir.c            |  7 +++++--
 fs/hfsplus/options.c        | 32 ++++++++++++++++++--------------
 fs/hfsplus/super.c          |  7 +------
 fs/hfsplus/unicode.c        | 31 ++++++++++++++++++++++++++++---
 fs/hfsplus/xattr.c          | 20 +++++++++++++-------
 fs/hfsplus/xattr_security.c |  6 ++++--
 6 files changed, 69 insertions(+), 34 deletions(-)

diff --git a/fs/hfsplus/dir.c b/fs/hfsplus/dir.c
index 84714bbccc12..b19cb6c34dd2 100644
--- a/fs/hfsplus/dir.c
+++ b/fs/hfsplus/dir.c
@@ -144,7 +144,9 @@ static int hfsplus_readdir(struct file *file, struct dir_context *ctx)
 	err = hfs_find_init(HFSPLUS_SB(sb)->cat_tree, &fd);
 	if (err)
 		return err;
-	strbuf = kmalloc(NLS_MAX_CHARSET_SIZE * HFSPLUS_MAX_STRLEN + 1, GFP_KERNEL);
+	len = (HFSPLUS_SB(sb)->nls ? NLS_MAX_CHARSET_SIZE : 4) *
+	      HFSPLUS_MAX_STRLEN + 1;
+	strbuf = kmalloc(len, GFP_KERNEL);
 	if (!strbuf) {
 		err = -ENOMEM;
 		goto out;
@@ -203,7 +205,8 @@ static int hfsplus_readdir(struct file *file, struct dir_context *ctx)
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
index d3dc0d4ba77f..ede7776d1da9 100644
--- a/fs/hfsplus/options.c
+++ b/fs/hfsplus/options.c
@@ -104,6 +104,9 @@ int hfsplus_parse_options(char *input, struct hfsplus_sb_info *sbi)
 	char *p;
 	substring_t args[MAX_OPT_ARGS];
 	int tmp, token;
+	bool have_iocharset;
+
+	have_iocharset = false;
 
 	if (!input)
 		goto done;
@@ -175,20 +178,24 @@ int hfsplus_parse_options(char *input, struct hfsplus_sb_info *sbi)
 			pr_warn("option nls= is deprecated, use iocharset=\n");
 			fallthrough;
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
+			have_iocharset = true;
 			break;
 		case opt_decompose:
 			clear_bit(HFSPLUS_SB_NODECOMPOSE, &sbi->flags);
@@ -211,13 +218,10 @@ int hfsplus_parse_options(char *input, struct hfsplus_sb_info *sbi)
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
index 122ed89ebf9f..8a66a77ad3e1 100644
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
index 73342c925a4b..dc9be40d049f 100644
--- a/fs/hfsplus/unicode.c
+++ b/fs/hfsplus/unicode.c
@@ -190,7 +190,12 @@ int hfsplus_uni2asc(struct super_block *sb,
 				c0 = ':';
 				break;
 			}
-			res = nls->uni2char(c0, op, len);
+			if (nls)
+				res = nls->uni2char(c0, op, len);
+			else if (len > 0)
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
+		else if (len > 0)
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
index 49891b12c415..607f46b3d0f3 100644
--- a/fs/hfsplus/xattr.c
+++ b/fs/hfsplus/xattr.c
@@ -422,11 +422,13 @@ int hfsplus_setxattr(struct inode *inode, const char *name,
 		     const void *value, size_t size, int flags,
 		     const char *prefix, size_t prefixlen)
 {
+	int xattr_name_len;
 	char *xattr_name;
 	int res;
 
-	xattr_name = kmalloc(NLS_MAX_CHARSET_SIZE * HFSPLUS_ATTR_MAX_STRLEN + 1,
-		GFP_KERNEL);
+	xattr_name_len = (HFSPLUS_SB(inode->i_sb)->nls ? NLS_MAX_CHARSET_SIZE : 4) *
+			 HFSPLUS_ATTR_MAX_STRLEN + 1;
+	xattr_name = kmalloc(xattr_name_len, GFP_KERNEL);
 	if (!xattr_name)
 		return -ENOMEM;
 	strcpy(xattr_name, prefix);
@@ -578,9 +580,11 @@ ssize_t hfsplus_getxattr(struct inode *inode, const char *name,
 {
 	int res;
 	char *xattr_name;
+	int xattr_name_len;
 
-	xattr_name = kmalloc(NLS_MAX_CHARSET_SIZE * HFSPLUS_ATTR_MAX_STRLEN + 1,
-			     GFP_KERNEL);
+	xattr_name_len = (HFSPLUS_SB(inode->i_sb)->nls ? NLS_MAX_CHARSET_SIZE : 4) *
+			 HFSPLUS_ATTR_MAX_STRLEN + 1;
+	xattr_name = kmalloc(xattr_name_len, GFP_KERNEL);
 	if (!xattr_name)
 		return -ENOMEM;
 
@@ -699,8 +703,9 @@ ssize_t hfsplus_listxattr(struct dentry *dentry, char *buffer, size_t size)
 		return err;
 	}
 
-	strbuf = kmalloc(NLS_MAX_CHARSET_SIZE * HFSPLUS_ATTR_MAX_STRLEN +
-			XATTR_MAC_OSX_PREFIX_LEN + 1, GFP_KERNEL);
+	xattr_name_len = (HFSPLUS_SB(inode->i_sb)->nls ? NLS_MAX_CHARSET_SIZE : 4) *
+			 HFSPLUS_ATTR_MAX_STRLEN + XATTR_MAC_OSX_PREFIX_LEN + 1;
+	strbuf = kmalloc(xattr_name_len, GFP_KERNEL);
 	if (!strbuf) {
 		res = -ENOMEM;
 		goto out;
@@ -732,7 +737,8 @@ ssize_t hfsplus_listxattr(struct dentry *dentry, char *buffer, size_t size)
 		if (be32_to_cpu(attr_key.cnid) != inode->i_ino)
 			goto end_listxattr;
 
-		xattr_name_len = NLS_MAX_CHARSET_SIZE * HFSPLUS_ATTR_MAX_STRLEN;
+		xattr_name_len = (HFSPLUS_SB(inode->i_sb)->nls ? NLS_MAX_CHARSET_SIZE : 4) *
+				 HFSPLUS_ATTR_MAX_STRLEN;
 		if (hfsplus_uni2asc(inode->i_sb,
 			(const struct hfsplus_unistr *)&fd.key->attr.key_name,
 					strbuf, &xattr_name_len)) {
diff --git a/fs/hfsplus/xattr_security.c b/fs/hfsplus/xattr_security.c
index c1c7a16cbf21..b4b45c796ef4 100644
--- a/fs/hfsplus/xattr_security.c
+++ b/fs/hfsplus/xattr_security.c
@@ -38,11 +38,13 @@ static int hfsplus_initxattrs(struct inode *inode,
 				void *fs_info)
 {
 	const struct xattr *xattr;
+	int xattr_name_len;
 	char *xattr_name;
 	int err = 0;
 
-	xattr_name = kmalloc(NLS_MAX_CHARSET_SIZE * HFSPLUS_ATTR_MAX_STRLEN + 1,
-		GFP_KERNEL);
+	xattr_name_len = (HFSPLUS_SB(inode->i_sb)->nls ? NLS_MAX_CHARSET_SIZE : 4) *
+			 HFSPLUS_ATTR_MAX_STRLEN + 1;
+	xattr_name = kmalloc(xattr_name_len, GFP_KERNEL);
 	if (!xattr_name)
 		return -ENOMEM;
 	for (xattr = xattr_array; xattr->name != NULL; xattr++) {
-- 
2.20.1

