Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9435E6302
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 14:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbiIVM7H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Sep 2022 08:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbiIVM7G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Sep 2022 08:59:06 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178393D5B0;
        Thu, 22 Sep 2022 05:59:05 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MYFfX1rvlzHp3N;
        Thu, 22 Sep 2022 20:56:52 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 20:59:02 +0800
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 20:59:02 +0800
Subject: Re: [PATCH 1/3] quota: Check next/prev free block number after
 reading from quota file
To:     Jan Kara <jack@suse.cz>
CC:     <jack@suse.com>, <tytso@mit.edu>, <brauner@kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>
References: <20220820110514.881373-1-chengzhihao1@huawei.com>
 <20220820110514.881373-2-chengzhihao1@huawei.com>
 <20220921133715.7tesk3qylombwmyk@quack3>
 <41578612-d582-79ea-bb8e-89fa19d4406e@huawei.com>
 <20220922113902.rhoxfgdzcvdzo3wc@quack3>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <bb852092-5eab-9a9f-9c0e-4ae1d1b1f892@huawei.com>
Date:   Thu, 22 Sep 2022 20:58:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20220922113902.rhoxfgdzcvdzo3wc@quack3>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

在 2022/9/22 19:39, Jan Kara 写道:
> On Thu 22-09-22 16:13:59, Zhihao Cheng wrote:
[...]
>>>
>>> The free block should actually be > QT_TREEOFF so I'd add the check to
>>> do_check_range().
>>
>> 'dh->dqdh_next_free' may be updated when quota entry removed,
>> 'dh->dqdh_next_free' can be used for next new quota entris.
>> Before sending v2, I found 'dh->dqdh_next_free' and 'dh->dqdh_prev_free' can
>> easily be zero in newly allocated blocks when continually creating files
>> onwed by different users:
>> find_free_dqentry
>>    get_free_dqblk
>>      write_blk(info, info->dqi_blocks, buf)  // zero'd qt_disk_dqdbheader
>>      blk = info->dqi_blocks++   // allocate new one block
>>    info->dqi_free_entry = blk   // will be used for new quota entries
>>
>> find_free_dqentry
>>    if (info->dqi_free_entry)
>>      blk = info->dqi_free_entry
>>      read_blk(info, blk, buf)   // dh->dqdh_next_free = dh->dqdh_prev_free =
>> 0
>>
>> I think it's normal when 'dh->dqdh_next_free' or 'dh->dqdh_prev_free' equals
>> to 0.
> 
> Good point! 0 means "not present". So any block number (either in free list
> or pointed from the quota tree) should be either 0 or > QT_TREEOFF.
> 
> 								Honza
> 

In case my emails being filtered agagin, this is notification of v2:
https://lore.kernel.org/linux-ext4/20220922130401.1792256-1-chengzhihao1@huawei.com/T/#m9676d64e8f7cdd7b7decdd0d6b725ec658110b3e
