Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0147243D89B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Oct 2021 03:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbhJ1Bfj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Oct 2021 21:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbhJ1Bfg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Oct 2021 21:35:36 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5709C061570
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Oct 2021 18:33:10 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id na16-20020a17090b4c1000b0019f5bb661f9so3473627pjb.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Oct 2021 18:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pAiaBNCk1xnEBH3C9EMpKzrgqAPJnlmXDrtIiJ0dt1I=;
        b=pAV9PI3uqSjbwl4ehA+e1fD0AmJsR9RObZKjbvBijn3hthsC3BOWhi8AwEhKayTbAn
         +kULxKOjbDPkdJvduTRaYnTinwRQ3sTGC3RmXxOu+ZBFQAZP2dCfU0u+xx+MyQD5sCXu
         juQ8/OlFDYxVdxNYORCgy1YjcIYTJ/VbxjTb7UxVpCGr1z8kM8Yws8W6G4x0NWwc6hyB
         NrmNiLX5o2T12KN42PUJoRgcExOicwbK7jy2OCO7u+1RAggFonc1ris6SaZqTakBedPe
         +KiIfancYaA+JSRyfWPQcobeLcn00lylDFmKvFb7FlRzM0bgeIYcMRtTDSe9GGiatzrv
         LAlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pAiaBNCk1xnEBH3C9EMpKzrgqAPJnlmXDrtIiJ0dt1I=;
        b=cHtAAvIM09F9Kw0DuZ7W0XVNnGlUJ4RUGTYe6F0HJHsinvUFqYgn81Ls5Z6zSAwFXv
         hoiBmdQHu83aywwYuL/eCNSu1vxuOyTvTD/iMDXXm0hjbJ0XbTp64W5y8CsFolRPeMyC
         r2owqxeQJ/K20u6/sMpELk6c0NQeJh1Yw6LsRxvalLVjS8Pno24MlkDlT3TIJxrwhCtn
         DagcqdVvBeRs/SvZH7QUjLiPE+OmjhUGNjV2dEreGtNOPOMA3gDELum/18VeIIEOyVDP
         LKW/h8IyRhcXLzdnhmrUS9kXUZWIbTZrDDOTKpBrjJAg6LZBB+bCLwTQdpFO7dhTKL0L
         Rvfw==
X-Gm-Message-State: AOAM53102aQusyoZhquaBjuphBAi3hBr0z7IASBP9jv8MqD1FHsMyHox
        uboeEOR4YIHiNEfqVa3SHJ0RftupO2WjguLnTHnszQ==
X-Google-Smtp-Source: ABdhPJxm6eCpHzum4moJkAnlQxDuj0JlmT3Vix8IBxxMECN3GUzGEt1VHXlaU6FsHMYZFBw/KnWLJLzVXyU36Brr9pk=
X-Received: by 2002:a17:90b:3b88:: with SMTP id pc8mr1221700pjb.93.1635384790364;
 Wed, 27 Oct 2021 18:33:10 -0700 (PDT)
MIME-Version: 1.0
References: <20211018044054.1779424-1-hch@lst.de> <20211018044054.1779424-9-hch@lst.de>
In-Reply-To: <20211018044054.1779424-9-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 27 Oct 2021 18:32:58 -0700
Message-ID: <CAPcyv4iK-Op9Nxoq91YLv0aRj6PkGF64UY0Z_kfovF0cpuJ_JQ@mail.gmail.com>
Subject: Re: [PATCH 08/11] dm-linear: add a linear_dax_pgoff helper
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

Looks good.

Mike, ack?

