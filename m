Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA60742572
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 14:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbjF2MNL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 08:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjF2MNK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 08:13:10 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CAF4E6C;
        Thu, 29 Jun 2023 05:13:09 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QsHM70jxMzMpYQ;
        Thu, 29 Jun 2023 20:09:55 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 29 Jun 2023 20:13:06 +0800
Message-ID: <d00a224e-1991-ce90-d458-45390a20f8dc@huawei.com>
Date:   Thu, 29 Jun 2023 20:13:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v2 6/7] quota: simplify drop_dquot_ref()
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
        <yangerkun@huawei.com>, <chengzhihao1@huawei.com>,
        <yukuai3@huawei.com>, Baokun Li <libaokun1@huawei.com>
References: <20230628132155.1560425-1-libaokun1@huawei.com>
 <20230628132155.1560425-7-libaokun1@huawei.com>
 <20230629110813.kfaja4bdomilmns6@quack3>
From:   Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20230629110813.kfaja4bdomilmns6@quack3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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

On 2023/6/29 19:08, Jan Kara wrote:
> On Wed 28-06-23 21:21:54, Baokun Li wrote:
>> Now when dqput() drops the last reference count, it will call
>> synchronize_srcu(&dquot_srcu) in quota_release_workfn() to ensure that
>> no other user will use the dquot after the last reference count is dropped,
>> so we don't need to call synchronize_srcu(&dquot_srcu) in drop_dquot_ref()
>> and remove the corresponding logic directly to simplify the code.
> Nice simplification!  It is also important that dqput() now cannot sleep
> which was another reason for the logic with tofree_head in
> remove_inode_dquot_ref().

I don't understand this sentence very well, so I would appreciate it

if you could explain it in detail. 🤔

> Probably this is good to mention in the
> changelog.
>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> ---
>>   fs/quota/dquot.c | 33 ++++++---------------------------
>>   1 file changed, 6 insertions(+), 27 deletions(-)
>>
>> diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
>> index e8e702ac64e5..df028fb2ce72 100644
>> --- a/fs/quota/dquot.c
>> +++ b/fs/quota/dquot.c
>> @@ -1090,8 +1090,7 @@ static int add_dquot_ref(struct super_block *sb, int type)
>>    * Remove references to dquots from inode and add dquot to list for freeing
>>    * if we have the last reference to dquot
>>    */
>> -static void remove_inode_dquot_ref(struct inode *inode, int type,
>> -				   struct list_head *tofree_head)
>> +static void remove_inode_dquot_ref(struct inode *inode, int type)
>>   {
>>   	struct dquot **dquots = i_dquot(inode);
>>   	struct dquot *dquot = dquots[type];
>> @@ -1100,21 +1099,7 @@ static void remove_inode_dquot_ref(struct inode *inode, int type,
>>   		return;
>>   
>>   	dquots[type] = NULL;
>> -	if (list_empty(&dquot->dq_free)) {
>> -		/*
>> -		 * The inode still has reference to dquot so it can't be in the
>> -		 * free list
>> -		 */
>> -		spin_lock(&dq_list_lock);
>> -		list_add(&dquot->dq_free, tofree_head);
>> -		spin_unlock(&dq_list_lock);
>> -	} else {
>> -		/*
>> -		 * Dquot is already in a list to put so we won't drop the last
>> -		 * reference here.
>> -		 */
>> -		dqput(dquot);
>> -	}
>> +	dqput(dquot);
>>   }
> I think you can also just drop remove_inode_dquot_ref() as it is trivial
> now and inline it at its only callsite...
>
> 								Honza
Sure, I'll just remove it in the next version and inline the only 
remaining code
into remove_dquot_ref().

Thanks!
-- 
With Best Regards,
Baokun Li
.
