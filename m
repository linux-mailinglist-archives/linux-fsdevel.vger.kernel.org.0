Return-Path: <linux-fsdevel+bounces-48177-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE29DAABC5D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 10:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 642A63B74E4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 07:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3312486358;
	Tue,  6 May 2025 07:38:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC0A20AF62;
	Tue,  6 May 2025 07:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746517085; cv=none; b=I9vHuxPWIIqD4+Q1Reah+GjG3qSxfNmBiCH7/2aEGEAdNe1pOPvpEwkdBenLjUCtLxKku8kljO1sKqXTPbH0M2jEHArhb/V07eYqVCpwokv92V3fptJQppDjWAtKE1F1i6P4x2Vl5aZfx6BeBxOA2dHjXUcolYswA+Jm6R2HP14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746517085; c=relaxed/simple;
	bh=tZIO+EQRo+626MNrPTrnWNLtIsRmHwA8dCHXaINz9v8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=B79QXiY5WGdgjlzf7qv9M4ch1XWiSj14TRNslSNWRAvrpvdgdjTt2E6PcfSOQ6ydED+Fg4tYSJpBtpJYHAQL+jablO5XlfZ2ZbFog3mMb8CTsHlhlaCmvA41HV68qNIC48GGsgls6N7Yt9LmsjPGRLFpNvKHFSBeSPmdWnvxG0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Zs9B02zsPzyVFB;
	Tue,  6 May 2025 15:33:44 +0800 (CST)
Received: from kwepemg500008.china.huawei.com (unknown [7.202.181.45])
	by mail.maildlp.com (Postfix) with ESMTPS id 580D6180B5F;
	Tue,  6 May 2025 15:37:59 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by kwepemg500008.china.huawei.com
 (7.202.181.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 6 May
 2025 15:37:58 +0800
Message-ID: <1aa40b1f-9d61-4cde-8414-6920609cff2f@huawei.com>
Date: Tue, 6 May 2025 15:37:57 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] ext4: fix out of bounds punch offset
To: Zhang Yi <yi.zhang@huaweicloud.com>
CC: <linux-ext4@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
	<jack@suse.cz>, <wanghaichi0403@gmail.com>, <yi.zhang@huawei.com>,
	<yukuai3@huawei.com>, <yangerkun@huawei.com>
References: <20250506012009.3896990-1-yi.zhang@huaweicloud.com>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20250506012009.3896990-1-yi.zhang@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemg500008.china.huawei.com (7.202.181.45)

On 2025/5/6 9:20, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
>
> Punching a hole with a start offset that exceeds max_end is not
> permitted and will result in a negative length in the
> truncate_inode_partial_folio() function while truncating the page cache,
> potentially leading to undesirable consequences.
>
> A simple reproducer:
>
>    truncate -s 9895604649994 /mnt/foo
>    xfs_io -c "pwrite 8796093022208 4096" /mnt/foo
>    xfs_io -c "fpunch 8796093022213 25769803777" /mnt/foo
>
>    kernel BUG at include/linux/highmem.h:275!
>    Oops: invalid opcode: 0000 [#1] SMP PTI
>    CPU: 3 UID: 0 PID: 710 Comm: xfs_io Not tainted 6.15.0-rc3
>    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-2.fc40 04/01/2014
>    RIP: 0010:zero_user_segments.constprop.0+0xd7/0x110
>    RSP: 0018:ffffc90001cf3b38 EFLAGS: 00010287
>    RAX: 0000000000000005 RBX: ffffea0001485e40 RCX: 0000000000001000
>    RDX: 000000000040b000 RSI: 0000000000000005 RDI: 000000000040b000
>    RBP: 000000000040affb R08: ffff888000000000 R09: ffffea0000000000
>    R10: 0000000000000003 R11: 00000000fffc7fc5 R12: 0000000000000005
>    R13: 000000000040affb R14: ffffea0001485e40 R15: ffff888031cd3000
>    FS:  00007f4f63d0b780(0000) GS:ffff8880d337d000(0000)
>    knlGS:0000000000000000
>    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>    CR2: 000000001ae0b038 CR3: 00000000536aa000 CR4: 00000000000006f0
>    DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>    DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>    Call Trace:
>     <TASK>
>     truncate_inode_partial_folio+0x3dd/0x620
>     truncate_inode_pages_range+0x226/0x720
>     ? bdev_getblk+0x52/0x3e0
>     ? ext4_get_group_desc+0x78/0x150
>     ? crc32c_arch+0xfd/0x180
>     ? __ext4_get_inode_loc+0x18c/0x840
>     ? ext4_inode_csum+0x117/0x160
>     ? jbd2_journal_dirty_metadata+0x61/0x390
>     ? __ext4_handle_dirty_metadata+0xa0/0x2b0
>     ? kmem_cache_free+0x90/0x5a0
>     ? jbd2_journal_stop+0x1d5/0x550
>     ? __ext4_journal_stop+0x49/0x100
>     truncate_pagecache_range+0x50/0x80
>     ext4_truncate_page_cache_block_range+0x57/0x3a0
>     ext4_punch_hole+0x1fe/0x670
>     ext4_fallocate+0x792/0x17d0
>     ? __count_memcg_events+0x175/0x2a0
>     vfs_fallocate+0x121/0x560
>     ksys_fallocate+0x51/0xc0
>     __x64_sys_fallocate+0x24/0x40
>     x64_sys_call+0x18d2/0x4170
>     do_syscall_64+0xa7/0x220
>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> Fix this by filtering out cases where the punching start offset exceeds
> max_end.
>
> Fixes: 982bf37da09d ("ext4: refactor ext4_punch_hole()")
> Reported-by: Liebes Wang <wanghaichi0403@gmail.com>
> Closes: https://lore.kernel.org/linux-ext4/ac3a58f6-e686-488b-a9ee-fc041024e43d@huawei.com/
> Tested-by: Liebes Wang <wanghaichi0403@gmail.com>
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
Looks good to me.

Reviewed-by: Baokun Li <libaokun1@huawei.com>
> ---
>   fs/ext4/inode.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 94c7d2d828a6..4ec4a80b6879 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4016,7 +4016,7 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>   	WARN_ON_ONCE(!inode_is_locked(inode));
>   
>   	/* No need to punch hole beyond i_size */
> -	if (offset >= inode->i_size)
> +	if (offset >= inode->i_size || offset >= max_end)
>   		return 0;
>   
>   	/*



