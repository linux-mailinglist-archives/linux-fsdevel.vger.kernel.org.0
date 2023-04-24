Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A736ED3A5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 19:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbjDXRg7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 13:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjDXRgu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 13:36:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C93D6E88
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 10:36:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 762006277E
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 17:36:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6AF2C433D2;
        Mon, 24 Apr 2023 17:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682357786;
        bh=O+VH47OY+LMKS1yWRxLnFITGzAXnJhMcO+aQ31YosSI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CHTJcerld60cyeUxcXERpLEUdnU9xeS/xs6JKknGZF4HiWke7EGQ4INji9IoyuGRD
         XB6QrYUhU/MD+KV3tJnl4Fole95JrQexde2hGazDSel1wij/oWbBXMhLyk9hl6xc3f
         IV5OeBGAbxlfuXRUahKwCm6HtRlnP/0UeFypJI9EfNDy/JyYOyPpLj8pmkn5bJ6SvY
         9DYYfdCI2L2OC53g68ffzN5DAnzubfeGKIMYf/Yjpscax7/kr47iwp6XwpJCuNnFTa
         GD0RDqG+/9PBfoZ3ResCywL8ShM2rbrwZKksgohBq436wCymQOENGiHNfcVNuURb6d
         T9fGbQDQB9sSg==
Date:   Mon, 24 Apr 2023 19:36:22 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Seth Forshee <sforshee@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 5/5] fs: allow to tuck mounts explicitly
Message-ID: <20230424-lagen-ansetzen-b50d5ad83fe7@brauner>
References: <20230202-fs-move-mount-replace-v1-0-9b73026d5f10@kernel.org>
 <20230202-fs-move-mount-replace-v1-5-9b73026d5f10@kernel.org>
 <20230421062958.GE3390869@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230421062958.GE3390869@ZenIV>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 21, 2023 at 07:29:58AM +0100, Al Viro wrote:
> On Sat, Mar 18, 2023 at 04:52:01PM +0100, Christian Brauner wrote:
> 
> > +/**
> > + * mnt_tuck_mountpoint - tuck a mount beneath another one
> > + *
> > + * @tucked_mnt: the mount to tuck
> > + * @top_mnt:	the mount to tuck @tucked_mnt under
> > + * @tucked_mp:	the new mountpoint of @top_mnt on @tucked_mnt
> > + *
> > + * Remove @top_mnt from its current mountpoint @top_mnt->mnt_mp and
> > + * parent @top_mnt->mnt_parent and mount it on top of @tucked_mnt at
> > + * @tucked_mp. And mount @tucked_mnt on the old parent and old
> > + * mountpoint of @top_mnt.
> > + *
> > + * Note that we keep the reference count in tact when we remove @top_mnt
> > + * from its old mountpoint and parent to prevent UAF issues. Once we've
> > + * mounted @top_mnt on @tucked_mnt the reference count gets bumped once
> > + * more. So make sure that we drop it to not leak the mount and
> > + * mountpoint.
> > + */
> > +static void mnt_tuck_mountpoint(struct mount *tucked_mnt, struct mount *top_mnt,
> > +				struct mountpoint *tucked_mp)
> > +{
> > +	struct mount *old_top_parent = top_mnt->mnt_parent;
> > +	struct mountpoint *old_top_mp;
> > +
> > +	old_top_mp = unhash_mnt(top_mnt);
> > +	attach_mnt(top_mnt, tucked_mnt, tucked_mp);
> > +	mnt_set_mountpoint(old_top_parent, old_top_mp, tucked_mnt);
> > +	put_mountpoint(old_top_mp);
> > +	mnt_add_count(old_top_parent, -1);
> > +}
> 
> Umm...  And if something is mounted on top of your tucked_mnt?  Right
> on top of its root, I mean...  BTW, why not make it
> 
> static void mnt_tuck_mountpoint(struct mount *tucked_mnt, struct mount *top_mnt,
>                                 struct mountpoint *tucked_mp)
> {
>         struct mount *old_parent = top_mnt->mnt_parent;
>         struct mountpoint *old_mp = top_mnt->mnt_mp;
> 
>         mnt_set_mountpoint(old_parent, old_mp, tucked_mnt);
>         mnt_change_mountpoint(tucked_mnt, tucked_mp, top_mnt);
> }
> 
> I mean, look at the existing caller of mnt_change_mountpoint() nearby -
> that's precisely how that "tucking" is done right now.  And I'm rather
> afraid that it's vulnerable to the same problem - if the tree we are
> copying has the root of its root mount overmounted by something...

