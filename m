Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE6423EA4C5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 14:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237054AbhHLMje (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 08:39:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20106 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235563AbhHLMja (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 08:39:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628771945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sbqGKseWRRYhbY2LGrYsEOQPjgQ6ehV+W5zF3jgNGfg=;
        b=cyMImLTLaArjT4LGx0T0mtmk4mEV59XFkyZlVepb5PTUKQ5Gz+CPnKK/jbEVGrNMNCULJi
        mwb+8sUz1bUgBg7zwlaQ3Crzv+m+rI+x5UMgxGlByD8YL5/sCeWQh9mN9dNKdTtavREJvA
        0rfno5rxB+EptaNxrLi0ttX+qKyisfY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-564-AeOQ-rpKPO6w26TwvTb1RA-1; Thu, 12 Aug 2021 08:39:04 -0400
X-MC-Unique: AeOQ-rpKPO6w26TwvTb1RA-1
Received: by mail-wm1-f72.google.com with SMTP id z18-20020a1c7e120000b02902e69f6fa2e0so1782969wmc.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Aug 2021 05:39:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=sbqGKseWRRYhbY2LGrYsEOQPjgQ6ehV+W5zF3jgNGfg=;
        b=GFqIKNBhDu77fGyJho6i7mwbRKln2MVgz9UmDe6LXnfvqAfKDyg1umygpi8OSQINLI
         +EaZCDbwWOOQJKp+8QVw/dBbPm+uKbbxnuQ9buT38A3YEclcCZOiriLq/0/IRPtBrSYS
         H8Z/zbhyZ3QS2smWWgnSTJZiLm04czThxWFXD6/d55ku48tH/yVIy8UJ5m0lcYEZu0Bg
         4diSmCyi5P3xt9GTQuiiEtayXYTHHT2iEYgpYjAZlPoP8PtEj+bDiO59DolPRz8oNDQY
         l2qWnlBa37gwYKN+gVMXz7g0l603V4FfHWYOvz4vxe6TOHckJr2yYdv0vn5JeI13lXLz
         Rv7A==
X-Gm-Message-State: AOAM530+930HHfeQK65gYVgoYGAgHxdaBeF3/2P5P5JHl6YZcBPZyPc/
        b/F6w5EwgM1Qtmv7dccZKxFeBURc4KTE37Cp4jjL2rBz614RclfWyoVUo3MVdwWvpxdjlrRNW9y
        0nPU0t3gG4ni8u1LBozJExMjIVg==
X-Received: by 2002:adf:db83:: with SMTP id u3mr3880775wri.363.1628771942739;
        Thu, 12 Aug 2021 05:39:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxDcYmjDSU043EHzDh1omoow7kdOXdSFpNIKh9fkmzaYfVhQ8MrQo4AHUXle/AZphgQiUXdsA==
X-Received: by 2002:adf:db83:: with SMTP id u3mr3880754wri.363.1628771942458;
        Thu, 12 Aug 2021 05:39:02 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23d8b.dip0.t-ipconnect.de. [79.242.61.139])
        by smtp.gmail.com with ESMTPSA id d18sm2297940wrb.16.2021.08.12.05.38.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 05:39:01 -0700 (PDT)
Subject: Re: [PATCH v1 3/7] kernel/fork: always deny write access to current
 MM exe_file
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
        linux-unionfs@vger.kernel.org, linux-api@vger.kernel.org,
        x86@kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Andrei Vagin <avagin@gmail.com>
References: <20210812084348.6521-1-david@redhat.com>
 <20210812084348.6521-4-david@redhat.com>
 <20210812100544.uhsfp75b4jcrv3qx@wittgenstein>
 <1b6d27cf-2238-0c1c-c563-b38728fbabc2@redhat.com>
 <20210812123239.trksnm57owzwzokj@wittgenstein>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <59b6be94-c7d0-0535-1348-4e9c7f188d20@redhat.com>
Date:   Thu, 12 Aug 2021 14:38:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210812123239.trksnm57owzwzokj@wittgenstein>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12.08.21 14:32, Christian Brauner wrote:
> On Thu, Aug 12, 2021 at 12:13:44PM +0200, David Hildenbrand wrote:
>> On 12.08.21 12:05, Christian Brauner wrote:
>>> [+Cc Andrei]
>>>
>>> On Thu, Aug 12, 2021 at 10:43:44AM +0200, David Hildenbrand wrote:
>>>> We want to remove VM_DENYWRITE only currently only used when mapping the
>>>> executable during exec. During exec, we already deny_write_access() the
>>>> executable, however, after exec completes the VMAs mapped
>>>> with VM_DENYWRITE effectively keeps write access denied via
>>>> deny_write_access().
>>>>
>>>> Let's deny write access when setting the MM exe_file. With this change, we
>>>> can remove VM_DENYWRITE for mapping executables.
>>>>
>>>> This represents a minor user space visible change:
>>>> sys_prctl(PR_SET_MM_EXE_FILE) can now fail if the file is already
>>>> opened writable. Also, after sys_prctl(PR_SET_MM_EXE_FILE), the file
>>>
>>> Just for completeness, this also affects PR_SET_MM_MAP when exe_fd is
>>> set.
>>
>> Correct.
>>
>>>
>>>> cannot be opened writable. Note that we can already fail with -EACCES if
>>>> the file doesn't have execute permissions.
>>>>
>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>> ---
>>>
>>> The biggest user I know and that I'm involved in is CRIU which heavily
>>> uses PR_SET_MM_MAP (with a fallback to PR_SET_MM_EXE_FILE on older
>>> kernels) during restore. Afair, criu opens the exe fd as an O_PATH
>>> during dump and thus will use the same flag during restore when
>>> opening it. So that should be fine.
>>
>> Yes.
>>
>>>
>>> However, if I understand the consequences of this change correctly, a
>>> problem could be restoring workloads that hold a writable fd open to
>>> their exe file at dump time which would mean that during restore that fd
>>> would be reopened writable causing CRIU to fail when setting the exe
>>> file for the task to be restored.
>>
>> If it's their exe file, then the existing VM_DENYWRITE handling would have
>> forbidden these workloads to open the fd of their exe file writable, right?
> 
> Yes.
> 
>> At least before doing any PR_SET_MM_MAP/PR_SET_MM_EXE_FILE. But that should
>> rule out quite a lot of cases we might be worried about, right?
> 
> Yes, it rules out the most obvious cases. The problem is really just
> that we don't know how common weirder cases are. But that doesn't mean
> we shouldn't try and risk it. This is a nice cleanup and playing
> /proc/self/exe games isn't super common.
> 

Right, and having the file your executing opened writable isn't 
something very common as well.

If we really run into problems, we could not protect the new file when 
issuing PR_SET_MM_MAP/PR_SET_MM_EXE_FILE. But I'd like to avoid that, if 
possible, because it feels like working around something that never 
should have worked that way and is quite inconsistent.

-- 
Thanks,

David / dhildenb

