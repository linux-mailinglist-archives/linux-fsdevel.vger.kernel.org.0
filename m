Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEAC91745D8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Feb 2020 10:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgB2JVx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Feb 2020 04:21:53 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52363 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgB2JVx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Feb 2020 04:21:53 -0500
Received: by mail-wm1-f68.google.com with SMTP id p9so5996773wmc.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Feb 2020 01:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2Ue+Dgx3CeJSePHgMAW1fINAp8LiFMrWYxPNI01tF+o=;
        b=VVPSupxCDZkkwJM0MuDX9yAVNfzq2i20C46ilTipuMbfK6l0nZb/BKn1/XdwebMeiv
         t2xcgHSniB3MKaroeXK4nR+DcPgDxbWR30zD9RR8oBloBpVXwwEAvELJRhHJheOooch6
         AL1GBbnr7DrKL7XwdsXHxymQXtL6qu7oDGLHVDq2QA9CBvv2KS3xgfE5//9ZdKO24frF
         iX0UEZKXNMxk4SOHXamSczkyh2f4Ep9b8YG7nw0VL/FXzcL3t/1rrge9pnAjNePfFQfx
         94jYhaNVO6BW/X2uUXHrchRqQx8rUFTZymcU84RKq1yf1zkD/xaUjIgfPc9htlsS4L4u
         fyhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Ue+Dgx3CeJSePHgMAW1fINAp8LiFMrWYxPNI01tF+o=;
        b=KgnQqFbGz/YtHti1uJyNc4CDeXOGzUnNEUwGyvimqdvWhFT/G3Ru8y5k0BP8nyHyZ4
         HgH2xjo5e6lvLFMcHkMfz0XN4WW59r/mWheGWH1VKghXVl+NAkcjkK1KffIXtHqmj9rF
         +1OoHNTAWw570/X6qzxEpypZ7EjxGhIuNBUC7i1+DFyAHr9a+z+7+sD694EQf6B5gvEv
         XCmfWAIj7jhIIUjhzH2Q3ZqrwyGZTQ6Z5g49761mxnmpPhPItdre8B0iibT8kRppjINo
         jC7+0NWGIkVVzfwtLpwCiHDWB33SDgeklBebER1/EHfmEfEG6tpZIQbUwxi1jymqmdT3
         vzNA==
X-Gm-Message-State: APjAAAV7ZsjHjRcqqetY9wXnU2utn+1D7qhberZHB9WecPW8+/oIIYvl
        tAeLydzJtYWj5HDag9IyIoVM4vw/zSZyXTIYxJQ=
X-Google-Smtp-Source: APXvYqwXr3ckvpjnUV3luGA4fCi4IOXlgKlcLyhHcepYxIFSxB+bII3J0lhiHYkO46BI/jCcSRb6B2gBvrulhaqW66Y=
X-Received: by 2002:a1c:25c5:: with SMTP id l188mr9801660wml.105.1582968108954;
 Sat, 29 Feb 2020 01:21:48 -0800 (PST)
MIME-Version: 1.0
References: <20200228163456.1587-1-vgoyal@redhat.com> <20200228163456.1587-3-vgoyal@redhat.com>
In-Reply-To: <20200228163456.1587-3-vgoyal@redhat.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Sat, 29 Feb 2020 10:21:37 +0100
Message-ID: <CAM9Jb+gLczXgFmLJg8a=XThoJT1S8XajFkb8AkjDCV1XXyarqg@mail.gmail.com>
Subject: Re: [PATCH v6 2/6] dax, pmem: Add a dax operation zero_page_range
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        hch@infradead.org, dan.j.williams@intel.com, david@fromorbit.com,
        dm-devel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>
