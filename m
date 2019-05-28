Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C726D2C9FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2019 17:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbfE1PNf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 May 2019 11:13:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50126 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726826AbfE1PNf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 May 2019 11:13:35 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AD78330C319A;
        Tue, 28 May 2019 15:13:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-125-65.rdu2.redhat.com [10.10.125.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 334277FD20;
        Tue, 28 May 2019 15:13:32 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 17/25] fsinfo: autofs - add sb operation fsinfo() [ver #13]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mszeredi@redhat.com
Date:   Tue, 28 May 2019 16:13:31 +0100
Message-ID: <155905641144.1662.13767023676855295385.stgit@warthog.procyon.org.uk>
In-Reply-To: <155905626142.1662.18430571708534506785.stgit@warthog.procyon.org.uk>
References: <155905626142.1662.18430571708534506785.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Tue, 28 May 2019 15:13:34 +0000 (UTC)
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

 fs/autofs/inode.c |   63 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
index 58457ec0ab27..bd9126d8c541 100644
--- a/fs/autofs/inode.c
+++ b/fs/autofs/inode.c
@@ -11,6 +11,7 @@
 #include <linux/pagemap.h>
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
+#include <linux/fsinfo.h>
 
 #include "autofs_i.h"
 
@@ -101,6 +102,65 @@ static int autofs_show_options(struct seq_file *m, struct dentry *root)
 	return 0;
 }
 
+#ifdef CONFIG_FSINFO
+/*
+ * Get filesystem information.
+ */
+static int autofs_fsinfo(struct path *path, struct fsinfo_kparams *params)
+{
+	struct autofs_sb_info *sbi = autofs_sbi(path->dentry->d_sb);
+	struct inode *inode = d_inode(path->dentry->d_sb->s_root);
+	struct fsinfo_capabilities *caps;
+
+	switch (params->request) {
+	case FSINFO_ATTR_CAPABILITIES:
+		caps = params->buffer;
+		fsinfo_set_cap(caps, FSINFO_CAP_IS_AUTOMOUNTER_FS);
+		fsinfo_set_cap(caps, FSINFO_CAP_AUTOMOUNTS);
+		fsinfo_set_cap(caps, FSINFO_CAP_NOT_PERSISTENT);
+		return sizeof(*caps);
+
+	case FSINFO_ATTR_PARAMETERS:
+		fsinfo_note_paramf(params, "fd", "%d", sbi->pipefd);
+		if (!uid_eq(inode->i_uid, GLOBAL_ROOT_UID))
+			fsinfo_note_paramf(params, "uid", "%u",
+				from_kuid_munged(&init_user_ns, inode->i_uid));
+		if (!gid_eq(inode->i_gid, GLOBAL_ROOT_GID))
+			fsinfo_note_paramf(params, "gid", "%u",
+				from_kgid_munged(&init_user_ns, inode->i_gid));
+		fsinfo_note_paramf(params, "pgrp", "%d",
+				   pid_vnr(sbi->oz_pgrp));
+		fsinfo_note_paramf(params, "timeout", "%lu",
+				   sbi->exp_timeout/HZ);
+		fsinfo_note_paramf(params, "minproto", "%d",
+				   sbi->min_proto);
+		fsinfo_note_paramf(params, "maxproto", "%d",
+				   sbi->max_proto);
+		if (autofs_type_offset(sbi->type))
+			fsinfo_note_param(params, "offset", NULL);
+		else if (autofs_type_direct(sbi->type))
+			fsinfo_note_param(params, "direct", NULL);
+		else
+			fsinfo_note_param(params, "indirect", NULL);
+		if (sbi->flags & AUTOFS_SBI_STRICTEXPIRE)
+			fsinfo_note_param(params, "strictexpire", NULL);
+		if (sbi->flags & AUTOFS_SBI_IGNORE)
+			fsinfo_note_param(params, "ignore", NULL);
+#ifdef CONFIG_CHECKPOINT_RESTORE
+		if (sbi->pipe)
+			fsinfo_note_paramf(params, "pipe_ino",
+					  "%ld", file_inode(sbi->pipe)->i_ino);
+		else
+			fsinfo_note_param(params, "pipe_ino", "-1");
+#endif
+		return params->usage;
+
+	default:
+		return generic_fsinfo(path, params);
+	}
+}
+#endif /* CONFIG_FSINFO */
+
 static void autofs_evict_inode(struct inode *inode)
 {
 	clear_inode(inode);
@@ -111,6 +171,9 @@ static const struct super_operations autofs_sops = {
 	.statfs		= simple_statfs,
 	.show_options	= autofs_show_options,
 	.evict_inode	= autofs_evict_inode,
+#ifdef CONFIG_FSINFO
+	.fsinfo		= autofs_fsinfo,
+#endif
 };
 
 struct autofs_fs_context {

