Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5F0188F7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2019 13:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbfEIL2k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 May 2019 07:28:40 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:32929 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725869AbfEIL2j (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 May 2019 07:28:39 -0400
Received: from lhreml703-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 104CA225B8BBA7A807A8;
        Thu,  9 May 2019 12:28:38 +0100 (IST)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.154)
 by smtpsuk.huawei.com (10.201.108.44) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Thu, 9 May 2019 12:28:32 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <viro@zeniv.linux.org.uk>
CC:     <linux-security-module@vger.kernel.org>,
        <linux-integrity@vger.kernel.org>, <initramfs@vger.kernel.org>,
        <linux-api@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <zohar@linux.vnet.ibm.com>,
        <silviu.vlasceanu@huawei.com>, <dmitry.kasatkin@huawei.com>,
        <takondra@cisco.com>, <kamensky@cisco.com>, <hpa@zytor.com>,
        <arnd@arndb.de>, <rob@landley.net>, <james.w.mcmechan@gmail.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v2 2/3] initramfs: set extended attributes
Date:   Thu, 9 May 2019 13:24:19 +0200
Message-ID: <20190509112420.15671-3-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190509112420.15671-1-roberto.sassu@huawei.com>
References: <20190509112420.15671-1-roberto.sassu@huawei.com>
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
        sys_lsetxattr() with ksys_lsetxattr(), added check for
        xattr_entry_size, added check for hdr->c_size, replaced strlen()
        with strnlen()]

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Signed-off-by: Victor Kamensky <kamensky@cisco.com>
Signed-off-by: Taras Kondratiuk <takondra@cisco.com>
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 init/initramfs.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 61 insertions(+), 2 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 4749e1115eef..98c2aa4b5ab4 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -146,7 +146,8 @@ static __initdata time64_t mtime;
 
 static __initdata unsigned long ino, major, minor, nlink;
 static __initdata umode_t mode;
-static __initdata unsigned long body_len, name_len;
+static __initdata u32 name_len, xattr_len;
+static __initdata u64 body_len;
 static __initdata uid_t uid;
 static __initdata gid_t gid;
 static __initdata unsigned rdev;
@@ -218,7 +219,7 @@ static void __init read_into(char *buf, unsigned size, enum state next)
 	}
 }
 
-static __initdata char *header_buf, *symlink_buf, *name_buf;
+static __initdata char *header_buf, *symlink_buf, *name_buf, *xattr_buf;
 
 static int __init do_start(void)
 {
@@ -392,6 +393,64 @@ static int __init do_symlink(void)
 	return 0;
 }
 
+struct xattr_hdr {
+	char c_size[8]; /* total size including c_size field */
+	char c_data[];  /* <name>\0<value> */
+};
+
+static int __init do_setxattrs(void)
+{
+	char *buf = xattr_buf;
+	char *bufend = buf + xattr_len;
+	struct xattr_hdr *hdr;
+	char str[sizeof(hdr->c_size) + 1];
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
+		ret = ksys_lsetxattr(name_buf, xattr_name, xattr_value,
+				     xattr_value_size, 0);
+
+		pr_debug("%s: %s size: %lu val: %s (ret: %d)\n", name_buf,
+			 xattr_name, xattr_value_size, xattr_value, ret);
+	}
+
+	return 0;
+}
+
 static __initdata int (*actions[])(void) = {
 	[Start]		= do_start,
 	[Collect]	= do_collect,
-- 
2.17.1

