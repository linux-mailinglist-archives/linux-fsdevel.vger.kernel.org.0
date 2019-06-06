Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 099D8368C4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2019 02:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfFFAbu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jun 2019 20:31:50 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35998 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbfFFAbu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jun 2019 20:31:50 -0400
Received: by mail-pl1-f193.google.com with SMTP id d21so181214plr.3;
        Wed, 05 Jun 2019 17:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lo7TraqO2TMX5/7qZP2mO+ca/It9ukuhru5HRXoJ+t8=;
        b=dqGz+SPZoQWuzMmF+26oDXHR36YQOeuiY2hvn5T+OlUeSufslIHnc5Q43rfpZJp3Gm
         l1LPDH6UhdmENAja2sHpQxtFV7g9n/gh4+L+F1OA62qYU47wFfo4BL+yCvD2K2l+Be8+
         2yjwwJeUOSHFHF5hz/EMC+zaGoiSx/fZcJTo7X/RLS1aRH/nj9jkgD1jb10dfxSgD+E0
         mJETksq7ZM2CLWQBCTy/JvEQbgYo67gMgBVtM4G2eTVG3QPdCkgSmbM2dsz2+LhXLatC
         O/AqAM/MuhbhUhzTDBrY8e+qA2da9/gPjw7zxnOdhWik2xA38O6THyWgsX4xdHEVP7Se
         EHUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lo7TraqO2TMX5/7qZP2mO+ca/It9ukuhru5HRXoJ+t8=;
        b=gZ0cKbF8rD4eboBKTCTlJV2ZO/HvJ6GezPs5+43qSHytjzsst2kzqfzGGnQuafB6Ci
         oTmz9v42dGEk2lRuFL9QirENZqErB69euXu5LhpVdrcxpS2yc6Xo203m0YmwKjjH6Crl
         RaZPN+TklmkOAl1Cm4LxptMZfOlODzE0rZtJF/sPaMrpHagg2ao0m6EeIKxuswUTiBmI
         A1cjowL5c8owaZ+2VEyxV/pOaunFoLpgaSf8gwnliIyzb7kWx7a+Cr5aHNgSrvF1W+0d
         dYDD+VkupCyBC0WRf1mqRdwARR2Yj4poHMNzgsj4X0q2qwtspNc94SVzIiG40DA+wq6P
         krSQ==
X-Gm-Message-State: APjAAAVdhpWVzq4kj03CJ2Qp0bwX+AzTC3hltgn6mdcN+jLpInkik8oX
        mAdas57DwroxjFeequYSokccOHeNTb/5BRiz+iw=
X-Google-Smtp-Source: APXvYqyTcNnzprFBbids7q5uDqSDxZJo72BiRRp8BbvOaGjPTFgR7nQv5w6VdX7shYCXchNQPNlZbCCIKX/nTrrt0ms=
X-Received: by 2002:a17:902:2a29:: with SMTP id i38mr19688493plb.46.1559781108873;
 Wed, 05 Jun 2019 17:31:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190604135632.1487-1-amir73il@gmail.com> <CAN-5tyFBd4mJ84C2J9dwG_iYeEDN0tX86DjW4oaV7yscj4VR7g@mail.gmail.com>
In-Reply-To: <CAN-5tyFBd4mJ84C2J9dwG_iYeEDN0tX86DjW4oaV7yscj4VR7g@mail.gmail.com>
From:   Steve French <smfrench@gmail.com>
Date:   Wed, 5 Jun 2019 19:31:37 -0500
Message-ID: <CAH2r5mtbmXx6g7zf+C8cg8sT6WJKAoH=93nk5O5mLxpBzTHPTg@mail.gmail.com>
Subject: Re: [PATCH v5 8/9] vfs: allow copy_file_range to copy across devices
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
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

I tried the patchset and new xfstests with cifs.ko and looks like the
copy_file_range patches are fine

