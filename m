Return-Path: <linux-fsdevel+bounces-70813-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D307CA7F65
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 15:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 082EB318CA32
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 12:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8B229AB15;
	Fri,  5 Dec 2025 12:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="JrZon1c+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2233274B23;
	Fri,  5 Dec 2025 12:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764936518; cv=none; b=ijWPFRTkn/2jgU1XZyAjUCQrJBs6iRKPwW5e3f+r9mTEkzjdoZ/1xMHmsYoeyPES8LU8DA1y++o2pi3jsZrFtqKoPqhTI4QPoo0aNSvNlXYOZNgSLg1QfB4bDYJLh6U/lWB45lCsCNaXdu5zYlTmz1oIoaBUenFHwCy0SPwWMWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764936518; c=relaxed/simple;
	bh=WdXn2u/Gx4lmmbm6ovntTtvLKANucrEh6lJrHbOVr5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tw5VNwBdCEVSvFYfdxs82CmAlLOBKhBPqk/BMkm0xjgkXYnXdnraDuWKgDk5FddAImRme9/r7rhiGLDD8O1TzWWFQVQins+0kSTKq8qxT6yF+gYxWCv7zDpnqphKVFo9GAPezCiJT1tIf8UR4Y3kWvI+pCPQ33+pT/drJ73lm/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=JrZon1c+; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qOqOO1RkHv+TL4sHO2I/M94wigINI1Cn0aqofm8+DJM=; b=JrZon1c+goGZ/cvJPITZz+HQAG
	H8Glqh4GmzB4ynFJAlqotxWYu/at+K2gILu3ugTSYfgyyA9nlgkYCOH9DsRXqv3mk+Id9XnDEeOyo
	KPPF7riTyhWttscjHg/UmGw+FFzHJ+L3PDkBoL47BA7n8mYjoZSHW/H/o341Ym97v+olzn/mai3wg
	jtud26oX+CTo/9jlt8VAMQYI2a5VHeGTe/kcmC2pGu8768drFMpPega2QiNq3vkswcBw485F65wHM
	TiWeqs1otv1R5KDD6QrYP4z85DZ5jaJokaX/uCSIHMgPaKqDiJ87vv2t31h78rMOxahMYDXcOxl2s
	+bhzADnQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53922)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vRUbi-000000004aX-0Y8R;
	Fri, 05 Dec 2025 12:08:18 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vRUbe-0000000025R-1Eju;
	Fri, 05 Dec 2025 12:08:14 +0000
Date: Fri, 5 Dec 2025 12:08:14 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Xie Yuanbin <xieyuanbin1@huawei.com>
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
	brauner@kernel.org, catalin.marinas@arm.com, hch@lst.de,
	jack@suse.com, linux-arm-kernel@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, pangliyuan1@huawei.com,
	wangkefeng.wang@huawei.com, will@kernel.org,
	wozizhi@huaweicloud.com, yangerkun@huawei.com
Subject: Re: [Bug report] hash_name() may cross page boundary and trigger
 sleep in RCU context
Message-ID: <aTLLLuup7TeAqFVL@shell.armlinux.org.uk>
References: <CAHk-=wg4ZnsfpgXYL5qhjYDYo1Gnssz+VxnKZzHXMEmE7qrnQQ@mail.gmail.com>
 <20251203014800.4988-1-xieyuanbin1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251203014800.4988-1-xieyuanbin1@huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Dec 03, 2025 at 09:48:00AM +0800, Xie Yuanbin wrote:
> On Tue, 2 Dec 2025 14:07:25 -0800, Linus Torvalds wrote:
> > On Tue, 2 Dec 2025 at 04:43, Russell King (Oracle)
> > <linux@armlinux.org.uk> wrote:
> >>
> >> What I'm thinking is to address both of these by handling kernel space
> >> page faults (which will be permission or PTE-not-present) separately
> >> (not even build tested):
> >
> > That patch looks sane to me.
> >
> > But I also didn't build test it, just scanned it visually ;)
> 
> That patch removes harden_branch_predictor() from __do_user_fault(), and
> moves it to do_page_fault()->do_kernel_address_page_fault(). 
> This resolves previously mentioned kernel warning issue. However,
> __do_user_fault() is not only called by do_page_fault(), it is
> alse called by do_bad_area(), do_sect_fault() and do_translation_fault().
> 
> So I think that some harden_branch_predictor() is missing on other paths.
> According to my tests, when CONFIG_ARM_LPAE=n, harden_branch_predictor()
> will never be called anymore, even if a user program trys to access the
> kernel address.
> 
> Or perhaps I've misunderstood something, could you please point it out?
> Thank you very much.

