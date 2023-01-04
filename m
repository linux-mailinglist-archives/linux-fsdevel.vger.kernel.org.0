Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45BA365DF0B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jan 2023 22:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240483AbjADV2k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Jan 2023 16:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240264AbjADV2Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Jan 2023 16:28:16 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728AB3F121
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 Jan 2023 13:22:18 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id s5so50383368edc.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Jan 2023 13:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5r/V3HPXwjpuD7IphcjrrB8OiZUQp0rchrkxxQGzaWI=;
        b=KEIC0i6TYit5Z0cdFjku8f3xpdIif4U2Ymvz3XlFlq2j6BxcLI8+aRhr5ueD/4NPZt
         5J/8Tmn+RoO27XqmSSN+2MvKrF23PsPGVyxQsTSipAdevtpNTCAHHgE1Q/dRVQTvoBqO
         4T5iaYELTABGEiuIT0Ntyw6CUkWJlk7WiKrlY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5r/V3HPXwjpuD7IphcjrrB8OiZUQp0rchrkxxQGzaWI=;
        b=IVi80uie6UlqpdyhPXTs77YYS8FxqR6LKhD6BKxqv+vmSLUCgrm1MBYm/tvREw8Yo0
         OKmHunn9OXOoZ915Go6hHqKOy4dQ86nxOmgb0Md2Q5RFmpfOlTFFrEc7bmpM1t+xOcMz
         BGko39c7+dfAsV+TV3Djv2lpS+cChvhs4k/M1kcZBLOqsZTafj83irXrt28WlZ8y7I0a
         n/tmsOAj1pj7CX0GaYKJCfhHfor79sUAYzCF0tYvPD26NoFJgbroj2rmNbRFcZ4YddgC
         O4t1rd1QwfERBbcaAnFzXFhroSScQ5I64xGhiuy4IPoG1VCgC2nC9ixbG4/mwSnxjY7k
         4WFg==
X-Gm-Message-State: AFqh2kq0MhdCPwnNc8lIcKoSJkbDx0dK0b04TMHS6zQkP9GRPu+qGqLG
        12qFOIsMfTdEyNsFKe7PLEZOeIqYTyHRwBCMxXRlRA==
X-Google-Smtp-Source: AMrXdXvyL02g5V8vC60eMixSySeuV+cmNwoRkD+KYiZL+r9p1DmuiHRjgR21Y+li8eMYghzwdId8ULZTKPgGOnDzC2M=
X-Received: by 2002:a05:6402:f27:b0:485:8114:9779 with SMTP id
 i39-20020a0564020f2700b0048581149779mr3674496eda.41.1672867336970; Wed, 04
 Jan 2023 13:22:16 -0800 (PST)
MIME-Version: 1.0
References: <20221229081252.452240-1-sarthakkukreti@chromium.org>
 <20221229081252.452240-4-sarthakkukreti@chromium.org> <Y7Wr2uadI+82BB6a@magnolia>
In-Reply-To: <Y7Wr2uadI+82BB6a@magnolia>
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
Date:   Wed, 4 Jan 2023 13:22:06 -0800
Message-ID: <CAG9=OMNbeU=Xg5bWvHUSfzRf8vsk6csvcw5BGZeMD5Lo7dfKFQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] fs: Introduce FALLOC_FL_PROVISION
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     sarthakkukreti@google.com, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Bart Van Assche <bvanassche@google.com>,
        Daniil Lunev <dlunev@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

(Resend; the text flow made the last reply unreadable)

On Wed, Jan 4, 2023 at 8:39 AM Darrick J. Wong <djwong@kernel.org> wrote:
>
> On Thu, Dec 29, 2022 at 12:12:48AM -0800, Sarthak Kukreti wrote:
> > FALLOC_FL_PROVISION is a new fallocate() allocation mode that
> > sends a hint to (supported) thinly provisioned block devices to
> > allocate space for the given range of sectors via REQ_OP_PROVISION.
> >
> > The man pages for both fallocate(2) and posix_fallocate(3) describe
> > the default allocation mode as:
> >
> > ```
> > The default operation (i.e., mode is zero) of fallocate()
> > allocates the disk space within the range specified by offset and len.
> > ...
> > subsequent writes to bytes in the specified range are guaranteed
> > not to fail because of lack of disk space.
> > ```
> >
> > For thinly provisioned storage constructs (dm-thin, filesystems on sparse
> > files), the term 'disk space' is overloaded and can either mean the apparent
> > disk space in the filesystem/thin logical volume or the true disk
> > space that will be utilized on the underlying non-sparse allocation layer.
> >
> > The use of a separate mode allows us to cleanly disambiguate whether fallocate()
> > causes allocation only at the current layer (default mode) or whether it propagates
> > allocations to underlying layers (provision mode)
>
> Why is it important to make this distinction?  The outcome of fallocate
> is supposed to be that subsequent writes do not fail with ENOSPC.  In my
> (fs developer) mind, REQ_OP_PROVISION simply an extra step to be taken
> after allocating file blocks.
>
Some use cases still benefit from keeping the default mode - eg.
virtual machines running on massive storage pools that don't expect to
hit the storage limit anytime soon (like most cloud storage
providers). Essentially, if the 'no ENOSPC' guarantee is maintained
via other means, then REQ_OP_PROVISION adds latency that isn't needed
(and cloud storage providers don't need to set aside that extra space
that may or may not be used).

