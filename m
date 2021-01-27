Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5F330545B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jan 2021 08:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbhA0HTo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jan 2021 02:19:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:47124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233498AbhA0HQr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jan 2021 02:16:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A14A22073A;
        Wed, 27 Jan 2021 07:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611731766;
        bh=roeH+S42no3Sboc4a7IJP429EgMi3Brd/syWUAT1emI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YwAkJqJB5KFzCdu4e+4xCNTp5SGGkGySjdzbItm+79z64FYD48iciemcPnv9Mlnh2
         fQe/1cHafViGhPE5p2SUGGk7l2Vhny6UH/75EGwWZ3nK0+HnxUNWUmWGRosC2xio9O
         dRi+UbUKyDXe8JCUdmtUZW0806oZFEhVUm2J2GGpN8AlBtCoUdYBvDoW9GI5hoFou2
         3xjIKrj9pkB94a6Kv5TBwDw6939ekhvFTRuKbb7P+RY+RabHAYJmGrLgripNRJJX3W
         Raf3XxHZrQEIZAvG4133epfOMyH9k3RvBZMOilB6mOoVuQkWm455KOkyOh/K8Y5DFv
         MHtESQFL6GhMA==
Received: by mail-lf1-f50.google.com with SMTP id f1so1249639lfu.3;
        Tue, 26 Jan 2021 23:16:05 -0800 (PST)
X-Gm-Message-State: AOAM530hTGoI/NZEUqRnpztQG0Cn43JQoq4V3v2LqhN1rQpHFale6zgN
        YHpuyXJcRDV06hRuJQEI2t3QbwUHSclvuTQlo4w=
X-Google-Smtp-Source: ABdhPJwFmb6CVFGHBWXlzQnS58PALEhepsv7f0h0Je/37NQinPkKDgqPDkTeBlpmndchuGkIHeS1z4Fyx1z/Fa+aNwE=
X-Received: by 2002:a05:6512:b1b:: with SMTP id w27mr4506047lfu.10.1611731763892;
 Tue, 26 Jan 2021 23:16:03 -0800 (PST)
MIME-Version: 1.0
References: <20210126145247.1964410-1-hch@lst.de> <20210126145247.1964410-15-hch@lst.de>
In-Reply-To: <20210126145247.1964410-15-hch@lst.de>
From:   Song Liu <song@kernel.org>
Date:   Tue, 26 Jan 2021 23:15:52 -0800
X-Gmail-Original-Message-ID: <CAPhsuW599kbe-YFX0FOOGJy30gy3V2_hMYW3jg3sK_VwaayEBQ@mail.gmail.com>
Message-ID: <CAPhsuW599kbe-YFX0FOOGJy30gy3V2_hMYW3jg3sK_VwaayEBQ@mail.gmail.com>
Subject: Re: [PATCH 14/17] md/raid6: refactor raid5_read_one_chunk
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

On Tue, Jan 26, 2021 at 7:19 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Refactor raid5_read_one_chunk so that all simple checks are done
> before allocating the bio.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Song Liu <song@kernel.org>

Thanks for the clean-up!


