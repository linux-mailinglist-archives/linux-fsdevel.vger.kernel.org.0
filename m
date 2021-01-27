Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A23DB305485
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jan 2021 08:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233913AbhA0HYm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jan 2021 02:24:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:48200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233559AbhA0HWJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jan 2021 02:22:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F0B662073C;
        Wed, 27 Jan 2021 07:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611732089;
        bh=PHGvgPZS9fmzb8WwHWTDSJ0PUf4j0hQIB49cA17Ux8M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aOcLULEJAETe0ZlQOMFoWv+xV+961UgFHoRNBzUMPi/oFzrgBLf6fpFTjN/IS05QO
         zYzdqWHKfbJrw60OF8NQxrmzPpTarFG5BYYhXfdM82s2hq4GFbvrBTg0+/gc9t50It
         YL3Oe/Z9JLGMVM5I+aLWcGsKrktoXC5hMjaVZsxS33HhjLk4OG2Duzg5eJzML2qsTX
         SvIigcKxB7d/BjQsPegVpK8LEUO0LIj3aQP1HkoGMEQsssBIbzs2Nv5jASFVBV6Rrv
         RhIZkevlJdJVxgQR3wvBJsdnYdlgcaGm25mcIExHcY0pbsKd4dATwjIkTayV/aOI2P
         9V2GznHJHrLLQ==
Received: by mail-lf1-f41.google.com with SMTP id a12so1275057lfb.1;
        Tue, 26 Jan 2021 23:21:28 -0800 (PST)
X-Gm-Message-State: AOAM532kN5kIFTnSDDNffFt8U5V1HRe1h0MbN/HVgBV6qoV0xLZPxmxN
        KmYwyOR4aAKVBpIVpB1CDNP8EMhivxYSCxNfDYg=
X-Google-Smtp-Source: ABdhPJxzU6eEXjGgMsXjIbLicQlntxxKhHAHPBju5x4svSgsvP73GNvKL+gYo0RpjmVTLgHo2j69VOR6hw/D9eon+xA=
X-Received: by 2002:a05:6512:b1b:: with SMTP id w27mr4516614lfu.10.1611732087108;
 Tue, 26 Jan 2021 23:21:27 -0800 (PST)
MIME-Version: 1.0
References: <20210126145247.1964410-1-hch@lst.de> <20210126145247.1964410-12-hch@lst.de>
In-Reply-To: <20210126145247.1964410-12-hch@lst.de>
From:   Song Liu <song@kernel.org>
Date:   Tue, 26 Jan 2021 23:21:16 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4SRXoOjfU5GHoOGfONjb1yMT7HEyHLZb4E4vNARF44jw@mail.gmail.com>
Message-ID: <CAPhsuW4SRXoOjfU5GHoOGfONjb1yMT7HEyHLZb4E4vNARF44jw@mail.gmail.com>
Subject: Re: [PATCH 11/17] md: remove bio_alloc_mddev
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

On Tue, Jan 26, 2021 at 7:12 AM Christoph Hellwig <hch@lst.de> wrote:
>
> bio_alloc_mddev is never called with a NULL mddev, and ->bio_set is
> initialized in md_run, so it always must be initialized as well.  Just
> open code the remaining call to bio_alloc_bioset.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Song Liu <song@kernel.org>

> ---
>  drivers/md/md.c     | 12 +-----------
>  drivers/md/md.h     |  2 --
>  drivers/md/raid1.c  |  2 +-
>  drivers/md/raid10.c |  2 +-
>  4 files changed, 3 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 7d1bb24add3107..e2b9dbb6e888f6 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -340,16 +340,6 @@ static int start_readonly;
>   */
>  static bool create_on_open = true;
>
> -struct bio *bio_alloc_mddev(gfp_t gfp_mask, int nr_iovecs,
> -                           struct mddev *mddev)
> -{
> -       if (!mddev || !bioset_initialized(&mddev->bio_set))
> -               return bio_alloc(gfp_mask, nr_iovecs);
> -
> -       return bio_alloc_bioset(gfp_mask, nr_iovecs, &mddev->bio_set);
> -}
> -EXPORT_SYMBOL_GPL(bio_alloc_mddev);
> -
>  static struct bio *md_bio_alloc_sync(struct mddev *mddev)
>  {
>         if (!mddev || !bioset_initialized(&mddev->sync_set))
> @@ -613,7 +603,7 @@ static void submit_flushes(struct work_struct *ws)
>                         atomic_inc(&rdev->nr_pending);
>                         atomic_inc(&rdev->nr_pending);
>                         rcu_read_unlock();
> -                       bi = bio_alloc_mddev(GFP_NOIO, 0, mddev);
> +                       bi = bio_alloc_bioset(GFP_NOIO, 0, &mddev->bio_set);
>                         bi->bi_end_io = md_end_flush;
>                         bi->bi_private = rdev;
>                         bio_set_dev(bi, rdev->bdev);
> diff --git a/drivers/md/md.h b/drivers/md/md.h
> index f13290ccc1c248..bcbba1b5ec4a71 100644
> --- a/drivers/md/md.h
> +++ b/drivers/md/md.h
> @@ -742,8 +742,6 @@ extern void md_rdev_clear(struct md_rdev *rdev);
>  extern void md_handle_request(struct mddev *mddev, struct bio *bio);
>  extern void mddev_suspend(struct mddev *mddev);
>  extern void mddev_resume(struct mddev *mddev);
> -extern struct bio *bio_alloc_mddev(gfp_t gfp_mask, int nr_iovecs,
> -                                  struct mddev *mddev);
>
>  extern void md_reload_sb(struct mddev *mddev, int raid_disk);
>  extern void md_update_sb(struct mddev *mddev, int force);
> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> index 3b19141cdb4bc2..d2378765dc154f 100644
> --- a/drivers/md/raid1.c
> +++ b/drivers/md/raid1.c
> @@ -1104,7 +1104,7 @@ static void alloc_behind_master_bio(struct r1bio *r1_bio,
>         int i = 0;
>         struct bio *behind_bio = NULL;
>
> -       behind_bio = bio_alloc_mddev(GFP_NOIO, vcnt, r1_bio->mddev);
> +       behind_bio = bio_alloc_bioset(GFP_NOIO, vcnt, &r1_bio->mddev->bio_set);
>         if (!behind_bio)
>                 return;
>
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index be8f14afb6d143..e1eefbec15d444 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -4531,7 +4531,7 @@ static sector_t reshape_request(struct mddev *mddev, sector_t sector_nr,
>                 return sectors_done;
>         }
>
> -       read_bio = bio_alloc_mddev(GFP_KERNEL, RESYNC_PAGES, mddev);
> +       read_bio = bio_alloc_bioset(GFP_KERNEL, RESYNC_PAGES, &mddev->bio_set);
>
>         bio_set_dev(read_bio, rdev->bdev);
>         read_bio->bi_iter.bi_sector = (r10_bio->devs[r10_bio->read_slot].addr
> --
> 2.29.2
>
