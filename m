Return-Path: <linux-fsdevel+bounces-70955-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B21CABDAC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 08 Dec 2025 03:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 020273002142
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Dec 2025 02:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA4E2777EA;
	Mon,  8 Dec 2025 02:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="op1FV9mh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0932405E1;
	Mon,  8 Dec 2025 02:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765161188; cv=none; b=tytNHofTo5NIK++ODX9spBEdq5J/XzV3oGyMGlhi1DkrvVCtGVKDDSw82nQQA5bLuzp9v6S2D0Ra35A7DmyC8P/M2Vv8rLUkPmk3/fb35TpcGCEA06CKsXgho6QegGZUl6iPsIUY0oW8I092VYuf6V9KjlJEPzMF19wRfXm0ONQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765161188; c=relaxed/simple;
	bh=rfIrGm3s7KjAD+R2hAYjpGF3ZDOj3YyauZXGpzwpfj0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s3TWEJqDd1mbRB2RAir4+wFXuKx76mMYc+qOBx1pqA5sZ6YV3DGv7pJOO51ALjmLPtugUNkIHvq1Jf6nZsrfuQx9frPHl3whTXq1f9qeR8WBUWLKTXQUqSHGnpb6U3nTx4l23bGEdkqPrVR43El0APdsXGJzGAnQbLeG/IfvziM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=op1FV9mh; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=InKH1/gynvVQk7glFamhjKgZ5wYewPEcLp8Bz6n3g0E=;
	b=op1FV9mhWKOiJNfy0ymBe3cwCenJiplbd147oSBh5IvbJX0GynPf0KApsHSnlDjDq8hX/Jco6
	4r+TSLkKlwoZIAPybGNW6uIFwPJ4p07fGbN+wyjzLkBqqn+StRvmZ2zc4cH9EaPNq5XZx0VhhlS
	P3UREAHZNBweKmeyLGGkNFM=
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4dPmF14b2jz1cyPb;
	Mon,  8 Dec 2025 10:31:01 +0800 (CST)
Received: from kwepemj100009.china.huawei.com (unknown [7.202.194.3])
	by mail.maildlp.com (Postfix) with ESMTPS id 072BD1A0188;
	Mon,  8 Dec 2025 10:32:57 +0800 (CST)
Received: from DESKTOP-A37P9LK.huawei.com (10.67.109.17) by
 kwepemj100009.china.huawei.com (7.202.194.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 8 Dec 2025 10:32:56 +0800
From: Xie Yuanbin <xieyuanbin1@huawei.com>
To: <linux@armlinux.org.uk>
CC: <viro@zeniv.linux.org.uk>, <akpm@linux-foundation.org>,
	<brauner@kernel.org>, <catalin.marinas@arm.com>, <hch@lst.de>,
	<jack@suse.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <pangliyuan1@huawei.com>,
	<torvalds@linux-foundation.org>, <wangkefeng.wang@huawei.com>,
	<will@kernel.org>, <wozizhi@huaweicloud.com>, <xieyuanbin1@huawei.com>,
	<yangerkun@huawei.com>
Subject: Re: [Bug report] hash_name() may cross page boundary and trigger sleep in RCU context
Date: Mon, 8 Dec 2025 10:32:06 +0800
Message-ID: <20251208023206.44238-1-xieyuanbin1@huawei.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <aTLLLuup7TeAqFVL@shell.armlinux.org.uk>
References: <aTLLLuup7TeAqFVL@shell.armlinux.org.uk>
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

On Fri, 5 Dec 2025 12:08:14 +0000, Russell King wrote:
> On Wed, Dec 03, 2025 at 09:48:00AM +0800, Xie Yuanbin wrote:
>> On Tue, 2 Dec 2025 14:07:25 -0800, Linus Torvalds wrote:
>> > On Tue, 2 Dec 2025 at 04:43, Russell King (Oracle)
>> > <linux@armlinux.org.uk> wrote:
>> >>
>> >> What I'm thinking is to address both of these by handling kernel space
>> >> page faults (which will be permission or PTE-not-present) separately
>> >> (not even build tested):
>> >
>> > That patch looks sane to me.
>> >
>> > But I also didn't build test it, just scanned it visually ;)
>>
>> That patch removes harden_branch_predictor() from __do_user_fault(), and
>> moves it to do_page_fault()->do_kernel_address_page_fault().
>> This resolves previously mentioned kernel warning issue. However,
>> __do_user_fault() is not only called by do_page_fault(), it is
>> alse called by do_bad_area(), do_sect_fault() and do_translation_fault().
>>
>> So I think that some harden_branch_predictor() is missing on other paths.
>> According to my tests, when CONFIG_ARM_LPAE=n, harden_branch_predictor()
>> will never be called anymore, even if a user program trys to access the
>> kernel address.
>>
>> Or perhaps I've misunderstood something, could you please point it out?
>> Thank you very much.
>
> Right, let's split these issues into separate patches. Please test this
> patch, which should address only the hash_name() fault issue, and
> provides the basis for fixing the branch predictor issue.

I conducted a simple test, and it seems that both the hash_name()
might sleep issue and the branch predictor issue have been fixed.

BTW, even with this patch, test cases may still fail. There is another
bug in hash_name() will also be triggered by the testcase, which will be
fixed in this patch:
Link: https://lore.kernel.org/20251127025848.363992-1-pangliyuan1@huawei.com

Test case is from:
Link: https://lore.kernel.org/20251127140109.191657-1-xieyuanbin1@huawei.com

Test in commit 6987d58a9cbc5bd57c98 ("Add linux-next specific files for
20251205") from linux-next branch.

I still have a question about this patch: Is 
```patch
+		if (interrupts_enabled(regs))
+			local_irq_enable();
```
necessary? Although this implementation is closer to the original code,
which can reduce side effects, do_bad_area(), do_sect_fault(),
and do_translation_fault() all call __do_kernel_fault() with interrupts
disabled.

Thanks very much!

