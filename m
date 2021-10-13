Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA2942B7A1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Oct 2021 08:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238142AbhJMGlc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Oct 2021 02:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238119AbhJMGla (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Oct 2021 02:41:30 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538B3C061764
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Oct 2021 23:39:27 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id np13so1400088pjb.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Oct 2021 23:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DD/2eDntZRvmYFLabpX6hx1U0eeFdg0nt6CnyRZUcUo=;
        b=BK3/LJ89flw5mVlU3UcEyxJ6LbnnmcNslFQOP5bfSd/QHd96C82eb1OGM/6y9E9tVZ
         +RxJ42PRvcA8OnuNTe7jWQrLB4kIfwLscnkVOAeCEBYDFaLLczsrzmikDhrnLSmHevHI
         DJYQS0KGPHFoIgmlnCi12Zqd0uHHCS6ptE1xE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DD/2eDntZRvmYFLabpX6hx1U0eeFdg0nt6CnyRZUcUo=;
        b=6qK6i87ee/TqMMxuO5fsyGmhWfYo9LywtzIQaM9Rr9sDjNsSHE6N2+1yQ65AJvgKXK
         SPowD6a9NSEZtT5IsxWXHBfCl9RBAVRj0YuUDjgy6IEAxjKJc+l6GPbp9yodn2NXs6lW
         VFrCGa4O+rrjobiXhLPS8VtrF2CYyVQGRU7AyHE7TR85/wWbaUQElri0vV670yliPrJV
         GgOdh1YonBPUWCuhIoPLrkSktjNPtNamIVVTjJRTV2YXhhMug/3MERSHocEQbH9flCaB
         CNouL+t1LfdS50LqEGjcEgpgTJvn9s1DNnBnyFZNn/XUvFfjs0HTAvOVNgYo91Btqukn
         8B4g==
X-Gm-Message-State: AOAM531EPuzsdjN44NvqsjjAE7+K4SVfsFx1mjYQycjPiw+25bCLo8v5
        DPH0YS3wXPZzdn6wu/gdYWBodw==
X-Google-Smtp-Source: ABdhPJz6dN+fakHkI4mmw5FMrWYwE5jr866artFMUIcBHqytxUEdEx+T1ampoWpSo+mgvVckvfVoUQ==
X-Received: by 2002:a17:90b:4b4f:: with SMTP id mi15mr808506pjb.97.1634107166729;
        Tue, 12 Oct 2021 23:39:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y17sm9562796pfn.96.2021.10.12.23.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 23:39:26 -0700 (PDT)
Date:   Tue, 12 Oct 2021 23:39:25 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Coly Li <colyli@suse.de>,
        Mike Snitzer <snitzer@redhat.com>, Song Liu <song@kernel.org>,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Theodore Ts'o <tytso@mit.edu>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Dave Kleikamp <shaggy@kernel.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Anton Altaparmakov <anton@tuxera.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        dm-devel@redhat.com, drbd-dev@lists.linbit.com,
        linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
        linux-nfs@vger.kernel.org, linux-nilfs@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, ntfs3@lists.linux.dev,
        reiserfs-devel@vger.kernel.org
Subject: Re: don't use ->bd_inode to access the block device size
Message-ID: <202110122335.19348E8E8@keescook>
References: <20211013051042.1065752-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013051042.1065752-1-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 13, 2021 at 07:10:13AM +0200, Christoph Hellwig wrote:
> I wondered about adding a helper for looking at the size in byte units
> to avoid the SECTOR_SHIFT shifts in various places.  But given that
> I could not come up with a good name and block devices fundamentally
> work in sector size granularity I decided against that.

Without something like bdev_nr_bytes(), this series has 13 of 29 patches
actually _adding_ an open-coded calculation:

[PATCH 05/29] mtd/block2mtd: use bdev_nr_sectors instead of open coding it
[PATCH 06/29] nvmet: use bdev_nr_sectors instead of open coding it
[PATCH 07/29] target/iblock: use bdev_nr_sectors instead of open coding it
[PATCH 08/29] fs: use bdev_nr_sectors instead of open coding it in blkdev_max_block
[PATCH 11/29] btrfs: use bdev_nr_sectors instead of open coding it
[PATCH 16/29] jfs: use bdev_nr_sectors instead of open coding it
[PATCH 17/29] nfs/blocklayout: use bdev_nr_sectors instead of open coding it
[PATCH 18/29] nilfs2: use bdev_nr_sectors instead of open coding it
[PATCH 19/29] ntfs3: use bdev_nr_sectors instead of open coding it
[PATCH 20/29] pstore/blk: use bdev_nr_sectors instead of open coding it
[PATCH 21/29] reiserfs: use bdev_nr_sectors instead of open coding it
[PATCH 22/29] squashfs: use bdev_nr_sectors instead of open coding it
[PATCH 23/29] block: use bdev_nr_sectors instead of open coding it in blkdev_fallocate

I think it's well worth having that helper (or at least leaving these
alone). Otherwise, this is a lot of churn without a clear net benefit,
IMO.

