Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6995E17E215
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2020 15:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbgCIOCz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Mar 2020 10:02:55 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50067 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726809AbgCIOCz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Mar 2020 10:02:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583762574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZWNwv0kqxXu8MKNrXXsXkeiy6YToQwPQIxqZbinVxDs=;
        b=G4yfvT4z/0kOunxypPcn5aXEdBacXdPZqrAw9v/JIqhlMhDCdDX+qXVDXBJPMpdqASgvlL
        RDgBWdedk8l2JMCVRBimJIFukMS4ilAM/b2sD3MKCDX0WYOfOHRS/lhZdGnLrC/WQ4JflW
        i2AfWVO8qxDK7U1vGLwd7OFq6fpbIwE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-Mv0KAgR3PkOYMrJPzGdCLA-1; Mon, 09 Mar 2020 10:02:52 -0400
X-MC-Unique: Mv0KAgR3PkOYMrJPzGdCLA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42A2F1088388;
        Mon,  9 Mar 2020 14:02:50 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-182.rdu2.redhat.com [10.10.120.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 16E4760C87;
        Mon,  9 Mar 2020 14:02:46 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 13/14] fsinfo: Example support for Ext4 [ver #18]
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, dhowells@redhat.com, raven@themaw.net,
        mszeredi@redhat.com, christian@brauner.io, jannh@google.com,
        darrick.wong@oracle.com, kzak@redhat.com, jlayton@redhat.com,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 09 Mar 2020 14:02:46 +0000
Message-ID: <158376256623.344135.9686051802633431404.stgit@warthog.procyon.org.uk>
In-Reply-To: <158376244589.344135.12925590041630631412.stgit@warthog.procyon.org.uk>
References: <158376244589.344135.12925590041630631412.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add the ability to list some Ext4 volume timestamps as an example.

Is this useful for ext4?  Is there anything else that could be useful?

Signed-off-by: David Howells <dhowells@redhat.com>
cc: "Theodore Ts'o" <tytso@mit.edu>
cc: Andreas Dilger <adilger.kernel@dilger.ca>
cc: linux-ext4@vger.kernel.org
---

 fs/ext4/Makefile            |    1 +
 fs/ext4/ext4.h              |    6 ++++++
 fs/ext4/fsinfo.c            |   45 +++++++++++++++++++++++++++++++++++++++++++
 fs/ext4/super.c             |    3 +++
 include/uapi/linux/fsinfo.h |   16 +++++++++++++++
 samples/vfs/test-fsinfo.c   |   35 +++++++++++++++++++++++++++++++++
 6 files changed, 106 insertions(+)
 create mode 100644 fs/ext4/fsinfo.c

diff --git a/fs/ext4/Makefile b/fs/ext4/Makefile
index 4ccb3c9189d8..71d5b460c7c7 100644
--- a/fs/ext4/Makefile
+++ b/fs/ext4/Makefile
@@ -16,3 +16,4 @@ ext4-$(CONFIG_EXT4_FS_SECURITY)		+= xattr_security.o
 ext4-inode-test-objs			+= inode-test.o
 obj-$(CONFIG_EXT4_KUNIT_TESTS)		+= ext4-inode-test.o
 ext4-$(CONFIG_FS_VERITY)		+= verity.o
+ext4-$(CONFIG_FSINFO)			+= fsinfo.o
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 9a2ee2428ecc..461968a87cd6 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -42,6 +42,7 @@
 
 #include <linux/fscrypt.h>
 #include <linux/fsverity.h>
+#include <linux/fsinfo.h>
 
 #include <linux/compiler.h>
 
@@ -3166,6 +3167,11 @@ extern const struct inode_operations ext4_file_inode_operations;
 extern const struct file_operations ext4_file_operations;
 extern loff_t ext4_llseek(struct file *file, loff_t offset, int origin);
 
+/* fsinfo.c */
+#ifdef CONFIG_FSINFO
+extern int ext4_fsinfo(struct path *path, struct fsinfo_context *ctx);
+#endif
+
 /* inline.c */
 extern int ext4_get_max_inline_size(struct inode *inode);
 extern int ext4_find_inline_data_nolock(struct inode *inode);
diff --git a/fs/ext4/fsinfo.c b/fs/ext4/fsinfo.c
new file mode 100644
index 000000000000..785f82a74dc9
--- /dev/null
+++ b/fs/ext4/fsinfo.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Filesystem information for ext4
+ *
+ * Copyright (C) 2020 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include <linux/mount.h>
+#include "ext4.h"
+
+static int ext4_fsinfo_get_volume_name(struct path *path, struct fsinfo_context *ctx)
+{
+	const struct ext4_sb_info *sbi = EXT4_SB(path->mnt->mnt_sb);
+	const struct ext4_super_block *es = sbi->s_es;
+
+	memcpy(ctx->buffer, es->s_volume_name, sizeof(es->s_volume_name));
+	return strlen(ctx->buffer);
+}
+
+static int ext4_fsinfo_get_timestamps(struct path *path, struct fsinfo_context *ctx)
+{
+	const struct ext4_sb_info *sbi = EXT4_SB(path->mnt->mnt_sb);
+	const struct ext4_super_block *es = sbi->s_es;
+	struct fsinfo_ext4_timestamps *ts = ctx->buffer;
+
+#define Z(R,S) R = S | (((u64)S##_hi) << 32)
+	Z(ts->mkfs_time,	es->s_mkfs_time);
+	Z(ts->mount_time,	es->s_mtime);
+	Z(ts->write_time,	es->s_wtime);
+	Z(ts->last_check_time,	es->s_lastcheck);
+	Z(ts->first_error_time,	es->s_first_error_time);
+	Z(ts->last_error_time,	es->s_last_error_time);
+	return sizeof(*ts);
+}
+
+static const struct fsinfo_attribute ext4_fsinfo_attributes[] = {
+	FSINFO_STRING	(FSINFO_ATTR_VOLUME_NAME,	ext4_fsinfo_get_volume_name),
+	FSINFO_VSTRUCT	(FSINFO_ATTR_EXT4_TIMESTAMPS,	ext4_fsinfo_get_timestamps),
+	{}
+};
+
+int ext4_fsinfo(struct path *path, struct fsinfo_context *ctx)
+{
+	return fsinfo_get_attribute(path, ctx, ext4_fsinfo_attributes);
+}
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 8434217549b3..02b4df073c4b 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1477,6 +1477,9 @@ static const struct super_operations ext4_sops = {
 	.freeze_fs	= ext4_freeze,
 	.unfreeze_fs	= ext4_unfreeze,
 	.statfs		= ext4_statfs,
+#ifdef CONFIG_FSINFO
+	.fsinfo		= ext4_fsinfo,
+#endif
 	.remount_fs	= ext4_remount,
 	.show_options	= ext4_show_options,
 #ifdef CONFIG_QUOTA
diff --git a/include/uapi/linux/fsinfo.h b/include/uapi/linux/fsinfo.h
index 154c13a55819..d8d05f0f1473 100644
--- a/include/uapi/linux/fsinfo.h
+++ b/include/uapi/linux/fsinfo.h
@@ -41,6 +41,8 @@
 #define FSINFO_ATTR_AFS_SERVER_NAME	0x301	/* Name of the Nth server (string) */
 #define FSINFO_ATTR_AFS_SERVER_ADDRESSES 0x302	/* List of addresses of the Nth server */
 
+#define FSINFO_ATTR_EXT4_TIMESTAMPS	0x400	/* Ext4 superblock timestamps */
+
 /*
  * Optional fsinfo() parameter structure.
  *
@@ -312,4 +314,18 @@ struct fsinfo_afs_server_address {
 
 #define FSINFO_ATTR_AFS_SERVER_ADDRESSES__STRUCT struct fsinfo_afs_server_address
 
+/*
+ * Information struct for fsinfo(FSINFO_ATTR_EXT4_TIMESTAMPS).
+ */
+struct fsinfo_ext4_timestamps {
+	__u64		mkfs_time;
+	__u64		mount_time;
+	__u64		write_time;
+	__u64		last_check_time;
+	__u64		first_error_time;
+	__u64		last_error_time;
+};
+
+#define FSINFO_ATTR_EXT4_TIMESTAMPS__STRUCT struct fsinfo_ext4_timestamps
+
 #endif /* _UAPI_LINUX_FSINFO_H */
diff --git a/samples/vfs/test-fsinfo.c b/samples/vfs/test-fsinfo.c
index 82944f09e0c9..829297e9d1b6 100644
--- a/samples/vfs/test-fsinfo.c
+++ b/samples/vfs/test-fsinfo.c
@@ -374,6 +374,40 @@ static void dump_afs_fsinfo_server_address(void *reply, unsigned int size)
 	printf("family=%u\n", ss->ss_family);
 }
 
+static char *dump_ext4_time(char *buffer, time_t tim)
+{
+	struct tm tm;
+	int len;
+
+	if (tim == 0)
+		return "-";
+
+	if (!localtime_r(&tim, &tm)) {
+		perror("localtime_r");
+		exit(1);
+	}
+	len = strftime(buffer, 100, "%F %T", &tm);
+	if (len == 0) {
+		perror("strftime");
+		exit(1);
+	}
+	return buffer;
+}
+
+static void dump_ext4_fsinfo_timestamps(void *reply, unsigned int size)
+{
+	struct fsinfo_ext4_timestamps *r = reply;
+	char buffer[100];
+
+	printf("\n");
+	printf("\tmkfs    : %s\n", dump_ext4_time(buffer, r->mkfs_time));
+	printf("\tmount   : %s\n", dump_ext4_time(buffer, r->mount_time));
+	printf("\twrite   : %s\n", dump_ext4_time(buffer, r->write_time));
+	printf("\tfsck    : %s\n", dump_ext4_time(buffer, r->last_check_time));
+	printf("\t1st-err : %s\n", dump_ext4_time(buffer, r->first_error_time));
+	printf("\tlast-err: %s\n", dump_ext4_time(buffer, r->last_error_time));
+}
+
 static void dump_string(void *reply, unsigned int size)
 {
 	char *s = reply, *p;
@@ -460,6 +494,7 @@ static const struct fsinfo_attribute fsinfo_attributes[] = {
 	FSINFO_STRING	(FSINFO_ATTR_AFS_CELL_NAME,	string),
 	FSINFO_STRING	(FSINFO_ATTR_AFS_SERVER_NAME,	string),
 	FSINFO_LIST_N	(FSINFO_ATTR_AFS_SERVER_ADDRESSES, afs_fsinfo_server_address),
+	FSINFO_VSTRUCT	(FSINFO_ATTR_EXT4_TIMESTAMPS,	ext4_fsinfo_timestamps),
 	{}
 };
 


