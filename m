Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F03B52C9E9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2019 17:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfE1PMs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 May 2019 11:12:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48156 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726826AbfE1PMs (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 May 2019 11:12:48 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CC0B73019882;
        Tue, 28 May 2019 15:12:47 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-125-65.rdu2.redhat.com [10.10.125.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9093D5DDD9;
        Tue, 28 May 2019 15:12:42 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 12/25] kernfs, cgroup: Add fsinfo support [ver #13]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mszeredi@redhat.com
Date:   Tue, 28 May 2019 16:12:42 +0100
Message-ID: <155905636240.1662.16803705540477209176.stgit@warthog.procyon.org.uk>
In-Reply-To: <155905626142.1662.18430571708534506785.stgit@warthog.procyon.org.uk>
References: <155905626142.1662.18430571708534506785.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Tue, 28 May 2019 15:12:47 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add support for fsinfo() to kernfs and cgroup.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/kernfs/mount.c         |   20 ++++++++++++++++++++
 include/linux/kernfs.h    |    4 ++++
 kernel/cgroup/cgroup-v1.c |   44 ++++++++++++++++++++++++++++++++++++++++++++
 kernel/cgroup/cgroup.c    |   19 +++++++++++++++++++
 4 files changed, 87 insertions(+)

diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index 9a4646eecb71..f40d467d274b 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -17,6 +17,7 @@
 #include <linux/namei.h>
 #include <linux/seq_file.h>
 #include <linux/exportfs.h>
+#include <linux/fsinfo.h>
 
 #include "kernfs-internal.h"
 
@@ -45,6 +46,22 @@ static int kernfs_sop_show_path(struct seq_file *sf, struct dentry *dentry)
 	return 0;
 }
 
+#ifdef CONFIG_FSINFO
+static int kernfs_sop_fsinfo(struct path *path, struct fsinfo_kparams *params)
+{
+	struct kernfs_root *root = kernfs_root(kernfs_dentry_node(path->dentry));
+	struct kernfs_syscall_ops *scops = root->syscall_ops;
+	int ret;
+
+	if (scops && scops->fsinfo) {
+		ret = scops->fsinfo(root, params);
+		if (ret != -EAGAIN)
+			return ret;
+	}
+	return generic_fsinfo(path, params);
+}
+#endif
+
 const struct super_operations kernfs_sops = {
 	.statfs		= simple_statfs,
 	.drop_inode	= generic_delete_inode,
@@ -52,6 +69,9 @@ const struct super_operations kernfs_sops = {
 
 	.show_options	= kernfs_sop_show_options,
 	.show_path	= kernfs_sop_show_path,
+#ifdef CONFIG_FSINFO
+	.fsinfo		= kernfs_sop_fsinfo,
+#endif
 };
 
 /*
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 2bf477f86eb1..d01ec4dc2db1 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -27,6 +27,7 @@ struct super_block;
 struct file_system_type;
 struct poll_table_struct;
 struct fs_context;
+struct fsinfo_kparams;
 
 struct kernfs_fs_context;
 struct kernfs_open_node;
@@ -171,6 +172,9 @@ struct kernfs_node {
  */
 struct kernfs_syscall_ops {
 	int (*show_options)(struct seq_file *sf, struct kernfs_root *root);
+#ifdef CONFIG_FSINFO
+	int (*fsinfo)(struct kernfs_root *root, struct fsinfo_kparams *params);
+#endif
 
 	int (*mkdir)(struct kernfs_node *parent, const char *name,
 		     umode_t mode);
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 68ca5de7ec27..c8a85dfcac87 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -14,6 +14,7 @@
 #include <linux/pid_namespace.h>
 #include <linux/cgroupstats.h>
 #include <linux/fs_parser.h>
+#include <linux/fsinfo.h>
 
 #include <trace/events/cgroup.h>
 
@@ -921,6 +922,46 @@ const struct fs_parameter_description cgroup1_fs_parameters = {
 	.specs		= cgroup1_param_specs,
 };
 
+#ifdef CONFIG_FSINFO
+static int cgroup1_fsinfo(struct kernfs_root *kf_root, struct fsinfo_kparams *params)
+{
+	struct cgroup_root *root = cgroup_root_from_kf(kf_root);
+	struct cgroup_subsys *ss;
+	int ssid;
+
+	switch (params->request) {
+	case FSINFO_ATTR_PARAMETERS:
+		if (root->name[0])
+			fsinfo_note_param(params, "name", root->name);
+
+		if (test_bit(CGRP_CPUSET_CLONE_CHILDREN, &root->cgrp.flags))
+			fsinfo_note_param(params, "clone_children", NULL);
+		if (root->flags & CGRP_ROOT_CPUSET_V2_MODE)
+			fsinfo_note_param(params, "noprefix", NULL);
+		if (root->flags & CGRP_ROOT_NOPREFIX)
+			fsinfo_note_param(params, "noprefix", NULL);
+		if (root->flags & CGRP_ROOT_XATTR)
+			fsinfo_note_param(params, "xattr", NULL);
+
+		spin_lock(&release_agent_path_lock);
+		if (root->release_agent_path[0])
+			fsinfo_note_param(params, "release_agent",
+					  root->release_agent_path);
+		spin_unlock(&release_agent_path_lock);
+
+
+		for_each_subsys(ss, ssid) {
+			if (root->subsys_mask & (1 << ssid))
+				fsinfo_note_param(params, ss->legacy_name, NULL);
+		}
+		return params->usage;
+
+	default:
+		return -EAGAIN; /* Tell kernfs to call generic_fsinfo() */
+	}
+}
+#endif /* CONFIG_FSINFO */
+
 int cgroup1_parse_param(struct fs_context *fc, struct fs_parameter *param)
 {
 	struct cgroup_fs_context *ctx = cgroup_fc2context(fc);
@@ -1114,6 +1155,9 @@ int cgroup1_reconfigure(struct fs_context *fc)
 struct kernfs_syscall_ops cgroup1_kf_syscall_ops = {
 	.rename			= cgroup1_rename,
 	.show_options		= cgroup1_show_options,
+#ifdef CONFIG_FSINFO
+	.fsinfo			= cgroup1_fsinfo,
+#endif
 	.mkdir			= cgroup_mkdir,
 	.rmdir			= cgroup_rmdir,
 	.show_path		= cgroup_show_path,
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 4a0eb465d17e..7e32570905e9 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -55,6 +55,7 @@
 #include <linux/nsproxy.h>
 #include <linux/file.h>
 #include <linux/fs_parser.h>
+#include <linux/fsinfo.h>
 #include <linux/sched/cputime.h>
 #include <linux/psi.h>
 #include <net/sock.h>
@@ -1858,6 +1859,21 @@ static int cgroup_show_options(struct seq_file *seq, struct kernfs_root *kf_root
 	return 0;
 }
 
+#ifdef CONFIG_FSINFO
+static int cgroup_fsinfo(struct kernfs_root *kf_root, struct fsinfo_kparams *params)
+{
+	switch (params->request) {
+	case FSINFO_ATTR_PARAMETERS:
+		if (cgrp_dfl_root.flags & CGRP_ROOT_NS_DELEGATE)
+			fsinfo_note_param(params, "nsdelegate", NULL);
+		return params->usage;
+
+	default:
+		return -EAGAIN; /* Tell kernfs to call generic_fsinfo() */
+	}
+}
+#endif /* CONFIG_FSINFO */
+
 static int cgroup_reconfigure(struct fs_context *fc)
 {
 	struct cgroup_fs_context *ctx = cgroup_fc2context(fc);
@@ -5550,6 +5566,9 @@ int cgroup_rmdir(struct kernfs_node *kn)
 
 static struct kernfs_syscall_ops cgroup_kf_syscall_ops = {
 	.show_options		= cgroup_show_options,
+#ifdef CONFIG_FSINFO
+	.fsinfo			= cgroup_fsinfo,
+#endif
 	.mkdir			= cgroup_mkdir,
 	.rmdir			= cgroup_rmdir,
 	.show_path		= cgroup_show_path,