The others look good to me, though!

-Kees

>
> Diffstat:
>  block/fops.c                        |    2 +-
>  drivers/block/drbd/drbd_int.h       |    3 +--
>  drivers/md/bcache/super.c           |    2 +-
>  drivers/md/bcache/util.h            |    4 ----
>  drivers/md/bcache/writeback.c       |    2 +-
>  drivers/md/dm-bufio.c               |    2 +-
>  drivers/md/dm-cache-metadata.c      |    2 +-
>  drivers/md/dm-cache-target.c        |    2 +-
>  drivers/md/dm-clone-target.c        |    2 +-
>  drivers/md/dm-dust.c                |    5 ++---
>  drivers/md/dm-ebs-target.c          |    2 +-
>  drivers/md/dm-era-target.c          |    2 +-
>  drivers/md/dm-exception-store.h     |    2 +-
>  drivers/md/dm-flakey.c              |    3 +--
>  drivers/md/dm-integrity.c           |    6 +++---
>  drivers/md/dm-linear.c              |    3 +--
>  drivers/md/dm-log-writes.c          |    4 ++--
>  drivers/md/dm-log.c                 |    2 +-
>  drivers/md/dm-mpath.c               |    2 +-
>  drivers/md/dm-raid.c                |    6 +++---
>  drivers/md/dm-switch.c              |    2 +-
>  drivers/md/dm-table.c               |    3 +--
>  drivers/md/dm-thin-metadata.c       |    2 +-
>  drivers/md/dm-thin.c                |    2 +-
>  drivers/md/dm-verity-target.c       |    3 +--
>  drivers/md/dm-writecache.c          |    2 +-
>  drivers/md/dm-zoned-target.c        |    2 +-
>  drivers/md/md.c                     |   26 +++++++++++---------------
>  drivers/mtd/devices/block2mtd.c     |    5 +++--
>  drivers/nvme/target/io-cmd-bdev.c   |    4 ++--
>  drivers/target/target_core_iblock.c |    5 +++--
>  fs/affs/super.c                     |    2 +-
>  fs/btrfs/dev-replace.c              |    2 +-
>  fs/btrfs/disk-io.c                  |    3 ++-
>  fs/btrfs/ioctl.c                    |    4 ++--
>  fs/btrfs/volumes.c                  |    7 ++++---
>  fs/buffer.c                         |    4 ++--
>  fs/cramfs/inode.c                   |    2 +-
>  fs/ext4/super.c                     |    2 +-
>  fs/fat/inode.c                      |    5 +----
>  fs/hfs/mdb.c                        |    2 +-
>  fs/hfsplus/wrapper.c                |    2 +-
>  fs/jfs/resize.c                     |    5 ++---
>  fs/jfs/super.c                      |    5 ++---
>  fs/nfs/blocklayout/dev.c            |    4 ++--
>  fs/nilfs2/ioctl.c                   |    2 +-
>  fs/nilfs2/super.c                   |    2 +-
>  fs/nilfs2/the_nilfs.c               |    3 ++-
>  fs/ntfs/super.c                     |    8 +++-----
>  fs/ntfs3/super.c                    |    3 +--
>  fs/pstore/blk.c                     |    4 ++--
>  fs/reiserfs/super.c                 |    7 ++-----
>  fs/squashfs/super.c                 |    5 +++--
>  fs/udf/lowlevel.c                   |    5 ++---
>  fs/udf/super.c                      |    9 +++------
>  include/linux/genhd.h               |    6 ++++++
>  56 files changed, 100 insertions(+), 117 deletions(-)

--
Kees Cook
