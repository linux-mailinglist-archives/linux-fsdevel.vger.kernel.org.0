Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9363D73DF64
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 14:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjFZMhk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 08:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbjFZMhh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 08:37:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470A4E71
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 05:37:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6F8960D27
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 12:37:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37023C433CA
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 12:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687783050;
        bh=1HgdAcBid0/XGt9gisFnnU2Ur+CMAjUAkWCceo9bhb4=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=QMVLmkjs9DTY5+3uw8uO6g0cuuJ3pMOQtPTDKyJtvKPAjYOoes99VIcyHWInSAZFs
         7HrwRZNilOvJpLKQTacKJVmUee0TyLsf2cglGYE6dUuC4cbwqcSWwIzsSk31PMzxcj
         ZTqCtkFfIWk6yT3IWnYzkjqCUXgS/DSjjj0ejDeLpZOF8MnrO2ZwZaMPsJsEWUb6SQ
         NkxMzlqpt7Hl0IZ+it3XAydAhdiPRqVPt3NUvJHVet9NYyGyZKqEzvNK9/kmP+gND1
         f60NgfnSam9HN0KjbgsDWTgh1/1X4Rn+811D1lNkuTbMV0VmTf6LeFzrdnBrwd4J/C
         G5PylH8gDjP4A==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5607cdb0959so1337074eaf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 05:37:30 -0700 (PDT)
X-Gm-Message-State: AC+VfDyOY1HMUfdQaNKrBsJcxLGHUJkc+OaL3P6up671XX+LJXUHHcAd
        +y3FI7OsJuigfwhKTfB366taU2hpWbuN48/0eJE=
X-Google-Smtp-Source: ACHHUZ5yI0ZuDqSH1xgQ/66xXcecCKOegyRgBbs4gCemqt1A1hCUOdyZUt50Auar3RsWT/nFjXTDzgHgobAyZjLhST0=
X-Received: by 2002:a4a:dc45:0:b0:560:c32a:8e10 with SMTP id
 q5-20020a4adc45000000b00560c32a8e10mr8909975oov.0.1687783049313; Mon, 26 Jun
 2023 05:37:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:11c3:0:b0:4e8:f6ff:2aab with HTTP; Mon, 26 Jun 2023
 05:37:28 -0700 (PDT)
In-Reply-To: <PUZPR04MB63164CC193BB2EA5270F810E8126A@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <PUZPR04MB6316DB8A8CB6107D56716EBC815BA@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <CAKYAXd9ubktMNDdXPBDjRyUeGARMjMR5Hq+vwwCUbhwUmNURtQ@mail.gmail.com>
 <PUZPR04MB631602DE8C97F0D3DAA036F08121A@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <PUZPR04MB63164CC193BB2EA5270F810E8126A@PUZPR04MB6316.apcprd04.prod.outlook.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Mon, 26 Jun 2023 21:37:28 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-aXYh1qzjMb0uhMxpHdA+VuyjruFTFDiuR_88eiPQP5g@mail.gmail.com>
Message-ID: <CAKYAXd-aXYh1qzjMb0uhMxpHdA+VuyjruFTFDiuR_88eiPQP5g@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] exfat: get file size from DataLength
To:     "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc:     "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
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

2023-06-26 17:45 GMT+09:00, Yuezhang.Mo@sony.com <Yuezhang.Mo@sony.com>:
>> From: Mo, Yuezhang
>> Sent: Sunday, June 25, 2023 2:29 PM
>> > From: Namjae Jeon <linkinjeon@kernel.org>
>> > First, Thank you so much for your work.
>> > Have you ever run xfstests against exfat included this changes ?
>>
>> Yes, all generic/??? tests of xfstests pass, except generic/251.
>> Are there any tests that fail in your environment?
>
> I run xfstests iteratively and found generic/465 will sometimes fail, the
> probability of failure is 1/20.
> I will investigate it and update these patches.
Okay.
>
> PS: generic/251 also fails without these patches, the reason is `cp -a`
> fails.
I will check it.

Thanks!
>
