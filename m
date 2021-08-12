Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D65033EA8CC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 18:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233300AbhHLQxB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 12:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhHLQw7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 12:52:59 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3866C061756
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Aug 2021 09:52:33 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id n7so11587766ljq.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Aug 2021 09:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nMdbm1Duu6T2o7Pmii6aGZ5IPzKeI0bawgd87K5hISA=;
        b=XKB75bis9tKuNhHX3eDTMKeSxlvftJ15dFdW/PqjC89Ur4xgXcznCXav012keKDr9q
         uVwQApi3YeYfIStj4+gOxYXeF8i11qPieLQ1yiCkx373DM+kh0ueZlzSltpcrquT6StP
         3ucAz74g4LfHvAL2yjncpx8WOYjTgEkJKVJzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nMdbm1Duu6T2o7Pmii6aGZ5IPzKeI0bawgd87K5hISA=;
        b=lyL45an4TS4nZSFYRwLwsHhb0Rp1oQIcsee5on0CV82CcJJ8SY0Wn3g2aGGdZfnOHh
         /CC74rfuVYW5R+cgshbkztaI4yHsvGv5fKpSAoVhe+NJGaI2KpQlcyRQrYuGatQKOUtj
         ph5zrXnmJ5/gxV8DNtmPH9ii+rWBMK1BPx1iPk5+oBrNeJW2qrxpjFaVk1hWxRiLLxf5
         TiHQb8+PkzqeZ0v5OwGKPi5ghUjROA1mrlHqN8HpPiw0isIPEMRx2vc7jtd1Ak31YQbI
         fK9IfNLuSol6JR69H4z7Ujl6rOt6+L2YAi2qs5cqD4J5x2T2C70/bfFoer7rbR9CVBl+
         vjlA==
X-Gm-Message-State: AOAM533U9NT91Bd+5luchc09Jk29AZ8AOB4hm7f5qJog4YxShMoHk/Wv
        GcGdu3C9Sq5TUqoPLC1hRAfCPRmfDbGmafXf
X-Google-Smtp-Source: ABdhPJzDf5LiyRZgSsS8sGkV5Z7Qf3iCfeL26ZBfLa67eiO5Tnf9lpCQGmSGo0fI+lC3lscPTJT2hw==
X-Received: by 2002:a2e:9007:: with SMTP id h7mr3601900ljg.224.1628787151840;
        Thu, 12 Aug 2021 09:52:31 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id q14sm313930lfr.87.2021.08.12.09.52.28
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 09:52:30 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id h17so11423628ljh.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Aug 2021 09:52:28 -0700 (PDT)
X-Received: by 2002:a05:6512:1290:: with SMTP id u16mr3010715lfs.487.1628787137615;
 Thu, 12 Aug 2021 09:52:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210812084348.6521-1-david@redhat.com> <20210812084348.6521-4-david@redhat.com>
In-Reply-To: <20210812084348.6521-4-david@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 12 Aug 2021 06:51:59 -1000
X-Gmail-Original-Message-ID: <CAHk-=wjWgFbEaE9T0smQu8WKkhrcNZZrghBUQ9441OdMsDg1-w@mail.gmail.com>
Message-ID: <CAHk-=wjWgFbEaE9T0smQu8WKkhrcNZZrghBUQ9441OdMsDg1-w@mail.gmail.com>
Subject: Re: [PATCH v1 3/7] kernel/fork: always deny write access to current
 MM exe_file
To:     David Hildenbrand <david@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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

On Wed, Aug 11, 2021 at 10:45 PM David Hildenbrand <david@redhat.com> wrote:
>
>         /* No ordering required: file already has been exposed. */
> -       RCU_INIT_POINTER(mm->exe_file, get_mm_exe_file(oldmm));
> +       exe_file = get_mm_exe_file(oldmm);
> +       RCU_INIT_POINTER(mm->exe_file, exe_file);
> +       if (exe_file)
> +               deny_write_access(exe_file);

Can we make a helper function for this, since it's done in two different places?

> -       if (new_exe_file)
> +       if (new_exe_file) {
>                 get_file(new_exe_file);
> +               /*
> +                * exec code is required to deny_write_access() successfully,
> +                * so this cannot fail
> +                */
> +               deny_write_access(new_exe_file);
> +       }
>         rcu_assign_pointer(mm->exe_file, new_exe_file);

And the above looks positively wrong. The comment is also nonsensical,
in that it basically says "we thought this cannot fail, so we'll just
rely on it".

If it truly cannot fail, then the comment should give the reason, not
the "we depend on this not failing".

And honestly, I don't see why it couldn't fail. And if it *does* fail,
we cannot then RCU-assign the exe_file pointer with this, because
you'll get a counter imbalance when you do the allow_write_access()
later.

Anyway, do_open_execat() does do deny_write_access() with proper error
checking. I think that is the existing reference that you depend on -
so that it doesn't fail. So the comment could possibly say that the
only caller has done this, but can we not just use the reference
deny_write_access() directly, and not do a new one here?

IOW, maybe there's an extraneous 'allow_write_access()' somewhere that
should be dropped when we do the whole binprm dance in execve()?

             Linus
