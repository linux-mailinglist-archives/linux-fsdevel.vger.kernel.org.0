Return-Path: <linux-fsdevel+bounces-25628-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B967894E59E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 06:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9727B20B4B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 04:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACE313E02D;
	Mon, 12 Aug 2024 04:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=westnet.com.au header.i=@westnet.com.au header.b="KM6GIGvL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from omr001.pc5.atmailcloud.com (omr001.pc5.atmailcloud.com [103.150.252.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E242F2C;
	Mon, 12 Aug 2024 04:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.150.252.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723435297; cv=none; b=m8xTGmMB46/NLN8j3W+vDqEneGS0HU8YiCFfAXmt6NaWNDwU7lyBhDGB1eAcUs9CWd9vtyunNTOqUhVdewNQTnPPugueKNs7VhThgJCx0CfwLEwoGAi9GqWpbzTmBxOm9USjNbN7LX8XaiZm4oB5fIvBrxUAdaYN9l2JkTWCDEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723435297; c=relaxed/simple;
	bh=zX7panmrDQ3wh2nggk6+Tsrbim9BO2Xc/Wm6mDNP31Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WtbbQMTVgRu4tEvojql4EOjCkfjviTCCCP+nb6qYUhshI0v/kWF3ucFtCbQuKVeaoSgbzqYBZe8Rgzx3Nrg1yjxo5CIj0n9Srno+5mESdpdPd3b9n2D60Ct5+H9gBKAp6OpHkky3QddQkQazntWzEL+x1pWJx0wpy/nwTT4zXMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=westnet.com.au; spf=pass smtp.mailfrom=westnet.com.au; dkim=pass (2048-bit key) header.d=westnet.com.au header.i=@westnet.com.au header.b=KM6GIGvL; arc=none smtp.client-ip=103.150.252.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=westnet.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=westnet.com.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=westnet.com.au; s=202309; h=Content-Type:From:To:Subject:MIME-Version:Date:
	Message-ID; bh=M4HFryxWKe0qeZYXB6YRpgflRXAYZpHEa3EbGsxpmxA=; b=KM6GIGvLRpWzSB
	RmHc2aPRzxA91UruObNsKI7vAsEnDopFYUbwF6tzY9R+LzJFI4Uvz9U0+6jgmwTdSlYjQe+cERUXT
	CKs3D/kqT5HifWVNEEOGcWmVDEXEoi66e+FJBOsy7h/2Kt0nQw7WLB+vcY2GRu2YtQaiwpuMFPjNS
	+SgfgdXO+WoxRGv4qPXQ5uM9fYda1qZ0nyynkY0Q8HcnX0vvwPoa4r9g5ZP0dE3HGNvNsGz58QniS
	yMkAce01E4OAqqZxTCutQobEZZZmW4mXbuMlFfzdJpNCWWogKjYUrsQUIH1BGPbqNYB9P5FkTA9UM
	G6AD0uF5HDRDX4OgXVyA==;
Received: from CMR-KAKADU04.i-058615fd6484c2476
	 by OMR.i-0e5869b43dfedcea0 with esmtps
	(envelope-from <gregungerer@westnet.com.au>)
	id 1sdKlC-0008AJ-0t;
	Mon, 12 Aug 2024 02:26:14 +0000
Received: from [27.33.250.67] (helo=[192.168.0.22])
	 by CMR-KAKADU04.i-058615fd6484c2476 with esmtpsa
	(envelope-from <gregungerer@westnet.com.au>)
	id 1sdKlB-00045F-11;
	Mon, 12 Aug 2024 02:26:13 +0000
