Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 098A833DBD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2019 06:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfFDELy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jun 2019 00:11:54 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:41950 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfFDELy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jun 2019 00:11:54 -0400
Received: by mail-yb1-f196.google.com with SMTP id d2so7444417ybh.8;
        Mon, 03 Jun 2019 21:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GiXYhf/KYBm+yKWNmNHreRstmpry2l5webf9eh8jDYg=;
        b=nCoSj671i82M1oynA0o8CM084JJNDqjdDfLZZJmREHgFONnl+kW2+USpnqRpruYHyp
         Pf7so4+XL+MXH+2VSehb5vIE+ZhwvUUAu2oQsq7VRkTVlYM4mEk8+g0heYLAetNa2K5z
         jA3DZdtgg8eIiYlz9jZznU0eREJgA8LSeu+TK73Rjq1wDIhD0XI3AIyyKPdH6H5SjtrK
         cEmRza+aYBu+0Xh3GAREmis9jz3rGscQs4qGb4yA7rAeeLPXIMqqbEbXdRBkBiMfh8n7
         uu3Z6Ne6Fo+xr3RlO7+G+7u6haIQFBb4payvw8KmqZDEXqaFPywzdBoCywTUfC8RjIoE
         rqiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GiXYhf/KYBm+yKWNmNHreRstmpry2l5webf9eh8jDYg=;
        b=di5YqzS3kw7NXVl161rYyl/ShfAYcuj7QoNW8oBP/e5zXao0zhozj2DfyFr6AuOET6
         G5wIs4cwQ/wki7xdtstr3Dk04bHvUF5XjACteENZthNGwHTJIM0eLSCJzY78sAmVRM3h
         2p9Ph49dWW6ZFvMleGeCj8Q7vAzdYfE819Fw46vq/oEG5Z/NveXePKTK1g7eOE+PI5cj
         2EM6pbSn1PMLceMHGZMODawX/qeq9P5KdN8fcrYpxoJH7CE0zXhTF6HABbUN+6wtHaUb
         /qKt/ZMgSJRPDbCE/B0uDBLcQ9Di1dghzZBSAxHkqQbgFHDpXYYVjlytUSlLiK66o9UN
         v6Bg==
X-Gm-Message-State: APjAAAX21oWFIllhCYx5p1GLWCiCfVcTr8oj1hP3ZF7xuR8aeRGtaD5d
        xbScTRj5ZmjxuVoS+Z7IkL/pyAAHJHFZSyFXx1g=
X-Google-Smtp-Source: APXvYqx+Ml1TOubdve9+7Jc6qldfoWjeamIEqBzgGRWPt6Osis+a6esFHpOMJgl+Uwrf7MWEJjaIs58k8ua3FGgOG7c=
X-Received: by 2002:a25:4489:: with SMTP id r131mr13733327yba.14.1559621512767;
 Mon, 03 Jun 2019 21:11:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190529174318.22424-1-amir73il@gmail.com> <20190529174318.22424-14-amir73il@gmail.com>
 <CAN-5tyF9OnRsF_dgtx8aUGFB5tUUs=JK1wzXvRGo3za8jfpJdQ@mail.gmail.com>
 <CAOQ4uxh_0RVus56Ao_tFXCHdM6dsTrk=MsSBs1p7NjX4eJZkbg@mail.gmail.com> <CAN-5tyFMOxjUrzBFf3OE+5P8pnh0Q-ngUWCmU2eFB1WKFyGPQw@mail.gmail.com>
In-Reply-To: <CAN-5tyFMOxjUrzBFf3OE+5P8pnh0Q-ngUWCmU2eFB1WKFyGPQw@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 4 Jun 2019 07:11:39 +0300
Message-ID: <CAOQ4uxg4f2+xb-_xyCV4RYS_1Gyht9W2dWoLgHoWJMxU7B8wHw@mail.gmail.com>
Subject: Re: [PATCH v3 13/13] vfs: allow copy_file_range to copy across devices
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Luis Henriques <lhenriques@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        ceph-devel@vger.kernel.org, linux-nfs <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        Steve French <stfrench@microsoft.com>,
        Dave Chinner <dchinner@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 3, 2019 at 11:39 PM Olga Kornievskaia
