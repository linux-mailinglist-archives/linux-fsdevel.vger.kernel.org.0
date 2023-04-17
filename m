Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C256E47A0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 14:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjDQM0E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 08:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbjDQMZz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 08:25:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5883A5D4;
        Mon, 17 Apr 2023 05:25:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7A6862373;
        Mon, 17 Apr 2023 12:25:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C6DEC433EF;
        Mon, 17 Apr 2023 12:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681734325;
        bh=/r1+zZxUu5ihF6vPOxIti8XEd3BZuJLuK0gX/quPPqQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Aw6o+f2wOhS4nJgMWDML/1MlVdDmfQBFZc5JfdXMoMBJrEng52Zh6e0ucTc4ZImNE
         Co0gBBAWIItTREQWaV6OsCJF55xupY1KzM3NO4rsBIctZZXfIPRU4x/b7/MXzQkM9M
         YUBLlZjZ7xRULrvAvPfqaZfCpRIEYP7TxGUNc9pEHitY94x9JBYPZ3yDeKyI6WDK4J
         g12hTEU0zxNdfDH5dIjmJeez7XjsXdwSmmKHf8k+YoAwbU5YWM3pSol/GUocvIayzN
         Qq+mClWh/n1ikkG9XTOrtq8QGplV3cqjZaV7Z4I2VkhgG/ipx77OFIMc/zIKU6qg3/
         p0SxEXsk8LHZg==
Message-ID: <6c08ad94ca949d0f3525f7e1fc24a72c50affd59.camel@kernel.org>
Subject: Re: [PATCH/RFC] VFS: LOOKUP_MOUNTPOINT should used cached info
 whenever possible.
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>, NeilBrown <neilb@suse.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Dave Wysochanski <dwysocha@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Date:   Mon, 17 Apr 2023 08:25:23 -0400
In-Reply-To: <20230417-beisein-investieren-360fa20fb68a@brauner>
References: <95ee689c76bf034fa2fe9fade0bccdb311f3a04f.camel@kernel.org>
         <168168683217.24821.6260957092725278201@noble.neil.brown.name>
         <20230417-beisein-investieren-360fa20fb68a@brauner>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2023-04-17 at 13:55 +0200, Christian Brauner wrote:
> On Mon, Apr 17, 2023 at 09:13:52AM +1000, NeilBrown wrote:
> >=20
> > When performing a LOOKUP_MOUNTPOINT lookup we don't really want to
> > engage with underlying systems at all.  Any mount point MUST be in the
> > dcache with a complete direct path from the root to the mountpoint.
> > That should be sufficient to find the mountpoint given a path name.
> >=20
> > This becomes an issue when the filesystem changes unexpected, such as
> > when a NFS server is changed to reject all access.  It then becomes
> > impossible to unmount anything mounted on the filesystem which has
> > changed.  We could simply lazy-unmount the changed filesystem and that
> > will often be sufficient.  However if the target filesystem needs
> > "umount -f" to complete the unmount properly, then the lazy unmount wil=
l
> > leave it incompletely unmounted.  When "-f" is needed, we really need t=
o
>=20
> I don't understand this yet. All I see is nfs_umount_begin() that's
> different for MNT_FORCE to kill remaining io. Why does that preclude
> MNT_DETACH? You might very well fail MNT_FORCE and the only way you can
> get rid is to use MNT_DETACH, no? So I don't see why that is an
> argument.
>=20
> > be able to name the target filesystem.
> >=20
> > We NEVER want to revalidate anything.  We already avoid the revalidatio=
n
> > of the mountpoint itself, be we won't need to revalidate anything on th=
e
> > path either as thay might affect the cache, and the cache is what we ar=
e
> > really looking in.
> >=20
> > Permission checks are a little less clear.  We currently allow any user
>=20
> This is all very brittle.
>=20
> First case that comes to mind is overlayfs where the permission checking
> is performed twice. Once on the overlayfs inode itself based on the
> caller's security context and a second time on the underlying inode with
> the security context of the mounter of the overlayfs instance.
>=20
> A mounter could have dropped all privileges aside from CAP_SYS_ADMIN so
> they'd be able to mount the overlayfs instance but would be restricted
> from accessing certain directories or files. The task accessing the
> overlayfs instance however could have a completely different security
> context including CAP_DAC_READ_SEARCH and such. Both tasks could
> reasonably be in different user namespaces and so on.
>=20
> The LSM hooks are also called twice and would now also be called once.
>=20
> It also forgets that acl_permission() check may very well call into the
> filesystem via check_acl().
>=20
> So umount could either be used to infer existence of files that the user
> wouldn't otherwise know they exist or in the worst case allow to umount
> something that they wouldn't have access to.
>=20
> Aside from that this would break userspace assumptions and as Al and
> I've mentioned before in the other thread you'd need a new flag to
> umount2() for this. The permission model can't just change behind users
> back.
>=20
> But I dislike it for the now even more special-cased umount path lookup
> alone tbh. I'd feel way more comfortable with a non-lookup related
> solution that doesn't have subtle implications for permission checking.
>=20

