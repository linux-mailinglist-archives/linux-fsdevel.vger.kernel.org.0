Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 965722ABDD9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Nov 2020 14:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729875AbgKINwJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Nov 2020 08:52:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729320AbgKINwI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Nov 2020 08:52:08 -0500
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C748C0613CF;
        Mon,  9 Nov 2020 05:52:08 -0800 (PST)
Received: by mail-il1-x144.google.com with SMTP id n5so8308398ile.7;
        Mon, 09 Nov 2020 05:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kU2Lz6FCVrZiuEoHabGbCYI8mZi4aQygf2Kr0fLfGG4=;
        b=Lb/BkUcVIcd6xhv8oVONfECjW/ZB+eIGRHnh0dm3V/Dcve1CHMxGnjqr8op+1v76K7
         BboZLuIC9lFoWJc8zRN7ckG8JYkUCEMrBXYH3LeqwWaeQw6FiksBZKkC4/rY+nMcbUOP
         mcyx+jHFLBCXxcHO2RHq4/pyA2nmEefVK9oOy9OsQ2fr8vLqz43v1yvxxZclHh7D+k2N
         Qw7b/fXaJ5trjyicYsioOneOxQN4Qzfe8MAWER1MvLiN60BX2gzHW6baJIDiu8cGcvYG
         BbC7br0UMOuvYPQzgHxuAO2xrcgSSEORe8jj2L4/gatFyG+wbhw19VFJICOjyYa/QKXf
         TWnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kU2Lz6FCVrZiuEoHabGbCYI8mZi4aQygf2Kr0fLfGG4=;
        b=D8rIfe5/uWkbC96VbYLZLOB1Be1V6kifmsvMT/yHbyh94Rej9hB8K6xRXfurRtakZk
         A6dojU4SMDTorGcBtecsRUDl5R/VGT9o7VPYOWOHAMwmfwsH4eZqupQGK8+vCywTNvFk
         SWBoIqAvWp3qlZE59p3H67kffGiFG3p8oeg+x7rQ2o16d7h6MfscaAv0wvgRU5yuFTTG
         bxBHBcY674d522JcQNvYxZUkEW+EZ3NyGYwl0ukH3RVwg5RDUBqcV9YIPdupaWdePWTR
         Sy0yETcTBC4JizmuFwMFJsW5IDLS+RVkuOP15CyFn2Jz4sx6WCJGQjPHw4XnyJNEM6hx
         kmXA==
X-Gm-Message-State: AOAM531ZiLGQQ12TVLv7zLhF8uB5Mim/6Af5ikO/eVtKjBQ/zU5KrYsO
        7eD2SwiVQI44xfhwkrI+lfq6x3B6pcqrmxerMgE=
X-Google-Smtp-Source: ABdhPJyXm5ijaiShQDd7Xj0k0fsOvCm3U5j3JctcQpIY73kNN30YAUsNc9VfJ5DemzskInCCw4oOffcooZ/r5dSiKD8=
X-Received: by 2002:a05:6e02:c:: with SMTP id h12mr10623495ilr.177.1604929927708;
 Mon, 09 Nov 2020 05:52:07 -0800 (PST)
MIME-Version: 1.0
References: <20201106190337.1973127-1-hch@lst.de> <20201106190337.1973127-18-hch@lst.de>
In-Reply-To: <20201106190337.1973127-18-hch@lst.de>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Mon, 9 Nov 2020 14:52:08 +0100
Message-ID: <CAOi1vP83cOt_FOFLXQmgBpDgmaq8o8OQcUYWOb97jzkgOw6r4A@mail.gmail.com>
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

On Fri, Nov 6, 2020 at 8:04 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Use set_capacity_and_notify to set the size of both the disk and block
> device.  This also gets the uevent notifications for the resize for free.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
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

Acked-by: Ilya Dryomov <idryomov@gmail.com>

Thanks,

                Ilya
