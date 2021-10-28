Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 922EA43D8BA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Oct 2021 03:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbhJ1Bnw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Oct 2021 21:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhJ1Bnv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Oct 2021 21:43:51 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6040C061745
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Oct 2021 18:41:25 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id np13so3466234pjb.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Oct 2021 18:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+57OykW2c30gUJR4jUskDQk4x1gwxn9Qbm17JsREFMA=;
        b=GwABTqD6Tkvmyhn2eav2yJwtbW1tJceyJOpR55oElF8Cpl62Tl7fpwDRJSoK85tktg
         WcSZzYI1J3gqZuBvcpDIMaP3fjxWgAXp2/71GNnfMTHJUKsW82nQtl3PxcHMw5XB0BGj
         ol0Z6vrOct/ohRKJEQ4971tC4ghv27sixDbbqgpjArwG9QA0di/1K6lcnuWx54KE2Iv0
         PlLdrGzgfAPZa89z4zZVquTUHRBE3n1XFA2eZslunyTMpQ/h+DaZ/H5bzksM/u3SBYyF
         eGC2TY3oTZ8dh7yBcSfW5yNsChH5J+OrCKaL/dFJg1o9GeZbeU8dYWzE/mMch4zQe8Vr
         Evvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+57OykW2c30gUJR4jUskDQk4x1gwxn9Qbm17JsREFMA=;
        b=SA2ejFLjDytujnGca4kn7Td544xiahHl7FTEClIB5e7YsMM8lzi2JZnNrWUPiAgMQz
         EgNonUhBoiippuz15crkjvynl+/WKpGXg//Jb+jI06tnNxVRGdKXIeMiyygMZ+UH41Jw
         EtP4XS3YSRwlw0oqzCdjVTlYA/yqeTg/9lSWHdIVAyq9gUnlpEeTAjLapthG2JxVRT5m
         hFzwzpa2/4iIjpLjRCyWV5A2xA7puhSFNzlHNM7szQvJl9ond12NJLgZTe8ReQPo9PyX
         V1r4Ab8xO5UIrPjR91WWVxBf80uvg1toeGCyTBIYZ+CSG+ckwSnH5hUbOlK6wfVeYEI+
         4qsA==
X-Gm-Message-State: AOAM531aRYvrExw8hKYBOPsDyxLO9RP2JLoz4bkqtc6j7KKAxhSQ4sNM
        ife21leUx7UfSjdQcklVzwKBe8L/4QdVOM/H3dWscg==
X-Google-Smtp-Source: ABdhPJy+l4+hDjjFqjiYrNzY24jHwGCV82yPyLMD7+lqHF6GqMdOIsbo6sHeOhaMgqSlqL4IZjgKI/J2hsCPQtYDPIA=
X-Received: by 2002:a17:902:ab50:b0:13f:4c70:9322 with SMTP id
 ij16-20020a170902ab5000b0013f4c709322mr995386plb.89.1635385285322; Wed, 27
 Oct 2021 18:41:25 -0700 (PDT)
MIME-Version: 1.0
References: <20211018044054.1779424-1-hch@lst.de> <20211018044054.1779424-11-hch@lst.de>
In-Reply-To: <20211018044054.1779424-11-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 27 Oct 2021 18:41:13 -0700
Message-ID: <CAPcyv4iLbbqyAsy1yjFXT48D3Ssp+jy4EMJt+Sj_o2W-WMgK9w@mail.gmail.com>
Subject: Re: [PATCH 10/11] dm-stripe: add a stripe_dax_pgoff helper
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
> Add a helper to perform the entire remapping for DAX accesses.  This
> helper open codes bdev_dax_pgoff given that the alignment checks have
> already been done by the submitting file system and don't need to be
> repeated.

Again, looks good. Kind of embarrassing when the open-coded version is
less LOC than using the helper.

Mike, ack?

