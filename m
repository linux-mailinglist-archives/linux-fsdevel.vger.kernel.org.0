Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3CF487C14
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jan 2022 19:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240410AbiAGSUv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jan 2022 13:20:51 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:39976 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240487AbiAGSUs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jan 2022 13:20:48 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9382D1F397;
        Fri,  7 Jan 2022 18:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1641579646; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B9BRI/ZexXhUtAahe0n7/++cF4caOz/WHaC0XK/LnNs=;
        b=X94G8KnzLVOiZI3QPpq0bWfwWvZd0j9lNIaaFrkcXD9D7BSezJYU0szM6+xg7W9Ca1upcr
        XF6LgOsc680vnL2RBbJR5pKCEWrhrzWw4sqXtY9UBpNlitObeaweUKbk06jPSpvK1AN/l9
        PpHoZl7AvZ24C2hwXCedQR2nchc1bLQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1641579646;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B9BRI/ZexXhUtAahe0n7/++cF4caOz/WHaC0XK/LnNs=;
        b=XkvwypxiOJwu9Ekxntx6l2wL413cInLMMPY+v0gNmAeMqvlsOrF9d8Q/J1Lq2Hpv6T8v9H
        1qTaSsoLq0RYjqAg==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9FB43A3B83;
        Fri,  7 Jan 2022 18:20:40 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id C7EB9A05D7; Fri,  7 Jan 2022 19:20:45 +0100 (CET)
Date:   Fri, 7 Jan 2022 19:20:45 +0100
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: Indefinitely sleeping task in poll_schedule_timeout()
Message-ID: <20220107182045.6laakeg2cfhelej5@quack3.lan>
References: <20220104124425.6t6iepgzoruuqpvo@quack3.lan>
 <CAHk-=wiWcMw4zNfkty06u6KQ4tp064BHwMVcJBUjLHSjFCU6-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiWcMw4zNfkty06u6KQ4tp064BHwMVcJBUjLHSjFCU6-w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 06-01-22 10:41:27, Linus Torvalds wrote:
> On Thu, Jan 6, 2022 at 7:45 AM Jan Kara <jack@suse.cz> wrote:
> >
> > So maybe something like attached patch (boot tested only so far)? What you
> > do think?
> 
> I don't think the patch is wrong, but it looks like we've actually
> never reacted to bad file descriptors, so I get the strong feeling
> that the patch might break existing code that has worked by accident
> before.

Well, max_select_fd() returns -EBADF in case some file descriptor is wrong.
But yes, once this initial test passes we didn't care about bad fd. So if
the timing used to work out so that fd was never closed before the
max_select_fd() check I agree my patch could break such app.

> And the breakage might end up very subtle - select() randomly now
> returning EBADFD if you have a race with somebody closing the fd that
> previously was benign and silent. Which is going to be hell to debug
> because it's some sporadic user-space race with close and select at
> the same time, and it might easily actually break user space because
> somebody just takes "error from select" to be fatal and asserts it.
> 
> What do_pollfd() does if there's no file associated with the fd is to
> use EPOLLNVAL (an actual negative fd is ignored):
> 
>         mask = EPOLLNVAL;
>         f = fdget(fd);
>         if (!f.file)
>                 goto out;
> 
> and I wonder if we should try something equivalent for select() as a
> slightly less drastic change.
> 
> Of course, select() doesn't actually have EPOLLNVAL, but it does have
> EPOLLERR and EPOLLPRI, which would set all the bits for that fd.
> 
> The patch would be something like this (NOTE NOTE NOTE: this is not
> only whitespace-damaged - it was done with "git diff -w" to not show
> the whitespace change. Look at how it changes the nesting of that "if
> (f.file)" thing, and it needs to change the indentation of all those
> subsequent if-statements that check the mask. I did it this way just
> to show the logic change, a real patch would be much bigger due to the
> whitespace change).
> 
>     diff --git a/fs/select.c b/fs/select.c
>     index 945896d0ac9e..d77f8a614ad4 100644
>     --- a/fs/select.c
>     +++ b/fs/select.c
>     @@ -528,12 +528,14 @@ static int do_select(int n, fd_set_bits *fds,
>                     if (!(bit & all_bits))
>                             continue;
>                     f = fdget(i);
>     +               mask = EPOLLERR | EPOLLPRI;
>                     if (f.file) {
>                             wait_key_set(wait, in, out, bit,
>                                          busy_flag);
>                             mask = vfs_poll(f.file, wait);
> 
>                             fdput(f);
>     +               }
>                     if ((mask & POLLIN_SET) && (in & bit)) {
>                             res_in |= bit;
>                             retval++;
>     @@ -560,8 +562,6 @@ static int do_select(int n, fd_set_bits *fds,
>                      */
>                     } else if (busy_flag & mask)
>                             can_busy_loop = true;
>     -
>     -               }
>             }
>             if (res_in)
>                     *rinp = res_in;
> 

OK, nice, I think this would work and probably has lower chance of breaking
someone.

> That said: while I don't think your patch is wrong, if we do want to
> do that EBADF thing, I think your patch is still very very ugly. You
> are adding this new 'bad_fd' variable for no good reason.
> 
> We already have an error variable: 'table.error'.
> 
> So a *minimal* patch that does what you suggest is to just do something like
> 
>     diff --git a/fs/select.c b/fs/select.c
>     index 945896d0ac9e..7a06d28ec83d 100644
>     --- a/fs/select.c
>     +++ b/fs/select.c
>     @@ -528,7 +528,9 @@ static int do_select(int n, fd_set_bits *fds,
> struct timespec64 *end_time)
>                     if (!(bit & all_bits))
>                             continue;
>                     f = fdget(i);
>     -               if (f.file) {
>     +               if (unlikely(!f.file)) {
>     +                       table.error = -EBADF;
>     +               } else {
>                             wait_key_set(wait, in, out, bit,
>                                          busy_flag);
>                             mask = vfs_poll(f.file, wait);
> 
> (which is again whitespace-damaged, but this time that's just to make
> it legible inline - there's no indentation change).

Yup, nicer.

> Hmm? I'd be ok with either of these (the second of these patches
> _should_ be equivalent to yours), but I think that first one might be
> the one that might cause less potential user-space breakage.

Agreed. I'll code it and give it some testing. 

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
