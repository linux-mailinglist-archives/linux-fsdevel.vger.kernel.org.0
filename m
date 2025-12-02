Return-Path: <linux-fsdevel+bounces-70453-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 525DEC9B8C4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 14:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E1605346158
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Dec 2025 13:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFFC312810;
	Tue,  2 Dec 2025 13:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="lt78+yZY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CBD1F936;
	Tue,  2 Dec 2025 13:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764680611; cv=none; b=Ao8s1aR24KAfuTRmzKiqEF/C49UDmEAkqH3rCEblTFroeIe/SWNNfAaau8AeqbTmecV/FkdGqRWn2rwhEsUnB+zcdsSIMpTumVkgKn5YLqpPilFqjOYyatglrn+O31ojmSq7J59ohqbjW0zGczya/5QeE7H9m6zvUBq+VYaZVz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764680611; c=relaxed/simple;
	bh=eytzkeN0sU5Xzn3f4JByPVe/5ocJoNqZ3YKMVaFyOWw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nCV3RyWZD+HoHASt15Phg0xCgN5HRRkHLT8A8+WwPfy+SWoBgHrJLpLHqRVCSlK2QtSv9W5O1k2R8mH1VO68dGWBA/zcrKon3q2ST2iWwOhIiIDQ1lSpEFjWOOXG+F5fivyBAGkUX1lH9iAa486ZVpiE+g7Azl+/7HMxSmnB8Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=lt78+yZY; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=aW6anQe+oLE0EKfJdPntunSgyOR4oOu5YRcRbL0hNo8=;
	b=lt78+yZYRHvYg5avVm+Rhd87KT9ImxmJ017DGVZpVir/urktGskUe7450cajX2iW46QJ3RNyW
	cog1/A/drM91gD8GLIy8N+QLuAdv6CUpUku1rFEaa0CilArBvwSuIIPUbeCVZ/D9RA76RXxmoc0
	5+uhZv1fpfUSWEfTIc1yEVk=
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4dLLVW0qkqzcb07;
	Tue,  2 Dec 2025 21:00:51 +0800 (CST)
Received: from kwepemj100009.china.huawei.com (unknown [7.202.194.3])
	by mail.maildlp.com (Postfix) with ESMTPS id 6AE79180B36;
	Tue,  2 Dec 2025 21:03:17 +0800 (CST)
