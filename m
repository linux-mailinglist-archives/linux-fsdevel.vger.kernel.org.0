Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7012757096
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jul 2023 01:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbjGQXhF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jul 2023 19:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbjGQXg6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jul 2023 19:36:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573491720
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Jul 2023 16:36:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68DA36134B
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Jul 2023 23:35:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE6E2C433C8
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Jul 2023 23:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689636927;
        bh=Pq89fuR9FnEcDV2rh0fo+UXicLkFFMfRYlcfYwTWEgk=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=pGohk/L9kBE3+Yv3eQUo/5yuCeSiatxg2BuRL3l2336M4U1wvSKShaigJYw8QRflt
         GaLeTLfGBaReOkCOj7hcD3PQCpgaBfU+lBclcAZt9ipuVrT5gOTLkbkTjJV6h3xZwj
         yTOLfU6k8u9qDMoaJyZIdl0g6wWbKrTnxADXGbOsTK890qyEmJSoG+nnPlK/r5qTha
         UdZypmVxQFiZnsqCjC53JFbSPQyMnwulQuORPV4y8C90RmsE9LFYsVoaUi5IiRZpMR
         8prLsZAxdaDxuQuUCGbheu6KMtAPW65En88TLcwWnaM/azzNP5ojN2vT+zL6n2+6iW
         QEzvxYVwUxhUQ==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-56598263d1dso3278156eaf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Jul 2023 16:35:27 -0700 (PDT)
X-Gm-Message-State: ABy/qLZyDwKH9VNqaJig1qc5teFbqLIpHObxemyX8xLU1JB8eLLWW5gG
        RG7Wnouw8tJlBaCrbiMXECZjVx6HoFdyjmVramg=
X-Google-Smtp-Source: APBJJlHyGzE6PJ2RroWVsx5Wi3+hd7FmATiLy4RXxnoMmm7BtmeRo/KjlzJaxazYTFmUyfAsqQpb9xrjIOtjyMLz6NA=
X-Received: by 2002:a4a:9194:0:b0:566:97a9:b73b with SMTP id
 d20-20020a4a9194000000b0056697a9b73bmr5581925ooh.2.1689636926991; Mon, 17 Jul
 2023 16:35:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:53c4:0:b0:4e8:f6ff:2aab with HTTP; Mon, 17 Jul 2023
 16:35:26 -0700 (PDT)
In-Reply-To: <PUZPR04MB6316739EDE3554E9EE25AE10813BA@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <20230713130310.8445-1-linkinjeon@kernel.org> <PUZPR04MB6316739EDE3554E9EE25AE10813BA@PUZPR04MB6316.apcprd04.prod.outlook.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Tue, 18 Jul 2023 08:35:26 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-Qd5vSYXXPppck3thk5kgQT7qtTxeG-+RVXZMn1u6BDA@mail.gmail.com>
Message-ID: <CAKYAXd-Qd5vSYXXPppck3thk5kgQT7qtTxeG-+RVXZMn1u6BDA@mail.gmail.com>
Subject: Re: [PATCH] exfat: check if filename entries exceeds max filename length
To:     "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Maxim Suhanov <dfirblog@gmail.com>,
        Sungjong Seo <sj1557.seo@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2023-07-17 13:43 GMT+09:00, Yuezhang.Mo@sony.com <Yuezhang.Mo@sony.com>:
>
>> From: Namjae Jeon <linkinjeon@kernel.org>
>> Sent: Thursday, July 13, 2023 9:03 PM
>> exfat_extract_uni_name copies characters from a given file name entry
>> into
>> the 'uniname' variable. This variable is actually defined on the stack of
>> the
>> exfat_readdir() function. According to the definition of the
>> 'exfat_uni_name'
>> type, the file name should be limited 255 characters (+ null teminator
>> space),
>> but the exfat_get_uniname_from_ext_entry()
>> function can write more characters because there is no check if filename
>> entries exceeds max filename length. This patch add the check not to copy
>> filename characters when exceeding max filename length.
>
> This case is not compliant with the exFAT file system specification, I think
> it is
> better to return an error and let the user fix it with fsck.
> The current fix may result in multiple files with the same name in a
> directory.
>
> Such as, there are files $(filename255) and files $(filename255)1,
> $(filename255)2...
> in a directory, but they will all be found as $(filename255).
We were considering between handling it as an error and like this patch.
In windows, such files is visible and can be accessed without any
error like this patch.
And please don't assume that fsck can be run in all cases. In some
products and scenarios, fsck cannot be executed and should not be
expected. I can add an error print to make the user run fsck.
>
>
>