>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/md/dm-linear.c | 49 +++++++++++++-----------------------------
>  1 file changed, 15 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
> index 32fbab11bf90c..bf03f73fd0f36 100644
> --- a/drivers/md/dm-linear.c
> +++ b/drivers/md/dm-linear.c
> @@ -164,63 +164,44 @@ static int linear_iterate_devices(struct dm_target *ti,
>  }
>
>  #if IS_ENABLED(CONFIG_FS_DAX)
> +static struct dax_device *linear_dax_pgoff(struct dm_target *ti, pgoff_t *pgoff)
> +{
> +       struct linear_c *lc = ti->private;
> +       sector_t sector = linear_map_sector(ti, *pgoff << PAGE_SECTORS_SHIFT);
> +
> +       *pgoff = (get_start_sect(lc->dev->bdev) + sector) >> PAGE_SECTORS_SHIFT;
> +       return lc->dev->dax_dev;
> +}
> +
>  static long linear_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
>                 long nr_pages, void **kaddr, pfn_t *pfn)
>  {
> -       long ret;
> -       struct linear_c *lc = ti->private;
> -       struct block_device *bdev = lc->dev->bdev;
> -       struct dax_device *dax_dev = lc->dev->dax_dev;
> -       sector_t dev_sector, sector = pgoff * PAGE_SECTORS;
> -
> -       dev_sector = linear_map_sector(ti, sector);
> -       ret = bdev_dax_pgoff(bdev, dev_sector, nr_pages * PAGE_SIZE, &pgoff);
> -       if (ret)
> -               return ret;
> +       struct dax_device *dax_dev = linear_dax_pgoff(ti, &pgoff);
> +
>         return dax_direct_access(dax_dev, pgoff, nr_pages, kaddr, pfn);
>  }
>
>  static size_t linear_dax_copy_from_iter(struct dm_target *ti, pgoff_t pgoff,
>                 void *addr, size_t bytes, struct iov_iter *i)
>  {
> -       struct linear_c *lc = ti->private;
> -       struct block_device *bdev = lc->dev->bdev;
> -       struct dax_device *dax_dev = lc->dev->dax_dev;
> -       sector_t dev_sector, sector = pgoff * PAGE_SECTORS;
> +       struct dax_device *dax_dev = linear_dax_pgoff(ti, &pgoff);
>
> -       dev_sector = linear_map_sector(ti, sector);
> -       if (bdev_dax_pgoff(bdev, dev_sector, ALIGN(bytes, PAGE_SIZE), &pgoff))
> -               return 0;
>         return dax_copy_from_iter(dax_dev, pgoff, addr, bytes, i);
>  }
>
>  static size_t linear_dax_copy_to_iter(struct dm_target *ti, pgoff_t pgoff,
>                 void *addr, size_t bytes, struct iov_iter *i)
>  {
> -       struct linear_c *lc = ti->private;
> -       struct block_device *bdev = lc->dev->bdev;
> -       struct dax_device *dax_dev = lc->dev->dax_dev;
> -       sector_t dev_sector, sector = pgoff * PAGE_SECTORS;
> +       struct dax_device *dax_dev = linear_dax_pgoff(ti, &pgoff);
>
> -       dev_sector = linear_map_sector(ti, sector);
> -       if (bdev_dax_pgoff(bdev, dev_sector, ALIGN(bytes, PAGE_SIZE), &pgoff))
> -               return 0;
>         return dax_copy_to_iter(dax_dev, pgoff, addr, bytes, i);
>  }
>
>  static int linear_dax_zero_page_range(struct dm_target *ti, pgoff_t pgoff,
>                                       size_t nr_pages)
>  {
> -       int ret;
> -       struct linear_c *lc = ti->private;
> -       struct block_device *bdev = lc->dev->bdev;
> -       struct dax_device *dax_dev = lc->dev->dax_dev;
> -       sector_t dev_sector, sector = pgoff * PAGE_SECTORS;
> -
> -       dev_sector = linear_map_sector(ti, sector);
> -       ret = bdev_dax_pgoff(bdev, dev_sector, nr_pages << PAGE_SHIFT, &pgoff);
> -       if (ret)
> -               return ret;
> +       struct dax_device *dax_dev = linear_dax_pgoff(ti, &pgoff);
> +
>         return dax_zero_page_range(dax_dev, pgoff, nr_pages);
>  }
>
> --
> 2.30.2
>
