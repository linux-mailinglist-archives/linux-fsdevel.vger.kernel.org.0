Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6883CCC0A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jul 2021 03:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbhGSBuq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Jul 2021 21:50:46 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:34589 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233713AbhGSBuq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Jul 2021 21:50:46 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UgAb0Iu_1626659265;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UgAb0Iu_1626659265)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 19 Jul 2021 09:47:45 +0800
Subject: Re: [PATCH] vfs: only allow SETFLAGS to set DAX flag on files and
 dirs
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org
References: <20210716061951.81529-1-jefflexu@linux.alibaba.com>
 <20210716162017.GA22346@magnolia>
From:   JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <e85ceae6-23b8-aea8-1314-7e2ebece61d6@linux.alibaba.com>
Date:   Mon, 19 Jul 2021 09:47:45 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210716162017.GA22346@magnolia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 7/17/21 12:20 AM, Darrick J. Wong wrote:
> On Fri, Jul 16, 2021 at 02:19:51PM +0800, Jeffle Xu wrote:
>> This is similar to commit dbc77f31e58b ("vfs: only allow FSSETXATTR to
>> set DAX flag on files and dirs").
>>
>> Though the underlying filesystems may have filtered invalid flags, e.g.,
>> ext4_mask_flags() called in ext4_fileattr_set(), also check it in VFS
>> layer.
>>
>> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
>> ---
>>  fs/ioctl.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/ioctl.c b/fs/ioctl.c
>> index 1e2204fa9963..1fe73e148e2d 100644
>> --- a/fs/ioctl.c
>> +++ b/fs/ioctl.c
>> @@ -835,7 +835,7 @@ static int fileattr_set_prepare(struct inode *inode,
>>  	 * It is only valid to set the DAX flag on regular files and
>>  	 * directories on filesystems.
>>  	 */
>> -	if ((fa->fsx_xflags & FS_XFLAG_DAX) &&
>> +	if ((fa->fsx_xflags & FS_XFLAG_DAX || fa->flags & FS_DAX_FL) &&
> 
> I thought we always had to surround flag tests with separate
> parentheses...?

Thanks.

The 'bitwise and' has a higher priority than 'logical or'. But for sure
I can add parentheses to make it more readable and precise.

-- 
Thanks,
Jeffle
