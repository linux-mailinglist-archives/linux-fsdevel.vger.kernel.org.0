Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5D274A76E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jul 2023 01:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbjGFXJu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 19:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjGFXJt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 19:09:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AFE81723;
        Thu,  6 Jul 2023 16:09:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0902614AE;
        Thu,  6 Jul 2023 23:09:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38C2BC433C8;
        Thu,  6 Jul 2023 23:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688684987;
        bh=Uuv++2ma5NDjs+bcuMRFWEcW6o+iWpjfQ5AjXPN6aes=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=VGPecl0dUu+eoBIkAvremADAHGcRgX1U5KN8szvk7xy2YHMQCoWkNwv+d7wW3VaiW
         tG0oe0J04JDQ1yp/7Q/mMbGixqjLjjvCuzYDpf919EnJ3MwravembIGl0Rw2o6r1dy
         dG7B4Xu2BIpQi4UqrmSwBHZg9a0WytEcVRfYWcm//uqLb08IsEIqrLaVnRqQqs2O9v
         siWdJl8Gu2UIl3WigKm/leMlKcxwbM6VR2zlkvfUUwN0fKMfnV6fCaxvCViZv9NehO
         3CauD4mb2A8RNn5FKbpa1iVhJQSvZOju9vcAyjB3Mmpu/VXqIDzmJ2ugQO1D+pvL+X
         CTrMmlysZjmOw==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-558a79941c6so891584eaf.3;
        Thu, 06 Jul 2023 16:09:47 -0700 (PDT)
X-Gm-Message-State: ABy/qLYS2NaRU7dwszkKfXoAKqhdprLR1ANGYfX/I7H0AJXzhKF0AgSh
        6Mkp+q82KM1mLAO55E+RlMyBZfuw7lTROXRtTyM=
X-Google-Smtp-Source: APBJJlECo6Iml4AOjDS5ZRWCl6DBjqmG2Xldifp3HJdosuJzXEvUQv9g5GMMZlzAAN77NstB/lbwfuh0C7xdo2unch0=
X-Received: by 2002:a4a:3748:0:b0:563:69ba:5919 with SMTP id
 r69-20020a4a3748000000b0056369ba5919mr2457082oor.4.1688684986300; Thu, 06 Jul
 2023 16:09:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:5e07:0:b0:4e8:f6ff:2aab with HTTP; Thu, 6 Jul 2023
 16:09:45 -0700 (PDT)
In-Reply-To: <4cec63dcd3c0443c928800ffeec9118c@hihonor.com>
References: <4cec63dcd3c0443c928800ffeec9118c@hihonor.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Fri, 7 Jul 2023 08:09:45 +0900
X-Gmail-Original-Message-ID: <CAKYAXd89OqqqSPNBZjggexWCrnBD6V7rWE547iKejmeihHFAiw@mail.gmail.com>
Message-ID: <CAKYAXd89OqqqSPNBZjggexWCrnBD6V7rWE547iKejmeihHFAiw@mail.gmail.com>
Subject: Re: [PATCH] exfat: use kvmalloc_array/kvfree instead of kmalloc_array/kfree
To:     gaoming <gaoming20@hihonor.com>
Cc:     Sungjong Seo <sj1557.seo@samsung.com>,
        "open list:EXFAT FILE SYSTEM" <linux-fsdevel@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        fengbaopeng <fengbaopeng@hihonor.com>,
        gaoxu <gaoxu2@hihonor.com>,
        wangfei 00014658 <wangfei66@hihonor.com>,
        shenchen 00013118 <harry.shen@hihonor.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2023-07-05 18:15 GMT+09:00, gaoming <gaoming20@hihonor.com>:
