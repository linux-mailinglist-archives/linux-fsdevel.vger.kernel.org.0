Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46B943F069F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Aug 2021 16:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238113AbhHRO0L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Aug 2021 10:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239854AbhHROYD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Aug 2021 10:24:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C3DC061155;
        Wed, 18 Aug 2021 07:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=jzP03WJks1rcorPHhNxvobSIkXwAyFDxv0GxDOTQtjc=; b=dU066UNDgZs+u11V6bzMLybesP
        RS9a+S3me1UMJVq8VbIaXEFbBsoN5NBxSS+fD0RPSEMAABCmiklz8JhBafHO0UENhRgDQxonwW9YN
        j3YGWlH5REELTZOlMofSULozPVwIF2wxiMxQnQQi5k38+leOtsy5KuiZU43TQe3zzzhKkbPL9s+VC
        CoVWmjVEQsuZ7xTCxAWXAbIaP3kkK4INDBDnjmQKkfkx0eX6HyU6v7LtYvXVKmSg6ootaEqtuAVRV
        gXoDDszvA9OWA/xgr5PWMh6+WIYCQGOONkLW7VZhJXzDzDbQUoN+nXKMMZ8ZjGzINZvuqrWShNIP+
        Zml1pzDg==;
Received: from [2001:4bb8:188:1b1:5a9e:9f39:5a86:b20c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGMQt-003v9V-Dg; Wed, 18 Aug 2021 14:20:58 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Shreeya Patel <shreeya.patel@collabora.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH 10/11] unicode: Add utf8-data module
Date:   Wed, 18 Aug 2021 16:06:50 +0200
Message-Id: <20210818140651.17181-11-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210818140651.17181-1-hch@lst.de>
References: <20210818140651.17181-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

utf8data.h contains a large database table which is an auto-generated
decodification trie for the unicode normalization functions.

Allow building it into a separate module.

Based on a patch from Shreeya Patel <shreeya.patel@collabora.com>.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/unicode/Kconfig                            | 13 ++++-
 fs/unicode/Makefile                           | 13 ++---
 fs/unicode/mkutf8data.c                       | 24 ++++++++--
 fs/unicode/utf8-core.c                        | 35 +++++++++++---
 fs/unicode/utf8-norm.c                        | 48 ++++---------------
 fs/unicode/utf8-selftest.c                    | 16 +++----
 ...{utf8data.h_shipped => utf8data.c_shipped} | 22 +++++++--
 fs/unicode/utf8n.h                            | 40 ++++++++--------
 include/linux/unicode.h                       |  2 +
 9 files changed, 123 insertions(+), 90 deletions(-)
 rename fs/unicode/{utf8data.h_shipped => utf8data.c_shipped} (99%)

diff --git a/fs/unicode/Kconfig b/fs/unicode/Kconfig
index 2c27b9a5cd6c..610d7bc05d6e 100644
--- a/fs/unicode/Kconfig
+++ b/fs/unicode/Kconfig
@@ -8,7 +8,16 @@ config UNICODE
 	  Say Y here to enable UTF-8 NFD normalization and NFD+CF casefolding
 	  support.
 
+config UNICODE_UTF8_DATA
+	tristate "UTF-8 normalization and casefolding tables"
+	depends on UNICODE
+	default UNICODE
+	help
+	  This contains a large table of case foldings, which can be loaded as
+	  a separate module if you say M here.  To be on the safe side stick
+	  to the default of Y.  Saying N here makes no sense, if you do not want
+	  utf8 casefolding support, disable CONFIG_UNICODE instead.
+
 config UNICODE_NORMALIZATION_SELFTEST
 	tristate "Test UTF-8 normalization support"
-	depends on UNICODE
-	default n
+	depends on UNICODE_UTF8_DATA
diff --git a/fs/unicode/Makefile b/fs/unicode/Makefile
index b88aecc86550..2f9d9188852b 100644
--- a/fs/unicode/Makefile
+++ b/fs/unicode/Makefile
@@ -2,14 +2,15 @@
 
 obj-$(CONFIG_UNICODE) += unicode.o
 obj-$(CONFIG_UNICODE_NORMALIZATION_SELFTEST) += utf8-selftest.o
+obj-$(CONFIG_UNICODE_UTF8_DATA) += utf8data.o
 
 unicode-y := utf8-norm.o utf8-core.o
 
