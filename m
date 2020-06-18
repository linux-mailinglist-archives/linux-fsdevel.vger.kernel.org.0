Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3EFF1FE9A9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jun 2020 05:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgFRDxk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jun 2020 23:53:40 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:36226 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727839AbgFRDxk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jun 2020 23:53:40 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 1BD8C27422F0F153F043;
        Thu, 18 Jun 2020 11:53:38 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.198) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Thu, 18 Jun 2020
 11:53:31 +0800
Subject: Re: [PATCH v2 3/5] ext4: detect metadata async write error when
 getting journal's write access
From:   "zhangyi (F)" <yi.zhang@huawei.com>
To:     Jan Kara <jack@suse.cz>
CC:     <linux-ext4@vger.kernel.org>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <zhangxiaoxu5@huawei.com>,
        <linux-fsdevel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20200617115947.836221-1-yi.zhang@huawei.com>
 <20200617115947.836221-4-yi.zhang@huawei.com>
 <20200617124157.GB29763@quack2.suse.cz>
 <8caf9fe1-b7ce-655f-1f4d-3e0e90e211dc@huawei.com>
Message-ID: <9efa3fdb-e0d0-ef90-94ba-1e9124722df0@huawei.com>
Date:   Thu, 18 Jun 2020 11:53:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <8caf9fe1-b7ce-655f-1f4d-3e0e90e211dc@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.215.198]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/6/17 21:44, zhangyi (F) wrote:
> On 2020/6/17 20:41, Jan Kara wrote:
>> On Wed 17-06-20 19:59:45, zhangyi (F) wrote:
>>> Although we have already introduce s_bdev_wb_err_work to detect and
>>> handle async write metadata buffer error as soon as possible, there is
>>> still a potential race that could lead to filesystem inconsistency,
>>> which is the buffer may reading and re-writing out to journal before
>>> s_bdev_wb_err_work run. So this patch detect bdev mapping->wb_err when
>>> getting journal's write access and also mark the filesystem error if
>>> something bad happened.
>>>
>>> Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
>>
>> So instead of all this, cannot we just do:
>>
>> 	if (work_pending(sbi->s_bdev_wb_err_work))
>> 		flush_work(sbi->s_bdev_wb_err_work);
>>
>> ? And so we are sure the filesystem is aborted if the abort was pending?
>>
> 
> Thanks for this suggestion. Yeah, we could do this, it depends on the second
> patch, if we check and flush the pending work here, we could not use the
> end_buffer_async_write() in ext4_end_buffer_async_write(), we need to open
> coding ext4_end_buffer_async_write() and queue the error work before the
> buffer is unlocked, or else the race is still there. Do you agree ?
> 

Add one point, add work_pending check here may not safe. We need to make sure
the filesystem is aborted, so we need to wait the error handle work is finished,
but the work's pending bit is cleared before it start running. I think may
better to just invoke flush_work() here.

BTW, I also notice another race condition that may lead to inconsistency. In
bdev_try_to_free_page(), if we free a write error buffer before the worker
is finished, the jbd2 checkpoint procedure will miss this error and wrongly
think it has already been written to disk successfully, and finally it will
destroy the log and lead to inconsistency (the same to no-journal mode).
So I think the ninth patch in my v1 patch set is still needed. What do you
think?

Thanks,
Yi.

