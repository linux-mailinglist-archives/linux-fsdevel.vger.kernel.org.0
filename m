Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0A12AEE38
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Nov 2020 10:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbgKKJzr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Nov 2020 04:55:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgKKJzq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Nov 2020 04:55:46 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D378BC0613D1;
        Wed, 11 Nov 2020 01:55:45 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id e17so1439067ili.5;
        Wed, 11 Nov 2020 01:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qfEf7xRtwJh6vel7ndE10SMbjF6zTEFOWV8RA9xu3eI=;
        b=Flu0kG/G8H5tmdzF22ns+x1T3WixC4FBs0RbA9YeGx20Pw3IL573gomPOrRSgLhidi
         jxm4xXdraWCqe23Uz/lTRF5Gzul+neu0ZW5SRlL8rLtuRaQOMWWnKLr+e1J5E2f/IB4R
         iaO9iEipyz2F49FzVbspMmUTamyYBNigOi7Hq45S5vTkNhsbMM69J9bWbbawzfmKvyaE
         prBgh+sprAAWuhDKQzcpJRm9c4LoRmjW0z3OGufy4OEk4vgw7impUerADJ8+P1l4Evs/
         gUeZGg6Qzu0m4oCwYhIr6na+Ay9Hq4ATHKFwzo1XQC1pmqP6NOhCJ7ijtefRPRR/Tb4r
         FFHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qfEf7xRtwJh6vel7ndE10SMbjF6zTEFOWV8RA9xu3eI=;
        b=KvtS3IeStM5spfDS6t6NO2+Z1VVJWwY9Dkb++mMQr4Cbe0WS12JoCGvRiKDFTDqW23
         Fcl0HjtUQWBREdxrjcfttIJ1Dl3UDFkmWILgzi2EV40lzqdbH6U3RU2Sxd3ZtHbAxq5M
         e7uKNRkXS77qam+khns2CflLQkAbtEdbDN5EDc6Qtv0/JI6ZZyj58jtePF9bAzs1B8qu
         2UEBX/rhc9OohOWQBumtJHm192PB+q6NVqH/1Nu599qdHrSlSgAhl05U9Y1c3J2ChkXg
         eZZHtlCXQifk2Ur/USrSzX8jorUsiOURvtiLIHqxAFdoQYGWu5edS8Gd2Z9dlu+Blm+G
         c0Xw==
X-Gm-Message-State: AOAM530rzE2Uf1a3DNfiF3E8gear4jJ9Te9pOjiINn0CCaTDD+fG/Jf+
        I3OImvDk2aXapBxLGV/SDmHx5+N36GBSYNMgtEOmEDHQZ3pvnb2q
X-Google-Smtp-Source: ABdhPJy9ZPoku1YjH4P5V9sTrbXGNc0TDLR8E4ST1Mn4KA5kvu+HvwpbOUC5MO/5tCHlTeWvzQ658Y1GM8zrKYsupSY=
X-Received: by 2002:a92:1f43:: with SMTP id i64mr17516886ile.281.1605088545285;
 Wed, 11 Nov 2020 01:55:45 -0800 (PST)
MIME-Version: 1.0
References: <20201111082658.3401686-1-hch@lst.de> <20201111082658.3401686-18-hch@lst.de>
In-Reply-To: <20201111082658.3401686-18-hch@lst.de>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Wed, 11 Nov 2020 10:55:45 +0100
Message-ID: <CAOi1vP-JjnNdAUqd9Gy6YdFgi8Ev4_Jt3zcB9DhAmdAvQhG7Eg@mail.gmail.com>
Subject: Re: [PATCH 17/24] rbd: use set_capacity_and_notify
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Justin Sanders <justin@coraid.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
        Minchan Kim <minchan@kernel.org>,
        Mike Snitzer <snitzer@redhat.com>, Song Liu <song@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        dm-devel@redhat.com, linux-block <linux-block@vger.kernel.org>,
        Lars Ellenberg <drbd-dev@lists.linbit.com>,
        nbd@other.debian.org,
        Ceph Development <ceph-devel@vger.kernel.org>,
        xen-devel@lists.xenproject.org, linux-raid@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 11, 2020 at 9:27 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Use set_capacity_and_notify to set the size of both the disk and block
> device.  This also gets the uevent notifications for the resize for free.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> ---
>  drivers/block/rbd.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index f84128abade319..b7a194ffda55b4 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -4920,8 +4920,7 @@ static void rbd_dev_update_size(struct rbd_device *rbd_dev)
>             !test_bit(RBD_DEV_FLAG_REMOVING, &rbd_dev->flags)) {
>                 size = (sector_t)rbd_dev->mapping.size / SECTOR_SIZE;
>                 dout("setting size to %llu sectors", (unsigned long long)size);
> -               set_capacity(rbd_dev->disk, size);
> -               revalidate_disk_size(rbd_dev->disk, true);
> +               set_capacity_and_notify(rbd_dev->disk, size);
>         }
>  }
>
> --
> 2.28.0
>

Hi Christoph,

The Acked-by is wrong here.  I acked this patch (17/24, rbd), and Jack
acked the next one (18/24, rnbd).

Thanks,

                Ilya
