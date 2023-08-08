Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE487742A2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 19:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjHHRrN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Aug 2023 13:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234894AbjHHRpu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:45:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332EC25EC5;
        Tue,  8 Aug 2023 09:20:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C26AF624E4;
        Tue,  8 Aug 2023 11:34:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DE6DC433C7;
        Tue,  8 Aug 2023 11:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691494466;
        bh=jT5jlcg2gdDwL4+StPeX7zJK5A+Ru5LuAg/g9n75i/U=;
        h=From:Date:Subject:To:Cc:From;
        b=GCIxZSgjsOIaicABBTDeZGuDdV5hQUKX9WKXki8rIZ2oOo1WCeeH4bn0bPjurTu/Z
         lWJHsWGHCPYTXPBcWhM409AG7ECGlko/ZCtGEhXngpuHAhezkbWBWQNpJPRHx/qoh9
         kDDaw9aEn/t1lRhS13+u2Eq56Yt4FEE88ghA/ScjJ2OY2hUppYMPcvMrvguFcBMFWH
         ZdIiJgpBgjl92H0dPeOQBEi2l4qoA0EOoC/kkeez1MS0wYWdr+9+0UKs31km08ixN2
         BE25hX3+uHywV1HHJZ1aEPnJnJBTVbXpnrU1hzpGHejc9BflzsqdUDYPejmD55IGUj
         GlGKZTn/skjLA==
From:   Jeff Layton <jlayton@kernel.org>
Date:   Tue, 08 Aug 2023 07:34:20 -0400
Subject: [PATCH v9] vfs, security: Fix automount superblock LSM init
 problem, preventing NFS sb sharing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230808-master-v9-1-e0ecde888221@kernel.org>
X-B4-Tracking: v=1; b=H4sIADso0mQC/2XOTU7DMBAF4KtUXmPLHvwzZtV7IBahmSZWaVyNT
 aCqcnecLKqiLp8035t3E4U4URFvu5tgmlNJeWohvuzEYeymgWTqWxag4VWjBnnuSiWWLYCOmrD
 3UbTjC9Mx/W5F7x8tHzmfZR2Zuo0b71EHdD44VBADeA3KWBNcNADaGA86QACjSh1S3f90XMc8q
 AvnwzVPKvOgvk/rozGVmvm6DZ79+u5p2+ylkdb1FiFG4/FzfyKe6GttEeu4OTw6e3ehucbIom1
 rIj45fHTh7nB1lsBGF93R6H9uWZY/EOnj7GYBAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10673; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=3wamLJ1ZUQ6bMvCdgxc+3ktMYaNUWu2MFno2+xMRdvo=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBk0ihAaM4Cy7BUOnhJtMipuA2vB7LDwWtdMTodb
 37CD1VGBc+JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZNIoQAAKCRAADmhBGVaC
 FQ1YEADA9hlu16r8PP9DIZ3lEGF9ETvCSNiHCkPXJxZcUCSa//dXqUHxieB1GeICxj0UVq4N1x5
 BmcuJQHQfFwqNVEiYT8ynuaHIQp7ufEemlGjr4xRtFg0lLZ295tdj5kcwCGJFTk8mDlcb7Q4M0Y
 paw1ULQnvdBaYMd8JzrN1VzCZnMvmLcNTZbcxe/h9pMw9xEzu1Sgq9tceObZgQixaM7vS0bgqXl
 O/YhHoBYH/yvntZkC95/eoj5+IvNIsaivn27qvZljRNdsLdUXbgQ2RhkPCgVuWujnNrZoxNUpS2
 cIDGUv63TP54mnYVBzOu8UsiZcSfhyvgFJWFYwAtdrTGfC2SgUYieH5guFaIoTkj6Omany7Zt6/
 X7RjLdPNnNHrBpFi8xdxnkebDaJ86XUmtp7MIQm+qrJ0r/QBmIqIaOBqQvM/JDsWLdzjhh9QkA2
 wmPrs3WXqoxFbl6W1e4+/J6VRKhDm5Mxulm2oUFk1WbvCxTKEqPxv7RxH5V9sx1/pPpb0Vqo1Ne
 SMHBAQB8xUhbSE6Z3NiP3Q0q/XZbRl52FZFj4l3WacQRqO3uB1ebs4Ecvdj5u0Qzv9s6mxBiuoy
 niBGWiDzKcggYZnC06vTMIolRAG4a/Pn91Iygc3DVxxhyfavn+rVDCzLv/vptDPZIpzUIZVTd1e
 hk/lWvPq02KuXhA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

When NFS superblocks are created by automounting, their LSM parameters
aren't set in the fs_context struct prior to sget_fc() being called,
leading to failure to match existing superblocks.

This bug leads to messages like the following appearing in dmesg when
fscache is enabled:

    NFS: Cache volume key already in use (nfs,4.2,2,108,106a8c0,1,,,,100000,100000,2ee,3a98,1d4c,3a98,1)

Fix this by adding a new LSM hook to load fc->security for submount
creation.

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
ver #2)
- Added Smack support
- Made LSM parameter extraction dependent on reference != NULL.

