Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF7C486AAF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jan 2022 20:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243447AbiAFTvu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jan 2022 14:51:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233979AbiAFTvt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jan 2022 14:51:49 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391A5C061245
        for <linux-fsdevel@vger.kernel.org>; Thu,  6 Jan 2022 11:51:49 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id q25so4997607edb.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Jan 2022 11:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wOpMfolzyH+ikFx6DQ40ksQv/1Y03ZcoMA5s63Q4anU=;
        b=AiVb4fEZOgRbGhA5pO8ZCciIA/n84hx3XGTYsb/8XSaMDo8KsjvoFOWOf7H7HPabGa
         mWaNqDwdoe4fyWI7ggvx7TFtRmB055z0fB//2BpwdzqUFxqIkTU2DUeAeXHoVC7/B0Hz
         FEFapllg20Nd3+Z3BgmfBLjlB4ILOWEmjMLGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wOpMfolzyH+ikFx6DQ40ksQv/1Y03ZcoMA5s63Q4anU=;
        b=Q6M0KK4z8Uo6b4QLtTbJ6dK3NrwCVKz+73ZC33RHEx2DYP9c6m/6XIImFHTd11jNs6
         6Bg4iREj2lVcLoX7oWEcB5QA3i4JeO9Qh3/VruoYZEPlgyR9HmmY0rKXqWjOPS4sSGJG
         4iyBSxZmsR02eMusDJGHP0oj6E/owjNwl+ouzFtBKHDuf0FRwkqlDDTh41S0JYiFrq6l
         Q2eMrrCQAoz6SPacFCAHWWOu7heyvhgKJmDVs8JgJzUVyehVnUI59aYMIJDDdrxETJq1
         M9cm/vjIJQ6y4GBZwvyz/tGiepJAjIamZTKYKGJfZP8IjNqybPE/XMpnCXMRfNp101GS
         iaWQ==
X-Gm-Message-State: AOAM5339Zt9QkhqJiafpWP7wlZYW7eBIvgXNF4OQ0Ikt/JLH0K4i93eU
        YC7mAPT86wPKtm994nq1FpLeQfHJvKQJ5+mObl0=
X-Google-Smtp-Source: ABdhPJyuvIjcEZ/WUCcDe8ZCZD+DyVtQluDUxfTD7maxaaqw6JFinNGMSNjvA7SurnoNGRVdzF6lwA==
X-Received: by 2002:a17:907:7282:: with SMTP id dt2mr46794002ejc.653.1641498707606;
        Thu, 06 Jan 2022 11:51:47 -0800 (PST)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id gb4sm737401ejc.90.2022.01.06.11.51.47
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jan 2022 11:51:47 -0800 (PST)
Received: by mail-wm1-f46.google.com with SMTP id l4so2570875wmq.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Jan 2022 11:51:47 -0800 (PST)
X-Received: by 2002:a7b:c305:: with SMTP id k5mr8244976wmj.144.1641498706846;
 Thu, 06 Jan 2022 11:51:46 -0800 (PST)
MIME-Version: 1.0
References: <20220104124425.6t6iepgzoruuqpvo@quack3.lan> <CAHk-=wiWcMw4zNfkty06u6KQ4tp064BHwMVcJBUjLHSjFCU6-w@mail.gmail.com>
In-Reply-To: <CAHk-=wiWcMw4zNfkty06u6KQ4tp064BHwMVcJBUjLHSjFCU6-w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 6 Jan 2022 11:51:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiJFY5bheR0UgJRhz2uNBKoapdtNYK3iKjjrLTP61jh0g@mail.gmail.com>
Message-ID: <CAHk-=wiJFY5bheR0UgJRhz2uNBKoapdtNYK3iKjjrLTP61jh0g@mail.gmail.com>
Subject: Re: Indefinitely sleeping task in poll_schedule_timeout()
To:     Jan Kara <jack@suse.cz>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 6, 2022 at 10:41 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
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

Actually, it would probably be better to actually use EPOLLNVAL
exactly to be consistent with epoll() on a code level, and just also
add that bit to the POLL{IN,OUT,ERR}_SET collections, so that an fd
that has been closed will set all the in/out/ex bits.

I suspect that not only is the most consistent we can be with
'poll()', putting a bit in the output bitmap is less likely to break
existing apps, and is at least a useful situation: anybody who then
walks the output bitmaps to see what's going on will get EBADF when
actually trying to read/write from the file descriptor.

So it's actually _useful_ semantics, although obviously nobody can
rely on it (since we've never set those bits before, and presumably no
other unix does either).

The advantage of the EBADF return value is obviously that it's
ostensibly the portable thing to do, but considering that we've never
actually done that, I really do get the feeling that it's very likely
to break applications that do "select()" in one thread, and do
concurrent file management in another.

Regardless, I feel either change might cause subtle enough user
semantic breakage that I'd be inclined to leave this for 5.17, and
back-port it to stable after we've seen more testing, rather than
apply it this late in the development series.

                Linus
