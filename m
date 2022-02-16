Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF034B7DC6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Feb 2022 03:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343871AbiBPCpv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 21:45:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343868AbiBPCpu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 21:45:50 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3B0FBA73
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Feb 2022 18:45:39 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Jz2Jr29D7zZfd2;
        Wed, 16 Feb 2022 10:41:16 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Feb 2022 10:45:37 +0800
Subject: Re: [PATCH 08/10] mm: Turn deactivate_file_page() into
 deactivate_file_folio()
To:     Matthew Wilcox <willy@infradead.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20220214200017.3150590-1-willy@infradead.org>
 <20220214200017.3150590-9-willy@infradead.org>
 <56e09280-c1dd-6bdb-81f0-524af99c5f4f@huawei.com>
 <YgwOLye/QnBXCuL0@casper.infradead.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <59c2bef7-d41e-5801-7fc7-e3db77417b2b@huawei.com>
Date:   Wed, 16 Feb 2022 10:45:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YgwOLye/QnBXCuL0@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022/2/16 4:33, Matthew Wilcox wrote:
> On Tue, Feb 15, 2022 at 04:26:22PM +0800, Miaohe Lin wrote:
>>> +	folio_get(folio);
>>
>> Should we comment the assumption that caller already hold the refcnt?
> 
> Added to the kernel-doc:
> + * Context: Caller holds a reference on the page.
> 

I see. Thanks.

>> Anyway, this patch looks good to me. Thanks.
>>
>> Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
>>
>>> +	local_lock(&lru_pvecs.lock);
>>> +	pvec = this_cpu_ptr(&lru_pvecs.lru_deactivate_file);
>>>  
>>> -		if (pagevec_add_and_need_flush(pvec, page))
>>> -			pagevec_lru_move_fn(pvec, lru_deactivate_file_fn);
>>> -		local_unlock(&lru_pvecs.lock);
>>> -	}
>>> +	if (pagevec_add_and_need_flush(pvec, &folio->page))
>>> +		pagevec_lru_move_fn(pvec, lru_deactivate_file_fn);
>>> +	local_unlock(&lru_pvecs.lock);
>>>  }
>>>  
>>>  /*
>>> diff --git a/mm/truncate.c b/mm/truncate.c
>>> index 567557c36d45..14486e75ec28 100644
>>> --- a/mm/truncate.c
>>> +++ b/mm/truncate.c
>>> @@ -525,7 +525,7 @@ static unsigned long __invalidate_mapping_pages(struct address_space *mapping,
>>>  			 * of interest and try to speed up its reclaim.
>>>  			 */
>>>  			if (!ret) {
>>> -				deactivate_file_page(&folio->page);
>>> +				deactivate_file_folio(folio);
>>>  				/* It is likely on the pagevec of a remote CPU */
>>>  				if (nr_pagevec)
>>>  					(*nr_pagevec)++;
>>>
>>
>>
> .
> 

