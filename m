Return-Path: <linux-fsdevel+bounces-27944-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02189964E32
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 20:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F2A81F257DA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 18:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CAB1B86CA;
	Thu, 29 Aug 2024 18:50:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCB814C59C;
	Thu, 29 Aug 2024 18:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724957435; cv=none; b=Ga2oJcVkgizxrba5s7l4cjJNagvRNi0hPyw0xcF19iswrGCQDHgAQ+iRImSGkP5z/xm4WuyE8XzOUFNPZj91/yOINphJ3vX43SYBVgZATpdYMJgF+OatoGllimWjRpCb5uOqWRa9WrQUxP6x1QUT2kEfL9E1uYX8jTtI32s/oyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724957435; c=relaxed/simple;
	bh=Qvvdt8As0tj94WcYrAFQF5qmE5TlgptVt/D8ZJGXxjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kWHURlPvjDKS+y4vgGOoO1b5rOvQcbgzwjc52ReH1Atn+MQloGRSQVmaj9tBzUC58zqZ57IYl/oHSg+sqzbyZvy83ft1UD9n8/wWrtrc9AHrI6ifFWE/KvgNHLhFP5VAJp5MaGezZialTjdnWUdyFw3AVWSbJ8+ZPRlTEKKxTSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Wvr2G19nBz9sS8;
	Thu, 29 Aug 2024 20:50:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Xnbi20xoF7or; Thu, 29 Aug 2024 20:50:30 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Wvr2G0DSsz9sRs;
	Thu, 29 Aug 2024 20:50:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id E7E898B794;
	Thu, 29 Aug 2024 20:50:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 3gsZv-SyUxEW; Thu, 29 Aug 2024 20:50:29 +0200 (CEST)
Received: from [192.168.234.66] (unknown [192.168.234.66])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id A97138B764;
	Thu, 29 Aug 2024 20:50:28 +0200 (CEST)
Message-ID: <eb7fdc6b-889f-4934-814f-f0572f4b089a@csgroup.eu>
Date: Thu, 29 Aug 2024 20:50:28 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/17] vdso: Avoid call to memset() by getrandom
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>, Eric Biggers <ebiggers@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Naveen N Rao <naveen@kernel.org>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Theodore Ts'o <tytso@mit.edu>, Andrew Morton <akpm@linux-foundation.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, shuah <shuah@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20240827180819.GB2049@sol.localdomain>
 <20240827225330.GC29862@gate.crashing.org> <Zs8HirKLk-SrwTIu@zx2c4.com>
 <fc19bf63-d519-46e2-be70-80202c85ff92@app.fastmail.com>
 <20240828124519.GE29862@gate.crashing.org>
 <CAMj1kXGmDmxy75eP=rf_fzKmg0g_FeKV43jk2G_gibnKZBtVww@mail.gmail.com>
 <20240828162025.GG29862@gate.crashing.org>
 <CAMj1kXHZPfr2Sz78UrgsdX-2uBp0D1sCnznQnz5ZyMdiJq6rAA@mail.gmail.com>
 <20240828172538.GI29862@gate.crashing.org>
 <e5a36d98-c880-4d33-954a-2a05240ef02f@csgroup.eu>
 <20240829180241.GJ29862@gate.crashing.org>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240829180241.GJ29862@gate.crashing.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 29/08/2024 à 20:02, Segher Boessenkool a écrit :
> On Thu, Aug 29, 2024 at 07:36:38PM +0200, Christophe Leroy wrote:
>>
>>
>> Le 28/08/2024 à 19:25, Segher Boessenkool a écrit :
>>>
>>>> Not sure about static binaries, though: do those even use the VDSO?
>>>
>>> With "static binary" people usually mean "a binary not using any DSOs",
>>> I think the VDSO is a DSO, also in this respect?  As always, -static
>>> builds are *way* less problematic (and faster and smaller :-) )
>>>
>>
>> AFAIK on powerpc even static binaries use the vDSO, otherwise signals
>> don't work.
> 
> How can that work?  Non-dynamic binaries do not use ld.so (that is the
> definition of a dynamic binary, even).  So they cannot link (at runtime)
> to any DSO (unless that is done manually?!)
> 
> Maybe there is something at a fixed offset in the vDSO, or something
> like that?  Is this documented somewhere?
> 

You've got some explanation here : 
https://github.com/torvalds/linux/blob/master/Documentation/ABI/stable/vdso

