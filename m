Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6D4E44FC71
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Nov 2021 00:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234823AbhKNXVk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 Nov 2021 18:21:40 -0500
Received: from mail110.syd.optusnet.com.au ([211.29.132.97]:33603 "EHLO
        mail110.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234667AbhKNXVf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 Nov 2021 18:21:35 -0500
Received: from dread.disaster.area (pa49-195-103-97.pa.nsw.optusnet.com.au [49.195.103.97])
        by mail110.syd.optusnet.com.au (Postfix) with ESMTPS id 3255510EB55;
        Mon, 15 Nov 2021 10:18:35 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mmOle-008tfk-N6; Mon, 15 Nov 2021 10:18:34 +1100
Date:   Mon, 15 Nov 2021 10:18:34 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Ian Kent <raven@themaw.net>, xfs <linux-xfs@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Brian Foster <bfoster@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] xfs: make sure link path does not go away at access
Message-ID: <20211114231834.GM449541@dread.disaster.area>
References: <163660195990.22525.6041281669106537689.stgit@mickey.themaw.net>
 <163660197073.22525.11235124150551283676.stgit@mickey.themaw.net>
 <20211112003249.GL449541@dread.disaster.area>
 <CAJfpegvHDM_Mtc8+ASAcmNLd6RiRM+KutjBOoycun_Oq2=+p=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegvHDM_Mtc8+ASAcmNLd6RiRM+KutjBOoycun_Oq2=+p=w@mail.gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=6191994e
        a=fP9RlOTWD4uZJjPSFnn6Ew==:117 a=fP9RlOTWD4uZJjPSFnn6Ew==:17
        a=HsDoLlocmGUuF16g:21 a=kj9zAlcOel0A:10 a=vIxV3rELxO4A:10 a=7-415B0cAAAA:8
        a=jUFqNg-nAAAA:8 a=-ugEviTTWESdy8FKhj8A:9 a=CjuIK1q_8ugA:10
        a=hl_xKfOxWho2XEkUDbUg:22 a=biEYGPWJfzWAr4FL6Ov7:22
        a=-tElvS_Zar9K8zhlwiSp:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 12, 2021 at 08:23:24AM +0100, Miklos Szeredi wrote:
> On Fri, 12 Nov 2021 at 01:32, Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Thu, Nov 11, 2021 at 11:39:30AM +0800, Ian Kent wrote:
> > > When following a trailing symlink in rcu-walk mode it's possible to
> > > succeed in getting the ->get_link() method pointer but the link path
> > > string be deallocated while it's being used.
> > >
> > > Utilize the rcu mechanism to mitigate this risk.
> > >
> > > Suggested-by: Miklos Szeredi <miklos@szeredi.hu>
> > > Signed-off-by: Ian Kent <raven@themaw.net>
> > > ---
> > >  fs/xfs/kmem.h      |    4 ++++
> > >  fs/xfs/xfs_inode.c |    4 ++--
> > >  fs/xfs/xfs_iops.c  |   10 ++++++++--
> > >  3 files changed, 14 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/fs/xfs/kmem.h b/fs/xfs/kmem.h
> > > index 54da6d717a06..c1bd1103b340 100644
> > > --- a/fs/xfs/kmem.h
> > > +++ b/fs/xfs/kmem.h
> > > @@ -61,6 +61,10 @@ static inline void  kmem_free(const void *ptr)
> > >  {
> > >       kvfree(ptr);
> > >  }
> > > +static inline void  kmem_free_rcu(const void *ptr)
> > > +{
> > > +     kvfree_rcu(ptr);
> > > +}
> > >
> > >
> > >  static inline void *
> > > diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> > > index a4f6f034fb81..aaa1911e61ed 100644
> > > --- a/fs/xfs/xfs_inode.c
> > > +++ b/fs/xfs/xfs_inode.c
> > > @@ -2650,8 +2650,8 @@ xfs_ifree(
> > >        * already been freed by xfs_attr_inactive.
> > >        */
> > >       if (ip->i_df.if_format == XFS_DINODE_FMT_LOCAL) {
> > > -             kmem_free(ip->i_df.if_u1.if_data);
> > > -             ip->i_df.if_u1.if_data = NULL;
> > > +             kmem_free_rcu(ip->i_df.if_u1.if_data);
> > > +             RCU_INIT_POINTER(ip->i_df.if_u1.if_data, NULL);
> > >               ip->i_df.if_bytes = 0;
> > >       }
> >
> > How do we get here in a way that the VFS will walk into this inode
> > during a lookup?
> >
> > I mean, the dentry has to be validated and held during the RCU path
> > walk, so if we are running a transaction to mark the inode as free
> > here it has already been unlinked and the dentry turned
> > negative. So anything that is doing a lockless pathwalk onto that
> > dentry *should* see that it is a negative dentry at this point and
> > hence nothing should be walking any further or trying to access the
> > link that was shared from ->get_link().
> >
> > AFAICT, that's what the sequence check bug you fixed in the previous
> > patch guarantees. It makes no difference if the unlinked inode has
> > been recycled or not, the lookup race condition is the same in that
> > the inode has gone through ->destroy_inode and is now owned by the
> > filesystem and not the VFS.
> 
> Yes, the concern here is that without locking all the above can
> theoretically happen between the sequence number check and  if_data
> being dereferenced.

It would be good to describe the race condition in the commit message,
because it's not at all obvious to readers how this race condition
is triggered.

> > Otherwise, it might just be best to memset the buffer to zero here
> > rather than free it, and leave it to be freed when the inode is
> > freed from the RCU callback in xfs_inode_free_callback() as per
> > normal.

Just as a FYI ext4_evict_inode() does exactly this with it's inline
symlink data buffer it passes to ->get_link() when it is freeing the
inode when the last reference to an unlinked inode goes away:

        /*
         * Set inode->i_size to 0 before calling ext4_truncate(). We need
         * special handling of symlinks here because i_size is used to
         * determine whether ext4_inode_info->i_data contains symlink data or
         * block mappings. Setting i_size to 0 will remove its fast symlink
         * status. Erase i_data so that it becomes a valid empty block map.
         */
        if (ext4_inode_is_fast_symlink(inode))
                memset(EXT4_I(inode)->i_data, 0, sizeof(EXT4_I(inode)->i_data));
	inode->i_size = 0;

IOWs, if the pointer returned from ->get_link() on an ext4
filesystem is accessed by the VFS after ->evict() is called, then it
sees an empty buffer. IOWs, it's just not safe for the VFS to access
the inode's link buffer pointer the moment the last reference to an
unlinked inode goes away because it's contents are no longer
guaranteed to be valid.

I note that ext4 then immediately sets the VFS inode size to 0
length, indicating the link is no longer valid. It may well be that
XFS is not setting the VFS inode size to zero in this case (I don't
think the generic evict() path does that) so perhaps that's a guard
that could be used at the VFS level to avoid the race condition...

> My suggestion was to use .free_inode instead of .destroy_inode, the
> former always being called after an RCU grace period.

Which doesn't address the ext4 "zero the buffer in .evict", either.

And for XFS, it means we then likely need to add synchronise_rcu()
calls wherever we need to wait for inodes to be inactivated and/or
reclaimed because they won't even get queued for inactivation until
the current grace period expires. That's a potential locking
nightmare because inode inactivation and reclaim uses rcu protected
lockless algorithms to access XFS inodes without taking reference
counts....

I just can't see how this race condition is XFS specific and why
fixing it requires XFS to sepcifically handle it while we ignore
similar theoretical issues in other filesystems...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
