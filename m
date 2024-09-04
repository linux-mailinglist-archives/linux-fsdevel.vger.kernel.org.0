Return-Path: <linux-fsdevel+bounces-28562-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4299D96C0C2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 16:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E15E31F222F0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 14:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB89A1DB548;
	Wed,  4 Sep 2024 14:36:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B116463D;
	Wed,  4 Sep 2024 14:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725460580; cv=none; b=muypwSm+brZ9JrwQMIq4YXmcro1U0MQ+ujmTmy9ergt/b2+vdZOCRnyDsfDqwzvQdMGK3sKs4lRcC7ZwQ+NZzvJHQnj+/28lGx7nYEPG0vo066wtQrJKhY40qwf2ZAer7i2OJ6tODlwLNe2HwRoq9GmnotkCeveATH0GvHOg0iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725460580; c=relaxed/simple;
	bh=mrcpBZCNCDHUN8s1jct5aPcG3/C9zlzErsh6HAxxzVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BU8tYwZgM1wUklcuv3/A8c4VzhyITPhDrbfGyCFB6rjXSk2/5T0+SqM91zUFZzrJEIR5yik7+v2B0WuSlygJFNmEsPMmo5iXXvLsIAJpyYaQV14Xv4/k+lyhZye3Rh079MiM3yFr4flWFvtPl5K9qVNv7viXyVY+aBq6JHOkMqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WzQ685Z1lz9sS7;
	Wed,  4 Sep 2024 16:36:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j3Oi0qoOC3QN; Wed,  4 Sep 2024 16:36:16 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WzQ684j7Sz9sRy;
	Wed,  4 Sep 2024 16:36:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 8DE208B77A;
	Wed,  4 Sep 2024 16:36:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id MDg64KpQGgK2; Wed,  4 Sep 2024 16:36:16 +0200 (CEST)
Received: from [192.168.234.246] (unknown [192.168.234.246])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 9D5618B778;
	Wed,  4 Sep 2024 16:36:15 +0200 (CEST)
Message-ID: <070a2aa1-a804-4124-ad89-c43e09dc3ded@csgroup.eu>
Date: Wed, 4 Sep 2024 16:36:15 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/5] Wire up getrandom() vDSO implementation on powerpc
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
References: <cover.1725304404.git.christophe.leroy@csgroup.eu>
 <Zthr1nB_RJ56YD3O@zx2c4.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <Zthr1nB_RJ56YD3O@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 04/09/2024 à 16:16, Jason A. Donenfeld a écrit :
> Hi Christophe, Michael,
> 
> On Mon, Sep 02, 2024 at 09:17:17PM +0200, Christophe Leroy wrote:
>> This series wires up getrandom() vDSO implementation on powerpc.
>>
>> Tested on PPC32 on real hardware.
>> Tested on PPC64 (both BE and LE) on QEMU:
>>
>> Performance on powerpc 885:
>> 	~# ./vdso_test_getrandom bench-single
>> 	   vdso: 25000000 times in 62.938002291 seconds
>> 	   libc: 25000000 times in 535.581916866 seconds
>> 	syscall: 25000000 times in 531.525042806 seconds
>>
>> Performance on powerpc 8321:
>> 	~# ./vdso_test_getrandom bench-single
>> 	   vdso: 25000000 times in 16.899318858 seconds
>> 	   libc: 25000000 times in 131.050596522 seconds
>> 	syscall: 25000000 times in 129.794790389 seconds
>>
>> Performance on QEMU pseries:
>> 	~ # ./vdso_test_getrandom bench-single
>> 	   vdso: 25000000 times in 4.977777162 seconds
>> 	   libc: 25000000 times in 75.516749981 seconds
>> 	syscall: 25000000 times in 86.842242014 seconds
> 
> Looking good. I have no remaining nits on this patchset; it looks good
> to me.
> 
> A review from Michael would be nice though (in addition to the necessary
> "Ack" I need to commit this to my tree), because there are a lot of PPC
> particulars that I don't know enough about to review properly. For
> example, you use -ffixed-r30 on PPC64. I'm sure there's a good reason
> for this, but I don't know enough to assess it. And cvdso_call I have no
> idea what's going on. Etc.

You can learn a bit more about cvdso_call in commit ce7d8056e38b 
("powerpc/vdso: Prepare for switching VDSO to generic C implementation.")

About the fixed-r30, you can learn more in commit a88603f4b92e 
("powerpc/vdso: Don't use r30 to avoid breaking Go lang")


> 
> But anyway, awesome work, and I look forward to the final stretches.

Thanks, looking forward to getting this series applied.

Christophe

