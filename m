Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F3B4E8BB5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Mar 2022 03:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237345AbiC1BpZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Mar 2022 21:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234947AbiC1BpY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Mar 2022 21:45:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16F249FAF;
        Sun, 27 Mar 2022 18:43:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F1B9DB80DD4;
        Mon, 28 Mar 2022 01:43:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EBD8C340EC;
        Mon, 28 Mar 2022 01:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648431821;
        bh=7A18LrQnBuUKW4eG9uehKdgAef2TXiymAn97vaYYyic=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=RwJQFZtGH6IYV4yBdK9/XqHpSEzYp/le7BtiOpKc3vPrkUK9HeDttmo/4Y9JcEMQ5
         dxloLypelrGeHnpzkemfRKTsMcOdAS0RiJgtw4bvbhe3qDyhJA2Tm6pefQbQqppl9O
         Rg9gIconWvKH6OiCu1gzhBIixsAZXoJGZ/D+XJeQCWUV3xtxLKpLVpoGf90BGTdNdd
         IoPeU9PZ73IsZdje8BnM4rv7KpVITNwgT9DMiAdis0H6ikx9pC5hiVV6mXks4sOTlh
         43/yux82YofBDp0QlhvTeLwf7RRj26TgSlTFlBtJqhkbGAO8hzZHkgeHwLg63vCg4u
         1h5BjRnhpHIUQ==
Received: by mail-wr1-f42.google.com with SMTP id t11so18295668wrm.5;
        Sun, 27 Mar 2022 18:43:41 -0700 (PDT)
X-Gm-Message-State: AOAM53076yDSP6AEl6thQgaNWfpMCFVwEPg0xg7N+GDxQDpRM7fQyVTp
        AziQMW7DhbQ8PgcEDZBnA6ikdycF2VhIsn4r4gc=
X-Google-Smtp-Source: ABdhPJzJ3iRXdPbm8ua2lUtmz8nVVspNyR/f6MlQnEAoZIcRdAn/8tWte7Uydt/xG90+zGG/kqSEbolCVbzBTgRBSs4=
X-Received: by 2002:adf:908e:0:b0:1e7:bea7:3486 with SMTP id
 i14-20020adf908e000000b001e7bea73486mr19631349wri.401.1648431819935; Sun, 27
 Mar 2022 18:43:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6000:2c1:0:0:0:0 with HTTP; Sun, 27 Mar 2022 18:43:39
 -0700 (PDT)
In-Reply-To: <HK2PR04MB3891BE0766FAF0AEC39FE2DC811A9@HK2PR04MB3891.apcprd04.prod.outlook.com>
References: <HK2PR04MB3891BE0766FAF0AEC39FE2DC811A9@HK2PR04MB3891.apcprd04.prod.outlook.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Mon, 28 Mar 2022 10:43:39 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8Q7-1O9PQ693stmLjoG99KME__FSm0gPtvndi4xxoVcA@mail.gmail.com>
Message-ID: <CAKYAXd8Q7-1O9PQ693stmLjoG99KME__FSm0gPtvndi4xxoVcA@mail.gmail.com>
Subject: Re: [PATCH 1/2] exfat: fix referencing wrong parent directory
 information after renaming
To:     "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc:     "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>,
        "Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp" 
        <Kohada.Tetsuhiro@dc.mitsubishielectric.co.jp>
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

2022-03-25 18:42 GMT+09:00, Yuezhang.Mo@sony.com <Yuezhang.Mo@sony.com>:
Hi Yuezhang,

> During renaming, the parent directory information maybe
> updated. But the file/directory still references to the
> old parent directory information.
>
> This bug will cause 2 problems.
>
> (1) The renamed file can not be written.
>
>     [10768.175172] exFAT-fs (sda1): error, failed to bmap (inode : 7afd50e4
> iblock : 0, err : -5)
>     [10768.184285] exFAT-fs (sda1): Filesystem has been set read-only
>     ash: write error: Input/output error
Could you please elaborate how to reproduce it ?

Thanks.
>
> (2) Some dentries of the renamed file/directory are not set
>     to deleted after removing the file/directory.
>
> fixes: 5f2aa075070c ("exfat: add inode operations")
>
> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
> Reviewed-by: Andy Wu <Andy.Wu@sony.com>
> Reviewed-by: Aoyama Wataru <wataru.aoyama@sony.com>
> Reviewed-by: Daniel Palmer <daniel.palmer@sony.com>
> ---
>  fs/exfat/namei.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
> index a02a04a993bf..e7adb6bfd9d5 100644
> --- a/fs/exfat/namei.c
> +++ b/fs/exfat/namei.c
> @@ -1080,6 +1080,7 @@ static int exfat_rename_file(struct inode *inode,
> struct exfat_chain *p_dir,
>
>  		exfat_remove_entries(inode, p_dir, oldentry, 0,
>  			num_old_entries);
> +		ei->dir = *p_dir;
>  		ei->entry = newentry;
>  	} else {
>  		if (exfat_get_entry_type(epold) == TYPE_FILE) {
> --
> 2.25.1
>
