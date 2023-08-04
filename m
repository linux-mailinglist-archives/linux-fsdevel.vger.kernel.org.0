Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98777705A3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 18:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjHDQJs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 12:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjHDQJr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 12:09:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D1E3C3D;
        Fri,  4 Aug 2023 09:09:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E51EE62094;
        Fri,  4 Aug 2023 16:09:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0D8BC433C7;
        Fri,  4 Aug 2023 16:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691165384;
        bh=/G9+BOhktb0Ikvr9INPC/Qj1+ffwYhyfil9QoWRt2cU=;
        h=From:Date:Subject:To:Cc:From;
        b=gpj9lNfLMbVG2z6SVcHo74P7gL/uctG0/mmpB5IXHzNSeJFj0yBa/6HxLIia3RcS1
         R1Uq0cw1Jv2mJo9tLJ8NoxEY9AsMcksnIMDSXzRHsCRIdSpCWWX20BrPQGQ/jibPDQ
         5NEIRY8pi3tbVAfzWmRLmULWgTKChg1CSNo7Va/97AAdv4pv8ycz2ANX0FywpPCqah
         HmIfoxnVBSvybOKq99tes3v15aDgx6ja3KqJEx8tOXCDbbAVoyY+IbNS6Ctj4k1awh
         ME0XT5fwEpwE3jdpjiPYj2KfZxQJKEZYcW0SvQv8R18fT775xRFsmSoLuHVJ/byOh5
         iyajgfab+AOcA==
From:   Jeff Layton <jlayton@kernel.org>
Date:   Fri, 04 Aug 2023 12:09:34 -0400
Subject: [PATCH v7] vfs, security: Fix automount superblock LSM init
 problem, preventing NFS sb sharing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230804-master-v7-1-5d4e48407298@kernel.org>
X-B4-Tracking: v=1; b=H4sIAL0izWQC/2WOS47CMBBEr4K8HlvdPYk/rLgHYpEhTWIxxKhtM
 oNQ7o6TLcsnVb2ql8oskbPa715KeI45pqmC+9qp89hNA+vYV1YE9A0eSN+6XFh0BYIA7HsbVA3
 fhS/xfxMdT5Uvkm66jMLdVkdrPTjfWtd6Q8GRBTLYoGsDEgGiJXDkCE0uQyyHv07KmAZzl3R+p
 skkGczjug6NMZckz+3wbNe5j2+z1aibtm88hYDW/xyuLBP/rhZ1WpblDf+ie8P2AAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9504; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=MahDfl+gq9tOE3JX7xVtiX06rlkMCfvpGaUdptqaDBk=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBkzSLGCdrHd5XXJxPC6Y+WTl6dBwcZCIG9BD9bD
 DuDiWxXSSeJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZM0ixgAKCRAADmhBGVaC
 FW6XD/93q8Opv1kMW7cT4pW4eujQeYk+3smRjzI/93qRGKOu7Uj6EupmxEdAGq+ez6kazfeRhLC
 b/71VcfdsrXh63g70X9pqgCTEL2vWpl0VFUd1Bmth05kzwv2cBQWOEnBRayhaslDuMRk4LrnbLO
 oBAoY+5AcSC8geoLPtKQBLD8re/kNgOskx37TpJ+hgN6znG9jXeG2PXXBRIEr82jXAEL++2uTDG
 P1NleJcJ4hfaOijK4yD8WiXeJ/PLxyW0Aahie7fd5y/wSHOVFPkwvHninRMDyPXRW07fMjxhB2N
 VjlXDS+DVwOAPYRg6vq6j87d0ndEhzB/aS1QpiXtpaClBloKmS7iB4bimfYU1TR6gFCrkufoEUW
 pjM7WLFTDae5s0wgCN0Arg/yZIasDjx7Uh1eq0CqpiAmmyMxyqfoDVVvsKiheC3fxg14QDi1aMb
 Q72lZcQuXgLAyH1mbPBx0QrHLdjgQowiLuMTXeVNwnC1t6JsAtKOvUIO9OP1aIYJ7pSq5VTyf0U
 JCvh+95pgDum+pved7S5PKuuZgGMw+CXJwnDiVOnTtziATBI/K05lbA5DF+q6yGUDs2RurI9+my
 +yByyzjdGnuVT+RID9iUsLAQKSnVYdqj8v5ZGh8UVXYxDVoaDvLLPYARSWOogCyvLuwAk/VRi5I
 0TsM7sJebURcPwg==
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
creation when alloc_fs_context() is creating the fs_context for it.

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
ver #7)
 - Drop lsm_set boolean
 - Link to v6: https://lore.kernel.org/r/20230802-master-v6-1-45d48299168b@kernel.org

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
 include/linux/lsm_hook_defs.h |  1 +
 include/linux/security.h      |  6 +++++
 security/security.c           | 14 +++++++++++
 security/selinux/hooks.c      | 25 ++++++++++++++++++++
 security/smack/smack_lsm.c    | 54 +++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 104 insertions(+)

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
index d06e350fedee..97fe5aab82dc 100644
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
+	if (!reference || fc->purpose != FS_CONTEXT_FOR_SUBMOUNT)
+		return 0;
+
+	opts = kzalloc(sizeof(*opts), GFP_KERNEL);
+	if (!opts)
+		return -ENOMEM;
+
+	sbsec = selinux_superblock(reference->d_sb);
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
@@ -7182,6 +7206,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	/*
 	 * PUT "CLONING" (ACCESSING + ALLOCATING) HOOKS HERE
 	 */
+	LSM_HOOK_INIT(fs_context_init, selinux_fs_context_init),
 	LSM_HOOK_INIT(fs_context_dup, selinux_fs_context_dup),
 	LSM_HOOK_INIT(fs_context_parse_param, selinux_fs_context_parse_param),
 	LSM_HOOK_INIT(sb_eat_lsm_opts, selinux_sb_eat_lsm_opts),
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 6e270cf3fd30..ca5f2dbc9116 100644
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
+	if (!reference || fc->purpose != FS_CONTEXT_FOR_SUBMOUNT);
+		return 0;
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+	fc->security = ctx;
+
+	sbsp = smack_superblock(reference->d_sb);
+	isp = smack_inode(reference->d_sb->s_root->d_inode);
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

