Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA7AB4550
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2019 03:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391762AbfIQBoO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Sep 2019 21:44:14 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:51224 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728211AbfIQBoN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Sep 2019 21:44:13 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8A896A131DE1E2C342DD;
        Tue, 17 Sep 2019 09:44:11 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 17 Sep
 2019 09:44:07 +0800
Subject: Re: [PATCH] quota: fix wrong condition in is_quota_modification()
To:     Jan Kara <jack@suse.cz>
CC:     Jan Kara <jack@suse.com>, <chao@kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190911093650.35329-1-yuchao0@huawei.com>
 <20190912100610.GA14773@quack2.suse.cz>
 <ce4fe030-7ad4-134d-e0c4-77dc2c618b15@huawei.com>
 <20190916082306.GB2485@quack2.suse.cz>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <744449b0-fd6b-fb10-5f6e-d3d35730cc6c@huawei.com>
Date:   Tue, 17 Sep 2019 09:44:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190916082306.GB2485@quack2.suse.cz>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/9/16 16:23, Jan Kara wrote:
> On Mon 16-09-19 10:53:08, Chao Yu wrote:
>> On 2019/9/12 18:06, Jan Kara wrote:
>>> On Wed 11-09-19 17:36:50, Chao Yu wrote:
>>>> diff --git a/include/linux/quotaops.h b/include/linux/quotaops.h
>>>> index dc905a4ff8d7..bd30acad3a7f 100644
>>>> --- a/include/linux/quotaops.h
>>>> +++ b/include/linux/quotaops.h
>>>> @@ -22,7 +22,7 @@ static inline struct quota_info *sb_dqopt(struct super_block *sb)
>>>>  /* i_mutex must being held */
>>>>  static inline bool is_quota_modification(struct inode *inode, struct iattr *ia)
>>>>  {
>>>> -	return (ia->ia_valid & ATTR_SIZE && ia->ia_size != inode->i_size) ||
>>>> +	return (ia->ia_valid & ATTR_SIZE && ia->ia_size <= inode->i_size) ||
>>>>  		(ia->ia_valid & ATTR_UID && !uid_eq(ia->ia_uid, inode->i_uid)) ||
>>>>  		(ia->ia_valid & ATTR_GID && !gid_eq(ia->ia_gid, inode->i_gid));
>>>>  }
>>>
>>> OK, but your change makes i_size extension not to be quota modification
>>
>> I just try to adapt below rules covered with generic/092, which restrict
>> to not trim preallocate blocks beyond i_size, in that case, filesystem
>> won't change i_blocks.
>>
>> 1) truncate(i_size) will trim all blocks past i_size.
>> 2) truncate(x) where x > i_size will not trim all blocks past i_size.
> 
> Ah, OK.
> 
>> However, I'm okay with your change, because there could be filesystems won't
>> follow above rule.
> 
> Yes, I'm concerned that some filesystem may change i_blocks in some corner
> case when growing inode size (e.g. when it decides to convert inode from
> inline format to a normal block based format or something like that). So I
> don't think the optimization is really worth the chance for breakage.

Agreed, :)

Thanks,

> 
> 								Honza
> 
