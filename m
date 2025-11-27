Return-Path: <linux-fsdevel+bounces-69956-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DECC8CA6D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 03:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A30153B041F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 02:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B939525C80D;
	Thu, 27 Nov 2025 02:24:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CA6259C9C;
	Thu, 27 Nov 2025 02:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764210269; cv=none; b=HwfIcqiePpkCaq4SJkIwYNdegQxuFHhcoJQLwQZdFW2yofaxMX3IHmO5WB3rtEEAf61FmTRasJnlZYiEduwG1sQTZPbuRmFgZv7GhUBW/l05BEjQC40Z5YmNW2pQa7BmlW0HWGA0x4MtxrMpkbFwePSShtLexPEhqCvMXbsqeAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764210269; c=relaxed/simple;
	bh=y2nBS0RNRQyiIWKpNen2x6FQVA4AbGPvZq/xdCV8sqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SncxXbohGD5wCvX+hH0Ve78ajBxaXQXCdYsblbtTH7A/sMB37muZkJO4jXyt6EpgFEDLE1hOILoOESz4j5j8ir+iF2ugepdHN7nFjwNAYi4rowxl03vhvo8OK5AQuhVamZ8BMLdPTdy2LfHB+QSwYAF4c1J4GUHeMdtJVL6UYdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dH0bP44DLzYQtkJ;
	Thu, 27 Nov 2025 10:23:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 6BEC71A07BD;
	Thu, 27 Nov 2025 10:24:22 +0800 (CST)
Received: from [10.174.176.88] (unknown [10.174.176.88])
	by APP2 (Coremail) with SMTP id Syh0CgAXdHpTtidpTkSaCA--.14138S3;
	Thu, 27 Nov 2025 10:24:22 +0800 (CST)
Message-ID: <c375dd22-8b46-404b-b0c2-815dbd4c5ec8@huaweicloud.com>
Date: Thu, 27 Nov 2025 10:24:19 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug report] hash_name() may cross page boundary and trigger
 sleep in RCU context
To: Al Viro <viro@zeniv.linux.org.uk>, Zizhi Wo <wozizhi@huaweicloud.com>,
 torvalds@linux-foundation.org
Cc: jack@suse.com, brauner@kernel.org, hch@lst.de, akpm@linux-foundation.org,
 linux@armlinux.org.uk, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org, yangerkun@huawei.com,
 wangkefeng.wang@huawei.com, pangliyuan1@huawei.com, xieyuanbin1@huawei.com
References: <20251126090505.3057219-1-wozizhi@huaweicloud.com>
 <20251126185545.GC3538@ZenIV>
From: Zizhi Wo <wozizhi@huaweicloud.com>
In-Reply-To: <20251126185545.GC3538@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgAXdHpTtidpTkSaCA--.14138S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Ary7Kr18ur18uF48tr4xZwb_yoW8Wr1Dpr
	yxG3W5CF45Xw15twn7Aa92kryftan5KrWUGryfWwnYkw4YkFy09w4ftF4DW34agwn7Cr4k
	JF4j9w4qvrZYga7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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



在 2025/11/27 2:55, Al Viro 写道:
> On Wed, Nov 26, 2025 at 05:05:05PM +0800, Zizhi Wo wrote:
> 
>> under an RCU read-side critical section. In linux-mainline, arm/arm64
>> do_page_fault() still has this problem:
>>
>> lock_mm_and_find_vma->get_mmap_lock_carefully->mmap_read_lock_killable.
> 
> 	arm64 shouldn't hit do_page_fault() in the first place, and
> do_translation_fault() there will see that address is beyond TASK_SIZE
> and go straight to do_bad_area() -> __do_kernel_fault() -> fixup_exception(),
> with no messing with mmap_lock.
> 
> 	Can anybody confirm that problem exists on arm64 (ideally - with
> reproducer)?
> 


Thank you all for the replies.

We did reproduce the issue on arm, and I mistakenly assumed the same
problem existed on arm64 after looking at the do_page_fault() code.
However, I just confirmed using the test program that, as everyone
pointed out, it goes through do_translation_fault() and reaches
do_bad_area() -> __do_kernel_fault(). So indeed, the issue does not
exist on arm64 — that was my oversight...

That said, I’d like to ask a follow-up question:

Why does x86 have special handling in do_kern_addr_fault(), including
logic for vmalloc faults? For example, on CONFIG_X86_32, it still takes
the vmalloc_fault path. As noted in the x86 comments, "We can fault-in 
kernel-space virtual memory on-demand"...

But on arm64, I don’t see similar logic — is there a specific reason
for this difference? Maybe x86's vmalloc area is mapped lazily, while
ARM maps it fully during early boot?

Thanks,
Zizhi Wo


