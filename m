Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E43217E1EF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2020 15:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgCIOBf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Mar 2020 10:01:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21552 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726932AbgCIOBf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Mar 2020 10:01:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583762494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fbp99ftMwaqb4vdN5Il0e/9agqnS8u49GAbE8+OWunU=;
        b=TaeyDjGNGQHmvJNQbFW+SjKANYTd8ZDU2Vk0wV9voryxv+NF26wVw/yJ+0bILx26e/GrAg
        34pbfVt4l6e3tWrcXRKWtnnbwZAOD+FmyVeZ38KyvBq2+nYcSdgM3FplNfyyo77j7Rxc4g
        u1LwlOMc1KxE59eUMPMdNodlyUDQsbs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-oafstIMsNcK0Csv0HPlvPg-1; Mon, 09 Mar 2020 10:01:32 -0400
X-MC-Unique: oafstIMsNcK0Csv0HPlvPg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 95E781088380;
        Mon,  9 Mar 2020 14:01:30 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-182.rdu2.redhat.com [10.10.120.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 002B01000322;
        Mon,  9 Mar 2020 14:01:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 04/14] fsinfo: Allow retrieval of superblock devname,
 options and stats [ver #18]
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net, mszeredi@redhat.com,
        christian@brauner.io, jannh@google.com, darrick.wong@oracle.com,
        kzak@redhat.com, jlayton@redhat.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 09 Mar 2020 14:01:27 +0000
Message-ID: <158376248725.344135.14885409875718177248.stgit@warthog.procyon.org.uk>
In-Reply-To: <158376244589.344135.12925590041630631412.stgit@warthog.procyon.org.uk>
References: <158376244589.344135.12925590041630631412.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

 fs/fsinfo.c                 |   41 +++++++++++++++++++++++++++++++++++++++++
 fs/internal.h               |    2 ++
 fs/namespace.c              |   39 +++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/fsinfo.h |    3 +++
 samples/vfs/test-fsinfo.c   |    4 ++++
 5 files changed, 89 insertions(+)

diff --git a/fs/fsinfo.c b/fs/fsinfo.c
index 662b0edde151..9562bce5253c 100644
--- a/fs/fsinfo.c
+++ b/fs/fsinfo.c
@@ -217,6 +217,44 @@ static int fsinfo_generic_volume_id(struct path *path, struct fsinfo_context *ct
 	return fsinfo_string(path->dentry->d_sb->s_id, ctx);
 }
 
+/*
+ * Retrieve the superblock configuration (mount options) as a comma-separated
+ * string.  The initial comma is stripped off.
+ */
+static int fsinfo_generic_seq_read(struct path *path, struct fsinfo_context *ctx)
+{
+	struct super_block *sb = path->dentry->d_sb;
+	struct seq_file m = {
+		.buf	= ctx->buffer,
+		.size	= ctx->buf_size,
+	};
+	int ret = 0;
+
+	switch (ctx->requested_attr) {
+	case FSINFO_ATTR_CONFIGURATION:
+		if (sb->s_op->show_options)
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
+	if (ctx->requested_attr == FSINFO_ATTR_CONFIGURATION) {
+		if (m.count > 0 && ((char *)ctx->buffer)[0] == ',') {
+			m.count--;
+			ctx->skip = 1;
+		}
+	}
+	return m.count;
+}
+
 static const struct fsinfo_attribute fsinfo_common_attributes[] = {
 	FSINFO_VSTRUCT	(FSINFO_ATTR_STATFS,		fsinfo_generic_statfs),
 	FSINFO_VSTRUCT	(FSINFO_ATTR_IDS,		fsinfo_generic_ids),
@@ -226,6 +264,9 @@ static const struct fsinfo_attribute fsinfo_common_attributes[] = {
 	FSINFO_STRING	(FSINFO_ATTR_VOLUME_ID,		fsinfo_generic_volume_id),
 	FSINFO_VSTRUCT	(FSINFO_ATTR_VOLUME_UUID,	fsinfo_generic_volume_uuid),
 	FSINFO_VSTRUCT	(FSINFO_ATTR_FEATURES,		fsinfo_generic_features),
+	FSINFO_STRING	(FSINFO_ATTR_SOURCE,		fsinfo_generic_mount_source),
+	FSINFO_STRING	(FSINFO_ATTR_CONFIGURATION,	fsinfo_generic_seq_read),
+	FSINFO_STRING	(FSINFO_ATTR_FS_STATISTICS,	fsinfo_generic_seq_read),
 
 	FSINFO_LIST	(FSINFO_ATTR_FSINFO_ATTRIBUTES,	(void *)123UL),
 	FSINFO_VSTRUCT_N(FSINFO_ATTR_FSINFO_ATTRIBUTE_INFO, (void *)123UL),
diff --git a/fs/internal.h b/fs/internal.h
index a0d90f23593c..6f2cc77bf38d 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -91,6 +91,8 @@ extern int __mnt_want_write_file(struct file *);
 extern void __mnt_drop_write_file(struct file *);
 
 extern void dissolve_on_fput(struct vfsmount *);
+extern int fsinfo_generic_mount_source(struct path *, struct fsinfo_context *);
+
 /*
  * fs_struct.c
  */
diff --git a/fs/namespace.c b/fs/namespace.c
index 54d237251941..e26e06447993 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -30,6 +30,7 @@
 #include <uapi/linux/mount.h>
 #include <linux/fs_context.h>
 #include <linux/shmem_fs.h>
+#include <linux/fsinfo.h>
 
 #include "pnode.h"
 #include "internal.h"
@@ -3997,3 +3998,41 @@ const struct proc_ns_operations mntns_operations = {
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
+		.size	= ctx->buf_size,
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
+	return m.count;
+}
+
+#endif /* CONFIG_FSINFO */
diff --git a/include/uapi/linux/fsinfo.h b/include/uapi/linux/fsinfo.h
index 448378301456..253b5213a775 100644
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
index a48072c77401..1002b718cdbc 100644
--- a/samples/vfs/test-fsinfo.c
+++ b/samples/vfs/test-fsinfo.c
@@ -358,6 +358,10 @@ static const struct fsinfo_attribute fsinfo_attributes[] = {
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


