Return-Path: <linux-fsdevel+bounces-25759-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C31E94FDE3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 08:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 763D11F2333E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 06:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBA73BBFB;
	Tue, 13 Aug 2024 06:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westnet.com.au header.i=@westnet.com.au header.b="tkOZaraJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from omr02.pc5.atmailcloud.com (omr02.pc5.atmailcloud.com [54.206.55.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B469917999;
	Tue, 13 Aug 2024 06:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.55.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723530831; cv=none; b=cEtvQ7GEswiMffkeceLC7u4WBQrZFz19FRoBC8fLkclU3YZYyNt+YhBgJoDY4Ea9gLFHvxdCR6TYSBkuf/ZxbYWcYcCLeKagJGsgdUOqzWFunsFiUowySkQL307wyYWPTcVGjOr3+RbxOYHXHlkCH4HrajkYc1wWqRM8FV4bWMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723530831; c=relaxed/simple;
	bh=xLP94HoUSUt8ifOuF94rnAIWTfpREcUO4j61xow5Ezw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Id0riakXw9Y9/Yc5qR5wZdFazsxdEgzFSnAF8E06OkSwe3/UVs9mgV0y4OvOCHfl8F4nFypG7M3hYlCZgIzpwtKyIlEpAeuQwKlCpdxBHmRNlBD2j9ZV1JR0swI7mxSSkVzT9g4D7126nbZkaCIw9R5q3q1Mr01EqbWd/oPPmwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=westnet.com.au; spf=pass smtp.mailfrom=westnet.com.au; dkim=pass (2048-bit key) header.d=westnet.com.au header.i=@westnet.com.au header.b=tkOZaraJ; arc=none smtp.client-ip=54.206.55.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=westnet.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westnet.com.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=westnet.com.au; s=202309; h=Content-Type:From:To:Subject:MIME-Version:Date:
	Message-ID; bh=3cJHkeEWJdTOPVkgsndMVLebgcWMcA0m5U/SakPWxQY=; b=tkOZaraJYTjLyZ
	XUpMdUu9RBTqo9x0MAMwPf4FNM/BKUwTWVEt0lAo73SQ9hQUcb37HwyLxO8vSUoIKG+zd7gyf0s2f
	691njGEOdoTspkJrOwmDZyTwnF5AI/8dNoejNwuB4HIkMMEkhDWwYN1l5BRkPyqV+k3AM/FFzGgVT
	wGIufyxj6+v+L5LAS3y41emtekHO3Eun/IqCop1+QtJXEKuJDsKXOCzsMVYm1reZkL574H1Qm9Iyp
	4fb0tTRImuZRQ1d319SgPJTgUO524gDBXqrjOh5dZ1gO5Wz6ag+VBTl5Ho/La8AJRoo9d0Menj8dt
	MjWp/Rxo843lnvdxNRlA==;
Received: from CMR-KAKADU04.i-058615fd6484c2476
	 by OMR.i-0e491b094b8af55fe with esmtps
	(envelope-from <gregungerer@westnet.com.au>)
	id 1sdjWw-00049a-PY;
	Tue, 13 Aug 2024 04:53:10 +0000
Received: from [27.33.250.67] (helo=[192.168.0.22])
	 by CMR-KAKADU04.i-058615fd6484c2476 with esmtpsa
	(envelope-from <gregungerer@westnet.com.au>)
	id 1sdjWw-0001YC-0C;
	Tue, 13 Aug 2024 04:53:10 +0000
Message-ID: <a0293b2d-7a43-49b7-8146-c20fd4be262f@westnet.com.au>
Date: Tue, 13 Aug 2024 14:53:07 +1000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] binfmt_elf_fdpic: fix /proc/<pid>/auxv
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>,
 Kees Cook <keescook@chromium.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
References: <20240322195418.2160164-1-jcmvbkbc@gmail.com>
 <5b51975f-6d0b-413c-8b38-39a6a45e8821@westnet.com.au>
 <CAMo8Bf+RKVpYT309ystJKVHDqDaK4ZavGe3e-a_jvG7AOcqciw@mail.gmail.com>
