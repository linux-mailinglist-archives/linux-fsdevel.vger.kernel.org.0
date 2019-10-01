Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5221EC4135
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2019 21:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfJATkj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Tue, 1 Oct 2019 15:40:39 -0400
Received: from albireo.enyo.de ([37.24.231.21]:38560 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbfJATkj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Oct 2019 15:40:39 -0400
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1iFO0e-0006TH-IP; Tue, 01 Oct 2019 19:40:32 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1iFO0X-0007F7-5W; Tue, 01 Oct 2019 21:40:25 +0200
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Dave Chinner <david@fromorbit.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [bug, 5.2.16] kswapd/compaction null pointer crash [was Re: xfs_inode not reclaimed/memory leak on 5.2.16]
References: <87pnji8cpw.fsf@mid.deneb.enyo.de>
        <20190930085406.GP16973@dread.disaster.area>
        <87o8z1fvqu.fsf@mid.deneb.enyo.de>
        <20190930211727.GQ16973@dread.disaster.area>
        <96023250-6168-3806-320a-a3468f1cd8c9@suse.cz>
Date:   Tue, 01 Oct 2019 21:40:24 +0200
In-Reply-To: <96023250-6168-3806-320a-a3468f1cd8c9@suse.cz> (Vlastimil Babka's
        message of "Tue, 1 Oct 2019 11:10:22 +0200")
Message-ID: <87lfu4i79z.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Vlastimil Babka:

> On 9/30/19 11:17 PM, Dave Chinner wrote:
>> On Mon, Sep 30, 2019 at 09:07:53PM +0200, Florian Weimer wrote:
>>> * Dave Chinner:
>>>
>>>> On Mon, Sep 30, 2019 at 09:28:27AM +0200, Florian Weimer wrote:
>>>>> Simply running “du -hc” on a large directory tree causes du to be
>>>>> killed because of kernel paging request failure in the XFS code.
>>>>
>>>> dmesg output? if the system was still running, then you might be
>>>> able to pull the trace from syslog. But we can't do much without
>>>> knowing what the actual failure was....
>>>
>>> Huh.  I actually have something in syslog:
>>>
>>> [ 4001.238411] BUG: kernel NULL pointer dereference, address:
>>> 0000000000000000
>>> [ 4001.238415] #PF: supervisor read access in kernel mode
>>> [ 4001.238417] #PF: error_code(0x0000) - not-present page
>>> [ 4001.238418] PGD 0 P4D 0 
>>> [ 4001.238420] Oops: 0000 [#1] SMP PTI
>>> [ 4001.238423] CPU: 3 PID: 143 Comm: kswapd0 Tainted: G I 5.2.16fw+
>>> #1
>>> [ 4001.238424] Hardware name: System manufacturer System Product
>>> Name/P6X58D-E, BIOS 0701 05/10/2011
>>> [ 4001.238430] RIP: 0010:__reset_isolation_pfn+0x27f/0x3c0
>> 
>> That's memory compaction code it's crashed in.
>> 
>>> [ 4001.238432] Code: 44 c6 48 8b 00 a8 10 74 bc 49 8b 16 48 89 d0
>>> 48 c1 ea 35 48 8b 14 d7 48 c1 e8 2d 48 85 d2 74 0a 0f b6 c0 48 c1
>>> e0 04 48 01 c2 <48> 8b 02 4c 89 f2 41 b8 01 00 00 00 31 f6 b9 03 00
>>> 00 00 4c 89 f7
>
> Tried to decode it, but couldn't match it to source code, my version of
> compiled code is too different. Would it be possible to either send
> mm/compaction.o from the matching build, or output of 'objdump -d -l'
> for the __reset_isolation_pfn function?

See below.  I don't have debuginfo for this build, and the binary does
not reproduce for some reason.  Due to the heavy inlining, it might be
quite hard to figure out what's going on.

I've switched to kernel builds with debuginfo from now on.  I'm
surprised that it's not the default.

0000000000000120 <__reset_isolation_pfn>:
__reset_isolation_pfn():
     120:	48 89 f0             	mov    %rsi,%rax
     123:	48 c1 e8 0f          	shr    $0xf,%rax
     127:	48 3d ff ff 07 00    	cmp    $0x7ffff,%rax
     12d:	0f 87 83 00 00 00    	ja     1b6 <__reset_isolation_pfn+0x96>
     133:	4c 8b 0d 00 00 00 00 	mov    0x0(%rip),%r9        # 13a <__reset_isolation_pfn+0x1a>
			136: R_X86_64_PC32	mem_section-0x4
     13a:	4d 85 c9             	test   %r9,%r9
     13d:	74 77                	je     1b6 <__reset_isolation_pfn+0x96>
     13f:	49 89 f2             	mov    %rsi,%r10
     142:	49 c1 ea 17          	shr    $0x17,%r10
     146:	4f 8b 0c d1          	mov    (%r9,%r10,8),%r9
     14a:	4d 85 c9             	test   %r9,%r9
     14d:	74 67                	je     1b6 <__reset_isolation_pfn+0x96>
     14f:	0f b6 c0             	movzbl %al,%eax
     152:	48 c1 e0 04          	shl    $0x4,%rax
     156:	4c 01 c8             	add    %r9,%rax
     159:	74 5b                	je     1b6 <__reset_isolation_pfn+0x96>
     15b:	4c 8b 08             	mov    (%rax),%r9
     15e:	41 f6 c1 02          	test   $0x2,%r9b
     162:	74 52                	je     1b6 <__reset_isolation_pfn+0x96>
     164:	48 6b c6 38          	imul   $0x38,%rsi,%rax
     168:	55                   	push   %rbp
     169:	49 83 e1 f8          	and    $0xfffffffffffffff8,%r9
     16d:	48 89 e5             	mov    %rsp,%rbp
     170:	41 57                	push   %r15
     172:	41 56                	push   %r14
     174:	4d 89 ce             	mov    %r9,%r14
     177:	41 55                	push   %r13
     179:	41 54                	push   %r12
     17b:	53                   	push   %rbx
     17c:	48 83 ec 10          	sub    $0x10,%rsp
     180:	49 01 c6             	add    %rax,%r14
     183:	74 1c                	je     1a1 <__reset_isolation_pfn+0x81>
     185:	49 8b 06             	mov    (%r14),%rax
     188:	48 c1 e8 2b          	shr    $0x2b,%rax
     18c:	83 e0 03             	and    $0x3,%eax
     18f:	48 69 c0 80 05 00 00 	imul   $0x580,%rax,%rax
     196:	48 05 00 00 00 00    	add    $0x0,%rax
			198: R_X86_64_32S	contig_page_data
     19c:	48 39 c7             	cmp    %rax,%rdi
     19f:	74 1c                	je     1bd <__reset_isolation_pfn+0x9d>
     1a1:	45 31 d2             	xor    %r10d,%r10d
     1a4:	48 83 c4 10          	add    $0x10,%rsp
     1a8:	44 89 d0             	mov    %r10d,%eax
     1ab:	5b                   	pop    %rbx
     1ac:	41 5c                	pop    %r12
     1ae:	41 5d                	pop    %r13
     1b0:	41 5e                	pop    %r14
     1b2:	41 5f                	pop    %r15
     1b4:	5d                   	pop    %rbp
     1b5:	c3                   	retq   
     1b6:	45 31 d2             	xor    %r10d,%r10d
     1b9:	44 89 d0             	mov    %r10d,%eax
     1bc:	c3                   	retq   
     1bd:	48 89 7d d0          	mov    %rdi,-0x30(%rbp)
     1c1:	41 89 cc             	mov    %ecx,%r12d
     1c4:	41 89 cd             	mov    %ecx,%r13d
     1c7:	4c 89 f7             	mov    %r14,%rdi
     1ca:	89 d1                	mov    %edx,%ecx
     1cc:	41 89 d7             	mov    %edx,%r15d
     1cf:	48 89 f3             	mov    %rsi,%rbx
     1d2:	89 4d cc             	mov    %ecx,-0x34(%rbp)
     1d5:	e8 46 fe ff ff       	callq  20 <pageblock_skip_persistent>
     1da:	84 c0                	test   %al,%al
     1dc:	75 c3                	jne    1a1 <__reset_isolation_pfn+0x81>
     1de:	45 89 fa             	mov    %r15d,%r10d
     1e1:	45 20 e2             	and    %r12b,%r10b
     1e4:	0f 85 f3 01 00 00    	jne    3dd <__reset_isolation_pfn+0x2bd>
     1ea:	80 7d cc 01          	cmpb   $0x1,-0x34(%rbp)
     1ee:	74 6d                	je     25d <__reset_isolation_pfn+0x13d>
     1f0:	45 84 e4             	test   %r12b,%r12b
     1f3:	74 68                	je     25d <__reset_isolation_pfn+0x13d>
     1f5:	49 8b 0e             	mov    (%r14),%rcx
     1f8:	48 8b 05 00 00 00 00 	mov    0x0(%rip),%rax        # 1ff <__reset_isolation_pfn+0xdf>
			1fb: R_X86_64_PC32	mem_section-0x4
     1ff:	48 89 ca             	mov    %rcx,%rdx
     202:	48 c1 ea 2d          	shr    $0x2d,%rdx
     206:	48 85 c0             	test   %rax,%rax
     209:	74 17                	je     222 <__reset_isolation_pfn+0x102>
     20b:	48 c1 e9 35          	shr    $0x35,%rcx
     20f:	48 8b 04 c8          	mov    (%rax,%rcx,8),%rax
     213:	48 85 c0             	test   %rax,%rax
     216:	74 0a                	je     222 <__reset_isolation_pfn+0x102>
     218:	0f b6 d2             	movzbl %dl,%edx
     21b:	48 c1 e2 04          	shl    $0x4,%rdx
     21f:	48 01 d0             	add    %rdx,%rax
     222:	48 8b 00             	mov    (%rax),%rax
     225:	4c 89 f6             	mov    %r14,%rsi
     228:	b9 07 00 00 00       	mov    $0x7,%ecx
     22d:	ba 02 00 00 00       	mov    $0x2,%edx
     232:	4c 89 f7             	mov    %r14,%rdi
     235:	48 83 e0 f8          	and    $0xfffffffffffffff8,%rax
     239:	48 29 c6             	sub    %rax,%rsi
     23c:	48 b8 b7 6d db b6 6d 	movabs $0x6db6db6db6db6db7,%rax
     243:	db b6 6d 
     246:	48 c1 fe 03          	sar    $0x3,%rsi
     24a:	48 0f af f0          	imul   %rax,%rsi
     24e:	e8 00 00 00 00       	callq  253 <__reset_isolation_pfn+0x133>
			24f: R_X86_64_PLT32	get_pfnblock_flags_mask-0x4
     253:	48 83 f8 01          	cmp    $0x1,%rax
     257:	0f 85 44 ff ff ff    	jne    1a1 <__reset_isolation_pfn+0x81>
     25d:	48 8b 7d d0          	mov    -0x30(%rbp),%rdi
     261:	48 81 e3 00 fe ff ff 	and    $0xfffffffffffffe00,%rbx
     268:	48 8b 47 58          	mov    0x58(%rdi),%rax
     26c:	48 39 c3             	cmp    %rax,%rbx
     26f:	48 89 c1             	mov    %rax,%rcx
     272:	48 0f 43 cb          	cmovae %rbx,%rcx
     276:	48 03 47 68          	add    0x68(%rdi),%rax
     27a:	48 81 c3 00 02 00 00 	add    $0x200,%rbx
     281:	48 89 ca             	mov    %rcx,%rdx
     284:	48 c1 ea 0f          	shr    $0xf,%rdx
     288:	48 83 e8 01          	sub    $0x1,%rax
     28c:	48 39 d8             	cmp    %rbx,%rax
     28f:	48 0f 47 c3          	cmova  %rbx,%rax
     293:	48 89 c6             	mov    %rax,%rsi
     296:	48 c1 ee 0f          	shr    $0xf,%rsi
     29a:	48 81 fa ff ff 07 00 	cmp    $0x7ffff,%rdx
     2a1:	0f 87 ab 01 00 00    	ja     452 <__reset_isolation_pfn+0x332>
     2a7:	48 8b 3d 00 00 00 00 	mov    0x0(%rip),%rdi        # 2ae <__reset_isolation_pfn+0x18e>
			2aa: R_X86_64_PC32	mem_section-0x4
     2ae:	48 85 ff             	test   %rdi,%rdi
     2b1:	0f 84 ea fe ff ff    	je     1a1 <__reset_isolation_pfn+0x81>
     2b7:	49 89 ca             	mov    %rcx,%r10
     2ba:	49 c1 ea 17          	shr    $0x17,%r10
     2be:	4e 8b 14 d7          	mov    (%rdi,%r10,8),%r10
     2c2:	4d 85 d2             	test   %r10,%r10
     2c5:	74 23                	je     2ea <__reset_isolation_pfn+0x1ca>
     2c7:	0f b6 d2             	movzbl %dl,%edx
     2ca:	48 c1 e2 04          	shl    $0x4,%rdx
     2ce:	4c 01 d2             	add    %r10,%rdx
     2d1:	74 17                	je     2ea <__reset_isolation_pfn+0x1ca>
     2d3:	48 8b 12             	mov    (%rdx),%rdx
     2d6:	f6 c2 02             	test   $0x2,%dl
     2d9:	74 0f                	je     2ea <__reset_isolation_pfn+0x1ca>
     2db:	48 6b c9 38          	imul   $0x38,%rcx,%rcx
     2df:	48 83 e2 f8          	and    $0xfffffffffffffff8,%rdx
     2e3:	48 01 ca             	add    %rcx,%rdx
     2e6:	4c 0f 45 f2          	cmovne %rdx,%r14
     2ea:	48 81 fe 00 00 08 00 	cmp    $0x80000,%rsi
     2f1:	0f 84 aa fe ff ff    	je     1a1 <__reset_isolation_pfn+0x81>
     2f7:	48 89 c2             	mov    %rax,%rdx
     2fa:	48 c1 ea 17          	shr    $0x17,%rdx
     2fe:	48 8b 14 d7          	mov    (%rdi,%rdx,8),%rdx
     302:	48 85 d2             	test   %rdx,%rdx
     305:	0f 84 96 fe ff ff    	je     1a1 <__reset_isolation_pfn+0x81>
     30b:	40 0f b6 f6          	movzbl %sil,%esi
     30f:	48 c1 e6 04          	shl    $0x4,%rsi
     313:	48 01 f2             	add    %rsi,%rdx
     316:	0f 84 85 fe ff ff    	je     1a1 <__reset_isolation_pfn+0x81>
     31c:	48 8b 12             	mov    (%rdx),%rdx
     31f:	f6 c2 02             	test   $0x2,%dl
     322:	0f 84 79 fe ff ff    	je     1a1 <__reset_isolation_pfn+0x81>
     328:	48 6b c0 38          	imul   $0x38,%rax,%rax
     32c:	48 83 e2 f8          	and    $0xfffffffffffffff8,%rdx
     330:	48 01 c2             	add    %rax,%rdx
     333:	75 2e                	jne    363 <__reset_isolation_pfn+0x243>
     335:	e9 67 fe ff ff       	jmpq   1a1 <__reset_isolation_pfn+0x81>
     33a:	45 84 e4             	test   %r12b,%r12b
     33d:	74 14                	je     353 <__reset_isolation_pfn+0x233>
     33f:	41 8b 46 30          	mov    0x30(%r14),%eax
     343:	25 80 00 00 f0       	and    $0xf0000080,%eax
     348:	3d 00 00 00 f0       	cmp    $0xf0000000,%eax
     34d:	0f 84 21 01 00 00    	je     474 <__reset_isolation_pfn+0x354>
     353:	49 81 c6 c0 01 00 00 	add    $0x1c0,%r14
     35a:	4c 39 f2             	cmp    %r14,%rdx
     35d:	0f 86 3e fe ff ff    	jbe    1a1 <__reset_isolation_pfn+0x81>
     363:	45 84 ff             	test   %r15b,%r15b
     366:	74 d2                	je     33a <__reset_isolation_pfn+0x21a>
     368:	49 8b 4e 08          	mov    0x8(%r14),%rcx
     36c:	48 8d 41 ff          	lea    -0x1(%rcx),%rax
     370:	83 e1 01             	and    $0x1,%ecx
     373:	49 0f 44 c6          	cmove  %r14,%rax
     377:	48 8b 00             	mov    (%rax),%rax
     37a:	a8 10                	test   $0x10,%al
     37c:	74 bc                	je     33a <__reset_isolation_pfn+0x21a>
     37e:	49 8b 16             	mov    (%r14),%rdx
     381:	48 89 d0             	mov    %rdx,%rax
     384:	48 c1 ea 35          	shr    $0x35,%rdx
     388:	48 8b 14 d7          	mov    (%rdi,%rdx,8),%rdx
     38c:	48 c1 e8 2d          	shr    $0x2d,%rax
     390:	48 85 d2             	test   %rdx,%rdx
     393:	74 0a                	je     39f <__reset_isolation_pfn+0x27f>
     395:	0f b6 c0             	movzbl %al,%eax
     398:	48 c1 e0 04          	shl    $0x4,%rax
     39c:	48 01 c2             	add    %rax,%rdx
     39f:	48 8b 02             	mov    (%rdx),%rax
     3a2:	4c 89 f2             	mov    %r14,%rdx
     3a5:	41 b8 01 00 00 00    	mov    $0x1,%r8d
     3ab:	31 f6                	xor    %esi,%esi
     3ad:	b9 03 00 00 00       	mov    $0x3,%ecx
     3b2:	4c 89 f7             	mov    %r14,%rdi
     3b5:	48 83 e0 f8          	and    $0xfffffffffffffff8,%rax
     3b9:	48 29 c2             	sub    %rax,%rdx
     3bc:	48 b8 b7 6d db b6 6d 	movabs $0x6db6db6db6db6db7,%rax
     3c3:	db b6 6d 
     3c6:	48 c1 fa 03          	sar    $0x3,%rdx
     3ca:	48 0f af d0          	imul   %rax,%rdx
     3ce:	e8 00 00 00 00       	callq  3d3 <__reset_isolation_pfn+0x2b3>
			3cf: R_X86_64_PLT32	set_pfnblock_flags_mask-0x4
     3d3:	44 0f b6 55 cc       	movzbl -0x34(%rbp),%r10d
     3d8:	e9 c7 fd ff ff       	jmpq   1a4 <__reset_isolation_pfn+0x84>
     3dd:	49 8b 0e             	mov    (%r14),%rcx
     3e0:	48 8b 05 00 00 00 00 	mov    0x0(%rip),%rax        # 3e7 <__reset_isolation_pfn+0x2c7>
			3e3: R_X86_64_PC32	mem_section-0x4
     3e7:	48 89 ca             	mov    %rcx,%rdx
     3ea:	48 c1 ea 2d          	shr    $0x2d,%rdx
     3ee:	48 85 c0             	test   %rax,%rax
     3f1:	74 17                	je     40a <__reset_isolation_pfn+0x2ea>
     3f3:	48 c1 e9 35          	shr    $0x35,%rcx
     3f7:	48 8b 04 c8          	mov    (%rax,%rcx,8),%rax
     3fb:	48 85 c0             	test   %rax,%rax
     3fe:	74 0a                	je     40a <__reset_isolation_pfn+0x2ea>
     400:	0f b6 d2             	movzbl %dl,%edx
     403:	48 c1 e2 04          	shl    $0x4,%rdx
     407:	48 01 d0             	add    %rdx,%rax
     40a:	48 8b 00             	mov    (%rax),%rax
     40d:	4c 89 f6             	mov    %r14,%rsi
     410:	b9 01 00 00 00       	mov    $0x1,%ecx
     415:	ba 03 00 00 00       	mov    $0x3,%edx
     41a:	4c 89 f7             	mov    %r14,%rdi
     41d:	44 88 55 cb          	mov    %r10b,-0x35(%rbp)
     421:	48 83 e0 f8          	and    $0xfffffffffffffff8,%rax
     425:	48 29 c6             	sub    %rax,%rsi
     428:	48 b8 b7 6d db b6 6d 	movabs $0x6db6db6db6db6db7,%rax
     42f:	db b6 6d 
     432:	48 c1 fe 03          	sar    $0x3,%rsi
     436:	48 0f af f0          	imul   %rax,%rsi
     43a:	e8 00 00 00 00       	callq  43f <__reset_isolation_pfn+0x31f>
			43b: R_X86_64_PLT32	get_pfnblock_flags_mask-0x4
     43f:	44 0f b6 55 cb       	movzbl -0x35(%rbp),%r10d
     444:	48 85 c0             	test   %rax,%rax
     447:	0f 85 10 fe ff ff    	jne    25d <__reset_isolation_pfn+0x13d>
     44d:	e9 52 fd ff ff       	jmpq   1a4 <__reset_isolation_pfn+0x84>
     452:	48 81 fe 00 00 08 00 	cmp    $0x80000,%rsi
     459:	0f 84 42 fd ff ff    	je     1a1 <__reset_isolation_pfn+0x81>
     45f:	48 8b 3d 00 00 00 00 	mov    0x0(%rip),%rdi        # 466 <__reset_isolation_pfn+0x346>
			462: R_X86_64_PC32	mem_section-0x4
     466:	48 85 ff             	test   %rdi,%rdi
     469:	0f 85 88 fe ff ff    	jne    2f7 <__reset_isolation_pfn+0x1d7>
     46f:	e9 2d fd ff ff       	jmpq   1a1 <__reset_isolation_pfn+0x81>
     474:	49 8b 06             	mov    (%r14),%rax
     477:	48 89 c2             	mov    %rax,%rdx
     47a:	48 c1 e8 35          	shr    $0x35,%rax
     47e:	48 8b 04 c7          	mov    (%rdi,%rax,8),%rax
     482:	48 c1 ea 2d          	shr    $0x2d,%rdx
     486:	48 85 c0             	test   %rax,%rax
     489:	74 0a                	je     495 <__reset_isolation_pfn+0x375>
     48b:	0f b6 d2             	movzbl %dl,%edx
     48e:	48 c1 e2 04          	shl    $0x4,%rdx
     492:	48 01 d0             	add    %rdx,%rax
     495:	48 8b 00             	mov    (%rax),%rax
     498:	4c 89 f2             	mov    %r14,%rdx
     49b:	41 b8 01 00 00 00    	mov    $0x1,%r8d
     4a1:	31 f6                	xor    %esi,%esi
     4a3:	b9 03 00 00 00       	mov    $0x3,%ecx
     4a8:	4c 89 f7             	mov    %r14,%rdi
     4ab:	48 83 e0 f8          	and    $0xfffffffffffffff8,%rax
     4af:	48 29 c2             	sub    %rax,%rdx
     4b2:	48 b8 b7 6d db b6 6d 	movabs $0x6db6db6db6db6db7,%rax
     4b9:	db b6 6d 
     4bc:	48 c1 fa 03          	sar    $0x3,%rdx
     4c0:	48 0f af d0          	imul   %rax,%rdx
     4c4:	e8 00 00 00 00       	callq  4c9 <__reset_isolation_pfn+0x3a9>
			4c5: R_X86_64_PLT32	set_pfnblock_flags_mask-0x4
     4c9:	45 89 ea             	mov    %r13d,%r10d
     4cc:	e9 d3 fc ff ff       	jmpq   1a4 <__reset_isolation_pfn+0x84>
     4d1:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
     4d8:	00 00 00 00 
     4dc:	0f 1f 40 00          	nopl   0x0(%rax)
