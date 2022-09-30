Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0095F0751
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Sep 2022 11:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbiI3JOF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Sep 2022 05:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbiI3JOF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Sep 2022 05:14:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4012A14DAE1;
        Fri, 30 Sep 2022 02:14:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 44AAFB8278D;
        Fri, 30 Sep 2022 09:14:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEDA0C433D6;
        Fri, 30 Sep 2022 09:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664529240;
        bh=EhvThdAZv+g3hFSvq1K07sI3MuQ2B98FQivMykcx0uU=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=Q5vu8K/ZX4RIWf8MT6G5WXQT1eNPIRUELlUXCfTDkxDOWzVJ+aRCMxgHVN6siRUti
         ly8OPgp1n5qSzuwylMgt0DHPt6rhA+SRuwC7i//iywghxSsFFMH2CqDTIPBdNYxqOf
         GyTZhBbZb3cAFEIGLrNpTTrMdpL3T//5h67rfS7YeMQAFcatYQidvLGnyGdkfZiEFc
         FYNMU5EawPKbtkTcW1jr/XXqri3b+W9YNlY20Ycz/QoxCBni/jAVhZLtdD5NBBKlK3
         FBLothlu+rqKcn7HmT0Moe8djbtiUOc8GVqRFQX61VjmmGTmeNFIXze30dtxmIFNRG
         gvK6/JPepDefQ==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-127dca21a7dso4738201fac.12;
        Fri, 30 Sep 2022 02:14:00 -0700 (PDT)
X-Gm-Message-State: ACrzQf3YduIan6tcYjXo4KOjEzWgEE/FcZJxfL50O060qZ+La5VyFgad
        J6lKd2wpRLJT9I0Unji2kbMtMG28XSwXfc6mOTI=
X-Google-Smtp-Source: AMsMyM5PPhY8MrhOEKmeaOx8gPYekttQlObgQeIPMll8Wf7oIdz4KcbxSc9cGg/PhrCbeXqaFhL+1PgW3iHSCWDE890=
X-Received: by 2002:a05:6870:648f:b0:131:d95c:4ada with SMTP id
 cz15-20020a056870648f00b00131d95c4adamr3572965oab.8.1664529240061; Fri, 30
 Sep 2022 02:14:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6838:27c7:0:0:0:0 with HTTP; Fri, 30 Sep 2022 02:13:59
 -0700 (PDT)
In-Reply-To: <1ec3ff28-04e7-1b31-5cb0-fd0fde8f582c@redhat.com>
References: <CGME20220608020502epcas1p14911cac6731ee98fcb9c64282455caf7@epcas1p1.samsung.com>
 <20220608020408.2351676-1-sj1557.seo@samsung.com> <1ec3ff28-04e7-1b31-5cb0-fd0fde8f582c@redhat.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Fri, 30 Sep 2022 18:13:59 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8peY3zNz8QyVp=8s2B5EqhBxkOwYA4ZHWAZqs7xFt3cw@mail.gmail.com>
Message-ID: <CAKYAXd8peY3zNz8QyVp=8s2B5EqhBxkOwYA4ZHWAZqs7xFt3cw@mail.gmail.com>
Subject: Re: [PATCH] exfat: use updated exfat_chain directly during renaming
To:     Pavel Reichl <preichl@redhat.com>
Cc:     Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2022-09-30 18:00 GMT+09:00, Pavel Reichl <preichl@redhat.com>:
>
> On 6/8/22 04:04, Sungjong Seo wrote:
>>
>> Fixes: d8dad2588add ("exfat: fix referencing wrong parent directory
>> information after renaming")
>
> Hello,
>
> I just wonder, since the fixed patch had tag: 'Cc: stable@vger.kernel.org'
> should this, fixing patch, go to stable as well?
It was well applied into stable kernels although stable tag was missing.
>
> Thanks!
>
>