ver #3)
- Made LSM parameter extraction dependent on fc->purpose ==
   FS_CONTEXT_FOR_SUBMOUNT.  Shouldn't happen on FOR_RECONFIGURE.

ver #4)
- When doing a FOR_SUBMOUNT mount, don't set the root label in SELinux or Smack.

ver #5)
- Removed unused variable.
- Only allocate smack_mnt_opts if we're dealing with a submount.

ver #6)
- Rebase onto v6.5.0-rc4
- Link to v6: https://lore.kernel.org/r/20230802-master-v6-1-45d48299168b@kernel.org

ver #7)
- Drop lsm_set boolean
- Link to v7: https://lore.kernel.org/r/20230804-master-v7-1-5d4e48407298@kernel.org

ver #8)
- Remove spurious semicolon in smack_fs_context_init
- Make fs_context_init take a superblock as reference instead of dentry
- WARN_ON_ONCE's when fc->purpose != FS_CONTEXT_FOR_SUBMOUNT
- Call the security hook from fs_context_for_submount instead of alloc_fs_context
- Link to v8: https://lore.kernel.org/r/20230807-master-v8-1-54e249595f10@kernel.org

ver #9)
- rename *_fs_context_init to *_fs_context_submount
- remove checks for FS_CONTEXT_FOR_SUBMOUNT and NULL reference pointers
- fix prototype on smack_fs_context_submount
---
 fs/fs_context.c               | 23 ++++++++++++++++++-
 include/linux/lsm_hook_defs.h |  1 +
 include/linux/security.h      |  6 +++++
 security/security.c           | 14 ++++++++++++
 security/selinux/hooks.c      | 22 +++++++++++++++++++
 security/smack/smack_lsm.c    | 51 +++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 116 insertions(+), 1 deletion(-)

diff --git a/fs/fs_context.c b/fs/fs_context.c
index 851214d1d013..375023e40161 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -315,10 +315,31 @@ struct fs_context *fs_context_for_reconfigure(struct dentry *dentry,
 }
 EXPORT_SYMBOL(fs_context_for_reconfigure);
 
