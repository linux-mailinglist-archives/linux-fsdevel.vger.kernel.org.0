Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACE9356F3F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Apr 2021 16:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353155AbhDGOuX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Apr 2021 10:50:23 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60900 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348841AbhDGOtu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Apr 2021 10:49:50 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: shreeya)
        with ESMTPSA id BF8D31F4509C
From:   Shreeya Patel <shreeya.patel@collabora.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        chao@kernel.org, krisman@collabora.com, ebiggers@google.com,
        drosen@google.com, ebiggers@kernel.org, yuchao0@huawei.com
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, kernel@collabora.com,
        andre.almeida@collabora.com
Subject: [PATCH v7 4/4] fs: unicode: Add utf8 module and a unicode layer
Date:   Wed,  7 Apr 2021 20:18:45 +0530
Message-Id: <20210407144845.53266-5-shreeya.patel@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210407144845.53266-1-shreeya.patel@collabora.com>
References: <20210407144845.53266-1-shreeya.patel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

utf8data.h_shipped has a large database table which is an auto-generated
decodification trie for the unicode normalization functions.
It is not necessary to load this large table in the kernel if no
filesystem is using it, hence make UTF-8 encoding loadable by converting
it into a module.

Modify the file called unicode-core which will act as a layer for
unicode subsystem. It will load the UTF-8 module and access it's functions
whenever any filesystem that needs unicode is mounted.
Currently, only UTF-8 encoding is supported but if any other encodings
are supported in future then the layer file would be responsible for
loading the desired encoding module.

Also, indirect calls using function pointers are slow, use static calls to
avoid overhead caused in case of repeated indirect calls. Static calls
improves the performance by directly calling the functions as opposed to
indirect calls.

Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
---
Changes in v7
  - Update the help text in Kconfig
  - Handle the unicode_load_static_call function failure by decrementing
    the reference.
  - Correct the code for handling built-in utf8 option as well.
  - Correct the synchronization for accessing utf8mod.
  - Make changes to unicode_unload() for handling the situation where
    utf8mod != NULL and um == NULL.

Changes in v6
  - Add spinlock to protect utf8mod and avoid NULL pointer
    dereference.
  - Change the static call function names for being consistent with
    kernel coding style.
  - Merge the unicode_load_module function with unicode_load as it is
    not really needed to have a separate function.
  - Use try_then_module_get instead of module_get to avoid loading the
    module even when it is already loaded.
  - Improve the commit message.

Changes in v5
  - Rename global variables and default static call functions for better
    understanding
  - Make only config UNICODE_UTF8 visible and config UNICODE to be always
    enabled provided UNICODE_UTF8 is enabled.  
  - Improve the documentation for Kconfig
  - Improve the commit message.
 
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
  - Add a patch which checks if utf8 is loaded before calling utf8_unload()
    in ext4 and f2fs filesystems
  - Return error if strscpy() returns value < 0
  - Correct the conditions to prevent NULL pointer dereference while
    accessing functions via utf8_ops variable.
  - Add spinlock to avoid race conditions.
  - Use static_call() for preventing speculative execution attacks.

Changes in v2
  - Remove the duplicate file from the last patch.
  - Make the wrapper functions inline.
  - Remove msleep and use try_module_get() and module_put()
    for ensuring that module is loaded correctly and also
    doesn't get unloaded while in use.
  - Resolve the warning reported by kernel test robot.
  - Resolve all the checkpatch.pl warnings.

 fs/unicode/Kconfig        |  26 +++-
 fs/unicode/Makefile       |   5 +-
 fs/unicode/unicode-core.c | 297 ++++++++++++++------------------------
 fs/unicode/unicode-utf8.c | 264 +++++++++++++++++++++++++++++++++
 include/linux/unicode.h   |  96 ++++++++++--
 5 files changed, 483 insertions(+), 205 deletions(-)
 create mode 100644 fs/unicode/unicode-utf8.c

diff --git a/fs/unicode/Kconfig b/fs/unicode/Kconfig
index 2c27b9a5cd6c..0c69800a2a37 100644
--- a/fs/unicode/Kconfig
+++ b/fs/unicode/Kconfig
@@ -2,13 +2,31 @@
 #
 # UTF-8 normalization
 #
