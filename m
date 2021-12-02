Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1018466A5A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Dec 2021 20:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348549AbhLBTYE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Dec 2021 14:24:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237532AbhLBTYE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Dec 2021 14:24:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55AC7C06174A
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Dec 2021 11:20:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 335E8627A2
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Dec 2021 19:20:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E64EC00446;
        Thu,  2 Dec 2021 19:20:37 +0000 (UTC)
Date:   Thu, 2 Dec 2021 20:20:34 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Seth Forshee <sforshee@digitalocean.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Amir Goldstein <amir73il@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 10/10] fs: support mapped mounts of mapped filesystems
Message-ID: <20211202192034.wdod3j6adwqtfz43@wittgenstein>
References: <20211130121032.3753852-1-brauner@kernel.org>
 <20211130121032.3753852-11-brauner@kernel.org>
 <YakHc4tx1or8n7uj@do-x1extreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YakHc4tx1or8n7uj@do-x1extreme>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 02, 2021 at 11:50:43AM -0600, Seth Forshee wrote:
> On Tue, Nov 30, 2021 at 01:10:32PM +0100, Christian Brauner wrote:
> > From: Christian Brauner <christian.brauner@ubuntu.com>
> > 
> > In previous patches we added new and modified existing helpers to handle
> > idmapped mounts of filesystems mounted with an idmapping. In this final
> > patch we convert all relevant places in the vfs to actually pass the
> > filesystem's idmapping into these helpers.
> > 
> > With this the vfs is in shape to handle idmapped mounts of filesystems
> > mounted with an idmapping. Note that this is just the generic
> > infrastructure. Actually adding support for idmapped mounts to a
> > filesystem mountable with an idmapping is follow-up work.
> > 
> > In this patch we extend the definition of an idmapped mount from a mount
> > that that has the initial idmapping attached to it to a mount that has
> > an idmapping attached to it which is not the same as the idmapping the
> > filesystem was mounted with.
> > 
> > As before we do not allow the initial idmapping to be attached to a
> > mount. In addition this patch prevents that the idmapping the filesystem
> > was mounted with can be attached to a mount created based on this
> > filesystem.
> > 
> > This has multiple reasons and advantages. First, attaching the initial
> > idmapping or the filesystem's idmapping doesn't make much sense as in
> > both cases the values of the i_{g,u}id and other places where k{g,u}ids
> > are used do not change. Second, a user that really wants to do this for
> > whatever reason can just create a separate dedicated identical idmapping
> > to attach to the mount. Third, we can continue to use the initial
> > idmapping as an indicator that a mount is not idmapped allowing us to
> > continue to keep passing the initial idmapping into the mapping helpers
> > to tell them that something isn't an idmapped mount even if the
> > filesystem is mounted with an idmapping.
> > 
> > Link: https://lore.kernel.org/r/20211123114227.3124056-11-brauner@kernel.org (v1)
> > Cc: Seth Forshee <sforshee@digitalocean.com>
> > Cc: Amir Goldstein <amir73il@gmail.com>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > CC: linux-fsdevel@vger.kernel.org
> > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > ---
> > /* v2 */
> > - Amir Goldstein <amir73il@gmail.com>:
> >   - Continue passing down the initial idmapping to xfs. Since xfs cannot
> >     and is not planned to support idmapped superblocks don't mislead
> >     readers in the code by passing down the filesystem idmapping. It
> >     will be the initial idmapping always anyway.
> >   - Include mnt_idmapping.h header into fs/namespace.c
> > ---
> >  fs/namespace.c       | 37 +++++++++++++++++++++++++------------
> >  fs/open.c            |  7 ++++---
> >  fs/posix_acl.c       |  8 ++++----
> >  include/linux/fs.h   | 17 +++++++++--------
> >  security/commoncap.c |  9 ++++-----
> >  5 files changed, 46 insertions(+), 32 deletions(-)
> > 
> > diff --git a/fs/namespace.c b/fs/namespace.c
> > index 4994b816a74c..ccefede4ba1b 100644
> > --- a/fs/namespace.c
> > +++ b/fs/namespace.c
> > @@ -31,6 +31,7 @@
> >  #include <uapi/linux/mount.h>
> >  #include <linux/fs_context.h>
> >  #include <linux/shmem_fs.h>
> > +#include <linux/mnt_idmapping.h>
> >  
> >  #include "pnode.h"
> >  #include "internal.h"
> > @@ -561,7 +562,7 @@ static void free_vfsmnt(struct mount *mnt)
> >  	struct user_namespace *mnt_userns;
> >  
> >  	mnt_userns = mnt_user_ns(&mnt->mnt);
> > -	if (mnt_userns != &init_user_ns)
> > +	if (!initial_mapping(mnt_userns))
> >  		put_user_ns(mnt_userns);
> >  	kfree_const(mnt->mnt_devname);
> >  #ifdef CONFIG_SMP
> > @@ -965,6 +966,7 @@ static struct mount *skip_mnt_tree(struct mount *p)
> >  struct vfsmount *vfs_create_mount(struct fs_context *fc)
> >  {
> >  	struct mount *mnt;
> > +	struct user_namespace *fs_userns;
> >  
> >  	if (!fc->root)
> >  		return ERR_PTR(-EINVAL);
> > @@ -982,6 +984,10 @@ struct vfsmount *vfs_create_mount(struct fs_context *fc)
> >  	mnt->mnt_mountpoint	= mnt->mnt.mnt_root;
> >  	mnt->mnt_parent		= mnt;
> >  
> > +	fs_userns = mnt->mnt.mnt_sb->s_user_ns;
> > +	if (!initial_mapping(fs_userns))
> > +		mnt->mnt.mnt_userns = get_user_ns(fs_userns);
> > +
> 
> Won't this get be leaked if mnt_userns is overwritten by
> do_idmap_mount()?

Yep, good catch. Thanks for spotting this! I fixed that up in the tree.
We need a put in do_idmap_mount() as you've mentioned for the
!initial_mapping() case.

> 
> >  	lock_mount_hash();
> >  	list_add_tail(&mnt->mnt_instance, &mnt->mnt.mnt_sb->s_mounts);
> >  	unlock_mount_hash();
> > @@ -1072,7 +1078,7 @@ static struct mount *clone_mnt(struct mount *old, struct dentry *root,
> >  
> >  	atomic_inc(&sb->s_active);
> >  	mnt->mnt.mnt_userns = mnt_user_ns(&old->mnt);
> > -	if (mnt->mnt.mnt_userns != &init_user_ns)
> > +	if (!initial_mapping(mnt->mnt.mnt_userns))
> >  		mnt->mnt.mnt_userns = get_user_ns(mnt->mnt.mnt_userns);
> >  	mnt->mnt.mnt_sb = sb;
> >  	mnt->mnt.mnt_root = dget(root);
> > @@ -3927,10 +3933,18 @@ static unsigned int recalc_flags(struct mount_kattr *kattr, struct mount *mnt)
> >  static int can_idmap_mount(const struct mount_kattr *kattr, struct mount *mnt)
> >  {
> >  	struct vfsmount *m = &mnt->mnt;
> > +	struct user_namespace *fs_userns = m->mnt_sb->s_user_ns;
> >  
> >  	if (!kattr->mnt_userns)
> >  		return 0;
> >  
> > +	/*
> > +	 * Creating an idmapped mount with the filesystem wide idmapping
> > +	 * doesn't make sense so block that. We don't allow mushy semantics.
> > +	 */
> > +	if (kattr->mnt_userns == fs_userns)
> > +		return -EINVAL;
> > +
> >  	/*
> >  	 * Once a mount has been idmapped we don't allow it to change its
> >  	 * mapping. It makes things simpler and callers can just create
> > @@ -3943,12 +3957,8 @@ static int can_idmap_mount(const struct mount_kattr *kattr, struct mount *mnt)
> >  	if (!(m->mnt_sb->s_type->fs_flags & FS_ALLOW_IDMAP))
> >  		return -EINVAL;
> >  
> > -	/* Don't yet support filesystem mountable in user namespaces. */
> > -	if (m->mnt_sb->s_user_ns != &init_user_ns)
> > -		return -EINVAL;
> > -
> >  	/* We're not controlling the superblock. */
> > -	if (!capable(CAP_SYS_ADMIN))
> > +	if (!ns_capable(fs_userns, CAP_SYS_ADMIN))
> >  		return -EPERM;
> >  
> >  	/* Mount has already been visible in the filesystem hierarchy. */
> > @@ -4133,13 +4143,16 @@ static int build_mount_idmapped(const struct mount_attr *attr, size_t usize,
> >  	}
> >  
> >  	/*
> > -	 * The init_user_ns is used to indicate that a vfsmount is not idmapped.
> > -	 * This is simpler than just having to treat NULL as unmapped. Users
> > -	 * wanting to idmap a mount to init_user_ns can just use a namespace
> > -	 * with an identity mapping.
> > +	 * The initial idmapping cannot be used to create an idmapped
> > +	 * mount. Attaching the initial idmapping doesn't make much sense
> > +	 * as it is an identity mapping. A user can just create a dedicated
> > +	 * identity mapping to achieve the same result. We also use the
> > +	 * initial idmapping as an indicator of a mount that is not
> > +	 * idmapped. It can simply be passed into helpers that are aware of
> > +	 * idmapped mounts as a convenient shortcut.
> >  	 */
> 
> This isn't completely accurate, is it? If sb->s_user_ns != init_user_ns,
> an idmap to init_user_ns isn't an idendity mapping.

Yep, that's correct. Let me reword that.

Thank you for the reviews!
Christian
