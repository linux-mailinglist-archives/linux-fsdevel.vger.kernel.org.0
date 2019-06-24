Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF12650D96
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 16:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbfFXOL5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 10:11:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54544 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726891AbfFXOL5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 10:11:57 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E61696EB81;
        Mon, 24 Jun 2019 14:11:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-57.rdu2.redhat.com [10.10.120.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 96E3619C6A;
        Mon, 24 Jun 2019 14:11:55 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 21/25] fsinfo: devpts - add sb operation fsinfo() [ver #14]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net, mszeredi@redhat.com,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 24 Jun 2019 15:11:54 +0100
Message-ID: <156138551486.25627.9996141646216300722.stgit@warthog.procyon.org.uk>
In-Reply-To: <156138532485.25627.7459410522109581052.stgit@warthog.procyon.org.uk>
References: <156138532485.25627.7459410522109581052.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Mon, 24 Jun 2019 14:11:57 +0000 (UTC)
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

 fs/devpts/inode.c |   43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
index 3aa73a2ec2f1..6f0eb69f7cbb 100644
--- a/fs/devpts/inode.c
+++ b/fs/devpts/inode.c
@@ -28,6 +28,7 @@
 #include <linux/devpts_fs.h>
 #include <linux/fsnotify.h>
 #include <linux/seq_file.h>
+#include <linux/fsinfo.h>
 
 #define DEVPTS_DEFAULT_MODE 0600
 /*
@@ -401,9 +402,51 @@ static int devpts_show_options(struct seq_file *seq, struct dentry *root)
 	return 0;
 }
 
+#ifdef CONFIG_FSINFO
+/*
+ * Get filesystem information.
+ */
+static int devpts_fsinfo(struct path *path, struct fsinfo_kparams *params)
+{
+	struct pts_fs_info *fsi = DEVPTS_SB(path->dentry->d_sb);
+	struct pts_mount_opts *opts = &fsi->mount_opts;
+	struct fsinfo_capabilities *caps;
+
+	switch (params->request) {
+	case FSINFO_ATTR_CAPABILITIES:
+		caps = params->buffer;
+		fsinfo_set_cap(caps, FSINFO_CAP_IS_KERNEL_FS);
+		fsinfo_set_cap(caps, FSINFO_CAP_NOT_PERSISTENT);
+		fsinfo_set_cap(caps, FSINFO_CAP_UIDS);
+		fsinfo_set_cap(caps, FSINFO_CAP_GIDS);
+		return sizeof(*caps);
+
+	case FSINFO_ATTR_PARAMETERS:
+		fsinfo_note_sb_params(params, path->dentry->d_sb->s_flags);
+		if (opts->setuid)
+			fsinfo_note_paramf(params, "uid", "%u",
+				from_kuid_munged(&init_user_ns, opts->uid));
+		if (opts->setgid)
+			fsinfo_note_paramf(params, "gid", "%u",
+				from_kgid_munged(&init_user_ns, opts->gid));
+		fsinfo_note_paramf(params, "mode", "%03o", opts->mode);
+		fsinfo_note_paramf(params, "ptmxmode", "%03o", opts->ptmxmode);
+		if (opts->max < NR_UNIX98_PTY_MAX)
+			fsinfo_note_paramf(params, "max", "%d", opts->max);
+		return params->usage;
+
+	default:
+		return generic_fsinfo(path, params);
+	}
+}
+#endif /* CONFIG_FSINFO */
+
 static const struct super_operations devpts_sops = {
 	.statfs		= simple_statfs,
 	.show_options	= devpts_show_options,
+#ifdef CONFIG_FSINFO
+	.fsinfo		= devpts_fsinfo,
+#endif
 };
 
 static int devpts_fill_super(struct super_block *s, struct fs_context *fc)

