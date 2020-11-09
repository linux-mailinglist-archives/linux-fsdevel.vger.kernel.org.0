Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B626A2AAEC0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Nov 2020 02:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728952AbgKIB1c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Nov 2020 20:27:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbgKIB1b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Nov 2020 20:27:31 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB77C0613CF;
        Sun,  8 Nov 2020 17:27:31 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id d12so5509372wrr.13;
        Sun, 08 Nov 2020 17:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=u7fInsN0dgMnu8fAzY3wCxL0kCoLw+dIKIcs/otIlLI=;
        b=I+fNSTPnsAaAKQZ6jCM216iJlQaqEshpzb1n7Mk0P0CzlKQVMW0yctSJF0EwFXMlTJ
         xiLFwqnKmh4YBtL+D8FXupnP4Tt4qz8hnFFA+Zi0IxhETDvazYwh8PBeTwEGF0Jbd/MN
         0KeOnzLJElwt3V54PiLjaXC6sg/kF9o44dqzyg4MH9mIpR6ihoh3sRYnEZpCwBK7EAV+
         9OjQek2GVeQdyqXRPNWyTxly4jN7Cz4gJNwSWokksnvR/vIrVX4YMEcKVYWlRXyZQI8m
         f7e7Erjbc7dYLgaqoHqX7av0f3wI/G5yM5xMauv+C2BRKfQHdxgTLYS9nAo6nDzxphoU
         O1+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u7fInsN0dgMnu8fAzY3wCxL0kCoLw+dIKIcs/otIlLI=;
        b=DUyckTAsaGuNfI3c8F9erYEyftyQMFuBYIWP+jT7FtaD8n1Cus/CCf7eruPhPA6F5Q
         v7v9bhuomgx9F9IUKdjf6J6JivVW5MiIEekKWVbG8+ytuWGIwdd7ncPHVOlxSmco+JBt
         sj+uJUHFsx6Le8TOPrzUKTvq5XHy3tDuOJJccY5UdAOvjIAt3vxxVWE7D/HFj4DARF3F
         PDa5QwPZV0v41Gw1KqCS/SS+6ARfQF0gIvOb/FYS4JLWKPbdHx1VIYeEVnbD0WRgwIiH
         6rdFNWpfZFWfS97gRzNWlFYqvCXcGkZAFwgOSsV5MppvSWhXSU+YBztkE3n7y+b+TDd0
         fkbg==
X-Gm-Message-State: AOAM533QipIwYde1RofJ8VrTU8/ziwkAXDdCYJjMm/qbyVnsqHIpWKz7
        XFvGHuk+AZSTYC+/Er3FqO24XYAkF6fYG6yE
X-Google-Smtp-Source: ABdhPJzVg+gmDJzxRv9nWXxxORjkO64NczFwI57Z0tklrXqaLtacHGCcCQ9AtIipvSYgKtq3GdUBFw==
X-Received: by 2002:adf:9069:: with SMTP id h96mr15983096wrh.358.1604885249587;
        Sun, 08 Nov 2020 17:27:29 -0800 (PST)
Received: from ?IPv6:2a02:8084:e84:2480:228:f8ff:fe6f:83a8? ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id g17sm11485885wrw.37.2020.11.08.17.27.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Nov 2020 17:27:28 -0800 (PST)
Subject: Re: [PATCH 00/19] Add generic user_landing tracking
To:     Andy Lutomirski <luto@kernel.org>, Dmitry Safonov <dima@arista.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>, X86 ML <x86@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "David S. Miller" <davem@davemloft.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>
References: <20201108051730.2042693-1-dima@arista.com>
 <CALCETrW-hHyh3nF3ATmy61PCy1iFqVhVYX+-ptBCMP5Bf7aJ0w@mail.gmail.com>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
Message-ID: <9f416ebd-2535-1b57-7033-e1755e906743@gmail.com>
Date:   Mon, 9 Nov 2020 01:27:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CALCETrW-hHyh3nF3ATmy61PCy1iFqVhVYX+-ptBCMP5Bf7aJ0w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/8/20 7:07 PM, Andy Lutomirski wrote:
> On Sat, Nov 7, 2020 at 9:17 PM Dmitry Safonov <dima@arista.com> wrote:
>>
>> Started from discussion [1], where was noted that currently a couple of
>> architectures support mremap() for vdso/sigpage, but not munmap().
>> If an application maps something on the ex-place of vdso/sigpage,
>> later after processing signal it will land there (good luck!)
>>
>> Patches set is based on linux-next (next-20201106) and it depends on
>> changes in x86/cleanups (those reclaim TIF_IA32/TIF_X32) and also
>> on my changes in akpm (fixing several mremap() issues).
>>
>> Logically, the patches set divides on:
>> - patch       1: cleanup for patches in x86/cleanups
>> - patches  2-11: cleanups for arch_setup_additional_pages()
> 
> I like these cleanups, although I think you should stop using terms
> like "new-born".  A task being exec'd is not newborn at all -- it's in
> the middle of a transformation.

Thank you for looking at them, Andy :-)

Yeah, somehow I thought about new-execed process as a new-born binary.
I'll try to improve changelogs in v2.

Thanks,
         Dmitry
