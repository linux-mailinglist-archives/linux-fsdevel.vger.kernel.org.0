Return-Path: <linux-fsdevel+bounces-50892-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C04AD0B6D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jun 2025 08:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAF943AEE08
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jun 2025 06:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A99D1F37A1;
	Sat,  7 Jun 2025 06:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="R5HtIP6A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0352623A6;
	Sat,  7 Jun 2025 06:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749277030; cv=none; b=dOkkLmFFAighQUcu8RZec1CU/qxE8Im/D8OSpAdtadpBPLwBw4D0qMjRW3jiTPcOlQxD9FMQilrBt+YhsCgUByDNMRbJlraxPPqVkLRv5bn08PbViMQgNCck6cIX3FLwL4dvK6PxVXlHqTNiTlvjFE1JH6ssDfshG6nXfQoFXso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749277030; c=relaxed/simple;
	bh=mr9qkFlYELLTimIF+gfrM9ht93yt1e1HXupvyolc+G8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=or41z56eTfYGW7yxLNsO4csFm/BHAx6uhldyXad1ShctKKkw1NZ5s5lvMjzD5IR7IBdSDA41ppMJS+Mhy9Uhsz0yEwdL3aQq/r7RrNQd38v73p3J0OMsjZRl3XRrS8GYYIfMo0dxcue9pvB/Nog8+2pwsUM4fY1zupd06E/1K6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=R5HtIP6A; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1749277024; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=tv8Qd186a+YUGmKNnjp0VaSDu0lYv/4ErZQgFy9v7GI=;
	b=R5HtIP6AdVQg3Rx9rmznbYwvePNM2Z84yJ29rsQ4US8j1YG1NUMsC8vVOgEfmJuG4CH2ZMU1fFNihDfu4evof+KBNsIeOT1R52W/NfjZfFQVQZ0YqjJHar955zpIc9cHKPyOQPHHhU2e8N8zYx+iBesjYWYbtJVeVo4kkLFZypk=
Received: from 30.39.161.173(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WdEKcKv_1749276701 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 07 Jun 2025 14:11:42 +0800
Message-ID: <3d07c68f-da11-43d8-a2da-6b200b2fa40a@linux.alibaba.com>
Date: Sat, 7 Jun 2025 14:11:41 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] mm: shmem: correctly pass alloced parameter to
 shmem_recalc_inode() to avoid WARN_ON()
To: Kemeng Shi <shikemeng@huaweicloud.com>, hughd@google.com,
 willy@infradead.org, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20250605221037.7872-1-shikemeng@huaweicloud.com>
 <20250605221037.7872-2-shikemeng@huaweicloud.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250605221037.7872-2-shikemeng@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/6/6 06:10, Kemeng Shi wrote:
> As noted in the comments, we need to release block usage for swap entry
> which was replaced with poisoned swap entry. However, no block usage is
> actually freed by calling shmem_recalc_inode(inode, -nr_pages, -nr_pages).
> Instead, call shmem_recalc_inode(inode, 0, -nr_pages) can correctly release
> the block usage.
> 
> Fixes: 6cec2b95dadf7 ("mm/shmem: fix infinite loop when swap in shmem error at swapoff time")
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>   mm/shmem.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 4b42419ce6b2..e27d19867e03 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2145,7 +2145,7 @@ static void shmem_set_folio_swapin_error(struct inode *inode, pgoff_t index,
>   	 * won't be 0 when inode is released and thus trigger WARN_ON(i_blocks)
>   	 * in shmem_evict_inode().
>   	 */
> -	shmem_recalc_inode(inode, -nr_pages, -nr_pages);
> +	shmem_recalc_inode(inode, 0, -nr_pages);
>   	swap_free_nr(swap, nr_pages);
>   }

Have you tested your patch? When I inject an error to test your patch, 
the following issue will be triggered:

[  127.173330] ------------[ cut here ]------------
[  127.173331] WARNING: CPU: 13 PID: 6860 at mm/shmem.c:1388 
shmem_evict_inode+0xf0/0x348
[  127.173920] CPU: 13 UID: 0 PID: 6860 Comm: shmem_swapin_er Kdump: 
loaded Tainted: G            E       6.15.0-rc6+ #54 VOLUNTARY
[  127.173925] pstate: 63401005 (nZCv daif +PAN -UAO +TCO +DIT +SSBS 
BTYPE=--)
[  127.173927] pc : shmem_evict_inode+0xf0/0x348
[  127.173929] lr : shmem_evict_inode+0x68/0x348
[  127.173931] sp : ffff8000895639e0
[  127.173932] x29: ffff8000895639e0 x28: 0000000000000006 x27: 
ffff00013754bfc0
[  127.173935] x26: ffff800080d8f160 x25: 0000000000000006 x24: 
ffff0000c0aab440
[  127.173937] x23: ffff00013754b780 x22: ffff00013754b780 x21: 
ffff0000cbc9c6b0
[  127.173940] x20: ffff0000c0aab440 x19: ffff0000cbc9c700 x18: 
0000000000000030
[  127.173942] x17: 0000ffffa1f4cfff x16: 0000000000000003 x15: 
0000000000001000
[  127.173945] x14: 00000000ffffffff x13: 0000000000000004 x12: 
ffff800089563108
[  127.173947] x11: 0000000000000000 x10: 0000000000000002 x9 : 
ffff800080352080
[  127.173949] x8 : fffffffffffffffe x7 : ffff800089563700 x6 : 
0000000000000001
[  127.173952] x5 : 0000000000000004 x4 : 0000000000000002 x3 : 
0000000000000002
[  127.173954] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 
ffffffffffffff80
[  127.173957] Call trace:
[  127.173958]  shmem_evict_inode+0xf0/0x348 (P)
[  127.173961]  evict+0x1c8/0x2c8
[  127.173964]  iput_final+0x84/0x1a0
[  127.173966]  iput.part.0+0xd0/0xf0
[  127.173968]  iput+0x20/0x38
[  127.173971]  dentry_unlink_inode+0xc0/0x158
[  127.173973]  __dentry_kill+0x80/0x248
[  127.173974]  dput+0xf0/0x240
[  127.173976]  __fput+0x120/0x2f0
[  127.173978]  ____fput+0x18/0x28
[  127.173980]  task_work_run+0x88/0x120
[  127.173983]  do_exit+0x198/0x3c0
[  127.173986]  do_group_exit+0x38/0xa0
[  127.173987]  get_signal+0x6ac/0x6b8
[  127.173990]  do_signal+0x100/0x208
[  127.173991]  do_notify_resume+0xc8/0x158
[  127.173994]  el0_da+0xbc/0xc0
[  127.173997]  el0t_64_sync_handler+0x70/0xc8
[  127.173999]  el0t_64_sync+0x154/0x158
[  127.174001] ---[ end trace 0000000000000000 ]---