> The call stack shown below is a scenario in the Linux 4.19 kernel.
> Allocating memory failed where exfat fs use kmalloc_array due
> to system memory fragmentation, while the u-disk was inserted
> without recognition.
> Devices such as u-disk using the exfat file system are pluggable and may be
> insert into the system at any time.
> However, long-term running systems cannot guarantee the continuity of
> physical memory. Therefore, it's necessary to address this issue.
>
> Binder:2632_6: page allocation failure: order:4,
> mode:0x6040c0(GFP_KERNEL|__GFP_COMP), nodemask=(null)
> Call trace:
> [242178.097582]  dump_backtrace+0x0/0x4
> [242178.097589]  dump_stack+0xf4/0x134
> [242178.097598]  warn_alloc+0xd8/0x144
> [242178.097603]  __alloc_pages_nodemask+0x1364/0x1384
> [242178.097608]  kmalloc_order+0x2c/0x510
> [242178.097612]  kmalloc_order_trace+0x40/0x16c
> [242178.097618]  __kmalloc+0x360/0x408
> [242178.097624]  load_alloc_bitmap+0x160/0x284
> [242178.097628]  exfat_fill_super+0xa3c/0xe7c
> [242178.097635]  mount_bdev+0x2e8/0x3a0
> [242178.097638]  exfat_fs_mount+0x40/0x50
> [242178.097643]  mount_fs+0x138/0x2e8
> [242178.097649]  vfs_kern_mount+0x90/0x270
> [242178.097655]  do_mount+0x798/0x173c
> [242178.097659]  ksys_mount+0x114/0x1ac
> [242178.097665]  __arm64_sys_mount+0x24/0x34
> [242178.097671]  el0_svc_common+0xb8/0x1b8
> [242178.097676]  el0_svc_handler+0x74/0x90
> [242178.097681]  el0_svc+0x8/0x340
>
> By analyzing the exfat code,we found that continuous physical memory is
> not required here,so kvmalloc_array is used can solve this problem.
>
> Signed-off-by: gaoming <gaoming20@hihonor.com>
> ---
>  fs/exfat/balloc.c | 4 ++--
>  fs/exfat/dir.c    | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/fs/exfat/balloc.c b/fs/exfat/balloc.c
> index 9f42f25fab92..a183558cb7a0 100644
> --- a/fs/exfat/balloc.c
> +++ b/fs/exfat/balloc.c
> @@ -69,7 +69,7 @@ static int exfat_allocate_bitmap(struct super_block *sb,
>  	}
>  	sbi->map_sectors = ((need_map_size - 1) >>
>  			(sb->s_blocksize_bits)) + 1;
> -	sbi->vol_amap = kmalloc_array(sbi->map_sectors,
> +	sbi->vol_amap = kvmalloc_array(sbi->map_sectors,
>  				sizeof(struct buffer_head *), GFP_KERNEL);
>  	if (!sbi->vol_amap)
>  		return -ENOMEM;
> @@ -84,7 +84,7 @@ static int exfat_allocate_bitmap(struct super_block *sb,
>  			while (j < i)
>  				brelse(sbi->vol_amap[j++]);
>
> -			kfree(sbi->vol_amap);
> +			kvfree(sbi->vol_amap);
>  			sbi->vol_amap = NULL;
>  			return -EIO;
>  		}
> diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
> index 957574180a5e..5cbb78d0a2a2 100644
> --- a/fs/exfat/dir.c
> +++ b/fs/exfat/dir.c
> @@ -649,7 +649,7 @@ int exfat_put_dentry_set(struct exfat_entry_set_cache
> *es, int sync)
>  			brelse(es->bh[i]);
>
>  	if (IS_DYNAMIC_ES(es))
> -		kfree(es->bh);
> +		kvfree(es->bh);
>
>  	return err;
>  }
> @@ -888,7 +888,7 @@ int exfat_get_dentry_set(struct exfat_entry_set_cache
> *es,
>
>  	num_bh = EXFAT_B_TO_BLK_ROUND_UP(off + num_entries * DENTRY_SIZE, sb);
>  	if (num_bh > ARRAY_SIZE(es->__bh)) {
> -		es->bh = kmalloc_array(num_bh, sizeof(*es->bh), GFP_KERNEL);
> +		es->bh = kvmalloc_array(num_bh, sizeof(*es->bh), GFP_KERNEL);
Could you please elaborate why you change this to kvmalloc_array also?

Thanks.
>  		if (!es->bh) {
>  			brelse(bh);
>  			return -ENOMEM;
> --
> 2.17.1
>
>
