Return-Path: <linux-fsdevel+bounces-55423-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A5CB0A1F0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 13:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A0D6563347
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 11:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7724A2D94AF;
	Fri, 18 Jul 2025 11:30:18 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE222D3206;
	Fri, 18 Jul 2025 11:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752838218; cv=none; b=hjcpbziDJay04Di3huCPiRKAhHK0q6wRg6uiv4JsrI4pWHwseyz20cT9WEy5bzNSk3I42Bq5bP48/w/LWLm3MbQrkaklQPmqBwfTjhoC+vww7WfQSxyOUcUMB31idrzG0WQGqiadhRVCtEAOAK1x42fnG6hVGh1c3yTAWT6K0dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752838218; c=relaxed/simple;
	bh=UUVCBT6lKG/vOrflJdQpK6r+iw1jUuveLVSVaNg4mzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OwqKRYRsmwIXYvLQN8tnwEp9RWHhp7TZt+63/Jn1XLUFhfTbWXrGy6WyP/kmOyE94SDW2eUCm+zuKx0wJfWA5BRh7zmTxsoa0c9j4scAL0BiMKWiLaQdtRzXWPceQMJ+xVSpDAyLDYdAL6EHJ4PvOLCuhi7MVPklHYWUSbp0M/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bk6z94pvdzYQvRT;
	Fri, 18 Jul 2025 19:30:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 67B8E1A108A;
	Fri, 18 Jul 2025 19:30:12 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgBXIBFCMHpoxLmzAg--.29749S3;
	Fri, 18 Jul 2025 19:30:12 +0800 (CST)
Message-ID: <e6333d2d-cc30-44d3-8f23-6a6c5ea0134d@huaweicloud.com>
Date: Fri, 18 Jul 2025 19:30:10 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/7] iomap: optional zero range dirty folio processing
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-mm@kvack.org, hch@infradead.org, willy@infradead.org,
 "Darrick J. Wong" <djwong@kernel.org>,
 Ext4 Developers List <linux-ext4@vger.kernel.org>
References: <20250714204122.349582-1-bfoster@redhat.com>
 <20250714204122.349582-4-bfoster@redhat.com>
 <20250715052259.GO2672049@frogsfrogsfrogs>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20250715052259.GO2672049@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBXIBFCMHpoxLmzAg--.29749S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCrW5uw45tr1UXF4kGrWrAFb_yoW5ZFyUpF
	WDKFs0yr4kX347Xwn3JF4kAryFy39ava1UGry7GwnIv3s0gr1IkF10ka4Y9F15Wr1rCF42
	vr4jya4xWF1YyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUymb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UK2NtUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2025/7/15 13:22, Darrick J. Wong wrote:
> On Mon, Jul 14, 2025 at 04:41:18PM -0400, Brian Foster wrote:
>> The only way zero range can currently process unwritten mappings
>> with dirty pagecache is to check whether the range is dirty before
>> mapping lookup and then flush when at least one underlying mapping
>> is unwritten. This ordering is required to prevent iomap lookup from
>> racing with folio writeback and reclaim.
>>
>> Since zero range can skip ranges of unwritten mappings that are
>> clean in cache, this operation can be improved by allowing the
>> filesystem to provide a set of dirty folios that require zeroing. In
>> turn, rather than flush or iterate file offsets, zero range can
>> iterate on folios in the batch and advance over clean or uncached
>> ranges in between.
>>
>> Add a folio_batch in struct iomap and provide a helper for fs' to
> 
> /me confused by the single quote; is this supposed to read:
> 
> "...for the fs to populate..."?
> 
> Either way the code changes look like a reasonable thing to do for the
> pagecache (try to grab a bunch of dirty folios while XFS holds the
> mapping lock) so
> 
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> 
> --D
> 
> 
>> populate the batch at lookup time. Update the folio lookup path to
>> return the next folio in the batch, if provided, and advance the
>> iter if the folio starts beyond the current offset.
>>
>> Signed-off-by: Brian Foster <bfoster@redhat.com>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> ---
>>  fs/iomap/buffered-io.c | 89 +++++++++++++++++++++++++++++++++++++++---
>>  fs/iomap/iter.c        |  6 +++
>>  include/linux/iomap.h  |  4 ++
>>  3 files changed, 94 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
>> index 38da2fa6e6b0..194e3cc0857f 100644
>> --- a/fs/iomap/buffered-io.c
>> +++ b/fs/iomap/buffered-io.c
[...]
>> @@ -1398,6 +1452,26 @@ static int iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
>>  	return status;
>>  }
>>  
>> +loff_t
>> +iomap_fill_dirty_folios(
>> +	struct iomap_iter	*iter,
>> +	loff_t			offset,
>> +	loff_t			length)
>> +{
>> +	struct address_space	*mapping = iter->inode->i_mapping;
>> +	pgoff_t			start = offset >> PAGE_SHIFT;
>> +	pgoff_t			end = (offset + length - 1) >> PAGE_SHIFT;
>> +
>> +	iter->fbatch = kmalloc(sizeof(struct folio_batch), GFP_KERNEL);
>> +	if (!iter->fbatch)

Hi, Brian!

I think ext4 needs to be aware of this failure after it converts to use
iomap infrastructure. It is because if we fail to add dirty folios to the
fbatch, iomap_zero_range() will flush those unwritten and dirty range.
This could potentially lead to a deadlock, as most calls to
ext4_block_zero_page_range() occur under an active journal handle.
Writeback operations under an active journal handle may result in circular
waiting within journal transactions. So please return this error code, and
then ext4 can interrupt zero operations to prevent deadlock.

Thanks,
Yi.

>> +		return offset + length;
>> +	folio_batch_init(iter->fbatch);
>> +
>> +	filemap_get_folios_dirty(mapping, &start, end, iter->fbatch);
>> +	return (start << PAGE_SHIFT);
>> +}
>> +EXPORT_SYMBOL_GPL(iomap_fill_dirty_folios);


