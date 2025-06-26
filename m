Return-Path: <linux-fsdevel+bounces-53058-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 355A6AE960E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 08:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C84DF3A6F3C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 06:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993D822DA1F;
	Thu, 26 Jun 2025 06:20:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65171218599;
	Thu, 26 Jun 2025 06:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750918842; cv=none; b=LyMNtIqXkD1URTwnEanUvhQTrgavtahRD+Gx8C4n97L4fI9FOVxxyVENg13bdd34RET/k+Z+kNJx7jsiVZuf1gqnIQEp/eE/9ifrb2oiaJYLpQATm+cM5DQc3lD2tnQ99RfiSyTrTnESvGQZ7awQllbibXViH3YOoGahEzNwIXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750918842; c=relaxed/simple;
	bh=kmajPGloApxRKFaKW/UmyqYJ+75L1kgD7xbg9kNYje8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eP6Q2QAqqHi55ktRZmVSitmrsNs1JhtIOc5s+AnUUaVA+QL2ax88BnudWfb0K0Mi3lFGzrWD8pmWkXh6laO+MiYL/Geeyqq+qMIP0CayOiWPd/AIk1EHLHGJMozHSprOlXVKsIAPeBsAY+YjjiaCahHG0P2bUmtfika2r3gSmYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4bSSbw1jqdz9vG4;
	Thu, 26 Jun 2025 07:56:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q0xrpHJGhTt6; Thu, 26 Jun 2025 07:56:12 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4bSSbw0vypz9vFr;
	Thu, 26 Jun 2025 07:56:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 157358B7B7;
	Thu, 26 Jun 2025 07:56:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id KbYfiNafM5QK; Thu, 26 Jun 2025 07:56:11 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 13B658B7A7;
	Thu, 26 Jun 2025 07:56:11 +0200 (CEST)
Message-ID: <83fb5685-a206-477c-bff3-03e0ebf4c40c@csgroup.eu>
Date: Thu, 26 Jun 2025 07:56:10 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] powerpc: Implement masked user access
To: David Laight <david.laight.linux@gmail.com>,
 Segher Boessenkool <segher@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, Andre Almeida <andrealmeid@igalia.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <cover.1750585239.git.christophe.leroy@csgroup.eu>
 <20250622172043.3fb0e54c@pumpkin>
 <ff2662ca-3b86-425b-97f8-3883f1018e83@csgroup.eu>
 <20250624131714.GG17294@gate.crashing.org> <20250624175001.148a768f@pumpkin>
 <20250624182505.GH17294@gate.crashing.org> <20250624220816.078f960d@pumpkin>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20250624220816.078f960d@pumpkin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 24/06/2025 à 23:08, David Laight a écrit :
> On Tue, 24 Jun 2025 13:25:05 -0500
> Segher Boessenkool <segher@kernel.crashing.org> wrote:
> 
>>>> isel (which is base PowerPC, not something "e500" only) is a
>>>> computational instruction, it copies one of two registers to a third,
>>>> which of the two is decided by any bit in the condition register.
>>>
>>> Does that mean it could be used for all the ppc cpu variants?
>>
>> No, only things that implement architecture version of 2.03 or later.
>> That is from 2006, so essentially everything that is still made
>> implements it :-)
>>
>> But ancient things do not.  Both 970 (Apple G5) and Cell BE do not yet
>> have it (they are ISA 2.01 and 2.02 respectively).  And the older p5's
>> do not have it yet either, but the newer ones do.

For book3s64, GCC only use isel with -mcpu=power9 or -mcpu=power10

>>
>> And all classic PowerPC is ISA 1.xx of course.  Medieval CPUs :-)
> 
> That make more sense than the list in patch 5/5.

Sorry for the ambiguity. In patch 5/5 I was addressing only powerpc/32, 
and as far as I know the only powerpc/32 supported by Linux that has 
isel is the 85xx which has an e500 core.

For powerpc/64 we have less constraint than on powerpc32:
- Kernel memory starts at 0xc000000000000000
- User memory stops at 0x0010000000000000

So we can easily use 0x8000000000000000 as demarcation line, which 
allows a 3 instructions sequence:

	sradi	r9,r3,63   => shirt right algebric: r9 = 0 when r3 >= 0; r9 = -1 
when r3 < 0
	andc	r3,r3,r9   => and with complement: r3 unchanged when r9 = 0, r3 = 
0 when r9 = -1
	rldimi	r3,r9,0,1  => Rotate left and mask insert: Insert highest bit of 
r9 into r3

Whereas using isel requires a 4 instructions sequence:

	li	r9, 1		=> load immediate: r9 = 1
	rotldi	r9, r9, 63	=> rotate left: r9 = 0x8000000000000000
	cmpld	r3, r9		=> compare logically
	iselgt	r3, r9, r3	=> integer select greater than: select r3 when result 
of above compare is <= ; select r9 when result of compare is >

> 
>>
>>>> But sure, seen from very far off both isel and cmove can be used to
>>>> implement the ternary operator ("?:"), are similar in that way :-)
>>>
>>> Which is exactly what you want to avoid speculation.
>>
>> There are cheaper / simpler / more effective / better ways to get that,
>> but sure, everything is better than a conditional branch, always :-)
> 
> Everything except a TLB miss :-)
> 
> And for access_ok() avoiding the conditional is a good enough reason
> to use a 'conditional move' instruction.
> Avoiding speculation is actually free.
> 

And on CPUs that are not affected by Spectre and Meltdown like powerpc 
8xx or powerpc 603, masking the pointer is still worth it as it 
generates better code, even if the masking involves branching.

That's the reason why I did:
- e500 (affected by Spectre v1) ==> Use isel ==> 3 instructions sequence:

	lis	r9, TASK_SIZE@h	=> load immediate shifted => r9 = (TASK_SIZE >> 16) 
<< 16
	cmplw	r3, r9		=> compare addr with TASK_SIZE
	iselgt	r3, r9, r3	=> addr = TASK_SIZE when addr > TASK_SIZE; addr = 
addr when <= TASK_SIZE

For others:
- If TASK_SIZE <= 0x80000000 and kernel >= 0x80000000 ==> 3 instructions 
sequence similar to the 64 bits one above:

	srawi	r9,r3,63
	andc	r3,r3,r9
	rlwimi	r3,r9,0,0,0

- Otherwise, if speculation mitigation is required (e600), use the 
6-instructions masking sequence (r3 contains the address to mask)

	srwi	r9,r3,17	=> shift right: shift r3 by 17 to keep 15 bits (positive 
16 bits)
	subfic	r9,r9,22527	=> sub from immediate: r9 = (TASK_SIZE >> 17) - r9 
=> r9 < 0 when r3 is greater
	srawi	r9,r9,31	=> shift right algebric: r9 = 0 when r9 >= 0; r9 = -1 
when r9 < 0
	andis.	r10,r9,45056	=> and immediat shifted: r10 = r9 and upper part of 
TASK_SIZE => r10 = TASK_SIZE when r3 > TASK_SIZE, r10 = 0 otherwise
	andc	r3,r3,r9	=> and with complement: r3 is unchanged when r9 = 0 so 
when r3 <= TASK_SIZE, r3 is cleared when r9 = -1 so when r3 > TASK_SIZE
	or	r3,r3,r10	=> r3 = r3 | r10


- If no speculation mitigation is required, let GCC do as it wants

List of affected CPUs is available here: 
https://docs.nxp.com/bundle/GUID-805CC0EA-4001-47AD-86CD-4F340751F6B7/page/GUID-17B5D04F-6471-4EC6-BEB9-DE4D0AFA034A.html

