Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 183451EC617
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jun 2020 02:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbgFCAIp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Jun 2020 20:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728304AbgFCAIo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Jun 2020 20:08:44 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643D2C08C5C1
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jun 2020 17:08:43 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id c11so481316ljn.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Jun 2020 17:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PazKvjjbmAQeUYiZad4yyf2QZKpFBXiEaJOc1KsToFM=;
        b=cxQ3fmuQWsQSr6abyNc9/tsWVhRgX+CIskaA0+9tWleBkBxH+nD83NbhOrLA4+l62q
         IHd7DWRbt8QX/EQhJmNdBB/KVbcm3z19PVF4njNDsJ2EVCzILIGOTxNV+HKYvlu2vYC2
         U0ZUjz234y+0uLMwggsMalqWy5B+hZTC5aMVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PazKvjjbmAQeUYiZad4yyf2QZKpFBXiEaJOc1KsToFM=;
        b=uNxf105dyqXu7/R8j9hmy0ruACem7qjeQjyQCcXhulGMr1I/nDibOUoMONNtc02+hH
         1QJjy8rKyNQBxIksUDBOyy0uEcCy4ohgyRjjWcJ0saJ6eprkNiQDzW3pIoZCtKOE5sPj
         7cV1/8+cYKn9BpP77sawdCHTKKERY+xttA+rRsuD/ZRK3DAYjSu6+cKHvSR3VALHMMaf
         Hamisw+4cheC2ChYmMA0xJfhtRlX0bR4/40bYLzpMT52ONpB6YeBoNhRjh30fc0tUugw
         4FG0jun0m9BGkR7If1EZTMdHJGsRpo7RIS+iU2OlpB8hpdGXcSbRpokX5YglkTDTwVfM
         Tk/Q==
X-Gm-Message-State: AOAM530XkFJuDaKCRiedhocG9PAHCQwmf43mcBR67EdRGGdPswwkzk1M
        oIQTk9CVImc+6aO1Fkgw2/0bGBCZ1ws=
X-Google-Smtp-Source: ABdhPJwOfgJ25IDkZSUOqdNRK/fX3TjiZetMtX/tuFqqxIUWDZQZD27PmAvDHnwcUiR0UyjBXOG4tw==
X-Received: by 2002:a2e:8e25:: with SMTP id r5mr666127ljk.455.1591142920981;
        Tue, 02 Jun 2020 17:08:40 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id i24sm83627ljg.82.2020.06.02.17.08.39
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2020 17:08:40 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id x27so150124lfg.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Jun 2020 17:08:39 -0700 (PDT)
X-Received: by 2002:ac2:5a4c:: with SMTP id r12mr947879lfn.10.1591142919097;
 Tue, 02 Jun 2020 17:08:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200602204219.186620-1-christian.brauner@ubuntu.com>
 <CAHk-=wjy234P7tvpQb6bnd1rhO78Uc+B0g1CPg9VOhJNTxmtWw@mail.gmail.com> <20200602233355.zdwcfow3ff4o2dol@wittgenstein>
In-Reply-To: <20200602233355.zdwcfow3ff4o2dol@wittgenstein>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 2 Jun 2020 17:08:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wimp3tNuMcix2Z3uCF0sFfQt5GhVku=yhJAmSALucYGjg@mail.gmail.com>
Message-ID: <CAHk-=wimp3tNuMcix2Z3uCF0sFfQt5GhVku=yhJAmSALucYGjg@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] close_range()
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kyle Evans <self@kyle-evans.net>,
        Victor Stinner <victor.stinner@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>,
        David Howells <dhowells@redhat.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 2, 2020 at 4:33 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
> >
> > And maybe this _did_ get mentioned last time, and I just don't find
> > it. I also don't see anything like that in the patches, although the
> > flags argument is there.
>
> I spent some good time digging and I couldn't find this mentioned
> anywhere so maybe it just never got sent to the list?

It's entirely possible that it was just a private musing, and you
re-opening this issue just resurrected the thought.

I'm not sure how simple it would be to implement, but looking at it it
shouldn't be problematic to add a "max_fd" argument to unshare_fd()
and dup_fd().

Although the range for unsharing is obviously reversed, so I'd suggest
not trying to make "dup_fd()" take the exact range into account.

More like just making __close_range() do basically something like

        rcu_read_lock();
        cur_max = files_fdtable(files)->max_fds;
        rcu_read_unlock();

        if (flags & CLOSE_RANGE_UNSHARE) {
                unsigned int max_unshare_fd = ~0u;
                if (cur_max >= max_fd)
                        max_unshare_fd = fd;
                unshare_fd(max_unsgare_fd);
        }

        .. do the rest of __close_range() here ..

and all that "max_unsgare_fd" would do would be to limit the top end
of the file descriptor table unsharing: we'd still do the exact range
handling in __close_range() itself.

Because teaching unshare_fd() and dup_fd() about anything more complex
than the above doesn't sound worth it, but adding a way to just avoid
the unnecessary copy of any high file descriptors sounds simple
enough.

But I haven't thought deeply about this. I might have missed something.

            Linus
