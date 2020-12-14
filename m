Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB45F2D9174
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Dec 2020 01:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436911AbgLNAql (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Dec 2020 19:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgLNAqk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Dec 2020 19:46:40 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558F1C0613CF
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Dec 2020 16:46:00 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id y19so25889926lfa.13
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Dec 2020 16:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pZS4MgC4T9L3WbXrJzaLk8jAjyt7H8F4M/fTsd/U0J8=;
        b=JZAx5eHo5W+FGHX22LprJWy/oTPqq1yDS8+K7VYDnml4GZfLUDAxV1AHNqiZ7qAqDu
         S5Jmsldo9v9rO1roqtqBnaW5vuZMmqsb8BSNoA8p0pY8BJSyBeEeXqMI0FvlXTdA174f
         mm3dsfHYMRbjWr3Ic0jK0gBystXiyDGgTWmCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pZS4MgC4T9L3WbXrJzaLk8jAjyt7H8F4M/fTsd/U0J8=;
        b=DbQQDN/IfZL4JpS6l63LuWse2Hq43mCHD86SHbVfuv0o8JYtRk6y3OHUbDe3q5UEPc
         ofPACdan7XDs+IBVkY5fWjTskXoVXg4j3JeLDMkunpEG4cZqQqbTNhfnPgAZDGKQMW0d
         dhF4940udB4ENDFXzbWEILPgqo7y0BXayJsDgEbk4bwkAEDlWUqA0g2FwZrWDnah22qi
         m9dp6+iMjR6CCuzd0Be4LXoQlSulA9bgtMXhT08Y6g9tPypHaiFlbmNftpCNRVlt4HCg
         GeS1xc2VCDr5bYBCqp+q8RcALRNcnyrdBEqD3YtTRgIhOHXkfKs1OrHjD9692Q60pOnh
         BWmQ==
X-Gm-Message-State: AOAM530o7HtkvYmXFXAam8i09KC/jw19v1sJCI7scCCuiKNf70wk1Zv9
        0MTbwS0cFOLdR+8xSG2iZfJFoBcnsb2+8Q==
X-Google-Smtp-Source: ABdhPJyWgXrCBxp/1V3CVznsEebXtliy0/I+pCpGYtalqCKtSRTALqvgcXYjERr4LaqvPX75b0ye8g==
X-Received: by 2002:a19:6f0f:: with SMTP id k15mr8093408lfc.68.1607906756968;
        Sun, 13 Dec 2020 16:45:56 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id h8sm290080lfj.116.2020.12.13.16.45.55
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Dec 2020 16:45:55 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id o19so302665lfo.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Dec 2020 16:45:55 -0800 (PST)
X-Received: by 2002:a2e:9d89:: with SMTP id c9mr10010697ljj.220.1607906754932;
 Sun, 13 Dec 2020 16:45:54 -0800 (PST)
MIME-Version: 1.0
References: <20201212165105.902688-1-axboe@kernel.dk> <20201212165105.902688-5-axboe@kernel.dk>
 <CAHk-=wiA1+MuCLM0jRrY4ajA0wk3bs44n-iskZDv_zXmouk_EA@mail.gmail.com>
 <8c4e7013-2929-82ed-06f6-020a19b4fb3d@kernel.dk> <20201213225022.GF3913616@dread.disaster.area>
In-Reply-To: <20201213225022.GF3913616@dread.disaster.area>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 13 Dec 2020 16:45:39 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg5AXnXE3bjqj0fgH2os1ptKeF-ee6i0p5GCw1o63EdgQ@mail.gmail.com>
Message-ID: <CAHk-=wg5AXnXE3bjqj0fgH2os1ptKeF-ee6i0p5GCw1o63EdgQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] fs: honor LOOKUP_NONBLOCK for the last part of file open
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Dec 13, 2020 at 2:50 PM Dave Chinner <david@fromorbit.com> wrote:
> > >
> > > Only O_CREAT | O_TRUNC should matter, since those are the ones that
> > > cause writes as part of the *open*.
>
> And __O_TMPFILE, which is the same as O_CREAT.

This made me go look at the code, but we seem to be ok here -
__O_TMPFILE should never get to the do_open() logic at all, because it
gets caught before that and does off to do_tmpfile() and then
vfs_tmpfile() instead.

And then it's up to the filesystem to do the inode locking if it needs
to - it has a separate i_io->tempfile function for that.

From a LOOKUP_NONBLOCK standpoint, I think we should just disallow
O_TMPFILE the same way Jens disallowed O_TRUNCATE.

Otherwise we'd have to teach filesystems about it.

Which might be an option long-term of course, but I don't think it
makes sense for any initial patch-set: the real "we can do this with
no locks and quickly" case is just opening an existing file entirely
using the dcache.

Creating new files isn't exactly _uncommon_, of course, but it's
probably still two orders of magnitude less common than just opening
an existing file. Wild handwaving.

So I suspect O_CREAT simply isn't really interesting either. Sure, the
"it already exists" case could potentially be done without any locking
or anything like that, but again, I don't think that case is worth
optimizing for: O_CREAT probably just isn't common enough.

[ I don't have tons of hard data to back that handwaving argument
based on my gut feel up, but I did do a trace of a kernel build just
because that's my "default load" and out of 250 thousand openat()
calls, only 560 had O_CREAT and/or O_TRUNC. But while that's _my_
default load, it's obviously not necessarily very representative of
anything else. The "almost three orders of magnitude more regular
opens" doesn't _surprise_ me though ]

So I really think the right model is not to worry about trylock for
the inode lock at all, but to simply just always fail with EAGAIN in
that case - and not do LOOKUP_NONBLOCK for O_CREAT at all.

The normal fast-path case in open_last_lookups() is the "goto
finish_lookup" case in this sequence:

        if (!(open_flag & O_CREAT)) {
                if (nd->last.name[nd->last.len])
                        nd->flags |= LOOKUP_FOLLOW | LOOKUP_DIRECTORY;
                /* we _can_ be in RCU mode here */
                dentry = lookup_fast(nd, &inode, &seq);
                if (IS_ERR(dentry))
                        return ERR_CAST(dentry);
                if (likely(dentry))
                        goto finish_lookup;

and we never get to the inode locking sequence at all.

So just adding a

        if (nd->flags & LOOKUP_NONBLOCK)
                return -EAGAIN;

there is probably the right thing - rather than worry about trylock on
the inode lock.

Because if you've missed in the dcache, you've by definition lost the fast-path.

That said, numbers talk, BS walks, and maybe somebody has better loads
with better numbers. I assume Jens has some internal FB io_uring loads
and could do stats on what kinds of pathname opens matter there...

          Linus
