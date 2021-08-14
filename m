Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECA703EC182
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Aug 2021 11:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237639AbhHNJHX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 Aug 2021 05:07:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52804 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237547AbhHNJHW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 Aug 2021 05:07:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628932013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sWOfJKXDv3Msrm1oZtxU2+iL1w42iciVMe2lnnbOuSA=;
        b=IZudabC6+PPKpDqUUOvvZ8dNb0ZZBvTXwtNN1eK/zdOLkV7WwFpgEehA1U9kQXE/KMxvRK
        Pa0/2FXyk6+l3bfTbadv7MmXUvepD3Oj16xecsMatS/gcuhPDvaZBuX0NTZrp14Ac/qqRm
        LBe+MbT7T4FJVXp5e0CyArPy4R8hLNE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-531-p4R7xtDcMNiNjxZczC_Zeg-1; Sat, 14 Aug 2021 05:06:52 -0400
X-MC-Unique: p4R7xtDcMNiNjxZczC_Zeg-1
Received: by mail-wr1-f71.google.com with SMTP id p2-20020a5d48c20000b0290150e4a5e7e0so3546996wrs.13
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Aug 2021 02:06:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=sWOfJKXDv3Msrm1oZtxU2+iL1w42iciVMe2lnnbOuSA=;
        b=Fb7Y+0flpLPckfr5VSzgsHYLSgECxaNfyIx09kEKL+h7rGCGD/iK5peAk7+NdYMvzI
         SbVa2P8CVRB2pf7JlDS/DLZrZNy3VVNquQ39etlqWWXfe71gGfXPJU0Mv6HP+oJzeo24
         l7LhEVvLf8jAuEayLWQnHJq5/Kp/Nde24sa3mM0DfLQMjOq+kgbsGz4W/WDcZKY8g8bu
         nbzgqkkph+WT8AYyaHCs/4kptJy+gT0idpi8AWX0dLUQq28xDHBXTu3m+2GoVDFyXJHI
         N1m7JV/FovwPFCoi832uY207+B/qKrk3GttmfN5bF8/3soY8IqRNOE5uMVoyCcLOdW6U
         J2Nw==
X-Gm-Message-State: AOAM530wXJ9ZZTWUkP/igvnRHuPFALkkQ1hpRd0XsHVo4sC6n6lTP2pv
        NMQK7+428BdP3lN438rlx7rs/I8TUkRSNpmb5K29yh0BrvOXyznMzExoQzBbbcJMhbiwOggH8yU
        OK8oPsxOBDinq4JT1yj/pIQODXg==
X-Received: by 2002:a1c:3b09:: with SMTP id i9mr6361382wma.62.1628932011324;
        Sat, 14 Aug 2021 02:06:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxmRQCvf+Z+ORlo8pa+7ajUFCHPEEEB/g8t9ifOo/hJh3Qa3/emogzOCEyiSbKRsyYXp+6DPg==
X-Received: by 2002:a1c:3b09:: with SMTP id i9mr6361322wma.62.1628932011053;
        Sat, 14 Aug 2021 02:06:51 -0700 (PDT)
Received: from [192.168.3.132] (p4ff2325a.dip0.t-ipconnect.de. [79.242.50.90])
        by smtp.gmail.com with ESMTPSA id l9sm3846322wrt.95.2021.08.14.02.06.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Aug 2021 02:06:50 -0700 (PDT)
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        David Laight <David.Laight@aculab.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
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
        =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
        "linux-unionfs@vger.kernel.org" <linux-unionfs@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        linux-fsdevel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        Florian Weimer <fweimer@redhat.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
References: <87lf56bllc.fsf@disp2133>
 <CAHk-=wgru1UAm3kAKSOdnbewPXQMOxYkq9PnAsRadAC6pXCCMQ@mail.gmail.com>
 <87eeay8pqx.fsf@disp2133> <5b0d7c1e73ca43ef9ce6665fec6c4d7e@AcuMS.aculab.com>
 <87h7ft2j68.fsf@disp2133>
 <CAHk-=whmXTiGUzVrTP=mOPQrg-XOi3R-45hC4dQOqW4JmZdFUQ@mail.gmail.com>
 <b629cda1-becd-4725-b16c-13208ff478d3@www.fastmail.com>
 <CAHk-=wiJ0u33h2CXAO4b271Diik=z4jRt64=Gt6YV2jV4ef27g@mail.gmail.com>
 <CAHk-=wgi2+OSk2_uYwhL56NGzN8t2To8hm+c0BdBEbuBuzhg6g@mail.gmail.com>
 <YRcjCwfHvUZhcKf3@zeniv-ca.linux.org.uk>
 <YRckSj32tCO3nPYI@zeniv-ca.linux.org.uk>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 0/7] Remove in-tree usage of MAP_DENYWRITE
Message-ID: <f65e3462-a5aa-0c77-494b-916eb832ebe1@redhat.com>
Date:   Sat, 14 Aug 2021 11:06:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YRckSj32tCO3nPYI@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 14.08.21 04:02, Al Viro wrote:
> On Sat, Aug 14, 2021 at 01:57:31AM +0000, Al Viro wrote:
>> On Fri, Aug 13, 2021 at 02:58:57PM -1000, Linus Torvalds wrote:
>>> On Fri, Aug 13, 2021 at 2:54 PM Linus Torvalds
>>> <torvalds@linux-foundation.org> wrote:
>>>>
>>>> And nobody really complained when we weakened it, so maybe removing it
>>>> entirely might be acceptable.
>>>
>>> I guess we could just try it and see... Worst comes to worst, we'll
>>> have to put it back, but at least we'd know what crazy thing still
>>> wants it..
>>
>> Umm...  I'll need to go back and look through the thread, but I'm
>> fairly sure that there used to be suckers that did replacement of
>> binary that way (try to write, count on exclusion with execve while
>> it's being written to) instead of using rename.  Install scripts
>> of weird crap and stuff like that...
> 
> ... and before anyone goes off - I certainly agree that using that
> behaviour is not a good idea and had never been one.  All I'm saying
> is that there at least used to be very random (and rarely exercised)
> bits of userland relying upon that behaviour.
> 

Removing it completely is certainly more controversial than limiting it 
to the main executable. I'm mostly happy as long as we get rid of that 
nasty per-VMA handling, because that adds real complexity at places that 
are complicated enough.

Having the remaining deny_write_access()/allow_write_access() at sane 
places now (loading a new binary, exchanging exe_file) looks certainly 
much cleaner and I still consider it a valuable, simple sanity feature 
to have around. I don't think there is any sane use case for modifying 
the main executable, and it seems to be very easy to catch.

For example, besides users that rely on this behavior, in my thinking 
(see the cover letter), especially having a binary not getting changed 
while we're loading it sounds like a very good idea (not saying we would 
expose a way to exploit the kernel if we would allow for modifications 
while in the elf parser, but also not saying we wouldn't because I 
didn't check if there would be a way; at least we already allow it in 
the legacy library loader before mapping the segments with 
MAP_DENYWRITE). And if we decide to keep the behavior while loading the 
executable, keeping it while exe_file is set isn't much added 
code/complexity IMHO.

Long story short, I'd vote for keeping it in, and if we decide to rip it 
out completely, do it a a separate, more careful step.

-- 
Thanks,

David / dhildenb

