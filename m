Return-Path: <linux-fsdevel+bounces-15599-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1790889076D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 18:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB7F21F26A84
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 17:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B04130E5A;
	Thu, 28 Mar 2024 17:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f0dgZsew"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0B04437B;
	Thu, 28 Mar 2024 17:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711648013; cv=none; b=iHvl/TV/6Wp93vqmwr+2qnaJWhj0/ds2wULTpKP3q9CP7Q3dne0x/jYC/ePraxfJ37AyZp1r6ZXnbVsdglSCVDenCb8FtSZmIt6R759tEyfn3tjYr5dkeD9OCK1cfEzSF09a6+TPVT2E6Ea8AlI8PtqvoHYcCGMoeB2RlVEkncI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711648013; c=relaxed/simple;
	bh=YNR7A+kRgAjMXDjHr2JB1yywFqUpQ/6e+8DUHAu4Nlg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nm/tXP2+yIQtZXI2ONJodO/9rf7GC3aUVWsbRsSTqQ9eFG8xrAaOojvomVLTGu8xrB3Jz8S1oiB8j8oh45v0Ox1GzQuUBpwf8yqnh+6QVKxw2ShsHUqjxKk8TUyQfXNy5E4rvNbX4vZU/S2/gpU4X7IvNhS3YQvYj50G+44/mGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f0dgZsew; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F2CC433C7;
	Thu, 28 Mar 2024 17:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711648012;
	bh=YNR7A+kRgAjMXDjHr2JB1yywFqUpQ/6e+8DUHAu4Nlg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=f0dgZsewbfCG8PiA45FJQw1TL/EasYUMhLz2/QhlXeqqfXOMfSFzRv9IkgTHijlFV
	 FhqTfFXUmCq641ywYGBQNJBov/tcSVKyclO43CvFgYl4vG0jR5PyLIGzGCMyZLU3uq
	 upLsVvNze+XfKUgkqPNlhtRQ4CV0x+8HigCh3u2WrcBvzfPqQuTABnjeZ6Hvb3VE8w
	 6ZvOi3ANgqwkkwdMuKgaXo07dtclbN/G0YdTFjA+6G2vfiNmaVW0Ibuf2jgixdXOzz
	 yzc01GzZXuDW31OzbOufYEa/h1z/NE2Qj9VquGG7bkMy752oMrsKA8KOWYY6NXnc2q
	 ClRqTQBAOutLg==
Message-ID: <1ea303d0-b5c6-4185-b6ae-8836c5ac0469@kernel.org>
Date: Thu, 28 Mar 2024 10:46:50 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/3] mm/gup: consistently call it GUP-fast
To: Mike Rapoport <rppt@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Vineet Gupta <vgupta@kernel.org>, David Hildenbrand <david@redhat.com>,
 peterx <peterx@redhat.com>, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Jason Gunthorpe <jgg@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-mm@kvack.org,
 linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 x86@kernel.org, Ryan Roberts <ryan.roberts@arm.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Matt Turner <mattst88@gmail.com>,
 Alexey Brodkin <abrodkin@synopsys.com>
References: <20240327130538.680256-1-david@redhat.com> <ZgQ5hNltQ2DHQXps@x1n>
 <3922460a-4d01-4ecb-b8c5-7c57fd46f3fd@redhat.com>
 <dc1433ea-4e59-4ab7-83fb-23b393020980@app.fastmail.com>
 <3360dba8-0fac-4126-b72b-abc036957d6a@kernel.org>
 <10da3ced-9a79-4ebb-a77d-1aa49cc61952@app.fastmail.com>
 <ZgUZCBNloC-grPWJ@kernel.org>
