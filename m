Return-Path: <linux-fsdevel+bounces-18827-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A57E8BCD09
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 13:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D8861C210C5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 11:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18792143861;
	Mon,  6 May 2024 11:44:54 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7591DFE4;
	Mon,  6 May 2024 11:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714995893; cv=none; b=ggAvtEKVJB1qdvMZQmsA/ciGoIodb5ni+jkZLikm9pWXiiziyRPYtwArSsvm5L5D9a4nTkY6nCtun2W+bbjkm5tn3jRD18Rcs3oLjwB+hVtehWDrFEJqnojNvDPf9ePa1QrC/s9cfztB6KTfaHehonWriKyz9ej3W2oAUZku4fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714995893; c=relaxed/simple;
	bh=vVX8ey54S/LNAFujtNUW9wAhLyLI3G3H+odAJkJ87V0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ueJAM5uhJT284QvF+/j0pKBwJVbWUfznpKgHn6cYRkEzhNtlAAY1hS/XFRd649b60Gvgv9w7uL/DRQLXXFOc307srDel5CTik/hUvaodGkPb83zlQB68nPtDvKO5albCjwaZ6cwbKsNy5Kk0cjm0/USbFrARwkHTa38mOwQwD28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VY0215r8Yz4f3m8v;
	Mon,  6 May 2024 19:44:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 148D51A1072;
	Mon,  6 May 2024 19:44:47 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP2 (Coremail) with SMTP id Syh0CgDH6w6swjhmHsDLMA--.57384S3;
	Mon, 06 May 2024 19:44:46 +0800 (CST)
Subject: Re: [RFC PATCH v4 24/34] ext4: implement buffered write iomap path
To: Dave Chinner <david@fromorbit.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, tytso@mit.edu,
 adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
 hch@infradead.org, djwong@kernel.org, willy@infradead.org,
 zokeefe@google.com, yi.zhang@huawei.com, chengzhihao1@huawei.com,
 yukuai3@huawei.com, wangkefeng.wang@huawei.com
References: <20240410142948.2817554-1-yi.zhang@huaweicloud.com>
 <20240410142948.2817554-25-yi.zhang@huaweicloud.com>
 <ZjH5Ia+dWGss5Duv@dread.disaster.area> <ZjH+QFVXLlcDkSdh@dread.disaster.area>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <96bbdb25-b420-67b1-d4c4-b838a5c70f9f@huaweicloud.com>
Date: Mon, 6 May 2024 19:44:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZjH+QFVXLlcDkSdh@dread.disaster.area>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgDH6w6swjhmHsDLMA--.57384S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZFWxCryDXFyDtw17Cry3Jwb_yoWrJw1kpr
	Z8KFWUKFsrXr18ur1vvF4UWF1Fk3WxGr17Wr45WryqvFZ8ZFySga48GF1Y9FW7Ars2kF10
	qFWUuFyxZa4Yy37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
	WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07UZ18PUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/5/1 16:33, Dave Chinner wrote:
> On Wed, May 01, 2024 at 06:11:13PM +1000, Dave Chinner wrote:
>> On Wed, Apr 10, 2024 at 10:29:38PM +0800, Zhang Yi wrote:
>>> From: Zhang Yi <yi.zhang@huawei.com>
>>>
>>> Implement buffered write iomap path, use ext4_da_map_blocks() to map
>>> delalloc extents and add ext4_iomap_get_blocks() to allocate blocks if
>>> delalloc is disabled or free space is about to run out.
>>>
>>> Note that we always allocate unwritten extents for new blocks in the
>>> iomap write path, this means that the allocation type is no longer
>>> controlled by the dioread_nolock mount option. After that, we could
>>> postpone the i_disksize updating to the writeback path, and drop journal
>>> handle in the buffered dealloc write path completely.
> .....
>>> +/*
>>> + * Drop the staled delayed allocation range from the write failure,
>>> + * including both start and end blocks. If not, we could leave a range
>>> + * of delayed extents covered by a clean folio, it could lead to
>>> + * inaccurate space reservation.
>>> + */
>>> +static int ext4_iomap_punch_delalloc(struct inode *inode, loff_t offset,
>>> +				     loff_t length)
>>> +{
>>> +	ext4_es_remove_extent(inode, offset >> inode->i_blkbits,
>>> +			DIV_ROUND_UP_ULL(length, EXT4_BLOCK_SIZE(inode->i_sb)));
>>>  	return 0;
>>>  }
>>>  
>>> +static int ext4_iomap_buffered_write_end(struct inode *inode, loff_t offset,
>>> +					 loff_t length, ssize_t written,
>>> +					 unsigned int flags,
>>> +					 struct iomap *iomap)
>>> +{
>>> +	handle_t *handle;
>>> +	loff_t end;
>>> +	int ret = 0, ret2;
>>> +
>>> +	/* delalloc */
>>> +	if (iomap->flags & IOMAP_F_EXT4_DELALLOC) {
>>> +		ret = iomap_file_buffered_write_punch_delalloc(inode, iomap,
>>> +			offset, length, written, ext4_iomap_punch_delalloc);
>>> +		if (ret)
>>> +			ext4_warning(inode->i_sb,
>>> +			     "Failed to clean up delalloc for inode %lu, %d",
>>> +			     inode->i_ino, ret);
>>> +		return ret;
>>> +	}
>>
>> Why are you creating a delalloc extent for the write operation and
>> then immediately deleting it from the extent tree once the write
>> operation is done?
> 
> Ignore this, I mixed up the ext4_iomap_punch_delalloc() code
> directly above with iomap_file_buffered_write_punch_delalloc().
> 
> In hindsight, iomap_file_buffered_write_punch_delalloc() is poorly
> named, as it is handling a short write situation which requires
> newly allocated delalloc blocks to be punched.
> iomap_file_buffered_write_finish() would probably be a better name
> for it....
> 
>> Also, why do you need IOMAP_F_EXT4_DELALLOC? Isn't a delalloc iomap
>> set up with iomap->type = IOMAP_DELALLOC? Why can't that be used?
> 
> But this still stands - the first thing
> iomap_file_buffered_write_punch_delalloc() is:
> 
> 	if (iomap->type != IOMAP_DELALLOC)
>                 return 0;
> 

Thanks for the suggestion, the delalloc and non-delalloc write paths
share the same ->iomap_end() now (i.e. ext4_iomap_buffered_write_end()),
I use the IOMAP_F_EXT4_DELALLOC to identify the write path. For
non-delalloc path, If we have allocated more blocks and copied less, we
should truncate extra blocks that newly allocated by ->iomap_begin().
If we use IOMAP_DELALLOC, we can't tell if the blocks are pre-existing
or newly allocated, we can't truncate the pre-existing blocks, so I have
to introduce IOMAP_F_EXT4_DELALLOC. But if we split the delalloc and
non-delalloc handler, we could drop IOMAP_F_EXT4_DELALLOC.

I also checked xfs, IIUC, xfs doesn't free the extra blocks beyond EOF
in xfs_buffered_write_iomap_end() for non-delalloc case since they will
be freed by xfs_free_eofblocks in some other inactive paths, like
xfs_release()/xfs_inactive()/..., is that right?

Thanks,
Yi.


