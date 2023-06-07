Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2DB5725AC6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 11:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240113AbjFGJkT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 05:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239324AbjFGJkQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 05:40:16 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B51C1982
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jun 2023 02:40:13 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-51494659d49so1125983a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jun 2023 02:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1686130812; x=1688722812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OKacAnva3Yv49FZ4mmigtapivvs6Pz0X+m8VvMKeakc=;
        b=dCfiHbfC3g2G8d/J9z4HWJRn+4ZM/R3bpLuFPxQw29U/BxQqfJsF3/Pcs7fI41A4gX
         QmjGzJZ4A2vjupZlP6QlquJwygr1R+FDDkAU1dI8tFxGxMQBNhKyKD/kPuOGtcHtWHsN
         KTwy+1yD0l655Rbq6xnYm39sKjIDdP4MTsPmGu5Qrnj6S7RG+MOe/U9goLkbKdoPlXty
         JKXk/P/K/Z5i1goc4SEzvnQut6+E/y0p5im5y9dCvVaH0pV3VQijuFqDyfn3GCXb695U
         7ow15qjqM2IYWuhG0bdltyHA6aebtUZOak/1yjhnxavTWTfQy9rV8KO6L8zOuHlEdvBX
         31YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686130812; x=1688722812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OKacAnva3Yv49FZ4mmigtapivvs6Pz0X+m8VvMKeakc=;
        b=O9MSh/QXsmizeFIprtFHz+Wv2/FBpLdAZ2kUzzk1frEZRjHhKxqheq5iGh0aWiBfEF
         2B54o/8rGzSPOY9aU4ghERJCuHl9GxgfehxDr6FGqmZv1p224Cml3E4QYA6xsq2guq6L
         KmxAx+Z/+cqD1Ytx0+iz7LzWupFpZiB5f98U7weCdrramFUS1a+6KG5kUr2JLKxLLJ8M
         iv5xAe+54V9I4rwE62gdsxA9PmkBBvY/KUnx7gzABo7vd1LW0wVkvQn4ibHJwos6uTeY
         xlJJ1sInCSGXppIs4osR+/pmfDs8Sck/8XHEPdA62dFHNBPrW2+0+m+vhac+cydyT14Q
         qebQ==
X-Gm-Message-State: AC+VfDxO0a/vkRq6MWF/ty5GAB817ALdbOqq+1Om7kxK3lhajvAyqoY9
        HPRUstXWtfBgVDq5Ehpm2/Jn5dlJn5+Yx2gZVmZa5w==
X-Google-Smtp-Source: ACHHUZ6qGErDhBYRK2EQNWjsiTZgthNZdqE08xgi5M9Zl1p8ZDd17beUaKBrj0/jBLtUwBleXb1y7OCzWAlQzI4iqec=
X-Received: by 2002:aa7:c3c3:0:b0:516:3261:17d with SMTP id
 l3-20020aa7c3c3000000b005163261017dmr3772815edr.20.1686130811848; Wed, 07 Jun
 2023 02:40:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230606073950.225178-1-hch@lst.de> <20230606073950.225178-17-hch@lst.de>
In-Reply-To: <20230606073950.225178-17-hch@lst.de>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Wed, 7 Jun 2023 11:40:01 +0200
Message-ID: <CAMGffEkXqRMD3yeyjXzTn1ZyHnszmPhqRdP8eN12KXcTdz=9Xw@mail.gmail.com>
Subject: Re: [PATCH 16/31] block: use the holder as indication for exclusive opens
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Richard Weinberger <richard@nod.at>,
        Josef Bacik <josef@toxicpanda.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
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
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 6, 2023 at 9:40=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrote=
:
>
> The current interface for exclusive opens is rather confusing as it
> requires both the FMODE_EXCL flag and a holder.  Remove the need to pass
> FMODE_EXCL and just key off the exclusive open off a non-NULL holder.
>
> For blkdev_put this requires adding the holder argument, which provides
> better debug checking that only the holder actually releases the hold,
> but at the same time allows removing the now superfluous mode argument.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/bdev.c                        | 37 ++++++++++++++++------------
>  block/fops.c                        |  6 +++--
>  block/genhd.c                       |  5 ++--
>  block/ioctl.c                       |  5 ++--
>  drivers/block/drbd/drbd_nl.c        | 23 ++++++++++-------
>  drivers/block/pktcdvd.c             | 13 +++++-----
>  drivers/block/rnbd/rnbd-srv.c       |  4 +--
Acked-by: Jack Wang <jinpu.wang@ionos.com> # for rnbd
