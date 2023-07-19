Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD1975A2B3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jul 2023 01:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjGSXU4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jul 2023 19:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjGSXUy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jul 2023 19:20:54 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE2419A1
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jul 2023 16:20:53 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4faaaa476a9so240633e87.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jul 2023 16:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1689808851; x=1692400851;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fXADNzZ3eBsdw+cIUAh9/E7CHKbroOI07B9bl0Cc/y4=;
        b=R0RiCWp9xgiCHGbGQhulpuYYLaFv/6Y/Uf9Do58rXt+8egGWjeDMmb7M0z0x9Hu1Gd
         eoRDEE+sLmpn877NWU3gafXvLVBe+RP0iwjXEBC0t+ZZpnxSNwu7NTMRUpd+4fxN+NN5
         gqDGJfWEfb68nww8V8Mj6MXOoFhEfkGh5VZ/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689808851; x=1692400851;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fXADNzZ3eBsdw+cIUAh9/E7CHKbroOI07B9bl0Cc/y4=;
        b=hEjGRwbhah4iki9MCBFa/t4kPZEE3a/H+cdd2CNJ2daT7Vd3tI3XPT07IYidkfx/5g
         X50H4F4COwmVowto2htn5X/bRtKBSD38MuuAGRrM6aTWFfWIM8+5Y1+M/srfQBGUpiXI
         7L58FuNAHnwjdDhYvqpA6ch+hxH5ObDazNW8fzc6fZlKAVXQFtMdn3dzds+yOfNX3WUg
         PvrcVuZ41f4/O/R6CE37Roz/jWt+rtfdvULZb559b1btTYNy89O6zp0lTmki6bismA+k
         NHTF6c84Jb6Wmk3S3P8ZI1Vo4c2TXyBdIalJOFSNLMI4EKst3FtHQSpJQBDSRmNcBxyv
         /urA==
X-Gm-Message-State: ABy/qLbLJ95rYNay7uw//X/EOqYg2gdfJy86Y2wO9TUylWGucC8iS3O8
        7Jw82YTyC7DMcVbi4IniAPAMzf3NekXzi9jL6k7agUR9
X-Google-Smtp-Source: APBJJlH51Tp3tZxMhxb4eajq8uEw/RHnM6N28jPjeEc+0wq9R5JqDUR0OJ+Aq+UTqRhpD9qEWG2CPA==
X-Received: by 2002:a2e:6e17:0:b0:2b6:d4f7:b7fa with SMTP id j23-20020a2e6e17000000b002b6d4f7b7famr516488ljc.5.1689808851170;
        Wed, 19 Jul 2023 16:20:51 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id ks20-20020a170906f85400b009929c09abdfsm2982133ejb.70.2023.07.19.16.20.50
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 16:20:50 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-51e566b1774so133425a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jul 2023 16:20:50 -0700 (PDT)
X-Received: by 2002:aa7:d4da:0:b0:521:6d39:7e45 with SMTP id
 t26-20020aa7d4da000000b005216d397e45mr536050edr.31.1689808849578; Wed, 19 Jul
 2023 16:20:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230629155433.4170837-1-dhowells@redhat.com> <20230629155433.4170837-2-dhowells@redhat.com>
 <CAJfpegsJuvXJDcXpo9T19Gw0tDuvyOJdv44Y2bt04MEf1JLxGg@mail.gmail.com>
 <c634a18e-9f2b-4746-bd8f-aa1d41e6ddf7@mattwhitlock.name> <CAJfpegvq4M_Go7fHiWVBBkrK6h4ChLqQTd0+EOKbRWZDcVerWA@mail.gmail.com>
 <ZLg9HbhOVnLk1ogA@casper.infradead.org> <CAHk-=wiq95bWiWLyz96ombPfpy=PNrc2KKyzJ2d+WMrxi6=OVA@mail.gmail.com>
 <6609f1b8-3264-4017-ac3c-84a01ea12690@mattwhitlock.name>
In-Reply-To: <6609f1b8-3264-4017-ac3c-84a01ea12690@mattwhitlock.name>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 19 Jul 2023 16:20:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh7OY=7ocTFY8styG8GgQ1coWxds=b09acHZG4t36OxWg@mail.gmail.com>
Message-ID: <CAHk-=wh7OY=7ocTFY8styG8GgQ1coWxds=b09acHZG4t36OxWg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] splice: Fix corruption of spliced data after
 splice() returns
