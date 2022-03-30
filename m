Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F904EBA9A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Mar 2022 08:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiC3GLO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Mar 2022 02:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243179AbiC3GLK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Mar 2022 02:11:10 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28FF02AC5D
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 23:09:22 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id z12so20196775lfu.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 23:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pT4t7FiXDpWEJ+Gdcq9jt19cTP349yR9JVwGjR03zUk=;
        b=BEuTLZKeQP6zu3UJzSFP7JaR2YwCnRUrlJkQv4WtpxMCRumMmrfBnrFjl/HB01zmNV
         ZNzoks2Vuw2ELa4dCEgIM1XblYrH7/XoF7IiRGR7U+RHP6QUiZKMtRF4TvGIHB+ibVBm
         fuYfCI2pn1BpPo4Fadjzf9jWh6DrCFMQFbGXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pT4t7FiXDpWEJ+Gdcq9jt19cTP349yR9JVwGjR03zUk=;
        b=DTQVRaKSO30WRYP/D3LwsLsuPUohwYLH7KAyyKdmWa5n8NRSvyGo2i5/3oqYW0fpTK
         lOzVCD/kUQgpmiGhsds8p1psZKAW8MuhmWubmFBpCS/OHbXVakvwvwL+XqakuF3fNo71
         3znS6/Cwyh5baEaOK8rn1pTpUjDUB6ljx7UjqUu4MBnl8345rnE5BurSpr4Ue7qjTtnj
         zDMBqg4Kf2Qwses9KaEJs4Y61Dq2Eb2p+12qgWaarM1PSUpZ6ruc7+lmfelUloxhE9/q
         6yNGJTnQSrk5B2B0+skaz4OhIMLkxZUitqhOBgM397GxgOTxpKNS20rTfHEqNTfVWrK2
         S3OQ==
X-Gm-Message-State: AOAM531R1g1A8SHpwVsJJvMo+bjSRlzzn2oDmXJDjamSEUQuPxspapV0
        /Z4SHD2f3pJttbAG7JiQlIu9Ptbb5GeSsFvy
X-Google-Smtp-Source: ABdhPJy54IKf1iac4QbchcCbI+2T1R+P9HfWT4eHQpL0jz8z0Xtn3DJ0nqwcY2+ION+oNhHSnOqP/g==
X-Received: by 2002:a19:6709:0:b0:448:3162:d843 with SMTP id b9-20020a196709000000b004483162d843mr5602294lfc.95.1648620557128;
        Tue, 29 Mar 2022 23:09:17 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id g11-20020ac24d8b000000b0044a3454c858sm2224618lfe.81.2022.03.29.23.09.12
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 23:09:13 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id t25so33973820lfg.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 23:09:12 -0700 (PDT)
X-Received: by 2002:a05:6512:3055:b0:44a:3914:6603 with SMTP id
 b21-20020a056512305500b0044a39146603mr5600655lfb.435.1648620551380; Tue, 29
 Mar 2022 23:09:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220326114009.1690-1-aissur0002@gmail.com> <2698031.BEx9A2HvPv@fedor-zhuzhzhalka67>
 <CAHk-=wh2Ao+OgnWSxHsJodXiLwtaUndXSkuhh9yKnA3iXyBLEA@mail.gmail.com>
 <4705670.GXAFRqVoOG@fedor-zhuzhzhalka67> <CAHk-=wiKhn+VsvK8CiNbC27+f+GsPWvxMVbf7QET+7PQVPadwA@mail.gmail.com>
 <CAHk-=wjRwwUywAa9TzQUxhqNrQzZJQZvwn1JSET3h=U+3xi8Pg@mail.gmail.com> <YkPo0N/CVHFDlB6v@zx2c4.com>
In-Reply-To: <YkPo0N/CVHFDlB6v@zx2c4.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 29 Mar 2022 23:08:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgPwyQTnSF2s7WSb+KnGn4FTM58NJ+-v-561W7xnDk2OA@mail.gmail.com>
Message-ID: <CAHk-=wgPwyQTnSF2s7WSb+KnGn4FTM58NJ+-v-561W7xnDk2OA@mail.gmail.com>
Subject: Re: [PATCH 4/4] file: Fix file descriptor leak in copy_fd_bitmaps()
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Fedor Pchelkin <aissur0002@gmail.com>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Eric Biggers <ebiggers@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 29, 2022 at 10:21 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Peppering some printks, it looks like in `max_fds = ALIGN(max_fds,
> BITS_PER_LONG);`, max_fds is sometimes 4294967295 before the call, and
> that ALIGN winds up bringing it to 0.

Gaah. I actually went back and forth on the location of the ALIGN().

And then ended up putting it where it is for just a "smallest patch"
reason, which was clearly not the right thing to do.

The easier and more obvious fix was to just make the ALIGN() be at the
final 'return' statement, but I ended up moving it up just because I
didn't like how complicated the expression looked.

That was obviously very very wrong of me.

So does it help if you just remove that

        max_fds = ALIGN(max_fds, BITS_PER_LONG);

and instead make the final return be

        return ALIGN(min(count, max_fds), BITS_PER_LONG);

instead?

And now I feel like I should as penance just do what I tried to get
Christian to do, which was to just integrate the whole "don't even
bother looking past that passed-in max_fds" in count_open_files().

The whole organization of that "calculate current highest fd, only to
then ignore it if we didn't want that many file descriptors" is just
historical baggage.

                 Linus
