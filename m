Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D12050BA8F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 16:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448905AbiDVOv1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 10:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448902AbiDVOvX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:51:23 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A0B5C35D
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Apr 2022 07:48:29 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 21so10724922edv.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Apr 2022 07:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7zsIRzNIRn8xv0TLvT1DjIsq/RVivIHdkhDcQAho+Zs=;
        b=Nr0Z18y8ph+MXQmfpZLNfzIbpNdfJoEKXbDAt/UnP/BTrVycDDpH13iPs4rguEOzQ/
         otnKQwTY56EQgfUVXjybo05UyV3pChE/kkiOzcRklDeEiXQPap60evUUw/J1TX05u+iF
         UwqjtvWsFFR4dhn46H3L5tvi2uxVlS5TnRnjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7zsIRzNIRn8xv0TLvT1DjIsq/RVivIHdkhDcQAho+Zs=;
        b=OYvJDanAwKJvNUXXh7vALFLEMCqXmStVKKPvAJHSQ9KZvUNAOUfuEwav27J4Ly80KO
         L0zjdAh7vR34Ap/vjz7fAYEMJYivW7ggi+Ep2v7eHbmydI2TnIngZwtcKimHTJ2xMf85
         ip0AWUn0/b103fLSezvogXCJhUMCNtRY1rPbFqIhF659EyHqvB1nyZJX7fnxjDuLNrlu
         MUqFuMucWvXuVYG73s2wn5jEX1NGVTE3JfMjvaUYRHV6dXDnUfpTy5X7tUqLZ70Q1WUb
         8ZQChdPimt1NS5phx3rk34GP6m6vgZ7UtXn5zrk9YK6DUH4yIjNUwZ2IyFoMZFg8KpQ9
         AzQA==
X-Gm-Message-State: AOAM530xlxn38vmu1TLAttBG/dKC04Do09SfRSkZ6J2sW23Jg2EfS+bG
        iZbf3iPCfJEGsB+cQ2ZcX6UkhKx+mzhZpzJO5rUMTw==
X-Google-Smtp-Source: ABdhPJyLkyfn7hrzDCgBNR4IbPa/+dcKZx+aqeRvjZL/LtCvp3ryeyf9mXsqjnEUsQmn7dMJTi0QQQwhGBWdqs7sn3Q=
X-Received: by 2002:a05:6402:270e:b0:424:55a:d8a3 with SMTP id
 y14-20020a056402270e00b00424055ad8a3mr5174379edd.221.1650638907755; Fri, 22
 Apr 2022 07:48:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220408061809.12324-1-dharamhans87@gmail.com>
 <20220408061809.12324-2-dharamhans87@gmail.com> <CAJfpegvU+y+WRhWrgWfc_7O5BdVi=N+3RUuVdBFFoyYVr9MDeg@mail.gmail.com>
 <CACUYsyGiNgbyoxWWdXm0z73B7QfnPGU2gYanDNSQqmq5_rnrhw@mail.gmail.com>
In-Reply-To: <CACUYsyGiNgbyoxWWdXm0z73B7QfnPGU2gYanDNSQqmq5_rnrhw@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 22 Apr 2022 16:48:16 +0200
Message-ID: <CAJfpegsZF4D-sshMK0C=jSECskyQRAgA_1hKD9ytsHKvmXoBeA@mail.gmail.com>
Subject: Re: [PATCH 1/1] FUSE: Allow parallel direct writes on the same file
To:     Dharmendra Hans <dharamhans87@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org, Bernd Schubert <bschubert@ddn.com>,
        Dharmendra Singh <dsingh@ddn.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 22 Apr 2022 at 16:30, Dharmendra Hans <dharamhans87@gmail.com> wrote:
