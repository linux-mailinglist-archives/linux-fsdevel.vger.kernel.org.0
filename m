Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D444C3460
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Feb 2022 19:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbiBXSLJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Feb 2022 13:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiBXSLI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Feb 2022 13:11:08 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047FE1E6952;
        Thu, 24 Feb 2022 10:10:38 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-2d66f95f1d1so7568247b3.0;
        Thu, 24 Feb 2022 10:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5eZDgcxBiEahgQGqIVo4NOwq5Qo0wc2zSQHHLGRnIQM=;
        b=hOAnqSTI/Gh9yfCHqk+7dOsYcudQiruj8mpt7dmfjM5mWHLmv0u3d04DW8ALfBIXMG
         jo1aQNu8b37er4WOYMPhB0UKNBWuYIbVmK1S5rZBnKtE3j6emTQsT3qFtpIheorsTivo
         5oFwymdPrzK0TL7yVgoFRt/N/qYgq59XcFETBcR/mN/BchTGsA3oSWbl70lTpcsstt5O
         nRtu1Pud8PUcNNfPv5BadE0iVwqkk4S+ioB/E0TkrKnbVoRVJH4C91+Hcq3PdR/ymM2E
         gaQI4Q/rQrPyeTqMR7KeZVadtXbPVvCVGUzET6Lt8AJ66Q92342VKnjcz1C6+ONF0BvN
         RdLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5eZDgcxBiEahgQGqIVo4NOwq5Qo0wc2zSQHHLGRnIQM=;
        b=oUQpn0853d650zuVTsrS6za1Mq5zgvbiylpn6o5dgtNxOXlAHg6neHZlmxD6Pjm3RM
         /9TZY8vCpgDoxltXe0xt0+G431w3lZXhgFDMyLtT3JCVnBgrwXauBEsmMAqT28YDv6Jm
         cDHCkyEH3Fxpqtzk9Q49aSoC+ryCTcRvnrGjVpgy4QTKGIRHORkfrZBc8TbV0ik9dUrd
         IpfXjsuCYzXN9ley9gctykOa4ScDoG14kPhBvotXKW0ZtNH/LTbq/RDUjAYapNjhyum8
         XzmUFh0hzkWNPQ/M8K0rTXvr/9icEntkKuhB8e5oAlImWhMiiiHg1ow8ddyb27BKZ9xv
         IbGA==
X-Gm-Message-State: AOAM531A4Em7O3jg+5dv7olR05P+YacrdPzPE7GzwhPt6VQ5NznjSr67
        fYBO0hiGVVBC478N9gurQzHIICT1JQiiaLTkHwE=
X-Google-Smtp-Source: ABdhPJzAIqYPKdGLE2EeqFKSCMroLeeiWgQwRfA5B8K+sGjJ+1Pn3nTjD/EQPHmJEn7zy85dqMfSQ0Bfo7hIsT3Znj8=
X-Received: by 2002:a81:83d7:0:b0:2d6:b550:21b8 with SMTP id
 t206-20020a8183d7000000b002d6b55021b8mr3756069ywf.188.1645726237054; Thu, 24
 Feb 2022 10:10:37 -0800 (PST)
MIME-Version: 1.0
References: <164447124918.23354.17858831070003318849.stgit@noble.brown> <164447147262.23354.13106570458589592051.stgit@noble.brown>
In-Reply-To: <164447147262.23354.13106570458589592051.stgit@noble.brown>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Fri, 25 Feb 2022 03:10:24 +0900
Message-ID: <CAKFNMokgJMxfvdwc4isNj_gQHAecJF2tq3j8HRhhxW_xN5L5_Q@mail.gmail.com>
Subject: Re: [PATCH 08/11] Remove bdi_congested() and wb_congested() and
 related functions
