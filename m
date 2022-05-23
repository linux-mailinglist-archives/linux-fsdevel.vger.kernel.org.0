Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D26531644
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 May 2022 22:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbiEWTnU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 May 2022 15:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234706AbiEWTmw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 May 2022 15:42:52 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4446BE008
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 May 2022 12:41:41 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id rs12so19235740ejb.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 May 2022 12:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HnMg9PaJ6KDavvSY7bvDnr4e+cLVAv92In4gmvI8qTo=;
        b=HCaV3MV+Wk0Z923y3RiL9cz3mSUV0XeHVnP4FDh3NRxQZA+nm0aJ/Epv8MQnI8vcSc
         7zBAZSQ5t7wRZ8+gtBpm/ooAo0kdVyNyfRYoOO+JacEkD/OOyTn1L5NpMsVymQAbAwZu
         uYpqxRnwshqaGtIGG+BQ7pA8+4kShZx1czvPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HnMg9PaJ6KDavvSY7bvDnr4e+cLVAv92In4gmvI8qTo=;
        b=Q4OEHwsfkOl/oh0BFKyDibuvgpgL3VZNqLv7sHwIlCK04j9fLyFGhlP4xs0f3xMmZh
         JbdIeBrNEPTfCy973SAahnrH+cHo7MFc+JizYC+K/858WXiECMml3EWZEMS6e9Du5h42
         MYa305qQflC2rM8CR6bgZb5s4DRKTvCIq0EoYv0L8zO6zl8TzDz5eBVFbmBGkqNHw7be
         ovKr1LnjCMDJbSfprkP9dZdHd287hJME6ItrvajNEYRb9ktMb0fwsoNvJsTQhj36SsQl
         +sOqHJA2HV5qDqCPIbWippT0BN3b6cqd30TXiGAIRCiD+svichPfVLdU36Ktmw6e2PXt
         YdNw==
X-Gm-Message-State: AOAM5318yPDM7Mo8Cx02df06DI5LLdyaurcQvkHiD0szRw+GMPTA0E3k
        Ul9Gxw4Oxi2P8RxiESbdm+YZh44/TDCgKTvWYtY=
X-Google-Smtp-Source: ABdhPJw3z5HNOSZqhFReQqb9RAe5UKvt2HP4s6qAxqSSCV8uzXmvwcyXvul+vj0nTFD4E9/oZ7+XeA==
X-Received: by 2002:a17:907:1b1e:b0:6d7:31b0:e821 with SMTP id mp30-20020a1709071b1e00b006d731b0e821mr21392057ejc.334.1653334899511;
        Mon, 23 May 2022 12:41:39 -0700 (PDT)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id pk14-20020a170906d7ae00b006fed3fdf421sm1870542ejb.139.2022.05.23.12.41.38
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 12:41:39 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id p189so9415461wmp.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 May 2022 12:41:38 -0700 (PDT)
X-Received: by 2002:a05:600c:4f06:b0:394:836b:1552 with SMTP id
 l6-20020a05600c4f0600b00394836b1552mr518911wmq.145.1653334898506; Mon, 23 May
 2022 12:41:38 -0700 (PDT)
MIME-Version: 1.0
References: <d94a4e55-c4f2-73d8-9e2c-e55ae8436622@kernel.dk>
In-Reply-To: <d94a4e55-c4f2-73d8-9e2c-e55ae8436622@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 23 May 2022 12:41:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg54n0DONm_2Fqtpq63ZgfQUef0WLNhW_KaJX4HTh19YQ@mail.gmail.com>
Message-ID: <CAHk-=wg54n0DONm_2Fqtpq63ZgfQUef0WLNhW_KaJX4HTh19YQ@mail.gmail.com>
Subject: Re: [GIT PULL] io_uring xattr support
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring <io-uring@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
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

On Sun, May 22, 2022 at 2:26 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On top of the core io_uring changes, this pull request includes support
> for the xattr variants.

So I don't mind the code (having seen the earlier versions), but
looking at this all I *do* end up reacting to this part:

    [torvalds@ryzen linux]$ wc -l fs/io_uring.c
    12744 fs/io_uring.c

and no, this is not due to this xattr pull, but the xattr code did add
another few hundred lines of "io_uring command boilerplate for another
command" to this file that is a nasty file from hell.

I really think that it might be time to start thinking about splitting
that io_uring.c file up. Make it a directory, and have the core
command engine in io_uring/core.c, and then have the different actual
IO_URING_OP_xyz handling in separate files.

And yes, that would probably necessitate making the OP handling use
more of a dispatch table approach, but wouldn't that be good anyway?
That io_uring.c file is starting to have a lot of *big* switch
statements for the different cases.

Wouldn't it be nice to have a "op descriptor array" instead of the

        switch (req->opcode) {
        ...
        case IORING_OP_WRITE:
                return io_prep_rw(req, sqe);
        ...

kind of tables?

Yes, the compiler may end up generating a binary-tree
compare-and-branch thing for a switch like that, and it might be
better than an indirect branch in these days of spectre costs for
branch prediction safety, but if we're talking a few tens of cycles
per op, that's probably not really a big deal.

And from a maintenenace standpoint, I really think it would be good to
try to try to walk away from those "case IORING_OP_xyz" things, and
try to split things up into more manageable pieces.

Hmm?

               Linus
