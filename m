Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41944F527D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2019 18:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbfKHRWy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Nov 2019 12:22:54 -0500
Received: from mail-il1-f172.google.com ([209.85.166.172]:45849 "EHLO
        mail-il1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfKHRWy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Nov 2019 12:22:54 -0500
Received: by mail-il1-f172.google.com with SMTP id o18so5782995ils.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Nov 2019 09:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kCFuBzX0ssMEDdf5FEm7iYvhAqHfXgR1VUvfj9lOe/w=;
        b=CEfiZj/bsHwWAjk9E2+anUgIMAxbVSUOX+XJF2bZ0OcF0BZenHgQ0u67RQKxsSJVvO
         cg6auRE4K1Dd46AV9IDjw+fBDqbhIOvgtZ+xWLJSCCu7ESdlYcccDwf50l/5fKpJ98SU
         qu2KR81c1yXgqEMCFodWqnFqZnWA1GSDihhSmrcE97ct41ooi829D6bwXP4yixBHxOPR
         82Q1s9H/qJ44YK+ZDn1u9LMEaIEj2yNDLFqsg5PTSK9is2D2nmxrN7ZlqJUqvN89jCDH
         Z6dtGmWJoisrj5v4yiRnDtrVjKHAtkPbjKMzgkdxrde76DY/9Tx2bxjqD4hsArlMj+q+
         6A3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kCFuBzX0ssMEDdf5FEm7iYvhAqHfXgR1VUvfj9lOe/w=;
        b=nZAixp0lvGmHoS7QBLKqfwygaM091NyNkD5bWb2kIT/ftgXU8l+ZNrfcEAl2v2bGjH
         C5xDl4sQM3e0lMXUiMKQ0DPPubSi+EWFevpqcEJ5tkVqAn4WHbH4eZ1xGMBUqA5v7Lge
         bpDx7aUtEUX23eJGE520cVJDv7tlhN3H093ozd6jyXgaI3smw6jjekP2B6QV1LDxjGnH
         NPEbsSrOTaKUdd4buwf9hSHTy7qYy9zqd4QI3tOawhYPpLvlFZ4JzuV09vbwRMJdrSSr
         MfWJ0t5rlwnXSjALNoYjjT5rad68zzFXWaZXGgRcY+AnAYRu8mogXWikenXKFndfsMqQ
         WD2A==
X-Gm-Message-State: APjAAAWq5kYRLyXAzq95uFfQJPMPI9o+8Nz4ZGfSdAE8delSJk4lAYR4
        bNtOzzB0YhfLjV31HnZCTq2fxIUUcsttKFSL8KNcLA==
X-Google-Smtp-Source: APXvYqzUhTWVQWwZl8pu4w3UpG3z5Kvyp3soCrK0nJh9KxmLxN13e63bMlw9t1jl9c/rHz3FMSCFcELVM2qH6Nh1RWI=
X-Received: by 2002:a92:7e0d:: with SMTP id z13mr14651612ilc.168.1573233772737;
 Fri, 08 Nov 2019 09:22:52 -0800 (PST)
MIME-Version: 1.0
References: <000000000000c422a80596d595ee@google.com> <6bddae34-93df-6820-0390-ac18dcbf0927@gmail.com>
 <CAHk-=whh5bcxCecEL5Fy4XvQjgBTJ9uqvyp7dW=CLU6VNxS9iA@mail.gmail.com>
In-Reply-To: <CAHk-=whh5bcxCecEL5Fy4XvQjgBTJ9uqvyp7dW=CLU6VNxS9iA@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 8 Nov 2019 09:22:41 -0800
Message-ID: <CANn89iK9mTJ4BN-X3MeSx5LGXGYafXkhZyaUpdXDjVivTwA6Jg@mail.gmail.com>
Subject: Re: KCSAN: data-race in __alloc_file / __alloc_file
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzbot+3ef049d50587836c0606@syzkaller.appspotmail.com>,
        Marco Elver <elver@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 8, 2019 at 9:01 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Nov 8, 2019 at 5:28 AM Eric Dumazet <eric.dumazet@gmail.com> wrote:
> >
> > Linus, what do you think of the following fix ?
>
> I think it's incredibly ugly.
>
> I realize that avoiding the cacheline dirtying might be worth it, but
> I'd like to see some indication that it actually matters and helps
> from a performance angle. We've already dirtied memory fairly close,
> even if it might not share a cacheline (that structure is randomized,
> we've touched - or will touch - 'cred->usage') too.
>
> Honestly, I don't think get_cred() is even in a hotpath. Most cred use
> just use the current cred that doesn't need the 'get'. So the
> optimization looks somewhat questionable - for all we know it just
> makes things worse.
>
> I also don't like using a "WRITE_ONCE()" without a reason for it. In
> this case, the only "reason" is that KCSAN special-cases that thing.
> I'd much rather have some other way to mark it.
>
> So it just looks hacky to me.
>
> I like that people are looking at KCSAN, but I get a very strong
> feeling that right now the workarounds for KCSAN false-positives are
> incredibly ugly, and not always appropriate.
>
> There is absolutely zero need for a WRITE_ONCE() in this case. The
> code would work fine if the compiler did the zero write fifty times,
> and re-ordered it wildly. We have a flag that starts out set, and we
> clear it.  There's really no "write-once" about it.
>

Ok, so what do you suggest next ?

Declare KCSAN useless because too many false positives ?
