Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C3E5A9639
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Sep 2022 14:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbiIAMDw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Sep 2022 08:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233407AbiIAMDb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Sep 2022 08:03:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCB3BFE98
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Sep 2022 05:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662033781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=4at+xDVugZLgW/N/NU+QWS28AyXL9rvbaZGUP/LG5Fk=;
        b=HTu64rZeeVz2O+dQrzblk7A6Yz1J6kGY/Nq8yu7C2X7UNUc00j2pywd/EBks6k0UNG4pax
        RTJmR9Pc/ynzMDpjbp/6YVPeRNaw6LCz3+7JausSryyYmb7sO/VbtIvjiTlOqrk40LSttS
        P5gxbX8vXwBWxK8zfw26R/d2xacEbOo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-653-RaWSERpHPPez9koLB2ii3A-1; Thu, 01 Sep 2022 08:02:59 -0400
X-MC-Unique: RaWSERpHPPez9koLB2ii3A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 38726101AA45;
        Thu,  1 Sep 2022 12:02:58 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6E8C12026D4C;
        Thu,  1 Sep 2022 12:02:56 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Scott Mayhew <smayhew@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-nfs@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dwysocha@redhat.com,
        dhowells@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH v5] vfs, security: Fix automount superblock LSM init problem, preventing NFS sb sharing
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <217594.1662033775.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 01 Sep 2022 13:02:55 +0100
Message-ID: <217595.1662033775@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

    =

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

        NFS: Cache volume key already in use (nfs,4.2,2,108,106a8c0,1,,,,1=
00000,100000,2ee,3a98,1d4c,3a98,1)

Changes
=3D=3D=3D=3D=3D=3D=3D
ver #5)
 - Removed unused variable.
 - Only allocate smack_mnt_opts if we're dealing with a submount.

ver #4)
 - When doing a FOR_SUBMOUNT mount, don't set the root label in SELinux or
   Smack.

ver #3)
 - Made LSM parameter extraction dependent on fc->purpose =3D=3D
   FS_CONTEXT_FOR_SUBMOUNT.  Shouldn't happen on FOR_RECONFIGURE.

ver #2)
 - Added Smack support
 - Made LSM parameter extraction dependent on reference !=3D NULL.

