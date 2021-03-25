Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 999103485B8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Mar 2021 01:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239169AbhCYAJP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Mar 2021 20:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234902AbhCYAIu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Mar 2021 20:08:50 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9BEC06174A;
        Wed, 24 Mar 2021 17:08:50 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: shreeya)
        with ESMTPSA id 81A3F1F45F1C
From:   Shreeya Patel <shreeya.patel@collabora.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        chao@kernel.org, krisman@collabora.com, ebiggers@google.com,
        drosen@google.com, ebiggers@kernel.org, yuchao0@huawei.com
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, kernel@collabora.com,
        andre.almeida@collabora.com
Subject: [PATCH v4 5/5] fs: unicode: Add utf8 module and a unicode layer
Date:   Thu, 25 Mar 2021 05:38:11 +0530
Message-Id: <20210325000811.1379641-6-shreeya.patel@collabora.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210325000811.1379641-1-shreeya.patel@collabora.com>
References: <20210325000811.1379641-1-shreeya.patel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

utf8data.h_shipped has a large database table which is an auto-generated
decodification trie for the unicode normalization functions.
It is not necessary to load this large table in the kernel if no
file system is using it, hence make UTF-8 encoding loadable by converting
it into a module.
Modify the file called unicode-core which will act as a layer for
unicode subsystem. It will load the UTF-8 module and access it's functions
whenever any filesystem that needs unicode is mounted.
Also, indirect calls using function pointers are easily exploitable by
speculative execution attacks, hence use static_call() in unicode.h and
unicode-core.c files inorder to prevent these attacks by making direct
calls and also to improve the performance of function pointers.

Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
---
Changes in v4
  - Return error from the static calls instead of doing nothing and
    succeeding even without loading the module.
  - Remove the complete usage of utf8_ops and use static calls at all
    places.
  - Restore the static calls to default values when module is unloaded.
  - Decrement the reference of module after calling the unload function.
  - Remove spinlock as there will be no race conditions after removing
    utf8_ops.

Changes in v3
  - Correct the conditions to prevent NULL pointer dereference while
    accessing functions via utf8_ops variable.
  - Add spinlock to avoid race conditions that could occur if the module
    is deregistered after checking utf8_ops and before doing the
    try_module_get() in the following if condition
    if (!utf8_ops || !try_module_get(utf8_ops->owner)
  - Use static_call() for preventing speculative execution attacks.
  - WARN_ON in case utf8_ops is NULL in unicode_unload().
  - Rename module file from utf8mod to unicode-utf8.

Changes in v2
  - Remove the duplicate file utf8-core.c
  - Make the wrapper functions inline.
  - Remove msleep and use try_module_get() and module_put()
    for ensuring that module is loaded correctly and also
    doesn't get unloaded while in use.

 fs/unicode/Kconfig        |  11 +-
 fs/unicode/Makefile       |   5 +-
 fs/unicode/unicode-core.c | 243 +++++++----------------------------
 fs/unicode/unicode-utf8.c | 263 ++++++++++++++++++++++++++++++++++++++
 include/linux/unicode.h   | 129 +++++++++++++++++--
 5 files changed, 437 insertions(+), 214 deletions(-)
 create mode 100644 fs/unicode/unicode-utf8.c

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
index fbf9a629ed0d..49d50083e6ee 100644
--- a/fs/unicode/Makefile
+++ b/fs/unicode/Makefile
@@ -1,11 +1,14 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_UNICODE) += unicode.o
+obj-$(CONFIG_UNICODE_UTF8) += utf8.o
 obj-$(CONFIG_UNICODE_NORMALIZATION_SELFTEST) += utf8-selftest.o
 
-unicode-y := utf8-norm.o unicode-core.o
+unicode-y := unicode-core.o
+utf8-y := unicode-utf8.o utf8-norm.o
 
 $(obj)/utf8-norm.o: $(obj)/utf8data.h
+$(obj)/unicode-utf8.o: $(obj)/utf8-norm.o
 
 # In the normal build, the checked-in utf8data.h is just shipped.
 #
