Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACB76D279E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Mar 2023 20:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbjCaSOQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Mar 2023 14:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbjCaSOO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Mar 2023 14:14:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624381EA1C;
        Fri, 31 Mar 2023 11:14:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C7639B83174;
        Fri, 31 Mar 2023 18:14:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87126C433A1;
        Fri, 31 Mar 2023 18:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680286445;
        bh=gAgmbH9ftu5DAZPB9SoVGvrkWv8Y2dxMgr70HbBIrh0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=u2UyJ61FTV2+znZWsPlsLmvw7sSO3LeRWInykbiXqNJPkVJ40IoNP6aBsJ2TWeaQo
         q4hvnrrVkPXWhp+7v0LVHn2eHJRHdMeB2M8gGT9u2q7y/jHTOGvX0c3uaSmH//NvBI
         NAfAKgPsBu+QPzmtzJUt5QWiZB71tmWY0DG/A+kIwHiExDVDu+tg4eoSY1wTe4d2lI
         lIqqU5MzNf6ii6c4tioA47PHAuGJKnj1E8lOf3g/+VX7YlXkc0r5gJjBj5iEazVvfx
         uKIKMzuy2JcSrnDgai8EOWQ6XQhty1enPVqZRvFJEEC48cy1uMs1Es4DpzFbe5p93B
         FF/gFfYitQwzg==
Received: by mail-lf1-f47.google.com with SMTP id y15so30002961lfa.7;
        Fri, 31 Mar 2023 11:14:05 -0700 (PDT)
X-Gm-Message-State: AAQBX9eq96UeEg1wrTYYm2aZFLaMTWQqkQc2bsFKORCqRkdePjRpaLEi
        vN6dEwZ/PMFAY9ZQreFyS902OM0ETC4ZPJSWUB0=
X-Google-Smtp-Source: AKy350bGczgf8cOPQ3B8DjpL0OvNqhqJf0gVtuLTkWI0qZ++fzJqZuNXbM/Tji+xZXn5DWwX7QOe8uol0L5QJx5bU4Q=
X-Received: by 2002:ac2:5610:0:b0:4dd:a4e1:4861 with SMTP id
 v16-20020ac25610000000b004dda4e14861mr8251248lfd.3.1680286443592; Fri, 31 Mar
 2023 11:14:03 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1680172791.git.johannes.thumshirn@wdc.com> <8b8a3bb2db8c5183ef36c1810f2ac776ac526327.1680172791.git.johannes.thumshirn@wdc.com>
In-Reply-To: <8b8a3bb2db8c5183ef36c1810f2ac776ac526327.1680172791.git.johannes.thumshirn@wdc.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 31 Mar 2023 11:13:51 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7a+mpn+VprfA2mC5Fc+M9BFq8i6d-y+-o5G1u5dOsk2Q@mail.gmail.com>
Message-ID: <CAPhsuW7a+mpn+VprfA2mC5Fc+M9BFq8i6d-y+-o5G1u5dOsk2Q@mail.gmail.com>
Subject: Re: [PATCH v2 17/19] md: raid1: check if adding pages to resync bio fails
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
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 30, 2023 at 3:44=E2=80=AFAM Johannes Thumshirn
<johannes.thumshirn@wdc.com> wrote:
>
> Check if adding pages to resync bio fails and if bail out.
>
> As the comment above suggests this cannot happen, WARN if it actually
> happens.
>
> This way we can mark bio_add_pages as __must_check.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
>  drivers/md/raid1-10.c |  7 ++++++-
>  drivers/md/raid10.c   | 12 ++++++++++--
>  2 files changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/md/raid1-10.c b/drivers/md/raid1-10.c
> index e61f6cad4e08..c21b6c168751 100644
> --- a/drivers/md/raid1-10.c
> +++ b/drivers/md/raid1-10.c
> @@ -105,7 +105,12 @@ static void md_bio_reset_resync_pages(struct bio *bi=
o, struct resync_pages *rp,
>                  * won't fail because the vec table is big
>                  * enough to hold all these pages
>                  */

We know these won't fail. Shall we just use __bio_add_page?

Thanks,
Song

> -               bio_add_page(bio, page, len, 0);
> +               if (WARN_ON(!bio_add_page(bio, page, len, 0))) {
> +                       bio->bi_status =3D BLK_STS_RESOURCE;
> +                       bio_endio(bio);
> +                       return;
> +               }
> +
>                 size -=3D len;
>         } while (idx++ < RESYNC_PAGES && size > 0);
>  }
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index 6c66357f92f5..5682dba52fd3 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -3808,7 +3808,11 @@ static sector_t raid10_sync_request(struct mddev *=
mddev, sector_t sector_nr,
>                          * won't fail because the vec table is big enough
>                          * to hold all these pages
>                          */
> -                       bio_add_page(bio, page, len, 0);
> +                       if (WARN_ON(!bio_add_page(bio, page, len, 0))) {
> +                               bio->bi_status =3D BLK_STS_RESOURCE;
> +                               bio_endio(bio);
> +                               goto giveup;
> +                       }
>                 }
>                 nr_sectors +=3D len>>9;
>                 sector_nr +=3D len>>9;
> @@ -4989,7 +4993,11 @@ static sector_t reshape_request(struct mddev *mdde=
v, sector_t sector_nr,
>                          * won't fail because the vec table is big enough
>                          * to hold all these pages
>                          */
> -                       bio_add_page(bio, page, len, 0);
> +                       if (WARN_ON(!bio_add_page(bio, page, len, 0))) {
> +                               bio->bi_status =3D BLK_STS_RESOURCE;
> +                               bio_endio(bio);
> +                               return sectors_done; /* XXX: is this corr=
ect? */
> +                       }
>                 }
>                 sector_nr +=3D len >> 9;
>                 nr_sectors +=3D len >> 9;
> --
> 2.39.2
>
