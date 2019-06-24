Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 875D050D7C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 16:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbfFXOKv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 10:10:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53648 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727301AbfFXOKv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 10:10:51 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6104881F35;
        Mon, 24 Jun 2019 14:10:50 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-57.rdu2.redhat.com [10.10.120.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ED8011001DEF;
        Mon, 24 Jun 2019 14:10:48 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 13/25] hugetlbfs: Add support for fsinfo() [ver #14]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net, mszeredi@redhat.com,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 24 Jun 2019 15:10:43 +0100
Message-ID: <156138544306.25627.17156844240352443841.stgit@warthog.procyon.org.uk>
In-Reply-To: <156138532485.25627.7459410522109581052.stgit@warthog.procyon.org.uk>
References: <156138532485.25627.7459410522109581052.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Mon, 24 Jun 2019 14:10:50 +0000 (UTC)
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

