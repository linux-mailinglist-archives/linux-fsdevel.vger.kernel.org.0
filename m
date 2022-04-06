Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF4A4F5F07
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 15:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbiDFNTO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 09:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234051AbiDFNSa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:18:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4DE3749B944
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Apr 2022 02:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649239021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5YLfltNsQX6JNVdcfXs5JgFiHm7bLb/2vI3xBdu4ui8=;
        b=SfCuzpki0XfdlmT4L0OYUU2FHpnVZ1yslTDGpJL0IyrcQ7u36EWFX5xcNcAkFyh6zLDnYC
        SlulK++OMQcKBYo+rtaxrZ0JbOKh62iNqAnXuqubfPBVOlZ90+Rn2RnNRkl9A2UlQlxy1N
        zA2i5p6R/6oFqO/jCQbu1CXBMmxaGhw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-329-YGAyHnNeM_2UbJlmNCxqzA-1; Wed, 06 Apr 2022 05:53:49 -0400
X-MC-Unique: YGAyHnNeM_2UbJlmNCxqzA-1
Received: by mail-wm1-f71.google.com with SMTP id t124-20020a1c4682000000b0038c8e8f8212so554167wma.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Apr 2022 02:53:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5YLfltNsQX6JNVdcfXs5JgFiHm7bLb/2vI3xBdu4ui8=;
        b=Z4MKh05ZAqiDEJZMHZNYE8O2yHycWZ97EER2SEuiZwxaIWxvSLrUskqvGr4aqCfviS
         Vfqf5KIK96xfsEH2OHYC7YbuVDixJBuHwsM1juFmP5ZwEqN4IfBoPmqCRRU0Wu9YSKKK
         7MHv+EQtfALPS1JJyIO7FYhBDnFxg1QauPIMVT7wYVKTq/Ai54Ekf3tKell3s7LDa+d4
         XQ5qtAizMM04NrzBY+GBI4nZm4GhHh9n+45S3R+MewlsiFvulMNYicQKQy7u0ULI3iWD
         wqRmz/f6H8OCWRAC2+JZpDfjYyHkhQmLwi2Gc/NOQJVrvWznXS2wE9Pg/RSqygSiQbMD
         s2Jg==
X-Gm-Message-State: AOAM5310boQiZn5T3dHJ5QhrxyAMGFL72cmJ7a6jZnicJa3K4sXv+x6u
        DuAApK/7/fluVc6KzYkhiE8ki5RDXzU2OCKMUEsHmWUSFlyg3bMabniWWkYZTcE5eSryQcTGFHD
        58BZYTCtYyPtrTkdAb9Y+Au+PBgeqP9lBtv3RuZMZsQ==
X-Received: by 2002:a05:6000:168e:b0:204:f92:53e9 with SMTP id y14-20020a056000168e00b002040f9253e9mr6147833wrd.349.1649238827479;
        Wed, 06 Apr 2022 02:53:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx42UTKiXkjFd7vBE49MzUEoFIKgzGGnrD3yn13Cn5diYp72Y7jfRYqMuzHs0kGH57x/uOLoIWIGJtse90Yx4g=
X-Received: by 2002:a05:6000:168e:b0:204:f92:53e9 with SMTP id
 y14-20020a056000168e00b002040f9253e9mr6147779wrd.349.1649238826610; Wed, 06
 Apr 2022 02:53:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220406060516.409838-1-hch@lst.de> <20220406060516.409838-24-hch@lst.de>
In-Reply-To: <20220406060516.409838-24-hch@lst.de>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Wed, 6 Apr 2022 11:53:35 +0200
Message-ID: <CAHc6FU7oZ5HW+JYLp9SxEnE5_i=nZCgBYfWLQk9RR+9M151D4w@mail.gmail.com>
Subject: Re: [Cluster-devel] [PATCH 23/27] block: add a bdev_max_discard_sectors
 helper
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, jfs-discussion@lists.sourceforge.net,
        linux-nvme@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        Linux-MM <linux-mm@kvack.org>, dm-devel@redhat.com,
        target-devel@vger.kernel.org, linux-mtd@lists.infradead.org,
        drbd-dev@lists.linbit.com, linux-s390 <linux-s390@vger.kernel.org>,
        linux-nilfs@vger.kernel.org, linux-scsi@vger.kernel.org,
        cluster-devel <cluster-devel@redhat.com>,
        xen-devel@lists.xenproject.org,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-um@lists.infradead.org, nbd@other.debian.org,
        linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
        Ceph Development <ceph-devel@vger.kernel.org>,
        linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        ocfs2-devel@oss.oracle.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        ntfs3@lists.linux.dev, linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 6, 2022 at 8:07 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Add a helper to query the number of sectors support per each discard bio
