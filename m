Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A88AB774321
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 19:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbjHHR5Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Aug 2023 13:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233926AbjHHR4r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:56:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A78BF57A;
        Tue,  8 Aug 2023 09:25:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A44E662486;
        Tue,  8 Aug 2023 10:28:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B93C433C8;
        Tue,  8 Aug 2023 10:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691490527;
        bh=D7YmICW6P8bXrD+Z4rOAlT+hwdfL7F9gMbM83pCYo6o=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=EO2hsK9fOJerXjtrqwdrIAm5GtvxXrcreOr47Z/Rz8msVInZAEyhNWjlm/ZOSjl3W
         Ix0AGLVziLsybhh9sk03ZMKCzegHikNxfxSreSYe7CBV1s1fJ3n/ouQ8abkPRibMd/
         oCIXZ0AmD34/66Dh9TEGCaGG8RzsO3SscCZbGfeSpR6PfvWL8G+wJ20FRpSF9drn6P
         gBpkU4H240pZ+ulDy/C09Rn8K5v0/uxJo29w1XkX59mjIQhTcS2gjqF23tng2sLwvF
         T0vbkeTmQ+yyUJel4C4zSwzdbTFpJ8HPvtkicrXluHckUByUBTTMqCnQEsW5Hc9WlC
         dzAA62wJzmKVQ==
Message-ID: <b361709474e942fdbb0f4aee6e8d20325efbd5df.camel@kernel.org>
Subject: Re: [PATCH v8] vfs, security: Fix automount superblock LSM init
 problem, preventing NFS sb sharing
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        David Howells <dhowells@redhat.com>,
        Scott Mayhew <smayhew@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Date:   Tue, 08 Aug 2023 06:28:44 -0400
In-Reply-To: <20230808-zuckt-nachahmen-f51625f111f3@brauner>
References: <20230807-master-v8-1-54e249595f10@kernel.org>
         <20230807-ohrfeigen-misswirtschaft-29303ebbc83b@brauner>
         <5e32555a701602603681d0e08df86e398f7f025d.camel@kernel.org>
         <20230808-zuckt-nachahmen-f51625f111f3@brauner>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2023-08-08 at 10:53 +0200, Christian Brauner wrote:
