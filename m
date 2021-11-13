Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E53844F477
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Nov 2021 19:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235890AbhKMSRl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 13 Nov 2021 13:17:41 -0500
Received: from mail-wm1-f51.google.com ([209.85.128.51]:33536 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233656AbhKMSRk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 13 Nov 2021 13:17:40 -0500
Received: by mail-wm1-f51.google.com with SMTP id r9-20020a7bc089000000b00332f4abf43fso9017764wmh.0;
        Sat, 13 Nov 2021 10:14:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qJpFgDmQX4NgXIPsmsa3L8Op/10DaprZpinixut55a0=;
        b=pMcvvArxOLA28CrlEMufpftzTLA8cj3vWPvsuP3iNk9gyPdl9GXeGdDLFyCYLxDH8N
         BJxISe0UTSE950QzsVrxVWaBnDdraDJtSDmC0StCMpPN00JhPMchvqLCJnvOFRLbawON
         T9iOLxPwu1QlNeHpc59a9ET0CA3KMlkQYQjKbeRqwE3Fb9dluT26Ed49K+qsg3PWVyvB
         TE8jAZrPA7wIC28y+QJ2Z7NGxeaFn5Q0KUaMPCsjgt/aZWtGed88G15bEqatfn/BI++U
         Y2auy4rdh2YwHsoqvNOGCUivw4R1WDrege/UsO4PyfIM1pGJ995aMoBMmRlUticQZWrw
         QHlw==
X-Gm-Message-State: AOAM533LbW+sWr/rpbvSVWfMaVBod3dwQ94pj+GVZ3bk3hUeRiFVKeL/
        N8tavEllbMNMkcD+pt/Q1oI=
X-Google-Smtp-Source: ABdhPJySvDqEIK8+A9iIm0gq0uH+YP8Ng3lmMG7/q64IpdcsRxTBcPM1NXj/RYt+u7AjGEpgcD8v+w==
X-Received: by 2002:a05:600c:4108:: with SMTP id j8mr27714558wmi.139.1636827286595;
        Sat, 13 Nov 2021 10:14:46 -0800 (PST)
Received: from [10.9.0.26] ([46.166.133.199])
        by smtp.gmail.com with ESMTPSA id l18sm9308857wrt.81.2021.11.13.10.14.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Nov 2021 10:14:46 -0800 (PST)
Message-ID: <77b79f0c-48f2-16dd-1d00-22f3a1b1f5a6@linux.com>
Date:   Sat, 13 Nov 2021 21:14:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Reply-To: alex.popov@linux.com
Subject: Re: [PATCH v2 0/2] Introduce the pkill_on_warn parameter
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul McKenney <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>,
        Maciej Rozycki <macro@orcam.me.uk>,
        Muchun Song <songmuchun@bytedance.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>, Wei Liu <wl@xen.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Jann Horn <jannh@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Laura Abbott <labbott@kernel.org>,
        David S Miller <davem@davemloft.net>,
        Borislav Petkov <bp@alien8.de>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Scull <ascull@google.com>,
        Marc Zyngier <maz@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Wang Qing <wangqing@vivo.com>, Mel Gorman <mgorman@suse.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Andrew Klychkov <andrew.a.klychkov@gmail.com>,
        Mathieu Chouquet-Stringer <me@mathieu.digital>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stephen Kitt <steve@sk2.org>, Stephen Boyd <sboyd@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Mike Rapoport <rppt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-hardening@vger.kernel.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>, notify@kernel.org,
        main@lists.elisa.tech, safety-architecture@lists.elisa.tech,
        devel@lists.elisa.tech, Shuah Khan <shuah@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
References: <20211027233215.306111-1-alex.popov@linux.com>
 <ac989387-3359-f8da-23f9-f5f6deca4db8@linux.com>
 <CAHk-=wgRmjkP3+32XPULMLTkv24AkA=nNLa7xxvSg-F0G1sJ9g@mail.gmail.com>
From:   Alexander Popov <alex.popov@linux.com>
In-Reply-To: <CAHk-=wgRmjkP3+32XPULMLTkv24AkA=nNLa7xxvSg-F0G1sJ9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 13.11.2021 00:26, Linus Torvalds wrote:
> On Fri, Nov 12, 2021 at 10:52 AM Alexander Popov <alex.popov@linux.com> wrote:
>>
>> Hello everyone!
>> Friendly ping for your feedback.
> 
> I still haven't heard a compelling _reason_ for this all, and why
> anybody should ever use this or care?

Ok, to sum up:

Killing the process that hit a kernel warning complies with the Fail-Fast 
principle [1]. pkill_on_warn sysctl allows the kernel to stop the process when 
the **first signs** of wrong behavior are detected.

By default, the Linux kernel ignores a warning and proceeds the execution from 
the flawed state. That is opposite to the Fail-Fast principle.
A kernel warning may be followed by memory corruption or other negative effects, 
like in CVE-2019-18683 exploit [2] or many other cases detected by the SyzScope 
project [3]. pkill_on_warn would prevent the system from the errors going after 
a warning in the process context.

At the same time, pkill_on_warn does not kill the entire system like 
panic_on_warn. That is the middle way of handling kernel warnings.
Linus, it's similar to your BUG_ON() policy [4]. The process hitting BUG_ON() is 
killed, and the system proceeds to work. pkill_on_warn just brings a similar 
policy to WARN_ON() handling.

I believe that many Linux distros (which don't hit WARN_ON() here and there) 
will enable pkill_on_warn because it's reasonable from the safety and security 
points of view.

And I'm sure that the ELISA project by the Linux Foundation (Enabling Linux In 
Safety Applications [5]) would support the pkill_on_warn sysctl.
[Adding people from this project to CC]

I hope that I managed to show the rationale.

Best regards,
Alexander


[1]: https://en.wikipedia.org/wiki/Fail-fast
[2]: https://a13xp0p0v.github.io/2020/02/15/CVE-2019-18683.html
[3]: https://www.usenix.org/system/files/sec22summer_zou.pdf
[4]: http://lkml.iu.edu/hypermail/linux/kernel/1610.0/01217.html
[5]: https://elisa.tech/
