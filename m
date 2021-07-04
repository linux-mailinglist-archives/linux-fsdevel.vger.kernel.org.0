Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB52A3BAE51
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Jul 2021 20:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbhGDSem (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Jul 2021 14:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbhGDSel (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Jul 2021 14:34:41 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10B6C061762
        for <linux-fsdevel@vger.kernel.org>; Sun,  4 Jul 2021 11:32:05 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id t17so28397958lfq.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 04 Jul 2021 11:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NwKJolKeiHH3kIk5nNj/xNE+4YwSFd5mFVcQJiumDGE=;
        b=Q4V32khUX97/OkXtvqDZ5jecm4KYXVvosh1gh1iu5s/mdWmfu6UXQfzbLfGjux/uH6
         TdhfAyA+VuA74RBQK7BZ8NWOClyv1i9XqQ5MsDGcVUjqaWo/gg7oLB2fMGB8EiF8dHIE
         qPa7jCxMXOxVAgbOUQL75SvkfsbeDg7d02meQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NwKJolKeiHH3kIk5nNj/xNE+4YwSFd5mFVcQJiumDGE=;
        b=ARE/TkbccrDdI4bZ7ldKjFJeljNoMcRFuPzKqWdTkjTJR8TpukSSW9CoNF2ThJqlB7
         7bJSLJ0uLPUkvKCHArc3axqQ4bgvHsqaeNzLH4E528KHccthK6y+qqpyhqrvqG9c/jSg
         PB5eBvH4CB72NuXORZWRZ9jAJ5DsVGbDX8IsgdR+lYpV5f4fi3GSL6xn3Z/3Ag9nWAat
         dQYBbtaSKT5xjl76zGeKDxKunDLAzhPfef0HAardubpBp+lSOPdk7KsvzTTTMJ/8cocN
         yWbnedhb/s1XsabJGIzCeRV67y4wKnSjH4EUHodqClhn3bGrjJ9JqTm/px4v8R3P4GU9
         RPUQ==
X-Gm-Message-State: AOAM530PwkS+mlCalsGLFVv2oNSqlFen/B1TzBHBxO4wlPF12Fp8LPJ1
        dIA11jirWFUwcm3jX0kgcHpV85eaE5sAknBB6oE=
X-Google-Smtp-Source: ABdhPJzC+c79bzwSjBg4MJlivuFFpN/2EKNHZj+MrmfRB8VUb5xYOg7KtTYviEcJ8MkTrEq+1t5x+g==
X-Received: by 2002:a05:6512:31d4:: with SMTP id j20mr7279454lfe.521.1625423523531;
        Sun, 04 Jul 2021 11:32:03 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id f10sm856928lfr.303.2021.07.04.11.32.01
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jul 2021 11:32:02 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id t30so1445808ljo.5
        for <linux-fsdevel@vger.kernel.org>; Sun, 04 Jul 2021 11:32:01 -0700 (PDT)
X-Received: by 2002:a2e:2201:: with SMTP id i1mr7978592lji.61.1625423521316;
 Sun, 04 Jul 2021 11:32:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210704172948.GA1730187@roeck-us.net>
In-Reply-To: <20210704172948.GA1730187@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 4 Jul 2021 11:31:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wheBFiejruhRqByt0ey1J8eU=ZUo9XBbm-ct8_xE_+B9A@mail.gmail.com>
Message-ID: <CAHk-=wheBFiejruhRqByt0ey1J8eU=ZUo9XBbm-ct8_xE_+B9A@mail.gmail.com>
Subject: Re: [PATCH] iov_iter: separate direction from flavour
To:     Guenter Roeck <linux@roeck-us.net>, Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Sterba <dsterba@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Anton Altaparmakov <anton@tuxera.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[ Added Christoph, since the issue technically goes further back than
when the warning appeared - it just used to be silent ]

On Sun, Jul 4, 2021 at 10:29 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> This patch results in the following runtime warning on nommu systems.

Ok, good, it actually found something.

> [    8.574191] [<21059cab>] (vfs_read) from [<2105d92b>] (read_code+0x15/0x2e)
> [    8.574329] [<2105d92b>] (read_code) from [<21085a8d>] (load_flat_file+0x341/0x4f0)
> [    8.574481] [<21085a8d>] (load_flat_file) from [<21085e03>] (load_flat_binary+0x47/0x2dc)
> [    8.574639] [<21085e03>] (load_flat_binary) from [<2105d581>] (bprm_execve+0x1fd/0x32c)

Hmm. That actually loads things into user space, so the problem isn't
that it shouldn't use vfs_read() or that iov_iter_init() would be
doing somethign wrong - the problem appears purely to be that we're in
an "uaccess_kernel()" region.

And yes, we're still in the early init code:

> [    8.574797] [<2105d581>] (bprm_execve) from [<2105dbb3>] (kernel_execve+0xa3/0xac)
> [    8.574947] [<2105dbb3>] (kernel_execve) from [<211e7095>] (kernel_init+0x31/0xb0)
> [    8.575099] [<211e7095>] (kernel_init) from [<2100814d>] (ret_from_fork+0x11/0x24)

which presumably runs with KERNEL_DS.

Which is kind of bogus in the new world order.

None of this *matters* for a nommu system, of course, which is why
that code used to work, and why it's now warning.

But for the same reason, it should still continue to work, despite the
warning. Because iov_iter_init() will actually be doing the right
thing and making it all about user pointers.

Can you verify that it otherwise looks ok apart from the new warning?

I *think* we should move to initializing the kernel state to
"set_fs(USER_DS)", and that would be the right model these days.

Of course, that could cause other things to pop up on architectures
that haven't been converted away from CONFIG_SET_FS.

The safer thing might be to move it earlier in kernel_execve(): it
does end up doing that "set_fs(USER_DS)" eventually, but it's done
fairly late in "begin_new_exec()" (and it's done as a
force_uaccess_begin(), not set_fs(), but in a CONFIG_SET_FS
configuration that ends up being what it does.

> The same warning is also observed with m68k and mcf5208evb,
> though the traceback isn't as nice.

Hmm. Either the m68k trace printing is just bad, or maybe it just
doesn't have CONFIG_KALLSYMS (or KALLSYMS_ALL) enabled.

Anyway, does a hacky patch something like this

   diff --git a/fs/exec.c b/fs/exec.c
   index 38f63451b928..26293bd7c502 100644
   --- a/fs/exec.c
   +++ b/fs/exec.c
   @@ -1934,6 +1934,10 @@ int kernel_execve(const char *kernel_filename,
        int fd = AT_FDCWD;
        int retval;

   +    // Make sure CONFIG_SET_FS architectures actually
   +    // do things into user space.
   +    force_uaccess_begin();
   +
        filename = getname_kernel(kernel_filename);
        if (IS_ERR(filename))
                return PTR_ERR(filename);

make the warning go away? I really would like to set USER_DS even
earlier, but this might be the least disruptive place.

Anything that accesses kernel space should *not* depend on KERNEL_DS
at this point, since that would make all the properly converted
architectures already fail.

And any architectures that haven't been converted away from
CONFIG_SET_FS would have been hitting that force_uaccess_begin() later
in  begin_new_exec(), so they can't depend on any KERNEL_DS games
after kernel_execve() either.

So that one-liner is hacky, but *feels* safe to me. Am I perhaps
missing something?

It probably means we could remove the force_uaccess_begin() in
begin_new_exec() entirely, but let's first see if the one-liner at
least makes the warning go away.

           Linus
