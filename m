Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3A6C3CF6C2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 11:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234171AbhGTImN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 04:42:13 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:49003 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233756AbhGTImB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 04:42:01 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UgPaTDY_1626772944;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UgPaTDY_1626772944)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 20 Jul 2021 17:22:25 +0800
Subject: Re: [PATCH v2 3/4] fuse: add per-file DAX flag
From:   JeffleXu <jefflexu@linux.alibaba.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     stefanha@redhat.com, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        bo.liu@linux.alibaba.com, joseph.qi@linux.alibaba.com
References: <20210716104753.74377-1-jefflexu@linux.alibaba.com>
 <20210716104753.74377-4-jefflexu@linux.alibaba.com>
 <YPXWA+Uo5vFuHCH0@redhat.com>
 <61bca75f-2efa-f032-41d6-fcb525d8b528@linux.alibaba.com>
Message-ID: <9746c189-bbce-738c-7308-bdf094996bc8@linux.alibaba.com>
Date:   Tue, 20 Jul 2021 17:22:24 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <61bca75f-2efa-f032-41d6-fcb525d8b528@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 7/20/21 2:51 PM, JeffleXu wrote:
> 
> 
> On 7/20/21 3:44 AM, Vivek Goyal wrote:
>> On Fri, Jul 16, 2021 at 06:47:52PM +0800, Jeffle Xu wrote:
>>> Add one flag for fuse_attr.flags indicating if DAX shall be enabled for
>>> this file.
>>>
>>> When the per-file DAX flag changes for an *opened* file, the state of
>>> the file won't be updated until this file is closed and reopened later.
>>>
>>> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
>>> ---
>>>  fs/fuse/dax.c             | 21 +++++++++++++++++----
>>>  fs/fuse/file.c            |  4 ++--
>>>  fs/fuse/fuse_i.h          |  5 +++--
>>>  fs/fuse/inode.c           |  5 ++++-
>>>  include/uapi/linux/fuse.h |  5 +++++
>>>  5 files changed, 31 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
>>> index a478e824c2d0..0e862119757a 100644
>>> --- a/fs/fuse/dax.c
>>> +++ b/fs/fuse/dax.c
>>> @@ -1341,7 +1341,7 @@ static const struct address_space_operations fuse_dax_file_aops  = {
>>>  	.invalidatepage	= noop_invalidatepage,
>>>  };
>>>  
>>> -static bool fuse_should_enable_dax(struct inode *inode)
>>> +static bool fuse_should_enable_dax(struct inode *inode, unsigned int flags)
>>>  {
>>>  	struct fuse_conn *fc = get_fuse_conn(inode);
>>>  	unsigned int mode;
>>> @@ -1354,18 +1354,31 @@ static bool fuse_should_enable_dax(struct inode *inode)
>>>  	if (mode == FUSE_DAX_MOUNT_NEVER)
>>>  		return false;
>>>  
>>> -	return true;
>>> +	if (mode == FUSE_DAX_MOUNT_ALWAYS)
>>> +		return true;
>>> +
>>> +	WARN_ON(mode != FUSE_DAX_MOUNT_INODE);
>>> +	return flags & FUSE_ATTR_DAX;
>>>  }
>>>  
>>> -void fuse_dax_inode_init(struct inode *inode)
>>> +void fuse_dax_inode_init(struct inode *inode, unsigned int flags)
>>>  {
>>> -	if (!fuse_should_enable_dax(inode))
>>> +	if (!fuse_should_enable_dax(inode, flags))
>>>  		return;
>>>  
>>>  	inode->i_flags |= S_DAX;
>>>  	inode->i_data.a_ops = &fuse_dax_file_aops;
>>>  }
>>>  
>>> +void fuse_dax_dontcache(struct inode *inode, bool newdax)
>>> +{
>>> +	struct fuse_conn *fc = get_fuse_conn(inode);
>>> +
>>> +	if (fc->dax && fc->dax->mode == FUSE_DAX_MOUNT_INODE &&
>>> +	    IS_DAX(inode) != newdax)
>>> +		d_mark_dontcache(inode);
>>> +}
>>> +
>>
>> This capability to mark an inode dontcache should probably be in a
>> separate patch. These seem to logically two functionalities. One is
>> enabling DAX on an inode. And second is making sure how soon you
>> see the effect of that change and hence marking inode dontcache.
> 
> OK, sounds reasonable.
> 
>>
>> Not sure how useful this is. In cache=none mode we should get rid of
>> inode ASAP. In cache=auto mode we will get rid of after 1 second (or
>> after a user specified timeout). So only place this seems to be
>> useful is cache=always.
> 
> Actually dontcache here is used to avoid dynamic switching between DAX
> and non-DAX state while file is opened. The complexity of dynamic
> switching is that, you have to clear the address_space, since page cache
> and DAX entry can not coexist in the address space. Besides,
> inode->a_ops also needs to be changed dynamically.

FYI some context on the complication of switching DAX state dynamically,
when Ira Weiny was working on per-file DAX of ext4/xfs.

> At LSF/MM we discussed the difficulties of switching the DAX state of
a file with active mappings / page cache.  It was thought the races
could be avoided by limiting DAX state flips to 0-length files.
>
> However, this turns out to not be true.[3][5] This is because address
space operations (a_ops) may be in use at any time the inode is referenced.
> from Ira Weiny

[1]
https://patchwork.kernel.org/project/xfs/cover/20200407182958.568475-1-ira.weiny@intel.com/
[2] https://lore.kernel.org/lkml/20200305155144.GA5598@lst.de/
[3] https://lore.kernel.org/lkml/20200401040021.GC56958@magnolia/
[4] https://lore.kernel.org/lkml/20200403182904.GP80283@magnolia/

> 
> With dontcache, dynamic switching is no longer needed and the DAX state
> will be decided only when inode (in memory) is initialized. The downside
> is that the new DAX state won't be updated until the file is closed and
> reopened later.
> 
> 'cache=none' only invalidates dentry, while the inode (in memory) is
> still there (with address_space uncleared and a_ops unchanged).
> 
> The dynamic switching may be done, though it's not such straightforward.
> Currently, ext4/xfs are all implemented in this dontcache way, i.e., the
> new DAX state won't be seen until the file is closed and reopened later.
> 

-- 
Thanks,
Jeffle
