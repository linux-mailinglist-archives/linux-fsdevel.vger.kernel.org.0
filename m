Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA703CA0EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 16:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237908AbhGOOrK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 10:47:10 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:48968 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237741AbhGOOrK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 10:47:10 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 206301FE37;
        Thu, 15 Jul 2021 14:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1626360256; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wM/VbYhOEVQz5lr+L3h4QdVxDVwoIL6YfWfktRy4QEQ=;
        b=Y1NIKWeI9Oq5FBxViRkl+leY4UYq1u4NQE5wUX0OsAT1noMkcc3gKm7wUvfaU0rCMu6YKW
        QQS7M9SqQR4aanSeV1zpc0NLRu4VTSJMH+UV8dqWNRCt1AuVb/gu3BE5FnmpRy7CfGGhR1
        UBCewoYyz7+aUN1UsseydbfpuQ2heUk=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id D107313D93;
        Thu, 15 Jul 2021 14:44:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id WaKFML9J8GA/bgAAGKfGzw
        (envelope-from <nborisov@suse.com>); Thu, 15 Jul 2021 14:44:15 +0000
Subject: Re: [PATCH] vfs: Optimize dedupe comparison
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        david@fromorbit.com, djwong@kernel.org
References: <20210715141309.38443-1-nborisov@suse.com>
 <YPBGoDlf9T6kFjk1@casper.infradead.org>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <7c4c9e73-0a8b-5621-0b74-1bf34e4b4817@suse.com>
Date:   Thu, 15 Jul 2021 17:44:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YPBGoDlf9T6kFjk1@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 15.07.21 г. 17:30, Matthew Wilcox wrote:
> On Thu, Jul 15, 2021 at 05:13:09PM +0300, Nikolay Borisov wrote:
>> Currently the comparison method vfs_dedupe_file_range_compare utilizes
>> is a plain memcmp. This effectively means the code is doing byte-by-byte
>> comparison. Instead, the code could do word-sized comparison without
>> adverse effect on performance, provided that the comparison's length is
>> at least as big as the native word size, as well as resulting memory
>> addresses are properly aligned.
> 
> Sounds to me like somebody hasn't optimised memcmp() very well ...
> is this x86-64?
> 

That was my first impression, here's the profile:

       │    Disassembly of section .text:
       │
       │    ffffffff815c6f60 <memcmp>:
       │    memcmp():
       │      test   %rdx,%rdx
       │    ↓ je     22
       │      xor    %ecx,%ecx
       │    ↓ jmp    12
 49.32 │ 9:   add    $0x1,%rcx
  0.03 │      cmp    %rcx,%rdx
 11.82 │    ↓ je     21
  0.01 │12:   movzbl (%rdi,%rcx,1),%eax
 38.19 │      movzbl (%rsi,%rcx,1),%r8d
  0.59 │      sub    %r8d,%eax
  0.04 │    ↑ je     9
       │    ← retq
       │21: ← retq
       │22:   xor    %eax,%eax
       │    ← retq


It's indeed on x86-64 and according to the sources it's using
__builtin_memcmp according to arch/x86/boot/string.h

>> @@ -256,9 +257,35 @@ static int vfs_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
>>  		flush_dcache_page(src_page);
>>  		flush_dcache_page(dest_page);
>>
>> -		if (memcmp(src_addr + src_poff, dest_addr + dest_poff, cmp_len))
>> -			same = false;
>>
>> +		if (!IS_ALIGNED((unsigned long)(src_addr + src_poff), block_size) ||
>> +		    !IS_ALIGNED((unsigned long)(dest_addr + dest_poff), block_size) ||
>> +		    cmp_len < block_size) {
> 
> Can this even happen?  Surely we can only dedup on a block boundary and
> blocks are required to be a power of two and at least 512 bytes in size?

I was wondering the same thing, but AFAICS it seems to be possible i.e
if userspace spaces bad offsets, while all kinds of internal fs
synchronization ops are going to be performed on aligned offsets, that
doesn't mean the original ones, passed from userspace are themselves
aligned explicitly.
> 
>> +			if (memcmp(src_addr + src_poff, dest_addr + dest_poff,
>> +				   cmp_len))
>> +				same = false;
>> +		} else {
>> +			int i;
>> +			size_t blocks = cmp_len / block_size;
>> +			loff_t rem_len = cmp_len - (blocks * block_size);
>> +			unsigned long *src = src_addr + src_poff;
>> +			unsigned long *dst = dest_addr + src_poff;
>> +
>> +			for (i = 0; i < blocks; i++) {
>> +				if (src[i] - dst[i]) {
>> +					same = false;
>> +					goto finished;
>> +				}
>> +			}
>> +
>> +			if (rem_len) {
>> +				src_addr += src_poff + (blocks * block_size);
>> +				dest_addr += dest_poff + (blocks * block_size);
>> +				if (memcmp(src_addr, dest_addr, rem_len))
>> +					same = false;
>> +			}
>> +		}
>> +finished:
>>  		kunmap_atomic(dest_addr);
>>  		kunmap_atomic(src_addr);
>>  unlock:
>> --
>> 2.25.1
>>
> 
