Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C865E5D26
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 10:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiIVIOG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Sep 2022 04:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiIVIOE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Sep 2022 04:14:04 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA3567CB2;
        Thu, 22 Sep 2022 01:14:03 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MY7Kf6d7jzHply;
        Thu, 22 Sep 2022 16:11:50 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 16:14:01 +0800
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 16:14:00 +0800
Subject: Re: [PATCH 1/3] quota: Check next/prev free block number after
 reading from quota file
To:     Jan Kara <jack@suse.cz>
CC:     <jack@suse.com>, <tytso@mit.edu>, <brauner@kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>
References: <20220820110514.881373-1-chengzhihao1@huawei.com>
 <20220820110514.881373-2-chengzhihao1@huawei.com>
 <20220921133715.7tesk3qylombwmyk@quack3>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <41578612-d582-79ea-bb8e-89fa19d4406e@huawei.com>
Date:   Thu, 22 Sep 2022 16:13:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20220921133715.7tesk3qylombwmyk@quack3>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ÔÚ 2022/9/21 21:37, Jan Kara Ð´µÀ:
Hi Jan,
> On Sat 20-08-22 19:05:12, Zhihao Cheng wrote:
>> Following process:
[...]
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216372
>> Fixes: 1da177e4c3f4152 ("Linux-2.6.12-rc2")
> 
> It's better to just have:
> 
> CC: stable@vger.kernel.org
> 
> here. Fixes tag pointing to kernel release is not very useful.
Will add in v2.
> 
>> --- a/fs/quota/quota_tree.c
>> +++ b/fs/quota/quota_tree.c
>> @@ -71,6 +71,35 @@ static ssize_t write_blk(struct qtree_mem_dqinfo *info, uint blk, char *buf)
>>   	return ret;
>>   }
>>   
>> +static inline int do_check_range(struct super_block *sb, uint val, uint max_val)
>> +{
>> +	if (val >= max_val) {
>> +		quota_error(sb, "Getting block too big (%u >= %u)",
>> +			    val, max_val);
>> +		return -EUCLEAN;
>> +	}
>> +
>> +	return 0;
>> +}
> 
> I'd already provide min_val and the string for the message here as well (as
> you do in patch 2). It is less churn in the next patch and free blocks
> checking actually needs that as well. See below.
> 
>> +
>> +static int check_free_block(struct qtree_mem_dqinfo *info,
>> +			    struct qt_disk_dqdbheader *dh)
>> +{
>> +	int err = 0;
>> +	uint nextblk, prevblk;
>> +
>> +	nextblk = le32_to_cpu(dh->dqdh_next_free);
>> +	err = do_check_range(info->dqi_sb, nextblk, info->dqi_blocks);
>> +	if (err)
>> +		return err;
>> +	prevblk = le32_to_cpu(dh->dqdh_prev_free);
>> +	err = do_check_range(info->dqi_sb, prevblk, info->dqi_blocks);
>> +	if (err)
>> +		return err;
> 
> The free block should actually be > QT_TREEOFF so I'd add the check to
> do_check_range().

'dh->dqdh_next_free' may be updated when quota entry removed, 
'dh->dqdh_next_free' can be used for next new quota entris.
Before sending v2, I found 'dh->dqdh_next_free' and 'dh->dqdh_prev_free' 
can easily be zero in newly allocated blocks when continually creating 
files onwed by different users:
find_free_dqentry
   get_free_dqblk
     write_blk(info, info->dqi_blocks, buf)  // zero'd qt_disk_dqdbheader
     blk = info->dqi_blocks++   // allocate new one block
   info->dqi_free_entry = blk   // will be used for new quota entries

find_free_dqentry
   if (info->dqi_free_entry)
     blk = info->dqi_free_entry
     read_blk(info, blk, buf)   // dh->dqdh_next_free = 
dh->dqdh_prev_free = 0

I think it's normal when 'dh->dqdh_next_free' or 'dh->dqdh_prev_free' 
equals to 0.
> 
> Also rather than having check_free_block(), I'd provide a helper function
> like check_dquot_block_header() which will check only free blocks pointers
> now and in later patches you can add other checks there.
OK, will be updated in v2.
> 
> 								Honza
> 

