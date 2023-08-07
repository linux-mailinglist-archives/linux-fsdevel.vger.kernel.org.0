Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203507724CB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Aug 2023 14:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233653AbjHGM5J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Aug 2023 08:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232548AbjHGM5J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Aug 2023 08:57:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1DE10FD;
        Mon,  7 Aug 2023 05:57:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93BF5619EC;
        Mon,  7 Aug 2023 12:57:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69D66C433C9;
        Mon,  7 Aug 2023 12:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691413026;
        bh=mt1uuFOc8AlyTQ1K8cBuzB7Csp9E0a8Jlb1PTdNlCp0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=jAy5x1jASO3bVRPC78HEg0wHowcZoXtyllawrTdBEwQgceCCOovenUYMXV4Ph/dRD
         RBukby2R3Ud+sLX3uZv7UGsK1zfOSPF9+Bu/RBqOnc3jYbCDWk/BoGxPgA/2r3r6zw
         zgFILbbA7pRWxUNxWgrHvykIc4rpB74nklYVAefu15qE1grPgMC9I1dNFH1O3azBJL
         B0EMkt/MfnUWT/Vnd7j37m2uoiMZBR13TPOCn7veRdC7bU/OWsOPxK9GlD6nWfkcGl
         b2HU9SxG+xncyjJxEhNeQi+7jFjsg2u7frLL+YMTW2c3t6s5fPgfdKU6A2xhd8GrGi
         M4dW1B0/4b1ig==
Message-ID: <650f7b6ea6b55de4c9cbc791af0da4f800907c21.camel@kernel.org>
Subject: Re: [PATCH v7] vfs, security: Fix automount superblock LSM init
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
Date:   Mon, 07 Aug 2023 08:57:03 -0400
In-Reply-To: <20230805-anrechnen-medien-c639c85ebd42@brauner>
References: <20230804-master-v7-1-5d4e48407298@kernel.org>
         <20230805-anrechnen-medien-c639c85ebd42@brauner>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 2023-08-05 at 14:43 +0200, Christian Brauner wrote:
> On Fri, Aug 04, 2023 at 12:09:34PM -0400, Jeff Layton wrote:
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
> > creation when alloc_fs_context() is creating the fs_context for it.
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
> > ver #7)
> >  - Drop lsm_set boolean
> >  - Link to v6: https://lore.kernel.org/r/20230802-master-v6-1-45d482991=
68b@kernel.org
> >=20
> > ver #6)
> >  - Rebase onto v6.5.0-rc4
> >=20
> > ver #5)
> >  - Removed unused variable.
> >  - Only allocate smack_mnt_opts if we're dealing with a submount.
> >=20
> > ver #4)
> >  - When doing a FOR_SUBMOUNT mount, don't set the root label in SELinux=
 or
