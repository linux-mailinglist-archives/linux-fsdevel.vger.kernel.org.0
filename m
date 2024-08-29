Return-Path: <linux-fsdevel+bounces-27922-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B389964CED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 19:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2587F285AA4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 17:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001971B78F6;
	Thu, 29 Aug 2024 17:36:45 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21E13A8F0;
	Thu, 29 Aug 2024 17:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724953005; cv=none; b=NgFI8Ft76b2lf10EW311YRBWW7tQ+ttt76yzVaLmt/Iuv77mblc0kujcp5NhDNgisKgL30vL1oQ5BODsQ+yjn9nzdUq0bW2tBZcOAKrv6dV58iYyDJGhVIESetDxOfoS045/v0d28NkZ9v+qXftgPcrgNCRjWmG5XRw+BJ5vFxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724953005; c=relaxed/simple;
	bh=yCViMBF3htzQW2k40xveDOOEPO0zJOEzLhNmFYttUwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GEqwkgI40foio9Bm0BjB9rL1DYpG+zNHB2hfRRV1yZU/DnOXUw0EKVgTqQe3bbZsJlTPc7ukqUTmSzz42fE7grhoRueoSLmUSv82/cj66f7FD3qhPShcLkPrtGsvbbbkIEnH3eck62WXm7gXvSf+6bbzp74tXGua/zo8CPmR0m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WvpP538xwz9sS8;
	Thu, 29 Aug 2024 19:36:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 71Z_VYkOft16; Thu, 29 Aug 2024 19:36:41 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WvpP528mSz9sRs;
	Thu, 29 Aug 2024 19:36:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 317CB8B794;
	Thu, 29 Aug 2024 19:36:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id MDymf6ryo8rr; Thu, 29 Aug 2024 19:36:41 +0200 (CEST)
Received: from [192.168.234.66] (unknown [192.168.234.66])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 3CA178B764;
	Thu, 29 Aug 2024 19:36:39 +0200 (CEST)
Message-ID: <e5a36d98-c880-4d33-954a-2a05240ef02f@csgroup.eu>
Date: Thu, 29 Aug 2024 19:36:38 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/17] vdso: Avoid call to memset() by getrandom
To: Segher Boessenkool <segher@kernel.crashing.org>,
 Ard Biesheuvel <ardb@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, "Jason A . Donenfeld" <Jason@zx2c4.com>,
 Eric Biggers <ebiggers@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Theodore Ts'o <tytso@mit.edu>,
 Andrew Morton <akpm@linux-foundation.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, shuah <shuah@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <cover.1724309198.git.christophe.leroy@csgroup.eu>
 <5deb67090b214f0e6eae96b7c406546d1a16f89b.1724309198.git.christophe.leroy@csgroup.eu>
 <20240827180819.GB2049@sol.localdomain>
 <20240827225330.GC29862@gate.crashing.org> <Zs8HirKLk-SrwTIu@zx2c4.com>
 <fc19bf63-d519-46e2-be70-80202c85ff92@app.fastmail.com>
 <20240828124519.GE29862@gate.crashing.org>
 <CAMj1kXGmDmxy75eP=rf_fzKmg0g_FeKV43jk2G_gibnKZBtVww@mail.gmail.com>
 <20240828162025.GG29862@gate.crashing.org>
 <CAMj1kXHZPfr2Sz78UrgsdX-2uBp0D1sCnznQnz5ZyMdiJq6rAA@mail.gmail.com>
 <20240828172538.GI29862@gate.crashing.org>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240828172538.GI29862@gate.crashing.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 28/08/2024 à 19:25, Segher Boessenkool a écrit :
> 
>> Not sure about static binaries, though: do those even use the VDSO?
> 
> With "static binary" people usually mean "a binary not using any DSOs",
> I think the VDSO is a DSO, also in this respect?  As always, -static
> builds are *way* less problematic (and faster and smaller :-) )
> 

AFAIK on powerpc even static binaries use the vDSO, otherwise signals 
don't work.

Christophe

