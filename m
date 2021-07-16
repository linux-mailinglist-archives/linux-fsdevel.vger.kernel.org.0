Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC1ED3CB727
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 14:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbhGPMNC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jul 2021 08:13:02 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58664 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbhGPMNC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jul 2021 08:13:02 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7D637205E6;
        Fri, 16 Jul 2021 12:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1626437405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gn3NzijDyMlTSPv52ZJ0rg5uPOpBL0bDagguSlAodGg=;
        b=ZvOAHYYXDTqPqXQyYOZg674ICk3W48WdlIZ65ZjAwAbcaeJfY7OcOfcL19sIh2wMHxSnke
        Jx/WnJtDrz8zRQZYvZpfrrds6j0bbN0knxYwTVS+Be5odK6TRC+EGwUn/ye2YR+JFMmYzP
        rqnY4TpeaXnYvfYDzWH3eOXdH0t7LYw=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 358BF13AE4;
        Fri, 16 Jul 2021 12:10:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id oHZ4CR138WBAKwAAGKfGzw
        (envelope-from <nborisov@suse.com>); Fri, 16 Jul 2021 12:10:05 +0000
Subject: Re: [PATCH] vfs: Optimize dedupe comparison
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        david@fromorbit.com, djwong@kernel.org
References: <20210715141309.38443-1-nborisov@suse.com>
 <YPBGoDlf9T6kFjk1@casper.infradead.org>
 <7c4c9e73-0a8b-5621-0b74-1bf34e4b4817@suse.com>
 <YPBPkupPDnsCXrLU@casper.infradead.org>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <255720dc-01d2-e778-4c91-5868cd7f6a80@suse.com>
Date:   Fri, 16 Jul 2021 15:10:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YPBPkupPDnsCXrLU@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 15.07.21 г. 18:09, Matthew Wilcox wrote:
> On Thu, Jul 15, 2021 at 05:44:15PM +0300, Nikolay Borisov wrote:
>> That was my first impression, here's the profile:
>>
>>        │    Disassembly of section .text:
>>        │
>>        │    ffffffff815c6f60 <memcmp>:
>>        │    memcmp():
>>        │      test   %rdx,%rdx
>>        │    ↓ je     22
>>        │      xor    %ecx,%ecx
>>        │    ↓ jmp    12
>>  49.32 │ 9:   add    $0x1,%rcx
>>   0.03 │      cmp    %rcx,%rdx
>>  11.82 │    ↓ je     21
>>   0.01 │12:   movzbl (%rdi,%rcx,1),%eax
>>  38.19 │      movzbl (%rsi,%rcx,1),%r8d
>>   0.59 │      sub    %r8d,%eax
>>   0.04 │    ↑ je     9
> 
> That looks like a byte loop to me ...
> 
>> It's indeed on x86-64 and according to the sources it's using
>> __builtin_memcmp according to arch/x86/boot/string.h
> 
> I think the 'boot' part of that path might indicate that it's not what's
> actually being used by the kernel.
> 
> $ git grep __HAVE_ARCH_MEMCMP
> arch/arc/include/asm/string.h:#define __HAVE_ARCH_MEMCMP
> arch/arm64/include/asm/string.h:#define __HAVE_ARCH_MEMCMP
> arch/csky/abiv2/inc/abi/string.h:#define __HAVE_ARCH_MEMCMP
> arch/powerpc/include/asm/string.h:#define __HAVE_ARCH_MEMCMP
> arch/s390/include/asm/string.h:#define __HAVE_ARCH_MEMCMP       /* arch function */
> arch/s390/lib/string.c:#ifdef __HAVE_ARCH_MEMCMP
> arch/s390/purgatory/string.c:#define __HAVE_ARCH_MEMCMP /* arch function */
> arch/sparc/include/asm/string.h:#define __HAVE_ARCH_MEMCMP
> include/linux/string.h:#ifndef __HAVE_ARCH_MEMCMP
> lib/string.c:#ifndef __HAVE_ARCH_MEMCMP
> 
> So I think x86-64 is using the stupid one.
> 
>>> Can this even happen?  Surely we can only dedup on a block boundary and
>>> blocks are required to be a power of two and at least 512 bytes in size?
>>
>> I was wondering the same thing, but AFAICS it seems to be possible i.e
>> if userspace spaces bad offsets, while all kinds of internal fs
>> synchronization ops are going to be performed on aligned offsets, that
>> doesn't mean the original ones, passed from userspace are themselves
>> aligned explicitly.
> 
> Ah, I thought it'd be failed before we got to this point.
> 
> But honestly, I think x86-64 needs to be fixed to either use
> __builtin_memcmp() or to have a nicely written custom memcmp().  I
> tried to find the gcc implementation of __builtin_memcmp() on
> x86-64, but I can't.

__builtin_memcmp is a no go due to this function being an ifunc [0]
 and is being resolved to a call to memcmp which causes link => build
failures. So what remains is to either patch particular sites or as Dave
suggested have a generic optimized implementation.

glibc's implementation [1] seems straightforward enough to be
convertible to kernel style. However it would need definitive proof it
actually improves performance in a variety of scenarios.

[0] https://sourceware.org/glibc/wiki/GNU_IFUNC
[1] https://sourceware.org/git/?p=glibc.git;a=blob;f=string/memcmp.c

> 
