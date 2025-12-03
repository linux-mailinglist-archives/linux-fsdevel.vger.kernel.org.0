Return-Path: <linux-fsdevel+bounces-70530-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4BAC9D86F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 02:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F072B3A94A4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 01:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CF8239E7E;
	Wed,  3 Dec 2025 01:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="2a92kw6v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC6C226541;
	Wed,  3 Dec 2025 01:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764726501; cv=none; b=d9SFQpw/7EokmEZSYETOZmD09E57FmThpH9oGl0nXNwZho4XD5lR0XfzgDvFSgjUD6D45CCSvLRMQGl2ejz+gVllqCg6H5B4XGKdQszvfpA3NY1YBhtPzkSahWmANHSJJ0r0TJQXJB6eoZmDo+IdgjA3lJcS5BeCzn1wU7GuKi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764726501; c=relaxed/simple;
	bh=HbeKKo/Z3FReZ4Vgb0FueoQwD+EnMKz/fj3AeH/lK3U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i/lhb/7El9DYpWKAYVAdtrFiG+8nnQHRADj46Iei6t+KPDx4Va2/i9ViZJ6BI3gg27zpqtsVTT2EnX4Lw2acVOuA4+iktLKG1wspDUBrsqGCpSUxBTk6s7nksFNiPeY36kAKXVSHAzaqJ3xarbMKibPcga9PwMpIUrCBak7ppFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=2a92kw6v; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=sIempqaM8kOBJ+y/E9PeRjl6HxUaDOYzGfVfS5fH348=;
	b=2a92kw6vO7F3z660yI8YgpbKmYdDLdJLg/naZks2OKUbRKu8aEOtlsTu+5Qrwp57FyGJtT5aT
	Ad9FbZcuy328yLSaj8FoyvIZ/Izm2J46vkLNzBoF2w5xoarhGS1Zz0TrPCxZI53Fj2LCvWHZoNg
	Dlp9fm2qJPZ37hTiDEglcvI=
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4dLgTq2tFZz1prKT;
	Wed,  3 Dec 2025 09:46:23 +0800 (CST)
Received: from kwepemj100009.china.huawei.com (unknown [7.202.194.3])
	by mail.maildlp.com (Postfix) with ESMTPS id 9E082180409;
	Wed,  3 Dec 2025 09:48:16 +0800 (CST)
Received: from DESKTOP-A37P9LK.huawei.com (10.67.109.17) by
 kwepemj100009.china.huawei.com (7.202.194.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 3 Dec 2025 09:48:15 +0800
From: Xie Yuanbin <xieyuanbin1@huawei.com>
To: <torvalds@linux-foundation.org>, <linux@armlinux.org.uk>
CC: <akpm@linux-foundation.org>, <brauner@kernel.org>,
	<catalin.marinas@arm.com>, <hch@lst.de>, <jack@suse.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<pangliyuan1@huawei.com>, <wangkefeng.wang@huawei.com>, <will@kernel.org>,
	<wozizhi@huaweicloud.com>, <xieyuanbin1@huawei.com>, <yangerkun@huawei.com>
Subject: [Bug report] hash_name() may cross page boundary and trigger sleep in RCU context
Date: Wed, 3 Dec 2025 09:48:00 +0800
Message-ID: <20251203014800.4988-1-xieyuanbin1@huawei.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <CAHk-=wg4ZnsfpgXYL5qhjYDYo1Gnssz+VxnKZzHXMEmE7qrnQQ@mail.gmail.com>
References: <CAHk-=wg4ZnsfpgXYL5qhjYDYo1Gnssz+VxnKZzHXMEmE7qrnQQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemj100009.china.huawei.com (7.202.194.3)

On Tue, 2 Dec 2025 14:07:25 -0800, Linus Torvalds wrote:
> On Tue, 2 Dec 2025 at 04:43, Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
>>
>> What I'm thinking is to address both of these by handling kernel space
>> page faults (which will be permission or PTE-not-present) separately
>> (not even build tested):
>
> That patch looks sane to me.
>
> But I also didn't build test it, just scanned it visually ;)

That patch removes harden_branch_predictor() from __do_user_fault(), and
moves it to do_page_fault()->do_kernel_address_page_fault(). 
This resolves previously mentioned kernel warning issue. However,
__do_user_fault() is not only called by do_page_fault(), it is
alse called by do_bad_area(), do_sect_fault() and do_translation_fault().

So I think that some harden_branch_predictor() is missing on other paths.
According to my tests, when CONFIG_ARM_LPAE=n, harden_branch_predictor()
will never be called anymore, even if a user program trys to access the
kernel address.

Or perhaps I've misunderstood something, could you please point it out?
Thank you very much.

What about something like this (The patch has been tested):
```patch
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 2bc828a1940c..af86198631c5 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -183,9 +183,11 @@ __do_user_fault(unsigned long addr, unsigned int fsr, unsigned int sig,
 {
 	struct task_struct *tsk = current;

-	if (addr > TASK_SIZE)
+	if (addr >= TASK_SIZE)
 		harden_branch_predictor();

+	local_irq_enable();
+
 #ifdef CONFIG_DEBUG_USER
 	if (((user_debug & UDBG_SEGV) && (sig == SIGSEGV)) ||
 	    ((user_debug & UDBG_BUS)  && (sig == SIGBUS))) {
@@ -272,6 +274,24 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	if (kprobe_page_fault(regs, fsr))
 		return 0;

+	if (unlikely(addr >= TASK_SIZE)) {
+		/*
+		 * Fault from user mode for a kernel space address. User mode
+		 * should not be faulting in kernel space, which includes the
+		 * vector/khelper page. Handle the Spectre issues while
+		 * interrupts are still disabled, then send a SIGSEGV. Note
+		 * that __do_user_fault() will enable interrupts.
+		 *
+		 * Fault from kernel mode. Jump to __do_kernel_fault()->
+		 * fixup_exception() directly, without getting mm lock and
+		 * finding vma. The interrupts are not enabled but it will be
+		 * good, just like what do_translation_fault() and
+		 * do_bad_area() does.
+		 */
+		fault = 0;
+		code = SEGV_MAPERR;
+		goto bad_area;
+	}

 	/* Enable interrupts if they were enabled in the parent context. */
 	if (interrupts_enabled(regs))

```

Thanks very much!

