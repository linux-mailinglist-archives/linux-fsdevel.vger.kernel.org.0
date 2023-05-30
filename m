Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2098D716EFC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 22:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbjE3UlM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 16:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjE3UlL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 16:41:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F348E;
        Tue, 30 May 2023 13:41:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 286156336C;
        Tue, 30 May 2023 20:41:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86BC1C4339E;
        Tue, 30 May 2023 20:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685479269;
        bh=NZg4xbNptwq5J83x4/9FfgWYp2tn6LBMqAKgwyJG6tQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=huQNFFH3zVrLLnm5WPfMAbkQPvxCmvDcAuR9nNKd/g6ZoLU+oubgPMfhcvejhwbMy
         bRuBct3r6wHKkzYqhqEvGFfCpZYRAuAiT3wzv9jYwpqlslolPQpVoC6l4bkxTW5cgq
         aHvAkKgwybK+QQl1B0Jilwhzk8yfsI7fuifW9XQTkoKFITI0dXVq6KXEBzrUICZPze
         PyVOTDar79WsVhr08Ikvo3yCjwDdtgjfVU2jkcBlq4rrXYZPDH8DmVzyUBEoHLrosB
         Mkru2m9rHaX4pyzYCzA4oMl+/2mViC42oBWSv4cVmV6MbUN1IWMmZVyQlgMZsMsif+
         TJLaW7xm4WLyg==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-4f4db9987f8so275773e87.1;
        Tue, 30 May 2023 13:41:09 -0700 (PDT)
X-Gm-Message-State: AC+VfDyEDKU7ap/F+eqFKI+/1NjSEoNR+a/SpvbbwknSwtcTS2B9K1Wk
        VX4UKpEIsObbwju0F9EMx+H2XddgdzALxM+QQHA=
X-Google-Smtp-Source: ACHHUZ7vuf2vQNikh852gIOeYbs1mAspWrnHLpuRQ0WVk/9d/YVdWPAiSzLnXbcDRj80He113UbugMRuu4yM7AjsQxc=
X-Received: by 2002:a2e:a222:0:b0:2af:18a9:782f with SMTP id
 i2-20020a2ea222000000b002af18a9782fmr4570675ljm.0.1685479267531; Tue, 30 May
 2023 13:41:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1685461490.git.johannes.thumshirn@wdc.com> <d7cfd04d410accee4148d8c0e51230bcb8b4bb8f.1685461490.git.johannes.thumshirn@wdc.com>
In-Reply-To: <d7cfd04d410accee4148d8c0e51230bcb8b4bb8f.1685461490.git.johannes.thumshirn@wdc.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 30 May 2023 13:40:55 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6hZWx3Jx0UOc20mf06c5QS5vfDKF_nauzm0mLkr3Xhsw@mail.gmail.com>
Message-ID: <CAPhsuW6hZWx3Jx0UOc20mf06c5QS5vfDKF_nauzm0mLkr3Xhsw@mail.gmail.com>
Subject: Re: [PATCH v6 13/20] md: check for failure when adding pages in alloc_behind_master_bio
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        dm-devel@redhat.com, linux-raid@vger.kernel.org,
        Mike Snitzer <snitzer@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net, cluster-devel@redhat.com,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>, gouhao@uniontech.com,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 30, 2023 at 8:50=E2=80=AFAM Johannes Thumshirn
<johannes.thumshirn@wdc.com> wrote:
>
> alloc_behind_master_bio() can possibly add multiple pages to a bio, but i=
t
> is not checking for the return value of bio_add_page() if adding really
> succeeded.
>
> Check if the page adding succeeded and if not bail out.
>
> Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Acked-by: Song Liu <song@kernel.org>

> ---
>  drivers/md/raid1.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> index 68a9e2d9985b..8283ef177f6c 100644
> --- a/drivers/md/raid1.c
> +++ b/drivers/md/raid1.c
> @@ -1147,7 +1147,10 @@ static void alloc_behind_master_bio(struct r1bio *=
r1_bio,
>                 if (unlikely(!page))
>                         goto free_pages;
>
> -               bio_add_page(behind_bio, page, len, 0);
> +               if (!bio_add_page(behind_bio, page, len, 0)) {
> +                       free_page(page);
> +                       goto free_pages;
> +               }
>
>                 size -=3D len;
>                 i++;
> --
> 2.40.1
>
