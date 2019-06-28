Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44E3059F40
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2019 17:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfF1Ppo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jun 2019 11:45:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46420 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726716AbfF1Ppo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jun 2019 11:45:44 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DB60B3092652;
        Fri, 28 Jun 2019 15:45:38 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-219.rdu2.redhat.com [10.10.120.219])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5DEAA5D704;
        Fri, 28 Jun 2019 15:45:36 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 11/11] fsinfo: proc - add sb operation fsinfo() [ver #15]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net, mszeredi@redhat.com,
        christian@brauner.io, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 28 Jun 2019 16:45:35 +0100
Message-ID: <156173673559.14042.17529988400865163194.stgit@warthog.procyon.org.uk>
In-Reply-To: <156173661696.14042.17822154531324224780.stgit@warthog.procyon.org.uk>
References: <156173661696.14042.17822154531324224780.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Fri, 28 Jun 2019 15:45:43 +0000 (UTC)
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

 fs/proc/inode.c |   37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index 5f8d215b3fd0..28c287aff6aa 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -24,6 +24,7 @@
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/mount.h>
+#include <linux/fsinfo.h>
 
 #include <linux/uaccess.h>
 
@@ -115,6 +116,39 @@ static int proc_show_options(struct seq_file *seq, struct dentry *root)
 	return 0;
 }
 
+#ifdef CONFIG_FSINFO
+/*
+ * Get filesystem information.
+ */
+static int proc_fsinfo(struct path *path, struct fsinfo_kparams *params)
+{
+	struct super_block *sb = path->dentry->d_sb;
+	struct pid_namespace *pid = sb->s_fs_info;
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
+		fsinfo_note_sb_params(params, sb->s_flags);
+		if (!gid_eq(pid->pid_gid, GLOBAL_ROOT_GID))
+			fsinfo_note_paramf(params, "gid", "%u",
+				from_kgid_munged(&init_user_ns, pid->pid_gid));
+		if (pid->hide_pid != HIDEPID_OFF)
+			fsinfo_note_paramf(params, "hidepid",
+					  "%u", pid->hide_pid);
+		return params->usage;
+
+	default:
+		return generic_fsinfo(path, params);
+	}
+}
+#endif /* CONFIG_FSINFO */
+
 const struct super_operations proc_sops = {
 	.alloc_inode	= proc_alloc_inode,
 	.free_inode	= proc_free_inode,
@@ -122,6 +156,9 @@ const struct super_operations proc_sops = {
 	.evict_inode	= proc_evict_inode,
 	.statfs		= simple_statfs,
 	.show_options	= proc_show_options,
+#ifdef CONFIG_FSINFO
+	.fsinfo		= proc_fsinfo,
+#endif
 };
 
 enum {BIAS = -1U<<31};

