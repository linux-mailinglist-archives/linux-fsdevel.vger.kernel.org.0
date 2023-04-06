Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A846D98C4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Apr 2023 15:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238854AbjDFN5R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Apr 2023 09:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238861AbjDFN5P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Apr 2023 09:57:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F06AD0F
        for <linux-fsdevel@vger.kernel.org>; Thu,  6 Apr 2023 06:56:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41F856456E
        for <linux-fsdevel@vger.kernel.org>; Thu,  6 Apr 2023 13:56:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A634FC433D2;
        Thu,  6 Apr 2023 13:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680789402;
        bh=lQ5QR2UWta5vym3u3pTMMEle7AJvAeCmn0DncLzJXfg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K/gE+CtLgQ+0Hk02F5xHSIufDFXEAYwYpVThiDKVyLuq4waLdSo0PgaRUfUAQJ8AB
         /3MBAeinLQxlvxBT+S+Iy640rzZEpVwoD6fiym4qhwT2CI38PhYQXf9IojPUgxXb8g
         WFEfOngz0ifZCl0HCj8kO55gJ2xU3WRPifPFCR3l6vxRRAdodltCICVHKMH3SajOvv
         2+NRyUrRdaf65xK7fT5alPHQGw2vBUA5vTk6tmuYjzi6uNjhSLadcofjp23UEsf0Vv
         at4SNVcduC66QQscFKDdnWgufBy7Xg1GhKXkeFzDwcDw2+WDciUx0IcB4b6KEag5Jt
         UT+n2/BBtgO3g==
Date:   Thu, 6 Apr 2023 15:56:38 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Seth Forshee <sforshee@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] fs: allow to mount beneath top mount
Message-ID: <20230406-nachsagen-fluchen-2a3140949b6b@brauner>
References: <20230202-fs-move-mount-replace-v2-0-f53cd31d6392@kernel.org>
 <20230202-fs-move-mount-replace-v2-5-f53cd31d6392@kernel.org>
 <ZC3NTif1b6pOQuRP@do-x1extreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZC3NTif1b6pOQuRP@do-x1extreme>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 05, 2023 at 02:34:38PM -0500, Seth Forshee wrote:
> On Tue, Mar 28, 2023 at 06:13:10PM +0200, Christian Brauner wrote:
> 
> <snip>
> 
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> 
> I don't have a detailed knowledge of every subtlety of dealing with
> mounts, but I looked this over and it looks sound. I've added a few
> comments below regarding some opinions around names and minor comment
> fixes, but overall LGTM.
> 
> Reviewed-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
> 
> > ---
> >  fs/namespace.c             | 235 +++++++++++++++++++++++++++++++++++++++------
> >  include/uapi/linux/mount.h |   3 +-
> >  2 files changed, 210 insertions(+), 28 deletions(-)
> > 
> > diff --git a/fs/namespace.c b/fs/namespace.c
> > index 7f22fcfd8eab..fdb30842f3aa 100644
> > --- a/fs/namespace.c
> > +++ b/fs/namespace.c
> > @@ -935,6 +935,63 @@ static void attach_mnt(struct mount *mnt,
> >  	__attach_mnt(mnt, parent);
> >  }
> >  
> > +/**
> > + * mnt_set_mountpoint_beneath - mount a mount beneath another one
> > + *
> > + * @new_parent: the source mount
> > + * @top_mnt:	the mount beneath which @new_parent is mounted
> > + * @new_mp:	the new mountpoint of @top_mnt on @new_parent
> > + *
> > + * Remove @top_mnt from its current mountpoint @top_mnt->mnt_mp and
> > + * parent @top_mnt->mnt_parent and mount it on top of @new_parent at
> > + * @new_mp. And mount @new_parent on the old parent and old
> > + * mountpoint of @top_mnt.
> > + *
> > + * Note that we keep the reference count in tact when we remove @top_mnt
> > + * from its old mountpoint and parent to prevent UAF issues. Once we've
> > + * mounted @top_mnt on @new_parent the reference count gets bumped once
> > + * more. So make sure that we drop it to not leak the mount and
> > + * mountpoint.
> > + */
> > +static void mnt_set_mountpoint_beneath(struct mount *new_parent,
> > +				       struct mount *top_mnt,
> > +				       struct mountpoint *new_mp)
> 
> Just my preference, but I don't like the name @new_parent here. It kind
> of implies to me that the point is to reparent @top_mnt onto @new_parent
> rather than inserting a new mount underneath @top_mnt. I'd prefer
> something like @new, @new_mnt, or even just @mnt.

Sure, I can change that.