+# CONFIG_UNICODE will be automatically enabled if CONFIG_UNICODE_UTF8
+# is enabled. This config option adds the unicode subsystem layer which loads
+# the UTF-8 module whenever any filesystem needs it.
 config UNICODE
-	bool "UTF-8 normalization and casefolding support"
+	bool
+
+config UNICODE_UTF8
+	tristate "UTF-8 module"
+	select UNICODE
 	help
-	  Say Y here to enable UTF-8 NFD normalization and NFD+CF casefolding
-	  support.
+	  Say M here to enable UTF-8 NFD normalization and NFD+CF casefolding
+	  support as a loadable module or say Y for building it into the kernel.
+
+	  utf8data.h_shipped has a large database table which is an
+	  auto-generated decodification trie for the unicode normalization
+	  functions and it is not necessary to carry this large table in the
+	  kernel. Hence, enabling UNICODE_UTF8 as M will allow you to avoid
+	  carrying this large table into the kernel and module will only be
+	  loaded whenever required by any filesystem.
+	  Please note, in this case utf8 module will only be available after
+	  booting into the compiled kernel. If your filesystem requires it to
+	  have utf8 during boot time then you should have it built into the
+	  kernel by saying Y here to avoid boot failure.
 
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
index 730dbaedf593..d9e9e410893d 100644
--- a/fs/unicode/unicode-core.c
+++ b/fs/unicode/unicode-core.c
@@ -1,228 +1,132 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #include <linux/module.h>
 #include <linux/kernel.h>
-#include <linux/string.h>
 #include <linux/slab.h>
-#include <linux/parser.h>
 #include <linux/errno.h>
 #include <linux/unicode.h>
-#include <linux/stringhash.h>
+#include <linux/spinlock.h>
 
-#include "utf8n.h"
+DEFINE_SPINLOCK(utf8mod_lock);
 
-int unicode_validate(const struct unicode_map *um, const struct qstr *str)
-{
-	const struct utf8data *data = utf8nfdi(um->version);
+static struct module *utf8mod;
+static bool utf8mod_loaded;
 
-	if (utf8nlen(data, str->name, str->len) < 0)
-		return -1;
-	return 0;
+int unicode_validate_default(const struct unicode_map *um,
+			     const struct qstr *str)
+{
+	WARN_ON(1);
+	return -EIO;
 }
-EXPORT_SYMBOL(unicode_validate);
+EXPORT_SYMBOL(unicode_validate_default);
 
-int unicode_strncmp(const struct unicode_map *um,
-		    const struct qstr *s1, const struct qstr *s2)
+int unicode_strncmp_default(const struct unicode_map *um,
+			    const struct qstr *s1,
+			    const struct qstr *s2)
 {
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
+	WARN_ON(1);
+	return -EIO;
 }
-EXPORT_SYMBOL(unicode_strncmp);
+EXPORT_SYMBOL(unicode_strncmp_default);
 
-int unicode_strncasecmp(const struct unicode_map *um,
-			const struct qstr *s1, const struct qstr *s2)
+int unicode_strncasecmp_default(const struct unicode_map *um,
+				const struct qstr *s1,
+				const struct qstr *s2)
 {
-	const struct utf8data *data = utf8nfdicf(um->version);
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
+	WARN_ON(1);
+	return -EIO;
 }
-EXPORT_SYMBOL(unicode_strncasecmp);
-
-/* String cf is expected to be a valid UTF-8 casefolded
- * string.
- */
-int unicode_strncasecmp_folded(const struct unicode_map *um,
-			       const struct qstr *cf,
-			       const struct qstr *s1)
+EXPORT_SYMBOL(unicode_strncasecmp_default);
+
+int unicode_strncasecmp_folded_default(const struct unicode_map *um,
+				       const struct qstr *cf,
+				       const struct qstr *s1)
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
+	WARN_ON(1);
+	return -EIO;
 }
-EXPORT_SYMBOL(unicode_strncasecmp_folded);
+EXPORT_SYMBOL(unicode_strncasecmp_folded_default);
 
-int unicode_casefold(const struct unicode_map *um, const struct qstr *str,
-		     unsigned char *dest, size_t dlen)
+int unicode_normalize_default(const struct unicode_map *um,
+			      const struct qstr *str,
+			      unsigned char *dest, size_t dlen)
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
+	WARN_ON(1);
+	return -EIO;
+}
+EXPORT_SYMBOL(unicode_normalize_default);
 
