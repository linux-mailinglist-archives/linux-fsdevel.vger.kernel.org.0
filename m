Return-Path: <linux-fsdevel+bounces-70212-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7EBC93B5B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 10:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CBA23A3B31
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 09:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F268A26CE22;
	Sat, 29 Nov 2025 09:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="iAWqeivU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2461A073F;
	Sat, 29 Nov 2025 09:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764408391; cv=none; b=QWM7jnSessajokoQtR+rcyw7MdA9VQLAg9JRhJpQaSktaokhw23zN+iy5FAqSZc5DTUzQ1LvxC/gFVoQWfdxw1H/PEtXXbM4okEAD1mRb8xS690Qb3GmKxpWGr0nXE+E5MJ+ZbfbdIsPTq2zK94qVX7euEHjBbSowP6sjd4ymos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764408391; c=relaxed/simple;
	bh=g5m6xEW4evyv+pfWZ6uVFv1pyzXYpB+mkMFcJVRGtuk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pmUUrXdN/bhKvJAuelweW7pQDMzSw8oK4rGF9Y6T+Yml18/WAxdJMKqIAhhrNwuO2KipjfXbFq80uBWE0RABfi8IKxb9/MCF7j1c9mAZ3gnFkNQ2BumXSntS3YFVNHFrph4QD+VRdV9hbyK8+XP3nJnaldg7KYfkaERbLlHnAgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=iAWqeivU; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=e9dVSOpcR3NajjbHJM0v+Jek+ZgTYIb8ZcFiF66ekIA=;
	b=iAWqeivURbpGsCaVtOtNoNhK+3A3QPdc5EYzynM0vqm5qsEhctuFpESwUvj0IsTqCEVGPJrqD
	TjamLg1p5w2bEtnjHO2Dy2fRNExVPHlsJe+yDf8oL/w2evWSdtRf4WV+Xk4uI3cEXGJmnixpM21
	mBUfN7UzPFTCweFA0c+Ysak=
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4dJPrD1WKQz1prLT;
	Sat, 29 Nov 2025 17:24:28 +0800 (CST)
Received: from kwepemj100009.china.huawei.com (unknown [7.202.194.3])
	by mail.maildlp.com (Postfix) with ESMTPS id 22071180B3F;
	Sat, 29 Nov 2025 17:26:19 +0800 (CST)
Received: from DESKTOP-A37P9LK.huawei.com (10.67.109.17) by
 kwepemj100009.china.huawei.com (7.202.194.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 29 Nov 2025 17:26:18 +0800
From: Xie Yuanbin <xieyuanbin1@huawei.com>
To: <viro@zeniv.linux.org.uk>, <will@kernel.org>, <linux@armlinux.org.uk>,
	<bigeasy@linutronix.de>, <rmk+kernel@armlinux.org.uk>
CC: <akpm@linux-foundation.org>, <brauner@kernel.org>,
	<catalin.marinas@arm.com>, <hch@lst.de>, <jack@suse.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<pangliyuan1@huawei.com>, <wangkefeng.wang@huawei.com>,
	<wozizhi@huaweicloud.com>, <xieyuanbin1@huawei.com>, <yangerkun@huawei.com>,
	<lilinjie8@huawei.com>, <liaohua4@huawei.com>
Subject: Re: [Bug report] hash_name() may cross page boundary and trigger
Date: Sat, 29 Nov 2025 17:25:45 +0800
Message-ID: <20251129092545.5181-1-xieyuanbin1@huawei.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251129090813.GK3538@ZenIV>
References: <20251129090813.GK3538@ZenIV>
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

On Sat, 29 Nov 2025 09:08:13 +0000, Al Viro wrote:
> On Sat, Nov 29, 2025 at 12:08:17PM +0800, Xie Yuanbin wrote:
>
>> I think the `user_mode(regs)` check is necessary because the label
>> no_context actually jumps to __do_kernel_fault(), whereas page fault
>> from user mode should jump to `__do_user_fault()`.
>>
>> Alternatively, we would need to change `goto no_context` to
>> `goto bad_area`. Or perhaps I misunderstood something, please point it out.
>
> FWIW, goto bad_area has an obvious problem: uses of 'fault' value, which
> contains garbage.

Yes, I know it, I just omitted it. Thank you for pointing that out.

> or
> 	if (unlikely(addr >= TASK_SIZE)) {
> 		fault = 0;
> 		code = SEGV_MAPERR;
> 		goto bad_area;
> 	}

In fact, I have already submitted another patch, which is exactly the way
as you described:
Link: https://lore.kernel.org/20251127140109.191657-1-xieyuanbin1@huawei.com

The only difference is that I will move the judgment to before
local_irq_enable(). The reason for doing this is to fix another bug,
you can find more details about it here:
Link: https://lore.kernel.org/20250925025744.6807-1-xieyuanbin1@huawei.com
Link: https://lore.kernel.org/20251129021815.9679-1-xieyuanbin1@huawei.com

To keep the email concise, I will not repeat the description here.

Xie Yuanbin