> If you *don't* add this API flag and simply bake the REQ_OP_PROVISION
> call into mode 0 fallocate, then the new functionality can be added (or
> even backported) to existing kernels and customers can use it
> immediately.  If you *do*, then you get to wait a few years for
> developers to add it to their codebases only after enough enterprise
> distros pick up a new kernel to make it worth their while.
>
> > for thinly provisioned filesystems/
> > block devices. For devices that do not support REQ_OP_PROVISION, both these
> > allocation modes will be equivalent. Given the performance cost of sending provision
> > requests to the underlying layers, keeping the default mode as-is allows users to
> > preserve existing behavior.
>
> How expensive is this expected to be?  Is this why you wanted a separate
> mode flag?
>
Yes, the exact latency will depend on the stacked block devices and
the fragmentation at the allocation layers.

I did a quick test for benchmarking fallocate() with an:
A) ext4 filesystem mounted with 'noprovision'
B) ext4 filesystem mounted with 'provision' on a dm-thin device.
C) ext4 filesystem mounted with 'provision' on a loop device with a
sparse backing file on the filesystem in (B).

I tested file sizes from 512M to 8G, time taken for fallocate() in (A)
remains expectedly flat at ~0.01-0.02s, but for (B), it scales from
0.03-0.4s and for (C) it scales from 0.04s-0.52s (I captured the exact
time distribution in the cover letter
https://marc.info/?l=linux-ext4&m=167230113520636&w=2)

+0.5s for a 8G fallocate doesn't sound a lot but I think fragmentation
and how the block device is layered can make this worse...

> --D
>
> > Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> > ---
> >  block/fops.c                | 15 +++++++++++----
> >  include/linux/falloc.h      |  3 ++-
> >  include/uapi/linux/falloc.h |  8 ++++++++
> >  3 files changed, 21 insertions(+), 5 deletions(-)
> >
> > diff --git a/block/fops.c b/block/fops.c
> > index 50d245e8c913..01bde561e1e2 100644
> > --- a/block/fops.c
> > +++ b/block/fops.c
> > @@ -598,7 +598,8 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
> >
> >  #define      BLKDEV_FALLOC_FL_SUPPORTED                                      \
> >               (FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |           \
> > -              FALLOC_FL_ZERO_RANGE | FALLOC_FL_NO_HIDE_STALE)
> > +              FALLOC_FL_ZERO_RANGE | FALLOC_FL_NO_HIDE_STALE |       \
> > +              FALLOC_FL_PROVISION)
> >
> >  static long blkdev_fallocate(struct file *file, int mode, loff_t start,
> >                            loff_t len)
> > @@ -634,9 +635,11 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
> >       filemap_invalidate_lock(inode->i_mapping);
> >
> >       /* Invalidate the page cache, including dirty pages. */
> > -     error = truncate_bdev_range(bdev, file->f_mode, start, end);
> > -     if (error)
> > -             goto fail;
> > +     if (mode != FALLOC_FL_PROVISION) {
> > +             error = truncate_bdev_range(bdev, file->f_mode, start, end);
> > +             if (error)
> > +                     goto fail;
> > +     }
> >
> >       switch (mode) {
> >       case FALLOC_FL_ZERO_RANGE:
> > @@ -654,6 +657,10 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
> >               error = blkdev_issue_discard(bdev, start >> SECTOR_SHIFT,
> >                                            len >> SECTOR_SHIFT, GFP_KERNEL);
> >               break;
> > +     case FALLOC_FL_PROVISION:
> > +             error = blkdev_issue_provision(bdev, start >> SECTOR_SHIFT,
> > +                                            len >> SECTOR_SHIFT, GFP_KERNEL);
> > +             break;
> >       default:
> >               error = -EOPNOTSUPP;
> >       }
> > diff --git a/include/linux/falloc.h b/include/linux/falloc.h
> > index f3f0b97b1675..b9a40a61a59b 100644
> > --- a/include/linux/falloc.h
> > +++ b/include/linux/falloc.h
> > @@ -30,7 +30,8 @@ struct space_resv {
> >                                        FALLOC_FL_COLLAPSE_RANGE |     \
> >                                        FALLOC_FL_ZERO_RANGE |         \
> >                                        FALLOC_FL_INSERT_RANGE |       \
> > -                                      FALLOC_FL_UNSHARE_RANGE)
> > +                                      FALLOC_FL_UNSHARE_RANGE |      \
> > +                                      FALLOC_FL_PROVISION)
> >
> >  /* on ia32 l_start is on a 32-bit boundary */
> >  #if defined(CONFIG_X86_64)
> > diff --git a/include/uapi/linux/falloc.h b/include/uapi/linux/falloc.h
> > index 51398fa57f6c..2d323d113eed 100644
> > --- a/include/uapi/linux/falloc.h
> > +++ b/include/uapi/linux/falloc.h
> > @@ -77,4 +77,12 @@
> >   */
> >  #define FALLOC_FL_UNSHARE_RANGE              0x40
> >
> > +/*
> > + * FALLOC_FL_PROVISION acts as a hint for thinly provisioned devices to allocate
> > + * blocks for the range/EOF.
> > + *
> > + * FALLOC_FL_PROVISION can only be used with allocate-mode fallocate.
> > + */
> > +#define FALLOC_FL_PROVISION          0x80
> > +
> >  #endif /* _UAPI_FALLOC_H_ */
> > --
> > 2.37.3
> >
