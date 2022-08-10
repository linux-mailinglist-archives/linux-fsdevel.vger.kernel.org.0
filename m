Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA1F58F087
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Aug 2022 18:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232987AbiHJQjv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Aug 2022 12:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiHJQju (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Aug 2022 12:39:50 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23B978237;
        Wed, 10 Aug 2022 09:39:47 -0700 (PDT)
Received: from [192.168.58.158] (unknown [43.245.8.143])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9EFB266019C1;
        Wed, 10 Aug 2022 17:39:34 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1660149586;
        bh=ObL6CjqPxDbL6GAZc0g0PSlfpOj2dGXh9yxp6q4FrPI=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=U7pw0d+vqo7SnugcCvMtEGndCil2TW2VfjW9+e8Ujw/u91HO5G6phDbae8v8dQUTa
         FU0cJ1m46EjeidMctlXpmVbjmQdMMQJaGj8GpAUJ1tuB6iKtATlRGO5mDKerRp0giw
         dD4QJD+0ASYON9KJiV83/OXTdff+hll6H2IK7UBLlfktqXg5usg65qnKjr3D0eQZjG
         Ce1Ge3bX3+Rm7iXL+QVlwI7rZsdnmz7behQi5Vn8q3WgeLH4zWQLONKPMBx1N/qEN+
         9yWDOlqUUcd852iuzY+yywIu6ra4wVkXjc+0rl8HxnL8c9mivlKy2LkbZFLdiZ2kLp
         QQk/XX87vEaRg==
Message-ID: <54d4c322-cd6e-eefd-b161-2af2b56aae24@collabora.com>
Date:   Wed, 10 Aug 2022 21:39:26 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Cc:     usama.anjum@collabora.com, kernel@collabora.com
Subject: Re: [PATCH 0/5] Add process_memwatch syscall
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:PROC FILESYSTEM" <linux-fsdevel@vger.kernel.org>,
        "open list:ABI/API" <linux-api@vger.kernel.org>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-perf-users@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, krisman@collabora.com
References: <20220726161854.276359-1-usama.anjum@collabora.com>
 <95ed1a81-ff8e-2c48-8838-4b3995af51b7@redhat.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <95ed1a81-ff8e-2c48-8838-4b3995af51b7@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

Thank you for reviewing and commenting.

On 8/10/22 2:03 PM, David Hildenbrand wrote:
> On 26.07.22 18:18, Muhammad Usama Anjum wrote:
>> Hello,
> 
> Hi,
> 
>>
>> This patch series implements a new syscall, process_memwatch. Currently,
>> only the support to watch soft-dirty PTE bit is added. This syscall is
>> generic to watch the memory of the process. There is enough room to add
>> more operations like this to watch memory in the future.
>>
>> Soft-dirty PTE bit of the memory pages can be viewed by using pagemap
>> procfs file. The soft-dirty PTE bit for the memory in a process can be
>> cleared by writing to the clear_refs file. This series adds features that
>> weren't possible through the Proc FS interface.
>> - There is no atomic get soft-dirty PTE bit status and clear operation
>>   possible.
> 
> Such an interface might be easy to add, no?
Are you referring to ioctl? I think this syscall can be used in future
for adding other operations like soft-dirty. This is why syscall has
been added.

If community doesn't agree, I can translate this syscall to the ioctl
same as it is.

> 
>> - The soft-dirty PTE bit of only a part of memory cannot be cleared.
> 
> Same.
> 
> So I'm curious why we need a new syscall for that.
> 
>>
>> Historically, soft-dirty PTE bit tracking has been used in the CRIU
>> project. The Proc FS interface is enough for that as I think the process
>> is frozen. We have the use case where we need to track the soft-dirty
>> PTE bit for running processes. We need this tracking and clear mechanism
>> of a region of memory while the process is running to emulate the
>> getWriteWatch() syscall of Windows. This syscall is used by games to keep
>> track of dirty pages and keep processing only the dirty pages. This
>> syscall can be used by the CRIU project and other applications which
>> require soft-dirty PTE bit information.
>>
>> As in the current kernel there is no way to clear a part of memory (instead
>> of clearing the Soft-Dirty bits for the entire processi) and get+clear
>> operation cannot be performed atomically, there are other methods to mimic
>> this information entirely in userspace with poor performance:
>> - The mprotect syscall and SIGSEGV handler for bookkeeping
>> - The userfaultfd syscall with the handler for bookkeeping
> 
> You write "poor performance". Did you actually implement a prototype
> using userfaultfd-wp? Can you share numbers for comparison?
> 
> Adding an new syscall just for handling a corner case feature
> (soft-dirty, which we all love, of course) needs good justification.

The cycles are given in thousands. 60 means 60k cycles here which have
been measured with rdtsc().

|   | Region size in Pages | 1    | 10   | 100   | 1000  | 10000  |
|---|----------------------|------|------|-------|-------|--------|
| 1 | MEMWATCH             | 7    | 58   | 281   | 1178  | 17563  |
| 2 | MEMWATCH Perf        | 4    | 23   | 107   | 1331  | 8924   |
| 3 | USERFAULTFD          | 5405 | 6550 | 10387 | 55708 | 621522 |
| 4 | MPROTECT_SEGV        | 35   | 611  | 1060  | 6646  | 60149  |

1. MEMWATCH --> process_memwatch considering VM_SOFTDIRT (splitting is
possible)
2. MEMWATCH Perf --> process_memwatch without considering VM_SOFTDIRTY
3. Userafaultfd --> userfaultfd with handling is userspace
4. Mprotect_segv --> mprotect and signal handler in userspace

Note: Implementation of mprotect_segv is very similar to userfaultfd. In
both of these, the signal/fault is being handled in the userspace. In
mprotect_segv, the memory region is write-protected through mprotect and
SEGV signal is received when something is written to this region. This
signal's handler is where we do calculations about soft dirty pages.
Mprotect_segv mechanism must be lighter than userfaultfd inside kernel.

My benchmark application is purely single threaded to keep effort to a
minimum until we decide to spend more time. It has been written to
measure the time taken in a serial execution of these statements without
locks. If the multi-threaded application is used and randomization is
introduced, it should affect `MPROTECT_SEGV` and `userfaultd`
implementations more than memwatch. But in this particular setting,
memwatch and mprotect_segv perform closely.


> 
>>
>>         long process_memwatch(int pidfd, unsigned long start, int len,
>>                               unsigned int flags, void *vec, int vec_len);
>>
>> This syscall can be used by the CRIU project and other applications which
>> require soft-dirty PTE bit information. The following operations are
>> supported in this syscall:
>> - Get the pages that are soft-dirty.
>> - Clear the pages which are soft-dirty.
>> - The optional flag to ignore the VM_SOFTDIRTY and only track per page
>> soft-dirty PTE bit
> 
> Huh, why? VM_SOFTDIRTY is an internal implementation detail and should
> remain such.
> 
> VM_SOFTDIRTY translates to "all pages in this VMA are soft-dirty".
Clearing soft-dirty bit for a range of memory may result in splitting
the VMA. Soft-dirty bit of the per page need to be cleared. The
VM_SOFTDIRTY flag from this splitted VMA need to be cleared. The kernel
may decide to merge this splitted VMA back. Please note that kernel
doesn't take into account the VM_SOFTDIRTY flag of the VMAs when it
decides to merge the VMAs. This not only gives performance hit, but also
the non-dirty pages of the whole VMA start to appear as dirty again
after the VMA merging. To avoid this penalty,
MEMWATCH_SD_NO_REUSED_REGIONS flag has been added to ignore the
VM_SOFTDIRTY and just rely on the soft-dirty bit present on the per
page. The user is aware about the constraint that the new regions will
not be found dirty if this flag is specified.

> 

-- 
Muhammad Usama Anjum
