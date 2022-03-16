Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20DEA4DB22B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Mar 2022 15:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349811AbiCPOJx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Mar 2022 10:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351602AbiCPOJu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Mar 2022 10:09:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9856A4AE34;
        Wed, 16 Mar 2022 07:08:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 371A0611FB;
        Wed, 16 Mar 2022 14:08:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A16A7C340EC;
        Wed, 16 Mar 2022 14:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647439714;
        bh=teDzTOpQ2S8PwAjV8lyFv22pc1q/GxS3mxG8k7glWZA=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=p1WyPXvWw23Re9lL+sgBWu+567oqW71a7PxEV1AW3ytchmDo9HtNDMVo840Ig0WrK
         a7rFyxlfaBkOtj8HHguNxAqwzmo4gJQ6ZooLcQtvIut/E0EizBv9ec3zBm7LG/U5lz
         YGuHK750in9EuoK3WC56ygGCkT7H7GpEvQT26x3I88k2eDZC/XUcEEoQQkN4kpv2r+
         wVcfgK+vQ1vhA/zKAlsuEcGFeOl1A7O4o1kzzRFf+g4Y1JbEjBjltnrZhrWmCnOAHt
         eVnvNdLN41Ux/lUrkLxZdhkXOFpB+nLIYBbE0pzbtXQwBLZpCotK8a1DqqrfqSNbVl
         iGLdAuzxhshgw==
Received: by mail-wm1-f46.google.com with SMTP id v2-20020a7bcb42000000b0037b9d960079so3322910wmj.0;
        Wed, 16 Mar 2022 07:08:34 -0700 (PDT)
X-Gm-Message-State: AOAM532dJyxwVCq8wqTGPsT/VATfXW1w/nLCK4104a0cOTCsI62/S53C
        l+rDFTraEDqMr8zfqO+IwlT3EQvFPF+6sSbAB9c=
X-Google-Smtp-Source: ABdhPJw8Gqt+UcPld8IOovAXLE2a7Pc7Lbqw5tSjNXr+parD+j4iL2OGZjhAoMESwMCb7iKaGP4Qnj8X6k/jFl/TpV0=
X-Received: by 2002:a7b:c8c5:0:b0:389:d4f1:7cb with SMTP id
 f5-20020a7bc8c5000000b00389d4f107cbmr2791355wml.3.1647439712978; Wed, 16 Mar
 2022 07:08:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6000:1d93:0:0:0:0 with HTTP; Wed, 16 Mar 2022 07:08:32
 -0700 (PDT)
In-Reply-To: <20220316145728.709d85e0@suse.de>
References: <20220311114746.7643-1-vkarasulli@suse.de> <20220311114746.7643-2-vkarasulli@suse.de>
 <CAKYAXd9kdYi4rXmyfAO3ZbmKLu3i35QzsL_oOorROYieQnWGRg@mail.gmail.com>
 <YjGr3IpZ4p55YuAB@vasant-suse> <20220316145728.709d85e0@suse.de>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Wed, 16 Mar 2022 23:08:32 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-EhGuywjtH8T4aFRJ6sP4nGvS=5O2u+EULLV+8s=0T4A@mail.gmail.com>
Message-ID: <CAKYAXd-EhGuywjtH8T4aFRJ6sP4nGvS=5O2u+EULLV+8s=0T4A@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] exfat: add keep_last_dots mount option
To:     David Disseldorp <ddiss@suse.de>
Cc:     Vasant Karasulli <vkarasulli@suse.de>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.de>,
        Kohada.Tetsuhiro@dc.mitsubishielectric.co.jp
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2022-03-16 22:57 GMT+09:00, David Disseldorp <ddiss@suse.de>:
> On Wed, 16 Mar 2022 10:20:28 +0100, Vasant Karasulli wrote:
>
>> On So 13-03-22 09:01:32, Namjae Jeon wrote:
>> > 2022-03-11 20:47 GMT+09:00, Vasant Karasulli <vkarasulli@suse.de>:
>> > > The "keep_last_dots" mount option will, in a
>> > > subsequent commit, control whether or not trailing periods '.' are
>> > > stripped
>> > > from path components during file lookup or file creation.
>> > I don't know why the 1/2 patch should be split from the 2/2 patch.
>> > Wouldn't it be better to combine them? Otherwise it looks good to me.
>>
>> I just followed the same patch structure as was in the initial version
>> of the patch.
>
> I'm fine with having both patches squashed together. @Namjae: should we
> resubmit as a single patch or can you do the squash on your side before
> submitting to Linus?
I would be grateful if you resubmit it to the list after making it one:)

Thanks!
>
> Cheers, David
>
