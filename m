Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C25B04252C9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Oct 2021 14:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241211AbhJGMPz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Oct 2021 08:15:55 -0400
Received: from n169-113.mail.139.com ([120.232.169.113]:43535 "EHLO
        n169-113.mail.139.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241206AbhJGMPy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Oct 2021 08:15:54 -0400
X-Greylist: delayed 560 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Oct 2021 08:15:52 EDT
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG: 00000000
Received: from [192.168.255.10] (unknown[116.30.194.209])
        by rmsmtp-lg-appmail-31-12045 (RichMail) with SMTP id 2f0d615ee24f94a-8b09a;
        Thu, 07 Oct 2021 20:04:31 +0800 (CST)
X-RM-TRANSID: 2f0d615ee24f94a-8b09a
Message-ID: <3b660f79-9f60-5acd-0b9a-47f9e3e6a04b@139.com>
Date:   Thu, 7 Oct 2021 20:04:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [RFC PATCH v5 07/10] ovl: cache dirty overlayfs' inode
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Chengguang Xu <cgxu519@mykernel.net>
Cc:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel@vger.kernel.org
References: <20210923130814.140814-1-cgxu519@mykernel.net>
 <20210923130814.140814-8-cgxu519@mykernel.net>
 <CAJfpegtLi1PsfpkohJ-8kTHVazf7cZiX96OSBMn7Q39PY_PXaw@mail.gmail.com>
From:   Chengguang Xu <cgxu519@139.com>
In-Reply-To: <CAJfpegtLi1PsfpkohJ-8kTHVazf7cZiX96OSBMn7Q39PY_PXaw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

在 2021/10/7 19:09, Miklos Szeredi 写道:
> On Thu, 23 Sept 2021 at 15:08, Chengguang Xu <cgxu519@mykernel.net> wrote:
>> Now drop overlayfs' inode will sync dirty data,
>> so we change to only drop clean inode.
>>
>> The purpose of doing this is to keep compatible
>> behavior with before because without this change
>> dropping overlayfs inode will not trigger syncing
>> of underlying dirty inode.
>>
>> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
>> ---
>>   fs/overlayfs/super.c | 16 +++++++++++++++-
>>   1 file changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
>> index cddae3ca2fa5..bf4000eb9be8 100644
>> --- a/fs/overlayfs/super.c
>> +++ b/fs/overlayfs/super.c
>> @@ -441,11 +441,25 @@ static int ovl_write_inode(struct inode *inode,
>>          return ret;
>>   }
>>
>> +/*
>> + * In iput_final(), clean inode will drop directly and dirty inode will
>> + * keep in the cache until write back to sync dirty data then add to lru
>> + * list to wait reclaim.
>> + */
>> +static int ovl_drop_inode(struct inode *inode)
>> +{
>> +       struct inode *upper = ovl_inode_upper(inode);
>> +
>> +       if (!upper || !(inode->i_state & I_DIRTY_ALL))
> Could we check upper dirtyness here? That would give a more precise result.

We keep tracking mmapped-file(shared mode) by explicitely marking 
overlay inode dirty,

so if we drop overlay inode by checking upper dirtyness, we may lose 
control on those mmapped upper inodes.

>
> Alternatively don't set .drop_inode (i.e. use generic_drop_inode())
> and set I_DONTCACHE on overlay inodes.  That would cause the upper
> inode to be always written back before eviction.
>
> The latter would result in simpler logic, and I think performance-wise
> it wouldn't matter.  But I may be missing something.

I think we may seperate mmapped-file(shared) inode and other inode by

clear/set I_DONTCACHE flag on overlay inode if you prefer this approach.


Thanks,

Chengguang





