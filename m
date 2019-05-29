Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF95D2DC68
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 14:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbfE2MFj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 08:05:39 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41627 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfE2MFi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 08:05:38 -0400
Received: by mail-qk1-f194.google.com with SMTP id m18so1225204qki.8;
        Wed, 29 May 2019 05:05:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uptjHgaBaplGgf+wVSZU2eUIoKk2cN8EqiU/ukCqtno=;
        b=bVru2BYig38DgvLxps014WcqhT79gXuca2bK5YYvsZX6/pCoiF7T1M8KG+54g1GgRL
         hQ0oNIofY0Gbta4HzbzhsdohwMrktKK7svU/HIKpWqDXrof/fWkKZZHI66oi1DqDMQg5
         NB8WcqSYg1xcppR+jNWmNVDrEce6do2vQZJ5Nr7KW+wKe3F/AblZPRQzcqFyVwKaSSO2
         kTSiq8lbGzIrOUyrYSJkl6zT0uCMGemojqtWR/amdEUbXcf2UgXiFNaVlfh3zTd9SUa5
         mXsldNqN8pFQn+pLkwwwY8MA1i1shNTDENVRbNpm6kv0yluRrwi8cWE77677njpdVzkN
         p+KQ==
X-Gm-Message-State: APjAAAWZn+XYGCw+YL5NL9zlPbseU+lCQfI2zoFJclDHvZZmkybNeXbL
        qFFCFM6UG4tV0waJ2QuQ0t1qvxY7h/2cq94Skuw=
X-Google-Smtp-Source: APXvYqyekV82e1W5v+9f5Zmh22yFEE89mido7w9iaejsZbo7/EiB96l90U3/3zjongBQz+oYmXVaIj2lHXggVe4sbas=
X-Received: by 2002:a05:620a:1085:: with SMTP id g5mr80432085qkk.182.1559131537731;
 Wed, 29 May 2019 05:05:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190524201817.16509-1-jannh@google.com> <20190525144304.e2b9475a18a1f78a964c5640@linux-foundation.org>
 <CAG48ez36xJ9UA8gWef3+1rHQwob5nb8WP3RqnbT8GEOV9Z38jA@mail.gmail.com> <6956cfe5-90d4-aad4-48e3-66b0ece91fed@linux-m68k.org>
In-Reply-To: <6956cfe5-90d4-aad4-48e3-66b0ece91fed@linux-m68k.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 29 May 2019 14:05:21 +0200
Message-ID: <CAK8P3a0b7MBn+84jh0Y2zhFLLAqZ2tMvFDFF9Kw=breRLH4Utg@mail.gmail.com>
Subject: Re: [PATCH] binfmt_flat: make load_flat_shared_library() work
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Linux/m68k" <linux-m68k@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Sergei Poselenov <sposelenov@emcraft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 28, 2019 at 12:56 PM Greg Ungerer <gerg@linux-m68k.org> wrote:
> On 27/5/19 11:38 pm, Jann Horn wrote:
> > On Sat, May 25, 2019 at 11:43 PM Andrew Morton
> > <akpm@linux-foundation.org> wrote:
> >> On Fri, 24 May 2019 22:18:17 +0200 Jann Horn <jannh@google.com> wrote:
> >>> load_flat_shared_library() is broken: It only calls load_flat_file() if
> >>> prepare_binprm() returns zero, but prepare_binprm() returns the number of
> >>> bytes read - so this only happens if the file is empty.
> >>
> >> ouch.
> >>
> >>> Instead, call into load_flat_file() if the number of bytes read is
> >>> non-negative. (Even if the number of bytes is zero - in that case,
> >>> load_flat_file() will see nullbytes and return a nice -ENOEXEC.)
> >>>
> >>> In addition, remove the code related to bprm creds and stop using
> >>> prepare_binprm() - this code is loading a library, not a main executable,
> >>> and it only actually uses the members "buf", "file" and "filename" of the
> >>> linux_binprm struct. Instead, call kernel_read() directly.
> >>>
> >>> Cc: stable@vger.kernel.org
> >>> Fixes: 287980e49ffc ("remove lots of IS_ERR_VALUE abuses")
> >>> Signed-off-by: Jann Horn <jannh@google.com>
> >>> ---
> >>> I only found the bug by looking at the code, I have not verified its
> >>> existence at runtime.
> >>> Also, this patch is compile-tested only.
> >>> It would be nice if someone who works with nommu Linux could have a
> >>> look at this patch.
> >>
> >> 287980e49ffc was three years ago!  Has it really been broken for all
> >> that time?  If so, it seems a good source of freed disk space...
> >
> > Maybe... but I didn't want to rip it out without having one of the
> > maintainers confirm that this really isn't likely to be used anymore.
>
> I have not used shared libraries on m68k non-mmu setups for
> a very long time. At least 10 years I would think.

I think Emcraft have a significant customer base running ARM NOMMU
Linux, I wonder whether they would have run into this (adding
Sergei to Cc).
My suspicion is that they use only binfmt-elf-fdpic, not binfmt-flat.

The only architectures I see that enable binfmt-flat are sh, xtensa
and h8300, but only arch/sh uses CONFIG_BINFMT_SHARED_FLAT
for a few machine specific configurations, and I'm in turn fairly sure
those machines have not run a recent kernel in many years.

The one SH nommu platform likely to have users is j2, and that is
probably always used with musl-libc with elf-fdpic (given that
Rich Felker maintains both the kernel port and the library).

      Arnd
