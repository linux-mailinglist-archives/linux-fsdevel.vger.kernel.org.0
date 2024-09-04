Return-Path: <linux-fsdevel+bounces-28545-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8424896BB32
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 13:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A913C1C2252A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 11:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045261D3628;
	Wed,  4 Sep 2024 11:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PN21NC2B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A081D221F;
	Wed,  4 Sep 2024 11:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725450433; cv=none; b=pgbLitsjmKNrfy2jqDvwZQW8gARKEH/R+jXBZ9mmJVVCs3z11QM9vXxz5dGeW4mtuiZSvpvAtr66xNfZrEN1pfYNFmC0UmCO72usn3Jr1nL/zTv91XJabENDTEXvEArcu7WCGahE+/F5OrUvpG13QAB5mLe14OJh1j/bFcy7au8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725450433; c=relaxed/simple;
	bh=P4WCG3/m8J/kw8jFdWlJ523TfUCJST9PJBS4LrwfHhM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KyfcKCfLll+BYUxuJvMlcvZsnXgOtVkT193qM0teewZNorvYblx9/D2v1MNThchDh5s4zObcufC0a7CuJZyc4Mg/OiFO7tuOfaRzx79x2wIeWFMPtFr60zwyPAD4XNSF6lXMRzMBZdpfRuZ4Om8DaZlyIIoeROdkkxeQ4BehqAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PN21NC2B; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4845kj9l020520;
	Wed, 4 Sep 2024 11:46:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	MTV8FP7JpS252DXDlD7g+lznBNg91Cnezr5tlyrHd7M=; b=PN21NC2BvCWvtGFK
	4wUnS7e0D9xNsPbM8okDU5JElUtpZdNWwwCqre93Tq6bViGZFbZoLOGt7H9p6qva
	GSvtX7cgPVaBz8IAYz37IXmx1Ebr/EUB3ROku9eql8lPLw1H5mYUmyf3vEIPvPJH
	+oUaoM0fpMLwGUmjhF1UMYsSBvadfObIBvYEP636/wu2detlh9yFY0V0dS76n+qw
	G0WY2Ky4J4OOV4bj5WEHHIkuE7JZsFWFUEW0g1BYRxoEKhJr5W9o2Eekn2qLWXJm
	5Iu7uduAfU0kAhsDAMqrU8N6nk4xbYPyEQcwmKvvDBbaH/vFRDXxw/2jv/tturLu
	8+2ZUQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41btp9jtr3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 11:46:36 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 484BkabI014422;
	Wed, 4 Sep 2024 11:46:36 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41btp9jtqx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 11:46:36 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4848dW8i018726;
	Wed, 4 Sep 2024 11:46:34 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41cdw17mjc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 11:46:34 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 484BkX9d5571214
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Sep 2024 11:46:33 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 788905805F;
	Wed,  4 Sep 2024 11:46:33 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 591415805A;
	Wed,  4 Sep 2024 11:46:24 +0000 (GMT)
Received: from [9.43.58.251] (unknown [9.43.58.251])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  4 Sep 2024 11:46:23 +0000 (GMT)
Message-ID: <af338cfa-a926-4877-abd5-41bd9c0989fa@linux.ibm.com>
Date: Wed, 4 Sep 2024 17:16:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] powerpc/vdso: Wire up getrandom() vDSO
 implementation on VDSO64
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu
 <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling
 <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>, Shuah Khan <shuah@kernel.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-trace-kernel@vger.kernel.org,
        Adhemerval Zanella <adhemerval.zanella@linaro.org>,
        Xi Ruoyao <xry111@xry111.site>
References: <cover.1725304404.git.christophe.leroy@csgroup.eu>
 <de334b1de27260f217d6bc65e02c841e8eff75be.1725304404.git.christophe.leroy@csgroup.eu>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <de334b1de27260f217d6bc65e02c841e8eff75be.1725304404.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HJf9FfRxUIn-bus3YS-8Nv7wys3fWlq0
X-Proofpoint-ORIG-GUID: GsORRVOOw0bsMXq53jCcymkKLcDzZwmV
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_09,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 mlxscore=0 suspectscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409040088