To:     Matt Whitlock <kernel@mattwhitlock.name>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>, netdev@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>,
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@kvack.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 19 Jul 2023 at 14:02, Matt Whitlock <kernel@mattwhitlock.name> wrote:
>
> On Wednesday, 19 July 2023 16:16:07 EDT, Linus Torvalds wrote:
> > The *ONLY* reason for splice() existing is for zero-copy.
>
> The very first sentence of splice(2) reads: "splice() moves data between
> two file descriptors without copying between kernel address space and user
> address space." Thus, it is not unreasonable to believe that the point of
> splice is to avoid copying between user-space and kernel-space.

I'm not at all opposed to clarifying the documentation.

But I *am* very much against changing existing semantics. People rely
on it. The networking layer knows about it. The whole design is all
around "copy by reference".

And changing existing semantics would not only slow things down, it
wouldn't even *fix* anything that got this wrong. They'd still be
broken on old kernels.

When documentation and reality collide, documentation loses. That's
how this works.

> If you use read() and write(), then you're making two copies. If you use
> splice(), then you're making one copy (or zero, but that's an optimization
> that should be invisible to the user).

No. It really isn't.

It is an optimization that is INHERENT IN THE INTERFACE and has been
there literally since day #1. It was *never* invisible. It was the
*point*.

You getting this use case wrong is not an excuse to change reality. It
is, at most, a good reason to clarify the documentation.

The "without copying between kernel address space and user address
space" is about the ability to not copy AT ALL, and yes, let's by all
means clarify that part.

Really. If you cannot understand this fact, and the fact that you
simply misunderstood how splice() worked, I can't really help you
about that.

I repeat: if you want a stable copy of some file data, you *have* to
copy the file data. There's no magic. There's no difference between
"copy to user space" or "copy in kernel space". So you had better just
use "read()".

If you want to avoid the copy, you use one of the interfaces that are
about references to the data. splice() is not the only such interface.
mmap() acts the same way (on input).

You really should see splice() into a pipe as a way to 'mmap the data
without allocating user space backing store".

Of course, splice() *out* of a pipe is different too. It's the same
system call, but "splice into pipe" and "splice out of pipe" are
actually very different animals.

So splicing into a pipe is kind of like a small temporary mmap without
the TLB flush or VM allocation overhead.

But splicing out of the pipe is more akin to "map this buffer into
your own buffers as long as you don't modify it", so it basically say
"you can take just a reference to this page" (complexity addition:
SPLICE_F_GIFT and buffer stealing).

And all of this is literally designed to be able to do zero-copy from
multiple sources to multiple destinations. Not "sendpage()", which
could only do file->network, but a more generic ability like having
data that is sourced from (say) a TV capture card, and is transferred
to the network or maybe to another accelerator for encoding.

That's why the "pipe" part exists. It's the buffer in between
arbitrary end points. It's the replacement for a user buffer. But it's
also literally designed to be all about copy-by-reference.

Really.

So stop arguing. You misused splice(), because you didn't understand
it, and you got burnt. You don't like that. I get it. But that doesn't
make splice() wrong. That only made your use of it buggy.

So splice() is for zero-copy. It expects that you either stabilized
the data somehow (maybe those files are never modified, or maybe you
have other synchronization) or that you simply don't care whether it's
stable, and if the file changes, maybe the data you send changed too.

If you want "one-copy", what you can do is:

 - mmap() the file data (zero copy, not stable yet)

 - use "write()" to write the data to the network. This will copy it
to the skbs before the write() call returns and that copy makes it
stable.

Alternatively, if you want to be more than a bit odd, you _can_ do the
zero-copy on the write side, by doing

 - read the file data (one copy, now it's stable)

 - vmsplice() to the kernel buffer (zero copy)

 - splice() to the network (zero copy at least for the good cases)

and now you just need to make sure that you don't re-use the user
buffer until the network data has actually been sent. Which makes this
second alternative much more complicated than the first one, and I'm
absolutely not recommending it, but I'm mentioning it as a
possibility.

Honestly, the read/vmsplice/splice model is kind of crazy, but there
might be real reasons to do it that odd way, and the buffer handling
in user space is manageable (you might, for example, just decide to
"munmap()" the buffer after sending it out).

For an example of "why would you ever do that", you might have content
conversion issues between the read/vmsplice, or need to generate a
checksum on the stable data or whatever. So it's a *valid* use of
splice(), but it's certainly a bit odd.

              Linus
