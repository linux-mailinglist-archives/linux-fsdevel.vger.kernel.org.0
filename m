Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 284BE214800
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jul 2020 20:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgGDSft (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Jul 2020 14:35:49 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44392 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbgGDSft (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Jul 2020 14:35:49 -0400
Received: by mail-ot1-f66.google.com with SMTP id 5so26811736oty.11;
        Sat, 04 Jul 2020 11:35:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/7ImKIfSgkzTRdy3VH0zTAz2g580OOvL55arrNBXHTU=;
        b=IGW+oc//6FqbAPsbOqk43/UADR7NfQF2zRMJu7TtS9T8aI5KZ2qdW1qaLYpQ3uFcN2
         +wc47ZbLqz1SrwXL7DYYuzMxXT0BF5qL2R8kfaMU1c/RnYW2TVUOBfSrgk52nYZOIgfx
         s+g4YHEDULSwd2ljSuw05E1FGaliYbPsZTuwWBGdcOcCMLqJ3e/Ky2A8NZHyhsatmuWn
         de+DJdMkunGgBt+dQB005ezTAKSd5iZ9UhV2QfnZLtcJ/4ny0QEUpJ3qa9mn//OF/O4t
         CMOmQa7PGTldu7B66uWKDfTwMGTCY3MIdxk0PJowl6rdKz5oTDct3RU7MMhJOqksWAUO
         rZlw==
X-Gm-Message-State: AOAM531YF1oxC5uU4OZFnsyjd+1KnBPMOsuWeJL0k2KXSh4V0uGpwsV4
        OI9TkFjeUFjYsbYWsnNnt917E9H8HWPHX9s0jnBrqqGo
X-Google-Smtp-Source: ABdhPJyUe7YIsqlkWjiNEQH3Ag7AU3N7TQm7lXtyWCDzf+QjDWC36IS1w7Q0mNBb6yFG9dR56W1v7BX8pA9ynSVnTJM=
X-Received: by 2002:a9d:1b0d:: with SMTP id l13mr2983524otl.145.1593887747708;
 Sat, 04 Jul 2020 11:35:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200704140250.423345-1-gregkh@linuxfoundation.org> <20200704140250.423345-2-gregkh@linuxfoundation.org>
In-Reply-To: <20200704140250.423345-2-gregkh@linuxfoundation.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 4 Jul 2020 20:35:36 +0200
Message-ID: <CAMuHMdWeuzVjZMpR+d20X0mDCpVpNzEU0qpZO4LiMVGCgJBy3A@mail.gmail.com>
Subject: Re: [PATCH 1/3] readfile: implement readfile syscall
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-man@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Greg,

On Sat, Jul 4, 2020 at 4:05 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> It's a tiny syscall, meant to allow a user to do a single "open this
> file, read into this buffer, and close the file" all in a single shot.
>
> Should be good for reading "tiny" files like sysfs, procfs, and other
> "small" files.
>
> There is no restarting the syscall, this is a "simple" syscall, with the
> attempt to make reading "simple" files easier with less syscall
> overhead.
>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thanks for your patch!

> --- a/fs/open.c
> +++ b/fs/open.c

> +SYSCALL_DEFINE5(readfile, int, dfd, const char __user *, filename,
> +               char __user *, buffer, size_t, bufsize, int, flags)
> +{
> +       struct open_flags op;
> +       struct open_how how;
> +       struct file *file;
> +       loff_t pos = 0;
> +       int retval;
> +
> +       /* only accept a small subset of O_ flags that make sense */
> +       if ((flags & (O_NOFOLLOW | O_NOATIME)) != flags)
> +               return -EINVAL;
> +
> +       /* add some needed flags to be able to open the file properly */
> +       flags |= O_RDONLY | O_LARGEFILE;
> +
> +       how = build_open_how(flags, 0000);
> +       retval = build_open_flags(&how, &op);
> +       if (retval)
> +               return retval;
> +
> +       file = readfile_open(dfd, filename, &op);
> +       if (IS_ERR(file))
> +               return PTR_ERR(file);
> +
> +       retval = vfs_read(file, buffer, bufsize, &pos);

Should there be a way for the user to be informed that the file doesn't
fit in the provided buffer (.e.g. -EFBIG)?

> +
> +       filp_close(file, NULL);
> +
> +       return retval;
> +}

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
