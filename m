Return-Path: <linux-fsdevel+bounces-25751-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A494794FBBD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 04:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DCABB22118
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 02:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C82214F6C;
	Tue, 13 Aug 2024 02:21:44 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942231862A;
	Tue, 13 Aug 2024 02:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723515704; cv=none; b=n3LOhjV+o4Z6xvu2V0e3SNed5vye+vkhYMKZ6C3Vg4w9Pj3B6++w5xBhKVAxb/9NT9deyboCfsfwe/xxk5mfw+TH8OURh8EYG9L2/oQcG7wrn56yVwfHwNCt1FMotoDNGwKLyzc869RBu1WmtPzIVTjypJLfqeb6sc8QZRtAQFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723515704; c=relaxed/simple;
	bh=CWDikRhvACJ6VTavQgtCFQU2sXIpkGz0NQquxrwT4Hw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=f6TDa//LwhYT1vDmOs10xG6UHPnq5QQQVx7o81wpTT5EprIWqj3g/3cA0o4GL9xAe2w5OM0e2Qtmkmq6HFEQbBI9qAVZ27HDiIbNkzmGtOlAwQEeX89ZOgKatT4pNtLy0UltYhv127zn4c25yldaiJaiTay069YqHkuC+DIDmJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WjZrL2CmBz4f3jM9;
	Tue, 13 Aug 2024 10:21:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id F323E1A1645;
	Tue, 13 Aug 2024 10:21:35 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgBXfoQvw7pmIV0pBg--.64234S3;
	Tue, 13 Aug 2024 10:21:35 +0800 (CST)
Subject: Re: [PATCH v2 3/6] iomap: advance the ifs allocation if we have more
 than one blocks per folio
To: yangerkun <yangerkun@huawei.com>, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, djwong@kernel.org, hch@infradead.org,
 brauner@kernel.org, david@fromorbit.com, jack@suse.cz, willy@infradead.org,
 yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
References: <20240812121159.3775074-1-yi.zhang@huaweicloud.com>
 <20240812121159.3775074-4-yi.zhang@huaweicloud.com>
 <137c8c6e-ead3-51ed-be5a-c8eba0be3a2d@huawei.com>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <02adb965-ad95-2b75-f48a-51a4b75ad88b@huaweicloud.com>
Date: Tue, 13 Aug 2024 10:21:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <137c8c6e-ead3-51ed-be5a-c8eba0be3a2d@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXfoQvw7pmIV0pBg--.64234S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXFyUKr4ftr4DZw18Zw4fXwb_yoW5WFy8pr
	4kKFWUGrWxJrn3urnrtFyUZryUt3yUJ3WUGr48W3W7XF4UJr1jgr4UWFyq9F1UXr4xJr48
	Xr1jqryxuF15Ar7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUOBMKDUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/8/12 20:47, yangerkun wrote:
> 
> 
> 在 2024/8/12 20:11, Zhang Yi 写道:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> Now we allocate ifs if i_blocks_per_folio is larger than one when
>> writing back dirty folios in iomap_writepage_map(), so we don't attach
>> an ifs after buffer write to an entire folio until it starts writing
>> back, if we partial truncate that folio, iomap_invalidate_folio() can't
>> clear counterpart block's dirty bit as expected. Fix this by advance the
>> ifs allocation to __iomap_write_begin().
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>> ---
>>   fs/iomap/buffered-io.c | 17 ++++++++++++-----
>>   1 file changed, 12 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
>> index 763deabe8331..79031b7517e5 100644
>> --- a/fs/iomap/buffered-io.c
>> +++ b/fs/iomap/buffered-io.c
>> @@ -699,6 +699,12 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
>>       size_t from = offset_in_folio(folio, pos), to = from + len;
>>       size_t poff, plen;
>>   +    if (nr_blocks > 1) {
>> +        ifs = ifs_alloc(iter->inode, folio, iter->flags);
>> +        if ((iter->flags & IOMAP_NOWAIT) && !ifs)
>> +            return -EAGAIN;
>> +    }
>> +
>>       /*
>>        * If the write or zeroing completely overlaps the current folio, then
>>        * entire folio will be dirtied so there is no need for
> 
> The comments upper need change too.

Will update as well, thanks for pointing this out.

Thanks,
Yi.

> 
> 
>> @@ -710,10 +716,6 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
>>           pos + len >= folio_pos(folio) + folio_size(folio))
>>           return 0;
>>   -    ifs = ifs_alloc(iter->inode, folio, iter->flags);
>> -    if ((iter->flags & IOMAP_NOWAIT) && !ifs && nr_blocks > 1)
>> -        return -EAGAIN;
>> -
>>       if (folio_test_uptodate(folio))
>>           return 0;
>>   @@ -1928,7 +1930,12 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>>       WARN_ON_ONCE(end_pos <= pos);
>>         if (i_blocks_per_folio(inode, folio) > 1) {
>> -        if (!ifs) {
>> +        /*
>> +         * This should not happen since we always allocate ifs in
>> +         * iomap_folio_mkwrite_iter() and there is more than one
>> +         * blocks per folio in __iomap_write_begin().
>> +         */
>> +        if (WARN_ON_ONCE(!ifs)) {
>>               ifs = ifs_alloc(inode, folio, 0);
>>               iomap_set_range_dirty(folio, 0, end_pos - pos);
>>           }


