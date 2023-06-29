Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36AC07424DB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 13:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbjF2LPR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 07:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232165AbjF2LPA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 07:15:00 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123E4125;
        Thu, 29 Jun 2023 04:14:55 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QsG3y0q7YzMpbG;
        Thu, 29 Jun 2023 19:11:42 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 29 Jun 2023 19:14:53 +0800
Message-ID: <20dddac7-8f01-2d37-02d2-f63c8bcfbf25@huawei.com>
Date:   Thu, 29 Jun 2023 19:14:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v2 3/7] quota: rename dquot_active() to
 inode_dquot_active()
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
        <yangerkun@huawei.com>, <chengzhihao1@huawei.com>,
        <yukuai3@huawei.com>, Baokun Li <libaokun1@huawei.com>
References: <20230628132155.1560425-1-libaokun1@huawei.com>
 <20230628132155.1560425-4-libaokun1@huawei.com>
 <20230629102445.injcpqkfm6wnrw3y@quack3>
From:   Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20230629102445.injcpqkfm6wnrw3y@quack3>
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

On 2023/6/29 18:24, Jan Kara wrote:
> On Wed 28-06-23 21:21:51, Baokun Li wrote:
>> Now we have a helper function dquot_dirty() to determine if dquot has
>> DQ_MOD_B bit. dquot_active() can easily be misunderstood as a helper
>> function to determine if dquot has DQ_ACTIVE_B bit. So we avoid this by
>> adding the "inode_" prefix and later on we will add the helper function
>> dquot_active() to determine if dquot has DQ_ACTIVE_B bit.
>>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Maybe inode_quota_active() will be a better name what you are already
> renaming it?
>
> 								Honza
Indeed! I will rename it to inode_quota_active() in the next version.
>
>> ---
>>   fs/quota/dquot.c | 20 ++++++++++----------
>>   1 file changed, 10 insertions(+), 10 deletions(-)
>>
>> diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
>> index a8b43b5b5623..b21f5e888482 100644
>> --- a/fs/quota/dquot.c
>> +++ b/fs/quota/dquot.c
>> @@ -1435,7 +1435,7 @@ static int info_bdq_free(struct dquot *dquot, qsize_t space)
>>   	return QUOTA_NL_NOWARN;
>>   }
>>   
>> -static int dquot_active(const struct inode *inode)
>> +static int inode_dquot_active(const struct inode *inode)
>>   {
>>   	struct super_block *sb = inode->i_sb;
>>   
>> @@ -1458,7 +1458,7 @@ static int __dquot_initialize(struct inode *inode, int type)
>>   	qsize_t rsv;
>>   	int ret = 0;
>>   
>> -	if (!dquot_active(inode))
>> +	if (!inode_dquot_active(inode))
>>   		return 0;
>>   
>>   	dquots = i_dquot(inode);
>> @@ -1566,7 +1566,7 @@ bool dquot_initialize_needed(struct inode *inode)
>>   	struct dquot **dquots;
>>   	int i;
>>   
>> -	if (!dquot_active(inode))
>> +	if (!inode_dquot_active(inode))
>>   		return false;
>>   
>>   	dquots = i_dquot(inode);
>> @@ -1677,7 +1677,7 @@ int __dquot_alloc_space(struct inode *inode, qsize_t number, int flags)
>>   	int reserve = flags & DQUOT_SPACE_RESERVE;
>>   	struct dquot **dquots;
>>   
>> -	if (!dquot_active(inode)) {
>> +	if (!inode_dquot_active(inode)) {
>>   		if (reserve) {
>>   			spin_lock(&inode->i_lock);
>>   			*inode_reserved_space(inode) += number;
>> @@ -1747,7 +1747,7 @@ int dquot_alloc_inode(struct inode *inode)
>>   	struct dquot_warn warn[MAXQUOTAS];
>>   	struct dquot * const *dquots;
>>   
>> -	if (!dquot_active(inode))
>> +	if (!inode_dquot_active(inode))
>>   		return 0;
>>   	for (cnt = 0; cnt < MAXQUOTAS; cnt++)
>>   		warn[cnt].w_type = QUOTA_NL_NOWARN;
>> @@ -1790,7 +1790,7 @@ int dquot_claim_space_nodirty(struct inode *inode, qsize_t number)
>>   	struct dquot **dquots;
>>   	int cnt, index;
>>   
>> -	if (!dquot_active(inode)) {
>> +	if (!inode_dquot_active(inode)) {
>>   		spin_lock(&inode->i_lock);
>>   		*inode_reserved_space(inode) -= number;
>>   		__inode_add_bytes(inode, number);
>> @@ -1832,7 +1832,7 @@ void dquot_reclaim_space_nodirty(struct inode *inode, qsize_t number)
>>   	struct dquot **dquots;
>>   	int cnt, index;
>>   
>> -	if (!dquot_active(inode)) {
>> +	if (!inode_dquot_active(inode)) {
>>   		spin_lock(&inode->i_lock);
>>   		*inode_reserved_space(inode) += number;
>>   		__inode_sub_bytes(inode, number);
>> @@ -1876,7 +1876,7 @@ void __dquot_free_space(struct inode *inode, qsize_t number, int flags)
>>   	struct dquot **dquots;
>>   	int reserve = flags & DQUOT_SPACE_RESERVE, index;
>>   
>> -	if (!dquot_active(inode)) {
>> +	if (!inode_dquot_active(inode)) {
>>   		if (reserve) {
>>   			spin_lock(&inode->i_lock);
>>   			*inode_reserved_space(inode) -= number;
>> @@ -1931,7 +1931,7 @@ void dquot_free_inode(struct inode *inode)
>>   	struct dquot * const *dquots;
>>   	int index;
>>   
>> -	if (!dquot_active(inode))
>> +	if (!inode_dquot_active(inode))
>>   		return;
>>   
>>   	dquots = i_dquot(inode);
>> @@ -2103,7 +2103,7 @@ int dquot_transfer(struct mnt_idmap *idmap, struct inode *inode,
>>   	struct super_block *sb = inode->i_sb;
>>   	int ret;
>>   
>> -	if (!dquot_active(inode))
>> +	if (!inode_dquot_active(inode))
>>   		return 0;
>>   
>>   	if (i_uid_needs_update(idmap, iattr, inode)) {
>> -- 
>> 2.31.1
>>

Thanks!
-- 
With Best Regards,
Baokun Li
.
