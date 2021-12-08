Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B42F46DAFF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Dec 2021 19:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238864AbhLHS2t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Dec 2021 13:28:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:28936 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238851AbhLHS2s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Dec 2021 13:28:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638987916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=SYASKSc4xinWGQyTbDXYJVnC+zP6uiTfnZMCX9JDxjs=;
        b=cpPShlSCFO72GNowf19Bl+lJUdesCtc6+D+oe6HkAk/x3SCfqFr/bJ6PlW75vd5BLASO/p
        G/5iP37r0hDmMLttI8Hav1GTHYekko1a5YUk6kv2vlaJoBIab/s+f0QhmHchbo/mDBO0K1
        4fI/9EIfayC5TcpCzmyYiSufqfZwRCU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-25-8Vhn9exJOuaZPS1mGo5Qvg-1; Wed, 08 Dec 2021 13:25:12 -0500
X-MC-Unique: 8Vhn9exJOuaZPS1mGo5Qvg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6687C1927802;
        Wed,  8 Dec 2021 18:25:10 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B585B196E2;
        Wed,  8 Dec 2021 18:24:50 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 1/2] security: Remove security_add_mnt_opt() as it's
 unused
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk, paul@paul-moore.com,
        Anna.Schumaker@Netapp.com, kolga@netapp.com
Cc:     dhowells@redhat.com, casey@schaufler-ca.com,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 08 Dec 2021 18:24:49 +0000
Message-ID: <163898788970.2840238.15026995173472005588.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove the add_mnt_opt LSM hook as it's not actually used.  This makes it
easier to make the context pointers in selinux_mnt_opts non-const.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Alexander Viro <viro@zeniv.linux.org.uk>
cc: Paul Moore <paul@paul-moore.com>
cc: Casey Schaufler <casey@schaufler-ca.com>
cc: selinux@vger.kernel.org
cc: linux-security-module@vger.kernel.org
cc: linux-nfs@vger.kernel.org
cc: linux-cachefs@redhat.com
---

 include/linux/lsm_hook_defs.h |    2 --
 include/linux/lsm_hooks.h     |    2 --
 include/linux/security.h      |    8 --------
 security/security.c           |    8 --------
 security/selinux/hooks.c      |   39 ---------------------------------------
 5 files changed, 59 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index df8de62f4710..7f5c35d72082 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -78,8 +78,6 @@ LSM_HOOK(int, 0, sb_set_mnt_opts, struct super_block *sb, void *mnt_opts,
 LSM_HOOK(int, 0, sb_clone_mnt_opts, const struct super_block *oldsb,
 	 struct super_block *newsb, unsigned long kern_flags,
 	 unsigned long *set_kern_flags)
-LSM_HOOK(int, 0, sb_add_mnt_opt, const char *option, const char *val,
-	 int len, void **mnt_opts)
 LSM_HOOK(int, 0, move_mount, const struct path *from_path,
 	 const struct path *to_path)
 LSM_HOOK(int, 0, dentry_init_security, struct dentry *dentry,
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index d45b6f6e27fd..73cb0ab2bc03 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -180,8 +180,6 @@
  *	Copy all security options from a given superblock to another
  *	@oldsb old superblock which contain information to clone
  *	@newsb new superblock which needs filled in
- * @sb_add_mnt_opt:
- * 	Add one mount @option to @mnt_opts.
  * @sb_parse_opts_str:
  *	Parse a string of security data filling in the opts structure
  *	@options string containing all mount options known by the LSM
diff --git a/include/linux/security.h b/include/linux/security.h
index bbf44a466832..a4f0c421dd0c 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -313,8 +313,6 @@ int security_sb_clone_mnt_opts(const struct super_block *oldsb,
 				struct super_block *newsb,
 				unsigned long kern_flags,
 				unsigned long *set_kern_flags);
-int security_add_mnt_opt(const char *option, const char *val,
-				int len, void **mnt_opts);
 int security_move_mount(const struct path *from_path, const struct path *to_path);
 int security_dentry_init_security(struct dentry *dentry, int mode,
 				  const struct qstr *name,
@@ -711,12 +709,6 @@ static inline int security_sb_clone_mnt_opts(const struct super_block *oldsb,
 	return 0;
 }
 
-static inline int security_add_mnt_opt(const char *option, const char *val,
-					int len, void **mnt_opts)
-{
-	return 0;
-}
-
 static inline int security_move_mount(const struct path *from_path,
 				      const struct path *to_path)
 {
diff --git a/security/security.c b/security/security.c
index c88167a414b4..0c49a1f05ac4 100644
--- a/security/security.c
+++ b/security/security.c
@@ -994,14 +994,6 @@ int security_sb_clone_mnt_opts(const struct super_block *oldsb,
 }
 EXPORT_SYMBOL(security_sb_clone_mnt_opts);
 
-int security_add_mnt_opt(const char *option, const char *val, int len,
-			 void **mnt_opts)
-{
-	return call_int_hook(sb_add_mnt_opt, -EINVAL,
-					option, val, len, mnt_opts);
-}
-EXPORT_SYMBOL(security_add_mnt_opt);
-
 int security_move_mount(const struct path *from_path, const struct path *to_path)
 {
 	return call_int_hook(move_mount, 0, from_path, to_path);
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 62d30c0a30c2..8ea92f08e6bd 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1023,44 +1023,6 @@ static int selinux_add_opt(int token, const char *s, void **mnt_opts)
 	return -EINVAL;
 }
 
-static int selinux_add_mnt_opt(const char *option, const char *val, int len,
-			       void **mnt_opts)
-{
-	int token = Opt_error;
-	int rc, i;
-
-	for (i = 0; i < ARRAY_SIZE(tokens); i++) {
-		if (strcmp(option, tokens[i].name) == 0) {
-			token = tokens[i].opt;
-			break;
-		}
-	}
-
-	if (token == Opt_error)
-		return -EINVAL;
-
-	if (token != Opt_seclabel) {
-		val = kmemdup_nul(val, len, GFP_KERNEL);
-		if (!val) {
-			rc = -ENOMEM;
-			goto free_opt;
-		}
-	}
-	rc = selinux_add_opt(token, val, mnt_opts);
-	if (unlikely(rc)) {
-		kfree(val);
-		goto free_opt;
-	}
-	return rc;
-
-free_opt:
-	if (*mnt_opts) {
-		selinux_free_mnt_opts(*mnt_opts);
-		*mnt_opts = NULL;
-	}
-	return rc;
-}
-
 static int show_sid(struct seq_file *m, u32 sid)
 {
 	char *context = NULL;
@@ -7298,7 +7260,6 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(fs_context_dup, selinux_fs_context_dup),
 	LSM_HOOK_INIT(fs_context_parse_param, selinux_fs_context_parse_param),
 	LSM_HOOK_INIT(sb_eat_lsm_opts, selinux_sb_eat_lsm_opts),
-	LSM_HOOK_INIT(sb_add_mnt_opt, selinux_add_mnt_opt),
 #ifdef CONFIG_SECURITY_NETWORK_XFRM
 	LSM_HOOK_INIT(xfrm_policy_clone_security, selinux_xfrm_policy_clone),
 #endif


