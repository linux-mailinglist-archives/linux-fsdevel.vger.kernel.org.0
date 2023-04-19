Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7566E7E4D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Apr 2023 17:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233482AbjDSPbD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Apr 2023 11:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233490AbjDSPa4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Apr 2023 11:30:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477621B1
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Apr 2023 08:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681918212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tk4ILYUitykXDNv2nAhy0f5ydU+4a31pQqGhvmwhdPk=;
        b=jRmSxzoNVMoG0Wkb+cVSS/8NjtZJ3iyt+3d1nSX+Ya8xfNLVzQYwkt1NJqchOwqqMhLTTV
        WAwZ2x+j349sDxJmgiFmd1ixTOuMMfwtZrY+y7kk8a1SZTNOT4U+IEXUTaw09YVPreKjAV
        QY4Y5XIIMYF42HB8pHIISB7Pu2owGAs=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-xOBse5nSNmyUInhuNTTjMA-1; Wed, 19 Apr 2023 11:19:45 -0400
X-MC-Unique: xOBse5nSNmyUInhuNTTjMA-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-24736ac595aso2404873a91.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Apr 2023 08:19:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681917584; x=1684509584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tk4ILYUitykXDNv2nAhy0f5ydU+4a31pQqGhvmwhdPk=;
        b=gBTKCahjaDJjlk/WN2NOjtam8jR47lvvSdnl+KxLdJhPbZnAHt9aHDvw5kZ/px+MYI
         wTkCjxmSWlKKntYLLC7crxrJQ9v8HR9jB0JtGU5J7XDXcvA4EVp1dPyLH4ebXSgLgQWp
         Xxgv4RsrEB9+XoW2UhxiLmZPyQ2t/9bCDWcg2f/RGw0tZW19f/1rFrO9e8CkNsT7HW9q
         pSSb8yOkumncxOH53TIfZuvmIUHng5oytOc3HBXKs/LUpGOwb7ByiqqlfrvS33DtDBs2
         i+sCmDqxj+iP1G/yc3VHa8qsuD6mn8eHoaWa2JPi+MC9jB7WR0vJoAQtJWNxR5MYzccr
         5ObA==
X-Gm-Message-State: AAQBX9enb4u7dO6wmiC8lz6Ml8VI0wH5vvs2w/J9vG6g++muAb50w9d6
        JdJRzjItS/fpoGeNeOyG3PQqYJg5PrwLsYSl20Re3HeGcQ7hsfY/MqGLfXg5qJZFzb/21ufkqwN
        bkKtmQCaSeXVXeJmjSjnjbCIgn7FHTPvbNO0ZwzX8mw==
X-Received: by 2002:a17:90a:2ca4:b0:247:fec:3cf with SMTP id n33-20020a17090a2ca400b002470fec03cfmr1032464pjd.9.1681917584663;
        Wed, 19 Apr 2023 08:19:44 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZilzTP35l+fCVfSRmyAr7TA2z2HByJ2c77EoLXxjUVlBIE5WaJ/vbFqG27YJf1gGuB7p5La9B7yskBhiQ6yjg=
X-Received: by 2002:a17:90a:2ca4:b0:247:fec:3cf with SMTP id
 n33-20020a17090a2ca400b002470fec03cfmr1032449pjd.9.1681917584368; Wed, 19 Apr
 2023 08:19:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230419140929.5924-1-jth@kernel.org> <20230419140929.5924-12-jth@kernel.org>
In-Reply-To: <20230419140929.5924-12-jth@kernel.org>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Wed, 19 Apr 2023 17:19:31 +0200
Message-ID: <CAHc6FU6U1yZguZGeCc7BUqd1Qm4+SSRK8xbNZWBUSXTk_jjvVQ@mail.gmail.com>
Subject: Re: [PATCH v3 11/19] gfs: use __bio_add_page for adding single page
 to bio
To:     Johannes Thumshirn <jth@kernel.org>
Cc:     axboe@kernel.dk, johannes.thumshirn@wdc.com,
        cluster-devel@redhat.com, damien.lemoal@wdc.com,
        dm-devel@redhat.com, dsterba@suse.com, hare@suse.de, hch@lst.de,
        jfs-discussion@lists.sourceforge.net, kch@nvidia.com,
        linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-raid@vger.kernel.org, ming.lei@redhat.com,
        rpeterso@redhat.com, shaggy@kernel.org, snitzer@kernel.org,
        song@kernel.org, willy@infradead.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 19, 2023 at 4:10=E2=80=AFPM Johannes Thumshirn <jth@kernel.org>=
 wrote:
>
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> The GFS superblock reading code uses bio_add_page() to add a page to a
> newly created bio. bio_add_page() can fail, but the return value is never
> checked.

It's GFS2, not GFS, but otherwise this is obviously fine, thanks.

> Use __bio_add_page() as adding a single page to a newly created bio is
> guaranteed to succeed.
>
> This brings us a step closer to marking bio_add_page() as __must_check.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

Reviewed-by: Andreas Gruenbacher <agruenba@redhat.com>

> ---
>  fs/gfs2/ops_fstype.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
> index 6de901c3b89b..e0cd0d43b12f 100644
> --- a/fs/gfs2/ops_fstype.c
> +++ b/fs/gfs2/ops_fstype.c
> @@ -254,7 +254,7 @@ static int gfs2_read_super(struct gfs2_sbd *sdp, sect=
or_t sector, int silent)
>
>         bio =3D bio_alloc(sb->s_bdev, 1, REQ_OP_READ | REQ_META, GFP_NOFS=
);
>         bio->bi_iter.bi_sector =3D sector * (sb->s_blocksize >> 9);
> -       bio_add_page(bio, page, PAGE_SIZE, 0);
> +       __bio_add_page(bio, page, PAGE_SIZE, 0);
>
>         bio->bi_end_io =3D end_bio_io_page;
>         bio->bi_private =3D page;
> --
> 2.39.2
>

