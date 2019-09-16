Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 829A3B3384
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2019 04:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbfIPCxK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Sep 2019 22:53:10 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:50734 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727510AbfIPCxK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Sep 2019 22:53:10 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9047EFAC9337E64CF0B9;
        Mon, 16 Sep 2019 10:53:08 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 16 Sep
 2019 10:53:07 +0800
Subject: Re: [PATCH] quota: fix wrong condition in is_quota_modification()
To:     Jan Kara <jack@suse.cz>
CC:     Jan Kara <jack@suse.com>, <chao@kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190911093650.35329-1-yuchao0@huawei.com>
 <20190912100610.GA14773@quack2.suse.cz>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <ce4fe030-7ad4-134d-e0c4-77dc2c618b15@huawei.com>
Date:   Mon, 16 Sep 2019 10:53:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190912100610.GA14773@quack2.suse.cz>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/9/12 18:06, Jan Kara wrote:
> On Wed 11-09-19 17:36:50, Chao Yu wrote:
>> Quoted from
>> commit 3da40c7b0898 ("ext4: only call ext4_truncate when size <= isize")
>>
>> " At LSF we decided that if we truncate up from isize we shouldn't trim
>>   fallocated blocks that were fallocated with KEEP_SIZE and are past the
>>  new i_size.  This patch fixes ext4 to do this. "
>>
>> And generic/092 of fstest have covered this case for long time, however
>> is_quota_modification() didn't adjust based on that rule, so that in
>> below condition, we will lose to quota block change:
>> - fallocate blocks beyond EOF
>> - remount
>> - truncate(file_path, file_size)
>>
>> Fix it.
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  include/linux/quotaops.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/linux/quotaops.h b/include/linux/quotaops.h
>> index dc905a4ff8d7..bd30acad3a7f 100644
>> --- a/include/linux/quotaops.h
>> +++ b/include/linux/quotaops.h
>> @@ -22,7 +22,7 @@ static inline struct quota_info *sb_dqopt(struct super_block *sb)
>>  /* i_mutex must being held */
>>  static inline bool is_quota_modification(struct inode *inode, struct iattr *ia)
>>  {
>> -	return (ia->ia_valid & ATTR_SIZE && ia->ia_size != inode->i_size) ||
>> +	return (ia->ia_valid & ATTR_SIZE && ia->ia_size <= inode->i_size) ||
>>  		(ia->ia_valid & ATTR_UID && !uid_eq(ia->ia_uid, inode->i_uid)) ||
>>  		(ia->ia_valid & ATTR_GID && !gid_eq(ia->ia_gid, inode->i_gid));
>>  }
> 
> OK, but your change makes i_size extension not to be quota modification

I just try to adapt below rules covered with generic/092, which restrict to not
trim preallocate blocks beyond i_size, in that case, filesystem won't change
i_blocks.

1) truncate(i_size) will trim all blocks past i_size.
2) truncate(x) where x > i_size will not trim all blocks past i_size.

However, I'm okay with your change, because there could be filesystems won't
follow above rule.

Thanks,

> which is IMO wrong. So I think the condition should just be:
> 
> 	return (ia->ia_valid & ATTR_SIZE) || ...
> 
> I'll fix the patch up and pull it into my tree.
> 
> 									Honza
> 
