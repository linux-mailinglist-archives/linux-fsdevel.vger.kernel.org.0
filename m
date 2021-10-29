Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2A14400C3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Oct 2021 18:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhJ2Q6j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Oct 2021 12:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbhJ2Q6i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Oct 2021 12:58:38 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C9AC061714
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Oct 2021 09:56:09 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id i26so15963747ljg.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Oct 2021 09:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aEdVDAPX40INreqiADCLispl36CO/b9z9SQKpRdVE1Y=;
        b=JfdMII6gIZlyaHL+Q4xoTQwnX8b3fgyxMA3HvsY34gLVjvf0LTkJtWsyGhtP73w7ce
         l4Ck+JfF00mhahEor3hdwLmDAwbn+31pY/z3ebxXpyY2bNAhlRGguF0iPuRoVV7G7GWH
         wnIUdqYdvjvQIiSxRcrj1zWJIJvOuW6Og6578=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aEdVDAPX40INreqiADCLispl36CO/b9z9SQKpRdVE1Y=;
        b=QSYxCJ4MuFMghzTUPS8/f9k6uw2AqXym+jgftSKp0giYbltrJSbaSPD5aCMl5SpC4Y
         S2p67isL2DJs5WuApQdu12Yf8aApZs9GzA7XeKbuN9ZvKjv8qK24cbE6WLJui+gsT+U4
         SgaXaAjVSy9hQjWdK0yQuTxq5WyfR0xS1Pr5eBBGIe3B4xubB3DkL2itBU3tOFr9xlUj
         lzgBRYmr2cDEjcsvBWAPmkRv7JPHUX10wSn+b7Dd+EUxvU0wp3nGFrml2cJBYmptemaI
         QqTtElYZjiXson90ygev1YEQJGCCSzaRhis307UQQ3vIcP67npubgSRh8R4JbSyvZO4U
         DgoA==
X-Gm-Message-State: AOAM5323NHQgiQFdJ3VovGZWWkFFg6lSFDng6tLngymeYKxCvZc7s5W9
        X9Iw6my4MYvtuqj7WPVMoWmMfmoiHDmPmNE4coQ=
X-Google-Smtp-Source: ABdhPJwMHeY9yhVhg44dkW9p7+iC7uTeZX78M6+Ue+GZbYb6RJq59WRfsHzvhfgh2rW/t+MyqSfCEg==
X-Received: by 2002:a05:651c:2de:: with SMTP id f30mr8105942ljo.361.1635526567153;
        Fri, 29 Oct 2021 09:56:07 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id x5sm650319lfr.307.2021.10.29.09.56.06
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Oct 2021 09:56:06 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id x27so22265126lfu.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Oct 2021 09:56:06 -0700 (PDT)
X-Received: by 2002:a2e:b744:: with SMTP id k4mr12794150ljo.31.1635526190871;
 Fri, 29 Oct 2021 09:49:50 -0700 (PDT)
MIME-Version: 1.0
References: <163551653404.1877519.12363794970541005441.stgit@warthog.procyon.org.uk>
In-Reply-To: <163551653404.1877519.12363794970541005441.stgit@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 29 Oct 2021 09:49:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiy4KNREEqvd10Ku8VVSY1Lb=fxTA1TzGmqnLaHM3gdTg@mail.gmail.com>
Message-ID: <CAHk-=wiy4KNREEqvd10Ku8VVSY1Lb=fxTA1TzGmqnLaHM3gdTg@mail.gmail.com>
Subject: Re: [PATCH v4 00/10] fscache: Replace and remove old I/O API
To:     David Howells <dhowells@redhat.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        v9fs-developer@lists.sourceforge.net,
        CIFS <linux-cifs@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        linux-cachefs@redhat.com, Dave Wysochanski <dwysocha@redhat.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 29, 2021 at 7:09 AM David Howells <dhowells@redhat.com> wrote:
>
>  (1) A simple fallback API is added that can read or write a single page
>      synchronously.  The functions for this have "fallback" in their names
>      as they have to be removed at some point.

David, I still don't understand WHY.

I read the explanations in the commits, and that didn't help either.

Why, of why, do you insist of adding this intermediate interface that
is already documented to "must be removed" at the point it is even
added?

What's the point of adding garbage that is useless in the long run?

Why is the first step not just "remove fscache"?

