Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D22A6A5774
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Feb 2023 12:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjB1LFy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Feb 2023 06:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjB1LFx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Feb 2023 06:05:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8E72A17F
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Feb 2023 03:05:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A639C61033
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Feb 2023 11:05:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D07EC4339B
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Feb 2023 11:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677582352;
        bh=bPEVSRwdHZbo+GAxPEKB5AjrjzvHFI+v9sfoBFCRsH4=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=G8MaotF/NUMR0rHRTV/p8xwdg5lZ7nnKEor4HFbO3oEPdRziriB5lfH80SIeId/De
         KjfYnOagypvHdO27K/Ph4H7Ei1upRZ4by8HJW2GdoGsiEIh/FWUb/lNjTeQXYIJSws
         +dHGOHqMGqR7MYbjfbbn40Z0+UllcEKtRzLdNv1Gk/VcEa1UzVsa533ivcypEMLmpl
         u8rhisCqQDkfI6pvdB0LGXoWuLjjY7a9atZOx7q/9TwxMaaSXTisQYDOThnR/N4ra9
         sv5bsAjFrriEMoBdkrdQOzi1FyF7Njgl1SPVyTDD3KQJrko0SyGq2bSGl5z/k6Rf6D
         KqZhwiW1NNwAQ==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-172334d5c8aso10468342fac.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Feb 2023 03:05:52 -0800 (PST)
X-Gm-Message-State: AO0yUKUErnDbTA1bJJXjzm+K2BstrzYbm3vJn8tjbOPavaMWbVtLu2OD
        ijiwSLsd8SF7mFob3J3TL5wnUYWJRAvednnnA/w=
X-Google-Smtp-Source: AK7set/3xNNXCYbKpRkQikEyaZocXH6k6Z00G4qxGs9yXXwkAm8E7BybBHG0KOXFFoIHgzz34pZk/UfCi1IAtXHjNNA=
X-Received: by 2002:a05:6871:6ab0:b0:172:2b6d:e85f with SMTP id
 zf48-20020a0568716ab000b001722b6de85fmr594294oab.11.1677582351154; Tue, 28
 Feb 2023 03:05:51 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac9:67ca:0:b0:4c2:5d59:8c51 with HTTP; Tue, 28 Feb 2023
 03:05:50 -0800 (PST)
In-Reply-To: <PUZPR04MB6316DF13B8E9FC79FD477A6C81AC9@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <PUZPR04MB6316DF13B8E9FC79FD477A6C81AC9@PUZPR04MB6316.apcprd04.prod.outlook.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Tue, 28 Feb 2023 20:05:50 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8T=hwywG115eF3i+RyNWrR9tLkcLpVmaSci76Fv_cCUA@mail.gmail.com>
Message-ID: <CAKYAXd8T=hwywG115eF3i+RyNWrR9tLkcLpVmaSci76Fv_cCUA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] exfat: fix and refine exfat_alloc_cluster()
To:     "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc:     "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2023-02-28 15:07 GMT+09:00, Yuezhang.Mo@sony.com <Yuezhang.Mo@sony.com>:
> Changes for v2:
>   [2/3] do not return error if hint_cluster invalid
>
> Yuezhang Mo (3):
>   exfat: remove unneeded code from exfat_alloc_cluster()
>   exfat: don't print error log in normal case
>   exfat: fix the newly allocated clusters are not freed in error
>     handling
Applied, Thanks for your patches!
