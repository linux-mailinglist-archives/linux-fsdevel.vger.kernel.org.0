Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1462D8985
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Dec 2020 20:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407830AbgLLS6o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Dec 2020 13:58:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407741AbgLLS6e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Dec 2020 13:58:34 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD785C061794
        for <linux-fsdevel@vger.kernel.org>; Sat, 12 Dec 2020 10:57:53 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id o17so17054914lfg.4
        for <linux-fsdevel@vger.kernel.org>; Sat, 12 Dec 2020 10:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IwYObM/w/NyNp/P/d7JsTbIC76iG7PDM+NXpsj5IZ0w=;
        b=e4bGcxBOD/vJz+dA7Bs1/PuJtBEVjld4onBgNoQWBEQ+LRzC/y0n9lxJDPUfhcz+JJ
         FKqYkdciTBmeQNzVm3tnzi8cFYjEOQsVv+XqzscR9n6e+2dW7P0oQW492b7reLoFApaw
         onT/DhmJUr21udmBUVl+pPDGfpANd2eMjc4vM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IwYObM/w/NyNp/P/d7JsTbIC76iG7PDM+NXpsj5IZ0w=;
        b=i3+wAoHSX/3qP+KnuEW8esLyns7a9QL7CX3aczRhHyV8yg7I10le73UHrHgDNhr70T
         MnaOHilfmvqsG+k8OupmHSRGrszC8dhB6jjs4r3xpZ9L34SWH20dWZ9BE9BoEANbtqxB
         HkIViPTr6sAzcxyMoc2FTI4QNywCxZXn3F8kqADWM5gUlIF3cClgq//Jt7IsZdk3ZlC8
         LSBqRbznriJ1Yu3QWHMRJMPRGHbrqeCWPKcEU3ZJt3Z68Q9oyvDrgQzTLPpUqZ8y0SkU
         P6vwW/6kV0yv8bspW5kw3/kP0rkQBs7gLGLjRQwfPA19k0EXs2FxOYOoERm+uP0m9L0B
         iAmA==
X-Gm-Message-State: AOAM531cbPBUdbgeXeNsHMNwih+XgYjghDQyxaXPIrvHDfC6r48XtGe/
        bJewCRwqFGKjPtfs/cZaY5BdcgOk8DAY7w==
X-Google-Smtp-Source: ABdhPJyr/yR+N3DboB3xl3lxcTuI4uq6tCP4PVe413eim21O9pOkngCte2hDcy5m5HSixiy7x1VJCQ==
X-Received: by 2002:a2e:924a:: with SMTP id v10mr3685970ljg.154.1607799471951;
        Sat, 12 Dec 2020 10:57:51 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id y124sm267239lff.104.2020.12.12.10.57.50
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Dec 2020 10:57:51 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id a12so19977630lfl.6
        for <linux-fsdevel@vger.kernel.org>; Sat, 12 Dec 2020 10:57:50 -0800 (PST)
X-Received: by 2002:a2e:3211:: with SMTP id y17mr888512ljy.61.1607799470509;
 Sat, 12 Dec 2020 10:57:50 -0800 (PST)
MIME-Version: 1.0
References: <20201212165105.902688-1-axboe@kernel.dk> <20201212165105.902688-5-axboe@kernel.dk>
In-Reply-To: <20201212165105.902688-5-axboe@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 12 Dec 2020 10:57:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiA1+MuCLM0jRrY4ajA0wk3bs44n-iskZDv_zXmouk_EA@mail.gmail.com>
Message-ID: <CAHk-=wiA1+MuCLM0jRrY4ajA0wk3bs44n-iskZDv_zXmouk_EA@mail.gmail.com>
Subject: Re: [PATCH 4/5] fs: honor LOOKUP_NONBLOCK for the last part of file open
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Dec 12, 2020 at 8:51 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> We handle it for the path resolution itself, but we should also factor
> it in for open_last_lookups() and tmpfile open.

So I think this one is fundamentally wrong, for two reasons.

One is that "nonblock" shouldn't necessarily mean "take no locks at
all". That directory inode lock is very very different from "go down
to the filesystem to do IO". No other NONBLOCK thing has ever been "no
locks at all", they have all been about possibly long-term blocking.

The other this is that the mnt_want_write() check really smells no
different at all from any of the "some ->open functions might block".
Which you don't handle, and which again is entirely different from the
pathname resolution itself blocking.

So I don't think either of these cases are about LOOKUP_NONBLOCK, the
same way they aren't about LOOKUP_RCU.

The  mnt_want_write() in particular is much more about the kinds of
things we already check for in do_open().

In fact, looking at this patch, I think mnt_want_write() itself is
actually conceptually buggy, although it doesn't really matter: think
about device nodes etc. Opening a device node for writing doesn't
write to the filesystem that the device node is on.

Why does that code care about O_WRONLY | O_RDWR? That has *nothing* to
do with the open() wanting to write to the filesystem. We don't even
hold that lock after the open - we'll always drop it even for a
successful open.

Only O_CREAT | O_TRUNC should matter, since those are the ones that
cause writes as part of the *open*.

Again - I don't think that this is really a problem. I mention it more
as a "this shows how the code is _conceptually_ wrong", and how it's
not really about the pathname resolution any more.

In fact, I think that how we pass on that "got_write" to lookup_open()
is just another sign of how we do that mnt_want_write() in the wrong
place and at trhe wrong level. We shouldn't have been doing that
mnt_want_write() for writable oipens (that's a different thing), and
looking at lookup_open(), I think we should have waited with doing it
at all until we've checked if we even need it (ie O_CREAT on a file
that already exists does *not* need the mnt_want_write() at all, and
we'll see that when we get to that

        /* Negative dentry, just create the file */
        if (!dentry->d_inode && (open_flag & O_CREAT)) {

thing.

So I think this patch actually shows that we do things wrong in this
area, and I think the kinds of things it does are questionable as a
result. In particular, I'm not convinced that the directory semaphore
thing should be tied to LOOKUP_NONBLOCK, and I don't think the
mnt_want_write() logic is right at all.

The first one would be fixed by a separate flag.

The second one I think is more about "we are doing mnt_want_write() at
the wrong point, and if we move mnt_want_write() to the right place
we'd just fail it explicitly for the LOOKUP_NONBLOCK case" - the same
way a truncate should just be an explicit fail, not a "trylock"
failure.

I also think we need to deal with the O_NONBLOCK kind of situation at
the actual ->open() time (ie the whole "oh, NFS wants to revalidate
caches due to open/close consistency, named pipes want to wait for
pairing, device nodes want to wait for device". Again, I think that's
separate from LOOKUP_NONBLOCK, though.

               Linus
