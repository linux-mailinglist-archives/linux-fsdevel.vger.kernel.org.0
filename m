Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 270A611C269
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 02:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfLLBlh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Dec 2019 20:41:37 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35795 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbfLLBlh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Dec 2019 20:41:37 -0500
Received: by mail-lj1-f196.google.com with SMTP id j6so366191lja.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2019 17:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qkGwL2n2COMGi/65rr06OKZlwq6a94CxCGW0s5lEfc0=;
        b=KgSvodEa7eLrcqdNK9kKIImqn5jEmRctWpRgCEnbVU+jw3hmZb5+262OnTWzIHVrKB
         4bckfwrJrGys15oOES9fMPyMF2VG1oJxHymVlnVo7XzOorvhCUqVrbg00X+UKrC2vXFo
         SG8r+gelbxFlvgfg2uzQmA5lr/M+IXcQCtoKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qkGwL2n2COMGi/65rr06OKZlwq6a94CxCGW0s5lEfc0=;
        b=XFguFzrJA1tVmhCOPNquaqGkTLRwsHJntS3eVLWRkO/jJjhFa9jUYJmywAyu+Zt1LF
         Lt/vgAqtN0vqr1LjuGvFR0YeXGWFfOfeMY46v0xF9kN/cRGOR1AFgb6niDG1Si6aprYE
         2laFTjMboRhiJpON4FOkEdXKV46wTHBRcFPyz6pTYb1tO5fDl5gpb//g2YtQpc1neQ1C
         YvrsXZBgxkf18MOZjH6xNU4w5PqU7oGZUi+CzdcghE4GRX5exH8pSEj9IFMMAcFaAsTm
         9rvmzUx8h+Kn+LOEmsUvAXrQi7NJeVrNfWTomDCwb4a9meTO4CplzPpATDIVoUBQu+BZ
         yL9w==
X-Gm-Message-State: APjAAAWmEzXU3yIkVcxQmCrydqrQANepmB5G12wrpI+1Fszz73cZk9Bz
        60g6MjN6g6XLTUL4xwklLpbTeI7C2ts=
X-Google-Smtp-Source: APXvYqxmMLK4yAwkRyHUj4z4etuKrDZSU3z5U28h9xpORmb+jMBe9DcG+qLXDSD6rBFWan4E9erWow==
X-Received: by 2002:a05:651c:1032:: with SMTP id w18mr4214785ljm.61.1576114894147;
        Wed, 11 Dec 2019 17:41:34 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id v26sm2062983lfq.73.2019.12.11.17.41.32
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 17:41:33 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id m6so370582ljc.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2019 17:41:32 -0800 (PST)
X-Received: by 2002:a2e:9ad8:: with SMTP id p24mr4229397ljj.148.1576114892571;
 Wed, 11 Dec 2019 17:41:32 -0800 (PST)
MIME-Version: 1.0
References: <20191211152943.2933-1-axboe@kernel.dk> <CAHk-=wjz3LE1kznro1dozhk9i9Dr4pCnkj7Fuccn2xdWeGHawQ@mail.gmail.com>
 <d0adcde2-3106-4fea-c047-4d17111bab70@kernel.dk> <e43a2700-8625-e136-dc9d-d0d2da5d96ac@kernel.dk>
 <CAHk-=wje8i3DVcO=fMC4tzKTS5+eHv0anrVZa_JENQt08T=qCQ@mail.gmail.com>
 <0d4e3954-c467-30a7-5a8e-7c4180275533@kernel.dk> <CAHk-=whk4bcVPvtAv5OmHiW5z6AXgCLFhO4YrXD7o0XC+K-aHw@mail.gmail.com>
 <fef996ca-a4ed-9633-1f79-91292a984a20@kernel.dk> <CAHk-=wg=hHUFg3i0vDmKEg8HFbEKquAsoC8CJoZpP-8_A1jZDA@mail.gmail.com>
 <1c93194a-ed91-c3aa-deb5-a3394805defb@kernel.dk> <CAHk-=wj0pXsngjWKw5p3oTvwkNnT2DyoZWqPB+-wBY+BGTQ96w@mail.gmail.com>
 <d8a8ea42-7f76-926c-ae9a-d49b11578153@kernel.dk>
In-Reply-To: <d8a8ea42-7f76-926c-ae9a-d49b11578153@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 11 Dec 2019 17:41:16 -0800
X-Gmail-Original-Message-ID: <CAHk-=whtf0-f5wCcSAj=oTK2TEaesF43UdHnPyvgE9X1EuwvBw@mail.gmail.com>
Message-ID: <CAHk-=whtf0-f5wCcSAj=oTK2TEaesF43UdHnPyvgE9X1EuwvBw@mail.gmail.com>
Subject: Re: [PATCHSET v3 0/5] Support for RWF_UNCACHED
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@fb.com>,
        Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 11, 2019 at 5:29 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> I'd very much argue that it IS a bug, maybe just doesn't show on your
> system.

Oh, I agree. But I also understand why people hadn't noticed, and I
don't think it's all that critical - because if you do 1M iops cached,
you're doing something really really strange.

I too can see xas_create using 30% CPU time, but that's when I do a
perf record on just kswapd - and when I actually look at it on a
system level, it looks nowhere near that bad.

So I think people should look at this. Part of it might be for Willy:
does that xas_create() need to be that expensive? I hate how "perf"
callchains work, but it does look like it is probably
page_cache_delete -> xas_store -> xas_create that is the bulk of the
cost there.

Replacing the real page with the shadow entry shouldn't be that big of
a deal, I would really hope.

Willy, that used to be a __radix_tree_lookup -> __radix_tree_replace
thing, is there perhaps some simple optmization that could be done on
the XArray case here?

                Linus