Are you just trying to point out that this would create shadow mounts - aka
discussion in the previous mail - or is there something else you're getting at?

If it's shadow mounts then this could be restricted to non-overmounted source
mounts aka do a lookup_mnt(from_path) and if it doesn't return NULL refuse
creating a tucked mount with @from_path?

> 
> > +static void tuck_mnt(struct mount *tucked_mnt,
> > +		     struct mount *top_mnt,
> > +		     struct mountpoint *tucked_mp)
> > +{
> > +	mnt_tuck_mountpoint(tucked_mnt, top_mnt, tucked_mp);
> > +	__attach_mnt(tucked_mnt, tucked_mnt->mnt_parent);
> > +}
> 
> Not sure it's worth bothering with - only one caller and it might be
> cleaner to expand attach_mnt() there, turning it into set or tuck,
> followed by unconditional __attach...

Yeah, sure.

> 
> > +typedef enum mnt_tree_flags_t {
> > +	MNT_TREE_MOVE	= BIT(0),
> > +	MNT_TREE_TUCK	= BIT(1),

I've renamed all that in v2 btw to MNT_TREE_BENEATH/MOVE_MOUNT_BENEATH
so as to avoid the inevitable mount --f... typo. Also I've been told I
should've urban-dictionaried it. I haven't yet done so. But there might be
additional fun I'm currently unaware of...

> > +} mnt_tree_flags_t;
> 
> What combinations are possible?

Both can be specified together or alone.

