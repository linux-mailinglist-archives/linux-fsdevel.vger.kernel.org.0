Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3112578E80
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2019 16:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387494AbfG2O52 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jul 2019 10:57:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:56498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbfG2O51 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jul 2019 10:57:27 -0400
Received: from [192.168.0.101] (unknown [180.111.32.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7F582067D;
        Mon, 29 Jul 2019 14:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564412246;
        bh=hMANmngripBsLJYd0Y/7x4OoPirri23tE2oLpVKpNB4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=fmIYCh1tQ7HGhaBzdlRtL2bHHiOLDhp8u5eyZg8qMCO41oty4t2dCIDuN3sxkRk7e
         C/M4SoQ+feASKNhouXi6y5RnqTyepKX4N1mk3kln5zowMv36DnEMloxEU4IpopLkGr
         BVSnI82o391mNn0iFzF+OuKAodyIiVWC47INjDH8=
Subject: Re: [f2fs-dev] [PATCH v4 3/3] f2fs: Support case-insensitive file
 name lookups
To:     Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Daniel Rosenberg <drosen@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-f2fs-devel@lists.sourceforge.net, linux-doc@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-team@android.com
References: <20190723230529.251659-1-drosen@google.com>
 <20190723230529.251659-4-drosen@google.com>
 <9362e4ed-2be8-39f5-b4d9-9c86e37ab993@kernel.org>
 <20190729062735.GA98839@jaegeuk-macbookpro.roam.corp.google.com>
 <fa07a09d-92c9-4e0b-7c2b-e87771273dce@huawei.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <fe7066e9-f299-c675-cec3-919cdabe18ce@kernel.org>
Date:   Mon, 29 Jul 2019 22:57:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <fa07a09d-92c9-4e0b-7c2b-e87771273dce@huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019-7-29 15:22, Chao Yu wrote:
> On 2019/7/29 14:27, Jaegeuk Kim wrote:
>> On 07/28, Chao Yu wrote:
>>> On 2019-7-24 7:05, Daniel Rosenberg via Linux-f2fs-devel wrote:
>>>>  /* Flags that are appropriate for regular files (all but dir-specific ones). */
>>>>  #define F2FS_REG_FLMASK		(~(F2FS_DIRSYNC_FL | F2FS_PROJINHERIT_FL))
>>>
>>> We missed to add F2FS_CASEFOLD_FL here to exclude it in F2FS_REG_FLMASK.
>>
>> Applied.
>>
>>>
>>>> @@ -1660,7 +1660,16 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
>>>>  		return -EPERM;
>>>>  
>>>>  	oldflags = fi->i_flags;
>>>> +	if ((iflags ^ oldflags) & F2FS_CASEFOLD_FL) {
>>>> +		if (!f2fs_sb_has_casefold(F2FS_I_SB(inode)))
>>>> +			return -EOPNOTSUPP;
>>>> +
>>>> +		if (!S_ISDIR(inode->i_mode))
>>>> +			return -ENOTDIR;
>>>>  
>>>> +		if (!f2fs_empty_dir(inode))
>>>> +			return -ENOTEMPTY;
>>>> +	}
>>
>> Modified like this:
>> @@ -1665,6 +1665,13 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
>>         if (IS_NOQUOTA(inode))
>>                 return -EPERM;
>>
>> +       if ((iflags ^ fi->i_flags) & F2FS_CASEFOLD_FL) {
>> +               if (!f2fs_sb_has_casefold(F2FS_I_SB(inode)))
>> +                       return -EOPNOTSUPP;
>> +               if (!f2fs_empty_dir(inode))
>> +                       return -ENOTEMPTY;
>> +       }
>> +
>>
>> Note that, directory is checked by above change.
>>
>> I've uploaded in f2fs.git, so could you check it out and test a bit?
> 
> I've checked it out, it looks good to me now, and later I will test this new
> version.
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>

It can pass generic/556 as well.

Thanks,

> 
> Thanks,
> 
>>
>> Thanks,
>>
>>>
>>> I applied the patches based on last Jaegeuk's dev branch, it seems we needs to
>>> adjust above code a bit. Otherwise it looks good to me.
>>>
>>> BTW, it looks the patchset works fine with generic/556 testcase.
>>>
>>> Thanks,
>> .
>>