> 
> > +{
> > +	struct mount *old_top_parent = top_mnt->mnt_parent;
> > +	struct mountpoint *old_top_mp;
> > +
> > +	old_top_mp = unhash_mnt(top_mnt);
> > +	attach_mnt(top_mnt, new_parent, new_mp);
> > +	mnt_set_mountpoint(old_top_parent, old_top_mp, new_parent);
> > +	put_mountpoint(old_top_mp);
> > +	mnt_add_count(old_top_parent, -1);
> > +}
> > +
> > +/**
> > + * mnt_beneath - mount a mount beneath another one, attach to
> > + *               @mount_hashtable and parent's list of child mounts
> 
> This doesn't match the name of the function.

Yep, already fixed locally. I think kernel test robot complained about
this as well.

> 
> > + *
> > + * @new_parent: the source mount
> > + * @top_mnt:	the mount beneath which @new_parent is mounted
> > + * @new_mp:	the new mountpoint of @top_mnt on @new_parent
> > + *
> > + * Remove @top_mnt from its current parent and mountpoint and mount it
> > + * on @new_mp on @new_parent, and mount @new_parent on the old parent
> > + * and old mountpoint of @top_mnt. Finally, attach @new_parent mount to
> > + * @mnt_hashtable and @new_parent->mnt_parent->mnt_mounts.
> > + *
> > + * Note, when we call __attach_mnt() we've already mounted @new_parent
> > + * on top of @top_mnt's old parent so @new_parent->mnt_parent will point
> > + * to the correct parent.
> > + */
> > +static void attach_mnt_beneath(struct mount *new_parent,
> > +		     struct mount *top_mnt,
> > +		     struct mountpoint *new_mp)
> > +{
> > +	mnt_set_mountpoint_beneath(new_parent, top_mnt, new_mp);
> > +	__attach_mnt(new_parent, new_parent->mnt_parent);
> > +}
> > +
> >  void mnt_change_mountpoint(struct mount *parent, struct mountpoint *mp, struct mount *mnt)
> >  {
> >  	struct mountpoint *old_mp = mnt->mnt_mp;
> > @@ -2154,12 +2211,16 @@ int count_mounts(struct mnt_namespace *ns, struct mount *mnt)
> >  	return 0;
> >  }
> >  
> > +typedef enum mnt_tree_flags_t {
> > +	MNT_TREE_MOVE		= BIT(0),
> > +	MNT_TREE_BENEATH	= BIT(1),
> > +} mnt_tree_flags_t;
> 
> Typically the _t would be left out of the enum name and only included in
> the type name.

Ok.

> 
> > +
> >  /*
> >   *  @source_mnt : mount tree to be attached
> > - *  @nd         : place the mount tree @source_mnt is attached
> > - *  @parent_nd  : if non-null, detach the source_mnt from its parent and
> > - *  		   store the parent mount and mountpoint dentry.
> > - *  		   (done when source_mnt is moved)
> > + *  @top_mnt	: mount that @source_mnt will be mounted on or mounted beneath
> > + *  @dest_mp	: the mountpoint @source_mnt will be mounted at
> > + *  @flags	: modify how @source_mnt is supposed to be attached
> >   *
> >   *  NOTE: in the table below explains the semantics when a source mount
> >   *  of a given type is attached to a destination mount of a given type.
> 
> Since you're updating the comment seems you might as well also add the
> function name to really make it kernel-doc format.

Ah, that was an oversight on my part. Added now.

> 
> > @@ -2218,20 +2279,21 @@ int count_mounts(struct mnt_namespace *ns, struct mount *mnt)
> >   * in allocations.
> >   */
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
> > +	bool moving = flags & MNT_TREE_MOVE, beneath = flags & MNT_TREE_BENEATH;
> >  
> >  	/* Preallocate a mountpoint in case the new mounts need
> > -	 * to be tucked under other mounts.
> > +	 * to be mounted beneath under other mounts.
> 
> s/beneath under/beneath/

Thanks.

> 
> > @@ -2306,14 +2387,36 @@ static int attach_recursive_mnt(struct mount *source_mnt,
> >  	return err;
> >  }
> >  
> > -static struct mountpoint *lock_mount(struct path *path)
> > +/**
> > + * lock_mount_mountpoint - lock mount and mountpoint
> > + * @path: target path
> > + * @beneath: whether we intend to mount beneath @path
> > + *
> > + * Follow the mount stack on @path until the top mount is found.
> > + *
> > + * If we intend to mount on top of @path->mnt acquire the inode_lock()
> > + * for the top mount's ->mnt_root to protect against concurrent removal
> > + * of our prospective mountpoint from another mount namespace.
> > + *
> > + * If we intend to mount beneath the top mount @m acquire the
> > + * inode_lock() on @m's mountpoint @mp on @m->mnt_parent. Otherwise we
> > + * risk racing with someone who unlinked @mp from another mount
> > + * namespace where @m doesn't have a child mount mounted @mp. We don't
> > + * care if @m->mnt_root/@path->dentry is removed (as long as
> > + * @path->dentry isn't equal to @m->mnt_mountpoint of course).
> > + *
> > + * Return: Either the target mountpoint on the top mount or the top
> > + *         mount's mountpoint.
> > + */
> > +static struct mountpoint *lock_mount_mountpoint(struct path *path, bool beneath)
> >  {
> >  	struct vfsmount *mnt = path->mnt;
> >  	struct dentry *dentry;
> >  	struct mountpoint *mp;
> >  
> >  	for (;;) {
> > -		dentry = path->dentry;
> > +		dentry = beneath ? real_mount(mnt)->mnt_mountpoint :
> > +				   path->dentry;
> >  		inode_lock(dentry->d_inode);
> >  		if (unlikely(cant_mount(dentry))) {
> >  			inode_unlock(dentry->d_inode);
> > @@ -2343,6 +2446,11 @@ static struct mountpoint *lock_mount(struct path *path)
> >  	return mp;
> >  }
> >  
> > +static inline struct mountpoint *lock_mount(struct path *path)
> > +{
> > +	return lock_mount_mountpoint(path, false);
> > +}
> > +
> 
> Another matter of preference, but I think the names lock_mount() and
> lock_mount_mountpoint() are both confusing because nothing which could
> reasonably be called a mount is actually locked. What if you rename
> these to lock_mountpoint() and __lock_mountpoint()? "Mountpoint" is a
> little overloaded, but that seems like the closest to what these
> functions are actually doing.

Hm, I think then I'll rather just go with lock_mount() and
__lock_mount() as I don't think mountpoint is clearer and it allows us
to avoid fixing up all places where lock_mount() is currently used.
