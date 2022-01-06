Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE24486A0F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jan 2022 19:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242948AbiAFSlr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jan 2022 13:41:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242731AbiAFSlq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jan 2022 13:41:46 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E417C061245
        for <linux-fsdevel@vger.kernel.org>; Thu,  6 Jan 2022 10:41:46 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id q25so4311041edb.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Jan 2022 10:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OGYYaF8XiLojo2uXhkiDLi9UtwHXXmN//HPjV9UbSSc=;
        b=QTqDnqdHeqLqqsca+9O6IqrUjXJ1E9pn1Y8R9Q6iFMbUN1dpskgiOhjnu0s3J3CJkJ
         fpARzWD/IKqdGpXJXQbrXZIL2+kFcusGqbJ1H8R+GxqE80O//SK5Bc2DDUykmxi2e57g
         d3XY3SBwcXcohZVRsnX8HsGkhMEp8Yo00/Fzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OGYYaF8XiLojo2uXhkiDLi9UtwHXXmN//HPjV9UbSSc=;
        b=Nu0NJSBEejQGTIhSQu41tsP19Rqdz8/gpAwXkajGIpsDC6ye+dAMbNpetFjeGA37sJ
         Ymhq1P3IjM/k89GHY03KEiyn1MCoOcp7rn33gphDvIpic+bmP1V2Uez3vZZXdk6QeXuo
         M57LH1NWI06JmGEpmEglxQ1k+LVNXL6fgD2To1ETjr+1aRPJ4SFmReCYv4NDsjnTH7xa
         Hk0HqlInWIs9I7g3BTFJeOQ3lY8MeEb2n6kW/pccIZZIUrSY2eEcseS5QWGsHCW6Ugin
         3Ad/aZ9aYDe88DvVWXWtRg/d5XliWvexU/yQnUUJYRFR0iTntr9hM7XqzqUDg/OxW2hb
         nTlg==
X-Gm-Message-State: AOAM530SiTpdL0li6v+Qpf7FmrUj5Rh0lYCxx5+uScVrT0Clo0KkukGX
        un+d+Ri92gjOdNzmMl2zv0rJsC8YFW5kCkDRySs=
X-Google-Smtp-Source: ABdhPJygS/Y57a/B3YzFVy1jyz4yWi+o4rS/j2XwjYWwn8qLjQFXXvMwooevVzK0De9EvJqfAo37Tg==
X-Received: by 2002:aa7:ccc7:: with SMTP id y7mr4613029edt.96.1641494504489;
        Thu, 06 Jan 2022 10:41:44 -0800 (PST)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id hp18sm687939ejc.120.2022.01.06.10.41.44
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jan 2022 10:41:44 -0800 (PST)
Received: by mail-wm1-f46.google.com with SMTP id e5so2459299wmq.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Jan 2022 10:41:44 -0800 (PST)
X-Received: by 2002:a7b:c92a:: with SMTP id h10mr7997386wml.26.1641494503662;
 Thu, 06 Jan 2022 10:41:43 -0800 (PST)
MIME-Version: 1.0
References: <20220104124425.6t6iepgzoruuqpvo@quack3.lan>
In-Reply-To: <20220104124425.6t6iepgzoruuqpvo@quack3.lan>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 6 Jan 2022 10:41:27 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiWcMw4zNfkty06u6KQ4tp064BHwMVcJBUjLHSjFCU6-w@mail.gmail.com>
Message-ID: <CAHk-=wiWcMw4zNfkty06u6KQ4tp064BHwMVcJBUjLHSjFCU6-w@mail.gmail.com>
Subject: Re: Indefinitely sleeping task in poll_schedule_timeout()
To:     Jan Kara <jack@suse.cz>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 6, 2022 at 7:45 AM Jan Kara <jack@suse.cz> wrote:
>
> So maybe something like attached patch (boot tested only so far)? What you
> do think?

I don't think the patch is wrong, but it looks like we've actually
never reacted to bad file descriptors, so I get the strong feeling
that the patch might break existing code that has worked by accident
before.

And the breakage might end up very subtle - select() randomly now
returning EBADFD if you have a race with somebody closing the fd that
previously was benign and silent. Which is going to be hell to debug
because it's some sporadic user-space race with close and select at
the same time, and it might easily actually break user space because
somebody just takes "error from select" to be fatal and asserts it.

What do_pollfd() does if there's no file associated with the fd is to
use EPOLLNVAL (an actual negative fd is ignored):

        mask = EPOLLNVAL;
        f = fdget(fd);
        if (!f.file)
                goto out;

and I wonder if we should try something equivalent for select() as a
slightly less drastic change.

Of course, select() doesn't actually have EPOLLNVAL, but it does have
EPOLLERR and EPOLLPRI, which would set all the bits for that fd.

The patch would be something like this (NOTE NOTE NOTE: this is not
only whitespace-damaged - it was done with "git diff -w" to not show
the whitespace change. Look at how it changes the nesting of that "if
(f.file)" thing, and it needs to change the indentation of all those
subsequent if-statements that check the mask. I did it this way just
to show the logic change, a real patch would be much bigger due to the
whitespace change).

    diff --git a/fs/select.c b/fs/select.c
    index 945896d0ac9e..d77f8a614ad4 100644
    --- a/fs/select.c
    +++ b/fs/select.c
    @@ -528,12 +528,14 @@ static int do_select(int n, fd_set_bits *fds,
                    if (!(bit & all_bits))
                            continue;
                    f = fdget(i);
    +               mask = EPOLLERR | EPOLLPRI;
                    if (f.file) {
                            wait_key_set(wait, in, out, bit,
                                         busy_flag);
                            mask = vfs_poll(f.file, wait);

                            fdput(f);
    +               }
                    if ((mask & POLLIN_SET) && (in & bit)) {
                            res_in |= bit;
                            retval++;
    @@ -560,8 +562,6 @@ static int do_select(int n, fd_set_bits *fds,
                     */
                    } else if (busy_flag & mask)
                            can_busy_loop = true;
    -
    -               }
            }
            if (res_in)
                    *rinp = res_in;


That said: while I don't think your patch is wrong, if we do want to
do that EBADF thing, I think your patch is still very very ugly. You
are adding this new 'bad_fd' variable for no good reason.

We already have an error variable: 'table.error'.

So a *minimal* patch that does what you suggest is to just do something like

    diff --git a/fs/select.c b/fs/select.c
    index 945896d0ac9e..7a06d28ec83d 100644
    --- a/fs/select.c
    +++ b/fs/select.c
    @@ -528,7 +528,9 @@ static int do_select(int n, fd_set_bits *fds,
struct timespec64 *end_time)
                    if (!(bit & all_bits))
                            continue;
                    f = fdget(i);
    -               if (f.file) {
    +               if (unlikely(!f.file)) {
    +                       table.error = -EBADF;
    +               } else {
                            wait_key_set(wait, in, out, bit,
                                         busy_flag);
                            mask = vfs_poll(f.file, wait);

(which is again whitespace-damaged, but this time that's just to make
it legible inline - there's no indentation change).

Hmm? I'd be ok with either of these (the second of these patches
_should_ be equivalent to yours), but I think that first one might be
the one that might cause less potential user-space breakage.

... and neither of the above whitespace-damaged patches are *tested*
in any way. I might have completely screwed something up.

Comments? Anybody?

               Linus
