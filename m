Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9AA6E46F5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 13:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjDQL6A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 07:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjDQL57 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 07:57:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB22A7DA7;
        Mon, 17 Apr 2023 04:57:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A212261A14;
        Mon, 17 Apr 2023 11:55:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF13FC433EF;
        Mon, 17 Apr 2023 11:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681732506;
        bh=cLtOWzZVTlZDYmXOCrD+ea5o1vVwxhEqXqOPnPszawA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FzKG4Wub03cJxOkNAS58u4OnXcFtHE6zGJriHsNG6Oq/zlz1HGVl8UTJVgtgUED3+
         Df1SMxmCOg1Y0x8rlayiP9E53xiZk6gO7y9G6zuYo6jxtQ0+uzeuX74B0Tvj/ba7u1
         roamL7RLc5Vcey01dsR8Mj7flat+wyArNoRJ06p+d6E7sAUXHG9WKtNYxlxM9+gwJq
         GnwWj1nR0kaoM5qKHjGB9QzFYVzTp+2XaaTotId5QWQc/OQHFbXzEXbarLmVUraCra
         d05ynpmmjnGFsQmfIRqH1lENLNNVNsqNBfn9zp7/imHGajK+SKYFl2/u/+0lK3Xk8c
         GBBpTjlVj9ayw==
Date:   Mon, 17 Apr 2023 13:55:00 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dave Wysochanski <dwysocha@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH/RFC] VFS: LOOKUP_MOUNTPOINT should used cached info
 whenever possible.
Message-ID: <20230417-beisein-investieren-360fa20fb68a@brauner>
References: <95ee689c76bf034fa2fe9fade0bccdb311f3a04f.camel@kernel.org>
 <168168683217.24821.6260957092725278201@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <168168683217.24821.6260957092725278201@noble.neil.brown.name>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 17, 2023 at 09:13:52AM +1000, NeilBrown wrote:
> 
> When performing a LOOKUP_MOUNTPOINT lookup we don't really want to
> engage with underlying systems at all.  Any mount point MUST be in the
> dcache with a complete direct path from the root to the mountpoint.
> That should be sufficient to find the mountpoint given a path name.
> 
> This becomes an issue when the filesystem changes unexpected, such as
> when a NFS server is changed to reject all access.  It then becomes
> impossible to unmount anything mounted on the filesystem which has
> changed.  We could simply lazy-unmount the changed filesystem and that
> will often be sufficient.  However if the target filesystem needs
> "umount -f" to complete the unmount properly, then the lazy unmount will
> leave it incompletely unmounted.  When "-f" is needed, we really need to

I don't understand this yet. All I see is nfs_umount_begin() that's
different for MNT_FORCE to kill remaining io. Why does that preclude
MNT_DETACH? You might very well fail MNT_FORCE and the only way you can
get rid is to use MNT_DETACH, no? So I don't see why that is an
argument.

> be able to name the target filesystem.
> 
> We NEVER want to revalidate anything.  We already avoid the revalidation
> of the mountpoint itself, be we won't need to revalidate anything on the
> path either as thay might affect the cache, and the cache is what we are
> really looking in.
> 
> Permission checks are a little less clear.  We currently allow any user

This is all very brittle.

First case that comes to mind is overlayfs where the permission checking
is performed twice. Once on the overlayfs inode itself based on the
caller's security context and a second time on the underlying inode with
the security context of the mounter of the overlayfs instance.

A mounter could have dropped all privileges aside from CAP_SYS_ADMIN so
they'd be able to mount the overlayfs instance but would be restricted
from accessing certain directories or files. The task accessing the
overlayfs instance however could have a completely different security
context including CAP_DAC_READ_SEARCH and such. Both tasks could
reasonably be in different user namespaces and so on.

The LSM hooks are also called twice and would now also be called once.

It also forgets that acl_permission() check may very well call into the
filesystem via check_acl().

So umount could either be used to infer existence of files that the user
wouldn't otherwise know they exist or in the worst case allow to umount
something that they wouldn't have access to.

Aside from that this would break userspace assumptions and as Al and
I've mentioned before in the other thread you'd need a new flag to
umount2() for this. The permission model can't just change behind users
back.

But I dislike it for the now even more special-cased umount path lookup
alone tbh. I'd feel way more comfortable with a non-lookup related
solution that doesn't have subtle implications for permission checking.

