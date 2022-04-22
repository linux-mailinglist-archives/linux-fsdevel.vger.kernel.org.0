Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3C450BA22
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 16:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448680AbiDVOdg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 10:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448490AbiDVOdf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:33:35 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF53953E13;
        Fri, 22 Apr 2022 07:30:41 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id j17so8170900pfi.9;
        Fri, 22 Apr 2022 07:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tqTVtmg3VMpgT0arpQefVVAUzTvn49VG+57BcF06njU=;
        b=asHjRXOhNhV6lN/7JRYxgl8xw2b1u8M7Z2Dpw4CmRwWzFIY1d1QldtsCm0iQO/Jy1o
         cPO0DsnwSQVJfHe7nG2wHD5tSPxB6nrokdrQ9np/lN/b9v3hbr+0Vsr+sFcZQxPGimoV
         QlWq+7jbgYd6QZOystWFXiVC9bmTun96xDz/KjIMrI+ZkSvHVu7CJiqyFdJiKqR9KfKm
         +vhqZVJymoM1Yqc+OBvQBaOdd9eISzirMQXW9rtmTh5dqtDeYUtm2i2JUEFnLorvKHv6
         XphPqGRjvVQXM2qAmrqOAcwH72W71hDWPFBZpv009HG9FN4yfkFuwyLFqngxjtdLKyoi
         nuvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tqTVtmg3VMpgT0arpQefVVAUzTvn49VG+57BcF06njU=;
        b=kiPcs2hpvVWYVamWXrttSMAdvGNgqrTFptuz+YW20Ff9Yy2mbyYSFGaoWuOCSKQ1ys
         7nnJIl6PGFq01FDJsnleoU9xRm6sdefULJjUpAuOjS+ffyX4IRY1aFU8dkU8Ce4eVc5N
         eqS+K4K/WV3WN+XSCT8aN/Stv6ZO3Y5PQUuJk+qAlvykwhqgpwOvtQ2E9Rb5fFoUzfL+
         PJ8JOv8QM/tFnD/RW15qcCLOD0xk7tdorENO/osJhSrt8//Z7Qti317Muy+0vBaEa5lH
         hBsTyAY3sjveAzou/LUTQYZ5BAH2PhhoBDYbADdc3Cg9Q1Ekwnk8fVKq8xlHyCWbXFfW
         81ZA==
X-Gm-Message-State: AOAM533/XLTkIU0m5GbUcdyKgyxUZdSbkioftF1iw/SMbilOSAM4ijVf
        usgQI+WvjH2XxyK4tpM311WNrpeoTk4hVqVMNCZAOHMjhgFVeg==
X-Google-Smtp-Source: ABdhPJyO7NL4Nf82adbhtDG7TE/iUhKEzGvZ4jsR0dGOW4UI+tMSUqq///daHDSKtauuXaEuqy2wYOCcnuDR0IHRBBg=
X-Received: by 2002:a62:5343:0:b0:4f7:baad:5c22 with SMTP id
 h64-20020a625343000000b004f7baad5c22mr5250192pfb.30.1650637841200; Fri, 22
 Apr 2022 07:30:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220408061809.12324-1-dharamhans87@gmail.com>
 <20220408061809.12324-2-dharamhans87@gmail.com> <CAJfpegvU+y+WRhWrgWfc_7O5BdVi=N+3RUuVdBFFoyYVr9MDeg@mail.gmail.com>
In-Reply-To: <CAJfpegvU+y+WRhWrgWfc_7O5BdVi=N+3RUuVdBFFoyYVr9MDeg@mail.gmail.com>
From:   Dharmendra Hans <dharamhans87@gmail.com>
Date:   Fri, 22 Apr 2022 20:00:29 +0530
Message-ID: <CACUYsyGiNgbyoxWWdXm0z73B7QfnPGU2gYanDNSQqmq5_rnrhw@mail.gmail.com>
Subject: Re: [PATCH 1/1] FUSE: Allow parallel direct writes on the same file
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org, Bernd Schubert <bschubert@ddn.com>,
        Dharmendra Singh <dsingh@ddn.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 21, 2022 at 8:52 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Fri, 8 Apr 2022 at 08:18, Dharmendra Singh <dharamhans87@gmail.com> wrote:
