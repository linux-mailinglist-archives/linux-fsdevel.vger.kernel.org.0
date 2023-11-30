Return-Path: <linux-fsdevel+bounces-4372-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1084F7FEF4D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 13:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41B011C209A1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 12:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CD84779D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 12:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E1C10F8;
	Thu, 30 Nov 2023 04:26:33 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4SgwR83CWnz4f3lwS;
	Thu, 30 Nov 2023 20:26:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 6C9E21A087A;
	Thu, 30 Nov 2023 20:26:30 +0800 (CST)
Received: from [10.174.176.34] (unknown [10.174.176.34])
	by APP1 (Coremail) with SMTP id cCh0CgDX2xF0f2hlDKFrCQ--.55161S3;
	Thu, 30 Nov 2023 20:26:30 +0800 (CST)
Subject: Re: [RFC PATCH 12/18] iomap: don't increase i_size if it's not a
 write operation
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, tytso@mit.edu,
 adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
 djwong@kernel.org, yi.zhang@huawei.com, chengzhihao1@huawei.com,
 yukuai3@huawei.com
References: <20231123125121.4064694-1-yi.zhang@huaweicloud.com>
 <20231123125121.4064694-13-yi.zhang@huaweicloud.com>
 <ZV9xFt1WhLIoULyc@infradead.org>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <8c697498-8c29-b752-5b6b-5698d916d056@huaweicloud.com>
Date: Thu, 30 Nov 2023 20:26:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZV9xFt1WhLIoULyc@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgDX2xF0f2hlDKFrCQ--.55161S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw1DXry7tw1UXF47try5Arb_yoW8AF1rpr
	909F40k3Z7tr1q9rnrtrZ0qa4Fq3W8try7Cryjkr4fZr1DAFyIgr1rWa4Y9FWFkr9xAr4S
	qr4kZ3yrWF1xZ3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07UWE__UUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2023/11/23 23:34, Christoph Hellwig wrote:
> On Thu, Nov 23, 2023 at 08:51:14PM +0800, Zhang Yi wrote:
>> index fd4d43bafd1b..3b9ba390dd1b 100644
>> --- a/fs/iomap/buffered-io.c
>> +++ b/fs/iomap/buffered-io.c
>> @@ -852,13 +852,13 @@ static size_t iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
>>  	 * cache.  It's up to the file system to write the updated size to disk,
>>  	 * preferably after I/O completion so that no stale data is exposed.
>>  	 */
>> -	if (pos + ret > old_size) {
>> +	if ((iter->flags & IOMAP_WRITE) && pos + ret > old_size) {
>>  		i_size_write(iter->inode, pos + ret);
>>  		iter->iomap.flags |= IOMAP_F_SIZE_CHANGED;
>>  	}
>>  	__iomap_put_folio(iter, pos, ret, folio);
>>  
>> -	if (old_size < pos)
>> +	if ((iter->flags & IOMAP_WRITE) && old_size < pos)
>>  		pagecache_isize_extended(iter->inode, old_size, pos);
>>  	if (ret < len)
>>  		iomap_write_failed(iter->inode, pos + ret, len - ret);
> 
> I agree with your rationale, but I hate how this code ends up
> looking.  In many ways iomap_write_end seems like the wrong
> place to update the inode size anyway.  I've not done a deep
> analysis, but I think there shouldn't really be any major blocker
> to only setting IOMAP_F_SIZE_CHANGED in iomap_write_end, and then
> move updating i_size and calling pagecache_isize_extended to
> iomap_write_iter.
> 

Think about it in depth, I think we cannot move updating i_size
to iomap_write_iter() because we have to do this under folio lock,
otherwise, once we unlock folio, the writeback process could start
writing back and call folio_zero_segment() to zero out the valid
data beyond the unupdated i_size. Only if we move
__iomap_put_folio() out together, but I suppose it's not a good
way.

Thanks,
Yi.


