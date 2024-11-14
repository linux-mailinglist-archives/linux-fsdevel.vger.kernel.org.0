Return-Path: <linux-fsdevel+bounces-34718-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9669C8014
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 02:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78E05B2414D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 01:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39341DD0D2;
	Thu, 14 Nov 2024 01:40:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692091CCEFD
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Nov 2024 01:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731548409; cv=none; b=mrna6sQaU7abEYyCRrhufoXDxIaqqYWoX3cRbChD898zsr6pZdJwqiANcGLDikCUkIEPdaGIkFyh6RBEj1tVgyDCJgwnDs/HBdpPZrEgtxx+jVmOIX9mAHOqgd0JuJ0qLp9lvFXpj7HpVGI9ieY6pl3/n0b/Wy3oOabtK8fYDnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731548409; c=relaxed/simple;
	bh=AFyq9ZZJYaQzh2UYhH0Kw30ORoi3MHUBSFdnUMeboyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VfvjGng+UPF/XJ6IilqhOTyxngXDKrGmdm3WthNqzf8AZUtnBKTE3lwBLtnehhUiMW4IqGaLsx9P+GfcGzK29xNMt5+qPOhUQRgrmcxJog5D8mRn01Ff8tpdY8/uv9q2lY4zVP7i8HUCAgbL23cbq+vFz19mqlkZoKyD+q4Yr8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03B73C4CEC3;
	Thu, 14 Nov 2024 01:40:05 +0000 (UTC)
Message-ID: <7290bc34-d398-4ea1-8e52-193f1021e114@linux-m68k.org>
Date: Thu, 14 Nov 2024 11:40:03 +1000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 02/13] x86/um: nommu: elf loader for fdpic
To: Hajime Tazaki <thehajime@gmail.com>, geert@linux-m68k.org
Cc: johannes@sipsolutions.net, linux-um@lists.infradead.org,
 ricarkol@google.com, Liam.Howlett@oracle.com, ebiederm@xmission.com,
 kees@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, dalias@libc.org
References: <cover.1731290567.git.thehajime@gmail.com>
 <ea2a3fb86915664d54ba174e043046f684e7cf8c.1731290567.git.thehajime@gmail.com>
 <CAMuHMdU+Lyj3C-P3kQMd6WfyjBY+YXZSx3Vv6C2y9k__pK45vg@mail.gmail.com>
 <m2pln0f6mm.wl-thehajime@gmail.com>
 <CAMuHMdXC0BbiOjWsiN1Mg8Jkm03_H6_-fERSnFEB2pkW_VWmaA@mail.gmail.com>
 <8bbfe73f7f1ef9f1a4674d963d1c4e8181f33341.camel@sipsolutions.net>
 <f262fb8364037899322b63906b525b13dc4546c2.camel@sipsolutions.net>
 <CAMuHMdVRB46fyFKjZn3Zw2bb8_mqZasqh-J7vse-GQkA3_OQDg@mail.gmail.com>
 <m2o72jff2a.wl-thehajime@gmail.com>
 <CAMuHMdXKAz0bxBGrbbHD6haeCbhYh=pCb4stox1fOifCvyCwpw@mail.gmail.com>
 <m2msi2g15z.wl-thehajime@gmail.com>
Content-Language: en-US
From: Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <m2msi2g15z.wl-thehajime@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Hajime,

On 14/11/24 09:32, Hajime Tazaki wrote:
> On Wed, 13 Nov 2024 22:55:02 +0900,
> Geert Uytterhoeven wrote:
>> On Wed, Nov 13, 2024 at 2:17 PM Hajime Tazaki <thehajime@gmail.com> wrote:
>>> On Wed, 13 Nov 2024 19:27:08 +0900,
>>> Geert Uytterhoeven wrote:
>>>> On Wed, Nov 13, 2024 at 9:37 AM Johannes Berg <johannes@sipsolutions.net> wrote:
>>>>> On Wed, 2024-11-13 at 09:36 +0100, Johannes Berg wrote:
>>>>>> On Wed, 2024-11-13 at 09:19 +0100, Geert Uytterhoeven wrote:
>>>>>>>
>>>>>>>>>> -       depends on ARM || ((M68K || RISCV || SUPERH || XTENSA) && !MMU)
>>>>>>>>>> +       depends on ARM || ((M68K || RISCV || SUPERH || UML || XTENSA) && !MMU)
>>>>>>>>>
>>>>>>>>> s/UML/X86/?
>>>>>>>>
>>>>>>>> I guess the fdpic loader can be used to X86, but this patchset only
>>>>>>>> adds UML to be able to select it.  I intended to add UML into nommu
>>>>>>>> family.
>>>>>>>
>>>>>>> While currently x86-nommu is supported for UML only, this is really
>>>>>>> x86-specific. I still hope UML will get support for other architectures
>>>>>>> one day, at which point a dependency on UML here will become wrong...
>>>>>>>
>>>>>>
>>>>>> X86 isn't set for UML, X64_32 and X64_64 are though.
>>>>>>
>>>>>> Given that the no-MMU UM support even is 64-bit only, that probably
>>>>>> should then really be (UML && X86_64).
>>>>>>
>>>>>> But it already has !MMU, so can't be selected otherwise, and it seems
>>>>>> that non-X86 UML
>>>>>
>>>>> ... would require far more changes in all kinds of places, so not sure
>>>>> I'd be too concerned about it here.
>>>>
>>>> OK, up to you...
>>>
>>> Indeed, this particular patch [02/13] intends to support the fdpic
>>> loader under the condition 1) x86_64 ELF binaries (w/ PIE), 2) on UML,
>>> 3) and with) !MMU configured.  Given that situation, the strict check
>>> should be like:
>>>
>>>     depends on ARM || ((M68K || RISCV || SUPERH || (UML && X86_64) || XTENSA) && !MMU)
>>>
>>> (as Johannes mentioned).
>>>
>>> on the other hand, the fdpic loader works (afaik) on MMU environment so,
>>>
>>>     depends on ARM || (UML && X86_64) || ((M68K || RISCV || SUPERH || XTENSA) && !MMU)
>>>
>>> should also works, but this might be too broad for this patchset (and
>>> not sure if this makes a new use case).
>>
>> AFAIK that depends on the architecture's MMU context structure, cfr.
>> the comment in commit 782f4c5c44e7d99d ("m68knommu: allow elf_fdpic
>> loader to be selected"), which restricts it to nommu on m68k.  If it
>> does work on X86_64, you can drop the dependency on UML, and we're
>> (almost) back to my initial comment ;-)
> 
> I checked and it doesn't work as-is with (UML_X86_64 && MMU).
> restricting nommu with UML might be a good to for this patch.
> 
> even if it works, I would like to focus on UML && !MMU for this patch
> series since I wish to make the (initial) patchset as small as
> possible.  If we would like to make it broadly available on x86, that
> would be a different patch.

Makes sense.

I was only interested in the ability to run ELF based static/PIE binaries
when I did 782f4c5c44e7d99d ("m68knommu: allow elf_fdpic loader to be selected").
I did the same thing for RISC-V in commit 9549fb354ef1 ("riscv: support the
elf-fdpic binfmt loader"), limiting it to !MMU configurations only.

There is no need for binfmt_fdpic in MMU configurations if all you want to
do is run ELF PIE binaries. The normal binfmt_elf loader can load and run
those already.

Regards
Greg



>>> anyway, thank you for the comment.
>>> # I really wanted to have comments from nommu folks.
>>
>> I've added some in CC...
> 
> Thanks,
> 
> -- Hajime

