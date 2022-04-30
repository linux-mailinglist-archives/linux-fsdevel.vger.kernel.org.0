Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBA655159D5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Apr 2022 04:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379927AbiD3CoJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 22:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237621AbiD3CoI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 22:44:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A42DFC3
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Apr 2022 19:40:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13287624D6
        for <linux-fsdevel@vger.kernel.org>; Sat, 30 Apr 2022 02:40:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7530CC385B0
        for <linux-fsdevel@vger.kernel.org>; Sat, 30 Apr 2022 02:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651286447;
        bh=zLfo+GvFiKZgTEynXurdG2YKtO/BFvAhw7DQB0A4KG8=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=bX41Ta8+2BvwlS0luypDmuOFI/bOxWMYU6PU0p0v9VboEuvONu+616JMjGVl7smMb
         31iL8QqjFu/JTsga+MJK2rf0WPk/srg65WXG2Y4LnwOq/PjiCMyKtdlL2hJACKchXM
         zkcRNwODiTc06mht/omEj6JdnPGlylb6m3J3M2k5o9eiR3yEhUo5jX7pRmxKqqXVGl
         //Fd2V+2mjanLz2sFe6DaTvPk1oZWJQ34UWUNT/ys57/m9AhIPbk6LrsuODf1C/4bv
         99/khb6IM51AzGZ7oHhc3PZT0WE93UKyVgRkaS9Xa0gdh00Xdsdoa+EARCQRQbFdse
         d7ouhw8b85Fgg==
Received: by mail-wr1-f45.google.com with SMTP id k2so12890974wrd.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Apr 2022 19:40:47 -0700 (PDT)
X-Gm-Message-State: AOAM5300uRXEco6srHsZqgexp10GeEaFreqMa8/Z6n9Whrun3SKE2BlO
        NEbYr4opAy6qAY6CyMbLmadTaBIgBR+3i+6Ehl4=
X-Google-Smtp-Source: ABdhPJzKyGWonoStbzv4Bu+k1DC+e+3vHWcwTToYoIVn4YSSfWO1tTFaPgQC53UjfU+g2PEPF+RGnU+vPL9RwqazxF0=
X-Received: by 2002:a05:6000:1a8b:b0:20c:45fe:b02e with SMTP id
 f11-20020a0560001a8b00b0020c45feb02emr1431662wry.504.1651286445699; Fri, 29
 Apr 2022 19:40:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5d:64e7:0:0:0:0:0 with HTTP; Fri, 29 Apr 2022 19:40:44
 -0700 (PDT)
In-Reply-To: <20220429200100.22659-1-rdunlap@infradead.org>
References: <20220429200100.22659-1-rdunlap@infradead.org>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Sat, 30 Apr 2022 11:40:44 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8BKGgsbn7428CTfUhnrunBPsSeTdXgiyKQU_cqYKOk1w@mail.gmail.com>
Message-ID: <CAKYAXd8BKGgsbn7428CTfUhnrunBPsSeTdXgiyKQU_cqYKOk1w@mail.gmail.com>
Subject: Re: [PATCH v2] fs/ntfs3: validate BOOT sectors_per_clusters
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2022-04-30 5:01 GMT+09:00, Randy Dunlap <rdunlap@infradead.org>:
> When the NTFS BOOT sectors_per_clusters field is > 0x80,
> it represents a shift value. Make sure that the shift value is
> not too large (> 31) before using it. Return 0xffffffff if it is.
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
> ---
> v2: use Willy's suggestions
>
>  fs/ntfs3/super.c |    8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
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
> +	if (boot->sectors_per_clusters > 0xe0) /* limit to 31-bit shift */
ntfs maximum cluster size is 2MB. I think that we can change it to
boot->sectors_per_clusters >= 0xf4.
> +		return 1U << (0 - boot->sectors_per_clusters);
> +	return 0xffffffff;
It would be better to change it to return an error(-EINVAL) instead of
0xffffffff.
and if sct_per_clst < 0, goto out immediately..
>  }
>
>  /*
>
>
