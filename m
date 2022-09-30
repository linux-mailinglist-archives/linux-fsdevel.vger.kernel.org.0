Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4825F0D1D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Sep 2022 16:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbiI3OKR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Sep 2022 10:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiI3OKN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Sep 2022 10:10:13 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9FB52E40
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Sep 2022 07:10:10 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 63so5415143ybq.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Sep 2022 07:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=DsDpak4hGP9eOQqikyTZRbcLuJcQ1VFkpeBTwP7Tglg=;
        b=cKTwlKQSMUY6uDctsm5SrLjchJI9rQzQhlcplGxLuO9/jzzixwYQ6iGA+x70gaLIyf
         D5rV2WTYTrGPXnuWnW4I2k34Lm4Sh9cCrV0ZhlbgpEyrtEzwOf6gjiv4Oi5/LL7xDplN
         3hWJPN6oxbLBD6uMtJyIq/rxORsZPm4jg8Wpn5s3SeClJyTZGjK9RMTPzKdCEFdsPo5m
         27hEL/L8rIl0AlmhnGU6rrKzFiZ0YX4rDvdSUgSJhugMAhSb6yhuHntly9zEr0Re3e7u
         QS+XUFxiWdGaewNbTKc5HvxHc60He+02gCZzpsBn/4Stwr9nShRBaEfT9sb7uyHn4uQR
         /v7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=DsDpak4hGP9eOQqikyTZRbcLuJcQ1VFkpeBTwP7Tglg=;
        b=RnUuf8X7xdd6ItG2Y9Wc26PnBHPc7yiIqhTpJx1t7AS2RR8rUSTV1cHqyF3sOsvDpC
         V8+zf4ffGe87g+T9UXSg6GZYnuCjpWdkpAsQ3laOR7K+9reG5wWrC72aneiI11DG6ku8
         8Se9v9WHkmMOysPTfLaHy9Ei8SM75ksJN8LrIuWQu9ErK2O7YxlgJ6/pRk8l83HYsyBG
         IBNNoK1T7ZgPSjaO1qyjYOEoTrlISM63hO21dcngaqR6ms67RDTmZW8gqqAqVBsqRvBC
         I1YwJdLCp11Ri8EaxLrGmI8m7FGTK8dEsaVqd8mwBeRN1EI7ki3b6nfnfGXERsWEcLcl
         fi3g==
X-Gm-Message-State: ACrzQf0IyFVFWO5GRH/dTRMp+PmuVSkbvCkwnrt80Sv3VCBGhjU/aKAP
        V+2Jz4dTwDCHAhfv/SM61VCZXIESoyGcnESID4pW5Q==
X-Google-Smtp-Source: AMsMyM4bYGIr/YojNkWActQYGGG+goRSFSZWwk+hqiwEg7gC8d11FKELyxohMTv2TxTqiT1XVRw3LdSzuGw8Fh/Q/7Q=
X-Received: by 2002:a05:6902:100b:b0:6af:cda:704d with SMTP id
 w11-20020a056902100b00b006af0cda704dmr8118126ybt.584.1664547009228; Fri, 30
 Sep 2022 07:10:09 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000008ea2da05e979435f@google.com> <0000000000000f962805e9d6ae62@google.com>
 <YzYFIK/jFiN6WEzT@ZenIV>
In-Reply-To: <YzYFIK/jFiN6WEzT@ZenIV>
From:   Marco Elver <elver@google.com>
Date:   Fri, 30 Sep 2022 16:09:32 +0200
Message-ID: <CANpmjNPXPoguZAS9L0XPey4=XX1NSTDEB_mA7j7t10FThefuUQ@mail.gmail.com>
Subject: Re: [syzbot] kernel panic: stack is corrupted in writeback_single_inode
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     syzbot <syzbot+84b7b87a6430a152c1f4@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        Hrutvik Kanabar <hrutvik@google.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 29 Sept 2022 at 22:50, Al Viro <viro@zeniv.linux.org.uk> wrote:
[...]
> ... and you _still_ have not bothered to Cc ntfs maintainers.
> Once more, with feeling:
>         If you are fuzzing something (ntfs, in this case), the people most
> interested in your report are the maintainers of the code in question.
> You know that from the moment you put the test together.  No matter where
> exactly the oops gets triggered, what it looks like, etc.

Apologies - we just updated syzbot to do better, so for bugs like this
it should now pick appropriate sub-filesystem maintainers.

Thanks,
~~ Marco