> >
> > As of now, in Fuse, direct writes on the same file are serialized
> > over inode lock i.e we hold inode lock for the whole duration of
> > the write request. This serialization works pretty well for the FUSE
> > user space implementations which rely on this inode lock for their
> > cache/data integrity etc. But it hurts badly such FUSE implementations
> > which has their own ways of mainting data/cache integrity and does not
> > use this serialization at all.
> >
> > This patch allows parallel direct writes on the same file with the
> > help of a flag called FOPEN_PARALLEL_WRITES. If this flag is set on
> > the file (flag is passed from libfuse to fuse kernel as part of file
> > open/create), we do not hold inode lock for the whole duration of the
> > request, instead acquire it only to protect updates on certain fields
> > of the inode. FUSE implementations which rely on this inode lock can
> > continue to do so and this is default behaviour.
> >
> > Signed-off-by: Dharmendra Singh <dsingh@ddn.com>
> > ---
> >  fs/fuse/file.c            | 38 ++++++++++++++++++++++++++++++++++----
> >  include/uapi/linux/fuse.h |  2 ++
> >  2 files changed, 36 insertions(+), 4 deletions(-)
> >
> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > index 37eebfb90500..d3e8f44c1228 100644
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -1465,6 +1465,8 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
> >         int err = 0;
> >         struct fuse_io_args *ia;
> >         unsigned int max_pages;
> > +       bool p_write = write &&
> > +               (ff->open_flags & FOPEN_PARALLEL_WRITES) ? true : false;
> >
> >         max_pages = iov_iter_npages(iter, fc->max_pages);
> >         ia = fuse_io_alloc(io, max_pages);
> > @@ -1472,10 +1474,11 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
> >                 return -ENOMEM;
> >
> >         if (!cuse && fuse_range_is_writeback(inode, idx_from, idx_to)) {
> > -               if (!write)
> > +               /* Parallel write does not come with inode lock held */
> > +               if (!write || p_write)
>
> Probably would be good to add an inode_is_locked() assert in
> fuse_sync_writes() to make sure we don't miss cases silently.

I think fuse_set_nowrite() called from fuse_sync_writes() already has
this assertion.

>
> >                         inode_lock(inode);
> >                 fuse_sync_writes(inode);
> > -               if (!write)
> > +               if (!write || p_write)
> >                         inode_unlock(inode);
> >         }
> >
> > @@ -1568,22 +1571,36 @@ static ssize_t fuse_direct_read_iter(struct kiocb *iocb, struct iov_iter *to)
> >  static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_iter *from)
> >  {
> >         struct inode *inode = file_inode(iocb->ki_filp);
> > +       struct file *file = iocb->ki_filp;
> > +       struct fuse_file *ff = file->private_data;
> >         struct fuse_io_priv io = FUSE_IO_PRIV_SYNC(iocb);
> >         ssize_t res;
> > +       bool p_write = ff->open_flags & FOPEN_PARALLEL_WRITES ? true : false;
> > +       bool unlock_inode = true;
> >
> >         /* Don't allow parallel writes to the same file */
> >         inode_lock(inode);
> >         res = generic_write_checks(iocb, from);
>
> I don't think this needs inode lock.  At least nfs_file_direct_write()
> doesn't have it.
>
> What it does have, however is taking the inode lock for shared for the
> actual write operation, which is probably something that fuse needs as
> well.
>
> Also I worry about size extending writes not holding the inode lock
> exclusive.  Would that be a problem in your use case?

Thanks for pointing out this issue. Actually there is an issue in
appending writes.
Until unless current appeding write is finished and does not update
i_size, next appending
write can't be allowed as it would be otherwise one request
overwriting data written
by another request.
For other kind of writes, I do not see the issue as i_size update can
be handled as it is
done currently as these writes are based upon fixed offset instead of
generating offset
from i_size.

So here is how I am thinking to handle this.
1) Take exclusive lock on the inode for appending writes.
2) Take shared lock on the inode for writes other than appending
writes. This shared lock
     will prevent truncation on the inode at the same time otherwise
we might face issues
    on i_size.

Please note that we use fi->lock to update the i_size. Hence we would
not be required
to upgrade this shared lock to exclusive lock when updating i_size.
Therefore having shared
lock for write requests other than appending writes fulfill our purpose.

>
> >         if (res > 0) {
> > +               /* Allow parallel writes on the inode by unlocking it */
> > +               if (p_write) {
> > +                       inode_unlock(inode);
> > +                       unlock_inode = false;
> > +               }
> >                 if (!is_sync_kiocb(iocb) && iocb->ki_flags & IOCB_DIRECT) {
> >                         res = fuse_direct_IO(iocb, from);
> >                 } else {
> >                         res = fuse_direct_io(&io, from, &iocb->ki_pos,
> >                                              FUSE_DIO_WRITE);
> > +                       if (p_write) {
> > +                               inode_lock(inode);
> > +                               unlock_inode = true;
> > +                       }
> >                         fuse_write_update_attr(inode, iocb->ki_pos, res);
>
> This doesn't need the inode lock either if the actual write wasn't locked.

Would remove

>
> >                 }
> >         }
> > -       inode_unlock(inode);
> > +       if (unlock_inode)
> > +               inode_unlock(inode);
> >
> >         return res;
> >  }
> > @@ -2850,10 +2867,16 @@ fuse_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
> >         size_t count = iov_iter_count(iter), shortened = 0;
> >         loff_t offset = iocb->ki_pos;
> >         struct fuse_io_priv *io;
> > -
> > +       bool p_write = (iov_iter_rw(iter) == WRITE &&
> > +                       ff->open_flags & FOPEN_PARALLEL_WRITES);
> >         pos = offset;
> >         inode = file->f_mapping->host;
> > +
> > +       if (p_write)
> > +               inode_lock(inode);
> >         i_size = i_size_read(inode);
>
> Neither this.

We would not be taking exclusive lock for request other than appending writes.

>
> > +       if (p_write)
> > +               inode_unlock(inode);
> >
> >         if ((iov_iter_rw(iter) == READ) && (offset >= i_size))
> >                 return 0;
> > @@ -2924,9 +2947,16 @@ fuse_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
> >         kref_put(&io->refcnt, fuse_io_release);
> >
> >         if (iov_iter_rw(iter) == WRITE) {
> > +
> > +               if (p_write)
> > +                       inode_lock(inode);
> > +
> >                 fuse_write_update_attr(inode, pos, ret);
> >                 if (ret < 0 && offset + count > i_size)
> >                         fuse_do_truncate(file);
> > +
> > +               if (p_write)
> > +                       inode_unlock(inode);
>
> Truncation needs the inode lock, though I'm not completely
> understanding why this truncation is needed.  But for example here it
> is assumed that file size won't change, which means that non-extending
> writes should hold inode lock shared and extending writes should hold
> inode lock exculsive to meet this assumption.

I did not get fully why this truncation is needed here as well. But we would be
taking exclusive lock in this case as  now file size can get  changed before we
came here.

If we agreed, I  would be sending the updated patch shortly.
(Also please take a look on other patches raised by me for atomic-open,  these
 patches are pending since couple of weeks)

Thanks,
Dharmendra