-		dest[nlen] = c;
-		if (!c)
-			return nlen;
-		if (c == -1)
-			break;
-	}
-	return -EINVAL;
+int unicode_casefold_default(const struct unicode_map *um,
+			     const struct qstr *str,
+			     unsigned char *dest, size_t dlen)
+{
+	WARN_ON(1);
+	return -EIO;
 }
-EXPORT_SYMBOL(unicode_casefold);
+EXPORT_SYMBOL(unicode_casefold_default);
 
-int unicode_casefold_hash(const struct unicode_map *um, const void *salt,
-			  struct qstr *str)
+int unicode_casefold_hash_default(const struct unicode_map *um,
+				  const void *salt, struct qstr *str)
 {
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
-	}
-	str->hash = end_name_hash(hash);
-	return 0;
+	WARN_ON(1);
+	return -EIO;
 }
-EXPORT_SYMBOL(unicode_casefold_hash);
+EXPORT_SYMBOL(unicode_casefold_hash_default);
 
-int unicode_normalize(const struct unicode_map *um, const struct qstr *str,
-		      unsigned char *dest, size_t dlen)
+struct unicode_map *unicode_load_default(const char *version)
 {
-	const struct utf8data *data = utf8nfdi(um->version);
-	struct utf8cursor cur;
-	ssize_t nlen = 0;
+	WARN_ON(1);
+	return ERR_PTR(-EIO);
+}
+EXPORT_SYMBOL(unicode_load_default);
 
-	if (utf8ncursor(&cur, data, str->name, str->len) < 0)
-		return -EINVAL;
+DEFINE_STATIC_CALL(unicode_validate_static_call, unicode_validate_default);
+EXPORT_STATIC_CALL(unicode_validate_static_call);
 
-	for (nlen = 0; nlen < dlen; nlen++) {
-		int c = utf8byte(&cur);
+DEFINE_STATIC_CALL(unicode_strncmp_static_call, unicode_strncmp_default);
+EXPORT_STATIC_CALL(unicode_strncmp_static_call);
 
-		dest[nlen] = c;
-		if (!c)
-			return nlen;
-		if (c == -1)
-			break;
-	}
-	return -EINVAL;
-}
-EXPORT_SYMBOL(unicode_normalize);
+DEFINE_STATIC_CALL(unicode_strncasecmp_static_call,
+		   unicode_strncasecmp_default);
+EXPORT_STATIC_CALL(unicode_strncasecmp_static_call);
 
-static int unicode_parse_version(const char *version, unsigned int *maj,
-				 unsigned int *min, unsigned int *rev)
-{
-	substring_t args[3];
-	char version_string[12];
-	static const struct match_token token[] = {
-		{1, "%d.%d.%d"},
-		{0, NULL}
-	};
-	int ret = strscpy(version_string, version, sizeof(version_string));
+DEFINE_STATIC_CALL(unicode_strncasecmp_folded_static_call,
+		   unicode_strncasecmp_folded_default);
+EXPORT_STATIC_CALL(unicode_strncasecmp_folded_static_call);
 
-	if (ret < 0)
-		return ret;
+DEFINE_STATIC_CALL(unicode_normalize_static_call, unicode_normalize_default);
+EXPORT_STATIC_CALL(unicode_normalize_static_call);
 
-	if (match_token(version_string, token, args) != 1)
-		return -EINVAL;
+DEFINE_STATIC_CALL(unicode_casefold_static_call, unicode_casefold_default);
+EXPORT_STATIC_CALL(unicode_casefold_static_call);
 
-	if (match_int(&args[0], maj) || match_int(&args[1], min) ||
-	    match_int(&args[2], rev))
-		return -EINVAL;
+DEFINE_STATIC_CALL(unicode_casefold_hash_static_call,
+		   unicode_casefold_hash_default);
+EXPORT_STATIC_CALL(unicode_casefold_hash_static_call);
 
-	return 0;
+DEFINE_STATIC_CALL(unicode_load_static_call, unicode_load_default);
+EXPORT_STATIC_CALL(unicode_load_static_call);
+
+static bool utf8mod_get(void)
+{
+	bool ret;
+
+	spin_lock(&utf8mod_lock);
+	ret = utf8mod_loaded && try_module_get(utf8mod);
+	spin_unlock(&utf8mod_lock);
+	return ret;
 }
 
 struct unicode_map *unicode_load(const char *version)
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
+	struct unicode_map *um;
 
-	um = kzalloc(sizeof(struct unicode_map), GFP_KERNEL);
-	if (!um)
-		return ERR_PTR(-ENOMEM);
-
-	um->charset = "UTF-8";
-	um->version = unicode_version;
+	if (!try_then_request_module(utf8mod_get(), "utf8")) {
+		pr_err("Failed to load UTF-8 module\n");
+		return ERR_PTR(-ENODEV);
+	}
+	um = static_call(unicode_load_static_call)(version);
+	if (IS_ERR(um))
+		module_put(utf8mod);
 
 	return um;
 }
