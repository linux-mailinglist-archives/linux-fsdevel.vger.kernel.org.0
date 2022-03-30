Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 243AD4EC9E3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Mar 2022 18:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348960AbiC3Qqb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Mar 2022 12:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348966AbiC3Qq3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Mar 2022 12:46:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9130A1E5331;
        Wed, 30 Mar 2022 09:44:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A8EEFB81D89;
        Wed, 30 Mar 2022 16:44:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61808C34110;
        Wed, 30 Mar 2022 16:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648658679;
        bh=k3tX7cf7Ikb3Ai6FvcSkobzmPxg6gEhP2eEpQQfMmLg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IWNNmqEzKFCpqzjmrUj2+Gy1Wqz8sUu8CHlh6XWXbIkO5umjOAMITXZNoglDHTIL5
         s0TKkjOd61p4zs4XzMFqUpZINHqZ/pls2jHmYN0qdL9LtXMrOIrIFB9Ysh3UMlQeP/
         2gpmF6dZsOqoTdPwpi7MkoUMCPblMXapwzv7NdNmTvKoV/0+hy81wsXMG6BhENDY/T
         cvJIshgkzOfXPdJUkW56Nj1vBcfTBjwqkvONdqBNlatuKLKHBbxcT+zPnqe3zomkJB
         Hr2IdxXTwb/lJpw/PLFvbwbJcSXm9fc3OPLSV7YdBDK7PpOIy9oRD1iR41Gpc1pX6o
         /Hm8dFWJQLnsA==
Date:   Wed, 30 Mar 2022 09:44:38 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Jeff Layton <jlayton@kernel.org>,
        Yang Xu <xuyang2018.jy@fujitsu.com>,
        linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCH v1 2/3] vfs: strip file's S_ISGID mode on vfs instead of
 on filesystem
Message-ID: <20220330164438.GC27649@magnolia>
References: <1648461389-2225-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1648461389-2225-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <4250135d7321841ee6bdf0487c576f311aa583aa.camel@kernel.org>
 <20220329221059.GN1609613@dread.disaster.area>
 <20220330104419.j7qwcf465hyms2tv@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330104419.j7qwcf465hyms2tv@wittgenstein>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 30, 2022 at 12:44:19PM +0200, Christian Brauner wrote:
