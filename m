Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4A833B26
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2019 00:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfFCWYM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jun 2019 18:24:12 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:42589 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfFCWYL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jun 2019 18:24:11 -0400
Received: by mail-vs1-f68.google.com with SMTP id z11so12272064vsq.9;
        Mon, 03 Jun 2019 15:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C8Ve0xjKXEJqPCX4CqFLywaP30z1QNXLFcyDp7e0Z10=;
        b=kwjpkGgWsUCehTdcGWr+86fSky5RB8AU+c2buIsl9+Jf316gbOuyXMMbNxFK5ZMHqh
         cdsz8TfiLL2mbKWXXiVY++23ne8nsGvf6RIiz4xmzKu7Cz9BpmydVWphO2+J9xrLclQN
         dwbydVcx284jBphRZrdhxNn+2hZBJzA7I2HiaZjy6hrOlypR7SDwSrVhwjBY1VhRnEHR
         hT7T9ZgQcEhnHaZuprDs3elOGUyhCR8fqsYxo4gFYhFKNvzr60cQrbuYSRR85tsT2VtK
         sRtQPTRbK0qt23dMbAYYhqNkOiwj7i7b3Rr5m03kf9/9f8UPe0o0CSo/Kn+vX+OaP5I3
         8FaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C8Ve0xjKXEJqPCX4CqFLywaP30z1QNXLFcyDp7e0Z10=;
        b=NWpTB4NO9VGLDMD/b5ACs8GucamcxP1ZP4/RjRZtnEYNAL3bZ0Ke4p2W6Z9Q4SLka+
         ZKDNbGEI26hTPKNw70lMJ1fbfHxIKNvPCexWdN4VOcsjf/f8O5HT7x74spkeHoYKbO8A
         Ju9zoqDmhnWWeWm8neLb9813ebULMImXkThJJ4OvsygHj/GMlMd+oWjVbO2gZDX457y5
         j0fTnSlsijSJdmuKYE+L4DwF9Sj8lZzNxpLP6XGW0fblt+3gD3CW4NvLb5tDxBAFHJ4Z
         u3is1RqYy3jDQo4QM/rwiOvhg/5PLVcPrG2I9Q59YH9GcbktNen6+fWWLAyPdUTR3wgd
         JyzQ==
X-Gm-Message-State: APjAAAV86nKNHnRY09Mdnr+540CJi7/WETFFiBRpWp1hmufJXQcCNn/r
        fLP98ZdyB1z6te6On/7jVoOv1xyOx0z5Yci+pf9DbQ==
X-Google-Smtp-Source: APXvYqxA2hWGTz0XN0jPUwqb0oSRZbvYot1ZMtOJXi8sVTlK32c0wPKaTR9Jc7yVx5G83r4lZvwyuo99mhs+XtGNMvg=
X-Received: by 2002:a67:de99:: with SMTP id r25mr13862777vsk.215.1559594386441;
 Mon, 03 Jun 2019 13:39:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190529174318.22424-1-amir73il@gmail.com> <20190529174318.22424-14-amir73il@gmail.com>
 <CAN-5tyF9OnRsF_dgtx8aUGFB5tUUs=JK1wzXvRGo3za8jfpJdQ@mail.gmail.com> <CAOQ4uxh_0RVus56Ao_tFXCHdM6dsTrk=MsSBs1p7NjX4eJZkbg@mail.gmail.com>
In-Reply-To: <CAOQ4uxh_0RVus56Ao_tFXCHdM6dsTrk=MsSBs1p7NjX4eJZkbg@mail.gmail.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Mon, 3 Jun 2019 16:39:35 -0400
Message-ID: <CAN-5tyFMOxjUrzBFf3OE+5P8pnh0Q-ngUWCmU2eFB1WKFyGPQw@mail.gmail.com>
Subject: Re: [PATCH v3 13/13] vfs: allow copy_file_range to copy across devices
To:     Amir Goldstein <amir73il@gmail.com>
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

