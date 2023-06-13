Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4CC72DA27
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jun 2023 08:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbjFMGuL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jun 2023 02:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239505AbjFMGty (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jun 2023 02:49:54 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1AB410D5
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jun 2023 23:49:52 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-516500163b2so4639a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jun 2023 23:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686638991; x=1689230991;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VjR/fYUWn3umct4pW+zuI2U1QWYzY0R84dwWOwLWrpo=;
        b=JLNYrc6NOkPmurlIdGQ+Qlh6LMA21xvl+T6tXY1PaOBM5uZpYHKDSLuU+R2S9PQSFi
         wCnvBvmhjftLerah1sdnENVbfCFaqC7l2Qt4rY3t6U2OCqMgP9mxo3lEQbhzCUVNr0Li
         ZDfgmmSZ3l04trLrHx4s+WiEz7DStQbxBQhg8Jvi1OZOEEQhaSzUJjbWZxr/NraHFKag
         dm3X5PrvbvErENcF/xd4z9jLrYMNZAFoY/lDkmr7NvrzL0R4i85MxF/64QeeCCW0RQid
         e2OYkHKUngsOHJsWq6jKSriiigq8bHNficwusSAMnTea7egFpMOcs0SQmCeV93nMPkGI
         dz+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686638991; x=1689230991;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VjR/fYUWn3umct4pW+zuI2U1QWYzY0R84dwWOwLWrpo=;
        b=IvkkSserfnBkY+myMOxqhU4cQfUuFZU5zLYONm+mkhGFF2U62oS3Y+LPKwOsTUNpQt
         09joKsRgHGr/2jHCKLtPWPjO0bV1MjRswF9dFk0c/x85Bbcp3dbcXMToeGzi7RWy3bS9
         FnGqDhNbSAMyUreCcXC0NpkrhSZxZr6Pa7FOHEmjMHaNKZcLChlDGxf8MLola0WZRr8m
         J5SOU6z4o1g2y4PhyNFAgRletrWM8UZFBC7UMKvuh8Pa+Cf9eoR0zslS2xjSmBG6RSZ8
         VtT+wAahBudV5q7sqN65YrWc7BVGyC1bQskY9wTqxbOozc6rXqknWNZhmV76RE9X3Phf
         JJGg==
X-Gm-Message-State: AC+VfDzjnK25Gi0GTM7USleJM+KTcNjlcreo17GAeowGU5FQHqUlhhQX
        5xCsHletMDX1amy+J60WDsTMZr9i3g/7h8etb0ioiA==
X-Google-Smtp-Source: ACHHUZ53qQZXD+nhjv6r4nfEMpCaVRQ5pPPzaMtxYepckzuvrZgGePDWTHfVaTqks5Jbo8xRNiafmt+gqE7EiqCfDas=
X-Received: by 2002:a50:9ee3:0:b0:50d:bb88:a80c with SMTP id
 a90-20020a509ee3000000b0050dbb88a80cmr14250edf.3.1686638991079; Mon, 12 Jun
 2023 23:49:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230612161614.10302-1-jack@suse.cz>
In-Reply-To: <20230612161614.10302-1-jack@suse.cz>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 13 Jun 2023 08:49:38 +0200
Message-ID: <CACT4Y+aEScXmq2F1-vqAfr-b2w-xyOohN+FZxorW1YuRvKDLNQ@mail.gmail.com>
Subject: Re: [PATCH] block: Add config option to not allow writing to mounted devices
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>, Ted Tso <tytso@mit.edu>,
        yebin <yebin@huaweicloud.com>, linux-fsdevel@vger.kernel.org,
        Kees Cook <keescook@google.com>,
        Alexander Popov <alex.popov@linux.com>,
        syzkaller <syzkaller@googlegroups.com>,
        Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 12 Jun 2023 at 18:16, Jan Kara <jack@suse.cz> wrote:
>
> Writing to mounted devices is dangerous and can lead to filesystem
> corruption as well as crashes. Furthermore syzbot comes with more and
> more involved examples how to corrupt block device under a mounted
> filesystem leading to kernel crashes and reports we can do nothing
> about. Add config option to disallow writing to mounted (exclusively
> open) block devices. Syzbot can use this option to avoid uninteresting
> crashes. Also users whose userspace setup does not need writing to
> mounted block devices can set this config option for hardening.

+syzkaller, Kees, Alexander, Eric

We can enable this on syzbot, however I have the same concerns as with
disabling of XFS_SUPPORT_V4:
https://github.com/google/syzkaller/issues/3918#issuecomment-1560624278

It's useful to know the actual situation with respect to
bugs/vulnerabilities and one of the goals of syzbot is surfacing this
situation.
For some areas there is mismatch between upstream kernel and
downstream distros. Upstream says "this is buggy and deprecated",
which is fine in itself if not the other part: downstream distros
simply ignore that (maybe not even aware) and keep things enabled for
as long as possible. Stopping testing this is moving more in this
direction: silencing warnings and pretending that everything is fine,
when it's not.

I wonder if there is a way to at least somehow bridge this gap.

There is CONFIG_BROKEN, but not sure if it's the right thing here.
Maybe we add something like CONFIG_INSECURE. And such insecure config
settings (not setting BLK_DEV_WRITE_HARDENING, setting XFS_SUPPORT_V4)
will say:

depends on INSECURE

So that distros will need to at least acknowledge this to users by saying:

CONFIG_INSECURE=y

They are then motivated to work on actually removing dependencies on
these deprecated things.

CONFIG_INSECURE description can say something along the lines of "this
kernel includes subsystems with known bugs that may cause security and
data integrity issues". When a subsystem adds "depends on INSECURE",
the commit should list some of the known issues.

Then I see how trading disabling things on syzbot in exchange for
"depends on INSECURE" becomes reasonable and satisfies all parties to
some degree.

Btw, if we do this it can make sense to invert this config (enable
concurrent writes), default to 'y' and recommend 'n'.

Does it make any sense? Any other suggestions?

P.S. Alex, if this lands this may be a candidate for addition to:
https://github.com/a13xp0p0v/kconfig-hardened-check
(and XFS_SUPPORT_V4 as well).



> Link: https://lore.kernel.org/all/60788e5d-5c7c-1142-e554-c21d709acfd9@linaro.org
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  block/Kconfig             | 12 ++++++++++++
>  block/bdev.c              | 10 ++++++++++
>  include/linux/blk_types.h |  3 +++
>  3 files changed, 25 insertions(+)
>
> FWIW I've tested this and my test VM with ext4 root fs boots fine and fstests
> on ext4 seem to be also running fine with BLK_DEV_WRITE_HARDENING enabled.
> OTOH my old VM setup which is not using initrd fails to boot with
> BLK_DEV_WRITE_HARDENING enabled because fsck cannot open the root device
> because the root is already mounted (read-only). Anyway this should be useful
> for syzbot (Dmitry indicated interest in this option in the past) and maybe
> other well controlled setups.
>
> diff --git a/block/Kconfig b/block/Kconfig
> index 86122e459fe0..c44e2238e18d 100644
> --- a/block/Kconfig
> +++ b/block/Kconfig
> @@ -77,6 +77,18 @@ config BLK_DEV_INTEGRITY_T10
>         select CRC_T10DIF
>         select CRC64_ROCKSOFT
>
> +config BLK_DEV_WRITE_HARDENING
> +       bool "Do not allow writing to mounted devices"
> +       help
> +       When a block device is mounted, writing to its buffer cache very likely
> +       going to cause filesystem corruption. It is also rather easy to crash
> +       the kernel in this way since the filesystem has no practical way of
> +       detecting these writes to buffer cache and verifying its metadata
> +       integrity. Select this option to disallow writing to mounted devices.
> +       This should be mostly fine but some filesystems (e.g. ext4) rely on
> +       the ability of filesystem tools to write to mounted filesystems to
> +       set e.g. UUID or run fsck on the root filesystem in some setups.
> +
>  config BLK_DEV_ZONED
>         bool "Zoned block device support"
>         select MQ_IOSCHED_DEADLINE
> diff --git a/block/bdev.c b/block/bdev.c
> index 21c63bfef323..ad01f0a6af0d 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -602,6 +602,12 @@ static int blkdev_get_whole(struct block_device *bdev, fmode_t mode)
>         struct gendisk *disk = bdev->bd_disk;
>         int ret;
>
> +       if (IS_ENABLED(BLK_DEV_WRITE_HARDENING)) {
> +               if (mode & FMODE_EXCL && atomic_read(&bdev->bd_writers) > 0)
> +                       return -EBUSY;
> +               if (mode & FMODE_WRITE && bdev->bd_holders > 0)
> +                       return -EBUSY;
> +       }
>         if (disk->fops->open) {
>                 ret = disk->fops->open(bdev, mode);
>                 if (ret) {
> @@ -617,6 +623,8 @@ static int blkdev_get_whole(struct block_device *bdev, fmode_t mode)
>                 set_init_blocksize(bdev);
>         if (test_bit(GD_NEED_PART_SCAN, &disk->state))
>                 bdev_disk_changed(disk, false);
> +       if (IS_ENABLED(BLK_DEV_WRITE_HARDENING) && mode & FMODE_WRITE)
> +               atomic_inc(&bdev->bd_writers);
>         atomic_inc(&bdev->bd_openers);
>         return 0;
>  }
> @@ -625,6 +633,8 @@ static void blkdev_put_whole(struct block_device *bdev, fmode_t mode)
>  {
>         if (atomic_dec_and_test(&bdev->bd_openers))
>                 blkdev_flush_mapping(bdev);
> +       if (IS_ENABLED(BLK_DEV_WRITE_HARDENING) && mode & FMODE_WRITE)
> +               atomic_dec(&bdev->bd_writers);
>         if (bdev->bd_disk->fops->release)
>                 bdev->bd_disk->fops->release(bdev->bd_disk, mode);
>  }
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 740afe80f297..25af3340f316 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -67,6 +67,9 @@ struct block_device {
>         struct partition_meta_info *bd_meta_info;
>  #ifdef CONFIG_FAIL_MAKE_REQUEST
>         bool                    bd_make_it_fail;
> +#endif
> +#ifdef CONFIG_BLK_DEV_WRITE_HARDENING
> +       atomic_t                bd_writers;
>  #endif
>         /*
>          * keep this out-of-line as it's both big and not needed in the fast
> --
> 2.35.3
>
