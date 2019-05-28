Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E40CA2C9ED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2019 17:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbfE1PM4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 May 2019 11:12:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55666 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726826AbfE1PMz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 May 2019 11:12:55 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4EC423083394;
        Tue, 28 May 2019 15:12:55 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-125-65.rdu2.redhat.com [10.10.125.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C1179AFE55;
        Tue, 28 May 2019 15:12:53 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 13/25] fsinfo: Support SELinux superblock parameter
 retrieval [ver #13]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mszeredi@redhat.com
Date:   Tue, 28 May 2019 16:12:53 +0100
Message-ID: <155905637302.1662.8473297942541287404.stgit@warthog.procyon.org.uk>
In-Reply-To: <155905626142.1662.18430571708534506785.stgit@warthog.procyon.org.uk>
References: <155905626142.1662.18430571708534506785.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Tue, 28 May 2019 15:12:55 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add support to SELinux for retrieval of the superblock parameters by
fsinfo(FSINFO_ATTR_LSM_PARAMETERS).

Signed-off-by: David Howells <dhowells@redhat.com>
---

 security/selinux/hooks.c            |   41 +++++++++++++++++++++++++++++
 security/selinux/include/security.h |    2 +
 security/selinux/ss/services.c      |   49 +++++++++++++++++++++++++++++++++++
 3 files changed, 92 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index c61787b15f27..9b5dbdcde9e6 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -91,6 +91,7 @@
 #include <linux/bpf.h>
 #include <linux/kernfs.h>
 #include <linux/stringhash.h>	/* for hashlen_string() */
+#include <linux/fsinfo.h>
 #include <uapi/linux/mount.h>
 
 #include "avc.h"
@@ -2735,6 +2736,43 @@ static int selinux_sb_statfs(struct dentry *dentry)
 	return superblock_has_perm(cred, dentry->d_sb, FILESYSTEM__GETATTR, &ad);
 }
 
+#ifdef CONFIG_FSINFO
+/*
+ * Retrieve the SELinux filesystem information, including mount parameters.
+ */
+static int selinux_sb_fsinfo(struct path *path, struct fsinfo_kparams *params)
+{
+	struct superblock_security_struct *sbsec = path->dentry->d_sb->s_security;
+
+	switch (params->request) {
+	case FSINFO_ATTR_LSM_PARAMETERS:
+		if (!(sbsec->flags & SE_SBINITIALIZED) ||
+		    !selinux_state.initialized)
+			return params->usage;
+
+		if (sbsec->flags & FSCONTEXT_MNT)
+			fsinfo_note_sid(params, FSCONTEXT_STR, sbsec->sid);
+		if (sbsec->flags & CONTEXT_MNT)
+			fsinfo_note_sid(params, CONTEXT_STR, sbsec->mntpoint_sid);
+		if (sbsec->flags & DEFCONTEXT_MNT)
+			fsinfo_note_sid(params, DEFCONTEXT_STR, sbsec->def_sid);
+		if (sbsec->flags & ROOTCONTEXT_MNT) {
+			struct dentry *root = sbsec->sb->s_root;
+			struct inode_security_struct *isec = backing_inode_security(root);
+			fsinfo_note_sid(params, ROOTCONTEXT_STR, isec->sid);
+		}
+		if (sbsec->flags & SBLABEL_MNT)
+			fsinfo_note_param(params, SECLABEL_STR, NULL);
+
+		return params->usage;
+
+	default:
+		return -ENODATA;
+	}
+	return 0;
+}
+#endif
+
 static int selinux_mount(const char *dev_name,
 			 const struct path *path,
 			 const char *type,
@@ -6761,6 +6799,9 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(sb_kern_mount, selinux_sb_kern_mount),
 	LSM_HOOK_INIT(sb_show_options, selinux_sb_show_options),
 	LSM_HOOK_INIT(sb_statfs, selinux_sb_statfs),
+#ifdef CONFIG_FSINFO
+	LSM_HOOK_INIT(sb_fsinfo, selinux_sb_fsinfo),
+#endif
 	LSM_HOOK_INIT(sb_mount, selinux_mount),
 	LSM_HOOK_INIT(sb_umount, selinux_umount),
 	LSM_HOOK_INIT(sb_set_mnt_opts, selinux_set_mnt_opts),
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 111121281c47..e9617bfcc6ee 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -67,6 +67,7 @@
 #define SECLABEL_STR "seclabel"
 
 struct netlbl_lsm_secattr;
+struct fsinfo_kparams;
 
 extern int selinux_enabled;
 
@@ -258,6 +259,7 @@ int security_sid_to_context_force(struct selinux_state *state,
 
 int security_sid_to_context_inval(struct selinux_state *state,
 				  u32 sid, char **scontext, u32 *scontext_len);
+void fsinfo_note_sid(struct fsinfo_kparams *params, const char *key, u32 sid);
 
 int security_context_to_sid(struct selinux_state *state,
 			    const char *scontext, u32 scontext_len,
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index cc043bc8fd4c..1111b02a999b 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -50,6 +50,7 @@
 #include <linux/audit.h>
 #include <linux/mutex.h>
 #include <linux/vmalloc.h>
+#include <linux/fsinfo.h>
 #include <net/netlabel.h>
 
 #include "flask.h"
@@ -1374,6 +1375,54 @@ int security_sid_to_context_inval(struct selinux_state *state, u32 sid,
 					    scontext_len, 1, 1);
 }
 
+#ifdef CONFIG_FSINFO
+void fsinfo_note_sid(struct fsinfo_kparams *params, const char *key, u32 sid)
+{
+	struct selinux_state *state = &selinux_state;
+	struct policydb *policydb;
+	struct context *context;
+	const char *val = "<<<INVALID>>>";
+	char *p;
+	int n;
+
+	if (!state->initialized) {
+		if (sid <= SECINITSID_NUM) {
+			val = initial_sid_to_string[sid];
+			goto out;
+		}
+
+		pr_err("SELinux: %s:  called before initial "
+		       "load_policy on unknown SID %d\n", __func__, sid);
+		goto out;
+	}
+
+	read_lock(&state->ss->policy_rwlock);
+
+	policydb = &state->ss->policydb;
+	context = sidtab_search(state->ss->sidtab, sid);
+	if (!context) {
+		pr_err("SELinux: %s:  unrecognized SID %d\n", __func__, sid);
+	} else {
+		/* Copy the user name, role name and type name into the scratch
+		 * buffer and then tack on the MLS.
+		 */
+		val = p = params->scratch_buffer;
+		n = sprintf(p, "%s:%s:%s",
+			    sym_name(policydb, SYM_USERS, context->user - 1),
+			    sym_name(policydb, SYM_ROLES, context->role - 1),
+			    sym_name(policydb, SYM_TYPES, context->type - 1));
+
+		p += n;
+		mls_sid_to_context(policydb, context, &p);
+		*p = 0;
+	}
+
+	read_unlock(&state->ss->policy_rwlock);
+out:
+	fsinfo_note_param(params, key, val);
+}
+#endif
+
 /*
  * Caveat:  Mutates scontext.
  */

