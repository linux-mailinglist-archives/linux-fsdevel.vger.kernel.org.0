Return-Path: <linux-fsdevel+bounces-70199-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F3004C9368F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 03:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0DAA04E1C38
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 02:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4C91DF963;
	Sat, 29 Nov 2025 02:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="rDScHZVC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1E61A01C6;
	Sat, 29 Nov 2025 02:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764382706; cv=none; b=ecLlx+0/kgvGa5S4HpO6OxPhiIvIA9twKUX44E2gkNlSXAV6jwVpqRLq1pv5qwNSTcITZQEkMlWJFjZrX4jHOQM53+DGrP0Oxp3NXMhMKAUsq9p4WKpBnnuuIg5r+qb7KMyN4qYfjE2uBjssgtQwZ8o87KTRQjRHbs9oach/nhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764382706; c=relaxed/simple;
	bh=kn01DPqEWVsRKnyDlfL02PwCBxz8cu2USXRLYTQgCgM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lycPWUg26d3sbzfwgMJ/Z8t0qwL4D/V3Pa311wibQ4UkpepTEwlNnRir8eZrD6YrHiDB+9EC5uk90QFMGLPQ7smayPdhVkKRf7e2Z2d5yPlqGHMhfWdu9OzQ3PHX1Yogckf89wPkCE3Ouo71JJHjrpl6JPFIva/ZbWd+/Fl3wDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=rDScHZVC; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=kn01DPqEWVsRKnyDlfL02PwCBxz8cu2USXRLYTQgCgM=;
	b=rDScHZVCx+yxOePYn8Wcv7pT5EneAyhEXpKgyfyNlZdFO+SZjIfif2JCM3YYpKX2AogeDsnam
	/17hK+QDSVVTcvAMpeNH1ZD5mzB3UTmEMrJEwauBJgQWVmdxVILASAgXYxRyzaIgfUZb+JMrv57
	oTVqNBOiz4Z5xvjvvJvwaQw=
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4dJDLT42p1z1T4Fk;
	Sat, 29 Nov 2025 10:16:33 +0800 (CST)
Received: from kwepemj100009.china.huawei.com (unknown [7.202.194.3])
	by mail.maildlp.com (Postfix) with ESMTPS id 18451180B58;
	Sat, 29 Nov 2025 10:18:20 +0800 (CST)
Received: from DESKTOP-A37P9LK.huawei.com (10.67.109.17) by
 kwepemj100009.china.huawei.com (7.202.194.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 29 Nov 2025 10:18:19 +0800
From: Xie Yuanbin <xieyuanbin1@huawei.com>
To: <torvalds@linux-foundation.org>, <will@kernel.org>,
	<linux@armlinux.org.uk>, <viro@zeniv.linux.org.uk>, <bigeasy@linutronix.de>,
	<rmk+kernel@armlinux.org.uk>
CC: <akpm@linux-foundation.org>, <brauner@kernel.org>,
	<catalin.marinas@arm.com>, <hch@lst.de>, <jack@suse.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<pangliyuan1@huawei.com>, <wangkefeng.wang@huawei.com>,
	<wozizhi@huaweicloud.com>, <xieyuanbin1@huawei.com>, <yangerkun@huawei.com>,
	<lilinjie8@huawei.com>, <liaohua4@huawei.com>
Subject: Re: [Bug report] hash_name() may cross page boundary and trigger
Date: Sat, 29 Nov 2025 10:18:15 +0800
Message-ID: <20251129021815.9679-1-xieyuanbin1@huawei.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <CAHk-=wh+cFLLi2x6u61pvL07phSyHPVBTo9Lac2uuqK4eRG_=w@mail.gmail.com>
References: <CAHk-=wh+cFLLi2x6u61pvL07phSyHPVBTo9Lac2uuqK4eRG_=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemj100009.china.huawei.com (7.202.194.3)

Hi, Linus Torvalds and Will Deacon!

We have some discussion and solutions on other threads, and it seems
that there are somthing missing on this discussion thread. Therefore,
I think it is necessary to synchronize some information here.

1. There is a test case that can consistently reproduce the bug, which
might be helpful for us to do the test. The test case is located after
the '---' maker line in the following patch:
Link: https://lore.kernel.org/20251126101952.174467-1-xieyuanbin1@huawei.com

2. Al Viro give a suggest on 2025-11-26 19:26:
Link: https://lore.kernel.org/20251126192640.GD3538@ZenIV

This patch is similar to one I submitted long time ago, which was
intended fix another bug: missing branch predictor mitigation:
Link: https://lore.kernel.org/20250925025744.6807-1-xieyuanbin1@huawei.com

My patch was not accepted, Sebastian's patch:
Link: https://lore.kernel.org/20251110145555.2555055-2-bigeasy@linutronix.de
fixed this bug, but Sebastian's patch has not yet been merged into the
linux-next branch, so this bug still exists in the current linux-next
branch.

I hope there is a simple solution to fix both bugs, so I submitted this
patch on 2025-11-27 14:49:
Link: https://lore.kernel.org/20251127140109.191657-1-xieyuanbin1@huawei.com
This patch is based on the linux-next branch, therefore it does not
contain Sebastian's patch.

3. On 2025-11-28 17:06, Linus Torvalds provided a solution similar to
Al Viro's suggestion and my patch:
Link: https://lore.kernel.org/CAHk-=wh+cFLLi2x6u61pvL07phSyHPVBTo9Lac2uuqK4eRG_=w@mail.gmail.com

Currently, all solutions have been tested that can fix this one bug.
I still hold the view that perhaps there is a simpler way to fix another
bug at the same time, because the solutions of these two bugs are very
similar.

Thanks very much!

Xie Yuanbin

