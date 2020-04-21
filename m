Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3CB41B317B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Apr 2020 22:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgDUUxt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Apr 2020 16:53:49 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38066 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbgDUUxt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Apr 2020 16:53:49 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id C95702A05E0
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     linux-ext4@vger.kernel.org
Cc:     ezequiel@collabora.com, linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com, Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH v3] unicode: Expose available encodings in sysfs
Date:   Tue, 21 Apr 2020 16:53:35 -0400
Message-Id: <20200421205335.2344628-1-krisman@collabora.com>
X-Mailer: git-send-email 2.26.1
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
subsystem to fill that gap.

Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Changes since v2:
  - Change sysfs topology (Ezequiel)
  - Add end period (Ezequiel)
  - change module_init to fs_initcall (Ezequiel)
Changes since v1:
  - Make init functions static. (lkp)
---
 Documentation/ABI/testing/sysfs-fs-unicode |  6 +++
 fs/unicode/utf8-core.c                     | 55 ++++++++++++++++++++++
 fs/unicode/utf8n.h                         |  4 ++
 3 files changed, 65 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-fs-unicode

diff --git a/Documentation/ABI/testing/sysfs-fs-unicode b/Documentation/ABI/testing/sysfs-fs-unicode
new file mode 100644
index 000000000000..b56e0dda6550
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-fs-unicode
@@ -0,0 +1,6 @@
+What:		/sys/fs/unicode/<encoding>/latest_version
+Date:		April 2020
+Contact:	Gabriel Krisman Bertazi <krisman@collabora.com>
+Description:
+		The latest version of the Unicode Standard supported by
+		this encoding in this kernel.
diff --git a/fs/unicode/utf8-core.c b/fs/unicode/utf8-core.c
index 2a878b739115..a075d024d783 100644
--- a/fs/unicode/utf8-core.c
+++ b/fs/unicode/utf8-core.c
@@ -6,6 +6,7 @@
 #include <linux/parser.h>
 #include <linux/errno.h>
 #include <linux/unicode.h>
+#include <linux/fs.h>
 
 #include "utf8n.h"
 
@@ -212,4 +213,58 @@ void utf8_unload(struct unicode_map *um)
 }
 EXPORT_SYMBOL(utf8_unload);
 
+static ssize_t latest_version_show(struct kobject *kobj,
+				   struct kobj_attribute *attr, char *buf)
+{
+	int l = utf8version_latest();
+
+	return snprintf(buf, PAGE_SIZE, "%d.%d.%d\n",
+			UNICODE_AGE_MAJ(l), UNICODE_AGE_MIN(l),
+			UNICODE_AGE_REV(l));
+}
+
+#define UNICODE_ATTR(x)						\
+	static struct kobj_attribute x ## _attr = __ATTR_RO(x)
+
+UNICODE_ATTR(latest_version);
+
+static struct attribute *encoding_attrs[] = {
+	&latest_version_attr.attr,
+	NULL,
+};
+static const struct attribute_group encoding_attr_group = {
+	.attrs = encoding_attrs,
+};
+
+static struct kobject *unicode_kobj;
+static struct kobject *utf8_kobj;
+
+static int __init unicode_init(void)
+{
+	int ret = 0;
+
+	unicode_kobj = kobject_create_and_add("unicode", fs_kobj);
+	if (!unicode_kobj)
+		return -ENOMEM;
+
+	utf8_kobj = kobject_create_and_add("utf-8", unicode_kobj);
+	if (!utf8_kobj) {
+		ret = -ENOMEM;
+		goto fail_unicode;
+	}
+
+	ret = sysfs_create_group(utf8_kobj, &encoding_attr_group);
+	if (ret)
+		goto fail_utf8;
+
+	return 0;
+
+fail_utf8:
+	kobject_put(utf8_kobj);
+fail_unicode:
+	kobject_put(unicode_kobj);
+	return ret;
+}
+fs_initcall(unicode_init);
+
 MODULE_LICENSE("GPL v2");
diff --git a/fs/unicode/utf8n.h b/fs/unicode/utf8n.h
index 0acd530c2c79..a14fa1e2f4c8 100644
--- a/fs/unicode/utf8n.h
+++ b/fs/unicode/utf8n.h
@@ -21,6 +21,10 @@
 	 ((unsigned int)(MIN) << UNICODE_MIN_SHIFT) |	\
 	 ((unsigned int)(REV)))
 
+#define UNICODE_AGE_MAJ(x) ((x) >> UNICODE_MAJ_SHIFT & 0xff)
+#define UNICODE_AGE_MIN(x) ((x) >> UNICODE_MIN_SHIFT & 0xff)
+#define UNICODE_AGE_REV(x) ((x) & 0xff)
+
 /* Highest unicode version supported by the data tables. */
 extern int utf8version_is_supported(u8 maj, u8 min, u8 rev);
 extern int utf8version_latest(void);
-- 
2.26.1