Content-Language: en-US
From: Greg Ungerer <gregungerer@westnet.com.au>
In-Reply-To: <CAMo8Bf+RKVpYT309ystJKVHDqDaK4ZavGe3e-a_jvG7AOcqciw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Atmail-Id: gregungerer@westnet.com.au
X-atmailcloud-spam-action: no action
X-Cm-Analysis: v=2.4 cv=dZSG32Xe c=1 sm=1 tr=0 ts=66bae6b6 a=Pz+tuLbDt1M46b9uk18y4g==:117 a=Pz+tuLbDt1M46b9uk18y4g==:17 a=IkcTkHD0fZMA:10 a=yoJbH4e0A30A:10 a=80-xaVIC0AIA:10 a=x7bEGLp0ZPQA:10 a=8-D65JXZAAAA:8 a=pGLkceISAAAA:8 a=NEAV23lmAAAA:8 a=wDIXi1D9eSG_FC4LhKkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Cm-Envelope: MS4xfGLLfUTOnIyosU8mZRs+INHuoDdA5S0SVVGBv2L8f3kXyXEZSVvjnrVglC3oauLk/3M9hDB+OJwXATfshCbPyX9+pDh3gNqB+dHGrd3YSTeTnPcL2cuE kppVlSMtE8zEIWT1uwhFqGy0rnqMVpgvVxj/Vk6smPooxnDaOKDwZm5sfUGrw+3wGfXybDw/ZVMQ+Q==
X-atmailcloud-route: unknown

Hi Max,

