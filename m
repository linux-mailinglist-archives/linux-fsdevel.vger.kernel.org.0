Return-Path: <linux-fsdevel+bounces-42064-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FCCA3BE0B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 13:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D41916A662
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 12:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01101E04BF;
	Wed, 19 Feb 2025 12:29:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A951DFD91;
	Wed, 19 Feb 2025 12:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739968197; cv=none; b=jD51Y2iDrl6YBv+go5rxZ2BrMSnmXNBRZPt0Gdi1Q2LLVX8JzM2rJGuo/Iwdtc/AZaY9zmyVePKtVkyzSC9GNfipGraFxXnPk3IeD3jSPJ3oAaecveVKC+7uOU06cwkrR5Rsrato7MGmmh/79R1VICSIJaIE7VYyBU4oZ7HRqjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739968197; c=relaxed/simple;
	bh=FCJOtv41Agf4mc6AQxG+YamyhLe7kyxpnwVuSp1A3Ac=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=d5tr2WnoJ9yA9fPnkmCmYG8qBf/55Eg5SZnb1/cmfuOsHimtnFRVdrfJBrJ3DzzGAyLz3x1VA3obHmVDA7QUbtSVSZ999Eho2vHvSJAzjeAR0NVlWWn/chJqKU5/9UhVG0bUM5DQgcaBZusLArSYsFTAQGXofiAg3iTVrb92GZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4YybGW1tRNzhZx2;
	Wed, 19 Feb 2025 20:26:11 +0800 (CST)
Received: from kwepemg500008.china.huawei.com (unknown [7.202.181.45])
	by mail.maildlp.com (Postfix) with ESMTPS id DA40A180116;
	Wed, 19 Feb 2025 20:29:34 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by kwepemg500008.china.huawei.com
 (7.202.181.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 19 Feb
 2025 20:29:33 +0800
Message-ID: <68912db5-bfce-427c-b523-3407e0804d15@huawei.com>
Date: Wed, 19 Feb 2025 20:29:32 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] jbd2: fix off-by-one while erasing journal
To: Zhang Yi <yi.zhang@huaweicloud.com>
CC: <linux-ext4@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
	<jack@suse.cz>, <leah.rumancik@gmail.com>, <yi.zhang@huawei.com>,
	<chengzhihao1@huawei.com>, <yukuai3@huawei.com>, <yangerkun@huawei.com>,
	Baokun Li <libaokun1@huawei.com>
References: <20250217065955.3829229-1-yi.zhang@huaweicloud.com>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20250217065955.3829229-1-yi.zhang@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemg500008.china.huawei.com (7.202.181.45)

On 2025/2/17 14:59, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
>
> In __jbd2_journal_erase(), the block_stop parameter includes the last
> block of a contiguous region; however, the calculation of byte_stop is
> incorrect, as it does not account for the bytes in that last block.
> Consequently, the page cache is not cleared properly, which occasionally
> causes the ext4/050 test to fail.
>
> Since block_stop operates on inclusion semantics, it involves repeated
> increments and decrements by 1, significantly increasing the complexity
> of the calculations. Optimize the calculation and fix the incorrect
> byte_stop by make both block_stop and byte_stop to use exclusion
> semantics.
>
> This fixes a failure in fstests ext4/050.
>
> Fixes: 01d5d96542fd ("ext4: add discard/zeroout flags to journal flush")
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Looks good, thanks for the patch!

Reviewed-by: Baokun Li <libaokun1@huawei.com>
> ---
>   fs/jbd2/journal.c | 15 ++++++---------
>   1 file changed, 6 insertions(+), 9 deletions(-)
>
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index d8084b31b361..49a9e99cbc03 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -1965,17 +1965,15 @@ static int __jbd2_journal_erase(journal_t *journal, unsigned int flags)
>   			return err;
>   		}
>   
> -		if (block_start == ~0ULL) {
> -			block_start = phys_block;
> -			block_stop = block_start - 1;
> -		}
> +		if (block_start == ~0ULL)
> +			block_stop = block_start = phys_block;
>   
>   		/*
>   		 * last block not contiguous with current block,
>   		 * process last contiguous region and return to this block on
>   		 * next loop
>   		 */
> -		if (phys_block != block_stop + 1) {
> +		if (phys_block != block_stop) {
>   			block--;
>   		} else {
>   			block_stop++;
> @@ -1994,11 +1992,10 @@ static int __jbd2_journal_erase(journal_t *journal, unsigned int flags)
>   		 */
>   		byte_start = block_start * journal->j_blocksize;
>   		byte_stop = block_stop * journal->j_blocksize;
> -		byte_count = (block_stop - block_start + 1) *
> -				journal->j_blocksize;
> +		byte_count = (block_stop - block_start) * journal->j_blocksize;
>   
>   		truncate_inode_pages_range(journal->j_dev->bd_mapping,
> -				byte_start, byte_stop);
> +				byte_start, byte_stop - 1);
>   
>   		if (flags & JBD2_JOURNAL_FLUSH_DISCARD) {
>   			err = blkdev_issue_discard(journal->j_dev,
> @@ -2013,7 +2010,7 @@ static int __jbd2_journal_erase(journal_t *journal, unsigned int flags)
>   		}
>   
>   		if (unlikely(err != 0)) {
> -			pr_err("JBD2: (error %d) unable to wipe journal at physical blocks %llu - %llu",
> +			pr_err("JBD2: (error %d) unable to wipe journal at physical blocks [%llu, %llu)",
>   					err, block_start, block_stop);
>   			return err;
>   		}



