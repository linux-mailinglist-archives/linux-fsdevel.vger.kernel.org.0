Return-Path: <linux-fsdevel+bounces-58992-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B35FCB33BB9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 11:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1662A3A9259
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 09:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700C52D29C4;
	Mon, 25 Aug 2025 09:50:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29CD22C0F65;
	Mon, 25 Aug 2025 09:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756115437; cv=none; b=CvOtHTSM2Gd+mQbYhII7ghny0Kutmhftf/6KnP3zZOQGbm9kA7TtpOat0tvPINQqPcwFMJWR8BBrMzdzYlz49laCvHxCTxDbD7Tr5/kn0tmwAQGjc7Ae5npYp4152K0fgrkkl2sK1KFjU1gCQZTdBM+5hE6bWVceYVjYMu5NxCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756115437; c=relaxed/simple;
	bh=WuNi08YDO7zUInQPrIkdSuqkazQY7ISfvSzQC4AW2Lg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A17O7XflMB7Mpc7DWpVvNRL/SE2ItC44W3Ky6CfhFbrhuEadmTrsZoPI1/4a+mzseYqS9Fq8PC3Xhr5XdLju7VKltFEcQLCJAm5ZPTzhN/rd935vPsdOjtBn6eZyOSqbNxrpKS7G+nCZmelhgshmHtlh171YoJiCrw8AoE9oSMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4c9QlP1HkLz9sSh;
	Mon, 25 Aug 2025 11:40:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xXbQBsr7Ehxm; Mon, 25 Aug 2025 11:40:49 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4c9QlP04NMz9sSc;
	Mon, 25 Aug 2025 11:40:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id D6B268B765;
	Mon, 25 Aug 2025 11:40:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id gtwn_B0_QRlE; Mon, 25 Aug 2025 11:40:48 +0200 (CEST)
Received: from [10.25.207.160] (unknown [10.25.207.160])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 763DD8B764;
	Mon, 25 Aug 2025 11:40:48 +0200 (CEST)
Message-ID: <16679d56-5ee0-469d-a11c-475a45a1c2b9@csgroup.eu>
Date: Mon, 25 Aug 2025 11:40:48 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/10] powerpc/uaccess: Implement masked user access
To: Gabriel Paubert <paubert@iram.es>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, Andre Almeida <andrealmeid@igalia.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Laight <david.laight.linux@gmail.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Daniel Borkmann <daniel@iogearbox.net>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-block@vger.kernel.org
References: <cover.1755854833.git.christophe.leroy@csgroup.eu>
 <647f1b1db985aec8ec1163bf97688563ae6f9609.1755854833.git.christophe.leroy@csgroup.eu>
 <aKwnMo7UllLZkOcK@lt-gp.iram.es>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <aKwnMo7UllLZkOcK@lt-gp.iram.es>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Gabriel,

Le 25/08/2025 à 11:04, Gabriel Paubert a écrit :
> [Vous ne recevez pas souvent de courriers de paubert@iram.es. D?couvrez pourquoi ceci est important ? https://aka.ms/LearnAboutSenderIdentification ]
> 
> Hi Christophe,
> 
> On Fri, Aug 22, 2025 at 11:58:06AM +0200, Christophe Leroy wrote:
>> Masked user access avoids the address/size verification by access_ok().
>> Allthough its main purpose is to skip the speculation in the
>> verification of user address and size hence avoid the need of spec
>> mitigation, it also has the advantage of reducing the amount of
>> instructions required so it even benefits to platforms that don't
>> need speculation mitigation, especially when the size of the copy is
>> not know at build time.
>>
>> So implement masked user access on powerpc. The only requirement is
>> to have memory gap that faults between the top user space and the
>> real start of kernel area.
>>
>> On 64 bits platforms the address space is divided that way:
>>
>>        0xffffffffffffffff      +------------------+
>>                                |                  |
>>                                |   kernel space   |
>>                                |                  |
>>        0xc000000000000000      +------------------+  <== PAGE_OFFSET
>>                                |//////////////////|
>>                                |//////////////////|
>>        0x8000000000000000      |//////////////////|
>>                                |//////////////////|
>>                                |//////////////////|
>>        0x0010000000000000      +------------------+  <== TASK_SIZE_MAX
>>                                |                  |
>>                                |    user space    |
>>                                |                  |
>>        0x0000000000000000      +------------------+
>>
>> Kernel is always above 0x8000000000000000 and user always
>> below, with a gap in-between. It leads to a 4 instructions sequence:
>>
>>    80: 7c 69 1b 78     mr      r9,r3
>>    84: 7c 63 fe 76     sradi   r3,r3,63
>>    88: 7d 29 18 78     andc    r9,r9,r3
>>    8c: 79 23 00 4c     rldimi  r3,r9,0,1
>>
>> This sequence leaves r3 unmodified when it is below 0x8000000000000000
>> and clamps it to 0x8000000000000000 if it is above.
>>
> 
> This comment looks wrong: the second instruction converts r3 to a
> replicated sign bit of the address ((addr>0)?0:-1) if treating the
> address as signed. After that the code only modifies the MSB of r3. So I
> don't see how r3 could be unchanged from the original value...

Unless I'm missing something, the above rldimi leaves the MSB of r3 
unmodified and replaces all other bits by the same in r9.

This is the code generated by GCC for the following:

	unsigned long mask = (unsigned long)((long)addr >> 63);

	addr = ((addr & ~mask) & (~0UL >> 1)) | (mask & (1UL << 63));


> 
> OTOH, I believe the following 3 instructions sequence would work,
> input address (a) in r3, scratch value (tmp) in r9, both intptr_t:
> 
>          sradi r9,r3,63  ; tmp = (a >= 0) ? 0L : -1L;
>          andc r3,r3,r9   ; a = a & ~tmp; (equivalently a = (a >= 0) ? a : 0)
>          rldimi r3,r9,0,1 ; copy MSB of tmp to MSB of a
> 
> But maybe I goofed...
> 

 From my understanding of rldimi, your proposed code would:
- Keep r3 unmodified when it is above 0x8000000000000000
- Set r3 to 0x7fffffffffffffff when it is below 0x8000000000000000

Extract of ppc64 ABI:

rldimi RA,RS,SH,MB

The contents of register RS are rotated 64 left SH bits.
A mask is generated having 1-bits from bit MB
through bit 63− SH and 0-bits elsewhere. The rotated
data are inserted into register RA under control of the
generated mask.



