Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33656E53D3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 23:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjDQV0p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 17:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjDQV0o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 17:26:44 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0509C44B5;
        Mon, 17 Apr 2023 14:26:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4010F21A0E;
        Mon, 17 Apr 2023 21:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1681766800; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/UnYgPZSOQeS1PriQLZpI4hcVjSWjnhacAMBruAauEE=;
        b=KCCtG3l7nBFsRARq7LjDjJ32Qm0hCQY/qxSIbWcp85+Xy0JQBDF8tA11e7oWY1Uks7bNQr
        PW+nrkVjkt9YWM+xjPQmxB5oe2JfqNbpAnQHctFT6Z2SagumGTdZxW+7X22mb+8tJJdR8v
        5BfmLuSYzRBWLBttwTcYsiPJI1Nv3t4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1681766800;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/UnYgPZSOQeS1PriQLZpI4hcVjSWjnhacAMBruAauEE=;
        b=gf7SccgYdAnXXEbatD7I41eB0MUDyCGioWLaU9CoYzn0gpkVci7DMHmZutqEkVynER1CLB
        YfnKrp3Qmdo7tlAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 57CEF1390E;
        Mon, 17 Apr 2023 21:26:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id COQ3BI25PWSWYwAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 17 Apr 2023 21:26:37 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Christian Brauner" <brauner@kernel.org>
Cc:     "Jeff Layton" <jlayton@kernel.org>,
        "Al Viro" <viro@zeniv.linux.org.uk>,
        "Dave Wysochanski" <dwysocha@redhat.com>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
        "linux-nfs" <linux-nfs@vger.kernel.org>,
        "David Howells" <dhowells@redhat.com>,
        "Christoph Hellwig" <hch@lst.de>
Subject: Re: [PATCH/RFC] VFS: LOOKUP_MOUNTPOINT should used cached info
 whenever possible.
In-reply-to: <20230417-beisein-investieren-360fa20fb68a@brauner>
References: <95ee689c76bf034fa2fe9fade0bccdb311f3a04f.camel@kernel.org>,
 <168168683217.24821.6260957092725278201@noble.neil.brown.name>,
 <20230417-beisein-investieren-360fa20fb68a@brauner>
Date:   Tue, 18 Apr 2023 07:26:34 +1000
Message-id: <168176679417.24821.211742267573907874@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 17 Apr 2023, Christian Brauner wrote:
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
> > "umount -f" to complete the unmount properly, then the lazy unmount will
> > leave it incompletely unmounted.  When "-f" is needed, we really need to
>=20
> I don't understand this yet. All I see is nfs_umount_begin() that's
> different for MNT_FORCE to kill remaining io. Why does that preclude
> MNT_DETACH? You might very well fail MNT_FORCE and the only way you can
> get rid is to use MNT_DETACH, no? So I don't see why that is an
> argument.

Possibly I could have been more clear.
If /foo is the mount point for a filesystem that is causing problems and
/foo/bar is the mount point of a different filesystem, which might have
other problems, then I was saying that the simple solution of
   umount -l /foo
which would MNT_DETACH both filesystems is not ideal because there might
be pending IO that will never complete, so the mount can never be
cleaned up.  In such cases we really want to be able to do
   umount -f /foo/bar
and ensure that succeeds.
You can see now that it isn't that MNT_FORCE precludes MNT_DETACH, but
they would be done on different filesystems.

MNT_FORCE is, I think, a good idea and a needed functionality that has
never been implemented well.
MNT_FORCE causes nfs_umount_begin to be called as you noted, which
aborts all pending RPCs on that filesystem.
This might be useful if you have an "ls" running, as it is likely to
abort on the first getdents() failure.  But if you have "ls -l' running,
it will likely just go and try another lstat(), and that is just as
likely to hang - thus still preventing the umount.

What we used to do was find anything using the mount and kill it
(sometime "fuser -k" would work).  These processes would likely be stuck
in a D wait, but "umount -f" would abort the RPCs and the processes
would get unstuck and could respond to the signal.  This would sometimes
take a couple of iterations.

These days we have TASK_KILLABLE so this is much less likely to be
needed - we just kill all the processes and they die promptly.  Most of
the time.  There are a few places that can still block, but which no-one
has had the motivation to fix.

It would be much nicer if we didn't need to kill things.  Even with
"fuser -k" it isn't really the sort of thing you want in a shutdown
script (or in systemd-shutdown).

It would be ideal if the shutdown process could call "umount" and if
that fails with EBUSY, call "umount -f" and be confident of ....
something.  Currently "-f" might inspire hope, but not confidence.

