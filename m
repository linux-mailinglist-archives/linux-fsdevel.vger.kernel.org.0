Return-Path: <linux-fsdevel+bounces-70103-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DA809C90A24
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 03:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8729C34323B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 02:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5345276058;
	Fri, 28 Nov 2025 02:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="v2N7Xi15"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A3523A98E;
	Fri, 28 Nov 2025 02:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764296893; cv=none; b=p+ml22GO3iBhoZbdn6J/m+oqmrIAz/GxeJyM6XvJfy+I1dIVzLwjIT2u3nEoQrNOgBk4wyfUSWzk89Cu3RYeX0PIuEQ2z2rjC8xdyFBTd8FLiDsYVc0NZt7Y5NJspLVAon6GLR94VqkeKespwSCMAPobPngaKIMToZALSpY+n/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764296893; c=relaxed/simple;
	bh=Y7XVbG621436+M4XfTBVil+S0xNFf9wSJPZFaP+4b/g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SprQe3Uia2N5Wdyw6dpo5cIiMa8eS3s5YsvU4TKdZcblxSC9+cgR3SSnh5Nx126lsphBaUfAzg8zO1GbeOEpJrJ+GW0yPk23HuVFnOnwCaPMIdo8dRzog4MW/J+k3oI36aqmgLXuJnGWz26cWV0WMeDPt1XgNDmB9LPl7u94Mro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=v2N7Xi15; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=8t+SKLfB9YSz+ESvF8MmSt0kWBtO3/8g8KlI38flHHg=;
	b=v2N7Xi15sXplM6/c4zwcXTdDZ2HeUyMB89bLjFelMFddlcr5SnQGmd1D8l3sxpZjoYTCwEAV4
	CQO8Hj1I6+GqeRNUeZkUdg1otg8WO5cwKOrZNH7wZtZ8gYwtw0xSlwKkysFtHoT/nlHFrdflYL9
	fso03TKP5dqdUWTiC1vO7+w=
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4dHcc36LWhzmV79;
	Fri, 28 Nov 2025 10:26:11 +0800 (CST)
Received: from kwepemj100009.china.huawei.com (unknown [7.202.194.3])
	by mail.maildlp.com (Postfix) with ESMTPS id 0145F1A016C;
	Fri, 28 Nov 2025 10:28:01 +0800 (CST)
Received: from DESKTOP-A37P9LK.huawei.com (10.67.109.17) by
 kwepemj100009.china.huawei.com (7.202.194.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 28 Nov 2025 10:27:59 +0800
From: Xie Yuanbin <xieyuanbin1@huawei.com>
To: <bigeasy@linutronix.de>
CC: <akpm@linux-foundation.org>, <arnd@arndb.de>, <brauner@kernel.org>,
	<david.laight@runbox.com>, <hch@lst.de>, <jack@suse.com>,
	<kuninori.morimoto.gx@renesas.com>, <liaohua4@huawei.com>,
	<lilinjie8@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux@armlinux.org.uk>, <lorenzo.stoakes@oracle.com>,
	<marc.zyngier@arm.com>, <nico@fluxnic.net>, <pangliyuan1@huawei.com>,
	<pfalcato@suse.de>, <punitagrawal@gmail.com>, <rjw@rjwysocki.net>,
	<rmk+kernel@armlinux.org.uk>, <rppt@kernel.org>, <tony@atomide.com>,
	<vbabka@suse.cz>, <viro@zeniv.linux.org.uk>, <wangkefeng.wang@huawei.com>,
	<will@kernel.org>, <wozizhi@huaweicloud.com>, <xieyuanbin1@huawei.com>
Subject: Re: [RFC PATCH v2 1/2] ARM/mm/fault: always goto bad_area when handling with page faults of kernel address
Date: Fri, 28 Nov 2025 10:27:56 +0800
Message-ID: <20251128022756.9973-1-xieyuanbin1@huawei.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251127145127.qUXs_UAE@linutronix.de>
References: <20251127145127.qUXs_UAE@linutronix.de>
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

On Thu, 27 Nov 2025 15:51:27 +0100, Sebastian Andrzej Siewior wrote:
> What is with the patch I sent wrong?

Hi, Sebastian Andrzej Siewior!

There is nothing wrong with your patches, but when you submitted
your patches, this bug has not been reportted:
Link: https://lore.kernel.org/20251126090505.3057219-1-wozizhi@huaweicloud.com

Your patches fixed the missing mitigation, but the aforementioned bug
still exists. I think there might be a better solution that can fix both
bugs at the same time.

We had some discussions about this bug:
Link: https://lore.kernel.org/CAHk-=wh1Wfwt9OFB4AfBbjyeu4JVZuSWQ4A8OoT3W6x9btddfw@mail.gmail.com
Link: https://lore.kernel.org/20251126192640.GD3538@ZenIV
Link: https://lore.kernel.org/aSeNtFxD1WRjFaiR@shell.armlinux.org.uk

According to the discussion, it might be better to handle the kernel
address fault directly, just like what x86 does, instead of finding VMA.
Link: https://elixir.bootlin.com/linux/v6.18-rc7/source/arch/x86/mm/fault.c#L1473
```c
	if (unlikely(fault_in_kernel_space(address)))
		do_kern_addr_fault(regs, error_code, address);
	else
		do_user_addr_fault(regs, error_code, address);
```

It seems your patches hasn't been merged into the linux-next branch yet.
This patch is based on linux-next, so it doesn't include your
modifications. This patch might conflict with your patch:
Link: https://lore.kernel.org/20251110145555.2555055-2-bigeasy@linutronix.de
so I'd like to discuss it with you.

Thanks!

Xie Yuanbin

