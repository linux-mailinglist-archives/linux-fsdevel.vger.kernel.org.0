Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C59B93F315C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Aug 2021 18:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbhHTQPl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Aug 2021 12:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbhHTQPk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Aug 2021 12:15:40 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387F0C061575
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Aug 2021 09:15:02 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id u22so21581518lfq.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Aug 2021 09:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mzTg/T5rxtdzoGmN3P0CSeW1UdQythyyKuVbkMYCPbE=;
        b=WdRAnbBbKD4NYNOEoU32NVSXl0xdyTdGAzo1g1eX67aWeryIYd/gjpKGX0OdMru+sw
         JAacMgCc8/geZAPcmxKQR+4SqL978WORH4bsJElSC/YM4T3uSCBvJGPsAmmgv823yaC+
         LOgcV3xCPibhMcvn6FEMtZuzLxr8aWxzaRpYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mzTg/T5rxtdzoGmN3P0CSeW1UdQythyyKuVbkMYCPbE=;
        b=auIQZcq4pYgRV3+UcgsZhsqwzuzRO3DnJkJFINqVYHOOhjOzPFwbB1wsChnoKnH5JU
         ZqBJDDhvOXeMrVPqeSkZ+74772WGdEJwXqX835cuKsW6xwh3JDIRzJ9k5/049Kb4lP+E
         cxNL/m3Czs5r//vdfj1xRF7fyee1UiVgPZlH2NSBON/ipsaSQizw7rfsRlfuFk/9jFCG
         wFZVIZDkWiCcb8vUP8HEDhTiBwAB7d7YXtlgbNiZ7wtuaaXi0u1ZMqIO+zpGKc7IC1gR
         LDm32x/zsTT03Qg2ozz8ciM5CLH6lVt3TElGsd3E3UUlQJp/egjQngC1nfE7x3a+fFT6
         iXLw==
X-Gm-Message-State: AOAM532whAv1bilq93mLufz/P1bdMLjKn4QBLjfIoDSwvzglzA8aHHGo
        Z0QSx5TNC6ph3zOP7jof/xkrmPN7YvCpawtGQKc=
X-Google-Smtp-Source: ABdhPJydN1/yyrmUu2ikdex24yrqp/haJlPqLVzNuZsuWxFMQ+aTNF98dXKzdj0poxCOJsvYWtRPog==
X-Received: by 2002:a05:6512:ad6:: with SMTP id n22mr16229304lfu.532.1629476100485;
        Fri, 20 Aug 2021 09:15:00 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id q5sm277153lfg.36.2021.08.20.09.14.59
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Aug 2021 09:14:59 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id l18so10573656lji.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Aug 2021 09:14:59 -0700 (PDT)
X-Received: by 2002:ac2:5a1a:: with SMTP id q26mr15105739lfn.41.1629475615982;
 Fri, 20 Aug 2021 09:06:55 -0700 (PDT)
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
 <CAHk-=wgHbYmUZvFkthGJ6zZx+ofTiiTRxPai5mPkmbtE=6JbaQ@mail.gmail.com> <20210820094301.62421e21@oasis.local.home>
In-Reply-To: <20210820094301.62421e21@oasis.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 20 Aug 2021 09:06:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi5xeN3fxfjqZu9HjhiMKfMJDeqniDU+S_ZigTG0uo3iA@mail.gmail.com>
Message-ID: <CAHk-=wi5xeN3fxfjqZu9HjhiMKfMJDeqniDU+S_ZigTG0uo3iA@mail.gmail.com>
Subject: Re: Removing Mandatory Locks
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jeff Layton <jlayton@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        David Hildenbrand <david@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
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
        Geert Uytterhoeven <geert@linux-m68k.org>,
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

On Fri, Aug 20, 2021 at 6:43 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Thu, 19 Aug 2021 15:32:31 -0700
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> >
> > I don't know if distros have some pattern we could use that would end
> > up being something that gets reported to the user?
>
> People have started using my trace-printk notice message, that seems to
> be big enough to get noticed.

Well, I think people who use ftrace are m,ore likely to look at kernel
messages than most...

So what would be more interesting is if there's some distro support
for showing kernel notifications..

I see new notifications for calendar events, for devices that got
mounted, for a lot of things - so I'm really wondering if somebody
already perhaps had something for specially formatted kernel
messages..

               Linus
