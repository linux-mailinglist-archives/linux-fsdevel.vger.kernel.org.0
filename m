Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC4F1C1D8F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 May 2020 21:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730241AbgEATDz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 May 2020 15:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730120AbgEATDz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 May 2020 15:03:55 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B999FC061A0E
        for <linux-fsdevel@vger.kernel.org>; Fri,  1 May 2020 12:03:54 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id g19so3342376otk.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 May 2020 12:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dV5C6Mdo+d2z1U4ixXFwa14iL+t03v6nPukDTsNC/Pw=;
        b=rZ0wZNpFKPj00rZsGXQ/OEy65W5RTZI1U2mldKOKzrK3O8YxNmuwVKAmgNGlrMSPJh
         dQ3h/11zRchfbBtSsQytLXthXnqjbswFFdOTKhvnJz2vylobGQeZ+LFvJofa3n+r2q6h
         dCWQyfMflvlzhIlaKHECXHUiyMqYb5bOSgYxPZbKUIJ6kUtcquH4lk62KWBOPOZ0l2ly
         3GJhN0ZjLbVF5/vkNCtpBlDafYpeOL+d8ft0arZhky+HvLzbqIp0tD5btouJClcvo4hf
         7MIo2rkjDqc6lk3WUSAmT2r4xYoI+Vso+T69h2J6g+m95bxiajkPrGm0RbCSU1AKatT5
         HKQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dV5C6Mdo+d2z1U4ixXFwa14iL+t03v6nPukDTsNC/Pw=;
        b=cPHPpumcUfoN4gFS2RonkRaS19KuSogOyMXzkEjN766XWKKejWt5apUZnfpcrZiKHr
         zdyIWOk8X/bfxLxAaTM35cWqHtujIBxG9XDn9zLZyn5UXzEMpVbVx/9imn1ydqbOGY3g
         LKk93H17gpUKvGEzX9o/Bvij0FH2Q5SrKbfGSDAE7b/4f0opXBZPW+ldD+RKdX00gI3b
         7ptF4OThyECfR2AyBQgzkxhpcYYy2JovrEiH60mY/514Y+HvxTzE4m4uJkdf1MVSrdTB
         wx5DeaAZxsDBDCzyPh2/ExMXnaNkIzRC7xcm6O9acaUbqKW39ynzMWkvVPUQiGXbFa9q
         Hh7w==
X-Gm-Message-State: AGi0PuaC73EDQhCODLnuZBwCnZyCbrpmo94J/H22K+yqzcOt4k6/37vm
        aHm6B+p7lDpMp2laT3JKMFKK6w==
X-Google-Smtp-Source: APiQypLpF0Ox0IO/qISGXS4LdidPlSkHRJysHJEBrOjiMzScpLoC5A3dEhhOSPrJ9hvlNYHsOmtChQ==
X-Received: by 2002:a05:6830:20d9:: with SMTP id z25mr4236191otq.254.1588359834043;
        Fri, 01 May 2020 12:03:54 -0700 (PDT)
Received: from [192.168.86.21] ([136.62.4.88])
        by smtp.gmail.com with ESMTPSA id c26sm1024801otl.49.2020.05.01.12.03.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2020 12:03:53 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] Fix ELF / FDPIC ELF core dumping, and use mmap_sem
 properly in there
To:     Greg Ungerer <gerg@linux-m68k.org>, Rich Felker <dalias@libc.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Jann Horn <jannh@google.com>, Nicolas Pitre <nico@fluxnic.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linux-sh list <linux-sh@vger.kernel.org>
References: <20200429214954.44866-1-jannh@google.com>
 <20200429215620.GM1551@shell.armlinux.org.uk>
 <CAHk-=wgpoEr33NJwQ+hqK1dz3Rs9jSw+BGotsSdt2Kb3HqLV7A@mail.gmail.com>
 <31196268-2ff4-7a1d-e9df-6116e92d2190@linux-m68k.org>
 <20200430145123.GE21576@brightrain.aerifal.cx>
 <6dd187b4-1958-fc40-73c4-3de53ed69a1e@linux-m68k.org>
From:   Rob Landley <rob@landley.net>
Message-ID: <cff13fb7-5045-4afd-e1d3-58af99d81d5a@landley.net>
Date:   Fri, 1 May 2020 14:09:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <6dd187b4-1958-fc40-73c4-3de53ed69a1e@linux-m68k.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/1/20 1:00 AM, Greg Ungerer wrote:
>> This sounds correct. My understanding of FLAT shared library support
>> is that it's really bad and based on having preassigned slot indices
>> for each library on the system, and a global array per-process to give
>> to data base address for each library. Libraries are compiled to know
>> their own slot numbers so that they just load from fixed_reg[slot_id]
>> to get what's effectively their GOT pointer.

fdpic is to elf what binflt is to a.out, and a.out shared libraries were never
pretty. Or easy.

>> I'm not sure if anybody has actually used this in over a decade. Last
>> time I looked the tooling appeared broken, but in this domain lots of
>> users have forked private tooling that's not publicly available or at
>> least not publicly indexed, so it's hard to say for sure.
> 
> Be at least 12 or 13 years since I last had a working shared library
> build for m68knommu. I have not bothered with it since then, not that I
> even used it much when it worked. Seemed more pain than it was worth.

Shared libraries worked fine with fdpic on sh2 last I checked, it's basically
just ELF PIC with the ability to move the 4 segments (text/rodata/bss/data)
independently of each other. (4 base pointers, no waiting.)

I don't think I've _ever_ used shared binflt libraries. I left myself
breadcrumbs back when I was wrestling with that stuff:

  https://landley.net/notes-2014.html#07-12-2014

But it looks like that last time I touched anything using elf2flt was:

  https://landley.net/notes-2018.html#08-05-2018

And that was just because arm's fdpic support stayed out of tree for years so I
dug up binflt and gave it another go. (It sucked so much I wound up building
static pie for cortex-m, taking the efficiency hit, and moving on. Running pie
binaries on nommu _works_, it's just incredibly inefficient. Since the writeable
and readable segments of the ELF are all relative to the same single base
pointer, you can't share the read-only parts of the binaries without address
remapping, so if you launch 4 instances of PIE bash on nommu you've loaded 4
instances of the bash text and rodata, and of course none of it can even be
demand faulted. In theory shared libraries _do_ help there but I hit some ld.so
bug and didn't want to debug a half-assed solution, so big hammer and moved on
until arm fdpic got merged and fixed it _properly_...)

Rob

P.S. The reason for binflt is bare metal hardware engineers who are conceptually
uncomfortable with software love them, because it's as close to "objcopy -O
binary" as they can get. Meanwhile on j-core we've had an 8k ROM boot loader
that loads vmlinux images and does the ELF relocations for 5 years now, and ever
since the switch to device tree that's our _only_ way to feed a dtb to the
kernel without statically linking it in, so it's ELF all the way down for us.
