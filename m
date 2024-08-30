Return-Path: <linux-fsdevel+bounces-28080-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CCE496673C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 18:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EFBE1C24A86
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 16:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E00B1BA26B;
	Fri, 30 Aug 2024 16:43:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E001B9B28;
	Fri, 30 Aug 2024 16:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725036179; cv=none; b=ugzpoAladcrCDvMWX3OPWdPVci9xMFtnjX/KjtP+1klbvvsaPoNlpLXlBCiT8ETHp4pg98SoVmAdPw41oUts08+vjETVG9QT0JybsNOc3Slj2tuOgZvJdrJn583TBB5DwHl3s3kswg0vER3dd/RFy8md2/JgInDQq52WZSXGR7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725036179; c=relaxed/simple;
	bh=TOnGq0IO24mAJLekrXPB1z6LZN6IYMcZ09nnaFQEPw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RlIJlsvvpwW8IiauzKL7Y1kTdNcTz9spdy/FCFSWuG/hSkt3QL5ShnMB+Pq8vLjPvJPc9LT/7el6zzbGqLsG+WROm4QZtNupozhODKpnYD7aHpzDlaGskhFa/1hSwfv3rDBnZpEj8ubGQs42KkkdTglewX9e7oksZ9bhkSoVR9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WwP8c465gz9sS8;
	Fri, 30 Aug 2024 18:42:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6brwcfcnvqln; Fri, 30 Aug 2024 18:42:56 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WwP8c3CYvz9sS7;
	Fri, 30 Aug 2024 18:42:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 59C838B794;
	Fri, 30 Aug 2024 18:42:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id spbTDoYI002a; Fri, 30 Aug 2024 18:42:56 +0200 (CEST)
Received: from [192.168.234.133] (unknown [192.168.234.133])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 74A238B764;
	Fri, 30 Aug 2024 18:42:55 +0200 (CEST)
Message-ID: <84682299-8cbe-4b66-9c26-17786e73af55@csgroup.eu>
Date: Fri, 30 Aug 2024 18:42:55 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] powerpc/vdso: Wire up getrandom() vDSO
 implementation on PPC32
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Naveen N Rao <naveen@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
 llvm@lists.linux.dev, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org,
 Adhemerval Zanella <adhemerval.zanella@linaro.org>,
 Xi Ruoyao <xry111@xry111.site>
References: <cover.1725031952.git.christophe.leroy@csgroup.eu>
 <e7e4c6d36cf98229850c333f113bcea909564501.1725031952.git.christophe.leroy@csgroup.eu>
 <ZtHv9R8b7qwWKR2b@zx2c4.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <ZtHv9R8b7qwWKR2b@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 30/08/2024 à 18:14, Jason A. Donenfeld a écrit :
> On Fri, Aug 30, 2024 at 05:57:08PM +0200, Christophe Leroy wrote:
>> + *	r5: 8-byte counter input/output (saved on stack)
>> + *
>> + *	r14-r15: counter
>> + */
>> +SYM_FUNC_START(__arch_chacha20_blocks_nostack)
>> +	stwu	r1, -96(r1)
>> +	stw	r5, 20(r1)
>> +	stmw	r14, 24(r1)
>> +	li	r31, 4
>> +	LWZX_LE	r14, 0, r5
>> +	LWZX_LE	r15, r31, r5
> 
> Why swap endian on the counter?

Unlike the keys, the counter is passed to the function as an u8*, not as 
a u64*, so I thought it was raw data in little endian order, same as 
when using Sodium. Is it wrong ?

Christophe

