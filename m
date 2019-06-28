Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF9259F39
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2019 17:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfF1PpX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jun 2019 11:45:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60080 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726657AbfF1PpX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jun 2019 11:45:23 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A276A3086218;
        Fri, 28 Jun 2019 15:45:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-219.rdu2.redhat.com [10.10.120.219])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3CC31194A8;
        Fri, 28 Jun 2019 15:45:20 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 09/11] hugetlbfs: Add support for fsinfo() [ver #15]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net, mszeredi@redhat.com,
        christian@brauner.io, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 28 Jun 2019 16:45:19 +0100
Message-ID: <156173671951.14042.15341588711184593526.stgit@warthog.procyon.org.uk>
In-Reply-To: <156173661696.14042.17822154531324224780.stgit@warthog.procyon.org.uk>
References: <156173661696.14042.17822154531324224780.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Fri, 28 Jun 2019 15:45:22 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add support for fsinfo().

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/hugetlbfs/inode.c |   57 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 1dcc57189382..62d5d5dec447 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -28,6 +28,7 @@
 #include <linux/hugetlb.h>
 #include <linux/pagevec.h>
 #include <linux/fs_parser.h>
+#include <linux/fsinfo.h>
 #include <linux/mman.h>
 #include <linux/slab.h>
 #include <linux/dnotify.h>
@@ -958,6 +959,59 @@ static int hugetlbfs_show_options(struct seq_file *m, struct dentry *root)
 	return 0;
 }
 
+#ifdef CONFIG_FSINFO
+static int hugetlbfs_fsinfo(struct path *path, struct fsinfo_kparams *params)
+{
+	struct dentry *dentry = path->dentry;
+	struct hugetlbfs_sb_info *sbinfo = HUGETLBFS_SB(dentry->d_sb);
+	struct hugepage_subpool *spool = sbinfo->spool;
+	unsigned long hpage_size = huge_page_size(sbinfo->hstate);
+	unsigned hpage_shift = huge_page_shift(sbinfo->hstate);
+	char mod;
+
+	switch (params->request) {
+	case FSINFO_ATTR_PARAMETERS:
+		fsinfo_note_sb_params(params, dentry->d_sb->s_flags);
+		if (!uid_eq(sbinfo->uid, GLOBAL_ROOT_UID))
+			fsinfo_note_paramf(params, "uid", "%u",
+					   from_kuid_munged(&init_user_ns,
+							    sbinfo->uid));
+
+		if (!gid_eq(sbinfo->gid, GLOBAL_ROOT_GID))
+			fsinfo_note_paramf(params, "gid", "%u",
+					   from_kgid_munged(&init_user_ns,
+							    sbinfo->gid));
+
+		if (spool && spool->max_hpages != -1)
+			fsinfo_note_paramf(params, "size", "%llu",
+					   (unsigned long long)spool->max_hpages << hpage_shift);
+
+		if (spool && spool->min_hpages != -1)
+			fsinfo_note_paramf(params, "min_size", "%llu",
+					   (unsigned long long)spool->min_hpages << hpage_shift);
+
+		hpage_size /= 1024;
+		mod = 'K';
+		if (hpage_size >= 1024) {
+			hpage_size /= 1024;
+			mod = 'M';
+		}
+		fsinfo_note_paramf(params, "pagesize", "%lu%c", hpage_size, mod);
+
+		if (sbinfo->mode != 0755)
+			fsinfo_note_paramf(params, "mode", "%o", sbinfo->mode);
+
+		if (sbinfo->max_inodes != -1)
+			fsinfo_note_paramf(params, "nr_inodes", "%lu",
+					   sbinfo->max_inodes);
+		return params->usage;
+
+	default:
+		return generic_fsinfo(path, params);
+	}
+}
+#endif /* CONFIG_FSINFO */
+
 static int hugetlbfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
 	struct hugetlbfs_sb_info *sbinfo = HUGETLBFS_SB(dentry->d_sb);
@@ -1116,6 +1170,9 @@ static const struct super_operations hugetlbfs_ops = {
 	.statfs		= hugetlbfs_statfs,
 	.put_super	= hugetlbfs_put_super,
 	.show_options	= hugetlbfs_show_options,
+#ifdef CONFIG_FSINFO
+	.fsinfo		= hugetlbfs_fsinfo,
+#endif
 };
 
 /*

