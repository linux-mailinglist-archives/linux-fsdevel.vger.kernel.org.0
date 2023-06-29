Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A26DF74281C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 16:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbjF2ORB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 10:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbjF2OQR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 10:16:17 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E002A3C00;
        Thu, 29 Jun 2023 07:16:11 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4QsL6L5TppzLn5P;
        Thu, 29 Jun 2023 22:14:02 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 29 Jun 2023 22:16:08 +0800
Message-ID: <939155cb-33bd-debd-02b8-d50c540ccc97@huawei.com>
Date:   Thu, 29 Jun 2023 22:16:08 +0800
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
 <d00a224e-1991-ce90-d458-45390a20f8dc@huawei.com>
 <20230629140922.dp74owntkbm5avop@quack3>
From:   Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20230629140922.dp74owntkbm5avop@quack3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023/6/29 22:09, Jan Kara wrote:
> On Thu 29-06-23 20:13:05, Baokun Li wrote:
>> On 2023/6/29 19:08, Jan Kara wrote:
>>> On Wed 28-06-23 21:21:54, Baokun Li wrote:
>>>> Now when dqput() drops the last reference count, it will call
>>>> synchronize_srcu(&dquot_srcu) in quota_release_workfn() to ensure that
>>>> no other user will use the dquot after the last reference count is dropped,
>>>> so we don't need to call synchronize_srcu(&dquot_srcu) in drop_dquot_ref()
>>>> and remove the corresponding logic directly to simplify the code.
>>> Nice simplification!  It is also important that dqput() now cannot sleep
>>> which was another reason for the logic with tofree_head in
>>> remove_inode_dquot_ref().
>> I don't understand this sentence very well, so I would appreciate it
>>
>> if you could explain it in detail. 🤔
> OK, let me phrase it in a "changelog" way :):
>
> remove_inode_dquot_ref() currently does not release the last dquot
> reference but instead adds the dquot to tofree_head list. This is because
> dqput() can sleep while dropping of the last dquot reference (writing back
> the dquot and calling ->release_dquot()) and that must not happen under
> dq_list_lock. Now that dqput() queues the final dquot cleanup into a
> workqueue, remove_inode_dquot_ref() can call dqput() unconditionally
> and we can significantly simplify it.
>
> 								Honza
I suddenly understand what you mean, you mean that now dqput() doesn't have
any possible sleep operation. So it can be called in spin_lock at will.

I was confused because I understood that dqput() cannot be called in the 
context
of possible sleep.

Thank you very much for the detailed explanation!
Now there is only the problem in patch 5.

Thanks!
-- 
With Best Regards,
Baokun Li
.
