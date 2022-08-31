Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204C45A7B72
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Aug 2022 12:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbiHaKiI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Aug 2022 06:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbiHaKh7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Aug 2022 06:37:59 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79087C32DC
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Aug 2022 03:37:51 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id og21so27490027ejc.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Aug 2022 03:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=4gYrLsowmI5GGuWghJMX58bQcBEnYZGfYoQ7YKZR6lk=;
        b=MG4erCNWjYHuSIEvvO741xtOx0OQLZr92W0tZx5zcIBAPX8bM6MALAcK3TActnS/CL
         onIOi9HOixErTpAkKfRcwfw9Iw6xjtu1vuufU5pwP3Eu8HphBTU/vxZRmM2vQsrnytBp
         v88VVo5ZXt/1O0WGeHz/QV+AY5566xeU1JoAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=4gYrLsowmI5GGuWghJMX58bQcBEnYZGfYoQ7YKZR6lk=;
        b=mkf9kG+Tu7ryoz85G3aUbsahqSBF5tgsDiBK/A16aduXuV+dlluT2Zvd3gl11O7oRr
         rrtXeiouwGhxv7yW9Xe+TSAlI2liC1wd9XgF2c8bxlcnIAFBFq45bu4QGJU00HkEqv9x
         VCWTalDK04vhAIcWe23A9+WUJfNOYI336fjznBdXIaTp1yzvMUOQbiGkU7ntRdWCxpRP
         jryF31ZBDvANsI+2m4DXJwAJJJbhPWN1RkUgmHG4gRocCWTgG4Vv8hAEbmScPXlp3VoI
         FxWthkPL2VxaJ2iR8eU0pTeRrYDfnxkY3JwM4OwRrE1NDkXloIL6vGJtTz4G+tTiz0MT
         LSzA==
X-Gm-Message-State: ACgBeo3kXQZ3y3NMqfMpNFLmI2mrFzOslYvB+OQ7ClLH1+RwnGvMfw11
        39de3LQyaIvuzgMEzMuX+y5EGbiwRa+8qcT7Avj+LRd9cu68oA==
X-Google-Smtp-Source: AA6agR7DfkXT6qMIySIpM4SIr/GNRsiXgpnVMta7acmws5dJJtJteiwRbajkuBZzOw4S3rQpjWNqEBu6Ojdoat2ykNY=
X-Received: by 2002:a17:906:8a4e:b0:740:2450:d69a with SMTP id
 gx14-20020a1709068a4e00b007402450d69amr15687098ejc.523.1661942269622; Wed, 31
 Aug 2022 03:37:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220831041843.973026-1-jhubbard@nvidia.com> <20220831041843.973026-8-jhubbard@nvidia.com>
In-Reply-To: <20220831041843.973026-8-jhubbard@nvidia.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 31 Aug 2022 12:37:38 +0200
Message-ID: <CAJfpegvdTqdk9rs-yaEp1aqav4=t9qSpQri7gW8zzb+t7+_88A@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] fuse: convert direct IO paths to use FOLL_PIN
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, Jan Kara <jack@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 31 Aug 2022 at 06:19, John Hubbard <jhubbard@nvidia.com> wrote:
>
> Convert the fuse filesystem to use pin_user_pages_fast() and
> unpin_user_page(), instead of get_user_pages_fast() and put_page().
>
> The user of pin_user_pages_fast() depends upon:
>
> 1) CONFIG_BLK_USE_PIN_USER_PAGES_FOR_DIO, and
>
> 2) User-space-backed pages or ITER_BVEC pages.
>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  fs/fuse/dev.c    | 11 +++++++++--
>  fs/fuse/file.c   | 32 +++++++++++++++++++++-----------
>  fs/fuse/fuse_i.h |  1 +
>  3 files changed, 31 insertions(+), 13 deletions(-)
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 51897427a534..5de98a7a45b1 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -675,7 +675,12 @@ static void fuse_copy_finish(struct fuse_copy_state *cs)
>                         flush_dcache_page(cs->pg);
>                         set_page_dirty_lock(cs->pg);
>                 }
> -               put_page(cs->pg);
> +               if (!cs->pipebufs &&
> +                   (user_backed_iter(cs->iter) || iov_iter_is_bvec(cs->iter)))
> +                       dio_w_unpin_user_page(cs->pg);
> +
> +               else
> +                       put_page(cs->pg);

Why not move the logic into a helper and pass a "bool pinned" argument?

>         }
>         cs->pg = NULL;
>  }
> @@ -730,7 +735,9 @@ static int fuse_copy_fill(struct fuse_copy_state *cs)
>                 }
>         } else {
>                 size_t off;
> -               err = iov_iter_get_pages2(cs->iter, &page, PAGE_SIZE, 1, &off);
> +
> +               err = dio_w_iov_iter_pin_pages(cs->iter, &page, PAGE_SIZE, 1,
> +                                              &off);
>                 if (err < 0)
>                         return err;
>                 BUG_ON(!err);
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 1a3afd469e3a..01da38928d0b 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -625,14 +625,19 @@ void fuse_read_args_fill(struct fuse_io_args *ia, struct file *file, loff_t pos,
>  }
>
>  static void fuse_release_user_pages(struct fuse_args_pages *ap,
> -                                   bool should_dirty)
> +                                   bool should_dirty, bool is_user_or_bvec)
>  {
>         unsigned int i;
>
> -       for (i = 0; i < ap->num_pages; i++) {
> -               if (should_dirty)
> -                       set_page_dirty_lock(ap->pages[i]);
> -               put_page(ap->pages[i]);
> +       if (is_user_or_bvec) {
> +               dio_w_unpin_user_pages_dirty_lock(ap->pages, ap->num_pages,
> +                                                 should_dirty);
> +       } else {
> +               for (i = 0; i < ap->num_pages; i++) {
> +                       if (should_dirty)
> +                               set_page_dirty_lock(ap->pages[i]);
> +                       put_page(ap->pages[i]);
> +               }

Same here.

>         }
>  }
>
> @@ -733,7 +738,7 @@ static void fuse_aio_complete_req(struct fuse_mount *fm, struct fuse_args *args,
>         struct fuse_io_priv *io = ia->io;
>         ssize_t pos = -1;
>
> -       fuse_release_user_pages(&ia->ap, io->should_dirty);
> +       fuse_release_user_pages(&ia->ap, io->should_dirty, io->is_user_or_bvec);
>
>         if (err) {
>                 /* Nothing */
> @@ -1414,10 +1419,10 @@ static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_iter *ii,
>         while (nbytes < *nbytesp && ap->num_pages < max_pages) {
>                 unsigned npages;
>                 size_t start;
> -               ret = iov_iter_get_pages2(ii, &ap->pages[ap->num_pages],
> -                                       *nbytesp - nbytes,
> -                                       max_pages - ap->num_pages,
> -                                       &start);
> +               ret = dio_w_iov_iter_pin_pages(ii, &ap->pages[ap->num_pages],
> +                                              *nbytesp - nbytes,
> +                                              max_pages - ap->num_pages,
> +                                              &start);
>                 if (ret < 0)
>                         break;
>
> @@ -1483,6 +1488,10 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
>                 fl_owner_t owner = current->files;
>                 size_t nbytes = min(count, nmax);
>
> +               /* For use in fuse_release_user_pages(): */
> +               io->is_user_or_bvec = user_backed_iter(iter) ||
> +                                     iov_iter_is_bvec(iter);
> +

How about io->is_pinned?  And a iov_iter_is_pinned() helper?

Thanks,
Miklos
