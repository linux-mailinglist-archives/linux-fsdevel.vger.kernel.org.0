Return-Path: <linux-fsdevel+bounces-50302-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1BD5ACAB4A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 11:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F0D817295C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 09:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A481DF25C;
	Mon,  2 Jun 2025 09:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lICwubug"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D261BEF87;
	Mon,  2 Jun 2025 09:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748856129; cv=none; b=L12uOMbksGaXNs5l9GTSKcz2vni4rne15MyM6HY3SIfgDDwSjfotIEYXWGfKzNK978zJqU5d/eL8JgvK81I/R0YPxW+2Bh0QnWImPkVswwB5quT0blyIMFTLJwzH7qNjQP+tVIBto3Q9aXR+gf5aJ/NG4Jc7r5KlJ7+iEKlS5QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748856129; c=relaxed/simple;
	bh=ifK3xbIKFgcxtP0ovq+mY1V3BtpZhbmCuyvu1jk/4Qk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=BYUb6eY11vZyB0zm+yWBF7mg2cReKyU55Gw8r8JT2/YrKh5vDZU08sBnnApfBODz4iaEOeEQgMxO1k4CnX7jUrpIqH4EtKrkHO3rkzKZMW3vKf8HC6NMUw++JXqAWgek0BV0yQ/F9Qgs5ynXRrfXn3fq0ShY5E2dLQSVZnRMVJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lICwubug; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A579FC4CEEB;
	Mon,  2 Jun 2025 09:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748856128;
	bh=ifK3xbIKFgcxtP0ovq+mY1V3BtpZhbmCuyvu1jk/4Qk=;
	h=Date:Reply-To:Subject:From:To:Cc:References:In-Reply-To:From;
	b=lICwubugffui43uBhTiA2GuR1GI9CkTjcny09G6ay59OQUvedXwANCTe20nhUA8Fk
	 7pKqE6QZlvDDzeHaL6kTEPHsMiRamfdH3tLZcYaZWtSZV1I3zBzmqNtnKxCZzQC+5/
	 ktOStb25vWs9yDXF2SlzizqhHLlLIsTO6jp+NMUMBUkWdMw3z3WJShpX81ON5+AOGc
	 4QarCEq3YH++oSc+k9xr0mkuphjNOHhGJoNIJLDg4HIL69ddu2iFZ5srA6YISumtyD
	 5vBJasgi026w45had/IsiIHyZ5pf0wuHhcrk43cOGAG0xKtzAgSXqdzLy1k7tL5+yt
	 LFfjyI6g7+Uiw==
Message-ID: <76935443-b1b9-496e-bcad-e24f260836a0@kernel.org>
Date: Mon, 2 Jun 2025 11:22:00 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: da.gomez@kernel.org
Subject: Re: xarray regression: XArray: Add extra debugging check to xas_lock
 and friends
From: Daniel Gomez <da.gomez@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>, Matthew Wilcox <willy@infradead.org>
Cc: Daniel Gomez <da.gomez@samsung.com>, Tamir Duberstein <tamird@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, kdevops@lists.linux.dev
References: <aAG_Sz_a2j3ummY2@bombadil.infradead.org>
 <7df55910-13b4-4ac5-b13b-22a44366e193@kernel.org>
