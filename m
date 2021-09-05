Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C33F401155
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Sep 2021 21:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238343AbhIETJS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Sep 2021 15:09:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44514 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238411AbhIETI7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Sep 2021 15:08:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630868874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GBTVYvl6r/DGTmkrkWcHeYmKn9Wnjnzo76ZSWSpnbek=;
        b=DzfLsnZ/I0qwKmbI3/47aGIvEaUuMxwHRpADRwVVMH4IleKQbRGM0rWZ87jg7a0x/IYBGg
        c7HXSbPxRDSnQyd8WLVQzCMq+kvWegrda9fe5wPCCyyLdhhSOu7RcQRh6d1U9g9XikWJY2
        ZMLvq/jWtukVVitB0P4r965Q6+YwI14=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-QMxcIWNKMu-B3MSAfSii3g-1; Sun, 05 Sep 2021 15:07:52 -0400
X-MC-Unique: QMxcIWNKMu-B3MSAfSii3g-1
Received: by mail-wm1-f70.google.com with SMTP id s197-20020a1ca9ce000000b002e72ba822dcso2885940wme.6
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 Sep 2021 12:07:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=GBTVYvl6r/DGTmkrkWcHeYmKn9Wnjnzo76ZSWSpnbek=;
        b=qqzJbLivR0uhE3lqgnffx3lEP/3zFP3R51KH5pIeBJFB/Il2SdGw+U6Osgw4m5NKWI
         5M8FJuNW7iaYpHzRTYgyDHcoZxNF0BXBJUh/5UxG7A0Ehe12oxCOzFyaVq8MMv00ic7O
         63v//ggDrByW944dCjA0lGxHGIQZdzgCTC0r0dqJFs6/tRyv7mdUOfRxtsTaiP/hj6F8
         qzj682kX2AzZrYOEwLD0/MAhJSljKNK1XMBfAsJjv8OpeynyjT37gYPWHmp277EoOJ7a
         bpSKe/nW0qyvTtBN2Ut1xidqFs2ceWbEuxTKAFVp+fC6ut5h2BDYHomu9iYBhayPWXnd
         zDjA==
X-Gm-Message-State: AOAM532kVtH3qwGWy/Tdh5PyFbu6YfHEmVTGk/EAGrgicWNwJQauIZqa
        A2FSUI118ohyBCoju7BUd1uiEDMcfBRvnXefrlj43eww9xut0kxS53nxPn2FZnwKhQ966C1CsuZ
        rmmQ2S3HGHi5LfnEyV6x3+uUkEQ==
X-Received: by 2002:adf:916f:: with SMTP id j102mr9428572wrj.422.1630868871731;
        Sun, 05 Sep 2021 12:07:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwJKpXpbX8Zx9j1c0iF75tnA3gLF7m6WMhftI7dZFfieFpkJUATagtI6L+4VC8O/dknnYxpxg==
X-Received: by 2002:adf:916f:: with SMTP id j102mr9428550wrj.422.1630868871507;
        Sun, 05 Sep 2021 12:07:51 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6f04.dip0.t-ipconnect.de. [91.12.111.4])
        by smtp.gmail.com with ESMTPSA id i20sm5300193wml.37.2021.09.05.12.07.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Sep 2021 12:07:51 -0700 (PDT)
Subject: Re: [PATCH v2 1/7] binfmt: don't use MAP_DENYWRITE when loading
 shared libraries via uselib()
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
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
        =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        David Laight <David.Laight@aculab.com>,
        linux-unionfs@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20210816194840.42769-1-david@redhat.com>
 <20210816194840.42769-2-david@redhat.com>
 <20210905153229.GA3019909@roeck-us.net>
 <CAHk-=whO-dnNxz5H8yfnGsNxrDHu-TVQq-X-VwhoDyWu3Lgnyg@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <77b36c45-773b-3cb8-fa18-45f0914c3090@redhat.com>
Date:   Sun, 5 Sep 2021 21:07:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=whO-dnNxz5H8yfnGsNxrDHu-TVQq-X-VwhoDyWu3Lgnyg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 05.09.21 19:17, Linus Torvalds wrote:
> On Sun, Sep 5, 2021 at 8:32 AM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> Guess someone didn't care compile testing their code. This is now in
>> mainline.
> 
> To be fair, a.out is disabled pretty much on all relevant platforms these days.

Yes, and it seems like it was disabled in all configs I used. (I did not 
compile all-yes configs; usually my stuff goes via -mm where it will end 
up in -next for a while ... this one was special)

> 
> Only alpha and m68k left, I think.
> 
> I applied the obvious patch from Geert.

Thanks Linus!


-- 
Thanks,

David / dhildenb