Received: from DESKTOP-A37P9LK.huawei.com (10.67.109.17) by
 kwepemj100009.china.huawei.com (7.202.194.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 2 Dec 2025 21:03:16 +0800
From: Xie Yuanbin <xieyuanbin1@huawei.com>
To: <linux@armlinux.org.uk>
CC: <akpm@linux-foundation.org>, <brauner@kernel.org>,
	<catalin.marinas@arm.com>, <hch@lst.de>, <jack@suse.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<pangliyuan1@huawei.com>, <torvalds@linux-foundation.org>,
	<wangkefeng.wang@huawei.com>, <will@kernel.org>, <wozizhi@huaweicloud.com>,
	<xieyuanbin1@huawei.com>, <yangerkun@huawei.com>
Subject: Re: [Bug report] hash_name() may cross page boundary and trigger sleep in RCU context
Date: Tue, 2 Dec 2025 21:02:24 +0800
Message-ID: <20251202130224.16376-1-xieyuanbin1@huawei.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <aS7e9CbQXS27sGcd@shell.armlinux.org.uk>
References: <aS7e9CbQXS27sGcd@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemj100009.china.huawei.com (7.202.194.3)

On Tue, 2 Dec 2025 12:43:32 +0000, Russell King (Oracle) wrote:
> We have another issue in the code - which has the branch predictor
> hardening for spectre issues, which can be called with interrupts
> enabled, causing a kernel warning - obviously not good.
>
> There's another issue which PREEMPT_RT has picked up on - which is
> that delivering signals via __do_user_fault() with interrupts disabled
> causes spinlocks (which can sleep on PREEMPT_RT) to warn.
>
> What I'm thinking is to address both of these by handling kernel space
> page faults (which will be permission or PTE-not-present) separately
> (not even build tested):
>
> diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
> index 2bc828a1940c..972bce697c6c 100644
> --- a/arch/arm/mm/fault.c
> +++ b/arch/arm/mm/fault.c
> @@ -175,7 +175,8 @@ __do_kernel_fault(struct mm_struct *mm, unsigned long addr, unsigned int fsr,
>
>  /*
>   * Something tried to access memory that isn't in our memory map..
> - * User mode accesses just cause a SIGSEGV
> + * User mode accesses just cause a SIGSEGV. Ensure interrupts are enabled
> + * here, which is safe as the fault being handled is from userspace.
>   */
>  static void
>  __do_user_fault(unsigned long addr, unsigned int fsr, unsigned int sig,
> @@ -183,8 +184,7 @@ __do_user_fault(unsigned long addr, unsigned int fsr, unsigned int sig,
>  {
>  	struct task_struct *tsk = current;
> 
> -	if (addr > TASK_SIZE)
> -		harden_branch_predictor();
> +	local_irq_enable();
>
>  #ifdef CONFIG_DEBUG_USER
>  	if (((user_debug & UDBG_SEGV) && (sig == SIGSEGV)) ||
> @@ -259,6 +259,38 @@ static inline bool ttbr0_usermode_access_allowed(struct pt_regs *regs)
>  }
>  #endif
>
> +static int __kprobes
> +do_kernel_address_page_fault(unsigned long addr, unsigned int fsr,
> +			     struct pt_regs *regs)
> +{
> +	if (user_mode(regs)) {
> +		/*
> +		 * Fault from user mode for a kernel space address. User mode
> +		 * should not be faulting in kernel space, which includes the
> +		 * vector/khelper page. Handle the Spectre issues while
> +		 * interrupts are still disabled, then send a SIGSEGV. Note
> +		 * that __do_user_fault() will enable interrupts.
> +		 */
> +		harden_branch_predictor();
> +		__do_user_fault(addr, fsr, SIGSEGV, SEGV_MAPERR, regs);
> +	} else {
> +		/*
> +		 * Fault from kernel mode. Enable interrupts if they were
> +		 * enabled in the parent context. Section (upper page table)
> +		 * translation faults are handled via do_translation_fault(),
> +		 * so we will only get here for a non-present kernel space
> +		 * PTE or kernel space permission fault. Both of these should
> +		 * not happen.
> +		 */
> +		if (interrupts_enabled(regs))
> +			local_irq_enable();
> +
> +		__do_kernel_fault(mm, addr, fsr, regs);
> +	}
> +
> +	return 0;
> +}
> +
>  static int __kprobes
>  do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
>  {
> @@ -272,6 +304,8 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
>  	if (kprobe_page_fault(regs, fsr))
>  		return 0;
>
> +	if (addr >= TASK_SIZE)
> +		return do_kernel_address_page_fault(addr, fsr, regs);
>
>  	/* Enable interrupts if they were enabled in the parent context. */
>  	if (interrupts_enabled(regs))
>
> ... and I think there was a bug in the branch predictor handling -
> addr == TASK_SIZE should have been included.
>
> Does this look sensible?

Hi, Russell King!

This patch removes
```c
	if (addr > TASK_SIZE)
		harden_branch_predictor();
```
from do_user_fault(), and adds it to do_page_fault()->
do_kernel_address_page_fault().

However, do_user_fault() is not only called by do_page_fault(). It is
also called by do_bad_area(), do_sect_fault() and do_translation_fault().
I am not sure that if this will lead to some missing
harden_branch_predictor() mitigation.

What about something like this:
```patch
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 2bc828a1940c..5c58072d8235 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -270,10 +270,15 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	vm_flags_t vm_flags = VM_ACCESS_FLAGS;

 	if (kprobe_page_fault(regs, fsr))
 		return 0;

+	if (unlikely(addr >= TASK_SIZE)) {
+		fault = 0;
+		code = SEGV_MAPERR;
+		goto bad_area;
+	}

 	/* Enable interrupts if they were enabled in the parent context. */
 	if (interrupts_enabled(regs))
 		local_irq_enable();
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 5c58072d8235..f8ee1854c854 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -184,10 +184,13 @@ __do_user_fault(unsigned long addr, unsigned int fsr, unsigned int sig,
 	struct task_struct *tsk = current;
 
 	if (addr > TASK_SIZE)
 		harden_branch_predictor();
 
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		local_irq_enable();
+
 #ifdef CONFIG_DEBUG_USER
 	if (((user_debug & UDBG_SEGV) && (sig == SIGSEGV)) ||
 	    ((user_debug & UDBG_BUS)  && (sig == SIGBUS))) {
 		pr_err("8<--- cut here ---\n");
 		pr_err("%s: unhandled page fault (%d) at 0x%08lx, code 0x%03x\n",
```

Thanks very much!

Xie Yuanbin

