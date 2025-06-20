Return-Path: <linux-fsdevel+bounces-52290-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AEACAE12B9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 07:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18D8F1BC36DE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 05:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB681202F6D;
	Fri, 20 Jun 2025 05:00:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3A82A8C1;
	Fri, 20 Jun 2025 05:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750395638; cv=none; b=KyGtX4agTYVsxlhXyIMd5v2a1YLnzBdV/tu5Jj4gS84mpfLe+pKI32cjxf25FiZMThLsH3Azho8BaPxnVdnxzc0/oMhVNDVbN4tCbEJ47E1nUAcsw6HTTxMfZ2OlKG4Nsevjunqcgt+UVqDg/Dct6kTquxFjJBoHviZRABHVs/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750395638; c=relaxed/simple;
	bh=ieHcvHe3oWKPR+PtGQ+16Jb/v+Qn0GU2mnFbBNymSEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r0ExSeWhk29LKu3C8VWWcFd2eQJnucZHi6DJ6y+VAy1FidR7hsiDSZ9cuK1WsaBxiH84f77+QvaiOYd0zaJTprTqYjDCQ5ZMBJunTTNcWy5T2pOviC7gtGIHF3mUC93g3hgDofQk60/rFMMMUxMA22zojRCoTJ8sWOJfUQ2bD68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bNlfV52YzzYQv05;
	Fri, 20 Jun 2025 13:00:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 9EDE51A121F;
	Fri, 20 Jun 2025 13:00:33 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgD3W2Dw6lRoMqdLQA--.187S3;
	Fri, 20 Jun 2025 13:00:33 +0800 (CST)
Message-ID: <00d60446-f380-4480-b643-2b63669ebccc@huaweicloud.com>
Date: Fri, 20 Jun 2025 13:00:32 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] ext4: restart handle if credits are insufficient
 during allocating blocks
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 ojaswin@linux.ibm.com, yi.zhang@huawei.com, libaokun1@huawei.com,
 yukuai3@huawei.com, yangerkun@huawei.com
References: <20250611111625.1668035-1-yi.zhang@huaweicloud.com>
 <20250611111625.1668035-4-yi.zhang@huaweicloud.com>
 <7nw5sxwibqmp6zuuanb6eklkxnm5n536fpgzqus6pxts37q2ix@vlpsd2muuj6w>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <7nw5sxwibqmp6zuuanb6eklkxnm5n536fpgzqus6pxts37q2ix@vlpsd2muuj6w>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgD3W2Dw6lRoMqdLQA--.187S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAw17GF1rtryDXrykJrWxCrg_yoW5Xw15pF
	WfCF1Ykr43W34Uuan2qws5Zr1fXw4jyrW7JryfGF9YvayDCw13KF48JFn0ya4Yvrs3WF4j
	vr4jy345Wa1FyrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUb
	mii3UUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2025/6/20 0:33, Jan Kara wrote:
> On Wed 11-06-25 19:16:22, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> After large folios are supported on ext4, writing back a sufficiently
>> large and discontinuous folio may consume a significant number of
>> journal credits, placing considerable strain on the journal. For
>> example, in a 20GB filesystem with 1K block size and 1MB journal size,
>> writing back a 2MB folio could require thousands of credits in the
>> worst-case scenario (when each block is discontinuous and distributed
>> across different block groups), potentially exceeding the journal size.
>> This issue can also occur in ext4_write_begin() and ext4_page_mkwrite()
>> when delalloc is not enabled.
>>
>> Fix this by ensuring that there are sufficient journal credits before
>> allocating an extent in mpage_map_one_extent() and _ext4_get_block(). If
>> there are not enough credits, return -EAGAIN, exit the current mapping
>> loop, restart a new handle and a new transaction, and allocating blocks
>> on this folio again in the next iteration.
>>
>> Suggested-by: Jan Kara <jack@suse.cz>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> 
> ...
> 
>>  static int _ext4_get_block(struct inode *inode, sector_t iblock,
>>  			   struct buffer_head *bh, int flags)
>>  {
>>  	struct ext4_map_blocks map;
>> +	handle_t *handle = ext4_journal_current_handle();
>>  	int ret = 0;
>>  
>>  	if (ext4_has_inline_data(inode))
>>  		return -ERANGE;
>>  
>> +	/* Make sure transaction has enough credits for this extent */
>> +	if (flags & EXT4_GET_BLOCKS_CREATE) {
>> +		ret = ext4_journal_ensure_extent_credits(handle, inode);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>>  	map.m_lblk = iblock;
>>  	map.m_len = bh->b_size >> inode->i_blkbits;
>>  
>> -	ret = ext4_map_blocks(ext4_journal_current_handle(), inode, &map,
>> -			      flags);
>> +	ret = ext4_map_blocks(handle, inode, &map, flags);
> 
> Good spotting with ext4_page_mkwrite() and ext4_write_begin() also needing
> this treatment! But rather then hiding the transaction extension in
> _ext4_get_block() I'd do this in ext4_block_write_begin() where it is much
> more obvious (and also it is much more obvious who needs to be prepared for
> handling EAGAIN error). Otherwise the patch looks good!
> 

Yes, I completely agree with you. However, unfortunately, do this in
ext4_block_write_begin() only works for ext4_write_begin().
ext4_page_mkwrite() does not call ext4_block_write_begin() to allocate
blocks, it call the vfs helper __block_write_begin_int() instead.

vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
{
	...
	if (!ext4_should_journal_data(inode)) {
		err = block_page_mkwrite(vma, vmf, get_block);
	...
}


So...

Thanks,
Yi.


