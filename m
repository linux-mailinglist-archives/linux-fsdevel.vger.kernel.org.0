Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7E75962DD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 21:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236933AbiHPTK0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 15:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236895AbiHPTKV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 15:10:21 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B615FF5B
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Aug 2022 12:10:20 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id w3so14738054edc.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Aug 2022 12:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=yzrVpPuDYTxXMkdItXzTsS/x0cvNzj9XD0M7B64fKkM=;
        b=hRVUjFvYmNjBenxN26rM1xLF3lI5JQT01UB04cU3e6k+/745Td4UiuUQ7TZ10C3voN
         siR7BMzwAUZsTJpxsypPp+ZGfQt91NHSg6/aSDd4A5Kd6mL7hB/2C5qiNVvp0kFEiqpZ
         Ts68OOg3tm882msV1Ffr4efqdWvIqV5y5DDDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=yzrVpPuDYTxXMkdItXzTsS/x0cvNzj9XD0M7B64fKkM=;
        b=1600vavm9slDiOmqFlTioDLSisa8mUKlkci7Goyi7OvpyWueXs9fyQTUwNEUdDIZQ0
         PsKBDCnorDn3vByHBkmKtD1x9doR79PZJpZKJOYjjJ5zfgIaw4WeaVUnC/x12GRforUP
         Nj3q4KQ6cKNyXQWFfgiGmMwVQhT32/0G222/KDC25OY7Ms+Vw4VCKMS64zeyGMywH6YC
         7LBpKAS46qyu9+rinVG7IRNpopJ0UL8TwwqkONvGHMg63+5dDMRV6oziD4m1khdYSwOo
         BXSBek5VgnN33sJpNjU1YVTO/Z2lAZsJ5UhBlF5yAmEZXOgQCrk9qRd3lhjOpGG+mZSu
         2Qxw==
X-Gm-Message-State: ACgBeo1dh0Dlix1/OM11vKF4osx5UUGWbftZQWgm/FoqPanV52gPmpIZ
        IFiL0TSLYJdldCfZmNGnOQNQ8KNe76Y6rcXo7JA=
X-Google-Smtp-Source: AA6agR5IGgRAsUX9RnM06YH0+JJ4ey8Whmo2jlmpZFtF7JTQlHl0RJWD456YsKIZNkMl5gmLr4gOIw==
X-Received: by 2002:aa7:d6da:0:b0:43f:99fb:f3aa with SMTP id x26-20020aa7d6da000000b0043f99fbf3aamr19410383edr.370.1660677018932;
        Tue, 16 Aug 2022 12:10:18 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id v17-20020aa7d811000000b0043d7ff1e3bcsm8986067edq.72.2022.08.16.12.10.16
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 12:10:17 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id n7so2527480wrv.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Aug 2022 12:10:16 -0700 (PDT)
X-Received: by 2002:a05:6000:1888:b0:222:ca41:dc26 with SMTP id
 a8-20020a056000188800b00222ca41dc26mr11814187wri.442.1660677016516; Tue, 16
 Aug 2022 12:10:16 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYv2Wof_Z4j8wGYapzngei_NjtnGUomb7y34h4VDjrQDBA@mail.gmail.com>
In-Reply-To: <CA+G9fYv2Wof_Z4j8wGYapzngei_NjtnGUomb7y34h4VDjrQDBA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 16 Aug 2022 12:10:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj=u9+0kitx6Z=efRDrGVu_OSUieenyK4ih=TFjZdyMYQ@mail.gmail.com>
Message-ID: <CAHk-=wj=u9+0kitx6Z=efRDrGVu_OSUieenyK4ih=TFjZdyMYQ@mail.gmail.com>
Subject: Re: [next] arm64: kernel BUG at fs/inode.c:622 - Internal error: Oops
 - BUG: 0 - pc : clear_inode
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, regressions@lists.linux.dev,
        lkft-triage@lists.linaro.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>
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

On Tue, Aug 16, 2022 at 12:00 PM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
>
> Following kernel BUG found while booting arm64 Qcom dragonboard 410c with
> Linux next-20220816 kernel Image.

What kind of environment is this?

Havign that inode list corruption makes it smell a *bit* like the
crazy memory corruption that we saw with the google cloud instances,
but that would only happen wif you actually use VIRTIO for your
environment?

Do you see the same issue with plain v6.0-rc1?

            Linus
