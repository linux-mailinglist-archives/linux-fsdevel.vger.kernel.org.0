Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC859772714
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Aug 2023 16:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbjHGOJ3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Aug 2023 10:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjHGOJ1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Aug 2023 10:09:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC3E9E;
        Mon,  7 Aug 2023 07:09:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67BAC61CC3;
        Mon,  7 Aug 2023 14:09:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47DA0C433C8;
        Mon,  7 Aug 2023 14:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691417364;
        bh=w146gKWPpitJxQv5WhKpO3GwODn9+7C1pxjXRO4Rdjs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=OnPDMwMyIYsVeOy2y14LmzIYesQohInbvROcVM0+CY9ovk2sg3DzuFxsKER6+GKwD
         dGh+qJlDTkizEVCPZITP4YlnWSxPSKSw+2dy3BFY9WvFVWlY+wpBKwdhDkvB76g6E7
         cxXITk2B17VkdZ3j0Nh2yw7Y6pSGSRCi9iYGRTaKftbmjjKkSA5Y1LP1wk4eCBVEGf
         zstlSmpw3fjVbgqxTWkq5MLMTxDvvES1TLYlVKn0bGQ1jacQZ1eQjoNYDaUUPbHGmM
         hUmUX023TxtKbXluAWxqSmpA4bNCG51Eg4MxeXYx5Uybc6XGT3MkvX+wGYVRDEbud9
         eQBTt6ip2IgJA==
Message-ID: <5e32555a701602603681d0e08df86e398f7f025d.camel@kernel.org>
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
Date:   Mon, 07 Aug 2023 10:09:21 -0400
In-Reply-To: <20230807-ohrfeigen-misswirtschaft-29303ebbc83b@brauner>
References: <20230807-master-v8-1-54e249595f10@kernel.org>
         <20230807-ohrfeigen-misswirtschaft-29303ebbc83b@brauner>
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

