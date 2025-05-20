Return-Path: <linux-fsdevel+bounces-49501-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0ADCABD86D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 14:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E445E7B2EF2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 12:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC4C1B4231;
	Tue, 20 May 2025 12:47:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F812AF11;
	Tue, 20 May 2025 12:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747745220; cv=none; b=U88a8NBgHglN+CRa5qD3D2tPDFV/Sy3uiOjxYhyACLkUG8e+36wksN3H/oCQkFqAWfgFboqWQvgAY3H0NhpndAFU0gN2d9aWCO9K6+jFiskITl3DE9RQJPHCi86lya0SerQr8dAc4JNKWFh4OYSY+Oa0/PvS7hfZ89puvTxLx0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747745220; c=relaxed/simple;
	bh=N8YuNF3oS7Gb/eojUnbuRs7+phf4HOwLnhy2GKpT48Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ncyWNwFuVepNjlksT24dEOmjaNbfXECzmsQLIZGppFUrZ3uAK1J29k/IvZrjQ1JIWjkusiSoug9VFDlfxuNrRR2GP1NogWy2Ss11amUuZRFTRSnRNyD7KJND11QMoZdBvw9jnqn/WcU7C9ZgJVDYtJ3abECHj2ZHtLaXLkd8/t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4b1vSt5PBfzYQttG;
	Tue, 20 May 2025 20:46:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id EC2EF1A0DB8;
	Tue, 20 May 2025 20:46:53 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgBXul68eSxoEuDoMw--.49654S3;
	Tue, 20 May 2025 20:46:53 +0800 (CST)
Message-ID: <924cfe2c-318c-493f-89a5-10849bfc7a00@huaweicloud.com>
Date: Tue, 20 May 2025 20:46:51 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] ext4/jbd2: convert jbd2_journal_blocks_per_page()
 to support large folio
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, willy@infradead.org, tytso@mit.edu,
 adilger.kernel@dilger.ca, yi.zhang@huawei.com, libaokun1@huawei.com,
 yukuai3@huawei.com, yangerkun@huawei.com
References: <20250512063319.3539411-1-yi.zhang@huaweicloud.com>
 <20250512063319.3539411-5-yi.zhang@huaweicloud.com>
 <ht54j6bvjmiqt62xmcveqlo7bmrunqs4ji7wikfteftdjijzek@7tz5gpejaoen>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <ht54j6bvjmiqt62xmcveqlo7bmrunqs4ji7wikfteftdjijzek@7tz5gpejaoen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBXul68eSxoEuDoMw--.49654S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF1DAFy5Jw1kJryUGr1Dtrb_yoW5Jr4UpF
	Wak34rCrW8X34UCr1kXF43XFWF93yIkFWUAr1fGFnaqa98Xw1IgFWIqa4jvay0yrn7Gr40
	vF4UG3s8GayjyaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2025/5/20 4:16, Jan Kara wrote:
> On Mon 12-05-25 14:33:15, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> jbd2_journal_blocks_per_page() returns the number of blocks in a single
>> page. Rename it to jbd2_journal_blocks_per_folio() and make it returns
>> the number of blocks in the largest folio, preparing for the calculation
>> of journal credits blocks when allocating blocks within a large folio in
>> the writeback path.
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ...
>> @@ -2657,9 +2657,10 @@ void jbd2_journal_ack_err(journal_t *journal)
>>  	write_unlock(&journal->j_state_lock);
>>  }
>>  
>> -int jbd2_journal_blocks_per_page(struct inode *inode)
>> +int jbd2_journal_blocks_per_folio(struct inode *inode)
>>  {
>> -	return 1 << (PAGE_SHIFT - inode->i_sb->s_blocksize_bits);
>> +	return 1 << (PAGE_SHIFT + mapping_max_folio_order(inode->i_mapping) -
>> +		     inode->i_sb->s_blocksize_bits);
>>  }
> 
> FWIW this will result in us reserving some 10k transaction credits for 1k
> blocksize with maximum 2M folio size. That is going to create serious
> pressure on the journalling machinery. For now I guess we are fine

Oooh, indeed, you are right, thanks a lot for pointing this out. As you
mentioned in patch 5, the credits calculation I proposed was incorrect,
I thought it wouldn't require too many credits.

I believe it is risky to mount a filesystem with a small journal space
and a large number of block groups. For example, if we build an image
with a 1K block size and a 1MB journal on a 20GB disk (which contains
2,540 groups), it will require 2,263 credits, exceeding the available
journal space.

For now, I'm going to disable large folio support on the filesystem with
limited journal space. i.e., when the return value of
ext4_writepage_trans_blocks() is greater than
jbd2_max_user_trans_buffers(journal) / 2, ext4_should_enable_large_folio()
return false, thoughts?

> but
> eventually we should rewrite how credits for writing out folio are computed
> to reduce this massive overestimation. It will be a bit tricky but we could
> always reserve credits for one / couple of extents and try to extend the
> transaction if we need more. The tricky part is to do the partial folio
> writeout in case we cannot extend the transaction...
> 

Yes, this is a feasible solution; however, I prefer to promote the iomap
conversion in the long run.

Thanks,
Yi.


