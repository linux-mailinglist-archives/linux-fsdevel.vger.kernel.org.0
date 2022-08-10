Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B47658E8FC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Aug 2022 10:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbiHJIpU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Aug 2022 04:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiHJIpT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Aug 2022 04:45:19 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44221ADA5;
        Wed, 10 Aug 2022 01:45:16 -0700 (PDT)
Received: from [192.168.10.7] (unknown [39.45.206.166])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7B0486601BE2;
        Wed, 10 Aug 2022 09:45:06 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1660121114;
        bh=1473869Iv8iu6o+SiEUIxAN5ZWzArP8lHuuYZHC8TEQ=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=VOT3kbYiY90iOsNmwjPKDRcrnhA+Nq+dHr2wUdQ3dp9YXfPoB45lsModbPKyApHkC
         FqBlOolHNZDE+WjJGbgYXMW9exPj0qxxJb+ixSAn890nshpejAJA9F3VE931As8+sK
         x6005gi8H2dMEftgItMtJpNFHI5E0rwISEYaEmkXVeTFZsMdGLpUv/fZqScFXLHSxt
         PrF69uDmhxQOiOzlllAlwWiKiu/Fnpy2Sm4c8YBdhu2x/lEV3arOPAJ+3fOIT9prrM
         lCuNUMzEy2M93qUld/dgvNQf3T9IPenUsGD5zceoYOZ52JX0DIPo7GXaVwqTNv8Pbd
         48dFgrtPO/2BQ==
Message-ID: <a5122af2-90e2-39c5-2d6a-57a4ab8d8f24@collabora.com>
Date:   Wed, 10 Aug 2022 13:45:00 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Cc:     usama.anjum@collabora.com, kernel@collabora.com
Subject: Re: [PATCH 0/5] Add process_memwatch syscall
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>,
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
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20220726161854.276359-1-usama.anjum@collabora.com>
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

On 7/26/22 9:18 PM, Muhammad Usama Anjum wrote:
> Hello,
> 
> This patch series implements a new syscall, process_memwatch. Currently,
> only the support to watch soft-dirty PTE bit is added. This syscall is
> generic to watch the memory of the process. There is enough room to add
> more operations like this to watch memory in the future.
> 
> Soft-dirty PTE bit of the memory pages can be viewed by using pagemap
> procfs file. The soft-dirty PTE bit for the memory in a process can be
> cleared by writing to the clear_refs file. This series adds features that
> weren't possible through the Proc FS interface.
> - There is no atomic get soft-dirty PTE bit status and clear operation
>   possible.
> - The soft-dirty PTE bit of only a part of memory cannot be cleared.
> 
> Historically, soft-dirty PTE bit tracking has been used in the CRIU
> project. The Proc FS interface is enough for that as I think the process
> is frozen. We have the use case where we need to track the soft-dirty
> PTE bit for running processes. We need this tracking and clear mechanism
> of a region of memory while the process is running to emulate the
> getWriteWatch() syscall of Windows. This syscall is used by games to keep
> track of dirty pages and keep processing only the dirty pages. This
> syscall can be used by the CRIU project and other applications which
> require soft-dirty PTE bit information.
> 
> As in the current kernel there is no way to clear a part of memory (instead
> of clearing the Soft-Dirty bits for the entire processi) and get+clear
> operation cannot be performed atomically, there are other methods to mimic
> this information entirely in userspace with poor performance:
> - The mprotect syscall and SIGSEGV handler for bookkeeping
> - The userfaultfd syscall with the handler for bookkeeping
> 
>         long process_memwatch(int pidfd, unsigned long start, int len,
>                               unsigned int flags, void *vec, int vec_len);
Any thoughts?

> 
> This syscall can be used by the CRIU project and other applications which
> require soft-dirty PTE bit information. The following operations are
> supported in this syscall:
> - Get the pages that are soft-dirty.
> - Clear the pages which are soft-dirty.
> - The optional flag to ignore the VM_SOFTDIRTY and only track per page
> soft-dirty PTE bit
> 
> There are two decisions which have been taken about how to get the output
> from the syscall.
> - Return offsets of the pages from the start in the vec
> - Stop execution when vec is filled with dirty pages
> These two arguments doesn't follow the mincore() philosophy where the
> output array corresponds to the address range in one to one fashion, hence
> the output buffer length isn't passed and only a flag is set if the page
> is present. This makes mincore() easy to use with less control. We are
> passing the size of the output array and putting return data consecutively
> which is offset of dirty pages from the start. The user can convert these
> offsets back into the dirty page addresses easily. Suppose, the user want
> to get first 10 dirty pages from a total memory of 100 pages. He'll
> allocate output buffer of size 10 and process_memwatch() syscall will
> abort after finding the 10 pages. This behaviour is needed to support
> Windows' getWriteWatch(). The behaviour like mincore() can be achieved by
> passing output buffer of 100 size. This interface can be used for any
> desired behaviour.
> 
> Regards,
> Muhammad Usama Anjum
> 
> Muhammad Usama Anjum (5):
>   fs/proc/task_mmu: make functions global to be used in other files
>   mm: Implement process_memwatch syscall
>   mm: wire up process_memwatch syscall for x86
>   selftests: vm: add process_memwatch syscall tests
>   mm: add process_memwatch syscall documentation
> 
>  Documentation/admin-guide/mm/soft-dirty.rst   |  48 +-
>  arch/x86/entry/syscalls/syscall_32.tbl        |   1 +
>  arch/x86/entry/syscalls/syscall_64.tbl        |   1 +
>  fs/proc/task_mmu.c                            |  84 +--
>  include/linux/mm_inline.h                     |  99 +++
>  include/linux/syscalls.h                      |   3 +-
>  include/uapi/asm-generic/unistd.h             |   5 +-
>  include/uapi/linux/memwatch.h                 |  12 +
>  kernel/sys_ni.c                               |   1 +
>  mm/Makefile                                   |   2 +-
>  mm/memwatch.c                                 | 285 ++++++++
>  tools/include/uapi/asm-generic/unistd.h       |   5 +-
>  .../arch/x86/entry/syscalls/syscall_64.tbl    |   1 +
>  tools/testing/selftests/vm/.gitignore         |   1 +
>  tools/testing/selftests/vm/Makefile           |   2 +
>  tools/testing/selftests/vm/memwatch_test.c    | 635 ++++++++++++++++++
>  16 files changed, 1098 insertions(+), 87 deletions(-)
>  create mode 100644 include/uapi/linux/memwatch.h
>  create mode 100644 mm/memwatch.c
>  create mode 100644 tools/testing/selftests/vm/memwatch_test.c
> 

-- 
Muhammad Usama Anjum
