Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5F9B382041
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 May 2021 20:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbhEPSDV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 May 2021 14:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhEPSDV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 May 2021 14:03:21 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3443C061573;
        Sun, 16 May 2021 11:02:04 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id f75-20020a1c1f4e0000b0290171001e7329so2278629wmf.1;
        Sun, 16 May 2021 11:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v5QeMzC7egI7pjAS/w22YSUqGDibggEE9rbaYoIGpqU=;
        b=jJ13KUi89rkNTv5tEp/or85ah2IUrc70DM23VD2NFuKqNXgbGkxRibfZ1yAv3qhGz+
         he7zfD+uCJJZqQtGUv8Jlrs+c6G1WzUzpODftpLvaiEGqEJCD+2TCQJqlRAHWUsRMVIq
         ZdaQVjzjaWmXSNhnya5mX2xStw+rRNkB8dMy/68hO9shWxp4ICdobyQh1325TaIb5CTI
         pJxNJIqSUnBWUW5YL7z2UHv4dJpUdMhezplO4j3Sn03+rdASCUUdJlsqvrzTFw+IbWeJ
         CSmboMAyYaBs5LwZiggmQnaVhdr8a92HVxaa4IzHaxJss7T1K0dIGvLwR1IVXaP2IoDV
         UhEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v5QeMzC7egI7pjAS/w22YSUqGDibggEE9rbaYoIGpqU=;
        b=I3RkU3B60d8ynkLIyfJUDcv+GyF5hVnIGH91ICpWzmGxvbYZrNoPoD/rA9busi6TF9
         cTFEuOaggL6ENNi2dFH/pg3BenVMbxDzgaDwZkWKMoKFrWE500+X7PHvC6GLk7a8ZySW
         59o/uiS5IKzcvHZS76SGLmMG7ujpzng+FCtwRBOdn74n++Pj6CQj7k1pl8zudnwNexqj
         u/HJ9Rqyi5DzhQTH+KW/sT8hXg8XBByVDRCL0Dun9f2mzoxLjwNQvXVHt9o1V/n8Pbhu
         3RY1Ff8CgUJ/8tC62evoWTGYNjMeriRYWZm56AvE3P28zGOzrD6dRwyoFjBjN+Iu2H9s
         Bx6g==
X-Gm-Message-State: AOAM531ze9H+t8CMW4E0kTU2SKzoijepWH/qRJ62PqocqnSqo61AKPWk
        RF1txNBEuGnnYKW5psIsM3ylmh+E2DxGCxsRSoS2aXheO2o=
X-Google-Smtp-Source: ABdhPJy/YKSh7Ymq0zYxR42sFCU6UUWGDIoSiLs09paq3ntNO3TKKfvRjNNb8S60ZlbPFETzHSzEp2EIVBGwPdhpQBI=
X-Received: by 2002:a1c:a442:: with SMTP id n63mr12383114wme.25.1621188123406;
 Sun, 16 May 2021 11:02:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210512131545.495160-1-hch@lst.de> <20210512131545.495160-3-hch@lst.de>
In-Reply-To: <20210512131545.495160-3-hch@lst.de>
From:   Kanchan Joshi <joshiiitr@gmail.com>
Date:   Sun, 16 May 2021 23:31:35 +0530
Message-ID: <CA+1E3r+8HrUymD-4Q06drqi_qV_L40OjgPCsw6C_Y6Gn_3FVSg@mail.gmail.com>
Subject: Re: [PATCH 02/15] block: don't try to poll multi-bio I/Os in __blkdev_direct_IO
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Wunderlich, Mark" <mark.wunderlich@intel.com>,
        "Vasudevan, Anil" <anil.vasudevan@intel.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 12, 2021 at 6:50 PM Christoph Hellwig <hch@lst.de> wrote:
>
> If an iocb is split into multiple bios we can't poll for both.  So don't
> bother to even try to poll in that case.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/block_dev.c | 37 ++++++++++++++-----------------------
>  1 file changed, 14 insertions(+), 23 deletions(-)
>
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index b8abccd03e5d..0080a3b710b4 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -375,7 +375,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
>         struct blk_plug plug;
>         struct blkdev_dio *dio;
>         struct bio *bio;
> -       bool is_poll = (iocb->ki_flags & IOCB_HIPRI) != 0;
> +       bool is_poll = (iocb->ki_flags & IOCB_HIPRI), do_poll = false;
>         bool is_read = (iov_iter_rw(iter) == READ), is_sync;
>         loff_t pos = iocb->ki_pos;
>         blk_qc_t qc = BLK_QC_T_NONE;
> @@ -437,22 +437,9 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
>                 pos += bio->bi_iter.bi_size;
>
>                 nr_pages = bio_iov_vecs_to_alloc(iter, BIO_MAX_VECS);
> -               if (!nr_pages) {
> -                       bool polled = false;
> -
> -                       if (iocb->ki_flags & IOCB_HIPRI) {
> -                               bio_set_polled(bio, iocb);
> -                               polled = true;
> -                       }
> -
> -                       qc = submit_bio(bio);
> -
> -                       if (polled)
> -                               WRITE_ONCE(iocb->ki_cookie, qc);
> -                       break;
> -               }
> -
> -               if (!dio->multi_bio) {
> +               if (dio->multi_bio) {
> +                       atomic_inc(&dio->ref);
> +               } else if (nr_pages) {
>                         /*
>                          * AIO needs an extra reference to ensure the dio
>                          * structure which is embedded into the first bio
> @@ -462,11 +449,16 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
>                                 bio_get(bio);
>                         dio->multi_bio = true;
>                         atomic_set(&dio->ref, 2);
> -               } else {
> -                       atomic_inc(&dio->ref);
> +               } else if (is_poll) {
> +                       bio_set_polled(bio, iocb);
> +                       do_poll = true;
> +               }
> +               qc = submit_bio(bio);
> +               if (!nr_pages) {
> +                       if (do_poll)
> +                               WRITE_ONCE(iocb->ki_cookie, qc);
> +                       break;
>                 }
> -
> -               submit_bio(bio);
>                 bio = bio_alloc(GFP_KERNEL, nr_pages);
>         }

dio->ref update goes amiss here.
For multi-bio, if the original code sets it as N, this will set it as
N+1, causing endless-wait for the caller.

-- 
Kanchan
