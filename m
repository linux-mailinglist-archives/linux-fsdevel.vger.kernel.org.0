Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135196E4728
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 14:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjDQMKA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 08:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjDQMJv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 08:09:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C48259C9;
        Mon, 17 Apr 2023 05:09:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D69626230E;
        Mon, 17 Apr 2023 12:09:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7591EC433D2;
        Mon, 17 Apr 2023 12:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681733364;
        bh=Fw/+D+1wcKCprvlSb1vLDIZy3DBLaPbPzlsx2af75FI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=cidl145Qyl9B8ba0byP051fDawyZaGndvkMtWM+VImmWpuofFy+MLkxzkQIkagJfd
         FTmnLEuFLlzbiFaouZSP6ord6mpxv36ECHlIUQ0F7lALIRfv97iiLgUX0PAhHjHEIB
         gP64Waex9meRnU4DBXJ7d7XO+YzA5NqLl3vgAxq94CvHgZcYXEstDzSxDVet4RkU37
         PAq/rFBPNjR2PUiOxjuts3g030F0U0K0q63wCndwsgdQWpY0cz0dqq7kv/h5mZW6gn
         DTlbJV5Ljyt6nzZftwlaA89YVwS526aaV+Ec/VF9yc/QN1TdTGKA72kFDKIVkHzVbB
         8qK5yX0XtJIKA==
Message-ID: <509e7dc348362b09c6f5a92bd2857ae666355ae3.camel@kernel.org>
Subject: Re: [PATCH/RFC] VFS: LOOKUP_MOUNTPOINT should used cached info
 whenever possible.
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Dave Wysochanski <dwysocha@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Date:   Mon, 17 Apr 2023 08:09:22 -0400
In-Reply-To: <168168683217.24821.6260957092725278201@noble.neil.brown.name>
References: <95ee689c76bf034fa2fe9fade0bccdb311f3a04f.camel@kernel.org>
         <168168683217.24821.6260957092725278201@noble.neil.brown.name>
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

On Mon, 2023-04-17 at 09:13 +1000, NeilBrown wrote:
> When performing a LOOKUP_MOUNTPOINT lookup we don't really want to
> engage with underlying systems at all.  Any mount point MUST be in the
> dcache with a complete direct path from the root to the mountpoint.
> That should be sufficient to find the mountpoint given a path name.
>=20
> This becomes an issue when the filesystem changes unexpected, such as
> when a NFS server is changed to reject all access.  It then becomes
> impossible to unmount anything mounted on the filesystem which has
> changed.  We could simply lazy-unmount the changed filesystem and that
> will often be sufficient.  However if the target filesystem needs
> "umount -f" to complete the unmount properly, then the lazy unmount will
> leave it incompletely unmounted.  When "-f" is needed, we really need to
> be able to name the target filesyste
>=20
> We NEVER want to revalidate anything.  We already avoid the revalidation
> of the mountpoint itself, be we won't need to revalidate anything on the
> path either as thay might affect the cache, and the cache is what we are
> really looking in.
>=20
> Permission checks are a little less clear.  We currently allow any user
> to make the umount syscall and perform the path lookup and only reject
> unprivileged users once the target mount point has been found.  If we
> completely relax permission checks then an unprivileged user could probe
> inaccessible parts of the name space by examining the error returned
> from umount().
>=20

That sounds pretty reasonable. Most umounts are done by root in some
fashion anyway.



> So we only relax permission check when the user has CAP_SYS_ADMIN
> (may_mount() succeeds).
>=20
> Note that if the path given is not direct and for example uses symlinks
> or "..", then dentries or symlink content may not be cached and a remote
> server could cause problem.  We can only be certain of a safe unmount if
> a direct path is used.
>=20

I guess we do still have to allow it to do a lookup due to symlinks. I
think this is still worthwhile though since it'd fix a lot of these
cases.

> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/namei.c | 46 ++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 40 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/namei.c b/fs/namei.c
> index edfedfbccaef..f2df1adae7c5 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -498,8 +498,8 @@ static int sb_permission(struct super_block *sb, stru=
ct inode *inode, int mask)
>   *
>   * When checking for MAY_APPEND, MAY_WRITE must also be set in @mask.
>   */
> -int inode_permission(struct mnt_idmap *idmap,
> -		     struct inode *inode, int mask)
> +int inode_permission_mp(struct mnt_idmap *idmap,
> +			struct inode *inode, int mask, bool mp)
>  {
>  	int retval;
> =20
> @@ -523,7 +523,14 @@ int inode_permission(struct mnt_idmap *idmap,
>  			return -EACCES;
>  	}
> =20
> -	retval =3D do_inode_permission(idmap, inode, mask);
> +	if (mp)
> +		/* We are looking for a mountpoint and so don't
> +		 * want to interact with the filesystem at all, just
> +		 * the dcache and icache.
> +		 */
> +		retval =3D generic_permission(idmap, inode, mask);
> +	else
> +		retval =3D do_inode_permission(idmap, inode, mask);
>  	if (retval)
>  		return retval;
> =20
> @@ -533,6 +540,24 @@ int inode_permission(struct mnt_idmap *idmap,
> =20
>  	return security_inode_permission(inode, mask);
>  }
> +
> +/**
> + * inode_permission - Check for access rights to a given inode
> + * @idmap:	idmap of the mount the inode was found from
> + * @inode:	Inode to check permission on
> + * @mask:	Right to check for (%MAY_READ, %MAY_WRITE, %MAY_EXEC)
> + *
> + * Check for read/write/execute permissions on an inode.  We use fs[ug]i=
d for
> + * this, letting us set arbitrary permissions for filesystem access with=
out
> + * changing the "normal" UIDs which are used for other things.
> + *
> + * When checking for MAY_APPEND, MAY_WRITE must also be set in @mask.
> + */
> +int inode_permission(struct mnt_idmap *idmap,
> +		     struct inode *inode, int mask)
> +{
> +	return inode_permission_mp(idmap, inode, mask, false);
> +}
>  EXPORT_SYMBOL(inode_permission);
> =20
>  /**
> @@ -589,6 +614,7 @@ struct nameidata {
>  #define ND_ROOT_PRESET 1
>  #define ND_ROOT_GRABBED 2
>  #define ND_JUMPED 4
> +#define ND_SYS_ADMIN 8
> =20
>  static void __set_nameidata(struct nameidata *p, int dfd, struct filenam=
e *name)
>  {
> @@ -853,7 +879,8 @@ static bool try_to_unlazy_next(struct nameidata *nd, =
struct dentry *dentry)
> =20
>  static inline int d_revalidate(struct dentry *dentry, unsigned int flags=
)
>  {
> -	if (unlikely(dentry->d_flags & DCACHE_OP_REVALIDATE))
> +	if (unlikely(dentry->d_flags & DCACHE_OP_REVALIDATE) &&
> +	    likely(!(flags & LOOKUP_MOUNTPOINT)))
>  		return dentry->d_op->d_revalidate(dentry, flags);
>  	else
>  		return 1;
> @@ -1708,12 +1735,17 @@ static struct dentry *lookup_slow(const struct qs=
tr *name,
>  static inline int may_lookup(struct mnt_idmap *idmap,
>  			     struct nameidata *nd)
>  {
> +	/* If we are looking for a mountpoint and we have the SYS_ADMIN
> +	 * capability, then we will by-pass the filesys for permission checks
> +	 * and just use generic_permission().
> +	 */
> +	bool mp =3D (nd->flags & LOOKUP_MOUNTPOINT) && (nd->state & ND_SYS_ADMI=
N);
>  	if (nd->flags & LOOKUP_RCU) {
> -		int err =3D inode_permission(idmap, nd->inode, MAY_EXEC|MAY_NOT_BLOCK)=
;
> +		int err =3D inode_permission_mp(idmap, nd->inode, MAY_EXEC|MAY_NOT_BLO=
CK, mp);
>  		if (err !=3D -ECHILD || !try_to_unlazy(nd))
>  			return err;
>  	}
> -	return inode_permission(idmap, nd->inode, MAY_EXEC);
> +	return inode_permission_mp(idmap, nd->inode, MAY_EXEC, mp);
>  }
> =20
>  static int reserve_stack(struct nameidata *nd, struct path *link)
> @@ -2501,6 +2533,8 @@ int filename_lookup(int dfd, struct filename *name,=
 unsigned flags,
>  	if (IS_ERR(name))
>  		return PTR_ERR(name);
>  	set_nameidata(&nd, dfd, name, root);
> +	if ((flags & LOOKUP_MOUNTPOINT) && may_mount())
> +		nd.state =3D ND_SYS_ADMIN;
>  	retval =3D path_lookupat(&nd, flags | LOOKUP_RCU, path);
>  	if (unlikely(retval =3D=3D -ECHILD))
>  		retval =3D path_lookupat(&nd, flags, path);

This behavior looks right along the lines of what I was thinking.

Just for bisectability, it might be worthwhile to break this up along
conceptual lines: one patch to make it skip d_revalidate, one that
changes the permission checking, etc.

I'll plan to give this a try soon with Dave's reproducer.

Thanks!
--=20
Jeff Layton <jlayton@kernel.org>