Content-Language: en-US
From: Vineet Gupta <vgupta@kernel.org>
In-Reply-To: <ZgUZCBNloC-grPWJ@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 3/28/24 00:15, Mike Rapoport wrote:
> On Thu, Mar 28, 2024 at 07:09:13AM +0100, Arnd Bergmann wrote:
>> On Thu, Mar 28, 2024, at 06:51, Vineet Gupta wrote:
>>> On 3/27/24 09:22, Arnd Bergmann wrote:
>>>> On Wed, Mar 27, 2024, at 16:39, David Hildenbrand wrote:
>>>>> On 27.03.24 16:21, Peter Xu wrote:
>>>>>> On Wed, Mar 27, 2024 at 02:05:35PM +0100, David Hildenbrand wrote:
>>>>>>
>>>>>> I'm not sure what config you tried there; as I am doing some build tests
>>>>>> recently, I found turning off CONFIG_SAMPLES + CONFIG_GCC_PLUGINS could
>>>>>> avoid a lot of issues, I think it's due to libc missing.  But maybe not the
>>>>>> case there.
>>>>> CCin Arnd; I use some of his compiler chains, others from Fedora directly. For
>>>>> example for alpha and arc, the Fedora gcc is "13.2.1".
>>>>> But there is other stuff like (arc):
>>>>>
>>>>> ./arch/arc/include/asm/mmu-arcv2.h: In function 'mmu_setup_asid':
>>>>> ./arch/arc/include/asm/mmu-arcv2.h:82:9: error: implicit declaration of 
>>>>> function 'write_aux_reg' [-Werro
>>>>> r=implicit-function-declaration]
>>>>>     82 |         write_aux_reg(ARC_REG_PID, asid | MMU_ENABLE);
>>>>>        |         ^~~~~~~~~~~~~
>>>> Seems to be missing an #include of soc/arc/aux.h, but I can't
>>>> tell when this first broke without bisecting.
>>> Weird I don't see this one but I only have gcc 12 handy ATM.
>>>
>>>     gcc version 12.2.1 20230306 (ARC HS GNU/Linux glibc toolchain -
>>> build 1360)
>>>
>>> I even tried W=1 (which according to scripts/Makefile.extrawarn) should
>>> include -Werror=implicit-function-declaration but don't see this still.
>>>
>>> Tomorrow I'll try building a gcc 13.2.1 for ARC.
>> David reported them with the toolchains I built at
>> https://mirrors.edge.kernel.org/pub/tools/crosstool/
>> I'm fairly sure the problem is specific to the .config
>> and tree, not the toolchain though.
> This happens with defconfig and both gcc 12.2.0 and gcc 13.2.0 from your
> crosstools. I also see these on the current Linus' tree:
>
> arc/kernel/ptrace.c:342:16: warning: no previous prototype for 'syscall_trace_enter' [-Wmissing-prototypes]
> arch/arc/kernel/kprobes.c:193:15: warning: no previous prototype for 'arc_kprobe_handler' [-Wmissing-prototypes]

Yep these two I could trigger and fix posted [1]

> This fixed the warning about write_aux_reg for me, probably Vineet would
> want this include somewhere else...
>
> diff --git a/arch/arc/include/asm/mmu-arcv2.h b/arch/arc/include/asm/mmu-arcv2.h
> index ed9036d4ede3..0fca342d7b79 100644
> --- a/arch/arc/include/asm/mmu-arcv2.h
> +++ b/arch/arc/include/asm/mmu-arcv2.h
> @@ -69,6 +69,8 @@
>  
>  #ifndef __ASSEMBLY__
>  
> +#include <asm/arcregs.h>
> +
>  struct mm_struct;
>  extern int pae40_exist_but_not_enab(void);

Thx Mike. Indeed the fix is trivial but on tip of tree I still can't
trigger the warning to even test anything. I'm at following with my
other fixes.

    2024-03-27 962490525cff Merge tag 'probes-fixes-v6.9-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace  

I tried defconfig build as well as the exact config from Linaro report
[2], and/or various toolchains: from snps github, Arnd's crosstool
toolchain.
Granted all of these are linux toolchains - I vaguely remember at some
time, baremetal elf32 toolchain behaved differently due to different
defaults etc.
I have a feeling this was something transient which got fixed up due to
order of header includes etc.

Anyone in the followup email David only reported 2 warnings which have
been tended to as mentioned above - will be sent to Linus soon.

[1]
http://lists.infradead.org/pipermail/linux-snps-arc/2024-March/007916.html
[2]
https://storage.tuxsuite.com/public/linaro/lkft/builds/2eA2VSZdDsL0DMBBhjoauN9IVoK/

Thx,
-Vineet