Message-ID: <5b51975f-6d0b-413c-8b38-39a6a45e8821@westnet.com.au>
Date: Mon, 12 Aug 2024 12:26:09 +1000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] binfmt_elf_fdpic: fix /proc/<pid>/auxv
To: Max Filippov <jcmvbkbc@gmail.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <keescook@chromium.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
References: <20240322195418.2160164-1-jcmvbkbc@gmail.com>
Content-Language: en-US
From: Greg Ungerer <gregungerer@westnet.com.au>
In-Reply-To: <20240322195418.2160164-1-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Atmail-Id: gregungerer@westnet.com.au
X-atmailcloud-spam-action: no action
X-Cm-Analysis: v=2.4 cv=dZSG32Xe c=1 sm=1 tr=0 ts=66b972c5 a=Pz+tuLbDt1M46b9uk18y4g==:117 a=Pz+tuLbDt1M46b9uk18y4g==:17 a=IkcTkHD0fZMA:10 a=yoJbH4e0A30A:10 a=80-xaVIC0AIA:10 a=x7bEGLp0ZPQA:10 a=pGLkceISAAAA:8 a=Vz-taIwyhSfJWuoW5SAA:9 a=QEXdDO2ut3YA:10
X-Cm-Envelope: MS4xfHJia8hp2f7HuldQ4ed3pxkWtkI0xiK5j3mNFVhm9bKbIw1qVcDQr9TfHiuzH8PWkUHrEox/GJ0w+kbi05GsMRXnCgZLOFST7wxRxcMe/24FlqAYTqCk 3mF5biqqW0xiFPqdBZAIYddSBmyhrwcWwvlmbnBfqVPDtNlaZT99VwhgJqEYRMzZoVTkZofAdkVzyA==
X-atmailcloud-route: unknown

Hi Max,

On 23/3/24 05:54, Max Filippov wrote:
> Althought FDPIC linux kernel provides /proc/<pid>/auxv files they are
> empty because there's no code that initializes mm->saved_auxv in the
> FDPIC ELF loader.
> 
> Synchronize FDPIC ELF aux vector setup with ELF. Replace entry-by-entry
> aux vector copying to userspace with initialization of mm->saved_auxv
> first and then copying it to userspace as a whole.
> 
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>

This is breaking ARM nommu builds supporting fdpic and elf binaries for me.

Tests I have for m68k and riscv nommu setups running elf binaries
don't show any problems - I am only seeing this on ARM.


