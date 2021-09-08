Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC0134037ED
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Sep 2021 12:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348892AbhIHKgG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Sep 2021 06:36:06 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:37248 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234958AbhIHKgD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Sep 2021 06:36:03 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0UngnJV5_1631097293;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UngnJV5_1631097293)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 08 Sep 2021 18:34:53 +0800
Subject: Re: [Virtio-fs] [virtiofsd PATCH v4 4/4] virtiofsd: support per-file
 DAX in FUSE_LOOKUP
To:     Greg Kurz <groug@kaod.org>
Cc:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>, miklos@szeredi.hu,
        virtualization@lists.linux-foundation.org, virtio-fs@redhat.com,
        joseph.qi@linux.alibaba.com, stefanha@redhat.com,
        linux-fsdevel@vger.kernel.org, vgoyal@redhat.com
References: <20210817022220.17574-1-jefflexu@linux.alibaba.com>
 <20210817022347.18098-1-jefflexu@linux.alibaba.com>
 <20210817022347.18098-5-jefflexu@linux.alibaba.com>
 <YRwHRmL/jUSqgkIU@work-vm>
 <29627110-e4bf-836f-2343-1faeb36ad4d3@linux.alibaba.com>
 <YR5Xzw02IuVAN94b@work-vm>
 <4494052b-aff1-e2e3-e704-c8743168f62e@linux.alibaba.com>
 <20210824121515.5419d6a7@bahia.lan>
From:   JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <88041d90-d170-3ae1-903e-2fa32e51027f@linux.alibaba.com>
Date:   Wed, 8 Sep 2021 18:34:53 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210824121515.5419d6a7@bahia.lan>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/24/21 6:15 PM, Greg Kurz wrote:
> On Fri, 20 Aug 2021 13:03:23 +0800
> JeffleXu <jefflexu@linux.alibaba.com> wrote:
>>
>> Fine. Got it. However the returned fd (opened without O_PATH) is only
>> used for FS_IOC_GETFLAGS/FS_IOC_FSGETXATTR ioctl, while in most cases
>> for special device files, these two ioctls should return -ENOTTY.
>>
> 
> The actual problem is that a FIFO will cause openat() to block until
> the other end of the FIFO is open for writing...

Got it.

> 
>> If it's really a security issue, then lo_inode_open() could be used to
> 
> ... and cause a DoS on virtiofsd. So yes, this is a security issue and
> lo_inode_open() was introduced specifically to handle this.
> 
>> get a temporary fd, i.e., check if it's a special file before opening.
>> After all, FUSE_OPEN also handles in this way. Besides, I can't
>> understand what "race-free way" means.
>>
> 
> "race-free way" means a way that guarantees that file type
> cannot change between the time you check it and the time
> you open it (TOCTOU error). For example, doing a plain stat(),
> checking st_mode and proceeding to open() is wrong : nothing
> prevents the file to be unlinked and replaced by something
> else between stat() and open().
> 
> We avoid that by keeping O_PATH fds around and using
> lo_inode_open() instead of openat().

Thanks for the detailed explanation. Got it.

> 
> In your case, it seems that you should do the checking after
> you have an actual lo_inode for the target file, and pass
> that to lo_should_enable_dax() instead of the parent lo_inode
> and target name.
> 

Yes, that will be more reasonable. Thanks.

-- 
Thanks,
Jeffle
