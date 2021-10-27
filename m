Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB84F43D33E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Oct 2021 22:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244094AbhJ0U4A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Oct 2021 16:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234080AbhJ0Uz7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Oct 2021 16:55:59 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583A4C061570
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Oct 2021 13:53:33 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id r5so2904108pls.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Oct 2021 13:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JF27tid0jnJ4Lv4ojsqdS1ywAxF2Yh/rXBicw2Nx/Bg=;
        b=1isnZNLrwmgFC3LXRliYMUrYtu55I8EQQ7pQxVF+w9vAU0wMFXPxuqqMaEfcBFZxXg
         qcnLJVTOmdX1rGsKPaKzFF9Qu8Ee1ZOBQ182Hw4pibX9D4X5BrxrW8qLlaMVoa3uA3Tk
         KGDMGjWdaecMTrVHOCSpZJWK2sZUzx48BP4iJpaAETHGMQ4UeJfwWrv7HXh9aCqjIq+2
         9ALeonJXxoVD6TAd61eVgIdGSZeRVRycG+QFqApL/sPZtYnF3KhgHnv0ssu3/ANRUj/4
         POtGkuO11AqaPuPuXfXiiUY+Tsb2EtZLFRQXaHjr8SeP+pOqWQy14Q9lU0490jcBhr1l
         CXAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JF27tid0jnJ4Lv4ojsqdS1ywAxF2Yh/rXBicw2Nx/Bg=;
        b=SoianBLQpPpIkDXDyHcYI3GWmzmzys8nEpGqm8OT6eXzV+vb07DbbbQ65FZL9LsPa3
         RvM4SBitkcHF4b4z3aFE89ToP1kpn/Qm0eUSwIVtbbK8GEwAlTuxYLq50KL1zK4CNMUW
         uWebC6p/cNzzHJeOhadGnxcBp7J0OQZgexinougPTZhZ+/bC97v7ZV5VqLbYnEUUnN7y
         5S0mvB77ReIlrA/8fLpUfuCVR8AwFRW9mXUpcUCz6yDIzCluf7w3PoAouyjMtYmJBEsh
         MYXhinanB8MEM/iTAdKsvW22QOQKNJ51gzZSyrBZwgo5Uf5P0QNoWmJbPJFcfDEb9bn9
         d91w==
X-Gm-Message-State: AOAM532VK1uu4xfzl/RCITElGo8WnUQaCX2ANAOvREjjRO808tuViNVG
        NXT4P2XsmStmlyeb3zT+dSO2unvPRWFWecofr9qSfYNnNYY=
X-Google-Smtp-Source: ABdhPJzghlFw+zkjpuNy8dyEqDgjwZ/Nb0+yCd5621faImzBOeUtIgX/3CShbYonbAi1vtWBePJ7pkat1hh6sB8QXRU=
X-Received: by 2002:a17:90b:3b88:: with SMTP id pc8mr3618pjb.93.1635368012904;
 Wed, 27 Oct 2021 13:53:32 -0700 (PDT)
MIME-Version: 1.0
References: <20211018044054.1779424-1-hch@lst.de> <20211018044054.1779424-2-hch@lst.de>
In-Reply-To: <20211018044054.1779424-2-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 27 Oct 2021 13:53:21 -0700
Message-ID: <CAPcyv4hrEPizMOH-XhCqh=23EJDG=W6VwvQ1pVstfe-Jm-AsiQ@mail.gmail.com>
Subject: Re: [PATCH 01/11] dm: make the DAX support dependend on CONFIG_FS_DAX
To:     Christoph Hellwig <hch@lst.de>, Mike Snitzer <snitzer@redhat.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        device-mapper development <dm-devel@redhat.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Oct 17, 2021 at 9:41 PM Christoph Hellwig <hch@lst.de> wrote:
>
> The device mapper DAX support is all hanging off a block device and thus
> can't be used with device dax.  Make it depend on CONFIG_FS_DAX instead
> of CONFIG_DAX_DRIVER.  This also means that bdev_dax_pgoff only needs to
> be built under CONFIG_FS_DAX now.

Looks good.

Mike, can I get an ack to take this through nvdimm.git? (you'll likely
see me repeat this question on subsequent patches in this series).

