Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33DA34FC913
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Apr 2022 02:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239284AbiDLAKv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Apr 2022 20:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238840AbiDLAKt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Apr 2022 20:10:49 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F4B2ED42
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Apr 2022 17:08:32 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id q3so4022113plg.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Apr 2022 17:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2wEkt+Fl5QHii5v8XtDT8LMRWz6S8eR3qRxTt2Sw5V4=;
        b=O5GYMczRyjp9uULNTyB4HDTn7FN9FuUeovnT56eEy6ngCmuYvzf1umOPz47prHSQNf
         sjm/mmaBMH9kX3OdAcZ7e/mJAQAcMPie9u2zSpjWdnb1xMYgeQIiHu/x3QzFfgMPwLcn
         ChcH10leiDHwQJUEVJeAwZiwajcffDTsWWV8oFMN6dAi0MmppUO+1s4Tub7/W9P9bpJo
         C/zenybAGnDMDQP2ii5SwFJs5SuLp7PIFO7OKXo4uROOns9yBTBle9VJuXUdM3HT/PBz
         G5aoKrJ8LlOqXpDBI/i4othZBimrMI7KGMfeW3P4doPTZZLtAGAaKDecV9y6sDmmSnos
         PvTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2wEkt+Fl5QHii5v8XtDT8LMRWz6S8eR3qRxTt2Sw5V4=;
        b=fg0Z6bKMYPWIc919odOQkNdpRK6sBJXjK2E8G/R40OOI99QAc49k/VR1rvRPWHNRL9
         4tUTFj/aowvOufoTlJEiaNcohFlpKGJ+EZ00LdJby/EER5HmlDWlVX3NOxzh4ib8CT+9
         1oBUme1SIljP9W7BGccZr8xdDmasKVuH1+J5txU4uimIPzxdJwApjZMPUPIxsTpHWQT1
         1b4xB3yrsLNy+pqrokI43u3D+shXB13wbpFROkuK2bOHpRNXO83nzdtyI6jRDT8Cq/M0
         kgDVYkDbQ9q7s8jz94VOsDY4jRPtTnlBxZOUmW+RpYsAeW/16ZZnE3JDWtS9xfcZZkJt
         Nn4w==
X-Gm-Message-State: AOAM532r7fcEQWBiu2KqFiT9xahd+3Gj68B0o+JFKajyxsQqkeR+2my7
        ezQe9Bs6+6nCjPwvCHsZbg1zEIJ6CADsvVBaDtotkg==
X-Google-Smtp-Source: ABdhPJwiqEMeg1D9j4J0Y+o8ZfMSN8ekDMHy7Zw5j+2VdEX4b8YSMIxWQgkLUtHS84yYy4GAXTgkQnH5MT/1f7wCXo8=
X-Received: by 2002:a17:903:32c5:b0:156:b466:c8ed with SMTP id
 i5-20020a17090332c500b00156b466c8edmr34561265plr.34.1649722112368; Mon, 11
 Apr 2022 17:08:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220405194747.2386619-1-jane.chu@oracle.com> <20220405194747.2386619-5-jane.chu@oracle.com>
