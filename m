Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208CF65940A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Dec 2022 02:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234101AbiL3Bc5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Dec 2022 20:32:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiL3Bc4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Dec 2022 20:32:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF37DE9A;
        Thu, 29 Dec 2022 17:32:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C405B81A97;
        Fri, 30 Dec 2022 01:32:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB074C433F0;
        Fri, 30 Dec 2022 01:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672363973;
        bh=VOn8eoQiO6gbJRcKeLobts+OA5WiHLhdUl1hzpTzSXA=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=OFaCVO/BM/EYs/d+Qy170u7JNHZdmFbKFlg5mOl0+RiwGzW7KjdjC51N6kaVTkmaI
         Y8cSOVyvbc+GtJp2ZDnQdyBOF6bXrGAZ9G+2p/C1iDtMBoFa8U+xer7H1niNJLkSUp
         0PsRj/9miK+8HLiL96LO9SoLKTM4wqwnknk6lu78dpT2yC2MFkUjHpBUdz5/MJJ+TS
         aYzAcaWBLfmTdtC9lTdCZVstkPBG2lvC4O2nMCofXldKEoFD19500yvoakyYu6zFhr
         tx5jN6JBpJf1q27QZ7MCbEplu4KEVM4u3BwOz7bkKNjZh/n8RgNd8W7vhICWFTTExs
         zkZE/w+pN7UKQ==
Received: by mail-ot1-f49.google.com with SMTP id v15-20020a9d69cf000000b006709b5a534aso12397143oto.11;
        Thu, 29 Dec 2022 17:32:52 -0800 (PST)
X-Gm-Message-State: AFqh2kqtm55EPjAVPIbZuu0yiv6lQVueWmpW7hHsAfhPEG9WqMbMd+NA
        1mTYORJWXSW556IbpY/emO8dDAElHztLoZNbW28=
X-Google-Smtp-Source: AMrXdXuK4Ngu01866bHJcOyjxtXHMrYb38E8rUXPrH/z6wJm8bAfLLsS7JrqN2fTmENw9DuBKOPnsDdwlrsdzflfO3I=
X-Received: by 2002:a05:6830:12c6:b0:663:c86f:7573 with SMTP id
 a6-20020a05683012c600b00663c86f7573mr2099798otq.187.1672363971988; Thu, 29
 Dec 2022 17:32:51 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6838:2d06:0:0:0:0 with HTTP; Thu, 29 Dec 2022 17:32:51
 -0800 (PST)
In-Reply-To: <PUZPR04MB6316579893496BC54C4FE96F81EC9@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <PUZPR04MB6316579893496BC54C4FE96F81EC9@PUZPR04MB6316.apcprd04.prod.outlook.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Fri, 30 Dec 2022 10:32:51 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-dTvQSCwMu2qHpb0VEqmQStekb6iFgzgYqi0i_7Bq7_w@mail.gmail.com>
Message-ID: <CAKYAXd-dTvQSCwMu2qHpb0VEqmQStekb6iFgzgYqi0i_7Bq7_w@mail.gmail.com>
Subject: Re: [PATCH v1] exfat: fix reporting fs error when reading dir beyond EOF
To:     "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc:     "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2022-12-26 16:23 GMT+09:00, Yuezhang.Mo@sony.com <Yuezhang.Mo@sony.com>:
> Since seekdir() does not check whether the position is valid, the
> position may exceed the size of the directory. We found that for
> a directory with discontinuous clusters, if the position exceeds
> the size of the directory and the excess size is greater than or
> equal to the cluster size, exfat_readdir() will return -EIO,
> causing a file system error and making the file system unavailable.
>
> Reproduce this bug by:
>
> seekdir(dir, dir_size + cluster_size);
> dirent = readdir(dir);
>
> The following log will be printed if mount with 'errors=remount-ro'.
>
> [11166.712896] exFAT-fs (sdb1): error, invalid access to FAT (entry
> 0xffffffff)
> [11166.712905] exFAT-fs (sdb1): Filesystem has been set read-only
>
> Fixes: 1e5654de0f51 ("exfat: handle wrong stream entry size in
> exfat_readdir()")
>
> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
> Reviewed-by: Andy Wu <Andy.Wu@sony.com>
> Reviewed-by: Aoyama Wataru <wataru.aoyama@sony.com>
Applied, Thanks for your patch!
