Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC1A3122CB
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Feb 2021 09:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbhBGIfK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Feb 2021 03:35:10 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12142 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbhBGIdH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Feb 2021 03:33:07 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DYMmx4fsHz164sT;
        Sun,  7 Feb 2021 16:30:57 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.498.0; Sun, 7 Feb 2021
 16:32:18 +0800
Subject: Re: [PATCH 3/6] fs-verity: add FS_IOC_READ_VERITY_METADATA ioctl
To:     Eric Biggers <ebiggers@kernel.org>
CC:     <linux-fscrypt@vger.kernel.org>, Theodore Ts'o <tytso@mit.edu>,
        <linux-api@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-fsdevel@vger.kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
        <linux-ext4@vger.kernel.org>, Victor Hsieh <victorhsieh@google.com>
References: <20210115181819.34732-1-ebiggers@kernel.org>
 <20210115181819.34732-4-ebiggers@kernel.org>
 <107cf2f2-a6fe-57c2-d17d-57679d7c612d@huawei.com>
 <YB+ead3SvsQy5ULH@sol.localdomain>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <fbe787cc-fcba-7c97-d5ca-cb67345d0c8c@huawei.com>
Date:   Sun, 7 Feb 2021 16:32:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <YB+ead3SvsQy5ULH@sol.localdomain>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/2/7 16:01, Eric Biggers wrote:
> On Sun, Feb 07, 2021 at 03:46:43PM +0800, Chao Yu wrote:
>> Hi Eric,
>>
>> On 2021/1/16 2:18, Eric Biggers wrote:
>>> +static int f2fs_ioc_read_verity_metadata(struct file *filp, unsigned long arg)
>>> +{
>>> +	if (!f2fs_sb_has_verity(F2FS_I_SB(file_inode(filp))))
>>> +		return -EOPNOTSUPP;
>>
>> One case is after we update kernel image, f2fs module may no longer support
>> compress algorithm which current file was compressed with, to avoid triggering
>> IO with empty compress engine (struct f2fs_compress_ops pointer):
>>
>> It needs to add f2fs_is_compress_backend_ready() check condition here?
>>
>> Thanks,
>>
>>> +
>>> +	return fsverity_ioctl_read_metadata(filp, (const void __user *)arg);
>>> +}
> 
> In that case it wouldn't have been possible to open the file, because
> f2fs_file_open() checks for it.  So it's not necessary to repeat the same check
> in every operation on the file descriptor.

Oh, yes, it's safe now.

I'm thinking we need to remove the check in f2fs_file_open(), because the check
will fail metadata access/update (via f{g,s}etxattr/ioctl), however original
intention of that check is only to avoid syscalls to touch compressed data w/o
the engine, anyway this is another topic.

The whole patchset looks fine to me, feel free to add:

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> 
> - Eric
> .
> 
