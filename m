Return-Path: <linux-fsdevel+bounces-70285-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E35C958ED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 03:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 16C0E4E0EE9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 02:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F151A23A4;
	Mon,  1 Dec 2025 02:03:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4541719C54F;
	Mon,  1 Dec 2025 02:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764554620; cv=none; b=gcrw3F4sxBuEg7KONhMSZaIVJ2X2PQ4hexWtrYsU8U/Me1zLdNa9ebjTMe1DpbO6vUAEqxNWDkGtJykyXLW5wWPaaDFMLyF1f3zmNLJ+X3tG+qa5k5xKvftT49ZT3GQPpxMNeh4tF517CfgktW9L6dWTJZdmU/2QBMi+BB2hOwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764554620; c=relaxed/simple;
	bh=QHq6546lCp/PCMRxTR0J/QCaBv5K0swyQVVX//7YN3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JRRNX//XtimWhsHQshFCOd9O9oK6+V0VvU3zouKvr34NDJu+ui0KRk/rZw25ZySt6GI/sB+ImSZp1SMsmp+YU0fBRiqMDV4frvkQ+fVJIV84iyJ9lvmnjDwqPaN4ztPOmM/TF62znfrzEDN8q+PF1VVIzSx2PbmEbW2W30sHhF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dKRxb1zLKzKHMKL;
	Mon,  1 Dec 2025 10:02:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id E856E1A0B02;
	Mon,  1 Dec 2025 10:03:28 +0800 (CST)
Received: from [10.174.176.88] (unknown [10.174.176.88])
	by APP2 (Coremail) with SMTP id Syh0CgAnCFJu9yxpwNe4AA--.50055S3;
	Mon, 01 Dec 2025 10:03:28 +0800 (CST)
Message-ID: <60238f31-d896-466b-b53f-604846738fa2@huaweicloud.com>
Date: Mon, 1 Dec 2025 10:03:26 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug report] hash_name() may cross page boundary and trigger
 sleep in RCU context
To: Al Viro <viro@zeniv.linux.org.uk>, Zizhi Wo <wozizhi@huaweicloud.com>
Cc: torvalds@linux-foundation.org, jack@suse.com, brauner@kernel.org,
 hch@lst.de, akpm@linux-foundation.org, linux@armlinux.org.uk,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
 yangerkun@huawei.com, wangkefeng.wang@huawei.com, pangliyuan1@huawei.com,
 xieyuanbin1@huawei.com
References: <20251126090505.3057219-1-wozizhi@huaweicloud.com>
 <20251126185545.GC3538@ZenIV>
 <c375dd22-8b46-404b-b0c2-815dbd4c5ec8@huaweicloud.com>
 <20251129033728.GH3538@ZenIV>
From: Zizhi Wo <wozizhi@huaweicloud.com>
In-Reply-To: <20251129033728.GH3538@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgAnCFJu9yxpwNe4AA--.50055S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uFykXr4fZr1rGry7Zr1xAFb_yoW8trWUpF
	15Wr17Krs5Gr1xC3Z7Xa129FyrC3s7Jr4rGw1a9asavw1Ygr43WF4YyF43uF129rZYya10
	vr4FyFyDZanYyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvE14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
	evJa73UjIFyTuYvjfUOv38UUUUU
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/



在 2025/11/29 11:37, Al Viro 写道:
> On Thu, Nov 27, 2025 at 10:24:19AM +0800, Zizhi Wo wrote:
> 
>> Why does x86 have special handling in do_kern_addr_fault(), including
>> logic for vmalloc faults? For example, on CONFIG_X86_32, it still takes
>> the vmalloc_fault path. As noted in the x86 comments, "We can fault-in
>> kernel-space virtual memory on-demand"...
>>
>> But on arm64, I don’t see similar logic — is there a specific reason
>> for this difference? Maybe x86's vmalloc area is mapped lazily, while
>> ARM maps it fully during early boot?
> 
> x86 MMU uses the same register for kernel and userland top-level page
> tables; arm64 MMU has separate page tables for those - TTBR0 and TTBR1
> point to the table to be used for translation, depending upon the bit
> 55 of virtual address.
> 
> vmalloc works with page table of init_mm (see pgd_offset_k() uses in
> there).  On arm64 that's it - TTBR1 is set to that and it stays that way,
> so access to vmalloc'ed area will do the right thing.
> 
> On 32bit x86 you need to propagate the change into top-level page tables
> of every thread.  That's what arch_sync_kernel_mappings() is for; look for
> the calls in mm/vmalloc.c and see the discussion of race in the comment in
> front of x86 vmalloc_fault().  Nothing of that sort is needed of arm64,
> since all threads are using the same page table for kernel part of the
> address space.
> 
> The reason why 64bit x86 doesn't need to bother is different - there we
> fill all relevant top-level page table slots in preallocate_vmalloc_pages()
> before any additional threads could be created.  The pointers in those
> slots are not going to change and they will be propagated to all subsequent
> threads by pgd_alloc(), so the page tables actually modified by vmalloc()
> are shared by all threads.

Thank you very much for your answer. This well explains my confusion!

Thanks,
Zizhi Wo

> 
> AFAICS, 32bit arm is similar to 32bit x86 in that respect; propagation
> is lazier, though - there arch_sync_kernel_mappings() bumps a counter
> in init_mm and context switches use that to check if propagation needs
> to be done.  No idea how well does that work on vfree() side of things -
> hadn't looked into that rabbit hole...
> 


