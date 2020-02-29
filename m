Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3BA317459A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Feb 2020 09:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgB2IEO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Feb 2020 03:04:14 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36508 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgB2IEO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Feb 2020 03:04:14 -0500
Received: by mail-wm1-f67.google.com with SMTP id g83so3601833wme.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Feb 2020 00:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5uuuwXmEYzKMQWHoj3FlOv3W0FcMz6JiZ2HkvpHOxlY=;
        b=NHbDra58T/LGoW6ToL2m1yJYHBIA52uz+lA/+D9pJUMdOjW6x42+5vYm6+HsegtKvf
         z4oRg9viu+uCeJocBr1uu54cOt9Ux+7k6yAD28PDK/Uj1YoYX4uU5TzmaODEfvDnYvE8
         T1ekke2cgSGEtV7gKMMk82ltzoWmJIGQ3a9zq6xw5blJeOcVDnteB8DtZqOY/gUKrIhw
         tL+R38Dey9qMSKJmE/6qh4IaJbvycIU1hrEsWShwo+Si+dkGawJYcSwJoIHfeeGaN8mT
         Dx6Ut6tDeCZsT9M03HNyim5y/O1rkBT8U0DxaUqUQ8H+aM7Kse/ArGnDgA7p0zgZ1oIE
         hAJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5uuuwXmEYzKMQWHoj3FlOv3W0FcMz6JiZ2HkvpHOxlY=;
        b=tgPUiGt/aOAiFzsBiui/GVvn6oItFarBkuvPvYD6qHbrQ6DLWmiymbM7xKg9z8I1Zl
         9i3I7bdRSHe1+sHkEJMB+eGycOnORRozbLfBeW2H6lWC8gap7LF5Gj9A0MRLElcUIhZK
         Jvn8zDzGRo1mJBZ5laIpsw/4ZlVT4bXOew2aWIMQ3STc2GhdhdZSDZ5Pmd2RPTfIYZkH
         C6IuYwZ/lyinWePKjKUicL6uil1DXpfILtz4hBKuYKCFEKn41ZYwPEICGQEx95FrAthl
         T2XNKhhcYd+6nBmB8Rnxf50ReUrNqmKoClJuAk2x7aTSmQAtOVGbrzXdmDhm2tFaeLBe
         MiTg==
X-Gm-Message-State: APjAAAVsbUMU1JBZnG0lI+grVo1rKDnBdJ3tpjm8HXLomAiQRR/SoQ96
        O6yQz7fQSSzajrL9QFfs7zuBeaoAdiPwVUIHCP4=
X-Google-Smtp-Source: APXvYqx0csBzSURuS/yibvzs0QZc0eFRxP0mymsBxYXXWF0i4h66voqBNGDpRg+MOvg+NnwvY7slgvvjgmbCqiyqQpQ=
X-Received: by 2002:a1c:9c52:: with SMTP id f79mr9014466wme.30.1582963452149;
 Sat, 29 Feb 2020 00:04:12 -0800 (PST)
MIME-Version: 1.0
References: <20200228163456.1587-1-vgoyal@redhat.com> <20200228163456.1587-2-vgoyal@redhat.com>
In-Reply-To: <20200228163456.1587-2-vgoyal@redhat.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Sat, 29 Feb 2020 09:04:00 +0100
Message-ID: <CAM9Jb+gJWH_bC-9fgGdeP5LaSVjJ3JgTnjBxpRJMfe6vbTPOTA@mail.gmail.com>
Subject: Re: [PATCH v6 1/6] pmem: Add functions for reading/writing page
 to/from pmem
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        hch@infradead.org, dan.j.williams@intel.com, david@fromorbit.com,
        dm-devel@redhat.com, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 28 Feb 2020 at 17:35, Vivek Goyal <vgoyal@redhat.com> wrote:
>
> This splits pmem_do_bvec() into pmem_do_read() and pmem_do_write().
> pmem_do_write() will be used by pmem zero_page_range() as well. Hence
> sharing the same code.
>
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  drivers/nvdimm/pmem.c | 86 +++++++++++++++++++++++++------------------
>  1 file changed, 50 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> index 4eae441f86c9..075b11682192 100644
> --- a/drivers/nvdimm/pmem.c
> +++ b/drivers/nvdimm/pmem.c
> @@ -136,9 +136,25 @@ static blk_status_t read_pmem(struct page *page, unsigned int off,
>         return BLK_STS_OK;
>  }
>
> -static blk_status_t pmem_do_bvec(struct pmem_device *pmem, struct page *page,
> -                       unsigned int len, unsigned int off, unsigned int op,
> -                       sector_t sector)
> +static blk_status_t pmem_do_read(struct pmem_device *pmem,
> +                       struct page *page, unsigned int page_off,
> +                       sector_t sector, unsigned int len)
> +{
> +       blk_status_t rc;
> +       phys_addr_t pmem_off = sector * 512 + pmem->data_offset;

minor nit,  maybe 512 is replaced by macro? Looks like its used at multiple
places, maybe can keep at is for now.

> +       void *pmem_addr = pmem->virt_addr + pmem_off;
> +
> +       if (unlikely(is_bad_pmem(&pmem->bb, sector, len)))
> +               return BLK_STS_IOERR;
> +
> +       rc = read_pmem(page, page_off, pmem_addr, len);
> +       flush_dcache_page(page);
> +       return rc;
> +}
> +
> +static blk_status_t pmem_do_write(struct pmem_device *pmem,
> +                       struct page *page, unsigned int page_off,
> +                       sector_t sector, unsigned int len)
>  {
>         blk_status_t rc = BLK_STS_OK;
>         bool bad_pmem = false;
> @@ -148,34 +164,25 @@ static blk_status_t pmem_do_bvec(struct pmem_device *pmem, struct page *page,
>         if (unlikely(is_bad_pmem(&pmem->bb, sector, len)))
>                 bad_pmem = true;
>
> -       if (!op_is_write(op)) {
> -               if (unlikely(bad_pmem))
> -                       rc = BLK_STS_IOERR;
> -               else {
> -                       rc = read_pmem(page, off, pmem_addr, len);
> -                       flush_dcache_page(page);
> -               }
> -       } else {
> -               /*
> -                * Note that we write the data both before and after
> -                * clearing poison.  The write before clear poison
> -                * handles situations where the latest written data is
> -                * preserved and the clear poison operation simply marks
> -                * the address range as valid without changing the data.
> -                * In this case application software can assume that an
> -                * interrupted write will either return the new good
> -                * data or an error.
> -                *
> -                * However, if pmem_clear_poison() leaves the data in an
> -                * indeterminate state we need to perform the write
> -                * after clear poison.
> -                */
> -               flush_dcache_page(page);
> -               write_pmem(pmem_addr, page, off, len);
> -               if (unlikely(bad_pmem)) {
> -                       rc = pmem_clear_poison(pmem, pmem_off, len);
> -                       write_pmem(pmem_addr, page, off, len);
> -               }
> +       /*
> +        * Note that we write the data both before and after
> +        * clearing poison.  The write before clear poison
> +        * handles situations where the latest written data is
> +        * preserved and the clear poison operation simply marks
> +        * the address range as valid without changing the data.
> +        * In this case application software can assume that an
> +        * interrupted write will either return the new good
> +        * data or an error.
> +        *
> +        * However, if pmem_clear_poison() leaves the data in an
> +        * indeterminate state we need to perform the write
> +        * after clear poison.
> +        */
> +       flush_dcache_page(page);
> +       write_pmem(pmem_addr, page, page_off, len);
> +       if (unlikely(bad_pmem)) {
> +               rc = pmem_clear_poison(pmem, pmem_off, len);
> +               write_pmem(pmem_addr, page, page_off, len);
>         }
>
>         return rc;
> @@ -197,8 +204,12 @@ static blk_qc_t pmem_make_request(struct request_queue *q, struct bio *bio)
>
>         do_acct = nd_iostat_start(bio, &start);
>         bio_for_each_segment(bvec, bio, iter) {
> -               rc = pmem_do_bvec(pmem, bvec.bv_page, bvec.bv_len,
> -                               bvec.bv_offset, bio_op(bio), iter.bi_sector);
> +               if (op_is_write(bio_op(bio)))
> +                       rc = pmem_do_write(pmem, bvec.bv_page, bvec.bv_offset,
> +                               iter.bi_sector, bvec.bv_len);
> +               else
> +                       rc = pmem_do_read(pmem, bvec.bv_page, bvec.bv_offset,
> +                               iter.bi_sector, bvec.bv_len);
>                 if (rc) {
>                         bio->bi_status = rc;
>                         break;
> @@ -223,9 +234,12 @@ static int pmem_rw_page(struct block_device *bdev, sector_t sector,
>         struct pmem_device *pmem = bdev->bd_queue->queuedata;
>         blk_status_t rc;
>
> -       rc = pmem_do_bvec(pmem, page, hpage_nr_pages(page) * PAGE_SIZE,
> -                         0, op, sector);
> -
> +       if (op_is_write(op))
> +               rc = pmem_do_write(pmem, page, 0, sector,
> +                                  hpage_nr_pages(page) * PAGE_SIZE);
> +       else
> +               rc = pmem_do_read(pmem, page, 0, sector,
> +                                  hpage_nr_pages(page) * PAGE_SIZE);
>         /*
>          * The ->rw_page interface is subtle and tricky.  The core
>          * retries on any error, so we can only invoke page_endio() in
> --
> 2.20.1

Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> _______________________________________________
> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
