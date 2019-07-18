Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB8D26D67A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2019 23:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391450AbfGRVaJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jul 2019 17:30:09 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35212 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbfGRVaJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jul 2019 17:30:09 -0400
Received: by mail-qk1-f196.google.com with SMTP id r21so21732487qke.2;
        Thu, 18 Jul 2019 14:30:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gXA3fCzwUc7S8+pRMyyFoXYQ6Lxj2094nm3NP6Me1pg=;
        b=uCH2vUxrfcr6142uAaV9WcXORBKH/D7E4P4NiRuyJaE8kui154F7hapgGZCVK4V5oV
         h1KnYS8zB5WGcRW0yhYqz6ThOCVt0oV80LAGfoSFKRtZfNXUcqq4Vkc98WyzSf5MEfhC
         ChJWDCasnRmyjbS9ZdJ1VIkfY5G1MVa9zaR2pgCczj6oOHsD73sgibeBSKVPZopGXvDM
         xY7mk5kdPJ2hzmYK77+wvt1X8GlX5DuOJeI7mCZMAvHFwnVsvpfPZ56B86qqTVg8XPES
         7Uk5MUGfBIJqa4SUJOhaEv7m8ueBN492aEPpsSidYIuqRP6htYAWtO8+oyTfmZ0jeCe8
         JWVw==
X-Gm-Message-State: APjAAAVWFgTKNxdz5VJMuDG74/oEsWc7zg83gF05rrI4hZNlp1YwqMUs
        1xmowdKoxZ9t80vjXWPDDaUz1du0yDU5c5Rfqb8=
X-Google-Smtp-Source: APXvYqwAnwmqNY3PBxWPuNJix5kLy4PEG765j1QyxyCKOemfTtTG+YSbK8sHn1TSB6/emkF2O/3aVUhdKFw2Cxuzrg4=
X-Received: by 2002:a37:5f45:: with SMTP id t66mr32747316qkb.286.1563485406992;
 Thu, 18 Jul 2019 14:30:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190706145737.5299-1-cyphar@cyphar.com> <20190706145737.5299-9-cyphar@cyphar.com>
 <CAK8P3a33rGhPDFfRBAQyLTMG_WoEgX_toDgWR2O7rSwxKsZG+w@mail.gmail.com> <20190718161231.xcno272nvqpln3wj@yavin>
In-Reply-To: <20190718161231.xcno272nvqpln3wj@yavin>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 18 Jul 2019 23:29:50 +0200
Message-ID: <CAK8P3a3MiYK4bJiA3G_m5H-TpfN5__--b+=szsJBhG7_it+NQg@mail.gmail.com>
Subject: Re: [PATCH v9 08/10] open: openat2(2) syscall
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Christian Brauner <christian@brauner.io>,
        Eric Biederman <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        containers@lists.linux-foundation.org,
        alpha <linux-alpha@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        linux-ia64@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linux-mips@vger.kernel.org,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org,
        sparclinux <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 18, 2019 at 6:12 PM Aleksa Sarai <cyphar@cyphar.com> wrote:
> On 2019-07-18, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Sat, Jul 6, 2019 at 5:00 PM Aleksa Sarai <cyphar@cyphar.com> wrote:
> >
> > In fact, that seems similar enough to the existing openat() that I think
> > you could also just add the fifth argument to the existing call when
> > a newly defined flag is set, similarly to how we only use the 'mode'
> > argument when O_CREAT or O_TMPFILE are set.
>
> I considered doing this (and even had a preliminary version of it), but
> I discovered that I was not in favour of this idea -- once I started to
> write tests using it -- for a few reasons:
>
>   1. It doesn't really allow for clean extension for a future 6th
>          argument (because you are using up O_* flags to signify "use the
>          next argument", and O_* flags don't give -EINVAL if they're
>          unknown). Now, yes you can do the on-start runtime check that
>          everyone does -- but I've never really liked having to do it.
>
>          Having reserved padding for later extensions (that is actually
>          checked and gives -EINVAL) matches more modern syscall designs.
>
>   2. I really was hoping that the variadic openat(2) could be done away
>      using this union setup (Linus said he didn't like it, and suggested
>          using something like 'struct stat' as an argument for openat(2) --
>          though personally I am not sure I would personally like to use an
>          interface like that).
>
>   3. In order to avoid wasting a syscall argument for mode/mask you need
>          to either have something like your suggested mode_mask (which makes
>          the syscall arguments less consistent) or have some sort of
>          mode-like argument that is treated specially (which is really awful
>          on multiple levels -- this one I also tried and even wrote my
>          original tests using). And in both cases, the shims for
>          open{,at}(2) are somewhat less clean.

These are all good reasons, thanks for providing the background.

> All of that being said, I'd be happy to switch to whatever you think
> makes the most sense. As long as it's possible to get an O_PATH with
> RESOLVE_IN_ROOT set, I'm happy.

I don't feel I should be in charge of making the decision. I'd still
prefer avoiding the indirect argument structure because

4. it's inconsistent with most other syscalls

5. you get the same problem with seccomp and strace that
   clone3() has -- these and others only track the register
   arguments by default.

6. copying the structure adds a small overhead compared to
   passing registers

7. the calling conventions may be inconvenient for  a user space
   library, so you end up with different prototypes for the low-level
   syscall and the libc abstraction.

I don't see any of the above seven points as a showstopper
either way, so I hope someone else has a strong opinion
and can make the decision easier for you.

In the meantime just keep what you have, so you don't have
to change it multiple times.

       Arnd