Right, let's split these issues into separate patches. Please test this
patch, which should address only the hash_name() fault issue, and
provides the basis for fixing the branch predictor issue.

Yes, at the moment, do_kernel_address_page_fault() looks very much like
do_bad_area(), but with the addition of the IRQ-enable if the parent
context was enabled, but the following patch to address the branch
predictor hardening will show why its different.

In my opinion, this approach makes the handling for kernel address
page faults (non-present pages and page permission faults) much easier
to understand.

Note that this will call __do_user_fault() with interrupts disabled.

Build tested, and remotely boot tested on Cortex-A5 hardware but
without kfence enabled. Also tested usermode access to kernel space
which fails with SEGV:
- read from 0xc0000000 (section permission fault, do_sect_fault)
- read from 0xffff2000 (page translation fault, do_page_fault)
- read from 0xffff0000 (vectors page - read possible as expected)
- write to 0xffff0000 (page permission fault, do_page_fault)

8<===
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: [PATCH] ARM: fix hash_name() fault

Zizhi Wo reports:

"During the execution of hash_name()->load_unaligned_zeropad(), a
 potential memory access beyond the PAGE boundary may occur. For
 example, when the filename length is near the PAGE_SIZE boundary.
 This triggers a page fault, which leads to a call to
 do_page_fault()->mmap_read_trylock(). If we can't acquire the lock,
 we have to fall back to the mmap_read_lock() path, which calls
 might_sleep(). This breaks RCU semantics because path lookup occurs
 under an RCU read-side critical section."

This is seen with CONFIG_DEBUG_ATOMIC_SLEEP=y and CONFIG_KFENCE=y.

Kernel addresses (with the exception of the vectors/kuser helper
page) do not have VMAs associated with them. If the vectors/kuser
helper page faults, then there are two possibilities:

1. if the fault happened while in kernel mode, then we're basically
   dead, because the CPU won't be able to vector through this page
   to handle the fault.
2. if the fault happened while in user mode, that means the page was
   protected from user access, and we want to fault anyway.

Thus, we can handle kernel addresses from any context entirely
separately without going anywhere near the mmap lock. This gives us
an entirely non-sleeping path for all kernel mode kernel address
faults.

Reported-by: Zizhi Wo <wozizhi@huaweicloud.com>
Reported-by: Xie Yuanbin <xieyuanbin1@huawei.com>
Link: https://lore.kernel.org/r/20251126090505.3057219-1-wozizhi@huaweicloud.com
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mm/fault.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 46169fe42c61..2bbec38ced97 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -260,6 +260,35 @@ static inline bool ttbr0_usermode_access_allowed(struct pt_regs *regs)
 }
 #endif
 
+static int __kprobes
+do_kernel_address_page_fault(struct mm_struct *mm, unsigned long addr,
+			     unsigned int fsr, struct pt_regs *regs)
+{
+	if (user_mode(regs)) {
+		/*
+		 * Fault from user mode for a kernel space address. User mode
+		 * should not be faulting in kernel space, which includes the
+		 * vector/khelper page. Send a SIGSEGV.
+		 */
+		__do_user_fault(addr, fsr, SIGSEGV, SEGV_MAPERR, regs);
+	} else {
+		/*
+		 * Fault from kernel mode. Enable interrupts if they were
+		 * enabled in the parent context. Section (upper page table)
+		 * translation faults are handled via do_translation_fault(),
+		 * so we will only get here for a non-present kernel space
+		 * PTE or PTE permission fault. This may happen in exceptional
+		 * circumstances and need the fixup tables to be walked.
+		 */
+		if (interrupts_enabled(regs))
+			local_irq_enable();
+
+		__do_kernel_fault(mm, addr, fsr, regs);
+	}
+
+	return 0;
+}
+
 static int __kprobes
 do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 {
@@ -273,6 +302,12 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	if (kprobe_page_fault(regs, fsr))
 		return 0;
 
+	/*
+	 * Handle kernel addresses faults separately, which avoids touching
+	 * the mmap lock from contexts that are not able to sleep.
+	 */
+	if (addr >= TASK_SIZE)
+		return do_kernel_address_page_fault(mm, addr, fsr, regs);
 
 	/* Enable interrupts if they were enabled in the parent context. */
 	if (interrupts_enabled(regs))
-- 
2.47.3

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