> to make the umount syscall and perform the path lookup and only reject
> unprivileged users once the target mount point has been found.  If we
> completely relax permission checks then an unprivileged user could probe
> inaccessible parts of the name space by examining the error returned
> from umount().
> 
> So we only relax permission check when the user has CAP_SYS_ADMIN
> (may_mount() succeeds).
> 
> Note that if the path given is not direct and for example uses symlinks
> or "..", then dentries or symlink content may not be cached and a remote
> server could cause problem.  We can only be certain of a safe unmount if
> a direct path is used.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/namei.c | 46 ++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 40 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index edfedfbccaef..f2df1adae7c5 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -498,8 +498,8 @@ static int sb_permission(struct super_block *sb, struct inode *inode, int mask)
>   *
>   * When checking for MAY_APPEND, MAY_WRITE must also be set in @mask.
>   */
> -int inode_permission(struct mnt_idmap *idmap,
> -		     struct inode *inode, int mask)
> +int inode_permission_mp(struct mnt_idmap *idmap,
> +			struct inode *inode, int mask, bool mp)
>  {
>  	int retval;
>  
> @@ -523,7 +523,14 @@ int inode_permission(struct mnt_idmap *idmap,
>  			return -EACCES;
>  	}
>  
> -	retval = do_inode_permission(idmap, inode, mask);
> +	if (mp)
> +		/* We are looking for a mountpoint and so don't
> +		 * want to interact with the filesystem at all, just
> +		 * the dcache and icache.
> +		 */
> +		retval = generic_permission(idmap, inode, mask);
> +	else
> +		retval = do_inode_permission(idmap, inode, mask);
>  	if (retval)
>  		return retval;
>  
> @@ -533,6 +540,24 @@ int inode_permission(struct mnt_idmap *idmap,
>  
>  	return security_inode_permission(inode, mask);
>  }
> +
> +/**
> + * inode_permission - Check for access rights to a given inode
> + * @idmap:	idmap of the mount the inode was found from
> + * @inode:	Inode to check permission on
> + * @mask:	Right to check for (%MAY_READ, %MAY_WRITE, %MAY_EXEC)
> + *
> + * Check for read/write/execute permissions on an inode.  We use fs[ug]id for
> + * this, letting us set arbitrary permissions for filesystem access without
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
>  
>  /**
> @@ -589,6 +614,7 @@ struct nameidata {
>  #define ND_ROOT_PRESET 1
>  #define ND_ROOT_GRABBED 2
>  #define ND_JUMPED 4
> +#define ND_SYS_ADMIN 8
>  
>  static void __set_nameidata(struct nameidata *p, int dfd, struct filename *name)
>  {
> @@ -853,7 +879,8 @@ static bool try_to_unlazy_next(struct nameidata *nd, struct dentry *dentry)
>  
>  static inline int d_revalidate(struct dentry *dentry, unsigned int flags)
>  {
> -	if (unlikely(dentry->d_flags & DCACHE_OP_REVALIDATE))
> +	if (unlikely(dentry->d_flags & DCACHE_OP_REVALIDATE) &&
> +	    likely(!(flags & LOOKUP_MOUNTPOINT)))
>  		return dentry->d_op->d_revalidate(dentry, flags);
>  	else
>  		return 1;
> @@ -1708,12 +1735,17 @@ static struct dentry *lookup_slow(const struct qstr *name,
>  static inline int may_lookup(struct mnt_idmap *idmap,
>  			     struct nameidata *nd)
>  {
> +	/* If we are looking for a mountpoint and we have the SYS_ADMIN
> +	 * capability, then we will by-pass the filesys for permission checks
> +	 * and just use generic_permission().
> +	 */
> +	bool mp = (nd->flags & LOOKUP_MOUNTPOINT) && (nd->state & ND_SYS_ADMIN);
>  	if (nd->flags & LOOKUP_RCU) {
> -		int err = inode_permission(idmap, nd->inode, MAY_EXEC|MAY_NOT_BLOCK);
> +		int err = inode_permission_mp(idmap, nd->inode, MAY_EXEC|MAY_NOT_BLOCK, mp);
>  		if (err != -ECHILD || !try_to_unlazy(nd))
>  			return err;
>  	}
> -	return inode_permission(idmap, nd->inode, MAY_EXEC);
> +	return inode_permission_mp(idmap, nd->inode, MAY_EXEC, mp);
>  }
>  
>  static int reserve_stack(struct nameidata *nd, struct path *link)
> @@ -2501,6 +2533,8 @@ int filename_lookup(int dfd, struct filename *name, unsigned flags,
>  	if (IS_ERR(name))
>  		return PTR_ERR(name);
>  	set_nameidata(&nd, dfd, name, root);
> +	if ((flags & LOOKUP_MOUNTPOINT) && may_mount())
> +		nd.state = ND_SYS_ADMIN;
>  	retval = path_lookupat(&nd, flags | LOOKUP_RCU, path);
>  	if (unlikely(retval == -ECHILD))
>  		retval = path_lookupat(&nd, flags, path);
> -- 
> 2.40.0
> 