> based on the block device and use this helper to stop various places from
> poking into the request_queue to see if discard is supported and if so how
> much.  This mirrors what is done e.g. for write zeroes as well.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-core.c                    |  2 +-
>  block/blk-lib.c                     |  2 +-
>  block/ioctl.c                       |  3 +--
>  drivers/block/drbd/drbd_main.c      |  2 +-
>  drivers/block/drbd/drbd_nl.c        | 12 +++++++-----
>  drivers/block/drbd/drbd_receiver.c  |  5 ++---
>  drivers/block/loop.c                |  9 +++------
>  drivers/block/rnbd/rnbd-srv-dev.h   |  6 +-----
>  drivers/block/xen-blkback/xenbus.c  |  2 +-
>  drivers/md/bcache/request.c         |  4 ++--
>  drivers/md/bcache/super.c           |  2 +-
>  drivers/md/bcache/sysfs.c           |  2 +-
>  drivers/md/dm-cache-target.c        |  9 +--------
>  drivers/md/dm-clone-target.c        |  9 +--------
>  drivers/md/dm-io.c                  |  2 +-
>  drivers/md/dm-log-writes.c          |  3 +--
>  drivers/md/dm-raid.c                |  9 ++-------
>  drivers/md/dm-table.c               |  4 +---
>  drivers/md/dm-thin.c                |  9 +--------
>  drivers/md/dm.c                     |  2 +-
>  drivers/md/md-linear.c              |  4 ++--
>  drivers/md/raid0.c                  |  2 +-
>  drivers/md/raid1.c                  |  6 +++---
>  drivers/md/raid10.c                 |  8 ++++----
>  drivers/md/raid5-cache.c            |  2 +-
>  drivers/target/target_core_device.c |  8 +++-----
>  fs/btrfs/extent-tree.c              |  4 ++--
>  fs/btrfs/ioctl.c                    |  2 +-
>  fs/exfat/file.c                     |  2 +-
>  fs/exfat/super.c                    | 10 +++-------
>  fs/ext4/ioctl.c                     | 10 +++-------
>  fs/ext4/super.c                     | 10 +++-------
>  fs/f2fs/f2fs.h                      |  3 +--
>  fs/f2fs/segment.c                   |  6 ++----
>  fs/fat/file.c                       |  2 +-
>  fs/fat/inode.c                      | 10 +++-------
>  fs/gfs2/rgrp.c                      |  2 +-
>  fs/jbd2/journal.c                   |  7 ++-----
>  fs/jfs/ioctl.c                      |  2 +-
>  fs/jfs/super.c                      |  8 ++------
>  fs/nilfs2/ioctl.c                   |  2 +-
>  fs/ntfs3/file.c                     |  2 +-
>  fs/ntfs3/super.c                    |  2 +-
>  fs/ocfs2/ioctl.c                    |  2 +-
>  fs/xfs/xfs_discard.c                |  2 +-
>  fs/xfs/xfs_super.c                  | 12 ++++--------
>  include/linux/blkdev.h              |  5 +++++
>  mm/swapfile.c                       | 17 ++---------------
>  48 files changed, 87 insertions(+), 163 deletions(-)
>
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 937bb6b863317..b5c3a8049134c 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -820,7 +820,7 @@ void submit_bio_noacct(struct bio *bio)
>
>         switch (bio_op(bio)) {
>         case REQ_OP_DISCARD:
> -               if (!blk_queue_discard(q))
> +               if (!bdev_max_discard_sectors(bdev))
>                         goto not_supported;
>                 break;
>         case REQ_OP_SECURE_ERASE:
> diff --git a/block/blk-lib.c b/block/blk-lib.c
> index 2ae32a722851c..8b4b66d3a9bfc 100644
> --- a/block/blk-lib.c
> +++ b/block/blk-lib.c
> @@ -53,7 +53,7 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
>                         return -EOPNOTSUPP;
>                 op = REQ_OP_SECURE_ERASE;
>         } else {
> -               if (!blk_queue_discard(q))
> +               if (!bdev_max_discard_sectors(bdev))
>                         return -EOPNOTSUPP;
>                 op = REQ_OP_DISCARD;
>         }
> diff --git a/block/ioctl.c b/block/ioctl.c
> index ad3771b268b81..c2cd3ba5290ce 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -87,14 +87,13 @@ static int blk_ioctl_discard(struct block_device *bdev, fmode_t mode,
>  {
>         uint64_t range[2];
>         uint64_t start, len;
> -       struct request_queue *q = bdev_get_queue(bdev);
>         struct inode *inode = bdev->bd_inode;
>         int err;
>
>         if (!(mode & FMODE_WRITE))
>                 return -EBADF;
>
> -       if (!blk_queue_discard(q))
> +       if (!bdev_max_discard_sectors(bdev))
>                 return -EOPNOTSUPP;
>
>         if (copy_from_user(range, (void __user *)arg, sizeof(range)))
> diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
> index 9d43aadde19ad..8fd89a1b0b7b3 100644
> --- a/drivers/block/drbd/drbd_main.c
> +++ b/drivers/block/drbd/drbd_main.c
> @@ -942,7 +942,7 @@ int drbd_send_sizes(struct drbd_peer_device *peer_device, int trigger_reply, enu
>                         cpu_to_be32(bdev_alignment_offset(bdev));
>                 p->qlim->io_min = cpu_to_be32(bdev_io_min(bdev));
>                 p->qlim->io_opt = cpu_to_be32(bdev_io_opt(bdev));
> -               p->qlim->discard_enabled = blk_queue_discard(q);
> +               p->qlim->discard_enabled = !!bdev_max_discard_sectors(bdev);
>                 p->qlim->write_same_capable = 0;
>                 put_ldev(device);
>         } else {
> diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
> index 40bb0b356a6d6..8e28e0a8e5e41 100644
> --- a/drivers/block/drbd/drbd_nl.c
> +++ b/drivers/block/drbd/drbd_nl.c
> @@ -1210,7 +1210,7 @@ static void decide_on_discard_support(struct drbd_device *device,
>                 first_peer_device(device)->connection;
>         struct request_queue *q = device->rq_queue;
>
> -       if (bdev && !blk_queue_discard(bdev->backing_bdev->bd_disk->queue))
> +       if (bdev && !bdev_max_discard_sectors(bdev->backing_bdev))
>                 goto not_supported;
>
>         if (connection->cstate >= C_CONNECTED &&
> @@ -1439,14 +1439,15 @@ static bool write_ordering_changed(struct disk_conf *a, struct disk_conf *b)
>  static void sanitize_disk_conf(struct drbd_device *device, struct disk_conf *disk_conf,
>                                struct drbd_backing_dev *nbc)
>  {
> -       struct request_queue * const q = nbc->backing_bdev->bd_disk->queue;
> +       struct block_device *bdev = nbc->backing_bdev;
> +       struct request_queue *q = bdev->bd_disk->queue;
>
>         if (disk_conf->al_extents < DRBD_AL_EXTENTS_MIN)
>                 disk_conf->al_extents = DRBD_AL_EXTENTS_MIN;
>         if (disk_conf->al_extents > drbd_al_extents_max(nbc))
>                 disk_conf->al_extents = drbd_al_extents_max(nbc);
>
> -       if (!blk_queue_discard(q)) {
> +       if (!bdev_max_discard_sectors(bdev)) {
>                 if (disk_conf->rs_discard_granularity) {
>                         disk_conf->rs_discard_granularity = 0; /* disable feature */
>                         drbd_info(device, "rs_discard_granularity feature disabled\n");
> @@ -1455,6 +1456,7 @@ static void sanitize_disk_conf(struct drbd_device *device, struct disk_conf *dis
>
>         if (disk_conf->rs_discard_granularity) {
>                 int orig_value = disk_conf->rs_discard_granularity;
> +               sector_t discard_size = bdev_max_discard_sectors(bdev) << 9;
>                 int remainder;
>
>                 if (q->limits.discard_granularity > disk_conf->rs_discard_granularity)
> @@ -1463,8 +1465,8 @@ static void sanitize_disk_conf(struct drbd_device *device, struct disk_conf *dis
>                 remainder = disk_conf->rs_discard_granularity % q->limits.discard_granularity;
>                 disk_conf->rs_discard_granularity += remainder;
>
> -               if (disk_conf->rs_discard_granularity > q->limits.max_discard_sectors << 9)
> -                       disk_conf->rs_discard_granularity = q->limits.max_discard_sectors << 9;
> +               if (disk_conf->rs_discard_granularity > discard_size)
> +                       disk_conf->rs_discard_granularity = discard_size;
>
>                 if (disk_conf->rs_discard_granularity != orig_value)
>                         drbd_info(device, "rs_discard_granularity changed to %d\n",
> diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
> index 08da922f81d1d..8a4a47da56fe9 100644
> --- a/drivers/block/drbd/drbd_receiver.c
> +++ b/drivers/block/drbd/drbd_receiver.c
> @@ -1524,7 +1524,7 @@ int drbd_issue_discard_or_zero_out(struct drbd_device *device, sector_t start, u
>         granularity = max(q->limits.discard_granularity >> 9, 1U);
>         alignment = (bdev_discard_alignment(bdev) >> 9) % granularity;
>
> -       max_discard_sectors = min(q->limits.max_discard_sectors, (1U << 22));
> +       max_discard_sectors = min(bdev_max_discard_sectors(bdev), (1U << 22));
>         max_discard_sectors -= max_discard_sectors % granularity;
>         if (unlikely(!max_discard_sectors))
>                 goto zero_out;
> @@ -1575,11 +1575,10 @@ int drbd_issue_discard_or_zero_out(struct drbd_device *device, sector_t start, u
>
>  static bool can_do_reliable_discards(struct drbd_device *device)
>  {
> -       struct request_queue *q = bdev_get_queue(device->ldev->backing_bdev);
>         struct disk_conf *dc;
>         bool can_do;
>
> -       if (!blk_queue_discard(q))
> +       if (!bdev_max_discard_sectors(device->ldev->backing_bdev))
>                 return false;
>
>         rcu_read_lock();
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 8d800d46e4985..4b919b75205a7 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -314,15 +314,12 @@ static int lo_fallocate(struct loop_device *lo, struct request *rq, loff_t pos,
>
>         mode |= FALLOC_FL_KEEP_SIZE;
>
> -       if (!blk_queue_discard(lo->lo_queue)) {
> -               ret = -EOPNOTSUPP;
> -               goto out;
> -       }
> +       if (!bdev_max_discard_sectors(lo->lo_device))
> +               return -EOPNOTSUPP;
>
>         ret = file->f_op->fallocate(file, mode, pos, blk_rq_bytes(rq));
>         if (unlikely(ret && ret != -EINVAL && ret != -EOPNOTSUPP))
> -               ret = -EIO;
> - out:
> +               return -EIO;
>         return ret;
>  }
>
> diff --git a/drivers/block/rnbd/rnbd-srv-dev.h b/drivers/block/rnbd/rnbd-srv-dev.h
> index 2c3df02b5e8ec..1f7e1c8fd4d9b 100644
> --- a/drivers/block/rnbd/rnbd-srv-dev.h
> +++ b/drivers/block/rnbd/rnbd-srv-dev.h
> @@ -49,11 +49,7 @@ static inline int rnbd_dev_get_secure_discard(const struct rnbd_dev *dev)
>
>  static inline int rnbd_dev_get_max_discard_sects(const struct rnbd_dev *dev)
>  {
> -       if (!blk_queue_discard(bdev_get_queue(dev->bdev)))
> -               return 0;
> -
> -       return blk_queue_get_max_sectors(bdev_get_queue(dev->bdev),
> -                                        REQ_OP_DISCARD);
> +       return bdev_max_discard_sectors(dev->bdev);
>  }
>
>  static inline int rnbd_dev_get_discard_granularity(const struct rnbd_dev *dev)
> diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
> index 8b691fe50475f..83cd08041e6b3 100644
> --- a/drivers/block/xen-blkback/xenbus.c
> +++ b/drivers/block/xen-blkback/xenbus.c
> @@ -583,7 +583,7 @@ static void xen_blkbk_discard(struct xenbus_transaction xbt, struct backend_info
>         if (!xenbus_read_unsigned(dev->nodename, "discard-enable", 1))
>                 return;
>
> -       if (blk_queue_discard(q)) {
> +       if (bdev_max_discard_sectors(bdev)) {
>                 err = xenbus_printf(xbt, dev->nodename,
>                         "discard-granularity", "%u",
>                         q->limits.discard_granularity);
> diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
> index fdd0194f84dd0..e27f67f06a428 100644
> --- a/drivers/md/bcache/request.c
> +++ b/drivers/md/bcache/request.c
> @@ -1005,7 +1005,7 @@ static void cached_dev_write(struct cached_dev *dc, struct search *s)
>                 bio_get(s->iop.bio);
>
>                 if (bio_op(bio) == REQ_OP_DISCARD &&
> -                   !blk_queue_discard(bdev_get_queue(dc->bdev)))
> +                   !bdev_max_discard_sectors(dc->bdev))
>                         goto insert_data;
>
>                 /* I/O request sent to backing device */
> @@ -1115,7 +1115,7 @@ static void detached_dev_do_request(struct bcache_device *d, struct bio *bio,
>         bio->bi_private = ddip;
>
>         if ((bio_op(bio) == REQ_OP_DISCARD) &&
> -           !blk_queue_discard(bdev_get_queue(dc->bdev)))
> +           !bdev_max_discard_sectors(dc->bdev))
>                 bio->bi_end_io(bio);
>         else
>                 submit_bio_noacct(bio);
> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
> index bf3de149d3c9f..296f200b2e208 100644
> --- a/drivers/md/bcache/super.c
> +++ b/drivers/md/bcache/super.c
> @@ -2350,7 +2350,7 @@ static int register_cache(struct cache_sb *sb, struct cache_sb_disk *sb_disk,
>         ca->bdev->bd_holder = ca;
>         ca->sb_disk = sb_disk;
>
> -       if (blk_queue_discard(bdev_get_queue(bdev)))
> +       if (bdev_max_discard_sectors((bdev)))
>                 ca->discard = CACHE_DISCARD(&ca->sb);
>
>         ret = cache_alloc(ca);
> diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
> index d1029d71ff3bc..c6f677059214d 100644
> --- a/drivers/md/bcache/sysfs.c
> +++ b/drivers/md/bcache/sysfs.c
> @@ -1151,7 +1151,7 @@ STORE(__bch_cache)
>         if (attr == &sysfs_discard) {
>                 bool v = strtoul_or_return(buf);
>
> -               if (blk_queue_discard(bdev_get_queue(ca->bdev)))
> +               if (bdev_max_discard_sectors(ca->bdev))
>                         ca->discard = v;
>
>                 if (v != CACHE_DISCARD(&ca->sb)) {
> diff --git a/drivers/md/dm-cache-target.c b/drivers/md/dm-cache-target.c
> index 780a61bc6cc03..28c5de8eca4a0 100644
> --- a/drivers/md/dm-cache-target.c
> +++ b/drivers/md/dm-cache-target.c
> @@ -3329,13 +3329,6 @@ static int cache_iterate_devices(struct dm_target *ti,
>         return r;
>  }
>
> -static bool origin_dev_supports_discard(struct block_device *origin_bdev)
> -{
> -       struct request_queue *q = bdev_get_queue(origin_bdev);
> -
> -       return blk_queue_discard(q);
> -}
> -
>  /*
>   * If discard_passdown was enabled verify that the origin device
>   * supports discards.  Disable discard_passdown if not.
> @@ -3349,7 +3342,7 @@ static void disable_passdown_if_not_supported(struct cache *cache)
>         if (!cache->features.discard_passdown)
>                 return;
>
> -       if (!origin_dev_supports_discard(origin_bdev))
> +       if (!bdev_max_discard_sectors(origin_bdev))
>                 reason = "discard unsupported";
>
>         else if (origin_limits->max_discard_sectors < cache->sectors_per_block)
> diff --git a/drivers/md/dm-clone-target.c b/drivers/md/dm-clone-target.c
> index 128316a73d016..811b0a5379d03 100644
> --- a/drivers/md/dm-clone-target.c
> +++ b/drivers/md/dm-clone-target.c
> @@ -2016,13 +2016,6 @@ static void clone_resume(struct dm_target *ti)
>         do_waker(&clone->waker.work);
>  }
>
> -static bool bdev_supports_discards(struct block_device *bdev)
> -{
> -       struct request_queue *q = bdev_get_queue(bdev);
> -
> -       return (q && blk_queue_discard(q));
> -}
> -
>  /*
>   * If discard_passdown was enabled verify that the destination device supports
>   * discards. Disable discard_passdown if not.
> @@ -2036,7 +2029,7 @@ static void disable_passdown_if_not_supported(struct clone *clone)
>         if (!test_bit(DM_CLONE_DISCARD_PASSDOWN, &clone->flags))
>                 return;
>
> -       if (!bdev_supports_discards(dest_dev))
> +       if (!bdev_max_discard_sectors(dest_dev))
>                 reason = "discard unsupported";
>         else if (dest_limits->max_discard_sectors < clone->region_size)
>                 reason = "max discard sectors smaller than a region";
> diff --git a/drivers/md/dm-io.c b/drivers/md/dm-io.c
> index 5762366333a27..e4b95eaeec8c7 100644
> --- a/drivers/md/dm-io.c
> +++ b/drivers/md/dm-io.c
> @@ -311,7 +311,7 @@ static void do_region(int op, int op_flags, unsigned region,
>          * Reject unsupported discard and write same requests.
>          */
>         if (op == REQ_OP_DISCARD)
> -               special_cmd_max_sectors = q->limits.max_discard_sectors;
> +               special_cmd_max_sectors = bdev_max_discard_sectors(where->bdev);
>         else if (op == REQ_OP_WRITE_ZEROES)
>                 special_cmd_max_sectors = q->limits.max_write_zeroes_sectors;
>         if ((op == REQ_OP_DISCARD || op == REQ_OP_WRITE_ZEROES) &&
> diff --git a/drivers/md/dm-log-writes.c b/drivers/md/dm-log-writes.c
> index c9d036d6bb2ee..e194226c89e54 100644
> --- a/drivers/md/dm-log-writes.c
> +++ b/drivers/md/dm-log-writes.c
> @@ -866,9 +866,8 @@ static int log_writes_message(struct dm_target *ti, unsigned argc, char **argv,
>  static void log_writes_io_hints(struct dm_target *ti, struct queue_limits *limits)
>  {
>         struct log_writes_c *lc = ti->private;
> -       struct request_queue *q = bdev_get_queue(lc->dev->bdev);
>
> -       if (!q || !blk_queue_discard(q)) {
> +       if (!bdev_max_discard_sectors(lc->dev->bdev)) {
>                 lc->device_supports_discard = false;
>                 limits->discard_granularity = lc->sectorsize;
>                 limits->max_discard_sectors = (UINT_MAX >> SECTOR_SHIFT);
> diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
> index 2b26435a6946e..9526ccbedafba 100644
> --- a/drivers/md/dm-raid.c
> +++ b/drivers/md/dm-raid.c
> @@ -2963,13 +2963,8 @@ static void configure_discard_support(struct raid_set *rs)
>         raid456 = rs_is_raid456(rs);
>
>         for (i = 0; i < rs->raid_disks; i++) {
> -               struct request_queue *q;
> -
> -               if (!rs->dev[i].rdev.bdev)
> -                       continue;
> -
> -               q = bdev_get_queue(rs->dev[i].rdev.bdev);
> -               if (!q || !blk_queue_discard(q))
> +               if (!rs->dev[i].rdev.bdev ||
> +                   !bdev_max_discard_sectors(rs->dev[i].rdev.bdev))
>                         return;
>
>                 if (raid456) {
> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> index d46839faa0ca5..4297c38328a9b 100644
> --- a/drivers/md/dm-table.c
> +++ b/drivers/md/dm-table.c
> @@ -1888,9 +1888,7 @@ static bool dm_table_supports_nowait(struct dm_table *t)
>  static int device_not_discard_capable(struct dm_target *ti, struct dm_dev *dev,
>                                       sector_t start, sector_t len, void *data)
>  {
> -       struct request_queue *q = bdev_get_queue(dev->bdev);
> -
> -       return !blk_queue_discard(q);
> +       return !bdev_max_discard_sectors(dev->bdev);
>  }
>
>  static bool dm_table_supports_discards(struct dm_table *t)
> diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
> index 4d25d0e270313..cd333a3e4c33b 100644
> --- a/drivers/md/dm-thin.c
> +++ b/drivers/md/dm-thin.c
> @@ -2802,13 +2802,6 @@ static void requeue_bios(struct pool *pool)
>  /*----------------------------------------------------------------
>   * Binding of control targets to a pool object
>   *--------------------------------------------------------------*/
> -static bool data_dev_supports_discard(struct pool_c *pt)
> -{
> -       struct request_queue *q = bdev_get_queue(pt->data_dev->bdev);
> -
> -       return blk_queue_discard(q);
> -}
> -
>  static bool is_factor(sector_t block_size, uint32_t n)
>  {
>         return !sector_div(block_size, n);
> @@ -2828,7 +2821,7 @@ static void disable_passdown_if_not_supported(struct pool_c *pt)
>         if (!pt->adjusted_pf.discard_passdown)
>                 return;
>
> -       if (!data_dev_supports_discard(pt))
> +       if (!bdev_max_discard_sectors(pt->data_dev->bdev))
>                 reason = "discard unsupported";
>
>         else if (data_limits->max_discard_sectors < pool->sectors_per_block)
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index 3c5fad7c4ee68..ba75933cc22ca 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -982,7 +982,7 @@ static void clone_endio(struct bio *bio)
>
>         if (unlikely(error == BLK_STS_TARGET)) {
>                 if (bio_op(bio) == REQ_OP_DISCARD &&
> -                   !q->limits.max_discard_sectors)
> +                   !bdev_max_discard_sectors(bio->bi_bdev))
>                         disable_discard(md);
>                 else if (bio_op(bio) == REQ_OP_WRITE_ZEROES &&
>                          !q->limits.max_write_zeroes_sectors)
> diff --git a/drivers/md/md-linear.c b/drivers/md/md-linear.c
> index 0f55b079371b1..4dd5afff72844 100644
> --- a/drivers/md/md-linear.c
> +++ b/drivers/md/md-linear.c
> @@ -97,7 +97,7 @@ static struct linear_conf *linear_conf(struct mddev *mddev, int raid_disks)
>                 conf->array_sectors += rdev->sectors;
>                 cnt++;
>
> -               if (blk_queue_discard(bdev_get_queue(rdev->bdev)))
> +               if (bdev_max_discard_sectors(rdev->bdev))
>                         discard_supported = true;
>         }
>         if (cnt != raid_disks) {
> @@ -252,7 +252,7 @@ static bool linear_make_request(struct mddev *mddev, struct bio *bio)
>                 start_sector + data_offset;
>
>         if (unlikely((bio_op(bio) == REQ_OP_DISCARD) &&
> -                    !blk_queue_discard(bio->bi_bdev->bd_disk->queue))) {
> +                    !bdev_max_discard_sectors(bio->bi_bdev))) {
>                 /* Just ignore it */
>                 bio_endio(bio);
>         } else {
> diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
> index b21e101183f44..02ac3ab213c72 100644
> --- a/drivers/md/raid0.c
> +++ b/drivers/md/raid0.c
> @@ -412,7 +412,7 @@ static int raid0_run(struct mddev *mddev)
>                 rdev_for_each(rdev, mddev) {
>                         disk_stack_limits(mddev->gendisk, rdev->bdev,
>                                           rdev->data_offset << 9);
> -                       if (blk_queue_discard(bdev_get_queue(rdev->bdev)))
> +                       if (bdev_max_discard_sectors(rdev->bdev))
>                                 discard_supported = true;
>                 }
>                 if (!discard_supported)
> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> index d81b896855f9f..39b9cb4d54ee0 100644
> --- a/drivers/md/raid1.c
> +++ b/drivers/md/raid1.c
> @@ -802,7 +802,7 @@ static void flush_bio_list(struct r1conf *conf, struct bio *bio)
>                 if (test_bit(Faulty, &rdev->flags)) {
>                         bio_io_error(bio);
>                 } else if (unlikely((bio_op(bio) == REQ_OP_DISCARD) &&
> -                                   !blk_queue_discard(bio->bi_bdev->bd_disk->queue)))
> +                                   !bdev_max_discard_sectors(bio->bi_bdev)))
>                         /* Just ignore it */
>                         bio_endio(bio);
>                 else
> @@ -1826,7 +1826,7 @@ static int raid1_add_disk(struct mddev *mddev, struct md_rdev *rdev)
>                         break;
>                 }
>         }
> -       if (mddev->queue && blk_queue_discard(bdev_get_queue(rdev->bdev)))
> +       if (mddev->queue && bdev_max_discard_sectors(rdev->bdev))
>                 blk_queue_flag_set(QUEUE_FLAG_DISCARD, mddev->queue);
>         print_conf(conf);
>         return err;
> @@ -3141,7 +3141,7 @@ static int raid1_run(struct mddev *mddev)
>                         continue;
>                 disk_stack_limits(mddev->gendisk, rdev->bdev,
>                                   rdev->data_offset << 9);
> -               if (blk_queue_discard(bdev_get_queue(rdev->bdev)))
> +               if (bdev_max_discard_sectors(rdev->bdev))
>                         discard_supported = true;
>         }
>
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index 7816c8b2e8087..eaa86c6a35a55 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -888,7 +888,7 @@ static void flush_pending_writes(struct r10conf *conf)
>                         if (test_bit(Faulty, &rdev->flags)) {
>                                 bio_io_error(bio);
>                         } else if (unlikely((bio_op(bio) ==  REQ_OP_DISCARD) &&
> -                                           !blk_queue_discard(bio->bi_bdev->bd_disk->queue)))
> +                                           !bdev_max_discard_sectors(bio->bi_bdev)))
>                                 /* Just ignore it */
>                                 bio_endio(bio);
>                         else
> @@ -1083,7 +1083,7 @@ static void raid10_unplug(struct blk_plug_cb *cb, bool from_schedule)
>                 if (test_bit(Faulty, &rdev->flags)) {
>                         bio_io_error(bio);
>                 } else if (unlikely((bio_op(bio) ==  REQ_OP_DISCARD) &&
> -                                   !blk_queue_discard(bio->bi_bdev->bd_disk->queue)))
> +                                   !bdev_max_discard_sectors(bio->bi_bdev)))
>                         /* Just ignore it */
>                         bio_endio(bio);
>                 else
> @@ -2144,7 +2144,7 @@ static int raid10_add_disk(struct mddev *mddev, struct md_rdev *rdev)
>                 rcu_assign_pointer(p->rdev, rdev);
>                 break;
>         }
> -       if (mddev->queue && blk_queue_discard(bdev_get_queue(rdev->bdev)))
> +       if (mddev->queue && bdev_max_discard_sectors(rdev->bdev))
>                 blk_queue_flag_set(QUEUE_FLAG_DISCARD, mddev->queue);
>
>         print_conf(conf);
> @@ -4141,7 +4141,7 @@ static int raid10_run(struct mddev *mddev)
>
>                 disk->head_position = 0;
>
> -               if (blk_queue_discard(bdev_get_queue(rdev->bdev)))
> +               if (bdev_max_discard_sectors(rdev->bdev))
>                         discard_supported = true;
>                 first = 0;
>         }
> diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
> index a7d50ff9020a8..c3cbf9a574a39 100644
> --- a/drivers/md/raid5-cache.c
> +++ b/drivers/md/raid5-cache.c
> @@ -1318,7 +1318,7 @@ static void r5l_write_super_and_discard_space(struct r5l_log *log,
>
>         r5l_write_super(log, end);
>
> -       if (!blk_queue_discard(bdev_get_queue(bdev)))
> +       if (!bdev_max_discard_sectors(bdev))
>                 return;
>
>         mddev = log->rdev->mddev;
> diff --git a/drivers/target/target_core_device.c b/drivers/target/target_core_device.c
> index 16e775bcf4a7c..7d510e4231713 100644
> --- a/drivers/target/target_core_device.c
> +++ b/drivers/target/target_core_device.c
> @@ -829,9 +829,7 @@ struct se_device *target_alloc_device(struct se_hba *hba, const char *name)
>  }
>
>  /*
> - * Check if the underlying struct block_device request_queue supports
> - * the QUEUE_FLAG_DISCARD bit for UNMAP/WRITE_SAME in SCSI + TRIM
> - * in ATA and we need to set TPE=1
> + * Check if the underlying struct block_device request_queue supports disard.
>   */
>  bool target_configure_unmap_from_queue(struct se_dev_attrib *attrib,
>                                        struct block_device *bdev)
> @@ -839,11 +837,11 @@ bool target_configure_unmap_from_queue(struct se_dev_attrib *attrib,
>         struct request_queue *q = bdev_get_queue(bdev);
>         int block_size = bdev_logical_block_size(bdev);
>
> -       if (!blk_queue_discard(q))
> +       if (!bdev_max_discard_sectors(bdev))
>                 return false;
>
>         attrib->max_unmap_lba_count =
> -               q->limits.max_discard_sectors >> (ilog2(block_size) - 9);
> +               bdev_max_discard_sectors(bdev) >> (ilog2(block_size) - 9);
>         /*
>          * Currently hardcoded to 1 in Linux/SCSI code..
>          */
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index f477035a2ac23..efd8deb3ab7e8 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -1291,7 +1291,7 @@ static int do_discard_extent(struct btrfs_io_stripe *stripe, u64 *bytes)
>                 ret = btrfs_reset_device_zone(dev_replace->tgtdev, phys, len,
>                                               &discarded);
>                 discarded += src_disc;
> -       } else if (blk_queue_discard(bdev_get_queue(stripe->dev->bdev))) {
> +       } else if (bdev_max_discard_sectors(stripe->dev->bdev)) {
>                 ret = btrfs_issue_discard(dev->bdev, phys, len, &discarded);
>         } else {
>                 ret = 0;
> @@ -5987,7 +5987,7 @@ static int btrfs_trim_free_extents(struct btrfs_device *device, u64 *trimmed)
>         *trimmed = 0;
>
>         /* Discard not supported = nothing to do. */
> -       if (!blk_queue_discard(bdev_get_queue(device->bdev)))
> +       if (!bdev_max_discard_sectors(device->bdev))
>                 return 0;
>
>         /* Not writable = nothing to do. */
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 238cee5b5254d..fc7953755fd8b 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -501,7 +501,7 @@ static noinline int btrfs_ioctl_fitrim(struct btrfs_fs_info *fs_info,
>                 if (!device->bdev)
>                         continue;
>                 q = bdev_get_queue(device->bdev);
> -               if (blk_queue_discard(q)) {
> +               if (bdev_max_discard_sectors(device->bdev)) {
>                         num_devices++;
>                         minlen = min_t(u64, q->limits.discard_granularity,
>                                      minlen);
> diff --git a/fs/exfat/file.c b/fs/exfat/file.c
> index 2f51300592366..765e4f63dd18d 100644
> --- a/fs/exfat/file.c
> +++ b/fs/exfat/file.c
> @@ -358,7 +358,7 @@ static int exfat_ioctl_fitrim(struct inode *inode, unsigned long arg)
>         if (!capable(CAP_SYS_ADMIN))
>                 return -EPERM;
>
> -       if (!blk_queue_discard(q))
> +       if (!bdev_max_discard_sectors(inode->i_sb->s_bdev))
>                 return -EOPNOTSUPP;
>
>         if (copy_from_user(&range, (struct fstrim_range __user *)arg, sizeof(range)))
> diff --git a/fs/exfat/super.c b/fs/exfat/super.c
> index 8ca21e7917d16..be0788ecaf20e 100644
> --- a/fs/exfat/super.c
> +++ b/fs/exfat/super.c
> @@ -627,13 +627,9 @@ static int exfat_fill_super(struct super_block *sb, struct fs_context *fc)
>         if (opts->allow_utime == (unsigned short)-1)
>                 opts->allow_utime = ~opts->fs_dmask & 0022;
>
> -       if (opts->discard) {
> -               struct request_queue *q = bdev_get_queue(sb->s_bdev);
> -
> -               if (!blk_queue_discard(q)) {
> -                       exfat_warn(sb, "mounting with \"discard\" option, but the device does not support discard");
> -                       opts->discard = 0;
> -               }
> +       if (opts->discard && !bdev_max_discard_sectors(sb->s_bdev)) {
> +               exfat_warn(sb, "mounting with \"discard\" option, but the device does not support discard");
> +               opts->discard = 0;
>         }
>
>         sb->s_flags |= SB_NODIRATIME;
> diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
> index 992229ca2d830..6e3b9eea126f4 100644
> --- a/fs/ext4/ioctl.c
> +++ b/fs/ext4/ioctl.c
> @@ -1044,7 +1044,6 @@ static int ext4_ioctl_checkpoint(struct file *filp, unsigned long arg)
>         __u32 flags = 0;
>         unsigned int flush_flags = 0;
>         struct super_block *sb = file_inode(filp)->i_sb;
> -       struct request_queue *q;
>
>         if (copy_from_user(&flags, (__u32 __user *)arg,
>                                 sizeof(__u32)))
> @@ -1065,10 +1064,8 @@ static int ext4_ioctl_checkpoint(struct file *filp, unsigned long arg)
>         if (flags & ~EXT4_IOC_CHECKPOINT_FLAG_VALID)
>                 return -EINVAL;
>
> -       q = bdev_get_queue(EXT4_SB(sb)->s_journal->j_dev);
> -       if (!q)
> -               return -ENXIO;
> -       if ((flags & JBD2_JOURNAL_FLUSH_DISCARD) && !blk_queue_discard(q))
> +       if ((flags & JBD2_JOURNAL_FLUSH_DISCARD) &&
> +           !bdev_max_discard_sectors(EXT4_SB(sb)->s_journal->j_dev))
>                 return -EOPNOTSUPP;
>
>         if (flags & EXT4_IOC_CHECKPOINT_FLAG_DRY_RUN)
> @@ -1393,14 +1390,13 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>
>         case FITRIM:
>         {
> -               struct request_queue *q = bdev_get_queue(sb->s_bdev);
>                 struct fstrim_range range;
>                 int ret = 0;
>
>                 if (!capable(CAP_SYS_ADMIN))
>                         return -EPERM;
>
> -               if (!blk_queue_discard(q))
> +               if (!bdev_max_discard_sectors(sb->s_bdev))
>                         return -EOPNOTSUPP;
>
>                 /*
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 81749eaddf4c1..93f4e4e9e2631 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -5458,13 +5458,9 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>                         goto failed_mount9;
>         }
>
> -       if (test_opt(sb, DISCARD)) {
> -               struct request_queue *q = bdev_get_queue(sb->s_bdev);
> -               if (!blk_queue_discard(q))
> -                       ext4_msg(sb, KERN_WARNING,
> -                                "mounting with \"discard\" option, but "
> -                                "the device does not support discard");
> -       }
> +       if (test_opt(sb, DISCARD) && !bdev_max_discard_sectors(sb->s_bdev))
> +               ext4_msg(sb, KERN_WARNING,
> +                        "mounting with \"discard\" option, but the device does not support discard");
>
>         if (es->s_error_count)
>                 mod_timer(&sbi->s_err_report, jiffies + 300*HZ); /* 5 minutes */
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index cd1e65bcf0b04..0ea9a5fa7c1dd 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -4381,8 +4381,7 @@ static inline bool f2fs_hw_should_discard(struct f2fs_sb_info *sbi)
>
>  static inline bool f2fs_bdev_support_discard(struct block_device *bdev)
>  {
> -       return blk_queue_discard(bdev_get_queue(bdev)) ||
> -              bdev_is_zoned(bdev);
> +       return bdev_max_discard_sectors(bdev) || bdev_is_zoned(bdev);
>  }
>
>  static inline bool f2fs_hw_support_discard(struct f2fs_sb_info *sbi)
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 22dfeb9915290..71f09adbcba86 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1196,9 +1196,8 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
>                                                 unsigned int *issued)
>  {
>         struct block_device *bdev = dc->bdev;
> -       struct request_queue *q = bdev_get_queue(bdev);
>         unsigned int max_discard_blocks =
> -                       SECTOR_TO_BLOCK(q->limits.max_discard_sectors);
> +                       SECTOR_TO_BLOCK(bdev_max_discard_sectors(bdev));
>         struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
>         struct list_head *wait_list = (dpolicy->type == DPOLICY_FSTRIM) ?
>                                         &(dcc->fstrim_list) : &(dcc->wait_list);
> @@ -1375,9 +1374,8 @@ static void __update_discard_tree_range(struct f2fs_sb_info *sbi,
>         struct discard_cmd *dc;
>         struct discard_info di = {0};
>         struct rb_node **insert_p = NULL, *insert_parent = NULL;
> -       struct request_queue *q = bdev_get_queue(bdev);
>         unsigned int max_discard_blocks =
> -                       SECTOR_TO_BLOCK(q->limits.max_discard_sectors);
> +                       SECTOR_TO_BLOCK(bdev_max_discard_sectors(bdev));
>         block_t end = lstart + len;
>
>         dc = (struct discard_cmd *)f2fs_lookup_rb_tree_ret(&dcc->root,
> diff --git a/fs/fat/file.c b/fs/fat/file.c
> index a5a309fcc7faf..e4c7d10e80129 100644
> --- a/fs/fat/file.c
> +++ b/fs/fat/file.c
> @@ -133,7 +133,7 @@ static int fat_ioctl_fitrim(struct inode *inode, unsigned long arg)
>         if (!capable(CAP_SYS_ADMIN))
>                 return -EPERM;
>
> -       if (!blk_queue_discard(q))
> +       if (!bdev_max_discard_sectors(sb->s_bdev))
>                 return -EOPNOTSUPP;
>
>         user_range = (struct fstrim_range __user *)arg;
> diff --git a/fs/fat/inode.c b/fs/fat/inode.c
> index bf6051bdf1d1d..3d1afb95a925a 100644
> --- a/fs/fat/inode.c
> +++ b/fs/fat/inode.c
> @@ -1872,13 +1872,9 @@ int fat_fill_super(struct super_block *sb, void *data, int silent, int isvfat,
>                 goto out_fail;
>         }
>
> -       if (sbi->options.discard) {
> -               struct request_queue *q = bdev_get_queue(sb->s_bdev);
> -               if (!blk_queue_discard(q))
> -                       fat_msg(sb, KERN_WARNING,
> -                                       "mounting with \"discard\" option, but "
> -                                       "the device does not support discard");
> -       }
> +       if (sbi->options.discard && !bdev_max_discard_sectors(sb->s_bdev))
> +               fat_msg(sb, KERN_WARNING,
> +                       "mounting with \"discard\" option, but the device does not support discard");
>
>         fat_set_state(sb, 1, 0);
>         return 0;
> diff --git a/fs/gfs2/rgrp.c b/fs/gfs2/rgrp.c
> index 801ad9f4f2bef..7f20ac9133bc6 100644
> --- a/fs/gfs2/rgrp.c
> +++ b/fs/gfs2/rgrp.c
> @@ -1405,7 +1405,7 @@ int gfs2_fitrim(struct file *filp, void __user *argp)
>         if (!test_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags))
>                 return -EROFS;
>
> -       if (!blk_queue_discard(q))
> +       if (!bdev_max_discard_sectors(sdp->sd_vfs->s_bdev))
>                 return -EOPNOTSUPP;
>
>         if (copy_from_user(&r, argp, sizeof(r)))
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index fcacafa4510d1..19d226cd4ff4d 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -1762,7 +1762,6 @@ static int __jbd2_journal_erase(journal_t *journal, unsigned int flags)
>         unsigned long block, log_offset; /* logical */
>         unsigned long long phys_block, block_start, block_stop; /* physical */
>         loff_t byte_start, byte_stop, byte_count;
> -       struct request_queue *q = bdev_get_queue(journal->j_dev);
>
>         /* flags must be set to either discard or zeroout */
>         if ((flags & ~JBD2_JOURNAL_FLUSH_VALID) || !flags ||
> @@ -1770,10 +1769,8 @@ static int __jbd2_journal_erase(journal_t *journal, unsigned int flags)
>                         (flags & JBD2_JOURNAL_FLUSH_ZEROOUT)))
>                 return -EINVAL;
>
> -       if (!q)
> -               return -ENXIO;
> -
> -       if ((flags & JBD2_JOURNAL_FLUSH_DISCARD) && !blk_queue_discard(q))
> +       if ((flags & JBD2_JOURNAL_FLUSH_DISCARD) &&
> +           !bdev_max_discard_sectors(journal->j_dev))
>                 return -EOPNOTSUPP;
>
>         /*
> diff --git a/fs/jfs/ioctl.c b/fs/jfs/ioctl.c
> index 03a845ab4f009..357ae6e5c36ec 100644
> --- a/fs/jfs/ioctl.c
> +++ b/fs/jfs/ioctl.c
> @@ -117,7 +117,7 @@ long jfs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>                 if (!capable(CAP_SYS_ADMIN))
>                         return -EPERM;
>
> -               if (!blk_queue_discard(q)) {
> +               if (!bdev_max_discard_sectors(sb->s_bdev)) {
>                         jfs_warn("FITRIM not supported on device");
>                         return -EOPNOTSUPP;
>                 }
> diff --git a/fs/jfs/super.c b/fs/jfs/super.c
> index f1a13a74cddf3..85d4f44f2ac4d 100644
> --- a/fs/jfs/super.c
> +++ b/fs/jfs/super.c
> @@ -372,19 +372,16 @@ static int parse_options(char *options, struct super_block *sb, s64 *newLVSize,
>                 }
>
>                 case Opt_discard:
> -               {
> -                       struct request_queue *q = bdev_get_queue(sb->s_bdev);
>                         /* if set to 1, even copying files will cause
>                          * trimming :O
>                          * -> user has more control over the online trimming
>                          */
>                         sbi->minblks_trim = 64;
> -                       if (blk_queue_discard(q))
> +                       if (bdev_max_discard_sectors(sb->s_bdev))
>                                 *flag |= JFS_DISCARD;
>                         else
>                                 pr_err("JFS: discard option not supported on device\n");
>                         break;
> -               }
>
>                 case Opt_nodiscard:
>                         *flag &= ~JFS_DISCARD;
> @@ -392,10 +389,9 @@ static int parse_options(char *options, struct super_block *sb, s64 *newLVSize,
>
>                 case Opt_discard_minblk:
>                 {
> -                       struct request_queue *q = bdev_get_queue(sb->s_bdev);
>                         char *minblks_trim = args[0].from;
>                         int rc;
> -                       if (blk_queue_discard(q)) {
> +                       if (bdev_max_discard_sectors(sb->s_bdev)) {
>                                 *flag |= JFS_DISCARD;
>                                 rc = kstrtouint(minblks_trim, 0,
>                                                 &sbi->minblks_trim);
> diff --git a/fs/nilfs2/ioctl.c b/fs/nilfs2/ioctl.c
> index fec194a666f4b..52b73f558fcb1 100644
> --- a/fs/nilfs2/ioctl.c
> +++ b/fs/nilfs2/ioctl.c
> @@ -1059,7 +1059,7 @@ static int nilfs_ioctl_trim_fs(struct inode *inode, void __user *argp)
>         if (!capable(CAP_SYS_ADMIN))
>                 return -EPERM;
>
> -       if (!blk_queue_discard(q))
> +       if (!bdev_max_discard_sectors(nilfs->ns_bdev))
>                 return -EOPNOTSUPP;
>
>         if (copy_from_user(&range, argp, sizeof(range)))
> diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
> index 787b53b984ee1..e763236169331 100644
> --- a/fs/ntfs3/file.c
> +++ b/fs/ntfs3/file.c
> @@ -28,7 +28,7 @@ static int ntfs_ioctl_fitrim(struct ntfs_sb_info *sbi, unsigned long arg)
>         if (!capable(CAP_SYS_ADMIN))
>                 return -EPERM;
>
> -       if (!blk_queue_discard(q))
> +       if (!bdev_max_discard_sectors(sbi->sb->s_bdev))
>                 return -EOPNOTSUPP;
>
>         user_range = (struct fstrim_range __user *)arg;
> diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
> index cd30e81abbce0..c734085bcce4a 100644
> --- a/fs/ntfs3/super.c
> +++ b/fs/ntfs3/super.c
> @@ -913,7 +913,7 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
>         }
>
>         rq = bdev_get_queue(bdev);
> -       if (blk_queue_discard(rq) && rq->limits.discard_granularity) {
> +       if (bdev_max_discard_sectors(bdev) && rq->limits.discard_granularity) {
>                 sbi->discard_granularity = rq->limits.discard_granularity;
>                 sbi->discard_granularity_mask_inv =
>                         ~(u64)(sbi->discard_granularity - 1);
> diff --git a/fs/ocfs2/ioctl.c b/fs/ocfs2/ioctl.c
> index f59461d85da45..9b78ef103ada6 100644
> --- a/fs/ocfs2/ioctl.c
> +++ b/fs/ocfs2/ioctl.c
> @@ -910,7 +910,7 @@ long ocfs2_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>                 if (!capable(CAP_SYS_ADMIN))
>                         return -EPERM;
>
> -               if (!blk_queue_discard(q))
> +               if (!bdev_max_discard_sectors(sb->s_bdev))
>                         return -EOPNOTSUPP;
>
>                 if (copy_from_user(&range, argp, sizeof(range)))
> diff --git a/fs/xfs/xfs_discard.c b/fs/xfs/xfs_discard.c
> index 0191de8ce9ced..a4e6609d616b7 100644
> --- a/fs/xfs/xfs_discard.c
> +++ b/fs/xfs/xfs_discard.c
> @@ -162,7 +162,7 @@ xfs_ioc_trim(
>
>         if (!capable(CAP_SYS_ADMIN))
>                 return -EPERM;
> -       if (!blk_queue_discard(q))
> +       if (!bdev_max_discard_sectors(mp->m_ddev_targp->bt_bdev))
>                 return -EOPNOTSUPP;
>
>         /*
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index 54be9d64093ed..a276b8111f636 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -1608,14 +1608,10 @@ xfs_fs_fill_super(.
>                         goto out_filestream_unmount;
>         }>

> -       if (xfs_has_discard(mp)) {
> -               struct request_queue *q = bdev_get_queue(sb->s_bdev);
> -
> -               if (!blk_queue_discard(q)) {
> -                       xfs_warn(mp, "mounting with \"discard\" option, but "
> -                                       "the device does not support discard");
> -                       mp->m_features &= ~XFS_FEAT_DISCARD;
> -               }
> +       if (xfs_has_discard(mp) && !bdev_max_discard_sectors(sb->s_bdev)) {
> +               xfs_warn(mp,
> +       "mounting with \"discard\" option, but the device does not support discard");
> +               mp->m_features &= ~XFS_FEAT_DISCARD;
>         }
>
>         if (xfs_has_reflink(mp)) {
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 34b1cfd067421..ce16247d3afab 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1254,6 +1254,11 @@ bdev_zone_write_granularity(struct block_device *bdev)
>  int bdev_alignment_offset(struct block_device *bdev);
>  unsigned int bdev_discard_alignment(struct block_device *bdev);
>
> +static inline unsigned int bdev_max_discard_sectors(struct block_device *bdev)
> +{
> +       return bdev_get_queue(bdev)->limits.max_discard_sectors;
> +}
> +

So this patch replaces checking for blk_queue_discard(q) with checking
whether bdev_max_discard_sectors() is nonzero. That doesn't seem to be
equivalent for callers like drivers/md/raid0.c:raid0_run() which clear
the QUEUE_FLAG_DISCARD flag without zeroing out max_discard_sectors,
for example. Should a test for the QUEUE_FLAG_DISCARD flag be added
here?

If I'm misreading things, could you please document that
bdev_max_discard_sectors() != 0 implies that discard is supported?

Thanks,
Andreas

>  static inline unsigned int bdev_write_zeroes_sectors(struct block_device *bdev)
>  {
>         struct request_queue *q = bdev_get_queue(bdev);
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 4069f17a82c8e..5d9cedf9e7b84 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -2957,20 +2957,6 @@ static int setup_swap_map_and_extents(struct swap_info_struct *p,
>         return nr_extents;
>  }
>
> -/*
> - * Helper to sys_swapon determining if a given swap
> - * backing device queue supports DISCARD operations.
> - */
> -static bool swap_discardable(struct swap_info_struct *si)
> -{
> -       struct request_queue *q = bdev_get_queue(si->bdev);
> -
> -       if (!blk_queue_discard(q))
> -               return false;
> -
> -       return true;
> -}
> -
>  SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
>  {
>         struct swap_info_struct *p;
> @@ -3132,7 +3118,8 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
>                                          sizeof(long),
>                                          GFP_KERNEL);
>
> -       if (p->bdev && (swap_flags & SWAP_FLAG_DISCARD) && swap_discardable(p)) {
> +       if ((swap_flags & SWAP_FLAG_DISCARD) &&
> +           p->bdev && bdev_max_discard_sectors(p->bdev)) {
>                 /*
>                  * When discard is enabled for swap with no particular
>                  * policy flagged, we set all swap discard flags here in
> --
> 2.30.2
>

