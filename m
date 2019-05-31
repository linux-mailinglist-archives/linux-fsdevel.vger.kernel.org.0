Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84082315A5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2019 21:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbfEaTvS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 May 2019 15:51:18 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43802 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727199AbfEaTvR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 May 2019 15:51:17 -0400
Received: by mail-qt1-f196.google.com with SMTP id z24so2332567qtj.10;
        Fri, 31 May 2019 12:51:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xsy7KltLXxbW0BgIu9F6NiZrWo9L3TAjqu6dUK3uAPQ=;
        b=HKiKcAe9NTvT7jlqURubrv6AeE+r3LE2+ofsKjOLjlU0ld0Pi3r+5W07WAc3VTxYm/
         5wrIZtFRKGTy2rH60ru5gu6eOl/YzHfcZSENVMsY8hGuobbDe4O1sp/TxLr5Xtsr4Dl0
         dwdKN9ROAl13qXJcOMT007U4IWvdTWmffPs1e/NuDc2RCbGRUSJHKyvb2Ua41NmLi8G1
         EhPapRhPY4RVQXaXXLgkI1YZG/BcMmh5QvS0t30z3V25fLVbsq6/fspHUsKpvJ5a4hme
         +UQJfWQiDpAbWQZ3HSdJDulMjntf/kxRd4eh+RUPfIwyjA0FaD9D0kqAasz8h5U5CYIq
         Ph5g==
X-Gm-Message-State: APjAAAUm+OEZ/7YxeQJx+zOKF7n1s+UtucC9RQHHqU7lyIRYoURhthq4
        lFcldEooRRjhXGvtLlCoJhz/ZuU5uw2YIIyBzTU=
X-Google-Smtp-Source: APXvYqy5TLpyp1w9fDgzU51O06QTfSxUvNh0UTj3TiR4JGC7+S/GTS9DUNmT2pYJmAL1ZIsCzMU5oyvll93f7R/CrRg=
X-Received: by 2002:a0c:e78b:: with SMTP id x11mr6666549qvn.93.1559332276507;
 Fri, 31 May 2019 12:51:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190531191204.4044-1-palmer@sifive.com> <20190531191204.4044-3-palmer@sifive.com>
In-Reply-To: <20190531191204.4044-3-palmer@sifive.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 31 May 2019 21:51:00 +0200
Message-ID: <CAK8P3a3HPeVq29k3Zk5rSk4bddiUQFrdEgDZUgdNnYZK+8QpGw@mail.gmail.com>
Subject: Re: [PATCH 2/5] Add fchmodat4(), a new syscall
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 31, 2019 at 9:23 PM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> man 3p says that fchmodat() takes a flags argument, but the Linux
> syscall does not.  There doesn't appear to be a good userspace
> workaround for this issue but the implementation in the kernel is pretty
> straight-forward.  The specific use case where the missing flags came up
> was WRT a fuse filesystem implemenation, but the functionality is pretty
> generic so I'm assuming there would be other use cases.
>
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> ---
>  fs/open.c                | 21 +++++++++++++++++++--
>  include/linux/syscalls.h |  5 +++++
>  2 files changed, 24 insertions(+), 2 deletions(-)
>
> diff --git a/fs/open.c b/fs/open.c
> index a00350018a47..cfad7684e8d3 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -568,11 +568,17 @@ SYSCALL_DEFINE2(fchmod, unsigned int, fd, umode_t, mode)
>         return ksys_fchmod(fd, mode);
>  }
>
> -int do_fchmodat(int dfd, const char __user *filename, umode_t mode)
> +int do_fchmodat4(int dfd, const char __user *filename, umode_t mode, int flags)
...
> +
> +int do_fchmodat(int dfd, const char __user *filename, umode_t mode)
> +{
> +       return do_fchmodat4(dfd, filename, mode, 0);
> +}
> +

There is only one external caller of do_fchmodat(), so just change that
to pass the extra argument here, and keep a single do_fchmodat()
function used by the sys_fchmod(), sys_fchmod4(), sys_chmod()
and ksys_chmod().

        Arnd
