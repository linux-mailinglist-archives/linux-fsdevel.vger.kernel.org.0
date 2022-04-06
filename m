Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF654F69EC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 21:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbiDFTc5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 15:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbiDFTcC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Apr 2022 15:32:02 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB944DED6;
        Wed,  6 Apr 2022 11:27:09 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 17so4428674lji.1;
        Wed, 06 Apr 2022 11:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=14ZeLO2m8aH+YS1qjEoT4F85qJZ7QGK39BPrvGxvzsc=;
        b=FPNoADLl+t1rHvkAR4xL1rOVDAlhpOOGr+u25kx4PQUes2dgJf3VMVWx4RqhVzv0kX
         5gpTEucABhvBe61J4YvVZaXJLzFCw916y+PHHhJE/Wk03gJslw060TSXfyhR1UHGywmM
         tUGOjgO/tvv35BrogxJk0r3s4DdOfMfzpXGFBBL0VZ4D2j63zFHyR97t/y7gV0AKAs1R
         hJGS19Gw9w9127XdxMP2Q/fLKeeUGVCZ+7PdNdPrfLy3sdigpvNPW6LqW6+cm1sSbapN
         l5bvXsAYagi8cRbMUqlCJ8BHK39gp8H12JfHpjgHeRLKmO5URsKxvm9vLNu+PpYSBxuq
         Nhnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=14ZeLO2m8aH+YS1qjEoT4F85qJZ7QGK39BPrvGxvzsc=;
        b=NztxpoVwO6DaTpCClUnO2YM5hvcIOJ1s0JWVFNzArOJmfP9A+WIJlZvzxh0cYJTpx5
         6/iNP+p7CIRaFFuCeCqj/w5i/D+HcToU1WxVs4b9Es72UTOUnE/RHwjmbXqH+p5qvUnZ
         wB2JNpOuZbXq8UTGHhx9Xoahnv9Gvr4cjVyP8KiYrs+1jKKfYy/HGVX9q9KBFMcnVzsX
         jAB7qpkGRGp0BMRjIxc/BYCNfIHxMcsHA6srW3P32UWipWKl6SQAq+PsI9to0U9L+3hQ
         rHJ6J1sGwvTmW9PmvZ5eScFqutlzh8z6iDVUoTmsReaoUNz2/oy9aDQ0kf9M6Iw1TraJ
         qoTQ==
X-Gm-Message-State: AOAM533gg1ht9S0sImmTssn1zG59KFWScsdWfoZHPhY+t9Oj0NIJg4Ej
        UDvHnixHP6OXWzG7TVL2q+yc6tDFk/7SJGiIz1c=
X-Google-Smtp-Source: ABdhPJyXW8VZEbBsOkirhtMJbbJG7kJrgPict1d8+Pn0N6NHsEhNVlSmQmy+z/FM0XLhigCLmUpRJ5pzX/36OC/hFtE=
X-Received: by 2002:a2e:b008:0:b0:249:83ad:ab65 with SMTP id
 y8-20020a2eb008000000b0024983adab65mr6004527ljk.350.1649269627731; Wed, 06
 Apr 2022 11:27:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220406060516.409838-1-hch@lst.de> <20220406060516.409838-25-hch@lst.de>
In-Reply-To: <20220406060516.409838-25-hch@lst.de>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Thu, 7 Apr 2022 03:26:55 +0900
Message-ID: <CAKFNMom3wHtwHyQ0f7gTF+hSNCc716Syn5EADtzb+Sx1iSUiEA@mail.gmail.com>
Subject: Re: [PATCH 24/27] block: add a bdev_discard_granularity helper
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        device-mapper development <dm-devel@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-um@lists.infradead.org, linux-block@vger.kernel.org,
        drbd-dev@lists.linbit.com, nbd@other.debian.org,
        ceph-devel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, jfs-discussion@lists.sourceforge.net,
        linux-nilfs <linux-nilfs@vger.kernel.org>, ntfs3@lists.linux.dev,
        ocfs2-devel@oss.oracle.com, Linux MM <linux-mm@kvack.org>
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

