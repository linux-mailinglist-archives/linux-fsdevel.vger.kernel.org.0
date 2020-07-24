Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B89EF22C6BE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jul 2020 15:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbgGXNg6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jul 2020 09:36:58 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23688 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727969AbgGXNg5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jul 2020 09:36:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595597815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/AwV8WBhuqPeelgBaxBkgLyMvJZx/53MPZJnj+q0yps=;
        b=YlEH4y2N0DiHPNALUyZb0Tn2NGvCKN5dOqg19ha23xitbdagqXLHWOHRvtQ7fG4DwHPLD/
        Y0ezqL7f9ZPrBJneF2mVOlyCHcIPfAunJBnPJmsbAAhKyTY6+R5xqls7ibufH0dYNmEdIv
        JXk+eiHS+aHfprbUU7h1UuefpbrZBGo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-xVUtadiBObi71rLlEvRplw-1; Fri, 24 Jul 2020 09:36:51 -0400
X-MC-Unique: xVUtadiBObi71rLlEvRplw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 596E01009443;
        Fri, 24 Jul 2020 13:36:49 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-32.rdu2.redhat.com [10.10.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 344BB70107;
        Fri, 24 Jul 2020 13:36:46 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 13/17] fsinfo: Add support to ext4 [ver #20]
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Eric Biggers <ebiggers@kernel.org>, linux-ext4@vger.kernel.org,
        dhowells@redhat.com, raven@themaw.net, mszeredi@redhat.com,
        christian@brauner.io, jannh@google.com, darrick.wong@oracle.com,
        kzak@redhat.com, jlayton@redhat.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 24 Jul 2020 14:36:45 +0100
Message-ID: <159559780541.2144584.10693606144623090740.stgit@warthog.procyon.org.uk>
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


