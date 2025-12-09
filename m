Return-Path: <linux-fsdevel+bounces-70998-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9862CAEA10
	for <lists+linux-fsdevel@lfdr.de>; Tue, 09 Dec 2025 02:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00D14301C3D2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Dec 2025 01:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969862DF144;
	Tue,  9 Dec 2025 01:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="S0Onu6kY";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="S0Onu6kY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633352D738F;
	Tue,  9 Dec 2025 01:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765243839; cv=none; b=X3NtT7ul1pwDsORWKx8eqd+Il/5wMgPeKir5AINOp3ICzj8q3awUHpiP571LUHTjZADiDMp9H+Y0EP627KxAIdlgUzn8VaLiAEvRDR9bJPCePrnAUilyAFE9U2BDcM39eI1ToaKIwW+3/8ln/bfmxMB1nIpVSvUjQYeA9Pae7EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765243839; c=relaxed/simple;
	bh=EaN56bNHDdaDU4xaAsWBhkgyh1tI7ov9fWzaVcBUtA8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kfRaZNS4xoXxRgi7kitVqKFP1jbthvBRDQfAEdSrQhWFQ3nipYhAOZPEqo+22RUGHhvvdn+/l9cYuWpyqXkikHd6gyuPn2NBCGrdNb6PxgcQ23UMWu/krr5RWqhVtaZ7udcx3I5mbj4l7DTjaYA9NAdA6xg7W9rpS/yRKZV7iOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=S0Onu6kY; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=S0Onu6kY; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=EaN56bNHDdaDU4xaAsWBhkgyh1tI7ov9fWzaVcBUtA8=;
	b=S0Onu6kYl9D8cUbpZTYsCtWPafYB7opD91x91GJEgAsQozI1jQu1RjI3r+YUxODEgOrBO16G4
	4rudE/tl/ISBlGPl73FxPE7obeVr4McmRTQApR9kNXgBFAfoNDCG51gTbJjvPO6iIYhfcJjKNJ/
	i74oJ0pNGViS2Nr3mDxm6bI=
Received: from canpmsgout01.his.huawei.com (unknown [172.19.92.178])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4dQLrf0nkvz1BG9d;
	Tue,  9 Dec 2025 09:30:26 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=EaN56bNHDdaDU4xaAsWBhkgyh1tI7ov9fWzaVcBUtA8=;
	b=S0Onu6kYl9D8cUbpZTYsCtWPafYB7opD91x91GJEgAsQozI1jQu1RjI3r+YUxODEgOrBO16G4
	4rudE/tl/ISBlGPl73FxPE7obeVr4McmRTQApR9kNXgBFAfoNDCG51gTbJjvPO6iIYhfcJjKNJ/
	i74oJ0pNGViS2Nr3mDxm6bI=
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4dQLpK2wChz1T4GD;
	Tue,  9 Dec 2025 09:28:25 +0800 (CST)
Received: from kwepemj100009.china.huawei.com (unknown [7.202.194.3])
	by mail.maildlp.com (Postfix) with ESMTPS id D0A49180BD8;
	Tue,  9 Dec 2025 09:30:25 +0800 (CST)
Received: from DESKTOP-A37P9LK.china.huawei.com (10.67.109.17) by
 kwepemj100009.china.huawei.com (7.202.194.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 9 Dec 2025 09:30:24 +0800
From: Xie Yuanbin <xieyuanbin1@huawei.com>
To: <linux@armlinux.org.uk>
CC: <akpm@linux-foundation.org>, <brauner@kernel.org>,
	<catalin.marinas@arm.com>, <hch@lst.de>, <jack@suse.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<pangliyuan1@huawei.com>, <torvalds@linux-foundation.org>,
	<viro@zeniv.linux.org.uk>, <wangkefeng.wang@huawei.com>, <will@kernel.org>,
	<wozizhi@huaweicloud.com>, <xieyuanbin1@huawei.com>, <yangerkun@huawei.com>
Subject: Re: [Bug report] hash_name() may cross page boundary and trigger sleep in RCU context
Date: Tue, 9 Dec 2025 09:30:21 +0800
Message-ID: <20251209013021.2537-1-xieyuanbin1@huawei.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <aTbyPNINxjzU3Lua@shell.armlinux.org.uk>
References: <aTbyPNINxjzU3Lua@shell.armlinux.org.uk>
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

On Mon, 8 Dec 2025 15:43:56 +0000, Russell King wrote:
> On Mon, Dec 08, 2025 at 09:18:42PM +0800, Xie Yuanbin wrote:
>> I had indeed been lacking in consideration regarding do_alignment()
>> before, so thank you for reply. But, may I ask that, is there a scenario
>> where user-mode access to kernel addresses causes an alignment fault
>> (do_alignment())?
>
> If you mean, won't permission errors be detected first, then no.
> Alignment is one of the first things that is checked if alignment
> faults are enabled.
>
> So yes, if userspace attempts an unaigned load of a kernel address,
> and the CPU does not support / have enabled unaigned load support,
> then we will get a data abort with the FSR indicating an alignment
> fault. So do_alignment() wil be entered.
>
> Whether branch predictor handling needs to happen in this path is
> a separate question, but as it's highly likely we'll take an
> exception anyway and userspace is doing Bad Stuff, I feel it's
> better to be over-cautious.

Thanks for your reply. I know it now, and thank you.

