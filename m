Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6388550D91
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 16:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbfFXOLu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 10:11:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54430 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726934AbfFXOLu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 10:11:50 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A36D981DF2;
        Mon, 24 Jun 2019 14:11:49 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-57.rdu2.redhat.com [10.10.120.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4084A600CD;
        Mon, 24 Jun 2019 14:11:48 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 20/25] fsinfo: shmem - add tmpfs sb operation fsinfo() [ver
 #14]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net, mszeredi@redhat.com,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 24 Jun 2019 15:11:47 +0100
Message-ID: <156138550754.25627.3434495073988452560.stgit@warthog.procyon.org.uk>
In-Reply-To: <156138532485.25627.7459410522109581052.stgit@warthog.procyon.org.uk>
References: <156138532485.25627.7459410522109581052.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Mon, 24 Jun 2019 14:11:49 +0000 (UTC)
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

 mm/shmem.c |   72 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index 38a77ee13db1..1a660ca7042f 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -39,6 +39,7 @@
 #include <linux/frontswap.h>
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
+#include <linux/fsinfo.h>
 
 #include <asm/tlbflush.h> /* for arch/microblaze update_mmu_cache() */
 
@@ -1403,6 +1404,20 @@ static void shmem_show_mpol(struct seq_file *seq, struct mempolicy *mpol)
 	seq_printf(seq, ",mpol=%s", buffer);
 }
 
+#ifdef CONFIG_FSINFO
+static void shmem_fsinfo_mpol(struct fsinfo_kparams *params, struct mempolicy *mpol)
+{
+	char buffer[64];
+
+	if (!mpol || mpol->mode == MPOL_DEFAULT)
+		return;		/* show nothing */
+
+	mpol_to_str(buffer, sizeof(buffer), mpol);
+
+	fsinfo_note_paramf(params, "mpol", "%s", buffer);
+}
+#endif
+
 static struct mempolicy *shmem_get_sbmpol(struct shmem_sb_info *sbinfo)
 {
 	struct mempolicy *mpol = NULL;
@@ -1418,6 +1433,11 @@ static struct mempolicy *shmem_get_sbmpol(struct shmem_sb_info *sbinfo)
 static inline void shmem_show_mpol(struct seq_file *seq, struct mempolicy *mpol)
 {
 }
+#ifdef CONFIG_FSINFO
+static void shmem_fsinfo_mpol(struct fsinfo_kparams *params, struct mempolicy *mpol)
+{
+}
+#endif
 static inline struct mempolicy *shmem_get_sbmpol(struct shmem_sb_info *sbinfo)
 {
 	return NULL;
@@ -3478,7 +3498,9 @@ static int shmem_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	struct shmem_fs_context *ctx = fc->fs_private;
 	struct fs_parse_result result;
 	unsigned long long size;
+#ifdef CONFIG_NUMA
 	struct mempolicy *mpol;
+#endif
 	char *rest;
 	int opt;
 
@@ -3623,6 +3645,53 @@ static int shmem_show_options(struct seq_file *seq, struct dentry *root)
 	return 0;
 }
 
+#ifdef CONFIG_FSINFO
+static int shmem_fsinfo(struct path *path, struct fsinfo_kparams *params)
+{
+	struct shmem_sb_info *sbinfo = SHMEM_SB(path->dentry->d_sb);
+	struct fsinfo_capabilities *caps;
+
+	switch (params->request) {
+	case FSINFO_ATTR_CAPABILITIES:
+		caps = params->buffer;
+		fsinfo_set_unix_caps(caps);
+		fsinfo_set_cap(caps, FSINFO_CAP_IS_MEMORY_FS);
+		fsinfo_set_cap(caps, FSINFO_CAP_NOT_PERSISTENT);
+#ifdef CONFIG_TMPFS_XATTR
+		fsinfo_set_cap(caps, FSINFO_CAP_XATTRS);
+#endif
+		return sizeof(*caps);
+
+	case FSINFO_ATTR_PARAMETERS:
+		fsinfo_note_sb_params(params, path->dentry->d_sb->s_flags);
+		if (sbinfo->max_blocks != shmem_default_max_blocks())
+			fsinfo_note_paramf(params, "size", "%luk",
+				sbinfo->max_blocks << (PAGE_SHIFT - 10));
+		if (sbinfo->max_inodes != shmem_default_max_inodes())
+			fsinfo_note_paramf(params, "nr_inodes",
+					  "%lu", sbinfo->max_inodes);
+		if (sbinfo->mode != (0777 | S_ISVTX))
+			fsinfo_note_paramf(params, "mode",
+					  "%03ho", sbinfo->mode);
+		if (!uid_eq(sbinfo->uid, GLOBAL_ROOT_UID))
+			fsinfo_note_paramf(params, "uid", "%u",
+				from_kuid_munged(&init_user_ns, sbinfo->uid));
+		if (!gid_eq(sbinfo->gid, GLOBAL_ROOT_GID))
+			fsinfo_note_paramf(params, "gid", "%u",
+				from_kgid_munged(&init_user_ns, sbinfo->gid));
+#ifdef CONFIG_TRANSPARENT_HUGE_PAGECACHE
+		/* Rightly or wrongly, show huge mount option unmasked by shmem_huge */
+		if (sbinfo->huge)
+			fsinfo_note_paramf(params, "huge", "%s",
+					shmem_format_huge(sbinfo->huge));
+#endif
+		shmem_fsinfo_mpol(params, sbinfo->mpol);
+		return params->usage;
+	default:
+		return generic_fsinfo(path, params);
+	}
+}
+#endif /* CONFIG_FSINFO */
 #endif /* CONFIG_TMPFS */
 
 static void shmem_put_super(struct super_block *sb)
@@ -3854,6 +3923,9 @@ static const struct super_operations shmem_ops = {
 #ifdef CONFIG_TMPFS
 	.statfs		= shmem_statfs,
 	.show_options	= shmem_show_options,
+#ifdef CONFIG_FSINFO
+	.fsinfo		= shmem_fsinfo,
+#endif
 #endif
 	.evict_inode	= shmem_evict_inode,
 	.drop_inode	= generic_delete_inode,

