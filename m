Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46E0B21C1E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2019 18:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbfEQQ7i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 May 2019 12:59:38 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:32952 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726575AbfEQQ7i (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 May 2019 12:59:38 -0400
Received: from lhreml707-cah.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 603483F45E49C5D0A908;
        Fri, 17 May 2019 17:59:36 +0100 (IST)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.154)
 by smtpsuk.huawei.com (10.201.108.48) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Fri, 17 May 2019 17:59:25 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <viro@zeniv.linux.org.uk>
CC:     <linux-security-module@vger.kernel.org>,
        <linux-integrity@vger.kernel.org>, <initramfs@vger.kernel.org>,
        <linux-api@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <zohar@linux.vnet.ibm.com>,
        <silviu.vlasceanu@huawei.com>, <dmitry.kasatkin@huawei.com>,
        <takondra@cisco.com>, <kamensky@cisco.com>, <hpa@zytor.com>,
        <arnd@arndb.de>, <rob@landley.net>, <james.w.mcmechan@gmail.com>,
        <niveditas98@gmail.com>, Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v3 1/2] initramfs: set extended attributes
Date:   Fri, 17 May 2019 18:55:18 +0200
Message-ID: <20190517165519.11507-2-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190517165519.11507-1-roberto.sassu@huawei.com>
References: <20190517165519.11507-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.204.65.154]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Mimi Zohar <zohar@linux.vnet.ibm.com>

This patch adds xattrs to a file, with name and value taken from a supplied
buffer. The data format is:

<xattr #N data len (ASCII, 8 chars)><xattr #N name>\0<xattr #N value>

[kamensky: fixed restoring of xattrs for symbolic links by using
           sys_lsetxattr() instead of sys_setxattr()]

[sassu: removed state management, kept only do_setxattrs(), replaced
        sys_lsetxattr() with vfs_setxattr(), added check for
        xattr_entry_size, added check for hdr->c_size, replaced strlen()
        with strnlen(); moved do_setxattrs() before do_name()]

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Signed-off-by: Victor Kamensky <kamensky@cisco.com>
Signed-off-by: Taras Kondratiuk <takondra@cisco.com>
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 init/initramfs.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 69 insertions(+), 2 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 435a428c2af1..0c6dd1d5d3f6 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -10,6 +10,8 @@
 #include <linux/syscalls.h>
 #include <linux/utime.h>
 #include <linux/file.h>
+#include <linux/namei.h>
+#include <linux/xattr.h>
 
 static ssize_t __init xwrite(int fd, const char *p, size_t count)
 {
@@ -146,7 +148,8 @@ static __initdata time64_t mtime;
 
 static __initdata unsigned long ino, major, minor, nlink;
 static __initdata umode_t mode;
-static __initdata unsigned long body_len, name_len;
+static __initdata u32 name_len, xattr_len;
+static __initdata u64 body_len;
 static __initdata uid_t uid;
 static __initdata gid_t gid;
 static __initdata unsigned rdev;
@@ -218,7 +221,7 @@ static void __init read_into(char *buf, unsigned size, enum state next)
 	}
 }
 
-static __initdata char *header_buf, *symlink_buf, *name_buf;
+static __initdata char *header_buf, *symlink_buf, *name_buf, *xattr_buf;
 
 static int __init do_start(void)
 {
@@ -315,6 +318,70 @@ static int __init maybe_link(void)
 	return 0;
 }
 
+struct xattr_hdr {
+	char c_size[8]; /* total size including c_size field */
+	char c_data[];  /* <name>\0<value> */
+};
+
+static int __init __maybe_unused do_setxattrs(char *pathname)
+{
+	char *buf = xattr_buf;
+	char *bufend = buf + xattr_len;
+	struct xattr_hdr *hdr;
+	char str[sizeof(hdr->c_size) + 1];
+	struct path path;
+
+	if (!xattr_len)
+		return 0;
+
+	str[sizeof(hdr->c_size)] = 0;
+
+	while (buf < bufend) {
+		char *xattr_name, *xattr_value;
+		unsigned long xattr_entry_size;
+		unsigned long xattr_name_size, xattr_value_size;
+		int ret;
+
+		if (buf + sizeof(hdr->c_size) > bufend) {
+			error("malformed xattrs");
+			break;
+		}
+
+		hdr = (struct xattr_hdr *)buf;
+		memcpy(str, hdr->c_size, sizeof(hdr->c_size));
+		ret = kstrtoul(str, 16, &xattr_entry_size);
+		buf += xattr_entry_size;
+		if (ret || buf > bufend || !xattr_entry_size) {
+			error("malformed xattrs");
+			break;
+		}
+
+		xattr_name = hdr->c_data;
+		xattr_name_size = strnlen(xattr_name,
+					xattr_entry_size - sizeof(hdr->c_size));
+		if (xattr_name_size == xattr_entry_size - sizeof(hdr->c_size)) {
+			error("malformed xattrs");
+			break;
+		}
+
+		xattr_value = xattr_name + xattr_name_size + 1;
+		xattr_value_size = buf - xattr_value;
+
+		ret = kern_path(pathname, 0, &path);
+		if (!ret) {
+			ret = vfs_setxattr(path.dentry, xattr_name, xattr_value,
+					   xattr_value_size, 0);
+
+			path_put(&path);
+		}
+
+		pr_debug("%s: %s size: %lu val: %s (ret: %d)\n", pathname,
+			 xattr_name, xattr_value_size, xattr_value, ret);
+	}
+
+	return 0;
+}
+
 static __initdata int wfd;
 
 static int __init do_name(void)
-- 
2.17.1