> On Wed, Mar 30, 2022 at 09:10:59AM +1100, Dave Chinner wrote:
> > On Tue, Mar 29, 2022 at 07:12:11AM -0400, Jeff Layton wrote:
> > > On Mon, 2022-03-28 at 17:56 +0800, Yang Xu wrote:
> > > > Currently, vfs only passes mode argument to filesystem, then use inode_init_owner()
> > > > to strip S_ISGID. Some filesystem(ie ext4/btrfs) will call inode_init_owner
> > > > firstly, then posxi acl setup, but xfs uses the contrary order. It will affect
> > > > S_ISGID clear especially umask with S_IXGRP.
> > > > 
> > > > Vfs has all the info it needs - it doesn't need the filesystems to do everything
> > > > correctly with the mode and ensuring that they order things like posix acl setup
> > > > functions correctly with inode_init_owner() to strip the SGID bit.
> > > > 
> > > > Just strip the SGID bit at the VFS, and then the filesystems can't get it wrong.
> > > > 
> > > > Also, the inode_sgid_strip() api should be used before IS_POSIXACL() because
> > > > this api may change mode by using umask but S_ISGID clear isn't related to
> > > > SB_POSIXACL flag.
> > > > 
> > > > Suggested-by: Dave Chinner <david@fromorbit.com>
> > > > Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> > > > ---
> > > >  fs/inode.c | 4 ----
> > > >  fs/namei.c | 7 +++++--
> > > >  2 files changed, 5 insertions(+), 6 deletions(-)
> > > > 
> > > > diff --git a/fs/inode.c b/fs/inode.c
> > > > index 1f964e7f9698..a2dd71c2437e 100644
> > > > --- a/fs/inode.c
> > > > +++ b/fs/inode.c
> > > > @@ -2246,10 +2246,6 @@ void inode_init_owner(struct user_namespace *mnt_userns, struct inode *inode,
> > > >  		/* Directories are special, and always inherit S_ISGID */
> > > >  		if (S_ISDIR(mode))
> > > >  			mode |= S_ISGID;
> > > > -		else if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP) &&
> > > > -			 !in_group_p(i_gid_into_mnt(mnt_userns, dir)) &&
> > > > -			 !capable_wrt_inode_uidgid(mnt_userns, dir, CAP_FSETID))
> > > > -			mode &= ~S_ISGID;
> > > >  	} else
> > > >  		inode_fsgid_set(inode, mnt_userns);
> > > >  	inode->i_mode = mode;
> > > > diff --git a/fs/namei.c b/fs/namei.c
> > > > index 3f1829b3ab5b..e68a99e0ac96 100644
> > > > --- a/fs/namei.c
> > > > +++ b/fs/namei.c
> > > > @@ -3287,6 +3287,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
> > > >  	if (open_flag & O_CREAT) {
> > > >  		if (open_flag & O_EXCL)
> > > >  			open_flag &= ~O_TRUNC;
> > > > +		inode_sgid_strip(mnt_userns, dir->d_inode, &mode);
> > > >  		if (!IS_POSIXACL(dir->d_inode))
> > > >  			mode &= ~current_umask();
> > > >  		if (likely(got_write))
> > > > @@ -3521,6 +3522,8 @@ struct dentry *vfs_tmpfile(struct user_namespace *mnt_userns,
> > > >  	child = d_alloc(dentry, &slash_name);
> > > >  	if (unlikely(!child))
> > > >  		goto out_err;
> > > > +	inode_sgid_strip(mnt_userns, dir, &mode);
> > > > +
> > > >  	error = dir->i_op->tmpfile(mnt_userns, dir, child, mode);
> > > >  	if (error)
> > > >  		goto out_err;
> > > > @@ -3849,14 +3852,14 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
> > > >  	error = PTR_ERR(dentry);
> > > >  	if (IS_ERR(dentry))
> > > >  		goto out1;
> > > > -
> > > > +	mnt_userns = mnt_user_ns(path.mnt);
> > > > +	inode_sgid_strip(mnt_userns, path.dentry->d_inode, &mode);
> > > >  	if (!IS_POSIXACL(path.dentry->d_inode))
> > > >  		mode &= ~current_umask();
> > > >  	error = security_path_mknod(&path, dentry, mode, dev);
> > > >  	if (error)
> > > >  		goto out2;
> > > >  
> > > > -	mnt_userns = mnt_user_ns(path.mnt);
> > > >  	switch (mode & S_IFMT) {
> > > >  		case 0: case S_IFREG:
> > > >  			error = vfs_create(mnt_userns, path.dentry->d_inode,
> > > 
> > > I haven't gone over this in detail, but have you tested this with NFS at
> > > all?
> > > 
> > > IIRC, NFS has to leave setuid/gid stripping to the server, so I wonder
> > > if this may end up running afoul of that by forcing the client to try
> > > and strip these bits.
> > 
> > All it means is that the mode passed to the NFS server for the
> > create already has the SGID bit stripped from it. It means the
> > client is no longer reliant on the server behaving correctly to
> > close this security hole.
> > 
> > That is, failing to strip the SGID bit appropriately in the local
> > context is a security issue. Hence local machine security requires
> > that the NFS client should try to strip the SGID to defend against
> > buggy/unfixed servers that fail to strip it appropriately and
> > thereby continute to expose the local machine to this SGID security
> > issue.
> > 
> > That's the problem here - the SGID stripping in inode_init_owner()
> > is not documented, wasn't reviewed, doesn't work correctly
> > across all filesystems and leaves nasty security landmines when the VFS
> > create mode and the stripped inode mode differ.
> > 
> > Various filesystems have workarounds, partial fixes or no fixes for
> > these issues and landmines. Hence we have a situation where we are
> > playing whack-a-mole to discover and slap band-aids over all the
> > places that inode_init_owner() based stripping does not work
> > correctly.
> > 
> > In XFS, this meant the problem was not orginally fixed by the
> > silent, unreviewed change to inode_init_owner() in 2018
> > because it didn't call inode_init_owner() at all. So 4 years after
> > the bug was "fixed" and the CVE released, we are still exposed to
> > the bug because *no filesystem people knew about it* and *nobody wrote a
> > regression test* to check that the probelm was fixed and stayed
> > fixed.
> > 
> > And now that XFS does call inode_init_owner(), we've subsequently
> > discovered that XFS still fail when default acls are enabled because
> > we create the ACL from the mode passed from the VFS, not the
> > stripped mode that results from inode_init_owner() being called.
> > 
> > See what I mean about landmines?
> > 
> > The fact is this: regardless of which filesystem is in use, failure
> > to strip the SGID correctly is considered a security failure that
> > needs to be fixed. The current VFS infrastructure requires the
> > filesystem to do everything right and not step on any landmines to
> > strip the SGID bit, when in fact it can easily be done at the VFS
> > and the filesystems then don't even need to be aware that the SGID
> > needs to be (or has been stripped) by the operation the user asked
> > to be done.
> > 
> > We need the architecture to be *secure by design*, not tacked onto
> > the side like it is now.  We need to stop trying to dance around
> > these landmines - it is *not working* and we are blowing our own
> > feet off repeatedly. This hurts a lot (especially in distro land)
> > so we need to take the responsibility for stripping SGID properly
> > away from the filesystems and put it where it belongs: in the VFS.
> 
> I agree. When I added tests for set*id stripping to xfstests for the
> sake of getting complete vfs coverage of idmapped mounts in generic/633
> I immediately found bugs. Once I made the testsuite useable by all
> filesystems we started seeing more.
> 
> I think we should add and use the new proposed stripping helper in the
> vfs - albeit with a slightly changed api and also use it in
> inode_init_owner(). While it is a delicate change in the worst case we
> end up removing additional privileges that's an acceptable regression
> risk to take.

And if it's not too much trouble, can we add an fstest to encode our
current expectations about how setgid inheritance works?  I would really
like to reduce the need for historic setgid behavior spelunking. ;)

--D
