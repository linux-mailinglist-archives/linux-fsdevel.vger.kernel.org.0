Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBE5150D86
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 16:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbfFXOLU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 10:11:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:5055 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727315AbfFXOLU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 10:11:20 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3C5CA3082211;
        Mon, 24 Jun 2019 14:11:20 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-57.rdu2.redhat.com [10.10.120.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A4BF66085B;
        Mon, 24 Jun 2019 14:11:16 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 16/25] fsinfo: Support Smack superblock parameter retrieval
 [ver #14]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net, mszeredi@redhat.com,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 24 Jun 2019 15:11:14 +0100
Message-ID: <156138547413.25627.9827414528195932042.stgit@warthog.procyon.org.uk>
In-Reply-To: <156138532485.25627.7459410522109581052.stgit@warthog.procyon.org.uk>
References: <156138532485.25627.7459410522109581052.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Mon, 24 Jun 2019 14:11:20 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add support to Smack for retrieval of the superblock parameters.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 security/smack/smack_lsm.c |   43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 0de725f88bed..0a1e88d50ad3 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -45,6 +45,7 @@
 #include <linux/parser.h>
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
+#include <linux/fsinfo.h>
 #include "smack.h"
 
 #define TRANS_TRUE	"TRUE"
@@ -893,6 +894,45 @@ static int smack_sb_statfs(struct dentry *dentry)
 	return rc;
 }
 
+#ifdef CONFIG_FSINFO
+/*
+ * Retrieve the Smack filesystem information, including mount parameters.
+ */
+static int smack_sb_fsinfo(struct path *path, struct fsinfo_kparams *params)
+{
+	struct superblock_smack *sp = path->dentry->d_sb->s_security;
+
+	switch (params->request) {
+	case FSINFO_ATTR_LSM_PARAMETERS: {
+		struct dentry *root = path->dentry->d_sb->s_root;
+		struct inode *inode = d_backing_inode(root);
+		struct inode_smack *isp = inode->i_security;
+
+		if (sp->smk_flags & SMK_SB_INITIALIZED)
+			return 0;
+		if (sp->smk_floor)
+			fsinfo_note_param(params, "fsfloor", sp->smk_floor->smk_known);
+		if (sp->smk_hat)
+			fsinfo_note_param(params, "fshat", sp->smk_hat->smk_known);
+		if (sp->smk_default)
+			fsinfo_note_param(params, "fsdefault", sp->smk_default->smk_known);
+
+		if (sp->smk_root) {
+			if (isp && isp->smk_flags & SMK_INODE_TRANSMUTE)
+				fsinfo_note_param(params, "fstransmute", sp->smk_root->smk_known);
+			else
+				fsinfo_note_param(params, "fsroot", sp->smk_root->smk_known);
+		}
+		return params->usage;
+	}
+
+	default:
+		return -ENODATA;
+	}
+	return 0;
+}
+#endif
+
 /*
  * BPRM hooks
  */
@@ -4606,6 +4646,9 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(sb_free_mnt_opts, smack_free_mnt_opts),
 	LSM_HOOK_INIT(sb_eat_lsm_opts, smack_sb_eat_lsm_opts),
 	LSM_HOOK_INIT(sb_statfs, smack_sb_statfs),
+#ifdef CONFIG_FSINFO
+	LSM_HOOK_INIT(sb_fsinfo, smack_sb_fsinfo),
+#endif
 	LSM_HOOK_INIT(sb_set_mnt_opts, smack_set_mnt_opts),
 
 	LSM_HOOK_INIT(bprm_set_creds, smack_bprm_set_creds),

