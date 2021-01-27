Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A980305489
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jan 2021 08:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233928AbhA0HZF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jan 2021 02:25:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:48468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233822AbhA0HWz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jan 2021 02:22:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6F3FC2074F;
        Wed, 27 Jan 2021 07:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611732134;
        bh=UmXZ4WGct5TD5g2zWBqeUZIY7+IEh1H1mojHQndD4p0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oDBiPqUDddARVPP8esIP80QkXjEj9+85T5QDZeh7nu2cYyt+eQZA8QDXikjpMwlat
         MNfPUAT8hEpYvyQzrx6AP5DR+ANmDLKNYdk+3I1Le4ClABg804A6YrqVAha+HDnXt3
         aXXje54ZXGe396yLREjvTO7F28tQlsy1EwE9vIS6460xIuuh3AzToqKFH1MkXqxaCP
         /NJx/3JofqwPazejWSqyqiZGHT+4SBSDqNllnI/Q9rYdu+otPvNjz6i73xOtGWI2Ql
         1f8AcHX5BqzHDL4QaB+j75p6mcXxGRjds0fAREsI+L/1LEC6UF0JYg2RbF8i9aAb9k
         jpAFtWZcqE2ig==
Received: by mail-lf1-f44.google.com with SMTP id m22so1260324lfg.5;
        Tue, 26 Jan 2021 23:22:14 -0800 (PST)
X-Gm-Message-State: AOAM5303XuknvkR3/10+dIV7QrBQc2plCURRi7nKrpFEWPMcqPAmjyaC
        WD/vu16cWM6W4HQFjxBvgfpHjbV7YZ7NAQJ19hQ=
X-Google-Smtp-Source: ABdhPJxflUggj8S5jQsQ3WpKvrE0C44XGXqHsiBc4rX5F3+Z0c1NJpDcJfbjDkFKR5D14faCz9LusUBrixofxv3V23Y=
X-Received: by 2002:a05:6512:5c6:: with SMTP id o6mr4374679lfo.281.1611732132634;
 Tue, 26 Jan 2021 23:22:12 -0800 (PST)
MIME-Version: 1.0
References: <20210126145247.1964410-1-hch@lst.de> <20210126145247.1964410-13-hch@lst.de>
In-Reply-To: <20210126145247.1964410-13-hch@lst.de>
From:   Song Liu <song@kernel.org>
Date:   Tue, 26 Jan 2021 23:22:01 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6sVtB-baGn46_o6NVynuxQfy9_FuhC2ZK0cKu5cQHWDg@mail.gmail.com>
Message-ID: <CAPhsuW6sVtB-baGn46_o6NVynuxQfy9_FuhC2ZK0cKu5cQHWDg@mail.gmail.com>
Subject: Re: [PATCH 12/17] md: simplify sync_page_io
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <chao@kernel.org>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        linux-nilfs@vger.kernel.org, dm-devel@redhat.com,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-block@vger.kernel.org, drbd-dev@lists.linbit.com,
        linux-bcache@vger.kernel.org,
        linux-raid <linux-raid@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 26, 2021 at 7:14 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Use an on-stack bio and biovec for the single page synchronous I/O.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Song Liu <song@kernel.org>

> ---
>  drivers/md/md.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index e2b9dbb6e888f6..6a27f52007c871 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -1021,29 +1021,29 @@ int md_super_wait(struct mddev *mddev)
>  int sync_page_io(struct md_rdev *rdev, sector_t sector, int size,
>                  struct page *page, int op, int op_flags, bool metadata_op)
>  {
> -       struct bio *bio = md_bio_alloc_sync(rdev->mddev);
> -       int ret;
> +       struct bio bio;
> +       struct bio_vec bvec;
> +
> +       bio_init(&bio, &bvec, 1);
>
>         if (metadata_op && rdev->meta_bdev)
> -               bio_set_dev(bio, rdev->meta_bdev);
> +               bio_set_dev(&bio, rdev->meta_bdev);
>         else
> -               bio_set_dev(bio, rdev->bdev);
> -       bio_set_op_attrs(bio, op, op_flags);
> +               bio_set_dev(&bio, rdev->bdev);
> +       bio.bi_opf = op | op_flags;
>         if (metadata_op)
> -               bio->bi_iter.bi_sector = sector + rdev->sb_start;
> +               bio.bi_iter.bi_sector = sector + rdev->sb_start;
>         else if (rdev->mddev->reshape_position != MaxSector &&
>                  (rdev->mddev->reshape_backwards ==
>                   (sector >= rdev->mddev->reshape_position)))
> -               bio->bi_iter.bi_sector = sector + rdev->new_data_offset;
> +               bio.bi_iter.bi_sector = sector + rdev->new_data_offset;
>         else
> -               bio->bi_iter.bi_sector = sector + rdev->data_offset;
> -       bio_add_page(bio, page, size, 0);
> +               bio.bi_iter.bi_sector = sector + rdev->data_offset;
> +       bio_add_page(&bio, page, size, 0);
>
> -       submit_bio_wait(bio);
> +       submit_bio_wait(&bio);
>
> -       ret = !bio->bi_status;
> -       bio_put(bio);
> -       return ret;
> +       return !bio.bi_status;
>  }
>  EXPORT_SYMBOL_GPL(sync_page_io);
>
> --
> 2.29.2
>
