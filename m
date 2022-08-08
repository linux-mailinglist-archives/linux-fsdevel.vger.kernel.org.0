Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59B058CC82
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Aug 2022 19:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243901AbiHHRE1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Aug 2022 13:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243937AbiHHREX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Aug 2022 13:04:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C590B14D0D;
        Mon,  8 Aug 2022 10:04:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0E46CB80FE1;
        Mon,  8 Aug 2022 17:04:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A7AC433D6;
        Mon,  8 Aug 2022 17:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659978257;
        bh=jtGYMVgkxxDcJvyi/VygmZGFRm8Enop7JIgqZj9bcvo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=hGWltx2RnhTtXalJlucJihDaG/8Jw9ftCMcHLWYSJC2j0PB6zG+HsDTLnDbeVSrl4
         cRYnZM+zjtzG6fwnMFYSwSSrLQejSr0wVIFHrLgO+cqxHhM/BImnZRRJIwuE/lvh3s
         6gcraXruwWVQPSOXU28fLFWtJNiSb9pgIyq0mC9Ge88QN1cXlMhvK4490BAapeUUG0
         6qDVd6WqDaWaxBbHoqkEFiS19mEDlTdRFXVf9CQT4XJ9h0XfwMjkzuK60l3L2MF9D8
         5YVhAlSDyfdZ3aegNo05B5Rm0fxzMtMgXbcZyememubQk98FVwZCDXt5xugsL0ITOx
         vMnLwlPexiukQ==
Message-ID: <84a4014cad07ddaaa36cf217921235f8082c2cbf.camel@kernel.org>
Subject: Re: [PATCH v3] nfs: Fix automount superblock LSM init problem,
 preventing sb sharing
From:   Jeff Layton <jlayton@kernel.org>
To:     David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Scott Mayhew <smayhew@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-nfs@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dwysocha@redhat.com,
        linux-kernel@vger.kernel.org
Date:   Mon, 08 Aug 2022 13:04:14 -0400
In-Reply-To: <165970659095.2812394.6868894171102318796.stgit@warthog.procyon.org.uk>
References: <165970659095.2812394.6868894171102318796.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

nit: The problem is evident on NFS, but it's not really an "nfs:" patch,
IMO. I'd prefix this with vfs: since most of the fix is there and it
could be applicable elsewhere.


