Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D29EE7863A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2019 09:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfG2HW1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jul 2019 03:22:27 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3229 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725917AbfG2HW1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jul 2019 03:22:27 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 75FAC6D82EC4BAD96A58;
        Mon, 29 Jul 2019 15:22:24 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 29 Jul
 2019 15:22:22 +0800
Subject: Re: [f2fs-dev] [PATCH v4 3/3] f2fs: Support case-insensitive file
 name lookups
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
CC:     Daniel Rosenberg <drosen@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-doc@vger.kernel.org>, <linux-api@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <kernel-team@android.com>
References: <20190723230529.251659-1-drosen@google.com>
 <20190723230529.251659-4-drosen@google.com>
 <9362e4ed-2be8-39f5-b4d9-9c86e37ab993@kernel.org>
 <20190729062735.GA98839@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <fa07a09d-92c9-4e0b-7c2b-e87771273dce@huawei.com>
Date:   Mon, 29 Jul 2019 15:22:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190729062735.GA98839@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/7/29 14:27, Jaegeuk Kim wrote:
> On 07/28, Chao Yu wrote:
>> On 2019-7-24 7:05, Daniel Rosenberg via Linux-f2fs-devel wrote:
>>>  /* Flags that are appropriate for regular files (all but dir-specific ones). */
>>>  #define F2FS_REG_FLMASK		(~(F2FS_DIRSYNC_FL | F2FS_PROJINHERIT_FL))
>>
>> We missed to add F2FS_CASEFOLD_FL here to exclude it in F2FS_REG_FLMASK.
> 
> Applied.
> 
>>
>>> @@ -1660,7 +1660,16 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
>>>  		return -EPERM;
>>>  
>>>  	oldflags = fi->i_flags;
>>> +	if ((iflags ^ oldflags) & F2FS_CASEFOLD_FL) {
>>> +		if (!f2fs_sb_has_casefold(F2FS_I_SB(inode)))
>>> +			return -EOPNOTSUPP;
>>> +
>>> +		if (!S_ISDIR(inode->i_mode))
>>> +			return -ENOTDIR;
>>>  
>>> +		if (!f2fs_empty_dir(inode))
>>> +			return -ENOTEMPTY;
>>> +	}
> 
> Modified like this:
> @@ -1665,6 +1665,13 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
>         if (IS_NOQUOTA(inode))
>                 return -EPERM;
> 
> +       if ((iflags ^ fi->i_flags) & F2FS_CASEFOLD_FL) {
> +               if (!f2fs_sb_has_casefold(F2FS_I_SB(inode)))
> +                       return -EOPNOTSUPP;
> +               if (!f2fs_empty_dir(inode))
> +                       return -ENOTEMPTY;
> +       }
> +
> 
> Note that, directory is checked by above change.
> 
> I've uploaded in f2fs.git, so could you check it out and test a bit?

I've checked it out, it looks good to me now, and later I will test this new
version.

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> 
> Thanks,
> 
>>
>> I applied the patches based on last Jaegeuk's dev branch, it seems we needs to
>> adjust above code a bit. Otherwise it looks good to me.
>>
>> BTW, it looks the patchset works fine with generic/556 testcase.
>>
>> Thanks,
> .
> 
