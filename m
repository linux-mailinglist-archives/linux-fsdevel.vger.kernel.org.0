Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B25F23583DF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Apr 2021 14:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbhDHMx3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Apr 2021 08:53:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:36254 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231424AbhDHMxL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Apr 2021 08:53:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 40DADB090;
        Thu,  8 Apr 2021 12:52:59 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E40871F2B77; Thu,  8 Apr 2021 14:52:58 +0200 (CEST)
Date:   Thu, 8 Apr 2021 14:52:58 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: fsnotify path hooks
Message-ID: <20210408125258.GB3271@quack2.suse.cz>
References: <20210330141703.lkttbuflr5z5ia7f@wittgenstein>
 <CAOQ4uxirMBzcaLeLoBWCMPPr7367qeKjnW3f88bh1VMr_3jv_A@mail.gmail.com>
 <20210331094604.xxbjl3krhqtwcaup@wittgenstein>
 <CAOQ4uxirud-+ot0kZ=8qaicvjEM5w1scAeoLP_-HzQx+LwihHw@mail.gmail.com>
 <20210331125412.GI30749@quack2.suse.cz>
 <CAOQ4uxjOyuvpJ7Tv3cGmv+ek7+z9BJBF4sK_-OLxwePUrHERUg@mail.gmail.com>
 <CAOQ4uxhWE9JGOZ_jN9_RT5EkACdNWXOryRsm6Wg_zkaDNDSjsA@mail.gmail.com>
 <20210401102947.GA29690@quack2.suse.cz>
 <CAOQ4uxjHFkRVTY5iyTSpb0R5R6j-j=8+Htpu2hgMAz9MTci-HQ@mail.gmail.com>
 <CAOQ4uxjS56hjaXeTUdce2gJT3tTFb2Zs1_PiUJZzXF9i-SPGkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjS56hjaXeTUdce2gJT3tTFb2Zs1_PiUJZzXF9i-SPGkw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 06-04-21 21:49:13, Amir Goldstein wrote:
> [...]
> > > > So yeh, I do think it is manageable. I think the best solution would be
> > > > something along the lines of wrappers like the following:
> > > >
> > > > static inline int vfs_mkdir(...)
> > > > {
> > > >         int error = __vfs_mkdir_nonotify(...);
> > > >         if (!error)
> > > >                 fsnotify_mkdir(dir, dentry);
> > > >         return error;
> > > > }
> > > >
> > > > And then the few call sites that call the fsnotify_path_ hooks
> > > > (i.e. in syscalls and perhaps later in nfsd) will call the
> > > > __vfs_xxx_nonotify() variant.
> > >
> > > Yes, that is OK with me. Or we could have something like:
> > >
> > > static inline void fsnotify_dirent(struct vfsmount *mnt, struct inode *dir,
> > >                                    struct dentry *dentry, __u32 mask)
> > > {
> > >         if (!mnt) {
> > >                 fsnotify(mask, d_inode(dentry), FSNOTIFY_EVENT_INODE, dir,
> > >                          &dentry->d_name, NULL, 0);
> > >         } else {
> > >                 struct path path = {
> > >                         .mnt = mnt,
> > >                         .dentry = d_find_any_alias(dir)
> > >                 };
> > >                 fsnotify(mask, d_inode(dentry), FSNOTIFY_EVENT_PATH, &path,
> > >                          &dentry->d_name, NULL, 0);
> > >         }
> > > }
> > >
> > > static inline void fsnotify_mkdir(struct vfsmount *mnt, struct inode *inode,
> > >                                   struct dentry *dentry)
> > > {
> > >         audit_inode_child(inode, dentry, AUDIT_TYPE_CHILD_CREATE);
> > >
> > >         fsnotify_dirent(mnt, inode, dentry, FS_CREATE | FS_ISDIR);
> > > }
> > >
> > > static inline int vfs_mkdir(mnt, ...)
> > > {
> > >         int error = __vfs_mkdir_nonotify(...);
> > >         if (!error)
> > >                 fsnotify_mkdir(mnt, dir, dentry);
> > > }
> > >
> >
> > I've done something similar to that. I think it's a bit cleaner,
> > but we can debate on the details later.
> > Pushed POC to branch fsnotify_path_hooks.
> 
> FYI, I tried your suggested approach above for fsnotify_xattr(),
> but I think I prefer to use an explicit flavor fsnotify_xattr_mnt()
> and a wrapper fsnotify_xattr().
> Pushed WIP to fsnotify_path_hooks branch. It also contains
> some unstashed "fix" patches to tidy up the previous hooks.

What's in fsnotify_path_hooks branch looks good to me wrt xattr hooks. What
I somewhat dislike about e.g. the fsnotify_create() approach you took is
that there are separate hooks fsnotify_create() and fsnotify_create_path()
which expose what is IMO an internal fsnotify detail of what are different
event types. I'd say it is more natural (from VFS POV) to have just a
single hook and fill in as much information as available... Also from
outside view, it is unclear that e.g. vfs_create() will generate some types
of fsnotify events but not all while e.g. do_mknodat() will generate all
fsnotify events. That's why I'm not sure whether a helper like vfs_create()
in your tree is the right abstraction since generating one type of fsnotify
event while not generating another type should be a very conscious decision
of the implementor - basically if you have no other option.

That all being said, this is just an internal API so we are free to tweak
it in the future if we get things wrong. So I'm not pushing hard for my
proposal but I wanted to raise my concerns. Also I think Al Viro might have
his opinion on this so you should probably CC him when posting the series...

> I ran into another hurdle with fsnotify_xattr() -
> vfs_setxattr() is too large to duplicate a _nonotify() variant IMO.
> OTOH, I cannot lift fsnotify_xattr() up to callers without moving
> the fsnotify hook outside the inode lock.
> 
> This was not a problem with the directory entry path hooks.
> This is also not going to be a problem with fsnotify_change(),
> because notify_change() is called with inode locked.
> 
> Do you think that calling fsnotify_xattr() under inode lock is important?
> Should I refactor a helper vfs_setxattr_notify() that takes a boolean
> arg for optionally calling fsnotify_xattr()?
> Do you have another idea how to deal with that hook?

I think having the event generated outside of i_rwsem is fine. The only
reason why I think it could possibly matter is due to reordering of events
on the same inode but that order is uncertain anyway.

> With notify_change() I have a different silly problem with using the
> refactoring method - the name notify_change_nonotify() is unacceptable.
> We may consider __ATTR_NONOTIFY ia_valid flag as the method to
> use instead of refactoring in this case, just because we can and
> because it creates less clutter.
> 
> What do you think?

Hmm, notify_change() is an inconsistent name anyway (for historical
reasons). Consistent name would be vfs_setattr(). And
vfs_setattr_nonotify() would be a fine name as well. What do you think?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
