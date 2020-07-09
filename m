Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE3232195DB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jul 2020 04:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgGICEk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 22:04:40 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:36770 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726072AbgGICEk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 22:04:40 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6E24292A9D235B4B7F6B;
        Thu,  9 Jul 2020 10:04:38 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.218) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Thu, 9 Jul 2020
 10:04:30 +0800
Subject: Re: [PATCH RESEND] 9p: Fix memory leak in v9fs_mount
To:     Dominique Martinet <asmadeus@codewreck.org>
CC:     <ericvh@gmail.com>, <lucho@ionkov.net>,
        <v9fs-developer@lists.sourceforge.net>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
References: <20200615012153.89538-1-zhengbin13@huawei.com>
 <20200615102053.GA11026@nautica>
From:   "Zhengbin (OSKernel)" <zhengbin13@huawei.com>
Message-ID: <ae01f0bd-da0a-f01f-cbd0-3af10ccaa4ae@huawei.com>
Date:   Thu, 9 Jul 2020 10:04:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20200615102053.GA11026@nautica>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.177.218]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Is this OK? I don't see it on linux-next

On 2020/6/15 18:20, Dominique Martinet wrote:
> Zheng Bin wrote on Mon, Jun 15, 2020:
>> v9fs_mount
>>    v9fs_session_init
>>      v9fs_cache_session_get_cookie
>>        v9fs_random_cachetag                     -->alloc cachetag
>>        v9ses->fscache = fscache_acquire_cookie  -->maybe NULL
>>    sb = sget                                    -->fail, goto clunk
>> clunk_fid:
>>    v9fs_session_close
>>      if (v9ses->fscache)                        -->NULL
>>        kfree(v9ses->cachetag)
>>
>> Thus memleak happens.
>>
>> Signed-off-by: Zheng Bin <zhengbin13@huawei.com>
> Thanks, will run tests & queue next weekend
>

