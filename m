Return-Path: <linux-fsdevel+bounces-57112-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5330B1EC85
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 17:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6099189102B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 15:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D387285CB5;
	Fri,  8 Aug 2025 15:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=syntacore.com header.i=@syntacore.com header.b="cY1qxj6u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m.syntacore.com (m.syntacore.com [178.249.69.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDFB285CA2;
	Fri,  8 Aug 2025 15:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.249.69.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754668483; cv=none; b=YHGge2iOUkEjxn0ynXSR7ZJu/VckEXxkbecVmbPFp3shR5TJH+5eiqMQXmYU7ubAki7Kqf4SuGa5WdKx5rR0yKyPy26llRvOJh6dZZipxRe1AkL7mDLe3+D86NrZomuBzvkZ+UwTl7a/qMuk2y4bREekkGRbun/0N9aYaNGevBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754668483; c=relaxed/simple;
	bh=7WOPIyzEehEJNbU2YvlvCqDUTP5c7rF7fpWyJn2Ujkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UiiOLpwyMNUnUE3zVjLotiwqjHZQvol2u8Tzkb/Yo35QRWsjNDg2GvMlygl+Y5c7FQ2yRLcEaGKMVPrDi598bzHJu766Db+HwdHbrax2za2JpbqaCg0ELZJjqxZIX+UFaky8GUgFHQQiuPCdHKG7p6x5se8pIHv2ZzF77dpxd7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=syntacore.com; spf=pass smtp.mailfrom=syntacore.com; dkim=pass (2048-bit key) header.d=syntacore.com header.i=@syntacore.com header.b=cY1qxj6u; arc=none smtp.client-ip=178.249.69.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=syntacore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=syntacore.com
Received: from MRN-SC-KSMG-01.corp.syntacore.com (localhost [127.0.0.1])
	by m.syntacore.com (Postfix) with ESMTP id 6A5741A0005;
	Fri,  8 Aug 2025 15:54:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 m.syntacore.com 6A5741A0005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com; s=m;
	t=1754668474; bh=Kc+rXQkjUIWlJHfTJTdiMVQq7J3K3zY9PQJSj6n1aPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=cY1qxj6ujcXBoiuVPCl+xltzfS9Mli+br7NY1LQ7Y90FmKAMBaild5S9xJtD1UwL3
	 rCeoJBbLFG6tWSxbNwIEr/UWXAS9aERBN6cNQ9DOM8DMmxkdygcC+s5udB4H03T4Ma
	 zHqVGkbJEFzMaTmNqi4SfXObpMVNU9c1ib4KMChRBPLZ36JSZlnEqDN4vi4vSyFGP6
	 mq58f6e+axpHdDFRM9z4jWo1T5WSoVHBmSujkERo0l/0zui/ydNGuFpQZlU7jUQk9Y
	 CXQkXjJJDUGknP8UkGrSGa2p+SQEmXSlDCuOkMr0kkdIYNWVBcHfLlp39csWrHwJ/v
	 /j8jBVf745PtA==
