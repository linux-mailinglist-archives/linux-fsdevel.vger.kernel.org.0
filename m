Return-Path: <linux-fsdevel+bounces-70214-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD99C93BD3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 11:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E4E8A348CB3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 10:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03161274B29;
	Sat, 29 Nov 2025 10:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="LKw3pcCh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EB236D4EF;
	Sat, 29 Nov 2025 10:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764410770; cv=none; b=MuXEgyecW9uYw2Tz24Xy5lec6J7K9Q2/Viy2A28uh6R9nQ1nwgpV9fmsRinQS/dV7IJguGESSHJ0v4lhQ5m8rr72Iv+4xeqXilfQanKJ9cKosK5+HYi6FZH4+0Atk68E18TgJu3xKqTBF5Z8/+hJtUQUU6ruXcbgeNTWt2pg/C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764410770; c=relaxed/simple;
	bh=9MO8mf1J/AGraUMCxShb0p9gsBPVzSybXkU5Cx05RdM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Darmv8rE9j0dOlzXEP321B17GBYjJXmDl73Fg44N/OGPi8ipQk05ClbVzlKMIAQuCuCsVWLsrOfA4SiNBMPeY2zGFGm1M5FFrOHOFcFfmNj9TA+GT3VacMNiwViYxXcPDeSMNJY847pIcX8xxcv09R5j705zac9/N/sGwJQu6s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=LKw3pcCh; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=BisTJGQsAm8JxGS/FGbNQObzPYii/zoODGDdLNjCUjY=;
	b=LKw3pcChJY2cUq4YiMXDkqNKW1uu83CtT1Cn4XFrVavk9ZQBIgR9Sk+X+35pioEYv2visZasm
	L7+qSHl9jVwbawTaPiWHj9ttZntzmPQGQrcL95wodeDPDdbzBFohB+QJAOkM4kypwIn+YrfvhCo
	2pm5hyMdQxDlt5ORb9dDcS4=
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4dJQjT1yWtzcZyW;
	Sat, 29 Nov 2025 18:03:41 +0800 (CST)
Received: from kwepemj100009.china.huawei.com (unknown [7.202.194.3])
	by mail.maildlp.com (Postfix) with ESMTPS id D16C8180B4E;
	Sat, 29 Nov 2025 18:06:01 +0800 (CST)
Received: from DESKTOP-A37P9LK.huawei.com (10.67.109.17) by
 kwepemj100009.china.huawei.com (7.202.194.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 29 Nov 2025 18:06:00 +0800
From: Xie Yuanbin <xieyuanbin1@huawei.com>
To: <viro@zeniv.linux.org.uk>
CC: <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
	<bigeasy@linutronix.de>, <brauner@kernel.org>, <catalin.marinas@arm.com>,
	<hch@lst.de>, <jack@suse.com>, <liaohua4@huawei.com>, <lilinjie8@huawei.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux@armlinux.org.uk>, <pangliyuan1@huawei.com>,
	<rmk+kernel@armlinux.org.uk>, <wangkefeng.wang@huawei.com>,
	<will@kernel.org>, <wozizhi@huaweicloud.com>, <xieyuanbin1@huawei.com>,
	<yangerkun@huawei.com>
Subject: Re: [Bug report] hash_name() may cross page boundary and trigger
Date: Sat, 29 Nov 2025 18:05:57 +0800
Message-ID: <20251129100557.10610-1-xieyuanbin1@huawei.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251129094448.GL3538@ZenIV>
References: <20251129094448.GL3538@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemj100009.china.huawei.com (7.202.194.3)

On Sat, 29 Nov 2025 09:44:48 +0000, Al Viro wrote:
> On Sat, Nov 29, 2025 at 05:25:45PM +0800, Xie Yuanbin wrote:
>> In fact, I have already submitted another patch, which is exactly the way
>> as you described:
>> Link: https://lore.kernel.org/20251127140109.191657-1-xieyuanbin1@huawei.com
>>
>> The only difference is that I will move the judgment to before
>> local_irq_enable(). The reason for doing this is to fix another bug,
>> you can find more details about it here:
>> Link: https://lore.kernel.org/20250925025744.6807-1-xieyuanbin1@huawei.com
>> Link: https://lore.kernel.org/20251129021815.9679-1-xieyuanbin1@huawei.com
>
>AFAICS, your patch does nothing to the case when we hit kernel address from
>kernel mode, which is what triggers that "block in RCU mode for no good reason"
>fun...

I'm a little confused. Which patch are you referring to?

BTW, I'm trying my best to fix both of these two bugs (might_sleep() in
RCU Read Critical Section and missing harden_branch_predictor()
mitigation):
Link: https://lore.kernel.org/20251126090505.3057219-1-wozizhi@huaweicloud.com
Link: https://lore.kernel.org/20250925025744.6807-1-xieyuanbin1@huawei.com
at the same time, because I feel that the solutions of these two bugs are
very similar in some way. And there is a preliminary solution in place:
```patch
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 2bc828a1940c..5c58072d8235 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -270,10 +270,15 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
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
```
Link: https://lore.kernel.org/20251127140109.191657-1-xieyuanbin1@huawei.com

I'm not sure if I'm doing the right thing. Do you have any suggestions for
this?

Thanks very much!

Xie Yuanbin

