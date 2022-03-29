Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88764EB5A7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Mar 2022 00:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236284AbiC2WM6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Mar 2022 18:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236408AbiC2WMw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Mar 2022 18:12:52 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 51107186168;
        Tue, 29 Mar 2022 15:11:04 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-43-123.pa.nsw.optusnet.com.au [49.180.43.123])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 9A68E5342FF;
        Wed, 30 Mar 2022 09:11:02 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nZK3H-00BSLk-EW; Wed, 30 Mar 2022 09:10:59 +1100
Date:   Wed, 30 Mar 2022 09:10:59 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Yang Xu <xuyang2018.jy@fujitsu.com>, linux-fsdevel@vger.kernel.org,
        ceph-devel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v1 2/3] vfs: strip file's S_ISGID mode on vfs instead of
 on filesystem
Message-ID: <20220329221059.GN1609613@dread.disaster.area>
References: <1648461389-2225-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1648461389-2225-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <4250135d7321841ee6bdf0487c576f311aa583aa.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4250135d7321841ee6bdf0487c576f311aa583aa.camel@kernel.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=624383f7
        a=MV6E7+DvwtTitA3W+3A2Lw==:117 a=MV6E7+DvwtTitA3W+3A2Lw==:17
        a=kj9zAlcOel0A:10 a=o8Y5sQTvuykA:10 a=7-415B0cAAAA:8 a=omOdbC7AAAAA:8
        a=ls3SzQlE_Ex8uhEAaMwA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 29, 2022 at 07:12:11AM -0400, Jeff Layton wrote:
> On Mon, 2022-03-28 at 17:56 +0800, Yang Xu wrote:
> > Currently, vfs only passes mode argument to filesystem, then use inode_init_owner()
> > to strip S_ISGID. Some filesystem(ie ext4/btrfs) will call inode_init_owner
> > firstly, then posxi acl setup, but xfs uses the contrary order. It will affect
> > S_ISGID clear especially umask with S_IXGRP.
> > 
> > Vfs has all the info it needs - it doesn't need the filesystems to do everything
> > correctly with the mode and ensuring that they order things like posix acl setup
> > functions correctly with inode_init_owner() to strip the SGID bit.
> > 
> > Just strip the SGID bit at the VFS, and then the filesystems can't get it wrong.
> > 
> > Also, the inode_sgid_strip() api should be used before IS_POSIXACL() because
> > this api may change mode by using umask but S_ISGID clear isn't related to
> > SB_POSIXACL flag.
> > 
> > Suggested-by: Dave Chinner <david@fromorbit.com>
> > Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> > ---
> >  fs/inode.c | 4 ----
> >  fs/namei.c | 7 +++++--
> >  2 files changed, 5 insertions(+), 6 deletions(-)
> > 
> > diff --git a/fs/inode.c b/fs/inode.c
> > index 1f964e7f9698..a2dd71c2437e 100644
> > --- a/fs/inode.c
> > +++ b/fs/inode.c
> > @@ -2246,10 +2246,6 @@ void inode_init_owner(struct user_namespace *mnt_userns, struct inode *inode,
> >  		/* Directories are special, and always inherit S_ISGID */
> >  		if (S_ISDIR(mode))
> >  			mode |= S_ISGID;
> > -		else if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP) &&
> > -			 !in_group_p(i_gid_into_mnt(mnt_userns, dir)) &&
> > -			 !capable_wrt_inode_uidgid(mnt_userns, dir, CAP_FSETID))
> > -			mode &= ~S_ISGID;
> >  	} else
> >  		inode_fsgid_set(inode, mnt_userns);
> >  	inode->i_mode = mode;
> > diff --git a/fs/namei.c b/fs/namei.c
> > index 3f1829b3ab5b..e68a99e0ac96 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -3287,6 +3287,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
> >  	if (open_flag & O_CREAT) {
> >  		if (open_flag & O_EXCL)
> >  			open_flag &= ~O_TRUNC;
> > +		inode_sgid_strip(mnt_userns, dir->d_inode, &mode);
> >  		if (!IS_POSIXACL(dir->d_inode))
> >  			mode &= ~current_umask();
> >  		if (likely(got_write))
> > @@ -3521,6 +3522,8 @@ struct dentry *vfs_tmpfile(struct user_namespace *mnt_userns,
> >  	child = d_alloc(dentry, &slash_name);
> >  	if (unlikely(!child))
> >  		goto out_err;
> > +	inode_sgid_strip(mnt_userns, dir, &mode);
> > +
> >  	error = dir->i_op->tmpfile(mnt_userns, dir, child, mode);
> >  	if (error)
> >  		goto out_err;
> > @@ -3849,14 +3852,14 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
> >  	error = PTR_ERR(dentry);
> >  	if (IS_ERR(dentry))
> >  		goto out1;
> > -
> > +	mnt_userns = mnt_user_ns(path.mnt);
> > +	inode_sgid_strip(mnt_userns, path.dentry->d_inode, &mode);
> >  	if (!IS_POSIXACL(path.dentry->d_inode))
> >  		mode &= ~current_umask();
> >  	error = security_path_mknod(&path, dentry, mode, dev);
> >  	if (error)
> >  		goto out2;
> >  
> > -	mnt_userns = mnt_user_ns(path.mnt);
> >  	switch (mode & S_IFMT) {
> >  		case 0: case S_IFREG:
> >  			error = vfs_create(mnt_userns, path.dentry->d_inode,
> 
> I haven't gone over this in detail, but have you tested this with NFS at
> all?
> 
> IIRC, NFS has to leave setuid/gid stripping to the server, so I wonder
> if this may end up running afoul of that by forcing the client to try
> and strip these bits.

All it means is that the mode passed to the NFS server for the
create already has the SGID bit stripped from it. It means the
client is no longer reliant on the server behaving correctly to
close this security hole.

That is, failing to strip the SGID bit appropriately in the local
context is a security issue. Hence local machine security requires
that the NFS client should try to strip the SGID to defend against
buggy/unfixed servers that fail to strip it appropriately and
thereby continute to expose the local machine to this SGID security
issue.

That's the problem here - the SGID stripping in inode_init_owner()
is not documented, wasn't reviewed, doesn't work correctly
across all filesystems and leaves nasty security landmines when the VFS
create mode and the stripped inode mode differ.

Various filesystems have workarounds, partial fixes or no fixes for
these issues and landmines. Hence we have a situation where we are
playing whack-a-mole to discover and slap band-aids over all the
places that inode_init_owner() based stripping does not work
correctly.

In XFS, this meant the problem was not orginally fixed by the
silent, unreviewed change to inode_init_owner() in 2018
because it didn't call inode_init_owner() at all. So 4 years after
the bug was "fixed" and the CVE released, we are still exposed to
the bug because *no filesystem people knew about it* and *nobody wrote a
regression test* to check that the probelm was fixed and stayed
fixed.

And now that XFS does call inode_init_owner(), we've subsequently
discovered that XFS still fail when default acls are enabled because
we create the ACL from the mode passed from the VFS, not the
stripped mode that results from inode_init_owner() being called.

See what I mean about landmines?

The fact is this: regardless of which filesystem is in use, failure
to strip the SGID correctly is considered a security failure that
needs to be fixed. The current VFS infrastructure requires the
filesystem to do everything right and not step on any landmines to
strip the SGID bit, when in fact it can easily be done at the VFS
and the filesystems then don't even need to be aware that the SGID
needs to be (or has been stripped) by the operation the user asked
to be done.

We need the architecture to be *secure by design*, not tacked onto
the side like it is now.  We need to stop trying to dance around
these landmines - it is *not working* and we are blowing our own
feet off repeatedly. This hurts a lot (especially in distro land)
so we need to take the responsibility for stripping SGID properly
away from the filesystems and put it where it belongs: in the VFS.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