On Mon, 2023-08-07 at 15:38 +0200, Christian Brauner wrote:
> On Mon, Aug 07, 2023 at 09:18:01AM -0400, Jeff Layton wrote:
> > From: David Howells <dhowells@redhat.com>
> >=20
> > When NFS superblocks are created by automounting, their LSM parameters
> > aren't set in the fs_context struct prior to sget_fc() being called,
> > leading to failure to match existing superblocks.
> >=20
> > This bug leads to messages like the following appearing in dmesg when
> > fscache is enabled:
> >=20
> >     NFS: Cache volume key already in use (nfs,4.2,2,108,106a8c0,1,,,,10=
0000,100000,2ee,3a98,1d4c,3a98,1)
> >=20
> > Fix this by adding a new LSM hook to load fc->security for submount
> > creation.
> >=20
> > Signed-off-by: David Howells <dhowells@redhat.com>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > Fixes: 9bc61ab18b1d ("vfs: Introduce fs_context, switch vfs_kern_mount(=
) to it.")
> > Fixes: 779df6a5480f ("NFS: Ensure security label is set for root inode)
> > Tested-by: Jeff Layton <jlayton@kernel.org>
> > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> > Acked-by: "Christian Brauner (Microsoft)" <brauner@kernel.org>
> > Link: https://lore.kernel.org/r/165962680944.3334508.661002390034914203=
4.stgit@warthog.procyon.org.uk/ # v1
> > Link: https://lore.kernel.org/r/165962729225.3357250.143507288464715271=
37.stgit@warthog.procyon.org.uk/ # v2
> > Link: https://lore.kernel.org/r/165970659095.2812394.686889417110231879=
6.stgit@warthog.procyon.org.uk/ # v3
> > Link: https://lore.kernel.org/r/166133579016.3678898.628319501948056727=
5.stgit@warthog.procyon.org.uk/ # v4
> > Link: https://lore.kernel.org/r/217595.1662033775@warthog.procyon.org.u=
k/ # v5
> > ---
> > ver #2)
> > - Added Smack support
> > - Made LSM parameter extraction dependent on reference !=3D NULL.
> >=20
> > ver #3)
> > - Made LSM parameter extraction dependent on fc->purpose =3D=3D
> >    FS_CONTEXT_FOR_SUBMOUNT.  Shouldn't happen on FOR_RECONFIGURE.
> >=20
> > ver #4)
> > - When doing a FOR_SUBMOUNT mount, don't set the root label in SELinux =
or Smack.
> >=20
> > ver #5)
> > - Removed unused variable.
> > - Only allocate smack_mnt_opts if we're dealing with a submount.
> >=20
> > ver #6)
> > - Rebase onto v6.5.0-rc4
> > - Link to v6: https://lore.kernel.org/r/20230802-master-v6-1-45d4829916=
8b@kernel.org
> >=20
> > ver #7)
> > - Drop lsm_set boolean
> > - Link to v7: https://lore.kernel.org/r/20230804-master-v7-1-5d4e484072=
98@kernel.org
> >=20
> > ver #8)
> > - Remove spurious semicolon in smack_fs_context_init
> > - Make fs_context_init take a superblock as reference instead of dentry
> > - WARN_ON_ONCE's when fc->purpose !=3D FS_CONTEXT_FOR_SUBMOUNT
> > - Call the security hook from fs_context_for_submount instead of alloc_=
fs_context
> > ---
> >  fs/fs_context.c               | 23 +++++++++++++++++-
> >  include/linux/lsm_hook_defs.h |  1 +
> >  include/linux/security.h      |  6 +++++
> >  security/security.c           | 14 +++++++++++
> >  security/selinux/hooks.c      | 25 ++++++++++++++++++++
> >  security/smack/smack_lsm.c    | 54 +++++++++++++++++++++++++++++++++++=
++++++++
> >  6 files changed, 122 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/fs/fs_context.c b/fs/fs_context.c
> > index 851214d1d013..a76d7c82e091 100644
> > --- a/fs/fs_context.c
> > +++ b/fs/fs_context.c
> > @@ -315,10 +315,31 @@ struct fs_context *fs_context_for_reconfigure(str=
uct dentry *dentry,
> >  }
> >  EXPORT_SYMBOL(fs_context_for_reconfigure);
> > =20
> > +/**
> > + * fs_context_for_submount: allocate a new fs_context for a submount
> > + * @type: file_system_type of the new context
> > + * @reference: reference dentry from which to copy relevant info
> > + *
> > + * Allocate a new fs_context suitable for a submount. This also ensure=
s that
> > + * the fc->security object is inherited from @reference (if needed).
> > + */
> >  struct fs_context *fs_context_for_submount(struct file_system_type *ty=
pe,
> >  					   struct dentry *reference)
> >  {
> > -	return alloc_fs_context(type, reference, 0, 0, FS_CONTEXT_FOR_SUBMOUN=
T);
> > +	struct fs_context *fc;
> > +	int ret;
> > +
> > +	fc =3D alloc_fs_context(type, reference, 0, 0, FS_CONTEXT_FOR_SUBMOUN=
T);
> > +	if (IS_ERR(fc))
> > +		return fc;
> > +
> > +	ret =3D security_fs_context_init(fc, reference->d_sb);
> > +	if (ret) {
> > +		put_fs_context(fc);
> > +		return ERR_PTR(ret);
> > +	}
> > +
> > +	return fc;
> >  }
> >  EXPORT_SYMBOL(fs_context_for_submount);
> > =20
> > diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_def=
s.h
> > index 7308a1a7599b..2876dd6114c0 100644
> > --- a/include/linux/lsm_hook_defs.h
> > +++ b/include/linux/lsm_hook_defs.h
> > @@ -54,6 +54,7 @@ LSM_HOOK(int, 0, bprm_creds_from_file, struct linux_b=
inprm *bprm, struct file *f
> >  LSM_HOOK(int, 0, bprm_check_security, struct linux_binprm *bprm)
> >  LSM_HOOK(void, LSM_RET_VOID, bprm_committing_creds, struct linux_binpr=
m *bprm)
> >  LSM_HOOK(void, LSM_RET_VOID, bprm_committed_creds, struct linux_binprm=
 *bprm)
> > +LSM_HOOK(int, 0, fs_context_init, struct fs_context *fc, struct super_=
block *reference)
> >  LSM_HOOK(int, 0, fs_context_dup, struct fs_context *fc,
> >  	 struct fs_context *src_sc)
> >  LSM_HOOK(int, -ENOPARAM, fs_context_parse_param, struct fs_context *fc=
,
> > diff --git a/include/linux/security.h b/include/linux/security.h
> > index 32828502f09e..fe9bf5e805ee 100644
> > --- a/include/linux/security.h
> > +++ b/include/linux/security.h
> > @@ -293,6 +293,7 @@ int security_bprm_creds_from_file(struct linux_binp=
rm *bprm, struct file *file);
> >  int security_bprm_check(struct linux_binprm *bprm);
> >  void security_bprm_committing_creds(struct linux_binprm *bprm);
> >  void security_bprm_committed_creds(struct linux_binprm *bprm);
> > +int security_fs_context_init(struct fs_context *fc, struct super_block=
 *reference);
> >  int security_fs_context_dup(struct fs_context *fc, struct fs_context *=
src_fc);
> >  int security_fs_context_parse_param(struct fs_context *fc, struct fs_p=
arameter *param);
> >  int security_sb_alloc(struct super_block *sb);
> > @@ -629,6 +630,11 @@ static inline void security_bprm_committed_creds(s=
truct linux_binprm *bprm)
> >  {
> >  }
> > =20
> > +static inline int security_fs_context_init(struct fs_context *fc,
> > +					   struct super_block *reference)
> > +{
> > +	return 0;
> > +}
>=20
> Sorry, my point is we shouldn't be adding a generic
> security_fs_context_init() hook at all. Pre superblock creation we have
> a hook during parameter parsing for LSMs and another one during actual
> superblock creation in vfs_get_tree() and yet another one for fs_context
> duplicaton. We don't need another generic one during fs_context
> allocation.
>=20
> Yes, we may need a hook for submount allocation but then we'll add one
> exactly for that. And then for fs_context_for_submount @sb can't be
> empty so there's also no point in checking whether it is empty because
> you've already crashed in fs_context_for_submount(). All the checks
> below for !reference and fc->purpose !=3D FS_CONTEXT_FOR_SUBMOUNT can go
> away then as well.
>=20
> So we end up with something easier and stricter.
>=20

I'm not sure I understand what you're asking for here. fc->security
field initialization is dependent on the LSM in use. Where will we do
this initialization if we don't add this new hook? Are you suggesting
that we fold this into an existing LSM hook? If so, which one?


> >  static inline int security_fs_context_dup(struct fs_context *fc,
> >  					  struct fs_context *src_fc)
> >  {
> > diff --git a/security/security.c b/security/security.c
> > index b720424ca37d..f8a666d089f9 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -1138,6 +1138,20 @@ void security_bprm_committed_creds(struct linux_=
binprm *bprm)
> >  	call_void_hook(bprm_committed_creds, bprm);
> >  }
> > =20
> > +/**
> > + * security_fs_context_init() - Initialise fc->security
> > + * @fc: new filesystem context
> > + * @reference: dentry reference for submount/remount
> > + *
> > + * Fill out the ->security field for a new fs_context.
> > + *
> > + * Return: Returns 0 on success or negative error code on failure.
> > + */
> > +int security_fs_context_init(struct fs_context *fc, struct super_block=
 *reference)
> > +{
> > +	return call_int_hook(fs_context_init, 0, fc, reference);
> > +}
> > +
> >  /**
> >   * security_fs_context_dup() - Duplicate a fs_context LSM blob
> >   * @fc: destination filesystem context
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index d06e350fedee..c8fb0d77104f 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -2745,6 +2745,30 @@ static int selinux_umount(struct vfsmount *mnt, =
int flags)
> >  				   FILESYSTEM__UNMOUNT, NULL);
> >  }
> > =20
> > +static int selinux_fs_context_init(struct fs_context *fc,
> > +				   struct super_block *reference)
> > +{
> > +	const struct superblock_security_struct *sbsec;
> > +	struct selinux_mnt_opts *opts;
> > +
> > +	if (!reference || WARN_ON_ONCE(fc->purpose !=3D FS_CONTEXT_FOR_SUBMOU=
NT))
> > +		return 0;

--=20
Jeff Layton <jlayton@kernel.org>
