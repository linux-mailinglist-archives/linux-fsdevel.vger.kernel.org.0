Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D657ADBF9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2019 17:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfIIPRG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Sep 2019 11:17:06 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2195 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731749AbfIIPRG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Sep 2019 11:17:06 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id DE71CFAAD1B231270E59;
        Mon,  9 Sep 2019 23:10:38 +0800 (CST)
Received: from [127.0.0.1] (10.184.213.217) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Mon, 9 Sep 2019
 23:10:31 +0800
Subject: Re: Possible FS race condition between iterate_dir and
 d_alloc_parallel
To:     Al Viro <viro@zeniv.linux.org.uk>
CC:     <jack@suse.cz>, <akpm@linux-foundation.org>,
        <linux-fsdevel@vger.kernel.org>,
        "zhangyi (F)" <yi.zhang@huawei.com>, <renxudong1@huawei.com>,
        Hou Tao <houtao1@huawei.com>
References: <fd00be2c-257a-8e1f-eb1e-943a40c71c9a@huawei.com>
 <20190903154007.GJ1131@ZenIV.linux.org.uk>
 <20190903154114.GK1131@ZenIV.linux.org.uk>
 <b5876e84-853c-e1f6-4fef-83d3d45e1767@huawei.com>
 <afdfa1f4-c954-486b-1eb2-efea6fcc2e65@huawei.com>
 <20190909145910.GG1131@ZenIV.linux.org.uk>
From:   "zhengbin (A)" <zhengbin13@huawei.com>
Message-ID: <14888449-3300-756c-2029-8e494b59348b@huawei.com>
Date:   Mon, 9 Sep 2019 23:10:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190909145910.GG1131@ZenIV.linux.org.uk>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.184.213.217]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/9/9 22:59, Al Viro wrote:

> On Mon, Sep 09, 2019 at 10:10:00PM +0800, zhengbin (A) wrote:
>
> Hmm...  So your theory is that what you are seeing is the insertion
> into the list done by list_add() exposing an earlier ->next pointer
> to those who might be doing lockless walk through the list.
> Potentially up to the last barrier done before the list_add()...
>
>> We can solute it in 2 ways:
>>
>> 1. add a smp_wmb between __d_alloc and list_add(&dentry->d_child, &parent->d_subdirs)
>> 2. revert commit ebaaa80e8f20 ("lockless next_positive()")
> I want to take another look at the ->d_subdirs/->d_child readers...
> I agree that the above sounds plausible, but I really want to be
> sure about the exclusion we have for those accesses.
>
> I'm not sure that smp_wmb() alone would suffice, BTW - the reader side
> loop would need to be careful as well.
>
> Which architecture it was, again?  arm64?

arm64

>
> .
>