diff --git a/fs/unicode/unicode-core.c b/fs/unicode/unicode-core.c
index 730dbaedf593..727f9cc699db 100644
--- a/fs/unicode/unicode-core.c
+++ b/fs/unicode/unicode-core.c
@@ -1,237 +1,84 @@
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
+static struct module *utf8mod;
 
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
+DEFINE_STATIC_CALL(validate, unicode_validate_static_call);
+EXPORT_STATIC_CALL(validate);
 
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
+DEFINE_STATIC_CALL(strncmp, unicode_strncmp_static_call);
+EXPORT_STATIC_CALL(strncmp);
 
-int unicode_strncasecmp(const struct unicode_map *um,
-			const struct qstr *s1, const struct qstr *s2)
-{
-	const struct utf8data *data = utf8nfdicf(um->version);
-	struct utf8cursor cur1, cur2;
-	int c1, c2;
+DEFINE_STATIC_CALL(strncasecmp, unicode_strncasecmp_static_call);
+EXPORT_STATIC_CALL(strncasecmp);
 
-	if (utf8ncursor(&cur1, data, s1->name, s1->len) < 0)
-		return -EINVAL;
+DEFINE_STATIC_CALL(strncasecmp_folded, unicode_strncasecmp_folded_static_call);
+EXPORT_STATIC_CALL(strncasecmp_folded);
 
-	if (utf8ncursor(&cur2, data, s2->name, s2->len) < 0)
-		return -EINVAL;
+DEFINE_STATIC_CALL(normalize, unicode_normalize_static_call);
+EXPORT_STATIC_CALL(normalize);
 
-	do {
-		c1 = utf8byte(&cur1);
-		c2 = utf8byte(&cur2);
+DEFINE_STATIC_CALL(casefold, unicode_casefold_static_call);
+EXPORT_STATIC_CALL(casefold);
 
-		if (c1 < 0 || c2 < 0)
-			return -EINVAL;
-		if (c1 != c2)
-			return 1;
-	} while (c1);
+DEFINE_STATIC_CALL(casefold_hash, unicode_casefold_hash_static_call);
+EXPORT_STATIC_CALL(casefold_hash);
 
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
-{
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
+DEFINE_STATIC_CALL(load, unicode_load_static_call);
+EXPORT_STATIC_CALL(load);
 
-	return 0;
-}
-EXPORT_SYMBOL(unicode_strncasecmp_folded);
+DEFINE_STATIC_CALL(unload, unicode_unload_static_call);
+EXPORT_STATIC_CALL(unload);
 
-int unicode_casefold(const struct unicode_map *um, const struct qstr *str,
-		     unsigned char *dest, size_t dlen)
+static int unicode_load_module(void)
 {
-	const struct utf8data *data = utf8nfdicf(um->version);
-	struct utf8cursor cur;
-	size_t nlen = 0;
-
-	if (utf8ncursor(&cur, data, str->name, str->len) < 0)
-		return -EINVAL;
-
-	for (nlen = 0; nlen < dlen; nlen++) {
-		int c = utf8byte(&cur);
+	int ret = request_module("utf8");
 
-		dest[nlen] = c;
-		if (!c)
-			return nlen;
-		if (c == -1)
-			break;
-	}
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
-
-	if (utf8ncursor(&cur, data, str->name, str->len) < 0)
-		return -EINVAL;
-
-	while ((c = utf8byte(&cur))) {
-		if (c < 0)
-			return -EINVAL;
-		hash = partial_name_hash((unsigned char)c, hash);
+	if (ret) {
+		pr_err("Failed to load UTF-8 module\n");
+		return ret;
 	}
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
-
-	if (utf8ncursor(&cur, data, str->name, str->len) < 0)
-		return -EINVAL;
+	int ret = unicode_load_module();
 
-	for (nlen = 0; nlen < dlen; nlen++) {
-		int c = utf8byte(&cur);
+	if (ret)
+		return ERR_PTR(ret);
 
-		dest[nlen] = c;
-		if (!c)
-			return nlen;
-		if (c == -1)
-			break;
-	}
-	return -EINVAL;
+	if (!try_module_get(utf8mod))
+		return ERR_PTR(-ENODEV);
+	else
+		return static_call(load)(version);
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
-	int ret = strscpy(version_string, version, sizeof(version_string));
-
-	if (ret < 0)
-		return ret;
-
-	if (match_token(version_string, token, args) != 1)
-		return -EINVAL;
-
-	if (match_int(&args[0], maj) || match_int(&args[1], min) ||
-	    match_int(&args[2], rev))
-		return -EINVAL;
+	if (WARN_ON(!utf8mod))
+		return;
 
-	return 0;
+	static_call(unload)(um);
+	module_put(utf8mod);
 }
+EXPORT_SYMBOL(unicode_unload);
 
-struct unicode_map *unicode_load(const char *version)
+void unicode_register(struct module *owner)
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
+	utf8mod = owner;
 }
-EXPORT_SYMBOL(unicode_load);
+EXPORT_SYMBOL(unicode_register);
 
-void unicode_unload(struct unicode_map *um)
+void unicode_unregister(void)
 {
-	kfree(um);
+	utf8mod = NULL;
 }
-EXPORT_SYMBOL(unicode_unload);
+EXPORT_SYMBOL(unicode_unregister);
 
 MODULE_LICENSE("GPL v2");
diff --git a/fs/unicode/unicode-utf8.c b/fs/unicode/unicode-utf8.c
new file mode 100644
index 000000000000..61c40a60ddf4
--- /dev/null
+++ b/fs/unicode/unicode-utf8.c
@@ -0,0 +1,263 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/slab.h>
+#include <linux/parser.h>
+#include <linux/errno.h>
+#include <linux/unicode.h>
+#include <linux/stringhash.h>
+#include <linux/static_call.h>
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
+	int ret = strscpy(version_string, version, sizeof(version_string));
+
+	if (ret < 0)
+		return ret;
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
+void utf8_unload(struct unicode_map *um)
+{
+	kfree(um);
+}
+
+static int __init utf8_init(void)
+{
+	static_call_update(validate, utf8_validate);
+	static_call_update(strncmp, utf8_strncmp);
+	static_call_update(strncasecmp, utf8_strncasecmp);
+	static_call_update(strncasecmp_folded, utf8_strncasecmp_folded);
+	static_call_update(normalize, utf8_normalize);
+	static_call_update(casefold, utf8_casefold);
+	static_call_update(casefold_hash, utf8_casefold_hash);
+	static_call_update(load, utf8_load);
+	static_call_update(unload, utf8_unload);
+
+	unicode_register(THIS_MODULE);
+	return 0;
+}
+
+static void __exit utf8_exit(void)
+{
+	static_call_update(validate, unicode_validate_static_call);
+	static_call_update(strncmp, unicode_strncmp_static_call);
+	static_call_update(strncasecmp, unicode_strncasecmp_static_call);
+	static_call_update(strncasecmp_folded, unicode_strncasecmp_folded_static_call);
+	static_call_update(normalize, unicode_normalize_static_call);
+	static_call_update(casefold, unicode_casefold_static_call);
+	static_call_update(casefold_hash, unicode_casefold_hash_static_call);
+	static_call_update(load, unicode_load_static_call);
+	static_call_update(unload, unicode_unload_static_call);
+
+	unicode_unregister();
+}
+
+module_init(utf8_init);
+module_exit(utf8_exit);
+
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/unicode.h b/include/linux/unicode.h
index de23f9ee720b..7752bfddc1e1 100644
--- a/include/linux/unicode.h
+++ b/include/linux/unicode.h
@@ -4,33 +4,134 @@
 
 #include <linux/init.h>
 #include <linux/dcache.h>
+#include <linux/static_call.h>
+
 
 struct unicode_map {
 	const char *charset;
 	int version;
 };
 
-int unicode_validate(const struct unicode_map *um, const struct qstr *str);
+static int unicode_warn_on(void)
+{
+	WARN_ON(1);
+	return -EIO;
+}
+
+static int unicode_validate_static_call(const struct unicode_map *um,
+					const struct qstr *str)
+{
+	return unicode_warn_on();
+}
+
+static int unicode_strncmp_static_call(const struct unicode_map *um,
+				       const struct qstr *s1,
+				       const struct qstr *s2)
+{
+	return unicode_warn_on();
+}
+
+static int unicode_strncasecmp_static_call(const struct unicode_map *um,
+					   const struct qstr *s1,
+					   const struct qstr *s2)
+{
+	return unicode_warn_on();
+}
+
+static int unicode_strncasecmp_folded_static_call(const struct unicode_map *um,
+						  const struct qstr *cf,
+						  const struct qstr *s1)
+{
+	return unicode_warn_on();
+}
+
+static int unicode_normalize_static_call(const struct unicode_map *um,
+					 const struct qstr *str,
+					 unsigned char *dest, size_t dlen)
+{
+	return unicode_warn_on();
+}
+
+static int unicode_casefold_static_call(const struct unicode_map *um,
+					const struct qstr *str,
+					unsigned char *dest, size_t dlen)
+{
+	return unicode_warn_on();
+}
 
-int unicode_strncmp(const struct unicode_map *um,
-		    const struct qstr *s1, const struct qstr *s2);
+static int unicode_casefold_hash_static_call(const struct unicode_map *um,
+					     const void *salt, struct qstr *str)
+{
+	return unicode_warn_on();
+}
 
-int unicode_strncasecmp(const struct unicode_map *um,
-			const struct qstr *s1, const struct qstr *s2);
-int unicode_strncasecmp_folded(const struct unicode_map *um,
-			       const struct qstr *cf,
-			       const struct qstr *s1);
+static struct unicode_map *unicode_load_static_call(const char *version)
+{
+	unicode_warn_on();
+	return NULL;
+}
 
-int unicode_normalize(const struct unicode_map *um, const struct qstr *str,
-		      unsigned char *dest, size_t dlen);
+static void unicode_unload_static_call(struct unicode_map *um)
+{
+	unicode_warn_on();
+}
 
-int unicode_casefold(const struct unicode_map *um, const struct qstr *str,
-		     unsigned char *dest, size_t dlen);
+DECLARE_STATIC_CALL(validate, unicode_validate_static_call);
+DECLARE_STATIC_CALL(strncmp, unicode_strncmp_static_call);
+DECLARE_STATIC_CALL(strncasecmp, unicode_strncasecmp_static_call);
+DECLARE_STATIC_CALL(strncasecmp_folded, unicode_strncasecmp_folded_static_call);
+DECLARE_STATIC_CALL(normalize, unicode_normalize_static_call);
+DECLARE_STATIC_CALL(casefold, unicode_casefold_static_call);
+DECLARE_STATIC_CALL(casefold_hash, unicode_casefold_hash_static_call);
+DECLARE_STATIC_CALL(load, unicode_load_static_call);
+DECLARE_STATIC_CALL(unload, unicode_unload_static_call);
 
-int unicode_casefold_hash(const struct unicode_map *um, const void *salt,
-			  struct qstr *str);
+static inline int unicode_validate(const struct unicode_map *um, const struct qstr *str)
+{
+	return static_call(validate)(um, str);
+}
+
+static inline int unicode_strncmp(const struct unicode_map *um,
+				  const struct qstr *s1, const struct qstr *s2)
+{
+	return static_call(strncmp)(um, s1, s2);
+}
+
+static inline int unicode_strncasecmp(const struct unicode_map *um,
+				      const struct qstr *s1, const struct qstr *s2)
+{
+	return static_call(strncasecmp)(um, s1, s2);
+}
+
+static inline int unicode_strncasecmp_folded(const struct unicode_map *um,
+					     const struct qstr *cf,
+					     const struct qstr *s1)
+{
+	return static_call(strncasecmp_folded)(um, cf, s1);
+}
+
+static inline int unicode_normalize(const struct unicode_map *um, const struct qstr *str,
+				    unsigned char *dest, size_t dlen)
+{
+	return static_call(normalize)(um, str, dest, dlen);
+}
+
+static inline int unicode_casefold(const struct unicode_map *um, const struct qstr *str,
+				   unsigned char *dest, size_t dlen)
+{
+	return static_call(casefold)(um, str, dest, dlen);
+}
+
+static inline int unicode_casefold_hash(const struct unicode_map *um, const void *salt,
+					struct qstr *str)
+{
+	return static_call(casefold_hash)(um, salt, str);
+}
 
 struct unicode_map *unicode_load(const char *version);
 void unicode_unload(struct unicode_map *um);
 
+void unicode_register(struct module *owner);
+void unicode_unregister(void);
+
 #endif /* _LINUX_UNICODE_H */
-- 
2.30.1