These are good points.

One way around the issues you point out might be to pass down a new
MAY_LOOKUP_MOUNTPOINT mask flag to ->permission. That would allow the
filesystem driver to decide whether it wants to avoid potentially
problematic activity when checking permissions. nfs_permission could
check for that and take a more hands-off approach to the permissions
check. Between that and skipping d_revalidate on LOOKUP_MOUNTPOINT, I
think that might do what we need.

> > to make the umount syscall and perform the path lookup and only reject
> > unprivileged users once the target mount point has been found.  If we
> > completely relax permission checks then an unprivileged user could prob=
e
> > inaccessible parts of the name space by examining the error returned
> > from umount().
> >=20
> > So we only relax permission check when the user has CAP_SYS_ADMIN
> > (may_mount() succeeds).
> >=20
> > Note that if the path given is not direct and for example uses symlinks
> > or "..", then dentries or symlink content may not be cached and a remot=
e
> > server could cause problem.  We can only be certain of a safe unmount i=
f
> > a direct path is used.
> >=20
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  fs/namei.c | 46 ++++++++++++++++++++++++++++++++++++++++------
> >  1 file changed, 40 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/fs/namei.c b/fs/namei.c
> > index edfedfbccaef..f2df1adae7c5 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -498,8 +498,8 @@ static int sb_permission(struct super_block *sb, st=
ruct inode *inode, int mask)
> >   *
> >   * When checking for MAY_APPEND, MAY_WRITE must also be set in @mask.
> >   */
> > -int inode_permission(struct mnt_idmap *idmap,
> > -		     struct inode *inode, int mask)
> > +int inode_permission_mp(struct mnt_idmap *idmap,
> > +			struct inode *inode, int mask, bool mp)
> >  {
> >  	int retval;
> > =20
> > @@ -523,7 +523,14 @@ int inode_permission(struct mnt_idmap *idmap,
> >  			return -EACCES;
> >  	}
> > =20
> > -	retval =3D do_inode_permission(idmap, inode, mask);
> > +	if (mp)
> > +		/* We are looking for a mountpoint and so don't
> > +		 * want to interact with the filesystem at all, just
> > +		 * the dcache and icache.
> > +		 */
> > +		retval =3D generic_permission(idmap, inode, mask);
> > +	else
> > +		retval =3D do_inode_permission(idmap, inode, mask);
> >  	if (retval)
> >  		return retval;
> > =20
> > @@ -533,6 +540,24 @@ int inode_permission(struct mnt_idmap *idmap,
> > =20
> >  	return security_inode_permission(inode, mask);
> >  }
> > +
> > +/**
> > + * inode_permission - Check for access rights to a given inode
> > + * @idmap:	idmap of the mount the inode was found from
> > + * @inode:	Inode to check permission on
> > + * @mask:	Right to check for (%MAY_READ, %MAY_WRITE, %MAY_EXEC)
> > + *
> > + * Check for read/write/execute permissions on an inode.  We use fs[ug=
]id for
> > + * this, letting us set arbitrary permissions for filesystem access wi=
thout
> > + * changing the "normal" UIDs which are used for other things.
> > + *
> > + * When checking for MAY_APPEND, MAY_WRITE must also be set in @mask.
> > + */
> > +int inode_permission(struct mnt_idmap *idmap,
> > +		     struct inode *inode, int mask)
> > +{
> > +	return inode_permission_mp(idmap, inode, mask, false);
> > +}
> >  EXPORT_SYMBOL(inode_permission);
> > =20
> >  /**
> > @@ -589,6 +614,7 @@ struct nameidata {
> >  #define ND_ROOT_PRESET 1
> >  #define ND_ROOT_GRABBED 2
> >  #define ND_JUMPED 4
> > +#define ND_SYS_ADMIN 8
> > =20
> >  static void __set_nameidata(struct nameidata *p, int dfd, struct filen=
ame *name)
> >  {
> > @@ -853,7 +879,8 @@ static bool try_to_unlazy_next(struct nameidata *nd=
, struct dentry *dentry)
> > =20
> >  static inline int d_revalidate(struct dentry *dentry, unsigned int fla=
gs)
> >  {
> > -	if (unlikely(dentry->d_flags & DCACHE_OP_REVALIDATE))
> > +	if (unlikely(dentry->d_flags & DCACHE_OP_REVALIDATE) &&
> > +	    likely(!(flags & LOOKUP_MOUNTPOINT)))
> >  		return dentry->d_op->d_revalidate(dentry, flags);
> >  	else
> >  		return 1;
> > @@ -1708,12 +1735,17 @@ static struct dentry *lookup_slow(const struct =
qstr *name,
> >  static inline int may_lookup(struct mnt_idmap *idmap,
> >  			     struct nameidata *nd)
> >  {
> > +	/* If we are looking for a mountpoint and we have the SYS_ADMIN
> > +	 * capability, then we will by-pass the filesys for permission checks
> > +	 * and just use generic_permission().
> > +	 */
> > +	bool mp =3D (nd->flags & LOOKUP_MOUNTPOINT) && (nd->state & ND_SYS_AD=
MIN);
> >  	if (nd->flags & LOOKUP_RCU) {
> > -		int err =3D inode_permission(idmap, nd->inode, MAY_EXEC|MAY_NOT_BLOC=
K);
> > +		int err =3D inode_permission_mp(idmap, nd->inode, MAY_EXEC|MAY_NOT_B=
LOCK, mp);
> >  		if (err !=3D -ECHILD || !try_to_unlazy(nd))
> >  			return err;
> >  	}
> > -	return inode_permission(idmap, nd->inode, MAY_EXEC);
> > +	return inode_permission_mp(idmap, nd->inode, MAY_EXEC, mp);
> >  }
> > =20
> >  static int reserve_stack(struct nameidata *nd, struct path *link)
> > @@ -2501,6 +2533,8 @@ int filename_lookup(int dfd, struct filename *nam=
e, unsigned flags,
> >  	if (IS_ERR(name))
> >  		return PTR_ERR(name);
> >  	set_nameidata(&nd, dfd, name, root);
> > +	if ((flags & LOOKUP_MOUNTPOINT) && may_mount())
> > +		nd.state =3D ND_SYS_ADMIN;
> >  	retval =3D path_lookupat(&nd, flags | LOOKUP_RCU, path);
> >  	if (unlikely(retval =3D=3D -ECHILD))
> >  		retval =3D path_lookupat(&nd, flags, path);
> > --=20
> > 2.40.0
> >=20

--=20
Jeff Layton <jlayton@kernel.org>
