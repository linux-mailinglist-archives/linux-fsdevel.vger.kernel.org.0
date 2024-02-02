Return-Path: <linux-fsdevel+bounces-9970-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 839C5846B73
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 10:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2297C2811CD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 09:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA1061674;
	Fri,  2 Feb 2024 09:02:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DCA62162;
	Fri,  2 Feb 2024 09:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706864529; cv=none; b=VUUWh2eb77VZzwCuH396apu01wlEqFk2IqT+p4uK1zBTmpsPwVzFjK2XDqBnvGyz8PdGVBAzBEhF8zeBotKryk3W3A6OjQc497WZwNFU++dMBHH9ytsbSGFXd7xEy/qH69DBD+tk7UH7J7uIdjnJ6iT7xxiO1xKH7SYQN9swHis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706864529; c=relaxed/simple;
	bh=aHzEmoPoxsCtAcAXqMLjI12v8AWic6XYoYlNqsGWalQ=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ciTAJwlAtgsQe4zonSSVlkWIrzrg3d8TkUt0BLjayZCaxSEEh9wQwQSRTFbbyyDkbKVSZUNqWAA34vL9crScXo0akCVdzi8rx24fW0oD04aeF7/1rkZQcifE4CXoOF/ZIXV5aHN2hhTWVtBrzQuRLMC/iCSqDbUTth21UOZrMCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4TR8r34knvzXh7G;
	Fri,  2 Feb 2024 17:00:35 +0800 (CST)
Received: from dggpemd200004.china.huawei.com (unknown [7.185.36.141])
	by mail.maildlp.com (Postfix) with ESMTPS id 688AD140114;
	Fri,  2 Feb 2024 17:02:01 +0800 (CST)
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemd200004.china.huawei.com (7.185.36.141) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Fri, 2 Feb 2024 17:02:00 +0800
Subject: Re: [PATCH 2/2] mm/readahead: limit sync readahead while too many
 active refault
To: Jan Kara <jack@suse.cz>
References: <20240201100835.1626685-1-liushixin2@huawei.com>
 <20240201100835.1626685-3-liushixin2@huawei.com>
 <20240201093749.ll7uzgt7ixy7kkhw@quack3>
 <c768cab9-4ccb-9618-24a8-b51d3f141340@huawei.com>
 <20240201173130.frpaqpy7iyzias5j@quack3>
CC: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
	<brauner@kernel.org>, Matthew Wilcox <willy@infradead.org>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
From: Liu Shixin <liushixin2@huawei.com>
Message-ID: <78ee0c12-e706-875d-2baf-cb51dea9cfc4@huawei.com>
Date: Fri, 2 Feb 2024 17:02:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240201173130.frpaqpy7iyzias5j@quack3>
Content-Type: multipart/mixed;
	boundary="------------851C32ACB350EF2108EAD576"
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemd200004.china.huawei.com (7.185.36.141)

--------------851C32ACB350EF2108EAD576
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit



On 2024/2/2 1:31, Jan Kara wrote:
> On Thu 01-02-24 18:41:30, Liu Shixin wrote:
>> On 2024/2/1 17:37, Jan Kara wrote:
>>> On Thu 01-02-24 18:08:35, Liu Shixin wrote:
>>>> When the pagefault is not for write and the refault distance is close,
>>>> the page will be activated directly. If there are too many such pages in
>>>> a file, that means the pages may be reclaimed immediately.
>>>> In such situation, there is no positive effect to read-ahead since it will
>>>> only waste IO. So collect the number of such pages and when the number is
>>>> too large, stop bothering with read-ahead for a while until it decreased
>>>> automatically.
>>>>
>>>> Define 'too large' as 10000 experientially, which can solves the problem
>>>> and does not affect by the occasional active refault.
>>>>
>>>> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
>>> So I'm not convinced this new logic is needed. We already have
>>> ra->mmap_miss which gets incremented when a page fault has to read the page
>>> (and decremented when a page fault found the page already in cache). This
>>> should already work to detect trashing as well, shouldn't it? If it does
>>> not, why?
>>>
>>> 								Honza
>> ra->mmap_miss doesn't help, it increased only one in do_sync_mmap_readahead()
>> and then decreased one for every page in filemap_map_pages(). So in this scenario,
>> it can't exceed MMAP_LOTSAMISS.
> I see, OK. But that's a (longstanding) bug in how mmap_miss is handled. Can
> you please test whether attached patches fix the trashing for you? At least
> now I can see mmap_miss properly increments when we are hitting uncached
> pages...  Thanks!
>
> 								Honza
The patch doesn't seem to have much effect. I will try to analyze why it doesn't work.
The attached file is my testcase.

Thanks,
>


--------------851C32ACB350EF2108EAD576
Content-Type: text/plain; charset="UTF-8"; name="test.sh"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="test.sh"

#!/bin/bash
  
while true; do
    flag=$(ps -ef | grep -v grep | grep alloc_page| wc -l)
    if [ "$flag" -eq 0 ]; then
        /alloc_page &
    fi

    sleep 30

    start_time=$(date +%s)
    yum install -y expect > /dev/null 2>&1

    end_time=$(date +%s)

    elapsed_time=$((end_time - start_time))

    echo "$elapsed_time seconds"
    yum remove -y expect > /dev/null 2>&1
done
--------------851C32ACB350EF2108EAD576
Content-Type: text/plain; charset="UTF-8"; name="alloc_page.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="alloc_page.c"

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

#define SIZE 1*1024*1024 //1M

int main()
{
    void *ptr = NULL;
    int i;

    for (i = 0; i < 1024 * 6 - 50;i++) {
        ptr = (void *) malloc(SIZE);
        if (ptr == NULL) {
            printf("malloc err!");
            return -1;
        }

        memset(ptr, 0, SIZE);
    }

    sleep(99999);

    free(ptr);
    return 0;
}
--------------851C32ACB350EF2108EAD576--

