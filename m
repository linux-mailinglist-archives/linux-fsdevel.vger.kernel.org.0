Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2081D393B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 May 2020 20:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgENSjw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 May 2020 14:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727785AbgENSjt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 May 2020 14:39:49 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54866C061A0F
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2020 11:39:48 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id 72so3236514otu.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2020 11:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0n2QC4pZht4On7Hf8BM9MQmCusanOijIGIVj0WQ7O4Y=;
        b=wkHOhdSexBTMTj/0UKt+MD8bMtQVtvQuZFiJRX+rahutlZ20r+ZS7Zlpzh6RWESIPA
         sKynQ1cn1CfmybZJBTG+RPrZ3GSMsuFru/0H1LExriaEQAQvWro7s/QaAS7+R4IT2AD1
         kjP62gcBkUG5fVaZl8TAfU0qcUacL1zcSMnfxSKJPAw9lEkYKpp33gltOE2GRd5aDeK9
         Fwi2uBINqyCM1lbDN46wd9Hv5EWLnhWx+78Woaj1uiKfnuyDpzXhaKVkzXCZW72lqf1V
         v1W3E8izbdudvkOOV/umnnH0t555WO15WjZ3cEjgkXkq1OOiXyOGvCqQlBDWZufzHXjr
         BmIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0n2QC4pZht4On7Hf8BM9MQmCusanOijIGIVj0WQ7O4Y=;
        b=c7EnadJeyutYBIVoDbCB3O2V2591XkRlmfCYhDOs+6ifYZlPDRHZGmwb1Ucq7Lv+Oj
         u3NYAbkLoTSaXWO0m4i8x4EzdL9KJShMEMhK/lk0JXztmR/S7Rok+0hNekQC+GzGjhfD
         5UwGDylzRtDk7ERIWRZPuJiiFEweupiIZijsKDtMD0H9sZPjs38iFUE5vx4RdlIeCxni
         ixHnwwgEANRmdm6rE5GyRvpPIOuD5B2tnZjhWmzXIeoKlxps0M5YRgsol/PZEBQ/5qYR
         DteR0RDINC0IOuQGS5u4dQbsPluFTY1nMd0UHGC3iQfMJd/4X3JmKUEm/RMLYShUhSdC
         Vi6w==
X-Gm-Message-State: AOAM533THSHCEmRrb6WSET1C++Yzgs2jGYXlKN7/dWxXRQRhBtWgHwg/
        JBSAQ7mlcEXNWfhre0BnUeWkFQ==
X-Google-Smtp-Source: ABdhPJzUi+2/5kUM5jB4TBphH0ruI7xC5XhSSjSOXdF3paZ7fYazHOU5dPlZNvxyrsSK+5a21hxF9w==
X-Received: by 2002:a9d:20e2:: with SMTP id x89mr4800294ota.110.1589481587267;
        Thu, 14 May 2020 11:39:47 -0700 (PDT)
Received: from [192.168.86.21] ([136.62.4.88])
        by smtp.gmail.com with ESMTPSA id 90sm975745otl.1.2020.05.14.11.39.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2020 11:39:46 -0700 (PDT)
Subject: Re: [PATCH 3/5] exec: Remove recursion from search_binary_handler
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>, dalias@libc.org
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
 <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87v9l4zyla.fsf_-_@x220.int.ebiederm.org>
 <87eerszyim.fsf_-_@x220.int.ebiederm.org>
 <ee83587b-8a1c-3c4f-cc0f-7bc98afabae1@I-love.SAKURA.ne.jp>
 <CAHk-=wgQ2ovXMW=5ZHCpowkE1PwPQSL7oV4YXzBxd6eqNRXxnQ@mail.gmail.com>
 <87sgg6v8we.fsf@x220.int.ebiederm.org>
 <f33135b7-caa2-94f3-7563-fab6a1f5da0f@landley.net>
 <87ftc3lcmw.fsf@x220.int.ebiederm.org>
From:   Rob Landley <rob@landley.net>
Message-ID: <705e28f9-b8ec-4986-bf00-e2892f0272bc@landley.net>
Date:   Thu, 14 May 2020 13:46:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <87ftc3lcmw.fsf@x220.int.ebiederm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/13/20 4:59 PM, Eric W. Biederman wrote:
> Careful with your terminology.  ELF sections are for .o's For
> executables ELF have segments.  And reading through the code it is the
> program segments that are independently relocatable.

