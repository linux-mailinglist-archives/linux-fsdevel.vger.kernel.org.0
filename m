Return-Path: <linux-fsdevel+bounces-27140-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C9795EEBE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 12:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 999891C21BE7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 10:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C2214D2A7;
	Mon, 26 Aug 2024 10:45:45 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356D013A869;
	Mon, 26 Aug 2024 10:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724669145; cv=none; b=hWDncWWosqOEAG+D8/TCe3+OFT7qLD6djFYzluR8xnnvzNOmT7vuu3RKsx/Slr8Oez72vim6uiiicDFqzrl5kmlAkbABjUq1/6EZOlW7D12tZ5sibikb8peS2JbJvotBIhFS+OYHdgFgM/2zFpfoS5cX5m1hNuHUtkMHPVc7v5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724669145; c=relaxed/simple;
	bh=g0USLf+Ak90WITfjotmZss3CJ/mqie6EleQ66n1D8sw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DUtPlkqH7YO+J54ACptvZ542dgNBug5nyxjKFzEjODNlJJYTHKeNQ0ZwFDY4o/19KHScM22GPbdDPrHKVxsqJTcr5MFUMj8LLpfrDrVspGA7CrsbWcsAq9EjGj8JvyoIAcOw/Ldluo18A1uTpCRXdzhStuwtzu7Ps11LgipUSv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WsnQF0ZHkz9sRk;
	Mon, 26 Aug 2024 12:45:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8l3J2mPFqWI2; Mon, 26 Aug 2024 12:45:40 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WsnQD6mKZz9sPd;
	Mon, 26 Aug 2024 12:45:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id D56398B779;
	Mon, 26 Aug 2024 12:45:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id L__8Kfk3Evvz; Mon, 26 Aug 2024 12:45:40 +0200 (CEST)
Received: from [172.25.230.108] (unknown [172.25.230.108])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 86F3C8B763;
	Mon, 26 Aug 2024 12:45:40 +0200 (CEST)
Message-ID: <51adbe91-3c3a-4baa-bb39-29df98a6eea5@csgroup.eu>
Date: Mon, 26 Aug 2024 12:45:40 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/17] vdso: Clean header inclusion in getrandom
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
 <2a081f1fff5e40f496153f8e0162fc7ec5adab2e.1724309198.git.christophe.leroy@csgroup.eu>
 <Zsw3xMoX2EI5UUs1@zx2c4.com>
 <7e519ba2-0293-4320-84bf-44f930fc286d@csgroup.eu>
 <ZsxDssNPbLkcPetJ@zx2c4.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <ZsxDssNPbLkcPetJ@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 26/08/2024 à 10:58, Jason A. Donenfeld a écrit :
> On Mon, Aug 26, 2024 at 10:37:49AM +0200, Christophe Leroy wrote:
>>
>>
>> Le 26/08/2024 à 10:07, Jason A. Donenfeld a écrit :
>>> On Thu, Aug 22, 2024 at 09:13:10AM +0200, Christophe Leroy wrote:
>>>>    
>>>> +#define _PAGE_SIZE (1UL << CONFIG_PAGE_SHIFT)
>>>> +#define _PAGE_MASK (~(_PAGE_SIZE - 1))
>>>
>>> If PAGE_SIZE isn't defined at this point, why not just call it PAGE_SIZE
>>> instead of _PAGE_SIZE? But if that's the case, why not put the vdso
>>> definition of PAGE_SIZE into some vdso header included by this file?
>>
>> It was working ok on powerpc but on x86 I got:
> 
> Seems like there might be some more fiddling to do, then? Or did you
> conclude it's impossible?

Maybe someone who knows x86 in details could helps but after a first 
look I gave up because it looks very x86 specific, indeed that's 
x86/asm/vdso/gettimeofday.h that pulls several x86/asm/ headers , and 
the same type of issue might arise for any new architecture coming in.

For me it looked cleaner to just do as commit cffaefd15a8f ("vdso: Use 
CONFIG_PAGE_SHIFT in vdso/datapage.h") and not use PAGE_SIZE at all. But 
I didn't want to directly use (1UL << CONFIG_PAGE_SHIFT) and (~(1UL << 
(CONFIG_PAGE_SHIFT - 1))) in the code directly hence the new macros with 
a leading underscore to avoid any conflict with existing macros.

Christophe

