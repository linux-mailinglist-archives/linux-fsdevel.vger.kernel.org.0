Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA033F4628
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Aug 2021 09:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235321AbhHWH4w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Aug 2021 03:56:52 -0400
Received: from mail-vs1-f41.google.com ([209.85.217.41]:40755 "EHLO
        mail-vs1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235263AbhHWH4v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Aug 2021 03:56:51 -0400
Received: by mail-vs1-f41.google.com with SMTP id h29so8184113vsr.7;
        Mon, 23 Aug 2021 00:56:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bO20WydNuUjicbzTyFZXQBF0DVpWSwKIJdDjl+VnxdI=;
        b=FlqhUFLsgf820Fnm207VUxAruP6Em7I3U7iCjyNkX30DAXODEZslEYO17X9auGNjdC
         Owoy9ZwEsHTO5rttHTyOxiVtxsBgGo6psXXpruKWe6nwWSY9tVW9FngJR3n2RQ9sScnW
         BX3TMoHG6EY3ulm7cOCAS4I4h+AHM3ANZe2cQUDTRO9p8jsD6EqfICM6UQ5K7wwnE0c/
         N+DRlR041Drx7DRzTPkggY3KHH1bACK5wTDyPHPDCB+sV/uTLbRo6sp0cJcnm+RO08RU
         D9XY25TOhTIo66GuPB176tyLayWj5tdUnFO8E0d6epENTUPg6pIsIL9i11pGdfb4JJhl
         HIqQ==
X-Gm-Message-State: AOAM5310y4BUrX/1GL8G+gtSmKCz+eQQeI5piT288VDOPRSIC1TQkXRX
        fE4YjnNfLVS1RUSsb+IZAY9SF4NdOl/OHboWbw8=
X-Google-Smtp-Source: ABdhPJxMhnJoTSMt1e3XrfAQGUikNOXfRuWG7TZ644Gun+YviYlr+fG1nVKaZQa7BFgcKGc/DC0y/v+xN1ESjGAyAXg=
X-Received: by 2002:a05:6102:3e92:: with SMTP id m18mr22891652vsv.53.1629705368522;
 Mon, 23 Aug 2021 00:56:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210812084348.6521-1-david@redhat.com> <87o8a2d0wf.fsf@disp2133>
 <60db2e61-6b00-44fa-b718-e4361fcc238c@www.fastmail.com> <87lf56bllc.fsf@disp2133>
 <CAHk-=wgru1UAm3kAKSOdnbewPXQMOxYkq9PnAsRadAC6pXCCMQ@mail.gmail.com>
 <87eeay8pqx.fsf@disp2133> <5b0d7c1e73ca43ef9ce6665fec6c4d7e@AcuMS.aculab.com>
 <87h7ft2j68.fsf@disp2133> <CAHk-=whmXTiGUzVrTP=mOPQrg-XOi3R-45hC4dQOqW4JmZdFUQ@mail.gmail.com>
 <b629cda1-becd-4725-b16c-13208ff478d3@www.fastmail.com> <YRcyqbpVqwwq3P6n@casper.infradead.org>
 <87k0kkxbjn.fsf_-_@disp2133> <0c2af732e4e9f74c9d20b09fc4b6cbae40351085.camel@kernel.org>
 <CAHk-=wgewmbABDC3_ZNn11C+sm4Uz0L9HZ5Kvx0Joho4vsV4DQ@mail.gmail.com>
 <a1385746582a675c410aca4eb4947320faec4821.camel@kernel.org>
 <CAHk-=wgD-SNxB=2iCurEoP=RjrciRgLtXZ7R_DejK+mXF2etfg@mail.gmail.com>
 <639d90212662cf5cdf80c71bbfec95907c70114a.camel@kernel.org>
 <CAHk-=wgHbYmUZvFkthGJ6zZx+ofTiiTRxPai5mPkmbtE=6JbaQ@mail.gmail.com> <ec075ee5764f4c7f9dd630090fb01f70@AcuMS.aculab.com>
In-Reply-To: <ec075ee5764f4c7f9dd630090fb01f70@AcuMS.aculab.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 23 Aug 2021 09:55:57 +0200
Message-ID: <CAMuHMdVWC9=TtFG7=SmN+KQ=phh1MqNqgLFbrWXr9XsDv-Sp5Q@mail.gmail.com>
Subject: Re: Removing Mandatory Locks
To:     David Laight <David.Laight@aculab.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jeff Layton <jlayton@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Kees Cook <keescook@chromium.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Mike Rapoport <rppt@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Michel Lespinasse <walken@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Huang Ying <ying.huang@intel.com>,
        Jann Horn <jannh@google.com>, Feng Tang <feng.tang@intel.com>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Shawn Anastasio <shawn@anastas.io>,
        Steven Price <steven.price@arm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jens Axboe <axboe@kernel.dk>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Peter Xu <peterx@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Marco Elver <elver@google.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Nicolas Viennot <Nicolas.Viennot@twosigma.com>,
        Thomas Cedeno <thomascedeno@google.com>,
        Collin Fijalkovich <cfijalkovich@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Chengguang Xu <cgxu519@mykernel.net>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        "linux-unionfs@vger.kernel.org" <linux-unionfs@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "<linux-fsdevel@vger.kernel.org>" <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Florian Weimer <fweimer@redhat.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 20, 2021 at 10:30 AM David Laight <David.Laight@aculab.com> wrote:
> From: Linus Torvalds
> > Sent: 19 August 2021 23:33
> >
> > On Thu, Aug 19, 2021 at 2:43 PM Jeff Layton <jlayton@kernel.org> wrote:
> > >
> > > What sort of big, ugly warning did you have in mind?
> >
> > I originally thought WARN_ON_ONCE() just to get the distro automatic
> > error handling involved, but it would probably be a big problem for
> > the people who end up having panic-on-warn or something.
>
> Even panic-on-oops is a PITA.
> Took us weeks to realise that a customer system that was randomly
> rebooting was 'just' having a boring NULL pointer access.
>
> > So probably just a "make it a big box" thing that stands out, kind of
> > what lockdep etc does with
> >
> >         pr_warn("======...====\n");
> >
> > around the messages..

Do we really need more of these?
They take time to print (especially on serial
consoles) and increase kernel size.

What's wrong with using an appropriate KERN_*, and letting userspace
make sure the admin/user will see the message (see below)?

> >
> > I don't know if distros have some pattern we could use that would end
> > up being something that gets reported to the user?
>
> Will users even see it?
> A lot of recent distro installs try very hard to hide all the kernel
> messages.

Exactly.  E.g. Ubuntu doesn't show any kernel output during normal
operation.

On Fri, Aug 20, 2021 at 6:12 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Fri, Aug 20, 2021 at 6:43 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> > On Thu, 19 Aug 2021 15:32:31 -0700
> > Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > >
> > > I don't know if distros have some pattern we could use that would end
> > > up being something that gets reported to the user?

> So what would be more interesting is if there's some distro support
> for showing kernel notifications..
>
> I see new notifications for calendar events, for devices that got
> mounted, for a lot of things - so I'm really wondering if somebody
> already perhaps had something for specially formatted kernel
> messages..

Isn't that what the old syslog and the new systemd are supposed to
handle in userspace?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