> 
> >  static int attach_recursive_mnt(struct mount *source_mnt,
> > -			struct mount *dest_mnt,
> > -			struct mountpoint *dest_mp,
> > -			bool moving)
> > +				struct mount *top_mnt,
> > +				struct mountpoint *dest_mp,
> > +				mnt_tree_flags_t flags)
> >  {
> >  	struct user_namespace *user_ns = current->nsproxy->mnt_ns->user_ns;
> >  	HLIST_HEAD(tree_list);
> > -	struct mnt_namespace *ns = dest_mnt->mnt_ns;
> > +	struct mnt_namespace *ns = top_mnt->mnt_ns;
> >  	struct mountpoint *smp;
> > -	struct mount *child, *p;
> > +	struct mount *child, *dest_mnt, *p;
> >  	struct hlist_node *n;
> > -	int err;
> > +	int err = 0;
> > +	bool moving = flags & MNT_TREE_MOVE, tuck = flags & MNT_TREE_TUCK;
> >  
> >  	/* Preallocate a mountpoint in case the new mounts need
> >  	 * to be tucked under other mounts.
> > @@ -2244,29 +2305,48 @@ static int attach_recursive_mnt(struct mount *source_mnt,
> >  			goto out;
> >  	}
> >  
> > +	if (tuck)
> > +		dest_mnt = top_mnt->mnt_parent;
> > +	else
> > +		dest_mnt = top_mnt;
> > +
> >  	if (IS_MNT_SHARED(dest_mnt)) {
> >  		err = invent_group_ids(source_mnt, true);
> >  		if (err)
> >  			goto out;
> >  		err = propagate_mnt(dest_mnt, dest_mp, source_mnt, &tree_list);
> > -		lock_mount_hash();
> > -		if (err)
> > -			goto out_cleanup_ids;
> > +	}
> > +	lock_mount_hash();
> > +	if (err)
> > +		goto out_cleanup_ids;
> > +
> > +	/* Recheck with lock_mount_hash() held. */
> > +	if (tuck && IS_MNT_LOCKED(top_mnt)) {
> > +		err = -EINVAL;
> > +		goto out_cleanup_ids;
> > +	}
> > +
> > +	if (IS_MNT_SHARED(dest_mnt)) {
> >  		for (p = source_mnt; p; p = next_mnt(p, source_mnt))
> >  			set_mnt_shared(p);
> > -	} else {
> > -		lock_mount_hash();
> >  	}
> > +
> >  	if (moving) {
> >  		unhash_mnt(source_mnt);
> > -		attach_mnt(source_mnt, dest_mnt, dest_mp);
> > +		if (tuck)
> > +			tuck_mnt(source_mnt, top_mnt, smp);
> > +		else
> > +			attach_mnt(source_mnt, dest_mnt, dest_mp);
> >  		touch_mnt_namespace(source_mnt->mnt_ns);
> >  	} else {
> >  		if (source_mnt->mnt_ns) {
> >  			/* move from anon - the caller will destroy */
> >  			list_del_init(&source_mnt->mnt_ns->list);
> >  		}
> > -		mnt_set_mountpoint(dest_mnt, dest_mp, source_mnt);
> > +		if (tuck)
> > +			mnt_tuck_mountpoint(source_mnt, top_mnt, smp);
> > +		else
> > +			mnt_set_mountpoint(dest_mnt, dest_mp, source_mnt);
> >  		commit_tree(source_mnt);
> >  	}
> >  
> > @@ -2306,14 +2386,35 @@ static int attach_recursive_mnt(struct mount *source_mnt,
> >  	return err;
> >  }
> >  
> > -static struct mountpoint *lock_mount(struct path *path)
> > +/**
> > + * lock_mount_mountpoint - lock mount and mountpoint
> > + * @path: target path
> > + * @tuck: whether we intend to tuck a mount beneath @path
> > + *
> > + * Follow the mount stack on @path until the top mount is found.
> > + *
> > + * If we intend to mount on top of @path->mnt acquire the inode_lock()
> > + * for the top mount's ->mnt_root to protect against concurrent removal
> > + * of our prospective mountpoint from another mount namespace.
> > + *
> > + * If we intend to tuck beneath the top mount @m acquire the
> > + * inode_lock() on @m's mountpoint @mp on @m->mnt_parent. Otherwise we
> > + * risk racing with someone who unlinked @mp from another mount
> > + * namespace where @m doesn't have a child mount mounted @mp. We don't
> > + * care if @m->mnt_root/@path->dentry is removed (as long as
> > + * @path->dentry isn't equal to @m->mnt_mountpoint of course).
> > + *
> > + * Return: Either the target mountpoint on the top mount or the top
> > + *         mount's mountpoint.
> > + */
> > +static struct mountpoint *lock_mount_mountpoint(struct path *path, bool tuck)
> >  {
> >  	struct vfsmount *mnt = path->mnt;
> >  	struct dentry *dentry;
> >  	struct mountpoint *mp;
> >  
> >  	for (;;) {
> > -		dentry = path->dentry;
> > +		dentry = tuck ? real_mount(mnt)->mnt_mountpoint : path->dentry;
> >  		inode_lock(dentry->d_inode);
> 
> What happens if another mount --move changes ->mnt_mountpoint of that sucker

Groan, right.

> just as we fetch it and we end up with inode_lock(dentry->d_inode) of a dentry
> that is not pinned by anything?  path->dentry *is* pinned, so it's safe to
> work with; this one, OTOH...

So taking

if (beneath) {
        read_seqlock_excl(&mount_lock);
        dentry = dget(real_mount(mnt)->mnt_mountpoint);
        read_sequnlock_excl(&mount_lock);

and checking under namespace_lock() that mnt->mnt_mountpoint == dentry should
be enough to protect against this, no?

> 
> > +/**
> > + * can_tuck_mount - check that we can tuck a mount
> > + * @from: mount to tuck under
> > + * @to:   mount under which to tuck
> > + *
> > + * - Make sure that the mount to tuck under isn't a shared mount so we
> > + *   force the kernel to allocate a new peer group id. This simplifies
> > + *   the mount trees that can be created and limits propagation events
> > + *   in cases where @to, and/or @to->mnt_parent are in the same peer
> > + *   group. Something that's a nuisance already today.
> > + * - Make sure that @to->dentry is actually the root of a mount under
> > + *   which we can tuck another mount.
> > + * - Make sure that nothing can be tucked under the caller's current
> > + *   root or the rootfs of the namespace.
> > + * - Make sure that the caller can unmount the topmost mount ensuring
> > + *   that the caller could reveal the underlying mountpoint.
> > + *
> > + * Return: On success 0, and on error a negative error code is returned.
> > + */
> > +static int can_tuck_mount(struct path *from, struct path *to)
> > +{
> > +	struct mount *mnt_from = real_mount(from->mnt),
> > +		     *mnt_to = real_mount(to->mnt);
> > +
> > +	if (!check_mnt(mnt_to))
> > +		return -EINVAL;
> > +
> > +	if (!mnt_has_parent(mnt_to))
> > +		return -EINVAL;
> > +
> > +	if (IS_MNT_SHARED(mnt_from))
> > +		return -EINVAL;
> 
> What if it's not shared, but gets propagation from whatever we
> are going to attach it to?

Afaict, that should be ok. In fact, even having mnt_from be a shared
mount should be ok. The reason for restricting it to non-shared mounts
is outlined above in the documentation:

- Make sure that the mount to tuck under isn't a shared mount so we
  force the kernel to allocate a new peer group id. This simplifies
  the mount trees that can be created and limits propagation events
  in cases where @to, and/or @to->mnt_parent are in the same peer
  group. Something that's a nuisance already today.

If mnt_from isn't shared and @mnt_to is shared then @mnt_from will be
turned into a shared mount with a new peer group id. Sure, @mnt_from can
have child mounts that receive propagation from @mnt_to. But all of that
should be ok.

> 
> > +	if (!path_mounted(to))
> > +		return -EINVAL;
> > +
> > +	if (mnt_from == mnt_to)
> > +		return -EINVAL;
> > +
> > +	/*
> > +	 * Tucking a mount beneath the rootfs only makes sense when the
> > +	 * tuck semantics of pivot_root(".", ".") are used.
> > +	 */
> > +	if (&mnt_to->mnt == current->fs->root.mnt)
> > +		return -EINVAL;
> > +	if (mnt_to->mnt_parent == current->nsproxy->mnt_ns->root)
> > +		return -EINVAL;
> > +
> > +	for (struct mount *p = mnt_from; mnt_has_parent(p); p = p->mnt_parent)
> > +		if (p == mnt_to)
> > +			return -EINVAL;
> 
> Umm...  Can we have !mnt_has_parent(mnt_from), BTW?
> 
> > +	/* Ensure the caller could reveal the underlying mount. */
> > +	return can_umount(to, 0);
> 
> That's really odd.  It duplicates quite a bit of the tests above and
> the whole thing is rather hard to follow, especially since you've got
> tests done after the can_tuck_mount() call in do_move_mount()...

I wanted to have permission checks explicitly and visible open-coded and
I simply thought that the duplication in can_umount() wouldn't matter...
I can get rid of that.

> 
> > +}
> > +
> > +static int do_move_mount(struct path *old_path, struct path *new_path,
> > +			 bool tuck)
> >  {
> >  	struct mnt_namespace *ns;
> >  	struct mount *p;
> > @@ -2858,8 +3021,9 @@ static int do_move_mount(struct path *old_path, struct path *new_path)
> >  	struct mountpoint *mp, *old_mp;
> >  	int err;
> >  	bool attached;
> > +	mnt_tree_flags_t flags = 0;
> >  
> > -	mp = lock_mount(new_path);
> > +	mp = lock_mount_mountpoint(new_path, tuck);
> >  	if (IS_ERR(mp))
> >  		return PTR_ERR(mp);
> >  
> > @@ -2867,9 +3031,20 @@ static int do_move_mount(struct path *old_path, struct path *new_path)
> >  	p = real_mount(new_path->mnt);
> >  	parent = old->mnt_parent;
> >  	attached = mnt_has_parent(old);
> > +	if (attached)
> > +		flags |= MNT_TREE_MOVE;
> >  	old_mp = old->mnt_mp;
> >  	ns = old->mnt_ns;
> >  
> > +	if (tuck) {
> > +		err = can_tuck_mount(old_path, new_path);
> > +		if (err)
> > +			goto out;
> > +
> > +		p = p->mnt_parent;
> > +		flags |= MNT_TREE_TUCK;
> > +	}
> > +
> >  	err = -EINVAL;
> >  	/* The mountpoint must be in our namespace. */
> >  	if (!check_mnt(p))
> 
> Why not check it first?  That'd kill the corresponding
> check_mnt(to) in can_tuck_mount() (check_mnt() on parent is
> the same as on child).  Confused...

Sure.

> 
> > @@ -2910,8 +3085,7 @@ static int do_move_mount(struct path *old_path, struct path *new_path)
> >  		if (p == old)
> >  			goto out;
> >  
> > -	err = attach_recursive_mnt(old, real_mount(new_path->mnt), mp,
> > -				   attached);
> > +	err = attach_recursive_mnt(old, real_mount(new_path->mnt), mp, flags);
> >  	if (err)
> >  		goto out;
> >  
> > @@ -2943,7 +3117,7 @@ static int do_move_mount_old(struct path *path, const char *old_name)
> >  	if (err)
> >  		return err;
> >  
> > -	err = do_move_mount(&old_path, path);
> > +	err = do_move_mount(&old_path, path, false);
> >  	path_put(&old_path);
> >  	return err;
> >  }
> > @@ -3807,6 +3981,10 @@ SYSCALL_DEFINE5(move_mount,
> >  	if (flags & ~MOVE_MOUNT__MASK)
> >  		return -EINVAL;
> >  
> > +	if ((flags & (MOVE_MOUNT_TUCK | MOVE_MOUNT_SET_GROUP)) ==
> > +	    (MOVE_MOUNT_TUCK | MOVE_MOUNT_SET_GROUP))
> > +		return -EINVAL;
> > +
> >  	/* If someone gives a pathname, they aren't permitted to move
> >  	 * from an fd that requires unmount as we can't get at the flag
> >  	 * to clear it afterwards.
> > @@ -3836,7 +4014,8 @@ SYSCALL_DEFINE5(move_mount,
> >  	if (flags & MOVE_MOUNT_SET_GROUP)
> >  		ret = do_set_group(&from_path, &to_path);
> >  	else
> > -		ret = do_move_mount(&from_path, &to_path);
> > +		ret = do_move_mount(&from_path, &to_path,
> > +				    (flags & MOVE_MOUNT_TUCK));
> 
> OK, so you want to be able to use that on an anonymous tree, then?

Yeah, absolutely. Anonymous mounts are an absolute _delight_ and super nice for
service managers and containers that work a lot with mounts and need guarantees
that stuff can't just get overmounted without their knowledge.

Idk if you follow userspace at all but I've been pushing for util-linux
to completely adapt the new mount api as part of idmapped mount support.
That work will land in util-linux 2.39 (should be released in the next weeks).
So there we'll deal with a lot of anonymous mounts going forward.
