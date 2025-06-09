Return-Path: <linux-fsdevel+bounces-50953-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA378AD165D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 02:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB84C3A96DB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 00:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21282868B;
	Mon,  9 Jun 2025 00:47:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B01B323E;
	Mon,  9 Jun 2025 00:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749430025; cv=none; b=o5RUbeELnnniMcw69Cej+pXodbBnrHNb0+YCJ+q8QNcy8MecN2uwLUwDdX9FKLIJhy0ONGO+Pm/MXXCDbuMJ0Ju0A9JL1noCr/2P99ulaOYJH9pzEmiEw/n5+sPMesONBPY9G3PmLS2TPCJpwAt2N0IOkoIzplh/rMcahUxrKk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749430025; c=relaxed/simple;
	bh=b40CCJW+vHKp1umSIjlmrQRnm0GpSQXv3xqw4LtTmGc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=j49bg5CEaDc9wq0kwRinxeuJL62LnCQER5gr4qAPeIbCROIoAIr+Kk2Iu57fowX0GJzfZGQnh8lUKzOjHQEmw+e1dpCYmSJWpFu8Q9fq2i7UYzlbFBXW4D1rc++9sA8KGEJL1tg87OF5N8nHnC4+UTh1P2UwNqNfHz4RBhetfCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bFtXv3RbSzKHMdg;
	Mon,  9 Jun 2025 08:46:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id D042F1A08C5;
	Mon,  9 Jun 2025 08:46:53 +0800 (CST)
Received: from [10.174.99.169] (unknown [10.174.99.169])
	by APP3 (Coremail) with SMTP id _Ch0CgDHGMP8LkZoLgDVOg--.39400S2;
	Mon, 09 Jun 2025 08:46:53 +0800 (CST)
Subject: Re: [PATCH 1/7] mm: shmem: correctly pass alloced parameter to
 shmem_recalc_inode() to avoid WARN_ON()
To: Baolin Wang <baolin.wang@linux.alibaba.com>, hughd@google.com,
 willy@infradead.org, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20250605221037.7872-1-shikemeng@huaweicloud.com>
 <20250605221037.7872-2-shikemeng@huaweicloud.com>
 <3d07c68f-da11-43d8-a2da-6b200b2fa40a@linux.alibaba.com>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <994283d9-2dc4-6887-5d46-247b834879b5@huaweicloud.com>
Date: Mon, 9 Jun 2025 08:46:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <3d07c68f-da11-43d8-a2da-6b200b2fa40a@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgDHGMP8LkZoLgDVOg--.39400S2
X-Coremail-Antispam: 1UD129KBjvJXoWxArWDtw13ZFyrZFy7Cw18Grg_yoWrXw18pr
	1fGryDGr4IqrZ7GF1Iyr4DXryvqF43Aa18JrnxAF1xKF4UGw18Kr13Jr42gr1DA3ykAry7
	tw1kKw10qa1DGaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UK2N
	tUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 6/7/2025 2:11 PM, Baolin Wang wrote:
> 
> 
> On 2025/6/6 06:10, Kemeng Shi wrote:
>> As noted in the comments, we need to release block usage for swap entry
>> which was replaced with poisoned swap entry. However, no block usage is
>> actually freed by calling shmem_recalc_inode(inode, -nr_pages, -nr_pages).
>> Instead, call shmem_recalc_inode(inode, 0, -nr_pages) can correctly release
>> the block usage.
>>
>> Fixes: 6cec2b95dadf7 ("mm/shmem: fix infinite loop when swap in shmem error at swapoff time")
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>> ---
>>   mm/shmem.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/shmem.c b/mm/shmem.c
>> index 4b42419ce6b2..e27d19867e03 100644
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -2145,7 +2145,7 @@ static void shmem_set_folio_swapin_error(struct inode *inode, pgoff_t index,
>>        * won't be 0 when inode is released and thus trigger WARN_ON(i_blocks)
>>        * in shmem_evict_inode().
>>        */
>> -    shmem_recalc_inode(inode, -nr_pages, -nr_pages);
>> +    shmem_recalc_inode(inode, 0, -nr_pages);
>>       swap_free_nr(swap, nr_pages);
>>   }
> 
> Have you tested your patch? When I inject an error to test your patch, the following issue will be triggered:As all issues are hard to trigger, I only run some simple test to ensure normal
process is fine. Could you share how to inject the error to trigger following
issue. I will have a deep look. Thanks
> 
> [  127.173330] ------------[ cut here ]------------
> [  127.173331] WARNING: CPU: 13 PID: 6860 at mm/shmem.c:1388 shmem_evict_inode+0xf0/0x348
> [  127.173920] CPU: 13 UID: 0 PID: 6860 Comm: shmem_swapin_er Kdump: loaded Tainted: G            E       6.15.0-rc6+ #54 VOLUNTARY
> [  127.173925] pstate: 63401005 (nZCv daif +PAN -UAO +TCO +DIT +SSBS BTYPE=--)
> [  127.173927] pc : shmem_evict_inode+0xf0/0x348
> [  127.173929] lr : shmem_evict_inode+0x68/0x348
> [  127.173931] sp : ffff8000895639e0
> [  127.173932] x29: ffff8000895639e0 x28: 0000000000000006 x27: ffff00013754bfc0
> [  127.173935] x26: ffff800080d8f160 x25: 0000000000000006 x24: ffff0000c0aab440
> [  127.173937] x23: ffff00013754b780 x22: ffff00013754b780 x21: ffff0000cbc9c6b0
> [  127.173940] x20: ffff0000c0aab440 x19: ffff0000cbc9c700 x18: 0000000000000030
> [  127.173942] x17: 0000ffffa1f4cfff x16: 0000000000000003 x15: 0000000000001000
> [  127.173945] x14: 00000000ffffffff x13: 0000000000000004 x12: ffff800089563108
> [  127.173947] x11: 0000000000000000 x10: 0000000000000002 x9 : ffff800080352080
> [  127.173949] x8 : fffffffffffffffe x7 : ffff800089563700 x6 : 0000000000000001
> [  127.173952] x5 : 0000000000000004 x4 : 0000000000000002 x3 : 0000000000000002
> [  127.173954] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffffffffffffff80
> [  127.173957] Call trace:
> [  127.173958]  shmem_evict_inode+0xf0/0x348 (P)
> [  127.173961]  evict+0x1c8/0x2c8
> [  127.173964]  iput_final+0x84/0x1a0
> [  127.173966]  iput.part.0+0xd0/0xf0
> [  127.173968]  iput+0x20/0x38
> [  127.173971]  dentry_unlink_inode+0xc0/0x158
> [  127.173973]  __dentry_kill+0x80/0x248
> [  127.173974]  dput+0xf0/0x240
> [  127.173976]  __fput+0x120/0x2f0
> [  127.173978]  ____fput+0x18/0x28
> [  127.173980]  task_work_run+0x88/0x120
> [  127.173983]  do_exit+0x198/0x3c0
> [  127.173986]  do_group_exit+0x38/0xa0
> [  127.173987]  get_signal+0x6ac/0x6b8
> [  127.173990]  do_signal+0x100/0x208
> [  127.173991]  do_notify_resume+0xc8/0x158
> [  127.173994]  el0_da+0xbc/0xc0
> [  127.173997]  el0t_64_sync_handler+0x70/0xc8
> [  127.173999]  el0t_64_sync+0x154/0x158
> [  127.174001] ---[ end trace 0000000000000000 ]---
> 


