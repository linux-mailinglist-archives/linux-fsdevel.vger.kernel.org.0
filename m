Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22D7C440D77
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Oct 2021 08:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbhJaHwO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 31 Oct 2021 03:52:14 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:57890 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229638AbhJaHwN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 31 Oct 2021 03:52:13 -0400
X-Greylist: delayed 619 seconds by postgrey-1.27 at vger.kernel.org; Sun, 31 Oct 2021 03:52:13 EDT
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 446A01F953;
        Sun, 31 Oct 2021 07:39:23 +0000 (UTC)
Date:   Sun, 31 Oct 2021 07:39:23 +0000
From:   Eric Wong <e@80x24.org>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        willy@infradead.org, arnd@kernel.org,
        Willem de Bruijn <willemb@google.com>
Subject: Re: epoll may leak events on dup
Message-ID: <20211031073923.M174137@dcvr>
References: <20211030100319.GA11526@ircssh-3.c.rugged-nimbus-611.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211030100319.GA11526@ircssh-3.c.rugged-nimbus-611.internal>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Sargun Dhillon <sargun@sargun.me> wrote:
> I discovered an interesting behaviour in epoll today. If I register the same 
> file twice, under two different file descriptor numbers, and then I close one of 
> the two file descriptors, epoll "leaks" the first event. This is fine, because 
> one would think I could just go ahead and remove the event, but alas, that isn't 
> the case. Some example python code follows to show the issue at hand.
>
> I'm not sure if this is really considered a "bug" or just "interesting epoll
> behaviour", but in my opinion this is kind of a bug, especially because leaks
> may happen by accident -- especially if files are not immediately freed.

"Interesting epoll behavior" combined with a quirk with the
Python wrapper for epoll.  It passes the FD as epoll_event.data
(.data could also be any void *ptr, a u64, or u32).

Not knowing Python myself (but knowing Ruby and Perl5 well); I
assume Python developers chose the safest route in passing an
integer FD for .data.  Passing a pointer to an arbitrary
Perl/Ruby object would cause tricky lifetime issues with the
automatic memory management of those languages; I expect Python
would have the same problem.

> I'm also not sure why epoll events are registered by file, and not just fd.
> Is the expectation that you can share a single epoll amongst multiple
> "users" and register different files that have the same file descriptor

No, the other way around.  Different FDs for the same file.

Having registration keyed by [file+fd] allows users to pass
different pointers for different events to the same file;
which could have its uses.

Registering by FD alone isn't enough; since the epoll FD itself
can be shared across fork (which is of limited usefulness[1]).
Originaly iterations of epoll were keyed only by the file;
with the FD being added later.

> number (at least for purposes other than CRIU). Maybe someone can shed
> light on the behaviour.

CRIU?  Checkpoint/Restore In Userspace?


[1] In contrast, kqueue has a unique close-on-fork behavior
    which greatly simplifies usage from C code (but less so
    for high-level runtimes which auto-close FDs).