We cannot realistically make MNT_FORCE truly force a umount because
processes really need to die before that happens.  But we could ensure
that the filesystem is quiescent and stays that way.

Maybe we could add a flag to 'struct vfsmount' to say that "unmount has
been forced".  Any attempt to use a fd with such a vfsmnt would fail,
expect close() and anything similar.  Maybe nfs_umount_begin could
iterate all open files on that vfsmnt and purge any cached data so no
background writes were needed.  I think this would be very close to what
we needed.

Then systemd could run umount() and if that failed then
umount(MNT_FORCE) and if that fails umount(MNT_DETACH), with confidence
that there would be not more RPCs generates, so it would be safe to turn
off the network.

BTW, that is another reason that just doing "umount -l /foo" is not
ideal.  We sometimes want to wait for the umount to complete, so we can
remove the backing store or the network.  "umount -l /foo" doesn't let
us wait.  "umount /foo/bar" does.

>=20
> > be able to name the target filesystem.
> >=20
> > We NEVER want to revalidate anything.  We already avoid the revalidation
> > of the mountpoint itself, be we won't need to revalidate anything on the
> > path either as thay might affect the cache, and the cache is what we are
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

I'd prefer "called never"

>=20
> It also forgets that acl_permission() check may very well call into the
> filesystem via check_acl().

I didn't pay proper attention to acl_permission() - you are right.

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

I was really hoping that existing code could be made to just work.

Thanks for the review.

NeilBrown


>=20
> > to make the umount syscall and perform the path lookup and only reject
> > unprivileged users once the target mount point has been found.  If we
> > completely relax permission checks then an unprivileged user could probe
> > inaccessible parts of the name space by examining the error returned
> > from umount().
> >=20
> > So we only relax permission check when the user has CAP_SYS_ADMIN
> > (may_mount() succeeds).
> >=20
> > Note that if the path given is not direct and for example uses symlinks
> > or "..", then dentries or symlink content may not be cached and a remote
> > server could cause problem.  We can only be certain of a safe unmount if
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
> > @@ -498,8 +498,8 @@ static int sb_permission(struct super_block *sb, stru=
ct inode *inode, int mask)
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
> > + * Check for read/write/execute permissions on an inode.  We use fs[ug]i=
d for
> > + * this, letting us set arbitrary permissions for filesystem access with=
out
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
> >  static void __set_nameidata(struct nameidata *p, int dfd, struct filenam=
e *name)
> >  {
> > @@ -853,7 +879,8 @@ static bool try_to_unlazy_next(struct nameidata *nd, =
struct dentry *dentry)
> > =20
> >  static inline int d_revalidate(struct dentry *dentry, unsigned int flags)
> >  {
> > -	if (unlikely(dentry->d_flags & DCACHE_OP_REVALIDATE))
> > +	if (unlikely(dentry->d_flags & DCACHE_OP_REVALIDATE) &&
> > +	    likely(!(flags & LOOKUP_MOUNTPOINT)))
> >  		return dentry->d_op->d_revalidate(dentry, flags);
> >  	else
> >  		return 1;
> > @@ -1708,12 +1735,17 @@ static struct dentry *lookup_slow(const struct qs=
tr *name,
> >  static inline int may_lookup(struct mnt_idmap *idmap,
> >  			     struct nameidata *nd)
> >  {
> > +	/* If we are looking for a mountpoint and we have the SYS_ADMIN
> > +	 * capability, then we will by-pass the filesys for permission checks
> > +	 * and just use generic_permission().
> > +	 */
> > +	bool mp =3D (nd->flags & LOOKUP_MOUNTPOINT) && (nd->state & ND_SYS_ADMI=
N);
> >  	if (nd->flags & LOOKUP_RCU) {
> > -		int err =3D inode_permission(idmap, nd->inode, MAY_EXEC|MAY_NOT_BLOCK);
> > +		int err =3D inode_permission_mp(idmap, nd->inode, MAY_EXEC|MAY_NOT_BLO=
CK, mp);
> >  		if (err !=3D -ECHILD || !try_to_unlazy(nd))
> >  			return err;
> >  	}
> > -	return inode_permission(idmap, nd->inode, MAY_EXEC);
> > +	return inode_permission_mp(idmap, nd->inode, MAY_EXEC, mp);
> >  }
> > =20
> >  static int reserve_stack(struct nameidata *nd, struct path *link)
> > @@ -2501,6 +2533,8 @@ int filename_lookup(int dfd, struct filename *name,=
 unsigned flags,
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
>=20

