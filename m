Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 102FA400367
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Sep 2021 18:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350013AbhICQff (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Sep 2021 12:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349981AbhICQff (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Sep 2021 12:35:35 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096F8C061575
        for <linux-fsdevel@vger.kernel.org>; Fri,  3 Sep 2021 09:34:35 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id f18so12814020lfk.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Sep 2021 09:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PGwJPrU2ymA9P5fTXacx3Qx7nyhlT5Ql+hJVxARh6kE=;
        b=K1rpsMJtFquFY0qt0aI/UI9kou+zwJyr90hh+Vza9DcECr82hORBsg2aFd3wZYBMyW
         mxSJGjFZE1t/C6jfyYk7elauPxHWpv1yEHosEvvwTsPovx6P/GaYLx1qmSOFYXAnwgSc
         ifABx5ircSoY9atjYL5bS6LS1nIcyTGaPGEEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PGwJPrU2ymA9P5fTXacx3Qx7nyhlT5Ql+hJVxARh6kE=;
        b=iYU23Vj295putqMIRg/fy++csefdXdGXFm1EdLhD7uKb1j3+yECfGli+fZEq4N2Dmg
         t9QnLWjCs839YQEKv3K5isCOic+fpT0VHmTHHatvnAoIPJXT8s/2rdebjqNz5hfCQ64T
         n/zQsXteVTxt5t9pc+RIyPlLTzEVIj9gzZ5eCihvT1ylTntEkOFIAfKq3xAl/UEADXez
         Z+u0VXDozrqDb7+G8h2FilHlObypCKE8NAKBNjsLJM1Q57T55R7aiWxUxhMPinP/tReV
         Ia3FabrOxXuk6/1CWasg0OyGLeA0o63UN7wZs3LxmlSt5UWDWFmRs25es59uC79uJ4s1
         k9xQ==
X-Gm-Message-State: AOAM531KgbL9R4dEp6NNp5PtdYdG19cF4nZPAMViRfy/6zY1fwua99w+
        Aj1WiKhhHX8VD5pYzoK1S8i5xpLKOHvsqH80xYI=
X-Google-Smtp-Source: ABdhPJxl3i0OOZrEsIz4isOsOg+Xqz+8Lz9r23onJ/3anuvZgMscIDOZd3331b2GECgMX9QUviDKnQ==
X-Received: by 2002:a05:6512:38ae:: with SMTP id o14mr3580812lft.227.1630686873246;
        Fri, 03 Sep 2021 09:34:33 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id x13sm596310lfa.260.2021.09.03.09.34.33
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Sep 2021 09:34:33 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id q21so10426814ljj.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Sep 2021 09:34:33 -0700 (PDT)
X-Received: by 2002:a2e:8107:: with SMTP id d7mr3678393ljg.68.1630686392088;
 Fri, 03 Sep 2021 09:26:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210816194840.42769-1-david@redhat.com> <7c57a16b-8184-36a3-fcdc-5e751184827b@redhat.com>
In-Reply-To: <7c57a16b-8184-36a3-fcdc-5e751184827b@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 3 Sep 2021 09:26:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=whghWSYo498cKaK9VLwBKKW0uMynwPT3zpnEG73MfKqUA@mail.gmail.com>
Message-ID: <CAHk-=whghWSYo498cKaK9VLwBKKW0uMynwPT3zpnEG73MfKqUA@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Remove in-tree usage of MAP_DENYWRITE
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

On Fri, Sep 3, 2021 at 2:45 AM David Hildenbrand <david@redhat.com> wrote:
>
> So, how do we want to continue with this? Pick it up for v5.15? Have it
> in -next for a while and eventually pick it up for v5.16?

I'm ok with the series. If you have a git tree, do the normal pull
request, and we can do it for 5.15 and see if anybody notices.

As you say, any final removal of ETXTBSY should be a separate and
later patch on top.

            Linus
