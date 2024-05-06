Return-Path: <linux-fsdevel+bounces-18830-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 876A98BCE01
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 14:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0CA9B24A76
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 12:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A333E2744B;
	Mon,  6 May 2024 12:33:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980C4748F;
	Mon,  6 May 2024 12:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714998797; cv=none; b=GrP2ozyHrK5tt22LFqWEZk/5u7QJfgniweu8f8+ebO+ZoL50DDMuZPpXvSA2VJ3FichLBNMKKbLUU+3V3YVbWgwp+IzB3alk8RFc+mgYUyO9DiApWSQDycjZVKN7dg/qqxbtuc3NHv0rIgkWKYcgC31SmDZEELGQwNWGrwqypPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714998797; c=relaxed/simple;
	bh=DEA1KM0ghvQd+HuV8xLB5tsfrrm9padoKe5B5fuFlsE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=GR6KNQrJLoxZgefgdSmG4YcIsPXsa2v+8rsSGSoHTNnv8pPDPy/jndbPidrM5xMHVcGImZlXD5/Gp8qAsLBDw/MYOJdTPHxB4zkiEU9ZUeXjSVsighvHE6TkJK16iBveieoj157kHbpZLsO6zVQMennsQ/3hwlwHpUk1o+fBPxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VY15q13XZz4f3l85;
	Mon,  6 May 2024 20:33:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 642991A058D;
	Mon,  6 May 2024 20:33:08 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP2 (Coremail) with SMTP id Syh0CgDH6w4CzjhmXgPPMA--.59039S3;
	Mon, 06 May 2024 20:33:08 +0800 (CST)
Subject: Re: [RFC PATCH v4 27/34] ext4: implement zero_range iomap path
To: Dave Chinner <david@fromorbit.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, tytso@mit.edu,
 adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
 hch@infradead.org, djwong@kernel.org, willy@infradead.org,
 zokeefe@google.com, yi.zhang@huawei.com, chengzhihao1@huawei.com,
 yukuai3@huawei.com, wangkefeng.wang@huawei.com
References: <20240410142948.2817554-1-yi.zhang@huaweicloud.com>
 <20240410142948.2817554-28-yi.zhang@huaweicloud.com>
 <ZjIN9nuV6SaNODfE@dread.disaster.area>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <f59c3015-7029-9cd0-f5f0-087dfc1f24d0@huaweicloud.com>
Date: Mon, 6 May 2024 20:33:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZjIN9nuV6SaNODfE@dread.disaster.area>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgDH6w4CzjhmXgPPMA--.59039S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw1ktFWkGF4ktw15AF45Awb_yoW8Grykpr
	Z5KFy8Kr12gr97uFZ2gFZrXryFya13Gw48WrW3Jrn8Z343WryxKFyjgF1093W8X3y7A340
	vF1UW34Igw15AFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
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

On 2024/5/1 17:40, Dave Chinner wrote:
> On Wed, Apr 10, 2024 at 10:29:41PM +0800, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> Add ext4_iomap_zero_range() for the zero_range iomap path, it zero out
>> the mapped blocks, all work have been done in iomap_zero_range(), so
>> call it directly.
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>> ---
>>  fs/ext4/inode.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index 9d694c780007..5af3b8acf1b9 100644
>> --- a/fs/ext4/inode.c
>> +++ b/fs/ext4/inode.c
>> @@ -4144,6 +4144,13 @@ static int __ext4_block_zero_page_range(handle_t *handle,
>>  	return err;
>>  }
>>  
>> +static int ext4_iomap_zero_range(struct inode *inode,
>> +				 loff_t from, loff_t length)
>> +{
>> +	return iomap_zero_range(inode, from, length, NULL,
>> +				&ext4_iomap_buffered_read_ops);
>> +}
> 
> Zeroing is a buffered write operation, not a buffered read
> operation. It runs though iomap_write_begin(), so needs all the
> stale iomap detection stuff to be set up for correct operation.
> 

Yeah, right, thanks for point this out. Although we can guarantee
that the zeroing is a partial block overwrite and no need to
allocate new blocks on ext4, use ext4_iomap_buffered_read_ops is
not appropriate, I'll use write ops instead.

Thanks,
Yi.