Content-Language: en-US
Organization: kernel.org
In-Reply-To: <7df55910-13b4-4ac5-b13b-22a44366e193@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 30/05/2025 08.58, Daniel Gomez wrote:
> On 17/04/2025 19.56, Luis Chamberlain wrote:
>> Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: BUG at xa_alloc_index:57
>> Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: CPU: 1 UID: 0 PID: 874 Comm: modprobe Tainted: G        W           6.15.0-rc2-next-20250417 #5 PREEMPT(full)
>> Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: Tainted: [W]=WARN
>> Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 2024.11-5 01/28/2025
>> Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: Call Trace:
>> Apr 18 02:30:42 e00aeb44aaa1-xarray kernel:  <TASK>
>> Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: dump_stack_lvl (lib/dump_stack.c:122) 
>> Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: xa_alloc_index.constprop.0.cold (lib/test_xarray.c:602) test_xarray 
>> Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: check_xa_alloc_1 (lib/test_xarray.c:940) test_xarray 
>> Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: ? __pfx_xarray_checks (lib/test_xarray.c:2233) test_xarray 
>> Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: check_xa_alloc (lib/test_xarray.c:1106) test_xarray 
>> Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: xarray_checks (lib/test_xarray.c:2250) test_xarray 
>> Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: do_one_initcall (init/main.c:1271) 
>> Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: do_init_module (kernel/module/main.c:2930) 
>> Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: init_module_from_file (kernel/module/main.c:3587) 
>> Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: idempotent_init_module (./include/linux/spinlock.h:351 kernel/module/main.c:3528 kernel/module/main.c:3600) 
>> Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: __x64_sys_finit_module (./include/linux/file.h:62 (discriminator 1) ./include/linux/file.h:83 (discriminator 1) kernel/module/main.c:3622 (discriminator 1) kernel/module/main.c:3609 (discriminator 1) kernel/module/main.c:3609 (discriminator 1)) 
>> Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: do_syscall_64 (arch/x86/entry/syscall_64.c:63 (discriminator 1) arch/x86/entry/syscall_64.c:94 (discriminator 1)) 
>> Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
>> Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: RIP: 0033:0x7f0a99f18779
>> Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 4f 86 0d 00 f7 d8 64 89 01 48
>> All code
>> ========
>>    0:	ff c3                	inc    %ebx
>>    2:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
>>    9:	00 00 00 
>>    c:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
>>   11:	48 89 f8             	mov    %rdi,%rax
>>   14:	48 89 f7             	mov    %rsi,%rdi
>>   17:	48 89 d6             	mov    %rdx,%rsi
>>   1a:	48 89 ca             	mov    %rcx,%rdx
>>   1d:	4d 89 c2             	mov    %r8,%r10
>>   20:	4d 89 c8             	mov    %r9,%r8
>>   23:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
>>   28:	0f 05                	syscall
>>   2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
>>   30:	73 01                	jae    0x33
>>   32:	c3                   	ret
>>   33:	48 8b 0d 4f 86 0d 00 	mov    0xd864f(%rip),%rcx        # 0xd8689
>>   3a:	f7 d8                	neg    %eax
>>   3c:	64 89 01             	mov    %eax,%fs:(%rcx)
>>   3f:	48                   	rex.W
>>
>> Code starting with the faulting instruction
>> ===========================================
>>    0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
>>    6:	73 01                	jae    0x9
>>    8:	c3                   	ret
>>    9:	48 8b 0d 4f 86 0d 00 	mov    0xd864f(%rip),%rcx        # 0xd865f
>>   10:	f7 d8                	neg    %eax
>>   12:	64 89 01             	mov    %eax,%fs:(%rcx)
>>   15:	48                   	rex.W
>> Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: RSP: 002b:00007fffcb2588c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
>> Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: RAX: ffffffffffffffda RBX: 000055e8f735a970 RCX: 00007f0a99f18779
>> Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: RDX: 0000000000000000 RSI: 000055e8e9dd2328 RDI: 0000000000000003
>> Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: RBP: 0000000000000000 R08: 0000000000000000 R09: 000055e8f735c410
>> Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: R10: 0000000000000000 R11: 0000000000000246 R12: 000055e8e9dd2328
>> Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: R13: 0000000000040000 R14: 000055e8f735aa80 R15: 0000000000000000
>> Apr 18 02:30:42 e00aeb44aaa1-xarray kernel:  </TASK>
> 
> Also, since xas stays invalid, xa_destroy() skips setting XA_FREE_MARK (via
> xas_init_marks()), which I think is needed because we declared the array with
> XA_FLAGS_TRACK_FREE flag in DEFINE_XARRAY_ALLOC(xa0).

To clarify this: because XA_FREE_MARK is skipped in xa_destroy(), the next
xa_alloc_index()->xa_alloc() call will return a different index than the one
requested (base) and XA_BUG_ON(xa, id != index) check will fail.

