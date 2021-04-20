Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A40BD3657C9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Apr 2021 13:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbhDTLmb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Apr 2021 07:42:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:57582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230491AbhDTLma (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Apr 2021 07:42:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4B5AF613AB;
        Tue, 20 Apr 2021 11:41:57 +0000 (UTC)
Date:   Tue, 20 Apr 2021 13:41:54 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: fsnotify path hooks
Message-ID: <20210420114154.mwjj7reyntzjkvnw@wittgenstein>
References: <CAOQ4uxjOyuvpJ7Tv3cGmv+ek7+z9BJBF4sK_-OLxwePUrHERUg@mail.gmail.com>
 <CAOQ4uxhWE9JGOZ_jN9_RT5EkACdNWXOryRsm6Wg_zkaDNDSjsA@mail.gmail.com>
 <20210401102947.GA29690@quack2.suse.cz>
 <CAOQ4uxjHFkRVTY5iyTSpb0R5R6j-j=8+Htpu2hgMAz9MTci-HQ@mail.gmail.com>
 <CAOQ4uxjS56hjaXeTUdce2gJT3tTFb2Zs1_PiUJZzXF9i-SPGkw@mail.gmail.com>
 <20210408125258.GB3271@quack2.suse.cz>
 <CAOQ4uxhrvKkK3RZRoGTojpyiyVmQpLWknYiKs8iN=Uq+mhOvsg@mail.gmail.com>
 <20210409100811.GA20833@quack2.suse.cz>
 <20210409104546.37i6h2i4ga2xakvp@wittgenstein>
 <CAOQ4uxi-BG9-XLmQ0uLp0vb_woF=M0EUasLDJG-zHd66PFuKGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOQ4uxi-BG9-XLmQ0uLp0vb_woF=M0EUasLDJG-zHd66PFuKGw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 20, 2021 at 09:01:09AM +0300, Amir Goldstein wrote:
> > One thing, whatever you end up passing to vfs_create() please make sure
> > to retrieve mnt_userns once so permission checking and object creation
> > line-up:
> >
> > int vfs_create(struct vfsmount *mnt, struct inode *dir,
> >                struct dentry *dentry, umode_t mode, bool want_excl)
> > {
> >         struct user_namespace *mnt_userns;
> >
> >         mnt_userns = mnt_user_ns(mnt);
> >
> >         int error = may_create(mnt_userns, dir, dentry);
> >         if (error)
> >                 return error;
> >
> >         if (!dir->i_op->create)
> >                 return -EACCES; /* shouldn't it be ENOSYS? */
> >         mode &= S_IALLUGO;
> >         mode |= S_IFREG;
> >         error = security_inode_create(dir, dentry, mode);
> >         if (error)
> >                 return error;
> >         error = dir->i_op->create(mnt_userns, dir, dentry, mode, want_excl);
> >         if (!error)
> >                 fsnotify_create(mnt, dir, dentry);
> >         return error;
> > }
> >
> 
> Christian,
> 
> What is the concern here?
> Can mnt_user_ns() change under us?
> I am asking because Al doesn't like both mnt_userns AND path to
> be passed to do_tuncate() => notify_change()
> So I will need to retrieve mnt_userns again inside notify_change()
> after it had been used for security checks in do_open().
> Would that be acceptable to you?

The mnt_userns can't change once a mnt has been idmapped and it can
never change if the mount is visible in the filesystem already. The only
case we've been worried about and why we did it this way is when you
have a caller do fd = open_tree(OPEN_TREE_CLONE) and then share that
unattached fd with multiple processes
T1: mkdirat(fd, "dir1", 0755);
T2: mount_setattr(fd, "",); /* changes idmapping */
That case isn't a problem if the mnt_userns is only retrieved once for
permission checking and operating on the inode. I think with your
changes that still shouldn't be an issue though since the vfs_*()
helpers encompass the permission checking anyway and for notify_change,
we could simply add a mnt_userns field to struct iattr and pass it down.