-$(obj)/utf8-norm.o: $(obj)/utf8data.h
+$(obj)/utf8-data.o: $(obj)/utf8data.c
 
-# In the normal build, the checked-in utf8data.h is just shipped.
+# In the normal build, the checked-in utf8data.c is just shipped.
 #
-# To generate utf8data.h from UCD, put *.txt files in this directory
+# To generate utf8data.c from UCD, put *.txt files in this directory
 # and pass REGENERATE_UTF8DATA=1 from the command line.
 ifdef REGENERATE_UTF8DATA
 
@@ -24,15 +25,15 @@ quiet_cmd_utf8data = GEN     $@
 		-t $(srctree)/$(src)/NormalizationTest.txt \
 		-o $@
 
-$(obj)/utf8data.h: $(obj)/mkutf8data $(filter %.txt, $(cmd_utf8data)) FORCE
+$(obj)/utf8data.c: $(obj)/mkutf8data $(filter %.txt, $(cmd_utf8data)) FORCE
 	$(call if_changed,utf8data)
 
 else
 
-$(obj)/utf8data.h: $(src)/utf8data.h_shipped FORCE
+$(obj)/utf8data.c: $(src)/utf8data.c_shipped FORCE
 	$(call if_changed,shipped)
 
 endif
 
-targets += utf8data.h
+targets += utf8data.c
 hostprogs += mkutf8data
diff --git a/fs/unicode/mkutf8data.c b/fs/unicode/mkutf8data.c
index ff2025ac5a32..bc1a7c8b5c8d 100644
--- a/fs/unicode/mkutf8data.c
+++ b/fs/unicode/mkutf8data.c
@@ -3287,12 +3287,10 @@ static void write_file(void)
 		open_fail(utf8_name, errno);
 
 	fprintf(file, "/* This file is generated code, do not edit. */\n");
-	fprintf(file, "#ifndef __INCLUDED_FROM_UTF8NORM_C__\n");
-	fprintf(file, "#error Only nls_utf8-norm.c should include this file.\n");
-	fprintf(file, "#endif\n");
 	fprintf(file, "\n");
-	fprintf(file, "static const unsigned int utf8vers = %#x;\n",
-		unicode_maxage);
+	fprintf(file, "#include <linux/module.h>\n");
+	fprintf(file, "#include <linux/kernel.h>\n");
+	fprintf(file, "#include \"utf8n.h\"\n");
 	fprintf(file, "\n");
 	fprintf(file, "static const unsigned int utf8agetab[] = {\n");
 	for (i = 0; i != ages_count; i++)
@@ -3339,6 +3337,22 @@ static void write_file(void)
 		fprintf(file, "\n");
 	}
 	fprintf(file, "};\n");
+	fprintf(file, "\n");
+	fprintf(file, "struct utf8data_table utf8_data_table = {\n");
+	fprintf(file, "\t.utf8agetab = utf8agetab,\n");
+	fprintf(file, "\t.utf8agetab_size = ARRAY_SIZE(utf8agetab),\n");
+	fprintf(file, "\n");
+	fprintf(file, "\t.utf8nfdicfdata = utf8nfdicfdata,\n");
+	fprintf(file, "\t.utf8nfdicfdata_size = ARRAY_SIZE(utf8nfdicfdata),\n");
+	fprintf(file, "\n");
+	fprintf(file, "\t.utf8nfdidata = utf8nfdidata,\n");
+	fprintf(file, "\t.utf8nfdidata_size = ARRAY_SIZE(utf8nfdidata),\n");
+	fprintf(file, "\n");
+	fprintf(file, "\t.utf8data = utf8data,\n");
+	fprintf(file, "};\n");
+	fprintf(file, "EXPORT_SYMBOL_GPL(utf8_data_table);");
+	fprintf(file, "\n");
+	fprintf(file, "MODULE_LICENSE(\"GPL v2\");\n");
 	fclose(file);
 }
 
diff --git a/fs/unicode/utf8-core.c b/fs/unicode/utf8-core.c
index d9f713d38c0a..38ca824f1015 100644
--- a/fs/unicode/utf8-core.c
+++ b/fs/unicode/utf8-core.c
@@ -160,25 +160,45 @@ int utf8_normalize(const struct unicode_map *um, const struct qstr *str,
 }
 EXPORT_SYMBOL(utf8_normalize);
 
