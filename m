Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94DEF1FCEBE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jun 2020 15:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgFQNor (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jun 2020 09:44:47 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:35046 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726331AbgFQNor (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jun 2020 09:44:47 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A893EA6112A76EA029FA;
        Wed, 17 Jun 2020 21:44:45 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.198) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Wed, 17 Jun 2020
 21:44:36 +0800
Subject: Re: [PATCH v2 3/5] ext4: detect metadata async write error when
 getting journal's write access
To:     Jan Kara <jack@suse.cz>
CC:     <linux-ext4@vger.kernel.org>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <zhangxiaoxu5@huawei.com>,
        <linux-fsdevel@vger.kernel.org>
References: <20200617115947.836221-1-yi.zhang@huawei.com>
 <20200617115947.836221-4-yi.zhang@huawei.com>
 <20200617124157.GB29763@quack2.suse.cz>
From:   "zhangyi (F)" <yi.zhang@huawei.com>
Message-ID: <8caf9fe1-b7ce-655f-1f4d-3e0e90e211dc@huawei.com>
Date:   Wed, 17 Jun 2020 21:44:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200617124157.GB29763@quack2.suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.215.198]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/6/17 20:41, Jan Kara wrote:
> On Wed 17-06-20 19:59:45, zhangyi (F) wrote:
>> Although we have already introduce s_bdev_wb_err_work to detect and
>> handle async write metadata buffer error as soon as possible, there is
>> still a potential race that could lead to filesystem inconsistency,
>> which is the buffer may reading and re-writing out to journal before
>> s_bdev_wb_err_work run. So this patch detect bdev mapping->wb_err when
>> getting journal's write access and also mark the filesystem error if
>> something bad happened.
>>
>> Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
> 
> So instead of all this, cannot we just do:
> 
> 	if (work_pending(sbi->s_bdev_wb_err_work))
> 		flush_work(sbi->s_bdev_wb_err_work);
> 
> ? And so we are sure the filesystem is aborted if the abort was pending?
> 

Thanks for this suggestion. Yeah, we could do this, it depends on the second
patch, if we check and flush the pending work here, we could not use the
end_buffer_async_write() in ext4_end_buffer_async_write(), we need to open
coding ext4_end_buffer_async_write() and queue the error work before the
buffer is unlocked, or else the race is still there. Do you agree ?

Thanks,
Yi.

