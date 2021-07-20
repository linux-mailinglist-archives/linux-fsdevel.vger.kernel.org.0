Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27B833CF559
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 09:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235185AbhGTGwq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 02:52:46 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:56039 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229916AbhGTGwn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 02:52:43 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UgP8xJL_1626766400;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UgP8xJL_1626766400)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 20 Jul 2021 15:33:20 +0800
Subject: Re: [PATCH v2] vfs: only allow SETFLAGS to set DAX flag on files and
 dirs
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org
References: <20210719023834.104053-1-jefflexu@linux.alibaba.com>
 <20210719174331.GH22357@magnolia>
From:   JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <729b4efa-8903-c5ec-4e29-7f4e0d02ce2a@linux.alibaba.com>
Date:   Tue, 20 Jul 2021 15:33:20 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210719174331.GH22357@magnolia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 7/20/21 1:43 AM, Darrick J. Wong wrote:
> On Mon, Jul 19, 2021 at 10:38:34AM +0800, Jeffle Xu wrote:
>> This is similar to commit dbc77f31e58b ("vfs: only allow FSSETXATTR to
>> set DAX flag on files and dirs").
>>
>> Though the underlying filesystems may have filtered invalid flags, e.g.,
>> ext4_mask_flags() called in ext4_fileattr_set(), also check it in VFS
>> layer.
>>
>> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
>> ---
>> changes since v1:
>> - add separate parentheses surrounding flag tests
>> ---
>>  fs/ioctl.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/ioctl.c b/fs/ioctl.c
>> index 1e2204fa9963..90cfaa4db03a 100644
>> --- a/fs/ioctl.c
>> +++ b/fs/ioctl.c
>> @@ -835,7 +835,7 @@ static int fileattr_set_prepare(struct inode *inode,
>>  	 * It is only valid to set the DAX flag on regular files and
>>  	 * directories on filesystems.
>>  	 */
>> -	if ((fa->fsx_xflags & FS_XFLAG_DAX) &&
>> +	if (((fa->fsx_xflags & FS_XFLAG_DAX) || (fa->flags & FS_DAX_FL)) &&
> 
> Isn't fileattr_fill_flags supposed to fill out fa->fsx_xflags from
> fa->flags for a SETFLAGS call?

Yes, but fa->fsx_xflags inherited from fa->flags (at least in ext4 it
is) is the original flags/xflags of the file before SETFLAG/FSSETXATTR.
Here we want to check *new* flags/xflags.

> 
>>  	    !(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode)))
>>  		return -EINVAL;
>>  
>> -- 
>> 2.27.0
>>

-- 
Thanks,
Jeffle
