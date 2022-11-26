Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1C063933B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Nov 2022 02:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbiKZB7L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Nov 2022 20:59:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiKZB7K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Nov 2022 20:59:10 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E464A1CFFD;
        Fri, 25 Nov 2022 17:59:09 -0800 (PST)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NJvv20VVbzqSdh;
        Sat, 26 Nov 2022 09:55:10 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 26 Nov 2022 09:59:08 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 26 Nov 2022 09:59:07 +0800
Subject: Re: [PATCH v3 0/2] fs: clear a UBSAN shift-out-of-bounds warning
To:     Al Viro <viro@zeniv.linux.org.uk>
CC:     Eric Biggers <ebiggers@kernel.org>,
        <linux-fsdevel@vger.kernel.org>, "Chris Mason" <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, <linux-btrfs@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221125091358.1963-1-thunder.leizhen@huawei.com>
 <Y4Es4TIbVos5CTO9@ZenIV>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <0a8264a8-e2a9-952a-97ce-a7f06920ad39@huawei.com>
Date:   Sat, 26 Nov 2022 09:59:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <Y4Es4TIbVos5CTO9@ZenIV>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2022/11/26 5:00, Al Viro wrote:
> On Fri, Nov 25, 2022 at 05:13:56PM +0800, Zhen Lei wrote:
>> v2 --> v3:
>> Updated the commit message of patch 2/2 based on Alexander Viro's suggestion.
> 
> Not exactly what I meant...  I've tentatively applied it, with the

Haha, I felt like something was missing yesterday, too. But as far as my English
level is concerned, I usually copy the words suggested by others directly.

> following commit message:

Thanks.

> 
> --------------------------------
> get rid of INT_LIMIT, use type_max() instead
> 
> INT_LIMIT() tries to do what type_max() does, except that type_max()
> doesn't rely upon undefined behaviour[*], might as well use type_max()
> instead.
> 
> [*] if T is an N-bit signed integer type, the maximal value in T is
> pow(2, N - 1) - 1, all right, but naive expression for that value
> ends up with a couple of wraparounds and as usual for wraparounds
> in signed types, that's an undefined behaviour.  type_max() takes
> care to avoid those...
> 
> Caught-by: UBSAN
> Suggested-by: Eric Biggers <ebiggers@kernel.org>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> Reviewed-by: Eric Biggers <ebiggers@google.com>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> --------------------------------
> 
> Does anybody have objections against the commit message above?

Looks good to me.

> 
> .
> 

-- 
Regards,
  Zhen Lei
