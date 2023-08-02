Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF09076D7DB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 21:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbjHBTed (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 15:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjHBTec (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 15:34:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2E51722;
        Wed,  2 Aug 2023 12:34:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8332961AE1;
        Wed,  2 Aug 2023 19:34:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60FACC433C8;
        Wed,  2 Aug 2023 19:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691004869;
        bh=R2XNFOMlpoKl3UKqeQ3+36FDclL2w1qNFFl0yjA37tY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=C8tuKoLO6v8SLMytvrLPwndxfP+0EOH/QEtMW3GJkCjQAxRpGQsFVQHB/HAsaisCU
         256mv/t4snxdZ3//Xy7Ac/F+bQsl+5dzotXS05l+rbc3Jot7bm2Vcyj2ibLwRrCRhN
         BKfgG40x2qSYlWKCEP2xv4bzz7NimUZ9QWoXMkJIy0zk/fMiBLWdt/nTR2kAESkfaa
         1vV8/tm8koNlddsl/BvuGlW/oZfBRhKqONBIIdELktYvy3kXp6ut4Q+xbup7+eJCYh
         cN8VLCF5Oy7OxQzNJzOIN7BDjfDvUejh5Cw9qsBQnNn92ChU56i5uEWvNOaeeikxlJ
         Ooqfax0lPIFQA==
Message-ID: <ca156cecbc070c3b7c68626572274806079a6e04.camel@kernel.org>
Subject: Re: [PATCH v6] vfs, security: Fix automount superblock LSM init 
 problem, preventing NFS sb sharing
From:   Jeff Layton <jlayton@kernel.org>
To:     Paul Moore <paul@paul-moore.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        David Howells <dhowells@redhat.com>,
        Scott Mayhew <smayhew@redhat.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Date:   Wed, 02 Aug 2023 15:34:27 -0400
In-Reply-To: <bac543537058619345b363bbfc745927.paul@paul-moore.com>
References: <20230802-master-v6-1-45d48299168b@kernel.org>
         <bac543537058619345b363bbfc745927.paul@paul-moore.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2023-08-02 at 14:16 -0400, Paul Moore wrote:
> On Aug  2, 2023 Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > When NFS superblocks are created by automounting, their LSM parameters
> > aren't set in the fs_context struct prior to sget_fc() being called,
> > leading to failure to match existing superblocks.
> >=20
> > Fix this by adding a new LSM hook to load fc->security for submount
> > creation when alloc_fs_context() is creating the fs_context for it.
> >=20
> > However, this uncovers a further bug: nfs_get_root() initialises the
> > superblock security manually by calling security_sb_set_mnt_opts() or
> > security_sb_clone_mnt_opts() - but then vfs_get_tree() calls
> > security_sb_set_mnt_opts(), which can lead to SELinux, at least,
> > complaining.
> >=20
> > Fix that by adding a flag to the fs_context that suppresses the
> > security_sb_set_mnt_opts() call in vfs_get_tree().  This can be set by =
NFS
> > when it sets the LSM context on the new superblock.
> >=20
> > The first bug leads to messages like the following appearing in dmesg:
> >=20
> > 	NFS: Cache volume key already in use (nfs,4.2,2,108,106a8c0,1,,,,10000=
0,100000,2ee,3a98,1d4c,3a98,1)
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
> > This patch was originally sent by David several months ago, but it
> > never got merged. I'm resending to resurrect the discussion. Can we
> > get this fixed?
>=20
> Sorry, I sorta lost track of this after the ROOTCONTEXT_MNT discussion
> back in v3.  Looking at it a bit closer now I have one nitpicky
> request and one larger concern (see below).
>=20
> > diff --git a/fs/super.c b/fs/super.c
> > index e781226e2880..13adf43e2e5d 100644
> > --- a/fs/super.c
> > +++ b/fs/super.c
> > @@ -1541,10 +1541,12 @@ int vfs_get_tree(struct fs_context *fc)
> >  	smp_wmb();
> >  	sb->s_flags |=3D SB_BORN;
> > =20
> > -	error =3D security_sb_set_mnt_opts(sb, fc->security, 0, NULL);
> > -	if (unlikely(error)) {
> > -		fc_drop_locked(fc);
> > -		return error;
> > +	if (!(fc->lsm_set)) {
> > +		error =3D security_sb_set_mnt_opts(sb, fc->security, 0, NULL);
> > +		if (unlikely(error)) {
> > +			fc_drop_locked(fc);
> > +			return error;
> > +		}
> >  	}
>=20
> I generally dislike core kernel code which makes LSM calls conditional
> on some kernel state maintained outside the LSM.  Sometimes it has to
> be done as there is no other good options, but I would like us to try
> and avoid it if possible.  The commit description mentioned that this
> was put here to avoid a SELinux complaint, can you provide an example
> of the complain?  Does it complain about a double/invalid mount, e.g.
> "SELinux: mount invalid.  Same superblock, different security ..."?
>=20

The problem I had was not so much SELinux warnings, but rather that in a
situation where I would expect to share superblocks between two
filesystems, it didn't.

Basically if you do something like this:

# mount nfsserver:/export/foo /mnt/foo -o context=3Dsystem_u:object_r:root_=
t:s0
# mount nfsserver:/export/bar /mnt/bar -o context=3Dsystem_u:object_r:root_=
t:s0

...when "foo" and "bar" are directories on the same filesystem on the
server, you should get two vfsmounts that share a superblock. That's
what you get if selinux is disabled, but not when it's enabled (even
when it's in permissive mode).

The problems that David hit with the automounter have a similar root
cause though, I believe.

> I'd like to understand why the sb_set_mnt_opts() call fails when it
> comes after the fs_context_init() call.  I'm particulary curious to
> know if the failure is due to conflicting SELinux state in the
> fs_context, or if it is simply an issue of sb_set_mnt_opts() not
> properly handling existing values.  Perhaps I'm being overly naive,
> but I'm hopeful that we can address both of these within the SELinux
> code itself.
>=20

The problem I hit was that nfs_compare_super is called with a fs_context
that has a NULL ->security pointer. That caused it to call
selinux_sb_mnt_opts_compat with mnt_opts set to NULL, and at that point
it returns 1 and decides not to share sb's.

Filling out fc->security with this new operation seems to fix that, but
if you see a better way to do this, then I'm certainly open to the idea.

> In a worst case situation, we could always implement a flag *inside*
> the SELinux code, similar to what has been done with 'lsm_set' here.
>=20

I'm fine with a different solution, if you see a better one. You'll have
to handhold me through this one though. LSM stuff is not really my
forte'. Let me know what you'd like to see here.


> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index d06e350fedee..29cce0fadbeb 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -2745,6 +2745,30 @@ static int selinux_umount(struct vfsmount *mnt, =
int flags)
> >  				   FILESYSTEM__UNMOUNT, NULL);
> >  }
> > =20
> > +static int selinux_fs_context_init(struct fs_context *fc,
> > +				   struct dentry *reference)
> > +{
> > +	const struct superblock_security_struct *sbsec;
> > +	struct selinux_mnt_opts *opts;
> > +
> > +	if (fc->purpose =3D=3D FS_CONTEXT_FOR_SUBMOUNT) {
> > +		opts =3D kzalloc(sizeof(*opts), GFP_KERNEL);
> > +		if (!opts)
> > +			return -ENOMEM;
> > +
> > +		sbsec =3D selinux_superblock(reference->d_sb);
> > +		if (sbsec->flags & FSCONTEXT_MNT)
> > +			opts->fscontext_sid	=3D sbsec->sid;
> > +		if (sbsec->flags & CONTEXT_MNT)
> > +			opts->context_sid	=3D sbsec->mntpoint_sid;
> > +		if (sbsec->flags & DEFCONTEXT_MNT)
> > +			opts->defcontext_sid	=3D sbsec->def_sid;
>=20
> I acknowledge this is very nitpicky, but we're starting to make a
> greater effort towards using consistent style within the SELinux
> code.  With that in mind, please remove the alignment whitespace in
> the assignments above.  Thank you.
>=20

Will do. Thanks for having a look!

> > +		fc->security =3D opts;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static int selinux_fs_context_dup(struct fs_context *fc,
> >  				  struct fs_context *src_fc)
> >  {
>=20
> --
> paul-moore.com

--=20
Jeff Layton <jlayton@kernel.org>
