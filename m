Return-Path: <linux-fsdevel+bounces-70972-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4B5CAD3AE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 08 Dec 2025 14:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82E0A30698DC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Dec 2025 13:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD382F9DB0;
	Mon,  8 Dec 2025 13:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="n7TqFqQ9";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="n7TqFqQ9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB323148AA;
	Mon,  8 Dec 2025 13:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765199977; cv=none; b=mnGOLCyHN3j1cC+rZ2S9+xnizO7EM7P/wvCXTZ6usA+mcR85uXCM0OwPGK3wwNZYzw4H/Vv95mw6GscN7fiPD3xOIVPUx/LtcGlZuT2LtgbSKsHKG9FP/EfWT0qjsA4/hv6PMVsVoGl8Q0vW0cBL5ZilO4QPkRHd7Gx79yNH3Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765199977; c=relaxed/simple;
	bh=ysrxwg/xE7lnFNGohOCmC7V8F5GKgROP0io5QDz/Zq0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cIc9AlP5hjs6gA0sCZn+5PPpX9X1q2lLoyVrDTfKC1rOb3XgV562TlkAqtrla2T5kWIs6pKvvzhQyhRKjPXHGq/iunjHPafynswLkjOJzLO58GZW+bejbZlMmFro+mykwrtjNp8cu+BeJd3hxaj8jaIdFciKgfV69x2e3P1YDmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=n7TqFqQ9; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=n7TqFqQ9; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ysrxwg/xE7lnFNGohOCmC7V8F5GKgROP0io5QDz/Zq0=;
	b=n7TqFqQ9HTOt/u0LYnDQ4xGo+E13YxUv9GwtCrD38j0HVMGcYV38Luu01lOwQVG9NtKS53ntG
	STyMq76qqXq6/3MxzS2v99EqMwtmzBwtl5kAQmEHZOyQ3P72eNiW9+a6LrJw9ko6M0h3eHM+Zu6
	kL1nXtXwR3olt0dg2KfyNjU=
Received: from canpmsgout05.his.huawei.com (unknown [172.19.92.145])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4dQ2d62wx1z1BG9g;
	Mon,  8 Dec 2025 21:19:22 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ysrxwg/xE7lnFNGohOCmC7V8F5GKgROP0io5QDz/Zq0=;
	b=n7TqFqQ9HTOt/u0LYnDQ4xGo+E13YxUv9GwtCrD38j0HVMGcYV38Luu01lOwQVG9NtKS53ntG
	STyMq76qqXq6/3MxzS2v99EqMwtmzBwtl5kAQmEHZOyQ3P72eNiW9+a6LrJw9ko6M0h3eHM+Zu6
	kL1nXtXwR3olt0dg2KfyNjU=
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4dQ2ZM3grbz12LK7;
	Mon,  8 Dec 2025 21:16:59 +0800 (CST)
Received: from kwepemj100009.china.huawei.com (unknown [7.202.194.3])
	by mail.maildlp.com (Postfix) with ESMTPS id 4EE9C18046F;
	Mon,  8 Dec 2025 21:19:18 +0800 (CST)
Received: from DESKTOP-A37P9LK.huawei.com (10.67.109.17) by
 kwepemj100009.china.huawei.com (7.202.194.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 8 Dec 2025 21:19:17 +0800
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
Date: Mon, 8 Dec 2025 21:18:42 +0800
Message-ID: <20251208131842.76909-1-xieyuanbin1@huawei.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <aTajXdAVYh9qJI6B@shell.armlinux.org.uk>
References: <aTajXdAVYh9qJI6B@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemj100009.china.huawei.com (7.202.194.3)

On Mon, 8 Dec 2025 10:07:25 +0000, Russell King wrote:
> This isn't entirely fixed. A data abort for an alignment fault (thus
> calling do_alignment()) will enable interrupts, and then may call
> do_bad_area(). We can't short-circuit this path like we can with
> do_page_fault() as alignment faults from userspace can be valid for
> the vectors page - not that we should see them, but that doesn't mean
> that there isn't something in userspace that does.

I had indeed been lacking in consideration regarding do_alignment()
before, so thank you for reply. But, may I ask that, is there a scenario
where user-mode access to kernel addresses causes an alignment fault
(do_alignment())?

In your last email, you described it as follows:
On Fri, 5 Dec 2025 12:08:14 +0000, Russell King wrote:
> Also tested usermode access to kernel space
> which fails with SEGV:
> - read from 0xc0000000 (section permission fault, do_sect_fault)
> - read from 0xffff2000 (page translation fault, do_page_fault)
> - read from 0xffff0000 (vectors page - read possible as expected)
> - write to 0xffff0000 (page permission fault, do_page_fault)

There seems to be no do_alignment()?

In other words, is there a way to construct a user-mode testcase which
accesses a kernel address and triggers do_alignment()?

> That patch got missed - I'm notoriously bad at catching every email.
> There's just way too much email coming in.

No need to worry.

> It's to keep the behaviour closer to the original as possible, on the
> principle of avoiding unnecessary behavioural changes to the code. As
> noted above, do_bad_area() can be called with interrupts enabled.
>
> Whether RT folk would be happy removing that is a different question,
> given that they want as much of the kernel to be preemptable.

Thank you for your reply. I have no objections to this, although it might
introduce some unnecessary code paths, at least it won't bring any new
issues.

