Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510E358F129
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Aug 2022 19:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbiHJRFX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Aug 2022 13:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiHJRFW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Aug 2022 13:05:22 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B46E20F5A;
        Wed, 10 Aug 2022 10:05:21 -0700 (PDT)
Received: from localhost (modemcable141.102-20-96.mc.videotron.ca [96.20.102.141])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: krisman)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 227CD66019C1;
        Wed, 10 Aug 2022 18:05:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1660151120;
        bh=4xdK5anslBOIhnkqGW81pncrZ4JdPy+zW5SIE/JLnRY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=h3/E9F9xuu0PQBdbIIIowMiztInzpGA0Sr0/+ERtIQ9Vaj8xol3qxBdNobdQ5OFOQ
         lAbYHUygoM5LQQ5pucfxCdpxQTPn06tCWpoSfjKHlvwjjlSxcMj8Ew2NicpOm1AvJ3
         roEcd73rt3wd9yGwbKMRSMKfTRLj6KFgYIfZ2F4vNor+cpy8eB6hytQGEFPfzNo5Md
         msk+2xH6Fdmd57XrQPJRtVBSL67QF0eySoRR2reLPDjb1MJQU/w+xrfqcTVAbkf3vT
         XqEyOLcJ5t7UXVh9WHIGLYw/NAFIeHfZKTVCtl5iayQ/V09KExOQ4SdIqXZDjGHMtJ
         +LprGiO7NYsdA==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
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
        <linux-kselftest@vger.kernel.org>, kernel@collabora.com
Subject: Re: [PATCH 0/5] Add process_memwatch syscall
References: <20220726161854.276359-1-usama.anjum@collabora.com>
        <95ed1a81-ff8e-2c48-8838-4b3995af51b7@redhat.com>
Date:   Wed, 10 Aug 2022 13:05:13 -0400
In-Reply-To: <95ed1a81-ff8e-2c48-8838-4b3995af51b7@redhat.com> (David
        Hildenbrand's message of "Wed, 10 Aug 2022 11:03:11 +0200")
Message-ID: <87pmh8ghbq.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Hildenbrand <david@redhat.com> writes:

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
>
>> - The soft-dirty PTE bit of only a part of memory cannot be cleared.
>
> Same.
>
> So I'm curious why we need a new syscall for that.

Hi David,

Yes, sure. Though it has to be through an ioctl since we need both input
and output semantics at the same call to keep the atomic semantics.

I answered Peter Enderborg about our concerns when turning this into an
ioctl.  But they are possible to overcome.

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

Yes, we did.  I think Usama can share some numbers.

The problem with userfaultfd, as far as I understand, is that it will
require a second userspace process to be called in order to handle the
annotation that a page was touched, before remapping the page to make it
accessible to the originating process, every time a page is touched.
This context switch is prohibitively expensive to our use case, where
Windows applications might invoke it quite often.  Soft-dirty bit
instead, allows the page tracking to be done entirely in kernelspace.

If I understand correctly, userfaultfd is usefull for VM/container
migration, where the cost of the context switch is not a real concern,
since there are much bigger costs from the migration itself.

Maybe we're missing some feature about userfaultfd that would allow us
to avoid the cost, but from our observations we didn't find a way to
overcome it.

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
> VM_SOFTDIRTY translates to "all pages in this VMA are soft-dirty".

That is something very specific about our use case, and we should
explain it a bit better.  The problem is that VM_SOFTDIRTY modifications
introduce the overhead of the mm write lock acquisition, which is very
visible in our benchmarks of Windows games running over Wine.

Since the main reason for VM_SOFTDIRTY to exist, as far as we understand
it, is to track vma remapping, and this is a use case we don't need to
worry about when implementing windows semantics, we'd like to be able to
avoid this extra overhead, optionally, iff userspace knows it can be
done safely.

VM_SOFTDIRTY is indeed an internal interface.  Which is why we are
proposing to expose the feature in terms of tracking VMA reuse.

Thanks,

-- 
Gabriel Krisman Bertazi