Why is there this addition of the "deprecated" interface - that you
have now renamed "fallback"?

I agree that "fallback" is a less annoying name, so that renaming is
an improvement, but WHY?

I absolutely detested your whole "move old garbage around before
removal", and I also detest this "add new garbage that will be
removed".

What's the point? Why isn't the fix just "remove CONFIG_FSCACHE and
all the code".

You already *HAVE* the "fallback" code - it's all that

    #else /* CONFIG_NFS_FSCACHE */
    static inline int nfs_fscache_register(void) { return 0; }
    static inline void nfs_fscache_unregister(void) {}
    ...

stuff in <nfs/fscache.h> and friends. So why do you need _new_
fallback code, when CONFIG_FSCACHE already exists and already has a
"this disables fscache"?

Maybe there is some really good reason, but that really good reason
sure as hell isn't documented anywhere, and I really don't see the
point.

So let me say this again:

 - it would be much better if you could incrementally just improve the
existing FSCACHE so that it just _works_ all the time, and fixes the
problems in it, and a bisection works, and there is no flag-day.

 - but dammit, if you have to have a flag-day, then there is NO POINT
in all this "move the old code around before moving it", or "add a
fallback interface before removing it again".

Oh, I can understand wanting to keep the header files around in case
the interfaces end up being similar enough in the end that it all
matters.

But I don't understand why you do this kind of crud:

 fs/cachefiles/io.c      |   28 ++++++++-
 fs/fscache/io.c         |  137 +++++++++++++++++++++++++++++++++++++++------

when the neither of those directories will ever even be *compiled* if
CONFIG_FSCACHE isn't true (because CACHEFILES has a "depends on
FSCACHE").

See my argument? If FSCACHE isn't usable during the transition, then
don't make these kinds of pointless code movement or creation things
that are just dead.

There's absolutely no point in having some "fallback" interface that
allows people to test some configuration that simply isn't relevant.
It doesn't help anything. It just adds more noise and more
configurations, and no actual value that I can see.

It doesn't help bisectability: if some bug ever bisects to the
fallback code, what does that tell us? Nothing. Sure, it trivially
tells us the fallback code was buggy, but since the fallback code has
been removed afterwards, the _value_ of that information is nil,
zilch, nada. It's not "information", it's just "worthless data".

And hey, maybe there's some issue that I don't understand, and I don't
see. But if there is some subtle value here, it should  have been
documented.

So I say exactly the same thing I said last time: if the old fscache
code is not usable, and you can't incrementally fix it so that it
works all the time, then JUST REMOVE IT ALL. Moving it elsewhere
before the removal is only pointless noise. But adding some fallback
intermediate code before removal is ALSO just pointless noise.

Doing a flag-day with "switch from A to B" is already painful and
wrong. I don't like it. But I like it even _less_, if it's a "switch
from A to B to C".

If you do want t9o have a "halfway state", the only halfway state that
makes sense to me is something like

 (a) make all the changes to the old FSCACHE - keeping it all
_working_ during this phase - to make it have the same _interfaces_ as
the new fscache will have.

 (b) then remove the old FSCACHE entirely

 (c) then plop in the new FSCACHE

But note how there was no "fallback" stage anywhere. No code that lies
around dead at any point. At each point it was either all working old
or all working new (or nothing at all).

Yes, in this case that "step (a)" is extra work and you're basically
modifying code that you know will be removed, but the advantage now is

 -  at least the fscache _users_ are being modified while the old and
tested world is still working, and the interface change is
"bisectable" in that sense. That's useful in itself.

 - if it turns out that people have problems with the new generation
FSCACHE, they can reverse steps (b) and (c) without having to touch
and revert all the other filesystems changes.

IOW, if a "same interfaces" state exists, that's fine. But for it to
make sense, those same interfaces have to be actually _useful_, not
some fallback code that is neither the old nor the new.

And maybe you can't do that "step (a)" because the interfaces are part
of the fundamental problem with the old FSCACHE. But if you drop (a),
then don't add some stage between (b) and (c), because it's not
helpful.

And again, maybe I'm missing something. But really, I don't see why
this "remove old FSCACHE" stage should *ever* make any modifications
to fs/fscache/* and fs/cachefiles/* when disabling the config option
means that it just won't get built at all.

               Linus
