Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25EC631A1FE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Feb 2021 16:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbhBLPq0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Feb 2021 10:46:26 -0500
Received: from mail-pl1-f173.google.com ([209.85.214.173]:41505 "EHLO
        mail-pl1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbhBLPqY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Feb 2021 10:46:24 -0500
Received: by mail-pl1-f173.google.com with SMTP id a16so52073plh.8;
        Fri, 12 Feb 2021 07:46:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M8C1yZZgp4rNPfghNpxWN41GpCK1+InKLAelhxbvplw=;
        b=hZpgfmnlksgx4IeXq+4uYsXgBiV3Wuv56ZbgzH+aODufu6JzmrkVSl1zfOG+vrp5S2
         d8GPPaPIMLhL6ospHexo/xpsl4e1XGzbdBRs467jodP7d3MrFjX46vnwsHOVJFChdBH5
         tseGkI62kfbRh6eWkNbJrqZj1TqWHajscSaxyZpAFu930nQQcWNNG7jiuXXBO5wKxOWN
         5aGPufUTGO3VyKo2Ffw2oy1g4Bg50PH7mZnxHovAb6qk1MRZhoq3c5t3bKcIF+f5Y/Pl
         emUwXIdnaEx5GI4J5Bw0SBrBiV3IJzy/DPJ3OmumUL7lyecbVcDUoi0G/9+kjyXRpnwN
         mx0Q==
X-Gm-Message-State: AOAM531UnBQkbBwvSl/q2ii7gF5ZoLWAklsVZ4aGXm6S7kaW8j2j+YXQ
        y98I2MPc0YBWiZ+aANc+U1N7VYl4kLuPrPT4/xI=
X-Google-Smtp-Source: ABdhPJyYCXBmQgiV5syIf5Cv8mFWKTwy1gjS5Yhyhg4Qi/jYzZasdmgfRgJp2ybsEGtlgybQDIghy8J0Yy2+jaKx2kI=
X-Received: by 2002:a17:90a:4e1:: with SMTP id g88mr3222886pjg.7.1613144743400;
 Fri, 12 Feb 2021 07:45:43 -0800 (PST)
MIME-Version: 1.0
References: <20201116145809.410558-1-hch@lst.de> <20201116145809.410558-13-hch@lst.de>
In-Reply-To: <20201116145809.410558-13-hch@lst.de>
From:   Mike Snitzer <snitzer@redhat.com>
Date:   Fri, 12 Feb 2021 10:45:32 -0500
Message-ID: <CAMM=eLfD0_Am3--X+PsKPTfc9qzejxpMNjYwEh=WtjSa-iSncg@mail.gmail.com>
Subject: Re: [PATCH 12/78] dm: use set_capacity_and_notify
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Justin Sanders <justin@coraid.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
        Minchan Kim <minchan@kernel.org>, Song Liu <song@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        device-mapper development <dm-devel@redhat.com>,
        linux-block <linux-block@vger.kernel.org>,
        drbd-dev@lists.linbit.com, nbd@other.debian.org,
        ceph-devel@vger.kernel.org, xen-devel@lists.xenproject.org,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        linux-nvme@lists.infradead.org,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 16, 2020 at 10:05 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Use set_capacity_and_notify to set the size of both the disk and block
> device.  This also gets the uevent notifications for the resize for free.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/md/dm.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index c18fc25485186d..62ad44925e73ec 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -1971,8 +1971,7 @@ static struct dm_table *__bind(struct mapped_device *md, struct dm_table *t,
>         if (size != dm_get_size(md))
>                 memset(&md->geometry, 0, sizeof(md->geometry));
>
> -       set_capacity(md->disk, size);
> -       bd_set_nr_sectors(md->bdev, size);
> +       set_capacity_and_notify(md->disk, size);
>
>         dm_table_event_callback(t, event_callback, md);
>

Not yet pinned down _why_ DM is calling set_capacity_and_notify() with
a size of 0 but, when running various DM regression tests, I'm seeing
a lot of noise like:

[  689.240037] dm-2: detected capacity change from 2097152 to 0

Is this pr_info really useful?  Should it be moved to below: if
(!capacity || !size) so that it only prints if a uevent is sent?

Mike
