Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42C012CA12
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2019 17:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbfE1POP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 May 2019 11:14:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42860 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726969AbfE1POO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 May 2019 11:14:14 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D103A307D942;
        Tue, 28 May 2019 15:14:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-125-65.rdu2.redhat.com [10.10.125.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7A959EE1B4;
        Tue, 28 May 2019 15:14:12 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 22/25] fsinfo: debugfs - add sb operation fsinfo() [ver #13]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mszeredi@redhat.com
Date:   Tue, 28 May 2019 16:14:11 +0100
Message-ID: <155905645172.1662.12893154635552209881.stgit@warthog.procyon.org.uk>
In-Reply-To: <155905626142.1662.18430571708534506785.stgit@warthog.procyon.org.uk>
References: <155905626142.1662.18430571708534506785.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Tue, 28 May 2019 15:14:13 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ian Kent <raven@themaw.net>

The new fsinfo() system call adds a new super block operation
->fsinfo() which is used by file systems to provide file
system specific information for fsinfo() requests.

The fsinfo() request FSINFO_ATTR_PARAMETERS provides the same
function as sb operation ->show_options() so it needs to be
implemented by any file system that provides ->show_options()
as a minimum.

Also add a simple FSINFO_ATTR_CAPABILITIES implementation.

Signed-off-by: Ian Kent <raven@themaw.net>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/debugfs/inode.c |   37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 24354ccdc968..74b499c964f3 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -24,6 +24,7 @@
 #include <linux/seq_file.h>
 #include <linux/magic.h>
 #include <linux/slab.h>
+#include <linux/fsinfo.h>
 
 #include "internal.h"
 
@@ -143,6 +144,39 @@ static int debugfs_show_options(struct seq_file *m, struct dentry *root)
 	return 0;
 }
 
+#ifdef CONFIG_FSINFO
+/*
+ * Get filesystem information.
+ */
+static int debugfs_fsinfo(struct path *path, struct fsinfo_kparams *params)
+{
+	struct debugfs_fs_info *fsi = path->dentry->d_sb->s_fs_info;
+	struct fsinfo_capabilities *caps;
+
+	switch (params->request) {
+	case FSINFO_ATTR_CAPABILITIES:
+		caps = params->buffer;
+		fsinfo_set_cap(caps, FSINFO_CAP_IS_KERNEL_FS);
+		fsinfo_set_cap(caps, FSINFO_CAP_NOT_PERSISTENT);
+		return sizeof(*caps);
+
+	case FSINFO_ATTR_PARAMETERS:
+		if (!uid_eq(fsi->uid, GLOBAL_ROOT_UID))
+			fsinfo_note_paramf(params, "uid", "%u",
+				   from_kuid_munged(&init_user_ns, fsi->uid));
+		if (!gid_eq(fsi->gid, GLOBAL_ROOT_GID))
+			fsinfo_note_paramf(params, "gid", "%u",
+				   from_kgid_munged(&init_user_ns, fsi->gid));
+		if (fsi->mode != DEBUGFS_DEFAULT_MODE)
+			fsinfo_note_paramf(params, "mode", "%o", fsi->mode);
+		return params->usage;
+
+	default:
+		return generic_fsinfo(path, params);
+	}
+}
+#endif /* CONFIG_FSINFO */
+
 static void debugfs_free_inode(struct inode *inode)
 {
 	if (S_ISLNK(inode->i_mode))
@@ -154,6 +188,9 @@ static const struct super_operations debugfs_super_operations = {
 	.statfs		= simple_statfs,
 	.show_options	= debugfs_show_options,
 	.free_inode	= debugfs_free_inode,
+#ifdef CONFIG_FSINFO
+	.fsinfo		= debugfs_fsinfo,
+#endif
 };
 
 static void debugfs_release_dentry(struct dentry *dentry)

