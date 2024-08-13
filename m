Return-Path: <linux-fsdevel+bounces-25753-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FD394FBF8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 04:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A86222831D2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 02:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09531F95E;
	Tue, 13 Aug 2024 02:49:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A435E1E86A;
	Tue, 13 Aug 2024 02:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723517371; cv=none; b=XEzZdZDy6rc1bRSaFfwrFQTVTZEgZDQUpWO3Otu/sAmsjeuwLY/ru7gYYnY1X3FHtHDuJJ3VtPWVqQNcBiic4Z9DSEnVPCVeecCzXMpSHLP+5PSmWr3pOufVBBl95Jk/cU42q7PTpakDzcg3r+RClYod3mSGRmPANlIHEXjypkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723517371; c=relaxed/simple;
	bh=hQKnZrBwQM09zuJSipp9urEd+Q+xJzQsaB5ZluAZ2UU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=dPziTh8A7xroTv/h8onfOWYITX1WVAjCbj0et1tjZyqk3v20oAV1YyMR5LV4cIlhMEaEsYbsHponYRowNc05iivtLbU8RxKHpV00ljyN3XsKBCnBce0ZS2UTyjP0bbTxX1ksSv76/rgnLqXskbT0ymUscCyC9/TN3WXbhLUcO/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WjbSV36mNz4f3jZQ;
	Tue, 13 Aug 2024 10:49:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B2E1A1A07BA;
	Tue, 13 Aug 2024 10:49:23 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgBnj4WxybpmnD0rBg--.782S3;
	Tue, 13 Aug 2024 10:49:23 +0800 (CST)
Subject: Re: [PATCH v2 4/6] iomap: correct the dirty length in page mkwrite
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, hch@infradead.org, brauner@kernel.org,
 david@fromorbit.com, jack@suse.cz, willy@infradead.org, yi.zhang@huawei.com,
 chengzhihao1@huawei.com, yukuai3@huawei.com
References: <20240812121159.3775074-1-yi.zhang@huaweicloud.com>
 <20240812121159.3775074-5-yi.zhang@huaweicloud.com>
 <20240812164536.GE6043@frogsfrogsfrogs>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <0ee2814f-2878-bcff-7baf-703327091805@huaweicloud.com>
Date: Tue, 13 Aug 2024 10:49:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240812164536.GE6043@frogsfrogsfrogs>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBnj4WxybpmnD0rBg--.782S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ury5AFW7WFy7tr4xXw1DWrg_yoW8Kw1DpF
	WDKFWqkr48J3Zruwn3Ar1Yvr10kr9xXw40yF17W343AFn8ur12gr1UK3Wj9F1xKr13Aw4S
	vF4jqa4xXFyjyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUF1v3UUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/8/13 0:45, Darrick J. Wong wrote:
> On Mon, Aug 12, 2024 at 08:11:57PM +0800, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> When doing page mkwrite, iomap_folio_mkwrite_iter() dirty the entire
>> folio by folio_mark_dirty() even the map length is shorter than one
>> folio. However, on the filesystem with more than one blocks per folio,
>> we'd better to only set counterpart block's dirty bit according to
>> iomap_length(), so open code folio_mark_dirty() and pass the correct
>> length.
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>> ---
>>  fs/iomap/buffered-io.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
>> index 79031b7517e5..ac762de9a27f 100644
>> --- a/fs/iomap/buffered-io.c
>> +++ b/fs/iomap/buffered-io.c
>> @@ -1492,7 +1492,10 @@ static loff_t iomap_folio_mkwrite_iter(struct iomap_iter *iter,
>>  		block_commit_write(&folio->page, 0, length);
>>  	} else {
>>  		WARN_ON_ONCE(!folio_test_uptodate(folio));
>> -		folio_mark_dirty(folio);
>> +
>> +		ifs_alloc(iter->inode, folio, 0);
>> +		iomap_set_range_dirty(folio, 0, length);
>> +		filemap_dirty_folio(iter->inode->i_mapping, folio);
> 
> Is it correct to be doing a lot more work by changing folio_mark_dirty
> to filemap_dirty_folio?  Now pagefaults call __mark_inode_dirty which
> they did not before.  Also, the folio itself must be marked dirty if any
> of the ifs bitmap is marked dirty, so I don't understand the change
> here.
> 

This change is just open code iomap_dirty_folio() and correct the length
that passing to iomap_set_range_dirty().

bool iomap_dirty_folio(struct address_space *mapping, struct folio *folio)
{
	struct inode *inode = mapping->host;
	size_t len = folio_size(folio);
...
	ifs_alloc(inode, folio, 0);
	iomap_set_range_dirty(folio, 0, len);
	return filemap_dirty_folio(mapping, folio);
}

Before this change, the code also call filemap_dirty_folio() (though
folio_mark_dirty()->iomap_dirty_folio()->filemap_dirty_folio()), so it call
__mark_inode_dirty() too. After this change, filemap_dirty_folio()->
folio_test_set_dirty() will mark the folio dirty. Hence there is no
difference between the two points you mentioned. Am I missing something?

Thanks,
Yi.

> 
>>  	}
>>  
>>  	return length;
>> -- 
>> 2.39.2
>>
>>


