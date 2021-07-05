Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1CE43BB596
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jul 2021 05:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbhGEDcX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Jul 2021 23:32:23 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:13066 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbhGEDcX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Jul 2021 23:32:23 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GJB1R38GJzZnFs;
        Mon,  5 Jul 2021 11:26:35 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 5 Jul 2021 11:29:45 +0800
Received: from [127.0.0.1] (10.174.179.0) by dggpemm500006.china.huawei.com
 (7.185.36.236) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 5 Jul 2021
 11:29:45 +0800
Subject: Re: [PATCH -next 1/1] iomap: Fix a false positive of UBSAN in
 iomap_seek_data()
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     "Darrick J . Wong" <djwong@kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210702092109.2601-1-thunder.leizhen@huawei.com>
 <YN7dn08eeUXfixJ7@infradead.org>
 <2ce02a7f-4b8b-5a86-13ee-097aff084f82@huawei.com>
Message-ID: <9a619cb0-e998-83e5-8e42-d3606ab682e0@huawei.com>
Date:   Mon, 5 Jul 2021 11:29:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <2ce02a7f-4b8b-5a86-13ee-097aff084f82@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.0]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2021/7/2 19:50, Leizhen (ThunderTown) wrote:
> 
> 
> On 2021/7/2 17:34, Christoph Hellwig wrote:
>> We might as well just kill off the length variable while we're at it:
> 
> Hi, Christoph:
>   Maybe you need to write a separate patch. Because the patch I sent is
> to modify function iomap_seek_data(). I didn't look at the other functions.
> In fact, both iomap_seek_data() and iomap_seek_hole() need to be modified.
> The iomap_seek_data() may not be intuitive to delete the variable 'length'.
> 
> I'm now analyzing if the "if (length <= 0)" statement in iomap_seek_data()
> is redundant (the condition is never true).

I've thought about it, and that "if" statement can be removed as follows:

diff --git a/fs/iomap/seek.c b/fs/iomap/seek.c
index dab1b02eba5b..dc55f9ecd948 100644
--- a/fs/iomap/seek.c
+++ b/fs/iomap/seek.c
@@ -96,14 +96,13 @@ iomap_seek_data(struct inode *inode, loff_t offset, const struct iomap_ops *ops)
 		if (ret < 0)
 			return ret;
 		if (ret == 0)
-			break;
+			return offset;

 		offset += ret;
 		length -= ret;
 	}

-	if (length <= 0)
-		return -ENXIO;
-	return offset;
+	/* The end of the file is reached, and no data is found */
+	return -ENXIO;
 }
 EXPORT_SYMBOL_GPL(iomap_seek_data);



> 
>>
>>
>> diff --git a/fs/iomap/seek.c b/fs/iomap/seek.c
>> index dab1b02eba5b7f..942e354e9e13e6 100644
>> --- a/fs/iomap/seek.c
>> +++ b/fs/iomap/seek.c
>> @@ -35,23 +35,21 @@ loff_t
>>  iomap_seek_hole(struct inode *inode, loff_t offset, const struct iomap_ops *ops)
>>  {
>>  	loff_t size = i_size_read(inode);
>> -	loff_t length = size - offset;
>>  	loff_t ret;
>>  
>>  	/* Nothing to be found before or beyond the end of the file. */
>>  	if (offset < 0 || offset >= size)
>>  		return -ENXIO;
>>  
>> -	while (length > 0) {
>> -		ret = iomap_apply(inode, offset, length, IOMAP_REPORT, ops,
>> -				  &offset, iomap_seek_hole_actor);
>> +	while (offset < size) {
>> +		ret = iomap_apply(inode, offset, size - offset, IOMAP_REPORT,
>> +				  ops, &offset, iomap_seek_hole_actor);
>>  		if (ret < 0)
>>  			return ret;
>>  		if (ret == 0)
>>  			break;
>>  
>>  		offset += ret;
>> -		length -= ret;
>>  	}
>>  
>>  	return offset;
>>
>> .
>>

