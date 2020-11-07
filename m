Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA872AA1D9
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Nov 2020 01:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbgKGAj7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Nov 2020 19:39:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:42262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726447AbgKGAj6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Nov 2020 19:39:58 -0500
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD7D822210;
        Sat,  7 Nov 2020 00:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604709598;
        bh=yHGYGCtLswTDWsVV8G7btJ2YrfbhRJpoj/2QQHMNku0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JaraML33QnlELqv9b1nVGycC8TqrN2CO3mYGqYHHPbzpftbxLrgkNlDLzNuVKBnOA
         +2GGCnIf2S6SmvnOXWVOrneIGjkyT+jTAQmqF3CZZVfU2qqbBMNpn6QobIOWbu07iq
         qAPvrSntweEuYizqycf91KNQI82ZEYM27rTtgZAw=
Received: by mail-lf1-f51.google.com with SMTP id v144so4348780lfa.13;
        Fri, 06 Nov 2020 16:39:57 -0800 (PST)
X-Gm-Message-State: AOAM5330H0J2yYpb6Q3WzWIVjyxQedwd2/O0+fVb7U37A4dxhPukQzcS
        wlkpzAwLAuM1JiH1F+Joo7s9bypCSlWR6A5iTJY=
X-Google-Smtp-Source: ABdhPJxa7Wve2F+59EP4hPqinvAbRhF4pNbwqT8FgL1QaPoOKbDOM27LB1KUwtpCP4KuABwtVBcs7qNXSe7PRXbnm/0=
X-Received: by 2002:a19:4b45:: with SMTP id y66mr1708840lfa.482.1604709595815;
 Fri, 06 Nov 2020 16:39:55 -0800 (PST)
MIME-Version: 1.0
References: <20201106190337.1973127-1-hch@lst.de> <20201106190337.1973127-23-hch@lst.de>
In-Reply-To: <20201106190337.1973127-23-hch@lst.de>
From:   Song Liu <song@kernel.org>
Date:   Fri, 6 Nov 2020 16:39:44 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4TjGZYpf-Ad4sk5WMq8BLGTpxaCd-FnMfmqo49pX1Z9w@mail.gmail.com>
Message-ID: <CAPhsuW4TjGZYpf-Ad4sk5WMq8BLGTpxaCd-FnMfmqo49pX1Z9w@mail.gmail.com>
Subject: Re: [PATCH 22/24] md: remove a spurious call to revalidate_disk_size
 in update_size
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
        Minchan Kim <minchan@kernel.org>,
        Mike Snitzer <snitzer@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        drbd-dev@lists.linbit.com, nbd@other.debian.org,
        ceph-devel@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-raid <linux-raid@vger.kernel.org>,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 6, 2020 at 11:04 AM Christoph Hellwig <hch@lst.de> wrote:
>
> None of the ->resize methods updates the disk size, so calling
> revalidate_disk_size here won't do anything.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Song Liu <song@kernel.org>

> ---
>  drivers/md/md-cluster.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/md/md-cluster.c b/drivers/md/md-cluster.c
> index 87442dc59f6ca3..35e2690c1803dd 100644
> --- a/drivers/md/md-cluster.c
> +++ b/drivers/md/md-cluster.c
> @@ -1299,8 +1299,6 @@ static void update_size(struct mddev *mddev, sector_t old_dev_sectors)
>         } else {
>                 /* revert to previous sectors */
>                 ret = mddev->pers->resize(mddev, old_dev_sectors);
> -               if (!ret)
> -                       revalidate_disk_size(mddev->gendisk, true);
>                 ret = __sendmsg(cinfo, &cmsg);
>                 if (ret)
>                         pr_err("%s:%d: failed to send METADATA_UPDATED msg\n",
> --
> 2.28.0
>
