Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB0F3EAAE1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 21:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233593AbhHLTYd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 15:24:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38345 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229612AbhHLTYc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 15:24:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628796246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8N86vzBdNfGIw1497CO2pBCfWWqdNZr9GKs8Sj+sQpI=;
        b=LIpTaVRmcRILJgdF0PAQaWjGXprX7N0Ib8w/me6HXxfiG5JqvllOzvBf3KB22UwKtmcoth
        0Hc1VCIb9yaOba/LX/p1yvhQWH9xaGC1LHn5+dk6NbqGQ4yZC4fuAMl+v3mGSS1BAGjOlg
        a5fGl4gM6ydAsVcsvsxOHr9yoLeyRiE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-_CJtaTjbOFeAEzUi3vncpA-1; Thu, 12 Aug 2021 15:24:05 -0400
X-MC-Unique: _CJtaTjbOFeAEzUi3vncpA-1
Received: by mail-wm1-f72.google.com with SMTP id f25-20020a1c6a190000b029024fa863f6b0so3740644wmc.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Aug 2021 12:24:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=8N86vzBdNfGIw1497CO2pBCfWWqdNZr9GKs8Sj+sQpI=;
        b=LqKqZLkPkaOsHPyRK2YRnkMfWMq6PmFgk6BthRg/lt4rX3TV2hJR65nqZsJqzqbTKy
         OtdLvZOxvGpM8/X/AFR/CmJ0p8+9fzr+FTp5sK1msPUGT1ZaRs3ZxY7JtfA/o8IRbj8l
         0TDc9FVUhpMitFAquRULpguuDRZzbhj3SnXkQkfIrv/GSw7E9IDqnQOBVXutDr0imBui
         BOJPVOb40RKF7/YPWcXaVthVCawArJjJgIe5zNb5tcXRXiXStXXtKMgIzoKrk8Q0+MGu
         uuAwrlSo9VeTiUyW9OaUrw66lD17Q3ScERWYUUm+YYA4/pkOu8No2ZubBFZ7N62MF7S9
         slYw==
X-Gm-Message-State: AOAM5303Dgf15GQBilzoGxWMLoWA2MXqho7bd6OZx9a7oE3/zIPZ2iwN
        vJnetwtVGfFdZ1XuAb4nBZzSkumcdxRpNtFhf7YMUI6D9mwcpTJDlO180gq9HOvsz43z6WpD88w
        IXJBRwSieJ9wOUhezikwYlaRivA==
X-Received: by 2002:a05:600c:1552:: with SMTP id f18mr160502wmg.40.1628796243839;
        Thu, 12 Aug 2021 12:24:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyoi73TjuPhfXBY9qVs1gNFHq5iS0Cg54p1SYixusgscxJCJ6YZqkOPk8ytKcP9LVXjwJLvRw==
X-Received: by 2002:a05:600c:1552:: with SMTP id f18mr160487wmg.40.1628796243648;
        Thu, 12 Aug 2021 12:24:03 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23d8b.dip0.t-ipconnect.de. [79.242.61.139])
        by smtp.gmail.com with ESMTPSA id m10sm3080907wro.63.2021.08.12.12.24.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 12:24:02 -0700 (PDT)
Subject: Re: [PATCH v1 0/7] Remove in-tree usage of MAP_DENYWRITE
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
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
        =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
        linux-unionfs@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20210812084348.6521-1-david@redhat.com> <87o8a2d0wf.fsf@disp2133>
 <60db2e61-6b00-44fa-b718-e4361fcc238c@www.fastmail.com>
 <87lf56bllc.fsf@disp2133>
 <CAHk-=wgru1UAm3kAKSOdnbewPXQMOxYkq9PnAsRadAC6pXCCMQ@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <0ab1a811-4040-2657-7b48-b39ada300749@redhat.com>
Date:   Thu, 12 Aug 2021 21:24:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgru1UAm3kAKSOdnbewPXQMOxYkq9PnAsRadAC6pXCCMQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12.08.21 20:10, Linus Torvalds wrote:
> On Thu, Aug 12, 2021 at 7:48 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> Given that MAP_PRIVATE for shared libraries is our strategy for handling
>> writes to shared libraries perhaps we just need to use MAP_POPULATE or a
>> new related flag (perhaps MAP_PRIVATE_NOW)
> 
> No. That would be horrible for the usual bloated GUI libraries. It
> might help some (dynamic page faults are not cheap either), but it
> would hurt a lot.

Right, we most certainly don't want to waste system ram / swap space, 
memory for page tables, and degrade performance just because some 
corner-case nasty user space could harm itself.

> 
> This is definitely a "if you overwrite a system library while it's
> being used, you get to keep both pieces" situation.

Right, play stupid games, win stupid prices. I agree that if there would 
be an efficient way to detect+handle such overwrites gracefully, it 
would be great to have the kernel support that. ETXTBUSY as implemented 
with this series (but also before this series) is really only a 
minimalistic approach to help detect some issues regarding the main 
executable.

-- 
Thanks,

David / dhildenb

