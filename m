Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2067027737F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Sep 2020 16:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbgIXOBO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Sep 2020 10:01:14 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14275 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727859AbgIXOBO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Sep 2020 10:01:14 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 48B69DDB4B97E6442AE8;
        Thu, 24 Sep 2020 22:01:12 +0800 (CST)
Received: from [10.174.179.226] (10.174.179.226) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Thu, 24 Sep 2020 22:00:59 +0800
Subject: Re: [PATCH RESEND] fs: fix race condition oops between destroy_inode
 and writeback_sb_inodes
To:     Jan Kara <jack@suse.cz>
CC:     <linux-fsdevel@vger.kernel.org>, <viro@zeniv.linux.org.uk>,
        <lihaotian9@huawei.com>, <lutianxiong@huawei.com>,
        <linfeilong@huawei.com>
References: <20200919093923.19016-1-luoshijie1@huawei.com>
 <20200921102538.GF5862@quack2.suse.cz>
From:   Shijie Luo <luoshijie1@huawei.com>
Message-ID: <e175bd80-a0b2-f6b9-f88a-f659c8cfdee1@huawei.com>
Date:   Thu, 24 Sep 2020 22:00:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200921102538.GF5862@quack2.suse.cz>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.179.226]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 2020/9/21 18:25, Jan Kara wrote:
> On Sat 19-09-20 05:39:23, Shijie Luo wrote:
>> So 4.18 is rather old and we had several fixes in this area for crashes
>> similar to the one you show above. The list was likely:
>>
>> 68f23b89067 ("memcg: fix a crash in wb_workfn when a device disappears")
>>
>> but there were multiple changes before that to bdi logic to fix lifetime
>> issues when devices are hot-removed.
>>
Thanks for your reply, we checked several fixes in wb_workfn , and 
finally found

this patch (ceff86fddae8 ext4: Avoid freeing inodes on dirty list) works.

Our fsstress  process randomly uses ioctl interface to set inode with 
journal data flag, ext4 inode with journal data

flags is possible to be marked dirty and added to writeback lists again.

When locked_inode_to_wb_and_lock_list in __mark_inode_dirty releases 
inode->i_lock and do not lock

wb->list_lock, simultaneously the inode is evicted and removed from 
writeback lists, it's possible this

inode will be added to writeback list again. This problem causes inode 
allocated from slab is still on

writeback list, and may causes crash because destory_inode set inode->wb 
to be NULL.

