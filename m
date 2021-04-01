Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 439BB35139F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 12:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233629AbhDAKaM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Apr 2021 06:30:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:49068 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233917AbhDAK3t (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Apr 2021 06:29:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B7C7CB0B3;
        Thu,  1 Apr 2021 10:29:47 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 713D31E4415; Thu,  1 Apr 2021 12:29:47 +0200 (CEST)
Date:   Thu, 1 Apr 2021 12:29:47 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: fsnotify path hooks
Message-ID: <20210401102947.GA29690@quack2.suse.cz>
References: <CAOQ4uxjVdjLPbkkZd+_1csecDFuHxms3CcSLuAtRbKuozHUqWA@mail.gmail.com>
 <20210330125336.vj2hkgwhyrh5okee@wittgenstein>
 <CAOQ4uxjPhrY55kJLUr-=2+S4HOqF0qKAAX27h2T1H1uOnxM9pQ@mail.gmail.com>
 <20210330141703.lkttbuflr5z5ia7f@wittgenstein>
 <CAOQ4uxirMBzcaLeLoBWCMPPr7367qeKjnW3f88bh1VMr_3jv_A@mail.gmail.com>
 <20210331094604.xxbjl3krhqtwcaup@wittgenstein>
 <CAOQ4uxirud-+ot0kZ=8qaicvjEM5w1scAeoLP_-HzQx+LwihHw@mail.gmail.com>
 <20210331125412.GI30749@quack2.suse.cz>
 <CAOQ4uxjOyuvpJ7Tv3cGmv+ek7+z9BJBF4sK_-OLxwePUrHERUg@mail.gmail.com>
 <CAOQ4uxhWE9JGOZ_jN9_RT5EkACdNWXOryRsm6Wg_zkaDNDSjsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhWE9JGOZ_jN9_RT5EkACdNWXOryRsm6Wg_zkaDNDSjsA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 31-03-21 23:59:27, Amir Goldstein wrote:
> On Wed, Mar 31, 2021 at 5:06 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > > > As long as "exp_export: export of idmapped mounts not yet supported.\n"
> > > > I don't think it matters much.
> > > > It feels like adding idmapped mounts to nfsd is on your roadmap.
> > > > When you get to that we can discuss adding fsnotify path hooks to nfsd
> > > > if Jan agrees to the fsnotify path hooks concept.
> > >
> > > I was looking at the patch and thinking about it for a few days already. I
> > > think that generating fsnotify event later (higher up the stack where we
> > > have mount information) is fine and a neat idea. I just dislike the hackery
> > > with dentry flags.
> >
> > Me as well. I used this hack for fast POC.
> >
> > If we stick with the dual hooks approach, we will have to either pass a new
> > argument to vfs helpers or use another trick:
> >
> > Convert all the many calls sites that were converted by Christian to:
> >    vfs_XXX(&init_user_ns, ...
> > because they do not have mount context, to:
> >    vfs_XXX(NULL, ...
> >
> > Inside the vfs helpers, use init_user_ns when mnt_userns is NULL,
> > but pass the original mnt_userns argument to fsnotify_ns_XXX hooks.
> > A non-NULL mnt_userns arg means "path_notify" context.
> > I have already POC code for passing mnt_userns to fsnotify hooks [1].
> >
> > I did not check if this assumption always works, but there seems to
> > be a large overlap between idmapped aware callers and use cases
> > that will require sending events to a mount mark.
> >
> 
> The above "trick" is pretty silly as I believe Christian intends
> to fix all those call sites that pass init_user_ns.

If he does that we also should have the mountpoint there to use for
fsnotify, shouldn't we? :)

> > > Also I'm somewhat uneasy that it is random (from
> > > userspace POV) when path event is generated and when not (at least that's
> > > my impression from the patch - maybe I'm wrong). How difficult would it be
> > > to get rid of it? I mean what if we just moved say fsnotify_create() call
> > > wholly up the stack? It would mean more explicit calls to fsnotify_create()
> > > from filesystems - as far as I'm looking nfsd, overlayfs, cachefiles,
> > > ecryptfs. But that would seem to be manageable.  Also, to maintain sanity,
> >
> > 1. I don't think we can do that for all the fsnotify_create() hooks, such as
> >     debugfs for example
> > 2. It is useless to pass the mount from overlayfs to fsnotify, its a private
> >     mount that users cannot set a mark on anyway and Christian has
> >     promised to propose the same change for cachefiles and ecryptfs,
> >     so I think it's not worth the churn in those call sites
> > 3. I am uneasy with removing the fsnotify hooks from vfs helpers and
> >     trusting that new callers of vfs_create() will remember to add the high
> >     level hooks, so I prefer the existing behavior remains for such callers
> >
> 
> So I read your proposal the wrong way.
> You meant move fsnotify_create() up *without* passing mount context
> from overlayfs and friends.

Well, I was thinking that we could find appropriate mount context for
overlayfs or ecryptfs (which just shows how little I know about these
filesystems ;) I didn't think of e.g. debugfs. Anyway, if we can make
mountpoint marks work for directory events at least for most filesystems, I
think that is OK as well. However it would be then needed to detect whether
a given filesystem actually supports mount marks for dir events and if not,
report error from fanotify_mark() instead of silently not generating
events.

> So yeh, I do think it is manageable. I think the best solution would be
> something along the lines of wrappers like the following:
> 
> static inline int vfs_mkdir(...)
> {
>         int error = __vfs_mkdir_nonotify(...);
>         if (!error)
>                 fsnotify_mkdir(dir, dentry);
>         return error;
> }
> 
> And then the few call sites that call the fsnotify_path_ hooks
> (i.e. in syscalls and perhaps later in nfsd) will call the
> __vfs_xxx_nonotify() variant.

Yes, that is OK with me. Or we could have something like:

static inline void fsnotify_dirent(struct vfsmount *mnt, struct inode *dir,
				   struct dentry *dentry, __u32 mask)
{
	if (!mnt) {
		fsnotify(mask, d_inode(dentry), FSNOTIFY_EVENT_INODE, dir,
			 &dentry->d_name, NULL, 0);
	} else {
		struct path path = {
			.mnt = mnt,
			.dentry = d_find_any_alias(dir)
		};
		fsnotify(mask, d_inode(dentry), FSNOTIFY_EVENT_PATH, &path,
			 &dentry->d_name, NULL, 0);
	}
}

static inline void fsnotify_mkdir(struct vfsmount *mnt, struct inode *inode,
				  struct dentry *dentry)
{
        audit_inode_child(inode, dentry, AUDIT_TYPE_CHILD_CREATE);

        fsnotify_dirent(mnt, inode, dentry, FS_CREATE | FS_ISDIR);
}

static inline int vfs_mkdir(mnt, ...)
{
	int error = __vfs_mkdir_nonotify(...);
	if (!error)
		fsnotify_mkdir(mnt, dir, dentry);
}

And pass mnt to vfs_mkdir() for filesystems where we have it...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
