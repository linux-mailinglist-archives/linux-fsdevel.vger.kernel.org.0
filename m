Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0684517CDE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 May 2022 07:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiECF4b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 May 2022 01:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiECF4a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 May 2022 01:56:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF6123BF9
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 May 2022 22:52:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4728D6154D
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 May 2022 05:52:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F939C385B7
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 May 2022 05:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651557178;
        bh=ITa2NwqXe5zLXa48uJhMNSWPpRvUDo2drvTp2+JtsD4=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=rCdJPjUWySfQ1jZvtIdn8tJ+fRt9qrPwTmotfPk28AvGQreF50malXmLIK1d1GtPq
         HTYzjxl9fG/W05NWTqP2BVDmQVk33Lq7hrbDMJMETgy3FRxWjaDiCsAepOqY7fReob
         pTNox8NZvwQFispufe1caFXhVS8lEvRZdakRs3wgT/1V9QbteyXP2VaL0RXhUEqFj0
         TjBvprjVII0TvHHmB+iL2QviOBh+44RiCzeIr/1tBdiO+4+WxOEi3THU5GU6+GBZIT
         ehR3r9VakwvKXRA8bbH69b+Ge5EnCesO5v1xIRwwkMgvXIzNx4wcbUtkKHbUn2CU9C
         HEr3whKOktULA==
Received: by mail-wm1-f48.google.com with SMTP id m62so9272673wme.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 May 2022 22:52:58 -0700 (PDT)
X-Gm-Message-State: AOAM531lGV4eGqoD1MK7IvZvj6Kql0K+DsuBlrth7gx1IiKbUfd3VEGt
        gm1n9I09VX+T8ilon722U9lgDi1pE9eSnFtYQ+Q=
X-Google-Smtp-Source: ABdhPJyNNCIH65z+ugyOzWOp33nsssQlkEfrnNFd/8Kk2TgNO4FM3ihi6IvSwEhKnj15TITSvj9jhrH9UEyu66infmg=
X-Received: by 2002:a05:600c:3503:b0:38f:fbd7:1f0d with SMTP id
 h3-20020a05600c350300b0038ffbd71f0dmr1817436wmq.170.1651557176740; Mon, 02
 May 2022 22:52:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5d:4571:0:0:0:0:0 with HTTP; Mon, 2 May 2022 22:52:56 -0700 (PDT)
In-Reply-To: <20220502175342.20296-1-rdunlap@infradead.org>
References: <20220502175342.20296-1-rdunlap@infradead.org>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Tue, 3 May 2022 14:52:56 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8wWbe+xtd5jWSxmb9NF1YFYDo-2DQAJVLhZCHQaEnRSg@mail.gmail.com>
Message-ID: <CAKYAXd8wWbe+xtd5jWSxmb9NF1YFYDo-2DQAJVLhZCHQaEnRSg@mail.gmail.com>
Subject: Re: [PATCH v3] fs/ntfs3: validate BOOT sectors_per_clusters
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org,
        syzbot+1631f09646bc214d2e76@syzkaller.appspotmail.com,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev, Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kari Argillander <kari.argillander@stargateuniverse.net>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2022-05-03 2:53 GMT+09:00, Randy Dunlap <rdunlap@infradead.org>:
> When the NTFS BOOT sectors_per_clusters field is > 0x80,
> it represents a shift value. Make sure that the shift value is
> not too large before using it (NTFS max cluster size is 2MB).
> Return -EVINVAL if it too large.
>
> This prevents negative shift values and shift values that are
> larger than the field size.
>
> Prevents this UBSAN error:
>
>  UBSAN: shift-out-of-bounds in ../fs/ntfs3/super.c:673:16
>  shift exponent -192 is negative
>
> Fixes: 82cae269cfa9 ("fs/ntfs3: Add initialization of super block")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: syzbot+1631f09646bc214d2e76@syzkaller.appspotmail.com
> Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> Cc: ntfs3@lists.linux.dev
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Kari Argillander <kari.argillander@stargateuniverse.net>
> Cc: Namjae Jeon <linkinjeon@kernel.org>
> Cc: Matthew Wilcox <willy@infradead.org>
Looks good to me:)

Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>

Thanks.
> ---
> v2: use Willy's suggestions
> v3: use Namjae's suggestions -- but now Konstantin can decide.
>     drop Willy's Rev-by: tag due to changes
>
>  fs/ntfs3/super.c |   10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> --- linux-next-20220428.orig/fs/ntfs3/super.c
> +++ linux-next-20220428/fs/ntfs3/super.c
> @@ -668,9 +668,11 @@ static u32 format_size_gb(const u64 byte
>
>  static u32 true_sectors_per_clst(const struct NTFS_BOOT *boot)
>  {
> -	return boot->sectors_per_clusters <= 0x80
> -		       ? boot->sectors_per_clusters
> -		       : (1u << (0 - boot->sectors_per_clusters));
> +	if (boot->sectors_per_clusters <= 0x80)
> +		return boot->sectors_per_clusters;
> +	if (boot->sectors_per_clusters >= 0xf4) /* limit shift to 2MB max */
> +		return 1U << (0 - boot->sectors_per_clusters);
> +	return -EINVAL;
>  }
>
>  /*
> @@ -713,6 +715,8 @@ static int ntfs_init_from_boot(struct su
>
>  	/* cluster size: 512, 1K, 2K, 4K, ... 2M */
>  	sct_per_clst = true_sectors_per_clst(boot);
> +	if ((int)sct_per_clst < 0)
> +		goto out;
>  	if (!is_power_of_2(sct_per_clst))
>  		goto out;
>
>
>
