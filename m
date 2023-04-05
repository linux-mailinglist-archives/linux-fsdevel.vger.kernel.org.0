Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D736D72D1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Apr 2023 06:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236628AbjDEEB2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Apr 2023 00:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjDEEB1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Apr 2023 00:01:27 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9254E2D4C;
        Tue,  4 Apr 2023 21:01:25 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id A74AE604EF;
        Wed,  5 Apr 2023 06:01:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1680667283; bh=IgJOAynHdpBcJANHd4LhT2DF4QA7Z5iub7IhRy4wabA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=eYcPNmjSeNb97qGJWuPzaW/cRW9nzJr1Ld2xlLZPr10ni+AFcRGQWatKGnQPaAslI
         KUiHvQh20P5XG6eBMuENPeqhjXLiieN4yzqG2+oDk4IuHQutvWBirEJQFM1f2/UvfW
         T3UVyFZRpwVJUdOW7W2QYJAbbC3l4vpaHoLjhw+sjPsRy/P8rZKBe0azn/BZAyWTtz
         XTRvtCv3YT+tTRMo2prkkXstqqLGBHRGQDZydWfW6jDao/xSmNDZux6Cs70o/a71+j
         Xm6gQCd9sn41JnfD8ObSqBUEqzJ4LzcJswJ1S4TvlwXnQGj/VRn+8WAH4/w1mmBu9e
         nXV97rG2vR5+Q==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5hiR95S7h1fN; Wed,  5 Apr 2023 06:01:21 +0200 (CEST)
Received: from [192.168.1.4] (unknown [94.250.188.177])
        by domac.alu.hr (Postfix) with ESMTPSA id E5949604ED;
        Wed,  5 Apr 2023 06:01:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1680667281; bh=IgJOAynHdpBcJANHd4LhT2DF4QA7Z5iub7IhRy4wabA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=iSsis4HXkP+AQvhnySz1lbJEIKApmtHqbJIwT9PAbt1s/hAmf7rF9QCl5gEPhSekl
         QBLSCWf54FJM7qPBruCYoSpSVpeWC52afGsk6gQ8IAqJNsF9O9yM2w8wj+x/Z9zJO6
         tX5qEXq13Qaux/XzpsRdmijPWrz5leVcotbyu51xuVU6n5u/KjwVxpF2i981ArCsra
         tQ6BzaRYTo9TKGdHSNeqLs1TfMqLHjEABRFElGyG237pgguco7wO9Ix9bZpOjEohb9
         6Ft3HWl3zjoeRUL8FKXacFCFbZFv0sW0mX2c33O/HQNeHrhtxyDFlrx/dSnSBDbn8C
         skT8duR2LaiwA==
Message-ID: <6e8cf1cf-44bd-9d17-1c9d-d25c02f614fc@alu.unizg.hr>
Date:   Wed, 5 Apr 2023 06:01:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [BUG RESEND] [BISECTED]: selftest: ftracetest: memleak in
 vfs_write()
Content-Language: en-US, hr
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
References: <ca4dca01-66ce-c1a9-23cd-9d83b0d2c4b0@alu.unizg.hr>
 <76134d9f-a5ba-6a0d-37b3-28310b4a1e91@alu.unizg.hr>
 <20230404220744.GB1893@sol.localdomain>
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <20230404220744.GB1893@sol.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 05. 04. 2023. 00:07, Eric Biggers wrote:
> Hi Mirsad,
> 
> On Tue, Apr 04, 2023 at 09:52:10PM +0200, Mirsad Goran Todorovac wrote:
>>   backtrace:
>>     [<ffffffffb4afb23c>] slab_post_alloc_hook+0x8c/0x3e0
>>     [<ffffffffb4b02b19>] __kmem_cache_alloc_node+0x1d9/0x2a0
>>     [<ffffffffb4a77785>] __kmalloc+0x55/0x160
>>     [<ffffffffb493a913>] tracing_log_err+0x1a3/0x1d0
>>     [<ffffffffb4959049>] append_filter_err.isra.13+0x119/0x190
>>     [<ffffffffb495a89f>] create_filter+0xbf/0xe0
>>     [<ffffffffb495ab10>] create_event_filter+0x10/0x20
>>     [<ffffffffb495c040>] set_trigger_filter+0xa0/0x180
>>     [<ffffffffb495d745>] event_trigger_parse+0xf5/0x160
>>     [<ffffffffb495c889>] trigger_process_regex+0xc9/0x120
>>     [<ffffffffb495c976>] event_trigger_write+0x86/0xf0
>>     [<ffffffffb4b52dc2>] vfs_write+0xf2/0x520
>>     [<ffffffffb4b533d8>] ksys_write+0x68/0xe0
>>     [<ffffffffb4b5347e>] __x64_sys_write+0x1e/0x30
>>     [<ffffffffb586619c>] do_syscall_64+0x5c/0x90
>>     [<ffffffffb5a000ae>] entry_SYSCALL_64_after_hwframe+0x72/0xdc
>>
>> Please find the complete debug info at the URL:
>>
>> https://domac.alu.unizg.hr/~mtodorov/linux/bugreports/ftracetest/
>>
>> Bisect log is [edited]:
>>
>>> git bisect good a92ce570c81dc0feaeb12a429b4bc65686d17967
>>> # good: [c6f613e5f35b0e2154d5ca12f0e8e0be0c19be9a] ipmi/watchdog: use strscpy() to instead of strncpy()
>>> git bisect good c6f613e5f35b0e2154d5ca12f0e8e0be0c19be9a
>>> # good: [90b12f423d3c8a89424c7bdde18e1923dfd0941e] Merge tag 'for-linus-6.2-1' of https://github.com/cminyard/linux-ipmi
>>> git bisect good 90b12f423d3c8a89424c7bdde18e1923dfd0941e
>>> # first bad commit: [71946a25f357a51dcce849367501d7fb04c0465b] Merge tag 'mmc-v6.2' of git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc
>>>
>>> The commit was merged on December 13th 2022.
>>
>> The amount of applied diffs in the culprit commit 71946a25f357a51dcce849367501d7fb04c0465b
>> prevents me from bisecting further - I do not know which changes depend of which, and which
>> can be tested independently.
>>
>> Hopefully I might come up with a reproducer, but I need some feedback first. Maybe there
>> are ways to narrow down the lines of code that could have caused the leaks, yet I am
>> completely new to the kernel/trace subtree.
>>
>> Apologies for not Cc:ing Ulf nine weeks ago, but it was an omission, not deliberate act.
>>
> 
> This looks like an issue with the tracing subsystem.  I appreciate that you've
> now added the tracing maintainers to Cc.  I don't think your bisection to commit
> 71946a25f357 ("Merge tag 'mmc-v6.2' ...") is correct; that looks unrelated.
> 
> - Eric

Hi, Eric,

In the light of Steven's correct fix, you are obviously right, so I will investigate
where the bisect went wrong.

I should have added selftest/ftrace/ftracetest developers already on Jan 27th, and it
would be fixed for 6.2 already :-/

The good news is that I seem to be improving in hunting down the memleaks. Hopefully
I will hunt down a real security exploit?

All the best.

Best regards,
Mirsad

-- 
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu
 
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
The European Union

"I see something approaching fast ... Will it be friends with me?"