>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/dax/super.c        | 6 ++----
>  drivers/md/dm-linear.c     | 2 +-
>  drivers/md/dm-log-writes.c | 2 +-
>  drivers/md/dm-stripe.c     | 2 +-
>  drivers/md/dm-writecache.c | 2 +-
>  drivers/md/dm.c            | 2 +-
>  6 files changed, 7 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index b882cf8106ea3..e20d0cef10a18 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -63,7 +63,7 @@ static int dax_host_hash(const char *host)
>         return hashlen_hash(hashlen_string("DAX", host)) % DAX_HASH_SIZE;
>  }
>
> -#ifdef CONFIG_BLOCK
> +#if defined(CONFIG_BLOCK) && defined(CONFIG_FS_DAX)
>  #include <linux/blkdev.h>
>
>  int bdev_dax_pgoff(struct block_device *bdev, sector_t sector, size_t size,
> @@ -80,7 +80,6 @@ int bdev_dax_pgoff(struct block_device *bdev, sector_t sector, size_t size,
>  }
>  EXPORT_SYMBOL(bdev_dax_pgoff);
>
> -#if IS_ENABLED(CONFIG_FS_DAX)
>  /**
>   * dax_get_by_host() - temporary lookup mechanism for filesystem-dax
>   * @host: alternate name for the device registered by a dax driver
> @@ -219,8 +218,7 @@ bool dax_supported(struct dax_device *dax_dev, struct block_device *bdev,
>         return ret;
>  }
>  EXPORT_SYMBOL_GPL(dax_supported);
> -#endif /* CONFIG_FS_DAX */
> -#endif /* CONFIG_BLOCK */
> +#endif /* CONFIG_BLOCK && CONFIG_FS_DAX */
>
>  enum dax_device_flags {
>         /* !alive + rcu grace period == no new operations / mappings */
> diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
> index 679b4c0a2eea1..32fbab11bf90c 100644
> --- a/drivers/md/dm-linear.c
> +++ b/drivers/md/dm-linear.c
> @@ -163,7 +163,7 @@ static int linear_iterate_devices(struct dm_target *ti,
>         return fn(ti, lc->dev, lc->start, ti->len, data);
>  }
>
> -#if IS_ENABLED(CONFIG_DAX_DRIVER)
> +#if IS_ENABLED(CONFIG_FS_DAX)
>  static long linear_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
>                 long nr_pages, void **kaddr, pfn_t *pfn)
>  {
> diff --git a/drivers/md/dm-log-writes.c b/drivers/md/dm-log-writes.c
> index d93a4db235124..6d694526881d0 100644
> --- a/drivers/md/dm-log-writes.c
> +++ b/drivers/md/dm-log-writes.c
> @@ -903,7 +903,7 @@ static void log_writes_io_hints(struct dm_target *ti, struct queue_limits *limit
>         limits->io_min = limits->physical_block_size;
>  }
>
> -#if IS_ENABLED(CONFIG_DAX_DRIVER)
> +#if IS_ENABLED(CONFIG_FS_DAX)
>  static int log_dax(struct log_writes_c *lc, sector_t sector, size_t bytes,
>                    struct iov_iter *i)
>  {
> diff --git a/drivers/md/dm-stripe.c b/drivers/md/dm-stripe.c
> index 6660b6b53d5bf..f084607220293 100644
> --- a/drivers/md/dm-stripe.c
> +++ b/drivers/md/dm-stripe.c
> @@ -300,7 +300,7 @@ static int stripe_map(struct dm_target *ti, struct bio *bio)
>         return DM_MAPIO_REMAPPED;
>  }
>
> -#if IS_ENABLED(CONFIG_DAX_DRIVER)
> +#if IS_ENABLED(CONFIG_FS_DAX)
>  static long stripe_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
>                 long nr_pages, void **kaddr, pfn_t *pfn)
>  {
> diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
> index 18320444fb0a9..4c3a6e33604d3 100644
> --- a/drivers/md/dm-writecache.c
> +++ b/drivers/md/dm-writecache.c
> @@ -38,7 +38,7 @@
>  #define BITMAP_GRANULARITY     PAGE_SIZE
>  #endif
>
> -#if IS_ENABLED(CONFIG_ARCH_HAS_PMEM_API) && IS_ENABLED(CONFIG_DAX_DRIVER)
> +#if IS_ENABLED(CONFIG_ARCH_HAS_PMEM_API) && IS_ENABLED(CONFIG_FS_DAX)
>  #define DM_WRITECACHE_HAS_PMEM
>  #endif
>
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index 7870e6460633f..79737aee516b1 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -1783,7 +1783,7 @@ static struct mapped_device *alloc_dev(int minor)
>         md->disk->private_data = md;
>         sprintf(md->disk->disk_name, "dm-%d", minor);
>
> -       if (IS_ENABLED(CONFIG_DAX_DRIVER)) {
> +       if (IS_ENABLED(CONFIG_FS_DAX)) {
>                 md->dax_dev = alloc_dax(md, md->disk->disk_name,
>                                         &dm_dax_ops, 0);
>                 if (IS_ERR(md->dax_dev))
> --
> 2.30.2
>