> Add a dax operation zero_page_range, to zero a page. This will also clear any
> known poison in the page being zeroed.
>
> As of now, zeroing of one page is allowed in a single call. There
> are no callers which are trying to zero more than a page in a single call.
> Once we grow the callers which zero more than a page in single call, we
> can add that support. Primary reason for not doing that yet is that this
> will add little complexity in dm implementation where a range might be
> spanning multiple underlying targets and one will have to split the range
> into multiple sub ranges and call zero_page_range() on individual targets.
>
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  drivers/dax/super.c   | 20 ++++++++++++++++++++
>  drivers/nvdimm/pmem.c | 11 +++++++++++
>  include/linux/dax.h   |  4 ++++
>  3 files changed, 35 insertions(+)
>
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index 0aa4b6bc5101..e498daf3c0d7 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -344,6 +344,26 @@ size_t dax_copy_to_iter(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
>  }
>  EXPORT_SYMBOL_GPL(dax_copy_to_iter);
>
> +int dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
> +                       size_t nr_pages)
> +{
> +       if (!dax_alive(dax_dev))
> +               return -ENXIO;
> +
> +       if (!dax_dev->ops->zero_page_range)
> +               return -EOPNOTSUPP;
> +       /*
> +        * There are no callers that want to zero more than one page as of now.
> +        * Once users are there, this check can be removed after the
> +        * device mapper code has been updated to split ranges across targets.
> +        */
> +       if (nr_pages != 1)
> +               return -EIO;
> +
> +       return dax_dev->ops->zero_page_range(dax_dev, pgoff, nr_pages);
> +}
> +EXPORT_SYMBOL_GPL(dax_zero_page_range);
> +
>  #ifdef CONFIG_ARCH_HAS_PMEM_API
>  void arch_wb_cache_pmem(void *addr, size_t size);
>  void dax_flush(struct dax_device *dax_dev, void *addr, size_t size)
> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> index 075b11682192..5b774ddd0efb 100644
> --- a/drivers/nvdimm/pmem.c
> +++ b/drivers/nvdimm/pmem.c
> @@ -282,6 +282,16 @@ static const struct block_device_operations pmem_fops = {
>         .revalidate_disk =      nvdimm_revalidate_disk,
>  };
>
> +static int pmem_dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
> +                                   size_t nr_pages)
> +{
> +       struct pmem_device *pmem = dax_get_private(dax_dev);
> +
> +       return blk_status_to_errno(pmem_do_write(pmem, ZERO_PAGE(0), 0,
> +                                  PFN_PHYS(pgoff) >> SECTOR_SHIFT,
> +                                  PAGE_SIZE));
> +}
> +
>  static long pmem_dax_direct_access(struct dax_device *dax_dev,
>                 pgoff_t pgoff, long nr_pages, void **kaddr, pfn_t *pfn)
>  {
> @@ -313,6 +323,7 @@ static const struct dax_operations pmem_dax_ops = {
>         .dax_supported = generic_fsdax_supported,
>         .copy_from_iter = pmem_copy_from_iter,
>         .copy_to_iter = pmem_copy_to_iter,
> +       .zero_page_range = pmem_dax_zero_page_range,
>  };
>
>  static const struct attribute_group *pmem_attribute_groups[] = {
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index 328c2dbb4409..71735c430c05 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -34,6 +34,8 @@ struct dax_operations {
>         /* copy_to_iter: required operation for fs-dax direct-i/o */
>         size_t (*copy_to_iter)(struct dax_device *, pgoff_t, void *, size_t,
>                         struct iov_iter *);
> +       /* zero_page_range: required operation. Zero page range   */
> +       int (*zero_page_range)(struct dax_device *, pgoff_t, size_t);
>  };
>
>  extern struct attribute_group dax_attribute_group;
> @@ -199,6 +201,8 @@ size_t dax_copy_from_iter(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
>                 size_t bytes, struct iov_iter *i);
>  size_t dax_copy_to_iter(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
>                 size_t bytes, struct iov_iter *i);
> +int dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
> +                       size_t nr_pages);
>  void dax_flush(struct dax_device *dax_dev, void *addr, size_t size);
>
>  ssize_t dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
> --
> 2.20.1

Zeroing single page seems right approach for now.
Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> _______________________________________________
> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