1) xfs_io copy_range worked fine (once I fixed a bug I found in
cifs.ko in the "match_server" function)
2) the new xfstest 989 requires other features (swapfiles) which I can
add and 990 requires new xfsprogs presumably (xfs_io in current Ubuntu
doesn't seem to include xfs_io chmod)
generic/989    [not run] swapfiles are not supported
generic/990    [not run] xfs_io chmod support is missing

Are there other xfstests that you would like me to run (other than the
3 in the 900 series)?

On Tue, Jun 4, 2019 at 3:43 PM Olga Kornievskaia
<olga.kornievskaia@gmail.com> wrote:
>
> On Tue, Jun 4, 2019 at 9:56 AM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > We want to enable cross-filesystem copy_file_range functionality
> > where possible, so push the "same superblock only" checks down to
> > the individual filesystem callouts so they can make their own
> > decisions about cross-superblock copy offload and fallack to
> > generic_copy_file_range() for cross-superblock copy.
> >
> > [Amir] We do not call ->remap_file_range() in case the files are not
> > on the same sb and do not call ->copy_file_range() in case the files
> > do not belong to the same filesystem driver.
> >
> > This changes behavior of the copy_file_range(2) syscall, which will
> > now allow cross filesystem in-kernel copy.  CIFS already supports
> > cross-superblock copy, between two shares to the same server. This
> > functionality will now be available via the copy_file_range(2) syscall.
> >
> > Cc: Steve French <stfrench@microsoft.com>
> > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >
> > Darrick,
> >
> > Per feedback from Olga, I am sending a modified version of this patch
> > to address cross file_system_type copy issue in nfs.
> >
>
> Thanks Amir, this works for NFS with referrals.
>
> > For the sake of global warming I am not re-posting the entire patch set.
> > I removed your RVB because of the change.
> >
> > Thanks,
> > Amir.
> >
> > Changes since v4:
> > - Check "same filesystem driver" by comapring ->copy_file_range()
> >   function pointer
> >
> >  fs/ceph/file.c    |  4 +++-
> >  fs/cifs/cifsfs.c  |  2 +-
> >  fs/fuse/file.c    |  5 ++++-
> >  fs/nfs/nfs4file.c |  5 ++++-
> >  fs/read_write.c   | 18 ++++++++++++------
> >  5 files changed, 24 insertions(+), 10 deletions(-)
> >
> > diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> > index e87f7b2023af..4cd41ed5cc53 100644
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
> > @@ -2109,7 +2111,7 @@ static ssize_t ceph_copy_file_range(struct file *src_file, loff_t src_off,
> >         ret = __ceph_copy_file_range(src_file, src_off, dst_file, dst_off,
> >                                      len, flags);
> >
> > -       if (ret == -EOPNOTSUPP)
> > +       if (ret == -EOPNOTSUPP || ret == -EXDEV)
> >                 ret = generic_copy_file_range(src_file, src_off, dst_file,
> >                                               dst_off, len, flags);
> >         return ret;
> > diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
> > index c65823270313..f11eea6125c1 100644
> > --- a/fs/cifs/cifsfs.c
> > +++ b/fs/cifs/cifsfs.c
> > @@ -1149,7 +1149,7 @@ static ssize_t cifs_copy_file_range(struct file *src_file, loff_t off,
> >                                         len, flags);
> >         free_xid(xid);
> >
> > -       if (rc == -EOPNOTSUPP)
> > +       if (rc == -EOPNOTSUPP || rc == -EXDEV)
> >                 rc = generic_copy_file_range(src_file, off, dst_file,
> >                                              destoff, len, flags);
> >         return rc;
> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > index e03901ae729b..569baf286835 100644
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
> >         if (fc->writeback_cache) {
> > @@ -3182,7 +3185,7 @@ static ssize_t fuse_copy_file_range(struct file *src_file, loff_t src_off,
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
> > index cec7e7b1f693..bb594c8f4404 100644
> > --- a/fs/read_write.c
> > +++ b/fs/read_write.c
> > @@ -1599,7 +1599,16 @@ static ssize_t do_copy_file_range(struct file *file_in, loff_t pos_in,
> >                                   struct file *file_out, loff_t pos_out,
> >                                   size_t len, unsigned int flags)
> >  {
> > -       if (file_out->f_op->copy_file_range)
> > +       /*
> > +        * Although we now allow filesystems to handle cross sb copy, passing
> > +        * a file of the wrong filesystem type to filesystem driver can result
> > +        * in an attempt to dereference the wrong type of ->private_data, so
> > +        * avoid doing that until we really have a good reason.
> > +        * NFS has several different file_system_type's, but they all end up
> > +        * using the same ->copy_file_range() function pointer.
> > +        */
> > +       if (file_out->f_op->copy_file_range &&
> > +           file_out->f_op->copy_file_range == file_in->f_op->copy_file_range)
> >                 return file_out->f_op->copy_file_range(file_in, pos_in,
> >                                                        file_out, pos_out,
> >                                                        len, flags);
> > @@ -1622,10 +1631,6 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
> >         if (flags != 0)
> >                 return -EINVAL;
> >
> > -       /* this could be relaxed once a method supports cross-fs copies */
> > -       if (file_inode(file_in)->i_sb != file_inode(file_out)->i_sb)
> > -               return -EXDEV;
> > -
> >         ret = generic_copy_file_checks(file_in, pos_in, file_out, pos_out, &len,
> >                                        flags);
> >         if (unlikely(ret))
> > @@ -1648,7 +1653,8 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
> >          * Try cloning first, this is supported by more file systems, and
> >          * more efficient if both clone and copy are supported (e.g. NFS).
> >          */
> > -       if (file_in->f_op->remap_file_range) {
> > +       if (file_in->f_op->remap_file_range &&
> > +           file_inode(file_in)->i_sb == file_inode(file_out)->i_sb) {
> >                 loff_t cloned;
> >
> >                 cloned = file_in->f_op->remap_file_range(file_in, pos_in,
> > --
> > 2.17.1
> >



-- 
Thanks,

Steve
