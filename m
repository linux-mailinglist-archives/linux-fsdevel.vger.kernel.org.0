Return-Path: <linux-fsdevel+bounces-29802-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7EF897E035
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Sep 2024 07:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 136011C20A14
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Sep 2024 05:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD2119306B;
	Sun, 22 Sep 2024 05:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GMzlE5wf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E80156F2B;
	Sun, 22 Sep 2024 05:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726984160; cv=none; b=CT88odkiriti5F3L79wYweydK2YSaiow64Y8x//fKjzAoZxRVe8BiCfHhHU7WtHATIYMyCmKBPuE7hdKNDkKs8KNUnhEsFm1gOnhqTIGBaIx7HqOvi3lpU1QVvX6V0s20f7Hc19ChqWonFwg5HdgHfl2Yyk9LnTQ6yKPkdhuTSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726984160; c=relaxed/simple;
	bh=jJW9B3d+KU2/i9btemTRtY7T483RJ0ApDaKU8HYkSB0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NgumcTGmhGoN5hDn6FEWFaTmJYd6iDCkeLrIR0rQuABg1MijQj3aGbQrOkcSowQTrFwbz9fxd/ElrsxT9CsaiyGlCHYDIajDOX4eyAf2TWqExtUhpceeBN090KKw3QW409yeSWUX/+9My//pdd/QXEwxJhtwJ4QJzGHkfha07hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GMzlE5wf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E85BBC4CEC3;
	Sun, 22 Sep 2024 05:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726984160;
	bh=jJW9B3d+KU2/i9btemTRtY7T483RJ0ApDaKU8HYkSB0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=GMzlE5wf59FKARtlJgGs2n6P5kt5vtAqTeuh9OzKTGqWA0YNUSM/use4EZK3Gg3TN
	 0xlIRGf6HUJRm/EOzi9BsTj8f3/JaQhU76dvvIGb5K+P3oQvXr5gC260w+FOMGsqGA
	 B0dLfWBFoen4Sdr91RK2j18kS7kz6ve/pGOnaB0vdKo9NItHCOlavdg5GfnPWwZwk4
	 w2kQ6rNTlWA26ls+omY8Jj5l7bg1VpYAwB/dHmY31O0qpj0ekunANrkaW1UVsxvc9O
	 lIdu08TLrfzzxfRfV24zyAboJdh0Avrop6trmGiu2sl5KLRNbDjmyNWFk/bdqVRukb
	 gdn7eRvixtCOA==
X-Mailer: emacs 31.0.50 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Dave Hansen <dave.hansen@intel.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	linux-arm-kernel@lists.infradead.org
Cc: nd@arm.com, akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
	anshuman.khandual@arm.com, bp@alien8.de, broonie@kernel.org,
	catalin.marinas@arm.com, christophe.leroy@csgroup.eu,
	dave.hansen@linux.intel.com, hpa@zytor.com,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, maz@kernel.org, mingo@redhat.com,
	mpe@ellerman.id.au, naveen.n.rao@linux.ibm.com, npiggin@gmail.com,
	oliver.upton@linux.dev, shuah@kernel.org, skhan@linuxfoundation.org,
	szabolcs.nagy@arm.com, tglx@linutronix.de, will@kernel.org,
	x86@kernel.org, kvmarm@lists.linux.dev,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 06/30] arm64: context switch POR_EL0 register
In-Reply-To: <6c8ad091-a56b-41ba-b403-2e3c2e578100@intel.com>
References: <20240822151113.1479789-1-joey.gouly@arm.com>
 <20240822151113.1479789-7-joey.gouly@arm.com>
 <425b8f8c-b6b5-422a-b5f4-41dd2d1ae3bb@arm.com>
 <6c8ad091-a56b-41ba-b403-2e3c2e578100@intel.com>
Date: Sun, 22 Sep 2024 11:19:05 +0530
Message-ID: <yq5awmj4tezy.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dave Hansen <dave.hansen@intel.com> writes:

> On 9/11/24 08:01, Kevin Brodsky wrote:
>> On 22/08/2024 17:10, Joey Gouly wrote:
>>> @@ -371,6 +382,9 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
>>>  		if (system_supports_tpidr2())
>>>  			p->thread.tpidr2_el0 = read_sysreg_s(SYS_TPIDR2_EL0);
>>>  
>>> +		if (system_supports_poe())
>>> +			p->thread.por_el0 = read_sysreg_s(SYS_POR_EL0);
>> Here we are only reloading POR_EL0's value if the target is a user
>> thread. However, as this series stands, POR_EL0 is also relevant to
>> kthreads, because any uaccess or GUP done from a kthread will also be
>> checked against POR_EL0. This is especially important in cases like the
>> io_uring kthread, which accesses the memory of the user process that
>> spawned it. To prevent such a kthread from inheriting a stale value of
>> POR_EL0, it seems that we should reload POR_EL0's value in all cases
>> (user and kernel thread).
>
> The problem with this is trying to figure out which POR_EL0 to use.  The
> kthread could have been spawned ages ago and might not have a POR_EL0
> which is very different from the current value of any of the threads in
> the process right now.
>
> There's also no great way for a kthread to reach out and grab an updated
> value.  It's all completely inherently racy.
>
>> Other approaches could also be considered (e.g. resetting POR_EL0 to
>> unrestricted when creating a kthread), see my reply on v4 [1].
>
> I kinda think this is the only way to go.  It's the only sensible,
> predictable way.  I _think_ it's what x86 will end up doing with PKRU,
> but there's been enough churn there that I'd need to go double check
> what happens in practice.
>


that is also what powerpc does. 

/* usage of kthread_use_mm() should inherit the
 * AMR value of the operating address space. But, the AMR value is
 * thread-specific and we inherit the address space and not thread
 * access restrictions. Because of this ignore AMR value when accessing
 * userspace via kernel thread.
 */
static __always_inline u64 current_thread_amr(void)
{
	if (current->thread.regs)
		return current->thread.regs->amr;
	return default_amr;
}


-aneesh

