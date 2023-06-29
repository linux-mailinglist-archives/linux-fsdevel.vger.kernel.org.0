Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20BCA742591
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 14:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbjF2MSb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 08:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjF2MS3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 08:18:29 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DA61719;
        Thu, 29 Jun 2023 05:18:27 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QsHXZ50QdzqVGh;
        Thu, 29 Jun 2023 20:18:06 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 29 Jun 2023 20:18:24 +0800
Message-ID: <0c3a4a8c-4f39-dd12-b98c-28805120b846@huawei.com>
Date:   Thu, 29 Jun 2023 20:18:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v2 7/7] quota: remove unused function put_dquot_list()
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
        <yangerkun@huawei.com>, <chengzhihao1@huawei.com>,
        <yukuai3@huawei.com>, Baokun Li <libaokun1@huawei.com>
References: <20230628132155.1560425-1-libaokun1@huawei.com>
 <20230628132155.1560425-8-libaokun1@huawei.com>
 <20230629110547.oppa5crrgzt6xrkf@quack3>
From:   Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20230629110547.oppa5crrgzt6xrkf@quack3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023/6/29 19:05, Jan Kara wrote:
> On Wed 28-06-23 21:21:55, Baokun Li wrote:
>> Now that no one is calling put_dquot_list(), remove it.
>>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> I guess you can merge this with patch 6. When there was only a single user,
> there's no good reason to separate the removal of the unused function...
>
> 								Honza
I got a warning when I compiled after I finished patch 6, and then there was
this patch. I will merge this patch into patch 6 in the next version.
>> ---
>>   fs/quota/dquot.c | 20 --------------------
>>   1 file changed, 20 deletions(-)
>>
>> diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
>> index df028fb2ce72..ba0125473be3 100644
>> --- a/fs/quota/dquot.c
>> +++ b/fs/quota/dquot.c
>> @@ -1102,26 +1102,6 @@ static void remove_inode_dquot_ref(struct inode *inode, int type)
>>   	dqput(dquot);
>>   }
>>   
>> -/*
>> - * Free list of dquots
>> - * Dquots are removed from inodes and no new references can be got so we are
>> - * the only ones holding reference
>> - */
>> -static void put_dquot_list(struct list_head *tofree_head)
>> -{
>> -	struct list_head *act_head;
>> -	struct dquot *dquot;
>> -
>> -	act_head = tofree_head->next;
>> -	while (act_head != tofree_head) {
>> -		dquot = list_entry(act_head, struct dquot, dq_free);
>> -		act_head = act_head->next;
>> -		/* Remove dquot from the list so we won't have problems... */
>> -		list_del_init(&dquot->dq_free);
>> -		dqput(dquot);
>> -	}
>> -}
>> -
>>   static void remove_dquot_ref(struct super_block *sb, int type)
>>   {
>>   	struct inode *inode;
>> -- 
>> 2.31.1
>>
Thanks!
-- 
With Best Regards,
Baokun Li
.
