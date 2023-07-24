Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C35D75FCCC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 19:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjGXRAJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 13:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjGXRAI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 13:00:08 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8A21702
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 09:59:42 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-98dfb3f9af6so797036866b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 09:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690217973; x=1690822773;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o2B4woNmLNdUuguJvCzvlrs61XjRQO0GpugOQ9y5gEs=;
        b=HalCIjUStTaGlN01rfZnkZgNiWrLwtjO2VwMGTmj+UXr7Bz+WWN/5XoY5RdLUFRnWM
         7/WzoePPM5WiWiaMu40zMc44ztKANmPYWXKOt94R9Hen2XMOdnIbtLm9BfIbyhjWSust
         7TxiunNKouknbzxS0cy70kqIXqp+RvoVOa124=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690217973; x=1690822773;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o2B4woNmLNdUuguJvCzvlrs61XjRQO0GpugOQ9y5gEs=;
        b=h2+A74fqWxeUkvkX/v6SviVxG+brORKMWxAhnw5aRQj6bgUcdRf188NLe8XpniiXzg
         C/SaF9wjybhUJtdntTOFwF7ffq69EG9NT8pjAlxfLUqB78Lx7Rvx01AmkCZxAtC5cAak
         r0mRvhS4uI50/04wiZQisLRbrbT/fB0i5CuJNDQYnsRFJegAJOWODuguI9vpGH38YDUg
         hwAGRLYJLi4UC1sp6YOYvGcbjn1umhWcPH2tPMrt1AJolIe64PX+NcuXiEhvSSboZItZ
         K3gd97Wa6xqqezBgJVS1/jyJnL8YdSY513Cjy0jh3MgA6fw0qzluoiQmyFxLykStyA93
         mxww==
X-Gm-Message-State: ABy/qLZD0Ept1kDbdf0eX0mbxXA5X+yLSnOFcAh9okREx5Aw8E7aGO0q
        O8Xba/UzADRL8uTCDr0xAwzMTt3IQYqbjEyEiLHKGQ==
X-Google-Smtp-Source: APBJJlGpirlvQ1ygcYd4ivgv8H8LvCDJta9MhjQ+ZS2VwlYAp+K1q9rKGtP1e5IeR6VGIFujvsZsPQ==
X-Received: by 2002:a17:906:9bc6:b0:982:26c5:6525 with SMTP id de6-20020a1709069bc600b0098226c56525mr9677191ejc.60.1690217973617;
        Mon, 24 Jul 2023 09:59:33 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id ot7-20020a170906ccc700b009929c09abdfsm7022906ejb.70.2023.07.24.09.59.32
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 09:59:33 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5223fbd54c6so324519a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 09:59:32 -0700 (PDT)
X-Received: by 2002:aa7:ce0a:0:b0:522:3081:ddb4 with SMTP id
 d10-20020aa7ce0a000000b005223081ddb4mr2402715edv.20.1690217972684; Mon, 24
 Jul 2023 09:59:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230724-vfs-fdget_pos-v1-1-a4abfd7103f3@kernel.org>
 <CAHk-=whfJhag+iEscftpVq=dHTeL7rQopCvH+Pcs8vJHCGNvXQ@mail.gmail.com> <20230724-pyjama-papier-9e4cdf5359cb@brauner>
In-Reply-To: <20230724-pyjama-papier-9e4cdf5359cb@brauner>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 24 Jul 2023 09:59:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj2XZqex6kzz7SbdVHwP9fFoOvHSzHj--0KuxyrVO+3-w@mail.gmail.com>
Message-ID: <CAHk-=wj2XZqex6kzz7SbdVHwP9fFoOvHSzHj--0KuxyrVO+3-w@mail.gmail.com>
Subject: Re: [PATCH] file: always lock position
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
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

On Mon, 24 Jul 2023 at 09:46, Christian Brauner <brauner@kernel.org> wrote:
>
> So thinking a little about it I think that doesn't work.
> /proc/<pid>/fd/<xyz> does a reopen and for good reasons. The original
> open will have gone through the module's/subsytem's ->open() method
> which might stash additional refcounted data in e.g., file->private_data
> if we simply copy that file or sm then we risk UAFs.

Oh, absolutely, we';d absolutely need to do all the re-open things.

That said, we could limit it to FMODE_ATOMIC_POS - so just regular
files and directories. The only thing that sets that bit is
do_dentry_open().

And honestly, the only thing that *really* cares is directories,
because they generally have special rules for pos changing.

The regular files have the "POSIX rules" reason, but hey, if you use
pidfd_getfd() and mess with the pos behind the back of the process,
it's no different from using a debugger to change it, so the POSIX
rules issue just isn't relevant.

I really hate making the traditional unix single-threaded file
descriptor case take that lock.

Maybe it doesn't matter. Obviously it can't have contention, and your
patch in that sense is pretty benign.

But locking is just fundamentally expensive in the first place, and it
annoys me that I never realized that pidfd_getfd() did that thing that
I knew was broken for /proc.

                  Linus
