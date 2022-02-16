Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 675814B7DA7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Feb 2022 03:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343782AbiBPCgq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 21:36:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233597AbiBPCgp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 21:36:45 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE6623D
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Feb 2022 18:36:33 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Jz26L1TY2zZfTp;
        Wed, 16 Feb 2022 10:32:10 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Feb 2022 10:36:31 +0800
Subject: Re: [PATCH 02/10] mm/truncate: Inline invalidate_complete_page() into
 its one caller
To:     Matthew Wilcox <willy@infradead.org>
CC:     Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>
References: <20220214200017.3150590-1-willy@infradead.org>
 <20220214200017.3150590-3-willy@infradead.org>
 <71259221-bc5a-24d0-d7b9-46781d71473a@huawei.com>
 <YgwIgUIeWyOVeORI@casper.infradead.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <5aba3dfc-9483-bf4b-9f31-b513ce972035@huawei.com>
Date:   Wed, 16 Feb 2022 10:36:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YgwIgUIeWyOVeORI@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

On 2022/2/16 4:09, Matthew Wilcox wrote:
> On Tue, Feb 15, 2022 at 03:45:34PM +0800, Miaohe Lin wrote:
>>> @@ -309,7 +288,10 @@ int invalidate_inode_page(struct page *page)
>>>  		return 0;
>>>  	if (page_mapped(page))
>>>  		return 0;
>>> -	return invalidate_complete_page(mapping, page);
>>
>> It seems the checking of page->mapping != mapping is removed here.
>> IIUC, this would cause possibly unexpected side effect because
>> swapcache page can be invalidate now. I think this function is
>> not intended to deal with swapcache though it could do this.
> 
> You're right that it might now pass instead of being skipped.
> But it's not currently called for swapcache pages.  If we did want

AFAICS, __soft_offline_page might call invalidate_inode_page for swapcache page.
It only checks !PageHuge(page). Maybe __soft_offline_page should change to check
the flag or maybe it's fine to invalidate swapcache page there. I'm not sure...

> to prohibit swapcache pages explicitly, I'd rather we checked the
> flag instead of relying on page->mapping != page_mapping(page).

Agree.

> The intent of that check was "has it been truncated", not "is it
> swapcache".

Many thanks for clarifying this.

> 
> 
> .
> 
