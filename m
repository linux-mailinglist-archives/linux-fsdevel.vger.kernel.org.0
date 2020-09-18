Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCB43270188
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Sep 2020 18:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgIRQCM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Sep 2020 12:02:12 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33602 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgIRQCL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Sep 2020 12:02:11 -0400
Received: by mail-oi1-f196.google.com with SMTP id m7so7616436oie.0;
        Fri, 18 Sep 2020 09:02:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CLWLadygFzbacUrStlzsUwiQts54prWGYIH+pDEwe0A=;
        b=dYrQVj2rSXLlWEWNr3I6U+LMUuW6xJDLNKqC4E7FszQEKpmQFodheM4yINYXSj//4h
         NM1YRX+jum28PBQ41gM6/AMWC6ktoTFS+vbC0ZsBf0C4IZ81/JqC5U2qN3teCiFXUYF5
         aMclzO4ylo+9ObumQp7O9zxoLga6nGnBAjVLRmBYZpb/W4WDJqFpCAqekLFudl8uIdrm
         iZUoM+rZjj0dL8lXgqx86r2BiWszlUMFR0hF+gMXinVjoY1ajYGpU2/qz0vmVrtWtfIe
         8vjRzXOjFrQek3EfiMKb3Z/THPKF02ZimCEIjh1aIrjZpTT3i80ps+NArBlU9whzMuCi
         Hx5A==
X-Gm-Message-State: AOAM532srrIyMv6hz9hJYp9Xi/nPRaCXHbVFToX9G1562zLHtuxhlyrr
        u1M6ZZNVFkSe2LSw/75VDYwvB4h7zT4a159QT1I=
X-Google-Smtp-Source: ABdhPJygTxTyjBXaRmjiZjnzUB9+LiiCBE3DDYWxmdEXB/AZO3s12ola6t96FwD5p8jaLrRmcTTRjtSYPzdoh/tzvoc=
X-Received: by 2002:aca:df84:: with SMTP id w126mr10401882oig.103.1600444930764;
 Fri, 18 Sep 2020 09:02:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200917165720.3285256-1-hch@lst.de> <20200917165720.3285256-14-hch@lst.de>
In-Reply-To: <20200917165720.3285256-14-hch@lst.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 18 Sep 2020 18:01:59 +0200
Message-ID: <CAJZ5v0jAQnEHedZs7kQmfHx4KTw9G1wrObuEpid_m5uVk5qoJQ@mail.gmail.com>
Subject: Re: [PATCH 13/14] PM: mm: cleanup swsusp_swap_check
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        Minchan Kim <minchan@kernel.org>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        nbd@other.debian.org,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 17, 2020 at 7:39 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Use blkdev_get_by_dev instead of bdget + blkdev_get.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  kernel/power/swap.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
> index 9d3ffbfe08dbf6..71385bedcc3a49 100644
> --- a/kernel/power/swap.c
> +++ b/kernel/power/swap.c
> @@ -343,12 +343,10 @@ static int swsusp_swap_check(void)
>                 return res;
>         root_swap = res;
>
> -       hib_resume_bdev = bdget(swsusp_resume_device);
> -       if (!hib_resume_bdev)
> -               return -ENOMEM;
> -       res = blkdev_get(hib_resume_bdev, FMODE_WRITE, NULL);
> -       if (res)
> -               return res;
> +       hib_resume_bdev = blkdev_get_by_dev(swsusp_resume_device, FMODE_WRITE,
> +                       NULL);
> +       if (IS_ERR(hib_resume_bdev))
> +               return PTR_ERR(hib_resume_bdev);
>
>         res = set_blocksize(hib_resume_bdev, PAGE_SIZE);
>         if (res < 0)
> --
> 2.28.0
>