Received: from S-SC-EXCH-01.corp.syntacore.com (exchange.syntacore.com [10.76.202.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by m.syntacore.com (Postfix) with ESMTPS;
	Fri,  8 Aug 2025 15:54:32 +0000 (UTC)
Received: from [10.178.118.36] (10.178.118.36) by
 S-SC-EXCH-01.corp.syntacore.com (10.76.202.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 8 Aug 2025 18:53:53 +0300
Message-ID: <2c196c3f-4d49-494c-898e-8a1f6249ce24@syntacore.com>
Date: Fri, 8 Aug 2025 21:54:30 +0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC RESEND] binfmt_elf: preserve original ELF e_flags in core
 dumps
To: Kees Cook <kees@kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <viro@zeniv.linux.org.uk>,
	<brauner@kernel.org>, <jack@suse.cz>, <akpm@linux-foundation.org>,
	<david@redhat.com>, <lorenzo.stoakes@oracle.com>, <Liam.Howlett@oracle.com>,
	<vbabka@suse.cz>, <rppt@kernel.org>, <surenb@google.com>, <mhocko@suse.com>
References: <20250806161814.607668-1-svetlana.parfenova@syntacore.com>
 <202508061152.6B26BDC6FB@keescook>
 <e9990237-bc83-4cbb-bab8-013b939a61fb@syntacore.com>
 <202508071414.5A5AB6B2@keescook>
Content-Language: en-US
From: Svetlana Parfenova <svetlana.parfenova@syntacore.com>
In-Reply-To: <202508071414.5A5AB6B2@keescook>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: S-SC-EXCH-01.corp.syntacore.com (10.76.202.20) To
 S-SC-EXCH-01.corp.syntacore.com (10.76.202.20)
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/08/08 08:14:00 #27646097
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 5

On 08/08/2025 03.14, Kees Cook wrote:
> On Thu, Aug 07, 2025 at 07:13:50PM +0600, Svetlana Parfenova wrote:
>> On 07/08/2025 00.57, Kees Cook wrote:
>>> On Wed, Aug 06, 2025 at 10:18:14PM +0600, Svetlana Parfenova
>>> wrote:
>>>> Preserve the original ELF e_flags from the executable in the
>>>> core dump header instead of relying on compile-time defaults
>>>> (ELF_CORE_EFLAGS or value from the regset view). This ensures
>>>> that ABI-specific flags in the dump file match the actual
>>>> binary being executed.
>>>> 
>>>> Save the e_flags field during ELF binary loading (in
>>>> load_elf_binary()) into the mm_struct, and later retrieve it
>>>> during core dump generation (in fill_note_info()). Use this
>>>> saved value to populate the e_flags in the core dump ELF
>>>> header.
>>>> 
>>>> Add a new Kconfig option, CONFIG_CORE_DUMP_USE_PROCESS_EFLAGS,
>>>> to guard this behavior. Although motivated by a RISC-V use
>>>> case, the mechanism is generic and can be applied to all
>>>> architectures.
>>> 
>>> In the general case, is e_flags mismatched? i.e. why hide this
>>> behind a Kconfig? Put another way, if I enabled this Kconfig and
>>> dumped core from some regular x86_64 process, will e_flags be
>>> different?
>>> 
>> 
>> The Kconfig option is currently restricted to the RISC-V
>> architecture because it's not clear to me whether other
>> architectures need actual e_flags value from ELF header. If this
>> option is disabled, the core dump will always use a compile time
>> value for e_flags, regardless of which method is selected:
>> ELF_CORE_EFLAGS or CORE_DUMP_USE_REGSET. And this constant does 
>> not necessarily reflect the actual e_flags of the running process
>> (at least on RISC-V), which can vary depending on how the binary
>> was compiled. Thus, I made a third method to obtain e_flags that
>> reflects the real value. And it is gated behind a Kconfig option,
>> as not all users may need it.
> 
> Can you check if the ELF e_flags and the hard-coded e_flags actually 
> differ on other architectures? I'd rather avoid using the Kconfig so
> we can have a common execution path for all architectures.
> 

I checked various architectures, and most don’t use e_flags in core
dumps - just zero value. For x86 this is valid since it doesn’t define
values for e_flags. However, architectures like ARM do have meaningful
e_flags, yet still they are set to zero in core dumps. I guess the real
question isn't about core dump correctness, but whether tools like GDB
actually rely on e_flags to provide debug information. Seems like most
architectures either don’t use it or can operate without it. RISC-V
looks like black sheep here ... GDB relies on e_flags to determine the
ABI and interpret the core dump correctly.

What if I rework my patch the following way:
- remove Kconfig option;
- add function/macro that would override e_flags with value taken from
process, but it would only be applied if architecture specifies that.

Would that be a better approach?

-- 
Best regards,
Svetlana Parfenova

