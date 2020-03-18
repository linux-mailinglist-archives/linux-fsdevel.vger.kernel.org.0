Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87CB4189F4D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Mar 2020 16:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbgCRPKH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Mar 2020 11:10:07 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:32943 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726856AbgCRPKD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Mar 2020 11:10:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584544201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PhtuzhH7HoYoxWiFFKdPTqNn1KamL8DNhzQaNlGjd/s=;
        b=A4+oBWkt9GNJksS40d/kR9Wfd62czgdAJyDq8FEgtu8zLaZ5e2utoJpvQvcToIZCrBikzX
        m6AGxAVWgWcUSFH0l3aMQYD+3B68kBsAL2S6gU7EMaNs7ZIxo4pVOY0wvye6SbK9OYoyQ9
        QCCl/vWjuepIvfqVqVNURWNjkH2eCU8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-EhCaXUzsMf-nJJPjfB6LiQ-1; Wed, 18 Mar 2020 11:09:59 -0400
X-MC-Unique: EhCaXUzsMf-nJJPjfB6LiQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D7581005F94;
        Wed, 18 Mar 2020 15:09:57 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-113-126.rdu2.redhat.com [10.10.113.126])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 94FF85D9E5;
        Wed, 18 Mar 2020 15:09:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 12/13] fsinfo: Example support for Ext4 [ver #19]
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, dhowells@redhat.com, raven@themaw.net,
        mszeredi@redhat.com, christian@brauner.io, jannh@google.com,
        darrick.wong@oracle.com, kzak@redhat.com, jlayton@redhat.com,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 18 Mar 2020 15:09:53 +0000
Message-ID: <158454419382.2864823.6001642888459699321.stgit@warthog.procyon.org.uk>
In-Reply-To: <158454408854.2864823.5910520544515668590.stgit@warthog.procyon.org.uk>
References: <158454408854.2864823.5910520544515668590.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
index 61b37a052052..f0304aa107f8 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -42,6 +42,7 @@
 
 #include <linux/fscrypt.h>
 #include <linux/fsverity.h>
+#include <linux/fsinfo.h>
 
 #include <linux/compiler.h>
 
@@ -3190,6 +3191,11 @@ extern const struct inode_operations ext4_file_inode_operations;
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
index ff1b764b0c0e..3655fbeab754 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1487,6 +1487,9 @@ static const struct super_operations ext4_sops = {
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
index 150b693a1b5a..4cfb71227eff 100644
--- a/include/uapi/linux/fsinfo.h
+++ b/include/uapi/linux/fsinfo.h
@@ -42,6 +42,8 @@
 #define FSINFO_ATTR_AFS_SERVER_NAME	0x301	/* Name of the Nth server (string) */
 #define FSINFO_ATTR_AFS_SERVER_ADDRESSES 0x302	/* List of addresses of the Nth server */
 
+#define FSINFO_ATTR_EXT4_TIMESTAMPS	0x400	/* Ext4 superblock timestamps */
+
 /*
  * Optional fsinfo() parameter structure.
  *
@@ -323,4 +325,18 @@ struct fsinfo_afs_server_address {
 
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
index 9f9564f7f73e..6ad1128a3e1d 100644
--- a/samples/vfs/test-fsinfo.c
+++ b/samples/vfs/test-fsinfo.c
@@ -384,6 +384,40 @@ static void dump_afs_fsinfo_server_address(void *reply, unsigned int size)
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
@@ -471,6 +505,7 @@ static const struct fsinfo_attribute fsinfo_attributes[] = {
 	FSINFO_STRING	(FSINFO_ATTR_AFS_CELL_NAME,	string),
 	FSINFO_STRING	(FSINFO_ATTR_AFS_SERVER_NAME,	string),
 	FSINFO_LIST_N	(FSINFO_ATTR_AFS_SERVER_ADDRESSES, afs_fsinfo_server_address),
+	FSINFO_VSTRUCT	(FSINFO_ATTR_EXT4_TIMESTAMPS,	ext4_fsinfo_timestamps),
 	{}
 };
 


