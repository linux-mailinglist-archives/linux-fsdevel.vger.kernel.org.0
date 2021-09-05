Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1A12401106
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Sep 2021 19:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238060AbhIERTE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Sep 2021 13:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238030AbhIERTA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Sep 2021 13:19:00 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24D5C061575
        for <linux-fsdevel@vger.kernel.org>; Sun,  5 Sep 2021 10:17:56 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id i6so6065687edu.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 Sep 2021 10:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jpxSclMyPpq3hjTkndeLX+vXWq2jAp6AUp9RJSFInpc=;
        b=gK/q/jXjhkCQnjJcvu9HTWv3Xy/cZUkhrGXV+w6Yieir7RJN0wnXBCgrW7qEaTLfMe
         oYo31t90pvfHuligx33j3D0RxXp6Y2ZbKY0rpcBN0DvbvSQ1EHWrcrgoKint1hxYzqDA
         HGx76j07IWwevhOJYViS08kEj6stJNiezUr3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jpxSclMyPpq3hjTkndeLX+vXWq2jAp6AUp9RJSFInpc=;
        b=KoX8Bo4HXoijPweiwlodjd1mgMD6b0KdA5d7g7zUxFNs0Ft2f9O/4C84Pjgmrasxvl
         iy6FUmkA/bojcPI71id9PU921kfgZHwyXxY93WPv4N4JFcKZ4wzsPYpNZQkYzDwP6ETi
         966BHegNZ2NSjP05N3Hjbpa2tfqPIg/7vlItUguyY0ddoSAr3w6gOZRtira1AbCHFq+F
         2lxI6wZb8A23hDeOaOApplhU6UdoJQlEzJo3Rfbxp3kDJwcGJGnE6fmzqheuxYzzWZOt
         wct3YysYi1xNWd7gfwoCsvvE/mYOpWlUPOtzMCatAypoc91gc2Enfg++ivwv0rH6B6Yb
         K0EA==
X-Gm-Message-State: AOAM5311cyMTq+FgJB/vZ0CsNNngg8OobQudnotRuNDoP8PfnCSQhebI
        OEBrIxpHWuQB8W7wkz28t1IEZPoPkQjB4yRWfj4=
X-Google-Smtp-Source: ABdhPJwzWRe2gNOhxoLNbmPbgp+pYufZdCwjWlGbpJg7P5eRKfz/hU9NUFNhhTwIYjBkX/TmTcJmdw==
X-Received: by 2002:a50:c905:: with SMTP id o5mr9287648edh.250.1630862274906;
        Sun, 05 Sep 2021 10:17:54 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id z8sm2599100ejd.94.2021.09.05.10.17.53
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Sep 2021 10:17:54 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id me10so8412946ejb.11
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 Sep 2021 10:17:53 -0700 (PDT)
X-Received: by 2002:a2e:a7d0:: with SMTP id x16mr7195539ljp.494.1630862262563;
 Sun, 05 Sep 2021 10:17:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210816194840.42769-1-david@redhat.com> <20210816194840.42769-2-david@redhat.com>
 <20210905153229.GA3019909@roeck-us.net>
In-Reply-To: <20210905153229.GA3019909@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 5 Sep 2021 10:17:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=whO-dnNxz5H8yfnGsNxrDHu-TVQq-X-VwhoDyWu3Lgnyg@mail.gmail.com>
Message-ID: <CAHk-=whO-dnNxz5H8yfnGsNxrDHu-TVQq-X-VwhoDyWu3Lgnyg@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] binfmt: don't use MAP_DENYWRITE when loading
 shared libraries via uselib()
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     David Hildenbrand <david@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
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
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mike Rapoport <rppt@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
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
        Michal Hocko <mhocko@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Chengguang Xu <cgxu519@mykernel.net>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        David Laight <David.Laight@aculab.com>,
        linux-unionfs@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 5, 2021 at 8:32 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Guess someone didn't care compile testing their code. This is now in
> mainline.

To be fair, a.out is disabled pretty much on all relevant platforms these days.

Only alpha and m68k left, I think.

I applied the obvious patch from Geert.

            Linus
