Return-Path: <linux-fsdevel+bounces-63657-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD77BC9006
	for <lists+linux-fsdevel@lfdr.de>; Thu, 09 Oct 2025 14:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2712A1A625F5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Oct 2025 12:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950342E228D;
	Thu,  9 Oct 2025 12:24:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A062C0F63;
	Thu,  9 Oct 2025 12:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760012661; cv=none; b=PXiv+AoEX6qDfowWpRbllSfXFy1csCk8YcuzI+CvjbU94cwSfSNOYCLDqnYQUwXp6QFnWdwBHrPRsLrqoKWQQblHOgAhfA3AUYcQ7P1kLvlugjtsSmmcCd5J6fiumhBtZt2FPURT9ZnzVRxgNxrfoI/OlEtlb4JonUUcM9Fq7qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760012661; c=relaxed/simple;
	bh=DFW7U2QCk58NJ8XqDaLczOqyEVZA2we0Uvp7IqAZisE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uwirJj1Hy+moDngSZSKP32a3d/mwtlZTXDLQ5J8sjJaXt8GK3j7iawKQxHGJcoIHSCkSRaOVpeFH39+h9Ej+YqAxfy6uo14Cc7WVaoP1o9ZT1qH+Fo8hflUTGv6nWBix6nPPdizov/rCwUJHPSk76aefOTxzYdJZzMGNRKVOPvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cj8Dc10FqzKHMdD;
	Thu,  9 Oct 2025 20:23:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id EA9841A0CAF;
	Thu,  9 Oct 2025 20:24:12 +0800 (CST)
Received: from [10.174.178.152] (unknown [10.174.178.152])
	by APP4 (Coremail) with SMTP id gCh0CgDX6GBrqedo2AJRCQ--.21891S3;
	Thu, 09 Oct 2025 20:24:12 +0800 (CST)
Message-ID: <25b45870-c0a8-4f4e-bd3b-2d962b7a31a3@huaweicloud.com>
Date: Thu, 9 Oct 2025 20:24:10 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/13] ext4: switch to using the new extent movement
 method
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 yi.zhang@huawei.com, libaokun1@huawei.com, yukuai3@huawei.com,
 yangerkun@huawei.com
References: <20250925092610.1936929-1-yi.zhang@huaweicloud.com>
 <20250925092610.1936929-12-yi.zhang@huaweicloud.com>
 <wdluk2p7bmgkh3n3xzep3tf3qb7mv3x2o6ltemjcahgorgmhwb@hfu7t7ar2vol>
 <fcf30c3c-25c3-4b1a-8b34-a5dcd98b7ebd@huaweicloud.com>
 <5g66nxbf3ay2bryv4legk46pudqonsbrdkxr5ljegbxaydkctk@2dyyoxguxyxu>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <5g66nxbf3ay2bryv4legk46pudqonsbrdkxr5ljegbxaydkctk@2dyyoxguxyxu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgDX6GBrqedo2AJRCQ--.21891S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCF48tryxtrykuw4fZF1kKrg_yoWrKr4kpr
	WIkF15tr4DX34F9r1vvw12q34vqw1UKr4IqryrKa1fZF98Ar9agFy7Ja1Y9Fyrur4kCFyF
	vF40k345Cay5Xa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 10/9/2025 5:14 PM, Jan Kara wrote:
