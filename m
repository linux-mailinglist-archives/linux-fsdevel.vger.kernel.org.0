Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFBD2CA18
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2019 17:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbfE1PO3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 May 2019 11:14:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49910 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbfE1PO3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 May 2019 11:14:29 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 79D2CC05D419;
        Tue, 28 May 2019 15:14:28 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-125-65.rdu2.redhat.com [10.10.125.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 232011133A5D;
        Tue, 28 May 2019 15:14:26 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 24/25] fsinfo: ufs - add sb operation fsinfo() [ver #13]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mszeredi@redhat.com
Date:   Tue, 28 May 2019 16:14:26 +0100
Message-ID: <155905646637.1662.2508556539065009207.stgit@warthog.procyon.org.uk>
In-Reply-To: <155905626142.1662.18430571708534506785.stgit@warthog.procyon.org.uk>
References: <155905626142.1662.18430571708534506785.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 28 May 2019 15:14:28 +0000 (UTC)
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

Signed-off-by: Ian Kent <raven@themaw.net>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/ufs/super.c |   57 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/fs/ufs/super.c b/fs/ufs/super.c
index 84c0c5178cd2..6395ce4da5e6 100644
--- a/fs/ufs/super.c
+++ b/fs/ufs/super.c
@@ -89,6 +89,7 @@
 #include <linux/mount.h>
 #include <linux/seq_file.h>
 #include <linux/iversion.h>
+#include <linux/fsinfo.h>
 
 #include "ufs_fs.h"
 #include "ufs.h"
@@ -1401,6 +1402,59 @@ static int ufs_show_options(struct seq_file *seq, struct dentry *root)
 	return 0;
 }
 
+#ifdef CONFIG_FSINFO
+static int ufs_fsinfo_print_token(struct fsinfo_kparams *params, const char *token)
+{
+	char *new, *key, *value;
+
+	new = kstrdup(token, GFP_KERNEL);
+	if (!new)
+		return -ENOMEM;
+
+	key = new;
+	value = strchr(new, '=');
+	if (value)
+		*value++ = '\0';
+
+	fsinfo_note_param(params, key, value);
+
+	kfree(new);
+	return 0;
+}
+
+/*
+ * Get filesystem information.
+ */
+static int ufs_fsinfo(struct path *path, struct fsinfo_kparams *params)
+{
+	struct ufs_sb_info *sbi = UFS_SB(path->dentry->d_sb);
+	unsigned mval = sbi->s_mount_opt & UFS_MOUNT_UFSTYPE;
+	const struct match_token *tp = tokens;
+	int ret;
+
+	switch (params->request) {
+	case FSINFO_ATTR_PARAMETERS:
+		while (tp->token != Opt_onerror_panic && tp->token != mval)
+			++tp;
+		BUG_ON(tp->token == Opt_onerror_panic);
+		ret = ufs_fsinfo_print_token(params, tp->pattern);
+		if (ret)
+			return ret;
+		mval = sbi->s_mount_opt & UFS_MOUNT_ONERROR;
+		while (tp->token != Opt_err && tp->token != mval)
+			++tp;
+		BUG_ON(tp->token == Opt_err);
+		ret = ufs_fsinfo_print_token(params, tp->pattern);
+		if (ret)
+			return ret;
+		return params->usage;
+
+	default:
+		return generic_fsinfo(path, params);
+	}
+}
+#endif /* CONFIG_FSINFO */
+
 static int ufs_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
 	struct super_block *sb = dentry->d_sb;
@@ -1496,6 +1550,9 @@ static const struct super_operations ufs_super_ops = {
 	.statfs		= ufs_statfs,
 	.remount_fs	= ufs_remount,
 	.show_options   = ufs_show_options,
+#ifdef CONFIG_FSINFO
+	.fsinfo		= ufs_fsinfo,
+#endif
 };
 
 static struct dentry *ufs_mount(struct file_system_type *fs_type,

