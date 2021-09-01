Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 082443FD565
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Sep 2021 10:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243257AbhIAI3G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Sep 2021 04:29:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23161 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232792AbhIAI3C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Sep 2021 04:29:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630484885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=urXf/lsujl5mpSnmr3xeWIt4stnv1XjbfuMO6ZCP2KA=;
        b=iNZiwmasCBpWQOw/JrKv5P12Rl9xVv9+MuSK6TxEvhVWBvYrL9lDMnIVxT/IH2E05tCMH6
        qVwfPCwF6IUuK9s29vIQL9N5K+v4ZwviQ7YB8QKAk2XQ9qgKKJgfXCe0cgsoSEvOroc3ME
        ENykzBBD5GWnht+JYPTEnl07CpsYfpM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-589-4QKl_4xoOG2n8T0ctMJoRA-1; Wed, 01 Sep 2021 04:28:04 -0400
X-MC-Unique: 4QKl_4xoOG2n8T0ctMJoRA-1
Received: by mail-wr1-f72.google.com with SMTP id v18-20020adfe2920000b029013bbfb19640so517481wri.17
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Sep 2021 01:28:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=urXf/lsujl5mpSnmr3xeWIt4stnv1XjbfuMO6ZCP2KA=;
        b=nDGfuODkEPOlVUWnbntuPf8IhyWV9evXzk1wqvGhvGoOGj+cmHrKvpSV7+VD5PBtiJ
         GCpmSBVGcfawZr74rlyX3/+yVzfzyJypwjoBxfYu3YsZoQNLNb0lWyiVOaom4rmFz68M
         32O/ljfY/8YDACtV0NErhbNayTwiLwamIhko5XgpzdtrbPs8N5sy+Gz6y1e66cmDbWWN
         s1awZMdZkFUqUawR8gQbOd44LGLJQihrCGmPgazT5sDUheqxB+I4NGwlnVTe3U3DOrvJ
         j/8Cnb2d3dW+LS131RvDN7kouava6EjnSO7dQo2CXvV3h8OH89BWwCuraytDYqDMpQAS
         IPRg==
X-Gm-Message-State: AOAM531PHbhyJAzNdis5F/l9Q5UQc0YxJFQnKMqMk5tTvaKSAq8IiELr
        mLBgS6Sv0PKWU/95SqSiZynKOMEbuSg835fR5p7n0sC2VgdDhpBs2fJhmPy9A4mX6QGi1CF7caV
        HS9FhpK2KxIrNFp/ySl79Twr4CQ==
X-Received: by 2002:a5d:63d2:: with SMTP id c18mr36140369wrw.240.1630484883089;
        Wed, 01 Sep 2021 01:28:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwlbF4D3fGzYRuLDlt/6l/uQWEWI7qpyhqVbwr1jujGUThxUVQleu8elgEn7R9xymi0rU9RmA==
X-Received: by 2002:a5d:63d2:: with SMTP id c18mr36140350wrw.240.1630484882874;
        Wed, 01 Sep 2021 01:28:02 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23f71.dip0.t-ipconnect.de. [79.242.63.113])
        by smtp.gmail.com with ESMTPSA id n3sm5121111wmi.0.2021.09.01.01.28.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 01:28:02 -0700 (PDT)
Subject: Re: [PATCH v1 0/7] Remove in-tree usage of MAP_DENYWRITE
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
 <0ed69079-9e13-a0f4-776c-1f24faa9daec@redhat.com> <87mtp3g8gv.fsf@disp2133>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <a6dbc5b3-b12e-36b4-0aef-f319264d6e8f@redhat.com>
Date:   Wed, 1 Sep 2021 10:28:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87mtp3g8gv.fsf@disp2133>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 27.08.21 00:13, Eric W. Biederman wrote:
> David Hildenbrand <david@redhat.com> writes:
> 
>> On 26.08.21 19:48, Andy Lutomirski wrote:
>>> On Fri, Aug 13, 2021, at 5:54 PM, Linus Torvalds wrote:
>>>> On Fri, Aug 13, 2021 at 2:49 PM Andy Lutomirski <luto@kernel.org> wrote:
>>>>>
>>>>> I’ll bite.  How about we attack this in the opposite direction: remove the deny write mechanism entirely.
>>>>
>>>> I think that would be ok, except I can see somebody relying on it.
>>>>
>>>> It's broken, it's stupid, but we've done that ETXTBUSY for a _loong_ time.
>>>
>>> Someone off-list just pointed something out to me, and I think we should push harder to remove ETXTBSY.  Specifically, we've all been focused on open() failing with ETXTBSY, and it's easy to make fun of anyone opening a running program for write when they should be unlinking and replacing it.
>>>
>>> Alas, Linux's implementation of deny_write_access() is correct^Wabsurd, and deny_write_access() *also* returns ETXTBSY if the file is open for write.  So, in a multithreaded program, one thread does:
>>>
>>> fd = open("some exefile", O_RDWR | O_CREAT | O_CLOEXEC);
>>> write(fd, some stuff);
>>>
>>> <--- problem is here
>>>
>>> close(fd);
>>> execve("some exefile");
>>>
>>> Another thread does:
>>>
>>> fork();
>>> execve("something else");
>>>
>>> In between fork and execve, there's another copy of the open file description, and i_writecount is held, and the execve() fails.  Whoops.  See, for example:
>>>
>>> https://github.com/golang/go/issues/22315
>>>
>>> I propose we get rid of deny_write_access() completely to solve this.
>>>
>>> Getting rid of i_writecount itself seems a bit harder, since a handful of filesystems use it for clever reasons.
>>>
>>> (OFD locks seem like they might have the same problem.  Maybe we should have a clone() flag to unshare the file table and close close-on-exec things?)
>>>
>>
>> It's not like this issue is new (^2017) or relevant in practice. So no
>> need to hurry IMHO. One step at a time: it might make perfect sense to
>> remove ETXTBSY, but we have to be careful to not break other user
>> space that actually cares about the current behavior in practice.
> 
> It is an old enough issue that I agree there is no need to hurry.
> 
> I also ran into this issue not too long ago when I refactored the
> usermode_driver code.  My challenge was not being in userspace
> the delayed fput was not happening in my kernel thread.  Which meant
> that writing the file, then closing the file, then execing the file
> consistently reported -ETXTBSY.
> 
> The kernel code wound up doing:
> 	/* Flush delayed fput so exec can open the file read-only */
> 	flush_delayed_fput();
> 	task_work_run();
> 
> As I read the code the delay for userspace file descriptors is
> always done with task_work_add, so userspace should not hit
> that kind of silliness, and should be able to actually close
> the file descriptor before the exec.
> 
> 
> On the flip side, I don't know how anything can depend upon getting an
> -ETXTBSY.  So I don't think there is any real risk of breaking userspace
> if we remove it.

At least in LTP, we have two test cases testing exactly that behavior:

testcases/kernel/syscalls/creat/creat07.c
testcases/kernel/syscalls/execve/execve04.c


-- 
Thanks,

David / dhildenb

