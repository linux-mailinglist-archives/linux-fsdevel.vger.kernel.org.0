Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64BBE3EAA3A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 20:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbhHLS16 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 14:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbhHLS15 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 14:27:57 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7477C061756
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Aug 2021 11:27:31 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id z11so11068961edb.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Aug 2021 11:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IkXJUR2wo/lfdijzxf9i2+gB15K2x3AMKk03NvuHrAg=;
        b=DgletMF3GIx03R+Prc+kYYByk45jic0DRscnKADZUoHI1P+YyPtvtoPTQ7QnJ7IPQd
         SXOSwOUdkx2aiZaMFMOp1dhadasdgIRxU7GtFMCT7AGdEYsSqpb/znDsiIrZCbOQNfg4
         VzUm5rt2KFFchQnCpyiuGLbfU1kLNH4SQV4x0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IkXJUR2wo/lfdijzxf9i2+gB15K2x3AMKk03NvuHrAg=;
        b=i/BIGV0smBVAFsMai11FZLdEIGtswNHmjuhPDUVLVw9Ab90sgDp5b+1bvZpriSAbg0
         EySj/PLaqVnFvd/2zx93rS2qPI0grEjEpn0I7VN6Yd0SDb5gyE+ZbUJxMZESbY+X4RLz
         jREfRXfMr8m0xxBhZDTwDNmVmYE4/H3rkl3XwIVyAVXmqVIx66IVOykoH5tvPzkauTQo
         2mu6TY5PLtBCk3xMcNohI33Am7TCloRkE+nmRW92m3Ym5QDX3bCdgwEqDa55sCQGoIcG
         TvsnFFWfs8xTKYjtCzMGYBuaxluKEbHXPMGndA1eR55LmgGuNqGckVEf4c3jgtqr2lmd
         dpJQ==
X-Gm-Message-State: AOAM5324yuzxq85FUHEalrNl9wYIAzTbRzyE32GR6Dbb5+9lkt5htBc0
        ZETcKTCdt2N+Bzfm76cM9v77XExvUa6U6XlPHD4=
X-Google-Smtp-Source: ABdhPJw9pUufejeBRVkF1l8BrqBqsEyo2xrPDHLkjojZ0ikYIf1cWFVVGY1j2AHPWYe69PcnmK3NjA==
X-Received: by 2002:aa7:d404:: with SMTP id z4mr6955413edq.255.1628792850268;
        Thu, 12 Aug 2021 11:27:30 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id b11sm1110494eja.104.2021.08.12.11.27.30
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 11:27:30 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id bo19so11070061edb.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Aug 2021 11:27:30 -0700 (PDT)
X-Received: by 2002:a2e:944c:: with SMTP id o12mr3785844ljh.411.1628792497006;
 Thu, 12 Aug 2021 11:21:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210812084348.6521-1-david@redhat.com> <87o8a2d0wf.fsf@disp2133>
 <60db2e61-6b00-44fa-b718-e4361fcc238c@www.fastmail.com> <87lf56bllc.fsf@disp2133>
 <87lf56edgz.fsf@oldenburg.str.redhat.com>
In-Reply-To: <87lf56edgz.fsf@oldenburg.str.redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 12 Aug 2021 08:21:20 -1000
X-Gmail-Original-Message-ID: <CAHk-=wifW=eDZdOdydRTmupzzJj=6A+Z5dLFrjM3Hfmxj6DfyA@mail.gmail.com>
Message-ID: <CAHk-=wifW=eDZdOdydRTmupzzJj=6A+Z5dLFrjM3Hfmxj6DfyA@mail.gmail.com>
Subject: Re: [PATCH v1 0/7] Remove in-tree usage of MAP_DENYWRITE
To:     Florian Weimer <fweimer@redhat.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
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
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mike Rapoport <rppt@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Michel Lespinasse <walken@google.com>,
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
        Collin Fijalkovich <cfijalkovich@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Chengguang Xu <cgxu519@mykernel.net>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        linux-unionfs@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 12, 2021 at 8:16 AM Florian Weimer <fweimer@redhat.com> wrote:
>
> I think this is called MAP_COPY:
>
>   <https://www.gnu.org/software/hurd/glibc/mmap.html>

Please don't even consider the crazy notions that GNU Hurd did.

It's a fundamental design mistake. The Hurd VM was horrendous, and
MAP_COPY was a prime example of the kinds of horrors it had.

I'm not sure how much of the mis-designs were due to Hurd, and how
much of it due to Mach 3. But please don't point to Hurd VM
documentation except possibly to warn people. We want people to
_forget_ those mistakes, not repeat them.

          Linus
