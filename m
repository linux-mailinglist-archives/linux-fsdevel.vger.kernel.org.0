Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9F658F0A3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Aug 2022 18:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbiHJQpW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Aug 2022 12:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbiHJQpV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Aug 2022 12:45:21 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9FB13FB6;
        Wed, 10 Aug 2022 09:45:20 -0700 (PDT)
Received: from [192.168.58.158] (unknown [43.245.8.143])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3D75B6601C6F;
        Wed, 10 Aug 2022 17:45:02 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1660149918;
        bh=ADpakFyntTu99bJzdscZwFQJz67HrXhODiRO4Yo+iOI=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=lKdpcLsk+CEqi1feuozbCvLy9PorC/6CTbR+EZZbN8BUSPMDV+pWYORnjs8zYZ5cQ
         QW5tCSakmDw7Bd5vVbCyiNDr5uw255ZDqOCOf1A+Rp6yfR8gqE170BNTf9IiSgyCYx
         liuew+5mFZt5vJYS9+Op9FUeF6CpmFt6bqcrb032wgRXiCKLLmUcRFdMUoImwf6MjG
         Q4cY431DqQNJtV6dQ+VjAEb8uLbqlHx+wTRKhkkKivBLIYpvEOK+izDbtG3uoynwiQ
         TtXaDP1rctfUMitL60FRBtlVdrbP/Luo6qigN5naPnELJorUr/VET9wKhEB4IKqjwH
         RBJxKF8DmRwnQ==
Message-ID: <89bbe03c-694d-f8b7-f4d9-38277b48bd22@collabora.com>
Date:   Wed, 10 Aug 2022 21:44:55 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Cc:     usama.anjum@collabora.com,
        "kernel@collabora.com" <kernel@collabora.com>
Subject: Re: [PATCH 0/5] Add process_memwatch syscall
Content-Language: en-US
To:     "Peter.Enderborg@sony.com" <Peter.Enderborg@sony.com>,
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
        <linux-kselftest@vger.kernel.org>,
        "krisman@collabora.com" <krisman@collabora.com>
References: <20220726161854.276359-1-usama.anjum@collabora.com>
 <456a8052-dfd2-e00c-6da7-fb5aa0c35f2c@sony.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <456a8052-dfd2-e00c-6da7-fb5aa0c35f2c@sony.com>
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

On 8/10/22 2:22 PM, Peter.Enderborg@sony.com wrote:
> On 7/26/22 18:18, Muhammad Usama Anjum wrote:
>> Hello,
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
>> - The soft-dirty PTE bit of only a part of memory cannot be cleared.
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
>>
> 
> Why can it not be done as a IOCTL?
It can be done as ioctl. I think this syscall can be used in future for
adding other operations like soft-dirty. This is why syscall has been added.

-- 
Muhammad Usama Anjum