@@ -230,8 +134,29 @@ EXPORT_SYMBOL(unicode_load);
 
 void unicode_unload(struct unicode_map *um)
 {
-	kfree(um);
+	if (um) {
+		kfree(um);
+		module_put(utf8mod);
+	}
 }
 EXPORT_SYMBOL(unicode_unload);
 
+void unicode_register(struct module *owner)
+{
+	spin_lock(&utf8mod_lock);
+	utf8mod = owner;
+	utf8mod_loaded = true;
+	spin_unlock(&utf8mod_lock);
+}
+EXPORT_SYMBOL(unicode_register);
+
+void unicode_unregister(void)
+{
+	spin_lock(&utf8mod_lock);
+	utf8mod = NULL;
+	utf8mod_loaded = false;
+	spin_unlock(&utf8mod_lock);
+}
+EXPORT_SYMBOL(unicode_unregister);
+
 MODULE_LICENSE("GPL v2");
diff --git a/fs/unicode/unicode-utf8.c b/fs/unicode/unicode-utf8.c
new file mode 100644
index 000000000000..e0180f1c5ea8
--- /dev/null
+++ b/fs/unicode/unicode-utf8.c
@@ -0,0 +1,264 @@
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
+static int __init utf8_init(void)
+{
+	static_call_update(unicode_validate_static_call, utf8_validate);
+	static_call_update(unicode_strncmp_static_call, utf8_strncmp);
+	static_call_update(unicode_strncasecmp_static_call, utf8_strncasecmp);
+	static_call_update(unicode_strncasecmp_folded_static_call,
+			   utf8_strncasecmp_folded);
+	static_call_update(unicode_normalize_static_call, utf8_normalize);
+	static_call_update(unicode_casefold_static_call, utf8_casefold);
+	static_call_update(unicode_casefold_hash_static_call,
+			   utf8_casefold_hash);
+	static_call_update(unicode_load_static_call, utf8_load);
+
+	unicode_register(THIS_MODULE);
+	return 0;
+}
+
+static void __exit utf8_exit(void)
+{
+	static_call_update(unicode_validate_static_call,
+			   unicode_validate_default);
+	static_call_update(unicode_strncmp_static_call, unicode_strncmp_default);
+	static_call_update(unicode_strncasecmp_static_call,
+			   unicode_strncasecmp_default);
+	static_call_update(unicode_strncasecmp_folded_static_call,
+			   unicode_strncasecmp_folded_default);
+	static_call_update(unicode_normalize_static_call,
+			   unicode_normalize_default);
+	static_call_update(unicode_casefold_static_call,
+			   unicode_casefold_default);
+	static_call_update(unicode_casefold_hash_static_call,
+			   unicode_casefold_hash_default);
+	static_call_update(unicode_load_static_call, unicode_load_default);
+
+	unicode_unregister();
+}
+
+module_init(utf8_init);
+module_exit(utf8_exit);
+
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/unicode.h b/include/linux/unicode.h
index de23f9ee720b..0b157c6830c6 100644
--- a/include/linux/unicode.h
+++ b/include/linux/unicode.h
@@ -4,33 +4,101 @@
 
 #include <linux/init.h>
 #include <linux/dcache.h>
+#include <linux/static_call.h>
+
 
 struct unicode_map {
 	const char *charset;
 	int version;
 };
 
