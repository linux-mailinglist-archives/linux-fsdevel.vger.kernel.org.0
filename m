Return-Path: <linux-fsdevel+bounces-70033-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B9376C8EABE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 15:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 343E54E8FE5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 14:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8447430FC37;
	Thu, 27 Nov 2025 14:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="BrKKm1Dq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D654235C1E;
	Thu, 27 Nov 2025 14:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764252106; cv=none; b=hYRbulxcOYqUmUeZ62CfTpG1y4/G3YaKvWdUsT53Uor6j3Es0Ne4AGEVDx56vpWsV1CH41/gThxvnsRX7zpyW2vyoRxJcP8TMuRx+zvxmjymJBhFeZVB1o1BQKqPOE+30ilJ2HqwSjHRcfoWFw8xuuMLad+MKzTOaELnOgEQNDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764252106; c=relaxed/simple;
	bh=JjHsR7bSBPzEdpBJ54j/TFynJ/gzgrbhWbVs5boDnG0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aTqyK2nmgidDUWC+CbQItrcLg+DNQZr5eKvJZqsyEVdIIjSlRttAGaCj9OMFmK9UXbNFdu8P7PHLlcI1heZMRbJa6MThnnneLISdhU1I+xXwl3MC8U0+7vM7yA7LLUegCYBS5YqjSK7OLWoQxKxOCaovqM+IcQrMfIrBxTuU6p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=BrKKm1Dq; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=5Dqh1/ZwDt2FOZnFxUGnYOMEzfM7bVg75Vg41Zs839w=;
	b=BrKKm1DqDzeaPEp+Ht6Vp/QY+ceSXm0RUwkjGBSqqCOPFcoSOx/71e0Mm1DqOC4+FFZh1hLY7
	DeUshsfdhtVNukB5sNmzhb4QBQ8AfnDJggNB9pw+skQQpKsXxsvzSyPat63XJ8AQU5aBvI3TFWH
	MPAJn5/2Zab6HVX1/S+Pimk=
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4dHJ2l63Lrz1prLQ;
	Thu, 27 Nov 2025 21:59:43 +0800 (CST)
Received: from kwepemj100009.china.huawei.com (unknown [7.202.194.3])
	by mail.maildlp.com (Postfix) with ESMTPS id 981F21804F6;
	Thu, 27 Nov 2025 22:01:33 +0800 (CST)
Received: from DESKTOP-A37P9LK.huawei.com (10.67.109.17) by
 kwepemj100009.china.huawei.com (7.202.194.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 27 Nov 2025 22:01:32 +0800
From: Xie Yuanbin <xieyuanbin1@huawei.com>
To: <viro@zeniv.linux.org.uk>, <will@kernel.org>, <nico@fluxnic.net>,
	<rmk+kernel@armlinux.org.uk>, <linux@armlinux.org.uk>,
	<david.laight@runbox.com>, <rppt@kernel.org>, <vbabka@suse.cz>,
	<pfalcato@suse.de>, <brauner@kernel.org>, <lorenzo.stoakes@oracle.com>,
	<kuninori.morimoto.gx@renesas.com>, <tony@atomide.com>, <arnd@arndb.de>,
	<bigeasy@linutronix.de>, <akpm@linux-foundation.org>,
	<punitagrawal@gmail.com>, <hch@lst.de>, <jack@suse.com>, <rjw@rjwysocki.net>,
	<marc.zyngier@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<wozizhi@huaweicloud.com>, <liaohua4@huawei.com>, <lilinjie8@huawei.com>,
	<xieyuanbin1@huawei.com>, <pangliyuan1@huawei.com>,
	<wangkefeng.wang@huawei.com>
Subject: [RFC PATCH v2 2/2] ARM/mm/fault: Enable interrupts before sending signal
Date: Thu, 27 Nov 2025 22:01:09 +0800
Message-ID: <20251127140109.191657-2-xieyuanbin1@huawei.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251127140109.191657-1-xieyuanbin1@huawei.com>
References: <20251127140109.191657-1-xieyuanbin1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemj100009.china.huawei.com (7.202.194.3)

From: xieyuanbin1 <xieyuanbin1@huawei.com>

Sending a signal requires to acquire sighand_struct::siglock which is a
spinlock_t. On PREEMPT_RT spinlock_t becomes a sleeping spin lock which
requires interrupts to be enabled. Since the calling context is user
land, interrupts must have been enabled so it is fine to enable them in
this case.

Signed-off-by: xieyuanbin1 <xieyuanbin1@huawei.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
This patch depends on patch
Link: https://lore.kernel.org/20251029155918.503060-6-bigeasy@linutronix.de

The commit message is copy from:
Link: https://lore.kernel.org/20251029155918.503060-3-bigeasy@linutronix.de

Maybe I should add:
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Or something else? Thanks!

 arch/arm/mm/fault.c | 3 +++
 1 file changed, 3 insertions(+)

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
-- 
2.51.0


