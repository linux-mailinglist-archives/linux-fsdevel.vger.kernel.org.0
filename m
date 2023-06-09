Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0786272A1DA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 20:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjFISNl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Fri, 9 Jun 2023 14:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjFISNk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 14:13:40 -0400
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E913583;
        Fri,  9 Jun 2023 11:13:39 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-977d3292be0so55136166b.1;
        Fri, 09 Jun 2023 11:13:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686334418; x=1688926418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f2Xux0G0tFdJlDzvQzZhcAqUXfykTqTn9g16hyE21ys=;
        b=O8+rgBcSCmr7ISsLmZwhYt2QuRaOx19GpuhElVxPga2ffv3FF6dC4T+tx4hPruvjTb
         9vRqlJKiSAjiiRGfNO26zl63DYH+9TUf3eaCJGkc+eAoEUDKzBGjKZauFZUlu6Ew4Wu8
         JhOG4NfTbt8gyRAziil1iXgBKO9cgeHeI9W3aB6hL5YWVqq+X2A7WMIfDY4pDtQBhu4/
         HU1mPg0HVILj5bd8QjZ6/n1W7Oy8yg4cjCVfngIeZwEmYzSDFJw4tY1FwwTzcIDcPBN4
         R6O70UJnFPGL80aqDbuMt7vDiS28/aycG46CDyR+7ZSf0Bd1s1M69EeO5OMKX2EGFDh+
         BtaA==
X-Gm-Message-State: AC+VfDzM63fEMAKyAwGd7fowQQU+V97ul7KX08jd/wfRHyvKkIpIC42H
        0ys/UrPI0wjFM1vSdDaS0HFowj62vZw8QuUb3kE=
X-Google-Smtp-Source: ACHHUZ7r7lbBrTdxRkyp2bTqJCFBDA6+Ddf+RviatN0r97z5LUsaxAu6Q2CxPlvVkZ/6P5sUxBvleBvx6ETeZa4XK48=
X-Received: by 2002:a17:906:1049:b0:974:56cb:9dfc with SMTP id
 j9-20020a170906104900b0097456cb9dfcmr1993996ejj.1.1686334417837; Fri, 09 Jun
 2023 11:13:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230608110258.189493-1-hch@lst.de> <20230608110258.189493-12-hch@lst.de>
In-Reply-To: <20230608110258.189493-12-hch@lst.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 9 Jun 2023 20:13:23 +0200
Message-ID: <CAJZ5v0h61q6=JxjeUjjMz5k05HuRGWVKp_rK+9N8rug58kU_VQ@mail.gmail.com>
Subject: Re: [PATCH 11/30] swsusp: don't pass a stack address to blkdev_get_by_path
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Richard Weinberger <richard@nod.at>,
        Josef Bacik <josef@toxicpanda.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        Coly Li <colyli@suse.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-um@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
        linux-btrfs@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-pm@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 8, 2023 at 1:03 PM Christoph Hellwig <hch@lst.de> wrote:
>
> holder is just an on-stack pointer that can easily be reused by other calls,
> replace it with a static variable that doesn't change.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Hannes Reinecke <hare@suse.de>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  kernel/power/swap.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
> index 81aec3b2c60510..b03ff1a33c7f68 100644
> --- a/kernel/power/swap.c
> +++ b/kernel/power/swap.c
> @@ -1510,6 +1510,8 @@ int swsusp_read(unsigned int *flags_p)
>         return error;
>  }
>
> +static void *swsusp_holder;
> +
>  /**
>   *      swsusp_check - Check for swsusp signature in the resume device
>   */
> @@ -1517,14 +1519,13 @@ int swsusp_read(unsigned int *flags_p)
>  int swsusp_check(bool snapshot_test)
>  {
>         int error;
> -       void *holder;
>         fmode_t mode = FMODE_READ;
>
>         if (snapshot_test)
>                 mode |= FMODE_EXCL;
>
>         hib_resume_bdev = blkdev_get_by_dev(swsusp_resume_device,
> -                                           mode, &holder, NULL);
> +                                           mode, &swsusp_holder, NULL);
>         if (!IS_ERR(hib_resume_bdev)) {
>                 set_blocksize(hib_resume_bdev, PAGE_SIZE);
>                 clear_page(swsusp_header);
> --
> 2.39.2
>