>
> On Thu, Apr 21, 2022 at 8:52 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Fri, 8 Apr 2022 at 08:18, Dharmendra Singh <dharamhans87@gmail.com> wrote:
> > >
> > > As of now, in Fuse, direct writes on the same file are serialized
> > > over inode lock i.e we hold inode lock for the whole duration of
> > > the write request. This serialization works pretty well for the FUSE
> > > user space implementations which rely on this inode lock for their
> > > cache/data integrity etc. But it hurts badly such FUSE implementations
> > > which has their own ways of mainting data/cache integrity and does not
> > > use this serialization at all.
> > >
> > > This patch allows parallel direct writes on the same file with the
> > > help of a flag called FOPEN_PARALLEL_WRITES. If this flag is set on
> > > the file (flag is passed from libfuse to fuse kernel as part of file
> > > open/create), we do not hold inode lock for the whole duration of the
> > > request, instead acquire it only to protect updates on certain fields
> > > of the inode. FUSE implementations which rely on this inode lock can
> > > continue to do so and this is default behaviour.
> > >
> > > Signed-off-by: Dharmendra Singh <dsingh@ddn.com>
> > > ---
> > >  fs/fuse/file.c            | 38 ++++++++++++++++++++++++++++++++++----
> > >  include/uapi/linux/fuse.h |  2 ++
> > >  2 files changed, 36 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > > index 37eebfb90500..d3e8f44c1228 100644
> > > --- a/fs/fuse/file.c
> > > +++ b/fs/fuse/file.c
> > > @@ -1465,6 +1465,8 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
> > >         int err = 0;
> > >         struct fuse_io_args *ia;
> > >         unsigned int max_pages;
> > > +       bool p_write = write &&
> > > +               (ff->open_flags & FOPEN_PARALLEL_WRITES) ? true : false;
> > >
> > >         max_pages = iov_iter_npages(iter, fc->max_pages);
> > >         ia = fuse_io_alloc(io, max_pages);
> > > @@ -1472,10 +1474,11 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
> > >                 return -ENOMEM;
> > >
> > >         if (!cuse && fuse_range_is_writeback(inode, idx_from, idx_to)) {
> > > -               if (!write)
> > > +               /* Parallel write does not come with inode lock held */
> > > +               if (!write || p_write)
> >
> > Probably would be good to add an inode_is_locked() assert in
> > fuse_sync_writes() to make sure we don't miss cases silently.
>
> I think fuse_set_nowrite() called from fuse_sync_writes() already has
> this assertion.

Ah, okay.

>
> >
> > >                         inode_lock(inode);
> > >                 fuse_sync_writes(inode);
> > > -               if (!write)
> > > +               if (!write || p_write)
> > >                         inode_unlock(inode);
> > >         }
> > >
> > > @@ -1568,22 +1571,36 @@ static ssize_t fuse_direct_read_iter(struct kiocb *iocb, struct iov_iter *to)
> > >  static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_iter *from)
> > >  {
> > >         struct inode *inode = file_inode(iocb->ki_filp);
> > > +       struct file *file = iocb->ki_filp;
> > > +       struct fuse_file *ff = file->private_data;
> > >         struct fuse_io_priv io = FUSE_IO_PRIV_SYNC(iocb);
> > >         ssize_t res;
> > > +       bool p_write = ff->open_flags & FOPEN_PARALLEL_WRITES ? true : false;
> > > +       bool unlock_inode = true;
> > >
> > >         /* Don't allow parallel writes to the same file */
> > >         inode_lock(inode);
> > >         res = generic_write_checks(iocb, from);
> >
> > I don't think this needs inode lock.  At least nfs_file_direct_write()
> > doesn't have it.
> >
> > What it does have, however is taking the inode lock for shared for the
> > actual write operation, which is probably something that fuse needs as
> > well.
> >
> > Also I worry about size extending writes not holding the inode lock
> > exclusive.  Would that be a problem in your use case?
>
> Thanks for pointing out this issue. Actually there is an issue in
> appending writes.
> Until unless current appeding write is finished and does not update
> i_size, next appending
> write can't be allowed as it would be otherwise one request
> overwriting data written
> by another request.
> For other kind of writes, I do not see the issue as i_size update can
> be handled as it is
> done currently as these writes are based upon fixed offset instead of
> generating offset
> from i_size.

That's true, but I still worry...  Does your workload include
non-append extending writes?  Seems to me making those run in parallel
is asking for trouble.

> If we agreed, I  would be sending the updated patch shortly.
> (Also please take a look on other patches raised by me for atomic-open,  these
>  patches are pending since couple of weeks)

I'm looking at that currently.

Thanks,
Miklos