On Wed, May 29, 2019 at 5:03 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Wed, May 29, 2019 at 11:09 PM Olga Kornievskaia
> <olga.kornievskaia@gmail.com> wrote:
> >
> > On Wed, May 29, 2019 at 1:43 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> > > We want to enable cross-filesystem copy_file_range functionality
> > > where possible, so push the "same superblock only" checks down to
> > > the individual filesystem callouts so they can make their own
> > > decisions about cross-superblock copy offload and fallack to
> > > generic_copy_file_range() for cross-superblock copy.
> > >
> > > [Amir] We do not call ->remap_file_range() in case the inodes are not
> > > on the same sb and do not call ->copy_file_range() in case the inodes
> > > are not on the same filesystem type.
> > >
> > > This changes behavior of the copy_file_range(2) syscall, which will
> > > now allow cross filesystem in-kernel copy.  CIFS already supports
> > > cross-superblock copy, between two shares to the same server. This
> > > functionality will now be available via the copy_file_range(2) syscall.
> > >
> > > Cc: Steve French <stfrench@microsoft.com>
> > > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
> > > ---
> > >  fs/ceph/file.c    |  4 +++-
> > >  fs/cifs/cifsfs.c  |  2 +-
> > >  fs/fuse/file.c    |  5 ++++-
> > >  fs/nfs/nfs4file.c |  5 ++++-
> > >  fs/read_write.c   | 20 ++++++++++++++------
> > >  5 files changed, 26 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> > > index 8a70708e1aca..e9614d686301 100644
> > > --- a/fs/ceph/file.c
> > > +++ b/fs/ceph/file.c
> > > @@ -1909,6 +1909,8 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
> > >
> > >         if (src_inode == dst_inode)
> > >                 return -EINVAL;
> > > +       if (src_inode->i_sb != dst_inode->i_sb)
> > > +               return -EXDEV;
> > >         if (ceph_snap(dst_inode) != CEPH_NOSNAP)
> > >                 return -EROFS;
> > >
> > > @@ -2126,7 +2128,7 @@ static ssize_t ceph_copy_file_range(struct file *src_file, loff_t src_off,
> > >         ret = __ceph_copy_file_range(src_file, src_off, dst_file, dst_off,
> > >                                      len, flags);
> > >
> > > -       if (ret == -EOPNOTSUPP)
> > > +       if (ret == -EOPNOTSUPP || ret == -EXDEV)
> > >                 ret = generic_copy_file_range(src_file, src_off, dst_file,
> > >                                               dst_off, len, flags);
> > >         return ret;
> > > diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
> > > index ab6c5c24146d..83956452c108 100644
> > > --- a/fs/cifs/cifsfs.c
> > > +++ b/fs/cifs/cifsfs.c
> > > @@ -1154,7 +1154,7 @@ static ssize_t cifs_copy_file_range(struct file *src_file, loff_t off,
> > >                                         len, flags);
> > >         free_xid(xid);
> > >
> > > -       if (rc == -EOPNOTSUPP)
> > > +       if (rc == -EOPNOTSUPP || rc == -EXDEV)
> > >                 rc = generic_copy_file_range(src_file, off, dst_file,
> > >                                              destoff, len, flags);
> > >         return rc;
> > > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > > index 7f33d68f66d9..eab00cd089e8 100644
> > > --- a/fs/fuse/file.c
> > > +++ b/fs/fuse/file.c
> > > @@ -3126,6 +3126,9 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
> > >         if (fc->no_copy_file_range)
> > >                 return -EOPNOTSUPP;
> > >
> > > +       if (file_inode(file_in)->i_sb != file_inode(file_out)->i_sb)
> > > +               return -EXDEV;
> > > +
> > >         inode_lock(inode_out);
> > >
> > >         err = file_modified(file_out);
> > > @@ -3187,7 +3190,7 @@ static ssize_t fuse_copy_file_range(struct file *src_file, loff_t src_off,
> > >         ret = __fuse_copy_file_range(src_file, src_off, dst_file, dst_off,
> > >                                      len, flags);
> > >
> > > -       if (ret == -EOPNOTSUPP)
> > > +       if (ret == -EOPNOTSUPP || ret == -EXDEV)
> > >                 ret = generic_copy_file_range(src_file, src_off, dst_file,
> > >                                               dst_off, len, flags);
> > >         return ret;
> > > diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
> > > index 4842f3ab3161..f4157eb1f69d 100644
> > > --- a/fs/nfs/nfs4file.c
> > > +++ b/fs/nfs/nfs4file.c
> > > @@ -133,6 +133,9 @@ static ssize_t __nfs4_copy_file_range(struct file *file_in, loff_t pos_in,
> > >                                       struct file *file_out, loff_t pos_out,
> > >                                       size_t count, unsigned int flags)
> > >  {
> > > +       /* Only offload copy if superblock is the same */
> > > +       if (file_inode(file_in)->i_sb != file_inode(file_out)->i_sb)
> > > +               return -EXDEV;
> > >         if (!nfs_server_capable(file_inode(file_out), NFS_CAP_COPY))
> > >                 return -EOPNOTSUPP;
> > >         if (file_inode(file_in) == file_inode(file_out))
> > > @@ -148,7 +151,7 @@ static ssize_t nfs4_copy_file_range(struct file *file_in, loff_t pos_in,
> > >
> > >         ret = __nfs4_copy_file_range(file_in, pos_in, file_out, pos_out, count,
> > >                                      flags);
> > > -       if (ret == -EOPNOTSUPP)
> > > +       if (ret == -EOPNOTSUPP || ret == -EXDEV)
> > >                 ret = generic_copy_file_range(file_in, pos_in, file_out,
> > >                                               pos_out, count, flags);
> > >         return ret;
> > > diff --git a/fs/read_write.c b/fs/read_write.c
> > > index 706ea5f276a7..d8930bb735cb 100644
> > > --- a/fs/read_write.c
> > > +++ b/fs/read_write.c
> > > @@ -1618,7 +1618,18 @@ static ssize_t do_copy_file_range(struct file *file_in, loff_t pos_in,
> > >                                   struct file *file_out, loff_t pos_out,
> > >                                   size_t len, unsigned int flags)
> > >  {
> > > -       if (file_out->f_op->copy_file_range)
> > > +       /*
> > > +        * Although we now allow filesystems to handle cross sb copy, passing
> > > +        * an inode of the wrong filesystem type to filesystem operation can
> > > +        * often result in an attempt to dereference the wrong concrete inode
> > > +        * struct, so avoid doing that until we really have a good reason.
> > > +        * The incentive for passing inode from different sb to filesystem is
> > > +        * NFS cross server copy and for that use case, enforcing same
> > > +        * filesystem type is acceptable.
> > > +        */
> > > +       if (file_out->f_op->copy_file_range &&
> > > +           file_inode(file_in)->i_sb->s_type ==
> > > +           file_inode(file_out)->i_sb->s_type)
> >
> > While I'm not sure how much I care (vs wanting at least this much of
> > cross device copy available) but in NFS there are several NFS
> > file_system_type defined which would disallow a copy between them
> > (like nfs4_remote_fs_type, nfs4_remote_referral_fs_type, and good old
> > nfs4_fs_type).
> >
> > One idea would be to push the check into the filesystems themselves.
> >
>
> That will require more delicate patches to filesystems.
> Are you saying there is a *good* reason to do that now?
> Is nfs copy offload expected to be between different types of nfs
> file_system_type?

So I had to setup a test case to perhaps give you a good reason. An
NFS server might have an export that's a referral to another server.
In this case the NFS client gets an ERR_MOVED and would mount the 2nd
server. It shows up as a submount and it would have a different file
system type. Having that check would prevent the NFS client from doing
an NFS copy_file_range between those 2 servers and instead VFS would
fallback to the generic_copy_file_range.

So why is hard(er) to push the check that ->s_types are the same for
the input and output files into the filesystems like it's done in this
patch with the ->i_sb checks?
