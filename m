Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB1327CA6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2019 14:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730284AbfEWMVz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 May 2019 08:21:55 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:32963 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728309AbfEWMVz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 May 2019 08:21:55 -0400
Received: from lhreml705-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 1393C3ED738B108B2461;
        Thu, 23 May 2019 13:21:51 +0100 (IST)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.154)
 by smtpsuk.huawei.com (10.201.108.46) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Thu, 23 May 2019 13:21:43 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <viro@zeniv.linux.org.uk>
CC:     <linux-security-module@vger.kernel.org>,
        <linux-integrity@vger.kernel.org>, <initramfs@vger.kernel.org>,
        <linux-api@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bug-cpio@gnu.org>,
        <zohar@linux.vnet.ibm.com>, <silviu.vlasceanu@huawei.com>,
        <dmitry.kasatkin@huawei.com>, <takondra@cisco.com>,
        <kamensky@cisco.com>, <hpa@zytor.com>, <arnd@arndb.de>,
        <rob@landley.net>, <james.w.mcmechan@gmail.com>,
        <niveditas98@gmail.com>, Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v4 1/3] initramfs: add file metadata
Date:   Thu, 23 May 2019 14:18:01 +0200
Message-ID: <20190523121803.21638-2-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190523121803.21638-1-roberto.sassu@huawei.com>
References: <20190523121803.21638-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.204.65.154]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Mimi Zohar <zohar@linux.vnet.ibm.com>

This patch adds metadata to a file from a supplied buffer. The buffer might
contains multiple metadata records. The format of each record is:

<metadata len (ASCII, 8 chars)><version><type><metadata>

For now, only the TYPE_XATTR metadata type is supported. The specific
format of this metadata type is:

<xattr #N name>\0<xattr #N value>

[kamensky: fixed restoring of xattrs for symbolic links by using
           sys_lsetxattr() instead of sys_setxattr()]

[sassu: removed state management, kept only do_setxattrs(), added support
        for generic file metadata, replaced sys_lsetxattr() with
        vfs_setxattr(), added check for entry_size, added check for
        hdr->c_size, replaced strlen() with strnlen(); moved do_setxattrs()
        before do_name()]

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Signed-off-by: Victor Kamensky <kamensky@cisco.com>
Signed-off-by: Taras Kondratiuk <takondra@cisco.com>
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 include/linux/initramfs.h | 21 ++++++++++
 init/initramfs.c          | 88 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 107 insertions(+), 2 deletions(-)
 create mode 100644 include/linux/initramfs.h

diff --git a/include/linux/initramfs.h b/include/linux/initramfs.h
new file mode 100644
index 000000000000..2f8cee441236
--- /dev/null
+++ b/include/linux/initramfs.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * include/linux/initramfs.h
+ *
+ * Include file for file metadata in the initial ram disk.
+ */
+#ifndef _LINUX_INITRAMFS_H
+#define _LINUX_INITRAMFS_H
+
+#define METADATA_FILENAME "METADATA!!!"
+
+enum metadata_types { TYPE_NONE, TYPE_XATTR, TYPE__LAST };
+
+struct metadata_hdr {
+	char c_size[8];     /* total size including c_size field */
+	char c_version;     /* header version */
+	char c_type;        /* metadata type */
+	char c_metadata[];  /* metadata */
+} __packed;
+
+#endif /*LINUX_INITRAMFS_H*/
diff --git a/init/initramfs.c b/init/initramfs.c
index 178130fd61c2..5de396a6aac0 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -10,6 +10,9 @@
 #include <linux/syscalls.h>
 #include <linux/utime.h>
 #include <linux/file.h>
+#include <linux/namei.h>
+#include <linux/xattr.h>
+#include <linux/initramfs.h>
 
 static ssize_t __init xwrite(int fd, const char *p, size_t count)
 {
@@ -146,7 +149,7 @@ static __initdata time64_t mtime;
 
 static __initdata unsigned long ino, major, minor, nlink;
 static __initdata umode_t mode;
-static __initdata unsigned long body_len, name_len;
+static __initdata unsigned long body_len, name_len, metadata_len;
 static __initdata uid_t uid;
 static __initdata gid_t gid;
 static __initdata unsigned rdev;
@@ -218,7 +221,7 @@ static void __init read_into(char *buf, unsigned size, enum state next)
 	}
 }
 
-static __initdata char *header_buf, *symlink_buf, *name_buf;
+static __initdata char *header_buf, *symlink_buf, *name_buf, *metadata_buf;
 
 static int __init do_start(void)
 {
@@ -315,6 +318,87 @@ static int __init maybe_link(void)
 	return 0;
 }
 
+static int __init do_setxattrs(char *pathname, char *buf, size_t size)
+{
+	struct path path;
+	char *xattr_name, *xattr_value;
+	size_t xattr_name_size, xattr_value_size;
+	int ret;
+
+	xattr_name = buf;
+	xattr_name_size = strnlen(xattr_name, size);
+	if (xattr_name_size == size) {
+		error("malformed xattrs");
+		return -EINVAL;
+	}
+
+	xattr_value = xattr_name + xattr_name_size + 1;
+	xattr_value_size = buf + size - xattr_value;
+
+	ret = kern_path(pathname, 0, &path);
+	if (!ret) {
+		ret = vfs_setxattr(path.dentry, xattr_name, xattr_value,
+				   xattr_value_size, 0);
+
+		path_put(&path);
+	}
+
+	pr_debug("%s: %s size: %lu val: %s (ret: %d)\n", pathname,
+		 xattr_name, xattr_value_size, xattr_value, ret);
+
+	return ret;
+}
+
+static int __init __maybe_unused do_parse_metadata(char *pathname)
+{
+	char *buf = metadata_buf;
+	char *bufend = metadata_buf + metadata_len;
+	struct metadata_hdr *hdr;
+	char str[sizeof(hdr->c_size) + 1];
+	size_t entry_size;
+
+	if (!metadata_len)
+		return 0;
+
+	str[sizeof(hdr->c_size)] = 0;
+
+	while (buf < bufend) {
+		int ret;
+
+		if (buf + sizeof(*hdr) > bufend) {
+			error("malformed metadata");
+			break;
+		}
+
+		hdr = (struct metadata_hdr *)buf;
+		if (hdr->c_version != 1) {
+			pr_debug("Unsupported header version\n");
+			break;
+		}
+
+		memcpy(str, hdr->c_size, sizeof(hdr->c_size));
+		ret = kstrtoul(str, 16, &entry_size);
+		if (ret || buf + entry_size > bufend || !entry_size) {
+			error("malformed xattrs");
+			break;
+		}
+
+		switch (hdr->c_type) {
+		case TYPE_XATTR:
+			do_setxattrs(pathname, buf + sizeof(*hdr),
+				     entry_size - sizeof(*hdr));
+			break;
+		default:
+			pr_debug("Unsupported metadata type\n");
+			break;
+		}
+
+		buf += entry_size;
+	}
+
+	return 0;
+}
+
 static __initdata int wfd;
 
 static int __init do_name(void)
-- 
2.17.1

