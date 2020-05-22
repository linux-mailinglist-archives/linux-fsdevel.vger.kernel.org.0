Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD011DDF04
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 May 2020 06:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgEVEvT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 May 2020 00:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727906AbgEVEvS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 May 2020 00:51:18 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1657C08C5C0
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2020 21:51:18 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id 63so7341702oto.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2020 21:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=k2vrBoOQ9EETAdJub3TPOSyUEEBeAVV+/1nPCZoKSCA=;
        b=YUdG876PBuoWeuTwZEzqf5Q4iudaCv0TLlfWhk+qMWvqkLW/cyTPwaPEXSCHnUaRte
         pqqxOexa01y7orMgoydT8OLYzm6Jnt9aCaPV8ccQw7tonhT5b7nY8saHYgm6Zz7ZaPkS
         /PGE3v6jfnkEl5WmfW3hCIIXtGxEQfqic8sOmuDnhd0YD+YZtVguqKwslNB7SnFmovzc
         1C5xC6JE9bu2U3EEQ8dHyqq1y2Pia3vMvx21LLgND67asnZSWqlGfRb2aXSIWAmxvhv0
         y1yZk+Bu79IaX1jmXOqDkuz1tY+wtwI2TC8pARdarguH2mpqqVcTdOc0qGW7koZkN+MB
         YuHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k2vrBoOQ9EETAdJub3TPOSyUEEBeAVV+/1nPCZoKSCA=;
        b=nO0BKJPhXt488mb7b3S+3byDSzMt9/rUnd+jsGLNm6z3u68ik37TlW3Wd32B+wi/aJ
         B9EstpVZY+o2xwNhUZrrmTUaazWh/1+J9iRnj0bUUm+j/lFh8lAPz/5SKcnkY8M4/qDl
         UBISsuQlUyzFLJDeI00EYeVx5LYxH8nk4p+PFjnOejV2h1lHwt5HhlUZDZPe9qzJjoPF
         3RCFUiYM3vUwynrMqxo26z8bF08vCEQcpsgMi1Ltj0HfplbLN2rZ+4p24TTC29GRvSSa
         Q+P/RxfIV44wOpYJ+iDLonAvh7e2mUdZbsG97xkgvGDT5xsN8FlqdiBBV037CdyHXBWD
         LYNw==
X-Gm-Message-State: AOAM533HEhuA1yNIFa/b9brpWvisv+PKUsKhTykuaOYpY9dgej6l1fAx
        9ze+IT2D/i1SIT4M42Xu36jDdw==
X-Google-Smtp-Source: ABdhPJzkecxfonQTZASI2btg19lTvEFVD3+S1qpuQDgodr0t8yksLVLLZyT9CIvBtnHoK2Ch3kApVQ==
X-Received: by 2002:a05:6830:100a:: with SMTP id a10mr10480942otp.244.1590123077647;
        Thu, 21 May 2020 21:51:17 -0700 (PDT)
Received: from [192.168.86.21] ([136.62.4.88])
        by smtp.gmail.com with ESMTPSA id f3sm2200191otq.20.2020.05.21.21.51.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2020 21:51:16 -0700 (PDT)
Subject: Re: [PATCH v2 7/8] exec: Generic execfd support
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
 <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87v9l4zyla.fsf_-_@x220.int.ebiederm.org>
 <877dx822er.fsf_-_@x220.int.ebiederm.org>
 <87y2poyd91.fsf_-_@x220.int.ebiederm.org>
 <adaced72-d757-e3e4-cfeb-5512533d0aa5@landley.net>
 <874ksaioc6.fsf@x220.int.ebiederm.org>
 <fc2cf2a7-e1a7-3170-32c9-43e593636799@landley.net>
 <87r1vcd4wo.fsf@x220.int.ebiederm.org>
