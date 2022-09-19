Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B87305BD388
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Sep 2022 19:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbiISRV3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Sep 2022 13:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbiISRV1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Sep 2022 13:21:27 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BD93A14B
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Sep 2022 10:21:24 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id l14so251443eja.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Sep 2022 10:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=T9tjs2C6JiXyUusbaKulAdI7lGnBQljvbsg/PdLJCpA=;
        b=d9OWu4XihWylyVprmVcBC5mpF2dwkINsQkbE45w0j52Xy81466CqXQPMiUn98OKp2I
         D0OR+cpGgXgnZk/F2jIxYmIK2vfKKSY72iauA7Bdb3NO4Rsn4PtIq5pbAlsF4TH6MKLA
         dYmf0PmOlJ4YKvN7Iu0BbKVYqGq7ucGD9f4OE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=T9tjs2C6JiXyUusbaKulAdI7lGnBQljvbsg/PdLJCpA=;
        b=4h6vjs1X6ECbuXhE/TFW14Sd1UzxjoNEAdK7t7bGgOY1qW2CbtSnb59ugobwkr45Q+
         SAGaE/qdV2MWPQADeSkLZgW0v1oUpwi9L2lqIv+wGQWz/9qN9mMwHHFhh+bupRIOdF8s
         CfsBXA3nyRa1rXsXywLFxsamIb9PfLnjPSafuhKoraZIZU3KwnhqTbsDlvhBNLRuC9QO
         Hn9IzQ2aGJBnh7/jESXKz2v+ViMIuJaTooqWwLo6yHckBfOLxY6jqoWCQPCTQnNUMONV
         2o2wk7ikKgD1mI75acXLE1gp15mQkFNS/BJqfb32gYs75/Yx7lGvgyTaWLYErjK2GfY3
         K9eA==
X-Gm-Message-State: ACrzQf0z/mGLw/paKknSjJCf638IJNoYWSZ9p3m9r6Ytm1NrIgTuY4bo
        v88CvPqC47kCPEPpJSl0td5iUIzllZIedHLOtWU=
X-Google-Smtp-Source: AMsMyM4raLOsOH98lqjHA424bQnHL0hO4uWWwQJuo4LUnfe4RE+7oFdQhEewne3Nd6RutPIngF4d2g==
X-Received: by 2002:a17:907:72c8:b0:77f:e3f1:db2a with SMTP id du8-20020a17090772c800b0077fe3f1db2amr13645171ejc.198.1663608082125;
        Mon, 19 Sep 2022 10:21:22 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id s15-20020a1709067b8f00b00775f6081a87sm2896493ejo.121.2022.09.19.10.21.20
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 10:21:21 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id n10so123189wrw.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Sep 2022 10:21:20 -0700 (PDT)
X-Received: by 2002:a05:6512:3d16:b0:498:f04f:56cf with SMTP id
 d22-20020a0565123d1600b00498f04f56cfmr7388621lfv.612.1663608070133; Mon, 19
 Sep 2022 10:21:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220805154231.31257-13-ojeda@kernel.org> <Yu5Bex9zU6KJpcEm@yadro.com>
 <CANiq72=3j2NM2kS8iw14G6MnGirb0=O6XQyCsY9vVgsZ1DfLaQ@mail.gmail.com>
 <Yu6BXwtPZwYPIDT6@casper.infradead.org> <Yyh3kFUvt2aMh4nq@wedsonaf-dev> <CAHk-=wgaBaVaK2K=N05fwWSSLM6YJx=yLmP4f7j6d6o=nCAtdw@mail.gmail.com>
In-Reply-To: <CAHk-=wgaBaVaK2K=N05fwWSSLM6YJx=yLmP4f7j6d6o=nCAtdw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 19 Sep 2022 10:20:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=whTDbFZKB4KJ6=74hoLcerTm3JuN3PV8G6ktcz+Xm1qew@mail.gmail.com>
Message-ID: <CAHk-=whTDbFZKB4KJ6=74hoLcerTm3JuN3PV8G6ktcz+Xm1qew@mail.gmail.com>
Subject: Re: [PATCH v9 12/27] rust: add `kernel` crate
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Konstantin Shelekhin <k.shelekhin@yadro.com>, ojeda@kernel.org,
        alex.gaynor@gmail.com, ark.email@gmail.com,
        bjorn3_gh@protonmail.com, bobo1239@web.de, bonifaido@gmail.com,
        boqun.feng@gmail.com, davidgow@google.com, dev@niklasmohrin.de,
        dsosnowski@dsosnowski.pl, foxhlchen@gmail.com, gary@garyguo.net,
        geofft@ldpreload.com, gregkh@linuxfoundation.org,
        jarkko@kernel.org, john.m.baublitz@gmail.com,
        leseulartichaut@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, m.falkowski@samsung.com,
        me@kloenk.de, milan@mdaverde.com, mjmouse9999@gmail.com,
        patches@lists.linux.dev, rust-for-linux@vger.kernel.org,
        thesven73@gmail.com, viktor@v-gar.de,
        Andreas Hindborg <andreas.hindborg@wdc.com>
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

On Mon, Sep 19, 2022 at 9:09 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> The whole "really know what context this code is running within" is
> really important. You may want to write very explicit comments about
> it.

Side note: a corollary of this is that people should avoid "dynamic
context" things like the plague, because it makes for such pain when
the context isn't statically obvious.

So things like conditional locking should generally be avoided as much
as humanly possible. Either you take the lock or you don't - don't
write code where the lock context depends on some argument value or
flag, for example.

Code like this is fine:

        if (some_condition) {
                spin_lock(&mylock);
                xyz();
                spin_unlock(&mylock);
        }

because 'xyz()' is always run in the same context. But avoid patterns like

        if (some_condition)
                spin_lock(&mylock);
        xyz();
        if (same_condition)
                spin_unlock(&mylock);

where now 'xyz()' sometimes does something with the lock held, and
sometimes not. That way lies insanity.

Now, obviously, the context for helper functions (like the Rust kernel
crate is, pretty much by definition) obviously depends on the context
of the callers of said helpers, so in that sense the above kind of
"sometimes in locked context, sometimes not" will always be the case.

So those kinds of helper functions will generally need to be either
insensitive to context and usable in all contexts (best), or
documented - and verify with debug code like 'might_sleep()' - that
they only run in certain contexts.

And then in the worst case there's a gfp_flag that says "you can only
do these kinds of allocations" or whatever, but even then you should
strive to never have other dynamic behavior (ie please try to avoid
behavior like having a "already locked" argument and then taking a
lock depending on that).

Because if you follow those rules, at least you can statically see the
context from a call chain (so, for example, the stack trace of an oops
will make the context unambiguous, because there's hopefully no lock
or interrupt disabling or similar that has some dynamic behavior like
in that second example of "xyz()".

Do we have places in the kernel that do conditional locking? Yes we
do. Examples like that second case do exist. It's bad. Sometimes you
can't avoid it. But you can always *strive* to avoid it, and
minimizing those kinds of "context depends on other things"
situations.

And we should strive very hard to make those kinds of contexts very
clear and explicit and not dynamic exactly because it's so important
in the kernel, and it has subtle implications wrt other locking, and
memory allocations.

             Linus
