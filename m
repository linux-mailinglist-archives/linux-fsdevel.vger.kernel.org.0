Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A5D77955C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 18:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235582AbjHKQ5X convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 12:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235502AbjHKQ5V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 12:57:21 -0400
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB172D79;
        Fri, 11 Aug 2023 09:57:21 -0700 (PDT)
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-56d0deeca09so401101eaf.0;
        Fri, 11 Aug 2023 09:57:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691773040; x=1692377840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/MKrsTvyOkFqYnQxHrODPvzn4CYiImWubBs2zxt84WE=;
        b=N5zN+I8pPchiAd+KAWPGPUQU50wB0o4Q8DHbGKcz5BDjqyXOn/7BKL7q6+bCOyg/Oj
         X9Qb++jgWKLOfyqCil6MTnsef/wNKvF0N3X+Jw1+bApaxg91CZSPyXLxvs7e3YLeI4dD
         zaiitjwoWnLxJCVOA6v6te64qqbdL4bCjS74dlk7Bp5HE4QZorIV0neDHOzVEIkvSx87
         7plLYsGgzIU2XOFIb+syK84yL5Ww3lDlCWgENwTKA6ynsSkhQ4ILDYchhZcGe2bae7kc
         aEAcHCxr+QB5TdzlhuucbnRWMVSXSK+/gGswqVC/cQJ9a6nd/r9vK0fTx7D7l2yCuZ7x
         Bilw==
X-Gm-Message-State: AOJu0Yw6PAg/IaMe1xlmv/7/8qn14nWrkvieRPDEgx54UWLCvsG8Y3Fp
        5b/h4HJPQJjrEx0obBzE88xAehIfPk7tTI1dCsPIwELz
X-Google-Smtp-Source: AGHT+IFMyWrzb3vv1ElBiPYzpwa36cwgwBCpEMcLCPL2IYmDcOJa1XmuQJK0vw7falr30iJFoiXy4kqHBDPTohgtiSs=
X-Received: by 2002:a4a:e04e:0:b0:569:a08a:d9c5 with SMTP id
 v14-20020a4ae04e000000b00569a08ad9c5mr1997794oos.0.1691773040594; Fri, 11 Aug
 2023 09:57:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230810171429.31759-1-jack@suse.cz> <20230811110504.27514-16-jack@suse.cz>
In-Reply-To: <20230811110504.27514-16-jack@suse.cz>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 11 Aug 2023 18:57:09 +0200
Message-ID: <CAJZ5v0jpCQugJCqPEXCsjskmRRoF9PTj0p696WA+GoKVroL0Lw@mail.gmail.com>
Subject: Re: [PATCH 16/29] PM: hibernate: Convert to bdev_open_by_dev()
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 11, 2023 at 1:05 PM Jan Kara <jack@suse.cz> wrote:
>
> Convert hibernation code to use bdev_open_by_dev().
>
> CC: linux-pm@vger.kernel.org
> Signed-off-by: Jan Kara <jack@suse.cz>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  kernel/power/swap.c | 31 ++++++++++++++++---------------
>  1 file changed, 16 insertions(+), 15 deletions(-)
>
> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
> index f6ebcd00c410..b475bee282ff 100644
> --- a/kernel/power/swap.c
> +++ b/kernel/power/swap.c
> @@ -222,7 +222,7 @@ int swsusp_swap_in_use(void)
>   */
>
>  static unsigned short root_swap = 0xffff;
> -static struct block_device *hib_resume_bdev;
> +static struct bdev_handle *hib_resume_bdev_handle;
>
>  struct hib_bio_batch {
>         atomic_t                count;
> @@ -276,7 +276,8 @@ static int hib_submit_io(blk_opf_t opf, pgoff_t page_off, void *addr,
>         struct bio *bio;
>         int error = 0;
>
> -       bio = bio_alloc(hib_resume_bdev, 1, opf, GFP_NOIO | __GFP_HIGH);
> +       bio = bio_alloc(hib_resume_bdev_handle->bdev, 1, opf,
> +                       GFP_NOIO | __GFP_HIGH);
>         bio->bi_iter.bi_sector = page_off * (PAGE_SIZE >> 9);
>
>         if (bio_add_page(bio, page, PAGE_SIZE, 0) < PAGE_SIZE) {
> @@ -356,14 +357,14 @@ static int swsusp_swap_check(void)
>                 return res;
>         root_swap = res;
>
> -       hib_resume_bdev = blkdev_get_by_dev(swsusp_resume_device,
> +       hib_resume_bdev_handle = bdev_open_by_dev(swsusp_resume_device,
>                         BLK_OPEN_WRITE, NULL, NULL);
> -       if (IS_ERR(hib_resume_bdev))
> -               return PTR_ERR(hib_resume_bdev);
> +       if (IS_ERR(hib_resume_bdev_handle))
> +               return PTR_ERR(hib_resume_bdev_handle);
>
> -       res = set_blocksize(hib_resume_bdev, PAGE_SIZE);
> +       res = set_blocksize(hib_resume_bdev_handle->bdev, PAGE_SIZE);
>         if (res < 0)
> -               blkdev_put(hib_resume_bdev, NULL);
> +               bdev_release(hib_resume_bdev_handle);
>
>         return res;
>  }
> @@ -1521,10 +1522,10 @@ int swsusp_check(bool snapshot_test)
>         void *holder = snapshot_test ? &swsusp_holder : NULL;
>         int error;
>
> -       hib_resume_bdev = blkdev_get_by_dev(swsusp_resume_device, BLK_OPEN_READ,
> -                                           holder, NULL);
> -       if (!IS_ERR(hib_resume_bdev)) {
> -               set_blocksize(hib_resume_bdev, PAGE_SIZE);
> +       hib_resume_bdev_handle = bdev_open_by_dev(swsusp_resume_device,
> +                               BLK_OPEN_READ, holder, NULL);
> +       if (!IS_ERR(hib_resume_bdev_handle)) {
> +               set_blocksize(hib_resume_bdev_handle->bdev, PAGE_SIZE);
>                 clear_page(swsusp_header);
>                 error = hib_submit_io(REQ_OP_READ, swsusp_resume_block,
>                                         swsusp_header, NULL);
> @@ -1549,11 +1550,11 @@ int swsusp_check(bool snapshot_test)
>
>  put:
>                 if (error)
> -                       blkdev_put(hib_resume_bdev, holder);
> +                       bdev_release(hib_resume_bdev_handle);
>                 else
>                         pr_debug("Image signature found, resuming\n");
>         } else {
> -               error = PTR_ERR(hib_resume_bdev);
> +               error = PTR_ERR(hib_resume_bdev_handle);
>         }
>
>         if (error)
> @@ -1568,12 +1569,12 @@ int swsusp_check(bool snapshot_test)
>
>  void swsusp_close(bool snapshot_test)
>  {
> -       if (IS_ERR(hib_resume_bdev)) {
> +       if (IS_ERR(hib_resume_bdev_handle)) {
>                 pr_debug("Image device not initialised\n");
>                 return;
>         }
>
> -       blkdev_put(hib_resume_bdev, snapshot_test ? &swsusp_holder : NULL);
> +       bdev_release(hib_resume_bdev_handle);
>  }
>
>  /**
> --
> 2.35.3
>