In-Reply-To: <20220405194747.2386619-5-jane.chu@oracle.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 11 Apr 2022 17:08:21 -0700
Message-ID: <CAPcyv4ij8VxaeosTsRFgUTnSpRRaxWnxWK6xvUJrhmT-7ae+-Q@mail.gmail.com>
Subject: Re: [PATCH v7 4/6] dax: add DAX_RECOVERY flag and .recovery_write dev_pgmap_ops
To:     Jane Chu <jane.chu@oracle.com>
Cc:     david <david@fromorbit.com>, "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        device-mapper development <dm-devel@redhat.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vivek Goyal <vgoyal@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 5, 2022 at 12:48 PM Jane Chu <jane.chu@oracle.com> wrote:
>
> Introduce DAX_RECOVERY flag to dax_direct_access(). The flag is
> not set by default in dax_direct_access() such that the helper
> does not translate a pmem range to kernel virtual address if the
> range contains uncorrectable errors.  When the flag is set,
> the helper ignores the UEs and return kernel virtual adderss so
> that the caller may get on with data recovery via write.
>
> Also introduce a new dev_pagemap_ops .recovery_write function.
> The function is applicable to FSDAX device only. The device
> page backend driver provides .recovery_write function if the
> device has underlying mechanism to clear the uncorrectable
> errors on the fly.
>
> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> ---
>  drivers/dax/super.c             | 17 ++++++++--
>  drivers/md/dm-linear.c          |  4 +--
>  drivers/md/dm-log-writes.c      |  5 +--
>  drivers/md/dm-stripe.c          |  4 +--
>  drivers/md/dm-target.c          |  2 +-
>  drivers/md/dm-writecache.c      |  5 +--
>  drivers/md/dm.c                 |  5 +--
>  drivers/nvdimm/pmem.c           | 57 +++++++++++++++++++++++++++------
>  drivers/nvdimm/pmem.h           |  2 +-
>  drivers/s390/block/dcssblk.c    |  4 +--
>  fs/dax.c                        | 24 ++++++++++----
>  fs/fuse/dax.c                   |  4 +--
>  include/linux/dax.h             | 11 +++++--
>  include/linux/device-mapper.h   |  2 +-
>  include/linux/memremap.h        |  7 ++++
>  tools/testing/nvdimm/pmem-dax.c |  2 +-
>  16 files changed, 116 insertions(+), 39 deletions(-)
>
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index 0211e6f7b47a..8252858cd25a 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -13,6 +13,7 @@
>  #include <linux/uio.h>
>  #include <linux/dax.h>
>  #include <linux/fs.h>
> +#include <linux/memremap.h>
>  #include "dax-private.h"
>
>  /**
> @@ -117,6 +118,7 @@ enum dax_device_flags {
>   * @dax_dev: a dax_device instance representing the logical memory range
>   * @pgoff: offset in pages from the start of the device to translate
>   * @nr_pages: number of consecutive pages caller can handle relative to @pfn
> + * @flags: by default 0, set to DAX_RECOVERY to kick start dax recovery
>   * @kaddr: output parameter that returns a virtual address mapping of pfn
>   * @pfn: output parameter that returns an absolute pfn translation of @pgoff
>   *
> @@ -124,7 +126,7 @@ enum dax_device_flags {
>   * pages accessible at the device relative @pgoff.
>   */
>  long dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff, long nr_pages,
> -               void **kaddr, pfn_t *pfn)
> +               int flags, void **kaddr, pfn_t *pfn)
>  {
>         long avail;
>
> @@ -137,7 +139,7 @@ long dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff, long nr_pages,
>         if (nr_pages < 0)
>                 return -EINVAL;
>
> -       avail = dax_dev->ops->direct_access(dax_dev, pgoff, nr_pages,
> +       avail = dax_dev->ops->direct_access(dax_dev, pgoff, nr_pages, flags,
>                         kaddr, pfn);
>         if (!avail)
>                 return -ERANGE;
> @@ -194,6 +196,17 @@ int dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
>  }
>  EXPORT_SYMBOL_GPL(dax_zero_page_range);
>
> +size_t dax_recovery_write(struct dax_device *dax_dev, pgoff_t pgoff,
> +               pfn_t pfn, void *addr, size_t bytes, struct iov_iter *iter)
> +{
> +       struct dev_pagemap *pgmap = get_dev_pagemap(pfn_t_to_pfn(pfn), NULL);
> +
> +       if (!pgmap || !pgmap->ops || !pgmap->ops->recovery_write)
> +               return 0;
> +       return pgmap->ops->recovery_write(pgmap, pgoff, addr, bytes, iter);
> +}
> +EXPORT_SYMBOL_GPL(dax_recovery_write);
> +
>  #ifdef CONFIG_ARCH_HAS_PMEM_API
>  void arch_wb_cache_pmem(void *addr, size_t size);
>  void dax_flush(struct dax_device *dax_dev, void *addr, size_t size)
> diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
> index 76b486e4d2be..9e6d8bdf3b2a 100644
> --- a/drivers/md/dm-linear.c
> +++ b/drivers/md/dm-linear.c
> @@ -172,11 +172,11 @@ static struct dax_device *linear_dax_pgoff(struct dm_target *ti, pgoff_t *pgoff)
>  }
>
>  static long linear_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
> -               long nr_pages, void **kaddr, pfn_t *pfn)
> +               long nr_pages, int flags, void **kaddr, pfn_t *pfn)
>  {
>         struct dax_device *dax_dev = linear_dax_pgoff(ti, &pgoff);
>
> -       return dax_direct_access(dax_dev, pgoff, nr_pages, kaddr, pfn);
> +       return dax_direct_access(dax_dev, pgoff, nr_pages, flags, kaddr, pfn);
>  }
>
>  static int linear_dax_zero_page_range(struct dm_target *ti, pgoff_t pgoff,
> diff --git a/drivers/md/dm-log-writes.c b/drivers/md/dm-log-writes.c
> index c9d036d6bb2e..e23f062ade5f 100644
> --- a/drivers/md/dm-log-writes.c
> +++ b/drivers/md/dm-log-writes.c
> @@ -889,11 +889,12 @@ static struct dax_device *log_writes_dax_pgoff(struct dm_target *ti,
>  }
>
>  static long log_writes_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
> -                                        long nr_pages, void **kaddr, pfn_t *pfn)
> +                                        long nr_pages, int flags,
> +                                        void **kaddr, pfn_t *pfn)
>  {
>         struct dax_device *dax_dev = log_writes_dax_pgoff(ti, &pgoff);
>
> -       return dax_direct_access(dax_dev, pgoff, nr_pages, kaddr, pfn);
> +       return dax_direct_access(dax_dev, pgoff, nr_pages, flags, kaddr, pfn);
>  }
>
>  static int log_writes_dax_zero_page_range(struct dm_target *ti, pgoff_t pgoff,
> diff --git a/drivers/md/dm-stripe.c b/drivers/md/dm-stripe.c
> index c81d331d1afe..b89339c78702 100644
> --- a/drivers/md/dm-stripe.c
> +++ b/drivers/md/dm-stripe.c
> @@ -315,11 +315,11 @@ static struct dax_device *stripe_dax_pgoff(struct dm_target *ti, pgoff_t *pgoff)
>  }
>
>  static long stripe_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
> -               long nr_pages, void **kaddr, pfn_t *pfn)
> +               long nr_pages, int flags, void **kaddr, pfn_t *pfn)
>  {
>         struct dax_device *dax_dev = stripe_dax_pgoff(ti, &pgoff);
>
> -       return dax_direct_access(dax_dev, pgoff, nr_pages, kaddr, pfn);
> +       return dax_direct_access(dax_dev, pgoff, nr_pages, flags, kaddr, pfn);
>  }
>
>  static int stripe_dax_zero_page_range(struct dm_target *ti, pgoff_t pgoff,
> diff --git a/drivers/md/dm-target.c b/drivers/md/dm-target.c
> index 64dd0b34fcf4..24b1e5628f3a 100644
> --- a/drivers/md/dm-target.c
> +++ b/drivers/md/dm-target.c
> @@ -142,7 +142,7 @@ static void io_err_release_clone_rq(struct request *clone,
>  }
>
>  static long io_err_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
> -               long nr_pages, void **kaddr, pfn_t *pfn)
> +               long nr_pages, int flags, void **kaddr, pfn_t *pfn)
>  {
>         return -EIO;
>  }
> diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
> index 5630b470ba42..180ca8fa383e 100644
> --- a/drivers/md/dm-writecache.c
> +++ b/drivers/md/dm-writecache.c
> @@ -286,7 +286,8 @@ static int persistent_memory_claim(struct dm_writecache *wc)
>
>         id = dax_read_lock();
>
> -       da = dax_direct_access(wc->ssd_dev->dax_dev, offset, p, &wc->memory_map, &pfn);
> +       da = dax_direct_access(wc->ssd_dev->dax_dev, offset, p, 0,
> +                       &wc->memory_map, &pfn);
>         if (da < 0) {
>                 wc->memory_map = NULL;
>                 r = da;
> @@ -309,7 +310,7 @@ static int persistent_memory_claim(struct dm_writecache *wc)
>                 do {
>                         long daa;
>                         daa = dax_direct_access(wc->ssd_dev->dax_dev, offset + i, p - i,
> -                                               NULL, &pfn);
> +                                               0, NULL, &pfn);
>                         if (daa <= 0) {
>                                 r = daa ? daa : -EINVAL;
>                                 goto err3;
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index ad2e0bbeb559..a8c697bb6603 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -1087,7 +1087,8 @@ static struct dm_target *dm_dax_get_live_target(struct mapped_device *md,
>  }
>
>  static long dm_dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
> -                                long nr_pages, void **kaddr, pfn_t *pfn)
> +                                long nr_pages, int flags, void **kaddr,
> +                                pfn_t *pfn)
>  {
>         struct mapped_device *md = dax_get_private(dax_dev);
>         sector_t sector = pgoff * PAGE_SECTORS;
> @@ -1105,7 +1106,7 @@ static long dm_dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
>         if (len < 1)
>                 goto out;
>         nr_pages = min(len, nr_pages);
> -       ret = ti->type->direct_access(ti, pgoff, nr_pages, kaddr, pfn);
> +       ret = ti->type->direct_access(ti, pgoff, nr_pages, flags, kaddr, pfn);
>
>   out:
>         dm_put_live_table(md, srcu_idx);
> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> index 30c71a68175b..0400c5a7ba39 100644
> --- a/drivers/nvdimm/pmem.c
> +++ b/drivers/nvdimm/pmem.c
> @@ -238,12 +238,23 @@ static int pmem_rw_page(struct block_device *bdev, sector_t sector,
>
>  /* see "strong" declaration in tools/testing/nvdimm/pmem-dax.c */
>  __weak long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
> -               long nr_pages, void **kaddr, pfn_t *pfn)
> +               long nr_pages, int flags, void **kaddr, pfn_t *pfn)
>  {
>         resource_size_t offset = PFN_PHYS(pgoff) + pmem->data_offset;
> +       sector_t sector = PFN_PHYS(pgoff) >> SECTOR_SHIFT;
> +       unsigned int num = PFN_PHYS(nr_pages) >> SECTOR_SHIFT;
> +       struct badblocks *bb = &pmem->bb;
> +       sector_t first_bad;
> +       int num_bad;
> +       bool bad_in_range;
> +       long actual_nr;
> +
> +       if (!bb->count)
> +               bad_in_range = false;
> +       else
> +               bad_in_range = !!badblocks_check(bb, sector, num, &first_bad, &num_bad);

Why all this change...

>
> -       if (unlikely(is_bad_pmem(&pmem->bb, PFN_PHYS(pgoff) / 512,
> -                                       PFN_PHYS(nr_pages))))

...instead of adding "&& !(flags & DAX_RECOVERY)" to this statement?

> +       if (bad_in_range && !(flags & DAX_RECOVERY))
>                 return -EIO;
>
>         if (kaddr)
> @@ -251,13 +262,26 @@ __weak long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
>         if (pfn)
>                 *pfn = phys_to_pfn_t(pmem->phys_addr + offset, pmem->pfn_flags);
>
> +       if (!bad_in_range) {
> +               /*
> +                * If badblock is present but not in the range, limit known good range
> +                * to the requested range.
> +                */
> +               if (bb->count)
> +                       return nr_pages;
> +               return PHYS_PFN(pmem->size - pmem->pfn_pad - offset);
> +       }
> +
>         /*
> -        * If badblocks are present, limit known good range to the
> -        * requested range.
> +        * In case poison is found in the given range and DAX_RECOVERY flag is set,
> +        * recovery stride is set to kernel page size because the underlying driver and
> +        * firmware clear poison functions don't appear to handle large chunk (such as
> +        * 2MiB) reliably.
>          */
> -       if (unlikely(pmem->bb.count))
> -               return nr_pages;
> -       return PHYS_PFN(pmem->size - pmem->pfn_pad - offset);
> +       actual_nr = PHYS_PFN(PAGE_ALIGN((first_bad - sector) << SECTOR_SHIFT));
> +       dev_dbg(pmem->bb.dev, "start sector(%llu), nr_pages(%ld), first_bad(%llu), actual_nr(%ld)\n",
> +                       sector, nr_pages, first_bad, actual_nr);
> +       return (actual_nr == 0) ? 1 : actual_nr;

Similar feedback as above that this is more change than I would expect.

I think just adding...

if (flags & DAX_RECOVERY)
   return 1;

...before the typical return path is enough.
