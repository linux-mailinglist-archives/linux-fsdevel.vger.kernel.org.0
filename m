Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCCE3F9048
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Aug 2021 23:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243650AbhHZVsC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Aug 2021 17:48:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21402 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243620AbhHZVsB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Aug 2021 17:48:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630014433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K0s8bk6QfHD1VaGSzfIqDqYg0K6iJ7Ku0EqSDBa9+yo=;
        b=apJmwZhW/m/hDBuscxMKnlE+cXDvfUXnlcaVeFhttxxHXAkUFT1esOw/UwK1O6RjUm4zq/
        WZ0TWlp1Iy3MxG8uziMz70u8kNbQBYLk7NmDel8C4CM/42R0RE4T4yarCnhtNBbuVO+zeQ
        51KrJEBV2ufA5JZAU+XjaR5QDxniq30=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-jVC2jPHNN6OTC4y69DiqKw-1; Thu, 26 Aug 2021 17:47:12 -0400
X-MC-Unique: jVC2jPHNN6OTC4y69DiqKw-1
Received: by mail-wr1-f69.google.com with SMTP id v6-20020adfe4c6000000b001574f9d8336so1313569wrm.15
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Aug 2021 14:47:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=K0s8bk6QfHD1VaGSzfIqDqYg0K6iJ7Ku0EqSDBa9+yo=;
        b=fLP0mWYeay7SAKryQTZo17rt/BTcBkd3Jcy+ywHZ4l/eXgXBb77SzpXZmwddmYo0db
         3Fqm7YMp5dHe7IUQqb3Jj396utVUUBE79lkpKlGGe9a5TwcsDteBh8YoB7EyViDoM9L+
         TSeh3jfyraL25b8pnIlYl4IySxCtIchmKbuFvHYFFvQi9UTeY0HQf53jHf3Fh4N40Dfp
         I9G6e3GtRYVQFXIsDcb6tsNXKoyyNaHyoE6Rq3k8+UIAmsoXiyQfFjtRq6WaoCsdH1HE
         q8RmlwuJLKzvDY60ohd4UW7fQi7bHpSlRDo/bkhuPDfwjls6AsMvCwQbC4kPIY/mEBQS
         oecg==
X-Gm-Message-State: AOAM530aA5byfFfVthJqKKnEJZ1+ACr2bl9UNCZr9P/Cvs4thIxWhcLP
        JW6JODj5Wtnfb2SRHrX/FMisgFVAbFRHGmy7GXwRMl792Hgq+QkZ/DOzsj4F6eXDKVwCPThqmsr
        tEt28HdTlXhAQTheiw+DLPzSMZQ==
X-Received: by 2002:a5d:690a:: with SMTP id t10mr6609898wru.304.1630014430899;
        Thu, 26 Aug 2021 14:47:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyZSDS7ykz6c0cWQQRRV6c/ocWUVA2MbQuhyj4tL0c/EqpuZXrSGG6H7whtDXAvdDs+XQeksw==
X-Received: by 2002:a5d:690a:: with SMTP id t10mr6609835wru.304.1630014430662;
        Thu, 26 Aug 2021 14:47:10 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23dec.dip0.t-ipconnect.de. [79.242.61.236])
        by smtp.gmail.com with ESMTPSA id q10sm3612286wmq.12.2021.08.26.14.47.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Aug 2021 14:47:10 -0700 (PDT)
Subject: Re: [PATCH v1 0/7] Remove in-tree usage of MAP_DENYWRITE
To:     Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        David Laight <David.Laight@aculab.com>,
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
        "linux-unionfs@vger.kernel.org" <linux-unionfs@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        linux-fsdevel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        Florian Weimer <fweimer@redhat.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
References: <20210812084348.6521-1-david@redhat.com> <87o8a2d0wf.fsf@disp2133>
 <60db2e61-6b00-44fa-b718-e4361fcc238c@www.fastmail.com>
 <87lf56bllc.fsf@disp2133>
 <CAHk-=wgru1UAm3kAKSOdnbewPXQMOxYkq9PnAsRadAC6pXCCMQ@mail.gmail.com>
 <87eeay8pqx.fsf@disp2133> <5b0d7c1e73ca43ef9ce6665fec6c4d7e@AcuMS.aculab.com>
 <87h7ft2j68.fsf@disp2133>
 <CAHk-=whmXTiGUzVrTP=mOPQrg-XOi3R-45hC4dQOqW4JmZdFUQ@mail.gmail.com>
 <b629cda1-becd-4725-b16c-13208ff478d3@www.fastmail.com>
 <CAHk-=wiJ0u33h2CXAO4b271Diik=z4jRt64=Gt6YV2jV4ef27g@mail.gmail.com>
 <b60e9bd1-7232-472d-9c9c-1d6593e9e85e@www.fastmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <0ed69079-9e13-a0f4-776c-1f24faa9daec@redhat.com>
Date:   Thu, 26 Aug 2021 23:47:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <b60e9bd1-7232-472d-9c9c-1d6593e9e85e@www.fastmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 26.08.21 19:48, Andy Lutomirski wrote:
> On Fri, Aug 13, 2021, at 5:54 PM, Linus Torvalds wrote:
>> On Fri, Aug 13, 2021 at 2:49 PM Andy Lutomirski <luto@kernel.org> wrote:
>>>
>>> I’ll bite.  How about we attack this in the opposite direction: remove the deny write mechanism entirely.
>>
>> I think that would be ok, except I can see somebody relying on it.
>>
>> It's broken, it's stupid, but we've done that ETXTBUSY for a _loong_ time.
> 
> Someone off-list just pointed something out to me, and I think we should push harder to remove ETXTBSY.  Specifically, we've all been focused on open() failing with ETXTBSY, and it's easy to make fun of anyone opening a running program for write when they should be unlinking and replacing it.
> 
> Alas, Linux's implementation of deny_write_access() is correct^Wabsurd, and deny_write_access() *also* returns ETXTBSY if the file is open for write.  So, in a multithreaded program, one thread does:
> 
> fd = open("some exefile", O_RDWR | O_CREAT | O_CLOEXEC);
> write(fd, some stuff);
> 
> <--- problem is here
> 
> close(fd);
> execve("some exefile");
> 
> Another thread does:
> 
> fork();
> execve("something else");
> 
> In between fork and execve, there's another copy of the open file description, and i_writecount is held, and the execve() fails.  Whoops.  See, for example:
> 
> https://github.com/golang/go/issues/22315
> 
> I propose we get rid of deny_write_access() completely to solve this.
> 
> Getting rid of i_writecount itself seems a bit harder, since a handful of filesystems use it for clever reasons.
> 
> (OFD locks seem like they might have the same problem.  Maybe we should have a clone() flag to unshare the file table and close close-on-exec things?)
> 

It's not like this issue is new (^2017) or relevant in practice. So no 
need to hurry IMHO. One step at a time: it might make perfect sense to 
remove ETXTBSY, but we have to be careful to not break other user space 
that actually cares about the current behavior in practice.

-- 
Thanks,

David / dhildenb

