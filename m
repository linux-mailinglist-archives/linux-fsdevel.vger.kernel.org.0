Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D512922C695
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jul 2020 15:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbgGXNff (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jul 2020 09:35:35 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41705 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727047AbgGXNfc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jul 2020 09:35:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595597730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0604IJfk6DkSTO0UDaOBwJ+5DcWmppgwGX7qoAuG4Wk=;
        b=YkF8NIf9RPBSeTscX4uBwMslMYKoC3hWsHmezHhz/mzjX/KX49ZkkDROxwPcV5NUGGWApX
        FulXCYBRh5+6VWI65xFVE5tod8gtAb2F11JoG0xXLoYMyUlbBdnZLkNxhVFi0suIGdbO9F
        t/th7bW+/rr2o5T9lrjVpHoaXRi4R4U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-nz-y2Mm7NnWRpgvn8vAPgg-1; Fri, 24 Jul 2020 09:35:28 -0400
X-MC-Unique: nz-y2Mm7NnWRpgvn8vAPgg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B2EE9800C64;
        Fri, 24 Jul 2020 13:35:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-32.rdu2.redhat.com [10.10.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A4BC67010B;
        Fri, 24 Jul 2020 13:35:23 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 04/17] fsinfo: Allow retrieval of superblock devname,
 options and stats [ver #20]
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net, mszeredi@redhat.com,
        christian@brauner.io, jannh@google.com, darrick.wong@oracle.com,
        kzak@redhat.com, jlayton@redhat.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 24 Jul 2020 14:35:22 +0100
Message-ID: <159559772288.2144584.15067974721940754302.stgit@warthog.procyon.org.uk>
In-Reply-To: <159559768062.2144584.13583793543173131929.stgit@warthog.procyon.org.uk>
References: <159559768062.2144584.13583793543173131929.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Provide fsinfo() attributes to retrieve superblock device name, options,
and statistics in string form.  The following attributes are defined:

	FSINFO_ATTR_SOURCE		- Mount-specific device name
	FSINFO_ATTR_CONFIGURATION	- Mount options
	FSINFO_ATTR_FS_STATISTICS	- Filesystem statistics

FSINFO_ATTR_SOURCE could be made indexable by params->Nth to handle the
case where there is more than one source (e.g. the bcachefs filesystem).

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/fsinfo.c                 |   39 +++++++++++++++++++++++++++++++++++++++
 fs/internal.h               |    2 ++
 fs/namespace.c              |   41 +++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/fsinfo.h |    3 +++
 samples/vfs/test-fsinfo.c   |    4 ++++
 5 files changed, 89 insertions(+)

diff --git a/fs/fsinfo.c b/fs/fsinfo.c
index 79c222d465d8..aef7a736e8fc 100644
--- a/fs/fsinfo.c
+++ b/fs/fsinfo.c
@@ -231,6 +231,42 @@ static int fsinfo_generic_volume_id(struct path *path, struct fsinfo_context *ct
 	return fsinfo_string(path->dentry->d_sb->s_id, ctx);
 }
 
+/*
+ * Retrieve the superblock configuration (mount options) as a comma-separated
+ * string.  The initial comma is stripped off and NUL termination is added.
+ */
+static int fsinfo_generic_seq_read(struct path *path, struct fsinfo_context *ctx)
+{
+	struct super_block *sb = path->dentry->d_sb;
+	struct seq_file m = {
+		.buf	= ctx->buffer,
+		.size	= ctx->buf_size - 1,
+	};
+	int ret = 0;
+
+	switch (ctx->requested_attr) {
+	case FSINFO_ATTR_CONFIGURATION:
+		seq_puts(&m, sb_rdonly(sb) ? "ro" : "rw");
+		ret = security_sb_show_options(&m, sb);
+		if (!ret && sb->s_op->show_options)
+			ret = sb->s_op->show_options(&m, path->mnt->mnt_root);
+		break;
+
+	case FSINFO_ATTR_FS_STATISTICS:
+		if (sb->s_op->show_stats)
+			ret = sb->s_op->show_stats(&m, path->mnt->mnt_root);
+		break;
+	}
+
+	if (ret < 0)
+		return ret;
+	if (seq_has_overflowed(&m))
+		return ctx->buf_size + PAGE_SIZE;
+
+	((char *)ctx->buffer)[ctx->skip + m.count] = 0;
+	return m.count + 1;
+}
+
 static const struct fsinfo_attribute fsinfo_common_attributes[] = {
 	FSINFO_VSTRUCT	(FSINFO_ATTR_STATFS,		fsinfo_generic_statfs),
 	FSINFO_VSTRUCT	(FSINFO_ATTR_IDS,		fsinfo_generic_ids),
@@ -240,6 +276,9 @@ static const struct fsinfo_attribute fsinfo_common_attributes[] = {
 	FSINFO_STRING	(FSINFO_ATTR_VOLUME_ID,		fsinfo_generic_volume_id),
 	FSINFO_VSTRUCT	(FSINFO_ATTR_VOLUME_UUID,	fsinfo_generic_volume_uuid),
 	FSINFO_VSTRUCT	(FSINFO_ATTR_FEATURES,		fsinfo_generic_features),
+	FSINFO_STRING	(FSINFO_ATTR_SOURCE,		fsinfo_generic_mount_source),
+	FSINFO_STRING	(FSINFO_ATTR_CONFIGURATION,	fsinfo_generic_seq_read),
+	FSINFO_STRING	(FSINFO_ATTR_FS_STATISTICS,	fsinfo_generic_seq_read),
 
 	FSINFO_LIST	(FSINFO_ATTR_FSINFO_ATTRIBUTES,	(void *)123UL),
 	FSINFO_VSTRUCT_N(FSINFO_ATTR_FSINFO_ATTRIBUTE_INFO, (void *)123UL),
diff --git a/fs/internal.h b/fs/internal.h
index ea60d864a8cb..0b57da498f06 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -89,6 +89,8 @@ extern int __mnt_want_write_file(struct file *);
 extern void __mnt_drop_write_file(struct file *);
 
 extern void dissolve_on_fput(struct vfsmount *);
+extern int fsinfo_generic_mount_source(struct path *, struct fsinfo_context *);
+
 /*
  * fs_struct.c
  */
diff --git a/fs/namespace.c b/fs/namespace.c
index 73ff5bf0c9af..ead8d1a16610 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -30,6 +30,7 @@
 #include <uapi/linux/mount.h>
 #include <linux/fs_context.h>
 #include <linux/shmem_fs.h>
+#include <linux/fsinfo.h>
 
 #include "pnode.h"
 #include "internal.h"
@@ -4111,3 +4112,43 @@ const struct proc_ns_operations mntns_operations = {
 	.install	= mntns_install,
 	.owner		= mntns_owner,
 };
+
+#ifdef CONFIG_FSINFO
+static inline void mangle(struct seq_file *m, const char *s)
+{
+	seq_escape(m, s, " \t\n\\");
+}
+
+/*
+ * Return the mount source/device name as seen from this mountpoint.  Shared
+ * mounts may vary here and the filesystem is permitted to substitute its own
+ * rendering.
+ */
+int fsinfo_generic_mount_source(struct path *path, struct fsinfo_context *ctx)
+{
+	struct super_block *sb = path->mnt->mnt_sb;
+	struct mount *mnt = real_mount(path->mnt);
+	struct seq_file m = {
+		.buf	= ctx->buffer,
+		.size	= ctx->buf_size - 1,
+	};
+	int ret;
+
+	if (sb->s_op->show_devname) {
+		ret = sb->s_op->show_devname(&m, mnt->mnt.mnt_root);
+		if (ret < 0)
+			return ret;
+	} else {
+		if (!mnt->mnt_devname)
+			return fsinfo_string("none", ctx);
+		mangle(&m, mnt->mnt_devname);
+	}
+
+	if (seq_has_overflowed(&m))
+		return ctx->buf_size + PAGE_SIZE;
+
+	((char *)ctx->buffer)[m.count] = 0;
+	return m.count + 1;
+}
+
+#endif /* CONFIG_FSINFO */
diff --git a/include/uapi/linux/fsinfo.h b/include/uapi/linux/fsinfo.h
index b8b2c836267b..a27e92b68266 100644
--- a/include/uapi/linux/fsinfo.h
+++ b/include/uapi/linux/fsinfo.h
@@ -24,6 +24,9 @@
 #define FSINFO_ATTR_VOLUME_UUID		0x06	/* Volume UUID (LE uuid) */
 #define FSINFO_ATTR_VOLUME_NAME		0x07	/* Volume name (string) */
 #define FSINFO_ATTR_FEATURES		0x08	/* Filesystem features (bits) */
+#define FSINFO_ATTR_SOURCE		0x09	/* Superblock source/device name (string) */
+#define FSINFO_ATTR_CONFIGURATION	0x0a	/* Superblock configuration/options (string) */
+#define FSINFO_ATTR_FS_STATISTICS	0x0b	/* Superblock filesystem statistics (string) */
 
 #define FSINFO_ATTR_FSINFO_ATTRIBUTE_INFO 0x100	/* Information about attr N (for path) */
 #define FSINFO_ATTR_FSINFO_ATTRIBUTES	0x101	/* List of supported attrs (for path) */
diff --git a/samples/vfs/test-fsinfo.c b/samples/vfs/test-fsinfo.c
index c5932109f683..634f30b7e67f 100644
--- a/samples/vfs/test-fsinfo.c
+++ b/samples/vfs/test-fsinfo.c
@@ -364,6 +364,10 @@ static const struct fsinfo_attribute fsinfo_attributes[] = {
 	FSINFO_STRING	(FSINFO_ATTR_VOLUME_ID,		string),
 	FSINFO_VSTRUCT	(FSINFO_ATTR_VOLUME_UUID,	fsinfo_generic_volume_uuid),
 	FSINFO_STRING	(FSINFO_ATTR_VOLUME_NAME,	string),
+	FSINFO_STRING	(FSINFO_ATTR_SOURCE,		string),
+	FSINFO_STRING	(FSINFO_ATTR_CONFIGURATION,	string),
+	FSINFO_STRING	(FSINFO_ATTR_FS_STATISTICS,	string),
+
 	FSINFO_VSTRUCT_N(FSINFO_ATTR_FSINFO_ATTRIBUTE_INFO, fsinfo_meta_attribute_info),
 	FSINFO_LIST	(FSINFO_ATTR_FSINFO_ATTRIBUTES,	fsinfo_meta_attributes),
 	{}


