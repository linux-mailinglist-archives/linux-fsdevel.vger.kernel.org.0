Return-Path: <linux-fsdevel+bounces-27110-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06AEB95EA85
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 09:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F5031C21139
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 07:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1556713B780;
	Mon, 26 Aug 2024 07:32:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5F7376E6;
	Mon, 26 Aug 2024 07:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724657575; cv=none; b=ZnWL03rQqpRFTzUHMudmUJXk0sCeCmGy4urvOY7I5Q/0R+KOZ+cWoPl1erdMYmikjyLxerRaTilUqTaFyQe1fbzh9AB8VEw09Tsm98y6ozKsJgEWJM3V1LUwjPHtyScl6jaABQwp4GE6+TB//HZ5FBBLmuoJ67K5E4cLne/Jn98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724657575; c=relaxed/simple;
	bh=36FMxZsO1AVMWxx3BrlXfstysZmT2oIchtgmdHRtehI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MdzpKU0bqyOjBzxqNNIfa7yw5aH/8Ju+5ac676Q3tRk1SVM4/5uEj8oVBomc34Zg1bkkiRvV/+eQHdtZ2FCVhL+Q+7rSi3UHCumrSy02Mzh4LH5xcBhljSj+5UBT3kAvpeBhCS02r932CoiYWUlP7M1gxsDm0DL73AsG05nPg74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Wsj7f1sMnz9sRr;
	Mon, 26 Aug 2024 09:32:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zJY02ESYjtRG; Mon, 26 Aug 2024 09:32:46 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Wsj7f0yXmz9sRk;
	Mon, 26 Aug 2024 09:32:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 0EC928B76C;
	Mon, 26 Aug 2024 09:32:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id bh1CtcFXx0CH; Mon, 26 Aug 2024 09:32:45 +0200 (CEST)
Received: from [172.25.230.108] (unknown [172.25.230.108])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id B745C8B763;
	Mon, 26 Aug 2024 09:32:45 +0200 (CEST)
Message-ID: <a8b4c72d-07bd-4d14-aaa9-44fa332fd13e@csgroup.eu>
Date: Mon, 26 Aug 2024 09:32:45 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/17] asm-generic/unaligned.h: Extract common header
 for vDSO
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
 <a583352e8ae8f6a9a08f9b84a2c543fe43ef94db.1724309198.git.christophe.leroy@csgroup.eu>
 <Zsws0AkFnFDYo5p6@zx2c4.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <Zsws0AkFnFDYo5p6@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 26/08/2024 à 09:20, Jason A. Donenfeld a écrit :
> On Thu, Aug 22, 2024 at 09:13:09AM +0200, Christophe Leroy wrote:
>>   include/asm-generic/unaligned.h | 11 +----------
>>   include/vdso/unaligned.h        | 15 +++++++++++++++
>>   2 files changed, 16 insertions(+), 10 deletions(-)
>>   create mode 100644 include/vdso/unaligned.h
> 
> Do you need to also adjust the `#include <asm/unaligned.h>` inside of
> lib/vdso/getrandom.c to instead read `#include <vdso/unaligned.h>`?

Yes, all adjustments to lib/vdso/getrandom.c are in patch 2.

Christophe

