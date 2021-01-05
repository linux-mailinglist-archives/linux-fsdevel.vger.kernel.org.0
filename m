Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98F542EA37A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Jan 2021 03:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbhAECuy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jan 2021 21:50:54 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9713 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbhAECuy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jan 2021 21:50:54 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4D8xld4w5QzkWlC;
        Tue,  5 Jan 2021 10:49:01 +0800 (CST)
Received: from [10.174.177.6] (10.174.177.6) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.498.0; Tue, 5 Jan 2021
 10:50:04 +0800
Subject: Re: [RFC PATCH RESEND] fs: fix a hungtask problem when
 freeze/unfreeze fs
To:     Jan Kara <jack@suse.cz>
CC:     Al Viro <viro@zeniv.linux.org.uk>, <linux-fsdevel@vger.kernel.org>,
        <yangerkun@huawei.com>, <yi.zhang@huawei.com>,
        <linfeilong@huawei.com>
References: <20201226095641.17290-1-luoshijie1@huawei.com>
 <20201226155500.GB3579531@ZenIV.linux.org.uk>
 <870c4a20-ac5e-c755-fe8c-e1a192bffb29@huawei.com>
 <20210104160457.GG4018@quack2.suse.cz>
From:   Shijie Luo <luoshijie1@huawei.com>
Message-ID: <b0187d7d-cd4f-0cda-ea32-8c05b7e9b592@huawei.com>
Date:   Tue, 5 Jan 2021 10:48:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20210104160457.GG4018@quack2.suse.cz>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.177.6]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi!

On 2021/1/5 0:04, Jan Kara wrote:
>> Consuming the reference here because we won't "set frozen =
>> SB_FREEZE_COMPLETE" in thaw_super_locked() now.
>>
>> If don't do that, we never have a chance to consume it, thaw_super_locked()
>> will directly return "-EINVAL". But I do
>>
>> agree that it's not a good idea to return 0. How about returning "-EINVAL or
>> -ENOTSUPP" ?
>>
>> And, If we keep "frozen = SB_FREEZE_COMPLETE" in freeze_super() here, it
>> will cause another problem, thaw_super_locked()
>>
>> will always release rwsems in my logic, but freeze_super() won't acquire the
>> rwsems when filesystem is read-only.
> I was thinking about this for a while. I think the best solution would be
> to track whether the fs was read only (and thus frozen without locking
> percpu semaphores) at the time of freezing. I'm attaching that patch. Does
> it fix your problem?
>
> 									Honza

I tested your patch, and it can indeed fix this deadlock problem.

Thanks.

