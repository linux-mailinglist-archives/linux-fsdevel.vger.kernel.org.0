Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8784D6E1988
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 03:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjDNBTQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Apr 2023 21:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjDNBTN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Apr 2023 21:19:13 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4154C2C;
        Thu, 13 Apr 2023 18:19:09 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PyJTf70F8zrZZ5;
        Fri, 14 Apr 2023 09:17:42 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 14 Apr 2023 09:19:07 +0800
Message-ID: <61c62ae1-4c2b-5768-5044-93e43b6585de@huawei.com>
Date:   Fri, 14 Apr 2023 09:19:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] fs: fix sysctls.c built
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Christian Brauner <brauner@kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
References: <20230331084502.155284-1-wangkefeng.wang@huawei.com>
 <66c0e8b6-64d1-5be6-cd4d-9700d84e1b84@huawei.com>
 <20230412-sympathie-haltbar-da2d2183067b@brauner>
 <ZDg2m/U1NasHfK4j@bombadil.infradead.org>
 <ZDhOAKZK+P4IFDJp@bombadil.infradead.org>
 <ZDhbcRRDlCN9Dk6Y@bombadil.infradead.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <ZDhbcRRDlCN9Dk6Y@bombadil.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/4/14 3:43, Luis Chamberlain wrote:
> On Thu, Apr 13, 2023 at 11:46:24AM -0700, Luis Chamberlain wrote:
>> On Thu, Apr 13, 2023 at 10:06:35AM -0700, Luis Chamberlain wrote:
>>> On Wed, Apr 12, 2023 at 11:19:56AM +0200, Christian Brauner wrote:
>>>> On Tue, Apr 11, 2023 at 12:14:44PM +0800, Kefeng Wang wrote:
>>>>> /proc/sys/fs/overflowuid and overflowgid  will be lost without
>>>>> building this file, kindly ping, any comments, thanks.
>>>>>
>>>>>
...
>>>>
>>>> Given the description in
>>>> ab171b952c6e ("fs: move namespace sysctls and declare fs base directory")
>>>> you probably want to move this earlier.
>>>
>>> I was being *way* too cautious and I was wrong, so I'll take Kefang's patch as
>>> I can verify now that order does not matter and his patch is correct.
>>> I've corrected the documentation and clarified this on sysctl-next and
>>> so reflected on linux-next too with these two patches:
>>>
>>> sysctl: clarify register_sysctl_init() base directory order
>>> https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/commit/?h=sysctl-next-20230413&id=8ae59580f2b0529b6dd1a1cda6b838cfb268cb87
>>>
>>> proc_sysctl: move helper which creates required subdirectories
>>> https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/commit/?h=sysctl-next-20230413&id=f4c09b14073513efd581459520a01c4c88cb24d7
>>>
>>> proc_sysctl: update docs for __register_sysctl_table()
>>> https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/commit/?h=sysctl-next-20230413&id=d59d91edd67ec4cef62f26249510fe08b291ae72
>>>
>>> proc_sysctl: enhance documentation
>>> https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/commit/?h=sysctl-next-20230413&id=eb472aa0678fd03321093bffeb9c7fd7f5035844
>>>
>>> And so something we can do eventually is do away with all the base stuff.
>>> For now it's fine, it's not creating an issue.
>>
>> Come to think of it all the above patches except the one that moves code
>> ("proc_sysctl: move helper which creates required subdirectories") are
>> stable fix candidates prior to Kefeng's patch. I'll also update Kefeng's
>> patch to mention stable down to v5.17 and update the other patches with
>> the respective stable tag as well.

Thanks for your detail explanation.

> 
> OK pushed to sysctl-next and updated the patches above also to refer to
> stable and Cc you guys. Finally, a good reason or value to having Cc on
> the commit log. It just tmeans you (Christian and Kefeng) will be be CC'd
> once this trickles to stable kernel trees too.
> 
>    Luis
