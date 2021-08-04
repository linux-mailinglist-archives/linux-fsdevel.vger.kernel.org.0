Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C03E43DFB9B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Aug 2021 08:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235398AbhHDGwM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Aug 2021 02:52:12 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:50642 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235019AbhHDGwM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Aug 2021 02:52:12 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R571e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UhwYqW9_1628059917;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UhwYqW9_1628059917)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 04 Aug 2021 14:51:58 +0800
Subject: Re: [PATCH v2 0/4] virtiofs,fuse: support per-file DAX
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     stefanha@redhat.com, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        bo.liu@linux.alibaba.com, joseph.qi@linux.alibaba.com,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20210716104753.74377-1-jefflexu@linux.alibaba.com>
 <YPXu3BefIi7Ts48I@redhat.com>
 <031efb1d-7c0d-35fb-c147-dcc3b6cac0ef@linux.alibaba.com>
 <YPchgf665bwUMKWU@redhat.com>
 <38e9da34-cc2b-f496-7ebb-18db8da1aa01@linux.alibaba.com>
 <YPgXuacFfJ/JVRjo@redhat.com> <YPgyalU0avl9KI/U@redhat.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <f16e97cd-6e64-2c2c-080d-f70a5bf4a390@linux.alibaba.com>
Date:   Wed, 4 Aug 2021 14:51:57 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YPgyalU0avl9KI/U@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 7/21/21 10:42 PM, Vivek Goyal wrote:
> On Wed, Jul 21, 2021 at 08:48:57AM -0400, Vivek Goyal wrote:
> [..]
>>>> So is "dax=inode" enough for your needs? What's your requirement,
>>>> can you give little bit of more details.
>>>
>>> In our use case, the backend fs is something like SquashFS on host. The
>>> content of the file on host is downloaded *as needed*. When the file is
>>> not completely ready (completely downloaded), the guest will follow the
>>> normal IO routine, i.e., by FUSE_READ/FUSE_WRITE request. While the file
>>> is completely ready, per-file DAX is enabled for this file. IOW the FUSE
>>> server need to dynamically decide if per-file DAX shall be enabled,
>>> depending on if the file is completely downloaded.
>>
>> So you don't want to enable DAX yet because guest might fault on
>> a section of file which has not been downloaded yet?
>>
>> I am wondering if somehow user fault handling can help with this.
>> If we could handle faults for this file in user space, then you
>> should be able to download that particular page[s] and resolve
>> the fault?
> 
> Stefan mentioned that can't we block when fuse mmap request comes
> in and download corresponding section of file. Or do whatever you
> are doing in FUSE_READ. 
> 
> IOW, even if you enable dax in your use case on all files,
> FUSE_SETUPMAPPING request will give you control to make sure 
> file section being mmaped has been downloaded.
> 

Sorry for the late reply. I missed this mail as it is classified into
the mailing list folder.

The idea you mentioned may works. Anyway, the implementation details of
the FUSE server is not strongly binding to the FUSE protocol changes in
kernel. The protocol only requires that FUSE client shall be able to
store FS_DAX_FL attr persistently in *some way*. The changes in kernel
shall be general, no matter whether the FUSE server is FS_DAX_FL attr
based or something else.


-- 
Thanks,
Jeffle