+/**
+ * fs_context_for_submount: allocate a new fs_context for a submount
+ * @type: file_system_type of the new context
+ * @reference: reference dentry from which to copy relevant info
+ *
+ * Allocate a new fs_context suitable for a submount. This also ensures that
+ * the fc->security object is inherited from @reference (if needed).
+ */
 struct fs_context *fs_context_for_submount(struct file_system_type *type,
 					   struct dentry *reference)
 {
-	return alloc_fs_context(type, reference, 0, 0, FS_CONTEXT_FOR_SUBMOUNT);
+	struct fs_context *fc;
+	int ret;
+
+	fc = alloc_fs_context(type, reference, 0, 0, FS_CONTEXT_FOR_SUBMOUNT);
+	if (IS_ERR(fc))
+		return fc;
+
+	ret = security_fs_context_submount(fc, reference->d_sb);
+	if (ret) {
+		put_fs_context(fc);
+		return ERR_PTR(ret);
+	}
+
+	return fc;
 }
 EXPORT_SYMBOL(fs_context_for_submount);
 
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 7308a1a7599b..af796986baee 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -54,6 +54,7 @@ LSM_HOOK(int, 0, bprm_creds_from_file, struct linux_binprm *bprm, struct file *f
 LSM_HOOK(int, 0, bprm_check_security, struct linux_binprm *bprm)
 LSM_HOOK(void, LSM_RET_VOID, bprm_committing_creds, struct linux_binprm *bprm)
 LSM_HOOK(void, LSM_RET_VOID, bprm_committed_creds, struct linux_binprm *bprm)
+LSM_HOOK(int, 0, fs_context_submount, struct fs_context *fc, struct super_block *reference)
 LSM_HOOK(int, 0, fs_context_dup, struct fs_context *fc,
 	 struct fs_context *src_sc)
 LSM_HOOK(int, -ENOPARAM, fs_context_parse_param, struct fs_context *fc,
diff --git a/include/linux/security.h b/include/linux/security.h
index 32828502f09e..bac98ea18f78 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -293,6 +293,7 @@ int security_bprm_creds_from_file(struct linux_binprm *bprm, struct file *file);
 int security_bprm_check(struct linux_binprm *bprm);
 void security_bprm_committing_creds(struct linux_binprm *bprm);
 void security_bprm_committed_creds(struct linux_binprm *bprm);
+int security_fs_context_submount(struct fs_context *fc, struct super_block *reference);
 int security_fs_context_dup(struct fs_context *fc, struct fs_context *src_fc);
 int security_fs_context_parse_param(struct fs_context *fc, struct fs_parameter *param);
 int security_sb_alloc(struct super_block *sb);
@@ -629,6 +630,11 @@ static inline void security_bprm_committed_creds(struct linux_binprm *bprm)
 {
 }
 
+static inline int security_fs_context_submount(struct fs_context *fc,
+					   struct super_block *reference)
+{
+	return 0;
+}
 static inline int security_fs_context_dup(struct fs_context *fc,
 					  struct fs_context *src_fc)
 {
diff --git a/security/security.c b/security/security.c
index b720424ca37d..549104a447e3 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1138,6 +1138,20 @@ void security_bprm_committed_creds(struct linux_binprm *bprm)
 	call_void_hook(bprm_committed_creds, bprm);
 }
 
+/**
+ * security_fs_context_submount() - Initialise fc->security
+ * @fc: new filesystem context
+ * @reference: dentry reference for submount/remount
+ *
+ * Fill out the ->security field for a new fs_context.
+ *
+ * Return: Returns 0 on success or negative error code on failure.
+ */
+int security_fs_context_submount(struct fs_context *fc, struct super_block *reference)
+{
+	return call_int_hook(fs_context_submount, 0, fc, reference);
+}
+
 /**
  * security_fs_context_dup() - Duplicate a fs_context LSM blob
  * @fc: destination filesystem context
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index d06e350fedee..afd663744041 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2745,6 +2745,27 @@ static int selinux_umount(struct vfsmount *mnt, int flags)
 				   FILESYSTEM__UNMOUNT, NULL);
 }
 
+static int selinux_fs_context_submount(struct fs_context *fc,
+				   struct super_block *reference)
+{
+	const struct superblock_security_struct *sbsec;
+	struct selinux_mnt_opts *opts;
+
+	opts = kzalloc(sizeof(*opts), GFP_KERNEL);
+	if (!opts)
+		return -ENOMEM;
+
+	sbsec = selinux_superblock(reference);
+	if (sbsec->flags & FSCONTEXT_MNT)
+		opts->fscontext_sid = sbsec->sid;
+	if (sbsec->flags & CONTEXT_MNT)
+		opts->context_sid = sbsec->mntpoint_sid;
+	if (sbsec->flags & DEFCONTEXT_MNT)
+		opts->defcontext_sid = sbsec->def_sid;
+	fc->security = opts;
+	return 0;
+}
+
 static int selinux_fs_context_dup(struct fs_context *fc,
 				  struct fs_context *src_fc)
 {
@@ -7182,6 +7203,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	/*
 	 * PUT "CLONING" (ACCESSING + ALLOCATING) HOOKS HERE
 	 */
+	LSM_HOOK_INIT(fs_context_submount, selinux_fs_context_submount),
 	LSM_HOOK_INIT(fs_context_dup, selinux_fs_context_dup),
 	LSM_HOOK_INIT(fs_context_parse_param, selinux_fs_context_parse_param),
 	LSM_HOOK_INIT(sb_eat_lsm_opts, selinux_sb_eat_lsm_opts),
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 6e270cf3fd30..a8201cf22f20 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -614,6 +614,56 @@ static int smack_add_opt(int token, const char *s, void **mnt_opts)
 	return -EINVAL;
 }
 
+/**
+ * smack_fs_context_submount - Initialise security data for a filesystem context
+ * @fc: The filesystem context.
+ * @reference: reference superblock
+ *
+ * Returns 0 on success or -ENOMEM on error.
+ */
+static int smack_fs_context_submount(struct fs_context *fc,
+				 struct super_block *reference)
+{
+	struct superblock_smack *sbsp;
+	struct smack_mnt_opts *ctx;
+	struct inode_smack *isp;
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+	fc->security = ctx;
+
+	sbsp = smack_superblock(reference);
+	isp = smack_inode(reference->s_root->d_inode);
+
+	if (sbsp->smk_default) {
+		ctx->fsdefault = kstrdup(sbsp->smk_default->smk_known, GFP_KERNEL);
+		if (!ctx->fsdefault)
+			return -ENOMEM;
+	}
+
+	if (sbsp->smk_floor) {
+		ctx->fsfloor = kstrdup(sbsp->smk_floor->smk_known, GFP_KERNEL);
+		if (!ctx->fsfloor)
+			return -ENOMEM;
+	}
+
+	if (sbsp->smk_hat) {
+		ctx->fshat = kstrdup(sbsp->smk_hat->smk_known, GFP_KERNEL);
+		if (!ctx->fshat)
+			return -ENOMEM;
+	}
+
+	if (isp->smk_flags & SMK_INODE_TRANSMUTE) {
+		if (sbsp->smk_root) {
+			ctx->fstransmute = kstrdup(sbsp->smk_root->smk_known, GFP_KERNEL);
+			if (!ctx->fstransmute)
+				return -ENOMEM;
+		}
+	}
+	return 0;
+}
+
 /**
  * smack_fs_context_dup - Duplicate the security data on fs_context duplication
  * @fc: The new filesystem context.
@@ -4876,6 +4926,7 @@ static struct security_hook_list smack_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(ptrace_traceme, smack_ptrace_traceme),
 	LSM_HOOK_INIT(syslog, smack_syslog),
 
+	LSM_HOOK_INIT(fs_context_submount, smack_fs_context_submount),
 	LSM_HOOK_INIT(fs_context_dup, smack_fs_context_dup),
 	LSM_HOOK_INIT(fs_context_parse_param, smack_fs_context_parse_param),
 

---
base-commit: 52a93d39b17dc7eb98b6aa3edb93943248e03b2f
change-id: 20230802-master-3082090e8d69

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>

