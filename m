Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3CD64C87B8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 10:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbiCAJUd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Mar 2022 04:20:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiCAJUc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Mar 2022 04:20:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84DB80232;
        Tue,  1 Mar 2022 01:19:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5EDC0614FD;
        Tue,  1 Mar 2022 09:19:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCC8EC340F7;
        Tue,  1 Mar 2022 09:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646126390;
        bh=G2XBxItU6ulbbpz1WewN5XnT3mHZ/eKxD489Zbr6u2E=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=ZfKlgDtgVv0Jg2Bq8Pw1fbeQ81pbfOluvX6HLveYzzE9sDl9WlAppPk3qLIn+do8D
         wEAgoEVzA/jY12s0YPHjuib1MOO1k0ukWGKf2LVXjj1RQucivgQrXENXBhZrGgzExx
         9n6HPvEKn/cw4hGAHmTc4ZpbpK3fmkORedKWRthKfJAfmB7qfBMCr2NE+9evtO57EZ
         MtsRl137Q5hksRT+otGDoitiLfwjk5XK/lVKtA5dzHktAp2oB/FXhCA15ZeYtori1i
         G+y6oQIFB0q7KzYG9wk+FGK8xDdQ0Uq3DgYBRxFQPOjRup+61gctRxTZzCAVERt0uM
         IQTr/6mIh60Kg==
Received: by mail-wm1-f53.google.com with SMTP id o18-20020a05600c4fd200b003826701f847so273574wmq.4;
        Tue, 01 Mar 2022 01:19:50 -0800 (PST)
X-Gm-Message-State: AOAM5306vlUujlC3k0t/LcTlMIjwREr5G3B4O2O8Ts/Zka4CsGse6eBh
        nxNX/7iobivLXuR9NkoLdEeK9iwVmCR5SCear0A=
X-Google-Smtp-Source: ABdhPJxXWQCUG4JVzisvhb1gR+XL4D6XdN9f9Fc/vNgW1TjuZ8e7zB5F4zgaEBMjaFKHZXrv6G6BAqYg7PGeOcGCQ14=
X-Received: by 2002:a05:600c:3483:b0:380:edaf:d479 with SMTP id
 a3-20020a05600c348300b00380edafd479mr16098717wmq.20.1646126388969; Tue, 01
 Mar 2022 01:19:48 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a5d:4e02:0:0:0:0:0 with HTTP; Tue, 1 Mar 2022 01:19:48 -0800 (PST)
In-Reply-To: <HK2PR04MB3891A18281A56DD2D3492B9181019@HK2PR04MB3891.apcprd04.prod.outlook.com>
References: <HK2PR04MB38914869B1FEE326CFE11779812D9@HK2PR04MB3891.apcprd04.prod.outlook.com>
 <HK2PR04MB3891BFAB9DD271F5330D37A1812D9@HK2PR04MB3891.apcprd04.prod.outlook.com>
 <HK2PR04MB3891A18281A56DD2D3492B9181019@HK2PR04MB3891.apcprd04.prod.outlook.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Tue, 1 Mar 2022 18:19:48 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_RSqa_t6QLfqODdZVV+WtW6Ti3dgc3zq0SHJpoHPay=A@mail.gmail.com>
Message-ID: <CAKYAXd_RSqa_t6QLfqODdZVV+WtW6Ti3dgc3zq0SHJpoHPay=A@mail.gmail.com>
Subject: Re: [PATCH] exfat: do not clear VolumeDirty in writeback
To:     "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc:     "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2022-02-28 12:24 GMT+09:00, Yuezhang.Mo@sony.com <Yuezhang.Mo@sony.com>:
> Hi Namjae and Sungjong,
Hi Yuezhang,
>
> May I have your comments for this patch?
Sorry for late response. I will check it within this week:)
>
> Best Regards,
> Yuezhang,Mo
Thanks!
>
>