+static const struct utf8data *find_table_version(const struct utf8data *table,
+		size_t nr_entries, unsigned int version)
+{
+	size_t i = nr_entries - 1;
+
+	while (version < table[i].maxage)
+		i--;
+	if (version > table[i].maxage)
+		return NULL;
+	return &table[i];
+}
+
 struct unicode_map *utf8_load(unsigned int version)
 {
 	struct unicode_map *um;
 
-	if (!utf8version_is_supported(version))
-		return ERR_PTR(-EINVAL);
-
 	um = kzalloc(sizeof(struct unicode_map), GFP_KERNEL);
 	if (!um)
 		return ERR_PTR(-ENOMEM);
 	um->version = version;
-	um->ntab[UTF8_NFDI] = utf8nfdi(version);
-	if (!um->ntab[UTF8_NFDI])
+
+	um->tables = symbol_request(utf8_data_table);
+	if (!um->tables)
 		goto out_free_um;
-	um->ntab[UTF8_NFDICF] = utf8nfdicf(version);
+
+	if (!utf8version_is_supported(um, version))
+		goto out_symbol_put;
+	um->ntab[UTF8_NFDI] = find_table_version(um->tables->utf8nfdidata,
+			um->tables->utf8nfdidata_size, um->version);
+	if (!um->ntab[UTF8_NFDI])
+		goto out_symbol_put;
+	um->ntab[UTF8_NFDICF] = find_table_version(um->tables->utf8nfdicfdata,
+			um->tables->utf8nfdicfdata_size, um->version);
 	if (!um->ntab[UTF8_NFDICF])
-		goto out_free_um;
+		goto out_symbol_put;
 	return um;
 
+out_symbol_put:
+	symbol_put(um->tables);
 out_free_um:
 	kfree(um);
 	return ERR_PTR(-EINVAL);
@@ -187,6 +207,7 @@ EXPORT_SYMBOL(utf8_load);
 
 void utf8_unload(struct unicode_map *um)
 {
+	symbol_put(utf8_data_table);
 	kfree(um);
 }
 EXPORT_SYMBOL(utf8_unload);
diff --git a/fs/unicode/utf8-norm.c b/fs/unicode/utf8-norm.c
index 7c1f28ab31a8..829c7e2ad764 100644
--- a/fs/unicode/utf8-norm.c
+++ b/fs/unicode/utf8-norm.c
@@ -6,21 +6,12 @@
 
 #include "utf8n.h"
 
-struct utf8data {
-	unsigned int maxage;
-	unsigned int offset;
-};
-
-#define __INCLUDED_FROM_UTF8NORM_C__
-#include "utf8data.h"
-#undef __INCLUDED_FROM_UTF8NORM_C__
-
-int utf8version_is_supported(unsigned int version)
+int utf8version_is_supported(const struct unicode_map *um, unsigned int version)
 {
-	int i = ARRAY_SIZE(utf8agetab) - 1;
+	int i = um->tables->utf8agetab_size - 1;
 
-	while (i >= 0 && utf8agetab[i] != 0) {
-		if (version == utf8agetab[i])
+	while (i >= 0 && um->tables->utf8agetab[i] != 0) {
+		if (version == um->tables->utf8agetab[i])
 			return 1;
 		i--;
 	}
@@ -161,7 +152,7 @@ typedef const unsigned char utf8trie_t;
  * underlying datatype: unsigned char.
  *
  * leaf[0]: The unicode version, stored as a generation number that is
- *          an index into utf8agetab[].  With this we can filter code
+ *          an index into ->utf8agetab[].  With this we can filter code
  *          points based on the unicode version in which they were
  *          defined.  The CCC of a non-defined code point is 0.
  * leaf[1]: Canonical Combining Class. During normalization, we need
@@ -313,7 +304,7 @@ static utf8leaf_t *utf8nlookup(const struct unicode_map *um,
 		enum utf8_normalization n, unsigned char *hangul, const char *s,
 		size_t len)
 {
-	utf8trie_t	*trie = utf8data + um->ntab[n]->offset;
+	utf8trie_t	*trie = um->tables->utf8data + um->ntab[n]->offset;
 	int		offlen;
 	int		offset;
 	int		mask;
@@ -404,7 +395,8 @@ ssize_t utf8nlen(const struct unicode_map *um, enum utf8_normalization n,
 		leaf = utf8nlookup(um, n, hangul, s, len);
 		if (!leaf)
 			return -1;
-		if (utf8agetab[LEAF_GEN(leaf)] > um->ntab[n]->maxage)
+		if (um->tables->utf8agetab[LEAF_GEN(leaf)] >
+		    um->ntab[n]->maxage)
 			ret += utf8clen(s);
 		else if (LEAF_CCC(leaf) == DECOMPOSE)
 			ret += strlen(LEAF_STR(leaf));
@@ -520,7 +512,7 @@ int utf8byte(struct utf8cursor *u8c)
 
 		ccc = LEAF_CCC(leaf);
 		/* Characters that are too new have CCC 0. */
-		if (utf8agetab[LEAF_GEN(leaf)] >
+		if (u8c->um->tables->utf8agetab[LEAF_GEN(leaf)] >
 		    u8c->um->ntab[u8c->n]->maxage) {
 			ccc = STOPPER;
 		} else if (ccc == DECOMPOSE) {
@@ -597,25 +589,3 @@ int utf8byte(struct utf8cursor *u8c)
 	}
 }
 EXPORT_SYMBOL(utf8byte);
-
-const struct utf8data *utf8nfdi(unsigned int maxage)
-{
-	int i = ARRAY_SIZE(utf8nfdidata) - 1;
-
-	while (maxage < utf8nfdidata[i].maxage)
-		i--;
-	if (maxage > utf8nfdidata[i].maxage)
-		return NULL;
-	return &utf8nfdidata[i];
-}
-
-const struct utf8data *utf8nfdicf(unsigned int maxage)
-{
-	int i = ARRAY_SIZE(utf8nfdicfdata) - 1;
-
-	while (maxage < utf8nfdicfdata[i].maxage)
-		i--;
-	if (maxage > utf8nfdicfdata[i].maxage)
-		return NULL;
-	return &utf8nfdicfdata[i];
-}
diff --git a/fs/unicode/utf8-selftest.c b/fs/unicode/utf8-selftest.c
index cfa3832b75f4..eb2bbdd688d7 100644
--- a/fs/unicode/utf8-selftest.c
+++ b/fs/unicode/utf8-selftest.c
@@ -255,21 +255,21 @@ static void check_utf8_comparisons(struct unicode_map *table)
 	}
 }
 
-static void check_supported_versions(void)
+static void check_supported_versions(struct unicode_map *um)
 {
 	/* Unicode 7.0.0 should be supported. */
-	test(utf8version_is_supported(UNICODE_AGE(7, 0, 0)));
+	test(utf8version_is_supported(um, UNICODE_AGE(7, 0, 0)));
 
 	/* Unicode 9.0.0 should be supported. */
-	test(utf8version_is_supported(UNICODE_AGE(9, 0, 0)));
+	test(utf8version_is_supported(um, UNICODE_AGE(9, 0, 0)));
 
 	/* Unicode 1x.0.0 (the latest version) should be supported. */
-	test(utf8version_is_supported(UTF8_LATEST));
+	test(utf8version_is_supported(um, UTF8_LATEST));
 
 	/* Next versions don't exist. */
-	test(!utf8version_is_supported(UNICODE_AGE(13, 0, 0)));
-	test(!utf8version_is_supported(UNICODE_AGE(0, 0, 0)));
-	test(!utf8version_is_supported(UNICODE_AGE(-1, -1, -1)));
+	test(!utf8version_is_supported(um, UNICODE_AGE(13, 0, 0)));
+	test(!utf8version_is_supported(um, UNICODE_AGE(0, 0, 0)));
+	test(!utf8version_is_supported(um, UNICODE_AGE(-1, -1, -1)));
 }
 
 static int __init init_test_ucd(void)
@@ -285,7 +285,7 @@ static int __init init_test_ucd(void)
 		return PTR_ERR(um);
 	}
 
-	check_supported_versions();
+	check_supported_versions(um);
 	check_utf8_nfdi(um);
 	check_utf8_nfdicf(um);
 	check_utf8_comparisons(um);
diff --git a/fs/unicode/utf8data.h_shipped b/fs/unicode/utf8data.c_shipped
similarity index 99%
rename from fs/unicode/utf8data.h_shipped
rename to fs/unicode/utf8data.c_shipped
index 76e4f0e1b089..d9b62901aa96 100644
--- a/fs/unicode/utf8data.h_shipped
+++ b/fs/unicode/utf8data.c_shipped
@@ -1,9 +1,8 @@
 /* This file is generated code, do not edit. */
-#ifndef __INCLUDED_FROM_UTF8NORM_C__
-#error Only nls_utf8-norm.c should include this file.
-#endif
 
-static const unsigned int utf8vers = 0xc0100;
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include "utf8n.h"
 
 static const unsigned int utf8agetab[] = {
 	0,
@@ -4107,3 +4106,18 @@ static const unsigned char utf8data[64256] = {
 	0x52,0x04,0x00,0x00,0x11,0x04,0x00,0x00,0x02,0x00,0xcf,0x86,0xcf,0x06,0x02,0x00,
 	0x81,0x80,0xcf,0x86,0x85,0x84,0xcf,0x86,0xcf,0x06,0x02,0x00,0x00,0x00,0x00,0x00
 };
+
+struct utf8data_table utf8_data_table = {
+	.utf8agetab = utf8agetab,
+	.utf8agetab_size = ARRAY_SIZE(utf8agetab),
+
+	.utf8nfdicfdata = utf8nfdicfdata,
+	.utf8nfdicfdata_size = ARRAY_SIZE(utf8nfdicfdata),
+
+	.utf8nfdidata = utf8nfdidata,
+	.utf8nfdidata_size = ARRAY_SIZE(utf8nfdidata),
+
+	.utf8data = utf8data,
+};
+EXPORT_SYMBOL_GPL(utf8_data_table);
+MODULE_LICENSE("GPL v2");
diff --git a/fs/unicode/utf8n.h b/fs/unicode/utf8n.h
index 206c89f0dbf7..bd00d587747a 100644
--- a/fs/unicode/utf8n.h
+++ b/fs/unicode/utf8n.h
@@ -13,25 +13,7 @@
 #include <linux/module.h>
 #include <linux/unicode.h>
 
-int utf8version_is_supported(unsigned int version);
-
-/*
- * Look for the correct const struct utf8data for a unicode version.
- * Returns NULL if the version requested is too new.
- *
- * Two normalization forms are supported: nfdi and nfdicf.
- *
- * nfdi:
- *  - Apply unicode normalization form NFD.
- *  - Remove any Default_Ignorable_Code_Point.
- *
- * nfdicf:
- *  - Apply unicode normalization form NFD.
- *  - Remove any Default_Ignorable_Code_Point.
- *  - Apply a full casefold (C + F).
- */
-extern const struct utf8data *utf8nfdi(unsigned int maxage);
-extern const struct utf8data *utf8nfdicf(unsigned int maxage);
+int utf8version_is_supported(const struct unicode_map *um, unsigned int version);
 
 /*
  * Determine the length of the normalized from of the string,
@@ -78,4 +60,24 @@ int utf8ncursor(struct utf8cursor *u8c, const struct unicode_map *um,
  */
 extern int utf8byte(struct utf8cursor *u8c);
 
+struct utf8data {
+	unsigned int maxage;
+	unsigned int offset;
+};
+
+struct utf8data_table {
+	const unsigned int *utf8agetab;
+	int utf8agetab_size;
+
+	const struct utf8data *utf8nfdicfdata;
+	int utf8nfdicfdata_size;
+
+	const struct utf8data *utf8nfdidata;
+	int utf8nfdidata_size;
+
+	const unsigned char *utf8data;
+};
+
+extern struct utf8data_table utf8_data_table;
+
 #endif /* UTF8NORM_H */
diff --git a/include/linux/unicode.h b/include/linux/unicode.h
index 3e502c7456e8..2b3849e7cd64 100644
--- a/include/linux/unicode.h
+++ b/include/linux/unicode.h
@@ -6,6 +6,7 @@
 #include <linux/dcache.h>
 
 struct utf8data;
+struct utf8data_table;
 
 /* Encoding a unicode version number as a single unsigned int. */
 #define UNICODE_MAJ_SHIFT		(16)
@@ -35,6 +36,7 @@ enum utf8_normalization {
 struct unicode_map {
 	unsigned int version;
 	const struct utf8data *ntab[UTF8_NMAX];
+	const struct utf8data_table *tables;
 };
 
 int utf8_validate(const struct unicode_map *um, const struct qstr *str);
-- 
2.30.2

