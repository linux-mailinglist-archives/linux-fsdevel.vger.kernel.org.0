Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12C2AED105
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Nov 2019 00:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbfKBXPA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 2 Nov 2019 19:15:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:42872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727320AbfKBXO7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 2 Nov 2019 19:14:59 -0400
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82BD521A49
        for <linux-fsdevel@vger.kernel.org>; Sat,  2 Nov 2019 23:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572736498;
        bh=REB5//Mg+2UUv5NMyr1MVdv8ocwrgYZM1pxYX5vl4iA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=M+eT3FUF2jmJ2jN5PXXRGK/Qoi8ZaXjyPmPt7vGC/lPRcyHAo5BCeJPPl7GT3D2vH
         NREFz1CxaWKh03aYRPcbilVCC8pb01tix6xuZj4C6avNOQWC+IPC73Ws8tLGiGWf+O
         me6ANt3XpP/7rESPToHqJsbo7vFYVaL+XK229Yrk=
Received: by mail-wr1-f44.google.com with SMTP id e6so11281111wrw.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 02 Nov 2019 16:14:58 -0700 (PDT)
X-Gm-Message-State: APjAAAWREUiYoz6O7XNshWmLQUj48hqdm4pL6eTlXuZqSr1+cCs1FIGZ
        I6urs153zX8HHtHt9KyEPi3XhJfIF8EB7UAVWiB73w==
X-Google-Smtp-Source: APXvYqwiaT/TYsPpvX/nSDbageOpVx9vUfoOUY5rzyPCC92h+QcJ3qEjOCN+6nwzv7Sif3nKLVFkueWLU7OXFbCI5Iw=
X-Received: by 2002:adf:f7d1:: with SMTP id a17mr16289603wrq.111.1572736496889;
 Sat, 02 Nov 2019 16:14:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wj1BLz6s9cG9Ptk4ULxrTy=MkF7ZH=HF67d7M5HL1fd_A@mail.gmail.com>
 <E590C3AF-1D09-4927-B83F-DD0A6A148B6D@amacapital.net> <CAHk-=wgzRU9RjkZG0L9_yrnFN69REkrSokTQOGZMUkvdispvuQ@mail.gmail.com>
 <CAHk-=wgPQutQ8d8kUCvAFi+hfNWgaNLiZPkbg-GXY2DCtD-Z5Q@mail.gmail.com>
In-Reply-To: <CAHk-=wgPQutQ8d8kUCvAFi+hfNWgaNLiZPkbg-GXY2DCtD-Z5Q@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 2 Nov 2019 16:14:45 -0700
X-Gmail-Original-Message-ID: <CALCETrWZjW88OY2mh7v8cUU_6XTSJTkQhAfNbSC17AdhEWwVAA@mail.gmail.com>
Message-ID: <CALCETrWZjW88OY2mh7v8cUU_6XTSJTkQhAfNbSC17AdhEWwVAA@mail.gmail.com>
Subject: Re: [RFC PATCH 11/10] pipe: Add fsync() support [ver #2]
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, USB list <linux-usb@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Nov 2, 2019 at 4:10 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sat, Nov 2, 2019 at 4:02 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > But I don't think anybody actually _did_ any of that. But that's
> > basically the argument for the three splice operations:
> > write/vmsplice/splice(). Which one you use depends on the lifetime and
> > the source of your data. write() is obviously for the copy case (the
> > source data might not be stable), while splice() is for the "data from
> > another source", and vmsplace() is "data is from stable data in my
> > vm".
>
> Btw, it's really worth noting that "splice()" and friends are from a
> more happy-go-lucky time when we were experimenting with new
> interfaces, and in a day and age when people thought that interfaces
> like "sendpage()" and zero-copy and playing games with the VM was a
> great thing to do.

I suppose a nicer interface might be:


madvise(buf, len, MADV_STABILIZE);

(MADV_STABILIZE is an imaginary operation that write protects the
memory a la fork() but without the copying part.)

vmsplice_safer(fd, ...);

Where vmsplice_safer() is like vmsplice, except that it only works on
write-protected pages.  If you vmsplice_safer() some memory and then
write to the memory, the pipe keeps the old copy.

But this can all be done with memfd and splice, too, I think.


>
> It turns out that VM games are almost always more expensive than just
> copying the data in the first place, but hey, people didn't know that,
> and zero-copy was seen a big deal.
>
> The reality is that almost nobody uses splice and vmsplice at all, and
> they have been a much bigger headache than they are worth. If I could
> go back in time and not do them, I would. But there have been a few
> very special uses that seem to actually like the interfaces.
>
> But it's entirely possible that we should kill vmsplice() (likely by
> just implementing the semantics as "write()") because it's not common
> enough to have the complexity.

I think this is the right choice.

FWIW, the openssl vmsplice() call looks dubious, but I suspect it's
okay because it's vmsplicing to a netlink socket, and the kernel code
on the other end won't read the data after it returns a response.

--Andy
