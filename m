Return-Path: <linux-fsdevel+bounces-3575-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0137E7F6A37
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 02:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7ACECB20F6A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 01:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E9A801;
	Fri, 24 Nov 2023 01:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B64120;
	Thu, 23 Nov 2023 17:41:21 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SbyPR5nM6z4f3jqs;
	Fri, 24 Nov 2023 09:41:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 896E91A04EC;
	Fri, 24 Nov 2023 09:41:18 +0800 (CST)
Received: from [10.174.176.34] (unknown [10.174.176.34])
	by APP1 (Coremail) with SMTP id cCh0CgCnqxE9_19lwb4RBw--.60567S3;
	Fri, 24 Nov 2023 09:41:18 +0800 (CST)
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
Message-ID: <bf5c6d35-b5d2-c85d-0c18-1e74433b88df@huaweicloud.com>
Date: Fri, 24 Nov 2023 09:41:17 +0800
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
X-CM-TRANSID:cCh0CgCnqxE9_19lwb4RBw--.60567S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw1DXry7tw1UXF47try5Arb_yoW8Xr18pr
	9Y9F40y3Z7tr1DWrn7trZ8Xa4Fv3W8tryxCryjgr4fZrs0yr93Kr1Fga4Y9FsYkr9xZr1S
	qr4kX3yFgF1xZrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IUbPEf5UUUUU==
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

Yeah, make sense. It looks fine in my first glance, I will check
is there are any side effects.

Thanks,
Yi.