On Wed, Apr 6, 2022 at 11:06 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Abstract away implementation details from file systems by providing a
> block_device based helper to retreive the discard granularity.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-lib.c                     |  5 ++---
>  drivers/block/drbd/drbd_nl.c        |  9 +++++----
>  drivers/block/drbd/drbd_receiver.c  |  3 +--
>  drivers/block/loop.c                |  2 +-
>  drivers/target/target_core_device.c |  3 +--
>  fs/btrfs/ioctl.c                    | 12 ++++--------
>  fs/exfat/file.c                     |  3 +--
>  fs/ext4/mballoc.c                   |  6 +++---
>  fs/f2fs/file.c                      |  3 +--
>  fs/fat/file.c                       |  3 +--
>  fs/gfs2/rgrp.c                      |  7 +++----
>  fs/jfs/ioctl.c                      |  3 +--
>  fs/nilfs2/ioctl.c                   |  4 ++--
>  fs/ntfs3/file.c                     |  4 ++--
>  fs/ntfs3/super.c                    |  6 ++----
>  fs/ocfs2/ioctl.c                    |  3 +--
>  fs/xfs/xfs_discard.c                |  4 ++--
>  include/linux/blkdev.h              |  5 +++++
>  18 files changed, 38 insertions(+), 47 deletions(-)
>
> diff --git a/block/blk-lib.c b/block/blk-lib.c
> index 8b4b66d3a9bfc..43aa4d7fe859f 100644
> --- a/block/blk-lib.c
> +++ b/block/blk-lib.c
> @@ -12,8 +12,7 @@
>
>  static sector_t bio_discard_limit(struct block_device *bdev, sector_t sector)
>  {
> -       unsigned int discard_granularity =
> -               bdev_get_queue(bdev)->limits.discard_granularity;
> +       unsigned int discard_granularity = bdev_discard_granularity(bdev);
>         sector_t granularity_aligned_sector;
>
>         if (bdev_is_partition(bdev))
> @@ -59,7 +58,7 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
>         }
>
>         /* In case the discard granularity isn't set by buggy device driver */
> -       if (WARN_ON_ONCE(!q->limits.discard_granularity)) {
> +       if (WARN_ON_ONCE(!bdev_discard_granularity(bdev))) {
>                 char dev_name[BDEVNAME_SIZE];
>
>                 bdevname(bdev, dev_name);
> diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
> index 8e28e0a8e5e41..94ac3737723a8 100644
> --- a/drivers/block/drbd/drbd_nl.c
> +++ b/drivers/block/drbd/drbd_nl.c
> @@ -1440,7 +1440,6 @@ static void sanitize_disk_conf(struct drbd_device *device, struct disk_conf *dis
>                                struct drbd_backing_dev *nbc)
>  {
>         struct block_device *bdev = nbc->backing_bdev;
> -       struct request_queue *q = bdev->bd_disk->queue;
>
>         if (disk_conf->al_extents < DRBD_AL_EXTENTS_MIN)
>                 disk_conf->al_extents = DRBD_AL_EXTENTS_MIN;
> @@ -1457,12 +1456,14 @@ static void sanitize_disk_conf(struct drbd_device *device, struct disk_conf *dis
>         if (disk_conf->rs_discard_granularity) {
>                 int orig_value = disk_conf->rs_discard_granularity;
>                 sector_t discard_size = bdev_max_discard_sectors(bdev) << 9;
> +               unsigned int discard_granularity = bdev_discard_granularity(bdev);
>                 int remainder;
>
> -               if (q->limits.discard_granularity > disk_conf->rs_discard_granularity)
> -                       disk_conf->rs_discard_granularity = q->limits.discard_granularity;
> +               if (discard_granularity > disk_conf->rs_discard_granularity)
> +                       disk_conf->rs_discard_granularity = discard_granularity;
>
> -               remainder = disk_conf->rs_discard_granularity % q->limits.discard_granularity;
> +               remainder = disk_conf->rs_discard_granularity %
> +                               discard_granularity;
>                 disk_conf->rs_discard_granularity += remainder;
>
>                 if (disk_conf->rs_discard_granularity > discard_size)
> diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
> index 8a4a47da56fe9..275c53c7b629e 100644
> --- a/drivers/block/drbd/drbd_receiver.c
> +++ b/drivers/block/drbd/drbd_receiver.c
> @@ -1511,7 +1511,6 @@ void drbd_bump_write_ordering(struct drbd_resource *resource, struct drbd_backin
>  int drbd_issue_discard_or_zero_out(struct drbd_device *device, sector_t start, unsigned int nr_sectors, int flags)
>  {
>         struct block_device *bdev = device->ldev->backing_bdev;
> -       struct request_queue *q = bdev_get_queue(bdev);
>         sector_t tmp, nr;
>         unsigned int max_discard_sectors, granularity;
>         int alignment;
> @@ -1521,7 +1520,7 @@ int drbd_issue_discard_or_zero_out(struct drbd_device *device, sector_t start, u
>                 goto zero_out;
>
>         /* Zero-sector (unknown) and one-sector granularities are the same.  */
> -       granularity = max(q->limits.discard_granularity >> 9, 1U);
> +       granularity = max(bdev_discard_granularity(bdev) >> 9, 1U);
>         alignment = (bdev_discard_alignment(bdev) >> 9) % granularity;
>
>         max_discard_sectors = min(bdev_max_discard_sectors(bdev), (1U << 22));
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 4b919b75205a7..d5499795a1fec 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -759,7 +759,7 @@ static void loop_config_discard(struct loop_device *lo)
>                 struct request_queue *backingq = bdev_get_queue(I_BDEV(inode));
>
>                 max_discard_sectors = backingq->limits.max_write_zeroes_sectors;
> -               granularity = backingq->limits.discard_granularity ?:
> +               granularity = bdev_discard_granularity(I_BDEV(inode)) ?:
>                         queue_physical_block_size(backingq);
>
>         /*
> diff --git a/drivers/target/target_core_device.c b/drivers/target/target_core_device.c
> index 7d510e4231713..ee93f0cca4228 100644
> --- a/drivers/target/target_core_device.c
> +++ b/drivers/target/target_core_device.c
> @@ -834,7 +834,6 @@ struct se_device *target_alloc_device(struct se_hba *hba, const char *name)
>  bool target_configure_unmap_from_queue(struct se_dev_attrib *attrib,
>                                        struct block_device *bdev)
>  {
> -       struct request_queue *q = bdev_get_queue(bdev);
>         int block_size = bdev_logical_block_size(bdev);
>
>         if (!bdev_max_discard_sectors(bdev))
> @@ -846,7 +845,7 @@ bool target_configure_unmap_from_queue(struct se_dev_attrib *attrib,
>          * Currently hardcoded to 1 in Linux/SCSI code..
>          */
>         attrib->max_unmap_block_desc_count = 1;
> -       attrib->unmap_granularity = q->limits.discard_granularity / block_size;
> +       attrib->unmap_granularity = bdev_discard_granularity(bdev) / block_size;
>         attrib->unmap_granularity_alignment =
>                 bdev_discard_alignment(bdev) / block_size;
>         return true;
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index fc7953755fd8b..f1a1e9519808e 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -468,7 +468,6 @@ static noinline int btrfs_ioctl_fitrim(struct btrfs_fs_info *fs_info,
>                                         void __user *arg)
>  {
>         struct btrfs_device *device;
> -       struct request_queue *q;
>         struct fstrim_range range;
>         u64 minlen = ULLONG_MAX;
>         u64 num_devices = 0;
> @@ -498,14 +497,11 @@ static noinline int btrfs_ioctl_fitrim(struct btrfs_fs_info *fs_info,
>         rcu_read_lock();
>         list_for_each_entry_rcu(device, &fs_info->fs_devices->devices,
>                                 dev_list) {
> -               if (!device->bdev)
> +               if (!device->bdev || !bdev_max_discard_sectors(device->bdev))
>                         continue;
> -               q = bdev_get_queue(device->bdev);
> -               if (bdev_max_discard_sectors(device->bdev)) {
> -                       num_devices++;
> -                       minlen = min_t(u64, q->limits.discard_granularity,
> -                                    minlen);
> -               }
> +               num_devices++;
> +               minlen = min_t(u64, bdev_discard_granularity(device->bdev),
> +                                   minlen);
>         }
>         rcu_read_unlock();
>
> diff --git a/fs/exfat/file.c b/fs/exfat/file.c
> index 765e4f63dd18d..20d4e47f57ab2 100644
> --- a/fs/exfat/file.c
> +++ b/fs/exfat/file.c
> @@ -351,7 +351,6 @@ int exfat_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
>
>  static int exfat_ioctl_fitrim(struct inode *inode, unsigned long arg)
>  {
> -       struct request_queue *q = bdev_get_queue(inode->i_sb->s_bdev);
>         struct fstrim_range range;
>         int ret = 0;
>
> @@ -365,7 +364,7 @@ static int exfat_ioctl_fitrim(struct inode *inode, unsigned long arg)
>                 return -EFAULT;
>
>         range.minlen = max_t(unsigned int, range.minlen,
> -                               q->limits.discard_granularity);
> +                               bdev_discard_granularity(inode->i_sb->s_bdev));
>
>         ret = exfat_trim_fs(inode, &range);
>         if (ret < 0)
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index c3668c977cd99..6d1820536d88d 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -6455,7 +6455,7 @@ ext4_trim_all_free(struct super_block *sb, ext4_group_t group,
>   */
>  int ext4_trim_fs(struct super_block *sb, struct fstrim_range *range)
>  {
> -       struct request_queue *q = bdev_get_queue(sb->s_bdev);
> +       unsigned int discard_granularity = bdev_discard_granularity(sb->s_bdev);
>         struct ext4_group_info *grp;
>         ext4_group_t group, first_group, last_group;
>         ext4_grpblk_t cnt = 0, first_cluster, last_cluster;
> @@ -6475,9 +6475,9 @@ int ext4_trim_fs(struct super_block *sb, struct fstrim_range *range)
>             range->len < sb->s_blocksize)
>                 return -EINVAL;
>         /* No point to try to trim less than discard granularity */
> -       if (range->minlen < q->limits.discard_granularity) {
> +       if (range->minlen < discard_granularity) {
>                 minlen = EXT4_NUM_B2C(EXT4_SB(sb),
> -                       q->limits.discard_granularity >> sb->s_blocksize_bits);
> +                               discard_granularity >> sb->s_blocksize_bits);
>                 if (minlen > EXT4_CLUSTERS_PER_GROUP(sb))
>                         goto out;
>         }
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 5b89af0f27f05..8053d99f3920b 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -2285,7 +2285,6 @@ static int f2fs_ioc_fitrim(struct file *filp, unsigned long arg)
>  {
>         struct inode *inode = file_inode(filp);
>         struct super_block *sb = inode->i_sb;
> -       struct request_queue *q = bdev_get_queue(sb->s_bdev);
>         struct fstrim_range range;
>         int ret;
>
> @@ -2304,7 +2303,7 @@ static int f2fs_ioc_fitrim(struct file *filp, unsigned long arg)
>                 return ret;
>
>         range.minlen = max((unsigned int)range.minlen,
> -                               q->limits.discard_granularity);
> +                          bdev_discard_granularity(sb->s_bdev));
>         ret = f2fs_trim_fs(F2FS_SB(sb), &range);
>         mnt_drop_write_file(filp);
>         if (ret < 0)
> diff --git a/fs/fat/file.c b/fs/fat/file.c
> index e4c7d10e80129..bf91f977debea 100644
> --- a/fs/fat/file.c
> +++ b/fs/fat/file.c
> @@ -127,7 +127,6 @@ static int fat_ioctl_fitrim(struct inode *inode, unsigned long arg)
>         struct super_block *sb = inode->i_sb;
>         struct fstrim_range __user *user_range;
>         struct fstrim_range range;
> -       struct request_queue *q = bdev_get_queue(sb->s_bdev);
>         int err;
>
>         if (!capable(CAP_SYS_ADMIN))
> @@ -141,7 +140,7 @@ static int fat_ioctl_fitrim(struct inode *inode, unsigned long arg)
>                 return -EFAULT;
>
>         range.minlen = max_t(unsigned int, range.minlen,
> -                            q->limits.discard_granularity);
> +                            bdev_discard_granularity(sb->s_bdev));
>
>         err = fat_trim_fs(inode, &range);
>         if (err < 0)
> diff --git a/fs/gfs2/rgrp.c b/fs/gfs2/rgrp.c
> index 7f20ac9133bc6..6d26bb5254844 100644
> --- a/fs/gfs2/rgrp.c
> +++ b/fs/gfs2/rgrp.c
> @@ -1386,7 +1386,7 @@ int gfs2_fitrim(struct file *filp, void __user *argp)
>  {
>         struct inode *inode = file_inode(filp);
>         struct gfs2_sbd *sdp = GFS2_SB(inode);
> -       struct request_queue *q = bdev_get_queue(sdp->sd_vfs->s_bdev);
> +       struct block_device *bdev = sdp->sd_vfs->s_bdev;
>         struct buffer_head *bh;
>         struct gfs2_rgrpd *rgd;
>         struct gfs2_rgrpd *rgd_end;
> @@ -1405,7 +1405,7 @@ int gfs2_fitrim(struct file *filp, void __user *argp)
>         if (!test_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags))
>                 return -EROFS;
>
> -       if (!bdev_max_discard_sectors(sdp->sd_vfs->s_bdev))
> +       if (!bdev_max_discard_sectors(bdev))
>                 return -EOPNOTSUPP;
>
>         if (copy_from_user(&r, argp, sizeof(r)))
> @@ -1418,8 +1418,7 @@ int gfs2_fitrim(struct file *filp, void __user *argp)
>         start = r.start >> bs_shift;
>         end = start + (r.len >> bs_shift);
>         minlen = max_t(u64, r.minlen, sdp->sd_sb.sb_bsize);
> -       minlen = max_t(u64, minlen,
> -                      q->limits.discard_granularity) >> bs_shift;
> +       minlen = max_t(u64, minlen, bdev_discard_granularity(bdev)) >> bs_shift;
>
>         if (end <= start || minlen > sdp->sd_max_rg_data)
>                 return -EINVAL;
> diff --git a/fs/jfs/ioctl.c b/fs/jfs/ioctl.c
> index 357ae6e5c36ec..1e7b177ece605 100644
> --- a/fs/jfs/ioctl.c
> +++ b/fs/jfs/ioctl.c
> @@ -110,7 +110,6 @@ long jfs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>         case FITRIM:
>         {
>                 struct super_block *sb = inode->i_sb;
> -               struct request_queue *q = bdev_get_queue(sb->s_bdev);
>                 struct fstrim_range range;
>                 s64 ret = 0;
>
> @@ -127,7 +126,7 @@ long jfs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>                         return -EFAULT;
>
>                 range.minlen = max_t(unsigned int, range.minlen,
> -                       q->limits.discard_granularity);
> +                                    bdev_discard_granularity(sb->s_bdev));
>
>                 ret = jfs_ioc_trim(inode, &range);
>                 if (ret < 0)
> diff --git a/fs/nilfs2/ioctl.c b/fs/nilfs2/ioctl.c
> index 52b73f558fcb1..87e1004b606d2 100644
> --- a/fs/nilfs2/ioctl.c
> +++ b/fs/nilfs2/ioctl.c
> @@ -1052,7 +1052,6 @@ static int nilfs_ioctl_resize(struct inode *inode, struct file *filp,
>  static int nilfs_ioctl_trim_fs(struct inode *inode, void __user *argp)
>  {
>         struct the_nilfs *nilfs = inode->i_sb->s_fs_info;
> -       struct request_queue *q = bdev_get_queue(nilfs->ns_bdev);
>         struct fstrim_range range;
>         int ret;
>
> @@ -1065,7 +1064,8 @@ static int nilfs_ioctl_trim_fs(struct inode *inode, void __user *argp)
>         if (copy_from_user(&range, argp, sizeof(range)))
>                 return -EFAULT;
>
> -       range.minlen = max_t(u64, range.minlen, q->limits.discard_granularity);
> +       range.minlen = max_t(u64, range.minlen,
> +                            bdev_discard_granularity(nilfs->ns_bdev));
>
>         down_read(&nilfs->ns_segctor_sem);
>         ret = nilfs_sufile_trim_fs(nilfs->ns_sufile, &range);
> diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
> index e763236169331..15806eeae217a 100644
> --- a/fs/ntfs3/file.c
> +++ b/fs/ntfs3/file.c
> @@ -22,7 +22,6 @@ static int ntfs_ioctl_fitrim(struct ntfs_sb_info *sbi, unsigned long arg)
>  {
>         struct fstrim_range __user *user_range;
>         struct fstrim_range range;
> -       struct request_queue *q = bdev_get_queue(sbi->sb->s_bdev);
>         int err;
>
>         if (!capable(CAP_SYS_ADMIN))
> @@ -35,7 +34,8 @@ static int ntfs_ioctl_fitrim(struct ntfs_sb_info *sbi, unsigned long arg)
>         if (copy_from_user(&range, user_range, sizeof(range)))
>                 return -EFAULT;
>
> -       range.minlen = max_t(u32, range.minlen, q->limits.discard_granularity);
> +       range.minlen = max_t(u32, range.minlen,
> +                            bdev_discard_granularity(sbi->sb->s_bdev));
>
>         err = ntfs_trim_fs(sbi, &range);
>         if (err < 0)
> diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
> index c734085bcce4a..5f2e414cfa79b 100644
> --- a/fs/ntfs3/super.c
> +++ b/fs/ntfs3/super.c
> @@ -882,7 +882,6 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
>         int err;
>         struct ntfs_sb_info *sbi = sb->s_fs_info;
>         struct block_device *bdev = sb->s_bdev;
> -       struct request_queue *rq;
>         struct inode *inode;
>         struct ntfs_inode *ni;
>         size_t i, tt;
> @@ -912,9 +911,8 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
>                 goto out;
>         }
>
> -       rq = bdev_get_queue(bdev);
> -       if (bdev_max_discard_sectors(bdev) && rq->limits.discard_granularity) {
> -               sbi->discard_granularity = rq->limits.discard_granularity;
> +       if (bdev_max_discard_sectors(bdev) && bdev_discard_granularity(bdev)) {
> +               sbi->discard_granularity = bdev_discard_granularity(bdev);
>                 sbi->discard_granularity_mask_inv =
>                         ~(u64)(sbi->discard_granularity - 1);
>         }
> diff --git a/fs/ocfs2/ioctl.c b/fs/ocfs2/ioctl.c
> index 9b78ef103ada6..afd54ec661030 100644
> --- a/fs/ocfs2/ioctl.c
> +++ b/fs/ocfs2/ioctl.c
> @@ -903,7 +903,6 @@ long ocfs2_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>         case FITRIM:
>         {
>                 struct super_block *sb = inode->i_sb;
> -               struct request_queue *q = bdev_get_queue(sb->s_bdev);
>                 struct fstrim_range range;
>                 int ret = 0;
>
> @@ -916,7 +915,7 @@ long ocfs2_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>                 if (copy_from_user(&range, argp, sizeof(range)))
>                         return -EFAULT;
>
> -               range.minlen = max_t(u64, q->limits.discard_granularity,
> +               range.minlen = max_t(u64, bdev_discard_granularity(sb->s_bdev),
>                                      range.minlen);
>                 ret = ocfs2_trim_fs(sb, &range);
>                 if (ret < 0)
> diff --git a/fs/xfs/xfs_discard.c b/fs/xfs/xfs_discard.c
> index a4e6609d616b7..e2ada115c23f9 100644
> --- a/fs/xfs/xfs_discard.c
> +++ b/fs/xfs/xfs_discard.c
> @@ -152,8 +152,8 @@ xfs_ioc_trim(
>         struct xfs_mount                *mp,
>         struct fstrim_range __user      *urange)
>  {
> -       struct request_queue    *q = bdev_get_queue(mp->m_ddev_targp->bt_bdev);
> -       unsigned int            granularity = q->limits.discard_granularity;
> +       unsigned int            granularity =
> +               bdev_discard_granularity(mp->m_ddev_targp->bt_bdev);
>         struct fstrim_range     range;
>         xfs_daddr_t             start, end, minlen;
>         xfs_agnumber_t          start_agno, end_agno, agno;
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index ce16247d3afab..7b9c0cf95d2d5 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1259,6 +1259,11 @@ static inline unsigned int bdev_max_discard_sectors(struct block_device *bdev)
>         return bdev_get_queue(bdev)->limits.max_discard_sectors;
>  }
>
> +static inline unsigned int bdev_discard_granularity(struct block_device *bdev)
> +{
> +       return bdev_get_queue(bdev)->limits.discard_granularity;
> +}
> +
>  static inline unsigned int bdev_write_zeroes_sectors(struct block_device *bdev)
>  {
>         struct request_queue *q = bdev_get_queue(bdev);
> --
> 2.30.2
>

I got the following checkpatch warning:

 WARNING: 'retreive' may be misspelled - perhaps 'retrieve'?
 #101:
 block_device based helper to retreive the discard granularity.
                              ^^^^^^^^

 total: 0 errors, 1 warnings, 294 lines checked


The changes themselves look good.

Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>

Thanks,
Ryusuke Konishi
