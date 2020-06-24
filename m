Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B938A207B63
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 20:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406007AbgFXSUr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jun 2020 14:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405965AbgFXSUq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jun 2020 14:20:46 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F17C061573
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2020 11:20:45 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id s9so3610271ljm.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2020 11:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XimJzMILNab/U2O86DvGdgMSVqfmt24O53XaiquNzaw=;
        b=L7dvV468TVxudpkNjmIRlLmBHK2l5b48IN4xUNH3aPEtkp1XT90rStcv+QUsXusvih
         KeRXgDNYrhAcX2vKUzDkxiPSqnGiGnHAQ0jBNRlLYQvbj2AURCzWYOjdNtogRaldMDPw
         0aU+0lz1SHvCoYW/zOH0AcY+lBWGDLMzZDupI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XimJzMILNab/U2O86DvGdgMSVqfmt24O53XaiquNzaw=;
        b=qxbdHV5fPBFQe8Yxidwur8m/ufPAPrpYQ4p79RTuhj064zOQhU6kE5Hl7sAGa23eZc
         nQ7QC+EyNIPjfzACqVHkH+SbED8gKclK3PdWtsTATAB1t1e3vacMI9sTKyEe9dO0doAK
         Df0JU7U4nwQH3aN+uqoVVA7uyzU1eg5B8TJNGeGznXi/vuFWhcbm5MrnbXUT3UELIaPI
         H+171c0ig2ME7+qWR1P9Xf6wuFSKFuWK0Vjg9HhxEpuuxnnDgc9ZeXggurjCUYwkRh/7
         +LZWEb2QLqOxpCPUruy+iT8omwYFPgKevt1AW/942+LSMDScS51C0UbvfzJYaD3LG3e4
         WodA==
X-Gm-Message-State: AOAM533GdfJN68Mxme55roaKcvAmuJ+M3/7WacOodBx4htTdAecB7Lbx
        QFhylb8nKDVTHREDMRRObmJ1H+8PnQQ=
X-Google-Smtp-Source: ABdhPJzB/OX0oZflIj556kRPejcCpPQZN4D/2NEdI6gW6v1uLHVpfLgnDHmCWI/l7H8dr8XUx6XasA==
X-Received: by 2002:a2e:8953:: with SMTP id b19mr15350513ljk.187.1593022844136;
        Wed, 24 Jun 2020 11:20:44 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id x30sm5030660lfn.3.2020.06.24.11.20.43
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2020 11:20:43 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id i3so3664843ljg.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2020 11:20:43 -0700 (PDT)
X-Received: by 2002:a2e:b5d7:: with SMTP id g23mr13749439ljn.70.1593022842794;
 Wed, 24 Jun 2020 11:20:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200624162901.1814136-1-hch@lst.de> <20200624162901.1814136-4-hch@lst.de>
 <CAHk-=wit9enePELG=-HnLsr0nY5bucFNjqAqWoFTuYDGR1P4KA@mail.gmail.com>
 <20200624175548.GA25939@lst.de> <CAHk-=wi_51SPWQFhURtMBGh9xgdo74j1gMpuhdkddA2rDMrt1Q@mail.gmail.com>
 <20200624181437.GA26277@lst.de>
In-Reply-To: <20200624181437.GA26277@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 24 Jun 2020 11:20:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgC4a9rKrKLTHbH5cA5dyaqqy4Hnsr+re144AiJuNwv9Q@mail.gmail.com>
Message-ID: <CAHk-=wgC4a9rKrKLTHbH5cA5dyaqqy4Hnsr+re144AiJuNwv9Q@mail.gmail.com>
Subject: Re: [PATCH 03/11] fs: add new read_uptr and write_uptr file operations
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 24, 2020 at 11:14 AM Christoph Hellwig <hch@lst.de> wrote:
>
> So we'd need new user copy functions for just those cases

No. We'd open-code them. They'd look at "oh, I'm supposed to use a
kernel pointer" and just use those.

IOW, basically IN THE CODE that cares (and the whole argument is that
this code is one or two special cases) you do

    /* This has not been converted to the new world order */
    if (get_fs() == KERNEL_DS) memcpy(..) else copy_from_user();

You're overdesigning things. You're making them more complex than they
need to be.

Basically, I do *NOT* want to pollute the VFS layer with new
interfaces that shouldn't exist in the long run. I'd much rather make
the eventual goal be to get rid of 'read/write' entirely in favour of
the 'iter' things, but what I absolutely do *NOT* want to see is to
make a _third_ interface for reading and writing. Quite the reverse.
We should strive to make it a _single_ interface, not add a new one.

And I'd rather have a couple of ugly code details in odd places (that
we can hopefully fix up later) than have new VFS infrastructure that
will then hang around forever more.

                Linus
