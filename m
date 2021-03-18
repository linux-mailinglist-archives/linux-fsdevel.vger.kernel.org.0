Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4CD53406F8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Mar 2021 14:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbhCRNeX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Mar 2021 09:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbhCRNeQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Mar 2021 09:34:16 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DD2C06174A;
        Thu, 18 Mar 2021 06:34:15 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: shreeya)
        with ESMTPSA id B1A071F45E8F
From:   Shreeya Patel <shreeya.patel@collabora.com>
To:     krisman@collabora.com, jaegeuk@kernel.org, yuchao0@huawei.com,
        tytso@mit.edu, adilger.kernel@dilger.ca, drosen@google.com,
        ebiggers@google.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel@collabora.com, andre.almeida@collabora.com,
        Shreeya Patel <shreeya.patel@collabora.com>
Subject: [PATCH v2 4/4] fs: unicode: Add utf8 module and a unicode layer
Date:   Thu, 18 Mar 2021 19:03:05 +0530
Message-Id: <20210318133305.316564-5-shreeya.patel@collabora.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210318133305.316564-1-shreeya.patel@collabora.com>
References: <20210318133305.316564-1-shreeya.patel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

utf8data.h_shipped has a large database table which is an auto-generated
decodification trie for the unicode normalization functions.
It is not necessary to carry this large table in the kernel hence make
UTF-8 encoding loadable by converting it into a module.
Also, modify the file called unicode-core which will act as a layer for
unicode subsystem. It will load the UTF-8 module and access it's functions
whenever any filesystem that needs unicode is mounted.

Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
---

Changes in v2
  - Remove the duplicate file utf8-core.c
  - Make the wrapper functions inline.
  - Remove msleep and use try_module_get() and module_put()
    for ensuring that module is loaded correctly and also
    doesn't get unloaded while in use.

 fs/unicode/Kconfig        |  11 +-
 fs/unicode/Makefile       |   5 +-
 fs/unicode/unicode-core.c | 229 +++++------------------------------
 fs/unicode/utf8mod.c      | 246 ++++++++++++++++++++++++++++++++++++++
 include/linux/unicode.h   |  73 ++++++++---
 5 files changed, 346 insertions(+), 218 deletions(-)
 create mode 100644 fs/unicode/utf8mod.c

diff --git a/fs/unicode/Kconfig b/fs/unicode/Kconfig
index 2c27b9a5cd6c..2961b0206b4d 100644
--- a/fs/unicode/Kconfig
+++ b/fs/unicode/Kconfig
@@ -8,7 +8,16 @@ config UNICODE
 	  Say Y here to enable UTF-8 NFD normalization and NFD+CF casefolding
 	  support.
 
+# UTF-8 encoding can be compiled as a module using UNICODE_UTF8 option.
+# Having UTF-8 encoding as a module will avoid carrying large
+# database table present in utf8data.h_shipped into the kernel
+# by being able to load it only when it is required by the filesystem.
+config UNICODE_UTF8
+	tristate "UTF-8 module"
+	depends on UNICODE
+	default m
+
 config UNICODE_NORMALIZATION_SELFTEST
 	tristate "Test UTF-8 normalization support"
-	depends on UNICODE
+	depends on UNICODE_UTF8
 	default n
diff --git a/fs/unicode/Makefile b/fs/unicode/Makefile
index fbf9a629ed0d..9dbb04194b32 100644
--- a/fs/unicode/Makefile
+++ b/fs/unicode/Makefile
@@ -1,11 +1,14 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_UNICODE) += unicode.o
+obj-$(CONFIG_UNICODE_UTF8) += utf8.o
 obj-$(CONFIG_UNICODE_NORMALIZATION_SELFTEST) += utf8-selftest.o
 
-unicode-y := utf8-norm.o unicode-core.o
+unicode-y := unicode-core.o
+utf8-y := utf8mod.o utf8-norm.o
 
 $(obj)/utf8-norm.o: $(obj)/utf8data.h
