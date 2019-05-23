Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA8027CAC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2019 14:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730631AbfEWMW2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 May 2019 08:22:28 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:32964 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728309AbfEWMW2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 May 2019 08:22:28 -0400
Received: from lhreml705-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id A78CDBB7CA354BF85882;
        Thu, 23 May 2019 13:22:26 +0100 (IST)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.154)
 by smtpsuk.huawei.com (10.201.108.46) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Thu, 23 May 2019 13:22:18 +0100
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
Subject: [PATCH v4 2/3] initramfs: read metadata from special file METADATA!!!
Date:   Thu, 23 May 2019 14:18:02 +0200
Message-ID: <20190523121803.21638-3-roberto.sassu@huawei.com>
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

Instead of changing the CPIO format, metadata are parsed from regular files
with special name 'METADATA!!!'. This file immediately follows the file
metadata are added to.

This patch checks if the file being extracted has the special name and, if
yes, creates a buffer with the content of that file and calls
do_parse_metadata() to parse metadata from the buffer.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Reported-by: kbuild test robot <lkp@intel.com>
---
 init/initramfs.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 5de396a6aac0..862c03123de8 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -222,6 +222,7 @@ static void __init read_into(char *buf, unsigned size, enum state next)
 }
 
 static __initdata char *header_buf, *symlink_buf, *name_buf, *metadata_buf;
+static __initdata char *metadata_buf_ptr, *previous_name_buf;
 
 static int __init do_start(void)
 {
@@ -400,6 +401,7 @@ static int __init __maybe_unused do_parse_metadata(char *pathname)
 }
 
 static __initdata int wfd;
+static __initdata int metadata;
 
 static int __init do_name(void)
 {
@@ -408,6 +410,10 @@ static int __init do_name(void)
 	if (strcmp(collected, "TRAILER!!!") == 0) {
 		free_hash();
 		return 0;
+	} else if (strcmp(collected, METADATA_FILENAME) == 0) {
+		metadata = 1;
+	} else {
+		memcpy(previous_name_buf, collected, strlen(collected) + 1);
 	}
 	clean_path(collected, mode);
 	if (S_ISREG(mode)) {
@@ -444,11 +450,47 @@ static int __init do_name(void)
 	return 0;
 }
 
+static int __init do_process_metadata(char *buf, int len, bool last)
+{
+	int ret = 0;
+
+	if (!metadata_buf) {
+		metadata_buf_ptr = metadata_buf = kmalloc(body_len, GFP_KERNEL);
+		if (!metadata_buf_ptr) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		metadata_len = body_len;
+	}
+
+	if (metadata_buf_ptr + len > metadata_buf + metadata_len) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	memcpy(metadata_buf_ptr, buf, len);
+	metadata_buf_ptr += len;
+
+	if (last)
+		do_parse_metadata(previous_name_buf);
+out:
+	if (ret < 0 || last) {
+		kfree(metadata_buf);
+		metadata_buf = NULL;
+		metadata = 0;
+	}
+
+	return ret;
+}
+
 static int __init do_copy(void)
 {
 	if (byte_count >= body_len) {
 		if (xwrite(wfd, victim, body_len) != body_len)
 			error("write error");
+		if (metadata)
+			do_process_metadata(victim, body_len, true);
 		ksys_close(wfd);
 		do_utime(vcollected, mtime);
 		kfree(vcollected);
@@ -458,6 +500,8 @@ static int __init do_copy(void)
 	} else {
 		if (xwrite(wfd, victim, byte_count) != byte_count)
 			error("write error");
+		if (metadata)
+			do_process_metadata(victim, byte_count, false);
 		body_len -= byte_count;
 		eat(byte_count);
 		return 1;
@@ -467,6 +511,7 @@ static int __init do_copy(void)
 static int __init do_symlink(void)
 {
 	collected[N_ALIGN(name_len) + body_len] = '\0';
+	memcpy(previous_name_buf, collected, strlen(collected) + 1);
 	clean_path(collected, 0);
 	ksys_symlink(collected + N_ALIGN(name_len), collected);
 	ksys_lchown(collected, uid, gid);
@@ -534,8 +579,9 @@ static char * __init unpack_to_rootfs(char *buf, unsigned long len)
 	header_buf = kmalloc(110, GFP_KERNEL);
 	symlink_buf = kmalloc(PATH_MAX + N_ALIGN(PATH_MAX) + 1, GFP_KERNEL);
 	name_buf = kmalloc(N_ALIGN(PATH_MAX), GFP_KERNEL);
+	previous_name_buf = kmalloc(N_ALIGN(PATH_MAX), GFP_KERNEL);
 
-	if (!header_buf || !symlink_buf || !name_buf)
+	if (!header_buf || !symlink_buf || !name_buf || !previous_name_buf)
 		panic("can't allocate buffers");
 
 	state = Start;
@@ -580,6 +626,7 @@ static char * __init unpack_to_rootfs(char *buf, unsigned long len)
 		len -= my_inptr;
 	}
 	dir_utime();
+	kfree(previous_name_buf);
 	kfree(name_buf);
 	kfree(symlink_buf);
 	kfree(header_buf);
-- 
2.17.1