...
Freeing unused kernel image (initmem) memory: 472K
This architecture does not have kernel memory protection.
Run /init as init process
Internal error: Oops - undefined instruction: 0 [#1] ARM
Modules linked in:
CPU: 0 PID: 1 Comm: init Not tainted 6.10.0 #1
Hardware name: ARM-Versatile (Device Tree Support)
PC is at load_elf_fdpic_binary+0xb34/0xb80
LR is at 0x0
pc : [<00109ce8>]    lr : [<00000000>]    psr: 80000153
sp : 00823e40  ip : 00000000  fp : 00b8fee4
r10: 009c9b80  r9 : 00b8ff80  r8 : 009ee800
r7 : 00000000  r6 : 009f7e80  r5 : 00b8fedc  r4 : 00b87000
r3 : 00b8fed8  r2 : 00b8fee0  r1 : 00b87128  r0 : 00b8fef0
Flags: Nzcv  IRQs on  FIQs off  Mode SVC_32  ISA ARM  Segment none
Control: 00091176  Table: 00000000  DAC: 00000000
Register r0 information: non-slab/vmalloc memory
Register r1 information: slab/vmalloc mm_struct start 00b87000 pointer offset 296 size 428
Register r2 information: non-slab/vmalloc memory
Register r3 information: non-slab/vmalloc memory
Register r4 information: slab/vmalloc mm_struct start 00b87000 pointer offset 0 size 428
Register r5 information: non-slab/vmalloc memory
Register r6 information: slab/vmalloc kmalloc-32 start 009f7e80 pointer offset 0 size 32
Register r7 information: non-slab/vmalloc memory
Register r8 information: slab/vmalloc kmalloc-512 start 009ee800 pointer offset 0 size 512
Register r9 information: non-slab/vmalloc memory
Register r10 information: slab/vmalloc kmalloc-128 start 009c9b80 pointer offset 0 size 128
Register r11 information: non-slab/vmalloc memory
Register r12 information: non-slab/vmalloc memory
Process init (pid: 1, stack limit = 0x(ptrval))
Stack: (0x00823e40 to 0x00824000)
3e40: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
3e60: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
3e80: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
3ea0: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
3ec0: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
3ee0: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
3f00: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
3f20: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
3f40: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
3f60: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
3f80: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
3fa0: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
3fc0: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
3fe0: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
Call trace:
  load_elf_fdpic_binary from bprm_execve+0x1b4/0x488
  bprm_execve from kernel_execve+0x154/0x1e4
  kernel_execve from kernel_init+0x4c/0x108
  kernel_init from ret_from_fork+0x14/0x38
Exception stack(0x00823fb0 to 0x00823ff8)
3fa0:                                     ???????? ???????? ???????? ????????
3fc0: ???????? ???????? ???????? ???????? ???????? ???????? ???????? ????????
3fe0: ???????? ???????? ???????? ???????? ???????? ????????
Code: bad PC value
---[ end trace 0000000000000000 ]---
note: init[1] exited with irqs disabled
Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---


The code around that PC is:

   109cd0:       e2833ff1        add     r3, r3, #964    @ 0x3c4
   109cd4:       e5933000        ldr     r3, [r3]
   109cd8:       e5933328        ldr     r3, [r3, #808]  @ 0x328
   109cdc:       e5933084        ldr     r3, [r3, #132]  @ 0x84
   109ce0:       e5843034        str     r3, [r4, #52]   @ 0x34
   109ce4:       eafffdbc        b       1093dc <load_elf_fdpic_binary+0x228>
   109ce8:       e7f001f2        .word   0xe7f001f2
   109cec:       eb09471d        bl      35b968 <__stack_chk_fail>
   109cf0:       e59f0038        ldr     r0, [pc, #56]   @ 109d30 <load_elf_fdpic_binary+0xb7c>
   109cf4:       eb092f03        bl      355908 <_printk>
   109cf8:       eafffdb7        b       1093dc <load_elf_fdpic_binary+0x228>


Reverting just this change gets it working again.

Any idea what might be going on?

Regards
Greg


> ---
>   fs/binfmt_elf_fdpic.c | 88 +++++++++++++++++++++----------------------
>   1 file changed, 42 insertions(+), 46 deletions(-)
> 
> diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
> index fefc642541cb..7b4542a0cbe3 100644
> --- a/fs/binfmt_elf_fdpic.c
> +++ b/fs/binfmt_elf_fdpic.c
> @@ -505,8 +505,9 @@ static int create_elf_fdpic_tables(struct linux_binprm *bprm,
>   	char *k_platform, *k_base_platform;
>   	char __user *u_platform, *u_base_platform, *p;
>   	int loop;
> -	int nr;	/* reset for each csp adjustment */
>   	unsigned long flags = 0;
> +	int ei_index;
> +	elf_addr_t *elf_info;
>   
>   #ifdef CONFIG_MMU
>   	/* In some cases (e.g. Hyper-Threading), we want to avoid L1 evictions
> @@ -601,44 +602,24 @@ static int create_elf_fdpic_tables(struct linux_binprm *bprm,
>   	csp -= sp & 15UL;
>   	sp -= sp & 15UL;
>   
> -	/* put the ELF interpreter info on the stack */
> -#define NEW_AUX_ENT(id, val)						\
> -	do {								\
> -		struct { unsigned long _id, _val; } __user *ent, v;	\
> -									\
> -		ent = (void __user *) csp;				\
> -		v._id = (id);						\
> -		v._val = (val);						\
> -		if (copy_to_user(ent + nr, &v, sizeof(v)))		\
> -			return -EFAULT;					\
> -		nr++;							\
> +	/* Create the ELF interpreter info */
> +	elf_info = (elf_addr_t *)mm->saved_auxv;
> +	/* update AT_VECTOR_SIZE_BASE if the number of NEW_AUX_ENT() changes */
> +#define NEW_AUX_ENT(id, val) \
> +	do { \
> +		*elf_info++ = id; \
> +		*elf_info++ = val; \
>   	} while (0)
>   
> -	nr = 0;
> -	csp -= 2 * sizeof(unsigned long);
> -	NEW_AUX_ENT(AT_NULL, 0);
> -	if (k_platform) {
> -		nr = 0;
> -		csp -= 2 * sizeof(unsigned long);
> -		NEW_AUX_ENT(AT_PLATFORM,
> -			    (elf_addr_t) (unsigned long) u_platform);
> -	}
> -
> -	if (k_base_platform) {
> -		nr = 0;
> -		csp -= 2 * sizeof(unsigned long);
> -		NEW_AUX_ENT(AT_BASE_PLATFORM,
> -			    (elf_addr_t) (unsigned long) u_base_platform);
> -	}
> -
> -	if (bprm->have_execfd) {
> -		nr = 0;
> -		csp -= 2 * sizeof(unsigned long);
> -		NEW_AUX_ENT(AT_EXECFD, bprm->execfd);
> -	}
> -
> -	nr = 0;
> -	csp -= DLINFO_ITEMS * 2 * sizeof(unsigned long);
> +#ifdef ARCH_DLINFO
> +	/*
> +	 * ARCH_DLINFO must come first so PPC can do its special alignment of
> +	 * AUXV.
> +	 * update AT_VECTOR_SIZE_ARCH if the number of NEW_AUX_ENT() in
> +	 * ARCH_DLINFO changes
> +	 */
> +	ARCH_DLINFO;
> +#endif
>   	NEW_AUX_ENT(AT_HWCAP,	ELF_HWCAP);
>   #ifdef ELF_HWCAP2
>   	NEW_AUX_ENT(AT_HWCAP2,	ELF_HWCAP2);
> @@ -659,17 +640,32 @@ static int create_elf_fdpic_tables(struct linux_binprm *bprm,
>   	NEW_AUX_ENT(AT_EGID,	(elf_addr_t) from_kgid_munged(cred->user_ns, cred->egid));
>   	NEW_AUX_ENT(AT_SECURE,	bprm->secureexec);
>   	NEW_AUX_ENT(AT_EXECFN,	bprm->exec);
> +	if (k_platform) {
> +		NEW_AUX_ENT(AT_PLATFORM,
> +			    (elf_addr_t)(unsigned long)u_platform);
> +	}
> +	if (k_base_platform) {
> +		NEW_AUX_ENT(AT_BASE_PLATFORM,
> +			    (elf_addr_t)(unsigned long)u_base_platform);
> +	}
> +	if (bprm->have_execfd) {
> +		NEW_AUX_ENT(AT_EXECFD, bprm->execfd);
> +	}
> +#undef NEW_AUX_ENT
> +	/* AT_NULL is zero; clear the rest too */
> +	memset(elf_info, 0, (char *)mm->saved_auxv +
> +	       sizeof(mm->saved_auxv) - (char *)elf_info);
>   
> -#ifdef ARCH_DLINFO
> -	nr = 0;
> -	csp -= AT_VECTOR_SIZE_ARCH * 2 * sizeof(unsigned long);
> +	/* And advance past the AT_NULL entry.  */
> +	elf_info += 2;
>   
> -	/* ARCH_DLINFO must come last so platform specific code can enforce
> -	 * special alignment requirements on the AUXV if necessary (eg. PPC).
> -	 */
> -	ARCH_DLINFO;
> -#endif
> -#undef NEW_AUX_ENT
> +	ei_index = elf_info - (elf_addr_t *)mm->saved_auxv;
> +	csp -= ei_index * sizeof(elf_addr_t);
> +
> +	/* Put the elf_info on the stack in the right place.  */
> +	if (copy_to_user((void __user *)csp, mm->saved_auxv,
> +			 ei_index * sizeof(elf_addr_t)))
> +		return -EFAULT;
>   
>   	/* allocate room for argv[] and envv[] */
>   	csp -= (bprm->envc + 1) * sizeof(elf_caddr_t);

