Return-Path: <linux-fsdevel+bounces-69871-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B91AC894AD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 11:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 829DB3B7722
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 10:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353763019A4;
	Wed, 26 Nov 2025 10:27:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A410D2ECD37;
	Wed, 26 Nov 2025 10:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764152846; cv=none; b=ugxTJ0TdtURyyajrW19uIySBgWm1Y4TcsdG7xsPx8u9NGuY9LkSS4B18MT3NDyJ2M4hYmUQdiFWkRNZ2fi7JkKK788BZpTGDdYBYt0hSUpXtJ343HniItU8hwHhu32zmesSWLCbQavUKIiE9+xYX7tdgKG492CLPCarYGfMr2Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764152846; c=relaxed/simple;
	bh=xfErhco79GzB4NTozpKTS/+ugoUVeWXzOM3nID2vMjM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZZJRFiw+lQumEV/zxBpzH23GJHGu+03m38A1dV1PCzvdelFYC49QyFgJsMzWNref4+gULl99J9e4fyu+JUQWmtK58bL4rv7AWXhBI3nqcoHoCLle/8Qt+m3tyWxLSa2aHtdNMtijRuKO6neCYjTDR4osgLKLYlHVHJSbEbRnKSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dGbM85jvHzYQvB8;
	Wed, 26 Nov 2025 18:26:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 846F51A07BB;
	Wed, 26 Nov 2025 18:27:20 +0800 (CST)
Received: from [10.174.176.88] (unknown [10.174.176.88])
	by APP1 (Coremail) with SMTP id cCh0CgC3PkgH1iZpi0Q3CA--.23367S3;
	Wed, 26 Nov 2025 18:27:20 +0800 (CST)
Message-ID: <33ab4aef-020e-49e7-8539-31bf78dac61a@huaweicloud.com>
Date: Wed, 26 Nov 2025 18:27:19 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Zizhi Wo <wozizhi@huaweicloud.com>
Subject: Re: [Bug report] hash_name() may cross page boundary and trigger
 sleep in RCU context
To: Zizhi Wo <wozizhi@huaweicloud.com>, jack@suse.com, brauner@kernel.org,
 hch@lst.de, akpm@linux-foundation.org, linux@armlinux.org.uk,
 torvalds@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
 yangerkun@huawei.com, wangkefeng.wang@huawei.com, pangliyuan1@huawei.com,
 xieyuanbin1@huawei.com
References: <20251126090505.3057219-1-wozizhi@huaweicloud.com>
In-Reply-To: <20251126090505.3057219-1-wozizhi@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgC3PkgH1iZpi0Q3CA--.23367S3
X-Coremail-Antispam: 1UD129KBjvJXoWxArWDWFyxKr45XryxGr43GFg_yoW5XFW5pr
	4rCryYkrsxZry5Aw109a9IgFy5Jw4UGr43GrnagryUuw45WF12vF4UKry09F9xW3WDWayx
	Wr1qgwn7uas0gFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUL0edUUUUU=
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/



在 2025/11/26 17:05, Zizhi Wo 写道:
> We're running into the following issue on an ARM32 platform with the linux
> 5.10 kernel:
> 
> [<c0300b78>] (__dabt_svc) from [<c0529cb8>] (link_path_walk.part.7+0x108/0x45c)
> [<c0529cb8>] (link_path_walk.part.7) from [<c052a948>] (path_openat+0xc4/0x10ec)
> [<c052a948>] (path_openat) from [<c052cf90>] (do_filp_open+0x9c/0x114)
> [<c052cf90>] (do_filp_open) from [<c0511e4c>] (do_sys_openat2+0x418/0x528)
> [<c0511e4c>] (do_sys_openat2) from [<c0513d98>] (do_sys_open+0x88/0xe4)
> [<c0513d98>] (do_sys_open) from [<c03000c0>] (ret_fast_syscall+0x0/0x58)
> ...
> [<c0315e34>] (unwind_backtrace) from [<c030f2b0>] (show_stack+0x20/0x24)
> [<c030f2b0>] (show_stack) from [<c14239f4>] (dump_stack+0xd8/0xf8)
> [<c14239f4>] (dump_stack) from [<c038d188>] (___might_sleep+0x19c/0x1e4)
> [<c038d188>] (___might_sleep) from [<c031b6fc>] (do_page_fault+0x2f8/0x51c)
> [<c031b6fc>] (do_page_fault) from [<c031bb44>] (do_DataAbort+0x90/0x118)
> [<c031bb44>] (do_DataAbort) from [<c0300b78>] (__dabt_svc+0x58/0x80)
> ...
> 
> During the execution of hash_name()->load_unaligned_zeropad(), a potential
> memory access beyond the PAGE boundary may occur. For example, when the
> filename length is near the PAGE_SIZE boundary. This triggers a page fault,
> which leads to a call to do_page_fault()->mmap_read_trylock(). If we can't
> acquire the lock, we have to fall back to the mmap_read_lock() path, which
> calls might_sleep(). This breaks RCU semantics because path lookup occurs
> under an RCU read-side critical section. In linux-mainline, arm/arm64
> do_page_fault() still has this problem:
> 
> lock_mm_and_find_vma->get_mmap_lock_carefully->mmap_read_lock_killable.
> 
> And before commit bfcfaa77bdf0 ("vfs: use 'unsigned long' accesses for
> dcache name comparison and hashing"), hash_name accessed the name byte by
> byte.
> 
> To prevent load_unaligned_zeropad() from accessing beyond the valid memory
> region, we would need to intercept such cases beforehand? But doing so
> would require replicating the internal logic of load_unaligned_zeropad(),
> including handling endianness and constructing the correct value manually.
> Given that load_unaligned_zeropad() is used in many places across the
> kernel, we currently haven't found a good solution to address this cleanly.
> 
> What would be the recommended way to handle this situation? Would
> appreciate any feedback and guidance from the community. Thanks!
> 

As a detail, we enabled CONFIG_DEBUG_PREEMPT and CONFIG_KFENCE, which
allowed us to catch the potential out-of-bounds access.

Thanks,
Zizhi Wo