> >    Smack.
> >=20
> > ver #3)
> >  - Made LSM parameter extraction dependent on fc->purpose =3D=3D
> >    FS_CONTEXT_FOR_SUBMOUNT.  Shouldn't happen on FOR_RECONFIGURE.
> >=20
> > ver #2)
> >  - Added Smack support
> >  - Made LSM parameter extraction dependent on reference !=3D NULL.
> > ---
> >  fs/fs_context.c               |  4 ++++
> >  include/linux/lsm_hook_defs.h |  1 +
> >  include/linux/security.h      |  6 +++++
> >  security/security.c           | 14 +++++++++++
> >  security/selinux/hooks.c      | 25 ++++++++++++++++++++
> >  security/smack/smack_lsm.c    | 54 +++++++++++++++++++++++++++++++++++=
++++++++
> >  6 files changed, 104 insertions(+)
> >=20
> > diff --git a/fs/fs_context.c b/fs/fs_context.c
> > index 851214d1d013..a523aea956c4 100644
> > --- a/fs/fs_context.c
> > +++ b/fs/fs_context.c
> > @@ -282,6 +282,10 @@ static struct fs_context *alloc_fs_context(struct =
file_system_type *fs_type,
> >  		break;
> >  	}
> > =20
> > +	ret =3D security_fs_context_init(fc, reference);
> > +	if (ret < 0)
> > +		goto err_fc;
> > +
> >  	/* TODO: Make all filesystems support this unconditionally */
> >  	init_fs_context =3D fc->fs_type->init_fs_context;
> >  	if (!init_fs_context)
> > diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_def=
s.h
> > index 7308a1a7599b..7ce3550154b1 100644
> > --- a/include/linux/lsm_hook_defs.h
> > +++ b/include/linux/lsm_hook_defs.h
> > @@ -54,6 +54,7 @@ LSM_HOOK(int, 0, bprm_creds_from_file, struct linux_b=
inprm *bprm, struct file *f
> >  LSM_HOOK(int, 0, bprm_check_security, struct linux_binprm *bprm)
> >  LSM_HOOK(void, LSM_RET_VOID, bprm_committing_creds, struct linux_binpr=
m *bprm)
> >  LSM_HOOK(void, LSM_RET_VOID, bprm_committed_creds, struct linux_binprm=
 *bprm)
> > +LSM_HOOK(int, 0, fs_context_init, struct fs_context *fc, struct dentry=
 *reference)
> >  LSM_HOOK(int, 0, fs_context_dup, struct fs_context *fc,
> >  	 struct fs_context *src_sc)
> >  LSM_HOOK(int, -ENOPARAM, fs_context_parse_param, struct fs_context *fc=
,
> > diff --git a/include/linux/security.h b/include/linux/security.h
> > index 32828502f09e..61fda06fac9d 100644
> > --- a/include/linux/security.h
> > +++ b/include/linux/security.h
> > @@ -293,6 +293,7 @@ int security_bprm_creds_from_file(struct linux_binp=
rm *bprm, struct file *file);
> >  int security_bprm_check(struct linux_binprm *bprm);
> >  void security_bprm_committing_creds(struct linux_binprm *bprm);
> >  void security_bprm_committed_creds(struct linux_binprm *bprm);
> > +int security_fs_context_init(struct fs_context *fc, struct dentry *ref=
erence);
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
> > +					   struct dentry *reference)
>=20
> I think that's the wrong way of doing this hook. The security hook
> really doesn't belong into alloc_fs_context().
>=20
> I think what we want is a dedicated helper similar to vfs_dup_context():
>=20
> // Only pass the superblock. There's no need for the dentry. I would
> // avoid even passing fs_context but if that's preferred then sure.
> security_fs_context_submount(struct fs_context *fc, const struct super_bl=
ock *sb)
>=20
> vfs_submount_fs_context(struct file_system_type *fs_type, struct dentry *=
reference)
> {
>         fc =3D fs_context_for_submount(fs_type, reference);
>=20
>         security_fs_context_for_submount(fc, reference->d_sb);
> }
>=20
> This automatically ensures it's only called for submounts, the LSM
> doesn't need to care about fc->purpose and this isn't called
> in a pure allocation function for all allocation calls.
>=20
> The we should switch all callers over to that new helper and unexport
> that fs_context_for_submount() thing completely. Yes, that's more work
> but that's the correct thing to do. And we need to audit fuse, cifs,
> afs, and nfs anyway that they work fine with the new security hook.*
>=20

It's the same prototype. We could just move the hook call to the end of
fs_context_for_submount, and that would be less churn for its callers.
Or were you wanting to do that to make this a more gradual changeover
for some reason?

I will rework the security hook to take a sb pointer instead though.

>=20
> [1]: If really needed, then any additional fs specific work that needs
>      to be done during submount allocation should probably probably be
>      done in a new callback.
>=20
>      struct fs_context_operations {
>             void (*free)(struct fs_context *fc);
>             int (*dup)(struct fs_context *fc, struct fs_context *src_fc);
>     +       int (*submount)(struct fs_context *fc, const struct super_blo=
ck *sb);

--=20
Jeff Layton <jlayton@kernel.org>
