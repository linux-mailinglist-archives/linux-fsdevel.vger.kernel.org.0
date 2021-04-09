Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB4F2359C50
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 12:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233508AbhDIKqE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Apr 2021 06:46:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:36550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231611AbhDIKqD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Apr 2021 06:46:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CCF0160230;
        Fri,  9 Apr 2021 10:45:48 +0000 (UTC)
Date:   Fri, 9 Apr 2021 12:45:46 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: fsnotify path hooks
Message-ID: <20210409104546.37i6h2i4ga2xakvp@wittgenstein>
References: <CAOQ4uxirud-+ot0kZ=8qaicvjEM5w1scAeoLP_-HzQx+LwihHw@mail.gmail.com>
 <20210331125412.GI30749@quack2.suse.cz>
 <CAOQ4uxjOyuvpJ7Tv3cGmv+ek7+z9BJBF4sK_-OLxwePUrHERUg@mail.gmail.com>
 <CAOQ4uxhWE9JGOZ_jN9_RT5EkACdNWXOryRsm6Wg_zkaDNDSjsA@mail.gmail.com>
 <20210401102947.GA29690@quack2.suse.cz>
 <CAOQ4uxjHFkRVTY5iyTSpb0R5R6j-j=8+Htpu2hgMAz9MTci-HQ@mail.gmail.com>
 <CAOQ4uxjS56hjaXeTUdce2gJT3tTFb2Zs1_PiUJZzXF9i-SPGkw@mail.gmail.com>
 <20210408125258.GB3271@quack2.suse.cz>
 <CAOQ4uxhrvKkK3RZRoGTojpyiyVmQpLWknYiKs8iN=Uq+mhOvsg@mail.gmail.com>
 <20210409100811.GA20833@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210409100811.GA20833@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 09, 2021 at 12:08:11PM +0200, Jan Kara wrote:
> On Thu 08-04-21 18:11:31, Amir Goldstein wrote:
> > > > FYI, I tried your suggested approach above for fsnotify_xattr(),
> > > > but I think I prefer to use an explicit flavor fsnotify_xattr_mnt()
> > > > and a wrapper fsnotify_xattr().
> > > > Pushed WIP to fsnotify_path_hooks branch. It also contains
> > > > some unstashed "fix" patches to tidy up the previous hooks.
> > >
> > > What's in fsnotify_path_hooks branch looks good to me wrt xattr hooks.
> > > I somewhat dislike about e.g. the fsnotify_create() approach you took is
> > > that there are separate hooks fsnotify_create() and fsnotify_create_path()
> > > which expose what is IMO an internal fsnotify detail of what are different
> > > event types. I'd say it is more natural (from VFS POV) to have just a
> > > single hook and fill in as much information as available... Also from
> > 
> > So to be clear, you do NOT want additional wrappers like this and
> > you prefer to have the NULL mnt argument explicit in all callers?
> > 
> > static inline void fsnotify_xattr(struct dentry *dentry)
> > {
> >         fsnotify_xattr_mnt(NULL, dentry);
> > }
> > 
> > For fsnotify_xattr() it does not matter so much, but fsnotify_create/mkdir()
> > have quite a few callers in special filesystems.
> 
> Yes, I prefer explicit NULL mnt argument to make it obvious we are going to

I'm personally not a fan of that passing explicit NULL and one of the
first comments Al made to me about idmapped mounts was sm along the
lines of "don't pass NULL to indicate non-idmapped it's an invitation
for bugs". And I think that's actually a good point.
Maybe we should do something similar to anonymous mount namespaces. For
example, we could introduce an anonymous vfsmount that gets passed by
default. Basically similar to init_user_ns or init_net etc.

> miss something in this case. I agree it's going to be somewhat bigger churn
> but it isn't that bad (10 + 6 callers).
> 
> > > outside view, it is unclear that e.g. vfs_create() will generate some types
> > > of fsnotify events but not all while e.g. do_mknodat() will generate all
> > > fsnotify events. That's why I'm not sure whether a helper like vfs_create()
> > > in your tree is the right abstraction since generating one type of fsnotify
> > > event while not generating another type should be a very conscious decision
> > > of the implementor - basically if you have no other option.
> > 
> > I lost you here.
> 
> Sorry, I was probably too philosophical here ;)
> 
> > Are you ok with vfs_create() vs. vfs_create_nonotify()?
> 
> I'm OK with vfs_create_nonotify(). I have a problem with vfs_create()
> because it generates inode + fs events but does not generate mount events
> which is just strange (although I appreciate the technical reason behind
> it :).
> 
> > How do you propose to change fsnotify hooks in vfs_create()?
> 
> So either pass 'mnt' to vfs_create() - as we discussed, this may be
> actually acceptable these days due to idmapped mounts work - and generate

I would think passing struct vfsmount or even struct path to vfs_*
helpers is acceptable (although I know about the long-standing
resistance) as long as neither are passed down to inode methods
themselves. And that should work since the consensus seems to be to
never generate mnt fanotify events for an underlying mnt where one fs
stacks on top of another (cachefiles, ecryptfs, overlayfs, etc.).
Another argument for passing the vfsmount is that all of those stacking
filesystems already do have access to the relevant struct vfsmount
anyway (As I know from my idmapped mount port of overlayfs for example).

> all events there, or make vfs_create() not generate any fsnotify events and
> create new vfs_create_notify() which will take the 'mnt' and generate
> events. Either is fine with me and more consistent than what you currently
> propose. Thoughts?

One thing, whatever you end up passing to vfs_create() please make sure
to retrieve mnt_userns once so permission checking and object creation
line-up:

int vfs_create(struct vfsmount *mnt, struct inode *dir,
	       struct dentry *dentry, umode_t mode, bool want_excl)
{
	struct user_namespace *mnt_userns;

	mnt_userns = mnt_user_ns(mnt);

	int error = may_create(mnt_userns, dir, dentry);
	if (error)
		return error;

	if (!dir->i_op->create)
		return -EACCES;	/* shouldn't it be ENOSYS? */
	mode &= S_IALLUGO;
	mode |= S_IFREG;
	error = security_inode_create(dir, dentry, mode);
	if (error)
		return error;
	error = dir->i_op->create(mnt_userns, dir, dentry, mode, want_excl);
	if (!error)
		fsnotify_create(mnt, dir, dentry);
	return error;
}

Christian
