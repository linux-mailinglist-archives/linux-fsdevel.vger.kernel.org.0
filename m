Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8522B43C27B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Oct 2021 08:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236091AbhJ0GC6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Oct 2021 02:02:58 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:48119 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230225AbhJ0GC5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Oct 2021 02:02:57 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0Utr8PLe_1635314430;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Utr8PLe_1635314430)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 27 Oct 2021 14:00:31 +0800
Subject: Re: [PATCH v6 2/7] fuse: make DAX mount option a tri-state
To:     Ira Weiny <ira.weiny@intel.com>, Vivek Goyal <vgoyal@redhat.com>
Cc:     Dave Chinner <dchinner@redhat.com>, stefanha@redhat.com,
        miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        virtio-fs@redhat.com, bo.liu@linux.alibaba.com,
        joseph.qi@linux.alibaba.com
References: <20211011030052.98923-1-jefflexu@linux.alibaba.com>
 <20211011030052.98923-3-jefflexu@linux.alibaba.com>
 <YW2AU/E0pLHO5Yl8@redhat.com>
 <652ac323-6546-01b8-992e-460ad59577ca@linux.alibaba.com>
 <YXAzB5sOrFRUzTC5@redhat.com>
 <96956132-fced-5739-d69a-7b424dc65f7c@linux.alibaba.com>
 <20211025175251.GF3465596@iweiny-DESK2.sc.intel.com>
 <YXbzeomdC5cD1xfF@redhat.com>
 <20211025190201.GG3465596@iweiny-DESK2.sc.intel.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <5cb17c6b-380d-857b-d676-7ab2e8eba731@linux.alibaba.com>
Date:   Wed, 27 Oct 2021 14:00:30 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211025190201.GG3465596@iweiny-DESK2.sc.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks for your replying, Ira Weiny.


On 10/26/21 3:02 AM, Ira Weiny wrote:
> [snippet]
>>>> Hi, Ira Weiny,
>>>>
>>>> Do you have any thought on this, i.e. why the default behavior has
>>>> changed after introduction of per inode dax?
>>>
>>> While this is 'technically' different behavior the end user does not see any
>>> difference in behavior if they continue without software changes.  Specifically
>>> specifying nothing continues to operate with all the files on the FS to be
>>> '_not_ DAX'.  While specifying '-o dax' forces DAX on all files.
>>>
>>> This expands the default behavior in a backwards compatible manner.
>>
>> This is backward compatible in a sense that if somebody upgrades to new
>> kernel, things will still be same. 
>>
>> I think little problematic change is that say I bring in persistent
>> memory from another system (which has FS_XFLAGS_DAX set on some inodes)
>> and then mount it without andy of the dax mount options, then per
>> inode dax will be enabled unexpectedly if I boot with newer kernels
>> but it will be disable if I mount with older kernels. Do I understand it
>> right.
> 
> Indeed that will happen.  However, wouldn't the users (software) of those files
> have knowledge that those files were DAX and want to continue with them in that
> mode?
> 
>>
>>> The user
>>> can now enable DAX on some files.  But this is an opt-in on the part of the
>>> user of the FS and again does not change with existing software/scripts/etc.
>>
>> Don't understand this "opt-in" bit. If user mounts an fs without
>> specifying any of the dax options, then per inode dax will still be
>> enabled if inode has the correct flag set.
> 
> But only users who actually set that flag 'opt-in'.
> 
>> So is setting of flag being
>> considered as opt-in (insted of mount option).
> 
> Yes.
> 
>>
>> If setting of flag is being considered as opt-in, that probably will not
>> work very well with virtiofs. Because server can enforce a different
>> policy for enabling per file dax (instead of FS_XFLAG_DAX).
> 
> I'm not sure I understand how this happens?  I think the server probably has to
> enable per INODE by default to allow the client to do what the end users wants.
> 
> I agree that if the end user is expecting DAX and the server disables it then
> that is a problem but couldn't that happen before?  Maybe I'm getting confused
> because I'm not familiar enough with virtiofs.
> 
>>
>> And given there are two entities here (client and server), I think it
>> will be good if if we give client a chance as well to decide whether
>> it wants to enable per file dax or not. I know it can alwasy do 
>> "dax=never" but it can still be broken if client software remains
>> same but host/server software is upgraded or commnad line changed.
> 
> But the files are 'owned' by a single user or group of users who must have
> placed the file in DAX mode at some point right?

So this is the essence of this issue, i.e. whether those who mount the
filesystem (responsible for specifying mount options) and those who set
the persistent inode flag are one same group people.

For local filesystem like ext4/xfs, these two entities are most likely
one group people, so we can say that 'the default behavior is still
backward compatible'.

However this semantic can be challenged a little by the example exposed
by Vivek, that these two entities may not be one group even in local
filesystem. Though this case may be rare in real world.

But for remote filesystem like virtiofs, the deviation between these two
entities can be larger. For example, if the exported directory on host
is shared by two guest and guest A sets the persistent inode flag for
one file, then guest B will also see that DAX is enabled for this file
when the virtiofs is mounted with the default option inside guest B. In
this case, the persistent indoe flag is not set by guest B itself nor
the server, and it may break the expectation of guest B.

> 
>>
>> So for virtiofs, I think better behavior is to continue to not enable
>> any dax until and unless user opts-in using "-o dax=foo" options.
> 

I also prefer keeping the 'dax=never' default behavior for virtiofs.

-- 
Thanks,
Jeffle
