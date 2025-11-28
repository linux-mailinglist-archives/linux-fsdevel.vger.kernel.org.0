Return-Path: <linux-fsdevel+bounces-70096-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 073F5C90836
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 02:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19E7F3AB5F6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 01:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A2924E4C3;
	Fri, 28 Nov 2025 01:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="VuQi7oK1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF14F24677F;
	Fri, 28 Nov 2025 01:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764294088; cv=none; b=W6nsRIVBqoTURDDnRCH53ahovIRhqRHSaRHOm+hBnVVD9jmQtKOj9WrLHkEmkf76RAZK+FM6Gw6p2HFI5smY0wWEQNv+TUlUmH9WMcyXYN8PHA1bpT5dOGQw14usqA0D6EgdDOEv66rxIXYK2V1DRIbS1DhQ5xLSo54u2BeH5yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764294088; c=relaxed/simple;
	bh=JKgBquWmJz9cdJEPQY+0wdkze3wHqtrcKUOiUNM0fqo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gylyx1JCPggXvYTWy10RSXUbTY/k/hdnDEL2kB1TqGUJn67FGZosxpsK8JdEdVJh5EuJ9OSj9BWSBjXTvnVzBB8lkZugOrVnurdrSe/zNPakVe9uTHovHD7QM6hgu1Tasn0aTepLw2D5KrHL+xzFrPJbP/oGW7egBYJ2wh95Qkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=VuQi7oK1; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=In5Ymo73nmHkrOlmrEIqIHf+K2Funf1kBVHFkcyRhAI=;
	b=VuQi7oK10MFLxjtp0Nt9p8KnjFRw3EKbb3nAypChtdHZ0Eb9wiY6zpsaHTUrZ0nlAs7ltkXw2
	xB2mlmV6Nx6ocAZNWJXvl6gesQs+AsWLpVSxLHN9nAjH2wIzhi3eE09l+OtettYcZ8bzrFnI4jR
	g4OGgo8RVawvK0gG7bh4gag=
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4dHbYr66WxzpStw;
	Fri, 28 Nov 2025 09:39:12 +0800 (CST)
Received: from kwepemj100009.china.huawei.com (unknown [7.202.194.3])
	by mail.maildlp.com (Postfix) with ESMTPS id 0165B1804F2;
	Fri, 28 Nov 2025 09:41:23 +0800 (CST)
Received: from DESKTOP-A37P9LK.huawei.com (10.67.109.17) by
 kwepemj100009.china.huawei.com (7.202.194.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 28 Nov 2025 09:41:21 +0800
From: Xie Yuanbin <xieyuanbin1@huawei.com>
To: <viro@zeniv.linux.org.uk>, <linux@armlinux.org.uk>, <will@kernel.org>,
	<david.laight@runbox.com>, <rmk+kernel@armlinux.org.uk>
CC: <bigeasy@linutronix.de>, <brauner@kernel.org>, <jack@suse.cz>,
	<nico@fluxnic.net>, <akpm@linux-foundation.org>, <hch@lst.de>,
	<jack@suse.com>, <wozizhi@huaweicloud.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mm@kvack.org>, <catalin.marinas@arm.com>, <rppt@kernel.org>,
	<vbabka@suse.cz>, <pfalcato@suse.de>, <lorenzo.stoakes@oracle.com>,
	<kuninori.morimoto.gx@renesas.com>, <tony@atomide.com>, <arnd@arndb.de>,
	<punitagrawal@gmail.com>, <rjw@rjwysocki.net>, <marc.zyngier@arm.com>,
	<lilinjie8@huawei.com>, <liaohua4@huawei.com>, <wangkefeng.wang@huawei.com>,
	<pangliyuan1@huawei.com>, Xie Yuanbin <xieyuanbin1@huawei.com>
Subject: Re: [RFC PATCH] vfs: Fix might sleep in load_unaligned_zeropad() with rcu read lock held
Date: Fri, 28 Nov 2025 09:39:35 +0800
Message-ID: <20251128013935.3539-1-xieyuanbin1@huawei.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251126192640.GD3538@ZenIV>
References: <20251126192640.GD3538@ZenIV>
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

On Wed, 26 Nov 2025 19:26:40 +0000, Al Viro wrote:
> For quick and dirty variant (on current tree), how about
> adding
> 	if (unlikely(addr > TASK_SIZE) && !user_mode(regs))
> 		goto no_context;
>
> right after
>
> 	if (!ttbr0_usermode_access_allowed(regs))
> 		goto no_context;
>
> in do_page_fault() there?
>
> NOTE: that might or might not break vdso; I don't think it would, but...

On Wed, 26 Nov 2025 23:31:00 +0000, Russell King wrote:
> Now, for 32-bit ARM, I think I am coming to the conclusion that Al's
> suggestion is probably the easiest solution. However, whether it has
> side effects, I couldn't say - the 32-bit ARM fault code has been
> modified by quite a few people in ways I don't yet understand, so I
> can't be certain at the moment whether it would cause problems.
>
> I think the only thing to do is to try the solution and see what
> breaks. I'm not in a position to be able to do that as, having not
> had reason to touch 32-bit ARM for years, I don't have a hackable
> platform nearby. Maybe Xie Yuanbin can test it?

Hi, Al Viro and Russell King!

I moved the judgment forward to before local_irq_enable() and submitted
a new patch:
Link: https://lore.kernel.org/20251127140109.191657-1-xieyuanbin1@huawei.com

This is because there's another bug I reported before that also requires
a similar judgment, but before the interrupt is enabled.
Link: https://lore.kernel.org/20250925025744.6807-1-xieyuanbin1@huawei.com

I hope this can fix both of these bugs.

It is closer to the x86's implementation and works well in current tests.
Could you please take a look? Thanks you very much!

Xie Yuanbin