To:     NeilBrown <neilb@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>,
        Wu Fengguang <fengguang.wu@intel.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>, linux-doc@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>,
        linux-nilfs <linux-nilfs@vger.kernel.org>,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        ceph-devel@vger.kernel.org, drbd-dev@lists.linbit.com,
        LKML <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 10, 2022 at 2:41 PM NeilBrown <neilb@suse.de> wrote:
>
> These functions are no longer useful as no BDIs report congestions any
> more.
>
> Removing the test on bdi_write_contested() in current_may_throttle()
> could cause a small change in behaviour, but only when PF_LOCAL_THROTTLE
> is set.
>
> So replace the calls by 'false' and simplify the code - and remove the
> functions.
>
> Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com> (for nilfs bits)
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  drivers/block/drbd/drbd_int.h |    3 ---
>  drivers/block/drbd/drbd_req.c |    3 +--
>  fs/ext2/ialloc.c              |    5 -----
>  fs/nilfs2/segbuf.c            |   15 ---------------
>  fs/xfs/xfs_buf.c              |    3 ---
>  include/linux/backing-dev.h   |   26 --------------------------
>  mm/vmscan.c                   |    4 +---
>  7 files changed, 2 insertions(+), 57 deletions(-)
>
> diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
> index f27d5b0f9a0b..f804b1bfb3e6 100644
> --- a/drivers/block/drbd/drbd_int.h
> +++ b/drivers/block/drbd/drbd_int.h
> @@ -638,9 +638,6 @@ enum {
>         STATE_SENT,             /* Do not change state/UUIDs while this is set */
>         CALLBACK_PENDING,       /* Whether we have a call_usermodehelper(, UMH_WAIT_PROC)
>                                  * pending, from drbd worker context.
> -                                * If set, bdi_write_congested() returns true,
> -                                * so shrink_page_list() would not recurse into,
> -                                * and potentially deadlock on, this drbd worker.
>                                  */
>         DISCONNECT_SENT,
>
> diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
> index 3235532ae077..2e5fb7e442e3 100644
> --- a/drivers/block/drbd/drbd_req.c
> +++ b/drivers/block/drbd/drbd_req.c
> @@ -909,8 +909,7 @@ static bool remote_due_to_read_balancing(struct drbd_device *device, sector_t se
>
>         switch (rbm) {
>         case RB_CONGESTED_REMOTE:
> -               return bdi_read_congested(
> -                       device->ldev->backing_bdev->bd_disk->bdi);
> +               return 0;
>         case RB_LEAST_PENDING:
>                 return atomic_read(&device->local_cnt) >
>                         atomic_read(&device->ap_pending_cnt) + atomic_read(&device->rs_pending_cnt);
> diff --git a/fs/ext2/ialloc.c b/fs/ext2/ialloc.c
> index df14e750e9fe..998dd2ac8008 100644
> --- a/fs/ext2/ialloc.c
> +++ b/fs/ext2/ialloc.c
> @@ -170,11 +170,6 @@ static void ext2_preread_inode(struct inode *inode)
>         unsigned long offset;
>         unsigned long block;
>         struct ext2_group_desc * gdp;
> -       struct backing_dev_info *bdi;
> -
> -       bdi = inode_to_bdi(inode);
> -       if (bdi_rw_congested(bdi))
> -               return;
>
>         block_group = (inode->i_ino - 1) / EXT2_INODES_PER_GROUP(inode->i_sb);
>         gdp = ext2_get_group_desc(inode->i_sb, block_group, NULL);
> diff --git a/fs/nilfs2/segbuf.c b/fs/nilfs2/segbuf.c
> index 43287b0d3e9b..c4510f79037f 100644
> --- a/fs/nilfs2/segbuf.c
> +++ b/fs/nilfs2/segbuf.c
> @@ -343,17 +343,6 @@ static int nilfs_segbuf_submit_bio(struct nilfs_segment_buffer *segbuf,
>         struct bio *bio = wi->bio;
>         int err;
>
> -       if (segbuf->sb_nbio > 0 &&
> -           bdi_write_congested(segbuf->sb_super->s_bdi)) {
> -               wait_for_completion(&segbuf->sb_bio_event);
> -               segbuf->sb_nbio--;
> -               if (unlikely(atomic_read(&segbuf->sb_err))) {
> -                       bio_put(bio);
> -                       err = -EIO;
> -                       goto failed;
> -               }
> -       }
> -
>         bio->bi_end_io = nilfs_end_bio_write;
>         bio->bi_private = segbuf;
>         bio_set_op_attrs(bio, mode, mode_flags);
> @@ -365,10 +354,6 @@ static int nilfs_segbuf_submit_bio(struct nilfs_segment_buffer *segbuf,
>         wi->nr_vecs = min(wi->max_pages, wi->rest_blocks);
>         wi->start = wi->end;
>         return 0;
> -
> - failed:
> -       wi->bio = NULL;
> -       return err;
>  }

In this revised version, "int err" is no longer used, so could you
delete it as well ?

Regards,
Ryusuke Konishi

>
>  /**
> diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
> index b45e0d50a405..b7ebcfe6b8d3 100644
> --- a/fs/xfs/xfs_buf.c
> +++ b/fs/xfs/xfs_buf.c
> @@ -843,9 +843,6 @@ xfs_buf_readahead_map(
>  {
>         struct xfs_buf          *bp;
>
> -       if (bdi_read_congested(target->bt_bdev->bd_disk->bdi))
> -               return;
> -
>         xfs_buf_read_map(target, map, nmaps,
>                      XBF_TRYLOCK | XBF_ASYNC | XBF_READ_AHEAD, &bp, ops,
>                      __this_address);
> diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
> index 860b675c2929..2d764566280c 100644
> --- a/include/linux/backing-dev.h
> +++ b/include/linux/backing-dev.h
> @@ -135,11 +135,6 @@ static inline bool writeback_in_progress(struct bdi_writeback *wb)
>
>  struct backing_dev_info *inode_to_bdi(struct inode *inode);
>
> -static inline int wb_congested(struct bdi_writeback *wb, int cong_bits)
> -{
> -       return wb->congested & cong_bits;
> -}
> -
>  long congestion_wait(int sync, long timeout);
>
>  static inline bool mapping_can_writeback(struct address_space *mapping)
> @@ -391,27 +386,6 @@ static inline void wb_blkcg_offline(struct blkcg *blkcg)
>
>  #endif /* CONFIG_CGROUP_WRITEBACK */
>
> -static inline int bdi_congested(struct backing_dev_info *bdi, int cong_bits)
> -{
> -       return wb_congested(&bdi->wb, cong_bits);
> -}
> -
> -static inline int bdi_read_congested(struct backing_dev_info *bdi)
> -{
> -       return bdi_congested(bdi, 1 << WB_sync_congested);
> -}
> -
> -static inline int bdi_write_congested(struct backing_dev_info *bdi)
> -{
> -       return bdi_congested(bdi, 1 << WB_async_congested);
> -}
> -
> -static inline int bdi_rw_congested(struct backing_dev_info *bdi)
> -{
> -       return bdi_congested(bdi, (1 << WB_sync_congested) |
> -                                 (1 << WB_async_congested));
> -}
> -
>  const char *bdi_dev_name(struct backing_dev_info *bdi);
>
>  #endif /* _LINUX_BACKING_DEV_H */
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index ce8492939bd3..0b930556c4f2 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2362,9 +2362,7 @@ static unsigned int move_pages_to_lru(struct lruvec *lruvec,
>   */
>  static int current_may_throttle(void)
>  {
> -       return !(current->flags & PF_LOCAL_THROTTLE) ||
> -               current->backing_dev_info == NULL ||
> -               bdi_write_congested(current->backing_dev_info);
> +       return !(current->flags & PF_LOCAL_THROTTLE);
>  }
>
>  /*
>
>
