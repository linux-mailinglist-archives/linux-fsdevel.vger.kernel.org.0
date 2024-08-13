Return-Path: <linux-fsdevel+bounces-25754-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF4B94FC0F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 05:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DAFA281D5A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 03:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C051B28A;
	Tue, 13 Aug 2024 03:01:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D33E4C8C;
	Tue, 13 Aug 2024 03:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723518107; cv=none; b=NlZEGatp3g1W+5i78qyn0R5vwrKFeFwWdxf5HW9x7bKp0cvRkEoqV5EJgrok9hetDXJJJ45L/3+ZeTT6Mi9k7eBAExU29qGhZF+GLuoFrE9jXN7NiZxN/H2/9bo/vwTJiHVCCmW+rjmPD+1cn6a5KW7cWlg052gzUTHHhogYH0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723518107; c=relaxed/simple;
	bh=jm2reYs+G6A80eJrvZtYWfDcDiV6BG2XZDJ5QsPyTOE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=nOAwJZxBsrSOW1KyX3JMGGPZhKQouETOW20o8S2a+mH/KK0NhnGom2f9zQIEXf39DJUobeiL0ovtjkYK4SheeRk+Q66Y/Q+59Dg0P7krvOL+4Z3jJFsiToIvcascjYuinH+QAbMLCTSE7hWoxIACC3Q4AEbBoyytk280NUcmx20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WjbkY6BpHz4f3jMD;
	Tue, 13 Aug 2024 11:01:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 885E91A0568;
	Tue, 13 Aug 2024 11:01:39 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgBXzIKQzLpm2RAsBg--.33905S3;
	Tue, 13 Aug 2024 11:01:37 +0800 (CST)
Subject: Re: [PATCH v2 5/6] iomap: don't mark blocks uptodate after partial
 zeroing
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, hch@infradead.org, brauner@kernel.org,
 david@fromorbit.com, jack@suse.cz, willy@infradead.org, yi.zhang@huawei.com,
 chengzhihao1@huawei.com, yukuai3@huawei.com
References: <20240812121159.3775074-1-yi.zhang@huaweicloud.com>
 <20240812121159.3775074-6-yi.zhang@huaweicloud.com>
 <20240812164912.GF6043@frogsfrogsfrogs>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <d3774e9f-ac6d-7ac3-257f-b8f37cc52544@huaweicloud.com>
Date: Tue, 13 Aug 2024 11:01:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240812164912.GF6043@frogsfrogsfrogs>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBXzIKQzLpm2RAsBg--.33905S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ury5uFy5Jw1kAF43uw4Durg_yoW8Cr18pF
	Z8KFWqkr1kKFZru3W8AF13Zr10y39Igr4fCr47Wwn8uF45tr42gr9Fga1a9F1Fvry7Cr4F
	vr4vgFy8uF15ZrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

On 2024/8/13 0:49, Darrick J. Wong wrote:
> On Mon, Aug 12, 2024 at 08:11:58PM +0800, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> In __iomap_write_begin(), if we unaligned buffered write data to a hole
>> of a regular file, we only zero out the place where aligned to block
>> size that we don't want to write, but mark the whole range uptodate if
>> block size < folio size. This is wrong since the not zeroed part will
>> contains stale data and can be accessed by a concurrent buffered read
>> easily (on the filesystem may not hold inode->i_rwsem) once we mark the
>> range uptodate. Fix this by drop iomap_set_range_uptodate() in the
>> zeroing out branch.
>>
>> Fixes: 9dc55f1389f9 ("iomap: add support for sub-pagesize buffered I/O without buffer heads")
>> Reported-by: Matthew Wilcox <willy@infradead.org>
>> Closes: https://lore.kernel.org/all/ZqsN5ouQTEc1KAzV@casper.infradead.org/
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>> ---
>>  fs/iomap/buffered-io.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
>> index ac762de9a27f..96600405dbb5 100644
>> --- a/fs/iomap/buffered-io.c
>> +++ b/fs/iomap/buffered-io.c
>> @@ -744,8 +744,8 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
>>  					poff, plen, srcmap);
>>  			if (status)
>>  				return status;
>> +			iomap_set_range_uptodate(folio, poff, plen);
>>  		}
>> -		iomap_set_range_uptodate(folio, poff, plen);
> 
> Don't we need to iomap_set_range_uptodate for the bytes that we zeroed
> with folio_zero_segments?
> 

We must do partial block zeroing here, hence we don't need to set update
bit.

Thanks,
Yi.

> --D
> 
>>  	} while ((block_start += plen) < block_end);
>>  
>>  	return 0;
>> -- 
>> 2.39.2
>>
>>