On 9/3/24 12:47 AM, Christophe Leroy wrote:
> Extend getrandom() vDSO implementation to VDSO64
>
> Tested on QEMU on both ppc64_defconfig and ppc64le_defconfig.
>
> The results are not precise as it is QEMU on an x86 laptop, but
> no need to be precise to see the benefit.
>
> ~ # ./vdso_test_getrandom bench-single
>     vdso: 25000000 times in 4.977777162 seconds
>     libc: 25000000 times in 75.516749981 seconds
> syscall: 25000000 times in 86.842242014 seconds
>
> ~ # ./vdso_test_getrandom bench-single
>     vdso: 25000000 times in 6.473814156 seconds
>     libc: 25000000 times in 73.875109463 seconds
> syscall: 25000000 times in 71.805066229 seconds

Tried the patchset on top of

https://kernel.googlesource.com/pub/scm/linux/kernel/git/crng/random.git
(commit 963233ff013377bc2aa0d641b9efbb7fd4c2b72c (origin/master, 
origin/HEAD, master))

Results from a Power9 (PowerNV)
# ./vdso_test_getrandom bench-single
    vdso: 25000000 times in 0.787943615 seconds
    libc: 25000000 times in 14.101887252 seconds
    syscall: 25000000 times in 14.047475082 seconds

Impressive, thanks for enabling it.

Tested-by: Madhavan Srinivasan <maddy@linux.ibm.com>

> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
> v5:
> - VDSO32 for both PPC32 and PPC64 is in previous patch. This patch have the logic for VDSO64.
>
> v4:
> - Use __BIG_ENDIAN__ which is defined by GCC instead of CONFIG_CPU_BIG_ENDIAN which is unknown by selftests
> - Implement a cleaner/smaller output copy for little endian instead of keeping compat macro.
>
> v3: New (split out of previous patch)
> ---
>   arch/powerpc/Kconfig                         |  2 +-
>   arch/powerpc/kernel/vdso/Makefile            |  8 ++-
>   arch/powerpc/kernel/vdso/getrandom.S         |  8 +++
>   arch/powerpc/kernel/vdso/vdso64.lds.S        |  1 +
>   arch/powerpc/kernel/vdso/vgetrandom-chacha.S | 53 ++++++++++++++++++++
>   5 files changed, 69 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index e500a59ddecc..b45452ac4a73 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -311,7 +311,7 @@ config PPC
>   	select SYSCTL_EXCEPTION_TRACE
>   	select THREAD_INFO_IN_TASK
>   	select TRACE_IRQFLAGS_SUPPORT
> -	select VDSO_GETRANDOM			if VDSO32
> +	select VDSO_GETRANDOM
>   	#
>   	# Please keep this list sorted alphabetically.
>   	#
> diff --git a/arch/powerpc/kernel/vdso/Makefile b/arch/powerpc/kernel/vdso/Makefile
> index 7a4a935406d8..56fb1633529a 100644
> --- a/arch/powerpc/kernel/vdso/Makefile
> +++ b/arch/powerpc/kernel/vdso/Makefile
> @@ -9,6 +9,7 @@ obj-vdso32 = sigtramp32-32.o gettimeofday-32.o datapage-32.o cacheflush-32.o not
>   obj-vdso64 = sigtramp64-64.o gettimeofday-64.o datapage-64.o cacheflush-64.o note-64.o getcpu-64.o
>   
>   obj-vdso32 += getrandom-32.o vgetrandom-chacha-32.o
> +obj-vdso64 += getrandom-64.o vgetrandom-chacha-64.o
>   
>   ifneq ($(c-gettimeofday-y),)
>     CFLAGS_vgettimeofday-32.o += -include $(c-gettimeofday-y)
> @@ -21,6 +22,7 @@ endif
>   
>   ifneq ($(c-getrandom-y),)
>     CFLAGS_vgetrandom-32.o += -include $(c-getrandom-y)
> +  CFLAGS_vgetrandom-64.o += -include $(c-getrandom-y) $(call cc-option, -ffixed-r30)
>   endif
>   
>   # Build rules
> @@ -34,7 +36,7 @@ endif
>   targets := $(obj-vdso32) vdso32.so.dbg vgettimeofday-32.o vgetrandom-32.o
>   targets += crtsavres-32.o
>   obj-vdso32 := $(addprefix $(obj)/, $(obj-vdso32))
> -targets += $(obj-vdso64) vdso64.so.dbg vgettimeofday-64.o
> +targets += $(obj-vdso64) vdso64.so.dbg vgettimeofday-64.o vgetrandom-64.o
>   obj-vdso64 := $(addprefix $(obj)/, $(obj-vdso64))
>   
>   ccflags-y := -fno-common -fno-builtin -DBUILD_VDSO
> @@ -71,7 +73,7 @@ CPPFLAGS_vdso64.lds += -P -C
>   # link rule for the .so file, .lds has to be first
>   $(obj)/vdso32.so.dbg: $(obj)/vdso32.lds $(obj-vdso32) $(obj)/vgettimeofday-32.o $(obj)/vgetrandom-32.o $(obj)/crtsavres-32.o FORCE
>   	$(call if_changed,vdso32ld_and_check)
> -$(obj)/vdso64.so.dbg: $(obj)/vdso64.lds $(obj-vdso64) $(obj)/vgettimeofday-64.o FORCE
> +$(obj)/vdso64.so.dbg: $(obj)/vdso64.lds $(obj-vdso64) $(obj)/vgettimeofday-64.o $(obj)/vgetrandom-64.o FORCE
>   	$(call if_changed,vdso64ld_and_check)
>   
>   # assembly rules for the .S files
> @@ -87,6 +89,8 @@ $(obj-vdso64): %-64.o: %.S FORCE
>   	$(call if_changed_dep,vdso64as)
>   $(obj)/vgettimeofday-64.o: %-64.o: %.c FORCE
>   	$(call if_changed_dep,cc_o_c)
> +$(obj)/vgetrandom-64.o: %-64.o: %.c FORCE
> +	$(call if_changed_dep,cc_o_c)
>   
>   # Generate VDSO offsets using helper script
>   gen-vdso32sym := $(src)/gen_vdso32_offsets.sh
> diff --git a/arch/powerpc/kernel/vdso/getrandom.S b/arch/powerpc/kernel/vdso/getrandom.S
> index 21773ef3fc1d..a957cd2b2b03 100644
> --- a/arch/powerpc/kernel/vdso/getrandom.S
> +++ b/arch/powerpc/kernel/vdso/getrandom.S
> @@ -27,10 +27,18 @@
>     .cfi_adjust_cfa_offset PPC_MIN_STKFRM
>   	PPC_STL		r0, PPC_MIN_STKFRM + PPC_LR_STKOFF(r1)
>     .cfi_rel_offset lr, PPC_MIN_STKFRM + PPC_LR_STKOFF
> +#ifdef __powerpc64__
> +	PPC_STL		r2, PPC_MIN_STKFRM + STK_GOT(r1)
> +  .cfi_rel_offset r2, PPC_MIN_STKFRM + STK_GOT
> +#endif
>   	get_datapage	r8
>   	addi		r8, r8, VDSO_RNG_DATA_OFFSET
>   	bl		CFUNC(DOTSYM(\funct))
>   	PPC_LL		r0, PPC_MIN_STKFRM + PPC_LR_STKOFF(r1)
> +#ifdef __powerpc64__
> +	PPC_LL		r2, PPC_MIN_STKFRM + STK_GOT(r1)
> +  .cfi_restore r2
> +#endif
>   	cmpwi		r3, 0
>   	mtlr		r0
>   	addi		r1, r1, 2 * PPC_MIN_STKFRM
> diff --git a/arch/powerpc/kernel/vdso/vdso64.lds.S b/arch/powerpc/kernel/vdso/vdso64.lds.S
> index 400819258c06..9481e4b892ed 100644
> --- a/arch/powerpc/kernel/vdso/vdso64.lds.S
> +++ b/arch/powerpc/kernel/vdso/vdso64.lds.S
> @@ -123,6 +123,7 @@ VERSION
>   		__kernel_sigtramp_rt64;
>   		__kernel_getcpu;
>   		__kernel_time;
> +		__kernel_getrandom;
>   
>   	local: *;
>   	};
> diff --git a/arch/powerpc/kernel/vdso/vgetrandom-chacha.S b/arch/powerpc/kernel/vdso/vgetrandom-chacha.S
> index ac85788205cb..7f9061a9e8b4 100644
> --- a/arch/powerpc/kernel/vdso/vgetrandom-chacha.S
> +++ b/arch/powerpc/kernel/vdso/vgetrandom-chacha.S
> @@ -124,6 +124,26 @@
>    */
>   SYM_FUNC_START(__arch_chacha20_blocks_nostack)
>   #ifdef __powerpc64__
> +	std	counter, -216(r1)
> +
> +	std	r14, -144(r1)
> +	std	r15, -136(r1)
> +	std	r16, -128(r1)
> +	std	r17, -120(r1)
> +	std	r18, -112(r1)
> +	std	r19, -104(r1)
> +	std	r20, -96(r1)
> +	std	r21, -88(r1)
> +	std	r22, -80(r1)
> +	std	r23, -72(r1)
> +	std	r24, -64(r1)
> +	std	r25, -56(r1)
> +	std	r26, -48(r1)
> +	std	r27, -40(r1)
> +	std	r28, -32(r1)
> +	std	r29, -24(r1)
> +	std	r30, -16(r1)
> +	std	r31, -8(r1)
>   #else
>   	stwu	r1, -96(r1)
>   	stw	counter, 20(r1)
> @@ -149,9 +169,13 @@ SYM_FUNC_START(__arch_chacha20_blocks_nostack)
>   	stw	r30, 88(r1)
>   	stw	r31, 92(r1)
>   #endif
> +#endif	/* __powerpc64__ */
>   
>   	lwz	counter0, 0(counter)
>   	lwz	counter1, 4(counter)
> +#ifdef __powerpc64__
> +	rldimi	counter0, counter1, 32, 0
> +#endif
>   	mr	idx_r0, nblocks
>   	subi	dst_bytes, dst_bytes, 4
>   
> @@ -267,12 +291,21 @@ SYM_FUNC_START(__arch_chacha20_blocks_nostack)
>   
>   	subic.	idx_r0, idx_r0, 1	/* subi. can't use r0 as source */
>   
> +#ifdef __powerpc64__
> +	addi	counter0, counter0, 1
> +	srdi	counter1, counter0, 32
> +#else
>   	addic	counter0, counter0, 1
>   	addze	counter1, counter1
> +#endif
>   
>   	bne	.Lblock
>   
> +#ifdef __powerpc64__
> +	ld	counter, -216(r1)
> +#else
>   	lwz	counter, 20(r1)
> +#endif
>   	stw	counter0, 0(counter)
>   	stw	counter1, 4(counter)
>   
> @@ -284,6 +317,26 @@ SYM_FUNC_START(__arch_chacha20_blocks_nostack)
>   	li	r11, 0
>   	li	r12, 0
>   
> +#ifdef __powerpc64__
> +	ld	r14, -144(r1)
> +	ld	r15, -136(r1)
> +	ld	r16, -128(r1)
> +	ld	r17, -120(r1)
> +	ld	r18, -112(r1)
> +	ld	r19, -104(r1)
> +	ld	r20, -96(r1)
> +	ld	r21, -88(r1)
> +	ld	r22, -80(r1)
> +	ld	r23, -72(r1)
> +	ld	r24, -64(r1)
> +	ld	r25, -56(r1)
> +	ld	r26, -48(r1)
> +	ld	r27, -40(r1)
> +	ld	r28, -32(r1)
> +	ld	r29, -24(r1)
> +	ld	r30, -16(r1)
> +	ld	r31, -8(r1)
> +#else
>   #ifdef __BIG_ENDIAN__
>   	lmw	r14, 24(r1)
>   #else

