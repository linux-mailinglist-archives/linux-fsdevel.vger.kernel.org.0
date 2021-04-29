Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5F336E7C2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Apr 2021 11:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbhD2JPz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Apr 2021 05:15:55 -0400
Received: from mail.synology.com ([211.23.38.101]:54318 "EHLO synology.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232775AbhD2JPx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Apr 2021 05:15:53 -0400
Received: from localhost.localdomain (unknown [10.17.32.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by synology.com (Postfix) with ESMTPSA id 0344BCE781B4;
        Thu, 29 Apr 2021 17:15:06 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1619687706; bh=0sSfdqm0yzi0ey/gtrGRKKyyZxAerg/2fvBwbsr4J5M=;
        h=From:To:Cc:Subject:Date;
        b=dMfeD9cDptOb3qr9yivFOnIaVde+Jrmq/BPSHe6/fZ6atKXybhGD3RlAhETYdJ/+J
         +qEEX0MthdmYvjFKN+SLymykpc2Wwv2nf2V9Uhbp05Fq9tPKHymt43qlVlbYbBNIf1
         RHd1JdTMJ7CMVIBiOnWFd5kziCkfzE9Uf9BdGQV8=
From:   bingjingc <bingjingc@synology.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        slava@dubeyko.com, christian.brauner@ubuntu.com, leon@kernel.org,
        kvalo@codeaurora.org, keescook@chromium.org, jgg@ziepe.ca
Cc:     bingjingc@synology.com, cccheng@synology.com
Subject: [PATCH] hfsplus: fix attr searching failed of xattr key name with ':'
Date:   Thu, 29 Apr 2021 17:14:46 +0800
Message-Id: <1619687686-29580-1-git-send-email-bingjingc@synology.com>
X-Mailer: git-send-email 2.7.4
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: BingJing Chang <bingjingc@synology.com>

Some OSX extended attributes couldn't be displayed in ubuntu:
$ mount -t hfsplus /dev/sdb3 /mnt
$ cd /mnt
$ getfattr -d -m ".*" picture.png
Here, /dev/sdb is a usb stick from OSX computer.

Output:
osx.com.apple.FinderInfo=0sAAAAAAAAAAAEHAAAAAAAAAAAAABgf5OhAAAAAAAAAAg=
osx.com.apple.lastuseddate#PS=0soCWGYAAAAAATBhINAAAAAA==
osx.com.apple.macl=0sAgCH2+S5OA9OG5WnnVb5d67AAAAAAAAAAAAAAAAAAAAAAAAAAA...
Voronoi.png: osx.com.apple.metadata:_kMDItemUserTags: No such attribute
Voronoi.png: osx.com.apple.metadata:kMDItemIsScreenCapture: No suchattr...
Voronoi.png: osx.com.apple.metadata:kMDItemScreenCaptureGlobalRect: No ...
Voronoi.png: osx.com.apple.metadata:kMDItemScreenCaptureType: No such a...
osx.com.apple.quarantine="0082;608625a1;Preview;"

Here are 8 extended attributes in this file. However, some contents of
them could not be retrieved.

The problem is caused by the name-mangling scheme of ascii-unicode
conversions in fs/hfsplus/unicode.c. The character '/' is illegal in
Linux filenames but valid in OSX filenames. In contrast, the character ':'
is opposite. So a simple name-mangling scheme can be applied to
hfsplus filenames by replacing unicode '/' by ascii ':' and ascii ':' by
unicode '/'. However, there're no such constraints in attribute names.
Forcely converting ':' to '/' will cause the xattr lookup failures.

To fix this, we introduce a new parameter name_mangling in
hfsplus_uni2asc() and hfsplus_asc2uni() to indicate whether to perform
such name-mangling scheme or not. And we give the hints not to perform
the scheme for attribute keys.

Reviewed-by: Chung-Chiang Cheng <cccheng@synology.com>
Signed-off-by: BingJing Chang <bingjingc@synology.com>
---
 fs/hfsplus/attributes.c |  7 ++++---
 fs/hfsplus/catalog.c    |  4 ++--
 fs/hfsplus/dir.c        |  3 ++-
 fs/hfsplus/hfsplus_fs.h |  5 +++--
 fs/hfsplus/unicode.c    | 22 ++++++++++++----------
 fs/hfsplus/xattr.c      |  5 +++--
 6 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/fs/hfsplus/attributes.c b/fs/hfsplus/attributes.c
index eeebe80..234badf 100644
--- a/fs/hfsplus/attributes.c
+++ b/fs/hfsplus/attributes.c
@@ -55,9 +55,10 @@ int hfsplus_attr_build_key(struct super_block *sb, hfsplus_btree_key *key,
 	memset(key, 0, sizeof(struct hfsplus_attr_key));
 	key->attr.cnid = cpu_to_be32(cnid);
 	if (name) {
-		int res = hfsplus_asc2uni(sb,
-				(struct hfsplus_unistr *)&key->attr.key_name,
-				HFSPLUS_ATTR_MAX_STRLEN, name, strlen(name));
+		int res = hfsplus_asc2uni(sb, (struct hfsplus_unistr *)
+					  &key->attr.key_name,
+					  HFSPLUS_ATTR_MAX_STRLEN,
+					  name, strlen(name), false);
 		if (res)
 			return res;
 		len = be16_to_cpu(key->attr.key_name.length);
diff --git a/fs/hfsplus/catalog.c b/fs/hfsplus/catalog.c
index 35472cb..f40fc9e 100644
--- a/fs/hfsplus/catalog.c
+++ b/fs/hfsplus/catalog.c
@@ -47,7 +47,7 @@ int hfsplus_cat_build_key(struct super_block *sb,
 
 	key->cat.parent = cpu_to_be32(parent);
 	err = hfsplus_asc2uni(sb, &key->cat.name, HFSPLUS_MAX_STRLEN,
-			str->name, str->len);
+			      str->name, str->len, true);
 	if (unlikely(err < 0))
 		return err;
 
@@ -183,7 +183,7 @@ static int hfsplus_fill_cat_thread(struct super_block *sb,
 	entry->thread.reserved = 0;
 	entry->thread.parentID = cpu_to_be32(parentid);
 	err = hfsplus_asc2uni(sb, &entry->thread.nodeName, HFSPLUS_MAX_STRLEN,
-				str->name, str->len);
+			      str->name, str->len, true);
 	if (unlikely(err < 0))
 		return err;
 
diff --git a/fs/hfsplus/dir.c b/fs/hfsplus/dir.c
index 03e6c04..505b4e6 100644
--- a/fs/hfsplus/dir.c
+++ b/fs/hfsplus/dir.c
@@ -204,7 +204,8 @@ static int hfsplus_readdir(struct file *file, struct dir_context *ctx)
 			fd.entrylength);
 		type = be16_to_cpu(entry.type);
 		len = NLS_MAX_CHARSET_SIZE * HFSPLUS_MAX_STRLEN;
-		err = hfsplus_uni2asc(sb, &fd.key->cat.name, strbuf, &len);
+		err = hfsplus_uni2asc(sb, &fd.key->cat.name, strbuf, &len,
+				      true);
 		if (err)
 			goto out;
 		if (type == HFSPLUS_FOLDER) {
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 12b2047..1481d0a 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -522,9 +522,10 @@ int hfsplus_strcasecmp(const struct hfsplus_unistr *s1,
 int hfsplus_strcmp(const struct hfsplus_unistr *s1,
 		   const struct hfsplus_unistr *s2);
 int hfsplus_uni2asc(struct super_block *sb, const struct hfsplus_unistr *ustr,
-		    char *astr, int *len_p);
+		    char *astr, int *len_p, bool name_mangling);
 int hfsplus_asc2uni(struct super_block *sb, struct hfsplus_unistr *ustr,
-		    int max_unistr_len, const char *astr, int len);
+		    int max_unistr_len, const char *astr, int len,
+		    bool name_mangling);
 int hfsplus_hash_dentry(const struct dentry *dentry, struct qstr *str);
 int hfsplus_compare_dentry(const struct dentry *dentry, unsigned int len,
 			   const char *str, const struct qstr *name);
diff --git a/fs/hfsplus/unicode.c b/fs/hfsplus/unicode.c
index 73342c9..52d9186 100644
--- a/fs/hfsplus/unicode.c
+++ b/fs/hfsplus/unicode.c
@@ -121,7 +121,7 @@ static u16 *hfsplus_compose_lookup(u16 *p, u16 cc)
 
 int hfsplus_uni2asc(struct super_block *sb,
 		const struct hfsplus_unistr *ustr,
-		char *astr, int *len_p)
+		char *astr, int *len_p, bool name_mangling)
 {
 	const hfsplus_unichr *ip;
 	struct nls_table *nls = HFSPLUS_SB(sb)->nls;
@@ -187,7 +187,8 @@ int hfsplus_uni2asc(struct super_block *sb,
 				c0 = 0x2400;
 				break;
 			case '/':
-				c0 = ':';
+				if (name_mangling)
+					c0 = ':';
 				break;
 			}
 			res = nls->uni2char(c0, op, len);
@@ -253,8 +254,8 @@ int hfsplus_uni2asc(struct super_block *sb,
  * Convert one or more ASCII characters into a single unicode character.
  * Returns the number of ASCII characters corresponding to the unicode char.
  */
-static inline int asc2unichar(struct super_block *sb, const char *astr, int len,
-			      wchar_t *uc)
+static inline int asc2unichar(struct super_block *sb, const char *astr,
+			      int len, wchar_t *uc, bool name_mangling)
 {
 	int size = HFSPLUS_SB(sb)->nls->char2uni(astr, len, uc);
 	if (size <= 0) {
@@ -266,7 +267,8 @@ static inline int asc2unichar(struct super_block *sb, const char *astr, int len,
 		*uc = 0;
 		break;
 	case ':':
-		*uc = '/';
+		if (name_mangling)
+			*uc = '/';
 		break;
 	}
 	return size;
@@ -343,7 +345,7 @@ static u16 *decompose_unichar(wchar_t uc, int *size, u16 *hangul_buffer)
 
 int hfsplus_asc2uni(struct super_block *sb,
 		    struct hfsplus_unistr *ustr, int max_unistr_len,
-		    const char *astr, int len)
+		    const char *astr, int len, bool name_mangling)
 {
 	int size, dsize, decompose;
 	u16 *dstr, outlen = 0;
@@ -352,7 +354,7 @@ int hfsplus_asc2uni(struct super_block *sb,
 
 	decompose = !test_bit(HFSPLUS_SB_NODECOMPOSE, &HFSPLUS_SB(sb)->flags);
 	while (outlen < max_unistr_len && len > 0) {
-		size = asc2unichar(sb, astr, len, &c);
+		size = asc2unichar(sb, astr, len, &c, name_mangling);
 
 		if (decompose)
 			dstr = decompose_unichar(c, &dsize, dhangul);
@@ -399,7 +401,7 @@ int hfsplus_hash_dentry(const struct dentry *dentry, struct qstr *str)
 	len = str->len;
 	while (len > 0) {
 		int dsize;
-		size = asc2unichar(sb, astr, len, &c);
+		size = asc2unichar(sb, astr, len, &c, true);
 		astr += size;
 		len -= size;
 
@@ -456,7 +458,7 @@ int hfsplus_compare_dentry(const struct dentry *dentry,
 
 	while (len1 > 0 && len2 > 0) {
 		if (!dsize1) {
-			size = asc2unichar(sb, astr1, len1, &c);
+			size = asc2unichar(sb, astr1, len1, &c, true);
 			astr1 += size;
 			len1 -= size;
 
@@ -471,7 +473,7 @@ int hfsplus_compare_dentry(const struct dentry *dentry,
 		}
 
 		if (!dsize2) {
-			size = asc2unichar(sb, astr2, len2, &c);
+			size = asc2unichar(sb, astr2, len2, &c, true);
 			astr2 += size;
 			len2 -= size;
 
diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
index 4d169c5..de6a1c9 100644
--- a/fs/hfsplus/xattr.c
+++ b/fs/hfsplus/xattr.c
@@ -735,8 +735,9 @@ ssize_t hfsplus_listxattr(struct dentry *dentry, char *buffer, size_t size)
 
 		xattr_name_len = NLS_MAX_CHARSET_SIZE * HFSPLUS_ATTR_MAX_STRLEN;
 		if (hfsplus_uni2asc(inode->i_sb,
-			(const struct hfsplus_unistr *)&fd.key->attr.key_name,
-					strbuf, &xattr_name_len)) {
+				    (const struct hfsplus_unistr *)
+				    &fd.key->attr.key_name, strbuf,
+				    &xattr_name_len, false)) {
 			pr_err("unicode conversion failed\n");
 			res = -EIO;
 			goto end_listxattr;
-- 
2.7.4