From:   Rob Landley <rob@landley.net>
Message-ID: <6ce125fd-4fb1-8c39-a9a9-098391f2016a@landley.net>
Date:   Thu, 21 May 2020 23:51:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <87r1vcd4wo.fsf@x220.int.ebiederm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/21/20 10:28 PM, Eric W. Biederman wrote:
> 
> Rob Landley <rob@landley.net> writes:
> 
>> On 5/20/20 11:05 AM, Eric W. Biederman wrote:
> 
>> Toybox would _like_ proc mounted, but can't assume it. I'm writing a new
>> bash-compatible shell with nommu support, which means in order to do subshell
>> and background tasks if (!CONFIG_FORK) I need to create a pipe pair, vfork(),
>> have the child exec itself to unblock the parent, and then read the context data
>> that just got discarded through the pipe from the parent. ("Wheee." And you can
>> quote me on that.)
> 
> Do you have clone(CLONE_VM) ?  If my quick skim of the kernel sources is
> correct that should be the same as vfork except without causing the
> parent to wait for you.  Which I think would remove the need to reexec
> yourself.

As with perpetual motion, that only seems like it would work if you don't
understand what's going on.

A nommu system uses physical addresses, not virtual ones, so every process sees
the same addresses. So if I allocate a new block of memory and memcpy the
contents of the old one into the new one, any pointers in the copy point back
into the ORIGINAL block of memory. Trying to adjust the pointers in the copy is
the exact same problem as trying to do garbage collection in C: it's an AI
complete problem.

Any attempt to "implement a full fork" on nommu hits this problem: copying an
existing mapping to a new address range means any address values in the new
mapping point into the OLD mapping. Things like fdpic fix this up at exec time
(traversing elf tables and relocating), but not at runtime. If you can solve the
"relocate at runtime all addresses within an existing mapping, and all other
mappings that might point to this mapping, including local variables on the
stack that point to a structure member or halfway into a string rather than the
start of an allocation, without adjusting unrelated values coincidentally within
RANGE of a mapping" problem, THEN you can fork on a nommu system.

What vfork() does is pause the parent and have the child continue AS the parent
for a bit (with the system call returning 0). The child starts with all the same
memory mappings the parent has (usually not even a new stack). The child has a
new PID and new resources like its own file descriptor table so close() and
open() don't affect the parent, but if you change a global that's visible to the
parent when it resumes (ant often local variables too: don't return from the
function that called vfork() because if you DON'T have a new stack it'll stomp
the return address the parent needs when IT does it). If the child calls
malloc() the parent needs to free it because it's same heap (because same
mapping of the same physical memory).

Then when the child is ready to discard all those mappings (due to calling
either execve() or _exit(), those are the only two options), the parent resumes
from where it left off with the PID of the child as the system call return value.

The reason the child pauses the parent is so only one process is ever using
those mappings at a given time. Otherwise they're acting like threads without
locking, and usually both are sharing a stack.

P.S. You can use threads _instead_ of fork for some stuff on nommu, but that's
its own can of worms. You still need to vfork() when you do create a child
process you're going to exec, so it doesn't go away, you're just requiring
multiple techniques simultaneously to handle a special case.

P.P.S. vfork() is useful on mmu systems to solve the "don't fork from a thread"
problem. You can vfork() from a thread cheaply and reliably and it only pauses
the one thread you forked from, not every thread in the whole process. If you
fork() from a heavily threadded process you can cause a multi-milisecond latency
spike because even with an mmu the copy on write "keep track of what's shared by
what" generally can't handle the "threads AND processes sharing mappings" case,
so it just gives up and copies it all at fork time, in one go, holding a big
lock while doing so. This causes a large latency spike which vfork() avoids.
(And can cause a large wasteful allocation and memory dirtying which is
immediately freed.)

>>> The file descriptor is stored in mm->exe_file.
>>> Probably the most straight forward implementation is to allow
>>> execveat(AT_EXE_FILE, ...).
>>
>> Cool, that works.
>>
>>> You can look at binfmt_misc for how to reopen an open file descriptor.
>>
>> Added to the todo heap.
> 
> Yes I don't think it would be a lot of code.
> 
> I think you might be better served with clone(CLONE_VM) as it doesn't
> block so you don't need to feed yourself your context over a pipe.

Except that doesn't fix it.

Yes I could use threads instead, but the cure is worse than the disease and the
result is your shell background processes are threads rather than independent
processes (is $$ reporting PID or TID, I really don't want to go there).

> Eric

Rob