On Fri, 2022-08-05 at 14:36 +0100, David Howells wrote:
> When NFS superblocks are created by automounting, their LSM parameters
> aren't set in the fs_context struct prior to sget_fc() being called,
> leading to failure to match existing superblocks.
>=20
> Fix this by adding a new LSM hook to load fc->security for submount
> creation when alloc_fs_context() is creating the fs_context for it.
>=20
> However, this uncovers a further bug: nfs_get_root() initialises the
> superblock security manually by calling security_sb_set_mnt_opts() or
> security_sb_clone_mnt_opts() - but then vfs_get_tree() calls
> security_sb_set_mnt_opts(), which can lead to SELinux, at least,
> complaining.
>=20
> Fix that by adding a flag to the fs_context that suppresses the
> security_sb_set_mnt_opts() call in vfs_get_tree().  This can be set by NF=
S
> when it sets the LSM context on the new superblock.
>=20
> The first bug leads to messages like the following appearing in dmesg:
>=20
> 	NFS: Cache volume key already in use (nfs,4.2,2,108,106a8c0,1,,,,100000,=
100000,2ee,3a98,1d4c,3a98,1)
>=20
> Changes
> =3D=3D=3D=3D=3D=3D=3D
> ver #2)
>  - Made LSM parameter extraction dependent on fc->purpose =3D=3D
>    FS_CONTEXT_FOR_SUBMOUNT.  Shouldn't happen on FOR_RECONFIGURE.
>=20
> ver #2)
>  - Added Smack support
>  - Made LSM parameter extraction dependent on reference !=3D NULL.
>=20
> Signed-off-by: David Howells <dhowells@redhat.com>
> Fixes: 9bc61ab18b1d ("vfs: Introduce fs_context, switch vfs_kern_mount() =
to it.")
> Fixes: 779df6a5480f ("NFS: Ensure security label is set for root inode)
> cc: Trond Myklebust <trond.myklebust@hammerspace.com>
> cc: Anna Schumaker <anna@kernel.org>
> cc: Alexander Viro <viro@zeniv.linux.org.uk>
> cc: Scott Mayhew <smayhew@redhat.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: Paul Moore <paul@paul-moore.com>
> cc: Casey Schaufler <casey@schaufler-ca.com>
> cc: linux-nfs@vger.kernel.org
> cc: selinux@vger.kernel.org
> cc: linux-security-module@vger.kernel.org
> cc: linux-fsdevel@vger.kernel.org
> ---
>=20
>  fs/fs_context.c               |    4 +++
>  fs/nfs/getroot.c              |    1 +
>  fs/super.c                    |   10 ++++---
>  include/linux/fs_context.h    |    1 +
>  include/linux/lsm_hook_defs.h |    1 +
>  include/linux/lsm_hooks.h     |    6 +++-
>  include/linux/security.h      |    6 ++++
>  security/security.c           |    5 +++
>  security/selinux/hooks.c      |   29 +++++++++++++++++++
>  security/smack/smack_lsm.c    |   61 +++++++++++++++++++++++++++++++++++=
++++++
>  10 files changed, 119 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/fs_context.c b/fs/fs_context.c
> index 24ce12f0db32..22248b8a88a8 100644
> --- a/fs/fs_context.c
> +++ b/fs/fs_context.c
> @@ -282,6 +282,10 @@ static struct fs_context *alloc_fs_context(struct fi=
le_system_type *fs_type,
>  		break;
>  	}
> =20
> +	ret =3D security_fs_context_init(fc, reference);
> +	if (ret < 0)
> +		goto err_fc;
> +
>  	/* TODO: Make all filesystems support this unconditionally */
>  	init_fs_context =3D fc->fs_type->init_fs_context;
>  	if (!init_fs_context)
> diff --git a/fs/nfs/getroot.c b/fs/nfs/getroot.c
> index 11ff2b2e060f..651bffb0067e 100644
> --- a/fs/nfs/getroot.c
> +++ b/fs/nfs/getroot.c
> @@ -144,6 +144,7 @@ int nfs_get_root(struct super_block *s, struct fs_con=
text *fc)
>  	}
>  	if (error)
>  		goto error_splat_root;
> +	fc->lsm_set =3D true;
>  	if (server->caps & NFS_CAP_SECURITY_LABEL &&
>  		!(kflags_out & SECURITY_LSM_NATIVE_LABELS))
>  		server->caps &=3D ~NFS_CAP_SECURITY_LABEL;
> diff --git a/fs/super.c b/fs/super.c
> index 60f57c7bc0a6..a1c440336fd9 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1519,10 +1519,12 @@ int vfs_get_tree(struct fs_context *fc)
>  	smp_wmb();
>  	sb->s_flags |=3D SB_BORN;
> =20
> -	error =3D security_sb_set_mnt_opts(sb, fc->security, 0, NULL);
> -	if (unlikely(error)) {
> -		fc_drop_locked(fc);
> -		return error;
> +	if (!(fc->lsm_set)) {
> +		error =3D security_sb_set_mnt_opts(sb, fc->security, 0, NULL);
> +		if (unlikely(error)) {
> +			fc_drop_locked(fc);
> +			return error;
> +		}
>  	}
> =20
>  	/*
> diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
> index 13fa6f3df8e4..3876dd96bb20 100644
> --- a/include/linux/fs_context.h
> +++ b/include/linux/fs_context.h
> @@ -110,6 +110,7 @@ struct fs_context {
>  	bool			need_free:1;	/* Need to call ops->free() */
>  	bool			global:1;	/* Goes into &init_user_ns */
>  	bool			oldapi:1;	/* Coming from mount(2) */
> +	bool			lsm_set:1;	/* security_sb_set/clone_mnt_opts() already done */
>  };
> =20
>  struct fs_context_operations {
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.=
h
> index eafa1d2489fd..6d1c738e4a84 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -54,6 +54,7 @@ LSM_HOOK(int, 0, bprm_creds_from_file, struct linux_bin=
prm *bprm, struct file *f
>  LSM_HOOK(int, 0, bprm_check_security, struct linux_binprm *bprm)
>  LSM_HOOK(void, LSM_RET_VOID, bprm_committing_creds, struct linux_binprm =
*bprm)
>  LSM_HOOK(void, LSM_RET_VOID, bprm_committed_creds, struct linux_binprm *=
bprm)
> +LSM_HOOK(int, 0, fs_context_init, struct fs_context *fc, struct dentry *=
reference)
>  LSM_HOOK(int, 0, fs_context_dup, struct fs_context *fc,
>  	 struct fs_context *src_sc)
>  LSM_HOOK(int, -ENOPARAM, fs_context_parse_param, struct fs_context *fc,
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 91c8146649f5..1782814c7c5b 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -87,8 +87,12 @@
>   * Security hooks for mount using fs_context.
>   *	[See also Documentation/filesystems/mount_api.rst]
>   *
> + * @fs_context_init:
> + *	Initialise fc->security.  This is initialised to NULL by the caller.
> + *	@fc indicates the new filesystem context.
> + *	@dentry indicates a reference for submount/remount
>   * @fs_context_dup:
> - *	Allocate and attach a security structure to sc->security.  This point=
er
> + *	Allocate and attach a security structure to fc->security.  This point=
er
>   *	is initialised to NULL by the caller.
>   *	@fc indicates the new filesystem context.
>   *	@src_fc indicates the original filesystem context.
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 7fc4e9f49f54..94834f699b04 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -291,6 +291,7 @@ int security_bprm_creds_from_file(struct linux_binprm=
 *bprm, struct file *file);
>  int security_bprm_check(struct linux_binprm *bprm);
>  void security_bprm_committing_creds(struct linux_binprm *bprm);
>  void security_bprm_committed_creds(struct linux_binprm *bprm);
> +int security_fs_context_init(struct fs_context *fc, struct dentry *refer=
ence);
>  int security_fs_context_dup(struct fs_context *fc, struct fs_context *sr=
c_fc);
>  int security_fs_context_parse_param(struct fs_context *fc, struct fs_par=
ameter *param);
>  int security_sb_alloc(struct super_block *sb);
> @@ -620,6 +621,11 @@ static inline void security_bprm_committed_creds(str=
uct linux_binprm *bprm)
>  {
>  }
> =20
> +static inline int security_fs_context_init(struct fs_context *fc,
> +					   struct dentry *reference)
> +{
> +	return 0;
> +}
>  static inline int security_fs_context_dup(struct fs_context *fc,
>  					  struct fs_context *src_fc)
>  {
> diff --git a/security/security.c b/security/security.c
> index 188b8f782220..e683027f9424 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -880,6 +880,11 @@ void security_bprm_committed_creds(struct linux_binp=
rm *bprm)
>  	call_void_hook(bprm_committed_creds, bprm);
>  }
> =20
> +int security_fs_context_init(struct fs_context *fc, struct dentry *refer=
ence)
> +{
> +	return call_int_hook(fs_context_init, 0, fc, reference);
> +}
> +

It'd be good to have some LSM folks ack this change.

>  int security_fs_context_dup(struct fs_context *fc, struct fs_context *sr=
c_fc)
>  {
>  	return call_int_hook(fs_context_dup, 0, fc, src_fc);
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 1bbd53321d13..ddeaff4f3bb1 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2768,6 +2768,34 @@ static int selinux_umount(struct vfsmount *mnt, in=
t flags)
>  				   FILESYSTEM__UNMOUNT, NULL);
>  }
> =20
> +static int selinux_fs_context_init(struct fs_context *fc,
> +				   struct dentry *reference)
> +{
> +	const struct superblock_security_struct *sbsec;
> +	const struct inode_security_struct *root_isec;
> +	struct selinux_mnt_opts *opts;
> +
> +	if (fc->purpose =3D=3D FS_CONTEXT_FOR_SUBMOUNT) {
> +		opts =3D kzalloc(sizeof(*opts), GFP_KERNEL);
> +		if (!opts)
> +			return -ENOMEM;
> +
> +		root_isec =3D backing_inode_security(reference->d_sb->s_root);
> +		sbsec =3D selinux_superblock(reference->d_sb);
> +		if (sbsec->flags & FSCONTEXT_MNT)
> +			opts->fscontext_sid	=3D sbsec->sid;
> +		if (sbsec->flags & CONTEXT_MNT)
> +			opts->context_sid	=3D sbsec->mntpoint_sid;
> +		if (sbsec->flags & ROOTCONTEXT_MNT)
> +			opts->rootcontext_sid	=3D root_isec->sid;
> +		if (sbsec->flags & DEFCONTEXT_MNT)
> +			opts->defcontext_sid	=3D sbsec->def_sid;
> +		fc->security =3D opts;
> +	}
> +
> +	return 0;
> +}
> +
>  static int selinux_fs_context_dup(struct fs_context *fc,
>  				  struct fs_context *src_fc)
>  {
> @@ -7239,6 +7267,7 @@ static struct security_hook_list selinux_hooks[] __=
lsm_ro_after_init =3D {
>  	/*
>  	 * PUT "CLONING" (ACCESSING + ALLOCATING) HOOKS HERE
>  	 */
> +	LSM_HOOK_INIT(fs_context_init, selinux_fs_context_init),
>  	LSM_HOOK_INIT(fs_context_dup, selinux_fs_context_dup),
>  	LSM_HOOK_INIT(fs_context_parse_param, selinux_fs_context_parse_param),
>  	LSM_HOOK_INIT(sb_eat_lsm_opts, selinux_sb_eat_lsm_opts),
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 6207762dbdb1..6ba32bb097b5 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -612,6 +612,66 @@ static int smack_add_opt(int token, const char *s, v=
oid **mnt_opts)
>  	return -EINVAL;
>  }
> =20
> +/**
> + * smack_fs_context_init - Initialise security data for a filesystem con=
text
> + * @fc: The filesystem context.
> + * @reference: Reference dentry (automount/reconfigure) or NULL
> + *
> + * Returns 0 on success or -ENOMEM on error.
> + */
> +static int smack_fs_context_init(struct fs_context *fc,
> +				 struct dentry *reference)
> +{
> +	struct superblock_smack *sbsp;
> +	struct smack_mnt_opts *ctx;
> +	struct inode_smack *isp;
> +
> +	ctx =3D kzalloc(sizeof(*ctx), GFP_KERNEL);
> +	if (!ctx)
> +		return -ENOMEM;
> +	fc->security =3D ctx;
> +
> +	if (fc->purpose =3D=3D FS_CONTEXT_FOR_SUBMOUNT) {
> +		sbsp =3D smack_superblock(reference->d_sb);
> +		isp =3D smack_inode(reference->d_sb->s_root->d_inode);
> +
> +		if (sbsp->smk_default) {
> +			ctx->fsdefault =3D kstrdup(sbsp->smk_default->smk_known, GFP_KERNEL);
> +			if (!ctx->fsdefault)
> +				return -ENOMEM;
> +		}
> +
> +		if (sbsp->smk_floor) {
> +			ctx->fsfloor =3D kstrdup(sbsp->smk_floor->smk_known, GFP_KERNEL);
> +			if (!ctx->fsfloor)
> +				return -ENOMEM;
> +		}
> +
> +		if (sbsp->smk_hat) {
> +			ctx->fshat =3D kstrdup(sbsp->smk_hat->smk_known, GFP_KERNEL);
> +			if (!ctx->fshat)
> +				return -ENOMEM;
> +		}
> +
> +
> +		if (isp->smk_flags & SMK_INODE_TRANSMUTE) {
> +			if (sbsp->smk_root) {
> +				ctx->fstransmute =3D kstrdup(sbsp->smk_root->smk_known, GFP_KERNEL);
> +				if (!ctx->fstransmute)
> +					return -ENOMEM;
> +			}
> +		} else {
> +			if (sbsp->smk_root) {
> +				ctx->fsroot =3D kstrdup(sbsp->smk_root->smk_known, GFP_KERNEL);
> +				if (!ctx->fsroot)
> +					return -ENOMEM;
> +			}
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  /**
>   * smack_fs_context_dup - Duplicate the security data on fs_context dupl=
ication
>   * @fc: The new filesystem context.
> @@ -4755,6 +4815,7 @@ static struct security_hook_list smack_hooks[] __ls=
m_ro_after_init =3D {
>  	LSM_HOOK_INIT(ptrace_traceme, smack_ptrace_traceme),
>  	LSM_HOOK_INIT(syslog, smack_syslog),
> =20
> +	LSM_HOOK_INIT(fs_context_init, smack_fs_context_init),
>  	LSM_HOOK_INIT(fs_context_dup, smack_fs_context_dup),
>  	LSM_HOOK_INIT(fs_context_parse_param, smack_fs_context_parse_param),
> =20
>=20
>=20


Reviewed-by: Jeff Layton <jlayton@kernel.org>
Tested-by: Jeff Layton <jlayton@kernel.org>
