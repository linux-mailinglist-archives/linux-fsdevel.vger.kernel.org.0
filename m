Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 046032AB178
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Nov 2020 07:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729603AbgKIG4r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Nov 2020 01:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728873AbgKIG4q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Nov 2020 01:56:46 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22779C0613D4
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 Nov 2020 22:56:45 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id a71so7507932edf.9
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Nov 2020 22:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lhEWojdnEETMpoDmZaKWZITR453k36pmv/sfAr6vN/Q=;
        b=OlOP6e+hTTnzcMIwdaF/T/hnfIBf/9oJMDqvqjYzplHIQ4xMgH25+911Ixq0B3+K58
         5Dj/JmHZRD8Yi8zqOu+1rKF07XS2mrjA0Wv9PMukIV3uX40Qn/weu/uMdAMCHG7RU935
         A8pgkbko6hNqb1nFuLU3A3PiBPYVj8XjATb55mVvvHvMOvvFHanlnCDmyhaMxkXN6DKS
         Bf5AgcB50gTwwmoZvVJaG5dtCbnwCB8M7N5x+uhcjSrbjJF9nKnn2cuHHSz7I/a4akR/
         xE89AMdrexbc31NBbIF2vvHpBBUezGpS6XdWxnMo7c/NgKk9nHTIb/0D5wlGo0gz8gEr
         D1Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lhEWojdnEETMpoDmZaKWZITR453k36pmv/sfAr6vN/Q=;
        b=aubtxzdU/ihWpZImtr1SggAKyBB9inNCKquadvhKNpxUoFkYeVqgAUxN9Uks0akJjF
         mpP3Uq15kenuP5+H8c700hXGOlm/uU+sIJcXdo5agXvv2kdaQFqE+IYLy/UTHDmBtGuj
         BIx7sa9UGa7l6nwCl0WCZvwUsWVeWTJbefgiK5FxGcSzgHeLYKp+n/lbLtQU3nyulm1c
         o+2zWdb/RLV+/9rxhmzCLtOlgxMQp68ZwucF4c5pxxnYfa+FAWDgCpNjxYPHfI+9r1qO
         3h8hD1gHr5Gms2RO34i7cfLI/pofflRb9jG4cusZ8gLwzjE06jDMgzXAaP3q6RVKxebD
         YmWg==
X-Gm-Message-State: AOAM530r/T0daUNdRxJRM4FJP0TJPKzYrNFCWrJpGLzITWjdlgczSCq0
        wo/C3FOuf4gxc3WEfrdC1T/z4xAcgSkEE3gUb1eMPQ==
X-Google-Smtp-Source: ABdhPJy5lMTAmAT8/Ewb7MyKs6V0kAUlIo1q9lM6dl2oB700nsAVEi6e4At1FesCFzDNwPnUu593st+zxY/BthW2KiM=
X-Received: by 2002:a50:fc89:: with SMTP id f9mr14573990edq.89.1604905003672;
 Sun, 08 Nov 2020 22:56:43 -0800 (PST)
MIME-Version: 1.0
References: <20201106190337.1973127-1-hch@lst.de> <20201106190337.1973127-19-hch@lst.de>
In-Reply-To: <20201106190337.1973127-19-hch@lst.de>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Mon, 9 Nov 2020 07:56:32 +0100
Message-ID: <CAMGffEnRgesKniK_X5b2nAoiQ_i6xqL4gnCw7dJxapkD-6Dvwg@mail.gmail.com>
Subject: Re: [PATCH 18/24] rnbd: use set_capacity_and_notify
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Justin Sanders <justin@coraid.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
        Minchan Kim <minchan@kernel.org>,
        Mike Snitzer <snitzer@redhat.com>, Song Liu <song@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        device-mapper development <dm-devel@redhat.com>,
        linux-block@vger.kernel.org, drbd-dev@lists.linbit.com,
        nbd@other.debian.org, ceph-devel@vger.kernel.org,
        xen-devel@lists.xenproject.org,
        linux-raid <linux-raid@vger.kernel.org>,
        linux-nvme@lists.infradead.org,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 6, 2020 at 8:04 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Use set_capacity_and_notify to set the size of both the disk and block
> device.  This also gets the uevent notifications for the resize for free.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
Thanks, Christoph!
Acked-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> ---
>  drivers/block/rnbd/rnbd-clt.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
> index 8b2411ccbda97c..bb13d7dd195a08 100644
> --- a/drivers/block/rnbd/rnbd-clt.c
> +++ b/drivers/block/rnbd/rnbd-clt.c
> @@ -100,8 +100,7 @@ static int rnbd_clt_change_capacity(struct rnbd_clt_dev *dev,
>         rnbd_clt_info(dev, "Device size changed from %zu to %zu sectors\n",
>                        dev->nsectors, new_nsectors);
>         dev->nsectors = new_nsectors;
> -       set_capacity(dev->gd, dev->nsectors);
> -       revalidate_disk_size(dev->gd, true);
> +       set_capacity_and_notify(dev->gd, dev->nsectors);
>         return 0;
>  }
>
> --
> 2.28.0
>
