Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 151462CA00
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2019 17:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbfE1PNp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 May 2019 11:13:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49544 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbfE1PNp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 May 2019 11:13:45 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7E84DC0AD2A7;
        Tue, 28 May 2019 15:13:44 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-125-65.rdu2.redhat.com [10.10.125.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1A462D1A58;
        Tue, 28 May 2019 15:13:40 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 18/25] fsinfo: shmem - add tmpfs sb operation fsinfo() [ver
 #13]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mszeredi@redhat.com
Date:   Tue, 28 May 2019 16:13:39 +0100
Message-ID: <155905641991.1662.12764923887239561581.stgit@warthog.procyon.org.uk>
In-Reply-To: <155905626142.1662.18430571708534506785.stgit@warthog.procyon.org.uk>
References: <155905626142.1662.18430571708534506785.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 28 May 2019 15:13:44 +0000 (UTC)
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

 mm/shmem.c |   71 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index 38a77ee13db1..493d3c84e13b 100644
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
 
@@ -3623,6 +3645,52 @@ static int shmem_show_options(struct seq_file *seq, struct dentry *root)
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
@@ -3854,6 +3922,9 @@ static const struct super_operations shmem_ops = {
 #ifdef CONFIG_TMPFS
 	.statfs		= shmem_statfs,
 	.show_options	= shmem_show_options,
+#ifdef CONFIG_FSINFO
+	.fsinfo		= shmem_fsinfo,
+#endif
 #endif
 	.evict_inode	= shmem_evict_inode,
 	.drop_inode	= generic_delete_inode,

