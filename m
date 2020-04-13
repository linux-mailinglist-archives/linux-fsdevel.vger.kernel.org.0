Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACA21A6A8E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Apr 2020 18:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732092AbgDMQyF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Apr 2020 12:54:05 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60970 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732082AbgDMQyD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Apr 2020 12:54:03 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id E12392A02D3
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com, Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH v2] unicode: Expose available encodings in sysfs
Date:   Mon, 13 Apr 2020 12:53:52 -0400
Message-Id: <20200413165352.598877-1-krisman@collabora.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A filesystem configuration utility has no way to detect which filename
encodings are supported by the running kernel.  This means, for
instance, mkfs has no way to tell if the generated filesystem will be
mountable in the current kernel or not.  Also, users have no easy way to
know if they can update the encoding in their filesystems and still have
something functional in the end.

This exposes details of the encodings available in the unicode
subsystem, to fill that gap.

Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
Changes since v1:
  - Make init functions static. (lkp)

 Documentation/ABI/testing/sysfs-fs-unicode | 13 +++++
 fs/unicode/utf8-core.c                     | 64 ++++++++++++++++++++++
 fs/unicode/utf8-norm.c                     | 18 ++++++
 fs/unicode/utf8n.h                         |  5 ++
 4 files changed, 100 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-fs-unicode

diff --git a/Documentation/ABI/testing/sysfs-fs-unicode b/Documentation/ABI/testing/sysfs-fs-unicode
new file mode 100644
index 000000000000..15c63367bb8e
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-fs-unicode
@@ -0,0 +1,13 @@
+What:		/sys/fs/unicode/latest
+Date:		April 2020
+Contact:	Gabriel Krisman Bertazi <krisman@collabora.com>
+Description:
+		The latest version of the Unicode Standard supported by
+		this kernel
+
+What:		/sys/fs/unicode/encodings
+Date:		April 2020
+Contact:	Gabriel Krisman Bertazi <krisman@collabora.com>
+Description:
+		List of encodings and corresponding versions supported
+		by this kernel
diff --git a/fs/unicode/utf8-core.c b/fs/unicode/utf8-core.c
index 2a878b739115..b48e13e823a5 100644
--- a/fs/unicode/utf8-core.c
+++ b/fs/unicode/utf8-core.c
@@ -6,6 +6,7 @@
 #include <linux/parser.h>
 #include <linux/errno.h>
 #include <linux/unicode.h>
+#include <linux/fs.h>
 
 #include "utf8n.h"
 
@@ -212,4 +213,67 @@ void utf8_unload(struct unicode_map *um)
 }
 EXPORT_SYMBOL(utf8_unload);
 
+static ssize_t latest_show(struct kobject *kobj,
+			   struct kobj_attribute *attr, char *buf)
+{
+	int l = utf8version_latest();
+
+	return snprintf(buf, PAGE_SIZE, "UTF-8 %d.%d.%d\n", UNICODE_AGE_MAJ(l),
+			UNICODE_AGE_MIN(l), UNICODE_AGE_REV(l));
+
+}
+static ssize_t encodings_show(struct kobject *kobj,
+			      struct kobj_attribute *attr, char *buf)
+{
+	int n;
+
+	n = snprintf(buf, PAGE_SIZE, "UTF-8:");
+	n += utf8version_list(buf + n, PAGE_SIZE - n);
+	n += snprintf(buf+n, PAGE_SIZE-n, "\n");
+
+	return n;
+}
+
+#define UCD_ATTR(x) \
+	static struct kobj_attribute x ## _attr = __ATTR_RO(x)
+
+UCD_ATTR(latest);
+UCD_ATTR(encodings);
+
+static struct attribute *ucd_attrs[] = {
+	&latest_attr.attr,
+	&encodings_attr.attr,
+	NULL,
+};
+static const struct attribute_group ucd_attr_group = {
+	.attrs = ucd_attrs,
+};
+static struct kobject *ucd_root;
+
+static int __init ucd_init(void)
+{
+	int ret;
+
+	ucd_root = kobject_create_and_add("unicode", fs_kobj);
+	if (!ucd_root)
+		return -ENOMEM;
+
+	ret = sysfs_create_group(ucd_root, &ucd_attr_group);
+	if (ret) {
+		kobject_put(ucd_root);
+		ucd_root = NULL;
+		return ret;
+	}
+
+	return 0;
+}
+
+static void __exit ucd_exit(void)
+{
+	kobject_put(ucd_root);
+}
+
+module_init(ucd_init);
+module_exit(ucd_exit)
+
 MODULE_LICENSE("GPL v2");
diff --git a/fs/unicode/utf8-norm.c b/fs/unicode/utf8-norm.c
index 1d2d2e5b906a..f9ebba89a138 100644
--- a/fs/unicode/utf8-norm.c
+++ b/fs/unicode/utf8-norm.c
@@ -35,6 +35,24 @@ int utf8version_latest(void)
 }
 EXPORT_SYMBOL(utf8version_latest);
 
+int utf8version_list(char *buf, int len)
+{
+	int i = ARRAY_SIZE(utf8agetab) - 1;
+	int ret = 0;
+
+	/*
+	 * Print most relevant (latest) first.  No filesystem uses
+	 * unicode <= 12.0.0, so don't expose them to userspace.
+	 */
+	for (; utf8agetab[i] >= UNICODE_AGE(12, 0, 0); i--) {
+		ret += snprintf(buf+ret, len-ret, " %d.%d.%d",
+				UNICODE_AGE_MAJ(utf8agetab[i]),
+				UNICODE_AGE_MIN(utf8agetab[i]),
+				UNICODE_AGE_REV(utf8agetab[i]));
+	}
+	return ret;
+}
+
 /*
  * UTF-8 valid ranges.
  *
diff --git a/fs/unicode/utf8n.h b/fs/unicode/utf8n.h
index 0acd530c2c79..5dea2c4af1f3 100644
--- a/fs/unicode/utf8n.h
+++ b/fs/unicode/utf8n.h
@@ -21,9 +21,14 @@
 	 ((unsigned int)(MIN) << UNICODE_MIN_SHIFT) |	\
 	 ((unsigned int)(REV)))
 
+#define UNICODE_AGE_MAJ(x) ((x) >> UNICODE_MAJ_SHIFT & 0xff)
+#define UNICODE_AGE_MIN(x) ((x) >> UNICODE_MIN_SHIFT & 0xff)
+#define UNICODE_AGE_REV(x) ((x) & 0xff)
+
 /* Highest unicode version supported by the data tables. */
 extern int utf8version_is_supported(u8 maj, u8 min, u8 rev);
 extern int utf8version_latest(void);
+extern int utf8version_list(char *buf, int len);
 
 /*
  * Look for the correct const struct utf8data for a unicode version.
-- 
2.26.0