+$(obj)/utf8mod.o: $(obj)/utf8-norm.o
 
 # In the normal build, the checked-in utf8data.h is just shipped.
 #
diff --git a/fs/unicode/unicode-core.c b/fs/unicode/unicode-core.c
index 287a8a48836c..945984a3fe9e 100644
--- a/fs/unicode/unicode-core.c
+++ b/fs/unicode/unicode-core.c
@@ -1,235 +1,60 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #include <linux/module.h>
 #include <linux/kernel.h>
-#include <linux/string.h>
 #include <linux/slab.h>
-#include <linux/parser.h>
 #include <linux/errno.h>
 #include <linux/unicode.h>
-#include <linux/stringhash.h>
 
-#include "utf8n.h"
 
-int unicode_validate(const struct unicode_map *um, const struct qstr *str)
-{
-	const struct utf8data *data = utf8nfdi(um->version);
-
-	if (utf8nlen(data, str->name, str->len) < 0)
-		return -1;
-	return 0;
-}
-EXPORT_SYMBOL(unicode_validate);
-
-int unicode_strncmp(const struct unicode_map *um,
-		    const struct qstr *s1, const struct qstr *s2)
-{
-	const struct utf8data *data = utf8nfdi(um->version);
-	struct utf8cursor cur1, cur2;
-	int c1, c2;
-
-	if (utf8ncursor(&cur1, data, s1->name, s1->len) < 0)
-		return -EINVAL;
-
-	if (utf8ncursor(&cur2, data, s2->name, s2->len) < 0)
-		return -EINVAL;
-
-	do {
-		c1 = utf8byte(&cur1);
-		c2 = utf8byte(&cur2);
-
-		if (c1 < 0 || c2 < 0)
-			return -EINVAL;
-		if (c1 != c2)
-			return 1;
-	} while (c1);
-
-	return 0;
-}
-EXPORT_SYMBOL(unicode_strncmp);
-
-int unicode_strncasecmp(const struct unicode_map *um,
-			const struct qstr *s1, const struct qstr *s2)
-{
-	const struct utf8data *data = utf8nfdicf(um->version);
-	struct utf8cursor cur1, cur2;
-	int c1, c2;
+struct unicode_ops *utf8_ops;
+EXPORT_SYMBOL(utf8_ops);
 
-	if (utf8ncursor(&cur1, data, s1->name, s1->len) < 0)
-		return -EINVAL;
-
-	if (utf8ncursor(&cur2, data, s2->name, s2->len) < 0)
-		return -EINVAL;
-
-	do {
-		c1 = utf8byte(&cur1);
-		c2 = utf8byte(&cur2);
-
-		if (c1 < 0 || c2 < 0)
-			return -EINVAL;
-		if (c1 != c2)
-			return 1;
-	} while (c1);
-
-	return 0;
-}
-EXPORT_SYMBOL(unicode_strncasecmp);
-
-/* String cf is expected to be a valid UTF-8 casefolded
- * string.
- */
-int unicode_strncasecmp_folded(const struct unicode_map *um,
-			       const struct qstr *cf,
-			       const struct qstr *s1)
+static int unicode_load_module(void)
 {
-	const struct utf8data *data = utf8nfdicf(um->version);
-	struct utf8cursor cur1;
-	int c1, c2;
-	int i = 0;
-
-	if (utf8ncursor(&cur1, data, s1->name, s1->len) < 0)
-		return -EINVAL;
-
-	do {
-		c1 = utf8byte(&cur1);
-		c2 = cf->name[i++];
-		if (c1 < 0)
-			return -EINVAL;
-		if (c1 != c2)
-			return 1;
-	} while (c1);
-
-	return 0;
-}
-EXPORT_SYMBOL(unicode_strncasecmp_folded);
-
-int unicode_casefold(const struct unicode_map *um, const struct qstr *str,
-		     unsigned char *dest, size_t dlen)
-{
-	const struct utf8data *data = utf8nfdicf(um->version);
-	struct utf8cursor cur;
-	size_t nlen = 0;
-
-	if (utf8ncursor(&cur, data, str->name, str->len) < 0)
-		return -EINVAL;
+	int ret = request_module("utf8");
 
-	for (nlen = 0; nlen < dlen; nlen++) {
-		int c = utf8byte(&cur);
-
-		dest[nlen] = c;
-		if (!c)
-			return nlen;
-		if (c == -1)
-			break;
+	if (ret) {
+		pr_err("Failed to load UTF-8 module\n");
+		return ret;
 	}
-	return -EINVAL;
-}
-EXPORT_SYMBOL(unicode_casefold);
-
-int unicode_casefold_hash(const struct unicode_map *um, const void *salt,
-			  struct qstr *str)
-{
-	const struct utf8data *data = utf8nfdicf(um->version);
-	struct utf8cursor cur;
-	int c;
-	unsigned long hash = init_name_hash(salt);
 
-	if (utf8ncursor(&cur, data, str->name, str->len) < 0)
-		return -EINVAL;
-
-	while ((c = utf8byte(&cur))) {
-		if (c < 0)
-			return -EINVAL;
-		hash = partial_name_hash((unsigned char)c, hash);
-	}
-	str->hash = end_name_hash(hash);
 	return 0;
 }
-EXPORT_SYMBOL(unicode_casefold_hash);
 
-int unicode_normalize(const struct unicode_map *um, const struct qstr *str,
-		      unsigned char *dest, size_t dlen)
+struct unicode_map *unicode_load(const char *version)
 {
-	const struct utf8data *data = utf8nfdi(um->version);
-	struct utf8cursor cur;
-	ssize_t nlen = 0;
+	int ret = unicode_load_module();
 
-	if (utf8ncursor(&cur, data, str->name, str->len) < 0)
-		return -EINVAL;
+	if (ret)
+		return ERR_PTR(ret);
 
-	for (nlen = 0; nlen < dlen; nlen++) {
-		int c = utf8byte(&cur);
+	if (utf8_ops && !try_module_get(utf8_ops->owner))
+		return ERR_PTR(-ENODEV);
 
-		dest[nlen] = c;
-		if (!c)
-			return nlen;
-		if (c == -1)
-			break;
-	}
-	return -EINVAL;
+	else
+		return utf8_ops->load(version);
 }
-EXPORT_SYMBOL(unicode_normalize);
+EXPORT_SYMBOL(unicode_load);
 
-static int unicode_parse_version(const char *version, unsigned int *maj,
-				 unsigned int *min, unsigned int *rev)
+void unicode_unload(struct unicode_map *um)
 {
-	substring_t args[3];
-	char version_string[12];
-	static const struct match_token token[] = {
-		{1, "%d.%d.%d"},
-		{0, NULL}
-	};
-
-	strscpy(version_string, version, sizeof(version_string));
-
-	if (match_token(version_string, token, args) != 1)
-		return -EINVAL;
+	if (utf8_ops)
+		module_put(utf8_ops->owner);
 
-	if (match_int(&args[0], maj) || match_int(&args[1], min) ||
-	    match_int(&args[2], rev))
-		return -EINVAL;
-
-	return 0;
+	kfree(um);
 }
+EXPORT_SYMBOL(unicode_unload);
 
-struct unicode_map *unicode_load(const char *version)
+void unicode_register(struct unicode_ops *ops)
 {
-	struct unicode_map *um = NULL;
-	int unicode_version;
-
-	if (version) {
-		unsigned int maj, min, rev;
-
-		if (unicode_parse_version(version, &maj, &min, &rev) < 0)
-			return ERR_PTR(-EINVAL);
-
-		if (!utf8version_is_supported(maj, min, rev))
-			return ERR_PTR(-EINVAL);
-
-		unicode_version = UNICODE_AGE(maj, min, rev);
-	} else {
-		unicode_version = utf8version_latest();
-		printk(KERN_WARNING"UTF-8 version not specified. "
-		       "Assuming latest supported version (%d.%d.%d).",
-		       (unicode_version >> 16) & 0xff,
-		       (unicode_version >> 8) & 0xff,
-		       (unicode_version & 0xff));
-	}
-
-	um = kzalloc(sizeof(struct unicode_map), GFP_KERNEL);
-	if (!um)
-		return ERR_PTR(-ENOMEM);
-
-	um->charset = "UTF-8";
-	um->version = unicode_version;
-
-	return um;
+	utf8_ops = ops;
 }
-EXPORT_SYMBOL(unicode_load);
+EXPORT_SYMBOL(unicode_register);
 
-void unicode_unload(struct unicode_map *um)
+void unicode_unregister(void)
 {
-	kfree(um);
+	utf8_ops = NULL;
 }
-EXPORT_SYMBOL(unicode_unload);
+EXPORT_SYMBOL(unicode_unregister);
 
 MODULE_LICENSE("GPL v2");
diff --git a/fs/unicode/utf8mod.c b/fs/unicode/utf8mod.c
new file mode 100644
index 000000000000..9981960da863
--- /dev/null
+++ b/fs/unicode/utf8mod.c
@@ -0,0 +1,246 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/slab.h>
+#include <linux/parser.h>
+#include <linux/errno.h>
+#include <linux/unicode.h>
+#include <linux/stringhash.h>
+
+#include "utf8n.h"
+
+static int utf8_validate(const struct unicode_map *um, const struct qstr *str)
+{
+	const struct utf8data *data = utf8nfdi(um->version);
+
+	if (utf8nlen(data, str->name, str->len) < 0)
+		return -1;
+	return 0;
+}
+
+static int utf8_strncmp(const struct unicode_map *um,
+			const struct qstr *s1, const struct qstr *s2)
+{
+	const struct utf8data *data = utf8nfdi(um->version);
+	struct utf8cursor cur1, cur2;
+	int c1, c2;
+
+	if (utf8ncursor(&cur1, data, s1->name, s1->len) < 0)
+		return -EINVAL;
+
+	if (utf8ncursor(&cur2, data, s2->name, s2->len) < 0)
+		return -EINVAL;
+
+	do {
+		c1 = utf8byte(&cur1);
+		c2 = utf8byte(&cur2);
+
+		if (c1 < 0 || c2 < 0)
+			return -EINVAL;
+		if (c1 != c2)
+			return 1;
+	} while (c1);
+
+	return 0;
+}
+
+static int utf8_strncasecmp(const struct unicode_map *um,
+			    const struct qstr *s1, const struct qstr *s2)
+{
+	const struct utf8data *data = utf8nfdicf(um->version);
+	struct utf8cursor cur1, cur2;
+	int c1, c2;
+
+	if (utf8ncursor(&cur1, data, s1->name, s1->len) < 0)
+		return -EINVAL;
+
+	if (utf8ncursor(&cur2, data, s2->name, s2->len) < 0)
+		return -EINVAL;
+
+	do {
+		c1 = utf8byte(&cur1);
+		c2 = utf8byte(&cur2);
+
+		if (c1 < 0 || c2 < 0)
+			return -EINVAL;
+		if (c1 != c2)
+			return 1;
+	} while (c1);
+
+	return 0;
+}
+
+/* String cf is expected to be a valid UTF-8 casefolded
+ * string.
+ */
+static int utf8_strncasecmp_folded(const struct unicode_map *um,
+				   const struct qstr *cf,
+				   const struct qstr *s1)
+{
+	const struct utf8data *data = utf8nfdicf(um->version);
+	struct utf8cursor cur1;
+	int c1, c2;
+	int i = 0;
+
+	if (utf8ncursor(&cur1, data, s1->name, s1->len) < 0)
+		return -EINVAL;
+
+	do {
+		c1 = utf8byte(&cur1);
+		c2 = cf->name[i++];
+		if (c1 < 0)
+			return -EINVAL;
+		if (c1 != c2)
+			return 1;
+	} while (c1);
+
+	return 0;
+}
+
+static int utf8_casefold(const struct unicode_map *um, const struct qstr *str,
+			 unsigned char *dest, size_t dlen)
+{
+	const struct utf8data *data = utf8nfdicf(um->version);
+	struct utf8cursor cur;
+	size_t nlen = 0;
+
+	if (utf8ncursor(&cur, data, str->name, str->len) < 0)
+		return -EINVAL;
+
+	for (nlen = 0; nlen < dlen; nlen++) {
+		int c = utf8byte(&cur);
+
+		dest[nlen] = c;
+		if (!c)
+			return nlen;
+		if (c == -1)
+			break;
+	}
+	return -EINVAL;
+}
+
+static int utf8_casefold_hash(const struct unicode_map *um, const void *salt,
+			      struct qstr *str)
+{
+	const struct utf8data *data = utf8nfdicf(um->version);
+	struct utf8cursor cur;
+	int c;
+	unsigned long hash = init_name_hash(salt);
+
+	if (utf8ncursor(&cur, data, str->name, str->len) < 0)
+		return -EINVAL;
+
+	while ((c = utf8byte(&cur))) {
+		if (c < 0)
+			return -EINVAL;
+		hash = partial_name_hash((unsigned char)c, hash);
+	}
+	str->hash = end_name_hash(hash);
+	return 0;
+}
+
+static int utf8_normalize(const struct unicode_map *um, const struct qstr *str,
+			  unsigned char *dest, size_t dlen)
+{
+	const struct utf8data *data = utf8nfdi(um->version);
+	struct utf8cursor cur;
+	ssize_t nlen = 0;
+
+	if (utf8ncursor(&cur, data, str->name, str->len) < 0)
+		return -EINVAL;
+
+	for (nlen = 0; nlen < dlen; nlen++) {
+		int c = utf8byte(&cur);
+
+		dest[nlen] = c;
+		if (!c)
+			return nlen;
+		if (c == -1)
+			break;
+	}
+	return -EINVAL;
+}
+
+static int utf8_parse_version(const char *version, unsigned int *maj,
+			      unsigned int *min, unsigned int *rev)
+{
+	substring_t args[3];
+	char version_string[12];
+	static const struct match_token token[] = {
+		{1, "%d.%d.%d"},
+		{0, NULL}
+	};
+
+	strscpy(version_string, version, sizeof(version_string));
+
+	if (match_token(version_string, token, args) != 1)
+		return -EINVAL;
+
+	if (match_int(&args[0], maj) || match_int(&args[1], min) ||
+	    match_int(&args[2], rev))
+		return -EINVAL;
+
+	return 0;
+}
+
+static struct unicode_map *utf8_load(const char *version)
+{
+	struct unicode_map *um = NULL;
+	int unicode_version;
+
+	if (version) {
+		unsigned int maj, min, rev;
+
+		if (utf8_parse_version(version, &maj, &min, &rev) < 0)
+			return ERR_PTR(-EINVAL);
+
+		if (!utf8version_is_supported(maj, min, rev))
+			return ERR_PTR(-EINVAL);
+
+		unicode_version = UNICODE_AGE(maj, min, rev);
+	} else {
+		unicode_version = utf8version_latest();
+		pr_warn("UTF-8 version not specified. Assuming latest supported version (%d.%d.%d).",
+			(unicode_version >> 16) & 0xff,
+			(unicode_version >> 8) & 0xff,
+			(unicode_version & 0xfe));
+	}
+
+	um = kzalloc(sizeof(*um), GFP_KERNEL);
+	if (!um)
+		return ERR_PTR(-ENOMEM);
+
+	um->charset = "UTF-8";
+	um->version = unicode_version;
+
+	return um;
+}
+
+static struct unicode_ops ops = {
+	.owner = THIS_MODULE,
+	.validate = utf8_validate,
+	.strncmp = utf8_strncmp,
+	.strncasecmp = utf8_strncasecmp,
+	.strncasecmp_folded = utf8_strncasecmp_folded,
+	.casefold = utf8_casefold,
+	.casefold_hash = utf8_casefold_hash,
+	.normalize = utf8_normalize,
+	.load = utf8_load,
+};
+
+static int __init utf8_init(void)
+{
+	unicode_register(&ops);
+	return 0;
+}
+
+static void __exit utf8_exit(void)
+{
+	unicode_unregister();
+}
+
+module_init(utf8_init);
+module_exit(utf8_exit);
+
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/unicode.h b/include/linux/unicode.h
index de23f9ee720b..5c9ebd49bfc4 100644
--- a/include/linux/unicode.h
+++ b/include/linux/unicode.h
@@ -10,27 +10,72 @@ struct unicode_map {
 	int version;
 };
 
-int unicode_validate(const struct unicode_map *um, const struct qstr *str);
+struct unicode_ops {
+	struct module *owner;
+	int (*validate)(const struct unicode_map *um, const struct qstr *str);
+	int (*strncmp)(const struct unicode_map *um, const struct qstr *s1,
+		       const struct qstr *s2);
+	int (*strncasecmp)(const struct unicode_map *um, const struct qstr *s1,
+			   const struct qstr *s2);
+	int (*strncasecmp_folded)(const struct unicode_map *um, const struct qstr *cf,
+				  const struct qstr *s1);
+	int (*normalize)(const struct unicode_map *um, const struct qstr *str,
+			 unsigned char *dest, size_t dlen);
+	int (*casefold)(const struct unicode_map *um, const struct qstr *str,
+			unsigned char *dest, size_t dlen);
+	int (*casefold_hash)(const struct unicode_map *um, const void *salt,
+			     struct qstr *str);
+	struct unicode_map* (*load)(const char *version);
+};
+
+extern struct unicode_ops *utf8_ops;
+
+static inline int unicode_validate(const struct unicode_map *um, const struct qstr *str)
+{
+	return utf8_ops->validate(um, str);
+}
 
-int unicode_strncmp(const struct unicode_map *um,
-		    const struct qstr *s1, const struct qstr *s2);
+static inline int unicode_strncmp(const struct unicode_map *um,
+				  const struct qstr *s1, const struct qstr *s2)
+{
+	return utf8_ops->strncmp(um, s1, s2);
+}
 
-int unicode_strncasecmp(const struct unicode_map *um,
-			const struct qstr *s1, const struct qstr *s2);
-int unicode_strncasecmp_folded(const struct unicode_map *um,
-			       const struct qstr *cf,
-			       const struct qstr *s1);
+static inline int unicode_strncasecmp(const struct unicode_map *um,
+				      const struct qstr *s1, const struct qstr *s2)
+{
+	return utf8_ops->strncasecmp(um, s1, s2);
+}
 
-int unicode_normalize(const struct unicode_map *um, const struct qstr *str,
-		      unsigned char *dest, size_t dlen);
+static inline int unicode_strncasecmp_folded(const struct unicode_map *um,
+					     const struct qstr *cf,
+					     const struct qstr *s1)
+{
+	return utf8_ops->strncasecmp_folded(um, cf, s1);
+}
 
-int unicode_casefold(const struct unicode_map *um, const struct qstr *str,
-		     unsigned char *dest, size_t dlen);
+static inline int unicode_normalize(const struct unicode_map *um, const struct qstr *str,
+				    unsigned char *dest, size_t dlen)
+{
+	return utf8_ops->normalize(um, str, dest, dlen);
+}
 
-int unicode_casefold_hash(const struct unicode_map *um, const void *salt,
-			  struct qstr *str);
+static inline int unicode_casefold(const struct unicode_map *um, const struct qstr *str,
+				   unsigned char *dest, size_t dlen)
+{
+	return utf8_ops->casefold(um, str, dest, dlen);
+}
+
+static inline int unicode_casefold_hash(const struct unicode_map *um, const void *salt,
+					struct qstr *str)
+{
+	return utf8_ops->casefold_hash(um, salt, str);
+}
 
 struct unicode_map *unicode_load(const char *version);
 void unicode_unload(struct unicode_map *um);
 
+void unicode_register(struct unicode_ops *ops);
+void unicode_unregister(void);
+
 #endif /* _LINUX_UNICODE_H */
-- 
2.30.1