-int unicode_validate(const struct unicode_map *um, const struct qstr *str);
+int unicode_validate_default(const struct unicode_map *um,
+			     const struct qstr *str);
+
+int unicode_strncmp_default(const struct unicode_map *um,
+			    const struct qstr *s1,
+			    const struct qstr *s2);
+
+int unicode_strncasecmp_default(const struct unicode_map *um,
+				const struct qstr *s1,
+				const struct qstr *s2);
+
+int unicode_strncasecmp_folded_default(const struct unicode_map *um,
+				       const struct qstr *cf,
+				       const struct qstr *s1);
+
+int unicode_normalize_default(const struct unicode_map *um,
+			      const struct qstr *str,
+			      unsigned char *dest, size_t dlen);
+
+int unicode_casefold_default(const struct unicode_map *um,
+			     const struct qstr *str,
+			     unsigned char *dest, size_t dlen);
+
+int unicode_casefold_hash_default(const struct unicode_map *um,
+				  const void *salt, struct qstr *str);
 
-int unicode_strncmp(const struct unicode_map *um,
-		    const struct qstr *s1, const struct qstr *s2);
+struct unicode_map *unicode_load_default(const char *version);
 
-int unicode_strncasecmp(const struct unicode_map *um,
-			const struct qstr *s1, const struct qstr *s2);
-int unicode_strncasecmp_folded(const struct unicode_map *um,
-			       const struct qstr *cf,
-			       const struct qstr *s1);
+DECLARE_STATIC_CALL(unicode_validate_static_call, unicode_validate_default);
+DECLARE_STATIC_CALL(unicode_strncmp_static_call, unicode_strncmp_default);
+DECLARE_STATIC_CALL(unicode_strncasecmp_static_call,
+		    unicode_strncasecmp_default);
+DECLARE_STATIC_CALL(unicode_strncasecmp_folded_static_call,
+		    unicode_strncasecmp_folded_default);
+DECLARE_STATIC_CALL(unicode_normalize_static_call, unicode_normalize_default);
+DECLARE_STATIC_CALL(unicode_casefold_static_call, unicode_casefold_default);
+DECLARE_STATIC_CALL(unicode_casefold_hash_static_call,
+		    unicode_casefold_hash_default);
+DECLARE_STATIC_CALL(unicode_load_static_call, unicode_load_default);
 
-int unicode_normalize(const struct unicode_map *um, const struct qstr *str,
-		      unsigned char *dest, size_t dlen);
 
-int unicode_casefold(const struct unicode_map *um, const struct qstr *str,
-		     unsigned char *dest, size_t dlen);
+static inline int unicode_validate(const struct unicode_map *um, const struct qstr *str)
+{
+	return static_call(unicode_validate_static_call)(um, str);
+}
 
-int unicode_casefold_hash(const struct unicode_map *um, const void *salt,
-			  struct qstr *str);
+static inline int unicode_strncmp(const struct unicode_map *um,
+				  const struct qstr *s1, const struct qstr *s2)
+{
+	return static_call(unicode_strncmp_static_call)(um, s1, s2);
+}
+
+static inline int unicode_strncasecmp(const struct unicode_map *um,
+				      const struct qstr *s1, const struct qstr *s2)
+{
+	return static_call(unicode_strncasecmp_static_call)(um, s1, s2);
+}
+
+static inline int unicode_strncasecmp_folded(const struct unicode_map *um,
+					     const struct qstr *cf,
+					     const struct qstr *s1)
+{
+	return static_call(unicode_strncasecmp_folded_static_call)(um, cf, s1);
+}
+
+static inline int unicode_normalize(const struct unicode_map *um, const struct qstr *str,
+				    unsigned char *dest, size_t dlen)
+{
+	return static_call(unicode_normalize_static_call)(um, str, dest, dlen);
+}
+
+static inline int unicode_casefold(const struct unicode_map *um, const struct qstr *str,
+				   unsigned char *dest, size_t dlen)
+{
+	return static_call(unicode_casefold_static_call)(um, str, dest, dlen);
+}
+
+static inline int unicode_casefold_hash(const struct unicode_map *um, const void *salt,
+					struct qstr *str)
+{
+	return static_call(unicode_casefold_hash_static_call)(um, salt, str);
+}
 
 struct unicode_map *unicode_load(const char *version);
 void unicode_unload(struct unicode_map *um);
 
+void unicode_register(struct module *owner);
+void unicode_unregister(void);
+
 #endif /* _LINUX_UNICODE_H */
-- 
2.30.2

