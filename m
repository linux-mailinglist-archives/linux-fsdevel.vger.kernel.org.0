Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15C14EB5D6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Mar 2022 00:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236622AbiC2WZR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Mar 2022 18:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235847AbiC2WZP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Mar 2022 18:25:15 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91496165BF
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 15:23:30 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id h7so32735377lfl.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 15:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Dqci59lOGmtJ083V8k97ZYbp+giAEnmUDvP8kvIUkQ=;
        b=VT+r9uwHTgcY2d+uPwopx2P2879A0JSJ2gtfFxXD746GNnk+z6kMC9bmyoI1CnXMDl
         NcVjvjzkleAw9ej5n9U29kxGsWaLtCwRJW1vgaE0d8bTR07Nj77+TxMI/kwQpYcYPvN1
         odJbyA0ON7CIneCs1/wSlaM0123GCIo/jGohw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Dqci59lOGmtJ083V8k97ZYbp+giAEnmUDvP8kvIUkQ=;
        b=xO7Clilqjpwn+dl6EjsBs1D6w+XAhvpc+5V8eQycKxN47ybI/JU7w4emNCuKt5GqUX
         RHDMbeWkZ5ZVHQ4i81O2ZPbYRMZF3h4oGOvO/vHUbHQzJjoO9Q4SO8vPR5glbLIFwpGq
         EPo5ig5nccfeeu1ZFQkU4alwqq2p/byPgnwJuGR4oDYnnRwlm/uzWzObB2POwgldk2Sb
         Vwf1iquBLt0u7CEhzSs2pVAtxOp20rGxzLMHFxJOkqUE25OX60Fhv0yJxhFA3bVl2Ijm
         Nh1C/nxMy2tC/85J8ZJSB4RkJMYRLl4021u7Jo9kjqUbd3VXSi6fnDo7v+uwjk/iiQ3q
         kQ2A==
X-Gm-Message-State: AOAM531lY8IpKyUlrACa7Prfm3zrs1/zxU0K494HH3WdjiX6bkDnYnMy
        ry1JEf1wFPco4xxgnCoL+q+j3al+Ql52kKCy
X-Google-Smtp-Source: ABdhPJwJ3IHuszpKUgs/mYA/Wgfn1bimKoW744kbG3cTguZUESbxuKHZQruVBF87drv8XTRfwZyevQ==
X-Received: by 2002:a05:6512:304c:b0:44a:5bad:820f with SMTP id b12-20020a056512304c00b0044a5bad820fmr4527011lfb.68.1648592608478;
        Tue, 29 Mar 2022 15:23:28 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id t4-20020a2e9c44000000b0024ac62a66d9sm1273506ljj.60.2022.03.29.15.23.27
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 15:23:27 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id c15so25300849ljr.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 15:23:27 -0700 (PDT)
X-Received: by 2002:a2e:9b10:0:b0:247:f28c:ffd3 with SMTP id
 u16-20020a2e9b10000000b00247f28cffd3mr4407592lji.152.1648592606822; Tue, 29
 Mar 2022 15:23:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220326114009.1690-1-aissur0002@gmail.com> <2698031.BEx9A2HvPv@fedor-zhuzhzhalka67>
 <CAHk-=wh2Ao+OgnWSxHsJodXiLwtaUndXSkuhh9yKnA3iXyBLEA@mail.gmail.com>
 <4705670.GXAFRqVoOG@fedor-zhuzhzhalka67> <CAHk-=wiKhn+VsvK8CiNbC27+f+GsPWvxMVbf7QET+7PQVPadwA@mail.gmail.com>
 <CAHk-=wjRwwUywAa9TzQUxhqNrQzZJQZvwn1JSET3h=U+3xi8Pg@mail.gmail.com>
In-Reply-To: <CAHk-=wjRwwUywAa9TzQUxhqNrQzZJQZvwn1JSET3h=U+3xi8Pg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 29 Mar 2022 15:23:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjsdDBmaD-sS5FSb3ngn820z3x=1Ny+36agbEXhDuGOsg@mail.gmail.com>
Message-ID: <CAHk-=wjsdDBmaD-sS5FSb3ngn820z3x=1Ny+36agbEXhDuGOsg@mail.gmail.com>
Subject: Re: [PATCH 4/4] file: Fix file descriptor leak in copy_fd_bitmaps()
To:     Fedor Pchelkin <aissur0002@gmail.com>
Cc:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
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

On Tue, Mar 29, 2022 at 3:18 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Ok, applied as commit 1c24a186398f ("fs: fd tables have to be
> multiples of BITS_PER_LONG").

Oh, forgot to mention...

Christian - it strikes me that the whole "min(count, max_fds)" in
sane_fdtable_size() is a bit stupid.

A _smarter_ approach might be to pass in 'max_fds' to
count_open_files(), and simply not count past that value.

I didn't do that, because I wanted to keep the patch obvious. And it
probably doesn't matter, but it's kind of silly to possibly count a
lot of open files that we want to close anyway, when we already know
the place we should stop counting.

Whatever. I just wanted to mention it in case you decide you want to
clean that part up. This is mostly your code anyway.

               Linus
