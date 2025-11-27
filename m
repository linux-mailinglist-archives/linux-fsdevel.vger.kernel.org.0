Return-Path: <linux-fsdevel+bounces-69958-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A88D5C8CB72
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 04:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4FFCD34F3C0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 03:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6A429D288;
	Thu, 27 Nov 2025 03:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="RFgcpNci"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF061FF1AD;
	Thu, 27 Nov 2025 03:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764212616; cv=none; b=HCGIcoJh26xV5KBS7o4Ek2SWJUX+2em6FKjB3vB/JbN7u+poRN9D3i3yB201PVwka46OSQG3AT5yDAGrOvqkrYg2CLgTbiiKn9+t3XGV7Z0omFo+tqzuvNWTr/fFu2/CXSEWlV1rg3ga9u2e3DARnOYjFIVt5/Om42DSjp3wDuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764212616; c=relaxed/simple;
	bh=Gp3jnDYUpRwbCSsmSuWVj27ODVCkdA8HNi1M+mu+7bU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W1uGgnGc80+dBxhO3dPRP7Mdyh8hCCqtsp2Acn3XCgFG75BnquIOdWiU2hqpa1yMaPpvVtVQgzI6VonDzdTpEXnXDSi9f1p8IjT3UFY94Yd/z8M0dC4OBA5kW+eipfyJMV+hGBUzlgk9af2GrZhauUFoTTcQJcZKlaqCSt8Js1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=RFgcpNci; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=/LZy+TydcqSmvcD0OxLxJaigZpJM+j3ByE+efESnjLA=;
	b=RFgcpNciTsUxTzW0FEuArat0oaFMJJ2ugPWHX2RcAh+P3gVPQqGvig+Pft78Z9ZRMCBbBALKf
	V9yv1Ur4Pry9lkqkiELK28rV3mOVmIfVuZK7uDYZmC/dZYQhNILrGHIyk/KOkMMDi7K9bqeRIhq
	FZJJ4NJqQB4A9/pEEKeUV6o=
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4dH1RV6VBszmV7N;
	Thu, 27 Nov 2025 11:01:42 +0800 (CST)
Received: from kwepemj100009.china.huawei.com (unknown [7.202.194.3])
	by mail.maildlp.com (Postfix) with ESMTPS id 719521402C4;
	Thu, 27 Nov 2025 11:03:31 +0800 (CST)
Received: from DESKTOP-A37P9LK.huawei.com (10.67.109.17) by
 kwepemj100009.china.huawei.com (7.202.194.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 27 Nov 2025 11:03:30 +0800
From: Xie Yuanbin <xieyuanbin1@huawei.com>
To: <viro@zeniv.linux.org.uk>, <linux@armlinux.org.uk>, <will@kernel.org>,
	<david.laight@runbox.com>, <rmk+kernel@armlinux.org.uk>
CC: <brauner@kernel.org>, <jack@suse.cz>, <nico@fluxnic.net>,
	<akpm@linux-foundation.org>, <hch@lst.de>, <jack@suse.com>,
	<wozizhi@huaweicloud.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mm@kvack.org>, <catalin.marinas@arm.com>, <rppt@kernel.org>,
	<vbabka@suse.cz>, <pfalcato@suse.de>, <lorenzo.stoakes@oracle.com>,
	<kuninori.morimoto.gx@renesas.com>, <tony@atomide.com>, <arnd@arndb.de>,
	<bigeasy@linutronix.de>, <punitagrawal@gmail.com>, <rjw@rjwysocki.net>,
	<marc.zyngier@arm.com>, <lilinjie8@huawei.com>, <liaohua4@huawei.com>,
	<wangkefeng.wang@huawei.com>, <pangliyuan1@huawei.com>, Xie Yuanbin
	<xieyuanbin1@huawei.com>
Subject: [RFC PATCH] vfs: Fix might sleep in load_unaligned_zeropad() with rcu read lock held
Date: Thu, 27 Nov 2025 11:03:16 +0800
Message-ID: <20251127030316.8396-1-xieyuanbin1@huawei.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <aSeNtFxD1WRjFaiR@shell.armlinux.org.uk>
References: <aSeNtFxD1WRjFaiR@shell.armlinux.org.uk>
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

On, Wed, 26 Nov 2025 19:26:40 +0000, Al Viro wrote:
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

On, Wed, 26 Nov 2025 23:31:00 +0000, Russell King (Oracle) wrote:
> Now, for 32-bit ARM, I think I am coming to the conclusion that Al's
> suggestion is probably the easiest solution. However, whether it has
> side effects, I couldn't say - the 32-bit ARM fault code has been
> modified by quite a few people in ways I don't yet understand, so I
> can't be certain at the moment whether it would cause problems.

I think I've already submitted a very similar patch, to fix another bug:
On Thu, 16 Oct 2025 20:16:21 +0800, Xie Yuanbin wrote:
> +#ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
> +	if (unlikely(addr > TASK_SIZE) && user_mode(regs)) {
> +		fault = 0;
> +		code = SEGV_MAPERR;
> +		goto bad_area;
> +	}
> +#endif
Link: https://lore.kernel.org/20250925025744.6807-1-xieyuanbin1@huawei.com

However, the patch seems to have received no response for a very long
time.

On Wed, 26 Nov 2025 23:31:00 +0000, Russell King wrote:
> I think the only thing to do is to try the solution and see what
> breaks. I'm not in a position to be able to do that as, having not
> had reason to touch 32-bit ARM for years, I don't have a hackable
> platform nearby. Maybe Xie Yuanbin can test it?

With pleasure.
By the way, for the config and test case shown in this patch:
vfs: Fix might sleep in load_unaligned_zeropad() with rcu read lock held
Link: https://lore.kernel.org/20251126101952.174467-1-xieyuanbin1@huawei.com
the warning can be reproduced directly on QEMU.

Xie Yuanbin