> On Mon, Aug 07, 2023 at 10:09:21AM -0400, Jeff Layton wrote:
> > On Mon, 2023-08-07 at 15:38 +0200, Christian Brauner wrote:
> > > On Mon, Aug 07, 2023 at 09:18:01AM -0400, Jeff Layton wrote:
> > > > From: David Howells <dhowells@redhat.com>
> > > >=20
> > > > When NFS superblocks are created by automounting, their LSM paramet=
ers
> > > > aren't set in the fs_context struct prior to sget_fc() being called=
,
> > > > leading to failure to match existing superblocks.
> > > >=20
> > > > This bug leads to messages like the following appearing in dmesg wh=
en
> > > > fscache is enabled:
> > > >=20
> > > >     NFS: Cache volume key already in use (nfs,4.2,2,108,106a8c0,1,,=
,,100000,100000,2ee,3a98,1d4c,3a98,1)
> > > >=20
> > > > Fix this by adding a new LSM hook to load fc->security for submount
> > > > creation.
> > > >=20
> > > > Signed-off-by: David Howells <dhowells@redhat.com>
> > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > Fixes: 9bc61ab18b1d ("vfs: Introduce fs_context, switch vfs_kern_mo=
unt() to it.")
> > > > Fixes: 779df6a5480f ("NFS: Ensure security label is set for root in=
ode)
> > > > Tested-by: Jeff Layton <jlayton@kernel.org>
> > > > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > > > Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> > > > Acked-by: "Christian Brauner (Microsoft)" <brauner@kernel.org>
> > > > Link: https://lore.kernel.org/r/165962680944.3334508.66100239003491=
42034.stgit@warthog.procyon.org.uk/ # v1
> > > > Link: https://lore.kernel.org/r/165962729225.3357250.14350728846471=
527137.stgit@warthog.procyon.org.uk/ # v2
> > > > Link: https://lore.kernel.org/r/165970659095.2812394.68688941711023=
18796.stgit@warthog.procyon.org.uk/ # v3
> > > > Link: https://lore.kernel.org/r/166133579016.3678898.62831950194805=
67275.stgit@warthog.procyon.org.uk/ # v4
> > > > Link: https://lore.kernel.org/r/217595.1662033775@warthog.procyon.o=
rg.uk/ # v5
> > > > ---
> > > > ver #2)
> > > > - Added Smack support
> > > > - Made LSM parameter extraction dependent on reference !=3D NULL.
> > > >=20
> > > > ver #3)
> > > > - Made LSM parameter extraction dependent on fc->purpose =3D=3D
> > > >    FS_CONTEXT_FOR_SUBMOUNT.  Shouldn't happen on FOR_RECONFIGURE.
> > > >=20
> > > > ver #4)
> > > > - When doing a FOR_SUBMOUNT mount, don't set the root label in SELi=
nux or Smack.
> > > >=20
> > > > ver #5)
> > > > - Removed unused variable.
> > > > - Only allocate smack_mnt_opts if we're dealing with a submount.
> > > >=20
> > > > ver #6)
> > > > - Rebase onto v6.5.0-rc4
> > > > - Link to v6: https://lore.kernel.org/r/20230802-master-v6-1-45d482=
99168b@kernel.org
> > > >=20
> > > > ver #7)
> > > > - Drop lsm_set boolean
> > > > - Link to v7: https://lore.kernel.org/r/20230804-master-v7-1-5d4e48=
407298@kernel.org
> > > >=20
> > > > ver #8)
> > > > - Remove spurious semicolon in smack_fs_context_init
> > > > - Make fs_context_init take a superblock as reference instead of de=
ntry
> > > > - WARN_ON_ONCE's when fc->purpose !=3D FS_CONTEXT_FOR_SUBMOUNT
> > > > - Call the security hook from fs_context_for_submount instead of al=
loc_fs_context
> > > > ---
> > > >  fs/fs_context.c               | 23 +++++++++++++++++-
> > > >  include/linux/lsm_hook_defs.h |  1 +
> > > >  include/linux/security.h      |  6 +++++
> > > >  security/security.c           | 14 +++++++++++
> > > >  security/selinux/hooks.c      | 25 ++++++++++++++++++++
> > > >  security/smack/smack_lsm.c    | 54 +++++++++++++++++++++++++++++++=
++++++++++++
> > > >  6 files changed, 122 insertions(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/fs/fs_context.c b/fs/fs_context.c
> > > > index 851214d1d013..a76d7c82e091 100644
> > > > --- a/fs/fs_context.c
> > > > +++ b/fs/fs_context.c
> > > > @@ -315,10 +315,31 @@ struct fs_context *fs_context_for_reconfigure=
(struct dentry *dentry,
> > > >  }
> > > >  EXPORT_SYMBOL(fs_context_for_reconfigure);
> > > > =20
> > > > +/**
> > > > + * fs_context_for_submount: allocate a new fs_context for a submou=
nt
> > > > + * @type: file_system_type of the new context
> > > > + * @reference: reference dentry from which to copy relevant info
> > > > + *
> > > > + * Allocate a new fs_context suitable for a submount. This also en=
sures that
> > > > + * the fc->security object is inherited from @reference (if needed=
).
> > > > + */
> > > >  struct fs_context *fs_context_for_submount(struct file_system_type=
 *type,
> > > >  					   struct dentry *reference)
> > > >  {
> > > > -	return alloc_fs_context(type, reference, 0, 0, FS_CONTEXT_FOR_SUB=
MOUNT);
> > > > +	struct fs_context *fc;
> > > > +	int ret;
> > > > +
> > > > +	fc =3D alloc_fs_context(type, reference, 0, 0, FS_CONTEXT_FOR_SUB=
MOUNT);
> > > > +	if (IS_ERR(fc))
> > > > +		return fc;
> > > > +
> > > > +	ret =3D security_fs_context_init(fc, reference->d_sb);
> > > > +	if (ret) {
> > > > +		put_fs_context(fc);
> > > > +		return ERR_PTR(ret);
> > > > +	}
> > > > +
> > > > +	return fc;
> > > >  }
> > > >  EXPORT_SYMBOL(fs_context_for_submount);
> > > > =20
> > > > diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook=
_defs.h
> > > > index 7308a1a7599b..2876dd6114c0 100644
> > > > --- a/include/linux/lsm_hook_defs.h
> > > > +++ b/include/linux/lsm_hook_defs.h
> > > > @@ -54,6 +54,7 @@ LSM_HOOK(int, 0, bprm_creds_from_file, struct lin=
ux_binprm *bprm, struct file *f
> > > >  LSM_HOOK(int, 0, bprm_check_security, struct linux_binprm *bprm)
> > > >  LSM_HOOK(void, LSM_RET_VOID, bprm_committing_creds, struct linux_b=
inprm *bprm)
> > > >  LSM_HOOK(void, LSM_RET_VOID, bprm_committed_creds, struct linux_bi=
nprm *bprm)
> > > > +LSM_HOOK(int, 0, fs_context_init, struct fs_context *fc, struct su=
per_block *reference)
> > > >  LSM_HOOK(int, 0, fs_context_dup, struct fs_context *fc,
> > > >  	 struct fs_context *src_sc)
> > > >  LSM_HOOK(int, -ENOPARAM, fs_context_parse_param, struct fs_context=
 *fc,
> > > > diff --git a/include/linux/security.h b/include/linux/security.h
> > > > index 32828502f09e..fe9bf5e805ee 100644
> > > > --- a/include/linux/security.h
> > > > +++ b/include/linux/security.h
> > > > @@ -293,6 +293,7 @@ int security_bprm_creds_from_file(struct linux_=
binprm *bprm, struct file *file);
> > > >  int security_bprm_check(struct linux_binprm *bprm);
> > > >  void security_bprm_committing_creds(struct linux_binprm *bprm);
> > > >  void security_bprm_committed_creds(struct linux_binprm *bprm);
> > > > +int security_fs_context_init(struct fs_context *fc, struct super_b=
lock *reference);
> > > >  int security_fs_context_dup(struct fs_context *fc, struct fs_conte=
xt *src_fc);
> > > >  int security_fs_context_parse_param(struct fs_context *fc, struct =
fs_parameter *param);
> > > >  int security_sb_alloc(struct super_block *sb);
> > > > @@ -629,6 +630,11 @@ static inline void security_bprm_committed_cre=
ds(struct linux_binprm *bprm)
> > > >  {
> > > >  }
> > > > =20
> > > > +static inline int security_fs_context_init(struct fs_context *fc,
> > > > +					   struct super_block *reference)
> > > > +{
> > > > +	return 0;
> > > > +}
> > >=20
> > > Sorry, my point is we shouldn't be adding a generic
> > > security_fs_context_init() hook at all. Pre superblock creation we ha=
ve
> > > a hook during parameter parsing for LSMs and another one during actua=
l
> > > superblock creation in vfs_get_tree() and yet another one for fs_cont=
ext
> > > duplicaton. We don't need another generic one during fs_context
> > > allocation.
> > >=20
> > > Yes, we may need a hook for submount allocation but then we'll add on=
e
> > > exactly for that. And then for fs_context_for_submount @sb can't be
> > > empty so there's also no point in checking whether it is empty becaus=
e
> > > you've already crashed in fs_context_for_submount(). All the checks
> > > below for !reference and fc->purpose !=3D FS_CONTEXT_FOR_SUBMOUNT can=
 go
> > > away then as well.
> > >=20
> > > So we end up with something easier and stricter.
> > >=20
> >=20
> > I'm not sure I understand what you're asking for here. fc->security
> > field initialization is dependent on the LSM in use. Where will we do
> > this initialization if we don't add this new hook? Are you suggesting
> > that we fold this into an existing LSM hook? If so, which one?
>=20
> I'm sorry, I didn't mean to confuse. I just mean the following:
> * renaming security_fs_context_init() to security_fs_context_submount()
>   to reflect that it is only called during submount allocation now
> * Now that security_fs_context_submount() is called in
>   fs_context_for_submount() you can remove all the checks for @reference
>   and fc->purpose =3D=3D FS_CONTEXT_FOR_SUBMOUNT checks because they can'=
t
>   be unset otherwise you would've a bug in fs_context_for_submount().
>=20
> These two things were missing after you did move the LSM call into
> fs_context_for_submount(). That's basically it. So folded into what you
> sent out this amounts to:
>=20

Thanks, I'll fold those changes into this patch and resend. There's also
a bug that the kernel test robot spotted in SMACK code that I'll fix as
well. I'll send v9 after I've had a chance to retest the changes.

>  fs/fs_context.c               | 23 +++++++++++++++-
>  include/linux/lsm_hook_defs.h |  1 +
>  include/linux/security.h      |  6 +++++
>  security/security.c           | 14 ++++++++++
>  security/selinux/hooks.c      | 22 +++++++++++++++
>  security/smack/smack_lsm.c    | 51 +++++++++++++++++++++++++++++++++++
>  6 files changed, 116 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/fs_context.c b/fs/fs_context.c
> index 851214d1d013..375023e40161 100644
> --- a/fs/fs_context.c
> +++ b/fs/fs_context.c
> @@ -315,10 +315,31 @@ struct fs_context *fs_context_for_reconfigure(struc=
t dentry *dentry,
>  }
>  EXPORT_SYMBOL(fs_context_for_reconfigure);
> =20
> +/**
> + * fs_context_for_submount: allocate a new fs_context for a submount
> + * @type: file_system_type of the new context
> + * @reference: reference dentry from which to copy relevant info
> + *
> + * Allocate a new fs_context suitable for a submount. This also ensures =
that
> + * the fc->security object is inherited from @reference (if needed).
> + */
>  struct fs_context *fs_context_for_submount(struct file_system_type *type=
,
>  					   struct dentry *reference)
>  {
> -	return alloc_fs_context(type, reference, 0, 0, FS_CONTEXT_FOR_SUBMOUNT)=
;
> +	struct fs_context *fc;
> +	int ret;
> +
> +	fc =3D alloc_fs_context(type, reference, 0, 0, FS_CONTEXT_FOR_SUBMOUNT)=
;
> +	if (IS_ERR(fc))
> +		return fc;
> +
> +	ret =3D security_fs_context_submount(fc, reference->d_sb);
> +	if (ret) {
> +		put_fs_context(fc);
> +		return ERR_PTR(ret);
> +	}
> +
> +	return fc;
>  }
>  EXPORT_SYMBOL(fs_context_for_submount);
> =20
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.=
h
> index 7308a1a7599b..2876dd6114c0 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -54,6 +54,7 @@ LSM_HOOK(int, 0, bprm_creds_from_file, struct linux_bin=
prm *bprm, struct file *f
>  LSM_HOOK(int, 0, bprm_check_security, struct linux_binprm *bprm)
>  LSM_HOOK(void, LSM_RET_VOID, bprm_committing_creds, struct linux_binprm =
*bprm)
>  LSM_HOOK(void, LSM_RET_VOID, bprm_committed_creds, struct linux_binprm *=
bprm)
> +LSM_HOOK(int, 0, fs_context_init, struct fs_context *fc, struct super_bl=
ock *reference)
>  LSM_HOOK(int, 0, fs_context_dup, struct fs_context *fc,
>  	 struct fs_context *src_sc)
>  LSM_HOOK(int, -ENOPARAM, fs_context_parse_param, struct fs_context *fc,
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 32828502f09e..02b41f4d05d1 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -293,6 +293,7 @@ int security_bprm_creds_from_file(struct linux_binprm=
 *bprm, struct file *file);
>  int security_bprm_check(struct linux_binprm *bprm);
>  void security_bprm_committing_creds(struct linux_binprm *bprm);
>  void security_bprm_committed_creds(struct linux_binprm *bprm);
> +int security_fs_context_submount(struct fs_context *fc, struct super_blo=
ck *reference);
>  int security_fs_context_dup(struct fs_context *fc, struct fs_context *sr=
c_fc);
>  int security_fs_context_parse_param(struct fs_context *fc, struct fs_par=
ameter *param);
>  int security_sb_alloc(struct super_block *sb);
> @@ -629,6 +630,11 @@ static inline void security_bprm_committed_creds(str=
uct linux_binprm *bprm)
>  {
>  }
> =20
> +static inline int security_fs_context_submount(struct fs_context *fc,
> +					       struct super_block *reference)
> +{
> +	return 0;
> +}
>  static inline int security_fs_context_dup(struct fs_context *fc,
>  					  struct fs_context *src_fc)
>  {
> diff --git a/security/security.c b/security/security.c
> index b720424ca37d..3611ebdf31d9 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1138,6 +1138,20 @@ void security_bprm_committed_creds(struct linux_bi=
nprm *bprm)
>  	call_void_hook(bprm_committed_creds, bprm);
>  }
> =20
> +/**
> + * security_fs_context_submount() - Initialise fc->security
> + * @fc: new filesystem context
> + * @reference: dentry reference for submount/remount
> + *
> + * Fill out the ->security field for a new fs_context.
> + *
> + * Return: Returns 0 on success or negative error code on failure.
> + */
> +int security_fs_context_submount(struct fs_context *fc, struct super_blo=
ck *reference)
> +{
> +	return call_int_hook(fs_context_init, 0, fc, reference);
> +}
> +
>  /**
>   * security_fs_context_dup() - Duplicate a fs_context LSM blob
>   * @fc: destination filesystem context
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index d06e350fedee..8b950274138b 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2745,6 +2745,27 @@ static int selinux_umount(struct vfsmount *mnt, in=
t flags)
>  				   FILESYSTEM__UNMOUNT, NULL);
>  }
> =20
> +static int selinux_fs_context_submount(struct fs_context *fc,
> +				       struct super_block *reference)
> +{
> +	const struct superblock_security_struct *sbsec;
> +	struct selinux_mnt_opts *opts;
> +
> +	opts =3D kzalloc(sizeof(*opts), GFP_KERNEL);
> +	if (!opts)
> +		return -ENOMEM;
> +
> +	sbsec =3D selinux_superblock(reference);
> +	if (sbsec->flags & FSCONTEXT_MNT)
> +		opts->fscontext_sid =3D sbsec->sid;
> +	if (sbsec->flags & CONTEXT_MNT)
> +		opts->context_sid =3D sbsec->mntpoint_sid;
> +	if (sbsec->flags & DEFCONTEXT_MNT)
> +		opts->defcontext_sid =3D sbsec->def_sid;
> +	fc->security =3D opts;
> +	return 0;
> +}
> +
>  static int selinux_fs_context_dup(struct fs_context *fc,
>  				  struct fs_context *src_fc)
>  {
> @@ -7182,6 +7203,7 @@ static struct security_hook_list selinux_hooks[] __=
ro_after_init =3D {
>  	/*
>  	 * PUT "CLONING" (ACCESSING + ALLOCATING) HOOKS HERE
>  	 */
> +	LSM_HOOK_INIT(fs_context_submount, selinux_fs_context_submount),
>  	LSM_HOOK_INIT(fs_context_dup, selinux_fs_context_dup),
>  	LSM_HOOK_INIT(fs_context_parse_param, selinux_fs_context_parse_param),
>  	LSM_HOOK_INIT(sb_eat_lsm_opts, selinux_sb_eat_lsm_opts),
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 6e270cf3fd30..87f7e0506f4d 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -614,6 +614,56 @@ static int smack_add_opt(int token, const char *s, v=
oid **mnt_opts)
>  	return -EINVAL;
>  }
> =20
> +/**
> + * smack_fs_context_submount - Initialise security data for a filesystem=
 context
> + * @fc: The filesystem context.
> + * @reference: Reference superblock (automount/reconfigure) or NULL
> + *
> + * Returns 0 on success or -ENOMEM on error.
> + */
> +static int smack_fs_context_submount(struct fs_context *fc,
> +				     struct dentry *reference)
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
> +	sbsp =3D smack_superblock(reference);
> +	isp =3D smack_inode(reference->s_root->d_inode);
> +
> +	if (sbsp->smk_default) {
> +		ctx->fsdefault =3D kstrdup(sbsp->smk_default->smk_known, GFP_KERNEL);
> +		if (!ctx->fsdefault)
> +			return -ENOMEM;
> +	}
> +
> +	if (sbsp->smk_floor) {
> +		ctx->fsfloor =3D kstrdup(sbsp->smk_floor->smk_known, GFP_KERNEL);
> +		if (!ctx->fsfloor)
> +			return -ENOMEM;
> +	}
> +
> +	if (sbsp->smk_hat) {
> +		ctx->fshat =3D kstrdup(sbsp->smk_hat->smk_known, GFP_KERNEL);
> +		if (!ctx->fshat)
> +			return -ENOMEM;
> +	}
> +
> +	if (isp->smk_flags & SMK_INODE_TRANSMUTE) {
> +		if (sbsp->smk_root) {
> +			ctx->fstransmute =3D kstrdup(sbsp->smk_root->smk_known, GFP_KERNEL);
> +			if (!ctx->fstransmute)
> +				return -ENOMEM;
> +		}
> +	}
> +	return 0;
> +}
> +
>  /**
>   * smack_fs_context_dup - Duplicate the security data on fs_context dupl=
ication
>   * @fc: The new filesystem context.
> @@ -4876,6 +4926,7 @@ static struct security_hook_list smack_hooks[] __ro=
_after_init =3D {
>  	LSM_HOOK_INIT(ptrace_traceme, smack_ptrace_traceme),
>  	LSM_HOOK_INIT(syslog, smack_syslog),
> =20
> +	LSM_HOOK_INIT(fs_context_submount, smack_fs_context_submount),
>  	LSM_HOOK_INIT(fs_context_dup, smack_fs_context_dup),
>  	LSM_HOOK_INIT(fs_context_parse_param, smack_fs_context_parse_param),
> =20

--=20
Jeff Layton <jlayton@kernel.org>