> ---
>  drivers/md/raid5.c | 108 +++++++++++++++++++--------------------------
>  1 file changed, 45 insertions(+), 63 deletions(-)
>
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index f411b9e5c332f4..a348b2adf2a9f9 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -5393,90 +5393,72 @@ static void raid5_align_endio(struct bio *bi)
>  static int raid5_read_one_chunk(struct mddev *mddev, struct bio *raid_bio)
>  {
>         struct r5conf *conf = mddev->private;
> -       int dd_idx;
> -       struct bio* align_bi;
> +       struct bio *align_bio;
>         struct md_rdev *rdev;
> -       sector_t end_sector;
> +       sector_t sector, end_sector, first_bad;
> +       int bad_sectors, dd_idx;
>
>         if (!in_chunk_boundary(mddev, raid_bio)) {
>                 pr_debug("%s: non aligned\n", __func__);
>                 return 0;
>         }
> -       /*
> -        * use bio_clone_fast to make a copy of the bio
> -        */
> -       align_bi = bio_clone_fast(raid_bio, GFP_NOIO, &mddev->bio_set);
> -       if (!align_bi)
> -               return 0;
> -       /*
> -        *   set bi_end_io to a new function, and set bi_private to the
> -        *     original bio.
> -        */
> -       align_bi->bi_end_io  = raid5_align_endio;
> -       align_bi->bi_private = raid_bio;
> -       /*
> -        *      compute position
> -        */
> -       align_bi->bi_iter.bi_sector =
> -               raid5_compute_sector(conf, raid_bio->bi_iter.bi_sector,
> -                                    0, &dd_idx, NULL);
>
> -       end_sector = bio_end_sector(align_bi);
> +       sector = raid5_compute_sector(conf, raid_bio->bi_iter.bi_sector, 0,
> +                                     &dd_idx, NULL);
> +       end_sector = bio_end_sector(raid_bio);
> +
>         rcu_read_lock();
> +       if (r5c_big_stripe_cached(conf, sector))
> +               goto out_rcu_unlock;
> +
>         rdev = rcu_dereference(conf->disks[dd_idx].replacement);
>         if (!rdev || test_bit(Faulty, &rdev->flags) ||
>             rdev->recovery_offset < end_sector) {
>                 rdev = rcu_dereference(conf->disks[dd_idx].rdev);
> -               if (rdev &&
> -                   (test_bit(Faulty, &rdev->flags) ||
> +               if (!rdev)
> +                       goto out_rcu_unlock;
> +               if (test_bit(Faulty, &rdev->flags) ||
>                     !(test_bit(In_sync, &rdev->flags) ||
> -                     rdev->recovery_offset >= end_sector)))
> -                       rdev = NULL;
> +                     rdev->recovery_offset >= end_sector))
> +                       goto out_rcu_unlock;
>         }
>
> -       if (r5c_big_stripe_cached(conf, align_bi->bi_iter.bi_sector)) {
> -               rcu_read_unlock();
> -               bio_put(align_bi);
> +       atomic_inc(&rdev->nr_pending);
> +       rcu_read_unlock();
> +
> +       align_bio = bio_clone_fast(raid_bio, GFP_NOIO, &mddev->bio_set);
> +       bio_set_dev(align_bio, rdev->bdev);
> +       align_bio->bi_end_io = raid5_align_endio;
> +       align_bio->bi_private = raid_bio;
> +       align_bio->bi_iter.bi_sector = sector;
> +
> +       raid_bio->bi_next = (void *)rdev;
> +
> +       if (is_badblock(rdev, sector, bio_sectors(align_bio), &first_bad,
> +                       &bad_sectors)) {
> +               bio_put(align_bio);
> +               rdev_dec_pending(rdev, mddev);
>                 return 0;
>         }
>
> -       if (rdev) {
> -               sector_t first_bad;
> -               int bad_sectors;
> -
> -               atomic_inc(&rdev->nr_pending);
> -               rcu_read_unlock();
> -               raid_bio->bi_next = (void*)rdev;
> -               bio_set_dev(align_bi, rdev->bdev);
> -
> -               if (is_badblock(rdev, align_bi->bi_iter.bi_sector,
> -                               bio_sectors(align_bi),
> -                               &first_bad, &bad_sectors)) {
> -                       bio_put(align_bi);
> -                       rdev_dec_pending(rdev, mddev);
> -                       return 0;
> -               }
> +       /* No reshape active, so we can trust rdev->data_offset */
> +       align_bio->bi_iter.bi_sector += rdev->data_offset;
>
> -               /* No reshape active, so we can trust rdev->data_offset */
> -               align_bi->bi_iter.bi_sector += rdev->data_offset;
> +       spin_lock_irq(&conf->device_lock);
> +       wait_event_lock_irq(conf->wait_for_quiescent, conf->quiesce == 0,
> +                           conf->device_lock);
> +       atomic_inc(&conf->active_aligned_reads);
> +       spin_unlock_irq(&conf->device_lock);
>
> -               spin_lock_irq(&conf->device_lock);
> -               wait_event_lock_irq(conf->wait_for_quiescent,
> -                                   conf->quiesce == 0,
> -                                   conf->device_lock);
> -               atomic_inc(&conf->active_aligned_reads);
> -               spin_unlock_irq(&conf->device_lock);
> +       if (mddev->gendisk)
> +               trace_block_bio_remap(align_bio, disk_devt(mddev->gendisk),
> +                                     raid_bio->bi_iter.bi_sector);
> +       submit_bio_noacct(align_bio);
> +       return 1;
>
> -               if (mddev->gendisk)
> -                       trace_block_bio_remap(align_bi, disk_devt(mddev->gendisk),
> -                                             raid_bio->bi_iter.bi_sector);
> -               submit_bio_noacct(align_bi);
> -               return 1;
> -       } else {
> -               rcu_read_unlock();
> -               bio_put(align_bi);
> -               return 0;
> -       }
> +out_rcu_unlock:
> +       rcu_read_unlock();
> +       return 0;
>  }
>
>  static struct bio *chunk_aligned_read(struct mddev *mddev, struct bio *raid_bio)
> --
> 2.29.2
>
