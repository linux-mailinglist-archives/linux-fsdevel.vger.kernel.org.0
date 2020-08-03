Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88F9423A7C8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Aug 2020 15:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgHCNin (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Aug 2020 09:38:43 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29606 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728335AbgHCNie (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Aug 2020 09:38:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596461913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/AwV8WBhuqPeelgBaxBkgLyMvJZx/53MPZJnj+q0yps=;
        b=DSbsan4l8wTF2YjuF8cijfRE3Ftg4BsAb+jd18ddY9DMFKV5m5OrFsMwMWDT5i3eytj7oi
        U89jfc+EhW3VBQbOvC0O+wnsbRfp2Qr5H26gNpg+Zd1gWThdcnnlK9tencnEMY3MpcRps8
        Amd5AeQ7FqmVohZw+sOPQFZUvuD19Ts=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-vMeBDm6kPvyfAUd1PnObMQ-1; Mon, 03 Aug 2020 09:38:31 -0400
X-MC-Unique: vMeBDm6kPvyfAUd1PnObMQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3EB8357;
        Mon,  3 Aug 2020 13:38:29 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-32.rdu2.redhat.com [10.10.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2BEFE87E2C;
        Mon,  3 Aug 2020 13:38:25 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 14/18] fsinfo: Add support to ext4 [ver #21]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Eric Biggers <ebiggers@kernel.org>, linux-ext4@vger.kernel.org,
        dhowells@redhat.com, torvalds@linux-foundation.org,
        raven@themaw.net, mszeredi@redhat.com, christian@brauner.io,
        jannh@google.com, darrick.wong@oracle.com, kzak@redhat.com,
        jlayton@redhat.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 03 Aug 2020 14:38:25 +0100
Message-ID: <159646190516.1784947.7453810619136216278.stgit@warthog.procyon.org.uk>
In-Reply-To: <159646178122.1784947.11705396571718464082.stgit@warthog.procyon.org.uk>
References: <159646178122.1784947.11705396571718464082.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add support to ext4, including the following:

 (1) FSINFO_ATTR_SUPPORTS: Information about supported STATX attributes and
     support for ioctls like FS_IOC_[GS]ETFLAGS and FS_IOC_FS[GS]ETXATTR.

 (2) FSINFO_ATTR_FEATURES: Information about features supported by an ext4
     filesystem, such as whether version counting, birth time and name case
     folding are in operation.

 (3) FSINFO_ATTR_VOLUME_NAME: The volume name from the superblock.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
cc: "Theodore Ts'o" <tytso@mit.edu>
cc: Andreas Dilger <adilger.kernel@dilger.ca>
cc: Eric Biggers <ebiggers@kernel.org>
cc: linux-ext4@vger.kernel.org
---

 fs/ext4/Makefile |    1 +
 fs/ext4/ext4.h   |    6 +++
 fs/ext4/fsinfo.c |   97 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/ext4/super.c  |    3 ++
 4 files changed, 107 insertions(+)
 create mode 100644 fs/ext4/fsinfo.c

diff --git a/fs/ext4/Makefile b/fs/ext4/Makefile
index 2e42f47a7f98..ad67812bf7d0 100644
--- a/fs/ext4/Makefile
+++ b/fs/ext4/Makefile
@@ -17,3 +17,4 @@ ext4-$(CONFIG_EXT4_FS_SECURITY)		+= xattr_security.o
 ext4-inode-test-objs			+= inode-test.o
 obj-$(CONFIG_EXT4_KUNIT_TESTS)		+= ext4-inode-test.o
 ext4-$(CONFIG_FS_VERITY)		+= verity.o
+ext4-$(CONFIG_FSINFO)			+= fsinfo.o
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 42f5060f3cdf..99a737cf6308 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -43,6 +43,7 @@
 
 #include <linux/fscrypt.h>
 #include <linux/fsverity.h>
+#include <linux/fsinfo.h>
 
 #include <linux/compiler.h>
 
@@ -3233,6 +3234,11 @@ extern const struct inode_operations ext4_file_inode_operations;
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
index 000000000000..1d4093ef32e7
--- /dev/null
+++ b/fs/ext4/fsinfo.c
@@ -0,0 +1,97 @@
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
+static int ext4_fsinfo_supports(struct path *path, struct fsinfo_context *ctx)
+{
+	struct fsinfo_supports *p = ctx->buffer;
+	struct inode *inode = d_inode(path->dentry);
+	struct ext4_inode_info *ei = EXT4_I(inode);
+	struct ext4_inode *raw_inode;
+	u32 flags;
+
+	fsinfo_generic_supports(path, ctx);
+	p->stx_attributes |= (STATX_ATTR_APPEND |
+			      STATX_ATTR_COMPRESSED |
+			      STATX_ATTR_ENCRYPTED |
+			      STATX_ATTR_IMMUTABLE |
+			      STATX_ATTR_NODUMP |
+			      STATX_ATTR_VERITY);
+	if (EXT4_FITS_IN_INODE(raw_inode, ei, i_crtime))
+		p->stx_mask |= STATX_BTIME;
+
+	flags = EXT4_FL_USER_VISIBLE;
+	if (S_ISREG(inode->i_mode))
+		flags &= ~EXT4_PROJINHERIT_FL;
+	p->fs_ioc_getflags = flags;
+	flags &= EXT4_FL_USER_MODIFIABLE;
+	p->fs_ioc_setflags_set = flags;
+	p->fs_ioc_setflags_clear = flags;
+
+	p->fs_ioc_fsgetxattr_xflags = EXT4_FL_XFLAG_VISIBLE;
+	p->fs_ioc_fssetxattr_xflags_set = EXT4_FL_XFLAG_VISIBLE;
+	p->fs_ioc_fssetxattr_xflags_clear = EXT4_FL_XFLAG_VISIBLE;
+	return sizeof(*p);
+}
+
+static int ext4_fsinfo_features(struct path *path, struct fsinfo_context *ctx)
+{
+	struct fsinfo_features *p = ctx->buffer;
+	struct super_block *sb = path->dentry->d_sb;
+	struct inode *inode = d_inode(path->dentry);
+	struct ext4_inode_info *ei = EXT4_I(inode);
+	struct ext4_inode *raw_inode;
+
+	fsinfo_generic_features(path, ctx);
+	fsinfo_set_unix_features(p);
+	fsinfo_set_feature(p, FSINFO_FEAT_VOLUME_UUID);
+	fsinfo_set_feature(p, FSINFO_FEAT_VOLUME_NAME);
+	fsinfo_set_feature(p, FSINFO_FEAT_O_SYNC);
+	fsinfo_set_feature(p, FSINFO_FEAT_O_DIRECT);
+	fsinfo_set_feature(p, FSINFO_FEAT_ADV_LOCKS);
+
+	if (test_opt(sb, XATTR_USER))
+		fsinfo_set_feature(p, FSINFO_FEAT_XATTRS);
+	if (ext4_has_feature_journal(sb))
+		fsinfo_set_feature(p, FSINFO_FEAT_JOURNAL);
+	if (ext4_has_feature_casefold(sb))
+		fsinfo_set_feature(p, FSINFO_FEAT_NAME_CASE_INDEP);
+
+	if (sb->s_flags & SB_I_VERSION &&
+	    !test_opt2(sb, HURD_COMPAT) &&
+	    EXT4_INODE_SIZE(sb) > EXT4_GOOD_OLD_INODE_SIZE) {
+		fsinfo_set_feature(p, FSINFO_FEAT_IVER_DATA_CHANGE);
+		fsinfo_set_feature(p, FSINFO_FEAT_IVER_MONO_INCR);
+	}
+
+	if (EXT4_FITS_IN_INODE(raw_inode, ei, i_crtime))
+		fsinfo_set_feature(p, FSINFO_FEAT_HAS_BTIME);
+	return sizeof(*p);
+}
+
+static int ext4_fsinfo_get_volume_name(struct path *path, struct fsinfo_context *ctx)
+{
+	const struct ext4_sb_info *sbi = EXT4_SB(path->mnt->mnt_sb);
+	const struct ext4_super_block *es = sbi->s_es;
+
+	memcpy(ctx->buffer, es->s_volume_name, sizeof(es->s_volume_name));
+	return strlen(ctx->buffer) + 1;
+}
+
+static const struct fsinfo_attribute ext4_fsinfo_attributes[] = {
+	FSINFO_VSTRUCT	(FSINFO_ATTR_SUPPORTS,		ext4_fsinfo_supports),
+	FSINFO_VSTRUCT	(FSINFO_ATTR_FEATURES,		ext4_fsinfo_features),
+	FSINFO_STRING	(FSINFO_ATTR_VOLUME_NAME,	ext4_fsinfo_get_volume_name),
+	{}
+};
+
+int ext4_fsinfo(struct path *path, struct fsinfo_context *ctx)
+{
+	return fsinfo_get_attribute(path, ctx, ext4_fsinfo_attributes);
+}
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 330957ed1f05..47f349620176 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1481,6 +1481,9 @@ static const struct super_operations ext4_sops = {
 	.freeze_fs	= ext4_freeze,
 	.unfreeze_fs	= ext4_unfreeze,
 	.statfs		= ext4_statfs,
+#ifdef CONFIG_FSINFO
+	.fsinfo		= ext4_fsinfo,
+#endif
 	.remount_fs	= ext4_remount,
 	.show_options	= ext4_show_options,
 #ifdef CONFIG_QUOTA


