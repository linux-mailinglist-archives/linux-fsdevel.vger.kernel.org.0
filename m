Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1395A11BCB2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2019 20:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfLKTPR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Dec 2019 14:15:17 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40875 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbfLKTPQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Dec 2019 14:15:16 -0500
Received: by mail-lj1-f195.google.com with SMTP id s22so25332089ljs.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2019 11:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VOD7R27AsduJWVvdOr2UIanUZawLN4t/gENPDoXyCKs=;
        b=VdTfqGW9GvpFK5GEtZfMWoXvDM0CVFcRYBxvTgJD7+rU2yW/orFNa/DB6iVh91TX0t
         aDxZ9K5e9xBP74CjsXLZ6j+btdY5WwxvIgcQ3P7lR8WRNwUHrI70uAyCgm82AEi4TdHY
         GbH2oENsGX414IFAn8/pU1MmiER9PTwnReX7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VOD7R27AsduJWVvdOr2UIanUZawLN4t/gENPDoXyCKs=;
        b=Vt5i+LQ2z7uxq3P2ssu3ldihD/n4DDcfesYjDJbCqnwrt/aQ6LuN9V+Ak/pHc3+5xi
         jWE6I2YT0D5so7Cn8VZn9harm+mNqoWjW4+VLv3ygElJnqxznvlSihrtLxoMldhebvdl
         J+MHcGmCfgLmsXIcpQLIzuJm7CQkYg09NWDyWnUBXZ7ufoOZzZho5UkqPwsZrXVV3H5b
         eIxE/ig72LCnoQSSrQ9TW2VvOfZjoZoZDTEFq6I1AIVNniNDCAFhPv6M3aKwu1kAJLzd
         m6YzvLuXF8D1hoE87NJ/kGiIbPRVfqCokIhYxwIvnrdAfn7zQiOTY1khjjdpSSU0WYx6
         AIbw==
X-Gm-Message-State: APjAAAW9PCzhrxtgujFS/JeUG3jBqiYMgv7UhUAzuq9MnQ5tSw+IW9VH
        R9HnOhZ3wirjKDcmss+hNUqystcc/4Y=
X-Google-Smtp-Source: APXvYqwYiv7CjkLW3p1ElpA7JBcK6vehGVr4Ttbmj6VVLSuC8TlZHl/Up7ZhSnQE+WBsePgLKW8txw==
X-Received: by 2002:a2e:98c4:: with SMTP id s4mr3349787ljj.102.1576091714260;
        Wed, 11 Dec 2019 11:15:14 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id s22sm1681273ljm.41.2019.12.11.11.15.13
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 11:15:13 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id e28so25299294ljo.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2019 11:15:13 -0800 (PST)
X-Received: by 2002:a2e:9041:: with SMTP id n1mr3339710ljg.133.1576091712754;
 Wed, 11 Dec 2019 11:15:12 -0800 (PST)
MIME-Version: 1.0
References: <20191211152943.2933-1-axboe@kernel.dk> <CAHk-=wjz3LE1kznro1dozhk9i9Dr4pCnkj7Fuccn2xdWeGHawQ@mail.gmail.com>
 <d0adcde2-3106-4fea-c047-4d17111bab70@kernel.dk>
In-Reply-To: <d0adcde2-3106-4fea-c047-4d17111bab70@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 11 Dec 2019 11:14:56 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh_YwvNNikQ9yh7oqG5hyJE9tw+bXFft-mOQJ0n_v+a7g@mail.gmail.com>
Message-ID: <CAHk-=wh_YwvNNikQ9yh7oqG5hyJE9tw+bXFft-mOQJ0n_v+a7g@mail.gmail.com>
Subject: Re: [PATCHSET v3 0/5] Support for RWF_UNCACHED
To:     Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@fb.com>,
        Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[ Adding Johannes Weiner to the cc, I think he's looked at the working
set and the inactive/active LRU lists the most ]

On Wed, Dec 11, 2019 at 9:56 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> > In fact, that you say that just a pure random read case causes lots of
> > kswapd activity makes me think that maybe we've screwed up page
> > activation in general, and never noticed (because if you have enough
> > memory, you don't really see it that often)? So this might not be an
> > io_ring issue, but an issue in general.
>
> This is very much not an io_uring issue, you can see exactly the same
> kind of behavior with normal buffered reads or mmap'ed IO. I do wonder
> if streamed reads are as bad in terms of making kswapd go crazy, I
> forget if I tested that explicitly as well.

We definitely used to have people test things like "read the same
much-bigger-than-memory file over and over", and it wasn't supposed to
be all _that_ painful, because the pages never activated, and they got
moved out of the cache quickly and didn't disturb other activities
(other than the constant IO, of course, which can be a big deal in
itself).

But maybe that was just the streaming case. With read-around and
random accesses, maybe we end up activating too much (and maybe we
always did).

But I wouldn't be surprised if we've lost that as people went from
having 16-32MB to having that many GB instead - simply because a lot
of loads are basically entirely cached, and the few things that are
not tend to be explicitly uncached (ie O_DIRECT etc).

I think the workingset changes actually were maybe kind of related to
this - the inactive list can become too small to ever give people time
to do a good job of picking the _right_ thing to activate.

So this might either be the reverse situation - maybe we let the
inactive list grow too large, and then even a big random load will
activate pages that really shouldn't be activated? Or it might be
related to the workingset issue in that we've activated pages too
eagerly and not ever moved things back to the inactive list (which
then in some situations causes the inactive list to be very small).

Who knows. But this is definitely an area that I suspect hasn't gotten
all that much attention simply because memory has become much more
plentiful, and a lot of regular loads basically have enough memory
that almost all IO is cached anyway, and the old "you needed to be
more clever about balancing swap/inactive/active even under normal
loads" thing may have gone away a bit.

These days, even if you do somewhat badly in that balancing act, a lot
of loads probably won't notice that much. Either there is still so
much memory for caching that the added IO isn't really ever dominant,
or you had such a big load to begin with that it was long since
rewritten to use O_DIRECT.

            Linus
