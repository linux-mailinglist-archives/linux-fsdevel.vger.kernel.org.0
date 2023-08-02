Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9960976D42D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 18:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbjHBQug (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 12:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233179AbjHBQuS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 12:50:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B9A30D1;
        Wed,  2 Aug 2023 09:49:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25BC461924;
        Wed,  2 Aug 2023 16:49:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECAF6C433CB;
        Wed,  2 Aug 2023 16:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690994998;
        bh=8TDdoriMirQkbs+sSC9VzHqIztUiVMg3Kktox9rBgT4=;
        h=From:Date:Subject:To:Cc:From;
        b=a8+x7CVF3sWu9j5R5rqbCqUieawg4Qr4tmpg6Q88oHYPwnXWoMuqL65kBBVhq3BEY
         c8EH5ml8CrtJJF25vdbwiKbaXyXxCaL2F4UsIE3GPnqKYcnjil6Ees2usVVsKwKp08
         YOFBAJ7CudvmPWoEpmZ+OZxwagen4+ghQfpcQKnpDIOu9lO3VBsGCXXsgG8RzcHRxN
         b1yDjbQFpl6AGx8rVf3Gw4dDLjxh/a9Qjvp86NXy+xxaEL0SzX/aepWHS/SxZBO0mo
         6mQNoXCsdWBZe2Uuk3WR+KWSTJpb+pmS2NMb7WUORvgXUeb1BIQgmGWoY7qiLARe+V
         q3eb5zdz97+9Q==
From:   Jeff Layton <jlayton@kernel.org>
Date:   Wed, 02 Aug 2023 12:49:33 -0400
Subject: [PATCH v6] vfs, security: Fix automount superblock LSM init
 problem, preventing NFS sb sharing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230802-master-v6-1-45d48299168b@kernel.org>
X-B4-Tracking: v=1; b=H4sIAByJymQC/x3Myw6DIBCF4VcxrAsZphWwq75H0wXREUmjmIHeY
 nz3Epdf8p+ziUwcKYtrswmmd8wxLRXm1Ih+8ksgGYdqgYBncIBy9rkQywqEDsgNphM1XpnG+D2
 O7o/qkdMsy8Tkj7k2xoF1rbGtU9hZNIBKX7RtO40IWhsEixa1yiXEcvt4LlMKauXU/9KiEgf1e
 op9/wNokNpKsQAAAA==
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        David Howells <dhowells@redhat.com>,
        Scott Mayhew <smayhew@redhat.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=11586; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Y0txRBdmjz7yDLEswKP6N7utPuZsTScZ5wjuMSPYqJE=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBkyok049T0DHZRmmBtubznEDMlxtFtyYhKnXWM9
 SX+Mgwl1fOJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZMqJNAAKCRAADmhBGVaC
 Fcg2D/sH10RoA8oISlBvguOODhPLSAU16RhE21Czp7Q5jHf20erUf0bw3RdmtRTWLZEnTqVPfK5
 E74ZLh4xxWK3MKYZeLMtNKrnfHOe8AgW6W+qEmfOsKqNVxiGOzyNUou/Vffj2Y1wGv3gmiNcpUP
 LyLfvvc2ui7Ei8boCll5Kkf4KXUQXyAJ7ZWILH31yjwjd/tFeWT75r9qIgLIno+J2qHJ+6PG1gy
 qZCAplcBjsa5NmIA/b4HarUkhqa/9iI715LMqc65cV8oPBlKL/tCnwCrh9tHslygo51DvIsxOkW
 kVXiGIsQ4iAAAQfRx5YjK6OSgFiZpzH0THY+vIWKQjqCwmFcB7wtcXDNJT963NHSDom9TyLp09b
 pF96v7g5d/iNUw9fojnciqj6mJ9O2P1yH+HhmNsh0o16+NwJrzPFEEOG2lm//hjmijo5xnJqLju
 OhZrSfvcp4uZlKoYfkOMN4QHp11gXy1XhcW1Ff4A4xAegznId7U8FTP3T/PG9byBWOredAKWgK8
 0FVxT7IOBvwKscF1d8N433wZ5mTDZJRGkPWrQn0ebPZ2V89ciMT4Ndb1oiaGy8JCMBSq1bq/8yI
 GpnNmcIGiXoBi2MH6FifkWtVS5cC+XAmCsY5EOur+HTqK0XPLVogwdEGq16e7VBHDX/4dFR8eue
 W1pItWTmqrkR8JQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

When NFS superblocks are created by automounting, their LSM parameters
aren't set in the fs_context struct prior to sget_fc() being called,
leading to failure to match existing superblocks.

Fix this by adding a new LSM hook to load fc->security for submount
creation when alloc_fs_context() is creating the fs_context for it.

However, this uncovers a further bug: nfs_get_root() initialises the
superblock security manually by calling security_sb_set_mnt_opts() or
security_sb_clone_mnt_opts() - but then vfs_get_tree() calls
security_sb_set_mnt_opts(), which can lead to SELinux, at least,
complaining.

Fix that by adding a flag to the fs_context that suppresses the
security_sb_set_mnt_opts() call in vfs_get_tree().  This can be set by NFS
when it sets the LSM context on the new superblock.

The first bug leads to messages like the following appearing in dmesg:

	NFS: Cache volume key already in use (nfs,4.2,2,108,106a8c0,1,,,,100000,100000,2ee,3a98,1d4c,3a98,1)

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Fixes: 9bc61ab18b1d ("vfs: Introduce fs_context, switch vfs_kern_mount() to it.")
Fixes: 779df6a5480f ("NFS: Ensure security label is set for root inode)
Tested-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Acked-by: Casey Schaufler <casey@schaufler-ca.com>
Acked-by: "Christian Brauner (Microsoft)" <brauner@kernel.org>
Link: https://lore.kernel.org/r/165962680944.3334508.6610023900349142034.stgit@warthog.procyon.org.uk/ # v1
Link: https://lore.kernel.org/r/165962729225.3357250.14350728846471527137.stgit@warthog.procyon.org.uk/ # v2
Link: https://lore.kernel.org/r/165970659095.2812394.6868894171102318796.stgit@warthog.procyon.org.uk/ # v3
Link: https://lore.kernel.org/r/166133579016.3678898.6283195019480567275.stgit@warthog.procyon.org.uk/ # v4
Link: https://lore.kernel.org/r/217595.1662033775@warthog.procyon.org.uk/ # v5
---
This patch was originally sent by David several months ago, but it
never got merged. I'm resending to resurrect the discussion. Can we
get this fixed?

ver #6)
 - Rebase onto v6.5.0-rc4

ver #5)
 - Removed unused variable.
 - Only allocate smack_mnt_opts if we're dealing with a submount.

ver #4)
 - When doing a FOR_SUBMOUNT mount, don't set the root label in SELinux or
   Smack.

ver #3)
 - Made LSM parameter extraction dependent on fc->purpose ==
   FS_CONTEXT_FOR_SUBMOUNT.  Shouldn't happen on FOR_RECONFIGURE.

ver #2)
 - Added Smack support
 - Made LSM parameter extraction dependent on reference != NULL.
---
 fs/fs_context.c               |  4 ++++
 fs/nfs/getroot.c              |  1 +
 fs/super.c                    | 10 ++++----
 include/linux/fs_context.h    |  1 +
 include/linux/lsm_hook_defs.h |  1 +
 include/linux/security.h      |  6 +++++
 security/security.c           | 14 +++++++++++
 security/selinux/hooks.c      | 25 ++++++++++++++++++++
 security/smack/smack_lsm.c    | 54 +++++++++++++++++++++++++++++++++++++++++++
 9 files changed, 112 insertions(+), 4 deletions(-)

diff --git a/fs/fs_context.c b/fs/fs_context.c
index 851214d1d013..a523aea956c4 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -282,6 +282,10 @@ static struct fs_context *alloc_fs_context(struct file_system_type *fs_type,
 		break;
 	}
 
+	ret = security_fs_context_init(fc, reference);
+	if (ret < 0)
+		goto err_fc;
+
 	/* TODO: Make all filesystems support this unconditionally */
 	init_fs_context = fc->fs_type->init_fs_context;
 	if (!init_fs_context)
diff --git a/fs/nfs/getroot.c b/fs/nfs/getroot.c
index 11ff2b2e060f..651bffb0067e 100644
--- a/fs/nfs/getroot.c
+++ b/fs/nfs/getroot.c
@@ -144,6 +144,7 @@ int nfs_get_root(struct super_block *s, struct fs_context *fc)
 	}
 	if (error)
 		goto error_splat_root;
+	fc->lsm_set = true;
 	if (server->caps & NFS_CAP_SECURITY_LABEL &&
 		!(kflags_out & SECURITY_LSM_NATIVE_LABELS))
 		server->caps &= ~NFS_CAP_SECURITY_LABEL;
diff --git a/fs/super.c b/fs/super.c
index e781226e2880..13adf43e2e5d 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1541,10 +1541,12 @@ int vfs_get_tree(struct fs_context *fc)
 	smp_wmb();
 	sb->s_flags |= SB_BORN;
 
-	error = security_sb_set_mnt_opts(sb, fc->security, 0, NULL);
-	if (unlikely(error)) {
-		fc_drop_locked(fc);
-		return error;
+	if (!(fc->lsm_set)) {
+		error = security_sb_set_mnt_opts(sb, fc->security, 0, NULL);
+		if (unlikely(error)) {
+			fc_drop_locked(fc);
+			return error;
+		}
 	}
 
 	/*
diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
index ff6341e09925..26a9fcdb10cc 100644
--- a/include/linux/fs_context.h
+++ b/include/linux/fs_context.h
@@ -109,6 +109,7 @@ struct fs_context {
 	bool			need_free:1;	/* Need to call ops->free() */
 	bool			global:1;	/* Goes into &init_user_ns */
 	bool			oldapi:1;	/* Coming from mount(2) */
+	bool			lsm_set:1;	/* security_sb_set/clone_mnt_opts() already done */
 };
 
 struct fs_context_operations {
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 7308a1a7599b..7ce3550154b1 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -54,6 +54,7 @@ LSM_HOOK(int, 0, bprm_creds_from_file, struct linux_binprm *bprm, struct file *f
 LSM_HOOK(int, 0, bprm_check_security, struct linux_binprm *bprm)
 LSM_HOOK(void, LSM_RET_VOID, bprm_committing_creds, struct linux_binprm *bprm)
 LSM_HOOK(void, LSM_RET_VOID, bprm_committed_creds, struct linux_binprm *bprm)
+LSM_HOOK(int, 0, fs_context_init, struct fs_context *fc, struct dentry *reference)
 LSM_HOOK(int, 0, fs_context_dup, struct fs_context *fc,
 	 struct fs_context *src_sc)
 LSM_HOOK(int, -ENOPARAM, fs_context_parse_param, struct fs_context *fc,
diff --git a/include/linux/security.h b/include/linux/security.h
index 32828502f09e..61fda06fac9d 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -293,6 +293,7 @@ int security_bprm_creds_from_file(struct linux_binprm *bprm, struct file *file);
 int security_bprm_check(struct linux_binprm *bprm);
 void security_bprm_committing_creds(struct linux_binprm *bprm);
 void security_bprm_committed_creds(struct linux_binprm *bprm);
+int security_fs_context_init(struct fs_context *fc, struct dentry *reference);
 int security_fs_context_dup(struct fs_context *fc, struct fs_context *src_fc);
 int security_fs_context_parse_param(struct fs_context *fc, struct fs_parameter *param);
 int security_sb_alloc(struct super_block *sb);
@@ -629,6 +630,11 @@ static inline void security_bprm_committed_creds(struct linux_binprm *bprm)
 {
 }
 
+static inline int security_fs_context_init(struct fs_context *fc,
+					   struct dentry *reference)
+{
+	return 0;
+}
 static inline int security_fs_context_dup(struct fs_context *fc,
 					  struct fs_context *src_fc)
 {
diff --git a/security/security.c b/security/security.c
index b720424ca37d..8a6dc6f7cda0 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1138,6 +1138,20 @@ void security_bprm_committed_creds(struct linux_binprm *bprm)
 	call_void_hook(bprm_committed_creds, bprm);
 }
 
+/**
+ * security_fs_context_init() - Initialise fc->security
+ * @fc: new filesystem context
+ * @dentry: dentry reference for submount/remount
+ *
+ * Fill out the ->security field for a new fs_context.
+ *
+ * Return: Returns 0 on success or negative error code on failure.
+ */
+int security_fs_context_init(struct fs_context *fc, struct dentry *reference)
+{
+	return call_int_hook(fs_context_init, 0, fc, reference);
+}
+
 /**
  * security_fs_context_dup() - Duplicate a fs_context LSM blob
  * @fc: destination filesystem context
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index d06e350fedee..29cce0fadbeb 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2745,6 +2745,30 @@ static int selinux_umount(struct vfsmount *mnt, int flags)
 				   FILESYSTEM__UNMOUNT, NULL);
 }
 
+static int selinux_fs_context_init(struct fs_context *fc,
+				   struct dentry *reference)
+{
+	const struct superblock_security_struct *sbsec;
+	struct selinux_mnt_opts *opts;
+
+	if (fc->purpose == FS_CONTEXT_FOR_SUBMOUNT) {
+		opts = kzalloc(sizeof(*opts), GFP_KERNEL);
+		if (!opts)
+			return -ENOMEM;
+
+		sbsec = selinux_superblock(reference->d_sb);
+		if (sbsec->flags & FSCONTEXT_MNT)
+			opts->fscontext_sid	= sbsec->sid;
+		if (sbsec->flags & CONTEXT_MNT)
+			opts->context_sid	= sbsec->mntpoint_sid;
+		if (sbsec->flags & DEFCONTEXT_MNT)
+			opts->defcontext_sid	= sbsec->def_sid;
+		fc->security = opts;
+	}
+
+	return 0;
+}
+
 static int selinux_fs_context_dup(struct fs_context *fc,
 				  struct fs_context *src_fc)
 {
@@ -7182,6 +7206,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	/*
 	 * PUT "CLONING" (ACCESSING + ALLOCATING) HOOKS HERE
 	 */
+	LSM_HOOK_INIT(fs_context_init, selinux_fs_context_init),
 	LSM_HOOK_INIT(fs_context_dup, selinux_fs_context_dup),
 	LSM_HOOK_INIT(fs_context_parse_param, selinux_fs_context_parse_param),
 	LSM_HOOK_INIT(sb_eat_lsm_opts, selinux_sb_eat_lsm_opts),
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 6e270cf3fd30..938c8259c5e7 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -614,6 +614,59 @@ static int smack_add_opt(int token, const char *s, void **mnt_opts)
 	return -EINVAL;
 }
 
+/**
+ * smack_fs_context_init - Initialise security data for a filesystem context
+ * @fc: The filesystem context.
+ * @reference: Reference dentry (automount/reconfigure) or NULL
+ *
+ * Returns 0 on success or -ENOMEM on error.
+ */
+static int smack_fs_context_init(struct fs_context *fc,
+				 struct dentry *reference)
+{
+	struct superblock_smack *sbsp;
+	struct smack_mnt_opts *ctx;
+	struct inode_smack *isp;
+
+	if (fc->purpose == FS_CONTEXT_FOR_SUBMOUNT) {
+		ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+		if (!ctx)
+			return -ENOMEM;
+		fc->security = ctx;
+
+		sbsp = smack_superblock(reference->d_sb);
+		isp = smack_inode(reference->d_sb->s_root->d_inode);
+
+		if (sbsp->smk_default) {
+			ctx->fsdefault = kstrdup(sbsp->smk_default->smk_known, GFP_KERNEL);
+			if (!ctx->fsdefault)
+				return -ENOMEM;
+		}
+
+		if (sbsp->smk_floor) {
+			ctx->fsfloor = kstrdup(sbsp->smk_floor->smk_known, GFP_KERNEL);
+			if (!ctx->fsfloor)
+				return -ENOMEM;
+		}
+
+		if (sbsp->smk_hat) {
+			ctx->fshat = kstrdup(sbsp->smk_hat->smk_known, GFP_KERNEL);
+			if (!ctx->fshat)
+				return -ENOMEM;
+		}
+
+		if (isp->smk_flags & SMK_INODE_TRANSMUTE) {
+			if (sbsp->smk_root) {
+				ctx->fstransmute = kstrdup(sbsp->smk_root->smk_known, GFP_KERNEL);
+				if (!ctx->fstransmute)
+					return -ENOMEM;
+			}
+		}
+	}
+
+	return 0;
+}
+
 /**
  * smack_fs_context_dup - Duplicate the security data on fs_context duplication
  * @fc: The new filesystem context.
@@ -4876,6 +4929,7 @@ static struct security_hook_list smack_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(ptrace_traceme, smack_ptrace_traceme),
 	LSM_HOOK_INIT(syslog, smack_syslog),
 
+	LSM_HOOK_INIT(fs_context_init, smack_fs_context_init),
 	LSM_HOOK_INIT(fs_context_dup, smack_fs_context_dup),
 	LSM_HOOK_INIT(fs_context_parse_param, smack_fs_context_parse_param),
 

---
base-commit: 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4
change-id: 20230802-master-3082090e8d69

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>

