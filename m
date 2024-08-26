Return-Path: <linux-fsdevel+bounces-27117-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D3C95EB4D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 10:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3472CB240AC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 08:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B65913BAE4;
	Mon, 26 Aug 2024 08:01:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E521543ABD;
	Mon, 26 Aug 2024 08:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724659281; cv=none; b=Dy4iz3T/+vMaCMnsOwE1EgBqhxLQ6FcJ1BtrKtHKYzhcXzBa8pwgPuT5sCCri8ujxFI1vARsjf3/8hhnpynKse0kYfYpOIbXz4eHv1JwgfLrdGfzXgFakl27hQYKKvrEn/t6QYOWkUKJbtyqL1oIu4HgnzQorGObmncH/9YZ+W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724659281; c=relaxed/simple;
	bh=24hc1MaXwK1dPf3z/uHEmN69vbP/XiOk2Xd0i6mLAHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LBoUIW9JADty1AqilwhQ+YqIbQVgMNuoKwxIPdY0U6p5AnUEB9pvkrTo06vbXhEXxQZ0SQknfAL4KZ0aOCybBZ98pacAzgRHzsYblt6oYf8p8dOb7r1+D/VeUeDuXk5wK6k00ru8L4BJTPRA6UoXlsVDssc5mY8af0pvF+WKdzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WsjmY6zrTz9sRr;
	Mon, 26 Aug 2024 10:01:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PYRaK4kN_GHj; Mon, 26 Aug 2024 10:01:17 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WsjmY5zwMz9sRk;
	Mon, 26 Aug 2024 10:01:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id BA4DC8B76C;
	Mon, 26 Aug 2024 10:01:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id GaRqVOGsRqIK; Mon, 26 Aug 2024 10:01:17 +0200 (CEST)
Received: from [172.25.230.108] (unknown [172.25.230.108])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 3CB668B763;
	Mon, 26 Aug 2024 10:01:17 +0200 (CEST)
Message-ID: <7d58be73-a8e5-4ec7-bbdc-238b0c25c77b@csgroup.eu>
Date: Mon, 26 Aug 2024 10:01:17 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/17] vdso: Change getrandom's generation to unsigned
 long
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Theodore Ts'o <tytso@mit.edu>,
 Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, Shuah Khan
 <shuah@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <cover.1724309198.git.christophe.leroy@csgroup.eu>
 <525b48eb79978ddba2d1b8ee23b27bd6c5b0b4ee.1724309198.git.christophe.leroy@csgroup.eu>
 <Zswzu1l3xO99KN3I@zx2c4.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <Zswzu1l3xO99KN3I@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 26/08/2024 à 09:50, Jason A. Donenfeld a écrit :
> On Thu, Aug 22, 2024 at 09:13:14AM +0200, Christophe Leroy wrote:
>> Performing SMP atomic operations on u64 fails on powerpc32.
>>
>> Random driver generation is handled as unsigned long not u64,
>> see for instance base_cnrg or struct crng.
>>
>> Use the same type for vDSO's getrandom as it gets copied
>> from the above. This is also in line with the local
>> current_generation which is already an unsigned long.
> 
> This isn't going to work when 32-bit userspace tries to access a 64-bit
> kernel.
> 
> I had "fixed" this with a vdso_kernel_ulong type way back in an earlier
> version: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flkml%2F20240528122352.2485958-5-Jason%40zx2c4.com%2F%23Z31include%3Avdso%3Atypes.h&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C41747dd989164267c1cc08dcc5a3c424%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638602554376441761%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=Tf9ShSN6aOOFZ1HymAmHhj0xhQ6BUtHJX95t50gsp9k%3D&reserved=0
> 
> But tglx pointed out in that thread that this actually isn't necessary:
> 
> | All of this is pointless because if a 32-bit application runs on a
> | 64-bit kernel it has to use the 64-bit 'generation'. So why on earth do
> | we need magic here for a 32-bit kernel?
> |
> | Just use u64 for both and spare all this voodoo. We're seriously not
> | "optimizing" for 32-bit kernels.
> |
> | All what happens on a 32-bit kernel is that the RNG will store the
> | unsigned long (32bit) generation into a 64bit variable:
> |
> | 	smp_store_release(&_vdso_rng_data.generation, next_gen + 1);
> |
> | As the upper 32bit are always zero, there is no issue vs. load store
> | tearing at all. So there is zero benefit for this aside of slightly
> | "better" user space code when running on a 32-bit kernel. Who cares?
> 
> So I just got rid of it and used a u64 as he suggested.
> 
> However, there's also an additional reason why it's not worth churning
> further over this - because VM_DROPPABLE is 64-bit only (due to flags in
> vma bits), likely so is vDSO getrandom() for the time being. So I think
> it makes more sense to retool this series to be ppc64, and then if you
> really really want 32-bit and can convince folks it matters, then all of
> these parts (for example, here, the fact that the smp helper doesn't
> want to tear) can be fixed up in a separate series.

So yes I really really want it on ppc32 because this is the only type of 
boards I have and this is really were we need getrandom() to be 
optimised, indeed ppc64 was sherry-on-the-cake in my series, I just 
added it because it was easy to do after doing ppc32.

Christophe

