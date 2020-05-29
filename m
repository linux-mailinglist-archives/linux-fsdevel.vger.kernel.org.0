Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B19E81E81EE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 17:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgE2PgT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 11:36:19 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55108 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgE2PgS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 11:36:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sGnGrck9ZKLDATSUuJmMD1YOdzJB/if9OKL8No+eQlM=; b=jOuAsCeac6FPWk5V4LEAHqR0ix
        wOYvX7qeXn/jqfsTc2/w0Q1OBAEHfiVJldbzVmybr/ffmkht5TU7VzgAuQrxhqqVFJYj+2qVzUQFq
        BM+NRaMwb7nEuLwfA7gOVwhpR/FiZgy0fKs7MxjfmygKwPDh5PWoW2Q+SWtabiOubrovw/YOltTcy
        KA8mLyBduT0w3ORg0J3sDD2psuI7zNrIBOipCS0QY9Z5eqRE9Z2ZovRTE6u9g23/9Kdsi5/5BLsUw
        Rs113ZomlrkQFcdsZrylQTLHXyzYHkvp4qjApL0qUVP6gd8z7p90GoF9ozU/4izOOiR2YY23S7H5Q
        X0WPHBJQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeh0s-00006i-Ah; Fri, 29 May 2020 15:33:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C68943012C3;
        Fri, 29 May 2020 17:33:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 963D9286F97F7; Fri, 29 May 2020 17:33:36 +0200 (CEST)
Date:   Fri, 29 May 2020 17:33:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        viro@ZenIV.linux.org.uk, x86@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: mmotm 2020-05-13-20-30 uploaded (objtool warnings)
Message-ID: <20200529153336.GC706518@hirez.programming.kicks-ass.net>
References: <20200514033104.kRFL_ctMQ%akpm@linux-foundation.org>
 <611fa14d-8d31-796f-b909-686d9ebf84a9@infradead.org>
 <20200528172005.GP2483@worktop.programming.kicks-ass.net>
 <20200529135750.GA1580@lst.de>
 <20200529143556.GE706478@hirez.programming.kicks-ass.net>
 <20200529145325.GB706518@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529145325.GB706518@hirez.programming.kicks-ass.net>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 29, 2020 at 04:53:25PM +0200, Peter Zijlstra wrote:
> On Fri, May 29, 2020 at 04:35:56PM +0200, Peter Zijlstra wrote:

> *groan*, this is one of those CONFIG_PROFILE_ALL_BRANCHES builds. If I
> disable that it goes away.
> 
> Still trying to untangle the mess it generated, but on first go it
> looks like objtool is right, but I'm not sure what went wrong.

$ tools/objtool/objtool check -fab arch/x86/lib/csum-wrappers_64.o
arch/x86/lib/csum-wrappers_64.o: warning: objtool: csum_and_copy_from_user()+0x29f: call to memset() with UACCESS enabled
arch/x86/lib/csum-wrappers_64.o: warning: objtool:   csum_and_copy_from_user()+0x283: (branch)
arch/x86/lib/csum-wrappers_64.o: warning: objtool:   csum_and_copy_from_user()+0x113: (branch)
arch/x86/lib/csum-wrappers_64.o: warning: objtool:   .altinstr_replacement+0xffffffffffffffff: (branch)
arch/x86/lib/csum-wrappers_64.o: warning: objtool:   csum_and_copy_from_user()+0xea: (alt)
arch/x86/lib/csum-wrappers_64.o: warning: objtool:   .altinstr_replacement+0xffffffffffffffff: (branch)
arch/x86/lib/csum-wrappers_64.o: warning: objtool:   csum_and_copy_from_user()+0xe7: (alt)
arch/x86/lib/csum-wrappers_64.o: warning: objtool:   csum_and_copy_from_user()+0xd2: (branch)
arch/x86/lib/csum-wrappers_64.o: warning: objtool:   csum_and_copy_from_user()+0x7e: (branch)
arch/x86/lib/csum-wrappers_64.o: warning: objtool:   csum_and_copy_from_user()+0x43: (branch)
arch/x86/lib/csum-wrappers_64.o: warning: objtool:   csum_and_copy_from_user()+0x0: <=== (sym)

The problem is with the +0x113 branch, which is at 0x1d1.

That looks to be:

	if (!likely(user_access_begin(src, len)))
		goto out_err;

Except that the brach profiling stuff confused GCC enough to leak STAC
into the error path or something.

Reproduces for me with gcc-9 and gcc-10.

$ objdump -drS arch/x86/lib/csum-wrappers_64.o