> On Thu 09-10-25 15:20:59, Zhang Yi wrote:
>> On 10/8/2025 8:49 PM, Jan Kara wrote:
>>> On Thu 25-09-25 17:26:07, Zhang Yi wrote:
>>>> +			if (ret == -EBUSY &&
>>>> +			    sbi->s_journal && retries++ < 4 &&
>>>> +			    jbd2_journal_force_commit_nested(sbi->s_journal))
>>>> +				continue;
>>>> +			if (ret)
>>>>  				goto out;
>>>> -		} else { /* in_range(o_start, o_blk, o_len) */
>>>> -			cur_len += cur_blk - o_start;
>>>> +
>>>> +			*moved_len += m_len;
>>>> +			retries = 0;
>>>>  		}
>>>> -		unwritten = ext4_ext_is_unwritten(ex);
>>>> -		if (o_end - o_start < cur_len)
>>>> -			cur_len = o_end - o_start;
>>>> -
>>>> -		orig_page_index = o_start >> (PAGE_SHIFT -
>>>> -					       orig_inode->i_blkbits);
>>>> -		donor_page_index = d_start >> (PAGE_SHIFT -
>>>> -					       donor_inode->i_blkbits);
>>>> -		offset_in_page = o_start % blocks_per_page;
>>>> -		if (cur_len > blocks_per_page - offset_in_page)
>>>> -			cur_len = blocks_per_page - offset_in_page;
>>>> -		/*
>>>> -		 * Up semaphore to avoid following problems:
>>>> -		 * a. transaction deadlock among ext4_journal_start,
>>>> -		 *    ->write_begin via pagefault, and jbd2_journal_commit
>>>> -		 * b. racing with ->read_folio, ->write_begin, and
>>>> -		 *    ext4_get_block in move_extent_per_page
>>>> -		 */
>>>> -		ext4_double_up_write_data_sem(orig_inode, donor_inode);
>>>> -		/* Swap original branches with new branches */
>>>> -		*moved_len += move_extent_per_page(o_filp, donor_inode,
>>>> -				     orig_page_index, donor_page_index,
>>>> -				     offset_in_page, cur_len,
>>>> -				     unwritten, &ret);
>>>> -		ext4_double_down_write_data_sem(orig_inode, donor_inode);
>>>> -		if (ret < 0)
>>>> -			break;
>>>> -		o_start += cur_len;
>>>> -		d_start += cur_len;
>>>> +		orig_blk += mext.orig_map.m_len;
>>>> +		donor_blk += mext.orig_map.m_len;
>>>> +		len -= mext.orig_map.m_len;
>>>
>>> In case we've called mext_move_extent() we should update everything only by
>>> m_len, shouldn't we? Although I have somewhat hard time coming up with a
>>> realistic scenario where m_len != mext.orig_map.m_len for the parameters we
>>> call ext4_swap_extents() with... So maybe I'm missing something.
>>
>> In the case of MEXT_SKIP_EXTENT, the target move range of the donor file
>> is a hole. In this case, the m_len is return zero after calling
>> mext_move_extent(), not equal to mext.orig_map.m_len, and we need to move
>> forward and skip this range in the next iteration in ext4_move_extents().
>> Otherwise, it will lead to an infinite loop.
> 
> Right, that would be a problem. I thought this shouldn't happen because we
> call mext_move_extent() only if we have mapped or unwritten extent but if
> donor inode has a hole in the same place, MEXT_SKIP_EXTENT can still
> happen.

Yes, we can choose to simultaneously check the extent status of both the
origin inode and the donor inode before calling mext_move_extent(), and
only call mext_move_extent() when both extents are either mapped or
unwritten. However, the current iomap infrastructure (iomap_iter()) does
not support getting extents for two inodes simultaneously. In order to
facilitate a smoother conversion to iomap in the future (I've still
thinking details about how to switch this to iomap), I have only checked
the original inode in ext4_move_extents() and deferred the extent check
for the donor inode. At least, I think it should not be a significant
problem for now, as the presence of holes in the donor file is uncommon.

> 
>> In the other two cases, MEXT_MOVE_EXTENT and MEXT_COPY_DATA, m_len should
>> be equal to mext.orig_map.m_len after calling mext_move_extent().
> 
> So this is the bit which isn't 100% clear to me. Because what looks fishy
> to me is that ext4_swap_extents() can fail after swapping part of the
> passed range (e.g. due to extent split failure). In that case we'll return
> number smaller than mext.orig_map.m_len. Now that I'm looking again, we'll
> set *erp in all those cases (there are cases where ext4_swap_extents()
> returns smaller number even without setting *erp but I don't think those
> can happen given the locks we hold and what we've already verified - still

Yes, ext4_swap_extents() could shortly return if it encounters a hole.
However, we have already verified this case under locks. So this can not
happen.

> it would be good to add an assert for this in mext_move_extent()) so the

Sure.

> problem would rather be that we don't advance by m_len in case of error
> returned from mext_move_extent()?
> 

Yeah, you are right, this is a problem, I missed this case. As long as
m_len is not zero, we still need to increase move_len in
ext4_move_extents(), even if mext_move_extent() returns an error code.
Thank you for such a detailed review! :-)

Best Regards,
Yi.


