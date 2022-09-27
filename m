Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D122E5EB6A8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 03:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiI0BHm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Sep 2022 21:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiI0BHl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Sep 2022 21:07:41 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22577DF57;
        Mon, 26 Sep 2022 18:07:40 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Mc1dH2ftqzHppZ;
        Tue, 27 Sep 2022 09:05:23 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 27 Sep 2022 09:07:38 +0800
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 27 Sep 2022 09:07:37 +0800
Subject: Re: [PATCH v2 2/3] quota: Replace all block number checking with
 helper function
To:     Jan Kara <jack@suse.cz>
CC:     <jack@suse.com>, <tytso@mit.edu>, <brauner@kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>
References: <20220922130401.1792256-1-chengzhihao1@huawei.com>
 <20220922130401.1792256-3-chengzhihao1@huawei.com>
 <20220923114840.npx52cadeofesp5i@quack3>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <5f5e3d09-7fc6-33e1-3f2e-669baf8e5da1@huawei.com>
Date:   Tue, 27 Sep 2022 09:07:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20220923114840.npx52cadeofesp5i@quack3>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ÔÚ 2022/9/23 19:48, Jan Kara Ð´µÀ:
> On Thu 22-09-22 21:04:00, Zhihao Cheng wrote:
>> Cleanup all block checking places, replace them with helper function
>> do_check_range().
>>
>> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
>> ---
>>   fs/quota/quota_tree.c | 28 ++++++++++++----------------
>>   1 file changed, 12 insertions(+), 16 deletions(-)
> 
> Thanks for the fix! One comment below:
> 
>> diff --git a/fs/quota/quota_tree.c b/fs/quota/quota_tree.c
>> index f89186b6db1d..47711e739ddb 100644
>> --- a/fs/quota/quota_tree.c
>> +++ b/fs/quota/quota_tree.c
>> @@ -71,11 +71,12 @@ static ssize_t write_blk(struct qtree_mem_dqinfo *info, uint blk, char *buf)
>>   	return ret;
>>   }
>>   
>> -static inline int do_check_range(struct super_block *sb, uint val, uint max_val)
>> +static inline int do_check_range(struct super_block *sb, uint val,
>> +				 uint min_val, uint max_val)
>>   {
>> -	if (val >= max_val) {
>> -		quota_error(sb, "Getting block too big (%u >= %u)",
>> -			    val, max_val);
>> +	if (val < min_val || val >= max_val) {
>> +		quota_error(sb, "Getting block %u out of range %u-%u",
>> +			    val, min_val, max_val);
>>   		return -EUCLEAN;
>>   	}
> 
> It is strange that do_check_range() checks min_val() with strict inequality
> and max_val with non-strict one. That's off-by-one problem waiting to
> happen when we forget about this detail. Probably make max_val
> non-inclusive as well (the parameter max_val suggests the passed value is
> the biggest valid one anyway).
> 
> 								Honza
> 

I have sent v3 series, see
https://lore.kernel.org/all/20220923134555.2623931-1-chengzhihao1@huawei.com/T/

