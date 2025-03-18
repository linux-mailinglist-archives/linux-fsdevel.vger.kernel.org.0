Return-Path: <linux-fsdevel+bounces-44246-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 170E0A6686D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 05:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77A137A134B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 04:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8EF1B87D7;
	Tue, 18 Mar 2025 04:37:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC1D19ABAB;
	Tue, 18 Mar 2025 04:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742272652; cv=none; b=pBRDbLgo0SAg4zQVyJj5eB1O0mEFD/rZhUeyDJDuSAol9BR0P0Hh6MrPrOeEdfEoq5W6VvfePn+m3rx1Orww7N0nRsyCXdVv0eG28aIwh3iHLGJmMTz4br4Txg2YGfkEHkoTJoo0ZBIASEs2Yz27RHsUBoyCBXtPs6VppD2PG54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742272652; c=relaxed/simple;
	bh=Qh7kP66RGTGxKhNObUyde6HxN3TQhHvkFPc6LTNlBZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uZJuCO1iv/1tWpVTBMF2mk/YiBB4IlySC0a34ZeWJZTPvqZbCE5Zhwj/1Vm6Kq70I2J3sBkqIjPqlpsZCHjL7OcAXITd1t+0i3hA6gEXN9dgo122lAvqtT7VxohODbUbuCpbvLtOzKP6fUVyZcmsh1Xtlq+gWZL/nWKrmvWLcng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4ZGzZc6407z4f3jY9;
	Tue, 18 Mar 2025 12:36:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7090D1A058E;
	Tue, 18 Mar 2025 12:37:19 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgAni199+NhnGRVMGw--.2509S3;
	Tue, 18 Mar 2025 12:37:19 +0800 (CST)
Message-ID: <81ae9161-8403-4e6d-a3da-1b52bd989ac9@huaweicloud.com>
Date: Tue, 18 Mar 2025 12:37:17 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] jbd2: add a missing data flush during file and fs
 synchronization
To: tytso@mit.edu
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 adilger.kernel@dilger.ca, jack@suse.cz, yi.zhang@huawei.com,
 chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com,
 linux-ext4@vger.kernel.org
References: <20241206111327.4171337-1-yi.zhang@huaweicloud.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20241206111327.4171337-1-yi.zhang@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgAni199+NhnGRVMGw--.2509S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZrWkuF1kurykKw15Zw13urg_yoW5Gry7pr
	W8C3WYkrWvvFyxAr18XF4fJFWF9F40y34UWry09Fn8tw43Xwn2krWftr1Yy3WqkFs5Ww4r
	Xw1UC34qg34qk3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UAwI
	DUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

Hi, Ted.

Just wanted to kindly check if this patch might have been
overlooked?

Thanks,
Yi.

On 2024/12/6 19:13, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> When the filesystem performs file or filesystem synchronization (e.g.,
> ext4_sync_file()), it queries the journal to determine whether to flush
> the file device through jbd2_trans_will_send_data_barrier(). If the
> target transaction has not started committing, it assumes that the
> journal will submit the flush command, allowing the filesystem to bypass
> a redundant flush command. However, this assumption is not always valid.
> If the journal is not located on the filesystem device, the journal
> commit thread will not submit the flush command unless the variable
> ->t_need_data_flush is set to 1. Consequently, the flush may be missed,
> and data may be lost following a power failure or system crash, even if
> the synchronization appears to succeed.
> 
> Unfortunately, we cannot determine with certainty whether the target
> transaction will flush to the filesystem device before it commits.
> However, if it has not started committing, it must be the running
> transaction. Therefore, fix it by always set its t_need_data_flush to 1,
> ensuring that the committing thread will flush the filesystem device.
> 
> Fixes: bbd2be369107 ("jbd2: Add function jbd2_trans_will_send_data_barrier()")
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
>  fs/jbd2/journal.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 97f487c3d8fc..37632ae18a4e 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -609,7 +609,7 @@ int jbd2_journal_start_commit(journal_t *journal, tid_t *ptid)
>  int jbd2_trans_will_send_data_barrier(journal_t *journal, tid_t tid)
>  {
>  	int ret = 0;
> -	transaction_t *commit_trans;
> +	transaction_t *commit_trans, *running_trans;
>  
>  	if (!(journal->j_flags & JBD2_BARRIER))
>  		return 0;
> @@ -619,6 +619,16 @@ int jbd2_trans_will_send_data_barrier(journal_t *journal, tid_t tid)
>  		goto out;
>  	commit_trans = journal->j_committing_transaction;
>  	if (!commit_trans || commit_trans->t_tid != tid) {
> +		running_trans = journal->j_running_transaction;
> +		/*
> +		 * The query transaction hasn't started committing,
> +		 * it must still be running.
> +		 */
> +		if (WARN_ON_ONCE(!running_trans ||
> +				 running_trans->t_tid != tid))
> +			goto out;
> +
> +		running_trans->t_need_data_flush = 1;
>  		ret = 1;
>  		goto out;
>  	}


