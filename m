Return-Path: <linux-fsdevel+bounces-70204-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 57692C937E1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 05:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3F23A342D42
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 04:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D12422D7B9;
	Sat, 29 Nov 2025 04:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="QnpmFAd6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF53E1A9F97;
	Sat, 29 Nov 2025 04:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764389317; cv=none; b=WIOZucNs3wBSmzg8bKWFWLa72wTmvq/ij/n8U8GmE1lfR9/bvZrNylgmNZBILgot75+Lbez7A3ZXvK0D9nX83jVPYkTs93Hpubk/XINwQute1KxoCTxDMIQfDY5OkKXh8a1hR/s2sU1gntUYXg8244bQWPtyIUmGbCG88/CIOBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764389317; c=relaxed/simple;
	bh=5iyUx1IOkeCL5QTv7DsEEsEbgAqPgybzfX50VeBJk/4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TAMUCs6g3guiKrO+IboFArL4k+JPUa9U9oBkzdWfbQNDWzhlNs2dqecjUXKFdk2xAD9DzZa9FvkOaWrXUgxaWbKBex0x/XNmhoJySP5FgKZ/j/RtualKC6FHylgu+2VGF49+YVpSmK22qVlA3wwVF9iJ7ZLEQu/HjfIxAroEXrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=QnpmFAd6; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=NoGgYCD49mxEcy5U/zXcoMvWiWdPjcqwWl6NwL9nQZM=;
	b=QnpmFAd6TlrubU6aXhvwZbdddGjGP4Ir8Af9ucYd6Zwz37RmBOpmDnZOmZTg4klJYnlqYdyFe
	fzGUlPqKZa3gf1KhWg22d0n8/OtAkZ4T2XC19qTBcxWe12ivLLL+jYD3wtzkhSVmuprFXGhUvWQ
	GxP75zEiFjRrAgZT3wq7nc0=
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4dJGnT2Ln5zLlTZ;
	Sat, 29 Nov 2025 12:06:37 +0800 (CST)
Received: from kwepemj100009.china.huawei.com (unknown [7.202.194.3])
	by mail.maildlp.com (Postfix) with ESMTPS id 950921A0191;
	Sat, 29 Nov 2025 12:08:26 +0800 (CST)
Received: from DESKTOP-A37P9LK.huawei.com (10.67.109.17) by
 kwepemj100009.china.huawei.com (7.202.194.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 29 Nov 2025 12:08:25 +0800
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
Date: Sat, 29 Nov 2025 12:08:17 +0800
Message-ID: <20251129040817.65356-1-xieyuanbin1@huawei.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <CAHk-=wjA20ear0hDOvUS7g5-A=YAUifphcf-iFJ1pach0=3ubw@mail.gmail.com>
References: <CAHk-=wjA20ear0hDOvUS7g5-A=YAUifphcf-iFJ1pach0=3ubw@mail.gmail.com>
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

On Fri, 28 Nov 2025 17:35:37 -0800, Linus Torvalds wrote:
> On Fri, 28 Nov 2025 at 17:01, Zizhi Wo <wozizhi@huaweicloud.com> wrote:
>> It has an additional check to determine reg:
>>
>> if (unlikely(addr > TASK_SIZE) && !user_mode(regs))
>>         goto no_context;
>>
>> I'd like to ask if this "regs" examination also needs to be brought
>> along?
>
> That seems unnecessary.
>
> Yes, in this case the original problem you reported with sleeping in
> an RCU region was triggered by a kernel access, and a user-space
> access would never have caused any such issues.
>
> So checking for !user_mode(regs) isn't exactly *wrong*.
>
> But while it isn't wrong, I think it's also kind of pointless.
>
> Because regardless of whether it's a kernel or user space access, an
> access outside TASK_SIZE shouldn't be associated with a valid user
> space context, so the code might as well just go to the "no_context"
> label directly.
>
> That said, somebody should  definitely double-check me - because I
> think arm also did the vdso trick at high addresses that i386 used to
> do, so there is the fake VDSO thing up there.
>
> But if you get a page fault on that, it's not going to be fixed up, so
> even if user space can access it, there's no point in looking that
> fake vm area up for page faults.

I think the `user_mode(regs)` check is necessary because the label
no_context actually jumps to __do_kernel_fault(), whereas page fault
from user mode should jump to `__do_user_fault()`.

Alternatively, we would need to change `goto no_context` to
`goto bad_area`. Or perhaps I misunderstood something, please point it out.

Thanks very much!

Xie Yuanbin