Signed-off-by: David Howells <dhowells@redhat.com>
Fixes: 9bc61ab18b1d ("vfs: Introduce fs_context, switch vfs_kern_mount() t=
o it.")
Fixes: 779df6a5480f ("NFS: Ensure security label is set for root inode)
Tested-by: Jeff Layton <jlayton@kernel.org>
Acked-by: Casey Schaufler <casey@schaufler-ca.com>
cc: Trond Myklebust <trond.myklebust@hammerspace.com>
cc: Anna Schumaker <anna@kernel.org>
cc: Alexander Viro <viro@zeniv.linux.org.uk>
cc: Scott Mayhew <smayhew@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Paul Moore <paul@paul-moore.com>
cc: linux-nfs@vger.kernel.org
cc: selinux@vger.kernel.org
cc: linux-security-module@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/165962680944.3334508.6610023900349142034.s=
tgit@warthog.procyon.org.uk/ # v1
Link: https://lore.kernel.org/r/165962729225.3357250.14350728846471527137.=
stgit@warthog.procyon.org.uk/ # v2
Link: https://lore.kernel.org/r/165970659095.2812394.6868894171102318796.s=
tgit@warthog.procyon.org.uk/ # v3
Link: https://lore.kernel.org/r/166133579016.3678898.6283195019480567275.s=
tgit@warthog.procyon.org.uk/ # v4
---
 fs/fs_context.c               |    4 +++
 fs/nfs/getroot.c              |    1 =

 fs/super.c                    |   10 ++++---
 include/linux/fs_context.h    |    1 =

 include/linux/lsm_hook_defs.h |    1 =

 include/linux/lsm_hooks.h     |    6 +++-
 include/linux/security.h      |    6 ++++
 security/security.c           |    5 +++
 security/selinux/hooks.c      |   25 +++++++++++++++++++
 security/smack/smack_lsm.c    |   54 ++++++++++++++++++++++++++++++++++++=
++++++
 10 files changed, 108 insertions(+), 5 deletions(-)

diff --git a/fs/fs_context.c b/fs/fs_context.c
index 24ce12f0db32..22248b8a88a8 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -282,6 +282,10 @@ static struct fs_context *alloc_fs_context(struct fil=
e_system_type *fs_type,
 		break;
 	}
 =

+	ret =3D security_fs_context_init(fc, reference);
+	if (ret < 0)
+		goto err_fc;
+
 	/* TODO: Make all filesystems support this unconditionally */
 	init_fs_context =3D fc->fs_type->init_fs_context;
 	if (!init_fs_context)
diff --git a/fs/nfs/getroot.c b/fs/nfs/getroot.c
index 11ff2b2e060f..651bffb0067e 100644
--- a/fs/nfs/getroot.c
+++ b/fs/nfs/getroot.c
@@ -144,6 +144,7 @@ int nfs_get_root(struct super_block *s, struct fs_cont=
ext *fc)
 	}
 	if (error)
 		goto error_splat_root;
+	fc->lsm_set =3D true;
 	if (server->caps & NFS_CAP_SECURITY_LABEL &&
 		!(kflags_out & SECURITY_LSM_NATIVE_LABELS))
 		server->caps &=3D ~NFS_CAP_SECURITY_LABEL;
diff --git a/fs/super.c b/fs/super.c
index 734ed584a946..94666c0c92a4 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1552,10 +1552,12 @@ int vfs_get_tree(struct fs_context *fc)
 	smp_wmb();
 	sb->s_flags |=3D SB_BORN;
 =

-	error =3D security_sb_set_mnt_opts(sb, fc->security, 0, NULL);
-	if (unlikely(error)) {
-		fc_drop_locked(fc);
-		return error;
+	if (!(fc->lsm_set)) {
+		error =3D security_sb_set_mnt_opts(sb, fc->security, 0, NULL);
+		if (unlikely(error)) {
+			fc_drop_locked(fc);
+			return error;
+		}
 	}
 =

 	/*
diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
index 13fa6f3df8e4..3876dd96bb20 100644
--- a/include/linux/fs_context.h
+++ b/include/linux/fs_context.h
@@ -110,6 +110,7 @@ struct fs_context {
 	bool			need_free:1;	/* Need to call ops->free() */
 	bool			global:1;	/* Goes into &init_user_ns */
 	bool			oldapi:1;	/* Coming from mount(2) */
+	bool			lsm_set:1;	/* security_sb_set/clone_mnt_opts() already done */
 };
 =

 struct fs_context_operations {
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 60fff133c0b1..a0cf11cfce8d 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -54,6 +54,7 @@ LSM_HOOK(int, 0, bprm_creds_from_file, struct linux_binp=
rm *bprm, struct file *f
 LSM_HOOK(int, 0, bprm_check_security, struct linux_binprm *bprm)
 LSM_HOOK(void, LSM_RET_VOID, bprm_committing_creds, struct linux_binprm *=
bprm)
 LSM_HOOK(void, LSM_RET_VOID, bprm_committed_creds, struct linux_binprm *b=
prm)
+LSM_HOOK(int, 0, fs_context_init, struct fs_context *fc, struct dentry *r=
eference)
 LSM_HOOK(int, 0, fs_context_dup, struct fs_context *fc,
 	 struct fs_context *src_sc)
 LSM_HOOK(int, -ENOPARAM, fs_context_parse_param, struct fs_context *fc,
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 3aa6030302f5..099528f6a91c 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -87,8 +87,12 @@
  * Security hooks for mount using fs_context.
  *	[See also Documentation/filesystems/mount_api.rst]
  *
+ * @fs_context_init:
+ *	Initialise fc->security.  This is initialised to NULL by the caller.
+ *	@fc indicates the new filesystem context.
+ *	@dentry indicates a reference for submount/remount
  * @fs_context_dup:
- *	Allocate and attach a security structure to sc->security.  This pointe=
r
+ *	Allocate and attach a security structure to fc->security.  This pointe=
r
  *	is initialised to NULL by the caller.
  *	@fc indicates the new filesystem context.
  *	@src_fc indicates the original filesystem context.
diff --git a/include/linux/security.h b/include/linux/security.h
index 7bd0c490703d..eb865af42b36 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -291,6 +291,7 @@ int security_bprm_creds_from_file(struct linux_binprm =
*bprm, struct file *file);
 int security_bprm_check(struct linux_binprm *bprm);
 void security_bprm_committing_creds(struct linux_binprm *bprm);
 void security_bprm_committed_creds(struct linux_binprm *bprm);
+int security_fs_context_init(struct fs_context *fc, struct dentry *refere=
nce);
 int security_fs_context_dup(struct fs_context *fc, struct fs_context *src=
_fc);
 int security_fs_context_parse_param(struct fs_context *fc, struct fs_para=
meter *param);
 int security_sb_alloc(struct super_block *sb);
@@ -622,6 +623,11 @@ static inline void security_bprm_committed_creds(stru=
ct linux_binprm *bprm)
 {
 }
 =

+static inline int security_fs_context_init(struct fs_context *fc,
+					   struct dentry *reference)
+{
+	return 0;
+}
 static inline int security_fs_context_dup(struct fs_context *fc,
 					  struct fs_context *src_fc)
 {
diff --git a/security/security.c b/security/security.c
index 4b95de24bc8d..d04d01a57ee2 100644
--- a/security/security.c
+++ b/security/security.c
@@ -880,6 +880,11 @@ void security_bprm_committed_creds(struct linux_binpr=
m *bprm)
 	call_void_hook(bprm_committed_creds, bprm);
 }
 =

+int security_fs_context_init(struct fs_context *fc, struct dentry *refere=
nce)
+{
+	return call_int_hook(fs_context_init, 0, fc, reference);
+}
+
 int security_fs_context_dup(struct fs_context *fc, struct fs_context *src=
_fc)
 {
 	return call_int_hook(fs_context_dup, 0, fc, src_fc);
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 03bca97c8b29..9b48d15c9eab 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2766,6 +2766,30 @@ static int selinux_umount(struct vfsmount *mnt, int=
 flags)
 				   FILESYSTEM__UNMOUNT, NULL);
 }
 =

+static int selinux_fs_context_init(struct fs_context *fc,
+				   struct dentry *reference)
+{
+	const struct superblock_security_struct *sbsec;
+	struct selinux_mnt_opts *opts;
+
+	if (fc->purpose =3D=3D FS_CONTEXT_FOR_SUBMOUNT) {
+		opts =3D kzalloc(sizeof(*opts), GFP_KERNEL);
+		if (!opts)
+			return -ENOMEM;
+
+		sbsec =3D selinux_superblock(reference->d_sb);
+		if (sbsec->flags & FSCONTEXT_MNT)
+			opts->fscontext_sid	=3D sbsec->sid;
+		if (sbsec->flags & CONTEXT_MNT)
+			opts->context_sid	=3D sbsec->mntpoint_sid;
+		if (sbsec->flags & DEFCONTEXT_MNT)
+			opts->defcontext_sid	=3D sbsec->def_sid;
+		fc->security =3D opts;
+	}
+
+	return 0;
+}
+
 static int selinux_fs_context_dup(struct fs_context *fc,
 				  struct fs_context *src_fc)
 {
@@ -7260,6 +7284,7 @@ static struct security_hook_list selinux_hooks[] __l=
sm_ro_after_init =3D {
 	/*
 	 * PUT "CLONING" (ACCESSING + ALLOCATING) HOOKS HERE
 	 */
+	LSM_HOOK_INIT(fs_context_init, selinux_fs_context_init),
 	LSM_HOOK_INIT(fs_context_dup, selinux_fs_context_dup),
 	LSM_HOOK_INIT(fs_context_parse_param, selinux_fs_context_parse_param),
 	LSM_HOOK_INIT(sb_eat_lsm_opts, selinux_sb_eat_lsm_opts),
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index bffccdc494cb..3396ecebd791 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -613,6 +613,59 @@ static int smack_add_opt(int token, const char *s, vo=
id **mnt_opts)
 	return -EINVAL;
 }
 =

+/**
+ * smack_fs_context_init - Initialise security data for a filesystem cont=
ext
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
+	if (fc->purpose =3D=3D FS_CONTEXT_FOR_SUBMOUNT) {
+		ctx =3D kzalloc(sizeof(*ctx), GFP_KERNEL);
+		if (!ctx)
+			return -ENOMEM;
+		fc->security =3D ctx;
+
+		sbsp =3D smack_superblock(reference->d_sb);
+		isp =3D smack_inode(reference->d_sb->s_root->d_inode);
+
+		if (sbsp->smk_default) {
+			ctx->fsdefault =3D kstrdup(sbsp->smk_default->smk_known, GFP_KERNEL);
+			if (!ctx->fsdefault)
+				return -ENOMEM;
+		}
+
+		if (sbsp->smk_floor) {
+			ctx->fsfloor =3D kstrdup(sbsp->smk_floor->smk_known, GFP_KERNEL);
+			if (!ctx->fsfloor)
+				return -ENOMEM;
+		}
+
+		if (sbsp->smk_hat) {
+			ctx->fshat =3D kstrdup(sbsp->smk_hat->smk_known, GFP_KERNEL);
+			if (!ctx->fshat)
+				return -ENOMEM;
+		}
+
+		if (isp->smk_flags & SMK_INODE_TRANSMUTE) {
+			if (sbsp->smk_root) {
+				ctx->fstransmute =3D kstrdup(sbsp->smk_root->smk_known, GFP_KERNEL);
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
  * smack_fs_context_dup - Duplicate the security data on fs_context dupli=
cation
  * @fc: The new filesystem context.
@@ -4779,6 +4832,7 @@ static struct security_hook_list smack_hooks[] __lsm=
_ro_after_init =3D {
 	LSM_HOOK_INIT(ptrace_traceme, smack_ptrace_traceme),
 	LSM_HOOK_INIT(syslog, smack_syslog),
 =

+	LSM_HOOK_INIT(fs_context_init, smack_fs_context_init),
 	LSM_HOOK_INIT(fs_context_dup, smack_fs_context_dup),
 	LSM_HOOK_INIT(fs_context_parse_param, smack_fs_context_parse_param),
 =

