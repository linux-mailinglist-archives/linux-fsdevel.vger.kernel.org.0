Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5470477A839
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Aug 2023 17:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbjHMP5S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Aug 2023 11:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbjHMP4s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Aug 2023 11:56:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9821FE8;
        Sun, 13 Aug 2023 08:56:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 693F26347A;
        Sun, 13 Aug 2023 15:55:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6AD7C433C7;
        Sun, 13 Aug 2023 15:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691942111;
        bh=EE1qBYC2VFNgzkC+5CVDvVGU409np2W52fk9BXNiCT8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=B6Zx4/Zlu08UZbl5IW6n9yXisovtrPq6cDENng6nRMcd88Nk3qkJVpOJH5yA/zdZT
         vtbmJ7wLIStvLFZ8zbXcyyue4QAuAP7KuKoMJmZyRgdj02TrsG7Lhgv/qYFtrBwNde
         YnvUhgGS5ZSszmsHdk861EoAJBehNMZv2RodzHZNkFj+2ZxilvINTmJwLnLmupw2GY
         mrUwVW4LQ51S76y3LId2jMewToI/7Tc9djoZPRO9NSWJbw1E4ghOfsWvvU7Z/WXoqi
         UfGkvycKUF2ubgvYJyM0AIXXuyHFJ/se5v0JK2eX24SRy7oiR32bPjpdLPJIF06rmj
         TigsP6W6bNSvw==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2b9dc1bff38so51966551fa.1;
        Sun, 13 Aug 2023 08:55:11 -0700 (PDT)
X-Gm-Message-State: AOJu0YwCiD2VWjROBWqSl5Opb/OzFRK1lv7LNWf2kmAEboaqJSckDS9+
        1KA+J1L4CkPB6HjJROGKmWD+2HM+TSf/1mhutsI=
X-Google-Smtp-Source: AGHT+IE6JOJlfZPkn6MmM3Dm0G9btbpive7UJR8vXvvHfhahTolgYnkSCRd2XJcGPP1xys/Rq59sG0mLjb1ZArVUtMU=
X-Received: by 2002:a05:6512:2f9:b0:4fe:82a7:814d with SMTP id
 m25-20020a05651202f900b004fe82a7814dmr4223909lfq.48.1691942109831; Sun, 13
 Aug 2023 08:55:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230810171429.31759-1-jack@suse.cz> <20230811110504.27514-11-jack@suse.cz>
In-Reply-To: <20230811110504.27514-11-jack@suse.cz>
From:   Song Liu <song@kernel.org>
Date:   Sun, 13 Aug 2023 19:54:56 +0400
X-Gmail-Original-Message-ID: <CAPhsuW5S2gjPv+UpLjX=uBhsbPOmNGMbGjF2eJO7rWMnGVgOmg@mail.gmail.com>
Message-ID: <CAPhsuW5S2gjPv+UpLjX=uBhsbPOmNGMbGjF2eJO7rWMnGVgOmg@mail.gmail.com>
Subject: Re: [PATCH 11/29] md: Convert to bdev_open_by_dev()
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 11, 2023 at 3:05=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
[...]
> diff --git a/drivers/md/md.h b/drivers/md/md.h
> index 1aef86bf3fc3..e8108845157b 100644
> --- a/drivers/md/md.h
> +++ b/drivers/md/md.h
> @@ -59,6 +59,7 @@ struct md_rdev {
>          */
>         struct block_device *meta_bdev;
>         struct block_device *bdev;      /* block device handle */
> +       struct bdev_handle *bdev_handle;        /* Handle from open for b=
dev */

With bdev_handle, we should eventually get rid of md_rdev->bdev.
But that can be done in a separate patch.

Acked-by: Song Liu <song@kernel.org>

>
>         struct page     *sb_page, *bb_page;
>         int             sb_loaded;
> --
> 2.35.3
>
