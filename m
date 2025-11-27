Return-Path: <linux-fsdevel+bounces-70005-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF770C8E095
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 12:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0269F3AEB6B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 11:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB4B32E6B2;
	Thu, 27 Nov 2025 11:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="kzAHUMF2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9794D30103A;
	Thu, 27 Nov 2025 11:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764242482; cv=none; b=TnQ3wrPq1yaInCOsQycd1mpD2Jso9InIyocNrW9uE+KD2To2RMpHoG6sUVJmeR4r9gZeVHfxuvDhkXX7/P0Pf3usxqX14QIVB4XKLXCDyLIkMqolwo+9Y9UKug9HJ4haPdJ1ib8hLuNpVo1T0Nft/Vf7EpZJHds6Xaqaz96NqiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764242482; c=relaxed/simple;
	bh=t9H1iFjkLCjhwXZplf2BmTwi8OOStMLFSE/UsMu8IOM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f2PufN9QaD0oyq9a8HjGnuN7ORHepF1lxhHv5j0rVb/ARYtXNV0FeH9+73EFuu0/GZxOKAG8Us321ttt+cN+w35CDxgE4cuS2iWf+4Nl/KTdDhbp0/l0CcxLhXv5EbDJlCgue+qlL53s0l/ODdeyQKcXIXsTkRduhRM33HnYGbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=kzAHUMF2; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=DodGNQ4J3R60otr7WXzwptpN2trZwaXPd+16aznDXKU=;
	b=kzAHUMF2dUX/75F2x8k4f67X3bwt94v+LeKbd6y1I+Pfnt/W9chF7FpLBH1NgTjP/L/NGfo8n
	xvIQ0+PuPafeVGbUpzBFi9IJnhCxY1y3YnVnFQlCNNtgM7nYb04k1porCfASxHwGKtjxPIckwVs
	1urT6Cq6FxhqN1lH2J74Qto=
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4dHDTl6J2qz1K96R;
	Thu, 27 Nov 2025 19:19:23 +0800 (CST)
Received: from kwepemj100009.china.huawei.com (unknown [7.202.194.3])
	by mail.maildlp.com (Postfix) with ESMTPS id CD7A614011F;
	Thu, 27 Nov 2025 19:21:10 +0800 (CST)
Received: from DESKTOP-A37P9LK.huawei.com (10.67.109.17) by
 kwepemj100009.china.huawei.com (7.202.194.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 27 Nov 2025 19:21:09 +0800
From: Xie Yuanbin <xieyuanbin1@huawei.com>
To: <bigeasy@linutronix.de>, <viro@zeniv.linux.org.uk>,
	<linux@armlinux.org.uk>, <will@kernel.org>, <david.laight@runbox.com>,
	<rmk+kernel@armlinux.org.uk>
CC: <brauner@kernel.org>, <jack@suse.cz>, <nico@fluxnic.net>,
	<akpm@linux-foundation.org>, <hch@lst.de>, <jack@suse.com>,
	<wozizhi@huaweicloud.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mm@kvack.org>, <catalin.marinas@arm.com>, <rppt@kernel.org>,
	<vbabka@suse.cz>, <pfalcato@suse.de>, <lorenzo.stoakes@oracle.com>,
	<kuninori.morimoto.gx@renesas.com>, <tony@atomide.com>, <arnd@arndb.de>,
	<punitagrawal@gmail.com>, <rjw@rjwysocki.net>, <marc.zyngier@arm.com>,
	<lilinjie8@huawei.com>, <liaohua4@huawei.com>, <wangkefeng.wang@huawei.com>,
	<pangliyuan1@huawei.com>, Xie Yuanbin <xieyuanbin1@huawei.com>
Subject: Re: [RFC PATCH] vfs: Fix might sleep in load_unaligned_zeropad() with rcu read lock held
Date: Thu, 27 Nov 2025 19:20:35 +0800
Message-ID: <20251127112035.129014-1-xieyuanbin1@huawei.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251127072057.EbvhUyG4@linutronix.de>
References: <20251127072057.EbvhUyG4@linutronix.de>
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

On, Thu, 27 Nov 2025 08:20:57 +0100, Sebastian Andrzej Siewior wrote:
> This all should be covered by the series here
> 	https://lore.kernel.org/all/20251110145555.2555055-1-bigeasy@linutronix.de/

Yes, I know it.

> or do I miss something.

We had some discussions about this bug:
Link: https://lore.kernel.org/lkml/20251126090505.3057219-1-wozizhi@huaweicloud.com/

The discussions:
Link: https://lore.kernel.org/CAHk-=wh1Wfwt9OFB4AfBbjyeu4JVZuSWQ4A8OoT3W6x9btddfw@mail.gmail.com
Link: https://lore.kernel.org/20251126192640.GD3538@ZenIV
Link: https://lore.kernel.org/aSeNtFxD1WRjFaiR@shell.armlinux.org.uk

According to the discussion, in do_page_fault(), when addr >= TASK_SIZE,
we should not try to acquire the mm read lock or find vma. Instead, we
should directly call __do_kernel_fault() or __do_user_fault(). Your
submission just moved harden_branch_predictor() forward. I think we can
have more discussions about the patches to fix the missing spectre.

I am trying to write a new patch, I hope it will better handle these two
bugs and be compatible with PREEMPT_RT scenarios.

> Sebastian

Thanks!

Xie Yuanbin

