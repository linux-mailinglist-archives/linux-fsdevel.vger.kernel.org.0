Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F32ED50DA3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 16:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbfFXOM3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 10:12:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54544 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbfFXOM3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 10:12:29 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BB2CD3087946;
        Mon, 24 Jun 2019 14:12:28 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-57.rdu2.redhat.com [10.10.120.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 51D3A5C21F;
        Mon, 24 Jun 2019 14:12:26 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 25/25] fsinfo: ufs - add sb operation fsinfo() [ver #14]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net, mszeredi@redhat.com,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 24 Jun 2019 15:12:25 +0100
Message-ID: <156138554552.25627.15667264043714854814.stgit@warthog.procyon.org.uk>
In-Reply-To: <156138532485.25627.7459410522109581052.stgit@warthog.procyon.org.uk>
References: <156138532485.25627.7459410522109581052.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Mon, 24 Jun 2019 14:12:28 +0000 (UTC)
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

 fs/ufs/super.c |   58 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/fs/ufs/super.c b/fs/ufs/super.c
index 84c0c5178cd2..40a3e9db8ac7 100644
--- a/fs/ufs/super.c
+++ b/fs/ufs/super.c
@@ -89,6 +89,7 @@
 #include <linux/mount.h>
 #include <linux/seq_file.h>
 #include <linux/iversion.h>
+#include <linux/fsinfo.h>
 
 #include "ufs_fs.h"
 #include "ufs.h"
@@ -1401,6 +1402,60 @@ static int ufs_show_options(struct seq_file *seq, struct dentry *root)
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
+		fsinfo_note_sb_params(params, path->dentry->d_sb->s_flags);
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
@@ -1496,6 +1551,9 @@ static const struct super_operations ufs_super_ops = {
 	.statfs		= ufs_statfs,
 	.remount_fs	= ufs_remount,
 	.show_options   = ufs_show_options,
+#ifdef CONFIG_FSINFO
+	.fsinfo		= ufs_fsinfo,
+#endif
 };
 
 static struct dentry *ufs_mount(struct file_system_type *fs_type,