00000000000000be <csum_and_copy_from_user>:
{
  be:	e8 00 00 00 00       	callq  c3 <csum_and_copy_from_user+0x5>
			bf: R_X86_64_PLT32	__fentry__-0x4
  c3:	41 57                	push   %r15
  c5:	41 56                	push   %r14
  c7:	41 89 d6             	mov    %edx,%r14d
  ca:	41 55                	push   %r13
  cc:	49 89 f5             	mov    %rsi,%r13
  cf:	41 54                	push   %r12
  d1:	41 89 cc             	mov    %ecx,%r12d
  d4:	55                   	push   %rbp
  d5:	48 89 fd             	mov    %rdi,%rbp
  d8:	53                   	push   %rbx
  d9:	4c 89 c3             	mov    %r8,%rbx
  dc:	41 51                	push   %r9
	might_sleep();
  de:	e8 00 00 00 00       	callq  e3 <csum_and_copy_from_user+0x25>
			df: R_X86_64_PLT32	_cond_resched-0x4
	*errp = 0;
  e3:	48 89 da             	mov    %rbx,%rdx
  e6:	b8 ff ff 37 00       	mov    $0x37ffff,%eax
  eb:	48 c1 e0 2a          	shl    $0x2a,%rax
  ef:	48 c1 ea 03          	shr    $0x3,%rdx
  f3:	8a 14 02             	mov    (%rdx,%rax,1),%dl
  f6:	48 89 d8             	mov    %rbx,%rax
  f9:	83 e0 07             	and    $0x7,%eax
  fc:	83 c0 03             	add    $0x3,%eax
  ff:	38 d0                	cmp    %dl,%al
 101:	7c 0c                	jl     10f <csum_and_copy_from_user+0x51>
 103:	84 d2                	test   %dl,%dl
 105:	74 08                	je     10f <csum_and_copy_from_user+0x51>
 107:	48 89 df             	mov    %rbx,%rdi
 10a:	e8 00 00 00 00       	callq  10f <csum_and_copy_from_user+0x51>
			10b: R_X86_64_PLT32	__asan_report_store4_noabort-0x4

DECLARE_PER_CPU(struct task_struct *, current_task);

static __always_inline struct task_struct *get_current(void)
{
	return this_cpu_read_stable(current_task);
 10f:	65 4c 8b 3c 25 00 00 	mov    %gs:0x0,%r15
 116:	00 00 
			114: R_X86_64_32S	current_task
 * checking before using them, but you have to surround them with the
 * user_access_begin/end() pair.
 */
static __must_check __always_inline bool user_access_begin(const void __user *ptr, size_t len)
{
	if (unlikely(!access_ok(ptr,len)))
 118:	49 8d bf 10 0a 00 00 	lea    0xa10(%r15),%rdi
 11f:	b8 ff ff 37 00       	mov    $0x37ffff,%eax
 124:	c7 03 00 00 00 00    	movl   $0x0,(%rbx)
	if (!likely(user_access_begin(src, len)))
 12a:	49 63 f6             	movslq %r14d,%rsi
 12d:	48 89 fa             	mov    %rdi,%rdx
 130:	48 c1 e0 2a          	shl    $0x2a,%rax
 134:	48 c1 ea 03          	shr    $0x3,%rdx
 138:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
 13c:	74 0d                	je     14b <csum_and_copy_from_user+0x8d>
 13e:	48 89 34 24          	mov    %rsi,(%rsp)
 142:	e8 00 00 00 00       	callq  147 <csum_and_copy_from_user+0x89>
			143: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
 147:	48 8b 34 24          	mov    (%rsp),%rsi
 14b:	49 8b 97 10 0a 00 00 	mov    0xa10(%r15),%rdx
 152:	48 89 ef             	mov    %rbp,%rdi
 155:	e8 a6 fe ff ff       	callq  0 <__chk_range_not_ok>
 15a:	31 c9                	xor    %ecx,%ecx
 15c:	ba 01 00 00 00       	mov    $0x1,%edx
 161:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
			164: R_X86_64_32S	_ftrace_annotated_branch+0x120
 168:	89 c6                	mov    %eax,%esi
 16a:	41 89 c7             	mov    %eax,%r15d
 16d:	83 f6 01             	xor    $0x1,%esi
 170:	40 0f b6 f6          	movzbl %sil,%esi
 174:	e8 00 00 00 00       	callq  179 <csum_and_copy_from_user+0xbb>
			175: R_X86_64_PLT32	ftrace_likely_update-0x4
 179:	31 c9                	xor    %ecx,%ecx
 17b:	31 d2                	xor    %edx,%edx
 17d:	41 0f b6 f7          	movzbl %r15b,%esi
 181:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
			184: R_X86_64_32S	_ftrace_annotated_branch+0x150
 188:	e8 00 00 00 00       	callq  18d <csum_and_copy_from_user+0xcf>
			189: R_X86_64_PLT32	ftrace_likely_update-0x4
 18d:	45 84 ff             	test   %r15b,%r15b
 190:	74 0c                	je     19e <csum_and_copy_from_user+0xe0>
 192:	48 ff 05 00 00 00 00 	incq   0x0(%rip)        # 199 <csum_and_copy_from_user+0xdb>
			195: R_X86_64_PC32	_ftrace_branch+0x10c
		return 0;
 199:	45 31 ff             	xor    %r15d,%r15d
 19c:	eb 10                	jmp    1ae <csum_and_copy_from_user+0xf0>
	if (unlikely(!access_ok(ptr,len)))
 19e:	48 ff 05 00 00 00 00 	incq   0x0(%rip)        # 1a5 <csum_and_copy_from_user+0xe7>
			1a1: R_X86_64_PC32	_ftrace_branch+0x104
}

static __always_inline void stac(void)
{
	/* Note: a barrier is implicit in alternative() */
	alternative("", __ASM_STAC, X86_FEATURE_SMAP);
 1a5:	90                   	nop
 1a6:	90                   	nop
 1a7:	90                   	nop
	__uaccess_begin_nospec();
 1a8:	90                   	nop
 1a9:	90                   	nop
 1aa:	90                   	nop
	return 1;
 1ab:	41 b7 01             	mov    $0x1,%r15b
 1ae:	31 c9                	xor    %ecx,%ecx
 1b0:	41 0f b6 f7          	movzbl %r15b,%esi
 1b4:	ba 01 00 00 00       	mov    $0x1,%edx
 1b9:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
			1bc: R_X86_64_32S	_ftrace_annotated_branch+0xf0
 1c0:	e8 00 00 00 00       	callq  1c5 <csum_and_copy_from_user+0x107>
			1c1: R_X86_64_PLT32	ftrace_likely_update-0x4
 1c5:	45 84 ff             	test   %r15b,%r15b
 1c8:	75 0c                	jne    1d6 <csum_and_copy_from_user+0x118>
 1ca:	48 ff 05 00 00 00 00 	incq   0x0(%rip)        # 1d1 <csum_and_copy_from_user+0x113>
			1cd: R_X86_64_PC32	_ftrace_branch+0xe4
		goto out_err;
 1d1:	e9 4d 01 00 00       	jmpq   323 <csum_and_copy_from_user+0x265>
	if (unlikely((unsigned long)src & 6)) {
 1d6:	49 89 ef             	mov    %rbp,%r15
 1d9:	31 f6                	xor    %esi,%esi
	if (!likely(user_access_begin(src, len)))
 1db:	48 ff 05 00 00 00 00 	incq   0x0(%rip)        # 1e2 <csum_and_copy_from_user+0x124>
			1de: R_X86_64_PC32	_ftrace_branch+0xdc
	if (unlikely((unsigned long)src & 6)) {
 1e2:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
			1e5: R_X86_64_32S	_ftrace_annotated_branch+0xc0
 1e9:	41 83 e7 06          	and    $0x6,%r15d
 1ed:	40 0f 95 c6          	setne  %sil
 1f1:	31 c9                	xor    %ecx,%ecx
 1f3:	31 d2                	xor    %edx,%edx
 1f5:	e8 00 00 00 00       	callq  1fa <csum_and_copy_from_user+0x13c>
			1f6: R_X86_64_PLT32	ftrace_likely_update-0x4
 1fa:	4d 85 ff             	test   %r15,%r15
 1fd:	74 09                	je     208 <csum_and_copy_from_user+0x14a>
 1ff:	48 ff 05 00 00 00 00 	incq   0x0(%rip)        # 206 <csum_and_copy_from_user+0x148>
			202: R_X86_64_PC32	_ftrace_branch+0xbc
 206:	eb 4e                	jmp    256 <csum_and_copy_from_user+0x198>
 208:	48 ff 05 00 00 00 00 	incq   0x0(%rip)        # 20f <csum_and_copy_from_user+0x151>
			20b: R_X86_64_PC32	_ftrace_branch+0xb4
 20f:	e9 96 00 00 00       	jmpq   2aa <csum_and_copy_from_user+0x1ec>
			*(__u16 *)dst = val16;
 214:	4c 89 e8             	mov    %r13,%rax
 217:	b9 ff ff 37 00       	mov    $0x37ffff,%ecx
			unsafe_get_user(val16, (const __u16 __user *)src, out);
 21c:	48 ff 05 00 00 00 00 	incq   0x0(%rip)        # 223 <csum_and_copy_from_user+0x165>
			21f: R_X86_64_PC32	_ftrace_branch+0x8c
			*(__u16 *)dst = val16;
 223:	48 c1 e8 03          	shr    $0x3,%rax
 227:	48 c1 e1 2a          	shl    $0x2a,%rcx
 22b:	8a 14 08             	mov    (%rax,%rcx,1),%dl
 22e:	4c 89 e8             	mov    %r13,%rax
 231:	83 e0 07             	and    $0x7,%eax
 234:	ff c0                	inc    %eax
 236:	38 d0                	cmp    %dl,%al
 238:	7d 62                	jge    29c <csum_and_copy_from_user+0x1de>
 23a:	66 45 89 7d 00       	mov    %r15w,0x0(%r13)
			src += 2;
 23f:	48 83 c5 02          	add    $0x2,%rbp
			dst += 2;
 243:	49 83 c5 02          	add    $0x2,%r13
			len -= 2;
 247:	41 83 ee 02          	sub    $0x2,%r14d
			isum = (__force __wsum)add32_with_carry(
 24b:	45 0f b7 ff          	movzwl %r15w,%r15d
	asm("addl %2,%0\n\t"
 24f:	45 01 fc             	add    %r15d,%r12d
 252:	41 83 d4 00          	adc    $0x0,%r12d
		while (((unsigned long)src & 6) && len >= 2) {
 256:	40 f6 c5 06          	test   $0x6,%bpl
 25a:	74 4e                	je     2aa <csum_and_copy_from_user+0x1ec>
 25c:	41 83 fe 01          	cmp    $0x1,%r14d
 260:	7e 48                	jle    2aa <csum_and_copy_from_user+0x1ec>
			unsafe_get_user(val16, (const __u16 __user *)src, out);
 262:	31 c0                	xor    %eax,%eax
 264:	66 44 8b 7d 00       	mov    0x0(%rbp),%r15w
 269:	85 c0                	test   %eax,%eax
 26b:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
			26e: R_X86_64_32S	_ftrace_annotated_branch+0x90
 272:	89 04 24             	mov    %eax,(%rsp)
 275:	40 0f 95 c6          	setne  %sil
 279:	31 c9                	xor    %ecx,%ecx
 27b:	31 d2                	xor    %edx,%edx
 27d:	40 0f b6 f6          	movzbl %sil,%esi
 281:	e8 00 00 00 00       	callq  286 <csum_and_copy_from_user+0x1c8>
			282: R_X86_64_PLT32	ftrace_likely_update-0x4
 286:	8b 04 24             	mov    (%rsp),%eax
 289:	85 c0                	test   %eax,%eax
 28b:	74 87                	je     214 <csum_and_copy_from_user+0x156>
 28d:	48 ff 05 00 00 00 00 	incq   0x0(%rip)        # 294 <csum_and_copy_from_user+0x1d6>
			290: R_X86_64_PC32	_ftrace_branch+0x94
	alternative("", __ASM_CLAC, X86_FEATURE_SMAP);
 294:	90                   	nop
 295:	90                   	nop
 296:	90                   	nop
}
 297:	e9 87 00 00 00       	jmpq   323 <csum_and_copy_from_user+0x265>
			*(__u16 *)dst = val16;
 29c:	84 d2                	test   %dl,%dl
 29e:	74 9a                	je     23a <csum_and_copy_from_user+0x17c>
 2a0:	4c 89 ef             	mov    %r13,%rdi
 2a3:	e8 00 00 00 00       	callq  2a8 <csum_and_copy_from_user+0x1ea>
			2a4: R_X86_64_PLT32	__asan_report_store2_noabort-0x4
 2a8:	eb 90                	jmp    23a <csum_and_copy_from_user+0x17c>
	isum = csum_partial_copy_generic((__force const void *)src,
 2aa:	44 89 e1             	mov    %r12d,%ecx
 2ad:	45 31 c9             	xor    %r9d,%r9d
 2b0:	49 89 d8             	mov    %rbx,%r8
 2b3:	44 89 f2             	mov    %r14d,%edx
 2b6:	4c 89 ee             	mov    %r13,%rsi
 2b9:	48 89 ef             	mov    %rbp,%rdi
 2bc:	e8 00 00 00 00       	callq  2c1 <csum_and_copy_from_user+0x203>
			2bd: R_X86_64_PLT32	csum_partial_copy_generic-0x4
 2c1:	41 89 c4             	mov    %eax,%r12d
	alternative("", __ASM_CLAC, X86_FEATURE_SMAP);
 2c4:	90                   	nop
 2c5:	90                   	nop
 2c6:	90                   	nop
	if (unlikely(*errp))
 2c7:	b8 ff ff 37 00       	mov    $0x37ffff,%eax
 2cc:	48 89 da             	mov    %rbx,%rdx
 2cf:	48 c1 e0 2a          	shl    $0x2a,%rax
 2d3:	48 c1 ea 03          	shr    $0x3,%rdx
 2d7:	8a 14 02             	mov    (%rdx,%rax,1),%dl
 2da:	48 89 d8             	mov    %rbx,%rax
 2dd:	83 e0 07             	and    $0x7,%eax
 2e0:	83 c0 03             	add    $0x3,%eax
 2e3:	38 d0                	cmp    %dl,%al
 2e5:	7c 0c                	jl     2f3 <csum_and_copy_from_user+0x235>
 2e7:	84 d2                	test   %dl,%dl
 2e9:	74 08                	je     2f3 <csum_and_copy_from_user+0x235>
 2eb:	48 89 df             	mov    %rbx,%rdi
 2ee:	e8 00 00 00 00       	callq  2f3 <csum_and_copy_from_user+0x235>
			2ef: R_X86_64_PLT32	__asan_report_load4_noabort-0x4
 2f3:	8b 2b                	mov    (%rbx),%ebp
 2f5:	31 f6                	xor    %esi,%esi
 2f7:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
			2fa: R_X86_64_32S	_ftrace_annotated_branch+0x60
 2fe:	85 ed                	test   %ebp,%ebp
 300:	40 0f 95 c6          	setne  %sil
 304:	31 c9                	xor    %ecx,%ecx
 306:	31 d2                	xor    %edx,%edx
 308:	e8 00 00 00 00       	callq  30d <csum_and_copy_from_user+0x24f>
			309: R_X86_64_PLT32	ftrace_likely_update-0x4
 30d:	85 ed                	test   %ebp,%ebp
 30f:	74 09                	je     31a <csum_and_copy_from_user+0x25c>
 311:	48 ff 05 00 00 00 00 	incq   0x0(%rip)        # 318 <csum_and_copy_from_user+0x25a>
			314: R_X86_64_PC32	_ftrace_branch+0x6c
		goto out_err;
 318:	eb 09                	jmp    323 <csum_and_copy_from_user+0x265>
	if (unlikely(*errp))
 31a:	48 ff 05 00 00 00 00 	incq   0x0(%rip)        # 321 <csum_and_copy_from_user+0x263>
			31d: R_X86_64_PC32	_ftrace_branch+0x64
 321:	eb 3f                	jmp    362 <csum_and_copy_from_user+0x2a4>
	*errp = -EFAULT;
 323:	48 89 da             	mov    %rbx,%rdx
 326:	b8 ff ff 37 00       	mov    $0x37ffff,%eax
 32b:	48 c1 e0 2a          	shl    $0x2a,%rax
 32f:	48 c1 ea 03          	shr    $0x3,%rdx
 333:	8a 14 02             	mov    (%rdx,%rax,1),%dl
 336:	48 89 d8             	mov    %rbx,%rax
 339:	83 e0 07             	and    $0x7,%eax
 33c:	83 c0 03             	add    $0x3,%eax
 33f:	38 d0                	cmp    %dl,%al
 341:	7c 0c                	jl     34f <csum_and_copy_from_user+0x291>
 343:	84 d2                	test   %dl,%dl
 345:	74 08                	je     34f <csum_and_copy_from_user+0x291>
 347:	48 89 df             	mov    %rbx,%rdi
 34a:	e8 00 00 00 00       	callq  34f <csum_and_copy_from_user+0x291>
			34b: R_X86_64_PLT32	__asan_report_store4_noabort-0x4
 34f:	c7 03 f2 ff ff ff    	movl   $0xfffffff2,(%rbx)
	memset(dst, 0, len);
 355:	49 63 d6             	movslq %r14d,%rdx
 358:	31 f6                	xor    %esi,%esi
 35a:	4c 89 ef             	mov    %r13,%rdi
 35d:	e8 00 00 00 00       	callq  362 <csum_and_copy_from_user+0x2a4>
			35e: R_X86_64_PLT32	memset-0x4
}
 362:	5a                   	pop    %rdx
 363:	44 89 e0             	mov    %r12d,%eax
 366:	5b                   	pop    %rbx
 367:	5d                   	pop    %rbp
 368:	41 5c                	pop    %r12
 36a:	41 5d                	pop    %r13
 36c:	41 5e                	pop    %r14
 36e:	41 5f                	pop    %r15
 370:	c3                   	retq   