On 13/8/24 04:02, Max Filippov wrote:
> Hi Greg,
> 
> On Sun, Aug 11, 2024 at 7:26 PM Greg Ungerer <gregungerer@westnet.com.au> wrote:
>> On 23/3/24 05:54, Max Filippov wrote:
>>> Althought FDPIC linux kernel provides /proc/<pid>/auxv files they are
>>> empty because there's no code that initializes mm->saved_auxv in the
>>> FDPIC ELF loader.
>>>
>>> Synchronize FDPIC ELF aux vector setup with ELF. Replace entry-by-entry
>>> aux vector copying to userspace with initialization of mm->saved_auxv
>>> first and then copying it to userspace as a whole.
>>>
>>> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
>>
>> This is breaking ARM nommu builds supporting fdpic and elf binaries for me.
>>
>> Tests I have for m68k and riscv nommu setups running elf binaries
>> don't show any problems - I am only seeing this on ARM.
>>
>>
>> ...
>> Freeing unused kernel image (initmem) memory: 472K
>> This architecture does not have kernel memory protection.
>> Run /init as init process
>> Internal error: Oops - undefined instruction: 0 [#1] ARM
>> Modules linked in:
>> CPU: 0 PID: 1 Comm: init Not tainted 6.10.0 #1
>> Hardware name: ARM-Versatile (Device Tree Support)
>> PC is at load_elf_fdpic_binary+0xb34/0xb80
>> LR is at 0x0
>> pc : [<00109ce8>]    lr : [<00000000>]    psr: 80000153
>> sp : 00823e40  ip : 00000000  fp : 00b8fee4
>> r10: 009c9b80  r9 : 00b8ff80  r8 : 009ee800
>> r7 : 00000000  r6 : 009f7e80  r5 : 00b8fedc  r4 : 00b87000
>> r3 : 00b8fed8  r2 : 00b8fee0  r1 : 00b87128  r0 : 00b8fef0
>> Flags: Nzcv  IRQs on  FIQs off  Mode SVC_32  ISA ARM  Segment none
>> Control: 00091176  Table: 00000000  DAC: 00000000
>> Register r0 information: non-slab/vmalloc memory
>> Register r1 information: slab/vmalloc mm_struct start 00b87000 pointer offset 296 size 428
>> Register r2 information: non-slab/vmalloc memory
>> Register r3 information: non-slab/vmalloc memory
>> Register r4 information: slab/vmalloc mm_struct start 00b87000 pointer offset 0 size 428
>> Register r5 information: non-slab/vmalloc memory
>> Register r6 information: slab/vmalloc kmalloc-32 start 009f7e80 pointer offset 0 size 32
>> Register r7 information: non-slab/vmalloc memory
>> Register r8 information: slab/vmalloc kmalloc-512 start 009ee800 pointer offset 0 size 512
>> Register r9 information: non-slab/vmalloc memory
>> Register r10 information: slab/vmalloc kmalloc-128 start 009c9b80 pointer offset 0 size 128
>> Register r11 information: non-slab/vmalloc memory
>> Register r12 information: non-slab/vmalloc memory
>> Process init (pid: 1, stack limit = 0x(ptrval))
>> Stack: (0x00823e40 to 0x00824000)
>> 3e40: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
>> 3e60: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
>> 3e80: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
>> 3ea0: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
>> 3ec0: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
>> 3ee0: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
>> 3f00: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
>> 3f20: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
>> 3f40: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
>> 3f60: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
>> 3f80: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
>> 3fa0: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
>> 3fc0: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
>> 3fe0: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
>> Call trace:
>>    load_elf_fdpic_binary from bprm_execve+0x1b4/0x488
>>    bprm_execve from kernel_execve+0x154/0x1e4
>>    kernel_execve from kernel_init+0x4c/0x108
>>    kernel_init from ret_from_fork+0x14/0x38
>> Exception stack(0x00823fb0 to 0x00823ff8)
>> 3fa0:                                     ???????? ???????? ???????? ????????
>> 3fc0: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
>> 3fe0: ???????? ???????? ???????? ???????? ???????? ????????
>> Code: bad PC value
>> ---[ end trace 0000000000000000 ]---
>> note: init[1] exited with irqs disabled
>> Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
>> ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---
>>
>>
>> The code around that PC is:
>>
>>     109cd0:       e2833ff1        add     r3, r3, #964    @ 0x3c4
>>     109cd4:       e5933000        ldr     r3, [r3]
>>     109cd8:       e5933328        ldr     r3, [r3, #808]  @ 0x328
>>     109cdc:       e5933084        ldr     r3, [r3, #132]  @ 0x84
>>     109ce0:       e5843034        str     r3, [r4, #52]   @ 0x34
>>     109ce4:       eafffdbc        b       1093dc <load_elf_fdpic_binary+0x228>
>>     109ce8:       e7f001f2        .word   0xe7f001f2
>>     109cec:       eb09471d        bl      35b968 <__stack_chk_fail>
>>     109cf0:       e59f0038        ldr     r0, [pc, #56]   @ 109d30 <load_elf_fdpic_binary+0xb7c>
>>     109cf4:       eb092f03        bl      355908 <_printk>
>>     109cf8:       eafffdb7        b       1093dc <load_elf_fdpic_binary+0x228>
>>
>>
>> Reverting just this change gets it working again.
>>
>> Any idea what might be going on?
> 
> Other than that the layout of the aux vector has slightly changed I don't
> see anything. I can take a look at what's going on if you can share the
> reproducer.

I build the test binary using a simple script:

   https://github.com/gregungerer/simple-linux/blob/master/build-armnommu-linux-uclibc-fdpic.sh

Run the resulting vmlinux and devicetree under qemu as per comments at top of that script.

Note that that script has a revert of this change (at line 191), so you would need
to take that out to reproduce the problem. This script will look for a couple of
configs and a versatile patch:

   https://github.com/gregungerer/simple-linux/blob/master/configs/linux-6.10-armnommu-versatile.config
   https://github.com/gregungerer/simple-linux/blob/master/configs/uClibc-ng-1.0.49-armnommu-fdpic.config
   https://github.com/gregungerer/simple-linux/blob/master/configs/busybox-1.36.1.config
   https://github.com/gregungerer/simple-linux/blob/master/configs/rootfs.dev
   https://github.com/gregungerer/simple-linux/blob/master/patches/linux-6.10-armnommu-versatile.patch
   https://github.com/gregungerer/simple-linux/blob/master/patches/linux-6.10-binfmt_elf_fdpic-fix-proc-pid-auxv.patch

Or you could just clone the whole small set in one step from:

   https://github.com/gregungerer/simple-linux.git
   
If you need to me to run something I can do that easily too.

Regards
Greg




