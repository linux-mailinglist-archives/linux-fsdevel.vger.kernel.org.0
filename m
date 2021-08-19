Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 136CA3F206E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Aug 2021 21:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233673AbhHSTQO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Aug 2021 15:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234529AbhHSTQN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Aug 2021 15:16:13 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A04C061575
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Aug 2021 12:15:36 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id bt14so15027012ejb.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Aug 2021 12:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3vr2D0SIS0akc317M8AmB5tdttHbmb/GSWHt0r9JCvY=;
        b=Fi8Vc+JQZqNTkTyv3PJfMFM6Rl3+unfpZvxu37FIdnrCAKsddyUIQiihvHMsIlXmmG
         jNbLyQr3wk60i2yKJAYhtkAeCvXwf1kN2XLuYSaEIndqSsXppyqYoBHCIJS+KCfm+Uht
         PTLXKfh+AnNuqTz97gUxnmE0uYiHymupjQB9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3vr2D0SIS0akc317M8AmB5tdttHbmb/GSWHt0r9JCvY=;
        b=QmlJ62+VoFWDk2fJnsJx3h2VJQ9pl1XqnHA1oNe/ZDBZ6gqYPTE1S4YDXEsfTJMjKX
         6iEeB3oF5tdvHFziZZEqWA18mr4JpwAR58TonCE1sGNnFPRmWaQyOvvV0ss9LNqaWx6p
         Bu0f29ns45UY8wlZf+FNYrcZv7OBizRTrJZSFkSA+YCwpPwglklDokCfb4HTabMegYSw
         D8ma4eIHSO8LTG3/cb2GGZEeeasfBhsrLWpxTAp9YmOmqywevAU2t2I2VRs1ERxzngbe
         gsYwBVzfnYhpeW5atNeirHwBCYccRolUXJTF02CiUgMKN5M+F0s2mX/55Jsr/TwdNSYD
         kA5A==
X-Gm-Message-State: AOAM530wDeSJ4xfft/2CYaO/xGtEuYvDHJgJRUObZzWXa0a3RBJKcgfO
        XxcFRm3mPT86KMY9jjq+zCcmgUwGAtBwkEuaKDU=
X-Google-Smtp-Source: ABdhPJyVKNckH1u6DCkoWwz7b2kMZmCeNO0mcPd3cC3vBltssCy8OryBCkQmL+shsvM+AUcSC2+8lQ==
X-Received: by 2002:a17:906:69d0:: with SMTP id g16mr17178655ejs.20.1629400535159;
        Thu, 19 Aug 2021 12:15:35 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id um4sm1682367ejb.92.2021.08.19.12.15.34
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Aug 2021 12:15:34 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id w5so15035759ejq.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Aug 2021 12:15:34 -0700 (PDT)
X-Received: by 2002:a19:4f1a:: with SMTP id d26mr11307760lfb.377.1629400524676;
 Thu, 19 Aug 2021 12:15:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210812084348.6521-1-david@redhat.com> <87o8a2d0wf.fsf@disp2133>
 <60db2e61-6b00-44fa-b718-e4361fcc238c@www.fastmail.com> <87lf56bllc.fsf@disp2133>
 <CAHk-=wgru1UAm3kAKSOdnbewPXQMOxYkq9PnAsRadAC6pXCCMQ@mail.gmail.com>
 <87eeay8pqx.fsf@disp2133> <5b0d7c1e73ca43ef9ce6665fec6c4d7e@AcuMS.aculab.com>
 <87h7ft2j68.fsf@disp2133> <CAHk-=whmXTiGUzVrTP=mOPQrg-XOi3R-45hC4dQOqW4JmZdFUQ@mail.gmail.com>
 <b629cda1-becd-4725-b16c-13208ff478d3@www.fastmail.com> <YRcyqbpVqwwq3P6n@casper.infradead.org>
 <87k0kkxbjn.fsf_-_@disp2133> <0c2af732e4e9f74c9d20b09fc4b6cbae40351085.camel@kernel.org>
In-Reply-To: <0c2af732e4e9f74c9d20b09fc4b6cbae40351085.camel@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 19 Aug 2021 12:15:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgewmbABDC3_ZNn11C+sm4Uz0L9HZ5Kvx0Joho4vsV4DQ@mail.gmail.com>
Message-ID: <CAHk-=wgewmbABDC3_ZNn11C+sm4Uz0L9HZ5Kvx0Joho4vsV4DQ@mail.gmail.com>
Subject: Re: Removing Mandatory Locks
To:     Jeff Layton <jlayton@kernel.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
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

On Thu, Aug 19, 2021 at 11:39 AM Jeff Layton <jlayton@kernel.org> wrote:
>
> I'm all for ripping it out too. It's an insane interface anyway.
>
> I've not heard a single complaint about this being turned off in
> fedora/rhel or any other distro that has this disabled.

I'd love to remove it, we could absolutely test it. The fact that
several major distros have it disabled makes me think it's fine.

But as always, it would be good to check Android.

The desktop distros tend to have the same tools and programs, so if
Fedora and RHEL haven't needed it for years, then it's likely stale in
Debian too (despite being enabled).

But Android tends to be very different. Does anybody know?

            Linus