Sorry, I have trouble keeping this stuff straight when it's not in front of me.
(I have a paperback copy of the old "linkers and loaders" book and it was the
driest thing I have _ever_ slogged through. Back before the Linux Foundation ate
the FSG I was pushing https://refspecs.linuxbase.org/ to include missing ABI
supplement, I have copies of ones it doesn't collected from now long-dead sites...)

But more recently I've just made puppy eyes at Rich Felker to have him fix this
stuff for me, because I do _not_ retain the terminology here. REL vs RELA vs
PLT, can you have a PLT without a GOT...?

> There is a flag but it is defined per architecture and I don't think one
> of the architectures define it.

They all check for one, but I don't remember there being a #define.

I have a todo item to check more architectures' fdpic binaries, this was from
sh2eb (ala j-core):

  https://github.com/landley/toybox/commit/d61aeaf9e#diff-4442ddbb8949R65

There was the out of tree arm fdpic toolchain from the french guys for cortex-m,
and the original frv paper, and in theory blackfin but nothing they touched ever
got merged upstream anywhere:

In _theory_ you could do fdpic for x86, but as with u-boot for x86 nobody ever
bothers because it's got an x86-only solution. (And then the x86 version of
stuff gets pushed to other platforms because all our device tree files were
GPLed so of course acpi for arm became a thing. Sigh...)

> I looked at ARM and apparently with an MMU ARM turns fdpic binaries into
> PIE executables.  I am not certain why.

Falling back to a more widely tested codepath, I expect. Also maybe it saves 3
registers if all 4 are using the same base register? Map them linearly and it
becomes "single base + offset"? Which of course looses the extra ASLR benefits
the security people wanted, but "undoing what the security people want in the
name of an unmeasurable microbenchmark optimization" is a proud tradition.

Just because the 4 segments are compiled as independently relocatable doesn't
mean they HAVE to be. (You'd think the code would be using different register
numbers to index stuff so you'd STILL be using 4 registers, but I haven't looked
at what arm's doing...)

> The registers passed to the entry point are also different for both
> cases.

From the same machine code chunks? I boggle at what the ld.so fixup is doing then...

> I think it would have been nice if the fdpic support had used a
> different ELF type, instead of a different depending on using a
> different architecture.

This is what you get when a blackfin developer talks to the gnu/binutils developers:

  https://sourceware.org/legacy-ml/binutils/2008-04/msg00350.html

> All that aside the core dumping code looks to be essentially the same
> between binfmt_elf.c and binfmt_elf_fdpic.c.  Do you think people would
> be interested in refactoring binfmt_elf.c and binfmt_elf_fdpic.c so that
> they could share the same core dumping code?

I think merging the two of them together entirely would be a good idea, and
anything that can collapse together I'm happy to regression test on sh2.

I also note that qemu-sh4eb can run these binaries, maybe I can whip up a
qemu-system-sh4eb that runs a nommu fdpic userspace...

[hours later]

Ok, here's me asking Rich Felker a question:

>>> So fdpic binaries run under qemu-sh2eb and there's a qemu-system-sh2eb that
>>> SHOULD also be able to run them under the r2d board emulation, and the kernel
>>> builds fine under the sh2eb compiler but I can't enable fdpic support without
>>> CONFIG_NOMMU, and if I yank that dependency from Kconfig (which only sh2 has,
>>> arm and such do fdpic with or without mmu) the build breaks with:
>>>
>>> /home/landley/toybox/clean/ccc/sh2eb-linux-muslfdpic-cross/bin/sh2eb-linux-muslfdpic-ld:
>>> fs/binfmt_elf_fdpic.o: in function `load_elf_fdpic_binary':
>>> binfmt_elf_fdpic.c:(.text+0x1734): undefined reference to
>>> `elf_fdpic_arch_lay_out_mm'
>>>
>>> The problem is if I switch off CONFIG_MMU in the kernel, buckets of stuff in the
>>> r2d board kernel config changes and suddenly I don't get serial output from the
>>> qemu-system-sh2eb -M r2d boot anymore. Before it was running the kernel but just
>>> failing to run init...

And his response:

>> I don't think qemu-system-sh4eb can boot a nommu kernel. But you don't
>> need to in order to do userspace-only testing. Just build a normal
>> sh4eb kernel. It doesn't need CONFIG_BINFMT_ELF_FDPIC. The normal ELF
>> loader can load FDPIC just fine, because a valid FDPIC ELF file is a
>> valid ELF file, just with more constraints (in same sense a square is
>> a rectangle). The normal ELF loader won't independently float the text
>> and data segments, but that's okay because your emulated system has an
>> MMU and can just map them adjacently like they show up in the ELF file
>> with their untransformed addresses.
>> 
>> Now that I think about it, it's possible that the ARM folks broke this
>> when adding support for enabling CONFIG_BINFMT_ELF_FDPIC with MMU. If
>> so, and you find you really do need the FDPIC loader now because they
>> made the normal ELF loader refuse to do it, I think it will suffice to
>> copy the ARM version of elf_fdpic_arch_lay_out_mm from
>> arch/arm/kernel/elf.c to somewhere it will be compiled on SH.

I.E. testing the kernel fdpic loader under qemu is NOT EASY (because the fdpic
loader refuses to build in a with-mmu context, and the relevant board emulations
refuse to build without), but it can fall back to the conventional ELF loader
which collates the segments and treats fdpic as PIE? (Which... is how qemu-sh2eb
application emulation is loading them...?)

Which was news to me...

> Eric

Rob