<olga.kornievskaia@gmail.com> wrote:
>
> On Wed, May 29, 2019 at 5:03 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Wed, May 29, 2019 at 11:09 PM Olga Kornievskaia
> > <olga.kornievskaia@gmail.com> wrote:
> > >
> > > On Wed, May 29, 2019 at 1:43 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > > >
> > > > We want to enable cross-filesystem copy_file_range functionality
> > > > where possible, so push the "same superblock only" checks down to
> > > > the individual filesystem callouts so they can make their own
> > > > decisions about cross-superblock copy offload and fallack to
> > > > generic_copy_file_range() for cross-superblock copy.
> > > >
> > > > [Amir] We do not call ->remap_file_range() in case the inodes are not
> > > > on the same sb and do not call ->copy_file_range() in case the inodes
> > > > are not on the same filesystem type.
> > > >
> > > > This changes behavior of the copy_file_range(2) syscall, which will
> > > > now allow cross filesystem in-kernel copy.  CIFS already supports
> > > > cross-superblock copy, between two shares to the same server. This
> > > > functionality will now be available via the copy_file_range(2) syscall.
> > > >
> > > > Cc: Steve French <stfrench@microsoft.com>
> > > > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
> > > > ---
> > > >  fs/ceph/file.c    |  4 +++-
> > > >  fs/cifs/cifsfs.c  |  2 +-
> > > >  fs/fuse/file.c    |  5 ++++-
> > > >  fs/nfs/nfs4file.c |  5 ++++-
> > > >  fs/read_write.c   | 20 ++++++++++++++------
> > > >  5 files changed, 26 insertions(+), 10 deletions(-)
> > > >
> > > > diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> > > > index 8a70708e1aca..e9614d686301 100644
> > > > --- a/fs/ceph/file.c
> > > > +++ b/fs/ceph/file.c
> > > > @@ -1909,6 +1909,8 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
> > > >
> > > >         if (src_inode == dst_inode)
> > > >                 return -EINVAL;
> > > > +       if (src_inode->i_sb != dst_inode->i_sb)
> > > > +               return -EXDEV;
> > > >         if (ceph_snap(dst_inode) != CEPH_NOSNAP)
> > > >                 return -EROFS;
> > > >
> > > > @@ -2126,7 +2128,7 @@ static ssize_t ceph_copy_file_range(struct file *src_file, loff_t src_off,
> > > >         ret = __ceph_copy_file_range(src_file, src_off, dst_file, dst_off,
> > > >                                      len, flags);
> > > >
> > > > -       if (ret == -EOPNOTSUPP)
> > > > +       if (ret == -EOPNOTSUPP || ret == -EXDEV)
> > > >                 ret = generic_copy_file_range(src_file, src_off, dst_file,
> > > >                                               dst_off, len, flags);
> > > >         return ret;
> > > > diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
> > > > index ab6c5c24146d..83956452c108 100644
> > > > --- a/fs/cifs/cifsfs.c
> > > > +++ b/fs/cifs/cifsfs.c
> > > > @@ -1154,7 +1154,7 @@ static ssize_t cifs_copy_file_range(struct file *src_file, loff_t off,
> > > >                                         len, flags);
> > > >         free_xid(xid);
> > > >
> > > > -       if (rc == -EOPNOTSUPP)
> > > > +       if (rc == -EOPNOTSUPP || rc == -EXDEV)
> > > >                 rc = generic_copy_file_range(src_file, off, dst_file,
> > > >                                              destoff, len, flags);
> > > >         return rc;
> > > > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > > > index 7f33d68f66d9..eab00cd089e8 100644
> > > > --- a/fs/fuse/file.c
> > > > +++ b/fs/fuse/file.c
> > > > @@ -3126,6 +3126,9 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
> > > >         if (fc->no_copy_file_range)
> > > >                 return -EOPNOTSUPP;
> > > >
> > > > +       if (file_inode(file_in)->i_sb != file_inode(file_out)->i_sb)
> > > > +               return -EXDEV;
> > > > +
> > > >         inode_lock(inode_out);
> > > >
> > > >         err = file_modified(file_out);
> > > > @@ -3187,7 +3190,7 @@ static ssize_t fuse_copy_file_range(struct file *src_file, loff_t src_off,
> > > >         ret = __fuse_copy_file_range(src_file, src_off, dst_file, dst_off,
> > > >                                      len, flags);
> > > >
> > > > -       if (ret == -EOPNOTSUPP)
> > > > +       if (ret == -EOPNOTSUPP || ret == -EXDEV)
> > > >                 ret = generic_copy_file_range(src_file, src_off, dst_file,
> > > >                                               dst_off, len, flags);
> > > >         return ret;
> > > > diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
> > > > index 4842f3ab3161..f4157eb1f69d 100644
> > > > --- a/fs/nfs/nfs4file.c
> > > > +++ b/fs/nfs/nfs4file.c
> > > > @@ -133,6 +133,9 @@ static ssize_t __nfs4_copy_file_range(struct file *file_in, loff_t pos_in,
> > > >                                       struct file *file_out, loff_t pos_out,
> > > >                                       size_t count, unsigned int flags)
> > > >  {
> > > > +       /* Only offload copy if superblock is the same */
> > > > +       if (file_inode(file_in)->i_sb != file_inode(file_out)->i_sb)
> > > > +               return -EXDEV;
> > > >         if (!nfs_server_capable(file_inode(file_out), NFS_CAP_COPY))
> > > >                 return -EOPNOTSUPP;
> > > >         if (file_inode(file_in) == file_inode(file_out))
> > > > @@ -148,7 +151,7 @@ static ssize_t nfs4_copy_file_range(struct file *file_in, loff_t pos_in,
> > > >
> > > >         ret = __nfs4_copy_file_range(file_in, pos_in, file_out, pos_out, count,
> > > >                                      flags);
> > > > -       if (ret == -EOPNOTSUPP)
> > > > +       if (ret == -EOPNOTSUPP || ret == -EXDEV)
> > > >                 ret = generic_copy_file_range(file_in, pos_in, file_out,
> > > >                                               pos_out, count, flags);
> > > >         return ret;
> > > > diff --git a/fs/read_write.c b/fs/read_write.c
> > > > index 706ea5f276a7..d8930bb735cb 100644
> > > > --- a/fs/read_write.c
> > > > +++ b/fs/read_write.c
> > > > @@ -1618,7 +1618,18 @@ static ssize_t do_copy_file_range(struct file *file_in, loff_t pos_in,
> > > >                                   struct file *file_out, loff_t pos_out,
> > > >                                   size_t len, unsigned int flags)
> > > >  {
> > > > -       if (file_out->f_op->copy_file_range)
> > > > +       /*
> > > > +        * Although we now allow filesystems to handle cross sb copy, passing
> > > > +        * an inode of the wrong filesystem type to filesystem operation can
> > > > +        * often result in an attempt to dereference the wrong concrete inode
> > > > +        * struct, so avoid doing that until we really have a good reason.
> > > > +        * The incentive for passing inode from different sb to filesystem is
> > > > +        * NFS cross server copy and for that use case, enforcing same
> > > > +        * filesystem type is acceptable.
> > > > +        */
> > > > +       if (file_out->f_op->copy_file_range &&
> > > > +           file_inode(file_in)->i_sb->s_type ==
> > > > +           file_inode(file_out)->i_sb->s_type)

I can change that to:

+       if (file_out->f_op->copy_file_range &&
+           file_out->f_op->copy_file_range ==
+           file_in->f_op->copy_file_range)

That should be fine for nfs that uses same copy_file_range()
method for all different s_type.

> > >
> > > While I'm not sure how much I care (vs wanting at least this much of
> > > cross device copy available) but in NFS there are several NFS
> > > file_system_type defined which would disallow a copy between them
> > > (like nfs4_remote_fs_type, nfs4_remote_referral_fs_type, and good old
> > > nfs4_fs_type).
> > >
> > > One idea would be to push the check into the filesystems themselves.
> > >
> >
> > That will require more delicate patches to filesystems.
> > Are you saying there is a *good* reason to do that now?
> > Is nfs copy offload expected to be between different types of nfs
> > file_system_type?
>
> So I had to setup a test case to perhaps give you a good reason. An
> NFS server might have an export that's a referral to another server.
> In this case the NFS client gets an ERR_MOVED and would mount the 2nd
> server. It shows up as a submount and it would have a different file
> system type. Having that check would prevent the NFS client from doing
> an NFS copy_file_range between those 2 servers and instead VFS would
> fallback to the generic_copy_file_range.
>
> So why is hard(er) to push the check that ->s_types are the same for
> the input and output files into the filesystems like it's done in this
> patch with the ->i_sb checks?

It's not harder, its fragile.
See, in vfs, file_in and file_out are abstract file objects and only generic
file interface are used. This is no longer the case inside filesystem code.

If passed a file object of different fs, almost all the filesystem in question
will barf (as you noticed yourself), because they try to access nfs specific
file object fields:

ssize_t nfs42_proc_copy(struct file *src, loff_t pos_src,
                        struct file *dst, loff_t pos_dst,
                        size_t count)
{
        struct nfs_server *server = NFS_SERVER(file_inode(dst));

ssize_t cifs_file_copychunk_range(unsigned int xid,
                                struct file *src_file, loff_t off,
                                struct file *dst_file, loff_t destoff,
                                size_t len, unsigned int flags)
{
        struct inode *src_inode = file_inode(src_file);
...
       if (!src_file->private_data || !dst_file->private_data) {
                rc = -EBADF;
                cifs_dbg(VFS, "missing cifsFileInfo on copy range src file\n");
                goto out;
        }
...
       smb_file_src = src_file->private_data;
        src_tcon = tlink_tcon(smb_file_src->tlink);

So first of all, all the present filesystems that support copy_file_range
will have no be sanitized to verify file_in is an object of their own type
before dereferencing private fields. That's doable, but it still leaves
future filesystems volnurable to making this mistake. It is also quite
fragile to test, because file objects coming from most fs will have NULL
private_data, so it may take a very specific type of input file to reveal
bugs in implementations.

All in all, I prefer to keep it safe. As long as we don't really need
filesystems
to handle copy of file_in from a different fs, let's keep it simple and resolve
the specific nfs issue by testing for same ->copy_file_range pointer.

Thanks,
Amir.
