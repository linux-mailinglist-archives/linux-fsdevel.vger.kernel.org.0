Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB439649061
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Dec 2022 20:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiLJT0i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Dec 2022 14:26:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiLJT0h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Dec 2022 14:26:37 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0598F140C5
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Dec 2022 11:26:35 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id h16so6116082qtu.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Dec 2022 11:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9keNZ0RhWpm80fJ+6HQd3eTsL6/cMWIZJqgwBSVMw/8=;
        b=AsnDh9ot6s1fEkVxMGlieHt+EfJ66tv2wPgVZGQWQB2v1xvCvtMRNiWnQGRkOyBjHM
         V+zFoKMFfbLI2u/a4e4k/3sTCrriUYjrJzW2CuJcgA6D/pkvxGDzYhbpRBQ7mmYAZcFN
         +LTQMS3rq3/35Xqu2xCHQiqWxlHaskORT42Qs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9keNZ0RhWpm80fJ+6HQd3eTsL6/cMWIZJqgwBSVMw/8=;
        b=nMbseIiO+0xoFPh5wRcYZkSwr8aODxYAnmc8DCI8qMSaIxGL9bjH3SL5rt7thVDNjz
         95itnmwu5v79IXS+EQkjxNHXiH1XstNwHRtNzQvXTlgyNjzP93OZ9RN8ZJ6mjqenkZ/L
         CCek+a4lB44AvevXiJrZLxNmrgXoyE7FSqxej1OLPFz7CGqq0LcNdB+VaM4HptiVDGW/
         xGc6MHZBaptHCyptpbxhJ/H2aUPRQxnqPe3Uq6z4ipAsjde1rV+VYVi8w7ylaL3cXRMi
         2w1PGHA9t9oYHoiaGzeFjKfUaY7IKwIpaK4etxXSfsM5aSWWCi5D8B+r8fVAFaF9c1WA
         CIVg==
X-Gm-Message-State: ANoB5pn/vPHfXNCsuXXG9zBDHduWZpWh+I1I10spxlbXfbVq1iuO3HL1
        OeGIzxMi7N80Ko7M/ixiOYtekkP6nbtqAA7z
X-Google-Smtp-Source: AA0mqf4qIBfea9dWrxqQEfivjmYCjOPlm2B0pVwz7foQZ2jpzfRwevpYHuIsBI0Jzmi+qSt2oef/SQ==
X-Received: by 2002:a05:622a:250a:b0:39c:da20:d452 with SMTP id cm10-20020a05622a250a00b0039cda20d452mr14634858qtb.43.1670700393741;
        Sat, 10 Dec 2022 11:26:33 -0800 (PST)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com. [209.85.160.172])
        by smtp.gmail.com with ESMTPSA id t13-20020ac8530d000000b0035badb499c7sm3155431qtn.21.2022.12.10.11.26.32
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Dec 2022 11:26:32 -0800 (PST)
Received: by mail-qt1-f172.google.com with SMTP id s9so5832984qtx.6
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Dec 2022 11:26:32 -0800 (PST)
X-Received: by 2002:ac8:4992:0:b0:3a7:648d:23d4 with SMTP id
 f18-20020ac84992000000b003a7648d23d4mr18157067qtq.180.1670700392241; Sat, 10
 Dec 2022 11:26:32 -0800 (PST)
MIME-Version: 1.0
References: <b0901cba-3cb8-a309-701e-7b8cb13f0e8a@kernel.dk> <CAHk-=whgzBzTR5t6Dc6gZ_XS1q=UrqeiBf62op_fahbwns+xvQ@mail.gmail.com>
In-Reply-To: <CAHk-=whgzBzTR5t6Dc6gZ_XS1q=UrqeiBf62op_fahbwns+xvQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 10 Dec 2022 11:26:16 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiT67DtHF8dSu8nJpA7h+T4jBxfAuR7rcp0iLpKfvF=tw@mail.gmail.com>
Message-ID: <CAHk-=wiT67DtHF8dSu8nJpA7h+T4jBxfAuR7rcp0iLpKfvF=tw@mail.gmail.com>
Subject: Re: [GIT PULL] Add support for epoll min wait time
To:     Jens Axboe <axboe@kernel.dk>
Cc:     netdev <netdev@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Dec 10, 2022 at 10:51 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Now, maybe there is some reason why the tty like VMIN/VTIME just isn't
> relevant, but I do think that people have successfully used VMIN/VTIME
> for long enough that it should be at least given some thought.

Side note: another thing the tty layer model does is to make this be a
per-tty thing.

That's actually noticeable in regular 'poll()/select()' usage, so it
has interesting semantics: if VTIME is 0 (ie there is no inter-event
timeout), then poll/select will return "readable" only once you hit
VMIN characters.

Maybe this isn't relevant for the epoll() situation, but it might be
worth thinking about.

It's most definitely not obvious that any epoll() timeout should be
the same for different file descriptors.

Willy already mentioned "urgent file descriptors", and making these
things be per-fd would very naturally solve that whole situation too.

Again: I don't want to in any way force a "tty-like" solution. I'm
just saying that this kind of thing does have a long history, and I do
get the feeling that the tty solution is the more flexible one.

And while the tty model is "per tty" (it's obviously hidden in the
termios structure), any epoll equivalent would have to be different
(presumably per-event or something).

So I'm also not advocating some 1:1 equivalence, just bringing up the
whole "ttys do this similar thing but they seem to have a more
flexible model".

            Linus