>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/md/dm-stripe.c | 63 ++++++++++--------------------------------
>  1 file changed, 15 insertions(+), 48 deletions(-)
>
> diff --git a/drivers/md/dm-stripe.c b/drivers/md/dm-stripe.c
> index f084607220293..50dba3f39274c 100644
> --- a/drivers/md/dm-stripe.c
> +++ b/drivers/md/dm-stripe.c
> @@ -301,83 +301,50 @@ static int stripe_map(struct dm_target *ti, struct bio *bio)
>  }
>
>  #if IS_ENABLED(CONFIG_FS_DAX)
> -static long stripe_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
> -               long nr_pages, void **kaddr, pfn_t *pfn)
> +static struct dax_device *stripe_dax_pgoff(struct dm_target *ti, pgoff_t *pgoff)
>  {
> -       sector_t dev_sector, sector = pgoff * PAGE_SECTORS;
>         struct stripe_c *sc = ti->private;
> -       struct dax_device *dax_dev;
>         struct block_device *bdev;
> +       sector_t dev_sector;
>         uint32_t stripe;
> -       long ret;
>
> -       stripe_map_sector(sc, sector, &stripe, &dev_sector);
> +       stripe_map_sector(sc, *pgoff * PAGE_SECTORS, &stripe, &dev_sector);
>         dev_sector += sc->stripe[stripe].physical_start;
> -       dax_dev = sc->stripe[stripe].dev->dax_dev;
>         bdev = sc->stripe[stripe].dev->bdev;
>
> -       ret = bdev_dax_pgoff(bdev, dev_sector, nr_pages * PAGE_SIZE, &pgoff);
> -       if (ret)
> -               return ret;
> +       *pgoff = (get_start_sect(bdev) + dev_sector) >> PAGE_SECTORS_SHIFT;
> +       return sc->stripe[stripe].dev->dax_dev;
> +}
> +
> +static long stripe_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
> +               long nr_pages, void **kaddr, pfn_t *pfn)
> +{
> +       struct dax_device *dax_dev = stripe_dax_pgoff(ti, &pgoff);
> +
>         return dax_direct_access(dax_dev, pgoff, nr_pages, kaddr, pfn);
>  }
>
>  static size_t stripe_dax_copy_from_iter(struct dm_target *ti, pgoff_t pgoff,
>                 void *addr, size_t bytes, struct iov_iter *i)
>  {
> -       sector_t dev_sector, sector = pgoff * PAGE_SECTORS;
> -       struct stripe_c *sc = ti->private;
> -       struct dax_device *dax_dev;
> -       struct block_device *bdev;
> -       uint32_t stripe;
> -
> -       stripe_map_sector(sc, sector, &stripe, &dev_sector);
> -       dev_sector += sc->stripe[stripe].physical_start;
> -       dax_dev = sc->stripe[stripe].dev->dax_dev;
> -       bdev = sc->stripe[stripe].dev->bdev;
> +       struct dax_device *dax_dev = stripe_dax_pgoff(ti, &pgoff);
>
> -       if (bdev_dax_pgoff(bdev, dev_sector, ALIGN(bytes, PAGE_SIZE), &pgoff))
> -               return 0;
>         return dax_copy_from_iter(dax_dev, pgoff, addr, bytes, i);
>  }
>
>  static size_t stripe_dax_copy_to_iter(struct dm_target *ti, pgoff_t pgoff,
>                 void *addr, size_t bytes, struct iov_iter *i)
>  {
> -       sector_t dev_sector, sector = pgoff * PAGE_SECTORS;
> -       struct stripe_c *sc = ti->private;
> -       struct dax_device *dax_dev;
> -       struct block_device *bdev;
> -       uint32_t stripe;
> -
> -       stripe_map_sector(sc, sector, &stripe, &dev_sector);
> -       dev_sector += sc->stripe[stripe].physical_start;
> -       dax_dev = sc->stripe[stripe].dev->dax_dev;
> -       bdev = sc->stripe[stripe].dev->bdev;
> +       struct dax_device *dax_dev = stripe_dax_pgoff(ti, &pgoff);
>
> -       if (bdev_dax_pgoff(bdev, dev_sector, ALIGN(bytes, PAGE_SIZE), &pgoff))
> -               return 0;
>         return dax_copy_to_iter(dax_dev, pgoff, addr, bytes, i);
>  }
>
>  static int stripe_dax_zero_page_range(struct dm_target *ti, pgoff_t pgoff,
>                                       size_t nr_pages)
>  {
> -       int ret;
> -       sector_t dev_sector, sector = pgoff * PAGE_SECTORS;
> -       struct stripe_c *sc = ti->private;
> -       struct dax_device *dax_dev;
> -       struct block_device *bdev;
> -       uint32_t stripe;
> +       struct dax_device *dax_dev = stripe_dax_pgoff(ti, &pgoff);
>
> -       stripe_map_sector(sc, sector, &stripe, &dev_sector);
> -       dev_sector += sc->stripe[stripe].physical_start;
> -       dax_dev = sc->stripe[stripe].dev->dax_dev;
> -       bdev = sc->stripe[stripe].dev->bdev;
> -
> -       ret = bdev_dax_pgoff(bdev, dev_sector, nr_pages << PAGE_SHIFT, &pgoff);
> -       if (ret)
> -               return ret;
>         return dax_zero_page_range(dax_dev, pgoff, nr_pages);
>  }
>
> --
> 2.30.2
>
