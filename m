Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8CE82E702
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 23:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfE2VDj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 17:03:39 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:38091 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfE2VDj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 17:03:39 -0400
Received: by mail-yw1-f65.google.com with SMTP id b74so1681017ywe.5;
        Wed, 29 May 2019 14:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WFYgZ3xTZljDOPRhtfmN40cBxYCoBeqo14r6/1bn7UQ=;
        b=gFJvIacEhQDeFxNvbgcMUWsf4Kwj0EKvun0oJ/cNuKA2Vtx7nrp1e+AXwSt/gyVM/6
         IdTYHvF8RzK9kuz2BQxv4+kpX25QricTfOErHJ/D6s7sPKaDVBAP8I/4EYuhARiGAdoO
         7lrWj6I44mlO9y+SqkAIx4c6ben/f1XYde1SXQt8vy62qWX4/rzTPFTXfOs5qOqumvqr
         D/6kGECdyihCIHAgXIauYDxNHY9DnJtmOXrKYDFaK1QKhMTXMbjXBG6kV3R+wQiOYaFs
         wGN701reb5FO+wFThVXRDv7XXTRegCUYNwkLgDjJD8zYdXZahzQ+29MRJD9CD7Loy+Jo
         P9IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WFYgZ3xTZljDOPRhtfmN40cBxYCoBeqo14r6/1bn7UQ=;
        b=Ja1o6rtvk/k6Ski8vsa2Z+h2bvKEhlpnB7JpQQnBw5uyscl6K4DNkC6pWWkOTc/tqB
         nvS0mhDUnNWP4d0JGRaRXRizy919tHL+7dHAb2aPB2KMxMtbYEPq3OhqoSOSK8/b6eSk
         F2wmN5+R3USXRWzza8tU0IO7+X5UpDg2wE/Xxdw31jQxNDHAcHUP6j68VYYaAEAzx757
         fauUXywzAzoMGZzZdZA7TnPnVfbuelgwIqiAXmHhSZqEACII5/jb4W8DzVpxZjAnMEKU
         GnZ1FZ2s8vKMyDdNjPzCrDkW+FlXh0vqDu/oJwxSZNEjQJKA4V80KxaZ5ABictmEBjYX
         5cgA==
X-Gm-Message-State: APjAAAV53I0BTalGUPhoOeSmvI62Z1dUjPMsh/QevtZ3lPeu/M2kkgMw
        fzz+P08uN8hngv8bqXdzZQA4GN3NNVRdnKwaSFI=
X-Google-Smtp-Source: APXvYqyxScaKIEF7mVCGtEwtucu6Go1l0NvXGTZ8ohAT+592a9iPrsYZXeHzNqMFEpb9vDQnqj5a/1C1BkOYlDbHq+o=
X-Received: by 2002:a81:1186:: with SMTP id 128mr3736ywr.181.1559163817960;
 Wed, 29 May 2019 14:03:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190529174318.22424-1-amir73il@gmail.com> <20190529174318.22424-14-amir73il@gmail.com>
 <CAN-5tyF9OnRsF_dgtx8aUGFB5tUUs=JK1wzXvRGo3za8jfpJdQ@mail.gmail.com>
In-Reply-To: <CAN-5tyF9OnRsF_dgtx8aUGFB5tUUs=JK1wzXvRGo3za8jfpJdQ@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 30 May 2019 00:03:26 +0300
Message-ID: <CAOQ4uxh_0RVus56Ao_tFXCHdM6dsTrk=MsSBs1p7NjX4eJZkbg@mail.gmail.com>
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

