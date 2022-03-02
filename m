Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48EF54C9A9A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Mar 2022 02:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238937AbiCBBkp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Mar 2022 20:40:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238727AbiCBBko (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Mar 2022 20:40:44 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D146CA1444;
        Tue,  1 Mar 2022 17:40:01 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4K7cBJ2pFRz1GBwL;
        Wed,  2 Mar 2022 09:35:20 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 2 Mar 2022 09:39:58 +0800
Subject: Re: [PATCH 1/8] sched: coredump.h: clarify the use of MMF_VM_HUGEPAGE
To:     Yang Shi <shy828301@gmail.com>
CC:     Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        <linux-ext4@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Rik van Riel <riel@surriel.com>,
        Matthew Wilcox <willy@infradead.org>, Zi Yan <ziy@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        <darrick.wong@oracle.com>
References: <20220228235741.102941-1-shy828301@gmail.com>
 <20220228235741.102941-2-shy828301@gmail.com>
 <cfaefe6f-dd51-1595-a23c-1aa5dc8350ff@huawei.com>
 <CAHbLzkqP36q+exOy3wqa84ziRE6E=ThccGH9rpYC6f8H7RXwWw@mail.gmail.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <f75b0110-ae41-835a-0fb2-8fbdc2d8225a@huawei.com>
Date:   Wed, 2 Mar 2022 09:39:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAHbLzkqP36q+exOy3wqa84ziRE6E=ThccGH9rpYC6f8H7RXwWw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022/3/2 5:49, Yang Shi wrote:
> On Tue, Mar 1, 2022 at 12:45 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>>
>> On 2022/3/1 7:57, Yang Shi wrote:
>>> MMF_VM_HUGEPAGE is set as long as the mm is available for khugepaged by
>>> khugepaged_enter(), not only when VM_HUGEPAGE is set on vma.  Correct
>>> the comment to avoid confusion.
>>>
>>> Signed-off-by: Yang Shi <shy828301@gmail.com>
>>> ---
>>>  include/linux/sched/coredump.h | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/linux/sched/coredump.h b/include/linux/sched/coredump.h
>>> index 4d9e3a656875..4d0a5be28b70 100644
>>> --- a/include/linux/sched/coredump.h
>>> +++ b/include/linux/sched/coredump.h
>>> @@ -57,7 +57,8 @@ static inline int get_dumpable(struct mm_struct *mm)
>>>  #endif
>>>                                       /* leave room for more dump flags */
>>>  #define MMF_VM_MERGEABLE     16      /* KSM may merge identical pages */
>>> -#define MMF_VM_HUGEPAGE              17      /* set when VM_HUGEPAGE is set on vma */
>>> +#define MMF_VM_HUGEPAGE              17      /* set when mm is available for
>>> +                                        khugepaged */
>>
>> I think this comment could be written in one line. Anyway, this patch looks good to me.
>> Thanks.
> 
> Yes, as long as we don't care about the 80 characters limit. I know
> the limit was bumped to 100 by checkpatch, but I have seen 80 was
> still preferred by a lot of people.

I see. Many thanks for clarifying.

> 
>>
>> Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
> 
> Thanks.
> 
>>
>>>  /*
>>>   * This one-shot flag is dropped due to necessity of changing exe once again
>>>   * on NFS restore
>>>
>>
> .
> 