On Wed, May 29, 2019 at 11:09 PM Olga Kornievskaia
<olga.kornievskaia@gmail.com> wrote:
>
> On Wed, May 29, 2019 at 1:43 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > We want to enable cross-filesystem copy_file_range functionality
> > where possible, so push the "same superblock only" checks down to
> > the individual filesystem callouts so they can make their own
> > decisions about cross-superblock copy offload and fallack to
> > generic_copy_file_range() for cross-superblock copy.
> >
> > [Amir] We do not call ->remap_file_range() in case the inodes are not
> > on the same sb and do not call ->copy_file_range() in case the inodes
> > are not on the same filesystem type.
> >
> > This changes behavior of the copy_file_range(2) syscall, which will
> > now allow cross filesystem in-kernel copy.  CIFS already supports
> > cross-superblock copy, between two shares to the same server. This
> > functionality will now be available via the copy_file_range(2) syscall.
> >
> > Cc: Steve French <stfrench@microsoft.com>
> > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
> > ---
> >  fs/ceph/file.c    |  4 +++-
> >  fs/cifs/cifsfs.c  |  2 +-
> >  fs/fuse/file.c    |  5 ++++-
> >  fs/nfs/nfs4file.c |  5 ++++-
> >  fs/read_write.c   | 20 ++++++++++++++------
> >  5 files changed, 26 insertions(+), 10 deletions(-)
> >
> > diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> > index 8a70708e1aca..e9614d686301 100644
> > --- a/fs/ceph/file.c
> > +++ b/fs/ceph/file.c
> > @@ -1909,6 +1909,8 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
> >
> >         if (src_inode == dst_inode)
> >                 return -EINVAL;
> > +       if (src_inode->i_sb != dst_inode->i_sb)
> > +               return -EXDEV;
> >         if (ceph_snap(dst_inode) != CEPH_NOSNAP)
> >                 return -EROFS;
> >
> > @@ -2126,7 +2128,7 @@ static ssize_t ceph_copy_file_range(struct file *src_file, loff_t src_off,
> >         ret = __ceph_copy_file_range(src_file, src_off, dst_file, dst_off,
> >                                      len, flags);
> >
> > -       if (ret == -EOPNOTSUPP)
> > +       if (ret == -EOPNOTSUPP || ret == -EXDEV)
> >                 ret = generic_copy_file_range(src_file, src_off, dst_file,
> >                                               dst_off, len, flags);
> >         return ret;
> > diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
> > index ab6c5c24146d..83956452c108 100644
> > --- a/fs/cifs/cifsfs.c
> > +++ b/fs/cifs/cifsfs.c
> > @@ -1154,7 +1154,7 @@ static ssize_t cifs_copy_file_range(struct file *src_file, loff_t off,
> >                                         len, flags);
> >         free_xid(xid);
> >
> > -       if (rc == -EOPNOTSUPP)
> > +       if (rc == -EOPNOTSUPP || rc == -EXDEV)
> >                 rc = generic_copy_file_range(src_file, off, dst_file,
> >                                              destoff, len, flags);
> >         return rc;
> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > index 7f33d68f66d9..eab00cd089e8 100644
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -3126,6 +3126,9 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
> >         if (fc->no_copy_file_range)
> >                 return -EOPNOTSUPP;
> >
> > +       if (file_inode(file_in)->i_sb != file_inode(file_out)->i_sb)
> > +               return -EXDEV;
> > +
> >         inode_lock(inode_out);
> >
> >         err = file_modified(file_out);
> > @@ -3187,7 +3190,7 @@ static ssize_t fuse_copy_file_range(struct file *src_file, loff_t src_off,
> >         ret = __fuse_copy_file_range(src_file, src_off, dst_file, dst_off,
> >                                      len, flags);
> >
> > -       if (ret == -EOPNOTSUPP)
> > +       if (ret == -EOPNOTSUPP || ret == -EXDEV)
> >                 ret = generic_copy_file_range(src_file, src_off, dst_file,
> >                                               dst_off, len, flags);
> >         return ret;
> > diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
> > index 4842f3ab3161..f4157eb1f69d 100644
> > --- a/fs/nfs/nfs4file.c
> > +++ b/fs/nfs/nfs4file.c
> > @@ -133,6 +133,9 @@ static ssize_t __nfs4_copy_file_range(struct file *file_in, loff_t pos_in,
> >                                       struct file *file_out, loff_t pos_out,
> >                                       size_t count, unsigned int flags)
> >  {
> > +       /* Only offload copy if superblock is the same */
> > +       if (file_inode(file_in)->i_sb != file_inode(file_out)->i_sb)
> > +               return -EXDEV;
> >         if (!nfs_server_capable(file_inode(file_out), NFS_CAP_COPY))
> >                 return -EOPNOTSUPP;
> >         if (file_inode(file_in) == file_inode(file_out))
> > @@ -148,7 +151,7 @@ static ssize_t nfs4_copy_file_range(struct file *file_in, loff_t pos_in,
> >
> >         ret = __nfs4_copy_file_range(file_in, pos_in, file_out, pos_out, count,
> >                                      flags);
> > -       if (ret == -EOPNOTSUPP)
> > +       if (ret == -EOPNOTSUPP || ret == -EXDEV)
> >                 ret = generic_copy_file_range(file_in, pos_in, file_out,
> >                                               pos_out, count, flags);
> >         return ret;
> > diff --git a/fs/read_write.c b/fs/read_write.c
> > index 706ea5f276a7..d8930bb735cb 100644
> > --- a/fs/read_write.c
> > +++ b/fs/read_write.c
> > @@ -1618,7 +1618,18 @@ static ssize_t do_copy_file_range(struct file *file_in, loff_t pos_in,
> >                                   struct file *file_out, loff_t pos_out,
> >                                   size_t len, unsigned int flags)
> >  {
> > -       if (file_out->f_op->copy_file_range)
> > +       /*
> > +        * Although we now allow filesystems to handle cross sb copy, passing
> > +        * an inode of the wrong filesystem type to filesystem operation can
> > +        * often result in an attempt to dereference the wrong concrete inode
> > +        * struct, so avoid doing that until we really have a good reason.
> > +        * The incentive for passing inode from different sb to filesystem is
> > +        * NFS cross server copy and for that use case, enforcing same
> > +        * filesystem type is acceptable.
> > +        */
> > +       if (file_out->f_op->copy_file_range &&
> > +           file_inode(file_in)->i_sb->s_type ==
> > +           file_inode(file_out)->i_sb->s_type)
>
> While I'm not sure how much I care (vs wanting at least this much of
> cross device copy available) but in NFS there are several NFS
> file_system_type defined which would disallow a copy between them
> (like nfs4_remote_fs_type, nfs4_remote_referral_fs_type, and good old
> nfs4_fs_type).
>
> One idea would be to push the check into the filesystems themselves.
>

That will require more delicate patches to filesystems.
Are you saying there is a *good* reason to do that now?
Is nfs copy offload expected to be between different types of nfs
file_system_type?

Thanks,
Amir.
